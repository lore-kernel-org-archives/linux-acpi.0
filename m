From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] ACPI: Aesthetic cleanup of ACPI Kconfig file
Date: Thu, 22 May 2014 09:17:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1405220912400.7197@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:55684 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbaEVNUK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2014 09:20:10 -0400
Received: from [99.240.204.5] (port=45127 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1WnSuq-0006RE-Fk
	for linux-acpi@vger.kernel.org; Thu, 22 May 2014 09:20:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


A number of aesthetic (non-functional changes) to Kconfig file:

 * grammar/style fixes
 * indentation
 * add reference to corresponding module names
 * update some /sys directory references

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a34a228..0e46cc3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -29,7 +29,7 @@ menuconfig ACPI
 	  Linux support for ACPI is based on Intel Corporation's ACPI
 	  Component Architecture (ACPI CA).  For more information on the
 	  ACPI CA, see:
-	  <http://acpica.org/>
+	  <https://acpica.org/>

 	  ACPI is an open industry specification originally co-developed by
 	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba. Currently,
@@ -48,21 +48,25 @@ config ACPI_SLEEP
 	default y

 config ACPI_PROCFS_POWER
-	bool "Deprecated power /proc/acpi directories"
+	bool "Deprecated power /proc/acpi/ directories"
 	depends on PROC_FS
 	help
 	  For backwards compatibility, this option allows
           deprecated power /proc/acpi/ directories to exist, even when
           they have been replaced by functions in /sys.
+
           The deprecated directories (and their replacements) include:
-	  /proc/acpi/battery/* (/sys/class/power_supply/*)
-	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
+
+	  * /proc/acpi/battery/*      --> /sys/class/power_supply/*
+	  * /proc/acpi/ac_adapter/*   --> /sys/class/power_supply/*
+
 	  This option has no effect on /proc/acpi/ directories
-	  and functions, which do not yet exist in /sys
+	  and functions which do not yet exist in /sys.
+
 	  This option, together with the proc directories, will be
 	  deleted in the future.

-	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
+	  Say N to delete power /proc/acpi/ directories that have moved to /sys/.

 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
@@ -74,13 +78,17 @@ config ACPI_EC_DEBUGFS
 	  Controller in a way that a normal reboot is not enough. You then
 	  have to power off your system, and remove the laptop battery for
 	  some seconds.
+
 	  An Embedded Controller typically is available on laptops and reads
 	  sensor values like battery state and temperature.
-	  The kernel accesses the EC through ACPI parsed code provided by BIOS
-	  tables. This option allows to access the EC directly without ACPI
-	  code being involved.
-	  Thus this option is a debug option that helps to write ACPI drivers
-	  and can be used to identify ACPI code or EC firmware bugs.
+	  The kernel accesses the EC through ACPI-parsed code provided by BIOS
+	  tables. This option allows access to the EC directly without ACPI
+	  code being involved.  Thus this option is a debug option that helps
+	  to write ACPI drivers and can be used to identify ACPI code or
+	  EC firmware bugs.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called ec_sys.

 config ACPI_AC
 	tristate "AC Adapter"
@@ -89,7 +97,7 @@ config ACPI_AC
 	default y
 	help
 	  This driver supports the AC Adapter object, which indicates
-	  whether a system is on AC or not.  If you have a system that can
+	  whether a system is on A/C or not.  If you have a system that can
 	  switch between A/C and battery, say Y.

 	  To compile this driver as a module, choose M here:
@@ -102,8 +110,8 @@ config ACPI_BATTERY
 	default y
 	help
 	  This driver adds support for battery information through
-	  /proc/acpi/battery. If you have a mobile system with a battery,
-	  say Y.
+	  /sys/class/power_supply/. If you have a mobile system with
+	  a battery, say Y.

 	  To compile this driver as a module, choose M here:
 	  the module will be called battery.
@@ -174,10 +182,10 @@ config ACPI_IPMI
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
 	  uses the IPMI request/response message to communicate with BMC
-	  controller, which can be found on on the server.
+	  controller, which can be found on the server.

 	  To compile this driver as a module, choose M here:
-	  the module will be called as acpi_ipmi.
+	  the module will be called acpi_ipmi.

 config ACPI_HOTPLUG_CPU
 	bool
@@ -196,6 +204,9 @@ config ACPI_PROCESSOR_AGGREGATOR
 	  is defined, which is to reduce power consumption. This driver
 	  supports the new device.

+	  To compile this driver as a module, choose M here:
+	  the module will be called acpi_pad.
+
 config ACPI_THERMAL
 	tristate "Thermal Zone"
 	depends on ACPI_PROCESSOR
@@ -327,6 +338,9 @@ config ACPI_HED
 	  which is used to report some hardware errors notified via
 	  SCI, mainly the corrected errors.

+	  To compile this driver as a module, choose M here:
+	  the module will be called hed.
+
 config ACPI_CUSTOM_METHOD
 	tristate "Allow ACPI methods to be inserted/replaced at run time"
 	depends on DEBUG_FS
@@ -342,6 +356,9 @@ config ACPI_CUSTOM_METHOD
 	  load additional kernel modules after boot, this feature may be used
 	  to override that restriction).

+	  To compile this driver as a module, choose M here:
+	  the module will be called custom_method.
+
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
 	depends on EFI && X86
@@ -354,15 +371,14 @@ config ACPI_BGRT
 config ACPI_REDUCED_HARDWARE_ONLY
 	bool "Hardware-reduced ACPI support only" if EXPERT
 	def_bool n
-	depends on ACPI
 	help
-	This config item changes the way the ACPI code is built.  When this
-	option is selected, the kernel will use a specialized version of
-	ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
-	resulting kernel will be smaller but it will also be restricted to
-	running in ACPI reduced hardware mode ONLY.
+	  This config item changes the way the ACPI code is built.  When this
+	  option is selected, the kernel will use a specialized version of
+	  ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
+	  resulting kernel will be smaller but it will also be restricted to
+	  running in ACPI reduced hardware mode ONLY.

-	If you are unsure what to do, do not enable this option.
+	  If you are unsure what to do, do not enable this option.

 source "drivers/acpi/apei/Kconfig"


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
