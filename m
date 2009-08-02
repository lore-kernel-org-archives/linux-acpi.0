From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 3/8] eeepc-laptop: fix ordering of init and exit functions
Date: Sun, 02 Aug 2009 16:56:12 +0100
Message-ID: <4A75B71C.7030202@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35842 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbZHBP4O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 11:56:14 -0400
Received: by ewy10 with SMTP id 10so2535576ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2009 08:56:14 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

1. input and backlight devices were registered after acpi notifications
   are enabled.  This left a window where eeepc_hotk_notify() might
   find these devices in an inconsistent (half-initialized) state.

-> Move all device registration into eeepc_hotk_add(), which is called
   before enabling acpi notifications.


2. input and backlight devices were unregistered before acpi
   notifications are disabled.  This left a window where
   eeepc_hotk_notify() might find these devices in an inconsistent
   (half-destroyed) state.

-> Move all device unregistration into eeepc_hotk_remove(), which is
   called after disabling acpi notifications.


3. The acpi driver was not freed if an error occured further down in
   eeepc_laptop_init().

-> The rest of eeepc_laptop_init() has been moved to eeepc_hotk_add(),
   so this is no longer a problem.


4. The acpi driver was unregistered before the platform driver.  This
   left a window where a sysfs access could attempt to read the ehotk
   structure after it had been freed by eeepc_hotk_remove().

-> The acpi driver is now unregistered as the last step in
   eeepc_laptop_exit(), so this is no longer a problem.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |  120 +++++++++++++++++------------------
 1 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 8dd86f7..cf47d1c 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -847,44 +847,6 @@ error_slot:
 	return ret;
 }
 
-static int eeepc_hotk_add(struct acpi_device *device)
-{
-	int result;
-
-	if (!device)
-		 return -EINVAL;
-	pr_notice(EEEPC_HOTK_NAME "\n");
-	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
-	if (!ehotk)
-		return -ENOMEM;
-	ehotk->init_flag = DISABLE_ASL_WLAN | DISABLE_ASL_DISPLAYSWITCH;
-	ehotk->handle = device->handle;
-	strcpy(acpi_device_name(device), EEEPC_HOTK_DEVICE_NAME);
-	strcpy(acpi_device_class(device), EEEPC_HOTK_CLASS);
-	device->driver_data = ehotk;
-	ehotk->device = device;
-	result = eeepc_hotk_check();
-	if (result)
-		goto ehotk_fail;
-
-	return 0;
-
- ehotk_fail:
-	kfree(ehotk);
-	ehotk = NULL;
-
-	return result;
-}
-
-static int eeepc_hotk_remove(struct acpi_device *device, int type)
-{
-	if (!device || !acpi_driver_data(device))
-		 return -EINVAL;
-
-	kfree(ehotk);
-	return 0;
-}
-
 static int eeepc_hotk_resume(struct acpi_device *device)
 {
 	if (ehotk->wlan_rfkill) {
@@ -1066,19 +1028,6 @@ static void eeepc_hwmon_exit(void)
 	eeepc_hwmon_device = NULL;
 }
 
-static void __exit eeepc_laptop_exit(void)
-{
-	eeepc_backlight_exit();
-	eeepc_rfkill_exit();
-	eeepc_input_exit();
-	eeepc_hwmon_exit();
-	acpi_bus_unregister_driver(&eeepc_hotk_driver);
-	sysfs_remove_group(&platform_device->dev.kobj,
-			   &platform_attribute_group);
-	platform_device_unregister(platform_device);
-	platform_driver_unregister(&platform_driver);
-}
-
 static int eeepc_new_rfkill(struct rfkill **rfkill,
 			    const char *name, struct device *dev,
 			    enum rfkill_type type, int cm)
@@ -1193,21 +1142,27 @@ static int eeepc_hwmon_init(struct device *dev)
 	return result;
 }
 
-static int __init eeepc_laptop_init(void)
+static int eeepc_hotk_add(struct acpi_device *device)
 {
 	struct device *dev;
 	int result;
 
-	if (acpi_disabled)
-		return -ENODEV;
-	result = acpi_bus_register_driver(&eeepc_hotk_driver);
-	if (result < 0)
-		return result;
-	if (!ehotk) {
-		acpi_bus_unregister_driver(&eeepc_hotk_driver);
-		return -ENODEV;
-	}
+	if (!device)
+		 return -EINVAL;
+	pr_notice(EEEPC_HOTK_NAME "\n");
+	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
+	if (!ehotk)
+		return -ENOMEM;
+	ehotk->init_flag = DISABLE_ASL_WLAN | DISABLE_ASL_DISPLAYSWITCH;
+	ehotk->handle = device->handle;
+	strcpy(acpi_device_name(device), EEEPC_HOTK_DEVICE_NAME);
+	strcpy(acpi_device_class(device), EEEPC_HOTK_CLASS);
+	device->driver_data = ehotk;
+	ehotk->device = device;
 
+	result = eeepc_hotk_check();
+	if (result)
+		goto fail_check;
 	eeepc_enable_camera();
 
 	/* Register platform stuff */
@@ -1246,6 +1201,7 @@ static int __init eeepc_laptop_init(void)
 		goto fail_rfkill;
 
 	return 0;
+
 fail_rfkill:
 	eeepc_hwmon_exit();
 fail_hwmon:
@@ -1261,8 +1217,50 @@ fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
 	eeepc_input_exit();
+fail_check:
+	kfree(ehotk);
+
 	return result;
 }
 
+static int eeepc_hotk_remove(struct acpi_device *device, int type)
+{
+	if (!device || !acpi_driver_data(device))
+		 return -EINVAL;
+
+	eeepc_backlight_exit();
+	eeepc_rfkill_exit();
+	eeepc_input_exit();
+	eeepc_hwmon_exit();
+	sysfs_remove_group(&platform_device->dev.kobj,
+			   &platform_attribute_group);
+	platform_device_unregister(platform_device);
+	platform_driver_unregister(&platform_driver);
+
+	kfree(ehotk);
+	return 0;
+}
+
+static int __init eeepc_laptop_init(void)
+{
+	int result;
+
+	if (acpi_disabled)
+		return -ENODEV;
+	result = acpi_bus_register_driver(&eeepc_hotk_driver);
+	if (result < 0)
+		return result;
+	if (!ehotk) {
+		acpi_bus_unregister_driver(&eeepc_hotk_driver);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void __exit eeepc_laptop_exit(void)
+{
+	acpi_bus_unregister_driver(&eeepc_hotk_driver);
+}
+
 module_init(eeepc_laptop_init);
 module_exit(eeepc_laptop_exit);
-- 
1.6.3.2

