From: Len Brown <lenb@kernel.org>
Subject: [PATCH 89/98] ACPI video: check the return value of
 acpi_video_device_lcd_set_level
Date: Sat, 28 Mar 2009 00:32:04 -0400
Message-ID: <24450c7add575cef53097738f16a4c1a720fa5cb.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22704 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbZC1Edu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:50 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700BZE8OAMXGQ@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:47 -0500 (CDT)
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
 drivers/acpi/video.c |   37 +++++++++++++++++++++----------------
 1 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index f0e6eb5..52f52b3 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -322,12 +322,12 @@ static int acpi_video_get_brightness(struct backlight_device *bd)
 
 static int acpi_video_set_brightness(struct backlight_device *bd)
 {
-	int request_level = bd->props.brightness+2;
+	int request_level = bd->props.brightness + 2;
 	struct acpi_video_device *vd =
 		(struct acpi_video_device *)bl_get_data(bd);
-	acpi_video_device_lcd_set_level(vd,
-					vd->brightness->levels[request_level]);
-	return 0;
+
+	return acpi_video_device_lcd_set_level(vd,
+				vd->brightness->levels[request_level]);
 }
 
 static struct backlight_ops acpi_backlight_ops = {
@@ -482,23 +482,29 @@ acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
 static int
 acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 {
-	int status = AE_OK;
+	int status;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 	int state;
 
-
 	arg0.integer.value = level;
 
-	if (device->cap._BCM)
-		status = acpi_evaluate_object(device->dev->handle, "_BCM",
-					      &args, NULL);
+	status = acpi_evaluate_object(device->dev->handle, "_BCM",
+				      &args, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Evaluating _BCM failed"));
+		return -EIO;
+	}
+
 	device->brightness->curr = level;
 	for (state = 2; state < device->brightness->count; state++)
-		if (level == device->brightness->levels[state])
+		if (level == device->brightness->levels[state]) {
 			device->backlight->props.brightness = state - 2;
+			return 0;
+		}
 
-	return status;
+	ACPI_ERROR((AE_INFO, "Current brightness invalid"));
+	return -EINVAL;
 }
 
 static int
@@ -1082,13 +1088,12 @@ acpi_video_device_write_brightness(struct file *file,
 	/* validate through the list of available levels */
 	for (i = 2; i < dev->brightness->count; i++)
 		if (level == dev->brightness->levels[i]) {
-			if (ACPI_SUCCESS
-			    (acpi_video_device_lcd_set_level(dev, level)))
-				dev->brightness->curr = level;
+			if (!acpi_video_device_lcd_set_level(dev, level))
+				return count;
 			break;
 		}
 
-	return count;
+	return -EINVAL;
 }
 
 static int acpi_video_device_EDID_seq_show(struct seq_file *seq, void *offset)
@@ -1786,7 +1791,7 @@ acpi_video_switch_brightness(struct acpi_video_device *device, int event)
 
 	level_next = acpi_video_get_next_level(device, level_current, event);
 
-	acpi_video_device_lcd_set_level(device, level_next);
+	result = acpi_video_device_lcd_set_level(device, level_next);
 
 out:
 	if (result)
-- 
1.6.0.6

