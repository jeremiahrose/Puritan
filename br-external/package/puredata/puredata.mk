PUREDATA_VERSION = 0.49-0
PUREDATA_SITE = https://github.com/pure-data/pure-data/archive
PUREDATA_SOURCE = $(PUREDATA_VERSION).tar.gz
PUREDATA_AUTORECONF = YES
PUREDATA_INSTALL_STAGING = YES

define PUREDATA_POST_EXTRACT_FIXUP
        mkdir -p output/build/puredata-$(PUREDATA_VERSION)/m4/generated
endef

PUREDATA_POST_EXTRACT_HOOKS += PUREDATA_POST_EXTRACT_FIXUP

$(eval $(autotools-package))
