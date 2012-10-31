From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 25/26] ACPICA: AcpiGetObjectInfo: Add support for ACPI 5 _SUB method
Date: Wed, 31 Oct 2012 10:28:38 +0800
Message-ID: <3afa686d44b36d16d095f2c23a05bccd4eb8f28a.1351649952.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53350 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069Ab2JaC2o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:28:44 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Now calls _SUB in addition to the other ID methods: _HID, _CID,
and _UID.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    4 +++
 drivers/acpi/acpica/nsxfname.c |   29 ++++++++++++++---
 drivers/acpi/acpica/utids.c    |   67 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acnames.h         |    1 +
 include/acpi/actypes.h         |   12 ++++---
 5 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 5a6aa58..b0f5f92 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -363,6 +363,10 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 		    struct acpi_pnp_device_id ** return_id);
 
 acpi_status
+acpi_ut_execute_SUB(struct acpi_namespace_node *device_node,
+		    struct acpi_pnp_device_id **return_id);
+
+acpi_status
 acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 		    struct acpi_pnp_device_id_list ** return_cid_list);
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 2d10df2..811c6f1 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -231,6 +231,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 				    struct acpi_pnp_device_id *source,
 				    char *string_area)
 {
+
 	/* Create the destination PNP_DEVICE_ID */
 
 	dest->string = string_area;
@@ -255,8 +256,8 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
  *              namespace node and possibly by running several standard
  *              control methods (Such as in the case of a device.)
  *
- * For Device and Processor objects, run the Device _HID, _UID, _CID, _STA,
- * _ADR, _sx_w, and _sx_d methods.
+ * For Device and Processor objects, run the Device _HID, _UID, _CID, _SUB,
+ * _STA, _ADR, _sx_w, and _sx_d methods.
  *
  * Note: Allocates the return buffer, must be freed by the caller.
  *
@@ -271,6 +272,7 @@ acpi_get_object_info(acpi_handle handle,
 	struct acpi_pnp_device_id_list *cid_list = NULL;
 	struct acpi_pnp_device_id *hid = NULL;
 	struct acpi_pnp_device_id *uid = NULL;
+	struct acpi_pnp_device_id *sub = NULL;
 	char *next_id_string;
 	acpi_object_type type;
 	acpi_name name;
@@ -315,7 +317,7 @@ acpi_get_object_info(acpi_handle handle,
 	if ((type == ACPI_TYPE_DEVICE) || (type == ACPI_TYPE_PROCESSOR)) {
 		/*
 		 * Get extra info for ACPI Device/Processor objects only:
-		 * Run the Device _HID, _UID, and _CID methods.
+		 * Run the Device _HID, _UID, _SUB, and _CID methods.
 		 *
 		 * Note: none of these methods are required, so they may or may
 		 * not be present for this device. The Info->Valid bitfield is used
@@ -338,6 +340,14 @@ acpi_get_object_info(acpi_handle handle,
 			valid |= ACPI_VALID_UID;
 		}
 
+		/* Execute the Device._SUB method */
+
+		status = acpi_ut_execute_SUB(node, &sub);
+		if (ACPI_SUCCESS(status)) {
+			info_size += sub->length;
+			valid |= ACPI_VALID_SUB;
+		}
+
 		/* Execute the Device._CID method */
 
 		status = acpi_ut_execute_CID(node, &cid_list);
@@ -425,8 +435,9 @@ acpi_get_object_info(acpi_handle handle,
 	}
 
 	/*
-	 * Copy the HID, UID, and CIDs to the return buffer. The variable-length
-	 * strings are copied to the reserved area at the end of the buffer.
+	 * Copy the HID, UID, SUB, and CIDs to the return buffer.
+	 * The variable-length strings are copied to the reserved area
+	 * at the end of the buffer.
 	 *
 	 * For HID and CID, check if the ID is a PCI Root Bridge.
 	 */
@@ -444,6 +455,11 @@ acpi_get_object_info(acpi_handle handle,
 							uid, next_id_string);
 	}
 
+	if (sub) {
+		next_id_string = acpi_ns_copy_device_id(&info->subsystem_id,
+							sub, next_id_string);
+	}
+
 	if (cid_list) {
 		info->compatible_id_list.count = cid_list->count;
 		info->compatible_id_list.list_size = cid_list->list_size;
@@ -480,6 +496,9 @@ acpi_get_object_info(acpi_handle handle,
 	if (uid) {
 		ACPI_FREE(uid);
 	}
+	if (sub) {
+		ACPI_FREE(sub);
+	}
 	if (cid_list) {
 		ACPI_FREE(cid_list);
 	}
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index f18ac81..774c3ae 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -127,6 +127,73 @@ cleanup:
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_execute_SUB
+ *
+ * PARAMETERS:  device_node         - Node for the device
+ *              return_id           - Where the _SUB is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Executes the _SUB control method that returns the subsystem
+ *              ID of the device. The _SUB value is always a string containing
+ *              either a valid PNP or ACPI ID.
+ *
+ *              NOTE: Internal function, no parameter validation
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ut_execute_SUB(struct acpi_namespace_node *device_node,
+		    struct acpi_pnp_device_id **return_id)
+{
+	union acpi_operand_object *obj_desc;
+	struct acpi_pnp_device_id *sub;
+	u32 length;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ut_execute_SUB);
+
+	status = acpi_ut_evaluate_object(device_node, METHOD_NAME__SUB,
+					 ACPI_BTYPE_STRING, &obj_desc);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Get the size of the String to be returned, includes null terminator */
+
+	length = obj_desc->string.length + 1;
+
+	/* Allocate a buffer for the SUB */
+
+	sub =
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
+				 (acpi_size) length);
+	if (!sub) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	/* Area for the string starts after PNP_DEVICE_ID struct */
+
+	sub->string =
+	    ACPI_ADD_PTR(char, sub, sizeof(struct acpi_pnp_device_id));
+
+	/* Simply copy existing string */
+
+	ACPI_STRCPY(sub->string, obj_desc->string.pointer);
+	sub->length = length;
+	*return_id = sub;
+
+      cleanup:
+
+	/* On exit, we must delete the return object */
+
+	acpi_ut_remove_reference(obj_desc);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_execute_UID
  *
  * PARAMETERS:  device_node         - Node for the device
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 745dd24e..7665df6 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -50,6 +50,7 @@
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__CID        "_CID"
 #define METHOD_NAME__UID        "_UID"
+#define METHOD_NAME__SUB        "_SUB"
 #define METHOD_NAME__ADR        "_ADR"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__STA        "_STA"
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d1fb674..4f43f1f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1024,7 +1024,7 @@ u32 (*acpi_interface_handler) (acpi_string interface_name, u32 supported);
 
 #define ACPI_UUID_LENGTH                16
 
-/* Structures used for device/processor HID, UID, CID */
+/* Structures used for device/processor HID, UID, CID, and SUB */
 
 struct acpi_pnp_device_id {
 	u32 length;		/* Length of string + null */
@@ -1054,6 +1054,7 @@ struct acpi_device_info {
 	u64 address;	/* _ADR value */
 	struct acpi_pnp_device_id hardware_id;	/* _HID value */
 	struct acpi_pnp_device_id unique_id;	/* _UID value */
+	struct acpi_pnp_device_id subsystem_id;	/* _SUB value */
 	struct acpi_pnp_device_id_list compatible_id_list;	/* _CID list <must be last> */
 };
 
@@ -1067,11 +1068,12 @@ struct acpi_device_info {
 #define ACPI_VALID_ADR                  0x02
 #define ACPI_VALID_HID                  0x04
 #define ACPI_VALID_UID                  0x08
-#define ACPI_VALID_CID                  0x10
-#define ACPI_VALID_SXDS                 0x20
-#define ACPI_VALID_SXWS                 0x40
+#define ACPI_VALID_SUB                  0x10
+#define ACPI_VALID_CID                  0x20
+#define ACPI_VALID_SXDS                 0x40
+#define ACPI_VALID_SXWS                 0x80
 
-/* Flags for _STA method */
+/* Flags for _STA return value (current_status above) */
 
 #define ACPI_STA_DEVICE_PRESENT         0x01
 #define ACPI_STA_DEVICE_ENABLED         0x02
-- 
1.7.10

