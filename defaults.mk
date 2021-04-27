ASFLAGS := \
  -mcpu=$(CPU) \
  -march=$(ARCH) \
  -mthumb \
  -g2 \

CPPFLAGS := \
  --specs=nano.specs \
  -mcpu=$(CPU) \
  -march=$(ARCH) \
  -mthumb \
  -g \
  -g2 \
  -Os \
  -fdata-sections \
  -ffunction-sections \
  -Wall \
  -Wextra \
  -Werror \
  -Wfatal-errors \

CFLAGS := \
  -std=c99 \

CXXFLAGS := \
  -fno-rtti \
  -fno-exceptions \
  -fno-unwind-tables \
  -fno-non-call-exceptions \
  -fno-use-cxa-atexit \
  -Weffc++ \
  -std=c++17 \

LDFLAGS := \
  --gc-sections \
  -Map=$(BUILD_DIR)/$(TARGET).map \
