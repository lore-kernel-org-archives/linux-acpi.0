From: Carlos Corbacho <cathectic@gmail.com>
Subject: [RFC][PATCH 3/5] ACPI: acer_acpi: Add documentation
Date: Tue, 17 Jul 2007 15:47:48 +0100
Message-ID: <200707171547.49139.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:20010 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbXGQOrh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 10:47:37 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1532030wxd
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 07:47:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Add documentation for acer_acpi

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 Documentation/acer_acpi.txt |  126 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/Documentation/acer_acpi.txt b/Documentation/acer_acpi.txt
new file mode 100644
index 0000000..bc8cce4
--- /dev/null
+++ b/Documentation/acer_acpi.txt
@@ -0,0 +1,126 @@
+Acer Laptop ACPI Extras Driver
+******************************
+
+	Copyright (C) 2005-2007 E.M. Smith
+	Copyright (C) 2007 Carlos Corbacho <cathectic@gmail.com>
+
+### THIS IS VERY MUCH A WORK IN PROGRESS.  NO WARRANTY GIVEN.  IF YOU
+### BREAK YOUR LAPTOP USING THIS DRIVER, YOU GET TO KEEP THE PIECES AND
+### WE WILL ACCEPT ABSOLUTELY NO RESPONSIBILITY.
+
+acer_acpi is a driver to allow you to control various aspects of your Acer
+laptop hardware using the Linux kernel, on Acer laptops that have an ACPI device
+with _HID PNP0C14 - the two supported devices so far are AMW0 and WMID.
+
+Background
+**********
+
+acer_acpi was originally developed in order to activate the wireless LAN card
+under a 64-bit version of Linux, as acerhk[1] (the previous fine solution to the
+problem) relied on making 32-bit BIOS calls which are not allowed from a 64-bit
+OS.
+
+However, acer_acpi will work on both x86 and x86-64.
+
+[1] acerhk: http://www.cakey.de/acerhk/
+
+Platform specific
+*****************
+
+Loading acer_acpi will create the following directory:
+
+/sys/devices/platform/acer_acpi/
+
+In this directory are the following files, which you can read/write to with
+the standard *NIX tools (cat, echo, etc...).
+
+wireless	Enable/ disable the wireless device
+bluetooth	Enable/ disable the bluetooth device
+threeg		Enable/ disable the 3G device (WMID only)
+
+e.g.
+
+To enable wireless:
+	# echo 1 > /sys/devices/platform/acer_acpi/wireless
+To disable wireless:
+	# echo 0 > /sys/devices/platform/acer_acpi/wireless
+To read the wireless status:
+	# cat /sys/devices/platform/acer_acpi/wireless
+
+Backlight
+*********
+
+If your backlight is supported (WMID only), this directory will exist:
+
+/sys/class/backlight/acer_acpi/
+
+Acer backlights support brightness values of 0 to 15
+
+Mail LED
+********
+
+If your mail LED is supported (AMW0 only), this directory will exist:
+
+/sys/class/leds/acer_acpi:mail
+
+Multimedia Keys
+***************
+
+Some newer Acer laptops inexplicably require an old keyboard quirk to make the
+multimedia keys emit scancodes.
+
+This quirk is automatically applied on those laptops that we know require it.
+If the multimedia keys on your laptop do not work, please contact us so we can
+add your laptop to this list.
+
+Bugs/ Limitations
+*****************
+
+* Acer has provided _no_ information or documentation on their hardware - this
+driver is the result of the hard work of many people deciphering Acer's
+hardware.
+
+* The behaviour of the wireless LED will depend on your hardware and driver
+combination.
+
+e.g. With the BCM4318 on the 5020 series:
+
+ndiswrapper: Light blinks on when transmitting
+bcm43xx: Solid light, blinks off when transmitting
+
+* AMW0 does not provide any methods to retrieve the current status of a device.
+We therefore store the last value we wrote to the device and return this. On
+startup for AMW0, we default to turning all the devices off so we have a sane
+default. This means that the status value can be wrong on X86_32 if you use
+wistron_btns to manipulate the same hardware.
+
+* acer_acpi does not yet have any means of deciding whether to enable or disable
+entries in sysfs - this means that for hardware that isn't there, you can still
+read/ write the corresponding sysfs file.
+
+(So: Just because there is a bluetooth file, doesn't mean you now actually have
+a Bluetooth device.)
+
+* AMW0 and WMID expose different capabilities (e.g. the mail LED works on AMW0,
+but not WMID).
+
+* We don't gurantee acer_acpi will work on your laptop. We keep a list of known
+supported (and some known unsupported hardware) here:
+http://code.google.com/p/aceracpi/wiki/SupportedHardware
+
+If your Acer laptop is not on that list, please send in your DSDT to us.
+
+Credits
+*******
+
+* Olaf Tauber, who did the real hard work when he developed acerhk
+http://www.informatik.hu-berlin.de/~tauber/acerhk
+
+* All the authors of laptop acpi modules in the kernel, whose work was an
+inspiration and a source of good code
+
+* Mathieu Segaud, who solved the problem with having to modprobe the driver
+twice in early versions
+
+* Jim Ramsay, who reverse engineered, and added support for the new WMID
+interface
-- 
1.4.2.1

