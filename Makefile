ARCHS = armv7 arm64 arm64e
SDK = iPhoneOS12.1.2
FINALPACKAGE = 1
THEOS_DEVICE_IP = 192.168.1.101

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Roxanne
Roxanne_FILES = Tweak.xm
Roxanne_FRAMEWORKS = UIKit CoreGraphics AVFoundation AudioToolbox
Roxanne_EXTRA_FRAMEWORKS += Cephei
Roxanne += -Wl,-segalign,4000
Roxanne_CFLAGS = -Wno-deprecated -Wno-deprecated-declarations -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += roxanne
include $(THEOS_MAKE_PATH)/aggregate.mk
