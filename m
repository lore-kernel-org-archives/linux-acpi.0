From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 2/5] acpi_video: Avoid unnecessary conversions between backlight levels and indexes
Date: Thu,  7 Mar 2013 13:39:37 -0600
Message-ID: <1362685180-7768-2-git-send-email-seth.forshee@canonical.com>
References: <20130307193812.GD24233@thinkpad-t410>
 <1362685180-7768-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49284 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab3CGTjs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Mar 2013 14:39:48 -0500
In-Reply-To: <1362685180-7768-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Seth Forshee <seth.forshee@canonical.com>

The acpi_video code deals mostly in backlight levels, but often these
levels are immediately converted to an index into the array of backlight
levels. This involves iterating over the array, whereas converting to
the index to a level is a simple index into the array.

Since the index to brightness conversion is a less expensive operation,
change the cached current brightness value to store the index rather
than the value. Also add versions of common brightness functions which
accept or return the index to avoid unnecessary conversions.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/acpi/video.c |  110 +++++++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index f0e7e60..edfcd74 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -196,7 +196,7 @@ struct acpi_video_brightness_flags {
 };
 
 struct acpi_video_device_brightness {
-	int curr;
+	int curr_state;
 	int count;
 	int *levels;
 	struct acpi_video_brightness_flags flags;
@@ -226,11 +226,15 @@ static void acpi_video_device_rebind(struct acpi_video_bus *video);
 static void acpi_video_device_bind(struct acpi_video_bus *video,
 				   struct acpi_video_device *device);
 static int acpi_video_device_enumerate(struct acpi_video_bus *video);
+static int acpi_video_device_lcd_set_state(struct acpi_video_device *device,
+					   int state);
 static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
 			int level);
 static int acpi_video_device_lcd_get_level_current(
 			struct acpi_video_device *device,
 			unsigned long long *level, int init);
+static int acpi_video_device_lcd_get_state_current(
+			struct acpi_video_device *device, int *state);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static int acpi_video_switch_brightness(struct acpi_video_device *device,
@@ -239,20 +243,15 @@ static int acpi_video_switch_brightness(struct acpi_video_device *device,
 /*backlight device sysfs support*/
 static int acpi_video_get_brightness(struct backlight_device *bd)
 {
-	unsigned long long cur_level;
-	int i;
+	int curr_state;
+	int result;
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
 
-	if (acpi_video_device_lcd_get_level_current(vd, &cur_level, 0))
-		return -EINVAL;
-	for (i = 2; i < vd->brightness->count; i++) {
-		if (vd->brightness->levels[i] == cur_level)
-			/* The first two entries are special - see page 575
-			   of the ACPI spec 3.0 */
-			return i-2;
-	}
-	return 0;
+	result = acpi_video_device_lcd_get_state_current(vd, &curr_state);
+	if (result)
+		return result;
+	return curr_state - 2;
 }
 
 static int acpi_video_set_brightness(struct backlight_device *bd)
@@ -261,8 +260,7 @@ static int acpi_video_set_brightness(struct backlight_device *bd)
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
 
-	return acpi_video_device_lcd_set_level(vd,
-				vd->brightness->levels[request_level]);
+	return acpi_video_device_lcd_set_state(vd, request_level);
 }
 
 static const struct backlight_ops acpi_backlight_ops = {
@@ -286,18 +284,15 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsig
 {
 	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
-	unsigned long long level;
-	int offset;
+	int curr_state;
+	int result;
 
-	if (acpi_video_device_lcd_get_level_current(video, &level, 0))
-		return -EINVAL;
-	for (offset = 2; offset < video->brightness->count; offset++)
-		if (level == video->brightness->levels[offset]) {
-			*state = video->brightness->count - offset - 1;
-			return 0;
-		}
+	result = acpi_video_device_lcd_get_state_current(video, &curr_state);
+	if (result)
+		return result;
 
-	return -EINVAL;
+	*state = video->brightness->count - curr_state - 1;
+	return 0;
 }
 
 static int
@@ -305,14 +300,12 @@ video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned long st
 {
 	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
-	int level;
 
 	if ( state >= video->brightness->count - 2)
 		return -EINVAL;
 
-	state = video->brightness->count - state;
-	level = video->brightness->levels[state -1];
-	return acpi_video_device_lcd_set_level(video, level);
+	state = video->brightness->count - state - 1;
+	return acpi_video_device_lcd_set_state(video, state);
 }
 
 static const struct thermal_cooling_device_ops video_cooling_ops = {
@@ -357,12 +350,12 @@ acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
 }
 
 static int
-acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
+acpi_video_device_lcd_set_state(struct acpi_video_device *device, int state)
 {
-	int status;
+	int level = device->brightness->levels[state];
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
-	int state;
+	acpi_status status;
 
 	arg0.integer.value = level;
 
@@ -373,16 +366,28 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 		return -EIO;
 	}
 
-	device->brightness->curr = level;
+	device->brightness->curr_state = state;
+	if (device->backlight)
+		device->backlight->props.brightness = state - 2;
+
+	return 0;
+}
+
+static int
+acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
+{
+	int state;
+
 	for (state = 2; state < device->brightness->count; state++)
-		if (level == device->brightness->levels[state]) {
-			if (device->backlight)
-				device->backlight->props.brightness = state - 2;
-			return 0;
-		}
+		if (level == device->brightness->levels[state])
+			break;
 
-	ACPI_ERROR((AE_INFO, "Current brightness invalid"));
-	return -EINVAL;
+	if (state == device->brightness->count) {
+		ACPI_ERROR((AE_INFO, "Invalid brightness value"));
+		return -EINVAL;
+	}
+
+	return acpi_video_device_lcd_set_state(device, state);
 }
 
 /*
@@ -481,7 +486,7 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 			*level += bqc_offset_aml_bug_workaround;
 			for (i = 2; i < device->brightness->count; i++)
 				if (device->brightness->levels[i] == *level) {
-					device->brightness->curr = *level;
+					device->brightness->curr_state = i;
 					return 0;
 			}
 			if (!init) {
@@ -497,9 +502,10 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 		} else {
 			/* Fixme:
 			 * should we return an error or ignore this failure?
-			 * dev->brightness->curr is a cached value which stores
-			 * the correct current backlight level in most cases.
-			 * ACPI video backlight still works w/ buggy _BQC.
+			 * dev->brightness->curr_state is a cached value which
+			 * stores the index of correct current backlight level
+			 * in most cases. ACPI video backlight still works w/
+			 * buggy _BQC.
 			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
 			 */
 			ACPI_WARNING((AE_INFO, "Evaluating %s failed", buf));
@@ -507,11 +513,24 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 		}
 	}
 
-	*level = device->brightness->curr;
+	*level = device->brightness->levels[device->brightness->curr_state];
 	return 0;
 }
 
 static int
+acpi_video_device_lcd_get_state_current(struct acpi_video_device *device,
+					int *state)
+{
+	int result;
+	unsigned long long level;
+
+	result = acpi_video_device_lcd_get_level_current(device, &level, 0);
+
+	*state = device->brightness->curr_state;
+	return result;
+}
+
+static int
 acpi_video_device_EDID(struct acpi_video_device *device,
 		       union acpi_object **edid, ssize_t length)
 {
@@ -706,7 +725,8 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	br->flags._BCM_use_index = br->flags._BCL_use_index;
 
 	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
-	br->curr = level = max_level;
+	level = max_level;
+	br->curr_state = count - 1;
 
 	if (!device->cap._BQC)
 		goto set_level;
-- 
1.7.9.5

