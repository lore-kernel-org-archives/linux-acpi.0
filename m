From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 13/14] wmi: Bind the platform device, not the ACPI node
Date: Mon, 30 Nov 2015 17:06:03 -0800
Message-ID: <a881575be17fd4f3ceb7294a8b87b759cdf9e62d.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46928 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373AbbLABG2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 20:06:28 -0500
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>

We already have the PNP glue to instantiate platform devices for the
ACPI devices that WMI drives.  WMI should therefore attach to the
platform device, not the ACPI node.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 57 +++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 88265b28430c..100130895fe2 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -37,6 +37,7 @@
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/wmi.h>
 
 ACPI_MODULE_NAME("wmi");
@@ -90,8 +91,8 @@ module_param(debug_dump_wdg, bool, 0444);
 MODULE_PARM_DESC(debug_dump_wdg,
 		 "Dump available WMI interfaces [0/1]");
 
-static int acpi_wmi_remove(struct acpi_device *device);
-static int acpi_wmi_add(struct acpi_device *device);
+static int acpi_wmi_remove(struct platform_device *device);
+static int acpi_wmi_probe(struct platform_device *device);
 
 static const struct acpi_device_id wmi_device_ids[] = {
 	{"PNP0C14", 0},
@@ -100,14 +101,13 @@ static const struct acpi_device_id wmi_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 
-static struct acpi_driver acpi_wmi_driver = {
-	.name = "acpi-wmi",
-	.owner = THIS_MODULE,
-	.ids = wmi_device_ids,
-	.ops = {
-		.add = acpi_wmi_add,
-		.remove = acpi_wmi_remove,
+static struct platform_driver acpi_wmi_driver = {
+	.driver = {
+		.name = "acpi-wmi",
+		.acpi_match_table = wmi_device_ids,
 	},
+	.probe = acpi_wmi_probe,
+	.remove = acpi_wmi_remove,
 };
 
 /*
@@ -1184,26 +1184,34 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 
 }
 
-static int acpi_wmi_remove(struct acpi_device *device)
+static int acpi_wmi_remove(struct platform_device *device)
 {
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+	struct acpi_device *acpi_device = ACPI_COMPANION(&device->dev);
+
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOTIFY,
 				   acpi_wmi_notify_handler);
-	acpi_remove_address_space_handler(device->handle,
+	acpi_remove_address_space_handler(acpi_device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-	wmi_free_devices(device);
-	device_unregister((struct device *)acpi_driver_data(device));
-	device->driver_data = NULL;
+	wmi_free_devices(acpi_device);
+	device_unregister((struct device *)dev_get_drvdata(&device->dev));
 
 	return 0;
 }
 
-static int acpi_wmi_add(struct acpi_device *device)
+static int acpi_wmi_probe(struct platform_device *device)
 {
+	struct acpi_device *acpi_device;
 	struct device *wmi_bus_dev;
 	acpi_status status;
 	int error;
 
-	status = acpi_install_address_space_handler(device->handle,
+	acpi_device = ACPI_COMPANION(&device->dev);
+	if (!acpi_device) {
+		dev_err(&device->dev, "ACPI companion is missing\n");
+		return -ENODEV;
+	}
+
+	status = acpi_install_address_space_handler(acpi_device->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_wmi_ec_space_handler,
 						    NULL, NULL);
@@ -1212,7 +1220,8 @@ static int acpi_wmi_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
-	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+	status = acpi_install_notify_handler(acpi_device->handle,
+					     ACPI_DEVICE_NOTIFY,
 					     acpi_wmi_notify_handler,
 					     NULL);
 	if (ACPI_FAILURE(status)) {
@@ -1227,9 +1236,9 @@ static int acpi_wmi_add(struct acpi_device *device)
 		error = PTR_ERR(wmi_bus_dev);
 		goto err_remove_notify_handler;
 	}
-	device->driver_data = wmi_bus_dev;
+	dev_set_drvdata(&device->dev, wmi_bus_dev);
 
-	error = parse_wdg(wmi_bus_dev, device);
+	error = parse_wdg(wmi_bus_dev, acpi_device);
 	if (error) {
 		pr_err("Failed to parse WDG method\n");
 		goto err_remove_busdev;
@@ -1242,11 +1251,11 @@ err_remove_busdev:
 	put_device(wmi_bus_dev);
 
 err_remove_notify_handler:
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOTIFY,
 				   acpi_wmi_notify_handler);
 
 err_remove_ec_handler:
-	acpi_remove_address_space_handler(device->handle,
+	acpi_remove_address_space_handler(acpi_device->handle,
 					  ACPI_ADR_SPACE_EC,
 					  &acpi_wmi_ec_space_handler);
 
@@ -1284,7 +1293,7 @@ static int __init acpi_wmi_init(void)
 	if (error)
 		goto err_unreg_class;
 
-	error = acpi_bus_register_driver(&acpi_wmi_driver);
+	error = platform_driver_register(&acpi_wmi_driver);
 	if (error) {
 		pr_err("Error loading mapper\n");
 		goto err_unreg_bus;
@@ -1303,7 +1312,7 @@ err_unreg_bus:
 
 static void __exit acpi_wmi_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_wmi_driver);
+	platform_driver_unregister(&acpi_wmi_driver);
 	class_unregister(&wmi_bus_class);
 	bus_unregister(&wmi_bus_type);
 }
-- 
2.5.0

