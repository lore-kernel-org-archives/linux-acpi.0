From: malattia@linux.it
Subject: [PATCH 2/2] Update sony-laptop docs
Date: Thu,  8 Feb 2007 20:16:41 +0100
Message-ID: <11709622012389-git-send-email-malattia@linux.it>
References: <11709622011964-git-send-email-malattia@linux.it> <11709622013582-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:45232 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423293AbXBHUBk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2007 15:01:40 -0500
In-Reply-To: <11709622013582-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Be consistent with current implementation (backlight subsys and
platform_device).

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 Documentation/acpi/sony_acpi.txt |   87 -------------------------------
 Documentation/sony-laptop.txt    |  106 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/Kconfig             |   14 +++---
 3 files changed, 113 insertions(+), 94 deletions(-)

diff --git a/Documentation/acpi/sony_acpi.txt b/Documentation/acpi/sony_acpi.txt
deleted file mode 100644
index 35a04be..0000000
--- a/Documentation/acpi/sony_acpi.txt
+++ /dev/null
@@ -1,87 +0,0 @@
-ACPI Sony Notebook Control Driver (SNC) Readme
-----------------------------------------------
-	Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
-
-This mini-driver drives the ACPI SNC device present in the
-ACPI BIOS of the Sony Vaio laptops.
-
-It gives access to some extra laptop functionalities. In
-its current form, this driver is mainly useful for controlling the
-screen brightness, but it may do more in the future.
-
-You should probably start by trying the sonypi driver, and try
-sony_acpi only if sonypi doesn't work for you.
-
-Usage:
-------
-
-Loading the sony_acpi module will create a /proc/acpi/sony/
-directory populated with a couple of files.
-
-You then read/write integer values from/to those files by using
-standard UNIX tools.
-
-The files are:
-	brightness		current screen brightness
-	brightness_default	screen brightness which will be set
-				when the laptop will be rebooted
-	cdpower			power on/off the internal CD drive
-
-Note that some files may be missing if they are not supported
-by your particular laptop model.
-
-Example usage:
-	# echo "1" > /proc/acpi/sony/brightness
-sets the lowest screen brightness,
-	# echo "8" > /proc/acpi/sony/brightness
-sets the highest screen brightness,
-	# cat /proc/acpi/sony/brightness
-retrieves the current screen brightness.
-
-Development:
-------------
-
-If you want to help with the development of this driver (and
-you are not afraid of any side effects doing strange things with
-your ACPI BIOS could have on your laptop), load the driver and
-pass the option 'debug=1'.
-
-REPEAT: DON'T DO THIS IF YOU DON'T LIKE RISKY BUSINESS.
-
-In your kernel logs you will find the list of all ACPI methods
-the SNC device has on your laptop. You can see the GBRT/SBRT methods
-used to get/set the brightness, but there are others.
-
-I HAVE NO IDEA WHAT THOSE METHODS DO.
-
-The sony_acpi driver creates, for some of those methods (the most
-current ones found on several Vaio models), an entry under
-/proc/acpi/sony/, just like the 'brightness' one. You can create
-other entries corresponding to your own laptop methods by further
-editing the source (see the 'sony_acpi_values' table, and add a new
-structure to this table with your get/set method names).
-
-Your mission, should you accept it, is to try finding out what
-those entries are for, by reading/writing random values from/to those
-files and find out what is the impact on your laptop.
-
-Should you find anything interesting, please report it back to me,
-I will not disavow all knowledge of your actions :)
-
-Bugs/Limitations:
------------------
-
-* This driver is not based on official documentation from Sony
-  (because there is none), so there is no guarantee this driver
-  will work at all, or do the right thing. Although this hasn't
-  happened to me, this driver could do very bad things to your
-  laptop, including permanent damage.
-
-* The sony_acpi and sonypi drivers do not interact at all. In the
-  future, sonypi could use sony_acpi to do (part of) its business.
-
-* spicctrl, which is the userspace tool used to communicate with the
-  sonypi driver (through /dev/sonypi) does not try to use the
-  sony_acpi driver. In the future, spicctrl could try sonypi first,
-  and if it isn't present, try sony_acpi instead.
-
diff --git a/Documentation/sony-laptop.txt b/Documentation/sony-laptop.txt
new file mode 100644
index 0000000..dfd26df
--- /dev/null
+++ b/Documentation/sony-laptop.txt
@@ -0,0 +1,106 @@
+Sony Notebook Control Driver (SNC) Readme
+-----------------------------------------
+	Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
+
+This mini-driver drives the SNC device present in the ACPI BIOS of
+the Sony Vaio laptops.
+
+It gives access to some extra laptop functionalities. In its current
+form, this driver let the user set or query the screen brightness
+through the backlight subsystem and remove/apply power to some devices.
+
+Backlight control:
+------------------
+If your laptop model supports it, you will find sysfs files in the
+/sys/class/backlight/sony/
+directory. You will be able to query and set the current screen
+brightness:
+	brightness		get/set screen brightness (an iteger
+				between 0 and 7)
+	actual_brightness	reading from this file will query the HW
+				to get real brightness value
+	max_brightness		the maximum brightness value
+
+
+Platform specific:
+------------------
+Loading the sony-laptop module will create a
+/sys/devices/platform/sony-laptop/
+directory populated with some files.
+
+You then read/write integer values from/to those files by using
+standard UNIX tools.
+
+The files are:
+	brightness_default	screen brightness which will be set
+				when the laptop will be rebooted
+	cdpower			power on/off the internal CD drive
+	audiopower		power on/off the internal sound card
+	lanpower		power on/off the internal ethernet card
+				(only in debug mode)
+
+Note that some files may be missing if they are not supported
+by your particular laptop model.
+
+Example usage:
+	# echo "1" > /sys/devices/platform/sony-laptop/brightness_default
+sets the lowest screen brightness for the next and later reboots,
+	# echo "8" > /sys/devices/platform/sony-laptop/brightness_default
+sets the highest screen brightness for the next and later reboots,
+	# cat /sys/devices/platform/sony-laptop/brightness_default
+retrieves the value.
+
+	# echo "0" > /sys/devices/platform/sony-laptop/audiopower
+powers off the sound card,
+	# echo "1" > /sys/devices/platform/sony-laptop/audiopower
+powers on the sound card.
+
+Development:
+------------
+
+If you want to help with the development of this driver (and
+you are not afraid of any side effects doing strange things with
+your ACPI BIOS could have on your laptop), load the driver and
+pass the option 'debug=1'.
+
+REPEAT: DON'T DO THIS IF YOU DON'T LIKE RISKY BUSINESS.
+
+In your kernel logs you will find the list of all ACPI methods
+the SNC device has on your laptop. You can see the GCDP/GCDP methods
+used to pwer on/off the CD drive, but there are others.
+
+I HAVE NO IDEA WHAT THOSE METHODS DO.
+
+The sony-laptop driver creates, for some of those methods (the most
+current ones found on several Vaio models), an entry under
+/sys/devices/platform/sony-laptop, just like the 'cdpower' one.
+You can create other entries corresponding to your own laptop methods by
+further editing the source (see the 'sony_acpi_values' table, and add a new
+entry to this table with your get/set method names using the
+HANDLE_NAMES macro).
+
+Your mission, should you accept it, is to try finding out what
+those entries are for, by reading/writing random values from/to those
+files and find out what is the impact on your laptop.
+
+Should you find anything interesting, please report it back to me,
+I will not disavow all knowledge of your actions :)
+
+Bugs/Limitations:
+-----------------
+
+* This driver is not based on official documentation from Sony
+  (because there is none), so there is no guarantee this driver
+  will work at all, or do the right thing. Although this hasn't
+  happened to me, this driver could do very bad things to your
+  laptop, including permanent damage.
+
+* The sony-laptop and sonypi drivers do not interact at all. In the
+  future, sonypi could use sony-laptop to do (part of) its business.
+
+* spicctrl, which is the userspace tool used to communicate with the
+  sonypi driver (through /dev/sonypi) does not try to use the
+  sony-laptop driver. In the future, spicctrl could try sonypi first,
+  and if it isn't present, try sony-laptop instead.
+
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 926ae11..8c409dc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -112,14 +112,14 @@ config SONY_LAPTOP
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	  ---help---
-	  This mini-driver drives the ACPI SNC device present in the
-	  ACPI BIOS of the Sony Vaio laptops.
+	  This mini-driver drives the SNC device present in the ACPI BIOS of
+	  the Sony Vaio laptops.
 
-	  It gives access to some extra laptop functionalities. In
-	  its current form, the only thing this driver does is letting
-	  the user set or query the screen brightness and remove/apply
-	  power to some devices.
+	  It gives access to some extra laptop functionalities. In its current
+	  form, this driver let the user set or query the screen brightness
+	  through the backlight subsystem and remove/apply power to some
+	  devices.
 
-	  Read <file:Documentation/acpi/sony_acpi.txt> for more information.
+	  Read <file:Documentation/sony-laptop.txt> for more information.
 
 endmenu
-- 
1.4.4.3

