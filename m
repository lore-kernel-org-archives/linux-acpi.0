From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 8/8] ACPI: simplify building device HID/CID list
Date: Mon, 31 Aug 2009 16:47:25 -0600
Message-ID: <20090831224725.12236.85639.stgit@bob.kio>
References: <20090831224535.12236.61350.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:46676 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbZHaWrT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:47:19 -0400
In-Reply-To: <20090831224535.12236.61350.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Minor code cleanup, no functional change.  Instead of remembering
what HIDs & CIDs to add later, just add them immediately.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   56 +++++++++++++++++++++------------------------------
 1 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f19a935..5dda709 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1014,21 +1014,19 @@ static void acpi_add_id(struct acpi_device *device, const char *dev_id)
 
 static void acpi_device_set_id(struct acpi_device *device)
 {
-	struct acpi_device_info *info = NULL;
-	char *hid = NULL;
-	struct acpica_device_id_list *cid_list = NULL;
-	char *cid_add = NULL;
 	acpi_status status;
+	struct acpi_device_info *info;
+	struct acpica_device_id_list *cid_list;
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
@@ -1041,41 +1039,43 @@ static void acpi_device_set_id(struct acpi_device *device)
 		}
 
 		if (info->valid & ACPI_VALID_HID)
-			hid = info->hardware_id.string;
-		if (info->valid & ACPI_VALID_CID)
+			acpi_add_id(device, info->hardware_id.string);
+		if (info->valid & ACPI_VALID_CID) {
 			cid_list = &info->compatible_id_list;
+			for (i = 0; i < cid_list->count; i++)
+				acpi_add_id(device, cid_list->ids[i].string);
+		}
 		if (info->valid & ACPI_VALID_ADR) {
 			device->pnp.bus_address = info->address;
 			device->flags.bus_address = 1;
 		}
 
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
 
@@ -1086,18 +1086,8 @@ static void acpi_device_set_id(struct acpi_device *device)
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
-			acpi_add_id(device, cid_list->ids[i].string);
-	if (cid_add)
-		acpi_add_id(device, cid_add);
-
-	kfree(info);
+	if (list_empty(&device->pnp.ids))
+		acpi_add_id(device, "device");
 }
 
 static int acpi_device_set_context(struct acpi_device *device)

