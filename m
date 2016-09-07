From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/14] ACPICA: Interpreter: Fix MLC issues by switching to new term_list grammar for table loading
Date: Wed,  7 Sep 2016 14:06:54 +0800
Message-ID: <b8d757e2cb1a17dc539aafdf16263dd317fb9980.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22216 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751936AbcIGGHA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:07:00 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 0e24fb67cde08d7df7671d7d7b183490dc79707e

The MLC (Module Level Code) is an ACPICA terminology describing the AML
code out of any control method, its support is an indication of the
interpreter behavior during the table loading.

The original implementation of MLC in ACPICA had several issues:
1. Out of any control method, besides of the object creating opcodes, only
   the code blocks wrapped by "If/Else/While" opcodes were supported.
2. The supported MLC code blocks were executed after loading the table
   rather than being executed right in place.
   ============================================================
   The demo of this order issue is as follows:
     Name (OBJ1, 1)
     If (CND1 == 1)
     {
       Name (OBJ2, 2)
     }
     Name (OBJ3, 3)
   The original MLC support created OBJ2 after OBJ3's creation.
   ============================================================
Other than these limitations, MLC support in ACPICA looks correct. And
supporting this should be easy/natural for ACPICA, but enabling of this was
blocked by some ACPICA internal and OSPM specific initialization order
issues we've fixed recently. The wrong support started from the following
false bug fixing commit:
  Commit: 7f0c826a437157d2b19662977e9cf3b472cf24a6
  Subject: ACPICA: Add support for module-level executable AML code
  Commit: 9a884ab64a4d092b4c3bf24fd9a30f7fbd4591e7
  Subject: ACPICA: Add additional module-level code support
  ...

We can confirm Windows interpreter behavior via reverse engineering means.
It can be proven that not only If/Else/While wrapped code blocks, all
opcodes can be executed at the module level, including operation region
accesses. And it can be proven that the MLC should be executed right in
place, not in such a deferred way executed after loading the table.

And the above facts indeed reflect the spec words around ACPI definition
block tables (DSDT/SSDT/...), the entire table and the Scope object is
defined by the AML specification in BNF style as:
  AMLCode := def_block_header term_list
  def_scope := scope_op pkg_length name_string term_list
The bodies of the scope opening terms (AMLCode/Scope) are all term_list,
thus the table loading should be no difference than the control method
evaluations as the body of the Method is also defined by the AML
specification as term_list:
  def_method := method_op pkg_length name_string method_flags term_list
The only difference is: after evaluating control method, created named
objects may be freed due to no reference, while named objects created by
the table loading should only be freed after unloading the table.

So this patch follows the spec and the de-facto standard behavior, enables
the new grammar (term_list) for the table loading.

By doing so, beyond the fixes to the above issues, we can see additional
differences comparing to the old grammar based table loading:
1. Originally, beyond the scope opening terms (AMLCode/Scope),
   If/Else/While wrapped code blocks under the scope creating terms
   (Device/power_resource/Processor/thermal_zone) are also supported as
   deferred MLC, which violates the spec defined grammar where object_list
   is enforced. With MLC support improved as non-deferred, the interpreter
   parses such scope creating terms as term_list rather object_list like the
   scope opening terms.
   After probing the Windows behavior and proving that it also parses these
   terms as term_list, we submitted an ECR (Engineering Change Request) to
   the ASWG (ACPI Specification Working Group) to clarify this. The ECR is
   titled as "ASL Grammar Clarification for Executable AML Opcodes" and has
   been accepted by the ASWG. The new grammar will appear in ACPI
   specification 6.2.
2. Originally, Buffer/Package/operation_region/create_XXXField/bank_field
   arguments are evaluated in a deferred way after loading the table. With
   MLC support improved, they are also parsed right in place during the
   table loading.
   This is also Windows compliant and the only difference is the removal
   of the debugging messages implemented before acpi_ds_execute_arguments(),
   see Link # [1] for the details. A previous commit should have ensured
   that acpi_check_address_range() won't regress.

Note that enabling this feature may cause regressions due to long term
Linux ACPI support on top of the wrong grammar. So this patch also prepares
a global option to be used to roll back to the old grammar during the
period between a regression is reported and the regression is
root-cause-fixed. Lv Zheng.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=112911 # [1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=117671 # [1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=153541 # [1]
Link: https://github.com/acpica/acpica/issues/122
Link: https://bugs.acpica.org/show_bug.cgi?id=963
Link: https://github.com/acpica/acpica/commit/0e24fb67
Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Reported-by: Ehsan <dashesy@gmail.com>
Reported-and-tested-by: Dutch Guy <lucht_piloot@gmx.net>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    3 +
 drivers/acpi/acpica/acparser.h |    2 +
 drivers/acpi/acpica/evrgnini.c |    3 +-
 drivers/acpi/acpica/exconfig.c |    3 +-
 drivers/acpi/acpica/nsload.c   |    3 +-
 drivers/acpi/acpica/nsparse.c  |  162 ++++++++++++++++++++++++++++++++--------
 drivers/acpi/acpica/psparse.c  |    4 +-
 drivers/acpi/acpica/psxface.c  |   71 ++++++++++++++++++
 drivers/acpi/acpica/tbxfload.c |    3 +-
 drivers/acpi/acpica/utxfinit.c |    3 +-
 include/acpi/acpixf.h          |    7 ++
 11 files changed, 227 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index f33a4ba..829672a 100644
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
index fc30577..939d411 100644
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
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index b6ea9c0..3843f1f 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -553,7 +553,8 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 				 *
 				 * See acpi_ns_exec_module_code
 				 */
-				if (obj_desc->method.
+				if (!acpi_gbl_parse_table_as_term_list &&
+				    obj_desc->method.
 				    info_flags & ACPI_METHOD_MODULE_LEVEL) {
 					handler_obj =
 					    obj_desc->method.dispatch.handler;
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index a1d177d..74dd5ba 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -118,7 +118,8 @@ acpi_ex_add_table(u32 table_index,
 	/* Execute any module-level code that was found in the table */
 
 	acpi_ex_exit_interpreter();
-	if (acpi_gbl_group_module_level_code) {
+	if (!acpi_gbl_parse_table_as_term_list
+	    && acpi_gbl_group_module_level_code) {
 		acpi_ns_exec_module_code_list();
 	}
 	acpi_ex_enter_interpreter();
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index b5e2b0a..2daa9a09 100644
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
index f631a47..e51012b 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -53,6 +53,96 @@ ACPI_MODULE_NAME("nsparse")
 
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
+	method_obj->method.info_flags |= ACPI_METHOD_MODULE_LEVEL;
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
+	status = acpi_ps_execute_table(info);
+
+cleanup:
+	if (info) {
+		ACPI_FREE(info->full_pathname);
+		info->full_pathname = NULL;
+	}
+	ACPI_FREE(info);
+	acpi_ut_remove_reference(method_obj);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    ns_one_complete_parse
  *
  * PARAMETERS:  pass_number             - 1 or 2
@@ -63,6 +153,7 @@ ACPI_MODULE_NAME("nsparse")
  * DESCRIPTION: Perform one complete parse of an ACPI/AML table.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_ns_one_complete_parse(u32 pass_number,
 			   u32 table_index,
@@ -170,38 +261,47 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 
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
index 0a23897..3aa9162 100644
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
index cf30cd82..22a52c28 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -252,6 +252,77 @@ cleanup:
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ps_execute_table
+ *
+ * PARAMETERS:  info            - Method info block, contains:
+ *              node            - Node to where the is entered into the
+ *                                namespace
+ *              obj_desc        - Pseudo method object describing the AML
+ *                                code of the entire table
+ *              pass_number     - Parse or execute pass
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
+	status = acpi_ps_parse_aml(walk_state);
+	walk_state = NULL;
+
+cleanup:
+	if (walk_state) {
+		acpi_ds_delete_walk_state(walk_state);
+	}
+	if (op) {
+		acpi_ps_delete_parse_tree(op);
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
index e0cc919..6088712 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -103,7 +103,8 @@ acpi_status ACPI_INIT_FUNCTION acpi_load_tables(void)
 				"While loading namespace from ACPI tables"));
 	}
 
-	if (!acpi_gbl_group_module_level_code) {
+	if (acpi_gbl_parse_table_as_term_list
+	    || !acpi_gbl_group_module_level_code) {
 		/*
 		 * Initialize the objects that remain uninitialized. This
 		 * runs the executable AML that may be part of the
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index d6d9462..a5ca0f5 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -265,7 +265,8 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_objects(u32 flags)
 	 * all of the tables have been loaded. It is a legacy option and is
 	 * not compatible with other ACPI implementations. See acpi_ns_load_table.
 	 */
-	if (acpi_gbl_group_module_level_code) {
+	if (!acpi_gbl_parse_table_as_term_list
+	    && acpi_gbl_group_module_level_code) {
 		acpi_ns_exec_module_code_list();
 
 		/*
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 8b44717..cf78ec2 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -195,6 +195,13 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, TRUE);
 
 /*
+ * Optionally support module level code by parsing the entire table as
+ * a term_list. Default is FALSE, do not execute entire table until some
+ * lock order issues are fixed.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_parse_table_as_term_list, FALSE);
+
+/*
  * Optionally use 32-bit FADT addresses if and when there is a conflict
  * (address mismatch) between the 32-bit and 64-bit versions of the
  * address. Although ACPICA adheres to the ACPI specification which
-- 
1.7.10

