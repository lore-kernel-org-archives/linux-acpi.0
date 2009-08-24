From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 10/10] ACPI: simplify building device HID/CID list
Date: Mon, 24 Aug 2009 10:39:21 -0600
Message-ID: <20090824163921.28131.36888.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:10380 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbZHXQjQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:39:16 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Minor code cleanup, no functional change.  Instead of remembering
what HIDs & CIDs to add later, just add them immediately.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   59 ++++++++++++++++++++++-----------------------------
 1 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a776018..44c333f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1014,22 +1014,20 @@ static void acpi_add_id(struct acpi_device *device, const char *dev_id)
 
 static void acpi_device_set_id(struct acpi_device *device)
 {
-	struct acpi_device_info *info;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	char *hid = NULL;
-	struct acpi_compatible_id_list *cid_list = NULL;
-	const char *cid_add = NULL;
 	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device_info *info;
+	struct acpi_compatible_id_list *cid_list;
 	int i;
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		if (ACPI_IS_ROOT_DEVICE(device)) {
-			hid = ACPI_SYSTEM_HID;
+			acpi_add_id(device, ACPI_SYSTEM_HID);
 			break;
 		} else if (ACPI_IS_ROOT_DEVICE(device->parent)) {
 			/* \_SB_, the only root-level namespace device */
-			hid = ACPI_BUS_HID;
+			acpi_add_id(device, ACPI_BUS_HID);
 			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
 			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
 			break;
@@ -1043,41 +1041,44 @@ static void acpi_device_set_id(struct acpi_device *device)
 
 		info = buffer.pointer;
 		if (info->valid & ACPI_VALID_HID)
-			hid = info->hardware_id.value;
-		if (info->valid & ACPI_VALID_CID)
+			acpi_add_id(device, info->hardware_id.value);
+		if (info->valid & ACPI_VALID_CID) {
 			cid_list = &info->compatibility_id;
+			for (i = 0; i < cid_list->count; i++)
+				acpi_add_id(device, cid_list->id[i].value);
+		}
 		if (info->valid & ACPI_VALID_ADR) {
 			device->pnp.bus_address = info->address;
 			device->flags.bus_address = 1;
 		}
+		kfree(buffer.pointer);
 
-		/* If we have a video/bay/dock device, add our selfdefined
-		   HID to the CID list. Like that the video/bay/dock drivers
-		   will get autoloaded and the device might still match
-		   against another driver.
-		*/
+		/*
+		 * Some devices don't reliably have _HIDs & _CIDs, so add
+		 * synthetic HIDs to make sure drivers can find them.
+		 */
 		if (acpi_is_video_device(device))
-			cid_add = ACPI_VIDEO_HID;
+			acpi_add_id(device, ACPI_VIDEO_HID);
 		else if (ACPI_SUCCESS(acpi_bay_match(device)))
-			cid_add = ACPI_BAY_HID;
+			acpi_add_id(device, ACPI_BAY_HID);
 		else if (ACPI_SUCCESS(acpi_dock_match(device)))
-			cid_add = ACPI_DOCK_HID;
+			acpi_add_id(device, ACPI_DOCK_HID);
 
 		break;
 	case ACPI_BUS_TYPE_POWER:
-		hid = ACPI_POWER_HID;
+		acpi_add_id(device, ACPI_POWER_HID);
 		break;
 	case ACPI_BUS_TYPE_PROCESSOR:
-		hid = ACPI_PROCESSOR_OBJECT_HID;
+		acpi_add_id(device, ACPI_PROCESSOR_OBJECT_HID);
 		break;
 	case ACPI_BUS_TYPE_THERMAL:
-		hid = ACPI_THERMAL_HID;
+		acpi_add_id(device, ACPI_THERMAL_HID);
 		break;
 	case ACPI_BUS_TYPE_POWER_BUTTON:
-		hid = ACPI_BUTTON_HID_POWERF;
+		acpi_add_id(device, ACPI_BUTTON_HID_POWERF);
 		break;
 	case ACPI_BUS_TYPE_SLEEP_BUTTON:
-		hid = ACPI_BUTTON_HID_SLEEPF;
+		acpi_add_id(device, ACPI_BUTTON_HID_SLEEPF);
 		break;
 	}
 
@@ -1088,18 +1089,8 @@ static void acpi_device_set_id(struct acpi_device *device)
 	 * This generic ID isn't useful for driver binding, but it provides
 	 * the useful property that "every acpi_device has an ID."
 	 */
-	if (!hid && !cid_list && !cid_add)
-		hid = "device";
-
-	if (hid)
-		acpi_add_id(device, hid);
-	if (cid_list)
-		for (i = 0; i < cid_list->count; i++)
-			acpi_add_id(device, cid_list->id[i].value);
-	if (cid_add)
-		acpi_add_id(device, cid_add);
-
-	kfree(buffer.pointer);
+	if (list_empty(&device->pnp.ids))
+		acpi_add_id(device, "device");
 }
 
 static int acpi_device_set_context(struct acpi_device *device)

