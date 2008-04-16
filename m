From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 6/7] Initialize brightness and display switching in
	separate functions
Date: Wed, 16 Apr 2008 21:02:15 +0200
Message-ID: <1208372535.1784.351.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41514 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbYDPTCQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 15:02:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

Initialize brightness and display switching in separate functions

Should be no functional change.
Also rename the ambiguous, multiple times declared "count" variable

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/video.c |  224 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 124 insertions(+), 100 deletions(-)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/video.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/video.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/video.c
@@ -619,8 +619,129 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	return status;
 }
 
+static int
+acpi_video_init_brightness(struct acpi_video_device *device)
+{
+	u32 max_level = 0;
+	union acpi_object *obj = NULL;
+	struct acpi_video_device_brightness *br = NULL;
+	int result;
+	char *name;
+	int i;
+	static int dev_count;
+
+	if (!device->cap._BCL || !device->cap._BCM)
+		return -ENODEV;
+
+	if (ACPI_FAILURE(acpi_video_device_lcd_query_levels(device,
+							    &obj))) {
+		kfree(obj);
+		return -ENODEV;
+	}
+
+	if (obj->package.count >= 2) {
+		int count = 0;
+		union acpi_object *o;
+
+		br = kzalloc(sizeof(*br), GFP_KERNEL);
+		if (!br) {
+			printk(KERN_ERR "can't allocate memory\n");
+			return -ENOMEM;
+		} else {
+			br->levels = kmalloc(obj->package.count *
+					     sizeof *(br->levels), GFP_KERNEL);
+			if (!br->levels)
+				goto out;
+
+			for (i = 0; i < obj->package.count; i++) {
+				o = (union acpi_object *)&obj->package.
+					elements[i];
+				if (o->type != ACPI_TYPE_INTEGER) {
+					printk(KERN_ERR PREFIX
+					       "Invalid data\n");
+					continue;
+				}
+				br->levels[count] = (u32) o->integer.value;
+
+				if (br->levels[count] > max_level)
+					max_level = br->levels[count];
+				count++;
+			}
+out:
+			if (count < 2) {
+				kfree(br->levels);
+				kfree(br);
+				return -ENODEV;
+			} else {
+				br->count = count;
+				device->brightness = br;
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "found %d "
+						  "brightness levels\n",
+						  count));
+			}
+		}
+		kfree(obj);
+		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+
+		sprintf(name, "acpi_video%d", dev_count++);
+		device->backlight = backlight_device_register(name,
+				      NULL, device, &acpi_backlight_ops);
+		device->backlight->props.max_brightness =
+			device->brightness->count-3;
+		device->backlight->props.brightness =
+			acpi_video_get_brightness(device->backlight);
+		backlight_update_status(device->backlight);
+		kfree(name);
+
+		device->cdev = thermal_cooling_device_register("LCD",
+					       device->dev, &video_cooling_ops);
+		if (IS_ERR(device->cdev))
+			return -ENODEV;
+
+		printk(KERN_INFO PREFIX
+		       "%s is registered as cooling_device%d\n",
+		       device->dev->dev.bus_id, device->cdev->id);
+		result = sysfs_create_link(&device->dev->dev.kobj,
+					   &device->cdev->device.kobj,
+					   "thermal_cooling");
+		if (result) {
+			printk(KERN_ERR PREFIX "Create sysfs link\n");
+			return -ENODEV;
+		}
+		result = sysfs_create_link(&device->cdev->device.kobj,
+					   &device->dev->dev.kobj,
+					   "device");
+		if (result) {
+			printk(KERN_ERR PREFIX "Create sysfs link\n");
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+static int
+acpi_video_init_display_switching(struct acpi_video_device *device)
+{
+	char *name;
+	static int dev_count;
+
+	if (!device->cap._DCS || !device->cap._DSS)
+		return -ENODEV;
+
+	name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+	sprintf(name, "acpi_video%d", dev_count++);
+	device->output_dev = video_output_register(name,
+				   NULL, device, &acpi_output_properties);
+	kfree(name);
+	return 0;
+}
+
 /*
- *  Arg:	
+ *  Arg:
  *  	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
@@ -633,11 +754,6 @@ acpi_video_bus_DOS(struct acpi_video_bus
 static void acpi_video_device_find_cap(struct acpi_video_device *device)
 {
 	acpi_handle h_dummy1;
-	int i;
-	u32 max_level = 0;
-	union acpi_object *obj = NULL;
-	struct acpi_video_device_brightness *br = NULL;
-
 
 	memset(&device->cap, 0, sizeof(device->cap));
 
@@ -665,100 +781,8 @@ static void acpi_video_device_find_cap(s
 		device->cap._DSS = 1;
 	}
 
-	if (ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
-
-		if (obj->package.count >= 2) {
-			int count = 0;
-			union acpi_object *o;
-
-			br = kzalloc(sizeof(*br), GFP_KERNEL);
-			if (!br) {
-				printk(KERN_ERR "can't allocate memory\n");
-			} else {
-				br->levels = kmalloc(obj->package.count *
-						     sizeof *(br->levels), GFP_KERNEL);
-				if (!br->levels)
-					goto out;
-
-				for (i = 0; i < obj->package.count; i++) {
-					o = (union acpi_object *)&obj->package.
-					    elements[i];
-					if (o->type != ACPI_TYPE_INTEGER) {
-						printk(KERN_ERR PREFIX "Invalid data\n");
-						continue;
-					}
-					br->levels[count] = (u32) o->integer.value;
-
-					if (br->levels[count] > max_level)
-						max_level = br->levels[count];
-					count++;
-				}
-			      out:
-				if (count < 2) {
-					kfree(br->levels);
-					kfree(br);
-				} else {
-					br->count = count;
-					device->brightness = br;
-					ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-							  "found %d brightness levels\n",
-							  count));
-				}
-			}
-		}
-
-	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available LCD brightness level\n"));
-	}
-
-	kfree(obj);
-
-	if (device->cap._BCL && device->cap._BCM && max_level > 0) {
-		int result;
-		static int count = 0;
-		char *name;
-		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
-		if (!name)
-			return;
-
-		sprintf(name, "acpi_video%d", count++);
-		device->backlight = backlight_device_register(name,
-			NULL, device, &acpi_backlight_ops);
-		device->backlight->props.max_brightness = device->brightness->count-3;
-		device->backlight->props.brightness = acpi_video_get_brightness(device->backlight);
-		backlight_update_status(device->backlight);
-		kfree(name);
-
-		device->cdev = thermal_cooling_device_register("LCD",
-					device->dev, &video_cooling_ops);
-		if (IS_ERR(device->cdev))
-			return;
-
-		printk(KERN_INFO PREFIX
-			"%s is registered as cooling_device%d\n",
-			device->dev->dev.bus_id, device->cdev->id);
-		result = sysfs_create_link(&device->dev->dev.kobj,
-				  &device->cdev->device.kobj,
-				  "thermal_cooling");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-		result = sysfs_create_link(&device->cdev->device.kobj,
-				  &device->dev->dev.kobj,
-				  "device");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-	}
-	if (device->cap._DCS && device->cap._DSS){
-		static int count = 0;
-		char *name;
-		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
-		if (!name)
-			return;
-		sprintf(name, "acpi_video%d", count++);
-		device->output_dev = video_output_register(name,
-				NULL, device, &acpi_output_properties);
-		kfree(name);
-	}
+	acpi_video_init_brightness(device);
+	acpi_video_init_display_switching(device);
 	return;
 }
 


