From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [patch 7/8] ACPI: video - more cleanups
Date: Mon, 05 Nov 2007 11:43:35 -0500
Message-ID: <20071105165012.815613696@anvil.corenet.prv>
References: <20071105164328.982283020@anvil.corenet.prv>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:50738 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbXKEQwv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2007 11:52:51 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1080853nze
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 08:52:49 -0800 (PST)
Content-Disposition: inline; filename=acpi-video-cleanup.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

ACPI: video - more cleanups

Remove unneeded checks and initializations, implement proper
unwinding after errors in initialization code, get rid of
unneeded casts, adjust formatting.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/acpi/video.c |  778 +++++++++++++++++++++++++--------------------------
 1 file changed, 388 insertions(+), 390 deletions(-)

Index: work/drivers/acpi/video.c
===================================================================
--- work.orig/drivers/acpi/video.c
+++ work/drivers/acpi/video.c
@@ -74,8 +74,8 @@ static int acpi_video_bus_add(struct acp
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
 
 static const struct acpi_device_id video_device_ids[] = {
-	{ACPI_VIDEO_HID, 0},
-	{"", 0},
+	{ ACPI_VIDEO_HID, 0 },
+	{ "", 0 },
 };
 MODULE_DEVICE_TABLE(acpi, video_device_ids);
 
@@ -86,7 +86,7 @@ static struct acpi_driver acpi_video_bus
 	.ops = {
 		.add = acpi_video_bus_add,
 		.remove = acpi_video_bus_remove,
-		},
+	},
 };
 
 struct acpi_video_bus_flags {
@@ -97,26 +97,28 @@ struct acpi_video_bus_flags {
 };
 
 struct acpi_video_bus_cap {
-	u8 _DOS:1;		/*Enable/Disable output switching */
-	u8 _DOD:1;		/*Enumerate all devices attached to display adapter */
-	u8 _ROM:1;		/*Get ROM Data */
-	u8 _GPD:1;		/*Get POST Device */
-	u8 _SPD:1;		/*Set POST Device */
-	u8 _VPO:1;		/*Video POST Options */
+	u8 _DOS:1;		/* Enable/Disable output switching */
+	u8 _DOD:1;		/* Enumerate all devices attached to
+				   display adapter */
+	u8 _ROM:1;		/* Get ROM Data */
+	u8 _GPD:1;		/* Get POST Device */
+	u8 _SPD:1;		/* Set POST Device */
+	u8 _VPO:1;		/* Video POST Options */
 	u8 reserved:2;
 };
 
 struct acpi_video_device_attrib {
 	u32 display_index:4;	/* A zero-based instance of the Display */
-	u32 display_port_attachment:4;	/*This field differentiates the display type */
-	u32 display_type:4;	/*Describe the specific type in use */
-	u32 vendor_specific:4;	/*Chipset Vendor Specific */
-	u32 bios_can_detect:1;	/*BIOS can detect the device */
-	u32 depend_on_vga:1;	/*Non-VGA output device whose power is related to 
-				   the VGA device. */
-	u32 pipe_id:3;		/*For VGA multiple-head devices. */
-	u32 reserved:10;	/*Must be 0 */
-	u32 device_id_scheme:1;	/*Device ID Scheme */
+	u32 display_port_attachment:4;	/* This field differentiates the
+					   display type */
+	u32 display_type:4;	/* Describe the specific type in use */
+	u32 vendor_specific:4;	/* Chipset Vendor Specific */
+	u32 bios_can_detect:1;	/* BIOS can detect the device */
+	u32 depend_on_vga:1;	/* Non-VGA output device whose power is
+				   related to the VGA device. */
+	u32 pipe_id:3;		/* For VGA multiple-head devices. */
+	u32 reserved:10;	/* Must be 0 */
+	u32 device_id_scheme:1;	/* Device ID Scheme */
 };
 
 struct acpi_video_enumerated_device {
@@ -284,24 +286,27 @@ static void acpi_video_switch_brightness
 static int acpi_video_device_get_state(struct acpi_video_device *device,
 			    unsigned long *state);
 static int acpi_video_output_get(struct output_device *od);
-static int acpi_video_device_set_state(struct acpi_video_device *device, int state);
+static int acpi_video_device_set_state(struct acpi_video_device *device,
+					int state);
 
 /*backlight device sysfs support*/
 static int acpi_video_get_brightness(struct backlight_device *bd)
 {
+	struct acpi_video_device *vd = bl_get_data(bd);
 	unsigned long cur_level;
-	struct acpi_video_device *vd =
-		(struct acpi_video_device *)bl_get_data(bd);
+
 	acpi_video_device_lcd_get_level_current(vd, &cur_level);
+
 	return (int) cur_level;
 }
 
 static int acpi_video_set_brightness(struct backlight_device *bd)
 {
 	int request_level = bd->props.brightness;
-	struct acpi_video_device *vd =
-		(struct acpi_video_device *)bl_get_data(bd);
+	struct acpi_video_device *vd = bl_get_data(bd);
+
 	acpi_video_device_lcd_set_level(vd, request_level);
+
 	return 0;
 }
 
@@ -314,17 +319,18 @@ static struct backlight_ops acpi_backlig
 static int acpi_video_output_get(struct output_device *od)
 {
 	unsigned long state;
-	struct acpi_video_device *vd =
-		(struct acpi_video_device *)dev_get_drvdata(&od->dev);
+	struct acpi_video_device *vd = dev_get_drvdata(&od->dev);
+
 	acpi_video_device_get_state(vd, &state);
+
 	return (int)state;
 }
 
 static int acpi_video_output_set(struct output_device *od)
 {
 	unsigned long state = od->request_state;
-	struct acpi_video_device *vd=
-		(struct acpi_video_device *)dev_get_drvdata(&od->dev);
+	struct acpi_video_device *vd = dev_get_drvdata(&od->dev);
+
 	return acpi_video_device_set_state(vd, state);
 }
 
@@ -341,37 +347,25 @@ static struct output_properties acpi_out
 static int
 acpi_video_device_query(struct acpi_video_device *device, unsigned long *state)
 {
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_DGS", NULL, state);
-
-	return status;
+	return acpi_evaluate_integer(device->dev->handle, "_DGS", NULL, state);
 }
 
 static int
 acpi_video_device_get_state(struct acpi_video_device *device,
 			    unsigned long *state)
 {
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_DCS", NULL, state);
-
-	return status;
+	return acpi_evaluate_integer(device->dev->handle, "_DCS", NULL, state);
 }
 
 static int
 acpi_video_device_set_state(struct acpi_video_device *device, int state)
 {
-	int status;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 	unsigned long ret;
 
-
 	arg0.integer.value = state;
-	status = acpi_evaluate_integer(device->dev->handle, "_DSS", &args, &ret);
-
-	return status;
+	return acpi_evaluate_integer(device->dev->handle, "_DSS", &args, &ret);
 }
 
 static int
@@ -382,26 +376,25 @@ acpi_video_device_lcd_query_levels(struc
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 
-
 	*levels = NULL;
 
-	status = acpi_evaluate_object(device->dev->handle, "_BCL", NULL, &buffer);
+	status = acpi_evaluate_object(device->dev->handle, "_BCL",
+					NULL, &buffer);
 	if (!ACPI_SUCCESS(status))
 		return status;
+
 	obj = (union acpi_object *)buffer.pointer;
-	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
 		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
 		status = -EFAULT;
 		goto err;
 	}
 
 	*levels = obj;
-
 	return 0;
 
-      err:
+ err:
 	kfree(buffer.pointer);
-
 	return status;
 }
 
@@ -412,7 +405,6 @@ acpi_video_device_lcd_set_level(struct a
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
-
 	arg0.integer.value = level;
 
 	if (device->cap._BCM)
@@ -443,11 +435,11 @@ acpi_video_device_EDID(struct acpi_video
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
-
 	*edid = NULL;
 
 	if (!device)
 		return -ENODEV;
+
 	if (length == 128)
 		arg0.integer.value = 1;
 	else if (length == 256)
@@ -455,7 +447,8 @@ acpi_video_device_EDID(struct acpi_video
 	else
 		return -EINVAL;
 
-	status = acpi_evaluate_object(device->dev->handle, "_DDC", &args, &buffer);
+	status = acpi_evaluate_object(device->dev->handle, "_DDC", &args,
+					&buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -482,12 +475,12 @@ acpi_video_bus_set_POST(struct acpi_vide
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
-
 	arg0.integer.value = option;
 
-	status = acpi_evaluate_integer(video->device->handle, "_SPD", &args, &tmp);
+	status = acpi_evaluate_integer(video->device->handle, "_SPD", &args,
+					&tmp);
 	if (ACPI_SUCCESS(status))
-		status = tmp ? (-EINVAL) : (AE_OK);
+		status = tmp ? -EINVAL : AE_OK;
 
 	return status;
 }
@@ -495,11 +488,7 @@ acpi_video_bus_set_POST(struct acpi_vide
 static int
 acpi_video_bus_get_POST(struct acpi_video_bus *video, unsigned long *id)
 {
-	int status;
-
-	status = acpi_evaluate_integer(video->device->handle, "_GPD", NULL, id);
-
-	return status;
+	return acpi_evaluate_integer(video->device->handle, "_GPD", NULL, id);
 }
 
 static int
@@ -508,7 +497,8 @@ acpi_video_bus_POST_options(struct acpi_
 {
 	int status;
 
-	status = acpi_evaluate_integer(video->device->handle, "_VPO", NULL, options);
+	status = acpi_evaluate_integer(video->device->handle, "_VPO", NULL,
+					options);
 	*options &= 3;
 
 	return status;
@@ -516,23 +506,25 @@ acpi_video_bus_POST_options(struct acpi_
 
 /*
  *  Arg:
- *  	video		: video bus device pointer
- *	bios_flag	: 
- *		0.	The system BIOS should NOT automatically switch(toggle)
- *			the active display output.
- *		1.	The system BIOS should automatically switch (toggle) the
- *			active display output. No switch event.
+ *	video		: video bus device pointer
+ *	bios_flag	:
+ *		0.	The system BIOS should NOT automatically switch
+ *			(toggle) the active display output.
+ *		1.	The system BIOS should automatically switch
+ *			(toggle) the active display output. No switch event.
  *		2.	The _DGS value should be locked.
- *		3.	The system BIOS should not automatically switch (toggle) the
- *			active display output, but instead generate the display switch
- *			event notify code.
+ *		3.	The system BIOS should not automatically switch
+ *			(toggle) the active display output, but instead
+ *			generate the display switch event notify code.
  *	lcd_flag	:
- *		0.	The system BIOS should automatically control the brightness level
- *			of the LCD when the power changes from AC to DC
- *		1. 	The system BIOS should NOT automatically control the brightness 
- *			level of the LCD when the power changes from AC to DC.
+ *		0.	The system BIOS should automatically control the
+ *			brightness level of the LCD when the power changes
+ *			from AC to DC
+ *		1.	The system BIOS should NOT automatically control
+ *			the brightness level of the LCD when the power
+ *			changes from AC to DC.
  * Return Value:
- * 		-1	wrong arg.
+ *		-1	wrong arg.
  */
 
 static int
@@ -542,178 +534,199 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
-
 	if (bios_flag < 0 || bios_flag > 3 || lcd_flag < 0 || lcd_flag > 1) {
 		status = -1;
 		goto Failed;
 	}
+
 	arg0.integer.value = (lcd_flag << 2) | bios_flag;
 	video->dos_setting = arg0.integer.value;
 	acpi_evaluate_object(video->device->handle, "_DOS", &args, NULL);
 
-      Failed:
+ Failed:
 	return status;
 }
 
-/*
- *  Arg:	
- *  	device	: video output device (LCD, CRT, ..)
- *
- *  Return Value:
- *  	None
- *
- *  Find out all required AML methods defined under the output
- *  device.
- */
-
-static void acpi_video_device_find_cap(struct acpi_video_device *device)
+static void
+acpi_video_get_brightness_levels(struct acpi_video_device *device,
+				 u32 *max_level)
 {
-	acpi_handle h_dummy1;
 	int i;
-	u32 max_level = 0;
+	int count = 0;
 	union acpi_object *obj = NULL;
-	struct acpi_video_device_brightness *br = NULL;
+	union acpi_object *o;
+	struct acpi_video_device_brightness *br;
 
+	*max_level = 0;
 
-	memset(&device->cap, 0, 4);
-
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_ADR", &h_dummy1))) {
-		device->cap._ADR = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCL", &h_dummy1))) {
-		device->cap._BCL = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCM", &h_dummy1))) {
-		device->cap._BCM = 1;
+	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Could not query available LCD brightness level\n"));
+		goto out;
 	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BQC",&h_dummy1)))
-		device->cap._BQC = 1;
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
-		device->cap._DDC = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DCS", &h_dummy1))) {
-		device->cap._DCS = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DGS", &h_dummy1))) {
-		device->cap._DGS = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DSS", &h_dummy1))) {
-		device->cap._DSS = 1;
-	}
-
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
+
+	if (obj->package.count >= 2) {
+
+		br = kzalloc(sizeof(*br), GFP_KERNEL);
+		if (!br) {
+			printk(KERN_ERR PREFIX "can't allocate memory\n");
+			goto out;
+		}
+
+		br->levels = kcalloc(obj->package.count, sizeof *(br->levels),
+				     GFP_KERNEL);
+		if (!br->levels) {
+			printk(KERN_ERR PREFIX
+				"can't allocate memory for levels\n");
+			kfree(br);
+			goto out;
+		}
+
+		for (i = 0; i < obj->package.count; i++) {
+			o = (union acpi_object *)&obj->package.elements[i];
+			if (o->type != ACPI_TYPE_INTEGER) {
+				printk(KERN_ERR PREFIX "Invalid data\n");
+				continue;
 			}
+			br->levels[count] = (u32) o->integer.value;
+
+			if (br->levels[count] > *max_level)
+				*max_level = br->levels[count];
+
+			count++;
 		}
 
-	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available LCD brightness level\n"));
+		if (count < 2) {
+			kfree(br->levels);
+			kfree(br);
+		} else {
+			br->count = count;
+			device->brightness = br;
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "found %d brightness levels\n",
+					  count));
+		}
 	}
 
+ out:
 	kfree(obj);
+}
+
+static int
+acpi_video_register_backlight(struct acpi_video_device *device,
+			      u32 max_level)
+{
+	static atomic_t count = ATOMIC_INIT(0);
+	struct backlight_device *bl;
+	unsigned long tmp;
+	char name[MAX_NAME_LEN];
+
+	snprintf(name, sizeof(name), "acpi_video%ld",
+		 (long)atomic_inc_return(&count) - 1);
+
+	acpi_video_device_lcd_get_level_current(device, &tmp);
+
+	bl = backlight_device_register(name, &device->dev->dev, device,
+					&acpi_backlight_ops);
+	if (IS_ERR(bl)) {
+		printk(KERN_ERR PREFIX
+			"can't register backlight device %s, error %ld\n",
+			name, PTR_ERR(bl));
+		return PTR_ERR(bl);
+	}
+
+	bl->props.max_brightness = max_level;
+	bl->props.brightness = (int)tmp;
+
+	device->backlight = bl;
+	backlight_update_status(device->backlight);
+
+	return 0;
+}
 
-	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
-		unsigned long tmp;
-		static int count = 0;
-		char *name;
-		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
-		if (!name)
-			return;
-
-		sprintf(name, "acpi_video%d", count++);
-		acpi_video_device_lcd_get_level_current(device, &tmp);
-		device->backlight = backlight_device_register(name,
-			NULL, device, &acpi_backlight_ops);
-		device->backlight->props.max_brightness = max_level;
-		device->backlight->props.brightness = (int)tmp;
-		backlight_update_status(device->backlight);
-
-		kfree(name);
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
+static int acpi_video_register_output(struct acpi_video_device *device)
+{
+	static atomic_t count = ATOMIC_INIT(0);
+	struct output_device *od;
+	char name[MAX_NAME_LEN];
+
+	snprintf(name, sizeof(name), "acpi_video%ld",
+		 (long)atomic_inc_return(&count) - 1);
+
+	od = video_output_register(name, &device->dev->dev, device,
+				   &acpi_output_properties);
+	if (IS_ERR(od)) {
+		printk(KERN_ERR PREFIX
+			"can't register output device %s, error %ld\n",
+			name, PTR_ERR(od));
+		return PTR_ERR(od);
 	}
-	return;
+
+	device->output_dev = od;
+	return 0;
+}
+
+/*
+ *  Arg:
+ *	device	: video output device (LCD, CRT, ..)
+ *
+ *  Return Value:
+ *	None
+ *
+ *  Find out all required AML methods defined under the output
+ *  device.
+ */
+
+#define VIDEO_DEV_CHECK_CAP(_cap)					\
+	do {								\
+		acpi_handle h;						\
+		if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle,	\
+					__stringify(_cap), &h)))	\
+			device->cap._cap = 1;				\
+	} while (0)
+
+static void acpi_video_device_find_cap(struct acpi_video_device *device)
+{
+	memset(&device->cap, 0, 4);
+
+	VIDEO_DEV_CHECK_CAP(_ADR);
+	VIDEO_DEV_CHECK_CAP(_BCL);
+	VIDEO_DEV_CHECK_CAP(_BCM);
+	VIDEO_DEV_CHECK_CAP(_BQC);
+	VIDEO_DEV_CHECK_CAP(_DDC);
+	VIDEO_DEV_CHECK_CAP(_DCS);
+	VIDEO_DEV_CHECK_CAP(_DGS);
+	VIDEO_DEV_CHECK_CAP(_DSS);
 }
 
 /*
- *  Arg:	
- *  	device	: video output device (VGA)
+ *  Arg:
+ *	device	: video output device (VGA)
  *
  *  Return Value:
- *  	None
+ *	None
  *
  *  Find out all required AML methods defined under the video bus device.
  */
 
+#define VIDEO_BUS_CHECK_CAP(_cap)					\
+	do {								\
+		acpi_handle h;						\
+		if (ACPI_SUCCESS(acpi_get_handle(video->device->handle,	\
+					__stringify(_cap), &h)))	\
+			video->cap._cap = 1;				\
+	} while (0)
+
 static void acpi_video_bus_find_cap(struct acpi_video_bus *video)
 {
-	acpi_handle h_dummy1;
-
 	memset(&video->cap, 0, 4);
-	if (ACPI_SUCCESS(acpi_get_handle(video->device->handle, "_DOS", &h_dummy1))) {
-		video->cap._DOS = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(video->device->handle, "_DOD", &h_dummy1))) {
-		video->cap._DOD = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(video->device->handle, "_ROM", &h_dummy1))) {
-		video->cap._ROM = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(video->device->handle, "_GPD", &h_dummy1))) {
-		video->cap._GPD = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(video->device->handle, "_SPD", &h_dummy1))) {
-		video->cap._SPD = 1;
-	}
-	if (ACPI_SUCCESS(acpi_get_handle(video->device->handle, "_VPO", &h_dummy1))) {
-		video->cap._VPO = 1;
-	}
+
+	VIDEO_BUS_CHECK_CAP(_DOS);
+	VIDEO_BUS_CHECK_CAP(_DOD);
+	VIDEO_BUS_CHECK_CAP(_ROM);
+	VIDEO_BUS_CHECK_CAP(_GPD);
+	VIDEO_BUS_CHECK_CAP(_SPD);
+	VIDEO_BUS_CHECK_CAP(_VPO);
 }
 
 /*
@@ -725,10 +738,6 @@ static int acpi_video_bus_check(struct a
 {
 	acpi_status status = -ENOENT;
 
-
-	if (!video)
-		return -EINVAL;
-
 	/* Since there is no HID, CID and so on for VGA driver, we have
 	 * to check well known required nodes.
 	 */
@@ -766,10 +775,6 @@ static int acpi_video_device_info_seq_sh
 {
 	struct acpi_video_device *dev = seq->private;
 
-
-	if (!dev)
-		goto end;
-
 	seq_printf(seq, "device_id:    0x%04x\n", (u32) dev->device_id);
 	seq_printf(seq, "type:         ");
 	if (dev->flags.crt)
@@ -785,7 +790,6 @@ static int acpi_video_device_info_seq_sh
 
 	seq_printf(seq, "known by bios: %s\n", dev->flags.bios ? "yes" : "no");
 
-      end:
 	return 0;
 }
 
@@ -802,10 +806,6 @@ static int acpi_video_device_state_seq_s
 	struct acpi_video_device *dev = seq->private;
 	unsigned long state;
 
-
-	if (!dev)
-		goto end;
-
 	status = acpi_video_device_get_state(dev, &state);
 	seq_printf(seq, "state:     ");
 	if (ACPI_SUCCESS(status))
@@ -820,7 +820,6 @@ static int acpi_video_device_state_seq_s
 	else
 		seq_printf(seq, "<not supported>\n");
 
-      end:
 	return 0;
 }
 
@@ -842,7 +841,6 @@ acpi_video_device_write_state(struct fil
 	char str[12] = { 0 };
 	u32 state = 0;
 
-
 	if (!dev || count + 1 > sizeof str)
 		return -EINVAL;
 
@@ -867,8 +865,7 @@ acpi_video_device_brightness_seq_show(st
 	struct acpi_video_device *dev = seq->private;
 	int i;
 
-
-	if (!dev || !dev->brightness) {
+	if (!dev->brightness) {
 		seq_printf(seq, "<not supported>\n");
 		return 0;
 	}
@@ -899,7 +896,6 @@ acpi_video_device_write_brightness(struc
 	unsigned int level = 0;
 	int i;
 
-
 	if (!dev || !dev->brightness || count + 1 > sizeof str)
 		return -EINVAL;
 
@@ -931,25 +927,18 @@ static int acpi_video_device_EDID_seq_sh
 	int i;
 	union acpi_object *edid = NULL;
 
-
-	if (!dev)
-		goto out;
-
 	status = acpi_video_device_EDID(dev, &edid, 128);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		status = acpi_video_device_EDID(dev, &edid, 256);
-	}
 
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		goto out;
-	}
 
-	if (edid && edid->type == ACPI_TYPE_BUFFER) {
+	if (edid && edid->type == ACPI_TYPE_BUFFER)
 		for (i = 0; i < edid->buffer.length; i++)
 			seq_putc(seq, edid->buffer.pointer[i]);
-	}
 
-      out:
+  out:
 	if (!edid)
 		seq_printf(seq, "<not supported>\n");
 	else
@@ -1095,7 +1084,7 @@ static int acpi_video_bus_ROM_seq_show(s
 	printk(KERN_INFO PREFIX "Please implement %s\n", __FUNCTION__);
 	seq_printf(seq, "<TODO>\n");
 
-      end:
+ end:
 	return 0;
 }
 
@@ -1110,17 +1099,15 @@ static int acpi_video_bus_POST_info_seq_
 	unsigned long options;
 	int status;
 
-
-	if (!video)
-		goto end;
-
 	status = acpi_video_bus_POST_options(video, &options);
 	if (ACPI_SUCCESS(status)) {
 		if (!(options & 1)) {
 			printk(KERN_WARNING PREFIX
-			       "The motherboard VGA device is not listed as a possible POST device.\n");
+				"The motherboard VGA device is not listed "
+				"as a possible POST device.\n");
 			printk(KERN_WARNING PREFIX
-			       "This indicates a BIOS bug. Please contact the manufacturer.\n");
+				"This indicates a BIOS bug. "
+				"Please contact the manufacturer.\n");
 		}
 		printk("%lx\n", options);
 		seq_printf(seq, "can POST: <integrated video>");
@@ -1131,7 +1118,7 @@ static int acpi_video_bus_POST_info_seq_
 		seq_putc(seq, '\n');
 	} else
 		seq_printf(seq, "<not supported>\n");
-      end:
+
 	return 0;
 }
 
@@ -1148,10 +1135,6 @@ static int acpi_video_bus_POST_seq_show(
 	int status;
 	unsigned long id;
 
-
-	if (!video)
-		goto end;
-
 	status = acpi_video_bus_get_POST(video, &id);
 	if (!ACPI_SUCCESS(status)) {
 		seq_printf(seq, "<not supported>\n");
@@ -1159,7 +1142,7 @@ static int acpi_video_bus_POST_seq_show(
 	}
 	seq_printf(seq, "device POSTed is <%s>\n", device_decode[id & 3]);
 
-      end:
+ end:
 	return 0;
 }
 
@@ -1167,7 +1150,6 @@ static int acpi_video_bus_DOS_seq_show(s
 {
 	struct acpi_video_bus *video = seq->private;
 
-
 	seq_printf(seq, "DOS setting: <%d>\n", video->dos_setting);
 
 	return 0;
@@ -1195,7 +1177,6 @@ acpi_video_bus_write_POST(struct file *f
 	char str[12] = { 0 };
 	unsigned long opt, options;
 
-
 	if (!video || count + 1 > sizeof str)
 		return -EINVAL;
 
@@ -1354,8 +1335,9 @@ static int acpi_video_bus_remove_fs(stru
    -------------------------------------------------------------------------- */
 
 /* device interface */
-static struct acpi_video_device_attrib*
-acpi_video_get_device_attr(struct acpi_video_bus *video, unsigned long device_id)
+static struct acpi_video_device_attrib *
+acpi_video_get_device_attr(struct acpi_video_bus *video,
+			   unsigned long device_id)
 {
 	struct acpi_video_enumerated_device *ids;
 	int i;
@@ -1369,96 +1351,132 @@ acpi_video_get_device_attr(struct acpi_v
 	return NULL;
 }
 
+static void
+acpi_video_get_device_flags(struct acpi_video_device *device)
+{
+	struct acpi_video_device_attrib *attribute =
+		acpi_video_get_device_attr(device->video, device->device_id);
+
+	if (attribute && attribute->device_id_scheme) {
+		switch (attribute->display_type) {
+		case ACPI_VIDEO_DISPLAY_CRT:
+			device->flags.crt = 1;
+			break;
+		case ACPI_VIDEO_DISPLAY_TV:
+			device->flags.tvout = 1;
+			break;
+		case ACPI_VIDEO_DISPLAY_DVI:
+			device->flags.dvi = 1;
+			break;
+		case ACPI_VIDEO_DISPLAY_LCD:
+			device->flags.lcd = 1;
+			break;
+		default:
+			device->flags.unknown = 1;
+			break;
+		}
+		if (attribute->bios_can_detect)
+			device->flags.bios = 1;
+	} else
+		device->flags.unknown = 1;
+}
+
 static int
 acpi_video_bus_get_one_device(struct acpi_device *device,
 			      struct acpi_video_bus *video)
 {
+	struct acpi_video_device *data;
 	unsigned long device_id;
+	u32 max_brightness;
 	int status;
-	struct acpi_video_device *data;
-	struct acpi_video_device_attrib* attribute;
+	int error;
 
-	if (!device || !video)
-		return -EINVAL;
+	status = acpi_evaluate_integer(device->handle, "_ADR", NULL,
+					&device_id);
+	if (!ACPI_SUCCESS(status))
+		return -ENOENT;
 
-	status =
-	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
-	if (ACPI_SUCCESS(status)) {
+	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-		data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
-		if (!data)
-			return -ENOMEM;
-
-		strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
-		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
-		acpi_driver_data(device) = data;
-
-		data->device_id = device_id;
-		data->video = video;
-		data->dev = device;
-
-		attribute = acpi_video_get_device_attr(video, device_id);
-
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
-			data->flags.unknown = 1;
-
-		acpi_video_device_bind(video, data);
-		acpi_video_device_find_cap(data);
-
-		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY,
-						     acpi_video_device_notify,
-						     data);
-		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Error installing notify handler\n"));
-			if(data->brightness)
-				kfree(data->brightness->levels);
-			kfree(data->brightness);
-			kfree(data);
-			return -ENODEV;
-		}
+	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	acpi_driver_data(device) = data;
 
-		mutex_lock(&video->device_list_lock);
-		list_add_tail(&data->entry, &video->video_device_list);
-		mutex_unlock(&video->device_list_lock);
+	data->device_id = device_id;
+	data->video = video;
+	data->dev = device;
 
-		acpi_video_device_add_fs(device);
+	acpi_video_get_device_flags(data);
+	acpi_video_device_find_cap(data);
+	acpi_video_get_brightness_levels(data, &max_brightness);
 
-		return 0;
+	acpi_video_device_bind(video, data);
+
+	if (data->cap._BCL && data->cap._BCM && data->cap._BQC &&
+	    max_brightness > 0) {
+		error = acpi_video_register_backlight(data, max_brightness);
+		if (error)
+			goto err_free_video_dev;
+	}
+
+	if (data->cap._DCS && data->cap._DSS) {
+		error = acpi_video_register_output(data);
+		if (error)
+			goto err_remove_backlight;
 	}
 
-	return -ENOENT;
+	status = acpi_install_notify_handler(device->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_video_device_notify,
+					     data);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing notify handler\n"));
+		error = -EINVAL;
+		goto err_remove_output_dev;
+	}
+
+	mutex_lock(&video->device_list_lock);
+	list_add_tail(&data->entry, &video->video_device_list);
+	mutex_unlock(&video->device_list_lock);
+
+	error = acpi_video_device_add_fs(device);
+	if (error)
+		goto err_remove_from_list;
+
+	return 0;
+
+ err_remove_from_list:
+	mutex_lock(&video->device_list_lock);
+	list_del(&data->entry);
+	mutex_unlock(&video->device_list_lock);
+	acpi_remove_notify_handler(data->dev->handle,
+				   ACPI_DEVICE_NOTIFY,
+				   acpi_video_device_notify);
+ err_remove_output_dev:
+	video_output_unregister(data->output_dev);
+ err_remove_backlight:
+	backlight_device_unregister(data->backlight);
+ err_free_video_dev:
+	if (data->brightness) {
+		kfree(data->brightness->levels);
+		kfree(data->brightness);
+	}
+	kfree(data);
+
+	return 0;
 }
 
 /*
  *  Arg:
- *  	video	: video bus device 
+ *	video	: video bus device
  *
  *  Return:
- *  	none
- *  
- *  Enumerate the video device list of the video bus, 
+ *	none
+ *
+ *  Enumerate the video device list of the video bus,
  *  bind the ids with the corresponding video devices
  *  under the video bus.
  */
@@ -1477,13 +1495,13 @@ static void acpi_video_device_rebind(str
 
 /*
  *  Arg:
- *  	video	: video bus device 
- *  	device	: video output device under the video 
- *  		bus
+ *	video	: video bus device
+ *	device	: video output device under the video
+ *		bus
  *
  *  Return:
- *  	none
- *  
+ *	none
+ *
  *  Bind the ids with the corresponding video devices
  *  under the video bus.
  */
@@ -1506,11 +1524,11 @@ acpi_video_device_bind(struct acpi_video
 
 /*
  *  Arg:
- *  	video	: video bus device 
+ *	video	: video bus device
  *
  *  Return:
- *  	< 0	: error
- *  
+ *	< 0	: error
+ *
  *  Call _DOD to enumerate all devices attached to display adapter
  *
  */
@@ -1525,14 +1543,15 @@ static int acpi_video_device_enumerate(s
 	union acpi_object *dod = NULL;
 	union acpi_object *obj;
 
-	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
+	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL,
+				      &buffer);
 	if (!ACPI_SUCCESS(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
 		return status;
 	}
 
 	dod = buffer.pointer;
-	if (!dod || (dod->type != ACPI_TYPE_PACKAGE)) {
+	if (!dod || dod->type != ACPI_TYPE_PACKAGE) {
 		ACPI_EXCEPTION((AE_INFO, status, "Invalid _DOD data"));
 		status = -EFAULT;
 		goto out;
@@ -1578,12 +1597,12 @@ static int acpi_video_device_enumerate(s
 
 /*
  *  Arg:
- *  	video	: video bus device 
- *  	event	: notify event
+ *	video	: video bus device
+ *	event	: notify event
  *
  *  Return:
- *  	< 0	: error
- *  
+ *	< 0	: error
+ *
  *	1. Find out the current active output device.
  *	2. Identify the next output device to switch to.
  *	3. call _DSS to do actual switch.
@@ -1683,47 +1702,39 @@ static void
 acpi_video_switch_brightness(struct acpi_video_device *device, int event)
 {
 	unsigned long level_current, level_next;
+
 	acpi_video_device_lcd_get_level_current(device, &level_current);
 	level_next = acpi_video_get_next_level(device, level_current, event);
 	acpi_video_device_lcd_set_level(device, level_next);
 }
 
-static int
+static void
 acpi_video_bus_get_devices(struct acpi_video_bus *video,
 			   struct acpi_device *device)
 {
-	int status = 0;
+	int error;
 	struct acpi_device *dev;
 
 	acpi_video_device_enumerate(video);
 
 	list_for_each_entry(dev, &device->children, node) {
-
-		status = acpi_video_bus_get_one_device(dev, video);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status, "Cant attach device"));
-			continue;
-		}
+		error = acpi_video_bus_get_one_device(dev, video);
+		if (error)
+			printk(KERN_ERR PREFIX "Can't attach device");
 	}
-	return status;
 }
 
 static int acpi_video_bus_put_one_device(struct acpi_video_device *device)
 {
-	acpi_status status;
-	struct acpi_video_bus *video;
+	struct acpi_video_bus *video = device->video;
 
-
-	if (!device || !device->video)
+	if (!video)
 		return -ENOENT;
 
-	video = device->video;
-
 	acpi_video_device_remove_fs(device->dev);
-
-	status = acpi_remove_notify_handler(device->dev->handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_video_device_notify);
+	acpi_remove_notify_handler(device->dev->handle,
+				   ACPI_DEVICE_NOTIFY,
+				   acpi_video_device_notify);
 	backlight_device_unregister(device->backlight);
 	video_output_unregister(device->output_dev);
 
@@ -1772,12 +1783,11 @@ static int acpi_video_bus_stop_devices(s
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_video_bus *video = data;
-	struct acpi_device *device = NULL;
+	struct acpi_device *device;
 	struct input_dev *input;
 	int keycode;
 
-
-	printk("video bus notify\n");
+	printk(KERN_DEBUG "video bus notify\n");
 
 	if (!video)
 		return;
@@ -1828,14 +1838,12 @@ static void acpi_video_bus_notify(acpi_h
 	input_sync(input);
 	input_report_key(input, keycode, 0);
 	input_sync(input);
-
-	return;
 }
 
 static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_video_device *video_device = data;
-	struct acpi_device *device = NULL;
+	struct acpi_device *device;
 	struct acpi_video_bus *bus;
 	struct input_dev *input;
 	int keycode;
@@ -1884,30 +1892,33 @@ static void acpi_video_device_notify(acp
 	input_sync(input);
 	input_report_key(input, keycode, 0);
 	input_sync(input);
-
-	return;
 }
 
-static int instance;
 static int acpi_video_bus_add(struct acpi_device *device)
 {
+	static atomic_t instance = ATOMIC_INIT(0);
+
 	acpi_status status;
 	struct acpi_video_bus *video;
 	struct input_dev *input;
 	int error;
+	int i;
 
 	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)
 		return -ENOMEM;
 
+	mutex_init(&video->device_list_lock);
+	INIT_LIST_HEAD(&video->video_device_list);
+	video->device = device;
+
 	/* a hack to fix the duplicate name "VID" problem on T61 */
 	if (!strcmp(device->pnp.bus_id, "VID")) {
-		if (instance)
-			device->pnp.bus_id[3] = '0' + instance;
-		instance ++;
+		i = atomic_inc_return(&instance) - 1;
+		if (i)
+			device->pnp.bus_id[3] = '0' + i;
 	}
 
-	video->device = device;
 	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
 	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 	acpi_driver_data(device) = video;
@@ -1921,9 +1932,6 @@ static int acpi_video_bus_add(struct acp
 	if (error)
 		goto err_free_video;
 
-	mutex_init(&video->device_list_lock);
-	INIT_LIST_HEAD(&video->video_device_list);
-
 	acpi_video_bus_get_devices(video, device);
 	acpi_video_bus_start_devices(video);
 
@@ -1993,25 +2001,20 @@ static int acpi_video_bus_add(struct acp
 
 static int acpi_video_bus_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-	struct acpi_video_bus *video = NULL;
-
+	struct acpi_video_bus *video = acpi_driver_data(device);
 
-	if (!device || !acpi_driver_data(device))
+	if (!video)
 		return -EINVAL;
 
-	video = acpi_driver_data(device);
-
 	acpi_video_bus_stop_devices(video);
-
-	status = acpi_remove_notify_handler(video->device->handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_video_bus_notify);
-
+	acpi_remove_notify_handler(video->device->handle,
+				    ACPI_DEVICE_NOTIFY,
+				    acpi_video_bus_notify);
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
 
 	input_unregister_device(video->input);
+
 	kfree(video->attached_array);
 	kfree(video);
 
@@ -2022,7 +2025,6 @@ static int __init acpi_video_init(void)
 {
 	int result = 0;
 
-
 	/*
 	   acpi_dbg_level = 0xFFFFFFFF;
 	   acpi_dbg_layer = 0x08000000;
@@ -2044,12 +2046,8 @@ static int __init acpi_video_init(void)
 
 static void __exit acpi_video_exit(void)
 {
-
 	acpi_bus_unregister_driver(&acpi_video_bus);
-
 	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-
-	return;
 }
 
 module_init(acpi_video_init);

-- 
Dmitry

