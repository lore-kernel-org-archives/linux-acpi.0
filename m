From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] ACPI: video - cleanup video device registration
Date: Mon, 31 Aug 2009 23:30:54 -0700
Message-ID: <20090901070334.2388F526EA5@mailhub.coreip.homeip.net>
References: <20090808072150.2980.3863.stgit@localhost.localdomain> <20090808075647.90344526EC9@mailhub.coreip.homeip.net> <alpine.LFD.2.00.0908292310580.15619@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:42837 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbZIAGi3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Sep 2009 02:38:29 -0400
Received: by pzk5 with SMTP id 5so3547981pzk.21
        for <linux-acpi@vger.kernel.org>; Mon, 31 Aug 2009 23:38:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908292310580.15619@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Sat, Aug 29, 2009 at 11:24:35PM -0400, Len Brown wrote:
> Dmitry, Rui,
> Can you refresh this patch (and its follow-on) on top of the current 
> linux-acpi test branch?
> 
> I re-did patch #3 by hand since it was trivial, but I'd rather that
> you do this one and its follow-on for me.
> 

How about the one below? It has both patches folded together...

-- 
Dmitry

ACPI: video - cleanup video device registration

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Split sub-device (backlight, cooling, video output) registration into
separate functions, ensure that failure in one would not affect others,
don't crash when backlight registration fails. Also don't use 2 kzallocs
for brioghtness data when one will suffice.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/video.c |  518 ++++++++++++++++++++++++++------------------------
 1 files changed, 272 insertions(+), 246 deletions(-)


diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b51f1fe..2fd95fb 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -186,9 +186,9 @@ struct acpi_video_brightness_flags {
 
 struct acpi_video_device_brightness {
 	int curr;
-	int count;
-	int *levels;
 	struct acpi_video_brightness_flags flags;
+	int count;
+	int levels[0];
 };
 
 struct acpi_video_device {
@@ -364,6 +364,48 @@ static struct backlight_ops acpi_backlight_ops = {
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
@@ -387,6 +429,40 @@ static struct output_properties acpi_output_properties = {
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
 static int video_get_max_state(struct thermal_cooling_device *cooling_dev, unsigned
@@ -439,6 +515,60 @@ static struct thermal_cooling_device_ops video_cooling_ops = {
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
@@ -780,8 +910,8 @@ acpi_video_cmp_level(const void *a, const void *b)
 }
 
 /*
- *  Arg:	
- *  	device	: video output device (LCD, CRT, ..)
+ *  Arg:
+ *	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
  *	Maximum brightness level
@@ -789,8 +919,7 @@ acpi_video_cmp_level(const void *a, const void *b)
  *  Allocate and initialize device->brightness.
  */
 
-static int
-acpi_video_init_brightness(struct acpi_video_device *device)
+static int acpi_video_init_brightness(struct acpi_video_device *device)
 {
 	union acpi_object *obj = NULL;
 	int i, max_level = 0, count = 0, level_ac_battery = 0;
@@ -800,32 +929,27 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	int result = -EINVAL;
 
 	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
-						"LCD brightness level\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Could not query available LCD brightness levels\n"));
 		goto out;
 	}
 
 	if (obj->package.count < 2)
 		goto out;
 
-	br = kzalloc(sizeof(*br), GFP_KERNEL);
+	br = kzalloc(sizeof(*br) +
+		     (obj->package.count + 2) * sizeof(br->levels[0]),
+		     GFP_KERNEL);
 	if (!br) {
-		printk(KERN_ERR "can't allocate memory\n");
+		printk(KERN_ERR PREFIX "can't allocate memory\n");
 		result = -ENOMEM;
 		goto out;
 	}
 
-	br->levels = kmalloc((obj->package.count + 2) * sizeof *(br->levels),
-				GFP_KERNEL);
-	if (!br->levels) {
-		result = -ENOMEM;
-		goto out_free;
-	}
-
 	for (i = 0; i < obj->package.count; i++) {
 		o = (union acpi_object *)&obj->package.elements[i];
 		if (o->type != ACPI_TYPE_INTEGER) {
-			printk(KERN_ERR PREFIX "Invalid data\n");
+			printk(KERN_ERR PREFIX "Invalid brightness data\n");
 			continue;
 		}
 		br->levels[count] = (u32) o->integer.value;
@@ -882,69 +1006,75 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
 	br->curr = level = max_level;
 
-	if (!device->cap._BQC)
-		goto set_level;
+	if (device->cap._BQC) {
+		result = acpi_video_device_lcd_get_level_current(device,
+								 &level_old);
+		if (result)
+			goto out;
 
-	result = acpi_video_device_lcd_get_level_current(device, &level_old);
-	if (result)
-		goto out_free_levels;
+		/*
+		 * Set the level to maximum and check if _BQC uses
+		 * indexed value
+		 */
+		result = acpi_video_device_lcd_set_level(device, max_level);
+		if (result)
+			goto out;
 
-	/*
-	 * Set the level to maximum and check if _BQC uses indexed value
-	 */
-	result = acpi_video_device_lcd_set_level(device, max_level);
-	if (result)
-		goto out_free_levels;
+		result = acpi_video_device_lcd_get_level_current(device,
+								 &level);
+		if (result)
+			goto out;
 
-	result = acpi_video_device_lcd_get_level_current(device, &level);
-	if (result)
-		goto out_free_levels;
+		br->flags._BQC_use_index = (level == max_level ? 0 : 1);
 
-	br->flags._BQC_use_index = (level == max_level ? 0 : 1);
+		if (br->flags._BQC_use_index) {
+			if (br->flags._BCL_reversed)
+				level_old = (br->count - 1) - level_old;
+			level = br->levels[level_old];
+		} else {
+			/*
+			 * Set the backlight to the initial state.
+			 * On some buggy laptops, _BQC returns an
+			 * uninitialized value when invoked for the
+			 * first time, i.e. level_old is invalid.
+			 * Set the backlight to max_level in this case.
+			 */
+			for (i = 2; i < br->count; i++)
+				if (level_old == br->levels[i])
+					level = level_old;
 
-	if (!br->flags._BQC_use_index) {
-		/*
-		 * Set the backlight to the initial state.
-		 * On some buggy laptops, _BQC returns an uninitialized value
-		 * when invoked for the first time, i.e. level_old is invalid.
-		 * set the backlight to max_level in this case
-		 */
-		for (i = 2; i < br->count; i++)
-			if (level_old == br->levels[i])
-				level = level_old;
-		goto set_level;
+		}
 	}
 
-	if (br->flags._BCL_reversed)
-		level_old = (br->count - 1) - level_old;
-	level = br->levels[level_old];
-
-set_level:
 	result = acpi_video_device_lcd_set_level(device, level);
 	if (result)
-		goto out_free_levels;
+		goto out;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "found %d brightness levels\n", count - 2));
-	kfree(obj);
-	return result;
 
-out_free_levels:
-	kfree(br->levels);
-out_free:
-	kfree(br);
 out:
-	device->brightness = NULL;
+	if (result) {
+		kfree(br);
+		device->brightness = NULL;
+	}
+
 	kfree(obj);
 	return result;
 }
 
+static void acpi_video_free_brightness_data(struct acpi_video_device *device)
+{
+	kfree(device->brightness);
+	device->brightness = NULL;
+}
+
 /*
  *  Arg:
  *	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
- *  	None
+ *	None
  *
  *  Find out all required AML methods defined under the output
  *  device.
@@ -983,73 +1113,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
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
-		device->cooling_dev = thermal_cooling_device_register("LCD",
-					device->dev, &video_cooling_ops);
-		if (IS_ERR(device->cooling_dev)) {
-			/*
-			 * Set cooling_dev to NULL so we don't crash trying to
-			 * free it.
-			 * Also, why the hell we are returning early and
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
-		result = sysfs_create_link(&device->dev->dev.kobj,
-				&device->cooling_dev->device.kobj,
-				"thermal_cooling");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-		result = sysfs_create_link(&device->cooling_dev->device.kobj,
-				&device->dev->dev.kobj, "device");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-
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
@@ -1716,86 +1779,86 @@ acpi_video_get_device_attr(struct acpi_video_bus *video, unsigned long device_id
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
+	if (acpi_video_backlight_support()) {
+		if (acpi_video_init_brightness(data) == 0) {
+			acpi_video_device_add_backlight(data);
+			acpi_video_device_add_cooling_dev(data);
 		}
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
@@ -1993,86 +2056,51 @@ out:
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
-	if (device->backlight) {
-		sysfs_remove_link(&device->backlight->dev.kobj, "device");
-		backlight_device_unregister(device->backlight);
-		device->backlight = NULL;
-	}
-	if (device->cooling_dev) {
-		sysfs_remove_link(&device->dev->dev.kobj,
-				  "thermal_cooling");
-		sysfs_remove_link(&device->cooling_dev->device.kobj,
-				  "device");
-		thermal_cooling_device_unregister(device->cooling_dev);
-		device->cooling_dev = NULL;
-	}
-	video_output_unregister(device->output_dev);
+	acpi_remove_notify_handler(device->dev->handle,
+				ACPI_DEVICE_NOTIFY, acpi_video_device_notify);
 
-	return 0;
+	acpi_video_device_remove_output_dev(device);
+	acpi_video_device_remove_cooling_dev(device);
+	acpi_video_device_remove_backlight(device);
+	acpi_video_free_brightness_data(device);
+
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
@@ -2138,8 +2166,6 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 	input_sync(input);
 	input_report_key(input, keycode, 0);
 	input_sync(input);
-
-	return;
 }
 
 static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
@@ -2270,7 +2296,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	if (!strcmp(device->pnp.bus_id, "VID")) {
 		if (instance)
 			device->pnp.bus_id[3] = '0' + instance;
-		instance ++;
+		instance++;
 	}
 	/* a hack to fix the duplicate name "VGA" problem on Pa 3553 */
 	if (!strcmp(device->pnp.bus_id, "VGA")) {
