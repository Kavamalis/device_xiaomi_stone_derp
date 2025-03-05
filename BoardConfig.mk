DEVICE_PATH := device/xiaomi/stone

# Board Info
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Display
TARGET_SCREEN_DENSITY := 440

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_stone
TARGET_RECOVERY_DEVICE_MODULES := libinit_stone

# Kernel
$(shell mkdir -p $(OUT_DIR)/target/product/stone/obj/KERNEL_OBJ/usr)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
KERNEL_LD := LD=ld.lld

BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

TARGET_KERNEL_ADDITIONAL_FLAGS := DTC_EXT=$(shell pwd)/prebuilts/misc/linux-x86/dtc/dtc LLVM=1

BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0x04C8C000 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=4e00000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
#BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# Prebuilt Kernel
ifeq ($(PREBUILT_KERNEL),true)
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL := false
TARGET_KERNEL_SOURCE := $(DEVICE_PATH)-kernel/kernel-headers
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)-kernel/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)-kernel/dtb.img
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)-kernel/dtb.img:$(TARGET_COPY_OUT)/dtb.img \
    $(DEVICE_PATH)-kernel/kernel:kernel \
else
TARGET_KERNEL_SOURCE := kernel/xiaomi/stone
TARGET_KERNEL_CONFIG := stone_defconfig
TARGET_KERNEL_NO_GCC := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
endif

# Media
TARGET_USES_ION := true
TARGET_DISABLED_UBWC := true

# OTA Assert
TARGET_OTA_ASSERT_DEVICE := moonstone,sunstone

# Inherit from the proprietary version
include vendor/xiaomi/stone/BoardConfigVendor.mk

# Inherit from sm6375-common
include device/xiaomi/sm6375-common/BoardConfigCommon.mk
