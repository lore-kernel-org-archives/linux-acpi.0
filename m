From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 4/8] eeepc-laptop: make input device a child of the platform
 device
Date: Sun, 02 Aug 2009 16:56:29 +0100
Message-ID: <4A75B72D.7060807@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35842 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbZHBP4a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 11:56:30 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so2535576ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 08:56:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

Sysfs showed the ehotk input device as a "virtual" device - lies!
The input device is provided by a physical device, the eeepc platform.

This requires that we move the creation of the input device to come
after platform device is created.  Input initialization is moved from
ehotk_check() [sic] to a new function called eeepc_input_init().  This
brings the input device into line with the other eeepc-laptop devices.

Also, refuse to load if we fail to register the input device.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |   70 ++++++++++++++++++++--------------
 1 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index cf47d1c..298dac9 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -579,7 +579,6 @@ static void cmsg_quirks(void)
 
 static int eeepc_hotk_check(void)
 {
-	const struct key_entry *key;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	int result;
 
@@ -604,31 +603,6 @@ static int eeepc_hotk_check(void)
 			pr_info("Get control methods supported: 0x%x\n",
 				ehotk->cm_supported);
 		}
-		ehotk->inputdev = input_allocate_device();
-		if (!ehotk->inputdev) {
-			pr_info("Unable to allocate input device\n");
-			return 0;
-		}
-		ehotk->inputdev->name = "Asus EeePC extra buttons";
-		ehotk->inputdev->phys = EEEPC_HOTK_FILE "/input0";
-		ehotk->inputdev->id.bustype = BUS_HOST;
-		ehotk->inputdev->getkeycode = eeepc_getkeycode;
-		ehotk->inputdev->setkeycode = eeepc_setkeycode;
-
-		for (key = eeepc_keymap; key->type != KE_END; key++) {
-			switch (key->type) {
-			case KE_KEY:
-				set_bit(EV_KEY, ehotk->inputdev->evbit);
-				set_bit(key->keycode, ehotk->inputdev->keybit);
-				break;
-			}
-		}
-		result = input_register_device(ehotk->inputdev);
-		if (result) {
-			pr_info("Unable to register input device\n");
-			input_free_device(ehotk->inputdev);
-			return 0;
-		}
 	} else {
 		pr_err("Hotkey device not present, aborting\n");
 		return -EINVAL;
@@ -1142,6 +1116,40 @@ static int eeepc_hwmon_init(struct device *dev)
 	return result;
 }
 
+static int eeepc_input_init(struct device *dev)
+{
+	const struct key_entry *key;
+	int result;
+
+	ehotk->inputdev = input_allocate_device();
+	if (!ehotk->inputdev) {
+		pr_info("Unable to allocate input device\n");
+		return -ENOMEM;
+	}
+	ehotk->inputdev->name = "Asus EeePC extra buttons";
+	ehotk->inputdev->dev.parent = dev;
+	ehotk->inputdev->phys = EEEPC_HOTK_FILE "/input0";
+	ehotk->inputdev->id.bustype = BUS_HOST;
+	ehotk->inputdev->getkeycode = eeepc_getkeycode;
+	ehotk->inputdev->setkeycode = eeepc_setkeycode;
+
+	for (key = eeepc_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, ehotk->inputdev->evbit);
+			set_bit(key->keycode, ehotk->inputdev->keybit);
+			break;
+		}
+	}
+	result = input_register_device(ehotk->inputdev);
+	if (result) {
+		pr_info("Unable to register input device\n");
+		input_free_device(ehotk->inputdev);
+		return result;
+	}
+	return 0;
+}
+
 static int eeepc_hotk_add(struct acpi_device *device)
 {
 	struct device *dev;
@@ -1162,7 +1170,7 @@ static int eeepc_hotk_add(struct acpi_device *device)
 
 	result = eeepc_hotk_check();
 	if (result)
-		goto fail_check;
+		goto fail_platform_driver;
 	eeepc_enable_camera();
 
 	/* Register platform stuff */
@@ -1192,6 +1200,10 @@ static int eeepc_hotk_add(struct acpi_device *device)
 		pr_info("Backlight controlled by ACPI video "
 			"driver\n");
 
+	result = eeepc_input_init(dev);
+	if (result)
+		goto fail_input;
+
 	result = eeepc_hwmon_init(dev);
 	if (result)
 		goto fail_hwmon;
@@ -1205,6 +1217,8 @@ static int eeepc_hotk_add(struct acpi_device *device)
 fail_rfkill:
 	eeepc_hwmon_exit();
 fail_hwmon:
+	eeepc_input_exit();
+fail_input:
 	eeepc_backlight_exit();
 fail_backlight:
 	sysfs_remove_group(&platform_device->dev.kobj,
@@ -1216,8 +1230,6 @@ fail_platform_device2:
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
-	eeepc_input_exit();
-fail_check:
 	kfree(ehotk);
 
 	return result;
-- 
1.6.3.2

