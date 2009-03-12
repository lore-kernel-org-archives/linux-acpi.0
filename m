From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 5/7] ACPI video: support _BQC/_BCL/_BCM methods that
	use index values
Date: Thu, 12 Mar 2009 16:57:07 +0800
Message-ID: <1236848227.2807.74.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819AbZCLI4L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 04:56:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

The input/output of _BQC/_BCL/_BCM control methods should be represented
by a number between 0 and 100, and can be thought of as a percentage.
But some buggy _BQC/_BCL/_BCM methods use the index values instead.
http://bugzilla.kernel.org/show_bug.cgi?id=12302
http://bugzilla.kernel.org/show_bug.cgi?id=12249
http://bugzilla.kernel.org/show_bug.cgi?id=12037

Add the functionality to support such kind of BIOSes in ACPI video driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/video.c |   91 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 21 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -171,6 +171,9 @@ struct acpi_video_device_cap {
 struct acpi_video_brightness_flags {
 	u8 _BCL_no_ac_battery_levels:1;	/* no AC/Battery levels in _BCL */
 	u8 _BCL_reversed:1;		/* _BCL package is in a reversed order*/
+	u8 _BCL_use_index:1;		/* levels in _BCL are index values */
+	u8 _BCM_use_index:1;		/* input of _BCM is an index value */
+	u8 _BQC_use_index:1;		/* _BQC returns an index value */
 };
 
 struct acpi_video_device_brightness {
@@ -505,7 +508,8 @@ acpi_video_device_lcd_set_level(struct a
 	device->brightness->curr = level;
 	for (state = 2; state < device->brightness->count; state++)
 		if (level == device->brightness->levels[state]) {
-			device->backlight->props.brightness = state - 2;
+			if (device->backlight)
+				device->backlight->props.brightness = state - 2;
 			return 0;
 		}
 
@@ -523,6 +527,13 @@ acpi_video_device_lcd_get_level_current(
 		status = acpi_evaluate_integer(device->dev->handle, "_BQC",
 						NULL, level);
 		if (ACPI_SUCCESS(status)) {
+			if (device->brightness->flags._BQC_use_index) {
+				if (device->brightness->flags._BCL_reversed)
+					*level = device->brightness->count
+								 - 3 - (*level);
+				*level = device->brightness->levels[*level + 2];
+
+			}
 			device->brightness->curr = *level;
 			return 0;
 		} else {
@@ -689,8 +700,10 @@ acpi_video_init_brightness(struct acpi_v
 {
 	union acpi_object *obj = NULL;
 	int i, max_level = 0, count = 0, level_ac_battery = 0;
+	unsigned long long level, level_old;
 	union acpi_object *o;
 	struct acpi_video_device_brightness *br = NULL;
+	int result = -EINVAL;
 
 	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
@@ -704,13 +717,16 @@ acpi_video_init_brightness(struct acpi_v
 	br = kzalloc(sizeof(*br), GFP_KERNEL);
 	if (!br) {
 		printk(KERN_ERR "can't allocate memory\n");
+		result = -ENOMEM;
 		goto out;
 	}
 
 	br->levels = kmalloc((obj->package.count + 2) * sizeof *(br->levels),
 				GFP_KERNEL);
-	if (!br->levels)
+	if (!br->levels) {
+		result = -ENOMEM;
 		goto out_free;
+	}
 
 	for (i = 0; i < obj->package.count; i++) {
 		o = (union acpi_object *)&obj->package.elements[i];
@@ -756,10 +772,55 @@ acpi_video_init_brightness(struct acpi_v
 
 	br->count = count;
 	device->brightness = br;
+
+	/* Check the input/output of _BQC/_BCL/_BCM */
+	if ((max_level < 100) && (max_level <= (count - 2)))
+		br->flags._BCL_use_index = 1;
+
+	/*
+	 * _BCM is always consistent with _BCL,
+	 * at least for all the laptops we have ever seen.
+	 */
+	br->flags._BCM_use_index = br->flags._BCL_use_index;
+
+	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
+	br->curr = max_level;
+	result = acpi_video_device_lcd_get_level_current(device, &level_old);
+	if (result)
+		goto out_free_levels;
+
+	result = acpi_video_device_lcd_set_level(device, br->curr);
+	if (result)
+		goto out_free_levels;
+
+	result = acpi_video_device_lcd_get_level_current(device, &level);
+	if (result)
+		goto out_free_levels;
+
+	if ((level != level_old) && !br->flags._BCM_use_index) {
+		/* Note:
+		 * This piece of code does not work correctly if the current
+		 * brightness levels is 0.
+		 * But I guess boxes that boot with such a dark screen are rare
+		 * and no mroe code is needed to cover this specifial case.
+		 */
+
+		if (level_ac_battery != 2) {
+			/*
+			 * For now, we don't support the _BCL like this:
+			 * 16, 15, 0, 1, 2, 3, ..., 14, 15, 16
+			 * because we may mess up the index returned by _BQC.
+			 * Plus: we have not got a box like this.
+			 */
+			ACPI_ERROR((AE_INFO, "_BCL not supported\n"));
+		}
+		br->flags._BQC_use_index = 1;
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "found %d brightness levels\n", count - 2));
 	kfree(obj);
-	return max_level;
+	return result;
 
 out_free_levels:
 	kfree(br->levels);
@@ -768,7 +829,7 @@ out_free:
 out:
 	device->brightness = NULL;
 	kfree(obj);
-	return 0;
+	return result;
 }
 
 /*
@@ -785,7 +846,6 @@ out:
 static void acpi_video_device_find_cap(struct acpi_video_device *device)
 {
 	acpi_handle h_dummy1;
-	u32 max_level = 0;
 
 
 	memset(&device->cap, 0, sizeof(device->cap));
@@ -814,13 +874,14 @@ static void acpi_video_device_find_cap(s
 		device->cap._DSS = 1;
 	}
 
-	if (acpi_video_backlight_support())
-		max_level = acpi_video_init_brightness(device);
-
-	if (device->cap._BCL && device->cap._BCM && max_level > 0) {
+	if (acpi_video_backlight_support()) {
 		int result;
 		static int count = 0;
 		char *name;
+
+		result = acpi_video_init_brightness(device);
+		if (result)
+			return;
 		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
 		if (!name)
 			return;
@@ -829,18 +890,6 @@ static void acpi_video_device_find_cap(s
 		device->backlight = backlight_device_register(name,
 			NULL, device, &acpi_backlight_ops);
 		device->backlight->props.max_brightness = device->brightness->count-3;
-		/*
-		 * If there exists the _BQC object, the _BQC object will be
-		 * called to get the current backlight brightness. Otherwise
-		 * the brightness will be set to the maximum.
-		 */
-		if (device->cap._BQC)
-			device->backlight->props.brightness =
-				acpi_video_get_brightness(device->backlight);
-		else
-			device->backlight->props.brightness =
-				device->backlight->props.max_brightness;
-		backlight_update_status(device->backlight);
 		kfree(name);
 
 		device->cdev = thermal_cooling_device_register("LCD",


