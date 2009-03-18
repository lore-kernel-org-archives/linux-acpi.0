From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 1/6] ACPI video: check the return value of
	acpi_video_device_lcd_get_level_current
Date: Wed, 18 Mar 2009 16:27:08 +0800
Message-ID: <1237364828.3826.57.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13213 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbZCRI0f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 04:26:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

Subject: check the return value of acpi_video_device_lcd_get_level_current
From: Zhang Rui <rui.zhang@intel.com>

check the return value of acpi_video_device_lcd_get_level_current

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/video.c |   55 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -294,7 +294,7 @@ static int acpi_video_device_lcd_get_lev
 			unsigned long long *level);
 static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
-static void acpi_video_switch_brightness(struct acpi_video_device *device,
+static int acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
 static int acpi_video_device_get_state(struct acpi_video_device *device,
 			    unsigned long long *state);
@@ -308,7 +308,9 @@ static int acpi_video_get_brightness(str
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
@@ -373,7 +375,8 @@ static int video_get_cur_state(struct th
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
@@ -1749,15 +1770,29 @@ acpi_video_get_next_level(struct acpi_vi
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


