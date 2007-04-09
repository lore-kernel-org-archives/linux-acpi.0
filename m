From: malattia@linux.it
Subject: [patch 8/9] update documentation and Kconfig help
Date: Mon, 9 Apr 2007 19:31:16 +0200
Message-ID: <20070409173116.GI10646@inferi.kami.home>
References: <20070409081903.057292676@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:38284 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbXDIRcy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2007 13:32:54 -0400
Content-Disposition: inline; filename="0008-update-documentation.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, stelian@popies.net

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 Documentation/sony-laptop.txt |   25 ++++++++++++++++++-------
 drivers/misc/Kconfig          |    9 ++++-----
 2 files changed, 22 insertions(+), 12 deletions(-)

Index: linux-2.6/Documentation/sony-laptop.txt
===================================================================
--- linux-2.6.orig/Documentation/sony-laptop.txt	2007-04-05 15:36:40.796465033 +0200
+++ linux-2.6/Documentation/sony-laptop.txt	2007-04-05 16:05:11.893975027 +0200
@@ -3,12 +3,18 @@ Sony Notebook Control Driver (SNC) Readm
 	Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
 	Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
 
-This mini-driver drives the SNC device present in the ACPI BIOS of
-the Sony Vaio laptops.
+This mini-driver drives the SNC and SPIC device present in the ACPI BIOS of the
+Sony Vaio laptops. This driver mixes both devices functions under the same
+(hopefully consistent) interface. This also means that the sonypi driver is
+obsoleted by sony-laptop now.
 
-It gives access to some extra laptop functionalities. In its current
-form, this driver let the user set or query the screen brightness
-through the backlight subsystem and remove/apply power to some devices.
+Fn keys (hotkeys):
+------------------
+Some models report hotkeys through the SNC or SPIC devices, such events are
+reported both through the ACPI subsystem as acpi events and through the INPUT
+subsystem. See the logs of acpid or /proc/acpi/event and
+/proc/bus/input/devices to find out what those events are and which input
+devices are created by the driver.
 
 Backlight control:
 ------------------
@@ -39,6 +45,8 @@ The files are:
 	audiopower		power on/off the internal sound card
 	lanpower		power on/off the internal ethernet card
 				(only in debug mode)
+	bluetoothpower		power on/off the internal bluetooth device
+	fanspeed		get/set the fan speed
 
 Note that some files may be missing if they are not supported
 by your particular laptop model.
@@ -76,9 +84,9 @@ The sony-laptop driver creates, for some
 current ones found on several Vaio models), an entry under
 /sys/devices/platform/sony-laptop, just like the 'cdpower' one.
 You can create other entries corresponding to your own laptop methods by
-further editing the source (see the 'sony_acpi_values' table, and add a new
+further editing the source (see the 'sony_nc_values' table, and add a new
 entry to this table with your get/set method names using the
-HANDLE_NAMES macro).
+SNC_HANDLE_NAMES macro).
 
 Your mission, should you accept it, is to try finding out what
 those entries are for, by reading/writing random values from/to those
@@ -87,6 +95,9 @@ files and find out what is the impact on
 Should you find anything interesting, please report it back to me,
 I will not disavow all knowledge of your actions :)
 
+See also http://www.linux.it/~malattia/wiki/index.php/Sony_drivers for other
+useful info.
+
 Bugs/Limitations:
 -----------------
 
Index: linux-2.6/drivers/misc/Kconfig
===================================================================
--- linux-2.6.orig/drivers/misc/Kconfig	2007-04-05 16:47:10.537504245 +0200
+++ linux-2.6/drivers/misc/Kconfig	2007-04-05 16:51:05.550897049 +0200
@@ -112,12 +112,11 @@ config SONY_LAPTOP
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	  ---help---
-	  This mini-driver drives the SNC device present in the ACPI BIOS of
-	  the Sony Vaio laptops.
+	  This mini-driver drives the SNC and SPIC devices present in the ACPI
+	  BIOS of the Sony Vaio laptops.
 
-	  It gives access to some extra laptop functionalities. In its current
-	  form, this driver let the user set or query the screen brightness
-	  through the backlight subsystem and remove/apply power to some
+	  It gives access to some extra laptop functionalities like Bluetooth,
+	  screen brightness control, Fn keys and allows powering on/off some
 	  devices.
 
 	  Read <file:Documentation/sony-laptop.txt> for more information.

--
-- 
mattia
:wq!
