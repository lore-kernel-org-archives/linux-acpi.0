From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] Fix autloading of dock, video, bay and all linux
	specific HID drivers
Date: Fri, 07 Dec 2007 13:20:34 +0100
Message-ID: <1197030034.28990.129.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbXLGMUf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 07:20:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: fseidel <fseidel@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Holger Macht <hmacht@suse.de>, akpm <akpm@linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>

From: Frank Seidel <fseidel@suse.de>

Fix autloading of dock, video, bay and all linux specific HID drivers

References: https://bugzilla.novell.com/show_bug.cgi?id=302482

Due to the new autloading of acpi drivers, the dock driver
wasn't loaded anymore as there is no HID to identify it with
(dock is needed if ACPI has a  _DCK method).
This patch is a workaround for this, original by Thomas Renninger,
revised first by Kay Sievers and last by Frank Seidel.
V2 of this patch fixed problems on systems without a defined _CID for
the docking devices.

Signed-off-by: Thomas Renninger <trenn@novell.com>
Signed-off-by: Kay Sievers <kasievers@novell.com>
Signed-off-by: Frank Seidel <fseidel@suse.de>

---
 drivers/acpi/scan.c |  101 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -941,6 +941,15 @@ static int acpi_bay_match(struct acpi_de
 	return -ENODEV;
 }
 
+/*
+ * acpi_dock_match - see if a device has a _DCK method
+ */
+static int acpi_dock_match(struct acpi_device *device)
+{
+	acpi_handle tmp;
+	return acpi_get_handle(device->handle, "_DCK", &tmp);
+}
+
 static void acpi_device_set_id(struct acpi_device *device,
 			       struct acpi_device *parent, acpi_handle handle,
 			       int type)
@@ -950,6 +959,7 @@ static void acpi_device_set_id(struct ac
 	char *hid = NULL;
 	char *uid = NULL;
 	struct acpi_compatible_id_list *cid_list = NULL;
+	const char *cid_add = NULL;
 	acpi_status status;
 
 	switch (type) {
@@ -972,15 +982,18 @@ static void acpi_device_set_id(struct ac
 			device->flags.bus_address = 1;
 		}
 
-		if(!(info->valid & (ACPI_VALID_HID | ACPI_VALID_CID))){
-			status = acpi_video_bus_match(device);
-			if(ACPI_SUCCESS(status))
-				hid = ACPI_VIDEO_HID;
-
-			status = acpi_bay_match(device);
-			if (ACPI_SUCCESS(status))
-				hid = ACPI_BAY_HID;
-		}
+		/* If we have a video/bay/dock device, add our selfdefined
+		   HID to the CID list. Like that the video/bay/dock drivers
+		   will get autoloaded and the device might still match
+		   against another driver.
+		*/
+		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
+			cid_add = ACPI_VIDEO_HID;
+		else if (ACPI_SUCCESS(acpi_bay_match(device)))
+			cid_add = ACPI_BAY_HID;
+		else if (ACPI_SUCCESS(acpi_dock_match(device)))
+			cid_add = ACPI_DOCK_HID;
+
 		break;
 	case ACPI_BUS_TYPE_POWER:
 		hid = ACPI_POWER_HID;
@@ -1021,11 +1034,43 @@ static void acpi_device_set_id(struct ac
 		strcpy(device->pnp.unique_id, uid);
 		device->flags.unique_id = 1;
 	}
-	if (cid_list) {
-		device->pnp.cid_list = kmalloc(cid_list->size, GFP_KERNEL);
-		if (device->pnp.cid_list)
-			memcpy(device->pnp.cid_list, cid_list, cid_list->size);
-		else
+	if (cid_list || cid_add) {
+		struct  acpi_compatible_id_list *list;
+		int size = 0;
+		int count = 0;
+
+		if (cid_list) {
+			size = cid_list->size;
+		} else if (cid_add) {
+			size = sizeof(struct acpi_compatible_id_list);
+			cid_list = ACPI_ALLOCATE_ZEROED((acpi_size) size);
+			if (!cid_list) {
+				printk(KERN_ERR "Memory allocation error\n");
+				kfree(buffer.pointer);
+				return;
+			} else {
+				cid_list->count = 0;
+				cid_list->size = size;
+			}
+		}
+		if (cid_add)
+			size += sizeof(struct acpi_compatible_id);
+		list = kmalloc(size, GFP_KERNEL);
+
+		if (list) {
+			if (cid_list) {
+				memcpy(list, cid_list, cid_list->size);
+				count = cid_list->count;
+			}
+			if (cid_add) {
+				strncpy(list->id[count].value, cid_add, ACPI_MAX_CID_LENGTH);
+				count++;
+				device->flags.compatible_ids = 1;
+			}
+			list->size = size;
+			list->count = count;
+			device->pnp.cid_list = list;
+		} else
 			printk(KERN_ERR "Memory allocation error\n");
 	}
 
@@ -1081,6 +1126,20 @@ static int acpi_bus_remove(struct acpi_d
 }
 
 static int
+acpi_is_child_device(struct acpi_device *device,
+			int (*matcher)(struct acpi_device*))
+{
+	int result = -ENODEV;
+
+	do {
+		if (ACPI_SUCCESS(matcher(device)))
+			return AE_OK;
+	} while ((device = device->parent));
+
+	return result;
+}
+
+static int
 acpi_add_single_object(struct acpi_device **child,
 		       struct acpi_device *parent, acpi_handle handle, int type,
 			struct acpi_bus_ops *ops)
@@ -1131,10 +1190,20 @@ acpi_add_single_object(struct acpi_devic
 	case ACPI_BUS_TYPE_PROCESSOR:
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
-			result = -ENOENT;
+		if (ACPI_FAILURE(result)) {
+			result = -ENODEV;
 			goto end;
 		}
+		if (!device->status.present) {
+                	/* Bay and dock should be handled even if absent */
+			if (!ACPI_SUCCESS(
+			     acpi_is_child_device(device, acpi_bay_match)) &&
+			    !ACPI_SUCCESS(
+			     acpi_is_child_device(device, acpi_dock_match))) {
+					result = -ENODEV;
+					goto end;
+			}
+		}
 		break;
 	default:
 		STRUCT_TO_INT(device->status) =


