From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/94] ACPI: move wmi, asus_acpi,
 toshiba_acpi to drivers/platform/x86
Date: Fri, 09 Jan 2009 04:26:16 -0500
Message-ID: <b4f9fe12157a33351d0df78e925dcacd13252783.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56402 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZAIJ1x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:53 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EFZ6AGOO13@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:53 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

These are platform specific drivers that happen to use ACPI,
while drivers/acpi/ is for code that implements ACPI itself.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig                          |   84 ------------------------
 drivers/acpi/Makefile                         |    3 -
 drivers/platform/x86/Kconfig                  |   85 +++++++++++++++++++++++++
 drivers/platform/x86/Makefile                 |    3 +
 drivers/{acpi => platform/x86}/asus_acpi.c    |    0 
 drivers/{acpi => platform/x86}/toshiba_acpi.c |    0 
 drivers/{acpi => platform/x86}/wmi.c          |    0 
 7 files changed, 88 insertions(+), 87 deletions(-)
 rename drivers/{acpi => platform/x86}/asus_acpi.c (100%)
 rename drivers/{acpi => platform/x86}/toshiba_acpi.c (100%)
 rename drivers/{acpi => platform/x86}/wmi.c (100%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b0243fd..d7f9839 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -196,90 +196,6 @@ config ACPI_NUMA
 	depends on (X86 || IA64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
-config ACPI_WMI
-	tristate "WMI (EXPERIMENTAL)"
-	depends on X86
-	depends on EXPERIMENTAL
-	help
-	  This driver adds support for the ACPI-WMI (Windows Management
-	  Instrumentation) mapper device (PNP0C14) found on some systems.
-
-	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
-	  ACPI firmware to userspace - this is done through various vendor
-	  defined methods and data blocks in a PNP0C14 device, which are then
-	  made available for userspace to call.
-
-	  The implementation of this in Linux currently only exposes this to
-	  other kernel space drivers.
-
-	  This driver is a required dependency to build the firmware specific
-	  drivers needed on many machines, including Acer and HP laptops.
-
-	  It is safe to enable this driver even if your DSDT doesn't define
-	  any ACPI-WMI devices.
-
-config ACPI_ASUS
-        tristate "ASUS/Medion Laptop Extras"
-	depends on X86
-	select BACKLIGHT_CLASS_DEVICE
-        ---help---
-          This driver provides support for extra features of ACPI-compatible
-          ASUS laptops. As some of Medion laptops are made by ASUS, it may also
-          support some Medion laptops (such as 9675 for example).  It makes all
-          the extra buttons generate standard ACPI events that go through
-          /proc/acpi/events, and (on some models) adds support for changing the
-          display brightness and output, switching the LCD backlight on and off,
-          and most importantly, allows you to blink those fancy LEDs intended
-          for reporting mail and wireless status.
-
-	  Note: display switching code is currently considered EXPERIMENTAL,
-	  toying with these values may even lock your machine.
-
-          All settings are changed via /proc/acpi/asus directory entries. Owner
-          and group for these entries can be set with asus_uid and asus_gid
-          parameters.
-
-          More information and a userspace daemon for handling the extra buttons
-          at <http://sourceforge.net/projects/acpi4asus/>.
-
-          If you have an ACPI-compatible ASUS laptop, say Y or M here. This
-          driver is still under development, so if your laptop is unsupported or
-          something works not quite as expected, please use the mailing list
-          available on the above page (acpi4asus-user@lists.sourceforge.net).
-
-	  NOTE: This driver is deprecated and will probably be removed soon,
-	  use asus-laptop instead.
-
-config ACPI_TOSHIBA
-	tristate "Toshiba Laptop Extras"
-	depends on X86 && INPUT
-	select INPUT_POLLDEV
-	select NET
-	select RFKILL
-	select BACKLIGHT_CLASS_DEVICE
-	---help---
-	  This driver adds support for access to certain system settings
-	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
-	  their lack of a BIOS setup menu and APM support.
-
-	  On these machines, all system configuration is handled through the
-	  ACPI.  This driver is required for access to controls not covered
-	  by the general ACPI drivers, such as LCD brightness, video output,
-	  etc.
-
-	  This driver differs from the non-ACPI Toshiba laptop driver (located
-	  under "Processor type and features") in several aspects.
-	  Configuration is accessed by reading and writing text files in the
-	  /proc tree instead of by program interface to /dev.  Furthermore, no
-	  power management functions are exposed, as those are handled by the
-	  general ACPI drivers.
-
-	  More information about this driver is available at
-	  <http://memebeam.org/toys/ToshibaAcpiDriver>.
-
-	  If you have a legacy free Toshiba laptop (such as the Libretto L1
-	  series), say Y.
-
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3c0c933..f64af36 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -59,9 +59,6 @@ obj-y				+= power.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
-obj-$(CONFIG_ACPI_WMI)		+= wmi.o
-obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
-obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0a9a5b9..31f3ce2 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -287,4 +287,89 @@ config EEEPC_LAPTOP
 
 	  If you have an Eee PC laptop, say Y or M here.
 
+
+config ACPI_WMI
+	tristate "WMI (EXPERIMENTAL)"
+	depends on ACPI
+	depends on EXPERIMENTAL
+	help
+	  This driver adds support for the ACPI-WMI (Windows Management
+	  Instrumentation) mapper device (PNP0C14) found on some systems.
+
+	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
+	  ACPI firmware to userspace - this is done through various vendor
+	  defined methods and data blocks in a PNP0C14 device, which are then
+	  made available for userspace to call.
+
+	  The implementation of this in Linux currently only exposes this to
+	  other kernel space drivers.
+
+	  This driver is a required dependency to build the firmware specific
+	  drivers needed on many machines, including Acer and HP laptops.
+
+	  It is safe to enable this driver even if your DSDT doesn't define
+	  any ACPI-WMI devices.
+
+config ACPI_ASUS
+	tristate "ASUS/Medion Laptop Extras"
+	depends on ACPI
+	select BACKLIGHT_CLASS_DEVICE
+	---help---
+	  This driver provides support for extra features of ACPI-compatible
+	  ASUS laptops. As some of Medion laptops are made by ASUS, it may also
+	  support some Medion laptops (such as 9675 for example).  It makes all
+	  the extra buttons generate standard ACPI events that go through
+	  /proc/acpi/events, and (on some models) adds support for changing the
+	  display brightness and output, switching the LCD backlight on and off,
+	  and most importantly, allows you to blink those fancy LEDs intended
+	  for reporting mail and wireless status.
+
+	  Note: display switching code is currently considered EXPERIMENTAL,
+	  toying with these values may even lock your machine.
+
+	  All settings are changed via /proc/acpi/asus directory entries. Owner
+	  and group for these entries can be set with asus_uid and asus_gid
+	  parameters.
+
+	  More information and a userspace daemon for handling the extra buttons
+	  at <http://sourceforge.net/projects/acpi4asus/>.
+
+	  If you have an ACPI-compatible ASUS laptop, say Y or M here. This
+	  driver is still under development, so if your laptop is unsupported or
+	  something works not quite as expected, please use the mailing list
+	  available on the above page (acpi4asus-user@lists.sourceforge.net).
+
+	  NOTE: This driver is deprecated and will probably be removed soon,
+	  use asus-laptop instead.
+
+config ACPI_TOSHIBA
+	tristate "Toshiba Laptop Extras"
+	depends on ACPI
+	depends on INPUT
+	select INPUT_POLLDEV
+	select NET
+	select RFKILL
+	select BACKLIGHT_CLASS_DEVICE
+	---help---
+	  This driver adds support for access to certain system settings
+	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
+	  their lack of a BIOS setup menu and APM support.
+
+	  On these machines, all system configuration is handled through the
+	  ACPI.  This driver is required for access to controls not covered
+	  by the general ACPI drivers, such as LCD brightness, video output,
+	  etc.
+
+	  This driver differs from the non-ACPI Toshiba laptop driver (located
+	  under "Processor type and features") in several aspects.
+	  Configuration is accessed by reading and writing text files in the
+	  /proc tree instead of by program interface to /dev.  Furthermore, no
+	  power management functions are exposed, as those are handled by the
+	  general ACPI drivers.
+
+	  More information about this driver is available at
+	  <http://memebeam.org/toys/ToshibaAcpiDriver>.
+
+	  If you have a legacy free Toshiba laptop (such as the Libretto L1
+	  series), say Y.
 endif # X86_PLATFORM_DEVICES
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4d26b1b..1e9de2a 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -14,3 +14,6 @@ obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_FUJITSU_LAPTOP)	+= fujitsu-laptop.o
 obj-$(CONFIG_PANASONIC_LAPTOP)	+= panasonic-laptop.o
 obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
+obj-$(CONFIG_ACPI_WMI)		+= wmi.o
+obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
+obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
diff --git a/drivers/acpi/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
similarity index 100%
rename from drivers/acpi/asus_acpi.c
rename to drivers/platform/x86/asus_acpi.c
diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
similarity index 100%
rename from drivers/acpi/toshiba_acpi.c
rename to drivers/platform/x86/toshiba_acpi.c
diff --git a/drivers/acpi/wmi.c b/drivers/platform/x86/wmi.c
similarity index 100%
rename from drivers/acpi/wmi.c
rename to drivers/platform/x86/wmi.c
-- 
1.5.6.6

