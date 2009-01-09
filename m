From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/94] drivers/misc/Makefile, Kconfig: cleanup
Date: Fri, 09 Jan 2009 04:26:14 -0500
Message-ID: <8c36790a21eec6c39c372e92c76e81865005a6ce.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44520 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbZAIJ1w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:52 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004Q46AF3D6E@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:52 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

tabs->space and delete unnecessary dummy build-in.o rule.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig  |   42 +++++++++++++++++++++---------------------
 drivers/misc/Makefile |    1 -
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fee7304..dcf6169 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -120,7 +120,7 @@ config TIFM_CORE
 	  cards are supported via 'MMC/SD Card support: TI Flash Media MMC/SD
 	  Interface support (MMC_TIFM_SD)'.
 
-          To compile this driver as a module, choose M here: the module will
+	  To compile this driver as a module, choose M here: the module will
 	  be called tifm_core.
 
 config TIFM_7XX1
@@ -133,11 +133,11 @@ config TIFM_7XX1
 	  To make actual use of the device, you will have to select some
 	  flash card format drivers, as outlined in the TIFM_CORE Help.
 
-          To compile this driver as a module, choose M here: the module will
+	  To compile this driver as a module, choose M here: the module will
 	  be called tifm_7xx1.
 
 config ACER_WMI
-        tristate "Acer WMI Laptop Extras (EXPERIMENTAL)"
+	tristate "Acer WMI Laptop Extras (EXPERIMENTAL)"
 	depends on X86
 	depends on EXPERIMENTAL
 	depends on ACPI
@@ -159,14 +159,14 @@ config ACER_WMI
 	  here.
 
 config ASUS_LAPTOP
-        tristate "Asus Laptop Extras (EXPERIMENTAL)"
-        depends on X86
-        depends on ACPI
+	tristate "Asus Laptop Extras (EXPERIMENTAL)"
+	depends on X86
+	depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
 	depends on BACKLIGHT_CLASS_DEVICE
-        ---help---
+	---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
 	  standard ACPI events that go through /proc/acpi/events. It also adds
@@ -179,12 +179,12 @@ config ASUS_LAPTOP
 	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
 
 config FUJITSU_LAPTOP
-        tristate "Fujitsu Laptop Extras"
-        depends on X86
-        depends on ACPI
+	tristate "Fujitsu Laptop Extras"
+	depends on X86
+	depends on ACPI
 	depends on INPUT
-        depends on BACKLIGHT_CLASS_DEVICE
-        ---help---
+	depends on BACKLIGHT_CLASS_DEVICE
+	---help---
 	  This is a driver for laptops built by Fujitsu:
 
 	    * P2xxx/P5xxx/S6xxx/S7xxx series Lifebooks
@@ -221,11 +221,11 @@ config HP_WMI
        depends on INPUT
        depends on RFKILL
        help
-         Say Y here if you want to support WMI-based hotkeys on HP laptops and
+	 Say Y here if you want to support WMI-based hotkeys on HP laptops and
 	 to read data from WMI such as docking or ambient light sensor state.
 
-         To compile this driver as a module, choose M here: the module will
-         be called hp-wmi.
+	 To compile this driver as a module, choose M here: the module will
+	 be called hp-wmi.
 
 config ICS932S401
 	tristate "Integrated Circuits ICS932S401"
@@ -238,11 +238,11 @@ config ICS932S401
 	  will be called ics932s401.
 
 config MSI_LAPTOP
-        tristate "MSI Laptop Extras"
-        depends on X86
-        depends on ACPI
-        depends on BACKLIGHT_CLASS_DEVICE
-        ---help---
+	tristate "MSI Laptop Extras"
+	depends on X86
+	depends on ACPI
+	depends on BACKLIGHT_CLASS_DEVICE
+	---help---
 	  This is a driver for laptops built by MSI (MICRO-STAR
 	  INTERNATIONAL):
 
@@ -259,7 +259,7 @@ config MSI_LAPTOP
 config PANASONIC_LAPTOP
 	tristate "Panasonic Laptop Extras"
 	depends on X86 && INPUT && ACPI
-        depends on BACKLIGHT_CLASS_DEVICE
+	depends on BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver adds support for access to backlight control and hotkeys
 	  on Panasonic Let's Note laptops.
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 817f7f5..027e1ea 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -1,7 +1,6 @@
 #
 # Makefile for misc devices that really don't fit anywhere else.
 #
-obj- := misc.o	# Dummy rule to force built-in.o to be made
 
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
-- 
1.5.6.6

