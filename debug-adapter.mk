ifeq ($(DEBUG_ADAPTER),jlink)
include $(dir $(realpath $(lastword $(MAKEFILE_LIST))))jlink.mk
else ifeq ($(DEBUG_ADAPTER),black_magic)
include $(dir $(realpath $(lastword $(MAKEFILE_LIST))))black-magic.mk
else
$(error "DEBUG_ADAPTER must be jlink or black_magic")
endif
