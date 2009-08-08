From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] ACPI: video - cleanup video device registration
Date: Sat, 08 Aug 2009 00:26:36 -0700
Message-ID: <20090808075647.90344526EC9@mailhub.coreip.homeip.net>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:39667 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbZHHH0j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Aug 2009 03:26:39 -0400
Received: by rv-out-0506.google.com with SMTP id f6so594921rvb.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Aug 2009 00:26:40 -0700 (PDT)
In-Reply-To: <20090808072150.2980.3863.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Split sub-device (backlight, cooling, video output) registration into
separate functions, ensure that failure in one would not affect others,
don't crash when backlight registration fails.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/video.c |  418 +++++++++++++++++++++++++++-----------------------
 1 files changed, 224 insertions(+), 194 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 5407e0b..bc5082b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -362,6 +362,48 @@ static struct backlight_ops acpi_backlight_ops = {
 	.update_status  = acpi_video_set_brightness,
 };
 
+static int acpi_video_device_add_backlight(struct acpi_video_device *device)
+{
+	static unsigned int count;
+	struct backlight_device *backlight;
+	char backlight_name[16];
+	int error;
+
+	snprintf(backlight_name, sizeof(backlight_name),
+		 "acpi_video%u", count++);
+
+	backlight = backlight_device_register(backlight_name, NULL,
+						device, &acpi_backlight_ops);
+	if (IS_ERR(backlight)) {
+		error = PTR_ERR(backlight);
+		printk(KERN_ERR PREFIX
+			"Failed to create backlight device, error: %d\n",
+			error);
+		return error;
+	}
+
+	backlight->props.max_brightness = device->brightness->count - 3;
+
+	error = sysfs_create_link(&backlight->dev.kobj,
+				  &device->dev->dev.kobj, "device");
+	if (error)
+		printk(KERN_ERR PREFIX
+			"Failed to create 'device' sysfs link for "
+			"backlight device, error: %d\n", error);
+
+	device->backlight = backlight;
+	return 0;
+}
+
+static void acpi_video_device_remove_backlight(struct acpi_video_device *device)
+{
+	if (device->backlight) {
+		sysfs_remove_link(&device->backlight->dev.kobj, "device");
+		backlight_device_unregister(device->backlight);
+		device->backlight = NULL;
+	}
+}
+
 /*video output device sysfs support*/
 static int acpi_video_output_get(struct output_device *od)
 {
@@ -385,6 +427,40 @@ static struct output_properties acpi_output_properties = {
 	.get_status = acpi_video_output_get,
 };
 
+static int acpi_video_device_add_output_dev(struct acpi_video_device *device)
+{
+	static unsigned int count;
+	struct output_device *output_dev;
+	char name[16];
+	int error;
+
+	if (!(device->cap._DCS && device->cap._DSS))
+		return -ENODEV;
+
+	snprintf(name, sizeof(name), "acpi_video%u", count++);
+
+	output_dev = video_output_register(name, NULL, device,
+					   &acpi_output_properties);
+	if (IS_ERR(output_dev)) {
+		error = PTR_ERR(output_dev);
+		printk(KERN_ERR PREFIX
+			"Failed to create video output device, error: %d\n",
+			error);
+		return error;
+	}
+
+	device->output_dev = output_dev;
+	return 0;
+}
+
+static void
+acpi_video_device_remove_output_dev(struct acpi_video_device *device)
+{
+	if (device->output_dev) {
+		video_output_unregister(device->output_dev);
+		device->output_dev = NULL;
+	}
+}
 
 /* thermal cooling device callbacks */
 static int video_get_max_state(struct thermal_cooling_device *cooling_dev,
@@ -441,6 +517,60 @@ static struct thermal_cooling_device_ops video_cooling_ops = {
 	.set_cur_state = video_set_cur_state,
 };
 
+static int acpi_video_device_add_cooling_dev(struct acpi_video_device *device)
+{
+	static unsigned int count;
+	struct thermal_cooling_device *cooling_dev;
+	char name[8];
+	int error;
+
+	snprintf(name, sizeof(name), "LCD%u", count++);
+
+	cooling_dev = thermal_cooling_device_register(name,
+					device->dev, &video_cooling_ops);
+	if (IS_ERR(cooling_dev)) {
+		error = PTR_ERR(cooling_dev);
+		printk(KERN_ERR PREFIX
+			"Failed to create cooling device, error: %d\n",
+			error);
+		return error;
+	}
+
+	error = sysfs_create_link(&device->dev->dev.kobj,
+				   &cooling_dev->device.kobj,
+				   "thermal_cooling");
+	if (error)
+		printk(KERN_ERR PREFIX
+			"Failed to create 'thermal_cooling' sysfs link to "
+			"cooling device, error: %d\n", error);
+
+	error = sysfs_create_link(&cooling_dev->device.kobj,
+				  &device->dev->dev.kobj, "device");
+	if (error)
+		printk(KERN_ERR PREFIX
+			"Failed to create 'device' sysfs link for "
+			"cooling device, error: %d\n", error);
+
+	device->cooling_dev = cooling_dev;
+	dev_info(&device->dev->dev, "registered as cooling_device%d\n",
+		 cooling_dev->id);
+
+	return 0;
+}
+
+static void
+acpi_video_device_remove_cooling_dev(struct acpi_video_device *device)
+{
+	if (device->cooling_dev) {
+		sysfs_remove_link(&device->dev->dev.kobj,
+				  "thermal_cooling");
+		sysfs_remove_link(&device->cooling_dev->device.kobj,
+				  "device");
+		thermal_cooling_device_unregister(device->cooling_dev);
+		device->cooling_dev = NULL;
+	}
+}
+
 /* --------------------------------------------------------------------------
                                Video Management
    -------------------------------------------------------------------------- */
@@ -774,8 +904,8 @@ acpi_video_cmp_level(const void *a, const void *b)
 }
 
 /*
- *  Arg:	
- *  	device	: video output device (LCD, CRT, ..)
+ *  Arg:
+ *	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
  *	Maximum brightness level
@@ -783,8 +913,7 @@ acpi_video_cmp_level(const void *a, const void *b)
  *  Allocate and initialize device->brightness.
  */
 
-static int
-acpi_video_init_brightness(struct acpi_video_device *device)
+static int acpi_video_init_brightness(struct acpi_video_device *device)
 {
 	union acpi_object *obj = NULL;
 	int i, max_level = 0, count = 0, level_ac_battery = 0;
@@ -923,6 +1052,15 @@ out:
 	return result;
 }
 
+static void acpi_video_free_brightness_data(struct acpi_video_device *device)
+{
+	if (device->brightness) {
+		kfree(device->brightness->levels);
+		kfree(device->brightness);
+		device->brightness = NULL;
+	}
+}
+
 /*
  *  Arg:
  *	device	: video output device (LCD, CRT, ..)
@@ -970,74 +1108,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DSS", &h_dummy1))) {
 		device->cap._DSS = 1;
 	}
-
-	if (acpi_video_backlight_support()) {
-		int result;
-		static int count = 0;
-		char *name;
-
-		result = acpi_video_init_brightness(device);
-		if (result)
-			return;
-		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
-		if (!name)
-			return;
-
-		sprintf(name, "acpi_video%d", count++);
-		device->backlight = backlight_device_register(name,
-			NULL, device, &acpi_backlight_ops);
-		device->backlight->props.max_brightness = device->brightness->count-3;
-		kfree(name);
-
-		result = sysfs_create_link(&device->backlight->dev.kobj,
-					   &device->dev->dev.kobj, "device");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-
-		device->cooling_dev =
-			thermal_cooling_device_register("LCD", device->dev,
-							&video_cooling_ops);
-		if (IS_ERR(device->cooling_dev)) {
-			/*
-			 * Set cdev to NULL so we don't crash trying to
-			 * free it.
-			 * Also, why the hell we are returnign early and
-			 * not attempt to register video output if cooling
-			 * device registration failed?
-			 * -- dtor
-			 */
-			device->cooling_dev = NULL;
-			return;
-		}
-
-		dev_info(&device->dev->dev, "registered as cooling_device%d\n",
-			 device->cooling_dev->id);
-
-		result = sysfs_create_link(&device->dev->dev.kobj,
-				&device->cooling_dev->device.kobj,
-				"thermal_cooling");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-		result = sysfs_create_link(&device->cooling_dev->device.kobj,
-				&device->dev->dev.kobj, "device");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-	}
-
-	if (acpi_video_display_switch_support()) {
-
-		if (device->cap._DCS && device->cap._DSS) {
-			static int count;
-			char *name;
-			name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
-			if (!name)
-				return;
-			sprintf(name, "acpi_video%d", count++);
-			device->output_dev = video_output_register(name,
-					NULL, device, &acpi_output_properties);
-			kfree(name);
-		}
-	}
 }
 
 /*
@@ -1705,86 +1775,85 @@ acpi_video_get_device_attr(struct acpi_video_bus *video, unsigned long device_id
 	return NULL;
 }
 
-static int
-acpi_video_bus_get_one_device(struct acpi_device *device,
-			      struct acpi_video_bus *video)
+static int acpi_video_bus_add_device(struct acpi_device *device,
+				     unsigned long long device_id,
+				     struct acpi_video_bus *video)
 {
-	unsigned long long device_id;
-	int status;
 	struct acpi_video_device *data;
 	struct acpi_video_device_attrib* attribute;
+	int status;
 
-	if (!device || !video)
-		return -EINVAL;
-
-	status =
-	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
-	if (ACPI_SUCCESS(status)) {
-
-		data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
-		if (!data)
-			return -ENOMEM;
+	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-		strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
-		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
-		device->driver_data = data;
+	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	device->driver_data = data;
 
-		data->device_id = device_id;
-		data->video = video;
-		data->dev = device;
+	data->device_id = device_id;
+	data->video = video;
+	data->dev = device;
 
-		attribute = acpi_video_get_device_attr(video, device_id);
+	attribute = acpi_video_get_device_attr(video, device_id);
 
-		if((attribute != NULL) && attribute->device_id_scheme) {
-			switch (attribute->display_type) {
-			case ACPI_VIDEO_DISPLAY_CRT:
-				data->flags.crt = 1;
-				break;
-			case ACPI_VIDEO_DISPLAY_TV:
-				data->flags.tvout = 1;
-				break;
-			case ACPI_VIDEO_DISPLAY_DVI:
-				data->flags.dvi = 1;
-				break;
-			case ACPI_VIDEO_DISPLAY_LCD:
-				data->flags.lcd = 1;
-				break;
-			default:
-				data->flags.unknown = 1;
-				break;
-			}
-			if(attribute->bios_can_detect)
-				data->flags.bios = 1;
-		} else
+	if (attribute && attribute->device_id_scheme) {
+		switch (attribute->display_type) {
+		case ACPI_VIDEO_DISPLAY_CRT:
+			data->flags.crt = 1;
+			break;
+		case ACPI_VIDEO_DISPLAY_TV:
+			data->flags.tvout = 1;
+			break;
+		case ACPI_VIDEO_DISPLAY_DVI:
+			data->flags.dvi = 1;
+			break;
+		case ACPI_VIDEO_DISPLAY_LCD:
+			data->flags.lcd = 1;
+			break;
+		default:
 			data->flags.unknown = 1;
+			break;
+		}
+		if(attribute->bios_can_detect)
+			data->flags.bios = 1;
+	} else
+		data->flags.unknown = 1;
 
-		acpi_video_device_bind(video, data);
-		acpi_video_device_find_cap(data);
+	acpi_video_device_bind(video, data);
+	acpi_video_device_find_cap(data);
 
-		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY,
-						     acpi_video_device_notify,
-						     data);
-		if (ACPI_FAILURE(status)) {
-			printk(KERN_ERR PREFIX
-					  "Error installing notify handler\n");
-			if(data->brightness)
-				kfree(data->brightness->levels);
-			kfree(data->brightness);
-			kfree(data);
-			return -ENODEV;
-		}
+	if (acpi_video_backlight_support()) {
+		acpi_video_init_brightness(data);
+		acpi_video_device_add_backlight(data);
+		acpi_video_device_add_cooling_dev(data);
+	}
 
-		mutex_lock(&video->device_list_lock);
-		list_add_tail(&data->entry, &video->video_device_list);
-		mutex_unlock(&video->device_list_lock);
+	if (acpi_video_display_switch_support())
+		acpi_video_device_add_output_dev(data);
 
-		acpi_video_device_add_fs(device);
+	status = acpi_install_notify_handler(device->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_video_device_notify,
+					     data);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Error installing notify handler\n");
 
-		return 0;
+		acpi_video_device_remove_output_dev(data);
+		acpi_video_device_remove_cooling_dev(data);
+		acpi_video_device_remove_backlight(data);
+		acpi_video_free_brightness_data(data);
+		kfree(data);
+		return -ENODEV;
 	}
 
-	return -ENOENT;
+	acpi_video_device_add_fs(device);
+
+	mutex_lock(&video->device_list_lock);
+	list_add_tail(&data->entry, &video->video_device_list);
+	mutex_unlock(&video->device_list_lock);
+
+	return 0;
 }
 
 /*
@@ -1982,88 +2051,51 @@ out:
 	return result;
 }
 
-static int
+static void
 acpi_video_bus_get_devices(struct acpi_video_bus *video,
 			   struct acpi_device *device)
 {
-	int status = 0;
 	struct acpi_device *dev;
+	unsigned long long device_id;
+	int status;
 
 	acpi_video_device_enumerate(video);
 
 	list_for_each_entry(dev, &device->children, node) {
-
-		status = acpi_video_bus_get_one_device(dev, video);
-		if (ACPI_FAILURE(status)) {
-			printk(KERN_WARNING PREFIX
-					"Cant attach device");
-			continue;
-		}
+		status = acpi_evaluate_integer(device->handle, "_ADR", NULL,
+					&device_id);
+		if (ACPI_SUCCESS(status))
+			acpi_video_bus_add_device(dev, device_id, video);
 	}
-	return status;
 }
 
-static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
+static void acpi_video_bus_remove_device(struct acpi_video_device *device)
 {
-	acpi_status status;
-	struct acpi_video_bus *video;
-
-
-	if (!device || !device->video)
-		return -ENOENT;
-
-	video = device->video;
+	list_del(&device->entry);
 
 	acpi_video_device_remove_fs(device->dev);
 
-	status = acpi_remove_notify_handler(device->dev->handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_video_device_notify);
+	acpi_remove_notify_handler(device->dev->handle,
+				ACPI_DEVICE_NOTIFY, acpi_video_device_notify);
 
-	if (device->backlight) {
-		sysfs_remove_link(&device->backlight->dev.kobj, "device");
-		backlight_device_unregister(device->backlight);
-	}
+	acpi_video_device_remove_output_dev(device);
+	acpi_video_device_remove_cooling_dev(device);
+	acpi_video_device_remove_backlight(device);
+	acpi_video_free_brightness_data(device);
 
-	if (device->cooling_dev) {
-		sysfs_remove_link(&device->dev->dev.kobj,
-				  "thermal_cooling");
-		sysfs_remove_link(&device->cooling_dev->device.kobj,
-				  "device");
-		thermal_cooling_device_unregister(device->cooling_dev);
-		device->cooling_dev = NULL;
-	}
-
-	video_output_unregister(device->output_dev);
-
-	return 0;
+	kfree(device);
 }
 
-static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
+static void acpi_video_bus_put_devices(struct acpi_video_bus *video)
 {
-	int status;
 	struct acpi_video_device *dev, *next;
 
 	mutex_lock(&video->device_list_lock);
 
-	list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
-
-		status = acpi_video_bus_put_one_device(dev);
-		if (ACPI_FAILURE(status))
-			printk(KERN_WARNING PREFIX
-			       "hhuuhhuu bug in acpi video driver.\n");
-
-		if (dev->brightness) {
-			kfree(dev->brightness->levels);
-			kfree(dev->brightness);
-		}
-		list_del(&dev->entry);
-		kfree(dev);
-	}
+	list_for_each_entry_safe(dev, next, &video->video_device_list, entry)
+		acpi_video_bus_remove_device(dev);
 
 	mutex_unlock(&video->device_list_lock);
-
-	return 0;
 }
 
 /* acpi_video interface */
@@ -2129,8 +2161,6 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 	input_sync(input);
 	input_report_key(input, keycode, 0);
 	input_sync(input);
-
-	return;
 }
 
 static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)

