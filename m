From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] asus-laptop: hotkeys via the generic input interface
Date: Sun, 18 Jan 2009 19:01:53 +0100
Message-ID: <1232301715-20292-5-git-send-email-corentincj@iksaif.net>
References: <1232301715-20292-1-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-3-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-4-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:58976 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934003AbZARSRP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 13:17:15 -0500
In-Reply-To: <1232301715-20292-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Corentin Chary <corentincj@iksaif.net>

This patch is based on eeepc-laptop.c and the patchs
from Nicolas Trangez and Daniel Nascimento (mainly for the keymap).

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |  155 +++++++++++++++++++++++++++++++++++-
 1 files changed, 154 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 1b7a28c..53dbfb4 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -46,6 +46,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
+#include <linux/input.h>
 
 #define ASUS_LAPTOP_VERSION "0.42"
 
@@ -181,6 +182,8 @@ struct asus_hotk {
 	u8 light_level;		//light sensor level
 	u8 light_switch;	//light sensor switch value
 	u16 event_count[128];	//count for each event TODO make this better
+	struct input_dev *inputdev;
+	u16 *keycode_map;
 };
 
 /*
@@ -250,6 +253,37 @@ ASUS_LED(rled, "record");
 ASUS_LED(pled, "phone");
 ASUS_LED(gled, "gaming");
 
+struct key_entry {
+	char type;
+	u8 code;
+	u16 keycode;
+};
+
+enum { KE_KEY, KE_END };
+
+static struct key_entry asus_keymap[] = {
+	{KE_KEY, 0x30, KEY_VOLUMEUP},
+	{KE_KEY, 0x31, KEY_VOLUMEDOWN},
+	{KE_KEY, 0x32, KEY_MUTE},
+	{KE_KEY, 0x33, KEY_SWITCHVIDEOMODE},
+	{KE_KEY, 0x34, KEY_SWITCHVIDEOMODE},
+	{KE_KEY, 0x40, KEY_PREVIOUSSONG},
+	{KE_KEY, 0x41, KEY_NEXTSONG},
+	{KE_KEY, 0x43, KEY_STOP},
+	{KE_KEY, 0x45, KEY_PLAYPAUSE},
+	{KE_KEY, 0x50, KEY_EMAIL},
+	{KE_KEY, 0x51, KEY_WWW},
+	{KE_KEY, 0x5C, BTN_EXTRA},  /* Performance */
+	{KE_KEY, 0x5D, KEY_WLAN},
+	{KE_KEY, 0x61, KEY_SWITCHVIDEOMODE},
+	{KE_KEY, 0x6B, BTN_TOUCH}, /* Lock Mouse */
+	{KE_KEY, 0x82, KEY_CAMERA},
+	{KE_KEY, 0x8A, KEY_TV},
+	{KE_KEY, 0x95, KEY_MEDIA},
+	{KE_KEY, 0x99, KEY_PHONE},
+	{KE_END, 0},
+};
+
 /*
  * This function evaluates an ACPI method, given an int as parameter, the
  * method is searched within the scope of the handle, can be NULL. The output
@@ -720,8 +754,68 @@ static ssize_t store_gps(struct device *dev, struct device_attribute *attr,
 	return store_status(buf, count, NULL, GPS_ON);
 }
 
+/*
+ * Hotkey functions
+ */
+static struct key_entry *asus_get_entry_by_scancode(int code)
+{
+	struct key_entry *key;
+
+	for (key = asus_keymap; key->type != KE_END; key++)
+		if (code == key->code)
+			return key;
+
+	return NULL;
+}
+
+static struct key_entry *asus_get_entry_by_keycode(int code)
+{
+	struct key_entry *key;
+
+	for (key = asus_keymap; key->type != KE_END; key++)
+		if (code == key->keycode && key->type == KE_KEY)
+			return key;
+
+	return NULL;
+}
+
+static int asus_getkeycode(struct input_dev *dev, int scancode, int *keycode)
+{
+	struct key_entry *key = asus_get_entry_by_scancode(scancode);
+
+	if (key && key->type == KE_KEY) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int asus_setkeycode(struct input_dev *dev, int scancode, int keycode)
+{
+	struct key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key = asus_get_entry_by_scancode(scancode);
+	if (key && key->type == KE_KEY) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!asus_get_entry_by_keycode(old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
+	static struct key_entry *key;
+
 	/* TODO Find a better way to handle events count. */
 	if (!hotk)
 		return;
@@ -742,7 +836,20 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 					dev_name(&hotk->device->dev), event,
 					hotk->event_count[event % 128]++);
 
-	return;
+	if (hotk->inputdev) {
+		key = asus_get_entry_by_scancode(event);
+		if (!key)
+			return ;
+
+		switch (key->type) {
+		case KE_KEY:
+			input_report_key(hotk->inputdev, key->keycode, 1);
+			input_sync(hotk->inputdev);
+			input_report_key(hotk->inputdev, key->keycode, 0);
+			input_sync(hotk->inputdev);
+			break;
+		}
+	}
 }
 
 #define ASUS_CREATE_DEVICE_ATTR(_name)					\
@@ -960,6 +1067,38 @@ static int asus_hotk_get_info(void)
 	return AE_OK;
 }
 
+static int asus_input_init(void)
+{
+	const struct key_entry *key;
+	int result;
+
+	hotk->inputdev = input_allocate_device();
+	if (!hotk->inputdev) {
+		printk(ASUS_INFO "Unable to allocate input device\n");
+		return 0;
+	}
+	hotk->inputdev->name = "Asus Laptop extra buttons";
+	hotk->inputdev->phys = ASUS_HOTK_FILE "/input0";
+	hotk->inputdev->id.bustype = BUS_HOST;
+	hotk->inputdev->getkeycode = asus_getkeycode;
+	hotk->inputdev->setkeycode = asus_setkeycode;
+
+	for (key = asus_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, hotk->inputdev->evbit);
+			set_bit(key->keycode, hotk->inputdev->keybit);
+			break;
+		}
+	}
+	result = input_register_device(hotk->inputdev);
+	if (result) {
+		printk(ASUS_INFO "Unable to register input device\n");
+		input_free_device(hotk->inputdev);
+	}
+	return result;
+}
+
 static int asus_hotk_check(void)
 {
 	int result = 0;
@@ -1092,10 +1231,17 @@ static void asus_led_exit(void)
 	ASUS_LED_UNREGISTER(gled);
 }
 
+static void asus_input_exit(void)
+{
+	if (hotk->inputdev)
+		input_unregister_device(hotk->inputdev);
+}
+
 static void __exit asus_laptop_exit(void)
 {
 	asus_backlight_exit();
 	asus_led_exit();
+	asus_input_exit();
 
 	acpi_bus_unregister_driver(&asus_hotk_driver);
 	sysfs_remove_group(&asuspf_device->dev.kobj, &asuspf_attribute_group);
@@ -1217,6 +1363,10 @@ static int __init asus_laptop_init(void)
 		printk(ASUS_INFO "Brightness ignored, must be controlled by "
 		       "ACPI video driver\n");
 
+	result = asus_input_init();
+	if (result)
+		goto fail_input;
+
 	result = asus_led_init(dev);
 	if (result)
 		goto fail_led;
@@ -1256,6 +1406,9 @@ static int __init asus_laptop_init(void)
 	asus_led_exit();
 
       fail_led:
+	asus_input_exit();
+
+      fail_input:
 	asus_backlight_exit();
 
       fail_backlight:
-- 
1.6.0.6

