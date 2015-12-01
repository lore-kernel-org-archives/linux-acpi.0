From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 12/14] wmi: Switch from acpi_driver.notify to acpi_install_notify_handler
Date: Mon, 30 Nov 2015 17:06:02 -0800
Message-ID: <df737c232c3033fa17ffcb6e5870b249b9abc227.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Arguably wmi should attach to the PNP platform device, not the ACPI
device.  As a platform driver, acpi_driver.notify won't be
available, so stop using it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 29448289f660..88265b28430c 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -92,7 +92,6 @@ MODULE_PARM_DESC(debug_dump_wdg,
 
 static int acpi_wmi_remove(struct acpi_device *device);
 static int acpi_wmi_add(struct acpi_device *device);
-static void acpi_wmi_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id wmi_device_ids[] = {
 	{"PNP0C14", 0},
@@ -108,7 +107,6 @@ static struct acpi_driver acpi_wmi_driver = {
 	.ops = {
 		.add = acpi_wmi_add,
 		.remove = acpi_wmi_remove,
-		.notify = acpi_wmi_notify,
 	},
 };
 
@@ -1116,7 +1114,8 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 	}
 }
 
-static void acpi_wmi_notify(struct acpi_device *device, u32 event)
+static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
+				    void *context)
 {
 	struct guid_block *block;
 	struct wmi_block *wblock;
@@ -1127,7 +1126,7 @@ static void acpi_wmi_notify(struct acpi_device *device, u32 event)
 		wblock = list_entry(p, struct wmi_block, list);
 		block = &wblock->gblock;
 
-		if (wblock->acpi_device == device &&
+		if (wblock->acpi_device->handle == handle &&
 		    (block->flags & ACPI_WMI_EVENT) &&
 		    (block->notify_id == event))
 		{
@@ -1179,13 +1178,16 @@ static void acpi_wmi_notify(struct acpi_device *device, u32 event)
 	}
 
 	acpi_bus_generate_netlink_event(
-		device->pnp.device_class, dev_name(&device->dev),
+		wblock->acpi_device->pnp.device_class,
+		dev_name(&wblock->dev.dev),
 		event, 0);
 
 }
 
 static int acpi_wmi_remove(struct acpi_device *device)
 {
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_wmi_notify_handler);
 	acpi_remove_address_space_handler(device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
 	wmi_free_devices(device);
@@ -1210,11 +1212,20 @@ static int acpi_wmi_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
+	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					     acpi_wmi_notify_handler,
+					     NULL);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&device->dev, "Error installing notify handler\n");
+		error = -ENODEV;
+		goto err_remove_ec_handler;
+	}
+
 	wmi_bus_dev = device_create(&wmi_bus_class, &device->dev, MKDEV(0, 0),
 				    NULL, "wmi_bus-%s", dev_name(&device->dev));
 	if (IS_ERR(wmi_bus_dev)) {
 		error = PTR_ERR(wmi_bus_dev);
-		goto err_remove_handler;
+		goto err_remove_notify_handler;
 	}
 	device->driver_data = wmi_bus_dev;
 
@@ -1230,7 +1241,11 @@ err_remove_busdev:
 	device_unregister(wmi_bus_dev);
 	put_device(wmi_bus_dev);
 
-err_remove_handler:
+err_remove_notify_handler:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_wmi_notify_handler);
+
+err_remove_ec_handler:
 	acpi_remove_address_space_handler(device->handle,
 					  ACPI_ADR_SPACE_EC,
 					  &acpi_wmi_ec_space_handler);
-- 
2.5.0
