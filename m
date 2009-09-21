From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 6/8] ACPI: remove acpi_device.flags.hardware_id
Date: Mon, 21 Sep 2009 13:35:29 -0600
Message-ID: <20090921193529.21656.11425.stgit@bob.kio>
References: <20090921193417.21656.32718.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:19396 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbZIUTf0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:35:26 -0400
In-Reply-To: <20090921193417.21656.32718.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Every acpi_device has at least one ID (if there's no _HID or _CID, we
give it a synthetic or default ID).  So there's no longer a need to
check whether an ID exists; we can just use it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c        |   37 +++++++++++++------------------------
 drivers/pnp/pnpacpi/core.c |    3 +--
 include/acpi/acpi_bus.h    |    3 +--
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 954cb1d..3f9b8d0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -47,9 +47,6 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 	int count;
 	struct acpi_hardware_id *id;
 
-	if (!acpi_dev->flags.hardware_id)
-		return -ENODEV;
-
 	len = snprintf(modalias, size, "acpi:");
 	size -= len;
 
@@ -203,17 +200,13 @@ static int acpi_device_setup_files(struct acpi_device *dev)
 			goto end;
 	}
 
-	if (dev->flags.hardware_id) {
-		result = device_create_file(&dev->dev, &dev_attr_hid);
-		if (result)
-			goto end;
-	}
+	result = device_create_file(&dev->dev, &dev_attr_hid);
+	if (result)
+		goto end;
 
-	if (dev->flags.hardware_id) {
-		result = device_create_file(&dev->dev, &dev_attr_modalias);
-		if (result)
-			goto end;
-	}
+	result = device_create_file(&dev->dev, &dev_attr_modalias);
+	if (result)
+		goto end;
 
         /*
          * If device has _EJ0, 'eject' file is created that is used to trigger
@@ -239,11 +232,8 @@ static void acpi_device_remove_files(struct acpi_device *dev)
 	if (ACPI_SUCCESS(status))
 		device_remove_file(&dev->dev, &dev_attr_eject);
 
-	if (dev->flags.hardware_id)
-		device_remove_file(&dev->dev, &dev_attr_modalias);
-
-	if (dev->flags.hardware_id)
-		device_remove_file(&dev->dev, &dev_attr_hid);
+	device_remove_file(&dev->dev, &dev_attr_modalias);
+	device_remove_file(&dev->dev, &dev_attr_hid);
 	if (dev->handle)
 		device_remove_file(&dev->dev, &dev_attr_path);
 }
@@ -474,8 +464,9 @@ static int acpi_device_register(struct acpi_device *device)
 	 * If failed, create one and link it into acpi_bus_id_list
 	 */
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
-		if (!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id ? acpi_device_hid(device) : "device")) {
-			acpi_device_bus_id->instance_no ++;
+		if (!strcmp(acpi_device_bus_id->bus_id,
+			    acpi_device_hid(device))) {
+			acpi_device_bus_id->instance_no++;
 			found = 1;
 			kfree(new_bus_id);
 			break;
@@ -483,7 +474,7 @@ static int acpi_device_register(struct acpi_device *device)
 	}
 	if (!found) {
 		acpi_device_bus_id = new_bus_id;
-		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? acpi_device_hid(device) : "device");
+		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
 		acpi_device_bus_id->instance_no = 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
@@ -1102,10 +1093,8 @@ static void acpi_device_set_id(struct acpi_device *device)
 	if (!hid && !cid_list && !cid_add)
 		hid = "device";
 
-	if (hid) {
+	if (hid)
 		acpi_add_id(device, hid);
-		device->flags.hardware_id = 1;
-	}
 	if (uid) {
 		device->pnp.unique_id = ACPI_ALLOCATE_ZEROED(strlen (uid) + 1);
 		if (device->pnp.unique_id) {
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 3a4478f..83b8b5a 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -230,8 +230,7 @@ static int __init acpi_pnp_match(struct device *dev, void *_pnp)
 	struct pnp_dev *pnp = _pnp;
 
 	/* true means it matched */
-	return acpi->flags.hardware_id
-	    && !acpi_get_physical_device(acpi->handle)
+	return !acpi_get_physical_device(acpi->handle)
 	    && compare_pnp_id(pnp->id, acpi_device_hid(acpi));
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e422547..1d205f5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -141,7 +141,6 @@ struct acpi_device_status {
 
 struct acpi_device_flags {
 	u32 dynamic_status:1;
-	u32 hardware_id:1;
 	u32 bus_address:1;
 	u32 unique_id:1;
 	u32 removable:1;
@@ -152,7 +151,7 @@ struct acpi_device_flags {
 	u32 performance_manageable:1;
 	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
 	u32 force_power_state:1;
-	u32 reserved:20;
+	u32 reserved:21;
 };
 
 /* File System */

