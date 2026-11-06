# Toolchain
CC := avr-gcc
OBJCOPY := avr-objcopy
SIZE := avr-size

# Flashing configuration
AVRDUDE := avrdude
PROGRAMMER := arduino
PORT ?= COM5
BAUD ?= 115200

# Target microcontroller
MCU := atmega328p
F_CPU := 16000000UL

# Preprocessor flags
CPPFLAGS := $(TEST_INCS) -DF_CPU=$(F_CPU)

# Compiler flags
CFLAGS := -mmcu=$(MCU) \
          -Wall -Wextra \
          -Os \
          -std=gnu11

# Linker flags
LDFLAGS := -mmcu=$(MCU)

# Output format
OBJCOPY_FLAGS := -O ihex -R .eeprom

# Object files
OBJECTS := $(addprefix $(BUILD_DIR)/,$(notdir $(SOURCES:.c=.o)))

# Output files
ELF := $(BUILD_DIR)/$(TEST_NAME).elf
HEX := $(BUILD_DIR)/$(TEST_NAME).hex

# Locate source files
vpath %.c $(sort $(dir $(SOURCES)))

# Default target
.PHONY: all clean size flash

all: $(HEX)

# Create build directory
$(BUILD_DIR):
	mkdir -p $@

# Compile C files into object files
$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# Link object files
$(ELF): $(OBJECTS)
	$(CC) $(LDFLAGS) $^ -o $@

# Convert ELF to Intel HEX
$(HEX): $(ELF)
	$(OBJCOPY) $(OBJCOPY_FLAGS) $< $@

# Display memory usage
size: $(ELF)
	$(SIZE) --format=avr --mcu=$(MCU) $<

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

flash: $(HEX)
	$(AVRDUDE) -c $(PROGRAMMER) -p m328p \
	-P $(PORT) -b $(BAUD) -D \
	-U flash:w:$(shell cygpath -m "$(HEX)"):i