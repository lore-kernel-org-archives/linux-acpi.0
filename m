From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/5] sony-laptop - Move sony-laptop.txt to
	Documentation/laptops
Date: Sat, 09 Feb 2008 01:32:14 +0000
Message-ID: <20080209013214.4895.98741.stgit@pacifica>
References: <20080209013157.4895.70128.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:57961 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754325AbYBIBcf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 20:32:35 -0500
In-Reply-To: <20080209013157.4895.70128.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, Mattia Dongili <malattia@linux.it>

Also update references to sony-laptop.txt in Kconfig.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
CC: Randy Dunlap <randy.dunlap@oracle.com>
CC: Mattia Dongili <malattia@linux.it>
---

 Documentation/00-INDEX                |    2 -
 Documentation/laptops/00-INDEX        |    2 +
 Documentation/laptops/sony-laptop.txt |  117 +++++++++++++++++++++++++++++++++
 Documentation/sony-laptop.txt         |  117 ---------------------------------
 drivers/misc/Kconfig                  |    2 -
 5 files changed, 120 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/laptops/sony-laptop.txt
 delete mode 100644 Documentation/sony-laptop.txt


diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index d69b2a3..012ef98 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -353,8 +353,6 @@ sh/
 	- directory with info on porting Linux to a new architecture.
 smart-config.txt
 	- description of the Smart Config makefile feature.
-sony-laptop.txt
-	- Sony Notebook Control Driver (SNC) Readme.
 sonypi.txt
 	- info on Linux Sony Programmable I/O Device support.
 sound/
diff --git a/Documentation/laptops/00-INDEX b/Documentation/laptops/00-INDEX
index e806b08..c5bac77 100644
--- a/Documentation/laptops/00-INDEX
+++ b/Documentation/laptops/00-INDEX
@@ -1,4 +1,6 @@
 00-INDEX
 	- This file
+sony-laptop.txt
+	- Sony Notebook Control Driver (SNC) Readme.
 thinkpad-acpi.txt
 	- information on the (IBM and Lenovo) ThinkPad ACPI Extras driver.
diff --git a/Documentation/laptops/sony-laptop.txt b/Documentation/laptops/sony-laptop.txt
new file mode 100644
index 0000000..7a5c1a8
--- /dev/null
+++ b/Documentation/laptops/sony-laptop.txt
@@ -0,0 +1,117 @@
+Sony Notebook Control Driver (SNC) Readme
+-----------------------------------------
+	Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
+
+This mini-driver drives the SNC and SPIC device present in the ACPI BIOS of the
+Sony Vaio laptops. This driver mixes both devices functions under the same
+(hopefully consistent) interface. This also means that the sonypi driver is
+obsoleted by sony-laptop now.
+
+Fn keys (hotkeys):
+------------------
+Some models report hotkeys through the SNC or SPIC devices, such events are
+reported both through the ACPI subsystem as acpi events and through the INPUT
+subsystem. See the logs of acpid or /proc/acpi/event and
+/proc/bus/input/devices to find out what those events are and which input
+devices are created by the driver.
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
+	bluetoothpower		power on/off the internal bluetooth device
+	fanspeed		get/set the fan speed
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
+further editing the source (see the 'sony_nc_values' table, and add a new
+entry to this table with your get/set method names using the
+SNC_HANDLE_NAMES macro).
+
+Your mission, should you accept it, is to try finding out what
+those entries are for, by reading/writing random values from/to those
+files and find out what is the impact on your laptop.
+
+Should you find anything interesting, please report it back to me,
+I will not disavow all knowledge of your actions :)
+
+See also http://www.linux.it/~malattia/wiki/index.php/Sony_drivers for other
+useful info.
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
diff --git a/Documentation/sony-laptop.txt b/Documentation/sony-laptop.txt
deleted file mode 100644
index 7a5c1a8..0000000
--- a/Documentation/sony-laptop.txt
+++ /dev/null
@@ -1,117 +0,0 @@
-Sony Notebook Control Driver (SNC) Readme
------------------------------------------
-	Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
-	Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
-
-This mini-driver drives the SNC and SPIC device present in the ACPI BIOS of the
-Sony Vaio laptops. This driver mixes both devices functions under the same
-(hopefully consistent) interface. This also means that the sonypi driver is
-obsoleted by sony-laptop now.
-
-Fn keys (hotkeys):
-------------------
-Some models report hotkeys through the SNC or SPIC devices, such events are
-reported both through the ACPI subsystem as acpi events and through the INPUT
-subsystem. See the logs of acpid or /proc/acpi/event and
-/proc/bus/input/devices to find out what those events are and which input
-devices are created by the driver.
-
-Backlight control:
-------------------
-If your laptop model supports it, you will find sysfs files in the
-/sys/class/backlight/sony/
-directory. You will be able to query and set the current screen
-brightness:
-	brightness		get/set screen brightness (an iteger
-				between 0 and 7)
-	actual_brightness	reading from this file will query the HW
-				to get real brightness value
-	max_brightness		the maximum brightness value
-
-
-Platform specific:
-------------------
-Loading the sony-laptop module will create a
-/sys/devices/platform/sony-laptop/
-directory populated with some files.
-
-You then read/write integer values from/to those files by using
-standard UNIX tools.
-
-The files are:
-	brightness_default	screen brightness which will be set
-				when the laptop will be rebooted
-	cdpower			power on/off the internal CD drive
-	audiopower		power on/off the internal sound card
-	lanpower		power on/off the internal ethernet card
-				(only in debug mode)
-	bluetoothpower		power on/off the internal bluetooth device
-	fanspeed		get/set the fan speed
-
-Note that some files may be missing if they are not supported
-by your particular laptop model.
-
-Example usage:
-	# echo "1" > /sys/devices/platform/sony-laptop/brightness_default
-sets the lowest screen brightness for the next and later reboots,
-	# echo "8" > /sys/devices/platform/sony-laptop/brightness_default
-sets the highest screen brightness for the next and later reboots,
-	# cat /sys/devices/platform/sony-laptop/brightness_default
-retrieves the value.
-
-	# echo "0" > /sys/devices/platform/sony-laptop/audiopower
-powers off the sound card,
-	# echo "1" > /sys/devices/platform/sony-laptop/audiopower
-powers on the sound card.
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
-the SNC device has on your laptop. You can see the GCDP/GCDP methods
-used to pwer on/off the CD drive, but there are others.
-
-I HAVE NO IDEA WHAT THOSE METHODS DO.
-
-The sony-laptop driver creates, for some of those methods (the most
-current ones found on several Vaio models), an entry under
-/sys/devices/platform/sony-laptop, just like the 'cdpower' one.
-You can create other entries corresponding to your own laptop methods by
-further editing the source (see the 'sony_nc_values' table, and add a new
-entry to this table with your get/set method names using the
-SNC_HANDLE_NAMES macro).
-
-Your mission, should you accept it, is to try finding out what
-those entries are for, by reading/writing random values from/to those
-files and find out what is the impact on your laptop.
-
-Should you find anything interesting, please report it back to me,
-I will not disavow all knowledge of your actions :)
-
-See also http://www.linux.it/~malattia/wiki/index.php/Sony_drivers for other
-useful info.
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
-* The sony-laptop and sonypi drivers do not interact at all. In the
-  future, sonypi could use sony-laptop to do (part of) its business.
-
-* spicctrl, which is the userspace tool used to communicate with the
-  sonypi driver (through /dev/sonypi) does not try to use the
-  sony-laptop driver. In the future, spicctrl could try sonypi first,
-  and if it isn't present, try sony-laptop instead.
-
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5716d2e..e3c70cd 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -183,7 +183,7 @@ config SONY_LAPTOP
 	  screen brightness control, Fn keys and allows powering on/off some
 	  devices.
 
-	  Read <file:Documentation/sony-laptop.txt> for more information.
+	  Read <file:Documentation/laptops/sony-laptop.txt> for more information.
 
 config SONYPI_COMPAT
 	bool "Sonypi compatibility"

