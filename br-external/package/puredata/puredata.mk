PUREDATA_VERSION = 0.49-0
PUREDATA_SITE = https://github.com/pure-data/pure-data/archive
PUREDATA_SOURCE = $(PUREDATA_VERSION).tar.gz
PUREDATA_AUTORECONF = YES
PUREDATA_INSTALL_STAGING = YES

define PUREDATA_POST_EXTRACT_FIXUP
        mkdir -p output/build/puredata-$(PUREDATA_VERSION)/m4/generated
endef
PUREDATA_POST_EXTRACT_HOOKS += PUREDATA_POST_EXTRACT_FIXUP

define PUREDATA_POST_INSTALL_FIXUP
	rm -f output/target/usr/lib/pd/bin/pd
	ln -s /usr/bin/pd output/target/usr/lib/pd/bin/pd
	mkdir --parents output/target/home/jez
	ln -s /tmp output/target/home/jez/.config
endef
PUREDATA_POST_INSTALL_TARGET_HOOKS += PUREDATA_POST_INSTALL_FIXUP

$(eval $(autotools-package))
