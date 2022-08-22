ifeq ($(JLINK_DEVICE),)
$(error "JLINK_DEVICE must be defined")
endif

JLINK_SPEED ?= 4000

# $1 Rule name
# $2 File
define generate_jlink_upload_rule
.PHONY: $$(BUILD_DIR)/$1.jlink
$$(BUILD_DIR)/$1.jlink: $2
	@mkdir -p $(dir $$@)
	@echo r > $$@
	@echo h >> $$@
	@echo loadfile $$< >> $$@
	@echo r >> $$@
	@echo exit >> $$@

.PHONY: upload
$1: $(BUILD_DIR)/$1.jlink suppress-jlink-license-popup
	@JLinkExe -NoGui 1 -device $(JLINK_DEVICE) -if SWD -autoconnect 1 -speed $(JLINK_SPEED) -CommandFile $$<
endef

.PHONY: suppress-jlink-license-popup
suppress-jlink-license-popup:
	@type lua > /dev/null 2>&1 && lua $(__arm_none_eabi_gcc_tools_path)/script/suppress-jlink-license-popup.lua > /dev/null 2>&1 || true

.PHONY: debug-deps
debug-deps: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).svd suppress-jlink-license-popup

$(eval $(call generate_jlink_upload_rule,upload,$(BUILD_DIR)/$(TARGET).hex))

.PHONY: $(BUILD_DIR)/erase.jlink
$(BUILD_DIR)/erase.jlink:
	@mkdir -p $(dir $@)
	@echo r > $@
	@echo h >> $@
	@echo erase >> $@
	@echo exit >> $@

.PHONY: erase
erase: $(BUILD_DIR)/erase.jlink suppress-jlink-license-popup
	@JLinkExe -NoGui 1 -device $(JLINK_DEVICE) -if SWD -autoconnect 1 -speed $(JLINK_SPEED) -CommandFile $<

.PHONY: attach-rtt-client
attach-rtt-client:
	@JLinkGDBServer -NoGui 1 -device $(JLINK_DEVICE) -if SWD -autoconnect 1 -speed $(JLINK_SPEED) -nohalt -singlerun & trap 'sleep 0.5' INT && JLinkRTTClient

.PHONY: rtt-client
rtt-client: upload
	@$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST)) attach-rtt-client
