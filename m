From: Tony Vroon <tony@linx.net>
Subject: [PATCH RFT] fujitsu-laptop: Add BL power, LED control and radio state information
Date: Mon, 29 Dec 2008 18:56:05 +0000 (GMT)
Message-ID: <20081229185605.BF1DF10080@gold.linx.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:40612 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbYL2S4K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Dec 2008 13:56:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Stephen Gildea <stepheng+linux@gildea.com>
Cc: Peter Gruber <nokos@gmx.net>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

The DSDT of Fujitsu Lifebooks contains a FUNC interface through which the backlight 
can be powered on and off. The status of the radios (killed or on), the state of the 
lid (open/closed) and whether the laptop is docked can also be retrieved.
This patch exposes the backlight power control through the backlight class and the 
state information through individual platform files. Unfortunately the RFKILL interface 
within the kernel is not suitable for the specific implementation of radio control 
in these laptops (there is no individual radio on/off control, only a global switch 
that disables all radios in hardware and can not be overridden).
Netbooks such as the U810 expose keyboard headlamps and some P-series have an 
illuminated Fujitsu logo with multiple states. The P-series support was fine-tuned 
with thanks to testing and code changes by Stephen Gildea.

LED class support is optional as most laptops (particularly Lifebook machines in the 
S series) do not expose any controllable LEDs at all. A phantom bit 9 LED (keyboard 
lamps) is present on some machines. This bug is detected and worked around.

Jonathan, if this passes your testing please forward it on to Len Brown ASAP for 
inclusion in 2.6.29 (the merge window is open so time is of the essence). Stephen, 
please add a Tested-By header if this works right on your P8010. Julian, same 
request for the U810.

Signed-off-by: Stephen Gildea <stepheng+linux@gildea.com>
Signed-off-by: Tony Vroon <tony@linx.net>

--- linux-2.6/drivers/misc/fujitsu-laptop.c.orig	2008-12-29 16:21:36.000000000 +0000
+++ linux-2.6/drivers/misc/fujitsu-laptop.c	2008-12-29 18:37:52.000000000 +0000
@@ -3,6 +3,7 @@
 /*
   Copyright (C) 2007,2008 Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
   Copyright (C) 2008 Peter Gruber <nokos@gmx.net>
+  Copyright (C) 2008 Tony Vroon <tony@linx.net>
   Based on earlier work:
     Copyright (C) 2003 Shane Spencer <shane@bogomip.com>
     Adrian Yee <brewt-fujitsu@brewt.org>
@@ -65,8 +66,11 @@
 #include <linux/kfifo.h>
 #include <linux/video_output.h>
 #include <linux/platform_device.h>
+#ifdef CONFIG_LEDS_CLASS
+#include <linux/leds.h>
+#endif
 
-#define FUJITSU_DRIVER_VERSION "0.4.3"
+#define FUJITSU_DRIVER_VERSION "0.5.0"
 
 #define FUJITSU_LCD_N_LEVELS 8
 
@@ -83,6 +87,24 @@
 #define ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS     0x86
 #define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS     0x87
 
+/* FUNC interface - command values */
+#define FUNC_RFKILL	0x1000
+#define FUNC_LEDS	0x1001
+#define FUNC_BUTTONS	0x1002
+#define FUNC_BACKLIGHT  0x1004
+
+/* FUNC interface - responses */
+#define UNSUPPORTED_CMD 0x80000000
+
+#ifdef CONFIG_LEDS_CLASS
+/* FUNC interface - LED control */
+#define FUNC_LED_OFF	0x1
+#define FUNC_LED_ON	0x30001
+#define KEYBOARD_LAMPS	0x100
+#define LOGOLAMP_POWERON 0x2000
+#define LOGOLAMP_ALWAYS  0x4000
+#endif
+
 /* Hotkey details */
 #define KEY1_CODE	0x410	/* codes for the keys in the GIRB register */
 #define KEY2_CODE	0x411
@@ -145,8 +167,9 @@
 	struct platform_device *pf_device;
 	struct kfifo *fifo;
 	spinlock_t fifo_lock;
-
-	unsigned int irb;	/* info about the pressed buttons */
+	int rfkill_state;
+	int logolamp_registered;
+	int kblamps_registered;
 };
 
 static struct fujitsu_hotkey_t *fujitsu_hotkey;
@@ -154,12 +177,141 @@
 static void acpi_fujitsu_hotkey_notify(acpi_handle handle, u32 event,
 				       void *data);
 
+#ifdef CONFIG_LEDS_CLASS
+static enum led_brightness logolamp_get(struct led_classdev *cdev);
+static void logolamp_set(struct led_classdev *cdev,
+			       enum led_brightness brightness);
+
+struct led_classdev logolamp_led = {
+ .name = "fujitsu::logolamp",
+ .brightness_get = logolamp_get,
+ .brightness_set = logolamp_set
+};
+
+static enum led_brightness kblamps_get(struct led_classdev *cdev);
+static void kblamps_set(struct led_classdev *cdev,
+			       enum led_brightness brightness);
+
+struct led_classdev kblamps_led = {
+ .name = "fujitsu::kblamps",
+ .brightness_get = kblamps_get,
+ .brightness_set = kblamps_set
+};
+#endif
+
 #ifdef CONFIG_FUJITSU_LAPTOP_DEBUG
 static u32 dbg_level = 0x03;
 #endif
 
 static void acpi_fujitsu_notify(acpi_handle handle, u32 event, void *data);
 
+/* Fujitsu ACPI interface function */
+
+static int call_fext_func(int cmd, int arg0, int arg1, int arg2)
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
+#ifdef CONFIG_LEDS_CLASS
+/* LED class callbacks */
+
+static void logolamp_set(struct led_classdev *cdev,
+			       enum led_brightness brightness)
+{
+	if (brightness >= LED_FULL) {	/* set state Always Enabled */
+		/* if in Disabled state, move to Enabled At Power On */
+		call_fext_func(FUNC_LEDS,0x1,LOGOLAMP_POWERON,FUNC_LED_ON);
+		/* if in Enabled At Power On state, move to Always Enabled */
+		call_fext_func(FUNC_LEDS,0x1,LOGOLAMP_ALWAYS,FUNC_LED_ON);
+	} else if (brightness >= LED_HALF) {	/* set state Enabled At Power On */
+		/* if in Disabled state, move to Enabled At Power On */
+		call_fext_func(FUNC_LEDS,0x1,LOGOLAMP_POWERON,FUNC_LED_ON);
+		/* if in Always Enabled state, move to Enabled At Power On */
+		call_fext_func(FUNC_LEDS,0x1,LOGOLAMP_ALWAYS,FUNC_LED_OFF);
+	} else {			/* set state Disabled */
+		/* set Disabled */
+		call_fext_func(FUNC_LEDS,0x1,LOGOLAMP_POWERON,FUNC_LED_OFF);
+	}
+}
+
+static void kblamps_set(struct led_classdev *cdev,
+			       enum led_brightness brightness)
+{
+	if (brightness >= LED_FULL) {
+		call_fext_func(FUNC_LEDS,0x1,KEYBOARD_LAMPS,FUNC_LED_ON);
+	} else {
+		call_fext_func(FUNC_LEDS,0x1,KEYBOARD_LAMPS,FUNC_LED_OFF);
+	}
+}
+
+static enum led_brightness logolamp_get(struct led_classdev *cdev)
+{
+	enum led_brightness brightness = LED_OFF;
+	int poweron, always;
+
+	poweron = call_fext_func(FUNC_LEDS,0x2,LOGOLAMP_POWERON,0x0);
+	if (poweron == FUNC_LED_ON) {
+		brightness = LED_HALF;
+		always = call_fext_func(FUNC_LEDS,0x2,LOGOLAMP_ALWAYS,0x0);
+		if (always == FUNC_LED_ON) {
+			brightness = LED_FULL;
+		}
+	}
+	return brightness;
+}
+
+static enum led_brightness kblamps_get(struct led_classdev *cdev)
+{
+	enum led_brightness brightness = LED_OFF;
+
+	if (call_fext_func(FUNC_LEDS,0x2,KEYBOARD_LAMPS,0x0) == FUNC_LED_ON)
+		brightness = LED_FULL;
+
+	return brightness;
+}
+#endif
+
 /* Hardware access for LCD brightness control */
 
 static int set_lcd_level(int level)
@@ -297,10 +449,21 @@
 
 static int bl_update_status(struct backlight_device *b)
 {
+	int ret;
+	if (b->props.power == 4)
+		ret = call_fext_func(FUNC_BACKLIGHT,0x1,0x4,0x3);
+	else
+		ret = call_fext_func(FUNC_BACKLIGHT,0x1,0x4,0x0);
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
@@ -382,42 +545,64 @@
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
-
-	status =
-	    acpi_evaluate_integer(fujitsu_hotkey->acpi_handle, "GIRB", NULL,
-				  &state);
-	if (status < 0)
-		return status;
+	return count;
+}
 
-	fujitsu_hotkey->irb = state;
+static ssize_t
+show_lid_state(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	if (fujitsu_hotkey->rfkill_state == UNSUPPORTED_CMD)
+		return sprintf(buf, "unknown\n");
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
+	if (fujitsu_hotkey->rfkill_state == UNSUPPORTED_CMD)
+		return sprintf(buf, "unknown\n");
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
+	if (fujitsu_hotkey->rfkill_state == UNSUPPORTED_CMD)
+		return sprintf(buf, "unknown\n");
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
 
@@ -771,7 +956,8 @@
 	input->id.bustype = BUS_HOST;
 	input->id.product = 0x06;
 	input->dev.parent = &device->dev;
-	input->evbit[0] = BIT(EV_KEY);
+
+	set_bit(EV_KEY, input->evbit);
 	set_bit(fujitsu->keycode1, input->keybit);
 	set_bit(fujitsu->keycode2, input->keybit);
 	set_bit(fujitsu->keycode3, input->keybit);
@@ -804,9 +990,40 @@
 	}
 
 	i = 0;			/* Discard hotkey ringbuffer */
-	while (get_irb() != 0 && (i++) < MAX_HOTKEY_RINGBUFFER_SIZE) ;
+	while (call_fext_func(FUNC_BUTTONS,0x1,0x0,0x0) != 0 && (i++) < MAX_HOTKEY_RINGBUFFER_SIZE) ;
 	vdbg_printk(FUJLAPTOP_DBG_INFO, "Discarded %i ringbuffer entries\n", i);
 
+	/* Sync RFKILL state */
+	fujitsu_hotkey->rfkill_state = 
+		call_fext_func(FUNC_RFKILL,0x4,0x0,0x0);
+
+	/* Suspect this is a keymap of the application panel, print it */
+	printk(KERN_INFO "fujitsu-laptop: BTNI: [0x%x]\n",
+		call_fext_func(FUNC_BUTTONS,0x0,0x0,0x0));
+
+	#ifdef CONFIG_LEDS_CLASS
+	if (call_fext_func(FUNC_LEDS,0x0,0x0,0x0) & LOGOLAMP_POWERON) {
+		result = led_classdev_register(&fujitsu->pf_device->dev, &logolamp_led);
+		if (result == 0) {
+		        fujitsu_hotkey->logolamp_registered = 1;
+		} else {
+			printk(KERN_ERR "fujitsu-laptop: Could not register LED handler for logo lamp, "
+			"error %i\n", result);
+		}
+	}
+
+	if ((call_fext_func(FUNC_LEDS,0x0,0x0,0x0) & KEYBOARD_LAMPS) &&
+	   (call_fext_func(FUNC_BUTTONS,0x0,0x0,0x0) == 0x0)) {
+		result = led_classdev_register(&fujitsu->pf_device->dev, &kblamps_led);
+		if (result == 0) {
+		        fujitsu_hotkey->kblamps_registered = 1;
+		} else {
+			printk(KERN_ERR "fujitsu-laptop: Could not register LED handler for keyboard lamps, "
+			"error %i\n", result);
+		}
+	}
+	#endif
+
 	return result;
 
 end:
@@ -852,16 +1069,13 @@
 
 	input = fujitsu_hotkey->input;
 
-	vdbg_printk(FUJLAPTOP_DBG_TRACE, "Hotkey event\n");
+	fujitsu_hotkey->rfkill_state = call_fext_func(FUNC_RFKILL,0x4,0x0,0x0);
 
 	switch (event) {
 	case ACPI_FUJITSU_NOTIFY_CODE1:
 		i = 0;
-		while ((irb = get_irb()) != 0
+		while ((irb = call_fext_func(FUNC_BUTTONS,0x1,0x0,0x0)) != 0
 		       && (i++) < MAX_HOTKEY_RINGBUFFER_SIZE) {
-			vdbg_printk(FUJLAPTOP_DBG_TRACE, "GIRB result [%x]\n",
-				    irb);
-
 			switch (irb & 0x4ff) {
 			case KEY1_CODE:
 				keycode = fujitsu->keycode1;
@@ -1035,6 +1249,15 @@
 		goto fail_hotkey1;
 	}
 
+	/* Sync backlight power status (needs FUJ02E3 device, hence deferred) */
+
+	if (!acpi_video_backlight_support()) {
+		if (call_fext_func(FUNC_BACKLIGHT,0x2,0x4,0x0) == 3)
+			fujitsu->bl_device->props.power = 4;
+		else
+			fujitsu->bl_device->props.power = 0;
+	}
+
 	printk(KERN_INFO "fujitsu-laptop: driver " FUJITSU_DRIVER_VERSION
 	       " successfully loaded.\n");
 
@@ -1074,6 +1297,16 @@
 
 static void __exit fujitsu_cleanup(void)
 {
+	#ifdef CONFIG_LEDS_CLASS
+	if (fujitsu_hotkey->logolamp_registered != 0) {
+		led_classdev_unregister(&logolamp_led);
+	}
+
+	if (fujitsu_hotkey->kblamps_registered != 0) {
+		led_classdev_unregister(&kblamps_led);
+	}
+	#endif
+
 	sysfs_remove_group(&fujitsu->pf_device->dev.kobj,
 			   &fujitsupf_attribute_group);
 	platform_device_unregister(fujitsu->pf_device);
@@ -1108,12 +1341,13 @@
 MODULE_PARM_DESC(debug, "Sets debug level bit-mask");
 #endif
 
-MODULE_AUTHOR("Jonathan Woithe, Peter Gruber");
+MODULE_AUTHOR("Jonathan Woithe, Peter Gruber, Tony Vroon");
 MODULE_DESCRIPTION("Fujitsu laptop extras support");
 MODULE_VERSION(FUJITSU_DRIVER_VERSION);
 MODULE_LICENSE("GPL");
 
 MODULE_ALIAS("dmi:*:svnFUJITSUSIEMENS:*:pvr:rvnFUJITSU:rnFJNB1D3:*:cvrS6410:*");
+MODULE_ALIAS("dmi:*:svnFUJITSUSIEMENS:*:pvr:rvnFUJITSU:rnFJNB1E6:*:cvrS6420:*");
 MODULE_ALIAS("dmi:*:svnFUJITSU:*:pvr:rvnFUJITSU:rnFJNB19C:*:cvrS7020:*");
 
 static struct pnp_device_id pnp_ids[] = {
