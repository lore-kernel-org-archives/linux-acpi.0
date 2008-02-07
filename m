From: Len Brown <lenb@kernel.org>
Subject: [PATCH 058/112] ACPI: register ACPI Video LCD as generic thermal cooling device
Date: Thu,  7 Feb 2008 04:34:20 -0500
Message-ID: <702ed512de9c8a67a69a981c73b7337c2131f198.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754814AbYBGJgM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:12 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Register ACPI video device as thermal cooling devices as they may be listed
in _TZD method and the backlight control can be used for throttling.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bd77e81..eab9c42 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -34,6 +34,7 @@
 #include <linux/seq_file.h>
 #include <linux/input.h>
 #include <linux/backlight.h>
+#include <linux/thermal.h>
 #include <linux/video_output.h>
 #include <asm/uaccess.h>
 
@@ -179,6 +180,7 @@ struct acpi_video_device {
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
 	struct backlight_device *backlight;
+	struct thermal_cooling_device *cdev;
 	struct output_device *output_dev;
 };
 
@@ -334,6 +336,54 @@ static struct output_properties acpi_output_properties = {
 	.set_state = acpi_video_output_set,
 	.get_status = acpi_video_output_get,
 };
+
+
+/* thermal cooling device callbacks */
+static int video_get_max_state(struct thermal_cooling_device *cdev, char *buf)
+{
+	struct acpi_device *device = cdev->devdata;
+	struct acpi_video_device *video = acpi_driver_data(device);
+
+	return sprintf(buf, "%d\n", video->brightness->count - 3);
+}
+
+static int video_get_cur_state(struct thermal_cooling_device *cdev, char *buf)
+{
+	struct acpi_device *device = cdev->devdata;
+	struct acpi_video_device *video = acpi_driver_data(device);
+	unsigned long level;
+	int state;
+
+	acpi_video_device_lcd_get_level_current(video, &level);
+	for (state = 2; state < video->brightness->count; state++)
+		if (level == video->brightness->levels[state])
+			return sprintf(buf, "%d\n",
+				       video->brightness->count - state - 1);
+
+	return -EINVAL;
+}
+
+static int
+video_set_cur_state(struct thermal_cooling_device *cdev, unsigned int state)
+{
+	struct acpi_device *device = cdev->devdata;
+	struct acpi_video_device *video = acpi_driver_data(device);
+	int level;
+
+	if ( state >= video->brightness->count - 2)
+		return -EINVAL;
+
+	state = video->brightness->count - state;
+	level = video->brightness->levels[state -1];
+	return acpi_video_device_lcd_set_level(video, level);
+}
+
+static struct thermal_cooling_device_ops video_cooling_ops = {
+	.get_max_state = video_get_max_state,
+	.get_cur_state = video_get_cur_state,
+	.set_cur_state = video_set_cur_state,
+};
+
 /* --------------------------------------------------------------------------
                                Video Management
    -------------------------------------------------------------------------- */
@@ -653,6 +703,7 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 
 	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
 		unsigned long tmp;
+		int result;
 		static int count = 0;
 		char *name;
 		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
@@ -666,8 +717,25 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		device->backlight->props.max_brightness = max_level;
 		device->backlight->props.brightness = (int)tmp;
 		backlight_update_status(device->backlight);
-
 		kfree(name);
+
+		device->cdev = thermal_cooling_device_register("LCD",
+					device->dev, &video_cooling_ops);
+		if (device->cdev) {
+			printk(KERN_INFO PREFIX
+				"%s is registered as cooling_device%d\n",
+				device->dev->dev.bus_id, device->cdev->id);
+			result = sysfs_create_link(&device->dev->dev.kobj,
+					  &device->cdev->device.kobj,
+					  "thermal_cooling");
+			if (result)
+				printk(KERN_ERR PREFIX "Create sysfs link\n");
+			result = sysfs_create_link(&device->cdev->device.kobj,
+					  &device->dev->dev.kobj,
+					  "device");
+                        if (result)
+				printk(KERN_ERR PREFIX "Create sysfs link\n");
+		}
 	}
 	if (device->cap._DCS && device->cap._DSS){
 		static int count = 0;
@@ -1729,6 +1797,14 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
 	backlight_device_unregister(device->backlight);
+	if (device->cdev) {
+		sysfs_remove_link(&device->dev->dev.kobj,
+				  "thermal_cooling");
+		sysfs_remove_link(&device->cdev->device.kobj,
+				  "device");
+		thermal_cooling_device_unregister(device->cdev);
+		device->cdev = NULL;
+	}
 	video_output_unregister(device->output_dev);
 
 	return 0;
-- 
1.5.4.23.gef5b9

