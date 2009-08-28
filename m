From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 05/24] eeepc-laptop: make input device a child of the platform device
Date: Fri, 28 Aug 2009 14:56:36 +0200
Message-ID: <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.12]:61286 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbZH1NDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:40 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2210.sfr.fr (SMTP Server) with ESMTP id 581A57001C95
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:03:42 +0200 (CEST)
In-Reply-To: <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Sysfs showed the ehotk input device as a "virtual" device - lies!
The input device is provided by a physical device, the eeepc platform.

This requires that we move the creation of the input device to come
after platform device is created.  Input initialization is moved from
ehotk_check() [sic] to a new function called eeepc_input_init().  This
brings the input device into line with the other eeepc-laptop devices.

Also, refuse to load if we fail to register the input device.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.4


