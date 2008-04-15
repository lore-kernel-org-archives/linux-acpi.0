From: nokos@gmx.net
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Tue, 15 Apr 2008 11:36:40 +0200
Message-ID: <1208252200.20860.9.camel@earth.gruber.myown>
References: <20080305030147.GA25310@earth.gruber.myown>
	 <1207784442.32532.0.camel@earth.gruber.myown>
	 <1208103760.19605.5.camel@earth.gruber.myown>
	 <1208169984.1784.37.camel@queen.suse.de>
	 <1208193500.11305.17.camel@earth.gruber.myown>
	 <1208195761.1784.95.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:36572 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757027AbYDOJhG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2008 05:37:06 -0400
In-Reply-To: <1208195761.1784.95.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Here is a modularized version of the patch, it also includes autodetection of S6410 
to switch between the brightness interface (can be overridden by module parameter) 

Jonathan can you test it if it doesn't break anything on the S7020?

Am Montag, den 14.04.2008, 19:56 +0200 schrieb Thomas Renninger:
> I do not have that much time currently, if you like I can go through the
> code again after you split it into two parts.
> Then it should be much easier to read...
> 

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index ea92bac..b2a73fa 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -448,6 +448,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 	     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Fujitsu Siemens",
+	.matches = {
+	             DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+	             DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S6410"),
+	         },
+	},
 	/*
 	 * Disable OSI(Linux) warnings on all "Hewlett-Packard"
 	 *
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 962817e..105490e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -155,6 +155,17 @@ config FUJITSU_LAPTOP
 
 	  If you have a Fujitsu laptop, say Y or M here.
 
+config FUJITSU_LAPTOP_HOTKEY
+        tristate "Fujitsu Laptop Hotkeys"
+        depends on X86
+        depends on ACPI
+        ---help---
+	  This is a driver for the hotkeys on laptops built by Fujitsu:
+
+	    * Tested with S6410
+
+	  If you have a S6410 Fujitsu laptop, say Y or M here.
+
 config TC1100_WMI
 	tristate "HP Compaq TC1100 Tablet WMI Extras (EXPERIMENTAL)"
 	depends on X86 && !X86_64
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3b12f5d..ff8e88e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
 obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_FUJITSU_LAPTOP)	+= fujitsu-laptop.o
+obj-$(CONFIG_FUJITSU_LAPTOP_HOTKEY)	+= fujitsu-laptop-hotkey.o
 obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
 obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
 obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
diff --git a/drivers/misc/fujitsu-laptop-hotkey.c b/drivers/misc/fujitsu-laptop-hotkey.c
new file mode 100644
index 0000000..9137536
--- /dev/null
+++ b/drivers/misc/fujitsu-laptop-hotkey.c
@@ -0,0 +1,321 @@
+/*-*-linux-c-*-*/
+
+/*
+  Copyright (C) 2008 Peter Gruber <nokos@gmx.net>
+
+  Templated from fujitsu-laptop.c which is copyright by its respective authors.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+  02110-1301, USA.
+ */
+
+/*
+ * fujitsu-laptop-hotkey.c - Fujitsu laptop hotkey support, providing access to
+ * additional features made available on a range of Fujitsu laptops including
+ * the S6xxx series.
+ *
+ * This driver has been tested on a Fujitsu Lifebook S6410.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/input.h>
+
+#define FUJITSU_DRIVER_VERSION "0.3"
+
+#define ACPI_FUJITSU_CLASS              "fujitsu"
+
+#define ACPI_FUJITSUE3_DRIVER_NAME        "Fujitsu laptop ACPI extras hotkey driver"
+#define ACPI_FUJITSUE3_HID                "FUJ02E3"
+#define ACPI_FUJITSUE3_DEVICE_NAME        "Fujitsu FUJ02E3"
+
+#define ACPI_FUJITSUE3_NOTIFY_CODE1	0x80
+
+#define LOCK_KEY	0x410 /* codes for the keys in the GIRB register */
+#define DISPLAY_KEY	0x411 /* keys are mapped to KEY_SCREENLOCK (the key with the key symbol) */
+#define ENERGY_KEY	0x412 /* KEY_MEDIA (the key with the laptop symbol, KEY_EMAIL (E key)) */
+#define REST_KEY	0x413 /* KEY_SUSPEND (R key)*/
+
+struct fujitsu_t {
+	int usealt;		/* use the alternative brightness interface */
+	acpi_handle acpi_handle;
+	struct acpi_device *dev;
+	struct input_dev *input;
+	char phys[32];
+	struct platform_device *pf_device;
+	int keycode;		/* remember keycode for release */
+
+	unsigned int irb;	/* info about the pressed buttons */
+};
+
+static struct fujitsu_t *fujitsu;
+
+static void acpi_fujitsu_notify(acpi_handle handle, u32 event,
+				   void *data);
+
+/* Hardware access */
+
+static int get_irb(void)
+{
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	status =
+	    acpi_evaluate_integer(fujitsu->acpi_handle, "GIRB", NULL,
+				  &state);
+	if (status < 0)
+		return status;
+
+	fujitsu->irb = state;
+
+	return fujitsu->irb;
+}
+
+/* ACPI device */
+
+static int acpi_fujitsu_add(struct acpi_device *device)
+{
+	acpi_status status;
+	int result = 0;
+	int state = 0;
+	struct input_dev *input;
+	int error;
+
+	ACPI_FUNCTION_TRACE("acpi_fujitsu_add");
+
+	if (!device)
+		return -EINVAL;
+
+	fujitsu->acpi_handle = device->handle;
+	sprintf(acpi_device_name(device), "%s",
+		ACPI_FUJITSUE3_DEVICE_NAME);
+	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
+	acpi_driver_data(device) = fujitsu;
+
+	status = acpi_install_notify_handler(device->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_fujitsu_notify,
+					     fujitsu);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing notify handler\n"));
+		error = -ENODEV;
+		goto err_stop;
+	}
+
+	fujitsu->input = input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		goto err_uninstall_notify;
+	}
+
+	snprintf(fujitsu->phys, sizeof(fujitsu->phys),
+		 "%s/video/input0", acpi_device_hid(device));
+
+	input->name = acpi_device_name(device);
+	input->phys = fujitsu->phys;
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
+	result = acpi_bus_get_power(fujitsu->acpi_handle, &state);
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
+	fujitsu->dev = device;
+
+	return result;
+
+      end:
+      err_free_input_dev:
+	input_free_device(input);
+      err_uninstall_notify:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_fujitsu_notify);
+      err_stop:
+
+	return result;
+}
+
+static int acpi_fujitsu_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+	struct fujitsu_t *fujitsu = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_fujitsu_remove");
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	fujitsu = acpi_driver_data(device);
+
+	status = acpi_remove_notify_handler(fujitsu->acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    acpi_fujitsu_notify);
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	fujitsu->acpi_handle = NULL;
+
+	return 0;
+}
+
+static const struct acpi_device_id fujitsu_device_ids[] = {
+	{ACPI_FUJITSUE3_HID, 0},
+	{"", 0},
+};
+
+static struct acpi_driver acpi_fujitsu_driver = {
+	.name = ACPI_FUJITSUE3_DRIVER_NAME,
+	.class = ACPI_FUJITSU_CLASS,
+	.ids = fujitsu_device_ids,
+	.ops = {
+		.add = acpi_fujitsu_add,
+		.remove = acpi_fujitsu_remove,
+		},
+};
+
+/* Initialization */
+
+static void
+acpi_fujitsu_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct input_dev *input;
+	int keycode;
+	unsigned int irb;
+
+	input = fujitsu->input;
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
+	} else if (keycode == 0 && fujitsu->keycode != 0) {
+		input_report_key(input, fujitsu->keycode, 0);
+		input_sync(input);
+		fujitsu->keycode = 0;
+	} else if (fujitsu->keycode != 0) {
+		input_report_key(input, fujitsu->keycode, 0);
+		input_sync(input);
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		fujitsu->keycode = keycode;
+	} else {
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		fujitsu->keycode = keycode;
+	}
+
+	return;
+}
+
+static int __init fujitsu_init(void)
+{
+	int ret, result;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	fujitsu = kmalloc(sizeof(struct fujitsu_t), GFP_KERNEL);
+	if (!fujitsu)
+		return -ENOMEM;
+	memset(fujitsu, 0, sizeof(struct fujitsu_t));
+
+	result = acpi_bus_register_driver(&acpi_fujitsu_driver);
+	if (result < 0) {
+		ret = -ENODEV;
+		goto fail_acpi;
+	}
+
+	printk(KERN_INFO "fujitsu-laptop-hotkey: driver " FUJITSU_DRIVER_VERSION
+	       " successfully loaded.\n");
+
+	return 0;
+
+      fail_acpi:
+
+	kfree(fujitsu);
+
+	return ret;
+}
+
+static void __exit fujitsu_cleanup(void)
+{
+	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
+
+	kfree(fujitsu);
+
+	printk(KERN_INFO "fujitsu-laptop-hotkey: driver unloaded.\n");
+}
+
+module_init(fujitsu_init);
+module_exit(fujitsu_cleanup);
+
+MODULE_AUTHOR("Peter Gruber");
+MODULE_DESCRIPTION("Fujitsu laptop hotkey support");
+MODULE_VERSION(FUJITSU_DRIVER_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index e2e7c05..9a80d29 100644
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
+ * The moduleparameter use_alt_lcd_levels switches between different ACPI
+ * brightness controls. With use_alt_lcd_levels=1 it has been testen on
+ * a Fujitsu Lifebook S6410. Here it also provides an input device for the
+ * extra buttons found on that laptop.
+ *
  */
 
 #include <linux/module.h>
@@ -49,6 +56,8 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/backlight.h>
+#include <linux/input.h>
+#include <linux/video_output.h>
 #include <linux/platform_device.h>
 
 #define FUJITSU_DRIVER_VERSION "0.3"
@@ -56,21 +65,36 @@
 #define FUJITSU_LCD_N_LEVELS 8
 
 #define ACPI_FUJITSU_CLASS              "fujitsu"
-#define ACPI_FUJITSU_HID                "FUJ02B1"
-#define ACPI_FUJITSU_DRIVER_NAME        "Fujitsu laptop FUJ02B1 ACPI extras driver"
-#define ACPI_FUJITSU_DEVICE_NAME        "Fujitsu FUJ02B1"
+
+#define ACPI_FUJITSUB1_DRIVER_NAME        "Fujitsu laptop ACPI extras driver"
+#define ACPI_FUJITSUB1_HID                "FUJ02B1"
+#define ACPI_FUJITSUB1_DEVICE_NAME        "Fujitsu FUJ02B1"
+
+#define ACPI_FUJITSUB1_NOTIFY_CODE1	0x80
+
+#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x86
+#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x87
 
 struct fujitsu_t {
+	int usealt;		/* use the alternative brightness interface */
 	acpi_handle acpi_handle;
+	struct acpi_device *dev;
+	struct input_dev *input;
+	char phys[32];
 	struct backlight_device *bl_device;
 	struct platform_device *pf_device;
 
-	unsigned long fuj02b1_state;
+	unsigned int max_brightness;
 	unsigned int brightness_changed;
 	unsigned int brightness_level;
+	unsigned int irb;	/* info about the pressed buttons */
 };
 
 static struct fujitsu_t *fujitsu;
+static int use_alt_lcd_levels = -1;
+
+static void acpi_fujitsu_notify(acpi_handle handle, u32 event,
+				   void *data);
 
 /* Hardware access */
 
@@ -81,7 +105,7 @@ static int set_lcd_level(int level)
 	struct acpi_object_list arg_list = { 1, &arg0 };
 	acpi_handle handle = NULL;
 
-	if (level < 0 || level >= FUJITSU_LCD_N_LEVELS)
+	if (level < 0 || level >= fujitsu->max_brightness)
 		return -EINVAL;
 
 	if (!fujitsu)
@@ -102,18 +126,45 @@ static int set_lcd_level(int level)
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
+	status = acpi_get_handle(fujitsu->acpi_handle, "SBL2", &handle);
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
+	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL,
+				  &state);
 	if (status < 0)
 		return status;
 
-	fujitsu->fuj02b1_state = state;
 	fujitsu->brightness_level = state & 0x0fffffff;
 
 	if (state & 0x80000000)
@@ -124,8 +175,61 @@ static int get_lcd_level(void)
 	return fujitsu->brightness_level;
 }
 
+static int get_max_brightness(void)
+{
+	unsigned long state = 0;
+	acpi_status status = AE_OK;
+
+	status =
+	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL,
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
+	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLS", NULL,
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
@@ -143,8 +247,56 @@ static struct backlight_ops fujitsubl_ops = {
 
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
@@ -156,15 +308,16 @@ static ssize_t show_lcd_level(struct device *dev,
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
@@ -174,10 +327,23 @@ static ssize_t store_lcd_level(struct device *dev,
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
 
@@ -196,8 +362,11 @@ static struct platform_driver fujitsupf_driver = {
 
 static int acpi_fujitsu_add(struct acpi_device *device)
 {
+	acpi_status status;
 	int result = 0;
 	int state = 0;
+	struct input_dev *input;
+	int error;
 
 	ACPI_FUNCTION_TRACE("acpi_fujitsu_add");
 
@@ -205,10 +374,46 @@ static int acpi_fujitsu_add(struct acpi_device *device)
 		return -EINVAL;
 
 	fujitsu->acpi_handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_FUJITSU_DEVICE_NAME);
+	sprintf(acpi_device_name(device), "%s",
+		ACPI_FUJITSUB1_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
 	acpi_driver_data(device) = fujitsu;
 
+	status = acpi_install_notify_handler(device->handle,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_fujitsu_notify,
+					     fujitsu);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing notify handler\n"));
+		error = -ENODEV;
+		goto err_stop;
+	}
+
+	fujitsu->input = input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		goto err_uninstall_notify;
+	}
+
+	snprintf(fujitsu->phys, sizeof(fujitsu->phys),
+		 "%s/video/input0", acpi_device_hid(device));
+
+	input->name = acpi_device_name(device);
+	input->phys = fujitsu->phys;
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
 	result = acpi_bus_get_power(fujitsu->acpi_handle, &state);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
@@ -220,29 +425,55 @@ static int acpi_fujitsu_add(struct acpi_device *device)
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
 
+	if (get_max_brightness() <= 0)
+		fujitsu->max_brightness = FUJITSU_LCD_N_LEVELS;
+
+	fujitsu->dev = device;
+
+	return result;
+
       end:
+      err_free_input_dev:
+	input_free_device(input);
+      err_uninstall_notify:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_fujitsu_notify);
+      err_stop:
 
 	return result;
 }
 
 static int acpi_fujitsu_remove(struct acpi_device *device, int type)
 {
+	acpi_status status;
+	struct fujitsu_t *fujitsu = NULL;
+
 	ACPI_FUNCTION_TRACE("acpi_fujitsu_remove");
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
+
+	fujitsu = acpi_driver_data(device);
+
+	status = acpi_remove_notify_handler(fujitsu->acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    acpi_fujitsu_notify);
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
 	fujitsu->acpi_handle = NULL;
 
 	return 0;
 }
 
 static const struct acpi_device_id fujitsu_device_ids[] = {
-	{ACPI_FUJITSU_HID, 0},
+	{ACPI_FUJITSUB1_HID, 0},
 	{"", 0},
 };
 
 static struct acpi_driver acpi_fujitsu_driver = {
-	.name = ACPI_FUJITSU_DRIVER_NAME,
+	.name = ACPI_FUJITSUB1_DRIVER_NAME,
 	.class = ACPI_FUJITSU_CLASS,
 	.ids = fujitsu_device_ids,
 	.ops = {
@@ -253,9 +484,88 @@ static struct acpi_driver acpi_fujitsu_driver = {
 
 /* Initialization */
 
+static int dmi_check_cb(const struct dmi_system_id *id)
+{
+        printk("fujitsu-laptop: Identified laptop model '%s'.\n", id->ident);
+        return 0;
+}
+
+static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
+	{
+	        .ident = "Fujitsu Siemens",
+		.matches = {
+	             DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+	             DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S6410"),
+		},
+		.callback = dmi_check_cb
+	},
+	{ }
+};
+
+
+static void
+acpi_fujitsu_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct input_dev *input;
+	int keycode;
+	int oldb, newb;
+
+	input = fujitsu->input;
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
+			acpi_bus_generate_proc_event(fujitsu->dev,
+						     ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS,
+						     0);
+			keycode = KEY_BRIGHTNESSUP;
+		} else if (oldb > newb) {
+			if (fujitsu->usealt)
+				set_lcd_level_alt(newb);
+			else
+				set_lcd_level(newb);
+			acpi_bus_generate_proc_event(fujitsu->dev,
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
 static int __init fujitsu_init(void)
 {
-	int ret, result;
+	int ret, result, max_brightness;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -265,6 +575,11 @@ static int __init fujitsu_init(void)
 		return -ENOMEM;
 	memset(fujitsu, 0, sizeof(struct fujitsu_t));
 
+	if (use_alt_lcd_levels==-1)
+                fujitsu->usealt = dmi_check_system(fujitsu_dmi_table);
+        else
+	        fujitsu->usealt = use_alt_lcd_levels != 0 ? 1 : 0;
+
 	result = acpi_bus_register_driver(&acpi_fujitsu_driver);
 	if (result < 0) {
 		ret = -ENODEV;
@@ -273,13 +588,22 @@ static int __init fujitsu_init(void)
 
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
@@ -322,6 +646,7 @@ static int __init fujitsu_init(void)
       fail_backlight:
 
 	backlight_device_unregister(fujitsu->bl_device);
+	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
 
       fail_acpi:
 
@@ -348,6 +673,10 @@ static void __exit fujitsu_cleanup(void)
 module_init(fujitsu_init);
 module_exit(fujitsu_cleanup);
 
+module_param(use_alt_lcd_levels, uint, 0644);
+MODULE_PARM_DESC(use_alt_lcd_levels,
+		 "Use alternative interface for lcd_levels (needed for Lifebook s6410).");
+
 MODULE_AUTHOR("Jonathan Woithe");
 MODULE_DESCRIPTION("Fujitsu laptop extras support");
 MODULE_VERSION(FUJITSU_DRIVER_VERSION);


