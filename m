From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 09/35] acpi-video-detect: video: Make video_detect code part of the video module
Date: Tue, 16 Jun 2015 16:27:47 +0200
Message-ID: <1434464893-3529-10-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554AbbFPO3A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:29:00 -0400
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

This is a preparation patch for the backlight interface selection logic
cleanup, there are 2 reasons to not always build the video_detect code
into the kernel:

1) In order for the video_detect.c to also deal with / select native
backlight interfaces on win8 systems, instead of doing this in video.c
where it does not belong, video_detect.c needs to call into the backlight
class code. Which cannot be done if it is builtin and the blacklight class
is not.

2) Currently all the platform/x86 drivers which have quirks to prefer
the vendor driver over acpi-video call acpi_video_unregister_backlight()
to remove the acpi-video backlight interface, this logic really belongs
in video_detect.c, which will cause video_detect.c to depend on symbols of
video.c and video.c already depends on video_detect.c symbols, so they
really need to be a single module.

Note that this commits make 2 changes so as to maintain 100% kernel
commandline compatibility:

1) The __setup call for the acpi_backlight= handling is moved to
   acpi/util.c as __setup may only be used by code which is alwasy builtin
2) video.c is renamed to acpi_video.c so that it can be combined with
   video_detect.c into video.ko

This commit also makes changes to drivers/platform/x86/Kconfig to ensure
that drivers which use acpi_video_backlight_support() from video_detect.c,
will not be built-in when acpi_video is not built in. This also changes
some "select" uses to "depends on" to avoid dependency loops.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-mv __setup call to utils.c and rename video.c to acpi_video.c so to
 maintain 100% kernel commandline compatibility
---
 drivers/acpi/Makefile                  |  5 ++---
 drivers/acpi/{video.c => acpi_video.c} |  2 +-
 drivers/acpi/utils.c                   | 15 +++++++++++++++
 drivers/acpi/video_detect.c            | 35 ++++++++++++----------------------
 drivers/platform/x86/Kconfig           | 21 +++++++++++++++-----
 include/linux/acpi.h                   |  1 +
 6 files changed, 47 insertions(+), 32 deletions(-)
 rename drivers/acpi/{video.c => acpi_video.c} (99%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8a063e2..73d840b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -52,9 +52,6 @@ acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
-ifdef CONFIG_ACPI_VIDEO
-acpi-y				+= video_detect.o
-endif
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
 
@@ -95,3 +92,5 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
+
+video-objs			+= acpi_video.o video_detect.o
diff --git a/drivers/acpi/video.c b/drivers/acpi/acpi_video.c
similarity index 99%
rename from drivers/acpi/video.c
rename to drivers/acpi/acpi_video.c
index 3bc4c68..db4f353 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/acpi_video.c
@@ -43,7 +43,7 @@
 #include <acpi/video.h>
 #include <asm/uaccess.h>
 
-#include "internal.h"
+#define PREFIX "ACPI: "
 
 #define ACPI_VIDEO_BUS_NAME		"Video Bus"
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index cd49a39..67c548a 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -712,3 +712,18 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
 	return false;
 }
 EXPORT_SYMBOL(acpi_check_dsm);
+
+/*
+ * acpi_backlight= handling, this is done here rather then in video_detect.c
+ * because __setup cannot be used in modules.
+ */
+char acpi_video_backlight_string[16];
+EXPORT_SYMBOL(acpi_video_backlight_string);
+
+static int __init acpi_backlight(char *str)
+{
+	strlcpy(acpi_video_backlight_string, str,
+		sizeof(acpi_video_backlight_string));
+	return 1;
+}
+__setup("acpi_backlight=", acpi_backlight);
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b2270ca..bb6133c 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -32,16 +32,23 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 
-#include "internal.h"
-
 ACPI_MODULE_NAME("video");
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 
 static long acpi_video_support;
 static bool acpi_video_caps_checked;
 
+static void acpi_video_parse_cmdline(void)
+{
+	if (!strcmp("vendor", acpi_video_backlight_string))
+		acpi_video_support |= ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR;
+	if (!strcmp("video", acpi_video_backlight_string))
+		acpi_video_support |= ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO;
+}
+
 static acpi_status
 find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
@@ -174,8 +181,10 @@ static void acpi_video_caps_check(void)
 	 * We must check whether the ACPI graphics device is physically plugged
 	 * in. Therefore this must be called after binding PCI and ACPI devices
 	 */
-	if (!acpi_video_caps_checked)
+	if (!acpi_video_caps_checked) {
+		acpi_video_parse_cmdline();
 		acpi_video_get_capabilities(NULL);
+	}
 }
 
 /* Promote the vendor interface instead of the generic video module.
@@ -212,23 +221,3 @@ int acpi_video_backlight_support(void)
 	return acpi_video_support & ACPI_VIDEO_BACKLIGHT;
 }
 EXPORT_SYMBOL(acpi_video_backlight_support);
-
-/*
- * Use acpi_backlight=vendor/video to force that backlight switching
- * is processed by vendor specific acpi drivers or video.ko driver.
- */
-static int __init acpi_backlight(char *str)
-{
-	if (str == NULL || *str == '\0')
-		return 1;
-	else {
-		if (!strcmp("vendor", str))
-			acpi_video_support |=
-				ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR;
-		if (!strcmp("video", str))
-			acpi_video_support |=
-				ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO;
-	}
-	return 1;
-}
-__setup("acpi_backlight=", acpi_backlight);
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f9f205c..909133c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -71,9 +71,10 @@ config ASUS_LAPTOP
 	depends on ACPI
 	select LEDS_CLASS
 	select NEW_LEDS
-	select BACKLIGHT_CLASS_DEVICE
+	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
 	select INPUT_POLLDEV
 	---help---
@@ -95,6 +96,7 @@ config DELL_LAPTOP
 	depends on X86
 	depends on DCDBAS
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL || RFKILL = n
 	depends on SERIO_I8042
 	select POWER_SUPPLY
@@ -109,6 +111,7 @@ config DELL_WMI
 	tristate "Dell WMI extras"
 	depends on ACPI_WMI
 	depends on INPUT
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
 	---help---
 	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
@@ -144,6 +147,7 @@ config FUJITSU_LAPTOP
 	depends on ACPI
 	depends on INPUT
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on LEDS_CLASS || LEDS_CLASS=n
 	---help---
 	  This is a driver for laptops built by Fujitsu:
@@ -247,6 +251,7 @@ config MSI_LAPTOP
 	tristate "MSI Laptop Extras"
 	depends on ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL
 	depends on INPUT && SERIO_I8042
 	select INPUT_SPARSEKMAP
@@ -280,6 +285,7 @@ config COMPAL_LAPTOP
 	tristate "Compal (and others) Laptop Extras"
 	depends on ACPI
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL
 	depends on HWMON
 	depends on POWER_SUPPLY
@@ -296,7 +302,8 @@ config COMPAL_LAPTOP
 config SONY_LAPTOP
 	tristate "Sony Laptop Extras"
 	depends on ACPI
-	select BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	depends on RFKILL
 	  ---help---
@@ -321,6 +328,7 @@ config IDEAPAD_LAPTOP
 	depends on RFKILL && INPUT
 	depends on SERIO_I8042
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
 	help
 	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
@@ -331,8 +339,8 @@ config THINKPAD_ACPI
 	depends on ACPI
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
-	select BACKLIGHT_LCD_SUPPORT
-	select BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select NVRAM
 	select NEW_LEDS
@@ -500,8 +508,9 @@ config EEEPC_LAPTOP
 	depends on ACPI
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on HOTPLUG_PCI
-	select BACKLIGHT_CLASS_DEVICE
+	depends on BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select LEDS_CLASS
 	select NEW_LEDS
@@ -587,6 +596,7 @@ config MSI_WMI
 	depends on ACPI_WMI
 	depends on INPUT
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
 	help
 	 Say Y here if you want to support WMI-based hotkeys on MSI laptops.
@@ -824,6 +834,7 @@ config MXM_WMI
 config INTEL_OAKTRAIL
 	tristate "Intel Oaktrail Platform Extras"
 	depends on ACPI
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL && BACKLIGHT_CLASS_DEVICE && ACPI
 	---help---
 	  Intel Oaktrail platform need this driver to provide interfaces to
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 798c8d0..ca02a51 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -253,6 +253,7 @@ extern bool wmi_has_guid(const char *guid);
 #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR		0x0400
 #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO		0x0800
 
+extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
 
 #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
-- 
2.3.6

