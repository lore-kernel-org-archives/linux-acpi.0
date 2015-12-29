From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 32/42] ACPICA: Cleanup code related to the per-table module level improvement
Date: Tue, 29 Dec 2015 14:01:53 +0800
Message-ID: <3da9bd0159c70fe0386812fad2b030999c3e84be.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 071eff738c59eda1792ac24b3b688b61691d7e7c

This patch collects cleanups from per-table module level improvement. By
splitting this patch from that commit, we can make per-table module level
improvement clearer for the revewers. This is a no-op change.

Link: https://github.com/acpica/acpica/commit/071eff73
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h  |    1 +
 drivers/acpi/acpica/evhandler.c |  113 +++++++++++++++++++++++++--------------
 drivers/acpi/acpica/evregion.c  |    6 +++
 drivers/acpi/acpica/evrgnini.c  |    2 +-
 drivers/acpi/acpica/exdump.c    |    6 ++-
 drivers/acpi/acpica/utxfinit.c  |    7 +++
 6 files changed, 91 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 3977134..ef0abf4 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -145,6 +145,7 @@ ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_operand_cache);
 
 ACPI_INIT_GLOBAL(u32, acpi_gbl_startup_flags, 0);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_shutdown, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_early_initialization, TRUE);
 
 /* Global handlers */
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 74e8595..5d6a3b5 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -55,6 +55,10 @@ static acpi_status
 acpi_ev_install_handler(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value);
 
+static union acpi_operand_object
+    *acpi_ev_find_region_handler(acpi_adr_space_type space_id,
+				 union acpi_operand_object *handler_obj);
+
 /* These are the address spaces that will get default handlers */
 
 u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
@@ -309,6 +313,43 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_find_region_handler
+ *
+ * PARAMETERS:  space_id        - The address space ID
+ *              handler_obj     - Head of the handler object list
+ *
+ * RETURN:      Matching handler object. NULL if space ID not matched
+ *
+ * DESCRIPTION: Search a handler object list for a match on the address
+ *              space ID.
+ *
+ ******************************************************************************/
+
+static union acpi_operand_object
+    *acpi_ev_find_region_handler(acpi_adr_space_type space_id,
+				 union acpi_operand_object *handler_obj)
+{
+
+	/* Walk the handler list for this device */
+
+	while (handler_obj) {
+
+		/* Same space_id indicates a handler is installed */
+
+		if (handler_obj->address_space.space_id == space_id) {
+			return (handler_obj);
+		}
+
+		/* Next handler object */
+
+		handler_obj = handler_obj->address_space.next;
+	}
+
+	return (NULL);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_install_space_handler
  *
  * PARAMETERS:  node            - Namespace node for the device
@@ -332,15 +373,15 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 {
 	union acpi_operand_object *obj_desc;
 	union acpi_operand_object *handler_obj;
-	acpi_status status;
+	acpi_status status = AE_OK;
 	acpi_object_type type;
 	u8 flags = 0;
 
 	ACPI_FUNCTION_TRACE(ev_install_space_handler);
 
 	/*
-	 * This registration is valid for only the types below and the root. This
-	 * is where the default handlers get placed.
+	 * This registration is valid for only the types below and the root.
+	 * The root node is where the default handlers get installed.
 	 */
 	if ((node->type != ACPI_TYPE_DEVICE) &&
 	    (node->type != ACPI_TYPE_PROCESSOR) &&
@@ -407,38 +448,29 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (obj_desc) {
 		/*
-		 * The attached device object already exists. Make sure the handler
-		 * is not already installed.
+		 * The attached device object already exists. Now make sure
+		 * the handler is not already installed.
 		 */
-		handler_obj = obj_desc->device.handler;
-
-		/* Walk the handler list for this device */
-
-		while (handler_obj) {
+		handler_obj = acpi_ev_find_region_handler(space_id,
+							  obj_desc->device.
+							  handler);
 
-			/* Same space_id indicates a handler already installed */
-
-			if (handler_obj->address_space.space_id == space_id) {
-				if (handler_obj->address_space.handler ==
-				    handler) {
-					/*
-					 * It is (relatively) OK to attempt to install the SAME
-					 * handler twice. This can easily happen with the
-					 * PCI_Config space.
-					 */
-					status = AE_SAME_HANDLER;
-					goto unlock_and_exit;
-				} else {
-					/* A handler is already installed */
-
-					status = AE_ALREADY_EXISTS;
-				}
+		if (handler_obj) {
+			if (handler_obj->address_space.handler == handler) {
+				/*
+				 * It is (relatively) OK to attempt to install the SAME
+				 * handler twice. This can easily happen with the
+				 * PCI_Config space.
+				 */
+				status = AE_SAME_HANDLER;
 				goto unlock_and_exit;
-			}
+			} else {
+				/* A handler is already installed */
 
-			/* Walk the linked list of handlers */
+				status = AE_ALREADY_EXISTS;
+			}
 
-			handler_obj = handler_obj->address_space.next;
+			goto unlock_and_exit;
 		}
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
@@ -477,7 +509,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-			  "Installing address handler for region %s(%X) on Device %4.4s %p(%p)\n",
+			  "Installing address handler for region %s(%X) "
+			  "on Device %4.4s %p(%p)\n",
 			  acpi_ut_get_region_name(space_id), space_id,
 			  acpi_ut_get_node_name(node), node, obj_desc));
 
@@ -515,19 +548,17 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	obj_desc->device.handler = handler_obj;
 
 	/*
-	 * Walk the namespace finding all of the regions this
-	 * handler will manage.
+	 * Walk the namespace finding all of the regions this handler will
+	 * manage.
 	 *
-	 * Start at the device and search the branch toward
-	 * the leaf nodes until either the leaf is encountered or
-	 * a device is detected that has an address handler of the
-	 * same type.
+	 * Start at the device and search the branch toward the leaf nodes
+	 * until either the leaf is encountered or a device is detected that
+	 * has an address handler of the same type.
 	 *
-	 * In either case, back up and search down the remainder
-	 * of the branch
+	 * In either case, back up and search down the remainder of the branch
 	 */
-	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
-					ACPI_NS_WALK_UNLOCK,
+	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node,
+					ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
 					acpi_ev_install_handler, NULL,
 					handler_obj, NULL);
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 5ee79a1..6717e57 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -127,6 +127,12 @@ acpi_status acpi_ev_initialize_op_regions(void)
  * DESCRIPTION: Dispatch an address space or operation region access to
  *              a previously installed handler.
  *
+ * NOTE: During early initialization, we always install the default region
+ * handlers for Memory, I/O and PCI_Config. This ensures that these operation
+ * region address spaces are always available as per the ACPI specification.
+ * This is especially needed in order to support the execution of
+ * module-level AML code during loading of the ACPI tables.
+ *
  ******************************************************************************/
 
 acpi_status
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index da32339..6181f5a 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -552,7 +552,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 
 	/*
 	 * The following loop depends upon the root Node having no parent
-	 * ie: acpi_gbl_root_node->parent_entry being set to NULL
+	 * ie: acpi_gbl_root_node->Parent being set to NULL
 	 */
 	while (node) {
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index d836f88..ff976c4 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -508,7 +508,8 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 			if (next) {
 				acpi_os_printf("(%s %2.2X)",
 					       acpi_ut_get_object_type_name
-					       (next), next->common.type);
+					       (next),
+					       next->address_space.space_id);
 
 				while (next->address_space.next) {
 					if ((next->common.type ==
@@ -520,7 +521,8 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 					acpi_os_printf("->%p(%s %2.2X)", next,
 						       acpi_ut_get_object_type_name
 						       (next),
-						       next->common.type);
+						       next->address_space.
+						       space_id);
 
 					if ((next == start) || (next == data)) {
 						acpi_os_printf
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index a7137ec..8586260 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -147,6 +147,13 @@ acpi_status __init acpi_enable_subsystem(u32 flags)
 
 	ACPI_FUNCTION_TRACE(acpi_enable_subsystem);
 
+	/*
+	 * The early initialization phase is complete. The namespace is loaded,
+	 * and we can now support address spaces other than Memory, I/O, and
+	 * PCI_Config.
+	 */
+	acpi_gbl_early_initialization = FALSE;
+
 #if (!ACPI_REDUCED_HARDWARE)
 
 	/* Enable ACPI mode */
-- 
1.7.10
