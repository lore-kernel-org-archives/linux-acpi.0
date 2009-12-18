From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] eeepc-laptop - switch to using sparse keymap library
Date: Thu, 17 Dec 2009 22:24:55 -0800
Message-ID: <20091218062454.GE21231@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43214 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZLRGZB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 01:25:01 -0500
Received: by pwj9 with SMTP id 9so1744556pwj.21
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2009 22:25:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Switch the driver to use sparse keymap library instead of using custom
implementation of keymap handling.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Updated to apply on acpi-test.

 drivers/platform/x86/Kconfig        |    1 
 drivers/platform/x86/eeepc-laptop.c |  187 ++++++++++-------------------------
 2 files changed, 53 insertions(+), 135 deletions(-)


diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6eebd09..4ecbfb4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -337,6 +337,7 @@ config EEEPC_LAPTOP
 	select HWMON
 	select LEDS_CLASS
 	select NEW_LEDS
+	select INPUT_SPARSEKMAP
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 5838c69..98da9b1 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -31,6 +31,7 @@
 #include <acpi/acpi_bus.h>
 #include <linux/uaccess.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <linux/rfkill.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
@@ -120,38 +121,29 @@ static const char *cm_setv[] = {
 	NULL, NULL, "PBPS", "TPDS"
 };
 
-struct key_entry {
-	char type;
-	u8 code;
-	u16 keycode;
-};
-
-enum { KE_KEY, KE_END };
-
 static const struct key_entry eeepc_keymap[] = {
-	/* Sleep already handled via generic ACPI code */
-	{KE_KEY, 0x10, KEY_WLAN },
-	{KE_KEY, 0x11, KEY_WLAN },
-	{KE_KEY, 0x12, KEY_PROG1 },
-	{KE_KEY, 0x13, KEY_MUTE },
-	{KE_KEY, 0x14, KEY_VOLUMEDOWN },
-	{KE_KEY, 0x15, KEY_VOLUMEUP },
-	{KE_KEY, 0x16, KEY_DISPLAY_OFF },
-	{KE_KEY, 0x1a, KEY_COFFEE },
-	{KE_KEY, 0x1b, KEY_ZOOM },
-	{KE_KEY, 0x1c, KEY_PROG2 },
-	{KE_KEY, 0x1d, KEY_PROG3 },
-	{KE_KEY, NOTIFY_BRN_MIN, KEY_BRIGHTNESSDOWN },
-	{KE_KEY, NOTIFY_BRN_MAX, KEY_BRIGHTNESSUP },
-	{KE_KEY, 0x30, KEY_SWITCHVIDEOMODE },
-	{KE_KEY, 0x31, KEY_SWITCHVIDEOMODE },
-	{KE_KEY, 0x32, KEY_SWITCHVIDEOMODE },
-	{KE_KEY, 0x37, KEY_F13 }, /* Disable Touchpad */
-	{KE_KEY, 0x38, KEY_F14 },
-	{KE_END, 0},
+	{ KE_KEY, 0x10, { KEY_WLAN } },
+	{ KE_KEY, 0x11, { KEY_WLAN } },
+	{ KE_KEY, 0x12, { KEY_PROG1 } },
+	{ KE_KEY, 0x13, { KEY_MUTE } },
+	{ KE_KEY, 0x14, { KEY_VOLUMEDOWN } },
+	{ KE_KEY, 0x15, { KEY_VOLUMEUP } },
+	{ KE_KEY, 0x16, { KEY_DISPLAY_OFF } },
+	{ KE_KEY, 0x1a, { KEY_COFFEE } },
+	{ KE_KEY, 0x1b, { KEY_ZOOM } },
+	{ KE_KEY, 0x1c, { KEY_PROG2 } },
+	{ KE_KEY, 0x1d, { KEY_PROG3 } },
+	{ KE_KEY, NOTIFY_BRN_MIN,     { KEY_BRIGHTNESSDOWN } },
+	{ KE_IGNORE, NOTIFY_BRN_MIN + 1, },
+	{ KE_KEY, NOTIFY_BRN_MIN + 2, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x30, { KEY_SWITCHVIDEOMODE } },
+	{ KE_KEY, 0x31, { KEY_SWITCHVIDEOMODE } },
+	{ KE_KEY, 0x32, { KEY_SWITCHVIDEOMODE } },
+	{ KE_KEY, 0x37, { KEY_F13 } }, /* Disable Touchpad */
+	{ KE_KEY, 0x38, { KEY_F14 } },
+	{ KE_END, 0 },
 };
 
-
 /*
  * This is the main structure, we can use it to store useful information
  */
@@ -1090,120 +1082,42 @@ static void eeepc_backlight_exit(struct eeepc_laptop *eeepc)
 /*
  * Input device (i.e. hotkeys)
  */
-static struct key_entry *eeepc_get_entry_by_scancode(
-	struct eeepc_laptop *eeepc,
-	int code)
+static int eeepc_input_init(struct eeepc_laptop *eeepc)
 {
-	struct key_entry *key;
-
-	for (key = eeepc->keymap; key->type != KE_END; key++)
-		if (code == key->code)
-			return key;
+	struct input_dev *input;
+	int error;
 
-	return NULL;
-}
-
-static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
-{
-	static struct key_entry *key;
-
-	key = eeepc_get_entry_by_scancode(eeepc, event);
-	if (key) {
-		switch (key->type) {
-		case KE_KEY:
-			input_report_key(eeepc->inputdev, key->keycode,
-						1);
-			input_sync(eeepc->inputdev);
-			input_report_key(eeepc->inputdev, key->keycode,
-						0);
-			input_sync(eeepc->inputdev);
-			break;
-		}
+	input = input_allocate_device();
+	if (!input) {
+		pr_info("Unable to allocate input device\n");
+		return -ENOMEM;
 	}
-}
-
-static struct key_entry *eeepc_get_entry_by_keycode(
-	struct eeepc_laptop *eeepc, int code)
-{
-	struct key_entry *key;
-
-	for (key = eeepc->keymap; key->type != KE_END; key++)
-		if (code == key->keycode && key->type == KE_KEY)
-			return key;
 
-	return NULL;
-}
+	input->name = "Asus EeePC extra buttons";
+	input->phys = EEEPC_LAPTOP_FILE "/input0";
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &eeepc->platform_device->dev;
 
-static int eeepc_getkeycode(struct input_dev *dev, int scancode, int *keycode)
-{
-	struct eeepc_laptop *eeepc = input_get_drvdata(dev);
-	struct key_entry *key = eeepc_get_entry_by_scancode(eeepc, scancode);
-
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
+	error = sparse_keymap_setup(input, eeepc_keymap, NULL);
+	if (error) {
+		pr_err("Unable to setup input device keymap\n");
+		goto err_free_dev;
 	}
 
-	return -EINVAL;
-}
-
-static int eeepc_setkeycode(struct input_dev *dev, int scancode, int keycode)
-{
-	struct eeepc_laptop *eeepc = input_get_drvdata(dev);
-	struct key_entry *key;
-	int old_keycode;
-
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = eeepc_get_entry_by_scancode(eeepc, scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!eeepc_get_entry_by_keycode(eeepc, old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
+	error = input_register_device(input);
+	if (error) {
+		pr_err("Unable to register input device\n");
+		goto err_free_keymap;
 	}
 
-	return -EINVAL;
-}
-
-static int eeepc_input_init(struct eeepc_laptop *eeepc)
-{
-	const struct key_entry *key;
-	int result;
-
-	eeepc->inputdev = input_allocate_device();
-	if (!eeepc->inputdev) {
-		pr_info("Unable to allocate input device\n");
-		return -ENOMEM;
-	}
-	eeepc->inputdev->name = "Asus EeePC extra buttons";
-	eeepc->inputdev->dev.parent = &eeepc->platform_device->dev;
-	eeepc->inputdev->phys = EEEPC_LAPTOP_FILE "/input0";
-	eeepc->inputdev->id.bustype = BUS_HOST;
-	eeepc->inputdev->getkeycode = eeepc_getkeycode;
-	eeepc->inputdev->setkeycode = eeepc_setkeycode;
-	input_set_drvdata(eeepc->inputdev, eeepc);
-
-	eeepc->keymap = kmemdup(eeepc_keymap, sizeof(eeepc_keymap),
-				GFP_KERNEL);
-	for (key = eeepc_keymap; key->type != KE_END; key++) {
-		switch (key->type) {
-		case KE_KEY:
-			set_bit(EV_KEY, eeepc->inputdev->evbit);
-			set_bit(key->keycode, eeepc->inputdev->keybit);
-			break;
-		}
-	}
-	result = input_register_device(eeepc->inputdev);
-	if (result) {
-		pr_info("Unable to register input device\n");
-		input_free_device(eeepc->inputdev);
-		return result;
-	}
+	eeepc->inputdev = input;
 	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(input);
+ err_free_dev:
+	input_free_device(input);
+	return error;
 }
 
 static void eeepc_input_exit(struct eeepc_laptop *eeepc)
@@ -1253,11 +1167,12 @@ static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
 				* event will be desired value (or else ignored)
 				*/
 			}
-			eeepc_input_notify(eeepc, event);
+			sparse_keymap_report_event(eeepc->inputdev, event,
+						   1, true);
 		}
 	} else {
 		/* Everything else is a bona-fide keypress event */
-		eeepc_input_notify(eeepc, event);
+		sparse_keymap_report_event(eeepc->inputdev, event, 1, true);
 	}
 }
 
@@ -1452,10 +1367,12 @@ static int __init eeepc_laptop_init(void)
 	result = acpi_bus_register_driver(&eeepc_acpi_driver);
 	if (result < 0)
 		goto fail_acpi_driver;
+
 	if (!eeepc_device_present) {
 		result = -ENODEV;
 		goto fail_no_device;
 	}
+
 	return 0;
 
 fail_no_device:
-- 
Dmitry
