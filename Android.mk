LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE), K013)
# Kernel defconfig
BOARD_KERNEL_FIRMWARE_DIR := $(LOCAL_PATH)/proprietary/kernel/firmware
BOARD_KERNEL_EXTRA_FIRMWARE := intel-ucode/06-37-08

include $(CLEAR_VARS)
LOCAL_MODULE := me176c_defconfig_firmware
LOCAL_MODULE_CLASS := FAKE

include $(BUILD_SYSTEM)/base_rules.mk
$(LOCAL_BUILT_MODULE): $(TARGET_KERNEL_DEFCONFIG) | dsdt.hex
	$(copy-file-to-target)
	@echo CONFIG_ACPI_CUSTOM_DSDT_FILE=\"$(abspath $(BUILT_ACPI_DSDT_TABLE))\" >> $@
	@echo CONFIG_EXTRA_FIRMWARE_DIR=\"$(abspath $(BOARD_KERNEL_FIRMWARE_DIR))\" >> $@
	@echo CONFIG_EXTRA_FIRMWARE=\"$(BOARD_KERNEL_EXTRA_FIRMWARE)\" >> $@

TARGET_KERNEL_DEFCONFIG := $(LOCAL_BUILT_MODULE)

include $(call all-makefiles-under, $(LOCAL_PATH))
endif
