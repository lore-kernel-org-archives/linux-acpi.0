From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 10/16] platform/x86: wmi: Incorporate acpi_install_notify_handler
Date: Fri, 26 May 2017 22:31:24 -0700
Message-ID: <a868fcacf5342c40371084d183b205fc1d19bc88.1495862272.git.dvhart@infradead.org>
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

As a platform driver, acpi_driver.notify will not be available,
so use acpi_install_notify_handler as we will be converting to a
platform driver.

This gives event drivers a simple way to handle events. It
also seems closer to what the Windows docs suggest that Windows
does: it sounds like, in Windows, the mapper is responsible for
called _WED before dispatching to the subdriver.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
[dvhart: merge two development commits and update commit message]
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 89 +++++++++++++++++++++++++++++++++++++---------
 include/linux/wmi.h        |  1 +
 2 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index bfc0a3f..208e187 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -93,7 +93,6 @@ MODULE_PARM_DESC(debug_dump_wdg,
 
 static int acpi_wmi_remove(struct acpi_device *device);
 static int acpi_wmi_add(struct acpi_device *device);
-static void acpi_wmi_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id wmi_device_ids[] = {
 	{"PNP0C14", 0},
@@ -109,7 +108,6 @@ static struct acpi_driver acpi_wmi_driver = {
 	.ops = {
 		.add = acpi_wmi_add,
 		.remove = acpi_wmi_remove,
-		.notify = acpi_wmi_notify,
 	},
 };
 
@@ -1023,36 +1021,80 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 	}
 }
 
-static void acpi_wmi_notify(struct acpi_device *device, u32 event)
+static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
+				    void *context)
 {
 	struct guid_block *block;
 	struct wmi_block *wblock;
 	struct list_head *p;
+	bool found_it = false;
 
 	list_for_each(p, &wmi_block_list) {
 		wblock = list_entry(p, struct wmi_block, list);
 		block = &wblock->gblock;
 
-		if (wblock->acpi_device == device &&
+		if (wblock->acpi_device->handle == handle &&
 		    (block->flags & ACPI_WMI_EVENT) &&
-		    (block->notify_id == event)) {
-			if (wblock->handler)
-				wblock->handler(event, wblock->handler_data);
-			if (debug_event) {
-				pr_info("DEBUG Event GUID: %pUL\n",
-					wblock->gblock.guid);
-			}
-
-			acpi_bus_generate_netlink_event(
-				device->pnp.device_class, dev_name(&device->dev),
-				event, 0);
+		    (block->notify_id == event))
+		{
+			found_it = true;
 			break;
 		}
 	}
+
+	if (!found_it)
+		return;
+
+	/* If a driver is bound, then notify the driver. */
+	if (wblock->dev.dev.driver) {
+		struct wmi_driver *driver;
+		struct acpi_object_list input;
+		union acpi_object params[1];
+		struct acpi_buffer evdata = { ACPI_ALLOCATE_BUFFER, NULL };
+		acpi_status status;
+
+		driver = container_of(wblock->dev.dev.driver,
+				      struct wmi_driver, driver);
+
+		input.count = 1;
+		input.pointer = params;
+		params[0].type = ACPI_TYPE_INTEGER;
+		params[0].integer.value = event;
+
+		status = acpi_evaluate_object(wblock->acpi_device->handle,
+					      "_WED", &input, &evdata);
+		if (ACPI_FAILURE(status)) {
+			dev_warn(&wblock->dev.dev,
+				 "failed to get event data\n");
+			return;
+		}
+
+		if (driver->notify)
+			driver->notify(&wblock->dev,
+				       (union acpi_object *)evdata.pointer);
+
+		kfree(evdata.pointer);
+	} else if (wblock->handler) {
+		/* Legacy handler */
+		wblock->handler(event, wblock->handler_data);
+	}
+
+	if (debug_event) {
+		pr_info("DEBUG Event GUID: %pUL\n",
+			wblock->gblock.guid);
+	}
+
+	acpi_bus_generate_netlink_event(
+		wblock->acpi_device->pnp.device_class,
+		dev_name(&wblock->dev.dev),
+		event, 0);
+
 }
 
 static int acpi_wmi_remove(struct acpi_device *device)
 {
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_wmi_notify_handler);
 	acpi_remove_address_space_handler(device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
 	wmi_free_devices(device);
@@ -1077,11 +1119,20 @@ static int acpi_wmi_add(struct acpi_device *device)
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
 
@@ -1096,7 +1147,11 @@ static int acpi_wmi_add(struct acpi_device *device)
 err_remove_busdev:
 	device_unregister(wmi_bus_dev);
 
-err_remove_handler:
+err_remove_notify_handler:
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_wmi_notify_handler);
+
+err_remove_ec_handler:
 	acpi_remove_address_space_handler(device->handle,
 					  ACPI_ADR_SPACE_EC,
 					  &acpi_wmi_ec_space_handler);
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 5309500..c6eedfd 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -39,6 +39,7 @@ struct wmi_driver {
 
 	int (*probe)(struct wmi_device *wdev);
 	int (*remove)(struct wmi_device *wdev);
+	void (*notify)(struct wmi_device *device, union acpi_object *data);
 };
 
 extern int __must_check __wmi_driver_register(struct wmi_driver *driver,
-- 
2.9.4
