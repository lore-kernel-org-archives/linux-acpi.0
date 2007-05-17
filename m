From: Andreas Mohr <andi@rhlx01.hs-esslingen.de>
Subject: [PATCH] drivers/acpi/Kconfig cleanup
Date: Thu, 17 May 2007 23:22:56 +0200
Message-ID: <20070517212256.GA3730@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:41915 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbXEQVW6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 May 2007 17:22:58 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi,

ACPI Kconfig cleanup, few updates and mostly typos.

- fix CONFIG_ACPI description
- excuse me, but I thought that CONFIG_ACPI_SLEEP has been ok for
  almost half a decade now? --> Remove misleading text.
- mention brokenness of some older Intel chipsets in CONFIG_X86_PM_TIMER
- spelling / cleanup

Patch against 2.6.22-rc1-mm1, however I'd want this to end up in
acpi-linux-2.6 (and thus 2.6.23 probably),
hopefully there are no conflicts.

Thanks!

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.22-rc1-mm1/drivers/acpi/Kconfig.orig	2007-05-26 20:09:53.000000000 +0200
+++ linux-2.6.22-rc1-mm1/drivers/acpi/Kconfig	2007-05-26 21:06:28.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menuconfig ACPI
-	bool "ACPI Support (Advanced Configuration and Power Interface) Support"
+	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !X86_NUMAQ
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
@@ -55,13 +55,6 @@
 	  (depending on the state), to allow the system to resume operation
 	  quickly at your request.
 
-	  Although this option sounds really nifty, barely any of the device
-	  drivers have been converted to the new driver model and hence few
-	  have proper power management support. 
-
-	  This option is not recommended for anyone except those doing driver
-	  power management development.
-
 config ACPI_SLEEP_PROC_FS
 	bool
 	depends on ACPI_SLEEP && PROC_FS
@@ -112,20 +105,20 @@
 	default y
 	help
 	  This driver handles events on the power, sleep and lid buttons.
-	  A daemon reads /proc/acpi/event and perform user-defined actions
+	  A daemon reads /proc/acpi/event and performs user-defined actions
 	  such as shutting down the system.  This is necessary for
-	  software controlled poweroff.
+	  software-controlled poweroff.
 
 config ACPI_VIDEO
 	tristate "Video"
 	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
 	help
-	  This driver implement the ACPI Extensions For Display Adapters
+	  This driver implements the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
 	  ACPI 2.0 Specification, Appendix B, allowing to perform some basic
 	  control like defining the video POST device, retrieving EDID information
-	  or to setup a video output, etc.
-	  Note that this is an ref. implementation only.  It may or may not work
+	  or setting up a video output, etc.
+	  Note that this is a ref. implementation only.  It may or may not work
 	  for your integrated video device.
 
 config ACPI_FAN
@@ -146,8 +139,8 @@
 	depends on EXPERIMENTAL
 	depends on ACPI_DOCK
 	help
-	  This driver adds support for ACPI controlled removable drive
-	  bays such as the IBM ultrabay or the Dell Module Bay.
+	  This driver adds support for ACPI controlled removable drive bays
+	  such as the IBM ultrabay or the Dell Module Bay.
 
 config ACPI_PROCESSOR
 	tristate "Processor"
@@ -221,10 +214,9 @@
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
 	  their lack of a BIOS setup menu and APM support.
 
-	  On these machines, all system configuration is handled through the
-	  ACPI.  This driver is required for access to controls not covered
-	  by the general ACPI drivers, such as LCD brightness, video output,
-	  etc.
+	  On these machines, all system configuration is handled through ACPI.
+	  This driver is required for access to controls not covered by
+	  the general ACPI drivers, such as LCD brightness, video output, etc.
 
 	  This driver differs from the non-ACPI Toshiba laptop driver (located
 	  under "Processor type and features") in several aspects.
@@ -236,7 +228,7 @@
 	  More information about this driver is available at
 	  <http://memebeam.org/toys/ToshibaAcpiDriver>.
 
-	  If you have a legacy free Toshiba laptop (such as the Libretto L1
+	  If you have a legacy-free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
 
 config ACPI_CUSTOM_DSDT
@@ -278,7 +270,7 @@
 	bool
 	default y
 	help
-	  This driver is required on some systems for the proper operation of
+	  This driver is required on some systems for proper operation of
 	  the battery and thermal drivers.  If you are compiling for a 
 	  mobile system, say Y.
 
@@ -298,7 +290,7 @@
 	depends on X86
 	default y
 	help
-	  The Power Management Timer is available on all ACPI-capable,
+	  The Power Management Timer is available on all ACPI-capable systems,
 	  in most cases even if ACPI is unusable or blacklisted.
 
 	  This timing source is not affected by power management features
@@ -309,6 +301,11 @@
 	  You should nearly always say Y here because many modern
 	  systems require this timer. 
 
+	  Some older Intel chipsets (ICH4, PIIX4, PIIX4E) have a timer design
+	  screwup, causing at least 3 times slower timer access due to
+	  workarounds. Even in these cases you should still enable this option
+	  but be prepared to choose a different clock source at bootup/runtime.
+
 config ACPI_CONTAINER
 	tristate "ACPI0004,PNP0A05 and PNP0A06 Container Driver (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
@@ -338,7 +335,7 @@
 	  memory DIMMs at some platform defined granularity (individually 
 	  or as a bank) at runtime, then you need not enable this driver.
 
-	  If one selects "m," this driver can be loaded using the following
+	  If one selects "m", this driver can be loaded using the following
 	  command: 
 		$>modprobe acpi_memhotplug 
 
