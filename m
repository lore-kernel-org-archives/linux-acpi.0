From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] ACPI video: Be more liberal in validating _BQC behaviour
Date: Tue, 16 Feb 2010 16:53:50 -0500
Message-ID: <1266357230-10602-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51832 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933384Ab0BPV4X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Feb 2010 16:56:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, Matthew Garrett <mjg@redhat.com>

Right now, if _BQC returns a value we don't understand we immediately
invalidate it. Change this behaviour so we only invalidate it if it
continues to give an invalid answer after we've already set a brightness.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/video.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b765790..ea314a2 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -327,7 +327,7 @@ static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
 			int level);
 static int acpi_video_device_lcd_get_level_current(
 			struct acpi_video_device *device,
-			unsigned long long *level);
+			unsigned long long *level, int init);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static int acpi_video_switch_brightness(struct acpi_video_device *device,
@@ -345,7 +345,7 @@ static int acpi_video_get_brightness(struct backlight_device *bd)
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
 
-	if (acpi_video_device_lcd_get_level_current(vd, &cur_level))
+	if (acpi_video_device_lcd_get_level_current(vd, &cur_level, 0))
 		return -EINVAL;
 	for (i = 2; i < vd->brightness->count; i++) {
 		if (vd->brightness->levels[i] == cur_level)
@@ -414,7 +414,7 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsig
 	unsigned long long level;
 	int offset;
 
-	if (acpi_video_device_lcd_get_level_current(video, &level))
+	if (acpi_video_device_lcd_get_level_current(video, &level, 0))
 		return -EINVAL;
 	for (offset = 2; offset < video->brightness->count; offset++)
 		if (level == video->brightness->levels[offset]) {
@@ -609,7 +609,7 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 
 static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
-					unsigned long long *level)
+					unsigned long long *level, int init)
 {
 	acpi_status status = AE_OK;
 	int i;
@@ -633,10 +633,16 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					device->brightness->curr = *level;
 					return 0;
 			}
-			/* BQC returned an invalid level. Stop using it.  */
-			ACPI_WARNING((AE_INFO, "%s returned an invalid level",
-						buf));
-			device->cap._BQC = device->cap._BCQ = 0;
+			if (!init) {
+				/*
+				 * BQC returned an invalid level.
+				 * Stop using it.
+				 */
+				ACPI_WARNING((AE_INFO,
+					      "%s returned an invalid level",
+					      buf));
+				device->cap._BQC = device->cap._BCQ = 0;
+			}
 		} else {
 			/* Fixme:
 			 * should we return an error or ignore this failure?
@@ -892,7 +898,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	if (!device->cap._BQC)
 		goto set_level;
 
-	result = acpi_video_device_lcd_get_level_current(device, &level_old);
+	result = acpi_video_device_lcd_get_level_current(device, &level_old, 1);
 	if (result)
 		goto out_free_levels;
 
@@ -903,7 +909,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	if (result)
 		goto out_free_levels;
 
-	result = acpi_video_device_lcd_get_level_current(device, &level);
+	result = acpi_video_device_lcd_get_level_current(device, &level, 0);
 	if (result)
 		goto out_free_levels;
 
@@ -1996,7 +2002,7 @@ acpi_video_switch_brightness(struct acpi_video_device *device, int event)
 		goto out;
 
 	result = acpi_video_device_lcd_get_level_current(device,
-							 &level_current);
+							 &level_current, 0);
 	if (result)
 		goto out;
 
-- 
1.6.6.1

