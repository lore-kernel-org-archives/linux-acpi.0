From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/15] ACPICA: Fixes comments caused divergences.
Date: Wed, 21 Nov 2012 18:07:08 +0800
Message-ID: <c319ad8c72da810bdb81d4092dbc547cc946d0b7.1353491652.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30210 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127Ab2KUKHN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:07:13 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch fixes divergences caused by the differences in the comments.
Some ACPICA utilities' feature definitions are also fixed in this patch.

This patch will not affect the generated vmlinux binary.
This will decrease 663 lines of 20121018 divergence.diff.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |   13 +++---
 drivers/acpi/acpica/acobject.h  |    2 +-
 drivers/acpi/acpica/acpredef.h  |   14 +++---
 drivers/acpi/acpica/dsopcode.c  |   14 +++---
 drivers/acpi/acpica/evgpe.c     |    4 +-
 drivers/acpi/acpica/evxface.c   |   23 +++++-----
 drivers/acpi/acpica/evxfevnt.c  |    4 +-
 drivers/acpi/acpica/evxfgpe.c   |    9 ++--
 drivers/acpi/acpica/exconfig.c  |    9 ++--
 drivers/acpi/acpica/exmutex.c   |    3 +-
 drivers/acpi/acpica/exregion.c  |   15 ++++---
 drivers/acpi/acpica/hwesleep.c  |    1 -
 drivers/acpi/acpica/hwregs.c    |    2 +-
 drivers/acpi/acpica/hwxface.c   |    2 +-
 drivers/acpi/acpica/hwxfsleep.c |    7 +--
 drivers/acpi/acpica/nsdump.c    |    4 +-
 drivers/acpi/acpica/nsnames.c   |    3 +-
 drivers/acpi/acpica/nspredef.c  |    1 -
 drivers/acpi/acpica/tbfadt.c    |    5 ++-
 drivers/acpi/acpica/utglobal.c  |    2 +
 drivers/acpi/acpica/utobject.c  |    2 +-
 drivers/acpi/acpica/utxferror.c |    4 +-
 include/acpi/acconfig.h         |    2 +-
 include/acpi/acpixf.h           |   19 +++++---
 include/acpi/actbl1.h           |    6 +--
 include/acpi/actypes.h          |    4 +-
 include/acpi/platform/acenv.h   |   94 ++++++++++++++++++++++++++-------------
 27 files changed, 161 insertions(+), 107 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index b1988bb..99d6b9b 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -189,11 +189,10 @@ struct acpi_namespace_node {
 #define ANOBJ_EVALUATED                 0x20	/* Set on first evaluation of node */
 #define ANOBJ_ALLOCATED_BUFFER          0x40	/* Method AML buffer is dynamic (install_method) */
 
-#define ANOBJ_IS_EXTERNAL               0x08	/* i_aSL only: This object created via External() */
-#define ANOBJ_METHOD_NO_RETVAL          0x10	/* i_aSL only: Method has no return value */
-#define ANOBJ_METHOD_SOME_NO_RETVAL     0x20	/* i_aSL only: Method has at least one return value */
-#define ANOBJ_IS_BIT_OFFSET             0x40	/* i_aSL only: Reference is a bit offset */
-#define ANOBJ_IS_REFERENCED             0x80	/* i_aSL only: Object was referenced */
+#define ANOBJ_IS_EXTERNAL               0x08	/* iASL only: This object created via External() */
+#define ANOBJ_METHOD_NO_RETVAL          0x10	/* iASL only: Method has no return value */
+#define ANOBJ_METHOD_SOME_NO_RETVAL     0x20	/* iASL only: Method has at least one return value */
+#define ANOBJ_IS_REFERENCED             0x80	/* iASL only: Object was referenced */
 
 /* Internal ACPI table management - master table list */
 
@@ -416,6 +415,10 @@ struct acpi_gpe_notify_object {
 	struct acpi_gpe_notify_object *next;
 };
 
+/*
+ * GPE dispatch info. At any time, the GPE can have at most one type
+ * of dispatch - Method, Handler, or Implicit Notify.
+ */
 union acpi_gpe_dispatch_info {
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level */
 	struct acpi_gpe_handler_info *handler;  /* Installed GPE handler */
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 24eb9ea..921262e 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -307,7 +307,7 @@ struct acpi_object_addr_handler {
 	struct acpi_namespace_node *node;	/* Parent device */
 	void *context;
 	acpi_adr_space_setup setup;
-	union acpi_operand_object *region_list;	/* regions using this handler */
+	union acpi_operand_object *region_list;	/* Regions using this handler */
 	union acpi_operand_object *next;
 };
 
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 9dfa1c8..55fff56 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -1,7 +1,6 @@
 /******************************************************************************
  *
  * Name: acpredef - Information table for ACPI predefined methods and objects
- *              $Revision: 1.1 $
  *
  *****************************************************************************/
 
@@ -51,13 +50,13 @@
  *
  * 1) PTYPE1 packages do not contain sub-packages.
  *
- * ACPI_PTYPE1_FIXED: Fixed length, 1 or 2 object types:
+ * ACPI_PTYPE1_FIXED: Fixed-length length, 1 or 2 object types:
  *      object type
  *      count
  *      object type
  *      count
  *
- * ACPI_PTYPE1_VAR: Variable length:
+ * ACPI_PTYPE1_VAR: Variable-length length:
  *      object type (Int/Buf/Ref)
  *
  * ACPI_PTYPE1_OPTION: Package has some required and some optional elements
@@ -85,10 +84,10 @@
  *      count
  *      (Used for _CST)
  *
- * ACPI_PTYPE2_FIXED: Each subpackage is of fixed length
+ * ACPI_PTYPE2_FIXED: Each subpackage is of Fixed-length
  *      (Used for _PRT)
  *
- * ACPI_PTYPE2_MIN: Each subpackage has a variable but minimum length
+ * ACPI_PTYPE2_MIN: Each subpackage has a Variable-length but minimum length
  *      (Used for _HPX)
  *
  * ACPI_PTYPE2_REV_FIXED: Revision at start, each subpackage is Fixed-length
@@ -124,7 +123,8 @@ enum acpi_return_package_types {
  * These are the names that can actually be evaluated via acpi_evaluate_object.
  * Not present in this table are the following:
  *
- *      1) Predefined/Reserved names that are never evaluated via acpi_evaluate_object:
+ *      1) Predefined/Reserved names that are never evaluated via
+ *         acpi_evaluate_object:
  *          _Lxx and _Exx GPE methods
  *          _Qxx EC methods
  *          _T_x compiler temporary variables
@@ -149,6 +149,8 @@ enum acpi_return_package_types {
  * information about the expected structure of the package. This information
  * is saved here (rather than in a separate table) in order to minimize the
  * overall size of the stored data.
+ *
+ * Note: The additional braces are intended to promote portability.
  */
 static const union acpi_predefined_info predefined_names[] = {
 	{{"_AC0", 0, ACPI_RTYPE_INTEGER}},
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 0df024e..8e9bdce 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -486,18 +486,18 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 	ACPI_FUNCTION_TRACE_PTR(ds_eval_table_region_operands, op);
 
 	/*
-	 * This is where we evaluate the signature_string and oem_iDString
-	 * and oem_table_iDString of the data_table_region declaration
+	 * This is where we evaluate the Signature string, oem_id string,
+	 * and oem_table_id string of the Data Table Region declaration
 	 */
 	node = op->common.node;
 
-	/* next_op points to signature_string op */
+	/* next_op points to Signature string op */
 
 	next_op = op->common.value.arg;
 
 	/*
-	 * Evaluate/create the signature_string and oem_iDString
-	 * and oem_table_iDString operands
+	 * Evaluate/create the Signature string, oem_id string,
+	 * and oem_table_id string operands
 	 */
 	status = acpi_ds_create_operands(walk_state, next_op);
 	if (ACPI_FAILURE(status)) {
@@ -505,8 +505,8 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 	}
 
 	/*
-	 * Resolve the signature_string and oem_iDString
-	 * and oem_table_iDString operands
+	 * Resolve the Signature string, oem_id string,
+	 * and oem_table_id string operands
 	 */
 	status = acpi_ex_resolve_operands(op->common.aml_opcode,
 					  ACPI_WALK_OPERANDS, walk_state);
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 36d1205..a137ce81 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -561,8 +561,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			status = AE_NO_MEMORY;
 		} else {
 			/*
-			 * Invoke the GPE Method (_Lxx, _Exx) i.e., evaluate the _Lxx/_Exx
-			 * control method that corresponds to this GPE
+			 * Invoke the GPE Method (_Lxx, _Exx) i.e., evaluate the
+			 * _Lxx/_Exx control method that corresponds to this GPE
 			 */
 			info->prefix_node =
 			    local_gpe_event_info->dispatch.method_node;
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index ae668f3..74fe0f1 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -56,13 +56,13 @@ ACPI_MODULE_NAME("evxface")
  *
  * FUNCTION:    acpi_install_notify_handler
  *
- * PARAMETERS:  Device          - The device for which notifies will be handled
+ * PARAMETERS:  device          - The device for which notifies will be handled
  *              handler_type    - The type of handler:
  *                                  ACPI_SYSTEM_NOTIFY: System Handler (00-7F)
  *                                  ACPI_DEVICE_NOTIFY: Device Handler (80-FF)
  *                                  ACPI_ALL_NOTIFY:    Both System and Device
- *              Handler         - Address of the handler
- *              Context         - Value passed to the handler on each GPE
+ *              handler         - Address of the handler
+ *              context         - Value passed to the handler on each GPE
  *
  * RETURN:      Status
  *
@@ -217,12 +217,12 @@ ACPI_EXPORT_SYMBOL(acpi_install_notify_handler)
  *
  * FUNCTION:    acpi_remove_notify_handler
  *
- * PARAMETERS:  Device          - The device for which the handler is installed
+ * PARAMETERS:  device          - The device for which the handler is installed
  *              handler_type    - The type of handler:
  *                                  ACPI_SYSTEM_NOTIFY: System Handler (00-7F)
  *                                  ACPI_DEVICE_NOTIFY: Device Handler (80-FF)
  *                                  ACPI_ALL_NOTIFY:    Both System and Device
- *              Handler         - Address of the handler
+ *              handler         - Address of the handler
  *
  * RETURN:      Status
  *
@@ -249,7 +249,8 @@ acpi_remove_notify_handler(acpi_handle device,
 	    (handler_type > ACPI_MAX_NOTIFY_HANDLER_TYPE)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
-	/* Make sure all deferred tasks are completed */
+
+	/* Make sure all deferred notify tasks are completed */
 
 	acpi_os_wait_events_complete();
 
@@ -596,7 +597,7 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Allocate memory for the handler object */
+	/* Allocate and init handler object (before lock) */
 
 	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_handler_info));
 	if (!handler) {
@@ -622,8 +623,6 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 		goto free_and_exit;
 	}
 
-	/* Allocate and init handler object */
-
 	handler->address = address;
 	handler->context = context;
 	handler->method_node = gpe_event_info->dispatch.method_node;
@@ -631,7 +630,7 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 			(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
 
 	/*
-	 * If the GPE is associated with a method, it might have been enabled
+	 * If the GPE is associated with a method, it may have been enabled
 	 * automatically during initialization, in which case it has to be
 	 * disabled now to avoid spurious execution of the handler.
 	 */
@@ -646,7 +645,7 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	gpe_event_info->dispatch.handler = handler;
 
-	/* Setup up dispatch flags to indicate handler (vs. method) */
+	/* Setup up dispatch flags to indicate handler (vs. method/notify) */
 
 	gpe_event_info->flags &=
 	    ~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
@@ -697,7 +696,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Make sure all deferred tasks are completed */
+	/* Make sure all deferred GPE tasks are completed */
 
 	acpi_os_wait_events_complete();
 
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 35520c6..ee6e96c 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -210,8 +210,8 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
  *
  * FUNCTION:    acpi_disable_event
  *
- * PARAMETERS:  Event           - The fixed eventto be enabled
- *              Flags           - Reserved
+ * PARAMETERS:  event           - The fixed event to be disabled
+ *              flags           - Reserved
  *
  * RETURN:      Status
  *
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 3f30e75..36f8ad8 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -51,7 +51,7 @@
 ACPI_MODULE_NAME("evxfgpe")
 
 #if (!ACPI_REDUCED_HARDWARE)	/* Entire module */
-/******************************************************************************
+/*******************************************************************************
  *
  * FUNCTION:    acpi_update_all_gpes
  *
@@ -172,6 +172,7 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
+
 ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
 
 
@@ -225,7 +226,7 @@ acpi_setup_gpe_for_wake(acpi_handle wake_device,
 		    ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
 	}
 
-	/* Validate WakeDevice is of type Device */
+	/* Validate wake_device is of type Device */
 
 	if (device_node->type != ACPI_TYPE_DEVICE) {
 		return_ACPI_STATUS (AE_BAD_PARAMETER);
@@ -432,8 +433,8 @@ ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              event_status    - Where the current status of the event will
- *                                be returned
+ *              event_status        - Where the current status of the event
+ *                                    will be returned
  *
  * RETURN:      Status
  *
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 16219bd..b4f42f5 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -120,8 +120,11 @@ acpi_ex_add_table(u32 table_index,
 	acpi_ns_exec_module_code_list();
 	acpi_ex_enter_interpreter();
 
-	/* Update GPEs for any new _Lxx/_Exx methods. Ignore errors */
-
+	/*
+	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
+	 * responsible for discovering any new wake GPEs by running _PRW methods
+	 * that may have been loaded by this table.
+	 */
 	status = acpi_tb_get_owner_id(table_index, &owner_id);
 	if (ACPI_SUCCESS(status)) {
 		acpi_ev_update_gpes(owner_id);
@@ -158,7 +161,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE(ex_load_table_op);
 
-	/* Validate lengths for the signature_string, OEMIDString, OEMtable_iD */
+	/* Validate lengths for the Signature, oem_id, and oem_table_id strings */
 
 	if ((operand[0]->string.length > ACPI_NAME_SIZE) ||
 	    (operand[1]->string.length > ACPI_OEM_ID_SIZE) ||
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index d1f449d..02157ef 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -377,7 +377,8 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
 	}
 
-	/* Must have a valid thread. */
+	/* Must have a valid thread ID */
+
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], null thread info",
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 1db2c0b..48c660a 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -142,9 +142,9 @@ acpi_ex_system_memory_space_handler(u32 function,
 		}
 
 		/*
-		 * Attempt to map from the requested address to the end of the region.
-		 * However, we will never map more than one page, nor will we cross
-		 * a page boundary.
+		 * October 2009: Attempt to map from the requested address to the
+		 * end of the region. However, we will never map more than one
+		 * page, nor will we cross a page boundary.
 		 */
 		map_length = (acpi_size)
 		    ((mem_info->address + mem_info->length) - address);
@@ -154,12 +154,15 @@ acpi_ex_system_memory_space_handler(u32 function,
 		 * a page boundary, just map up to the page boundary, do not cross.
 		 * On some systems, crossing a page boundary while mapping regions
 		 * can cause warnings if the pages have different attributes
-		 * due to resource management
+		 * due to resource management.
+		 *
+		 * This has the added benefit of constraining a single mapping to
+		 * one page, which is similar to the original code that used a 4k
+		 * maximum window.
 		 */
 		page_boundary_map_length =
 		    ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address;
-
-		if (!page_boundary_map_length) {
+		if (page_boundary_map_length == 0) {
 			page_boundary_map_length = ACPI_DEFAULT_PAGE_SIZE;
 		}
 
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 94996f9..6c0b1a9 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -200,7 +200,6 @@ acpi_status acpi_hw_extended_wake_prep(u8 sleep_state)
  * FUNCTION:    acpi_hw_extended_wake
  *
  * PARAMETERS:  sleep_state         - Which sleep state we just exited
- *              flags               - Reserved, set to zero
  *
  * RETURN:      Status
  *
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index f4e5750..165395f 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -485,7 +485,7 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 						&acpi_gbl_xpm1b_status);
 		break;
 
-	case ACPI_REGISTER_PM1_ENABLE:	/* PM1 A/B: 16-bit access */
+	case ACPI_REGISTER_PM1_ENABLE:	/* PM1 A/B: 16-bit access each */
 
 		status = acpi_hw_write_multiple(value,
 						&acpi_gbl_xpm1a_enable,
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 05a154c..cac44b9 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -333,7 +333,7 @@ ACPI_EXPORT_SYMBOL(acpi_read_bit_register)
  * FUNCTION:    acpi_write_bit_register
  *
  * PARAMETERS:  register_id     - ID of ACPI Bit Register to access
- *              Value           - Value to write to the register, in bit
+ *              value           - Value to write to the register, in bit
  *                                position zero. The bit is automatically
  *                                shifted to the correct position.
  *
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index ae443fe2..2898011 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -350,7 +350,7 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Enter a system sleep state (see ACPI 2.0 spec p 231)
+ * DESCRIPTION: Enter a system sleep state
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
@@ -382,8 +382,9 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state)
  * RETURN:      Status
  *
  * DESCRIPTION: Perform the first state of OS-independent ACPI cleanup after a
- *              sleep.
- *              Called with interrupts DISABLED.
+ *              sleep. Called with interrupts DISABLED.
+ *              We break wake/resume into 2 stages so that OSPM can handle
+ *              various OS-specific tasks between the two steps.
  *
  ******************************************************************************/
 acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 924b3c7..8e6f0037 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -729,5 +729,5 @@ void acpi_ns_dump_tables(acpi_handle search_base, u32 max_depth)
 			     ACPI_OWNER_ID_MAX, search_handle);
 	return_VOID;
 }
-#endif				/* _ACPI_ASL_COMPILER */
-#endif				/* defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER) */
+#endif
+#endif
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 55a175e..7d34641 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -126,7 +126,8 @@ acpi_ns_build_external_path(struct acpi_namespace_node *node,
  *              the node, In external format (name segments separated by path
  *              separators.)
  *
- * DESCRIPTION: Used for debug printing in acpi_ns_search_table().
+ * DESCRIPTION: Used to obtain the full pathname to a namespace node, usually
+ *              for error and debug statements.
  *
  ******************************************************************************/
 
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 2419f41..352be3b 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -1,7 +1,6 @@
 /******************************************************************************
  *
  * Module Name: nspredef - Validation of ACPI predefined methods and objects
- *              $Revision: 1.1 $
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 3906518..882285b 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -172,6 +172,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
  * FUNCTION:    acpi_tb_init_generic_address
  *
  * PARAMETERS:  generic_address     - GAS struct to be initialized
+ *              space_id            - ACPI Space ID for this register
  *              byte_width          - Width of this register
  *              address             - Address of the register
  *
@@ -407,8 +408,8 @@ static void acpi_tb_convert_fadt(void)
 	 * should be zero are indeed zero. This will workaround BIOSs that
 	 * inadvertently place values in these fields.
 	 *
-	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located at
-	 * offset 45, 55, 95, and the word located at offset 109, 110.
+	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located
+	 * at offset 45, 55, 95, and the word located at offset 109, 110.
 	 *
 	 * Note: The FADT revision value is unreliable. Only the length can be
 	 * trusted.
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 711fd22..c083611 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -372,6 +372,8 @@ acpi_status acpi_ut_init_globals(void)
 	return_ACPI_STATUS(AE_OK);
 }
 
+/* Public globals */
+
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 5c52ca7..822600b 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -419,7 +419,7 @@ void acpi_ut_delete_object_desc(union acpi_operand_object *object)
 {
 	ACPI_FUNCTION_TRACE_PTR(ut_delete_object_desc, object);
 
-	/* Object must be a union acpi_operand_object */
+	/* Object must be of type union acpi_operand_object */
 
 	if (ACPI_GET_DESCRIPTOR_TYPE(object) != ACPI_DESC_TYPE_OPERAND) {
 		ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index d4d3826..a247a22 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -297,9 +297,9 @@ ACPI_EXPORT_SYMBOL(acpi_bios_warning)
  *
  * PARAMETERS:  module_name     - Caller's module name (for error output)
  *              line_number     - Caller's line number (for error output)
- *              Pathname        - Full pathname to the node
+ *              pathname        - Full pathname to the node
  *              node_flags      - From Namespace node for the method/object
- *              Format          - Printf format string + additional args
+ *              format          - Printf format string + additional args
  *
  * RETURN:      None
  *
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 0943457..358258a 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -138,7 +138,7 @@
 
 /* Maximum sleep allowed via Sleep() operator */
 
-#define ACPI_MAX_SLEEP                  2000	/* Two seconds */
+#define ACPI_MAX_SLEEP                  2000	/* 2000 millisec == two seconds */
 
 /* Address Range lists are per-space_id (Memory and I/O only) */
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3d88395..d8ec35b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -56,11 +56,16 @@
 extern u8 acpi_gbl_permanent_mmap;
 
 /*
- * Globals that are publicly available, allowing for
- * run time configuration
+ * Globals that are publically available
  */
+
+/* Runtime configuration of debug print levels */
+
 extern u32 acpi_dbg_level;
 extern u32 acpi_dbg_layer;
+
+/* ACPICA runtime options */
+
 extern u8 acpi_gbl_enable_interpreter_slack;
 extern u8 acpi_gbl_all_methods_serialized;
 extern u8 acpi_gbl_create_osi_method;
@@ -106,7 +111,7 @@ extern u8 acpi_gbl_reduced_hardware;	/* ACPI 5.0 */
 
 extern u32 acpi_rsdt_forced;
 /*
- * Global interfaces
+ * Initialization
  */
 acpi_status
 acpi_initialize_tables(struct acpi_table_desc *initial_storage,
@@ -120,13 +125,15 @@ acpi_status acpi_initialize_objects(u32 flags);
 
 acpi_status acpi_terminate(void);
 
+/*
+ * Miscellaneous global interfaces
+ */
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable(void))
+ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable(void))
 #ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_subsystem_status(void);
 #endif
 
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable(void))
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable(void))
-
 #ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_system_info(struct acpi_buffer *ret_buffer);
 #endif
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 280fc45..61f04c0 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -768,7 +768,7 @@ struct acpi_madt_interrupt_source {
 
 struct acpi_madt_local_x2apic {
 	struct acpi_subtable_header header;
-	u16 reserved;		/* Reserved - must be zero */
+	u16 reserved;		/* reserved - must be zero */
 	u32 local_apic_id;	/* Processor x2APIC ID  */
 	u32 lapic_flags;
 	u32 uid;		/* ACPI processor UID */
@@ -781,14 +781,14 @@ struct acpi_madt_local_x2apic_nmi {
 	u16 inti_flags;
 	u32 uid;		/* ACPI processor UID */
 	u8 lint;		/* LINTn to which NMI is connected */
-	u8 reserved[3];
+	u8 reserved[3];		/* reserved - must be zero */
 };
 
 /* 11: Generic Interrupt (ACPI 5.0) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
-	u16 reserved;		/* Reserved - must be zero */
+	u16 reserved;		/* reserved - must be zero */
 	u32 gic_id;
 	u32 uid;
 	u32 flags;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4f43f1f..35d4dea0 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -595,7 +595,7 @@ typedef u32 acpi_object_type;
 
 /*
  * These are special object types that never appear in
- * a Namespace node, only in a union acpi_operand_object
+ * a Namespace node, only in an object of union acpi_operand_object
  */
 #define ACPI_TYPE_LOCAL_EXTRA           0x1C
 #define ACPI_TYPE_LOCAL_DATA            0x1D
@@ -662,7 +662,7 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
-/* Actions for acpi_set_gpe_wake_mask, acpi_hw_low_set_gpe */
+/* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index c743ca4..89fcc3e 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Name: acenv.h - Generation environment specific items
+ * Name: acenv.h - Host and compiler configuration
  *
  *****************************************************************************/
 
@@ -44,6 +44,12 @@
 #ifndef __ACENV_H__
 #define __ACENV_H__
 
+/*
+ * Environment configuration. The purpose of this file is to interface ACPICA
+ * to the local environment. This includes compiler-specific, OS-specific,
+ * and machine-specific configuration.
+ */
+
 /* Types for ACPI_MUTEX_TYPE */
 
 #define ACPI_BINARY_SEMAPHORE       0
@@ -60,13 +66,7 @@
  *
  *****************************************************************************/
 
-#ifdef ACPI_LIBRARY
-/*
- * Note: The non-debug version of the acpi_library does not contain any
- * debug support, for minimal size. The debug version uses ACPI_FULL_DEBUG
- */
-#define ACPI_USE_LOCAL_CACHE
-#endif
+/* iASL configuration */
 
 #ifdef ACPI_ASL_COMPILER
 #define ACPI_APPLICATION
@@ -78,21 +78,55 @@
 #define ACPI_SINGLE_THREADED
 #endif
 
+/* acpi_exec configuration. Multithreaded with full AML debugger */
+
 #ifdef ACPI_EXEC_APP
-#undef DEBUGGER_THREADING
-#define DEBUGGER_THREADING      DEBUGGER_SINGLE_THREADED
-#define ACPI_FULL_DEBUG
 #define ACPI_APPLICATION
-#define ACPI_DEBUGGER
+#define ACPI_FULL_DEBUG
 #define ACPI_MUTEX_DEBUG
 #define ACPI_DBG_TRACK_ALLOCATIONS
 #endif
 
+/* acpi_names configuration. Single threaded with debugger output enabled. */
+
+#ifdef ACPI_NAMES_APP
+#define ACPI_DEBUGGER
+#define ACPI_APPLICATION
+#define ACPI_SINGLE_THREADED
+#endif
+
+/*
+ * acpi_bin/acpi_help/acpi_src configuration. All single threaded, with
+ * no debug output.
+ */
+#if (defined ACPI_BIN_APP)   || \
+	(defined ACPI_SRC_APP)   || \
+	(defined ACPI_XTRACT_APP)
+#define ACPI_APPLICATION
+#define ACPI_SINGLE_THREADED
+#endif
+
+#ifdef ACPI_HELP_APP
+#define ACPI_APPLICATION
+#define ACPI_SINGLE_THREADED
+#define ACPI_NO_ERROR_MESSAGES
+#endif
+
+/* Linkable ACPICA library */
+
+#ifdef ACPI_LIBRARY
+#define ACPI_USE_LOCAL_CACHE
+#endif
+
+/* Common for all ACPICA applications */
+
 #ifdef ACPI_APPLICATION
 #define ACPI_USE_SYSTEM_CLIBRARY
 #define ACPI_USE_LOCAL_CACHE
 #endif
 
+/* Common debug support */
+
 #ifdef ACPI_FULL_DEBUG
 #define ACPI_DEBUGGER
 #define ACPI_DEBUG_OUTPUT
@@ -231,9 +265,9 @@
  * We want to keep these to a minimum.
  */
 #ifdef ACPI_USE_STANDARD_HEADERS
-/*
- * Use the standard headers from the standard locations
- */
+
+/* Use the standard headers from the standard locations */
+
 #include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
@@ -241,9 +275,8 @@
 
 #endif				/* ACPI_USE_STANDARD_HEADERS */
 
-/*
- * We will be linking to the standard Clib functions
- */
+/* We will be linking to the standard Clib functions */
+
 #define ACPI_STRSTR(s1,s2)      strstr((s1), (s2))
 #define ACPI_STRCHR(s1,c)       strchr((s1), (c))
 #define ACPI_STRLEN(s)          (acpi_size) strlen((s))
@@ -275,13 +308,12 @@
  *
  *****************************************************************************/
 
- /*
-  * Use local definitions of C library macros and functions
-  * NOTE: The function implementations may not be as efficient
-  * as an inline or assembly code implementation provided by a
-  * native C library.
-  */
-
+/*
+ * Use local definitions of C library macros and functions. These function
+ * implementations may not be as efficient as an inline or assembly code
+ * implementation provided by a native C library, but they are functionally
+ * equivalent.
+ */
 #ifndef va_arg
 
 #ifndef _VALIST
@@ -289,15 +321,13 @@
 typedef char *va_list;
 #endif				/* _VALIST */
 
-/*
- * Storage alignment properties
- */
+/* Storage alignment properties */
+
 #define  _AUPBND                (sizeof (acpi_native_int) - 1)
 #define  _ADNBND                (sizeof (acpi_native_int) - 1)
 
-/*
- * Variable argument list macro definitions
- */
+/* Variable argument list macro definitions */
+
 #define _bnd(X, bnd)            (((sizeof (X)) + (bnd)) & (~(bnd)))
 #define va_arg(ap, T)           (*(T *)(((ap) += (_bnd (T, _AUPBND))) - (_bnd (T,_ADNBND))))
 #define va_end(ap)              (void) 0
@@ -305,6 +335,8 @@ typedef char *va_list;
 
 #endif				/* va_arg */
 
+/* Use the local (ACPICA) definitions of the clib functions */
+
 #define ACPI_STRSTR(s1,s2)      acpi_ut_strstr ((s1), (s2))
 #define ACPI_STRCHR(s1,c)       acpi_ut_strchr ((s1), (c))
 #define ACPI_STRLEN(s)          (acpi_size) acpi_ut_strlen ((s))
-- 
1.7.10

