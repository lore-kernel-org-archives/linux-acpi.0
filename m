From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 04/14] wmi: Track wmi devices per ACPI device
Date: Mon, 30 Nov 2015 17:05:54 -0800
Message-ID: <1f46c6ccd05508b4fdf1537373df48d8b6c06e81.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Currently we free all devices when we detach from any ACPI node.
Instead, keep track of which node WMI devices are attached to and
free them only as needed.  While we're at it, match up notifications
with the device they came from correctly.

This will make our behavior more straightforward on systems with
more than one WMI node in the ACPI tables (e.g. the Dell XPS 13
9350).

This also adds a warning when GUIDs aren't unique.

NB: The guid_string parameter in guid_already_parsed was a
little-endian binary GUID, not a string.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 58 ++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index fc1f339b7431..dcb34a5f5669 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -63,7 +63,7 @@ struct guid_block {
 struct wmi_block {
 	struct list_head list;
 	struct guid_block gblock;
-	acpi_handle handle;
+	struct acpi_device *acpi_device;
 	wmi_notify_handler handler;
 	void *handler_data;
 	struct device dev;
@@ -225,7 +225,7 @@ static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 	acpi_handle handle;
 
 	block = &wblock->gblock;
-	handle = wblock->handle;
+	handle = wblock->acpi_device->handle;
 
 	snprintf(method, 5, "WE%02X", block->notify_id);
 	status = acpi_execute_simple_method(handle, method, enable);
@@ -264,7 +264,7 @@ u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
 		return AE_ERROR;
 
 	block = &wblock->gblock;
-	handle = wblock->handle;
+	handle = wblock->acpi_device->handle;
 
 	if (!(block->flags & ACPI_WMI_METHOD))
 		return AE_BAD_DATA;
@@ -326,7 +326,7 @@ struct acpi_buffer *out)
 		return AE_ERROR;
 
 	block = &wblock->gblock;
-	handle = wblock->handle;
+	handle = wblock->acpi_device->handle;
 
 	if (block->instance_count < instance)
 		return AE_BAD_PARAMETER;
@@ -399,7 +399,7 @@ const struct acpi_buffer *in)
 		return AE_ERROR;
 
 	block = &wblock->gblock;
-	handle = wblock->handle;
+	handle = wblock->acpi_device->handle;
 
 	if (block->instance_count < instance)
 		return AE_BAD_PARAMETER;
@@ -603,8 +603,8 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 
 		if ((gblock->flags & ACPI_WMI_EVENT) &&
 			(gblock->notify_id == event))
-			return acpi_evaluate_object(wblock->handle, "_WED",
-				&input, out);
+			return acpi_evaluate_object(wblock->acpi_device->handle,
+				"_WED", &input, out);
 	}
 
 	return AE_NOT_FOUND;
@@ -696,27 +696,40 @@ static int wmi_create_device(const struct guid_block *gblock,
 	return device_register(&wblock->dev);
 }
 
-static void wmi_free_devices(void)
+static void wmi_free_devices(struct acpi_device *device)
 {
 	struct wmi_block *wblock, *next;
 
 	/* Delete devices for all the GUIDs */
 	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		list_del(&wblock->list);
-		if (wblock->dev.class)
-			device_unregister(&wblock->dev);
-		else
-			kfree(wblock);
+		if (wblock->acpi_device == device) {
+			list_del(&wblock->list);
+			if (wblock->dev.class)
+				device_unregister(&wblock->dev);
+			else
+				kfree(wblock);
+		}
 	}
 }
 
-static bool guid_already_parsed(const char *guid_string)
+static bool guid_already_parsed(struct acpi_device *device,
+				const u8 *guid)
 {
 	struct wmi_block *wblock;
 
-	list_for_each_entry(wblock, &wmi_block_list, list)
-		if (memcmp(wblock->gblock.guid, guid_string, 16) == 0)
+	list_for_each_entry(wblock, &wmi_block_list, list) {
+		if (memcmp(wblock->gblock.guid, guid, 16) == 0) {
+			/*
+			 * Because we historically didn't track the relationship
+			 * between GUIDs and ACPI nodes, we don't know whether
+			 * we need to suppress GUIDs that are unique on a
+			 * given node but duplicated across nodes.
+			 */
+			dev_warn(&device->dev, "duplicate WMI GUID %pUL (first instance was on %s)\n",
+				 guid, dev_name(&wblock->acpi_device->dev));
 			return true;
+		}
+	}
 
 	return false;
 }
@@ -758,7 +771,7 @@ static int parse_wdg(struct acpi_device *device)
 		if (!wblock)
 			return -ENOMEM;
 
-		wblock->handle = device->handle;
+		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
 		/*
@@ -767,10 +780,10 @@ static int parse_wdg(struct acpi_device *device)
 		  case yet, so for now, we'll just ignore the duplicate
 		  for device creation.
 		*/
-		if (!guid_already_parsed(gblock[i].guid)) {
+		if (!guid_already_parsed(device, gblock[i].guid)) {
 			retval = wmi_create_device(&gblock[i], wblock, device);
 			if (retval) {
-				wmi_free_devices();
+				wmi_free_devices(device);
 				goto out_free_pointer;
 			}
 		}
@@ -845,8 +858,9 @@ static void acpi_wmi_notify(struct acpi_device *device, u32 event)
 		wblock = list_entry(p, struct wmi_block, list);
 		block = &wblock->gblock;
 
-		if ((block->flags & ACPI_WMI_EVENT) &&
-			(block->notify_id == event)) {
+		if (wblock->acpi_device == device &&
+		    (block->flags & ACPI_WMI_EVENT) &&
+		    (block->notify_id == event)) {
 			if (wblock->handler)
 				wblock->handler(event, wblock->handler_data);
 			if (debug_event) {
@@ -866,7 +880,7 @@ static int acpi_wmi_remove(struct acpi_device *device)
 {
 	acpi_remove_address_space_handler(device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-	wmi_free_devices();
+	wmi_free_devices(device);
 
 	return 0;
 }
-- 
2.5.0
