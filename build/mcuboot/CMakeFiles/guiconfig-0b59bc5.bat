@echo off
cd /D C:\Users\FC\Desktop\adc\app\build\mcuboot\zephyr\kconfig || (set FAIL_LINE=2& goto :ABORT)
C:\Users\FC\.zephyrtools\cmake\cmake-3.22.0-windows-x86_64\bin\cmake.exe -E env ZEPHYR_BASE=C:/Users/FC/Desktop/adc/zephyr ZEPHYR_TOOLCHAIN_VARIANT=zephyr PYTHON_EXECUTABLE=C:/Users/FC/.zephyrtools/env/Scripts/python.exe srctree=C:/Users/FC/Desktop/adc/zephyr KERNELVERSION=0x2066300 KCONFIG_CONFIG=C:/Users/FC/Desktop/adc/app/build/mcuboot/zephyr/.config ARCH=arm ARCH_DIR=C:/Users/FC/Desktop/adc/zephyr/arch BOARD_DIR=C:/Users/FC/Desktop/adc/zephyr/boards/arm/circuitdojo_feather_nrf9160 KCONFIG_BINARY_DIR=C:/Users/FC/Desktop/adc/app/build/mcuboot/Kconfig TOOLCHAIN_KCONFIG_DIR=C:/Users/FC/.zephyrtools/toolchain/zephyr-sdk-0.16.4/cmake/zephyr EDT_PICKLE=C:/Users/FC/Desktop/adc/app/build/mcuboot/zephyr/edt.pickle ZEPHYR_NRF_MODULE_DIR=C:/Users/FC/Desktop/adc/nrf ZEPHYR_MCUBOOT_MODULE_DIR=C:/Users/FC/Desktop/adc/bootloader/mcuboot ZEPHYR_MCUBOOT_KCONFIG=C:/Users/FC/Desktop/adc/nrf/modules/mcuboot/Kconfig ZEPHYR_TRUSTED_FIRMWARE_M_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/tee/tfm ZEPHYR_TRUSTED_FIRMWARE_M_KCONFIG=C:/Users/FC/Desktop/adc/nrf/modules/trusted-firmware-m/Kconfig ZEPHYR_TFM_MCUBOOT_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/tee/tfm-mcuboot ZEPHYR_CJSON_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/cjson ZEPHYR_CJSON_KCONFIG=C:/Users/FC/Desktop/adc/nrf/modules/cjson/Kconfig ZEPHYR_OPENTHREAD_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/openthread ZEPHYR_PELION_DM_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/pelion-dm ZEPHYR_CDDL_GEN_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/cddl-gen ZEPHYR_CDDL_GEN_KCONFIG=C:/Users/FC/Desktop/adc/nrf/modules/cddl-gen/Kconfig ZEPHYR_MEMFAULT_FIRMWARE_SDK_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/memfault-firmware-sdk ZEPHYR_CANOPENNODE_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/canopennode ZEPHYR_CANOPENNODE_KCONFIG=C:/Users/FC/Desktop/adc/zephyr/modules/canopennode/Kconfig ZEPHYR_CIVETWEB_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/civetweb ZEPHYR_CMSIS_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/hal/cmsis ZEPHYR_FATFS_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/fs/fatfs ZEPHYR_HAL_NORDIC_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/hal/nordic ZEPHYR_HAL_NORDIC_KCONFIG=C:/Users/FC/Desktop/adc/zephyr/modules/hal_nordic/Kconfig ZEPHYR_ST_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/hal/st ZEPHYR_LIBMETAL_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/hal/libmetal ZEPHYR_LITTLEFS_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/fs/littlefs ZEPHYR_LORAMAC_NODE_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/loramac-node ZEPHYR_LORAMAC_NODE_KCONFIG=C:/Users/FC/Desktop/adc/zephyr/modules/loramac-node/Kconfig ZEPHYR_LVGL_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/gui/lvgl ZEPHYR_LZ4_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/lz4 ZEPHYR_LZ4_KCONFIG=C:/Users/FC/Desktop/adc/zephyr/modules/lz4/Kconfig ZEPHYR_MBEDTLS_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/crypto/mbedtls ZEPHYR_MBEDTLS_KCONFIG=C:/Users/FC/Desktop/adc/zephyr/modules/mbedtls/Kconfig ZEPHYR_MCUMGR_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/mcumgr ZEPHYR_MIPI_SYS_T_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/debug/mipi-sys-t ZEPHYR_NANOPB_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/nanopb ZEPHYR_NANOPB_KCONFIG=C:/Users/FC/Desktop/adc/zephyr/modules/nanopb/Kconfig ZEPHYR_NRF_HW_MODELS_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/bsim_hw_models/nrf_hw_models ZEPHYR_OPEN_AMP_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/open-amp ZEPHYR_SEGGER_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/debug/segger ZEPHYR_TINYCBOR_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/tinycbor ZEPHYR_TINYCRYPT_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/crypto/tinycrypt ZEPHYR_TRACERECORDER_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/debug/TraceRecorder ZEPHYR_TRACERECORDER_KCONFIG=C:/Users/FC/Desktop/adc/zephyr/modules/TraceRecorder/Kconfig ZEPHYR_NRFXLIB_MODULE_DIR=C:/Users/FC/Desktop/adc/nrfxlib ZEPHYR_CONNECTEDHOMEIP_MODULE_DIR=C:/Users/FC/Desktop/adc/modules/lib/matter SHIELD_AS_LIST= DTS_POST_CPP=C:/Users/FC/Desktop/adc/app/build/mcuboot/zephyr/circuitdojo_feather_nrf9160.dts.pre.tmp DTS_ROOT_BINDINGS=C:/Users/FC/Desktop/adc/nrf/dts/bindings?C:/Users/FC/Desktop/adc/zephyr/dts/bindings C:/Users/FC/.zephyrtools/env/Scripts/python.exe C:/Users/FC/Desktop/adc/zephyr/scripts/kconfig/guiconfig.py C:/Users/FC/Desktop/adc/bootloader/mcuboot/boot/zephyr/Kconfig || (set FAIL_LINE=3& goto :ABORT)
goto :EOF

:ABORT
set ERROR_CODE=%ERRORLEVEL%
echo Batch file failed at line %FAIL_LINE% with errorcode %ERRORLEVEL%
exit /b %ERROR_CODE%