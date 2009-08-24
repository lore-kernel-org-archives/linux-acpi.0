From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 07/10] ACPI: remove acpi_device.flags.compatible_ids
Date: Mon, 24 Aug 2009 10:39:06 -0600
Message-ID: <20090824163905.28131.38316.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:10271 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZHXQjB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:39:01 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
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
index 76ba200..f389510 100644
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
@@ -875,11 +875,6 @@ static int acpi_bus_get_flags(struct acpi_device *device)
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
@@ -1119,10 +1114,8 @@ static void acpi_device_set_id(struct acpi_device *device)
 	if (cid_list)
 		for (i = 0; i < cid_list->count; i++)
 			acpi_add_id(device, cid_list->id[i].value);
-	if (cid_add) {
+	if (cid_add)
 		acpi_add_id(device, cid_add);
-		device->flags.compatible_ids = 1;
-	}
 
 	kfree(buffer.pointer);
 }
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3b3fef5..c7702a5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -144,7 +144,6 @@ struct acpi_device_status {
 struct acpi_device_flags {
 	u32 dynamic_status:1;
 	u32 hardware_id:1;
-	u32 compatible_ids:1;
 	u32 bus_address:1;
 	u32 unique_id:1;
 	u32 removable:1;
@@ -155,7 +154,7 @@ struct acpi_device_flags {
 	u32 performance_manageable:1;
 	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
 	u32 force_power_state:1;
-	u32 reserved:19;
+	u32 reserved:20;
 };
 
 /* File System */

