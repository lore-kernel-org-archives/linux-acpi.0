From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/14] ACPI 2.0 / AML: Add TermList parsing support for table loading
Date: Sat,  6 Feb 2016 11:54:17 +0800
Message-ID: <90a49b1aa366ff1a847815ec3fe24bbd45e11a36.1454730660.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

It is proven that not only If/Else/While opcodes, all opcodes can be
executed at the module level, including operation region accesses.  BIOSen
developers are responsible to protect operation region accesses when the
operation region drivers are not loaded by the OSPMs (their availabilities
are indicated via _REG(CONNECT)).
So in fact, all spec allowed early operation region accesses should be
possible at the module level. This includes default operation regions
(SystemMemory, SystemIo, PciConfig) and early operation regions
(EmbeddedControl reported via ECDT).

And the above facts indeed reflect the spec words around ACPI definition
block tables (DSDT/SSDT/...), the table is defined by the AML specification
in BNF style as AMLCode:
  AMLCode := DefBlockHeader TermList
Where DefBlockHeader is the header of the DSDT/SSDT table. So table loading
should be no difference than the control method evaluations as the body of
the control method is also defined by the AML specification as TermList:
  DefMethod := MethodOp PkgLength NameString MethodFlags TermList
The only difference is: after evaluating control method, created named
objects can be freed due to no reference, while named objects created by
loading the table should only be freed after the table is unloaded.

So this patch follows the spec and the de-facto standard behavior, enables
TermList evaluations when the table is loaded. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    3 +
 drivers/acpi/acpica/acparser.h |    2 +
 drivers/acpi/acpica/exconfig.c |    7 +-
 drivers/acpi/acpica/nsload.c   |    3 +-
 drivers/acpi/acpica/nsparse.c  |  163 ++++++++++++++++++++++++++++++++--------
 drivers/acpi/acpica/psparse.c  |    4 +-
 drivers/acpi/acpica/psxface.c  |   73 ++++++++++++++++++
 drivers/acpi/acpica/tbxfload.c |    3 +-
 drivers/acpi/acpica/utxfinit.c |    6 +-
 include/acpi/acpixf.h          |    7 ++
 10 files changed, 233 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 022d69c..28398b0 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -130,6 +130,9 @@ acpi_status
 acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node);
 
 acpi_status
+acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start_node);
+
+acpi_status
 acpi_ns_one_complete_parse(u32 pass_number,
 			   u32 table_index,
 			   struct acpi_namespace_node *start_node);
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 7da639d..ec396e4 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -78,6 +78,8 @@ extern const u8 acpi_gbl_long_op_index[];
  */
 acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info);
 
+acpi_status acpi_ps_execute_table(struct acpi_evaluate_info *info);
+
 /*
  * psargs - Parse AML opcode arguments
  */
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 011df21..1af9e4c 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -108,8 +108,10 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Add the table to the namespace */
 
+	acpi_ex_exit_interpreter();
 	status = acpi_ns_load_table(table_index, parent_node);
 	if (ACPI_FAILURE(status)) {
+		acpi_ex_enter_interpreter();
 		acpi_ut_remove_reference(obj_desc);
 		*ddb_handle = NULL;
 		return_ACPI_STATUS(status);
@@ -117,8 +119,9 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Execute any module-level code that was found in the table */
 
-	acpi_ex_exit_interpreter();
-	acpi_ns_exec_module_code_list();
+	if (acpi_gbl_parse_table_as_term_list) {
+		acpi_ns_exec_module_code_list();
+	}
 	acpi_ex_enter_interpreter();
 
 	/*
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 75cdb87..f2b19bb 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -162,7 +162,8 @@ unlock:
 	 * other ACPI implementations. Optionally, the execution can be deferred
 	 * until later, see acpi_initialize_objects.
 	 */
-	if (!acpi_gbl_group_module_level_code) {
+	if (!acpi_gbl_parse_table_as_term_list
+	    && !acpi_gbl_group_module_level_code) {
 		acpi_ns_exec_module_code_list();
 	}
 
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index f631a47..557e590 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -47,12 +47,103 @@
 #include "acparser.h"
 #include "acdispat.h"
 #include "actables.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsparse")
 
 /*******************************************************************************
  *
+ * FUNCTION:    ns_execute_table
+ *
+ * PARAMETERS:  table_desc      - An ACPI table descriptor for table to parse
+ *              start_node      - Where to enter the table into the namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Load ACPI/AML table by executing the entire table as a
+ *              term_list.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start_node)
+{
+	acpi_status status;
+	struct acpi_table_header *table;
+	acpi_owner_id owner_id;
+	struct acpi_evaluate_info *info = NULL;
+	u32 aml_length;
+	u8 *aml_start;
+	union acpi_operand_object *method_obj = NULL;
+
+	ACPI_FUNCTION_TRACE(ns_execute_table);
+
+	status = acpi_get_table_by_index(table_index, &table);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Table must consist of at least a complete header */
+
+	if (table->length < sizeof(struct acpi_table_header)) {
+		return_ACPI_STATUS(AE_BAD_HEADER);
+	}
+
+	aml_start = (u8 *)table + sizeof(struct acpi_table_header);
+	aml_length = table->length - sizeof(struct acpi_table_header);
+
+	status = acpi_tb_get_owner_id(table_index, &owner_id);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Create, initialize, and link a new temporary method object */
+
+	method_obj = acpi_ut_create_internal_object(ACPI_TYPE_METHOD);
+	if (!method_obj) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	/* Allocate the evaluation information block */
+
+	info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
+	if (!info) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
+			  "Create table code block: %p\n", method_obj));
+
+	method_obj->method.aml_start = aml_start;
+	method_obj->method.aml_length = aml_length;
+	method_obj->method.owner_id = owner_id;
+	method_obj->method.info_flags = ACPI_METHOD_MODULE_LEVEL;
+
+	info->pass_number = ACPI_IMODE_EXECUTE;
+	info->node = start_node;
+	info->obj_desc = method_obj;
+	info->node_flags = info->node->flags;
+	info->full_pathname = acpi_ns_get_normalized_pathname(info->node, TRUE);
+	if (!info->full_pathname) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	status = acpi_ps_execute_table(info);
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+
+cleanup:
+	acpi_ut_remove_reference(method_obj);
+	ACPI_FREE(info->full_pathname);
+	info->full_pathname = NULL;
+	ACPI_FREE(info);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    ns_one_complete_parse
  *
  * PARAMETERS:  pass_number             - 1 or 2
@@ -63,6 +154,7 @@ ACPI_MODULE_NAME("nsparse")
  * DESCRIPTION: Perform one complete parse of an ACPI/AML table.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_ns_one_complete_parse(u32 pass_number,
 			   u32 table_index,
@@ -170,38 +262,47 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 
 	ACPI_FUNCTION_TRACE(ns_parse_table);
 
-	/*
-	 * AML Parse, pass 1
-	 *
-	 * In this pass, we load most of the namespace. Control methods
-	 * are not parsed until later. A parse tree is not created. Instead,
-	 * each Parser Op subtree is deleted when it is finished. This saves
-	 * a great deal of memory, and allows a small cache of parse objects
-	 * to service the entire parse. The second pass of the parse then
-	 * performs another complete parse of the AML.
-	 */
-	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
-
-	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
-					    table_index, start_node);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	if (acpi_gbl_parse_table_as_term_list) {
+		ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start load pass\n"));
 
-	/*
-	 * AML Parse, pass 2
-	 *
-	 * In this pass, we resolve forward references and other things
-	 * that could not be completed during the first pass.
-	 * Another complete parse of the AML is performed, but the
-	 * overhead of this is compensated for by the fact that the
-	 * parse objects are all cached.
-	 */
-	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 2\n"));
-	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2,
-					    table_index, start_node);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		status = acpi_ns_execute_table(table_index, start_node);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	} else {
+		/*
+		 * AML Parse, pass 1
+		 *
+		 * In this pass, we load most of the namespace. Control methods
+		 * are not parsed until later. A parse tree is not created.
+		 * Instead, each Parser Op subtree is deleted when it is finished.
+		 * This saves a great deal of memory, and allows a small cache of
+		 * parse objects to service the entire parse. The second pass of
+		 * the parse then performs another complete parse of the AML.
+		 */
+		ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
+
+		status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
+						    table_index, start_node);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
+		/*
+		 * AML Parse, pass 2
+		 *
+		 * In this pass, we resolve forward references and other things
+		 * that could not be completed during the first pass.
+		 * Another complete parse of the AML is performed, but the
+		 * overhead of this is compensated for by the fact that the
+		 * parse objects are all cached.
+		 */
+		ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 2\n"));
+		status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2,
+						    table_index, start_node);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
 	}
 
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 8038ed2..7801607 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -571,7 +571,9 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 		 * cleanup to do
 		 */
 		if (((walk_state->parse_flags & ACPI_PARSE_MODE_MASK) ==
-		     ACPI_PARSE_EXECUTE) || (ACPI_FAILURE(status))) {
+		     ACPI_PARSE_EXECUTE &&
+		     !(walk_state->parse_flags & ACPI_PARSE_MODULE_LEVEL)) ||
+		    (ACPI_FAILURE(status))) {
 			acpi_ds_terminate_control_method(walk_state->
 							 method_desc,
 							 walk_state);
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 04b37fc..a41c435 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -252,6 +252,79 @@ cleanup:
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ps_execute_table
+ *
+ * PARAMETERS:  info            - Method info block, contains:
+ *                  node            - Node to where the is entered into the
+ *                                    namespace
+ *                  obj_desc        - Pseudo method object describing the AML
+ *                                    code of the entire table
+ *                  pass_number     - Parse or execute pass
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Execute a table
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ps_execute_table(struct acpi_evaluate_info *info)
+{
+	acpi_status status;
+	union acpi_parse_object *op = NULL;
+	struct acpi_walk_state *walk_state = NULL;
+
+	ACPI_FUNCTION_TRACE(ps_execute_table);
+
+	/* Create and init a Root Node */
+
+	op = acpi_ps_create_scope_op(info->obj_desc->method.aml_start);
+	if (!op) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	/* Create and initialize a new walk state */
+
+	walk_state =
+	    acpi_ds_create_walk_state(info->obj_desc->method.owner_id, NULL,
+				      NULL, NULL);
+	if (!walk_state) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	status = acpi_ds_init_aml_walk(walk_state, op, info->node,
+				       info->obj_desc->method.aml_start,
+				       info->obj_desc->method.aml_length, info,
+				       info->pass_number);
+	if (ACPI_FAILURE(status)) {
+		goto cleanup;
+	}
+
+	if (info->obj_desc->method.info_flags & ACPI_METHOD_MODULE_LEVEL) {
+		walk_state->parse_flags |= ACPI_PARSE_MODULE_LEVEL;
+	}
+
+	/*
+	 * Parse the AML, walk_state will be deleted by parse_aml
+	 */
+	acpi_ex_enter_interpreter();
+	status = acpi_ps_parse_aml(walk_state);
+	walk_state = NULL;
+	acpi_ex_exit_interpreter();
+
+cleanup:
+	if (op) {
+		acpi_ps_delete_parse_tree(op);
+	}
+	if (walk_state) {
+		acpi_ds_delete_walk_state(walk_state);
+	}
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ps_update_parameter_list
  *
  * PARAMETERS:  info            - See struct acpi_evaluate_info
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 12068ba..abeaf9e 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -81,7 +81,8 @@ acpi_status __init acpi_load_tables(void)
 	 * between acpi_initialize_subsystem() and acpi_load_tables() to use
 	 * their customized default region handlers.
 	 */
-	if (!acpi_gbl_group_module_level_code) {
+	if (acpi_gbl_parse_table_as_term_list
+	    || !acpi_gbl_group_module_level_code) {
 		status = acpi_ev_install_region_handlers();
 		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
 			ACPI_EXCEPTION((AE_INFO, status,
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 139f65f..f0d0c79 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -163,7 +163,8 @@ acpi_status __init acpi_enable_subsystem(u32 flags)
 	 * installed before any AML code can be executed, especially any
 	 * module-level code (11/2015).
 	 */
-	if (acpi_gbl_group_module_level_code) {
+	if (!acpi_gbl_parse_table_as_term_list
+	    && acpi_gbl_group_module_level_code) {
 		status = acpi_ev_install_region_handlers();
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
@@ -282,7 +283,8 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 	 * all of the tables have been loaded. It is a legacy option and is
 	 * not compatible with other ACPI implementations. See acpi_ns_load_table.
 	 */
-	if (acpi_gbl_group_module_level_code) {
+	if (!acpi_gbl_parse_table_as_term_list
+	    && acpi_gbl_group_module_level_code) {
 		acpi_ns_exec_module_code_list();
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index a98455c..19c98a3 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -195,6 +195,13 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, FALSE);
 
 /*
+ * Optionally support module level code by parsing the entire table as
+ * a term_list.
+ * For disassembler, this should be FALSE.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_parse_table_as_term_list, FALSE);
+
+/*
  * Optionally use 32-bit FADT addresses if and when there is a conflict
  * (address mismatch) between the 32-bit and 64-bit versions of the
  * address. Although ACPICA adheres to the ACPI specification which
-- 
1.7.10
