# Makefile to create p7zip for LEDE/OpenWRT
#
# Copyright (C) 2017- Darcy Hu <hot123tea123@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=p7zip
PKG_VERSION:=16.02
PKG_RELEASE:=2

http://sourceforge.net/projects/p7zip/files/p7zip/$(PKG_VERSION)/p7zip_$(PKG_VERSION)_src_all.tar.bz2/download

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION)_src_all.tar.bz2
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)_$(PKG_VERSION)
PKG_SOURCE_URL:=@SF/$(PKG_NAME)/$(PKG_NAME)/$(PKG_VERSION)
PKG_MD5SUM:=a0128d661cfe7cc8c121e73519c54fbf

include $(INCLUDE_DIR)/package.mk

MAKE_FLAGS += 7z 7za 7zr

define Package/p7zip/Default
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=Compression
	TITLE:=p7zip archiver
	URL:=http://http://www.7-zip.org
	DEPENDS:=+libstdcpp +libpthread
endef

define Package/p7zip-7z
	$(call Package/p7zip/Default)
	TITLE += (uses plugins to handle archives)
endef

define Package/p7zip-7z/install
	$(INSTALL_DIR) $(1)/usr/lib/p7zip/Codecs
	$(CP) $(PKG_BUILD_DIR)/bin/7z.so $(1)/usr/lib/p7zip
	$(CP) $(PKG_BUILD_DIR)/bin/Codecs/Rar.so $(1)/usr/lib/p7zip/Codecs

	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/7z $(1)/usr/lib/p7zip
	$(INSTALL_BIN) ./files/7z $(1)/usr/bin
endef

define Package/p7zip-7za
	$(call Package/p7zip/Default)
	TITLE += (fewer archive formats than p7zip-7z)
endef

define Package/p7zip-7za/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/7za $(1)/usr/bin
	$(LN) 7za $(1)/usr/bin/7z
endef

define Package/p7zip-7zr
	$(call Package/p7zip/Default)
	TITLE += (only 7z archives)
endef

define Package/p7zip-7zr/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/7zr $(1)/usr/bin
	$(LN) 7zr $(1)/usr/bin/7z
endef

$(eval $(call BuildPackage,p7zip-7z))
$(eval $(call BuildPackage,p7zip-7za))
$(eval $(call BuildPackage,p7zip-7zr))
