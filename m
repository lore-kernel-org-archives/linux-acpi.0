From: Kamal Mostafa <kamal@canonical.com>
Subject: [RFC PATCH 1/2] acpi/video: acpi_brightness_hook API
Date: Wed,  2 Jun 2010 15:11:41 -0700
Message-ID: <1275516702-27090-2-git-send-email-kamal@canonical.com>
References: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:49409 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756Ab0FBWMD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 18:12:03 -0400
In-Reply-To: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: Kamal Mostafa <kamal@canonical.com>

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/568611

New acpi_brightness_hook_register lets another driver (e.g. i915) override
the often-dysfunctional native acpi brightness control methods.

Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/acpi/video.c |  149 ++++++++++++++++++++++++++++++++++++++++++++++----
 include/acpi/video.h |   10 +++
 2 files changed, 147 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bd9843a..331fdcc 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -481,6 +481,12 @@ acpi_video_device_set_state(struct acpi_video_device *device, int state)
 	return status;
 }
 
+static unsigned int (*acpi_brightness_hook_routine)
+			(void *dev, unsigned int brightness) = NULL;
+static char *acpi_brightness_hook_driver;
+static void *acpi_brightness_hook_dev;
+static unsigned int acpi_brightness_hook_max;
+
 static int
 acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
 				   union acpi_object **levels)
@@ -520,13 +526,25 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 	struct acpi_object_list args = { 1, &arg0 };
 	int state;
 
-	arg0.integer.value = level;
+	/* If another driver has registered a brightness hook override,
+	 * set the brightness using that method, otherwise set the brightness
+	 * using the acpi _BCM method. */
+	if ( acpi_brightness_hook_routine ) {
+		status = acpi_brightness_hook_routine(acpi_brightness_hook_dev,
+				level * acpi_brightness_hook_max / 100);
+		if ( status != 0 ) {
+			ACPI_ERROR((AE_INFO, "brightness hook failed"));
+			return -EIO;
+		}
+	} else {
+		arg0.integer.value = level;
 
-	status = acpi_evaluate_object(device->dev->handle, "_BCM",
-				      &args, NULL);
-	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Evaluating _BCM failed"));
-		return -EIO;
+		status = acpi_evaluate_object(device->dev->handle, "_BCM",
+					      &args, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_ERROR((AE_INFO, "Evaluating _BCM failed"));
+			return -EIO;
+		}
 	}
 
 	device->brightness->curr = level;
@@ -607,7 +625,10 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 	acpi_status status = AE_OK;
 	int i;
 
-	if (device->cap._BQC || device->cap._BCQ) {
+	/* Try to get the current brightness using the _BQC/_BCQ method, only
+	 * if another driver has not registered a brightness hook override. */
+	if (!acpi_brightness_hook_routine
+			&& (device->cap._BQC || device->cap._BCQ)) {
 		char *buf = device->cap._BQC ? "_BQC" : "_BCQ";
 
 		status = acpi_evaluate_integer(device->dev->handle, buf,
@@ -784,7 +805,7 @@ acpi_video_cmp_level(const void *a, const void *b)
  *  	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
- *	Maximum brightness level
+ *  	0 on success, error code on failure.
  *
  *  Allocate and initialize device->brightness.
  */
@@ -944,6 +965,99 @@ out:
  *	device	: video output device (LCD, CRT, ..)
  *
  *  Return Value:
+ *  	0 on success, error code on failure.
+ *
+ *  Allocate and initialize device->brightness. when a driver has registered
+ *  a brightness hook override via acpi_brightness_hook_register.
+ *
+ *  Cobbles up a fake brightness 'levels' array (emulating a _BCL list) and
+ *  sets max brightness -- effectively what acpi_video_init_brightness does
+ *  for the native acpi brightness methods
+ */
+static int
+acpi_brightness_hook_init(struct acpi_video_device *device)
+{
+	struct acpi_video_device_brightness *br = NULL;
+	int result = -EINVAL;
+	int nsteps = 10;
+	int count, i;
+	static int initialized = 0;
+
+	if ( initialized )
+	    return 1;
+	initialized = 1;
+
+	device->brightness = NULL;
+
+	br = kzalloc(sizeof(*br), GFP_KERNEL);
+	if (!br) {
+		printk(KERN_ERR "can't allocate memory\n");
+		result = -ENOMEM;
+		return result;
+	}
+	br->levels = kmalloc((nsteps + 2) * sizeof *(br->levels),
+				GFP_KERNEL);
+	if (!br->levels) {
+		result = -ENOMEM;
+		kfree(br);
+		return result;
+	}
+
+	for (count=2, i = 1; i <= nsteps; i++)
+		br->levels[count++] = (u32) i * 100 / nsteps;
+	br->levels[0] = 100;
+	br->levels[1] = br->levels[2+(nsteps/2)];
+	br->count = count;
+	device->brightness = br;
+
+	result = acpi_video_device_lcd_set_level(device, 100);
+	if (result) {
+	    kfree(br->levels);
+	    kfree(br);
+	    device->brightness = NULL;
+	    return result;
+	}
+
+	/* Switch off acpi's native brightness switch control */
+	brightness_switch_enabled = 0;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "set up %d brightness levels\n", nsteps));
+
+	return 0;
+}
+
+/*
+ *  Arg:
+ *	driver_name	: name of the registering driver
+ *	set_brightness_routine:	pointer to the new set_brightness method
+ *	dev		: arbitrary pointer passed to set_brightness_routine
+ *	max_brightness	: set_brightnes_routines' maximum brightness value
+ *
+ *  Return Value:
+ *  	None
+ *
+ *  Register a brightness hook override method, which ACPI will use
+ *  instead of its native _BCM/_BCL/_BQC methods.
+ */
+void acpi_brightness_hook_register(
+		char *driver_name,
+		unsigned int (*set_brightness_routine)
+				(void *dev, unsigned int brightness),
+		void *dev, int max_brightness)
+{
+	acpi_brightness_hook_routine = set_brightness_routine;
+	acpi_brightness_hook_driver = driver_name,
+	acpi_brightness_hook_dev = dev;
+	acpi_brightness_hook_max = max_brightness;
+}
+EXPORT_SYMBOL(acpi_brightness_hook_register);
+
+/*
+ *  Arg:
+ *	device	: video output device (LCD, CRT, ..)
+ *
+ *  Return Value:
  *  	None
  *
  *  Find out all required AML methods defined under the output
@@ -984,22 +1098,33 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		device->cap._DSS = 1;
 	}
 
-	if (acpi_video_backlight_support()) {
+	if (acpi_brightness_hook_routine || acpi_video_backlight_support()) {
 		int result;
 		static int count = 0;
 		char *name;
 
-		result = acpi_video_init_brightness(device);
+		/* If another driver has registered a brightness hook override,
+		 * call the brightness_hook init, otherwise call the native
+		 * acpi_video brightness init. */
+		if (acpi_brightness_hook_routine)
+			result = acpi_brightness_hook_init(device);
+		else
+			result = acpi_video_init_brightness(device);
 		if (result)
 			return;
 		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
 		if (!name)
 			return;
 
-		sprintf(name, "acpi_video%d", count++);
+		if (acpi_brightness_hook_routine)
+			sprintf(name, "%s", acpi_brightness_hook_driver);
+		else
+			sprintf(name, "acpi_video%d", count++);
 		device->backlight = backlight_device_register(name,
 			NULL, device, &acpi_backlight_ops);
 		device->backlight->props.max_brightness = device->brightness->count-3;
+		dev_info(&device->dev->dev,
+				"registered as backlight/%s\n", name);
 		kfree(name);
 
 		result = sysfs_create_link(&device->backlight->dev.kobj,
diff --git a/include/acpi/video.h b/include/acpi/video.h
index cf7be3d..645b574 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -2,9 +2,19 @@
 #define __ACPI_VIDEO_H
 
 #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
+extern void acpi_brightness_hook_register(
+		char *driver_name,
+		unsigned int (*set_brightness_routine)
+				(void *dev, unsigned int brightness),
+		void *dev, unsigned int max_brightness);
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
 #else
+static inline acpi_brightness_hook_register(
+		char *driver_name,
+		unsigned int (*set_brightness_routine)
+				(void *dev, unsigned int brightness),
+		void *dev, unsigned int max_brightness) { return; }
 static inline int acpi_video_register(void) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
 #endif
-- 
1.7.0.4

