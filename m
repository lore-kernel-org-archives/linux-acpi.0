From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/140] asus-laptop: Lindent
Date: Wed,  7 Feb 2007 13:50:51 -0500
Message-ID: <117087442385-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:31152 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422760AbXBGSx4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:56 -0500
In-Reply-To: <1170874422581-git-send-email-lenb@kernel.org>
Message-Id: <8def05fa82bfa4af0c8e83a00ff377ddd9074480.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |  247 ++++++++++++++++++++++----------------------
 1 files changed, 123 insertions(+), 124 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 6f72cd5..b624350 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -79,9 +79,9 @@
 #define BT_ON       0x02	//internal Bluetooth
 #define MLED_ON     0x04	//mail LED
 #define TLED_ON     0x08	//touchpad LED
-#define RLED_ON     0x10        //Record LED
-#define PLED_ON     0x20        //Phone LED
-#define LCD_ON      0x40        //LCD backlight
+#define RLED_ON     0x10	//Record LED
+#define PLED_ON     0x20	//Phone LED
+#define LCD_ON      0x40	//LCD backlight
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -101,8 +101,8 @@ MODULE_LICENSE("GPL");
 /* LED */
 ASUS_HANDLE(mled_set, ASUS_HOTK_PREFIX "MLED");
 ASUS_HANDLE(tled_set, ASUS_HOTK_PREFIX "TLED");
-ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED"); /* W1JC */
-ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED"); /* A7J */
+ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED");	/* W1JC */
+ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED");	/* A7J */
 
 /* LEDD */
 ASUS_HANDLE(ledd_set, ASUS_HOTK_PREFIX "SLCM");
@@ -113,53 +113,52 @@ ASUS_HANDLE(ledd_set, ASUS_HOTK_PREFIX "SLCM");
  */
 ASUS_HANDLE(wl_switch, ASUS_HOTK_PREFIX "WLED");
 ASUS_HANDLE(bt_switch, ASUS_HOTK_PREFIX "BLED");
-ASUS_HANDLE(wireless_status, ASUS_HOTK_PREFIX "RSTS"); /* All new models */
+ASUS_HANDLE(wireless_status, ASUS_HOTK_PREFIX "RSTS");	/* All new models */
 
 /* Brightness */
 ASUS_HANDLE(brightness_set, ASUS_HOTK_PREFIX "SPLV");
 ASUS_HANDLE(brightness_get, ASUS_HOTK_PREFIX "GPLV");
 
 /* Backlight */
-ASUS_HANDLE(lcd_switch, "\\_SB.PCI0.SBRG.EC0._Q10", /* All new models */
-	    "\\_SB.PCI0.ISA.EC0._Q10", /* A1x */
-	    "\\_SB.PCI0.PX40.ECD0._Q10", /* L3C */
-	    "\\_SB.PCI0.PX40.EC0.Q10", /* M1A */
-	    "\\_SB.PCI0.LPCB.EC0._Q10", /* P30 */
-	    "\\_SB.PCI0.PX40.Q10", /* S1x */
-	    "\\Q10");  /* A2x, L2D, L3D, M2E */
+ASUS_HANDLE(lcd_switch, "\\_SB.PCI0.SBRG.EC0._Q10",	/* All new models */
+	    "\\_SB.PCI0.ISA.EC0._Q10",	/* A1x */
+	    "\\_SB.PCI0.PX40.ECD0._Q10",	/* L3C */
+	    "\\_SB.PCI0.PX40.EC0.Q10",	/* M1A */
+	    "\\_SB.PCI0.LPCB.EC0._Q10",	/* P30 */
+	    "\\_SB.PCI0.PX40.Q10",	/* S1x */
+	    "\\Q10");		/* A2x, L2D, L3D, M2E */
 
 /* Display */
 ASUS_HANDLE(display_set, ASUS_HOTK_PREFIX "SDSP");
-ASUS_HANDLE(display_get,
-	    "\\_SB.PCI0.P0P1.VGA.GETD", /*  A6B, A6K A6R A7D F3JM L4R M6R A3G
-					    M6A M6V VX-1 V6J V6V W3Z */
-	    "\\_SB.PCI0.P0P2.VGA.GETD", /* A3E A4K, A4D A4L A6J A7J A8J Z71V M9V
+ASUS_HANDLE(display_get, "\\_SB.PCI0.P0P1.VGA.GETD",	/*  A6B, A6K A6R A7D F3JM L4R M6R A3G
+							   M6A M6V VX-1 V6J V6V W3Z */
+	    "\\_SB.PCI0.P0P2.VGA.GETD",	/* A3E A4K, A4D A4L A6J A7J A8J Z71V M9V
 					   S5A M5A z33A W1Jc W2V */
-	    "\\_SB.PCI0.P0P3.VGA.GETD", /* A6V A6Q */
-	    "\\_SB.PCI0.P0PA.VGA.GETD", /* A6T, A6M */
-	    "\\_SB.PCI0.PCI1.VGAC.NMAP", /* L3C */
-	    "\\_SB.PCI0.VGA.GETD", /* Z96F */
-	    "\\ACTD", /* A2D */
-	    "\\ADVG", /* A4G Z71A W1N W5A W5F M2N M3N M5N M6N S1N S5N */
-	    "\\DNXT", /* P30 */
-	    "\\INFB", /* A2H D1 L2D L3D L3H L2E L5D L5C M1A M2E L4L W3V */
-	    "\\SSTE"); /* A3F A6F A3N A3L M6N W3N W6A */
-
-ASUS_HANDLE(ls_switch, ASUS_HOTK_PREFIX "ALSC"); /* Z71A Z71V */
-ASUS_HANDLE(ls_level, ASUS_HOTK_PREFIX "ALSL"); /* Z71A Z71V */
+	    "\\_SB.PCI0.P0P3.VGA.GETD",	/* A6V A6Q */
+	    "\\_SB.PCI0.P0PA.VGA.GETD",	/* A6T, A6M */
+	    "\\_SB.PCI0.PCI1.VGAC.NMAP",	/* L3C */
+	    "\\_SB.PCI0.VGA.GETD",	/* Z96F */
+	    "\\ACTD",		/* A2D */
+	    "\\ADVG",		/* A4G Z71A W1N W5A W5F M2N M3N M5N M6N S1N S5N */
+	    "\\DNXT",		/* P30 */
+	    "\\INFB",		/* A2H D1 L2D L3D L3H L2E L5D L5C M1A M2E L4L W3V */
+	    "\\SSTE");		/* A3F A6F A3N A3L M6N W3N W6A */
+
+ASUS_HANDLE(ls_switch, ASUS_HOTK_PREFIX "ALSC");	/* Z71A Z71V */
+ASUS_HANDLE(ls_level, ASUS_HOTK_PREFIX "ALSL");	/* Z71A Z71V */
 
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
  */
 struct asus_hotk {
-	char *name; //laptop name
+	char *name;		//laptop name
 	struct acpi_device *device;	//the device we are in
 	acpi_handle handle;	//the handle of the hotk device
 	char status;		//status of the hotk, for LEDs, ...
 	u32 ledd_status;	//status of the LED display
-	u8 light_level;    //light sensor level
-	u8 light_switch;    //light sensor switch value
+	u8 light_level;		//light sensor level
+	u8 light_switch;	//light sensor switch value
 	u16 event_count[128];	//count for each event TODO make this better
 };
 
@@ -197,10 +196,10 @@ static struct backlight_device *asus_backlight_device;
 static int read_brightness(struct backlight_device *bd);
 static int update_bl_status(struct backlight_device *bd);
 static struct backlight_properties asusbl_data = {
-	       .owner          = THIS_MODULE,
-	       .get_brightness = read_brightness,
-	       .update_status  = update_bl_status,
-	       .max_brightness = 15,
+	.owner = THIS_MODULE,
+	.get_brightness = read_brightness,
+	.update_status = update_bl_status,
+	.max_brightness = 15,
 };
 
 /* These functions actually update the LED's, and are called from a
@@ -263,7 +262,8 @@ static int read_acpi_int(acpi_handle handle, const char *method, int *val,
 	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
 
-static int read_wireless_status(int mask) {
+static int read_wireless_status(int mask)
+{
 	int status;
 
 	if (!wireless_status_handle)
@@ -287,8 +287,7 @@ static int read_status(int mask)
 	return (hotk->status & mask) ? 1 : 0;
 }
 
-static void write_status(acpi_handle handle, int out, int mask,
-			 int invert)
+static void write_status(acpi_handle handle, int out, int mask, int invert)
 {
 	hotk->status = (out) ? (hotk->status | mask) : (hotk->status & ~mask);
 
@@ -333,7 +332,7 @@ static int set_lcd_state(int value)
 	if (lcd == get_lcd_state())
 		return 0;
 
-	if(lcd_switch_handle) {
+	if (lcd_switch_handle) {
 		status = acpi_evaluate_object(lcd_switch_handle,
 					      NULL, NULL, NULL);
 
@@ -349,12 +348,12 @@ static void lcd_blank(int blank)
 {
 	struct backlight_device *bd = asus_backlight_device;
 
-	if(bd) {
+	if (bd) {
 		down(&bd->sem);
-		if(likely(bd->props)) {
+		if (likely(bd->props)) {
 			bd->props->power = blank;
-			if(likely(bd->props->update_status))
-			   bd->props->update_status(bd);
+			if (likely(bd->props->update_status))
+				bd->props->update_status(bd);
 		}
 		up(&bd->sem);
 	}
@@ -391,7 +390,7 @@ static int update_bl_status(struct backlight_device *bd)
 	int value = bd->props->brightness;
 
 	rv = set_brightness(bd, value);
-	if(rv)
+	if (rv)
 		return rv;
 
 	value = (bd->props->power == FB_BLANK_UNBLANK) ? 1 : 0;
@@ -408,7 +407,7 @@ static int update_bl_status(struct backlight_device *bd)
  * number of bytes written in page
  */
 static ssize_t show_infos(struct device *dev,
-			 struct device_attribute *attr, char *page)
+			  struct device_attribute *attr, char *page)
 {
 	int len = 0;
 	int temp;
@@ -535,8 +534,9 @@ static ssize_t show_bluetooth(struct device *dev,
 	return sprintf(buf, "%d\n", read_status(BT_ON));
 }
 
-static ssize_t store_bluetooth(struct device *dev, struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t store_bluetooth(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	return store_status(buf, count, bt_switch_handle, BT_ON, 0);
 }
@@ -558,7 +558,7 @@ static int read_display(void)
 
 	/* In most of the case, we know how to set the display, but sometime
 	   we can't read it */
-	if(display_get_handle) {
+	if (display_get_handle) {
 		if (!read_acpi_int(display_get_handle, NULL, &value, NULL))
 			printk(ASUS_WARNING "Error reading display status\n");
 	}
@@ -567,6 +567,7 @@ static int read_display(void)
 
 	return value;
 }
+
 /*
  * Now, *this* one could be more user-friendly, but so far, no-one has
  * complained. The significance of bits is the same as in store_disp()
@@ -664,7 +665,7 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 	if (event == ATKD_LCD_ON) {
 		write_status(NULL, 1, LCD_ON, 0);
 		lcd_blank(FB_BLANK_UNBLANK);
-	} else if(event == ATKD_LCD_OFF) {
+	} else if (event == ATKD_LCD_OFF) {
 		write_status(NULL, 0, LCD_ON, 0);
 		lcd_blank(FB_BLANK_POWERDOWN);
 	}
@@ -701,30 +702,29 @@ static ASUS_CREATE_DEVICE_ATTR(ls_switch);
 static ASUS_CREATE_DEVICE_ATTR(ls_level);
 
 static struct attribute *asuspf_attributes[] = {
-        &dev_attr_infos.attr,
-        &dev_attr_wlan.attr,
-        &dev_attr_bluetooth.attr,
-        &dev_attr_display.attr,
-        &dev_attr_ledd.attr,
-        &dev_attr_ls_switch.attr,
-        &dev_attr_ls_level.attr,
-        NULL
+	&dev_attr_infos.attr,
+	&dev_attr_wlan.attr,
+	&dev_attr_bluetooth.attr,
+	&dev_attr_display.attr,
+	&dev_attr_ledd.attr,
+	&dev_attr_ls_switch.attr,
+	&dev_attr_ls_level.attr,
+	NULL
 };
 
 static struct attribute_group asuspf_attribute_group = {
-        .attrs = asuspf_attributes
+	.attrs = asuspf_attributes
 };
 
 static struct platform_driver asuspf_driver = {
-        .driver = {
-                .name = ASUS_HOTK_FILE,
-                .owner = THIS_MODULE,
-        }
+	.driver = {
+		   .name = ASUS_HOTK_FILE,
+		   .owner = THIS_MODULE,
+		   }
 };
 
 static struct platform_device *asuspf_device;
 
-
 static void asus_hotk_add_fs(void)
 {
 	ASUS_SET_DEVICE_ATTR(infos, 0444, show_infos, NULL);
@@ -738,7 +738,7 @@ static void asus_hotk_add_fs(void)
 
 	if (display_set_handle && display_get_handle)
 		ASUS_SET_DEVICE_ATTR(display, 0644, show_disp, store_disp);
-	else if(display_set_handle)
+	else if (display_set_handle)
 		ASUS_SET_DEVICE_ATTR(display, 0200, NULL, store_disp);
 
 	if (ledd_set_handle)
@@ -750,7 +750,7 @@ static void asus_hotk_add_fs(void)
 	}
 }
 
-static int asus_handle_init(char *name, acpi_handle *handle,
+static int asus_handle_init(char *name, acpi_handle * handle,
 			    char **paths, int num_paths)
 {
 	int i;
@@ -770,7 +770,6 @@ static int asus_handle_init(char *name, acpi_handle *handle,
 	asus_handle_init(#object, &object##_handle, object##_paths,	\
 			 ARRAY_SIZE(object##_paths))
 
-
 /*
  * This function is used to initialize the hotk with right values. In this
  * method, we can make all the detection we want, and modify the hotk struct
@@ -835,7 +834,7 @@ static int asus_hotk_get_info(void)
 	if (!hotk->name)
 		return -ENOMEM;
 
-	if(*string)
+	if (*string)
 		printk(ASUS_NOTICE "  %s model detected\n", string);
 
 	ASUS_HANDLE_INIT(mled_set);
@@ -854,9 +853,9 @@ static int asus_hotk_get_info(void)
 	if (!read_acpi_int(hotk->handle, "HRWS", &hwrs_result, NULL))
 		hwrs_result = WL_HWRS | BT_HWRS;
 
-	if(hwrs_result & WL_HWRS)
+	if (hwrs_result & WL_HWRS)
 		ASUS_HANDLE_INIT(wl_switch);
-	if(hwrs_result & BT_HWRS)
+	if (hwrs_result & BT_HWRS)
 		ASUS_HANDLE_INIT(bt_switch);
 
 	ASUS_HANDLE_INIT(wireless_status);
@@ -871,7 +870,7 @@ static int asus_hotk_get_info(void)
 
 	/* There is a lot of models with "ALSL", but a few get
 	   a real light sens, so we need to check it. */
-	if(ASUS_HANDLE_INIT(ls_switch))
+	if (ASUS_HANDLE_INIT(ls_switch))
 		ASUS_HANDLE_INIT(ls_level);
 
 	kfree(model);
@@ -948,15 +947,15 @@ static int asus_hotk_add(struct acpi_device *device)
 	/* LED display is off by default */
 	hotk->ledd_status = 0xFFF;
 
- 	/* Set initial values of light sensor and level */
- 	hotk->light_switch = 1; /* Default to light sensor disabled */
- 	hotk->light_level = 0; /* level 5 for sensor sensitivity */
+	/* Set initial values of light sensor and level */
+	hotk->light_switch = 1;	/* Default to light sensor disabled */
+	hotk->light_level = 0;	/* level 5 for sensor sensitivity */
 
- 	if (ls_switch_handle)
- 		set_light_sens_switch(hotk->light_switch);
+	if (ls_switch_handle)
+		set_light_sens_switch(hotk->light_switch);
 
- 	if (ls_level_handle)
- 		set_light_sens_level(hotk->light_level);
+	if (ls_level_handle)
+		set_light_sens_level(hotk->light_level);
 
       end:
 	if (result) {
@@ -987,7 +986,7 @@ static int asus_hotk_remove(struct acpi_device *device, int type)
 
 static void asus_backlight_exit(void)
 {
-	if(asus_backlight_device)
+	if (asus_backlight_device)
 		backlight_device_unregister(asus_backlight_device);
 }
 
@@ -1012,21 +1011,21 @@ static void __exit asus_laptop_exit(void)
 	asus_led_exit();
 
 	acpi_bus_unregister_driver(&asus_hotk_driver);
-        sysfs_remove_group(&asuspf_device->dev.kobj, &asuspf_attribute_group);
-        platform_device_unregister(asuspf_device);
-        platform_driver_unregister(&asuspf_driver);
+	sysfs_remove_group(&asuspf_device->dev.kobj, &asuspf_attribute_group);
+	platform_device_unregister(asuspf_device);
+	platform_driver_unregister(&asuspf_driver);
 
 	kfree(asus_info);
 }
 
-static int asus_backlight_init(struct device * dev)
+static int asus_backlight_init(struct device *dev)
 {
 	struct backlight_device *bd;
 
-	if(brightness_set_handle && lcd_switch_handle) {
-		bd = backlight_device_register (ASUS_HOTK_FILE, dev,
-						NULL, &asusbl_data);
-		if (IS_ERR (bd)) {
+	if (brightness_set_handle && lcd_switch_handle) {
+		bd = backlight_device_register(ASUS_HOTK_FILE, dev,
+					       NULL, &asusbl_data);
+		if (IS_ERR(bd)) {
 			printk(ASUS_ERR
 			       "Could not register asus backlight device\n");
 			asus_backlight_device = NULL;
@@ -1036,11 +1035,11 @@ static int asus_backlight_init(struct device * dev)
 		asus_backlight_device = bd;
 
 		down(&bd->sem);
-		if(likely(bd->props)) {
+		if (likely(bd->props)) {
 			bd->props->brightness = read_brightness(NULL);
 			bd->props->power = FB_BLANK_UNBLANK;
-			if(likely(bd->props->update_status))
-			   bd->props->update_status(bd);
+			if (likely(bd->props->update_status))
+				bd->props->update_status(bd);
 		}
 		up(&bd->sem);
 	}
@@ -1048,39 +1047,39 @@ static int asus_backlight_init(struct device * dev)
 }
 
 static int asus_led_register(acpi_handle handle,
-			     struct led_classdev * ldev,
-			     struct device * dev)
+			     struct led_classdev *ldev, struct device *dev)
 {
-	if(!handle)
+	if (!handle)
 		return 0;
 
 	return led_classdev_register(dev, ldev);
 }
+
 #define ASUS_LED_REGISTER(object, device)				\
 	asus_led_register(object##_set_handle, &object##_led, device)
 
-static int asus_led_init(struct device * dev)
+static int asus_led_init(struct device *dev)
 {
 	int rv;
 
 	rv = ASUS_LED_REGISTER(mled, dev);
-	if(rv)
+	if (rv)
 		return rv;
 
 	rv = ASUS_LED_REGISTER(tled, dev);
-	if(rv)
+	if (rv)
 		return rv;
 
 	rv = ASUS_LED_REGISTER(rled, dev);
-	if(rv)
+	if (rv)
 		return rv;
 
 	rv = ASUS_LED_REGISTER(pled, dev);
-	if(rv)
+	if (rv)
 		return rv;
 
 	led_workqueue = create_singlethread_workqueue("led_workqueue");
-	if(!led_workqueue)
+	if (!led_workqueue)
 		return -ENOMEM;
 
 	return 0;
@@ -1118,51 +1117,51 @@ static int __init asus_laptop_init(void)
 	dev = acpi_get_physical_device(hotk->device->handle);
 
 	result = asus_backlight_init(dev);
-	if(result)
+	if (result)
 		goto fail_backlight;
 
 	result = asus_led_init(dev);
-	if(result)
+	if (result)
 		goto fail_led;
 
-        /* Register platform stuff */
+	/* Register platform stuff */
 	result = platform_driver_register(&asuspf_driver);
-        if (result)
-                goto fail_platform_driver;
+	if (result)
+		goto fail_platform_driver;
 
-        asuspf_device = platform_device_alloc(ASUS_HOTK_FILE, -1);
-        if (!asuspf_device) {
-                result = -ENOMEM;
-                goto fail_platform_device1;
-        }
+	asuspf_device = platform_device_alloc(ASUS_HOTK_FILE, -1);
+	if (!asuspf_device) {
+		result = -ENOMEM;
+		goto fail_platform_device1;
+	}
 
-        result = platform_device_add(asuspf_device);
-        if (result)
-                goto fail_platform_device2;
+	result = platform_device_add(asuspf_device);
+	if (result)
+		goto fail_platform_device2;
 
-        result = sysfs_create_group(&asuspf_device->dev.kobj,
+	result = sysfs_create_group(&asuspf_device->dev.kobj,
 				    &asuspf_attribute_group);
-        if (result)
-                goto fail_sysfs;
+	if (result)
+		goto fail_sysfs;
 
-        return 0;
+	return 0;
 
-fail_sysfs:
-        platform_device_del(asuspf_device);
+      fail_sysfs:
+	platform_device_del(asuspf_device);
 
-fail_platform_device2:
+      fail_platform_device2:
 	platform_device_put(asuspf_device);
 
-fail_platform_device1:
-        platform_driver_unregister(&asuspf_driver);
+      fail_platform_device1:
+	platform_driver_unregister(&asuspf_driver);
 
-fail_platform_driver:
+      fail_platform_driver:
 	asus_led_exit();
 
-fail_led:
+      fail_led:
 	asus_backlight_exit();
 
-fail_backlight:
+      fail_backlight:
 
 	return result;
 }
-- 
1.5.0.rc3.39.gec804
