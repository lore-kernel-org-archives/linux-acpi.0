From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/34] ACPI video: Be more liberal in validating _BQC behaviour
Date: Sun, 14 Mar 2010 21:40:54 -0400
Message-ID: <70287db87cfc968fe78bf82a489833cc77b84352.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:42593 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab0COB4i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:56:38 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA0063UW2BW4X2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:56:36 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

Right now, if _BQC returns a value we don't understand we immediately
invalidate it. Change this behaviour so we only invalidate it if it
continues to give an invalid answer after we've already set a brightness.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.0.2.201.g80978

