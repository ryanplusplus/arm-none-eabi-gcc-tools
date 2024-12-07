ASFLAGS := \
  -mcpu=$(CPU) \
  -mthumb \
  -g2 \

CPPFLAGS := \
  --specs=nano.specs \
  -mcpu=$(CPU) \
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
  -Wcast-qual \
  -Wconversion \
  -Wpedantic \
  -nostartfiles \

CFLAGS := \
  -std=c11 \

CXXFLAGS := \
  -fno-rtti \
  -fno-exceptions \
  -fno-unwind-tables \
  -fno-non-call-exceptions \
  -fno-threadsafe-statics \
  -fno-use-cxa-atexit \
  -Weffc++ \
  -std=c++17 \

LDFLAGS := \
  -Wl,--gc-sections \
  -Wl,-Map=$(BUILD_DIR)/$(TARGET).map \
