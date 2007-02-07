From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/140] asus-laptop: add backlight support
Date: Wed,  7 Feb 2007 13:50:47 -0500
Message-ID: <11708744191642-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:4200 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422751AbXBGSxm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:42 -0500
In-Reply-To: <1170874418134-git-send-email-lenb@kernel.org>
Message-Id: <6b7091e74fe176da97917ca60524e2b3554305f0.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Adds backlight support using backlight class. We now
change the brightness *and toggle the backlight !* via
/sys/class/backlight/asus-laptop/.

If the user switchs the backlight using the keyboard,
asus_hotk_notify looks for ATKD_LCD_OFF and ATKD_LCD_ON events,
and stores the right state into hotk->status and bd->props->power .

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig       |    1 +
 drivers/misc/asus-laptop.c |  183 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 87e1db8..89bba27 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -75,6 +75,7 @@ config ASUS_LAPTOP
         depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
 	depends on LEDS_CLASS
+	depends on BACKLIGHT_CLASS_DEVICE
         ---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 222d4fb..58ab44d 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -40,6 +40,8 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
+#include <linux/fb.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 #include <acpi/acpi_drivers.h>
@@ -56,6 +58,14 @@
 #define ASUS_HOTK_PREFIX        "\\_SB.ATKD."
 
 /*
+ * Some events we use, same for all Asus
+ */
+#define ATKD_BR_UP       0x10
+#define ATKD_BR_DOWN     0x20
+#define ATKD_LCD_ON      0x33
+#define ATKD_LCD_OFF     0x34
+
+/*
  * Known bits returned by \_SB.ATKD.HWRS
  */
 #define WL_HWRS     0x80
@@ -71,6 +81,7 @@
 #define TLED_ON     0x08	//touchpad LED
 #define RLED_ON     0x10        //Record LED
 #define PLED_ON     0x20        //Phone LED
+#define LCD_ON      0x40        //LCD backlight
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -101,6 +112,19 @@ ASUS_HANDLE(wl_switch, ASUS_HOTK_PREFIX "WLED");
 ASUS_HANDLE(bt_switch, ASUS_HOTK_PREFIX "BLED");
 ASUS_HANDLE(wireless_status, ASUS_HOTK_PREFIX "RSTS"); /* All new models */
 
+/* Brightness */
+ASUS_HANDLE(brightness_set, ASUS_HOTK_PREFIX "SPLV");
+ASUS_HANDLE(brightness_get, ASUS_HOTK_PREFIX "GPLV");
+
+/* Backlight */
+ASUS_HANDLE(lcd_switch, "\\_SB.PCI0.SBRG.EC0._Q10", /* All new models */
+	    "\\_SB.PCI0.ISA.EC0._Q10", /* A1x */
+	    "\\_SB.PCI0.PX40.ECD0._Q10", /* L3C */
+	    "\\_SB.PCI0.PX40.EC0.Q10", /* M1A */
+	    "\\_SB.PCI0.LPCB.EC0._Q10", /* P30 */
+	    "\\_SB.PCI0.PX40.Q10", /* S1x */
+	    "\\Q10");  /* A2x, L2D, L3D, M2E */
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -138,6 +162,21 @@ static struct acpi_driver asus_hotk_driver = {
 		},
 };
 
+/* The backlight device /sys/class/backlight */
+static struct backlight_device *asus_backlight_device;
+
+/*
+ * The backlight class declaration
+ */
+static int read_brightness(struct backlight_device *bd);
+static int update_bl_status(struct backlight_device *bd);
+static struct backlight_properties asusbl_data = {
+	       .owner          = THIS_MODULE,
+	       .get_brightness = read_brightness,
+	       .update_status  = update_bl_status,
+	       .max_brightness = 15,
+};
+
 /* These functions actually update the LED's, and are called from a
  * workqueue. By doing this as separate work rather than when the LED
  * subsystem asks, we avoid messing with the Asus ACPI stuff during a
@@ -253,6 +292,86 @@ ASUS_LED_HANDLER(pled, PLED_ON, 0);
 ASUS_LED_HANDLER(rled, RLED_ON, 0);
 ASUS_LED_HANDLER(tled, TLED_ON, 0);
 
+static int get_lcd_state(void)
+{
+	return read_status(LCD_ON);
+}
+
+static int set_lcd_state(int value)
+{
+	int lcd = 0;
+	acpi_status status = 0;
+
+	lcd = value ? 1 : 0;
+
+	if (lcd == get_lcd_state())
+		return 0;
+
+	if(lcd_switch_handle) {
+		status = acpi_evaluate_object(lcd_switch_handle,
+					      NULL, NULL, NULL);
+
+		if (ACPI_FAILURE(status))
+			printk(ASUS_WARNING "Error switching LCD\n");
+	}
+
+	write_status(NULL, lcd, LCD_ON, 0);
+	return 0;
+}
+
+static void lcd_blank(int blank)
+{
+	struct backlight_device *bd = asus_backlight_device;
+
+	if(bd) {
+		down(&bd->sem);
+		if(likely(bd->props)) {
+			bd->props->power = blank;
+			if(likely(bd->props->update_status))
+			   bd->props->update_status(bd);
+		}
+		up(&bd->sem);
+	}
+}
+
+static int read_brightness(struct backlight_device *bd)
+{
+	int value;
+
+	if (!read_acpi_int(brightness_get_handle, NULL, &value, NULL))
+		printk(ASUS_WARNING "Error reading brightness\n");
+
+	return value;
+}
+
+static int set_brightness(struct backlight_device *bd, int value)
+{
+	int ret = 0;
+
+	value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+	/* 0 <= value <= 15 */
+
+	if (!write_acpi_int(brightness_set_handle, NULL, value, NULL)) {
+		printk(ASUS_WARNING "Error changing brightness\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int update_bl_status(struct backlight_device *bd)
+{
+	int rv;
+	int value = bd->props->brightness;
+
+	rv = set_brightness(bd, value);
+	if(rv)
+		return rv;
+
+	value = (bd->props->power == FB_BLANK_UNBLANK) ? 1 : 0;
+	return set_lcd_state(value);
+}
+
 /*
  * Platform device handlers
  */
@@ -378,6 +497,18 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 	if (!hotk)
 		return;
 
+	/*
+	 * We need to tell the backlight device when the backlight power is
+	 * switched
+	 */
+	if (event == ATKD_LCD_ON) {
+		write_status(NULL, 1, LCD_ON, 0);
+		lcd_blank(FB_BLANK_UNBLANK);
+	} else if(event == ATKD_LCD_OFF) {
+		write_status(NULL, 0, LCD_ON, 0);
+		lcd_blank(FB_BLANK_POWERDOWN);
+	}
+
 	acpi_bus_generate_event(hotk->device, event,
 				hotk->event_count[event % 128]++);
 
@@ -547,6 +678,11 @@ static int asus_hotk_get_info(void)
 
 	ASUS_HANDLE_INIT(wireless_status);
 
+	ASUS_HANDLE_INIT(brightness_set);
+	ASUS_HANDLE_INIT(brightness_get);
+
+	ASUS_HANDLE_INIT(lcd_switch);
+
 	kfree(model);
 
 	return AE_OK;
@@ -611,10 +747,13 @@ static int asus_hotk_add(struct acpi_device *device)
 
 	asus_hotk_found = 1;
 
-	/* WLED and BLED are on by  default */
+	/* WLED and BLED are on by default */
 	write_status(bt_switch_handle, 1, BT_ON, 0);
 	write_status(wl_switch_handle, 1, WL_ON, 0);
 
+	/* LCD Backlight is on by default */
+	write_status(NULL, 1, LCD_ON, 0);
+
       end:
 	if (result) {
 		kfree(hotk->name);
@@ -642,6 +781,12 @@ static int asus_hotk_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static void asus_backlight_exit(void)
+{
+	if(asus_backlight_device)
+		backlight_device_unregister(asus_backlight_device);
+}
+
 #define  ASUS_LED_UNREGISTER(object)				\
 	if(object##_led.class_dev				\
 	   && !IS_ERR(object##_led.class_dev))			\
@@ -659,6 +804,7 @@ static void asus_led_exit(void)
 
 static void __exit asus_laptop_exit(void)
 {
+	asus_backlight_exit();
 	asus_led_exit();
 
 	acpi_bus_unregister_driver(&asus_hotk_driver);
@@ -669,6 +815,34 @@ static void __exit asus_laptop_exit(void)
 	kfree(asus_info);
 }
 
+static int asus_backlight_init(struct device * dev)
+{
+	struct backlight_device *bd;
+
+	if(brightness_set_handle && lcd_switch_handle) {
+		bd = backlight_device_register (ASUS_HOTK_FILE, dev,
+						NULL, &asusbl_data);
+		if (IS_ERR (bd)) {
+			printk(ASUS_ERR
+			       "Could not register asus backlight device\n");
+			asus_backlight_device = NULL;
+			return PTR_ERR(bd);
+		}
+
+		asus_backlight_device = bd;
+
+		down(&bd->sem);
+		if(likely(bd->props)) {
+			bd->props->brightness = read_brightness(NULL);
+			bd->props->power = FB_BLANK_UNBLANK;
+			if(likely(bd->props->update_status))
+			   bd->props->update_status(bd);
+		}
+		up(&bd->sem);
+	}
+	return 0;
+}
+
 static int asus_led_register(acpi_handle handle,
 			     struct led_classdev * ldev,
 			     struct device * dev)
@@ -739,6 +913,10 @@ static int __init asus_laptop_init(void)
 
 	dev = acpi_get_physical_device(hotk->device->handle);
 
+	result = asus_backlight_init(dev);
+	if(result)
+		goto fail_backlight;
+
 	result = asus_led_init(dev);
 	if(result)
 		goto fail_led;
@@ -778,6 +956,9 @@ fail_platform_driver:
 	asus_led_exit();
 
 fail_led:
+	asus_backlight_exit();
+
+fail_backlight:
 
 	return result;
 }
-- 
1.5.0.rc3.39.gec804
