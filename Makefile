###############################################################################
#
# Modify example to build in Makefile.mine
#
-include Makefile.mine

###############################################################################
#
# Name for the binary, hex and other output build files.
# 
EXAMPLE = $(APP_NAME)

###############################################################################
#
# Source code.
#
OBJECTS += ./src/$(APP_NAME)/$(APP_NAME).o 

BUILD_DIR = build

ARMGNU ?= arm-none-eabi

###############################################################################
#
# Rules used to build the example.
#
all: $(BUILD_DIR)/$(EXAMPLE).bin dump size

.s.o:
	+@echo "Compile: $<"
	@$(ARMGNU)-as -g -o $@ $<

$(BUILD_DIR)/$(EXAMPLE).elf: $(OBJECTS)
	+@echo "Linking: $@"
	@$(ARMGNU)-ld -o $@ $^ -T flash.ld

$(BUILD_DIR)/$(EXAMPLE).bin: $(BUILD_DIR)/$(EXAMPLE).elf
	+@echo "Binary: $@"
	@$(ARMGNU)-objcopy -O binary $< $@

dump: $(BUILD_DIR)/$(EXAMPLE).elf
	+@echo "Dump: $<"
	@$(ARMGNU)-objdump -D $< > $(BUILD_DIR)/$(EXAMPLE).list

size: $(BUILD_DIR)/$(EXAMPLE).elf
	$(ARMGNU)-size $<

clean:
	rm -f $(BUILD_DIR)/*.bin
	rm -f $(BUILD_DIR)/*.elf
	rm -f $(OBJECTS)
	rm -f $(BUILD_DIR)/*.list
