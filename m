From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 5/8] ACPI: remove acpi_device.flags.compatible_ids
Date: Mon, 21 Sep 2009 13:35:24 -0600
Message-ID: <20090921193524.21656.21804.stgit@bob.kio>
References: <20090921193417.21656.32718.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:4696 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbZIUTfV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:35:21 -0400
In-Reply-To: <20090921193417.21656.32718.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

We now keep a single list of IDs that includes both the _HID and any
_CIDs.  We no longer need to keep track of whether the device has a _CID.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c     |   15 ++++-----------
 include/acpi/acpi_bus.h |    3 +--
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9c65244..954cb1d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -47,7 +47,7 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 	int count;
 	struct acpi_hardware_id *id;
 
-	if (!acpi_dev->flags.hardware_id && !acpi_dev->flags.compatible_ids)
+	if (!acpi_dev->flags.hardware_id)
 		return -ENODEV;
 
 	len = snprintf(modalias, size, "acpi:");
@@ -209,7 +209,7 @@ static int acpi_device_setup_files(struct acpi_device *dev)
 			goto end;
 	}
 
-	if (dev->flags.hardware_id || dev->flags.compatible_ids) {
+	if (dev->flags.hardware_id) {
 		result = device_create_file(&dev->dev, &dev_attr_modalias);
 		if (result)
 			goto end;
@@ -239,7 +239,7 @@ static void acpi_device_remove_files(struct acpi_device *dev)
 	if (ACPI_SUCCESS(status))
 		device_remove_file(&dev->dev, &dev_attr_eject);
 
-	if (dev->flags.hardware_id || dev->flags.compatible_ids)
+	if (dev->flags.hardware_id)
 		device_remove_file(&dev->dev, &dev_attr_modalias);
 
 	if (dev->flags.hardware_id)
@@ -876,11 +876,6 @@ static int acpi_bus_get_flags(struct acpi_device *device)
 	if (ACPI_SUCCESS(status))
 		device->flags.dynamic_status = 1;
 
-	/* Presence of _CID indicates 'compatible_ids' */
-	status = acpi_get_handle(device->handle, "_CID", &temp);
-	if (ACPI_SUCCESS(status))
-		device->flags.compatible_ids = 1;
-
 	/* Presence of _RMV indicates 'removable' */
 	status = acpi_get_handle(device->handle, "_RMV", &temp);
 	if (ACPI_SUCCESS(status))
@@ -1124,10 +1119,8 @@ static void acpi_device_set_id(struct acpi_device *device)
 	if (cid_list)
 		for (i = 0; i < cid_list->count; i++)
 			acpi_add_id(device, cid_list->ids[i].string);
-	if (cid_add) {
+	if (cid_add)
 		acpi_add_id(device, cid_add);
-		device->flags.compatible_ids = 1;
-	}
 
 	kfree(info);
 }
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 635e305..e422547 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -142,7 +142,6 @@ struct acpi_device_status {
 struct acpi_device_flags {
 	u32 dynamic_status:1;
 	u32 hardware_id:1;
-	u32 compatible_ids:1;
 	u32 bus_address:1;
 	u32 unique_id:1;
 	u32 removable:1;
@@ -153,7 +152,7 @@ struct acpi_device_flags {
 	u32 performance_manageable:1;
 	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
 	u32 force_power_state:1;
-	u32 reserved:19;
+	u32 reserved:20;
 };
 
 /* File System */

