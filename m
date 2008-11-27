From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI: acpi_video_backlight_support return found generic video brightness levels
Date: Thu, 27 Nov 2008 12:39:26 +0100
Message-ID: <1227785967-10548-2-git-send-email-trenn@suse.de>
References: <alpine.LFD.2.00.0811270010260.3895@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50158 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbYK0Lj3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Nov 2008 06:39:29 -0500
In-Reply-To: <alpine.LFD.2.00.0811270010260.3895@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: hmh@hmh.eng.br, mjg59@srcf.ucam.org, arvidjaar@mail.ru, rpurdie@rpsys.net, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/video.c        |   38 +++------------------
 drivers/acpi/video_detect.c |   74 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index baa4419..239800b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -445,37 +445,6 @@ acpi_video_device_set_state(struct acpi_video_device *device, int state)
 }
 
 static int
-acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
-				   union acpi_object **levels)
-{
-	int status;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-
-
-	*levels = NULL;
-
-	status = acpi_evaluate_object(device->dev->handle, "_BCL", NULL, &buffer);
-	if (!ACPI_SUCCESS(status))
-		return status;
-	obj = (union acpi_object *)buffer.pointer;
-	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
-		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
-		status = -EFAULT;
-		goto err;
-	}
-
-	*levels = obj;
-
-	return 0;
-
-      err:
-	kfree(buffer.pointer);
-
-	return status;
-}
-
-static int
 acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 {
 	int status = AE_OK;
@@ -625,6 +594,10 @@ acpi_video_bus_DOS(struct acpi_video_bus *video, int bios_flag, int lcd_flag)
 	return status;
 }
 
+/* from video_detect.c */
+int
+acpi_video_device_lcd_query_levels(acpi_handle handle,
+				   union acpi_object **levels);
 /*
  *  Arg:	
  *  	device	: video output device (LCD, CRT, ..)
@@ -643,7 +616,8 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	union acpi_object *o;
 	struct acpi_video_device_brightness *br = NULL;
 
-	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
+	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device->dev->
+							     handle, &obj))) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
 						"LCD brightness level\n"));
 		goto out;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index f022eb6..29e317c 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -42,19 +42,62 @@ ACPI_MODULE_NAME("video");
 
 static long acpi_video_support;
 static bool acpi_video_caps_checked;
+static int brightness_levels;
+
+/* also used in video.c */
+int
+acpi_video_device_lcd_query_levels(acpi_handle handle,
+				   union acpi_object **levels)
+{
+	int status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	*levels = NULL;
+
+	status = acpi_evaluate_object(handle, "_BCL", NULL, &buffer);
+	if (!ACPI_SUCCESS(status))
+		return status;
+	obj = (union acpi_object *)buffer.pointer;
+	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
+		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
+		status = -EFAULT;
+		goto err;
+	}
+
+	*levels = obj;
+
+	return 0;
+
+      err:
+	kfree(buffer.pointer);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(acpi_video_device_lcd_query_levels);
 
 static acpi_status
 acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
-			  void **retyurn_value)
+			  void **return_value)
 {
 	long *cap = context;
 	acpi_handle h_dummy;
+	union acpi_object *obj = NULL;
+	int ret;
 
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy)) &&
 	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy))) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
 				  "support\n"));
-		*cap |= ACPI_VIDEO_BACKLIGHT;
+
+		ret = acpi_video_device_lcd_query_levels(handle, &obj);
+		if (!ret)
+			brightness_levels = obj->package.count;
+		kfree(obj);
+
+		if (brightness_levels > 1)
+			*cap |= ACPI_VIDEO_BACKLIGHT;
+		
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
 	}
@@ -178,7 +221,14 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 }
 EXPORT_SYMBOL(acpi_video_get_capabilities);
 
-/* Returns true if video.ko can do backlight switching */
+/*
+ * Returns:
+ * >  1 - found _BCL brightness levels -> generic video support
+ * == 1 - could not get brightness level through _BCL, but generic video
+ *        support enforced, due to dmi or boot param, should not happen
+ * == 0 - no generic video functions found or vendor specific
+ *        support enforced via dmi or boot param.
+ */
 int acpi_video_backlight_support(void)
 {
 	/*
@@ -192,16 +242,26 @@ int acpi_video_backlight_support(void)
 	if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR)
 		return 0;
 	else if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO)
-		return 1;
+		goto video;
 
 	/* Then check for DMI blacklist -> second highest prio */
 	if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_DMI_VENDOR)
 		return 0;
 	else if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_DMI_VIDEO)
-		return 1;
+		goto video;
 
-	/* Then go the default way */
-	return acpi_video_support & ACPI_VIDEO_BACKLIGHT;
+ video:
+	if (acpi_video_support & ACPI_VIDEO_BACKLIGHT) {
+		if (brightness_levels < 2) {
+			printk(KERN_WARNING "Default Video backlight interface"
+			       " chosen, but no brightness levels found\n");
+			return 1;
+		}
+		else
+			return brightness_levels;
+	}
+	else
+		return 0;
 }
 EXPORT_SYMBOL(acpi_video_backlight_support);
 
-- 
1.6.0.2

