From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] ACPI: video - cleanup video device registration
Date: Sun, 9 Aug 2009 22:51:52 -0700
Message-ID: <20090810062216.C9A68526EC9@mailhub.coreip.homeip.net>
References: <20090808072150.2980.3863.stgit@localhost.localdomain> <20090808075647.90344526EC9@mailhub.coreip.homeip.net> <1249870265.2670.537.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:64048 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZHJFv5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Aug 2009 01:51:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so598328rvb.5
        for <linux-acpi@vger.kernel.org>; Sun, 09 Aug 2009 22:51:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1249870265.2670.537.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Aug 10, 2009 at 10:11:05AM +0800, Zhang Rui wrote:
> On Sat, 2009-08-08 at 15:26 +0800, Dmitry Torokhov wrote:
> > +       if (acpi_video_backlight_support()) {
> > +               acpi_video_init_brightness(data);
> > +               acpi_video_device_add_backlight(data);
> > +               acpi_video_device_add_cooling_dev(data);
> 
> we should check the return value of acpi_video_init_brightness first.
> No backlight device or thermal cooling device if the video device
> doesn't support backlight control well.
> 

Ok, then what about the patch below then (on top of #4)?

-- 
Dmitry


ACPI: video - do not register backlight/cooling without brightness

Do not attempt registering backlight or cooling device when initialization
of brightness support failed - they are not useable without it.
Also don't use 2 kzallocs when one will suffice.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/video.c |  101 +++++++++++++++++++++++---------------------------
 1 files changed, 46 insertions(+), 55 deletions(-)


diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bc5082b..51b8004 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -184,9 +184,9 @@ struct acpi_video_brightness_flags {
 
 struct acpi_video_device_brightness {
 	int curr;
-	int count;
-	int *levels;
 	struct acpi_video_brightness_flags flags;
+	int count;
+	int levels[0];
 };
 
 struct acpi_video_device {
@@ -923,32 +923,27 @@ static int acpi_video_init_brightness(struct acpi_video_device *device)
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
@@ -1005,60 +1000,55 @@ static int acpi_video_init_brightness(struct acpi_video_device *device)
 	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
 	br->curr = level_old = max_level;
 
-	if (!device->cap._BQC)
-		goto set_level;
-
-	result = acpi_video_device_lcd_get_level_current(device, &level_old);
-	if (result)
-		goto out_free_levels;
+	if (device->cap._BQC) {
+		result = acpi_video_device_lcd_get_level_current(device,
+								 &level_old);
+		if (result)
+			goto out;
 
-	/*
-	 * Set the level to maximum and check if _BQC uses indexed value
-	 */
-	result = acpi_video_device_lcd_set_level(device, max_level);
-	if (result)
-		goto out_free_levels;
-
-	result = acpi_video_device_lcd_get_level_current(device, &level);
-	if (result)
-		goto out_free_levels;
+		/*
+		 * Set the level to maximum and check if _BQC uses
+		 * indexed value
+		 */
+		result = acpi_video_device_lcd_set_level(device, max_level);
+		if (result)
+			goto out;
 
-	br->flags._BQC_use_index = (level == max_level ? 0 : 1);
+		result = acpi_video_device_lcd_get_level_current(device,
+								 &level);
+		if (result)
+			goto out;
 
-	if (!br->flags._BQC_use_index)
-		goto set_level;
+		br->flags._BQC_use_index = (level == max_level ? 0 : 1);
 
-	if (br->flags._BCL_reversed)
-		level_old = (br->count - 1) - level_old;
-	level_old = br->levels[level_old];
+		if (br->flags._BQC_use_index) {
+			if (br->flags._BCL_reversed)
+				level_old = (br->count - 1) - level_old;
+			level_old = br->levels[level_old];
+		}
+	}
 
-set_level:
 	result = acpi_video_device_lcd_set_level(device, level_old);
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
 
 static void acpi_video_free_brightness_data(struct acpi_video_device *device)
 {
-	if (device->brightness) {
-		kfree(device->brightness->levels);
-		kfree(device->brightness);
-		device->brightness = NULL;
-	}
+	kfree(device->brightness);
+	device->brightness = NULL;
 }
 
 /*
@@ -1066,7 +1056,7 @@ static void acpi_video_free_brightness_data(struct acpi_video_device *device)
  *	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
- *  	None
+ *	None
  *
  *  Find out all required AML methods defined under the output
  *  device.
@@ -1824,9 +1814,10 @@ static int acpi_video_bus_add_device(struct acpi_device *device,
 	acpi_video_device_find_cap(data);
 
 	if (acpi_video_backlight_support()) {
-		acpi_video_init_brightness(data);
-		acpi_video_device_add_backlight(data);
-		acpi_video_device_add_cooling_dev(data);
+		if (acpi_video_init_brightness(data) == 0) {
+			acpi_video_device_add_backlight(data);
+			acpi_video_device_add_cooling_dev(data);
+		}
 	}
 
 	if (acpi_video_display_switch_support())
@@ -2259,7 +2250,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	if (!strcmp(device->pnp.bus_id, "VID")) {
 		if (instance)
 			device->pnp.bus_id[3] = '0' + instance;
-		instance ++;
+		instance++;
 	}
 	/* a hack to fix the duplicate name "VGA" problem on Pa 3553 */
 	if (!strcmp(device->pnp.bus_id, "VGA")) {
