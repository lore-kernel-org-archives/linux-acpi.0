From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 06/10] ACPI: maintain a single list of _HID and _CID IDs
Date: Mon, 24 Aug 2009 10:39:00 -0600
Message-ID: <20090824163900.28131.96903.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:2450 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbZHXQiz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:38:55 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
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
 drivers/acpi/scan.c        |  136 +++++++++++++++++---------------------------
 drivers/pnp/pnpacpi/core.c |   16 ++---
 include/acpi/acpi_bus.h    |   11 ++--
 3 files changed, 68 insertions(+), 95 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 88f39e1..76ba200 100644
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
-		struct acpi_compatible_id_list *cid_list;
-		int i;
-
-		cid_list = acpi_dev->pnp.cid_list;
-		for (i = 0; i < cid_list->count; i++) {
-			count = snprintf(&modalias[len], size, "%s:",
-					 cid_list->id[i].value);
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
-		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
-		int i;
-
-		for (id = ids; id->id[0]; id++) {
-			/* compare multiple _CID entries against driver ids */
-			for (i = 0; i < cid_list->count; i++) {
-				if (!strcmp((char*)id->id,
-					    cid_list->id[i].value))
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
 
@@ -1023,6 +1000,32 @@ static int acpi_dock_match(struct acpi_device *device)
 	return acpi_get_handle(device->handle, "_DCK", &tmp);
 }
 
+char *acpi_device_hid(struct acpi_device *device)
+{
+	struct acpi_hardware_id *hid;
+
+	hid = list_first_entry(&device->pnp.ids, struct acpi_hardware_id, list);
+	return hid->id;
+}
+
+static void acpi_add_id(struct acpi_device *device, const char *dev_id)
+{
+	struct acpi_hardware_id *id;
+
+	id = kmalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return;
+
+	id->id = kmalloc(strlen(dev_id) + 1, GFP_KERNEL);
+	if (!id->id) {
+		kfree(id);
+		return;
+	}
+
+	strcpy(id->id, dev_id);
+	list_add_tail(&id->list, &device->pnp.ids);
+}
+
 static void acpi_device_set_id(struct acpi_device *device)
 {
 	struct acpi_device_info *info;
@@ -1032,6 +1035,7 @@ static void acpi_device_set_id(struct acpi_device *device)
 	struct acpi_compatible_id_list *cid_list = NULL;
 	const char *cid_add = NULL;
 	acpi_status status;
+	int i;
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
@@ -1105,52 +1109,19 @@ static void acpi_device_set_id(struct acpi_device *device)
 		hid = "device";
 
 	if (hid) {
-		strcpy(device->pnp.hardware_id, hid);
+		acpi_add_id(device, hid);
 		device->flags.hardware_id = 1;
 	}
 	if (uid) {
 		strcpy(device->pnp.unique_id, uid);
 		device->flags.unique_id = 1;
 	}
-	if (cid_list || cid_add) {
-		struct  acpi_compatible_id_list *list;
-		int size = 0;
-		int count = 0;
-
-		if (cid_list) {
-			size = cid_list->size;
-		} else if (cid_add) {
-			size = sizeof(struct acpi_compatible_id_list);
-			cid_list = ACPI_ALLOCATE_ZEROED((acpi_size) size);
-			if (!cid_list) {
-				printk(KERN_ERR "Memory allocation error\n");
-				kfree(buffer.pointer);
-				return;
-			} else {
-				cid_list->count = 0;
-				cid_list->size = size;
-			}
-		}
-		if (cid_add)
-			size += sizeof(struct acpi_compatible_id);
-		list = kmalloc(size, GFP_KERNEL);
-
-		if (list) {
-			if (cid_list) {
-				memcpy(list, cid_list, cid_list->size);
-				count = cid_list->count;
-			}
-			if (cid_add) {
-				strncpy(list->id[count].value, cid_add,
-					ACPI_MAX_CID_LENGTH);
-				count++;
-				device->flags.compatible_ids = 1;
-			}
-			list->size = size;
-			list->count = count;
-			device->pnp.cid_list = list;
-		} else
-			printk(KERN_ERR PREFIX "Memory allocation error\n");
+	if (cid_list)
+		for (i = 0; i < cid_list->count; i++)
+			acpi_add_id(device, cid_list->id[i].value);
+	if (cid_add) {
+		acpi_add_id(device, cid_add);
+		device->flags.compatible_ids = 1;
 	}
 
 	kfree(buffer.pointer);
@@ -1217,6 +1188,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 		return -ENOMEM;
 	}
 
+	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
@@ -1308,7 +1280,7 @@ end:
 		kfree(buffer.pointer);
 		*child = device;
 	} else {
-		kfree(device->pnp.cid_list);
+		acpi_free_ids(device);
 		kfree(device);
 	}
 
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 1f5e2c1..3a4478f 100644
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
-		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
-		int i;
-
-		for (i = 0; i < cid_list->count; i++) {
-			if (!ispnpidacpi(cid_list->id[i].value))
-				continue;
-			pnp_add_id(dev, cid_list->id[i].value);
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
index 26be825..3b3fef5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -170,16 +170,19 @@ struct acpi_device_dir {
 
 typedef char acpi_bus_id[8];
 typedef unsigned long acpi_bus_address;
-typedef char acpi_hardware_id[15];
 typedef char acpi_unique_id[9];
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
-	acpi_hardware_id hardware_id;	/* _HID */
-	struct acpi_compatible_id_list *cid_list;	/* _CIDs */
+	struct list_head ids;		/* _HID and _CIDs */
 	acpi_unique_id unique_id;	/* _UID */
 	acpi_device_name device_name;	/* Driver-determined */
 	acpi_device_class device_class;	/*        "          */
@@ -187,7 +190,7 @@ struct acpi_device_pnp {
 
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
-#define acpi_device_hid(d)	((d)->pnp.hardware_id)
+char *acpi_device_hid(struct acpi_device *device);
 #define acpi_device_uid(d)	((d)->pnp.unique_id)
 #define acpi_device_name(d)	((d)->pnp.device_name)
 #define acpi_device_class(d)	((d)->pnp.device_class)

