DISIS_SPI_VERSION = 1.0
DISIS_SPI_SITE = ../br-external/package/disis_spi
DISIS_SPI_SITE_METHOD = local
DISIS_SPI_DEPENDENCIES = wiringpi puredata

define DISIS_SPI_BUILD_CMDS
	#$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
	$(TARGET_CC) $(TARGET_CFLAGS) -o $(@D)/disis_spi.o -c $(@D)/disis_spi.c
	$(TARGET_LD) $(TARGET_LDFLAGS) -shared -o $(@D)/disis_spi.l_arm $(@D)/disis_spi.o -lc -lm $(APPENDFLAGS)
	$(TARGET_STRIP) --strip-unneeded $(@D)/disis_spi.l_arm
	rm $(@D)/disis_spi.o
	mv $(@D)/disis_spi.l_arm $(@D)/disis_spi.pd_linux
endef

define DISIS_SPI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/disis_spi.pd_linux $(TARGET_DIR)/usr/local/lib/pd-externals/disis_spi.pd_linux
        $(INSTALL) -D -m 0755 $(@D)/disis_spi-help.pd $(TARGET_DIR)/usr/local/lib/pd-externals/disis_spi-help.pd
endef

$(eval $(generic-package))
