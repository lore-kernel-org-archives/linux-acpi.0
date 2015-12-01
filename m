From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 10/14] wmi: Add a driver .notify function
Date: Mon, 30 Nov 2015 17:06:00 -0800
Message-ID: <7f1d3526155d12236b9d0126db391002294fe23b.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

This gives event drivers a very simple way to handle events.  It
also seems closer to what the Windows docs suggest that Windows
does: it sounds like, in Windows, the mapper is responsible for
called _WED before dispatching to the subdriver.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 62 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/wmi.h        |  1 +
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7d8a11a45bf9..24fabfef5e8e 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1099,6 +1099,7 @@ static void acpi_wmi_notify(struct acpi_device *device, u32 event)
 	struct guid_block *block;
 	struct wmi_block *wblock;
 	struct list_head *p;
+	bool found_it = false;
 
 	list_for_each(p, &wmi_block_list) {
 		wblock = list_entry(p, struct wmi_block, list);
@@ -1106,20 +1107,59 @@ static void acpi_wmi_notify(struct acpi_device *device, u32 event)
 
 		if (wblock->acpi_device == device &&
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
+		device->pnp.device_class, dev_name(&device->dev),
+		event, 0);
+
 }
 
 static int acpi_wmi_remove(struct acpi_device *device)
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 53095006821e..c6eedfd94e7d 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -39,6 +39,7 @@ struct wmi_driver {
 
 	int (*probe)(struct wmi_device *wdev);
 	int (*remove)(struct wmi_device *wdev);
+	void (*notify)(struct wmi_device *device, union acpi_object *data);
 };
 
 extern int __must_check __wmi_driver_register(struct wmi_driver *driver,
-- 
2.5.0
