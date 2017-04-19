From: Dmitry Frank <mail@dmitryfrank.com>
Subject: [PATCH v2 1/3] ACPI: video: get rid of magic numbers and use enum instead
Date: Wed, 19 Apr 2017 12:48:07 +0300
Message-ID: <20170419094809.12895-2-mail@dmitryfrank.com>
References: <20170418123558.12436-1-mail@dmitryfrank.com>
 <20170419094809.12895-1-mail@dmitryfrank.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward14m.cmail.yandex.net ([5.255.216.145]:46495 "EHLO
        forward14m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761281AbdDSKD4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 06:03:56 -0400
In-Reply-To: <20170419094809.12895-1-mail@dmitryfrank.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Frank <mail@dmitryfrank.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, linux-acpi@vger.kernel.org

The first two items in the _BCL method response are special:

  - Level when machine has full power
  - Level when machine is on batteries
  - .... actual supported levels go there ....

So this commits adds an enum and uses its descriptive elements
throughout the code, instead of magic numbers.

Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
---
 drivers/acpi/acpi_video.c | 110 +++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index d00bc0ef87a6..9a607af971e7 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -88,6 +88,18 @@ static int acpi_video_bus_remove(struct acpi_device *device);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
 void acpi_video_detect_exit(void);
 
+/*
+ * Indices in the _BCL method response: the first two items are special,
+ * the rest are all supported levels.
+ *
+ * See page 575 of the ACPI spec 3.0
+ */
+enum acpi_video_level_idx {
+	ACPI_VIDEO_AC_LEVEL,		/* level when machine has full power */
+	ACPI_VIDEO_BATTERY_LEVEL,	/* level when machine is on batteries */
+	ACPI_VIDEO_FIRST_LEVEL,		/* actual supported levels begin here */
+};
+
 static const struct acpi_device_id video_device_ids[] = {
 	{ACPI_VIDEO_HID, 0},
 	{"", 0},
@@ -217,20 +229,16 @@ static int acpi_video_get_brightness(struct backlight_device *bd)
 
 	if (acpi_video_device_lcd_get_level_current(vd, &cur_level, false))
 		return -EINVAL;
-	for (i = 2; i < vd->brightness->count; i++) {
+	for (i = ACPI_VIDEO_FIRST_LEVEL; i < vd->brightness->count; i++) {
 		if (vd->brightness->levels[i] == cur_level)
-			/*
-			 * The first two entries are special - see page 575
-			 * of the ACPI spec 3.0
-			 */
-			return i - 2;
+			return i - ACPI_VIDEO_FIRST_LEVEL;
 	}
 	return 0;
 }
 
 static int acpi_video_set_brightness(struct backlight_device *bd)
 {
-	int request_level = bd->props.brightness + 2;
+	int request_level = bd->props.brightness + ACPI_VIDEO_FIRST_LEVEL;
 	struct acpi_video_device *vd = bl_get_data(bd);
 
 	cancel_delayed_work(&vd->switch_brightness_work);
@@ -244,18 +252,18 @@ static const struct backlight_ops acpi_backlight_ops = {
 };
 
 /* thermal cooling device callbacks */
-static int video_get_max_state(struct thermal_cooling_device *cooling_dev, unsigned
-			       long *state)
+static int video_get_max_state(struct thermal_cooling_device *cooling_dev,
+			       unsigned long *state)
 {
 	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
 
-	*state = video->brightness->count - 3;
+	*state = video->brightness->count - ACPI_VIDEO_FIRST_LEVEL - 1;
 	return 0;
 }
 
-static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsigned
-			       long *state)
+static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,
+			       unsigned long *state)
 {
 	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
@@ -264,7 +272,8 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsig
 
 	if (acpi_video_device_lcd_get_level_current(video, &level, false))
 		return -EINVAL;
-	for (offset = 2; offset < video->brightness->count; offset++)
+	for (offset = ACPI_VIDEO_FIRST_LEVEL; offset < video->brightness->count;
+	     offset++)
 		if (level == video->brightness->levels[offset]) {
 			*state = video->brightness->count - offset - 1;
 			return 0;
@@ -280,7 +289,7 @@ video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned long st
 	struct acpi_video_device *video = acpi_driver_data(device);
 	int level;
 
-	if (state >= video->brightness->count - 2)
+	if (state >= video->brightness->count - ACPI_VIDEO_FIRST_LEVEL)
 		return -EINVAL;
 
 	state = video->brightness->count - state;
@@ -345,10 +354,12 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 	}
 
 	device->brightness->curr = level;
-	for (state = 2; state < device->brightness->count; state++)
+	for (state = ACPI_VIDEO_FIRST_LEVEL; state < device->brightness->count;
+	     state++)
 		if (level == device->brightness->levels[state]) {
 			if (device->backlight)
-				device->backlight->props.brightness = state - 2;
+				device->backlight->props.brightness =
+					state - ACPI_VIDEO_FIRST_LEVEL;
 			return 0;
 		}
 
@@ -530,14 +541,16 @@ acpi_video_bqc_value_to_level(struct acpi_video_device *device,
 
 	if (device->brightness->flags._BQC_use_index) {
 		/*
-		 * _BQC returns an index that doesn't account for
-		 * the first 2 items with special meaning, so we need
-		 * to compensate for that by offsetting ourselves
+		 * _BQC returns an index that doesn't account for the first 2
+		 * items with special meaning (see enum acpi_video_level_idx),
+		 * so we need to compensate for that by offsetting ourselves
 		 */
 		if (device->brightness->flags._BCL_reversed)
-			bqc_value = device->brightness->count - 3 - bqc_value;
+			bqc_value = device->brightness->count -
+				ACPI_VIDEO_FIRST_LEVEL - 1 - bqc_value;
 
-		level = device->brightness->levels[bqc_value + 2];
+		level = device->brightness->levels[bqc_value +
+		                                   ACPI_VIDEO_FIRST_LEVEL];
 	} else {
 		level = bqc_value;
 	}
@@ -571,7 +584,8 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 
 			*level = acpi_video_bqc_value_to_level(device, *level);
 
-			for (i = 2; i < device->brightness->count; i++)
+			for (i = ACPI_VIDEO_FIRST_LEVEL;
+			     i < device->brightness->count; i++)
 				if (device->brightness->levels[i] == *level) {
 					device->brightness->curr = *level;
 					return 0;
@@ -716,7 +730,9 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
 	 * Some systems always report current brightness level as maximum
 	 * through _BQC, we need to test another value for them.
 	 */
-	test_level = current_level == max_level ? br->levels[3] : max_level;
+	test_level = current_level == max_level
+		? br->levels[ACPI_VIDEO_FIRST_LEVEL + 1]
+		: max_level;
 
 	result = acpi_video_device_lcd_set_level(device, test_level);
 	if (result)
@@ -730,8 +746,8 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
 		/* buggy _BQC found, need to find out if it uses index */
 		if (level < br->count) {
 			if (br->flags._BCL_reversed)
-				level = br->count - 3 - level;
-			if (br->levels[level + 2] == test_level)
+				level = br->count - ACPI_VIDEO_FIRST_LEVEL - 1 - level;
+			if (br->levels[level + ACPI_VIDEO_FIRST_LEVEL] == test_level)
 				br->flags._BQC_use_index = 1;
 		}
 
@@ -761,7 +777,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 		goto out;
 	}
 
-	if (obj->package.count < 2) {
+	if (obj->package.count < ACPI_VIDEO_FIRST_LEVEL) {
 		result = -EINVAL;
 		goto out;
 	}
@@ -773,8 +789,8 @@ int acpi_video_get_levels(struct acpi_device *device,
 		goto out;
 	}
 
-	br->levels = kmalloc((obj->package.count + 2) * sizeof *(br->levels),
-				GFP_KERNEL);
+	br->levels = kmalloc((obj->package.count + ACPI_VIDEO_FIRST_LEVEL) *
+	                     sizeof(*br->levels), GFP_KERNEL);
 	if (!br->levels) {
 		result = -ENOMEM;
 		goto out_free;
@@ -788,7 +804,8 @@ int acpi_video_get_levels(struct acpi_device *device,
 		}
 		value = (u32) o->integer.value;
 		/* Skip duplicate entries */
-		if (count > 2 && br->levels[count - 1] == value)
+		if (count > ACPI_VIDEO_FIRST_LEVEL
+		    && br->levels[count - 1] == value)
 			continue;
 
 		br->levels[count] = value;
@@ -804,27 +821,30 @@ int acpi_video_get_levels(struct acpi_device *device,
 	 * In this case, the first two elements in _BCL packages
 	 * are also supported brightness levels that OS should take care of.
 	 */
-	for (i = 2; i < count; i++) {
-		if (br->levels[i] == br->levels[0])
+	for (i = ACPI_VIDEO_FIRST_LEVEL; i < count; i++) {
+		if (br->levels[i] == br->levels[ACPI_VIDEO_AC_LEVEL])
 			level_ac_battery++;
-		if (br->levels[i] == br->levels[1])
+		if (br->levels[i] == br->levels[ACPI_VIDEO_BATTERY_LEVEL])
 			level_ac_battery++;
 	}
 
-	if (level_ac_battery < 2) {
-		level_ac_battery = 2 - level_ac_battery;
+	if (level_ac_battery < ACPI_VIDEO_FIRST_LEVEL) {
+		level_ac_battery = ACPI_VIDEO_FIRST_LEVEL - level_ac_battery;
 		br->flags._BCL_no_ac_battery_levels = 1;
-		for (i = (count - 1 + level_ac_battery); i >= 2; i--)
+		for (i = (count - 1 + level_ac_battery);
+		     i >= ACPI_VIDEO_FIRST_LEVEL; i--)
 			br->levels[i] = br->levels[i - level_ac_battery];
 		count += level_ac_battery;
-	} else if (level_ac_battery > 2)
+	} else if (level_ac_battery > ACPI_VIDEO_FIRST_LEVEL)
 		ACPI_ERROR((AE_INFO, "Too many duplicates in _BCL package"));
 
 	/* Check if the _BCL package is in a reversed order */
-	if (max_level == br->levels[2]) {
+	if (max_level == br->levels[ACPI_VIDEO_FIRST_LEVEL]) {
 		br->flags._BCL_reversed = 1;
-		sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
-			acpi_video_cmp_level, NULL);
+		sort(&br->levels[ACPI_VIDEO_FIRST_LEVEL],
+		     count - ACPI_VIDEO_FIRST_LEVEL,
+		     sizeof(br->levels[ACPI_VIDEO_FIRST_LEVEL]),
+		     acpi_video_cmp_level, NULL);
 	} else if (max_level != br->levels[count - 1])
 		ACPI_ERROR((AE_INFO,
 			    "Found unordered _BCL package"));
@@ -894,7 +914,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	 * level_old is invalid (no matter whether it's a level
 	 * or an index). Set the backlight to max_level in this case.
 	 */
-	for (i = 2; i < br->count; i++)
+	for (i = ACPI_VIDEO_FIRST_LEVEL; i < br->count; i++)
 		if (level == br->levels[i])
 			break;
 	if (i == br->count || !level)
@@ -906,7 +926,8 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		goto out_free_levels;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "found %d brightness levels\n", br->count - 2));
+	                  "found %d brightness levels\n",
+	                  br->count - ACPI_VIDEO_FIRST_LEVEL));
 	return 0;
 
 out_free_levels:
@@ -1297,7 +1318,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 	max = max_below = 0;
 	min = min_above = 255;
 	/* Find closest level to level_current */
-	for (i = 2; i < device->brightness->count; i++) {
+	for (i = ACPI_VIDEO_FIRST_LEVEL; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (abs(l - level_current) < abs(delta)) {
 			delta = l - level_current;
@@ -1307,7 +1328,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 	}
 	/* Ajust level_current to closest available level */
 	level_current += delta;
-	for (i = 2; i < device->brightness->count; i++) {
+	for (i = ACPI_VIDEO_FIRST_LEVEL; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (l < min)
 			min = l;
@@ -1680,7 +1701,8 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_FIRMWARE;
-	props.max_brightness = device->brightness->count - 3;
+	props.max_brightness =
+		device->brightness->count - ACPI_VIDEO_FIRST_LEVEL - 1;
 	device->backlight = backlight_device_register(name,
 						      parent,
 						      device,
-- 
2.11.0

