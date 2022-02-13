ifneq ($(__arm_none_eabi_gcc_tools_setup_included),Y)
$(error setup.mk must be included before tools.mk)
endif

TOOLCHAIN_PREFIX ?= arm-none-eabi-

include $(__arm_none_eabi_gcc_tools_path)gcc/tools.mk
include $(__arm_none_eabi_gcc_tools_path)debug-adapter.mk
