From: Tony Vroon <tony@linx.net>
Subject: [PATCH RFT] Add backlight power control and radio state information
Date: Sun, 21 Dec 2008 18:48:44 +0000 (GMT)
Message-ID: <20081221184844.2001110076@gold.linx.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:49976 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbYLUSsq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Dec 2008 13:48:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Peter Gruber <nokos@gmx.net>, linux-acpi@vger.kernel.org

The DSDT of Fujitsu Lifebooks contains a FUNC interface through which the backlight 
can be powered on and off. The status of the radios (killed or on), the state of the 
lid (open/closed) and whether the laptop is docked can also be retrieved.
This patch exposes the backlight power control through the backlight class and the 
state information through individual platform files. Unfortunately the RFKILL interface 
within the kernel is not suitable for the specific implementation of radio control 
in these laptops (there is no individual radio on/off control, only a global switch 
that disables all radios in hardware and can not be overridden).
This logs BTNI as it is expected to contain more information about the application 
panel layout. It also logs LEDI as it is expected that we can control one or more 
LEDs in the future.

Signed-off-by: Tony Vroon <tony@linx.net>

--- linux-2.6/drivers/misc/fujitsu-laptop.c.orig	2008-12-09 15:19:19.000000000 +0000
+++ linux-2.6/drivers/misc/fujitsu-laptop.c	2008-12-21 18:25:15.000000000 +0000
@@ -3,6 +3,7 @@
 /*
   Copyright (C) 2007,2008 Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
   Copyright (C) 2008 Peter Gruber <nokos@gmx.net>
+  Copyright (C) 2008 Tony Vroon <tony@linx.net>
   Based on earlier work:
     Copyright (C) 2003 Shane Spencer <shane@bogomip.com>
     Adrian Yee <brewt-fujitsu@brewt.org>
@@ -66,7 +67,7 @@
 #include <linux/video_output.h>
 #include <linux/platform_device.h>
 
-#define FUJITSU_DRIVER_VERSION "0.4.3"
+#define FUJITSU_DRIVER_VERSION "0.5.0"
 
 #define FUJITSU_LCD_N_LEVELS 8
 
@@ -83,6 +84,12 @@
 #define ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS     0x86
 #define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS     0x87
 
+/* FUNC interface - command values */
+#define FUNC_RFKILL	0x1000
+#define FUNC_LEDS	0x1001
+#define FUNC_BUTTONS	0x1002
+#define FUNC_BACKLIGHT  0x1004
+
 /* Hotkey details */
 #define KEY1_CODE	0x410	/* codes for the keys in the GIRB register */
 #define KEY2_CODE	0x411
@@ -145,8 +152,7 @@
 	struct platform_device *pf_device;
 	struct kfifo *fifo;
 	spinlock_t fifo_lock;
-
-	unsigned int irb;	/* info about the pressed buttons */
+	int rfkill_state;
 };
 
 static struct fujitsu_hotkey_t *fujitsu_hotkey;
@@ -160,6 +166,54 @@
 
 static void acpi_fujitsu_notify(acpi_handle handle, u32 event, void *data);
 
+/* Fujitsu ACPI interface function */
+
+static int call_fujex_func(int cmd, int arg0, int arg1, int arg2)
+{
+	acpi_status status = AE_OK;
+	union acpi_object params[4] = {
+	{ .type = ACPI_TYPE_INTEGER },
+	{ .type = ACPI_TYPE_INTEGER },
+	{ .type = ACPI_TYPE_INTEGER },
+	{ .type = ACPI_TYPE_INTEGER }
+	};
+	struct acpi_object_list arg_list = { 4, &params[0] };
+	struct acpi_buffer output;
+	union acpi_object out_obj;
+	acpi_handle handle = NULL;
+
+	status = acpi_get_handle(fujitsu_hotkey->acpi_handle, "FUNC", &handle);
+	if (ACPI_FAILURE(status)) {
+		vdbg_printk(FUJLAPTOP_DBG_ERROR, "FUNC interface is not present\n");
+		return -ENODEV;
+	}
+
+	params[0].integer.value = cmd;
+	params[1].integer.value = arg0;
+	params[2].integer.value = arg1;
+	params[3].integer.value = arg2;
+
+	output.length = sizeof(out_obj);
+	output.pointer = &out_obj;
+
+	status = acpi_evaluate_object(handle, NULL, &arg_list, &output);
+	if (ACPI_FAILURE(status)) {
+		vdbg_printk(FUJLAPTOP_DBG_WARN, "FUNC 0x%x (args 0x%x, 0x%x, 0x%x) call failed\n",
+				cmd, arg0, arg1, arg2);
+		return -ENODEV;
+	}
+
+	if (out_obj.type != ACPI_TYPE_INTEGER) {
+		vdbg_printk(FUJLAPTOP_DBG_WARN, "FUNC 0x%x (args 0x%x, 0x%x, 0x%x) did not return an integer\n",
+				cmd, arg0, arg1, arg2);
+		return -ENODEV;
+	}
+
+	vdbg_printk(FUJLAPTOP_DBG_TRACE, "FUNC 0x%x (args 0x%x, 0x%x, 0x%x) returned 0x%x\n", cmd, arg0, arg1,
+				arg2, (int)out_obj.integer.value);
+	return out_obj.integer.value;
+}
+
 /* Hardware access for LCD brightness control */
 
 static int set_lcd_level(int level)
@@ -297,10 +351,21 @@
 
 static int bl_update_status(struct backlight_device *b)
 {
+	int ret;
+	if (b->props.power == 4)
+		ret = call_fujex_func(FUNC_BACKLIGHT,0x1,0x4,0x3);
+	else
+		ret = call_fujex_func(FUNC_BACKLIGHT,0x1,0x4,0x0);
+	if (ret != 0)
+		vdbg_printk(FUJLAPTOP_DBG_ERROR, "Unable to adjust backlight power, error code %i\n", ret);
+
 	if (use_alt_lcd_levels)
-		return set_lcd_level_alt(b->props.brightness);
+		ret = set_lcd_level_alt(b->props.brightness);
 	else
-		return set_lcd_level(b->props.brightness);
+		ret = set_lcd_level(b->props.brightness);
+	if (ret != 0)
+		vdbg_printk(FUJLAPTOP_DBG_ERROR, "Unable to adjust LCD brightness, error code %i\n", ret);
+	return ret;
 }
 
 static struct backlight_ops fujitsubl_ops = {
@@ -382,42 +447,59 @@
 	return count;
 }
 
-/* Hardware access for hotkey device */
-
-static int get_irb(void)
+static ssize_t
+ignore_store(struct device *dev,
+	     struct device_attribute *attr, const char *buf, size_t count)
 {
-	unsigned long long state = 0;
-	acpi_status status = AE_OK;
-
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "Get irb\n");
+	return count;
+}
 
-	status =
-	    acpi_evaluate_integer(fujitsu_hotkey->acpi_handle, "GIRB", NULL,
-				  &state);
-	if (status < 0)
-		return status;
 
-	fujitsu_hotkey->irb = state;
+static ssize_t
+show_lid_state(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	if (fujitsu_hotkey->rfkill_state & 0x100)
+		return sprintf(buf, "open\n");
+	else
+		return sprintf(buf, "closed\n");
+}
 
-	return fujitsu_hotkey->irb;
+static ssize_t
+show_dock_state(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	if (fujitsu_hotkey->rfkill_state & 0x200)
+		return sprintf(buf, "docked\n");
+	else
+		return sprintf(buf, "undocked\n");
 }
 
 static ssize_t
-ignore_store(struct device *dev,
-	     struct device_attribute *attr, const char *buf, size_t count)
+show_radios_state(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
-	return count;
+	if (fujitsu_hotkey->rfkill_state & 0x20)
+		return sprintf(buf, "on\n");
+	else
+		return sprintf(buf, "killed\n");
 }
 
 static DEVICE_ATTR(max_brightness, 0444, show_max_brightness, ignore_store);
 static DEVICE_ATTR(brightness_changed, 0444, show_brightness_changed,
 		   ignore_store);
 static DEVICE_ATTR(lcd_level, 0644, show_lcd_level, store_lcd_level);
+static DEVICE_ATTR(lid, 0444, show_lid_state, ignore_store);
+static DEVICE_ATTR(dock, 0444, show_dock_state, ignore_store);
+static DEVICE_ATTR(radios, 0444, show_radios_state, ignore_store);
 
 static struct attribute *fujitsupf_attributes[] = {
 	&dev_attr_brightness_changed.attr,
 	&dev_attr_max_brightness.attr,
 	&dev_attr_lcd_level.attr,
+	&dev_attr_lid.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_radios.attr,
 	NULL
 };
 
@@ -771,7 +853,8 @@
 	input->id.bustype = BUS_HOST;
 	input->id.product = 0x06;
 	input->dev.parent = &device->dev;
-	input->evbit[0] = BIT(EV_KEY);
+
+	set_bit(EV_KEY, input->evbit);
 	set_bit(fujitsu->keycode1, input->keybit);
 	set_bit(fujitsu->keycode2, input->keybit);
 	set_bit(fujitsu->keycode3, input->keybit);
@@ -804,9 +887,21 @@
 	}
 
 	i = 0;			/* Discard hotkey ringbuffer */
-	while (get_irb() != 0 && (i++) < MAX_HOTKEY_RINGBUFFER_SIZE) ;
+	while (call_fujex_func(FUNC_BUTTONS,0x1,0x0,0x0) != 0 && (i++) < MAX_HOTKEY_RINGBUFFER_SIZE) ;
 	vdbg_printk(FUJLAPTOP_DBG_INFO, "Discarded %i ringbuffer entries\n", i);
 
+	/* Sync RFKILL state */
+	fujitsu_hotkey->rfkill_state = 
+		call_fujex_func(FUNC_RFKILL,0x4,0x0,0x0);
+
+	/* Suspect this is a keymap of the application panel, print it */
+	printk(KERN_INFO "fujitsu-laptop: BTNI: [0x%x]\n",
+		call_fujex_func(FUNC_BUTTONS,0x0,0x0,0x0));
+
+	/* We will need this for LED control later, print it */
+	printk(KERN_INFO "fujitsu-laptop: LEDI: [0x%x]\n",
+		call_fujex_func(FUNC_LEDS,0x0,0x0,0x0));
+
 	return result;
 
 end:
@@ -852,12 +947,12 @@
 
 	input = fujitsu_hotkey->input;
 
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "Hotkey event\n");
+	fujitsu_hotkey->rfkill_state = call_fujex_func(FUNC_RFKILL,0x4,0x0,0x0);
 
 	switch (event) {
 	case ACPI_FUJITSU_NOTIFY_CODE1:
 		i = 0;
-		while ((irb = get_irb()) != 0
+		while ((irb = call_fujex_func(FUNC_BUTTONS,0x1,0x0,0x0)) != 0
 		       && (i++) < MAX_HOTKEY_RINGBUFFER_SIZE) {
 			vdbg_printk(FUJLAPTOP_DBG_TRACE, "GIRB result [%x]\n",
 				    irb);
@@ -1035,6 +1130,15 @@
 		goto fail_hotkey1;
 	}
 
+	/* Sync backlight power status (needs FUJ02E3 device, hence deferred) */
+
+	if (!acpi_video_backlight_support()) {
+		if (call_fujex_func(FUNC_BACKLIGHT,0x2,0x4,0x0) == 3)
+			fujitsu->bl_device->props.power = 4;
+		else
+			fujitsu->bl_device->props.power = 0;
+	}
+
 	printk(KERN_INFO "fujitsu-laptop: driver " FUJITSU_DRIVER_VERSION
 	       " successfully loaded.\n");
 
@@ -1108,7 +1212,7 @@
 MODULE_PARM_DESC(debug, "Sets debug level bit-mask");
 #endif
 
-MODULE_AUTHOR("Jonathan Woithe, Peter Gruber");
+MODULE_AUTHOR("Jonathan Woithe, Peter Gruber, Tony Vroon");
 MODULE_DESCRIPTION("Fujitsu laptop extras support");
 MODULE_VERSION(FUJITSU_DRIVER_VERSION);
 MODULE_LICENSE("GPL");
