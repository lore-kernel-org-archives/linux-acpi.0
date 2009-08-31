From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 4/8] ACPI: maintain a single list of _HID and _CID IDs
Date: Mon, 31 Aug 2009 16:47:05 -0600
Message-ID: <20090831224705.12236.52498.stgit@bob.kio>
References: <20090831224535.12236.61350.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:33450 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZHaWq6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:46:58 -0400
In-Reply-To: <20090831224535.12236.61350.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

There's no need to treat _HID and _CID differently.  Keeping them in
a single list makes code that uses the IDs a little simpler because it
can just traverse the list rather than checking "do we have a HID?",
"do we have any CIDs?"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
---
 drivers/acpi/scan.c        |  164 +++++++++++++-------------------------------
 drivers/pnp/pnpacpi/core.c |   16 ++--
 include/acpi/acpi_bus.h    |   10 ++-
 3 files changed, 61 insertions(+), 129 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f22fe87..f604f74 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -45,6 +45,7 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 {
 	int len;
 	int count;
+	struct acpi_hardware_id *id;
 
 	if (!acpi_dev->flags.hardware_id && !acpi_dev->flags.compatible_ids)
 		return -ENODEV;
@@ -52,33 +53,14 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 	len = snprintf(modalias, size, "acpi:");
 	size -= len;
 
-	if (acpi_dev->flags.hardware_id) {
-		count = snprintf(&modalias[len], size, "%s:",
-				 acpi_dev->pnp.hardware_id);
+	list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
+		count = snprintf(&modalias[len], size, "%s:", id->id);
 		if (count < 0 || count >= size)
 			return -EINVAL;
 		len += count;
 		size -= count;
 	}
 
-	if (acpi_dev->flags.compatible_ids) {
-		struct acpica_device_id_list *cid_list;
-		int i;
-
-		cid_list = acpi_dev->pnp.cid_list;
-		for (i = 0; i < cid_list->count; i++) {
-			count = snprintf(&modalias[len], size, "%s:",
-					 cid_list->ids[i].string);
-			if (count < 0 || count >= size) {
-				printk(KERN_ERR PREFIX "%s cid[%i] exceeds event buffer size",
-				       acpi_dev->pnp.device_name, i);
-				break;
-			}
-			len += count;
-			size -= count;
-		}
-	}
-
 	modalias[len] = '\0';
 	return len;
 }
@@ -273,6 +255,7 @@ int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids)
 {
 	const struct acpi_device_id *id;
+	struct acpi_hardware_id *hwid;
 
 	/*
 	 * If the device is not present, it is unnecessary to load device
@@ -281,36 +264,30 @@ int acpi_match_device_ids(struct acpi_device *device,
 	if (!device->status.present)
 		return -ENODEV;
 
-	if (device->flags.hardware_id) {
-		for (id = ids; id->id[0]; id++) {
-			if (!strcmp((char*)id->id, device->pnp.hardware_id))
+	for (id = ids; id->id[0]; id++)
+		list_for_each_entry(hwid, &device->pnp.ids, list)
+			if (!strcmp((char *) id->id, hwid->id))
 				return 0;
-		}
-	}
-
-	if (device->flags.compatible_ids) {
-		struct acpica_device_id_list *cid_list = device->pnp.cid_list;
-		int i;
-
-		for (id = ids; id->id[0]; id++) {
-			/* compare multiple _CID entries against driver ids */
-			for (i = 0; i < cid_list->count; i++) {
-				if (!strcmp((char*)id->id,
-					    cid_list->ids[i].string))
-					return 0;
-			}
-		}
-	}
 
 	return -ENOENT;
 }
 EXPORT_SYMBOL(acpi_match_device_ids);
 
+static void acpi_free_ids(struct acpi_device *device)
+{
+	struct acpi_hardware_id *id, *tmp;
+
+	list_for_each_entry_safe(id, tmp, &device->pnp.ids, list) {
+		kfree(id->id);
+		kfree(id);
+	}
+}
+
 static void acpi_device_release(struct device *dev)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	kfree(acpi_dev->pnp.cid_list);
+	acpi_free_ids(acpi_dev);
 	kfree(acpi_dev);
 }
 
@@ -1023,62 +1000,30 @@ static int acpi_dock_match(struct acpi_device *device)
 	return acpi_get_handle(device->handle, "_DCK", &tmp);
 }
 
-static struct acpica_device_id_list*
-acpi_add_cid(
-	struct acpi_device_info         *info,
-	struct acpica_device_id         *new_cid)
+char *acpi_device_hid(struct acpi_device *device)
 {
-	struct acpica_device_id_list    *cid;
-	char                            *next_id_string;
-	acpi_size                       cid_length;
-	acpi_size                       new_cid_length;
-	u32                             i;
-
-
-	/* Allocate new CID list with room for the new CID */
-
-	if (!new_cid)
-		new_cid_length = info->compatible_id_list.list_size;
-	else if (info->compatible_id_list.list_size)
-		new_cid_length = info->compatible_id_list.list_size +
-			new_cid->length + sizeof(struct acpica_device_id);
-	else
-		new_cid_length = sizeof(struct acpica_device_id_list) + new_cid->length;
+	struct acpi_hardware_id *hid;
 
-	cid = ACPI_ALLOCATE_ZEROED(new_cid_length);
-	if (!cid) {
-		return NULL;
-	}
-
-	cid->list_size = new_cid_length;
-	cid->count = info->compatible_id_list.count;
-	if (new_cid)
-		cid->count++;
-	next_id_string = (char *) cid->ids + (cid->count * sizeof(struct acpica_device_id));
-
-	/* Copy all existing CIDs */
-
-	for (i = 0; i < info->compatible_id_list.count; i++) {
-		cid_length = info->compatible_id_list.ids[i].length;
-		cid->ids[i].string = next_id_string;
-		cid->ids[i].length = cid_length;
-
-		ACPI_MEMCPY(next_id_string, info->compatible_id_list.ids[i].string,
-			cid_length);
-
-		next_id_string += cid_length;
-	}
+	hid = list_first_entry(&device->pnp.ids, struct acpi_hardware_id, list);
+	return hid->id;
+}
 
-	/* Append the new CID */
+static void acpi_add_id(struct acpi_device *device, const char *dev_id)
+{
+	struct acpi_hardware_id *id;
 
-	if (new_cid) {
-		cid->ids[i].string = next_id_string;
-		cid->ids[i].length = new_cid->length;
+	id = kmalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return;
 
-		ACPI_MEMCPY(next_id_string, new_cid->string, new_cid->length);
+	id->id = kmalloc(strlen(dev_id) + 1, GFP_KERNEL);
+	if (!id->id) {
+		kfree(id);
+		return;
 	}
 
-	return cid;
+	strcpy(id->id, dev_id);
+	list_add_tail(&id->list, &device->pnp.ids);
 }
 
 static void acpi_device_set_id(struct acpi_device *device)
@@ -1089,6 +1034,7 @@ static void acpi_device_set_id(struct acpi_device *device)
 	struct acpica_device_id_list *cid_list = NULL;
 	char *cid_add = NULL;
 	acpi_status status;
+	int i;
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
@@ -1161,14 +1107,9 @@ static void acpi_device_set_id(struct acpi_device *device)
 		hid = "device";
 
 	if (hid) {
-		device->pnp.hardware_id = ACPI_ALLOCATE_ZEROED(strlen (hid) + 1);
-		if (device->pnp.hardware_id) {
-			strcpy(device->pnp.hardware_id, hid);
-			device->flags.hardware_id = 1;
-		}
-	} else
-		device->pnp.hardware_id = NULL;
-
+		acpi_add_id(device, hid);
+		device->flags.hardware_id = 1;
+	}
 	if (uid) {
 		device->pnp.unique_id = ACPI_ALLOCATE_ZEROED(strlen (uid) + 1);
 		if (device->pnp.unique_id) {
@@ -1178,24 +1119,12 @@ static void acpi_device_set_id(struct acpi_device *device)
 	} else
 		device->pnp.unique_id = NULL;
 
-	if (cid_list || cid_add) {
-		struct acpica_device_id_list *list;
-
-		if (cid_add) {
-			struct acpica_device_id cid;
-			cid.length = strlen (cid_add) + 1;
-			cid.string = cid_add;
-
-			list = acpi_add_cid(info, &cid);
-		} else {
-			list = acpi_add_cid(info, NULL);
-		}
-
-		if (list) {
-			device->pnp.cid_list = list;
-			if (cid_add)
-				device->flags.compatible_ids = 1;
-		}
+	if (cid_list)
+		for (i = 0; i < cid_list->count; i++)
+			acpi_add_id(device, cid_list->ids[i].string);
+	if (cid_add) {
+		acpi_add_id(device, cid_add);
+		device->flags.compatible_ids = 1;
 	}
 
 	kfree(info);
@@ -1262,6 +1191,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 		return -ENOMEM;
 	}
 
+	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
@@ -1353,7 +1283,7 @@ end:
 		kfree(buffer.pointer);
 		*child = device;
 	} else {
-		kfree(device->pnp.cid_list);
+		acpi_free_ids(device);
 		kfree(device);
 	}
 
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index ff963d4..3a4478f 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -153,6 +153,7 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	acpi_handle temp = NULL;
 	acpi_status status;
 	struct pnp_dev *dev;
+	struct acpi_hardware_id *id;
 
 	/*
 	 * If a PnPacpi device is not present , the device
@@ -193,15 +194,12 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	if (dev->capabilities & PNP_CONFIGURABLE)
 		pnpacpi_parse_resource_option_data(dev);
 
-	if (device->flags.compatible_ids) {
-		struct acpica_device_id_list *cid_list = device->pnp.cid_list;
-		int i;
-
-		for (i = 0; i < cid_list->count; i++) {
-			if (!ispnpidacpi(cid_list->ids[i].string))
-				continue;
-			pnp_add_id(dev, cid_list->ids[i].string);
-		}
+	list_for_each_entry(id, &device->pnp.ids, list) {
+		if (!strcmp(id->id, acpi_device_hid(device)))
+			continue;
+		if (!ispnpidacpi(id->id))
+			continue;
+		pnp_add_id(dev, id->id);
 	}
 
 	/* clear out the damaged flags */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a273cdf..fe00536 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -171,19 +171,23 @@ typedef unsigned long acpi_bus_address;
 typedef char acpi_device_name[40];
 typedef char acpi_device_class[20];
 
+struct acpi_hardware_id {
+	struct list_head list;
+	char *id;
+};
+
 struct acpi_device_pnp {
 	acpi_bus_id bus_id;	/* Object name */
 	acpi_bus_address bus_address;	/* _ADR */
-	char *hardware_id;	/* _HID */
-	struct acpica_device_id_list *cid_list;	/* _CIDs */
 	char *unique_id;	/* _UID */
+	struct list_head ids;		/* _HID and _CIDs */
 	acpi_device_name device_name;	/* Driver-determined */
 	acpi_device_class device_class;	/*        "          */
 };
 
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
-#define acpi_device_hid(d)	((d)->pnp.hardware_id)
+char *acpi_device_hid(struct acpi_device *device);
 #define acpi_device_uid(d)	((d)->pnp.unique_id)
 #define acpi_device_name(d)	((d)->pnp.device_name)
 #define acpi_device_class(d)	((d)->pnp.device_class)

