ifeq ($(JLINK_DEVICE),)
$(error "JLINK_DEVICE must be defined")
endif

.PHONY: debug-deps
debug-deps: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).svd

.PHONY: upload
upload: $(BUILD_DIR)/upload.jlink $(BUILD_DIR)/$(TARGET).hex
	JLinkExe -device $(JLINK_DEVICE) -if SWD -autoconnect 1 -speed 4000 -CommandFile $<

.PHONY: erase
erase: $(BUILD_DIR)/erase.jlink
	JLinkExe -device $(JLINK_DEVICE) -if SWD -autoconnect 1 -speed 4000 -CommandFile $<

.PHONY: $(BUILD_DIR)/upload.jlink
$(BUILD_DIR)/upload.jlink:
	@mkdir -p $(dir $@)
	@echo r > $@
	@echo h >> $@
	@echo loadfile $(BUILD_DIR)/$(TARGET).hex >> $@
	@echo r >> $@
	@echo exit >> $@

.PHONY: $(BUILD_DIR)/erase.jlink
$(BUILD_DIR)/erase.jlink:
	@mkdir -p $(dir $@)
	@echo r > $@
	@echo h >> $@
	@echo erase >> $@
	@echo exit >> $@
