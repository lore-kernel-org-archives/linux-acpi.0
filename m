From: Dmitry Frank <mail@dmitryfrank.com>
Subject: [PATCH] acpi: video: get rid of magic numbers and use enum instead
Date: Tue, 18 Apr 2017 15:35:58 +0300
Message-ID: <20170418123558.12436-1-mail@dmitryfrank.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward13p.cmail.yandex.net ([87.250.241.140]:58309 "EHLO
        forward13p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752125AbdDRMoN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 08:44:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Frank <mail@dmitryfrank.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, linux-acpi@vger.kernel.org

The first two items in the _BCL method response are special:

  - Level when machine has full power
  - Level when machine is on batteries
  - .... actual supported levels go there ....

So this commits adds an enum and uses its descriptive elements
throughout the code, instead of magic numbers.

Some subtle cases are commented additionally (the comment for
acpi_video_bqc_quirk is by Felipe Contreras, CCed)

Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
---
 drivers/acpi/acpi_video.c | 134 ++++++++++++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index d00bc0ef87a6..856694e5f325 100644
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
+enum lvl_idx {
+	LVL_IDX_AC,		/* level when machine has full power */
+	LVL_IDX_BATTERY,	/* level when machine is on batteries */
+	LVL_IDX_FIRST,		/* actual supported levels begin here */
+};
+
 static const struct acpi_device_id video_device_ids[] = {
 	{ACPI_VIDEO_HID, 0},
 	{"", 0},
@@ -132,7 +144,7 @@ struct acpi_video_device_attrib {
 				   the VGA device. */
 	u32 pipe_id:3;		/* For VGA multiple-head devices. */
 	u32 reserved:10;	/* Must be 0 */
-	u32 device_id_scheme:1;	/* Device ID Scheme */
+	u32 device_id_scheme:1;	/* Whether the device ID follows this scheme above */
 };
 
 struct acpi_video_enumerated_device {
@@ -217,20 +229,16 @@ static int acpi_video_get_brightness(struct backlight_device *bd)
 
 	if (acpi_video_device_lcd_get_level_current(vd, &cur_level, false))
 		return -EINVAL;
-	for (i = 2; i < vd->brightness->count; i++) {
+	for (i = LVL_IDX_FIRST; i < vd->brightness->count; i++) {
 		if (vd->brightness->levels[i] == cur_level)
-			/*
-			 * The first two entries are special - see page 575
-			 * of the ACPI spec 3.0
-			 */
-			return i - 2;
+			return i - LVL_IDX_FIRST;
 	}
 	return 0;
 }
 
 static int acpi_video_set_brightness(struct backlight_device *bd)
 {
-	int request_level = bd->props.brightness + 2;
+	int request_level = bd->props.brightness + LVL_IDX_FIRST;
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
+	*state = video->brightness->count - LVL_IDX_FIRST - 1;
 	return 0;
 }
 
-static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsigned
-			       long *state)
+static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,
+			       unsigned long *state)
 {
 	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
@@ -264,7 +272,7 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsig
 
 	if (acpi_video_device_lcd_get_level_current(video, &level, false))
 		return -EINVAL;
-	for (offset = 2; offset < video->brightness->count; offset++)
+	for (offset = LVL_IDX_FIRST; offset < video->brightness->count; offset++)
 		if (level == video->brightness->levels[offset]) {
 			*state = video->brightness->count - offset - 1;
 			return 0;
@@ -280,7 +288,7 @@ video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned long st
 	struct acpi_video_device *video = acpi_driver_data(device);
 	int level;
 
-	if (state >= video->brightness->count - 2)
+	if (state >= video->brightness->count - LVL_IDX_FIRST)
 		return -EINVAL;
 
 	state = video->brightness->count - state;
@@ -345,10 +353,11 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 	}
 
 	device->brightness->curr = level;
-	for (state = 2; state < device->brightness->count; state++)
+	for (state = LVL_IDX_FIRST; state < device->brightness->count; state++)
 		if (level == device->brightness->levels[state]) {
 			if (device->backlight)
-				device->backlight->props.brightness = state - 2;
+				device->backlight->props.brightness =
+					state - LVL_IDX_FIRST;
 			return 0;
 		}
 
@@ -530,14 +539,15 @@ acpi_video_bqc_value_to_level(struct acpi_video_device *device,
 
 	if (device->brightness->flags._BQC_use_index) {
 		/*
-		 * _BQC returns an index that doesn't account for
-		 * the first 2 items with special meaning, so we need
+		 * _BQC returns an index that doesn't account for the first 2
+		 * items with special meaning (see enum lvl_idx), so we need
 		 * to compensate for that by offsetting ourselves
 		 */
 		if (device->brightness->flags._BCL_reversed)
-			bqc_value = device->brightness->count - 3 - bqc_value;
+			bqc_value = device->brightness->count -
+				LVL_IDX_FIRST - 1 - bqc_value;
 
-		level = device->brightness->levels[bqc_value + 2];
+		level = device->brightness->levels[bqc_value + LVL_IDX_FIRST];
 	} else {
 		level = bqc_value;
 	}
@@ -571,7 +581,7 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 
 			*level = acpi_video_bqc_value_to_level(device, *level);
 
-			for (i = 2; i < device->brightness->count; i++)
+			for (i = LVL_IDX_FIRST; i < device->brightness->count; i++)
 				if (device->brightness->levels[i] == *level) {
 					device->brightness->curr = *level;
 					return 0;
@@ -714,9 +724,37 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
 
 	/*
 	 * Some systems always report current brightness level as maximum
-	 * through _BQC, we need to test another value for them.
+	 * through _BQC, we need to test another value for them. However,
+	 * there is a subtlety:
+	 *
+	 * If the _BCL package ordering is descending, the first level
+	 * (br->levels[2]) is likely to be 0, and if the number of levels
+	 * matches the number of steps, we might confuse a returned level to
+	 * mean the index.
+	 *
+	 * For example:
+	 *
+	 *     current_level = max_level = 100
+	 *     test_level = 0
+	 *     returned level = 100
+	 *
+	 * In this case 100 means the level, not the index, and _BCM failed.
+	 * Still, if the _BCL package ordering is descending, the index of
+	 * level 0 is also 100, so we assume _BQC is indexed, when it's not.
+	 *
+	 * This causes all _BQC calls to return bogus values causing weird
+	 * behavior from the user's perspective.  For example:
+	 *
+	 * xbacklight -set 10; xbacklight -set 20;
+	 *
+	 * would flash to 90% and then slowly down to the desired level (20).
+	 *
+	 * The solution is simple; test anything other than the first level
+	 * (e.g. 1).
 	 */
-	test_level = current_level == max_level ? br->levels[3] : max_level;
+	test_level = current_level == max_level
+		? br->levels[LVL_IDX_FIRST + 1]
+		: max_level;
 
 	result = acpi_video_device_lcd_set_level(device, test_level);
 	if (result)
@@ -730,8 +768,8 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
 		/* buggy _BQC found, need to find out if it uses index */
 		if (level < br->count) {
 			if (br->flags._BCL_reversed)
-				level = br->count - 3 - level;
-			if (br->levels[level + 2] == test_level)
+				level = br->count - LVL_IDX_FIRST - 1 - level;
+			if (br->levels[level + LVL_IDX_FIRST] == test_level)
 				br->flags._BQC_use_index = 1;
 		}
 
@@ -761,7 +799,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 		goto out;
 	}
 
-	if (obj->package.count < 2) {
+	if (obj->package.count < LVL_IDX_FIRST) {
 		result = -EINVAL;
 		goto out;
 	}
@@ -773,8 +811,13 @@ int acpi_video_get_levels(struct acpi_device *device,
 		goto out;
 	}
 
-	br->levels = kmalloc((obj->package.count + 2) * sizeof *(br->levels),
-				GFP_KERNEL);
+	/*
+	 * Note that we have to reserve 2 extra items (LVL_IDX_FIRST), in order
+	 * to account for buggy BIOS which don't export the first two special
+	 * levels (see below)
+	 */
+	br->levels = kmalloc((obj->package.count + LVL_IDX_FIRST) * sizeof(*br->levels),
+			     GFP_KERNEL);
 	if (!br->levels) {
 		result = -ENOMEM;
 		goto out_free;
@@ -788,7 +831,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 		}
 		value = (u32) o->integer.value;
 		/* Skip duplicate entries */
-		if (count > 2 && br->levels[count - 1] == value)
+		if (count > LVL_IDX_FIRST && br->levels[count - 1] == value)
 			continue;
 
 		br->levels[count] = value;
@@ -804,27 +847,28 @@ int acpi_video_get_levels(struct acpi_device *device,
 	 * In this case, the first two elements in _BCL packages
 	 * are also supported brightness levels that OS should take care of.
 	 */
-	for (i = 2; i < count; i++) {
-		if (br->levels[i] == br->levels[0])
+	for (i = LVL_IDX_FIRST; i < count; i++) {
+		if (br->levels[i] == br->levels[LVL_IDX_AC])
 			level_ac_battery++;
-		if (br->levels[i] == br->levels[1])
+		if (br->levels[i] == br->levels[LVL_IDX_BATTERY])
 			level_ac_battery++;
 	}
 
-	if (level_ac_battery < 2) {
-		level_ac_battery = 2 - level_ac_battery;
+	if (level_ac_battery < LVL_IDX_FIRST) {
+		level_ac_battery = LVL_IDX_FIRST - level_ac_battery;
 		br->flags._BCL_no_ac_battery_levels = 1;
-		for (i = (count - 1 + level_ac_battery); i >= 2; i--)
+		for (i = (count - 1 + level_ac_battery); i >= LVL_IDX_FIRST; i--)
 			br->levels[i] = br->levels[i - level_ac_battery];
 		count += level_ac_battery;
-	} else if (level_ac_battery > 2)
+	} else if (level_ac_battery > LVL_IDX_FIRST)
 		ACPI_ERROR((AE_INFO, "Too many duplicates in _BCL package"));
 
 	/* Check if the _BCL package is in a reversed order */
-	if (max_level == br->levels[2]) {
+	if (max_level == br->levels[LVL_IDX_FIRST]) {
 		br->flags._BCL_reversed = 1;
-		sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
-			acpi_video_cmp_level, NULL);
+		sort(&br->levels[LVL_IDX_FIRST],
+		     count - LVL_IDX_FIRST, sizeof(br->levels[LVL_IDX_FIRST]),
+		     acpi_video_cmp_level, NULL);
 	} else if (max_level != br->levels[count - 1])
 		ACPI_ERROR((AE_INFO,
 			    "Found unordered _BCL package"));
@@ -894,7 +938,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	 * level_old is invalid (no matter whether it's a level
 	 * or an index). Set the backlight to max_level in this case.
 	 */
-	for (i = 2; i < br->count; i++)
+	for (i = LVL_IDX_FIRST; i < br->count; i++)
 		if (level == br->levels[i])
 			break;
 	if (i == br->count || !level)
@@ -906,7 +950,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		goto out_free_levels;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "found %d brightness levels\n", br->count - 2));
+			  "found %d brightness levels\n", br->count - LVL_IDX_FIRST));
 	return 0;
 
 out_free_levels:
@@ -1297,7 +1341,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 	max = max_below = 0;
 	min = min_above = 255;
 	/* Find closest level to level_current */
-	for (i = 2; i < device->brightness->count; i++) {
+	for (i = LVL_IDX_FIRST; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (abs(l - level_current) < abs(delta)) {
 			delta = l - level_current;
@@ -1307,7 +1351,7 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 	}
 	/* Ajust level_current to closest available level */
 	level_current += delta;
-	for (i = 2; i < device->brightness->count; i++) {
+	for (i = LVL_IDX_FIRST; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (l < min)
 			min = l;
@@ -1680,7 +1724,7 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_FIRMWARE;
-	props.max_brightness = device->brightness->count - 3;
+	props.max_brightness = device->brightness->count - LVL_IDX_FIRST - 1;
 	device->backlight = backlight_device_register(name,
 						      parent,
 						      device,
-- 
2.11.0

