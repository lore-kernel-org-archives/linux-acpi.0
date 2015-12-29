From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/42] ACPICA: Revert "acpi_get_object_info: Add support for ACPI 5.0 _SUB method."
Date: Tue, 29 Dec 2015 13:55:47 +0800
Message-ID: <0d52c8bcd7a561582d1b08609dde86c98619a202.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e4743959b59ad93eab7310adf756adc930be0ddb

This reverts commit 8e7a8753827660c3dd1f571f3185610402b756f0.

The _SUB method was found to be problematic for this interface
because some implementations use control methods. Therefore,
it is being removed.

Operations cannot be used because this interface is called
during the device discovery scan and the region handlers are
not fully installed at that time.

Conflicts:
	source/components/debugger/dbdisply.c
	source/components/namespace/nsxfname.c
	source/components/utilities/utids.c
	source/include/acnames.h
	source/include/actypes.h
	source/tools/acpinames/anstubs.c

Link: https://github.com/acpica/acpica/commit/e4743959
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    4 ---
 drivers/acpi/acpica/dbdisply.c |   48 ++++++++++------------------
 drivers/acpi/acpica/nsxfname.c |   29 +++--------------
 drivers/acpi/acpica/utids.c    |   67 ----------------------------------------
 include/acpi/actypes.h         |    6 ++--
 5 files changed, 24 insertions(+), 130 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 6776348..9e84c05 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -364,10 +364,6 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 		    struct acpi_pnp_device_id ** return_id);
 
 acpi_status
-acpi_ut_execute_SUB(struct acpi_namespace_node *device_node,
-		    struct acpi_pnp_device_id **return_id);
-
-acpi_status
 acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 		    struct acpi_pnp_device_id_list ** return_cid_list);
 
diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index 3acc3a5..390a7ca 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -588,7 +588,7 @@ void acpi_db_display_calling_tree(void)
  *
  * FUNCTION:    acpi_db_display_object_type
  *
- * PARAMETERS:  name            - User entered NS node handle or name
+ * PARAMETERS:  object_arg      - User entered NS node handle
  *
  * RETURN:      None
  *
@@ -596,44 +596,34 @@ void acpi_db_display_calling_tree(void)
  *
  ******************************************************************************/
 
-void acpi_db_display_object_type(char *name)
+void acpi_db_display_object_type(char *object_arg)
 {
-	struct acpi_namespace_node *node;
+	acpi_handle handle;
 	struct acpi_device_info *info;
 	acpi_status status;
 	u32 i;
 
-	node = acpi_db_convert_to_node(name);
-	if (!node) {
-		return;
-	}
+	handle = ACPI_TO_POINTER(strtoul(object_arg, NULL, 16));
 
-	status = acpi_get_object_info(ACPI_CAST_PTR(acpi_handle, node), &info);
+	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status)) {
 		acpi_os_printf("Could not get object info, %s\n",
 			       acpi_format_exception(status));
 		return;
 	}
 
-	if (info->valid & ACPI_VALID_ADR) {
-		acpi_os_printf("ADR: %8.8X%8.8X, STA: %8.8X, Flags: %X\n",
-			       ACPI_FORMAT_UINT64(info->address),
-			       info->current_status, info->flags);
-	}
-	if (info->valid & ACPI_VALID_SXDS) {
-		acpi_os_printf("S1D-%2.2X S2D-%2.2X S3D-%2.2X S4D-%2.2X\n",
-			       info->highest_dstates[0],
-			       info->highest_dstates[1],
-			       info->highest_dstates[2],
-			       info->highest_dstates[3]);
-	}
-	if (info->valid & ACPI_VALID_SXWS) {
-		acpi_os_printf
-		    ("S0W-%2.2X S1W-%2.2X S2W-%2.2X S3W-%2.2X S4W-%2.2X\n",
-		     info->lowest_dstates[0], info->lowest_dstates[1],
-		     info->lowest_dstates[2], info->lowest_dstates[3],
-		     info->lowest_dstates[4]);
-	}
+	acpi_os_printf("ADR: %8.8X%8.8X, STA: %8.8X, Flags: %X\n",
+		       ACPI_FORMAT_UINT64(info->address),
+		       info->current_status, info->flags);
+
+	acpi_os_printf("S1D-%2.2X S2D-%2.2X S3D-%2.2X S4D-%2.2X\n",
+		       info->highest_dstates[0], info->highest_dstates[1],
+		       info->highest_dstates[2], info->highest_dstates[3]);
+
+	acpi_os_printf("S0W-%2.2X S1W-%2.2X S2W-%2.2X S3W-%2.2X S4W-%2.2X\n",
+		       info->lowest_dstates[0], info->lowest_dstates[1],
+		       info->lowest_dstates[2], info->lowest_dstates[3],
+		       info->lowest_dstates[4]);
 
 	if (info->valid & ACPI_VALID_HID) {
 		acpi_os_printf("HID: %s\n", info->hardware_id.string);
@@ -643,10 +633,6 @@ void acpi_db_display_object_type(char *name)
 		acpi_os_printf("UID: %s\n", info->unique_id.string);
 	}
 
-	if (info->valid & ACPI_VALID_SUB) {
-		acpi_os_printf("SUB: %s\n", info->subsystem_id.string);
-	}
-
 	if (info->valid & ACPI_VALID_CID) {
 		for (i = 0; i < info->compatible_id_list.count; i++) {
 			acpi_os_printf("CID %u: %s\n", i,
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index c19d86c..0e4e6b7 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -238,7 +238,6 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 				    struct acpi_pnp_device_id *source,
 				    char *string_area)
 {
-
 	/* Create the destination PNP_DEVICE_ID */
 
 	dest->string = string_area;
@@ -263,8 +262,8 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
  *              namespace node and possibly by running several standard
  *              control methods (Such as in the case of a device.)
  *
- * For Device and Processor objects, run the Device _HID, _UID, _CID, _SUB,
- * _CLS, _STA, _ADR, _sx_w, and _sx_d methods.
+ * For Device and Processor objects, run the Device _HID, _UID, _CID, _STA,
+ * _CLS, _ADR, _sx_w, and _sx_d methods.
  *
  * Note: Allocates the return buffer, must be freed by the caller.
  *
@@ -279,7 +278,6 @@ acpi_get_object_info(acpi_handle handle,
 	struct acpi_pnp_device_id_list *cid_list = NULL;
 	struct acpi_pnp_device_id *hid = NULL;
 	struct acpi_pnp_device_id *uid = NULL;
-	struct acpi_pnp_device_id *sub = NULL;
 	struct acpi_pnp_device_id *cls = NULL;
 	char *next_id_string;
 	acpi_object_type type;
@@ -325,7 +323,7 @@ acpi_get_object_info(acpi_handle handle,
 	if ((type == ACPI_TYPE_DEVICE) || (type == ACPI_TYPE_PROCESSOR)) {
 		/*
 		 * Get extra info for ACPI Device/Processor objects only:
-		 * Run the Device _HID, _UID, _SUB, _CID, and _CLS methods.
+		 * Run the Device _HID, _UID, _CLS, and _CID methods.
 		 *
 		 * Note: none of these methods are required, so they may or may
 		 * not be present for this device. The Info->Valid bitfield is used
@@ -348,14 +346,6 @@ acpi_get_object_info(acpi_handle handle,
 			valid |= ACPI_VALID_UID;
 		}
 
-		/* Execute the Device._SUB method */
-
-		status = acpi_ut_execute_SUB(node, &sub);
-		if (ACPI_SUCCESS(status)) {
-			info_size += sub->length;
-			valid |= ACPI_VALID_SUB;
-		}
-
 		/* Execute the Device._CID method */
 
 		status = acpi_ut_execute_CID(node, &cid_list);
@@ -456,9 +446,8 @@ acpi_get_object_info(acpi_handle handle,
 	}
 
 	/*
-	 * Copy the HID, UID, SUB, and CIDs to the return buffer.
-	 * The variable-length strings are copied to the reserved area
-	 * at the end of the buffer.
+	 * Copy the HID, UID, and CIDs to the return buffer. The variable-length
+	 * strings are copied to the reserved area at the end of the buffer.
 	 *
 	 * For HID and CID, check if the ID is a PCI Root Bridge.
 	 */
@@ -476,11 +465,6 @@ acpi_get_object_info(acpi_handle handle,
 							uid, next_id_string);
 	}
 
-	if (sub) {
-		next_id_string = acpi_ns_copy_device_id(&info->subsystem_id,
-							sub, next_id_string);
-	}
-
 	if (cid_list) {
 		info->compatible_id_list.count = cid_list->count;
 		info->compatible_id_list.list_size = cid_list->list_size;
@@ -522,9 +506,6 @@ cleanup:
 	if (uid) {
 		ACPI_FREE(uid);
 	}
-	if (sub) {
-		ACPI_FREE(sub);
-	}
 	if (cid_list) {
 		ACPI_FREE(cid_list);
 	}
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 7956df1e..05ee76e 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -127,73 +127,6 @@ cleanup:
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_execute_SUB
- *
- * PARAMETERS:  device_node         - Node for the device
- *              return_id           - Where the _SUB is returned
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Executes the _SUB control method that returns the subsystem
- *              ID of the device. The _SUB value is always a string containing
- *              either a valid PNP or ACPI ID.
- *
- *              NOTE: Internal function, no parameter validation
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ut_execute_SUB(struct acpi_namespace_node *device_node,
-		    struct acpi_pnp_device_id **return_id)
-{
-	union acpi_operand_object *obj_desc;
-	struct acpi_pnp_device_id *sub;
-	u32 length;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ut_execute_SUB);
-
-	status = acpi_ut_evaluate_object(device_node, METHOD_NAME__SUB,
-					 ACPI_BTYPE_STRING, &obj_desc);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Get the size of the String to be returned, includes null terminator */
-
-	length = obj_desc->string.length + 1;
-
-	/* Allocate a buffer for the SUB */
-
-	sub =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
-				 (acpi_size) length);
-	if (!sub) {
-		status = AE_NO_MEMORY;
-		goto cleanup;
-	}
-
-	/* Area for the string starts after PNP_DEVICE_ID struct */
-
-	sub->string =
-	    ACPI_ADD_PTR(char, sub, sizeof(struct acpi_pnp_device_id));
-
-	/* Simply copy existing string */
-
-	strcpy(sub->string, obj_desc->string.pointer);
-	sub->length = length;
-	*return_id = sub;
-
-cleanup:
-
-	/* On exit, we must delete the return object */
-
-	acpi_ut_remove_reference(obj_desc);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ut_execute_UID
  *
  * PARAMETERS:  device_node         - Node for the device
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f914958..9633f60 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1148,7 +1148,7 @@ u32 (*acpi_interface_handler) (acpi_string interface_name, u32 supported);
 
 #define ACPI_PCICLS_STRING_SIZE         7	/* Includes null terminator */
 
-/* Structures used for device/processor HID, UID, CID, and SUB */
+/* Structures used for device/processor HID, UID, CID */
 
 struct acpi_pnp_device_id {
 	u32 length;		/* Length of string + null */
@@ -1178,7 +1178,6 @@ struct acpi_device_info {
 	u64 address;	/* _ADR value */
 	struct acpi_pnp_device_id hardware_id;	/* _HID value */
 	struct acpi_pnp_device_id unique_id;	/* _UID value */
-	struct acpi_pnp_device_id subsystem_id;	/* _SUB value */
 	struct acpi_pnp_device_id class_code;	/* _CLS value */
 	struct acpi_pnp_device_id_list compatible_id_list;	/* _CID list <must be last> */
 };
@@ -1193,13 +1192,12 @@ struct acpi_device_info {
 #define ACPI_VALID_ADR                  0x0002
 #define ACPI_VALID_HID                  0x0004
 #define ACPI_VALID_UID                  0x0008
-#define ACPI_VALID_SUB                  0x0010
 #define ACPI_VALID_CID                  0x0020
 #define ACPI_VALID_CLS                  0x0040
 #define ACPI_VALID_SXDS                 0x0100
 #define ACPI_VALID_SXWS                 0x0200
 
-/* Flags for _STA return value (current_status above) */
+/* Flags for _STA method */
 
 #define ACPI_STA_DEVICE_PRESENT         0x01
 #define ACPI_STA_DEVICE_ENABLED         0x02
-- 
1.7.10
