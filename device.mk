# API
BOARD_SHIPPING_API_LEVEL := 30

SHIPPING_API_LEVEL := 30
PRODUCT_SHIPPING_API_LEVEL := $(SHIPPING_API_LEVEL)

# DEVICE uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Audio
PRODUCT_VENDOR_PROPERTIES += \
    persist.sys.audio.para_version=M17-Audiopara-global-V18-20221203 \
    persist.sys.audio.button_jack.profile=volume \
    persist.sys.audio.button_jack.switch=0

# Display
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_display_power_timer_ms=1000 \
    ro.surface_flinger.set_idle_timer_ms=5000 \
    ro.surface_flinger.set_touch_timer_ms=5000 \
    ro.surface_flinger.support_kernel_idle_timer=true

PRODUCT_VENDOR_PROPERTIES += \
    vendor.display.defer_fps_frame_count=2 \
    vendor.display.idle_time=0 \
    vendor.display.idle_time_inactive=0

# Kernel
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)-kernel/kernel
PRODUCT_ENABLE_UFFD_GC := false
ifeq ($(PREBUILT_KERNEL),true)
PRODUCT_VENDOR_KERNEL_HEADERS := device/xiaomi/stone-kernel/kernel-headers

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    device/xiaomi/stone-kernel
endif

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1.vendor

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail \
    libavservices_minijail.vendor \
    libavservices_minijail_vendor \
    libcodec2_hidl@1.1.vendor \
    libstagefright_omx \
    libstagefright_omx.vendor \
    libstagefright_foundation \
    libstagefright_softomx.vendor \
    android.hardware.media.c2@1.1.vendor \
    android.hardware.media.c2@1.2.vendor \
    libcodec2_soft_avcdec \
    libcodec2_soft_avcenc \
    libcodec2_soft_h263dec \
    libcodec2_soft_h263enc \
    libcodec2_soft_mpeg4dec \
    libcodec2_soft_mpeg4enc \
    libcodec2_soft_vp8dec \
    libcodec2_soft_vp8enc \
    libcodec2_soft_vp9dec \
    libcodec2_soft_vp9enc \
    libcodec2_soft_hevcdec \
    libcodec2_soft_hevcenc

PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)-kernel/ramdisk-modules/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)-kernel/vendor-modules/,$(TARGET_COPY_OUT_VENDOR)/lib/modules)

PRODUCT_VENDOR_KERNEL_HEADERS += $(LOCAL_PATH)-kernel/kernel-headers

# NFC
$(call inherit-product, hardware/st/nfc/nfc_vendor_product.mk)
TARGET_USES_ST_NFC := true

PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2.vendor \
    com.android.nfc_extras \
    libchrome.vendor \
    NfcNci \
    SecureElement \
    Tag

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.nfc.repair=1

# Overlays
PRODUCT_PACKAGES += \
    AOSPAStoneOverlay \
    StoneFrameworksOverlay \
    StoneSettingsOverlay \
    StoneSystemUIOverlay

# Rootdir
PRODUCT_PACKAGES += \
    init.device.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from vendor blobs
$(call inherit-product, vendor/xiaomi/stone/stone-vendor.mk)

# Inherit from sm6375-common
$(call inherit-product, device/xiaomi/sm6375-common/holi.mk)


# Audio
PRODUCT_PACKAGES += \
	android.hardware.audio.effect@7.0-impl \
	android.hardware.audio.service \
	android.hardware.audio@7.0-impl \
	libtinyalsa
TARGET_PROVIDES_AUDIO_HAL := true
