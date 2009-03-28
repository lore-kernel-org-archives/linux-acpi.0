From: Len Brown <lenb@kernel.org>
Subject: [PATCH 88/98] ACPI video: check the return value of
 acpi_video_device_lcd_get_level_current
Date: Sat, 28 Mar 2009 00:32:03 -0400
Message-ID: <c8890f903a6fdf5711726e8e8d65cb13423f8833.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22704 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbZC1Eds (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:48 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7008VW8O9Y36K@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:46 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   55 ++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bb5ed05..f0e6eb5 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -294,7 +294,7 @@ static int acpi_video_device_lcd_get_level_current(
 			unsigned long long *level);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
-static void acpi_video_switch_brightness(struct acpi_video_device *device,
+static int acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
 static int acpi_video_device_get_state(struct acpi_video_device *device,
 			    unsigned long long *state);
@@ -308,7 +308,9 @@ static int acpi_video_get_brightness(struct backlight_device *bd)
 	int i;
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
-	acpi_video_device_lcd_get_level_current(vd, &cur_level);
+
+	if (acpi_video_device_lcd_get_level_current(vd, &cur_level))
+		return -EINVAL;
 	for (i = 2; i < vd->brightness->count; i++) {
 		if (vd->brightness->levels[i] == cur_level)
 			/* The first two entries are special - see page 575
@@ -373,7 +375,8 @@ static int video_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
 	unsigned long long level;
 	int state;
 
-	acpi_video_device_lcd_get_level_current(video, &level);
+	if (acpi_video_device_lcd_get_level_current(video, &level))
+		return -EINVAL;
 	for (state = 2; state < video->brightness->count; state++)
 		if (level == video->brightness->levels[state])
 			return sprintf(buf, "%d\n",
@@ -502,11 +505,29 @@ static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long long *level)
 {
-	if (device->cap._BQC)
-		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
-					     level);
+	acpi_status status = AE_OK;
+
+	if (device->cap._BQC) {
+		status = acpi_evaluate_integer(device->dev->handle, "_BQC",
+						NULL, level);
+		if (ACPI_SUCCESS(status)) {
+			device->brightness->curr = *level;
+			return 0;
+		} else {
+			/* Fixme:
+			 * should we return an error or ignore this failure?
+			 * dev->brightness->curr is a cached value which stores
+			 * the correct current backlight level in most cases.
+			 * ACPI video backlight still works w/ buggy _BQC.
+			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
+			 */
+			ACPI_WARNING((AE_INFO, "Evaluating _BQC failed"));
+			device->cap._BQC = 0;
+		}
+	}
+
 	*level = device->brightness->curr;
-	return AE_OK;
+	return 0;
 }
 
 static int
@@ -1749,15 +1770,29 @@ acpi_video_get_next_level(struct acpi_video_device *device,
 	}
 }
 
-static void
+static int
 acpi_video_switch_brightness(struct acpi_video_device *device, int event)
 {
 	unsigned long long level_current, level_next;
+	int result = -EINVAL;
+
 	if (!device->brightness)
-		return;
-	acpi_video_device_lcd_get_level_current(device, &level_current);
+		goto out;
+
+	result = acpi_video_device_lcd_get_level_current(device,
+							 &level_current);
+	if (result)
+		goto out;
+
 	level_next = acpi_video_get_next_level(device, level_current, event);
+
 	acpi_video_device_lcd_set_level(device, level_next);
+
+out:
+	if (result)
+		printk(KERN_ERR PREFIX "Failed to switch the brightness\n");
+
+	return result;
 }
 
 static int
-- 
1.6.0.6

