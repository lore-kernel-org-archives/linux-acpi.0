From: Len Brown <lenb@kernel.org>
Subject: [PATCH 008/112] ACPI: Fix autloading of dock, video, bay and all linux specific HID drivers
Date: Thu,  7 Feb 2008 04:33:30 -0500
Message-ID: <3620f2f2f39e7870cf1a4fb2e34063a142f28716.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755043AbYBGJf0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:26 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frank Seidel <fseidel@suse.de>, Thomas Renninger <trenn@novell.com>, Kay Sievers <kasievers@novell.com>, Len Brown <len.brown@intel.com>

From: Frank Seidel <fseidel@suse.de>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |  100 +++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5b4d462..bf07926 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -941,6 +941,15 @@ static int acpi_bay_match(struct acpi_device *device){
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
@@ -950,6 +959,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 	char *hid = NULL;
 	char *uid = NULL;
 	struct acpi_compatible_id_list *cid_list = NULL;
+	const char *cid_add = NULL;
 	acpi_status status;
 
 	switch (type) {
@@ -972,15 +982,18 @@ static void acpi_device_set_id(struct acpi_device *device,
 			device->flags.bus_address = 1;
 		}
 
-		if(!(info->valid & (ACPI_VALID_HID | ACPI_VALID_CID))){
-			status = acpi_video_bus_match(device);
-			if(ACPI_SUCCESS(status))
-				hid = ACPI_VIDEO_HID;
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
 
-			status = acpi_bay_match(device);
-			if (ACPI_SUCCESS(status))
-				hid = ACPI_BAY_HID;
-		}
 		break;
 	case ACPI_BUS_TYPE_POWER:
 		hid = ACPI_POWER_HID;
@@ -1021,11 +1034,44 @@ static void acpi_device_set_id(struct acpi_device *device,
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
+				strncpy(list->id[count].value, cid_add,
+					ACPI_MAX_CID_LENGTH);
+				count++;
+				device->flags.compatible_ids = 1;
+			}
+			list->size = size;
+			list->count = count;
+			device->pnp.cid_list = list;
+		} else
 			printk(KERN_ERR "Memory allocation error\n");
 	}
 
@@ -1081,6 +1127,20 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 }
 
 static int
+acpi_is_child_device(struct acpi_device *device,
+			int (*matcher)(struct acpi_device *))
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
@@ -1131,10 +1191,20 @@ acpi_add_single_object(struct acpi_device **child,
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
+			/* Bay and dock should be handled even if absent */
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
-- 
1.5.4.23.gef5b9

