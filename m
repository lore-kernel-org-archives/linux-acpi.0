From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 12/16] platform/x86: wmi: Bind the platform device, not the ACPI node
Date: Fri, 26 May 2017 22:31:26 -0700
Message-ID: <ee94a4f1383c5fd3bb6ad024c0d7f298b40c6dea.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-acpi@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

We already have the PNP glue to instantiate platform devices for the
ACPI devices that WMI drives. WMI should therefore attach to the
platform device, not the ACPI node.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 57 +++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 483e4a6..f1c9464 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -37,6 +37,7 @@
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/wmi.h>
 #include <linux/uuid.h>
 
@@ -91,8 +92,8 @@ module_param(debug_dump_wdg, bool, 0444);
 MODULE_PARM_DESC(debug_dump_wdg,
 		 "Dump available WMI interfaces [0/1]");
 
-static int acpi_wmi_remove(struct acpi_device *device);
-static int acpi_wmi_add(struct acpi_device *device);
+static int acpi_wmi_remove(struct platform_device *device);
+static int acpi_wmi_probe(struct platform_device *device);
 
 static const struct acpi_device_id wmi_device_ids[] = {
 	{"PNP0C14", 0},
@@ -101,14 +102,13 @@ static const struct acpi_device_id wmi_device_ids[] = {
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
@@ -1113,26 +1113,34 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 
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
@@ -1141,7 +1149,8 @@ static int acpi_wmi_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
-	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+	status = acpi_install_notify_handler(acpi_device->handle,
+					     ACPI_DEVICE_NOTIFY,
 					     acpi_wmi_notify_handler,
 					     NULL);
 	if (ACPI_FAILURE(status)) {
@@ -1156,9 +1165,9 @@ static int acpi_wmi_add(struct acpi_device *device)
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
@@ -1170,11 +1179,11 @@ static int acpi_wmi_add(struct acpi_device *device)
 	device_unregister(wmi_bus_dev);
 
 err_remove_notify_handler:
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOTIFY,
 				   acpi_wmi_notify_handler);
 
 err_remove_ec_handler:
-	acpi_remove_address_space_handler(device->handle,
+	acpi_remove_address_space_handler(acpi_device->handle,
 					  ACPI_ADR_SPACE_EC,
 					  &acpi_wmi_ec_space_handler);
 
@@ -1212,7 +1221,7 @@ static int __init acpi_wmi_init(void)
 	if (error)
 		goto err_unreg_class;
 
-	error = acpi_bus_register_driver(&acpi_wmi_driver);
+	error = platform_driver_register(&acpi_wmi_driver);
 	if (error) {
 		pr_err("Error loading mapper\n");
 		goto err_unreg_bus;
@@ -1231,7 +1240,7 @@ static int __init acpi_wmi_init(void)
 
 static void __exit acpi_wmi_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_wmi_driver);
+	platform_driver_unregister(&acpi_wmi_driver);
 	class_unregister(&wmi_bus_class);
 	bus_unregister(&wmi_bus_type);
 }
-- 
2.9.4
