add_custom_target(spm_shared_property_target)
set_property(TARGET spm_shared_property_target  PROPERTY KERNEL_HEX_NAME;zephyr.hex)
set_property(TARGET spm_shared_property_target  PROPERTY ZEPHYR_BINARY_DIR;C:/Users/FC/Desktop/adc/app/build/spm/zephyr)
set_property(TARGET spm_shared_property_target  PROPERTY KERNEL_ELF_NAME;zephyr.elf)
set_property(TARGET spm_shared_property_target  PROPERTY BUILD_BYPRODUCTS;C:/Users/FC/Desktop/adc/app/build/spm/zephyr/zephyr.hex;C:/Users/FC/Desktop/adc/app/build/spm/zephyr/zephyr.elf)
set_property(TARGET spm_shared_property_target APPEND PROPERTY BUILD_BYPRODUCTS;C:/Users/FC/Desktop/adc/app/build/spm/libspmsecureentries.a)
set_property(TARGET spm_shared_property_target APPEND PROPERTY PM_YML_DEP_FILES;C:/Users/FC/Desktop/adc/nrf/samples/spm/pm.yml)
set_property(TARGET spm_shared_property_target APPEND PROPERTY PM_YML_FILES;C:/Users/FC/Desktop/adc/app/build/spm/zephyr/include/generated/pm.yml)
set_property(TARGET spm_shared_property_target APPEND PROPERTY PM_YML_DEP_FILES;C:/Users/FC/Desktop/adc/nrf/subsys/partition_manager/pm.yml.trustzone)
set_property(TARGET spm_shared_property_target APPEND PROPERTY PM_YML_FILES;C:/Users/FC/Desktop/adc/app/build/spm/modules/nrf/subsys/partition_manager/pm.yml.trustzone)
