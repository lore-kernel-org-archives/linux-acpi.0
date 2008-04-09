From: nokos@gmx.net
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Thu, 10 Apr 2008 01:40:42 +0200
Message-ID: <1207784442.32532.0.camel@earth.gruber.myown>
References: <20080305030147.GA25310@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:49509 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076AbYDIXlA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 19:41:00 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 0B6FD4C441
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2008 01:40:56 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id EDF54ABB6F
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2008 01:40:55 +0200 (CEST)
Received: from [0.0.0.0] (dslb-084-056-080-064.pools.arcor-ip.net [84.56.80.64])
	(Authenticated sender: nokos@arcor.de)
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 540A73425E3
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2008 01:40:55 +0200 (CEST)
Received: from 127.0.0.1 (ident=rfExz2uAd8Q) by earth.gruber.myown with
 esmtp (masqmail 0.2.21) id 1JjjuF-0KS-00 for
 <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2008 01:40:43 +0200
In-Reply-To: <20080305030147.GA25310@earth.gruber.myown>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

An updated version of the support for Fujitsu Lifebook S6410 in
fujitsu-laptop. Fixes adding of the notification and the brightness
button if no brightness change occured.

To activate the different brightness-button handling use the 
use_alt_lcd_levels=1 module parameter.

Signed-off-by: Peter Gruber <nokos@gmx.net>

> This adds Support for Fujitsu Lifebook S6410 in fujitsu-laptop. The
> module parameter use_alt_lcd_levels switches between different ACPI
> brightness controls (The one in the original does not work for the
> S6410, it only set the appropriate ACPI registerbut does not change the
> brightness). With use_alt_lcd_levels=1 it has been testen on a Fujitsu
> Lifebook S6410. Here it also provides an input device for the extra
> buttons found on that laptop.
> 
> The entry in blacklist.c is needed since the BIOS contains an ACPI Table
> which has no signature (ie. "\0\0\0\0" ) which contains the brightness
> adjustment functions if "Windows 2006" is detected by osi. With this
> table the brightness buttons would be routed through the standard VIDEO
> device but brightness adjustments would also not work.


diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index ea92bac..8d02671 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -447,6 +447,14 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
 	 	     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
 		},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Fujitsu Siemens",
+	.matches = {
+	             DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+	             DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S6410"),
+	         },
+	},
 	},
 	/*
 	 * Disable OSI(Linux) warnings on all "Hewlett-Packard"
diff --git a/drivers/misc/fujitsu-laptop.c
b/drivers/misc/fujitsu-laptop.c
index 1cfd7f3..4c871ba 100644
--- a/drivers/misc/fujitsu-laptop.c
+++ b/drivers/misc/fujitsu-laptop.c
@@ -2,6 +2,7 @@
 
 /*
   Copyright (C) 2007 Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
+  Copyright (C) 2008 Peter Gruber <nokos@gmx.net>
   Based on earlier work:
     Copyright (C) 2003 Shane Spencer <shane@bogomip.com>
     Adrian Yee <brewt-fujitsu@brewt.org>
@@ -41,6 +42,12 @@
  *
  * This driver has been tested on a Fujitsu Lifebook S7020.  It should
  * work on most P-series and S-series Lifebooks, but YMMV.
+ *
+ * The moduleparameter use_alt_lcd_levels switches between different
ACPI
+ * brightness controls. With use_alt_lcd_levels=1 it has been testen on
+ * a Fujitsu Lifebook S6410. Here it also provides an input device for
the
+ * extra buttons found on that laptop.
+ *
  */
 
 #include <linux/module.h>
@@ -49,31 +56,82 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/backlight.h>
+#include <linux/input.h>
+#include <linux/video_output.h>
 #include <linux/platform_device.h>
+#include <linux/autoconf.h>
 
 #define FUJITSU_DRIVER_VERSION "0.3"
 
 #define FUJITSU_LCD_N_LEVELS 8
 
 #define ACPI_FUJITSU_CLASS              "fujitsu"
-#define ACPI_FUJITSU_HID                "FUJ02B1"
-#define ACPI_FUJITSU_DRIVER_NAME        "Fujitsu laptop FUJ02B1 ACPI
extras driver"
-#define ACPI_FUJITSU_DEVICE_NAME        "Fujitsu FUJ02B1"
+
+#define ACPI_FUJITSUB1_DRIVER_NAME        "Fujitsu laptop ACPI extras
driver B1"
+#define ACPI_FUJITSUB1_HID                "FUJ02B1"
+#define ACPI_FUJITSUB1_DEVICE_NAME        "Fujitsu FUJ02B1"
+
+#define ACPI_FUJITSUE3_DRIVER_NAME        "Fujitsu laptop ACPI extras
driver E3"
+#define ACPI_FUJITSUE3_HID                "FUJ02E3"
+#define ACPI_FUJITSUE3_DEVICE_NAME        "Fujitsu FUJ02E3"
+
+#define ACPI_FUJITSUB1_NOTIFY_CODE1	0x80
+#define ACPI_FUJITSUE3_NOTIFY_CODE1	0x80
+
+#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x86
+#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x87
+
+#define LOCK_KEY	0x410 /* codes for the keys in the GIRB register */
+#define DISPLAY_KEY	0x411 /* keys are mapped to KEY_SCREENLOCK (the key
with the key symbol) */
+#define ENERGY_KEY	0x412 /* KEY_MEDIA (the key with the laptop symbol,
KEY_EMAIL (E key)) */
+#define REST_KEY	0x413 /* KEY_SUSPEND (R key)*/
 
 struct fujitsu_t {
-	acpi_handle acpi_handle;
+	int usealt;		/* use the alternative brightness interface */
+	acpi_handle acpi_handle_b1;
+	acpi_handle acpi_handle_e3;
+	struct acpi_device *dev_b1;
+	struct acpi_device *dev_e3;
+	struct input_dev *input_b1;
+	struct input_dev *input_e3;
+	char phys_b1[32];
+	char phys_e3[32];
 	struct backlight_device *bl_device;
 	struct platform_device *pf_device;
+	int keycode_e3;		/* remember keycode for release */
 
-	unsigned long fuj02b1_state;
+	unsigned int max_brightness;
 	unsigned int brightness_changed;
 	unsigned int brightness_level;
+	unsigned int irb;	/* info about the pressed buttons */
 };
 
 static struct fujitsu_t *fujitsu;
+static int use_alt_lcd_levels;
+
+static void acpi_fujitsu_notify_b1(acpi_handle handle, u32 event,
+				   void *data);
+static void acpi_fujitsu_notify_e3(acpi_handle handle, u32 event,
+				   void *data);
 
 /* Hardware access */
 
+static int get_irb(void)
+{
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	status =
+	    acpi_evaluate_integer(fujitsu->acpi_handle_e3, "GIRB", NULL,
+				  &state);
+	if (status < 0)
+		return status;
+
+	fujitsu->irb = state;
+
+	return fujitsu->irb;
+}
+
 static int set_lcd_level(int level)
 {
 	acpi_status status = AE_OK;
@@ -81,13 +139,13 @@ static int set_lcd_level(int level)
 	struct acpi_object_list arg_list = { 1, &arg0 };
 	acpi_handle handle = NULL;
 
-	if (level < 0 || level >= FUJITSU_LCD_N_LEVELS)
+	if (level < 0 || level >= fujitsu->max_brightness)
 		return -EINVAL;
 
 	if (!fujitsu)
 		return -EINVAL;
 
-	status = acpi_get_handle(fujitsu->acpi_handle, "SBLL", &handle);
+	status = acpi_get_handle(fujitsu->acpi_handle_b1, "SBLL", &handle);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SBLL not present\n"));
 		return -ENODEV;
@@ -102,18 +160,82 @@ static int set_lcd_level(int level)
 	return 0;
 }
 
+static int set_lcd_level_alt(int level)
+{
+	acpi_status status = AE_OK;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list arg_list = { 1, &arg0 };
+	acpi_handle handle = NULL;
+
+	if (level < 0 || level >= fujitsu->max_brightness)
+		return -EINVAL;
+
+	if (!fujitsu)
+		return -EINVAL;
+
+	status = acpi_get_handle(fujitsu->acpi_handle_b1, "SBL2", &handle);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SBL2 not present\n"));
+		return -ENODEV;
+	}
+
+	arg0.integer.value = level;
+
+	status = acpi_evaluate_object(handle, NULL, &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
 static int get_lcd_level(void)
 {
 	unsigned long state = 0;
 	acpi_status status = AE_OK;
 
-	// Get the Brightness
 	status =
-	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
+	    acpi_evaluate_integer(fujitsu->acpi_handle_b1, "GBLL", NULL,
+				  &state);
+	if (status < 0)
+		return status;
+
+	fujitsu->brightness_level = state & 0x0fffffff;
+
+	if (state & 0x80000000)
+		fujitsu->brightness_changed = 1;
+	else
+		fujitsu->brightness_changed = 0;
+
+	return fujitsu->brightness_level;
+}
+
+static int get_max_brightness(void)
+{
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	status =
+	    acpi_evaluate_integer(fujitsu->acpi_handle_b1, "RBLL", NULL,
+				  &state);
+	if (status < 0)
+		return status;
+
+	fujitsu->max_brightness = state;
+
+	return fujitsu->max_brightness;
+}
+
+static int get_lcd_level_alt(void)
+{
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	status =
+	    acpi_evaluate_integer(fujitsu->acpi_handle_b1, "GBLS", NULL,
+				  &state);
 	if (status < 0)
 		return status;
 
-	fujitsu->fuj02b1_state = state;
 	fujitsu->brightness_level = state & 0x0fffffff;
 
 	if (state & 0x80000000)
@@ -124,8 +246,24 @@ static int get_lcd_level(void)
 	return fujitsu->brightness_level;
 }
 
+
 /* Backlight device stuff */
 
+static int bl_get_brightness_alt(struct backlight_device *b)
+{
+	return get_lcd_level_alt();
+}
+
+static int bl_update_status_alt(struct backlight_device *b)
+{
+	return set_lcd_level_alt(b->props.brightness);
+}
+
+static struct backlight_ops fujitsubl_ops_alt = {
+	.get_brightness = bl_get_brightness_alt,
+	.update_status = bl_update_status_alt,
+};
+
 static int bl_get_brightness(struct backlight_device *b)
 {
 	return get_lcd_level();
@@ -143,8 +281,56 @@ static struct backlight_ops fujitsubl_ops = {
 
 /* Platform device */
 
-static ssize_t show_lcd_level(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t
+show_lcd_level_alt(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+
+	int ret;
+
+	ret = get_lcd_level_alt();
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%i\n", ret);
+}
+
+static ssize_t
+store_lcd_level_alt(struct device *dev,
+		    struct device_attribute *attr, const char *buf,
+		    size_t count)
+{
+
+	int level, ret;
+
+	if (sscanf(buf, "%i", &level) != 1
+	    || (level < 0 || level >= fujitsu->max_brightness))
+		return -EINVAL;
+
+	ret = set_lcd_level_alt(level);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t
+show_max_brightness(struct device *dev,
+		    struct device_attribute *attr, char *buf)
+{
+
+	int ret;
+
+	ret = get_max_brightness();
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%i\n", ret);
+}
+
+static ssize_t
+show_lcd_level(struct device *dev, struct device_attribute *attr,
+	       char *buf)
 {
 
 	int ret;
@@ -156,15 +342,16 @@ static ssize_t show_lcd_level(struct device *dev,
 	return sprintf(buf, "%i\n", ret);
 }
 
-static ssize_t store_lcd_level(struct device *dev,
-			       struct device_attribute *attr, const char *buf,
-			       size_t count)
+static ssize_t
+store_lcd_level(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t count)
 {
 
 	int level, ret;
 
 	if (sscanf(buf, "%i", &level) != 1
-	    || (level < 0 || level >= FUJITSU_LCD_N_LEVELS))
+	    || (level < 0 || level >= fujitsu->max_brightness))
 		return -EINVAL;
 
 	ret = set_lcd_level(level);
@@ -174,10 +361,23 @@ static ssize_t store_lcd_level(struct device *dev,
 	return count;
 }
 
+static ssize_t
+ignore_store(struct device *dev,
+	     struct device_attribute *attr, const char *buf, size_t count)
+{
+	return count;
+}
+
+static DEVICE_ATTR(max_brightness, 0444, show_max_brightness,
+		   ignore_store);
 static DEVICE_ATTR(lcd_level, 0644, show_lcd_level, store_lcd_level);
+static DEVICE_ATTR(lcd_level_alt, 0644, show_lcd_level_alt,
+		   store_lcd_level_alt);
 
 static struct attribute *fujitsupf_attributes[] = {
+	&dev_attr_max_brightness.attr,
 	&dev_attr_lcd_level.attr,
+	&dev_attr_lcd_level_alt.attr,
 	NULL
 };
 
@@ -194,22 +394,61 @@ static struct platform_driver fujitsupf_driver = {
 
 /* ACPI device */
 
-static int acpi_fujitsu_add(struct acpi_device *device)
+static int acpi_fujitsu_add_b1(struct acpi_device *device)
 {
+	acpi_status status;
 	int result = 0;
 	int state = 0;
+	struct input_dev *input;
+	int error;
 
-	ACPI_FUNCTION_TRACE("acpi_fujitsu_add");
+	ACPI_FUNCTION_TRACE("acpi_fujitsu_add_b1");
 
 	if (!device)
 		return -EINVAL;
 
-	fujitsu->acpi_handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_FUJITSU_DEVICE_NAME);
+	fujitsu->acpi_handle_b1 = device->handle;
+	sprintf(acpi_device_name(device), "%s",
+		ACPI_FUJITSUB1_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
 	acpi_driver_data(device) = fujitsu;
 
-	result = acpi_bus_get_power(fujitsu->acpi_handle, &state);
+	status = acpi_install_notify_handler(device->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_fujitsu_notify_b1,
+					     fujitsu);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing notify handler\n"));
+		error = -ENODEV;
+		goto err_stop;
+	}
+
+	fujitsu->input_b1 = input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		goto err_uninstall_notify;
+	}
+
+	snprintf(fujitsu->phys_b1, sizeof(fujitsu->phys_b1),
+		 "%s/video/input0", acpi_device_hid(device));
+
+	input->name = acpi_device_name(device);
+	input->phys = fujitsu->phys_b1;
+	input->id.bustype = BUS_HOST;
+	input->id.product = 0x06;
+	input->dev.parent = &device->dev;
+	input->evbit[0] = BIT(EV_KEY);
+	set_bit(KEY_BRIGHTNESSUP, input->keybit);
+	set_bit(KEY_BRIGHTNESSDOWN, input->keybit);
+	set_bit(KEY_UNKNOWN, input->keybit);
+
+	error = input_register_device(input);
+	if (error)
+		goto err_free_input_dev;
+
+	result = acpi_bus_get_power(fujitsu->acpi_handle_b1, &state);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Error reading power state\n"));
@@ -220,42 +459,311 @@ static int acpi_fujitsu_add(struct acpi_device
*device)
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
 
+	if (get_max_brightness() <= 0)
+		fujitsu->max_brightness = FUJITSU_LCD_N_LEVELS;
+
+	fujitsu->dev_b1 = device;
+
+	return result;
+
       end:
+      err_free_input_dev:
+	input_free_device(input);
+      err_uninstall_notify:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_fujitsu_notify_b1);
+      err_stop:
 
 	return result;
 }
 
-static int acpi_fujitsu_remove(struct acpi_device *device, int type)
+static int acpi_fujitsu_remove_b1(struct acpi_device *device, int type)
 {
-	ACPI_FUNCTION_TRACE("acpi_fujitsu_remove");
+	acpi_status status;
+	struct fujitsu_t *fujitsu = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_fujitsu_remove_b1");
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
-	fujitsu->acpi_handle = 0;
+
+	fujitsu = acpi_driver_data(device);
+
+	status = acpi_remove_notify_handler(fujitsu->acpi_handle_b1,
+					    ACPI_DEVICE_NOTIFY,
+					    acpi_fujitsu_notify_b1);
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	fujitsu->acpi_handle_b1 = 0;
 
 	return 0;
 }
 
-static const struct acpi_device_id fujitsu_device_ids[] = {
-	{ACPI_FUJITSU_HID, 0},
+static const struct acpi_device_id fujitsu_device_ids_b1[] = {
+	{ACPI_FUJITSUB1_HID, 0},
 	{"", 0},
 };
 
-static struct acpi_driver acpi_fujitsu_driver = {
-	.name = ACPI_FUJITSU_DRIVER_NAME,
+static struct acpi_driver acpi_fujitsu_driver_b1 = {
+	.name = ACPI_FUJITSUB1_DRIVER_NAME,
 	.class = ACPI_FUJITSU_CLASS,
-	.ids = fujitsu_device_ids,
+	.ids = fujitsu_device_ids_b1,
 	.ops = {
-		.add = acpi_fujitsu_add,
-		.remove = acpi_fujitsu_remove,
+		.add = acpi_fujitsu_add_b1,
+		.remove = acpi_fujitsu_remove_b1,
+		},
+};
+
+static int acpi_fujitsu_add_e3(struct acpi_device *device)
+{
+	acpi_status status;
+	int result = 0;
+	int state = 0;
+	struct input_dev *input;
+	int error;
+
+	ACPI_FUNCTION_TRACE("acpi_fujitsu_add_e3");
+
+	if (!device)
+		return -EINVAL;
+
+	fujitsu->acpi_handle_e3 = device->handle;
+	sprintf(acpi_device_name(device), "%s",
+		ACPI_FUJITSUE3_DEVICE_NAME);
+	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
+	acpi_driver_data(device) = fujitsu;
+
+	status = acpi_install_notify_handler(device->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_fujitsu_notify_e3,
+					     fujitsu);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing notify handler\n"));
+		error = -ENODEV;
+		goto err_stop;
+	}
+
+	fujitsu->input_e3 = input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		goto err_uninstall_notify;
+	}
+
+	snprintf(fujitsu->phys_e3, sizeof(fujitsu->phys_e3),
+		 "%s/video/input0", acpi_device_hid(device));
+
+	input->name = acpi_device_name(device);
+	input->phys = fujitsu->phys_e3;
+	input->id.bustype = BUS_HOST;
+	input->id.product = 0x06;
+	input->dev.parent = &device->dev;
+	input->evbit[0] = BIT(EV_KEY);
+	set_bit(KEY_SCREENLOCK, input->keybit);
+	set_bit(KEY_MEDIA, input->keybit);
+	set_bit(KEY_EMAIL, input->keybit);
+	set_bit(KEY_SUSPEND, input->keybit);
+	set_bit(KEY_UNKNOWN, input->keybit);
+
+	error = input_register_device(input);
+	if (error)
+		goto err_free_input_dev;
+
+	result = acpi_bus_get_power(fujitsu->acpi_handle_e3, &state);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error reading power state\n"));
+		goto end;
+	}
+
+	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
+	       acpi_device_name(device), acpi_device_bid(device),
+	       !device->power.state ? "on" : "off");
+
+	fujitsu->dev_e3 = device;
+
+	return result;
+
+      end:
+      err_free_input_dev:
+	input_free_device(input);
+      err_uninstall_notify:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_fujitsu_notify_e3);
+      err_stop:
+
+	return result;
+}
+
+static int acpi_fujitsu_remove_e3(struct acpi_device *device, int type)
+{
+	acpi_status status;
+	struct fujitsu_t *fujitsu = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_fujitsu_remove_e3");
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	fujitsu = acpi_driver_data(device);
+
+	status = acpi_remove_notify_handler(fujitsu->acpi_handle_e3,
+					    ACPI_DEVICE_NOTIFY,
+					    acpi_fujitsu_notify_e3);
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	fujitsu->acpi_handle_e3 = 0;
+
+	return 0;
+}
+
+static const struct acpi_device_id fujitsu_device_ids_e3[] = {
+	{ACPI_FUJITSUE3_HID, 0},
+	{"", 0},
+};
+
+static struct acpi_driver acpi_fujitsu_driver_e3 = {
+	.name = ACPI_FUJITSUE3_DRIVER_NAME,
+	.class = ACPI_FUJITSU_CLASS,
+	.ids = fujitsu_device_ids_e3,
+	.ops = {
+		.add = acpi_fujitsu_add_e3,
+		.remove = acpi_fujitsu_remove_e3,
 		},
 };
 
 /* Initialization */
 
+static void
+acpi_fujitsu_notify_b1(acpi_handle handle, u32 event, void *data)
+{
+	struct input_dev *input;
+	int keycode;
+	int oldb, newb;
+
+	input = fujitsu->input_b1;
+
+	switch (event) {
+	case ACPI_FUJITSUB1_NOTIFY_CODE1:
+		oldb = fujitsu->brightness_level;
+		get_lcd_level(); /* the alt version always yields changed */
+		newb = fujitsu->brightness_level;
+
+		if (oldb == newb && fujitsu->brightness_changed) {
+			keycode = 0;
+			if (oldb == 0)
+			    keycode = KEY_BRIGHTNESSDOWN;
+			else if (oldb == (fujitsu->max_brightness)-1)
+			    keycode = KEY_BRIGHTNESSUP;
+		} else if (oldb < newb) {
+			if (fujitsu->usealt)
+				set_lcd_level_alt(newb);
+			else
+				set_lcd_level(newb);
+			acpi_bus_generate_proc_event(fujitsu->dev_b1,
+						     ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS,
+						     0);
+			keycode = KEY_BRIGHTNESSUP;
+		} else if (oldb > newb) {
+			if (fujitsu->usealt)
+				set_lcd_level_alt(newb);
+			else
+				set_lcd_level(newb);
+			acpi_bus_generate_proc_event(fujitsu->dev_b1,
+						     ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS,
+						     0);
+			keycode = KEY_BRIGHTNESSDOWN;
+		} else {
+			keycode = KEY_UNKNOWN;
+		}
+		break;
+	default:
+		keycode = KEY_UNKNOWN;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Unsupported event [0x%x]\n", event));
+		break;
+	}
+
+	if (keycode != 0) {
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+	}
+
+	return;
+}
+
+static void
+acpi_fujitsu_notify_e3(acpi_handle handle, u32 event, void *data)
+{
+	struct input_dev *input;
+	int keycode;
+	unsigned int irb;
+
+	input = fujitsu->input_e3;
+
+	switch (event) {
+	case ACPI_FUJITSUE3_NOTIFY_CODE1:
+		irb = get_irb();
+
+		switch (irb & 0x4ff) {
+		case LOCK_KEY:
+			keycode = KEY_SCREENLOCK;
+			break;
+		case DISPLAY_KEY:
+			keycode = KEY_MEDIA;
+			break;
+		case ENERGY_KEY:
+			keycode = KEY_EMAIL;
+			break;
+		case REST_KEY:
+			keycode = KEY_SUSPEND;
+			break;
+		default:
+			keycode = 0;
+			break;
+		}
+		break;
+	default:
+		keycode = KEY_UNKNOWN;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Unsupported event [0x%x]\n", event));
+		break;
+	}
+
+	if (keycode == KEY_UNKNOWN) {
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+	} else if (keycode == 0 && fujitsu->keycode_e3 != 0) {
+		input_report_key(input, fujitsu->keycode_e3, 0);
+		input_sync(input);
+		fujitsu->keycode_e3 = 0;
+	} else if (fujitsu->keycode_e3 != 0) {
+		input_report_key(input, fujitsu->keycode_e3, 0);
+		input_sync(input);
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		fujitsu->keycode_e3 = keycode;
+	} else {
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		fujitsu->keycode_e3 = keycode;
+	}
+
+	return;
+}
+
 static int __init fujitsu_init(void)
 {
-	int ret, result;
+	int ret, result, max_brightness;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -265,21 +773,38 @@ static int __init fujitsu_init(void)
 		return -ENOMEM;
 	memset(fujitsu, 0, sizeof(struct fujitsu_t));
 
-	result = acpi_bus_register_driver(&acpi_fujitsu_driver);
+	fujitsu->usealt = use_alt_lcd_levels != 0 ? 1 : 0;
+
+	result = acpi_bus_register_driver(&acpi_fujitsu_driver_b1);
+	if (result < 0) {
+		ret = -ENODEV;
+		goto fail_acpi_b1;
+	}
+
+	result = acpi_bus_register_driver(&acpi_fujitsu_driver_e3);
 	if (result < 0) {
 		ret = -ENODEV;
-		goto fail_acpi;
+		goto fail_acpi_e3;
 	}
 
 	/* Register backlight stuff */
 
-	fujitsu->bl_device =
-	    backlight_device_register("fujitsu-laptop", NULL, NULL,
-				      &fujitsubl_ops);
+	if (fujitsu->usealt) {
+		fujitsu->bl_device =
+		    backlight_device_register("fujitsu-laptop", NULL, NULL,
+					      &fujitsubl_ops_alt);
+	} else {
+		fujitsu->bl_device =
+		    backlight_device_register("fujitsu-laptop", NULL, NULL,
+					      &fujitsubl_ops);
+	}
 	if (IS_ERR(fujitsu->bl_device))
 		return PTR_ERR(fujitsu->bl_device);
 
-	fujitsu->bl_device->props.max_brightness = FUJITSU_LCD_N_LEVELS - 1;
+	max_brightness = fujitsu->max_brightness;
+
+	fujitsu->bl_device->props.max_brightness = max_brightness - 1;
+
 	ret = platform_driver_register(&fujitsupf_driver);
 	if (ret)
 		goto fail_backlight;
@@ -323,7 +848,11 @@ static int __init fujitsu_init(void)
 
 	backlight_device_unregister(fujitsu->bl_device);
 
-      fail_acpi:
+      fail_acpi_e3:
+
+	acpi_bus_unregister_driver(&acpi_fujitsu_driver_b1);
+
+      fail_acpi_b1:
 
 	kfree(fujitsu);
 
@@ -338,7 +867,8 @@ static void __exit fujitsu_cleanup(void)
 	platform_driver_unregister(&fujitsupf_driver);
 	backlight_device_unregister(fujitsu->bl_device);
 
-	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
+	acpi_bus_unregister_driver(&acpi_fujitsu_driver_e3);
+	acpi_bus_unregister_driver(&acpi_fujitsu_driver_b1);
 
 	kfree(fujitsu);
 
@@ -348,6 +878,10 @@ static void __exit fujitsu_cleanup(void)
 module_init(fujitsu_init);
 module_exit(fujitsu_cleanup);
 
+module_param(use_alt_lcd_levels, uint, 0644);
+MODULE_PARM_DESC(use_alt_lcd_levels,
+		 "Use alternative interface for lcd_levels (needed for Lifebook
s6410).");
+
 MODULE_AUTHOR("Jonathan Woithe");
 MODULE_DESCRIPTION("Fujitsu laptop extras support");
 MODULE_VERSION(FUJITSU_DRIVER_VERSION);


