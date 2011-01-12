From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/48] ACPI video: remove output switching control
Date: Wed, 12 Jan 2011 05:19:02 -0500
Message-ID: <677bd810eedce61edf15452491781ff046b92edc.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:56246 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1ALKUG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 05:20:06 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW00H0QNDG6UN4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 04:20:06 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Remove the ACPI video output switching control as it never works.

With the patch applied,
ACPI video driver still catches the video output notification,
but it does nothing but raises the notification to userspace.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    5 --
 drivers/acpi/video.c                |   86 -----------------------------------
 drivers/acpi/video_detect.c         |   57 ++---------------------
 drivers/gpu/drm/Kconfig             |    1 -
 drivers/gpu/stub/Kconfig            |    1 -
 5 files changed, 4 insertions(+), 146 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index cdd2a6e..f91fc5a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -199,11 +199,6 @@ and is between 256 and 4096 characters. It is defined in the file
 			unusable.  The "log_buf_len" parameter may be useful
 			if you need to capture more output.
 
-	acpi_display_output=	[HW,ACPI]
-			acpi_display_output=vendor
-			acpi_display_output=video
-			See above.
-
 	acpi_irq_balance [HW,ACPI]
 			ACPI will balance active IRQs
 			default in APIC mode
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5cd0228..81766eb 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -33,7 +33,6 @@
 #include <linux/input.h>
 #include <linux/backlight.h>
 #include <linux/thermal.h>
-#include <linux/video_output.h>
 #include <linux/sort.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
@@ -172,9 +171,6 @@ struct acpi_video_device_cap {
 	u8 _BQC:1;		/* Get current brightness level */
 	u8 _BCQ:1;		/* Some buggy BIOS uses _BCQ instead of _BQC */
 	u8 _DDC:1;		/*Return the EDID for this device */
-	u8 _DCS:1;		/*Return status of output device */
-	u8 _DGS:1;		/*Query graphics state */
-	u8 _DSS:1;		/*Device state set */
 };
 
 struct acpi_video_brightness_flags {
@@ -202,7 +198,6 @@ struct acpi_video_device {
 	struct acpi_video_device_brightness *brightness;
 	struct backlight_device *backlight;
 	struct thermal_cooling_device *cooling_dev;
-	struct output_device *output_dev;
 };
 
 static const char device_decode[][30] = {
@@ -226,10 +221,6 @@ static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static int acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
-static int acpi_video_device_get_state(struct acpi_video_device *device,
-			    unsigned long long *state);
-static int acpi_video_output_get(struct output_device *od);
-static int acpi_video_device_set_state(struct acpi_video_device *device, int state);
 
 /*backlight device sysfs support*/
 static int acpi_video_get_brightness(struct backlight_device *bd)
@@ -265,30 +256,6 @@ static struct backlight_ops acpi_backlight_ops = {
 	.update_status  = acpi_video_set_brightness,
 };
 
-/*video output device sysfs support*/
-static int acpi_video_output_get(struct output_device *od)
-{
-	unsigned long long state;
-	struct acpi_video_device *vd =
-		(struct acpi_video_device *)dev_get_drvdata(&od->dev);
-	acpi_video_device_get_state(vd, &state);
-	return (int)state;
-}
-
-static int acpi_video_output_set(struct output_device *od)
-{
-	unsigned long state = od->request_state;
-	struct acpi_video_device *vd=
-		(struct acpi_video_device *)dev_get_drvdata(&od->dev);
-	return acpi_video_device_set_state(vd, state);
-}
-
-static struct output_properties acpi_output_properties = {
-	.set_state = acpi_video_output_set,
-	.get_status = acpi_video_output_get,
-};
-
-
 /* thermal cooling device callbacks */
 static int video_get_max_state(struct thermal_cooling_device *cooling_dev, unsigned
 			       long *state)
@@ -344,34 +311,6 @@ static struct thermal_cooling_device_ops video_cooling_ops = {
                                Video Management
    -------------------------------------------------------------------------- */
 
-/* device */
-
-static int
-acpi_video_device_get_state(struct acpi_video_device *device,
-			    unsigned long long *state)
-{
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_DCS", NULL, state);
-
-	return status;
-}
-
-static int
-acpi_video_device_set_state(struct acpi_video_device *device, int state)
-{
-	int status;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-	unsigned long long ret;
-
-
-	arg0.integer.value = state;
-	status = acpi_evaluate_integer(device->dev->handle, "_DSS", &args, &ret);
-
-	return status;
-}
-
 static int
 acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
 				   union acpi_object **levels)
@@ -831,15 +770,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DCS", &h_dummy1))) {
-		device->cap._DCS = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DGS", &h_dummy1))) {
-		device->cap._DGS = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DSS", &h_dummy1))) {
-		device->cap._DSS = 1;
-	}
 
 	if (acpi_video_backlight_support()) {
 		struct backlight_properties props;
@@ -904,21 +834,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 			printk(KERN_ERR PREFIX "Create sysfs link\n");
 
 	}
-
-	if (acpi_video_display_switch_support()) {
-
-		if (device->cap._DCS && device->cap._DSS) {
-			static int count;
-			char *name;
-			name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
-			if (!name)
-				return;
-			count++;
-			device->output_dev = video_output_register(name,
-					NULL, device, &acpi_output_properties);
-			kfree(name);
-		}
-	}
 }
 
 /*
@@ -1452,7 +1367,6 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 		thermal_cooling_device_unregister(device->cooling_dev);
 		device->cooling_dev = NULL;
 	}
-	video_output_unregister(device->output_dev);
 
 	return 0;
 }
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b836761..42d3d72 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -17,15 +17,14 @@
  * capabilities the graphics cards plugged in support. The check for general
  * video capabilities will be triggered by the first caller of
  * acpi_video_get_capabilities(NULL); which will happen when the first
- * backlight (or display output) switching supporting driver calls:
+ * backlight switching supporting driver calls:
  * acpi_video_backlight_support();
  *
  * Depending on whether ACPI graphics extensions (cmp. ACPI spec Appendix B)
  * are available, video.ko should be used to handle the device.
  *
  * Otherwise vendor specific drivers like thinkpad_acpi, asus_acpi,
- * sony_acpi,... can take care about backlight brightness and display output
- * switching.
+ * sony_acpi,... can take care about backlight brightness.
  *
  * If CONFIG_ACPI_VIDEO is neither set as "compiled in" (y) nor as a module (m)
  * this file will not be compiled, acpi_video_get_capabilities() and
@@ -83,11 +82,6 @@ long acpi_is_video_device(struct acpi_device *device)
 	if (!device)
 		return 0;
 
-	/* Is this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) ||
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
-		video_caps |= ACPI_VIDEO_OUTPUT_SWITCHING;
-
 	/* Is this device able to retrieve a video ROM ? */
 	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy)))
 		video_caps |= ACPI_VIDEO_ROM_AVAILABLE;
@@ -161,8 +155,6 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 		 *
 		 *   if (dmi_name_in_vendors("XY")) {
 		 *	acpi_video_support |=
-		 *		ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR;
-		 *	acpi_video_support |=
 		 *		ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
 		 *}
 		 */
@@ -212,33 +204,8 @@ int acpi_video_backlight_support(void)
 EXPORT_SYMBOL(acpi_video_backlight_support);
 
 /*
- * Returns true if video.ko can do display output switching.
- * This does not work well/at all with binary graphics drivers
- * which disable system io ranges and do it on their own.
- */
-int acpi_video_display_switch_support(void)
-{
-	if (!acpi_video_caps_checked)
-		acpi_video_get_capabilities(NULL);
-
-	if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR)
-		return 0;
-	else if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO)
-		return 1;
-
-	if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR)
-		return 0;
-	else if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO)
-		return 1;
-
-	return acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING;
-}
-EXPORT_SYMBOL(acpi_video_display_switch_support);
-
-/*
- * Use acpi_display_output=vendor/video or acpi_backlight=vendor/video
- * To force that backlight or display output switching is processed by vendor
- * specific acpi drivers or video.ko driver.
+ * Use acpi_backlight=vendor/video to force that backlight switching
+ * is processed by vendor specific acpi drivers or video.ko driver.
  */
 static int __init acpi_backlight(char *str)
 {
@@ -255,19 +222,3 @@ static int __init acpi_backlight(char *str)
 	return 1;
 }
 __setup("acpi_backlight=", acpi_backlight);
-
-static int __init acpi_display_output(char *str)
-{
-	if (str == NULL || *str == '\0')
-		return 1;
-	else {
-		if (!strcmp("vendor", str))
-			acpi_video_support |=
-				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR;
-		if (!strcmp("video", str))
-			acpi_video_support |=
-				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
-	}
-	return 1;
-}
-__setup("acpi_display_output=", acpi_display_output);
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 7af4436..64828a7 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -107,7 +107,6 @@ config DRM_I915
 	select FB_CFB_IMAGEBLIT
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select VIDEO_OUTPUT_CONTROL if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
diff --git a/drivers/gpu/stub/Kconfig b/drivers/gpu/stub/Kconfig
index 0e1edd7..09aea5f 100644
--- a/drivers/gpu/stub/Kconfig
+++ b/drivers/gpu/stub/Kconfig
@@ -3,7 +3,6 @@ config STUB_POULSBO
 	depends on PCI
 	# Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select VIDEO_OUTPUT_CONTROL if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
-- 
1.7.4.rc1.7.g2cf08

