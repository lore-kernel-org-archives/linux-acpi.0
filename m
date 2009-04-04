From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 03/12] thinkpad-acpi: documentation cleanup
Date: Sat,  4 Apr 2009 01:25:44 -0300
Message-ID: <1238819153-16004-4-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43284 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865AbZDDE0D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:03 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some cleanups to the documentation of the driver.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |   76 +++++++++++++++++++++----------
 1 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 41bc99f..f6e6bc6 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -20,7 +20,8 @@ moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
 kernel 2.6.29 and release 0.22.
 
 The driver is named "thinkpad-acpi".  In some places, like module
-names, "thinkpad_acpi" is used because of userspace issues.
+names and log messages, "thinkpad_acpi" is used because of userspace
+issues.
 
 "tpacpi" is used as a shorthand where "thinkpad-acpi" would be too
 long due to length limitations on some Linux kernel versions.
@@ -37,7 +38,7 @@ detailed description):
 	- ThinkLight on and off
 	- limited docking and undocking
 	- UltraBay eject
-	- CMOS control
+	- CMOS/UCMS control
 	- LED control
 	- ACPI sounds
 	- temperature sensors
@@ -46,6 +47,7 @@ detailed description):
 	- Volume control
 	- Fan control and monitoring: fan speed, fan enable/disable
 	- WAN enable and disable
+	- UWB enable and disable
 
 A compatibility table by model and feature is maintained on the web
 site, http://ibm-acpi.sf.net/. I appreciate any success or failure
@@ -53,7 +55,7 @@ reports, especially if they add to or correct the compatibility table.
 Please include the following information in your report:
 
 	- ThinkPad model name
-	- a copy of your DSDT, from /proc/acpi/dsdt
+	- a copy of your ACPI tables, using the "acpidump" utility
 	- a copy of the output of dmidecode, with serial numbers
 	  and UUIDs masked off
 	- which driver features work and which don't
@@ -66,17 +68,18 @@ Installation
 ------------
 
 If you are compiling this driver as included in the Linux kernel
-sources, simply enable the CONFIG_THINKPAD_ACPI option, and optionally
-enable the CONFIG_THINKPAD_ACPI_BAY option if you want the
-thinkpad-specific bay functionality.
+sources, look for the CONFIG_THINKPAD_ACPI Kconfig option.
+It is located on the menu path: "Device Drivers" -> "X86 Platform
+Specific Device Drivers" -> "ThinkPad ACPI Laptop Extras".
+
 
 Features
 --------
 
 The driver exports two different interfaces to userspace, which can be
 used to access the features it provides.  One is a legacy procfs-based
-interface, which will be removed at some time in the distant future.
-The other is a new sysfs-based interface which is not complete yet.
+interface, which will be removed at some time in the future.  The other
+is a new sysfs-based interface which is not complete yet.
 
 The procfs interface creates the /proc/acpi/ibm directory.  There is a
 file under that directory for each feature it supports.  The procfs
@@ -111,15 +114,17 @@ The version of thinkpad-acpi's sysfs interface is exported by the driver
 as a driver attribute (see below).
 
 Sysfs driver attributes are on the driver's sysfs attribute space,
-for 2.6.23 this is /sys/bus/platform/drivers/thinkpad_acpi/ and
+for 2.6.23+ this is /sys/bus/platform/drivers/thinkpad_acpi/ and
 /sys/bus/platform/drivers/thinkpad_hwmon/
 
 Sysfs device attributes are on the thinkpad_acpi device sysfs attribute
-space, for 2.6.23 this is /sys/devices/platform/thinkpad_acpi/.
+space, for 2.6.23+ this is /sys/devices/platform/thinkpad_acpi/.
 
 Sysfs device attributes for the sensors and fan are on the
 thinkpad_hwmon device's sysfs attribute space, but you should locate it
-looking for a hwmon device with the name attribute of "thinkpad".
+looking for a hwmon device with the name attribute of "thinkpad", or
+better yet, through libsensors.
+
 
 Driver version
 --------------
@@ -129,6 +134,7 @@ sysfs driver attribute: version
 
 The driver name and version. No commands can be written to this file.
 
+
 Sysfs interface version
 -----------------------
 
@@ -160,6 +166,7 @@ expect that an attribute might not be there, and deal with it properly
 (an attribute not being there *is* a valid way to make it clear that a
 feature is not available in sysfs).
 
+
 Hot keys
 --------
 
@@ -618,6 +625,7 @@ For Lenovo models *with* ACPI backlight control:
    and map them to KEY_BRIGHTNESS_UP and KEY_BRIGHTNESS_DOWN.  Process
    these keys on userspace somehow (e.g. by calling xbacklight).
 
+
 Bluetooth
 ---------
 
@@ -628,6 +636,9 @@ sysfs rfkill class: switch "tpacpi_bluetooth_sw"
 This feature shows the presence and current state of a ThinkPad
 Bluetooth device in the internal ThinkPad CDC slot.
 
+If the ThinkPad supports it, the Bluetooth state is stored in NVRAM,
+so it is kept across reboots and power-off.
+
 Procfs notes:
 
 If Bluetooth is installed, the following commands can be used:
@@ -652,6 +663,7 @@ Sysfs notes:
 	rfkill controller switch "tpacpi_bluetooth_sw": refer to
 	Documentation/rfkill.txt for details.
 
+
 Video output control -- /proc/acpi/ibm/video
 --------------------------------------------
 
@@ -693,11 +705,8 @@ Fn-F7 from working. This also disables the video output switching
 features of this driver, as it uses the same ACPI methods as
 Fn-F7. Video switching on the console should still work.
 
-UPDATE: There's now a patch for the X.org Radeon driver which
-addresses this issue. Some people are reporting success with the patch
-while others are still having problems. For more information:
+UPDATE: refer to https://bugs.freedesktop.org/show_bug.cgi?id=2000
 
-https://bugs.freedesktop.org/show_bug.cgi?id=2000
 
 ThinkLight control
 ------------------
@@ -720,10 +729,11 @@ The ThinkLight sysfs interface is documented by the LED class
 documentation, in Documentation/leds-class.txt.  The ThinkLight LED name
 is "tpacpi::thinklight".
 
-Due to limitations in the sysfs LED class, if the status of the thinklight
+Due to limitations in the sysfs LED class, if the status of the ThinkLight
 cannot be read or if it is unknown, thinkpad-acpi will report it as "off".
 It is impossible to know if the status returned through sysfs is valid.
 
+
 Docking / undocking -- /proc/acpi/ibm/dock
 ------------------------------------------
 
@@ -784,6 +794,7 @@ the only docking stations currently supported are the X-series
 UltraBase docks and "dumb" port replicators like the Mini Dock (the
 latter don't need any ACPI support, actually).
 
+
 UltraBay eject -- /proc/acpi/ibm/bay
 ------------------------------------
 
@@ -847,8 +858,9 @@ supported. Use "eject2" instead of "eject" for the second bay.
 Note: the UltraBay eject support on the 600e/x, A22p and A3x is
 EXPERIMENTAL and may not work as expected. USE WITH CAUTION!
 
-CMOS control
-------------
+
+CMOS/UCMS control
+-----------------
 
 procfs: /proc/acpi/ibm/cmos
 sysfs device attribute: cmos_command
@@ -882,6 +894,7 @@ The cmos command interface is prone to firmware split-brain problems, as
 in newer ThinkPads it is just a compatibility layer.  Do not use it, it is
 exported just as a debug tool.
 
+
 LED control
 -----------
 
@@ -939,6 +952,7 @@ ThinkPad indicator LED should blink in hardware accelerated mode, use the
 "timer" trigger, and leave the delay_on and delay_off parameters set to
 zero (to request hardware acceleration autodetection).
 
+
 ACPI sounds -- /proc/acpi/ibm/beep
 ----------------------------------
 
@@ -968,6 +982,7 @@ X40:
 	16 - one medium-pitched beep repeating constantly, stop with 17
 	17 - stop 16
 
+
 Temperature sensors
 -------------------
 
@@ -1115,6 +1130,7 @@ registers contain the current battery capacity, etc. If you experiment
 with this, do send me your results (including some complete dumps with
 a description of the conditions when they were taken.)
 
+
 LCD brightness control
 ----------------------
 
@@ -1124,10 +1140,9 @@ sysfs backlight device "thinkpad_screen"
 This feature allows software control of the LCD brightness on ThinkPad
 models which don't have a hardware brightness slider.
 
-It has some limitations: the LCD backlight cannot be actually turned on or
-off by this interface, and in many ThinkPad models, the "dim while on
-battery" functionality will be enabled by the BIOS when this interface is
-used, and cannot be controlled.
+It has some limitations: the LCD backlight cannot be actually turned
+on or off by this interface, it just controls the backlight brightness
+level.
 
 On IBM (and some of the earlier Lenovo) ThinkPads, the backlight control
 has eight brightness levels, ranging from 0 to 7.  Some of the levels
@@ -1201,6 +1216,7 @@ WARNING:
     and maybe reduce the life of the backlight lamps by needlessly kicking
     its level up and down at every change.
 
+
 Volume control -- /proc/acpi/ibm/volume
 ---------------------------------------
 
@@ -1217,6 +1233,11 @@ distinct. The unmute the volume after the mute command, use either the
 up or down command (the level command will not unmute the volume).
 The current volume level and mute state is shown in the file.
 
+The ALSA mixer interface to this feature is still missing, but patches
+to add it exist.  That problem should be addressed in the not so
+distant future.
+
+
 Fan control and monitoring: fan speed, fan enable/disable
 ---------------------------------------------------------
 
@@ -1383,8 +1404,11 @@ procfs: /proc/acpi/ibm/wan
 sysfs device attribute: wwan_enable (deprecated)
 sysfs rfkill class: switch "tpacpi_wwan_sw"
 
-This feature shows the presence and current state of a W-WAN (Sierra
-Wireless EV-DO) device.
+This feature shows the presence and current state of the built-in
+Wireless WAN device.
+
+If the ThinkPad supports it, the WWAN state is stored in NVRAM,
+so it is kept across reboots and power-off.
 
 It was tested on a Lenovo ThinkPad X60. It should probably work on other
 ThinkPad models which come with this module installed.
@@ -1413,6 +1437,7 @@ Sysfs notes:
 	rfkill controller switch "tpacpi_wwan_sw": refer to
 	Documentation/rfkill.txt for details.
 
+
 EXPERIMENTAL: UWB
 -----------------
 
@@ -1431,6 +1456,7 @@ Sysfs notes:
 	rfkill controller switch "tpacpi_uwb_sw": refer to
 	Documentation/rfkill.txt for details.
 
+
 Multiple Commands, Module Parameters
 ------------------------------------
 
@@ -1445,6 +1471,7 @@ for example:
 
 	modprobe thinkpad_acpi hotkey=enable,0xffff video=auto_disable
 
+
 Enabling debugging output
 -------------------------
 
@@ -1467,6 +1494,7 @@ The level of debugging information output by the driver can be changed
 at runtime through sysfs, using the driver attribute debug_level.  The
 attribute takes the same bitmask as the debug module parameter above.
 
+
 Force loading of module
 -----------------------
 
-- 
1.6.2.1

