From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/22] ACPICA: Add GPE support for dynamically loaded ACPI
 tables
Date: Thu, 20 May 2010 01:18:44 -0400
Message-ID: <186c307f008d2a53961cd970aaf7cb9c33e79cb1.1274332658.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab0ETGPh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:37 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:15:03 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

For all GPEs, including FADT-based and GPE Block Devices, execute
any _PRW methods in the new table, and process any _Lxx/_Exx GPE
methods in the new table. Any runtime GPE that is referred to
by an _Lxx/_Exx method in the new table is immediately enabled.
ACPICA BZ 833.

http://www.acpica.org/bugzilla/show_bug.cgi?id=833

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acevents.h |    2 +
 drivers/acpi/acpica/aclocal.h  |    4 +
 drivers/acpi/acpica/evgpe.c    |    2 +-
 drivers/acpi/acpica/evgpeblk.c |  316 +++++++++++++++++++++++++++++++++++-----
 drivers/acpi/acpica/exconfig.c |   21 ++-
 5 files changed, 298 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 5e094a2..0f83dc4 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -110,6 +110,8 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 			 u32 interrupt_number,
 			 struct acpi_gpe_block_info **return_gpe_block);
 
+void acpi_ev_update_gpes(acpi_owner_id table_owner_id);
+
 acpi_status
 acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 			     struct acpi_gpe_block_info *gpe_block);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 0886a3d..147a7e6 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -470,6 +470,10 @@ struct acpi_gpe_xrupt_info {
 struct acpi_gpe_walk_info {
 	struct acpi_namespace_node *gpe_device;
 	struct acpi_gpe_block_info *gpe_block;
+	u16 count;
+	acpi_owner_id owner_id;
+	u8 enable_this_gpe;
+	u8 execute_by_owner_id;
 };
 
 struct acpi_gpe_device_info {
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index deb26f4..a221ad4 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -265,7 +265,7 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 
 	ACPI_FUNCTION_ENTRY();
 
-	/* A NULL gpe_block means use the FADT-defined GPE block(s) */
+	/* A NULL gpe_device means use the FADT-defined GPE block(s) */
 
 	if (!gpe_device) {
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 85ded1f..3341d1d 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "acevents.h"
 #include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evgpeblk")
@@ -236,7 +237,9 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  * DESCRIPTION: Called from acpi_walk_namespace. Expects each object to be a
  *              control method under the _GPE portion of the namespace.
  *              Extract the name and GPE type from the object, saving this
- *              information for quick lookup during GPE dispatch
+ *              information for quick lookup during GPE dispatch. Allows a
+ *              per-owner_id evaluation if execute_by_owner_id is TRUE in the
+ *              walk_info parameter block.
  *
  *              The name of each GPE control method is of the form:
  *              "_Lxx" or "_Exx", where:
@@ -244,21 +247,36 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  *                  E      - means that the GPE is edge triggered
  *                  xx     - is the GPE number [in HEX]
  *
+ * If walk_info->execute_by_owner_id is TRUE, we only execute examine GPE methods
+ *    with that owner.
+ * If walk_info->enable_this_gpe is TRUE, the GPE that is referred to by a GPE
+ *    method is immediately enabled (Used for Load/load_table operators)
+ *
  ******************************************************************************/
 
 static acpi_status
 acpi_ev_match_gpe_method(acpi_handle obj_handle,
-			 u32 level, void *obj_desc, void **return_value)
+			 u32 level, void *context, void **return_value)
 {
 	struct acpi_namespace_node *method_node =
 	    ACPI_CAST_PTR(struct acpi_namespace_node, obj_handle);
-	struct acpi_gpe_block_info *gpe_block = (void *)obj_desc;
+	struct acpi_gpe_walk_info *walk_info =
+	    ACPI_CAST_PTR(struct acpi_gpe_walk_info, context);
 	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_namespace_node *gpe_device;
+	acpi_status status;
 	u32 gpe_number;
 	char name[ACPI_NAME_SIZE + 1];
 	u8 type;
 
-	ACPI_FUNCTION_TRACE(ev_save_method_info);
+	ACPI_FUNCTION_TRACE(ev_match_gpe_method);
+
+	/* Check if requested owner_id matches this owner_id */
+
+	if ((walk_info->execute_by_owner_id) &&
+	    (method_node->owner_id != walk_info->owner_id)) {
+		return_ACPI_STATUS(AE_OK);
+	}
 
 	/*
 	 * Match and decode the _Lxx and _Exx GPE method names
@@ -314,7 +332,8 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 
 	/* Ensure that we have a valid GPE number for this GPE block */
 
-	gpe_event_info = acpi_ev_low_get_gpe_info(gpe_number, gpe_block);
+	gpe_event_info =
+	    acpi_ev_low_get_gpe_info(gpe_number, walk_info->gpe_block);
 	if (!gpe_event_info) {
 		/*
 		 * This gpe_number is not valid for this GPE block, just ignore it.
@@ -324,13 +343,64 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	    ACPI_GPE_DISPATCH_HANDLER) {
+
+		/* If there is already a handler, ignore this GPE method */
+
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	    ACPI_GPE_DISPATCH_METHOD) {
+		/*
+		 * If there is already a method, ignore this method. But check
+		 * for a type mismatch (if both the _Lxx AND _Exx exist)
+		 */
+		if (type != (gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK)) {
+			ACPI_ERROR((AE_INFO,
+				    "For GPE 0x%.2X, found both _L%2.2X and _E%2.2X methods",
+				    gpe_number, gpe_number, gpe_number));
+		}
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/*
 	 * Add the GPE information from above to the gpe_event_info block for
 	 * use during dispatch of this GPE.
 	 */
-	gpe_event_info->flags = (u8)(type | ACPI_GPE_DISPATCH_METHOD);
+	gpe_event_info->flags |= (u8)(type | ACPI_GPE_DISPATCH_METHOD);
 	gpe_event_info->dispatch.method_node = method_node;
 
+	/*
+	 * Enable this GPE if requested. This only happens when during the
+	 * execution of a Load or load_table operator. We have found a new
+	 * GPE method and want to immediately enable the GPE if it is a
+	 * runtime GPE.
+	 */
+	if (walk_info->enable_this_gpe) {
+
+		/* Ignore GPEs that can wake the system */
+
+		if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE) ||
+		    !acpi_gbl_leave_wake_gpes_disabled) {
+			walk_info->count++;
+			gpe_device = walk_info->gpe_device;
+
+			if (gpe_device == acpi_gbl_fadt_gpe_device) {
+				gpe_device = NULL;
+			}
+
+			status = acpi_enable_gpe(gpe_device, gpe_number,
+						 ACPI_GPE_TYPE_RUNTIME);
+			if (ACPI_FAILURE(status)) {
+				ACPI_EXCEPTION((AE_INFO, status,
+						"Could not enable GPE 0x%02X",
+						gpe_number));
+			}
+		}
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
 			  "Registered GPE method %s as GPE number 0x%.2X\n",
 			  name, gpe_number));
@@ -348,18 +418,27 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
  *
  * DESCRIPTION: Called from acpi_walk_namespace. Expects each object to be a
  *              Device. Run the _PRW method. If present, extract the GPE
- *              number and mark the GPE as a CAN_WAKE GPE.
+ *              number and mark the GPE as a CAN_WAKE GPE. Allows a
+ *              per-owner_id execution if execute_by_owner_id is TRUE in the
+ *              walk_info parameter block.
+ *
+ * If walk_info->execute_by_owner_id is TRUE, we only execute _PRWs with that
+ *    owner.
+ * If walk_info->gpe_device is NULL, we execute every _PRW found. Otherwise,
+ *    we only execute _PRWs that refer to the input gpe_device.
  *
  ******************************************************************************/
 
 static acpi_status
 acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
-			  u32 level, void *info, void **return_value)
+			  u32 level, void *context, void **return_value)
 {
-	struct acpi_gpe_walk_info *gpe_info = (void *)info;
+	struct acpi_gpe_walk_info *walk_info =
+	    ACPI_CAST_PTR(struct acpi_gpe_walk_info, context);
 	struct acpi_namespace_node *gpe_device;
 	struct acpi_gpe_block_info *gpe_block;
 	struct acpi_namespace_node *target_gpe_device;
+	struct acpi_namespace_node *prw_node;
 	struct acpi_gpe_event_info *gpe_event_info;
 	union acpi_operand_object *pkg_desc;
 	union acpi_operand_object *obj_desc;
@@ -370,12 +449,24 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 
 	/* Check for a _PRW method under this device */
 
-	status = acpi_ut_evaluate_object(obj_handle, METHOD_NAME__PRW,
-					 ACPI_BTYPE_PACKAGE, &pkg_desc);
+	status = acpi_ns_get_node(obj_handle, METHOD_NAME__PRW,
+				  ACPI_NS_NO_UPSEARCH, &prw_node);
 	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(AE_OK);
+	}
 
-		/* Ignore all errors from _PRW, we don't want to abort the walk */
+	/* Check if requested owner_id matches this owner_id */
 
+	if ((walk_info->execute_by_owner_id) &&
+	    (prw_node->owner_id != walk_info->owner_id)) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Execute the _PRW */
+
+	status = acpi_ut_evaluate_object(prw_node, NULL,
+					 ACPI_BTYPE_PACKAGE, &pkg_desc);
+	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
@@ -387,12 +478,12 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 
 	/* Extract pointers from the input context */
 
-	gpe_device = gpe_info->gpe_device;
-	gpe_block = gpe_info->gpe_block;
+	gpe_device = walk_info->gpe_device;
+	gpe_block = walk_info->gpe_block;
 
 	/*
-	 * The _PRW object must return a package, we are only interested in the
-	 * first element
+	 * The _PRW object must return a package, we are only interested
+	 * in the first element
 	 */
 	obj_desc = pkg_desc->package.elements[0];
 
@@ -400,7 +491,10 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 
 		/* Use FADT-defined GPE device (from definition of _PRW) */
 
-		target_gpe_device = acpi_gbl_fadt_gpe_device;
+		target_gpe_device = NULL;
+		if (gpe_device) {
+			target_gpe_device = acpi_gbl_fadt_gpe_device;
+		}
 
 		/* Integer is the GPE number in the FADT described GPE blocks */
 
@@ -428,23 +522,38 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 		goto cleanup;
 	}
 
-	/*
-	 * Is this GPE within this block?
-	 *
-	 * TRUE if and only if these conditions are true:
-	 *     1) The GPE devices match.
-	 *     2) The GPE index(number) is within the range of the Gpe Block
-	 *          associated with the GPE device.
-	 */
-	if (gpe_device != target_gpe_device) {
-		goto cleanup;
+	/* Get the gpe_event_info for this GPE */
+
+	if (gpe_device) {
+		/*
+		 * Is this GPE within this block?
+		 *
+		 * TRUE if and only if these conditions are true:
+		 *     1) The GPE devices match.
+		 *     2) The GPE index(number) is within the range of the Gpe Block
+		 *          associated with the GPE device.
+		 */
+		if (gpe_device != target_gpe_device) {
+			goto cleanup;
+		}
+
+		gpe_event_info =
+		    acpi_ev_low_get_gpe_info(gpe_number, gpe_block);
+	} else {
+		/* gpe_device is NULL, just match the target_device and gpe_number */
+
+		gpe_event_info =
+		    acpi_ev_get_gpe_event_info(target_gpe_device, gpe_number);
 	}
 
-	gpe_event_info = acpi_ev_low_get_gpe_info(gpe_number, gpe_block);
 	if (gpe_event_info) {
-		/* This GPE can wake the system */
+		if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
+
+			/* This GPE can wake the system */
 
-		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+			gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+			walk_info->count++;
+		}
 	}
 
       cleanup:
@@ -874,6 +983,7 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 {
 	acpi_status status;
 	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_walk_info walk_info;
 
 	ACPI_FUNCTION_TRACE(ev_create_gpe_block);
 
@@ -916,12 +1026,17 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Find all GPE methods (_Lxx, _Exx) for this block */
+	/* Find all GPE methods (_Lxx or_Exx) for this block */
+
+	walk_info.gpe_block = gpe_block;
+	walk_info.gpe_device = gpe_device;
+	walk_info.enable_this_gpe = FALSE;
+	walk_info.execute_by_owner_id = FALSE;
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_METHOD, gpe_device,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
 					acpi_ev_match_gpe_method, NULL,
-					gpe_block, NULL);
+					&walk_info, NULL);
 
 	/* Return the new block */
 
@@ -945,6 +1060,123 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_update_gpes
+ *
+ * PARAMETERS:  table_owner_id      - ID of the newly-loaded ACPI table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Check for new GPE methods (_Lxx/_Exx) made available as a
+ *              result of a Load() or load_table() operation. If new GPE
+ *              methods have been installed, register the new methods and
+ *              enable and runtime GPEs that are associated with them. Also,
+ *              run any newly loaded _PRW methods in order to discover any
+ *              new CAN_WAKE GPEs.
+ *
+ ******************************************************************************/
+
+void acpi_ev_update_gpes(acpi_owner_id table_owner_id)
+{
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_walk_info walk_info;
+	acpi_status status = AE_OK;
+	u32 new_wake_gpe_count = 0;
+
+	/* We will examine only _PRW/_Lxx/_Exx methods owned by this table */
+
+	walk_info.owner_id = table_owner_id;
+	walk_info.execute_by_owner_id = TRUE;
+	walk_info.count = 0;
+
+	if (acpi_gbl_leave_wake_gpes_disabled) {
+		/*
+		 * 1) Run any newly-loaded _PRW methods to find any GPEs that
+		 * can now be marked as CAN_WAKE GPEs. Note: We must run the
+		 * _PRW methods before we process the _Lxx/_Exx methods because
+		 * we will enable all runtime GPEs associated with the new
+		 * _Lxx/_Exx methods at the time we process those methods.
+		 *
+		 * Unlock interpreter so that we can run the _PRW methods.
+		 */
+		walk_info.gpe_block = NULL;
+		walk_info.gpe_device = NULL;
+
+		acpi_ex_exit_interpreter();
+
+		status =
+		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+					   ACPI_UINT32_MAX,
+					   ACPI_NS_WALK_NO_UNLOCK,
+					   acpi_ev_match_prw_and_gpe, NULL,
+					   &walk_info, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"While executing _PRW methods"));
+		}
+
+		acpi_ex_enter_interpreter();
+		new_wake_gpe_count = walk_info.count;
+	}
+
+	/*
+	 * 2) Find any _Lxx/_Exx GPE methods that have just been loaded.
+	 *
+	 * Any GPEs that correspond to new _Lxx/_Exx methods and are not
+	 * marked as CAN_WAKE are immediately enabled.
+	 *
+	 * Examine the namespace underneath each gpe_device within the
+	 * gpe_block lists.
+	 */
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return;
+	}
+
+	walk_info.count = 0;
+	walk_info.enable_this_gpe = TRUE;
+
+	/* Walk the interrupt level descriptor list */
+
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+
+		/* Walk all Gpe Blocks attached to this interrupt level */
+
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			walk_info.gpe_block = gpe_block;
+			walk_info.gpe_device = gpe_block->node;
+
+			status = acpi_ns_walk_namespace(ACPI_TYPE_METHOD,
+							walk_info.gpe_device,
+							ACPI_UINT32_MAX,
+							ACPI_NS_WALK_NO_UNLOCK,
+							acpi_ev_match_gpe_method,
+							NULL, &walk_info, NULL);
+			if (ACPI_FAILURE(status)) {
+				ACPI_EXCEPTION((AE_INFO, status,
+						"While decoding _Lxx/_Exx methods"));
+			}
+
+			gpe_block = gpe_block->next;
+		}
+
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+
+	if (walk_info.count || new_wake_gpe_count) {
+		ACPI_INFO((AE_INFO,
+			   "Enabled %u new runtime GPEs, added %u new wakeup GPEs",
+			   walk_info.count, new_wake_gpe_count));
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	return;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_initialize_gpe_block
  *
  * PARAMETERS:  gpe_device          - Handle to the parent GPE block
@@ -965,7 +1197,7 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 {
 	acpi_status status;
 	struct acpi_gpe_event_info *gpe_event_info;
-	struct acpi_gpe_walk_info gpe_info;
+	struct acpi_gpe_walk_info walk_info;
 	u32 wake_gpe_count;
 	u32 gpe_enabled_count;
 	u32 gpe_index;
@@ -992,13 +1224,15 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 		 * definition a wake GPE and will not be enabled while the machine
 		 * is running.
 		 */
-		gpe_info.gpe_block = gpe_block;
-		gpe_info.gpe_device = gpe_device;
+		walk_info.gpe_block = gpe_block;
+		walk_info.gpe_device = gpe_device;
+		walk_info.execute_by_owner_id = FALSE;
 
-		status = acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+		status =
+		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
 					   acpi_ev_match_prw_and_gpe, NULL,
-					   &gpe_info, NULL);
+					   &walk_info, NULL);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"While executing _PRW methods"));
@@ -1054,9 +1288,11 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 		}
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
-			  "Found %u Wake, Enabled %u Runtime GPEs in this block\n",
-			  wake_gpe_count, gpe_enabled_count));
+	if (gpe_enabled_count || wake_gpe_count) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INIT,
+				  "Enabled %u Runtime GPEs, added %u Wake GPEs in this block\n",
+				  gpe_enabled_count, wake_gpe_count));
+	}
 
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 7e8b3be..008621c 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -82,8 +82,9 @@ acpi_ex_add_table(u32 table_index,
 		  struct acpi_namespace_node *parent_node,
 		  union acpi_operand_object **ddb_handle)
 {
-	acpi_status status;
 	union acpi_operand_object *obj_desc;
+	acpi_status status;
+	acpi_owner_id owner_id;
 
 	ACPI_FUNCTION_TRACE(ex_add_table);
 
@@ -119,7 +120,14 @@ acpi_ex_add_table(u32 table_index,
 	acpi_ns_exec_module_code_list();
 	acpi_ex_enter_interpreter();
 
-	return_ACPI_STATUS(status);
+	/* Update GPEs for any new _PRW or _Lxx/_Exx methods. Ignore errors */
+
+	status = acpi_tb_get_owner_id(table_index, &owner_id);
+	if (ACPI_SUCCESS(status)) {
+		acpi_ev_update_gpes(owner_id);
+	}
+
+	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************
@@ -248,10 +256,8 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	status = acpi_get_table_by_index(table_index, &table);
 	if (ACPI_SUCCESS(status)) {
-		ACPI_INFO((AE_INFO,
-			   "Dynamic OEM Table Load - [%.4s] OemId [%.6s] OemTableId [%.8s]",
-			   table->signature, table->oem_id,
-			   table->oem_table_id));
+		ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
+		acpi_tb_print_table_header(0, table);
 	}
 
 	/* Invoke table handler if present */
@@ -525,6 +531,9 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(status);
 	}
 
+	ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
+	acpi_tb_print_table_header(0, table_desc.pointer);
+
 	/* Remove the reference by added by acpi_ex_store above */
 
 	acpi_ut_remove_reference(ddb_handle);
-- 
1.6.0.6

