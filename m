From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] PCI/ACPI: move _OSC code to pci_root.c
Date: Tue, 03 Feb 2009 14:57:00 +0900
Message-ID: <4987DCAC.3010009@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>, Andrew Patterson <andrew.patterson@hp.com>
List-Id: linux-acpi@vger.kernel.org

Move PCI _OSC management code from drivers/pci/pci-acpi.c to
drivers/acpi/pci_root.c. The benefits are

- We no longer need struct osc_data and its management code (contents
  are moved to struct acpi_pci_root). This simplify the code, and we
  no longer care about kmalloc() failure.

- We can make pci_acpi_osc_support() be a static function, which is
  called only from drivers/acpi/pci_root.c.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/acpi/pci_root.c  |  178 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-acpi.c   |  215 -----------------------------------------------
 include/linux/pci-acpi.h |    1 
 3 files changed, 176 insertions(+), 218 deletions(-)

Index: 20090130/drivers/acpi/pci_root.c
===================================================================
--- 20090130.orig/drivers/acpi/pci_root.c
+++ 20090130/drivers/acpi/pci_root.c
@@ -66,11 +66,18 @@ struct acpi_pci_root {
 	struct acpi_device * device;
 	struct acpi_pci_id id;
 	struct pci_bus *bus;
+
+	u32 osc_support_set;	/* _OSC state of support bits */
+	u32 osc_control_set;	/* _OSC state of control bits */
+	u32 osc_control_qry;	/* the latest _OSC query result */
+
+	u32 osc_queried:1;	/* has _OSC control been queried? */
 };
 
 static LIST_HEAD(acpi_pci_roots);
 
 static struct acpi_pci_driver *sub_driver;
+static DEFINE_MUTEX(osc_lock);
 
 int acpi_pci_register_driver(struct acpi_pci_driver *driver)
 {
@@ -185,6 +192,173 @@ static void acpi_pci_bridge_scan(struct 
 		}
 }
 
+static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40,
+			  0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
+
+static acpi_status acpi_pci_run_osc(acpi_handle handle,
+				    const u32 *capbuf, u32 *retval)
+{
+	acpi_status status;
+	struct acpi_object_list input;
+	union acpi_object in_params[4];
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *out_obj;
+	u32 errors;
+
+	/* Setting up input parameters */
+	input.count = 4;
+	input.pointer = in_params;
+	in_params[0].type 		= ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length 	= 16;
+	in_params[0].buffer.pointer	= OSC_UUID;
+	in_params[1].type 		= ACPI_TYPE_INTEGER;
+	in_params[1].integer.value 	= 1;
+	in_params[2].type 		= ACPI_TYPE_INTEGER;
+	in_params[2].integer.value	= 3;
+	in_params[3].type		= ACPI_TYPE_BUFFER;
+	in_params[3].buffer.length 	= 12;
+	in_params[3].buffer.pointer 	= (u8 *)capbuf;
+
+	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	if (!output.length)
+		return AE_NULL_OBJECT;
+
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
+		status = AE_TYPE;
+		goto out_kfree;
+	}
+	/* Need to ignore the bit0 in result code */
+	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
+	if (errors) {
+		if (errors & OSC_REQUEST_ERROR)
+			printk(KERN_DEBUG "_OSC request fails\n");
+		if (errors & OSC_INVALID_UUID_ERROR)
+			printk(KERN_DEBUG "_OSC invalid UUID\n");
+		if (errors & OSC_INVALID_REVISION_ERROR)
+			printk(KERN_DEBUG "_OSC invalid revision\n");
+		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
+			if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
+				goto out_success;
+			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
+			status = AE_SUPPORT;
+			goto out_kfree;
+		}
+		status = AE_ERROR;
+		goto out_kfree;
+	}
+out_success:
+	*retval = *((u32 *)(out_obj->buffer.pointer + 8));
+	status = AE_OK;
+
+out_kfree:
+	kfree(output.pointer);
+	return status;
+}
+
+static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
+{
+	acpi_status status;
+	u32 support_set, result, capbuf[3];
+
+	/* do _OSC query for all possible controls */
+	support_set = root->osc_support_set | (flags & OSC_SUPPORT_MASKS);
+	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
+	capbuf[OSC_SUPPORT_TYPE] = support_set;
+	capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
+
+	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
+	if (ACPI_SUCCESS(status)) {
+		root->osc_support_set = support_set;
+		root->osc_control_qry = result;
+		root->osc_queried = 1;
+	}
+	return status;
+}
+
+static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
+{
+	acpi_status status;
+	acpi_handle tmp;
+
+	status = acpi_get_handle(root->device->handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+	mutex_lock(&osc_lock);
+	status = acpi_pci_query_osc(root, flags);
+	mutex_unlock(&osc_lock);
+	return status;
+}
+
+static struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
+{
+	struct acpi_pci_root *root;
+	list_for_each_entry(root, &acpi_pci_roots, node) {
+		if (root->device->handle == handle)
+			return root;
+	}
+	return NULL;
+}
+
+/**
+ * pci_osc_control_set - commit requested control to Firmware
+ * @handle: acpi_handle for the target ACPI object
+ * @flags: driver's requested control bits
+ *
+ * Attempt to take control from Firmware on requested control bits.
+ **/
+acpi_status pci_osc_control_set(acpi_handle handle, u32 flags)
+{
+	acpi_status status;
+	u32 control_req, result, capbuf[3];
+	acpi_handle tmp;
+	struct acpi_pci_root *root;
+
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	control_req = (flags & OSC_CONTROL_MASKS);
+	if (!control_req)
+		return AE_TYPE;
+
+	root = acpi_pci_find_root(handle);
+	if (!root)
+		return AE_NOT_EXIST;
+
+	mutex_lock(&osc_lock);
+	/* No need to evaluate _OSC if the control was already granted. */
+	if ((root->osc_control_set & control_req) == control_req)
+		goto out;
+
+	/* Need to query controls first before requesting them */
+	if (!root->osc_queried) {
+		status = acpi_pci_query_osc(root, root->osc_support_set);
+		if (ACPI_FAILURE(status))
+			goto out;
+	}
+	if ((root->osc_control_qry & control_req) != control_req) {
+		printk(KERN_DEBUG "_OSC FW not grant req. control\n");
+		status = AE_SUPPORT;
+		goto out;
+	}
+
+	capbuf[OSC_QUERY_TYPE] = 0;
+	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
+	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
+	status = acpi_pci_run_osc(handle, capbuf, &result);
+	if (ACPI_SUCCESS(status))
+		root->osc_control_set = result;
+out:
+	mutex_unlock(&osc_lock);
+	return status;
+}
+EXPORT_SYMBOL(pci_osc_control_set);
+
 static int __devinit acpi_pci_root_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -217,7 +391,7 @@ static int __devinit acpi_pci_root_add(s
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
 	flags = base_flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
-	pci_acpi_osc_support(device->handle, flags);
+	acpi_pci_osc_support(root, flags);
 
 	/* 
 	 * Segment
@@ -353,7 +527,7 @@ static int __devinit acpi_pci_root_add(s
 	if (pci_msi_enabled())
 		flags |= OSC_MSI_SUPPORT;
 	if (flags != base_flags)
-		pci_acpi_osc_support(device->handle, flags);
+		acpi_pci_osc_support(root, flags);
 
       end:
 	if (result) {
Index: 20090130/drivers/pci/pci-acpi.c
===================================================================
--- 20090130.orig/drivers/pci/pci-acpi.c
+++ 20090130/drivers/pci/pci-acpi.c
@@ -18,221 +18,6 @@
 #include <linux/pci-acpi.h>
 #include "pci.h"
 
-struct acpi_osc_data {
-	acpi_handle handle;
-	u32 support_set;
-	u32 control_set;
-	u32 control_query;
-	int is_queried;
-	struct list_head sibiling;
-};
-static LIST_HEAD(acpi_osc_data_list);
-
-struct acpi_osc_args {
-	u32 capbuf[3];
-};
-
-static DEFINE_MUTEX(pci_acpi_lock);
-
-static struct acpi_osc_data *acpi_get_osc_data(acpi_handle handle)
-{
-	struct acpi_osc_data *data;
-
-	list_for_each_entry(data, &acpi_osc_data_list, sibiling) {
-		if (data->handle == handle)
-			return data;
-	}
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return NULL;
-	INIT_LIST_HEAD(&data->sibiling);
-	data->handle = handle;
-	list_add_tail(&data->sibiling, &acpi_osc_data_list);
-	return data;
-}
-
-static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40,
-			  0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
-
-static acpi_status acpi_run_osc(acpi_handle handle,
-				struct acpi_osc_args *osc_args, u32 *retval)
-{
-	acpi_status status;
-	struct acpi_object_list input;
-	union acpi_object in_params[4];
-	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object *out_obj;
-	u32 errors, flags = osc_args->capbuf[OSC_QUERY_TYPE];
-
-	/* Setting up input parameters */
-	input.count = 4;
-	input.pointer = in_params;
-	in_params[0].type 		= ACPI_TYPE_BUFFER;
-	in_params[0].buffer.length 	= 16;
-	in_params[0].buffer.pointer	= OSC_UUID;
-	in_params[1].type 		= ACPI_TYPE_INTEGER;
-	in_params[1].integer.value 	= 1;
-	in_params[2].type 		= ACPI_TYPE_INTEGER;
-	in_params[2].integer.value	= 3;
-	in_params[3].type		= ACPI_TYPE_BUFFER;
-	in_params[3].buffer.length 	= 12;
-	in_params[3].buffer.pointer 	= (u8 *)osc_args->capbuf;
-
-	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	if (!output.length)
-		return AE_NULL_OBJECT;
-
-	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
-		status = AE_TYPE;
-		goto out_kfree;
-	}
-	/* Need to ignore the bit0 in result code */
-	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
-	if (errors) {
-		if (errors & OSC_REQUEST_ERROR)
-			printk(KERN_DEBUG "_OSC request fails\n"); 
-		if (errors & OSC_INVALID_UUID_ERROR)
-			printk(KERN_DEBUG "_OSC invalid UUID\n"); 
-		if (errors & OSC_INVALID_REVISION_ERROR)
-			printk(KERN_DEBUG "_OSC invalid revision\n"); 
-		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
-			if (flags & OSC_QUERY_ENABLE)
-				goto out_success;
-			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
-			status = AE_SUPPORT;
-			goto out_kfree;
-		}
-		status = AE_ERROR;
-		goto out_kfree;
-	}
-out_success:
-	*retval = *((u32 *)(out_obj->buffer.pointer + 8));
-	status = AE_OK;
-
-out_kfree:
-	kfree(output.pointer);
-	return status;
-}
-
-static acpi_status __acpi_query_osc(u32 flags, struct acpi_osc_data *osc_data)
-{
-	acpi_status status;
-	u32 support_set, result;
-	struct acpi_osc_args osc_args;
-
-	/* do _OSC query for all possible controls */
-	support_set = osc_data->support_set | (flags & OSC_SUPPORT_MASKS);
-	osc_args.capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	osc_args.capbuf[OSC_SUPPORT_TYPE] = support_set;
-	osc_args.capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
-
-	status = acpi_run_osc(osc_data->handle, &osc_args, &result);
-	if (ACPI_SUCCESS(status)) {
-		osc_data->support_set = support_set;
-		osc_data->control_query = result;
-		osc_data->is_queried = 1;
-	}
-
-	return status;
-}
-
-/*
- * pci_acpi_osc_support: Invoke _OSC indicating support for the given feature
- * @flags: Bitmask of flags to support
- *
- * See the ACPI spec for the definition of the flags
- */
-int pci_acpi_osc_support(acpi_handle handle, u32 flags)
-{
-	acpi_status status;
-	acpi_handle tmp;
-	struct acpi_osc_data *osc_data;
-	int rc = 0;
-
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return -ENOTTY;
-
-	mutex_lock(&pci_acpi_lock);
-	osc_data = acpi_get_osc_data(handle);
-	if (!osc_data) {
-		printk(KERN_ERR "acpi osc data array is full\n");
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	__acpi_query_osc(flags, osc_data);
-out:
-	mutex_unlock(&pci_acpi_lock);
-	return rc;
-}
-
-/**
- * pci_osc_control_set - commit requested control to Firmware
- * @handle: acpi_handle for the target ACPI object
- * @flags: driver's requested control bits
- *
- * Attempt to take control from Firmware on requested control bits.
- **/
-acpi_status pci_osc_control_set(acpi_handle handle, u32 flags)
-{
-	acpi_status status;
-	u32 control_req, control_set, result;
-	acpi_handle tmp;
-	struct acpi_osc_data *osc_data;
-	struct acpi_osc_args osc_args;
-
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	mutex_lock(&pci_acpi_lock);
-	osc_data = acpi_get_osc_data(handle);
-	if (!osc_data) {
-		printk(KERN_ERR "acpi osc data array is full\n");
-		status = AE_ERROR;
-		goto out;
-	}
-
-	control_req = (flags & OSC_CONTROL_MASKS);
-	if (!control_req) {
-		status = AE_TYPE;
-		goto out;
-	}
-
-	/* No need to evaluate _OSC if the control was already granted. */
-	if ((osc_data->control_set & control_req) == control_req)
-		goto out;
-
-	if (!osc_data->is_queried) {
-		status = __acpi_query_osc(osc_data->support_set, osc_data);
-		if (ACPI_FAILURE(status))
-			goto out;
-	}
-
-	if ((osc_data->control_query & control_req) != control_req) {
-		status = AE_SUPPORT;
-		goto out;
-	}
-
-	control_set = osc_data->control_set | control_req;
-	osc_args.capbuf[OSC_QUERY_TYPE] = 0;
-	osc_args.capbuf[OSC_SUPPORT_TYPE] = osc_data->support_set;
-	osc_args.capbuf[OSC_CONTROL_TYPE] = control_set;
-	status = acpi_run_osc(handle, &osc_args, &result);
-	if (ACPI_SUCCESS(status))
-		osc_data->control_set = result;
-out:
-	mutex_unlock(&pci_acpi_lock);
-	return status;
-}
-EXPORT_SYMBOL(pci_osc_control_set);
-
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
Index: 20090130/include/linux/pci-acpi.h
===================================================================
--- 20090130.orig/include/linux/pci-acpi.h
+++ 20090130/include/linux/pci-acpi.h
@@ -50,7 +50,6 @@
 
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
-int pci_acpi_osc_support(acpi_handle handle, u32 flags);
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
 	/* Find root host bridge */
