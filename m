From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/26] ACPICA: Fix divergences of definition conflicts.
Date: Wed, 31 Oct 2012 10:25:24 +0800
Message-ID: <325dcdeb5e70ae037401e2777ae3f27546141e0d.1351649950.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3776 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202Ab2JaCZi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:25:38 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

There are conflicts in the "acpi_device_id*" definitions between the
Linux and the ACPICA.  The definitions of acpi_device_id* in ACPICA
have been changed to the "acpi_pnp_device_id*".  This patch changes
the corresponding "acpica_device_id*" definitiions in the Linux.

This patch will not affect the generated vmlinx binary.
This will decrease 298 lines of 20120913 divergence.diff.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    6 +++---
 drivers/acpi/acpica/evrgnini.c |    4 ++--
 drivers/acpi/acpica/nsxfeval.c |    4 ++--
 drivers/acpi/acpica/nsxfname.c |   28 ++++++++++++++--------------
 drivers/acpi/acpica/utids.c    |   37 ++++++++++++++++++++-----------------
 drivers/acpi/scan.c            |    2 +-
 include/acpi/actypes.h         |   12 ++++++------
 7 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 82d6025..d94b417 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -355,15 +355,15 @@ acpi_ut_execute_power_methods(struct acpi_namespace_node *device_node,
  */
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id ** return_id);
+		    struct acpi_pnp_device_id ** return_id);
 
 acpi_status
 acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id ** return_id);
+		    struct acpi_pnp_device_id ** return_id);
 
 acpi_status
 acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id_list ** return_cid_list);
+		    struct acpi_pnp_device_id_list ** return_cid_list);
 
 /*
  * utlock - reader/writer locks
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 4c1c826..6786f00 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -350,8 +350,8 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 {
 	acpi_status status;
-	struct acpica_device_id *hid;
-	struct acpica_device_id_list *cid;
+	struct acpi_pnp_device_id *hid;
+	struct acpi_pnp_device_id_list *cid;
 	u32 i;
 	u8 match;
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 9692e67..494f2eb 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -542,8 +542,8 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 	acpi_status status;
 	struct acpi_namespace_node *node;
 	u32 flags;
-	struct acpica_device_id *hid;
-	struct acpica_device_id_list *cid;
+	struct acpi_pnp_device_id *hid;
+	struct acpi_pnp_device_id_list *cid;
 	u32 i;
 	u8 found;
 	int no_match;
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 08e9610..7bc4985 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -53,8 +53,8 @@
 ACPI_MODULE_NAME("nsxfname")
 
 /* Local prototypes */
-static char *acpi_ns_copy_device_id(struct acpica_device_id *dest,
-				    struct acpica_device_id *source,
+static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
+				    struct acpi_pnp_device_id *source,
 				    char *string_area);
 
 /******************************************************************************
@@ -219,20 +219,20 @@ ACPI_EXPORT_SYMBOL(acpi_get_name)
  *
  * FUNCTION:    acpi_ns_copy_device_id
  *
- * PARAMETERS:  dest                - Pointer to the destination DEVICE_ID
- *              source              - Pointer to the source DEVICE_ID
+ * PARAMETERS:  dest                - Pointer to the destination PNP_DEVICE_ID
+ *              source              - Pointer to the source PNP_DEVICE_ID
  *              string_area         - Pointer to where to copy the dest string
  *
  * RETURN:      Pointer to the next string area
  *
- * DESCRIPTION: Copy a single DEVICE_ID, including the string data.
+ * DESCRIPTION: Copy a single PNP_DEVICE_ID, including the string data.
  *
  ******************************************************************************/
-static char *acpi_ns_copy_device_id(struct acpica_device_id *dest,
-				    struct acpica_device_id *source,
+static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
+				    struct acpi_pnp_device_id *source,
 				    char *string_area)
 {
-	/* Create the destination DEVICE_ID */
+	/* Create the destination PNP_DEVICE_ID */
 
 	dest->string = string_area;
 	dest->length = source->length;
@@ -269,9 +269,9 @@ acpi_get_object_info(acpi_handle handle,
 {
 	struct acpi_namespace_node *node;
 	struct acpi_device_info *info;
-	struct acpica_device_id_list *cid_list = NULL;
-	struct acpica_device_id *hid = NULL;
-	struct acpica_device_id *uid = NULL;
+	struct acpi_pnp_device_id_list *cid_list = NULL;
+	struct acpi_pnp_device_id *hid = NULL;
+	struct acpi_pnp_device_id *uid = NULL;
 	char *next_id_string;
 	acpi_object_type type;
 	acpi_name name;
@@ -348,7 +348,7 @@ acpi_get_object_info(acpi_handle handle,
 
 			info_size +=
 			    (cid_list->list_size -
-			     sizeof(struct acpica_device_id_list));
+			     sizeof(struct acpi_pnp_device_id_list));
 			valid |= ACPI_VALID_CID;
 		}
 	}
@@ -418,11 +418,11 @@ acpi_get_object_info(acpi_handle handle,
 	next_id_string = ACPI_CAST_PTR(char, info->compatible_id_list.ids);
 	if (cid_list) {
 
-		/* Point past the CID DEVICE_ID array */
+		/* Point past the CID PNP_DEVICE_ID array */
 
 		next_id_string +=
 		    ((acpi_size) cid_list->count *
-		     sizeof(struct acpica_device_id));
+		     sizeof(struct acpi_pnp_device_id));
 	}
 
 	/*
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 5d84e19..f18ac81 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -67,10 +67,10 @@ ACPI_MODULE_NAME("utids")
  ******************************************************************************/
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id **return_id)
+		    struct acpi_pnp_device_id **return_id)
 {
 	union acpi_operand_object *obj_desc;
-	struct acpica_device_id *hid;
+	struct acpi_pnp_device_id *hid;
 	u32 length;
 	acpi_status status;
 
@@ -94,16 +94,17 @@ acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 	/* Allocate a buffer for the HID */
 
 	hid =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpica_device_id) +
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
 				 (acpi_size) length);
 	if (!hid) {
 		status = AE_NO_MEMORY;
 		goto cleanup;
 	}
 
-	/* Area for the string starts after DEVICE_ID struct */
+	/* Area for the string starts after PNP_DEVICE_ID struct */
 
-	hid->string = ACPI_ADD_PTR(char, hid, sizeof(struct acpica_device_id));
+	hid->string =
+	    ACPI_ADD_PTR(char, hid, sizeof(struct acpi_pnp_device_id));
 
 	/* Convert EISAID to a string or simply copy existing string */
 
@@ -144,10 +145,10 @@ cleanup:
 
 acpi_status
 acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id **return_id)
+		    struct acpi_pnp_device_id **return_id)
 {
 	union acpi_operand_object *obj_desc;
-	struct acpica_device_id *uid;
+	struct acpi_pnp_device_id *uid;
 	u32 length;
 	acpi_status status;
 
@@ -171,16 +172,17 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 	/* Allocate a buffer for the UID */
 
 	uid =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpica_device_id) +
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
 				 (acpi_size) length);
 	if (!uid) {
 		status = AE_NO_MEMORY;
 		goto cleanup;
 	}
 
-	/* Area for the string starts after DEVICE_ID struct */
+	/* Area for the string starts after PNP_DEVICE_ID struct */
 
-	uid->string = ACPI_ADD_PTR(char, uid, sizeof(struct acpica_device_id));
+	uid->string =
+	    ACPI_ADD_PTR(char, uid, sizeof(struct acpi_pnp_device_id));
 
 	/* Convert an Integer to string, or just copy an existing string */
 
@@ -226,11 +228,11 @@ cleanup:
 
 acpi_status
 acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id_list **return_cid_list)
+		    struct acpi_pnp_device_id_list **return_cid_list)
 {
 	union acpi_operand_object **cid_objects;
 	union acpi_operand_object *obj_desc;
-	struct acpica_device_id_list *cid_list;
+	struct acpi_pnp_device_id_list *cid_list;
 	char *next_id_string;
 	u32 string_area_size;
 	u32 length;
@@ -288,11 +290,12 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 	/*
 	 * Now that we know the length of the CIDs, allocate return buffer:
 	 * 1) Size of the base structure +
-	 * 2) Size of the CID DEVICE_ID array +
+	 * 2) Size of the CID PNP_DEVICE_ID array +
 	 * 3) Size of the actual CID strings
 	 */
-	cid_list_size = sizeof(struct acpica_device_id_list) +
-	    ((count - 1) * sizeof(struct acpica_device_id)) + string_area_size;
+	cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
+	    ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
+	    string_area_size;
 
 	cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
 	if (!cid_list) {
@@ -300,10 +303,10 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 		goto cleanup;
 	}
 
-	/* Area for CID strings starts after the CID DEVICE_ID array */
+	/* Area for CID strings starts after the CID PNP_DEVICE_ID array */
 
 	next_id_string = ACPI_CAST_PTR(char, cid_list->ids) +
-	    ((acpi_size) count * sizeof(struct acpica_device_id));
+	    ((acpi_size) count * sizeof(struct acpi_pnp_device_id));
 
 	/* Copy/convert the CIDs to the return buffer */
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1fcb867..db12710 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1185,7 +1185,7 @@ static void acpi_device_set_id(struct acpi_device *device)
 {
 	acpi_status status;
 	struct acpi_device_info *info;
-	struct acpica_device_id_list *cid_list;
+	struct acpi_pnp_device_id_list *cid_list;
 	int i;
 
 	switch (device->device_type) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index a85bae9..7520f42 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1020,15 +1020,15 @@ u32 (*acpi_interface_handler) (acpi_string interface_name, u32 supported);
 
 /* Structures used for device/processor HID, UID, CID */
 
-struct acpica_device_id {
+struct acpi_pnp_device_id {
 	u32 length;		/* Length of string + null */
 	char *string;
 };
 
-struct acpica_device_id_list {
+struct acpi_pnp_device_id_list {
 	u32 count;		/* Number of IDs in Ids array */
 	u32 list_size;		/* Size of list, including ID strings */
-	struct acpica_device_id ids[1];	/* ID array */
+	struct acpi_pnp_device_id ids[1];	/* ID array */
 };
 
 /*
@@ -1046,9 +1046,9 @@ struct acpi_device_info {
 	u8 lowest_dstates[5];	/* _sx_w values: 0xFF indicates not valid */
 	u32 current_status;	/* _STA value */
 	u64 address;	/* _ADR value */
-	struct acpica_device_id hardware_id;	/* _HID value */
-	struct acpica_device_id unique_id;	/* _UID value */
-	struct acpica_device_id_list compatible_id_list;	/* _CID list <must be last> */
+	struct acpi_pnp_device_id hardware_id;	/* _HID value */
+	struct acpi_pnp_device_id unique_id;	/* _UID value */
+	struct acpi_pnp_device_id_list compatible_id_list;	/* _CID list <must be last> */
 };
 
 /* Values for Flags field above (acpi_get_object_info) */
-- 
1.7.10

