From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 4/7] asus-laptop: add backlight support
Date: Fri, 26 Jan 2007 14:04:45 +0100
Message-ID: <200701261404.45462.corentincj@iksaif.net>
References: <200701251254.50198.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:36618 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965640AbXAZNEs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 08:04:48 -0500
In-Reply-To: <200701251254.50198.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

From: Corentin Chary <corentincj@iksaif.net>

Adds backlight support using backlight class. We now
change the brightness *and toggle the backlight !* via
/sys/class/backlight/asus-laptop/.

If the user switchs the backlight using the keyboard,
asus_hotk_notify looks for ATKD_LCD_OFF and ATKD_LCD_ON events,
and stores the right state into hotk->status and bd->props->power .

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/misc/Kconfig       |    1 
 drivers/misc/asus-laptop.c |  183 ++++++++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 1 deletion(-)

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-26 12:45:11.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-26 12:59:30.000000000 +0100
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
@@ -101,6 +112,19 @@
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
@@ -138,6 +162,21 @@
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
@@ -253,6 +292,86 @@
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
@@ -378,6 +497,18 @@
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
 
@@ -547,6 +678,11 @@
 
 	ASUS_HANDLE_INIT(wireless_status);
 
+	ASUS_HANDLE_INIT(brightness_set);
+	ASUS_HANDLE_INIT(brightness_get);
+
+	ASUS_HANDLE_INIT(lcd_switch);
+
 	kfree(model);
 
 	return AE_OK;
@@ -611,10 +747,13 @@
 
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
@@ -642,6 +781,12 @@
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
@@ -659,6 +804,7 @@
 
 static void __exit asus_laptop_exit(void)
 {
+	asus_backlight_exit();
 	asus_led_exit();
 
 	acpi_bus_unregister_driver(&asus_hotk_driver);
@@ -669,6 +815,34 @@
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
@@ -739,6 +913,10 @@
 
 	dev = acpi_get_physical_device(hotk->device->handle);
 
+	result = asus_backlight_init(dev);
+	if(result)
+		goto fail_backlight;
+
 	result = asus_led_init(dev);
 	if(result)
 		goto fail_led;
@@ -778,6 +956,9 @@
 	asus_led_exit();
 
 fail_led:
+	asus_backlight_exit();
+
+fail_backlight:
 
 	return result;
 }
diff -Naur a/drivers/misc/Kconfig b/drivers/misc/Kconfig
--- a/drivers/misc/Kconfig	2007-01-26 12:44:20.000000000 +0100
+++ b/drivers/misc/Kconfig	2007-01-26 12:46:22.000000000 +0100
@@ -75,6 +75,7 @@
         depends on ACPI
 	depends on EXPERIMENTAL && !ACPI_ASUS
 	depends on LEDS_CLASS
+	depends on BACKLIGHT_CLASS_DEVICE
         ---help---
 	  This is the new Linux driver for Asus laptops. It may also support some
 	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
