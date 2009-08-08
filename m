From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] ACPI: video - rename cdev to cooling_device
Date: Sat, 08 Aug 2009 00:26:31 -0700
Message-ID: <20090808075642.39D81526EC9@mailhub.coreip.homeip.net>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:39667 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbZHHH0d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Aug 2009 03:26:33 -0400
Received: by rv-out-0506.google.com with SMTP id f6so594921rvb.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Aug 2009 00:26:35 -0700 (PDT)
In-Reply-To: <20090808072150.2980.3863.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Cdev name is normally used for ether class devices or character
devices so rename member to avoid confusion for casual reader
of the code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/video.c |   61 +++++++++++++++++++++++++++-----------------------
 1 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 98ade4e..5407e0b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -198,7 +198,7 @@ struct acpi_video_device {
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
 	struct backlight_device *backlight;
-	struct thermal_cooling_device *cdev;
+	struct thermal_cooling_device *cooling_dev;
 	struct output_device *output_dev;
 };
 
@@ -387,47 +387,51 @@ static struct output_properties acpi_output_properties = {
 
 
 /* thermal cooling device callbacks */
-static int video_get_max_state(struct thermal_cooling_device *cdev, unsigned
-			       long *state)
+static int video_get_max_state(struct thermal_cooling_device *cooling_dev,
+				unsigned long *state)
 {
-	struct acpi_device *device = cdev->devdata;
+	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
 
 	*state = video->brightness->count - 3;
 	return 0;
 }
 
-static int video_get_cur_state(struct thermal_cooling_device *cdev, unsigned
-			       long *state)
+static int video_get_cur_state(struct thermal_cooling_device *cooling_dev,
+				unsigned long *state)
 {
-	struct acpi_device *device = cdev->devdata;
+	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device_brightness *brightness = video->brightness;
 	unsigned long long level;
 	int offset;
 
 	if (acpi_video_device_lcd_get_level_current(video, &level))
 		return -EINVAL;
-	for (offset = 2; offset < video->brightness->count; offset++)
-		if (level == video->brightness->levels[offset]) {
-			*state = video->brightness->count - offset - 1;
+
+	for (offset = 2; offset < brightness->count; offset++)
+		if (level == brightness->levels[offset]) {
+			*state = brightness->count - offset - 1;
 			return 0;
 		}
 
 	return -EINVAL;
 }
 
-static int
-video_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
+static int video_set_cur_state(struct thermal_cooling_device *cooling_dev,
+				unsigned long state)
 {
-	struct acpi_device *device = cdev->devdata;
+	struct acpi_device *device = cooling_dev->devdata;
 	struct acpi_video_device *video = acpi_driver_data(device);
+	struct acpi_video_device_brightness *brightness = video->brightness;
 	int level;
 
-	if ( state >= video->brightness->count - 2)
+	if (state >= brightness->count - 2)
 		return -EINVAL;
 
-	state = video->brightness->count - state;
-	level = video->brightness->levels[state -1];
+	state = brightness->count - state;
+	level = brightness->levels[state - 1];
+
 	return acpi_video_device_lcd_set_level(video, level);
 }
 
@@ -990,9 +994,10 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		if (result)
 			printk(KERN_ERR PREFIX "Create sysfs link\n");
 
-		device->cdev = thermal_cooling_device_register("LCD",
-					device->dev, &video_cooling_ops);
-		if (IS_ERR(device->cdev)) {
+		device->cooling_dev =
+			thermal_cooling_device_register("LCD", device->dev,
+							&video_cooling_ops);
+		if (IS_ERR(device->cooling_dev)) {
 			/*
 			 * Set cdev to NULL so we don't crash trying to
 			 * free it.
@@ -1001,22 +1006,22 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 			 * device registration failed?
 			 * -- dtor
 			 */
-			device->cdev = NULL;
+			device->cooling_dev = NULL;
 			return;
 		}
 
 		dev_info(&device->dev->dev, "registered as cooling_device%d\n",
-			 device->cdev->id);
+			 device->cooling_dev->id);
+
 		result = sysfs_create_link(&device->dev->dev.kobj,
-				&device->cdev->device.kobj,
+				&device->cooling_dev->device.kobj,
 				"thermal_cooling");
 		if (result)
 			printk(KERN_ERR PREFIX "Create sysfs link\n");
-		result = sysfs_create_link(&device->cdev->device.kobj,
+		result = sysfs_create_link(&device->cooling_dev->device.kobj,
 				&device->dev->dev.kobj, "device");
 		if (result)
 			printk(KERN_ERR PREFIX "Create sysfs link\n");
-
 	}
 
 	if (acpi_video_display_switch_support()) {
@@ -2020,13 +2025,13 @@ static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 		backlight_device_unregister(device->backlight);
 	}
 
-	if (device->cdev) {
+	if (device->cooling_dev) {
 		sysfs_remove_link(&device->dev->dev.kobj,
 				  "thermal_cooling");
-		sysfs_remove_link(&device->cdev->device.kobj,
+		sysfs_remove_link(&device->cooling_dev->device.kobj,
 				  "device");
-		thermal_cooling_device_unregister(device->cdev);
-		device->cdev = NULL;
+		thermal_cooling_device_unregister(device->cooling_dev);
+		device->cooling_dev = NULL;
 	}
 
 	video_output_unregister(device->output_dev);

