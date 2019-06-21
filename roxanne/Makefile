ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Roxanne
Roxanne_FILES = $(wildcard *.mm)
Roxanne_INSTALL_PATH = /Library/PreferenceBundles
Roxanne_FRAMEWORKS = UIKit MessageUI CoreGraphics AudioToolbox AVFoundation
Roxanne_PRIVATE_FRAMEWORKS = Preferences
Roxanne_EXTRA_FRAMEWORKS += CepheiPrefs
Roxanne_CFLAGS = -Wno-deprecated -Wno-deprecated-declarations -Wno-error

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Roxanne.plist$(ECHO_END)
