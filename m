From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC PATCH]: update all invocations of acpi_get_object_info
 interface
Date: Wed, 24 Jun 2009 15:22:23 +0800
Message-ID: <1245828143.10660.24.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19433 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbZFXHUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2009 03:20:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

We have made a major change for acpi_get_object_info interface.
See detail at,
http://git.moblin.org/cgit.cgi/acpica/commit/?id=95dd0f01c616acb6a9200f64a176f15c6d55e6d3

This will require a change to all invocations, since the interface has
changed. 

1) The return type is no longer ACPI_BUFFER, it just allocates and
   returns an ACPI_DEVICE_INFO.

2) The return structure has some differences.

3) Change acpi_device_pnp->hardware_id and ->unique_id to char * 
   pointers, since both the HID and UID are now variable-length
   strings, so a buffer should be allocated for them.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 arch/ia64/hp/common/sba_iommu.c    |    7 +-
 drivers/acpi/acpi_memhotplug.c     |   11 +--
 drivers/acpi/acpica/nsdumpdv.c     |    7 +-
 drivers/acpi/container.c           |   11 +--
 drivers/acpi/dock.c                |    8 +-
 drivers/acpi/glue.c                |    6 +-
 drivers/acpi/scan.c                |  152 +++++++++++++++++++++++------------
 drivers/char/agp/hp-agp.c          |    9 +--
 drivers/ide/ide-acpi.c             |    5 +-
 drivers/pci/hotplug/acpi_pcihp.c   |   16 ++--
 drivers/pci/hotplug/acpiphp_ibm.c  |   12 +--
 drivers/platform/x86/sony-laptop.c |    7 +-
 drivers/pnp/pnpacpi/core.c         |    6 +-
 include/acpi/acpi_bus.h            |    8 +-
 14 files changed, 141 insertions(+), 124 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 56ceb68..04ec14b 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2026,24 +2026,21 @@ acpi_sba_ioc_add(struct acpi_device *device)
 	struct ioc *ioc;
 	acpi_status status;
 	u64 hpa, length;
-	struct acpi_buffer buffer;
 	struct acpi_device_info *dev_info;
 
 	status = hp_acpi_csr_space(device->handle, &hpa, &length);
 	if (ACPI_FAILURE(status))
 		return 1;
 
-	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	status = acpi_get_object_info(device->handle, &buffer);
+	status = acpi_get_object_info(device->handle, &dev_info);
 	if (ACPI_FAILURE(status))
 		return 1;
-	dev_info = buffer.pointer;
 
 	/*
 	 * For HWP0001, only SBA appears in ACPI namespace.  It encloses the PCI
 	 * root bridges, and its CSR space includes the IOC function.
 	 */
-	if (strncmp("HWP0001", dev_info->hardware_id.value, 7) == 0) {
+	if (strncmp("HWP0001", dev_info->hardware_id.string, 7) == 0) {
 		hpa += ZX1_IOC_OFFSET;
 		/* zx1 based systems default to kernel page size iommu pages */
 		if (!iovp_shift)
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 7a0f4aa..14f0a9f 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -465,26 +465,23 @@ static acpi_status is_memory_device(acpi_handle handle)
 {
 	char *hardware_id;
 	acpi_status status;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_device_info *info;
 
-
-	status = acpi_get_object_info(handle, &buffer);
+	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status))
 		return status;
 
-	info = buffer.pointer;
 	if (!(info->valid & ACPI_VALID_HID)) {
-		kfree(buffer.pointer);
+		kfree(info);
 		return AE_ERROR;
 	}
 
-	hardware_id = info->hardware_id.value;
+	hardware_id = info->hardware_id.string;
 	if ((hardware_id == NULL) ||
 	    (strcmp(hardware_id, ACPI_MEMORY_DEVICE_HID)))
 		status = AE_ERROR;
 
-	kfree(buffer.pointer);
+	kfree(info);
 	return status;
 }
 
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 41994fe..0fe87f1 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -70,7 +70,6 @@ static acpi_status
 acpi_ns_dump_one_device(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value)
 {
-	struct acpi_buffer buffer;
 	struct acpi_device_info *info;
 	acpi_status status;
 	u32 i;
@@ -80,17 +79,15 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
 	status =
 	    acpi_ns_dump_one_object(obj_handle, level, context, return_value);
 
-	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	status = acpi_get_object_info(obj_handle, &buffer);
+	status = acpi_get_object_info(obj_handle, &info);
 	if (ACPI_SUCCESS(status)) {
-		info = buffer.pointer;
 		for (i = 0; i < level; i++) {
 			ACPI_DEBUG_PRINT_RAW((ACPI_DB_TABLES, " "));
 		}
 
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_TABLES,
 				      "    HID: %s, ADR: %8.8X%8.8X, Status: %X\n",
-				      info->hardware_id.value,
+				      info->hardware_id.string,
 				      ACPI_FORMAT_UINT64(info->address),
 				      info->current_status));
 		ACPI_FREE(info);
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index fe0cdf8..2aee8c2 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -200,20 +200,17 @@ container_walk_namespace_cb(acpi_handle handle,
 			    u32 lvl, void *context, void **rv)
 {
 	char *hid = NULL;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_device_info *info;
 	acpi_status status;
 	int *action = context;
 
-
-	status = acpi_get_object_info(handle, &buffer);
-	if (ACPI_FAILURE(status) || !buffer.pointer) {
+	status = acpi_get_object_info(handle, &info);
+	if (ACPI_FAILURE(status)) {
 		return AE_OK;
 	}
 
-	info = buffer.pointer;
 	if (info->valid & ACPI_VALID_HID)
-		hid = info->hardware_id.value;
+		hid = info->hardware_id.string;
 
 	if (hid == NULL) {
 		goto end;
@@ -240,7 +237,7 @@ container_walk_namespace_cb(acpi_handle handle,
 	}
 
       end:
-	kfree(buffer.pointer);
+	kfree(info);
 
 	return AE_OK;
 }
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index efb959d..39536b8 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -231,18 +231,16 @@ static int is_ata(acpi_handle handle)
 static int is_battery(acpi_handle handle)
 {
 	struct acpi_device_info *info;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	int ret = 1;
 
-	if (!ACPI_SUCCESS(acpi_get_object_info(handle, &buffer)))
+	if (!ACPI_SUCCESS(acpi_get_object_info(handle, &info)))
 		return 0;
-	info = buffer.pointer;
 	if (!(info->valid & ACPI_VALID_HID))
 		ret = 0;
 	else
-		ret = !strcmp("PNP0C0A", info->hardware_id.value);
+		ret = !strcmp("PNP0C0A", info->hardware_id.string);
 
-	kfree(buffer.pointer);
+	kfree(info);
 	return ret;
 }
 
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 8bd2c2a..c6986e9 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -93,15 +93,13 @@ do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
 	struct acpi_device_info *info;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_find_child *find = context;
 
-	status = acpi_get_object_info(handle, &buffer);
+	status = acpi_get_object_info(handle, &info);
 	if (ACPI_SUCCESS(status)) {
-		info = buffer.pointer;
 		if (info->address == find->address)
 			find->handle = handle;
-		kfree(buffer.pointer);
+		kfree(info);
 	}
 	return AE_OK;
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8ff510b..595c288 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -60,13 +60,13 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 	}
 
 	if (acpi_dev->flags.compatible_ids) {
-		struct acpi_compatible_id_list *cid_list;
+		struct acpica_device_id_list *cid_list;
 		int i;
 
 		cid_list = acpi_dev->pnp.cid_list;
 		for (i = 0; i < cid_list->count; i++) {
 			count = snprintf(&modalias[len], size, "%s:",
-					 cid_list->id[i].value);
+					 cid_list->ids[i].string);
 			if (count < 0 || count >= size) {
 				printk(KERN_ERR PREFIX "%s cid[%i] exceeds event buffer size",
 				       acpi_dev->pnp.device_name, i);
@@ -291,14 +291,14 @@ int acpi_match_device_ids(struct acpi_device *device,
 	}
 
 	if (device->flags.compatible_ids) {
-		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		struct acpica_device_id_list *cid_list = device->pnp.cid_list;
 		int i;
 
 		for (id = ids; id->id[0]; id++) {
 			/* compare multiple _CID entries against driver ids */
 			for (i = 0; i < cid_list->count; i++) {
 				if (!strcmp((char*)id->id,
-					    cid_list->id[i].value))
+					    cid_list->ids[i].string))
 					return 0;
 			}
 		}
@@ -1005,33 +1005,96 @@ static int acpi_dock_match(struct acpi_device *device)
 	return acpi_get_handle(device->handle, "_DCK", &tmp);
 }
 
+static struct acpica_device_id_list*
+acpi_add_cid (
+	struct acpi_device_info         *info,
+	struct acpica_device_id         *new_cid)
+{
+	struct acpica_device_id_list    *cid;
+	char                            *next_id_string;
+	acpi_size                       cid_length;
+	acpi_size                       new_cid_length;
+	u32                             i;
+
+
+	/* If new_cid == NULL, just copy info->compatible_id_list */
+
+	if (!new_cid) {
+		cid = ACPI_ALLOCATE_ZEROED (info->compatible_id_list.list_size);
+		if (!cid) {
+			return NULL;
+		}
+		ACPI_MEMCPY (cid, &info->compatible_id_list,
+				info->compatible_id_list.list_size);
+
+		return cid;
+	}
+
+	/* Allocate new CID list with room for the new CID */
+
+	if (info->compatible_id_list.list_size)
+		new_cid_length = info->compatible_id_list.list_size +
+			new_cid->length + sizeof (struct acpica_device_id);
+	else
+		new_cid_length = sizeof (struct acpica_device_id_list) + new_cid->length;
+
+	cid = ACPI_ALLOCATE_ZEROED (new_cid_length);
+	if (!cid) {
+		return NULL;
+	}
+
+	cid->list_size = new_cid_length;
+	cid->count = info->compatible_id_list.count + 1;
+	next_id_string = (char *) cid->ids + (cid->count * sizeof (struct acpica_device_id));
+
+	/* Copy all existing CIDs */
+
+	for (i = 0; i < info->compatible_id_list.count; i++) {
+		cid_length = info->compatible_id_list.ids[i].length;
+		cid->ids[i].string = next_id_string;
+		cid->ids[i].length = cid_length;
+
+		ACPI_MEMCPY (next_id_string, info->compatible_id_list.ids[i].string,
+			cid_length);
+
+		next_id_string += cid_length;
+	}
+
+	/* Append the new CID */
+
+	cid->ids[i].string = next_id_string;
+	cid->ids[i].length = new_cid->length;
+
+	ACPI_MEMCPY (next_id_string, new_cid->string, new_cid->length);
+
+	return cid;
+}
+
 static void acpi_device_set_id(struct acpi_device *device,
 			       struct acpi_device *parent, acpi_handle handle,
 			       int type)
 {
-	struct acpi_device_info *info;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device_info *info = NULL;
 	char *hid = NULL;
 	char *uid = NULL;
-	struct acpi_compatible_id_list *cid_list = NULL;
-	const char *cid_add = NULL;
+	struct acpica_device_id_list *cid_list = NULL;
+	char *cid_add = NULL;
 	acpi_status status;
 
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
-		status = acpi_get_object_info(handle, &buffer);
+		status = acpi_get_object_info(handle, &info);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
 			return;
 		}
 
-		info = buffer.pointer;
 		if (info->valid & ACPI_VALID_HID)
-			hid = info->hardware_id.value;
+			hid = info->hardware_id.string;
 		if (info->valid & ACPI_VALID_UID)
-			uid = info->unique_id.value;
+			uid = info->unique_id.string;
 		if (info->valid & ACPI_VALID_CID)
-			cid_list = &info->compatibility_id;
+			cid_list = &info->compatible_id_list;
 		if (info->valid & ACPI_VALID_ADR) {
 			device->pnp.bus_address = info->address;
 			device->flags.bus_address = 1;
@@ -1082,55 +1145,40 @@ static void acpi_device_set_id(struct acpi_device *device,
 	}
 
 	if (hid) {
-		strcpy(device->pnp.hardware_id, hid);
-		device->flags.hardware_id = 1;
+		device->pnp.hardware_id = ACPI_ALLOCATE_ZEROED (strlen (hid) + 1);
+		if (device->pnp.hardware_id) {
+			strcpy(device->pnp.hardware_id, hid);
+			device->flags.hardware_id = 1;
+		}
 	}
 	if (uid) {
-		strcpy(device->pnp.unique_id, uid);
-		device->flags.unique_id = 1;
+		device->pnp.unique_id = ACPI_ALLOCATE_ZEROED (strlen (uid) + 1);
+		if (device->pnp.unique_id) {
+			strcpy(device->pnp.unique_id, uid);
+			device->flags.unique_id = 1;
+		}
 	}
 	if (cid_list || cid_add) {
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
+		struct acpica_device_id_list *list;
+
+		if (cid_add) {
+			struct acpica_device_id cid;
+			cid.length = strlen (cid_add);
+			cid.string = cid_add;
+
+			list = acpi_add_cid (info, &cid);
+		} else {
+			list = acpi_add_cid (info, NULL);
 		}
-		if (cid_add)
-			size += sizeof(struct acpi_compatible_id);
-		list = kmalloc(size, GFP_KERNEL);
 
 		if (list) {
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
 			device->pnp.cid_list = list;
-		} else
-			printk(KERN_ERR PREFIX "Memory allocation error\n");
+			if (cid_add)
+				device->flags.compatible_ids = 1;
+		}
 	}
 
-	kfree(buffer.pointer);
+	kfree(info);
 }
 
 static int acpi_device_set_context(struct acpi_device *device, int type)
diff --git a/drivers/char/agp/hp-agp.c b/drivers/char/agp/hp-agp.c
index 183ac3f..765f13c 100644
--- a/drivers/char/agp/hp-agp.c
+++ b/drivers/char/agp/hp-agp.c
@@ -479,7 +479,6 @@ zx1_gart_probe (acpi_handle obj, u32 depth, void *context, void **ret)
 {
 	acpi_handle handle, parent;
 	acpi_status status;
-	struct acpi_buffer buffer;
 	struct acpi_device_info *info;
 	u64 lba_hpa, sba_hpa, length;
 	int match;
@@ -491,13 +490,11 @@ zx1_gart_probe (acpi_handle obj, u32 depth, void *context, void **ret)
 	/* Look for an enclosing IOC scope and find its CSR space */
 	handle = obj;
 	do {
-		buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-		status = acpi_get_object_info(handle, &buffer);
+		status = acpi_get_object_info(handle, &info);
 		if (ACPI_SUCCESS(status)) {
 			/* TBD check _CID also */
-			info = buffer.pointer;
-			info->hardware_id.value[sizeof(info->hardware_id)-1] = '\0';
-			match = (strcmp(info->hardware_id.value, "HWP0001") == 0);
+			info->hardware_id.string[sizeof(info->hardware_id.length)-1] = '\0';
+			match = (strcmp(info->hardware_id.string, "HWP0001") == 0);
 			kfree(info);
 			if (match) {
 				status = hp_acpi_csr_space(handle, &sba_hpa, &length);
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 77f79d2..91258dd 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -109,8 +109,6 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 	unsigned int bus, devnum, func;
 	acpi_integer addr;
 	acpi_handle dev_handle;
-	struct acpi_buffer buffer = {.length = ACPI_ALLOCATE_BUFFER,
-					.pointer = NULL};
 	acpi_status status;
 	struct acpi_device_info	*dinfo = NULL;
 	int ret = -ENODEV;
@@ -129,12 +127,11 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 		goto err;
 	}
 
-	status = acpi_get_object_info(dev_handle, &buffer);
+	status = acpi_get_object_info(dev_handle, &dinfo);
 	if (ACPI_FAILURE(status)) {
 		DEBPRINT("get_object_info for device failed\n");
 		goto err;
 	}
-	dinfo = buffer.pointer;
 	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
 	    dinfo->address == addr) {
 		*pcidevfn = addr;
diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index fbc63d5..9e19242 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -457,28 +457,26 @@ int acpi_root_bridge(acpi_handle handle)
 {
 	acpi_status status;
 	struct acpi_device_info *info;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	int i;
 
-	status = acpi_get_object_info(handle, &buffer);
+	status = acpi_get_object_info(handle, &info);
 	if (ACPI_SUCCESS(status)) {
-		info = buffer.pointer;
 		if ((info->valid & ACPI_VALID_HID) &&
 			!strcmp(PCI_ROOT_HID_STRING,
-					info->hardware_id.value)) {
-			kfree(buffer.pointer);
+					info->hardware_id.string)) {
+			kfree(info);
 			return 1;
 		}
 		if (info->valid & ACPI_VALID_CID) {
-			for (i=0; i < info->compatibility_id.count; i++) {
+			for (i = 0; i < info->compatible_id_list.count; i++) {
 				if (!strcmp(PCI_ROOT_HID_STRING,
-					info->compatibility_id.id[i].value)) {
-					kfree(buffer.pointer);
+					info->compatible_id_list.ids[i].string)) {
+					kfree(info);
 					return 1;
 				}
 			}
 		}
-		kfree(buffer.pointer);
+		kfree(info);
 	}
 	return 0;
 }
diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 5befa7e..a9d926b 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -398,23 +398,21 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
 	acpi_handle *phandle = (acpi_handle *)context;
 	acpi_status status; 
 	struct acpi_device_info *info;
-	struct acpi_buffer info_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	int retval = 0;
 
-	status = acpi_get_object_info(handle, &info_buffer);
+	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status)) {
 		err("%s:  Failed to get device information status=0x%x\n",
 			__func__, status);
 		return retval;
 	}
-	info = info_buffer.pointer;
-	info->hardware_id.value[sizeof(info->hardware_id.value) - 1] = '\0';
+	info->hardware_id.string[sizeof(info->hardware_id.length) - 1] = '\0';
 
 	if (info->current_status && (info->valid & ACPI_VALID_HID) &&
-			(!strcmp(info->hardware_id.value, IBM_HARDWARE_ID1) ||
-			 !strcmp(info->hardware_id.value, IBM_HARDWARE_ID2))) {
+			(!strcmp(info->hardware_id.string, IBM_HARDWARE_ID1) ||
+			 !strcmp(info->hardware_id.string, IBM_HARDWARE_ID2))) {
 		dbg("found hardware: %s, handle: %p\n",
-			info->hardware_id.value, handle);
+			info->hardware_id.string, handle);
 		*phandle = handle;
 		/* returning non-zero causes the search to stop
 		 * and returns this value to the caller of 
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5529585..a537987 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -976,15 +976,12 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 				      void *context, void **return_value)
 {
 	struct acpi_device_info *info;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-
-	if (ACPI_SUCCESS(acpi_get_object_info(handle, &buffer))) {
-		info = buffer.pointer;
 
+	if (ACPI_SUCCESS(acpi_get_object_info(handle, &info))) {
 		printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n",
 			(char *)&info->name, info->param_count);
 
-		kfree(buffer.pointer);
+		kfree(info);
 	}
 
 	return AE_OK;
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 9496494..c07fdb9 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -194,13 +194,13 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 		pnpacpi_parse_resource_option_data(dev);
 
 	if (device->flags.compatible_ids) {
-		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		struct acpica_device_id_list *cid_list = device->pnp.cid_list;
 		int i;
 
 		for (i = 0; i < cid_list->count; i++) {
-			if (!ispnpidacpi(cid_list->id[i].value))
+			if (!ispnpidacpi(cid_list->ids[i].string))
 				continue;
-			pnp_add_id(dev, cid_list->id[i].value);
+			pnp_add_id(dev, cid_list->ids[i].string);
 		}
 	}
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c34b110..113466e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -170,17 +170,15 @@ struct acpi_device_dir {
 
 typedef char acpi_bus_id[5];
 typedef unsigned long acpi_bus_address;
-typedef char acpi_hardware_id[15];
-typedef char acpi_unique_id[9];
 typedef char acpi_device_name[40];
 typedef char acpi_device_class[20];
 
 struct acpi_device_pnp {
 	acpi_bus_id bus_id;	/* Object name */
 	acpi_bus_address bus_address;	/* _ADR */
-	acpi_hardware_id hardware_id;	/* _HID */
-	struct acpi_compatible_id_list *cid_list;	/* _CIDs */
-	acpi_unique_id unique_id;	/* _UID */
+	char *hardware_id;	/* _HID */
+	struct acpica_device_id_list *cid_list;	/* _CIDs */
+	char *unique_id;	/* _UID */
 	acpi_device_name device_name;	/* Driver-determined */
 	acpi_device_class device_class;	/*        "          */
 };

 






