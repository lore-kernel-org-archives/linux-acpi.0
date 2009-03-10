From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 5/5] ACPI video: support _BQC/_BCL/_BCM methods that
	use index values
Date: Tue, 10 Mar 2009 16:03:34 +0800
Message-ID: <1236672214.2820.123.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62525 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbZCJICn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 04:02:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>

Subject: support _BQC/_BCL/_BCM methods that use index values
From: Zhang Rui <rui.zhang@intel.com>

The input/output of _BQC/_BCL/_BCM control methods should be represented
by a number between 0 and 100, and can be thought of as a percentage.
But some buggy _BQC/_BCL/_BCM methods use the index values instead.
http://bugzilla.kernel.org/show_bug.cgi?id=12302
http://bugzilla.kernel.org/show_bug.cgi?id=12249
http://bugzilla.kernel.org/show_bug.cgi?id=12037

Add the functionality to support such kind of BIOSes in ACPI video driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

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
@@ -689,6 +700,7 @@ acpi_video_init_brightness(struct acpi_v
 {
 	union acpi_object *obj = NULL;
 	int i, max_level = 0, count = 0, level_ac_battery = 0;
+	unsigned long long level;
 	union acpi_object *o;
 	struct acpi_video_device_brightness *br = NULL;
 
@@ -760,6 +772,38 @@ acpi_video_init_brightness(struct acpi_v
 
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
+	if (acpi_video_device_lcd_set_level(device, max_level))
+		goto out_free_levels;
+
+	if (acpi_video_device_lcd_get_level_current(device, &level))
+		goto out_free_levels;
+
+	if ((level != max_level) && !br->flags._BCM_use_index) {
+		if (level_ac_battery != 2) {
+			/*
+			 * For now, we don't support the _BCL like this:
+			 * 16, 15, 0, 1, 2, 3, ..., 14, 15, 16
+			 * because we may mess up the index returned by _BQC.
+			 * Plus: we have not got a box like this.
+			 */
+			ACPI_ERROR((AE_INFO, "_BCL not supported\n"));
+			goto out_free_levels;
+		}
+		br->flags._BQC_use_index = 1;
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "found %d brightness levels\n", count - 2));
 	kfree(obj);


