# Project root directory
ROOT_DIR := $(abspath ../..)

# Test configuration
TEST_NAME := test_spi
TEST_SRC := $(CURDIR)/test_spi.c

# Test include directories
TEST_INCS := -I$(ROOT_DIR)/src/spi/$(PLATFORM)/

# Lib source files
LIB_PATH := $(ROOT_DIR)/src/spi/$(PLATFORM)
LIB_SRC := $(LIB_PATH)/spi_init.c \
           $(LIB_PATH)/spi_write.c
SOURCES := $(TEST_SRC) $(LIB_SRC)

# Build output directory
BUILD_DIR := $(abspath ../$(TEST_NAME)-$(PLATFORM))

# Validate platform selection
ifeq ($(strip $(PLATFORM)),)
$(error Please specify PLATFORM=avr or PLATFORM=esp32)
endif

# Include platform-specific build configuration and rules
include $(ROOT_DIR)/build/$(PLATFORM)/$(PLATFORM).mk