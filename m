From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 2/7] ACPI video: check the return value of
	acpi_video_device_lcd_set_level
Date: Thu, 12 Mar 2009 16:57:01 +0800
Message-ID: <1236848221.2807.71.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:31138 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772AbZCLI4F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 04:56:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

check the return value of acpi_video_device_lcd_set_level.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/video.c |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -322,12 +322,12 @@ static int acpi_video_get_brightness(str
 
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
@@ -482,23 +482,29 @@ acpi_video_device_lcd_query_levels(struc
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
@@ -1082,13 +1088,12 @@ acpi_video_device_write_brightness(struc
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
@@ -1786,7 +1791,7 @@ acpi_video_switch_brightness(struct acpi
 
 	level_next = acpi_video_get_next_level(device, level_current, event);
 
-	acpi_video_device_lcd_set_level(device, level_next);
+	result = acpi_video_device_lcd_set_level(device, level_next);
 
 out:
 	if (result)


