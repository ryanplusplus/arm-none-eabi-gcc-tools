__arm_none_eabi_gcc_tools_setup_included := Y

__arm_none_eabi_gcc_tools_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

include $(__arm_none_eabi_gcc_tools_path)utils/utils.mk
