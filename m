From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/14] ACPICA: Namespace: Fix dynamic table loading issues by tuning namespace/interpreter locks
Date: Wed,  7 Sep 2016 14:07:10 +0800
Message-ID: <4932e788cbd7e0c58deef88cdfc8b5ba72f07f80.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:8329 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754424AbcIGGHP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:07:15 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 767ee53354e0c4b7e8e7c57c6dd7bf569f0d52bb

There are issues related to the namespace/interpreter locks, which causes
several ACPI functionalities not specification compliant. The lock issues
were detectec when we were trying to fix the functionalities (please see
Link # [1] for the details).

What's the lock issues? Let's first look into the namespace/interpreter
lock usages inside of the object evaluation and the table loading which are
the key AML interpretion code paths:
Table loading:
acpi_ns_load_table
	L(Namespace)
	acpi_ns_parse_table
		acpi_ns_one_complete_parse(LOAD_PASS1/LOAD_PASS2)
			acpi_ds_load1_begion_op
			acpi_ds_load1_end_op
			acpi_ds_load2_begion_op
			acpi_ds_load2_end_op
	U(Namespace)
Object evaluation:
acpi_ns_evaluate
	L(Interpreter)
	acpi_ps_execute_method
		acpi_ds_exec_begin_op
		acpi_ds_exec_end_op
			U(Interpreter)
			acpi_ns_load_table
				L(Namespace)
				U(Namespace)
			acpi_ev_initialize_region
				L(Namespace)
				U(Namespace)
			address_space.Setup
			address_space.Handler
			acpi_os_wait_semaphore
			acpi_os_acquire_mutex
			acpi_os_sleep
			L(Interpreter)
	U(Interpreter)
	L(Interpreter)
	acpi_ex_resolve_node_to_value
	U(Interpreter)
	acpi_ns_check_return_value
Where:
  1. L(Interpreter) means acquire(MTX_INTERPRETER);
  2. U(Interpreter) means release(MTX_INTERPRETER);
  3. L(Namespace) means acquire(MTX_NAMESPACE);
  4. U(Namespace) means release(MTX_NAMESPACE);

We can see that acpi_ns_exec_module_code() (which invokes acpi_ns_evaluate) is
implemented in a deferred way just in order to avoid to reacquire the
namespace lock. This is in fact the root cause of many other ACPICA issues:
1. We now know for sure that the module code should be executed right in
   place by the Windows AML interpreter. So in the current design, if
   the region initializations/accesses or the table loadings (where the
   namespace surely should be locked again) happening during the table
   loading period, dead lock could happen because ACPICA never unlocks the
   namespace during the AML interpretion.
2. ACPICA interpreter just ensures that all static namespace nodes (named
   objects created during the acpi_load_tables()) are created
   (acpi_ns_lookup()) with the correct lock held, but doesn't ensure that
   the named objects created by the control method are created with the
   same correct lock held. It requires the control methods to be executed
   in a serial way after "loading a table", that's why ACPICA requires
   method auto serialization.

This patch fixes these software design issues by extending interpreter
enter/exit APIs to hold both interpreter/namespace locks to ensure the lock
order correctness, so that we can get these code paths:
Table loading:
acpi_ns_load_table
	E(Interpreter)
		acpi_ns_parse_table
			acpi_ns_one_complete_parse
			acpi_ns_execute_table
				X(Interpreter)
				acpi_ns_load_table
				acpi_ev_initialize_region
				address_space.Setup
				address_space.Handler
				acpi_os_wait_semaphore
				acpi_os_acquire_mutex
				acpi_os_sleep
				E(Interpreter)
	X(Interpreter)
Object evaluation:
acpi_ns_evaluate
	E(Interpreter)
	acpi_ps_execute_method
		X(Interpreter)
		acpi_ns_load_table
		acpi_ev_initialize_region
		address_space.Setup
		address_space.Handler
		acpi_os_wait_semaphore
		acpi_os_acquire_mutex
		acpi_os_sleep
		E(Interpreter)
	X(Interpreter)
Where:
  1. E(Interpreter) means acquire(MTX_INTERPRETER, MTX_NAMESPACE);
  2. X(Interpreter) means release(MTX_NAMESPACE, MTX_INTERPRETER);

After this change, we can see:
1. All namespace nodes creations are locked by the namespace lock.
2. All namespace nodes referencing are locked with the same lock.
3. But we also can notice a defact that, all namespace nodes deletions
   could be affected by this change. As a consequence,
   acpi_ns_delete_namespace_subtree() may delete a static namespace node that
   is still referenced by the interpreter (for example, the parser scopes).
Currently, we needn't worry about the last defact because in ACPICA, table
unloading is not fully functioning, its design strictly relies on the fact
that when the namespace deletion happens, either the AML table or the OSPMs
should have been notified and thus either the AML table or the OSPMs
shouldn't reference deletion-related namespace nodes during the namespace
deletion. And this change still works with the above restrictions applied.
While making this a-step-forward helps us to correct the wrong grammar to
pull many things back to the correct rail. And pulling things back to the
correct rail in return makes it possible for us to support fully
functioning table unloading after doing many cleanups.

While this patch is generated, all namespace locks are examined to ensure
that they can meet either of the following pattens:
1. L(Namespace)
   U(Namespace)
2. E(Interpreter)
   X(Interpreter)
3. E(Interpreter)
   X(Interpreter)
   L(Namespace)
   U(Namespace)
   E(Interpreter)
   X(Interpreter)
We ensure this by adding X(Interpreter)/E(Interpreter) or removing
U(Namespace)/L(Namespace) for those currently are executed in the following
order:
   E(Interpreter)
   L(Namespace)
   U(Namespace)
   X(Interpreter)
And adding E(Interpreter)/X(Interpreter) for those currently are executed
in the following order:
   X(Interpreter)
   E(Interpreter)

Originally, the interpreter lock is held for the execution AML opcodes, the
namespace lock is held for the named object creation AML opcodes. Since
they are actually same in MS interpreter (can all be executed during the
table loading), we can combine the 2 locks and tune the locking code better
in this way. Lv Zheng.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=153541 # [1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=121701 # [1]
Link: https://bugs.acpica.org/show_bug.cgi?id=1323
Link: https://github.com/acpica/acpica/commit/767ee533
Reported-and-tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reported-and-tested-by: Greg White <gwhite@kupulau.com>
Reported-and-tested-by: Dutch Guy <lucht_piloot@gmx.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsmethod.c  |    4 ++++
 drivers/acpi/acpica/dswload2.c  |    7 ++-----
 drivers/acpi/acpica/exconfig.c  |   14 ++++++++------
 drivers/acpi/acpica/exoparg1.c  |   18 ++++++++++--------
 drivers/acpi/acpica/extrace.c   |   25 -------------------------
 drivers/acpi/acpica/exutils.c   |    8 ++++++++
 drivers/acpi/acpica/nsload.c    |   27 ++++++++++-----------------
 drivers/acpi/acpica/nsparse.c   |    3 +++
 drivers/acpi/acpica/psxface.c   |    2 ++
 drivers/acpi/acpica/utaddress.c |    8 --------
 10 files changed, 47 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 47c7b52..25b387a 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -757,8 +757,10 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 
 			/* Delete any direct children of (created by) this method */
 
+			(void)acpi_ex_exit_interpreter();
 			acpi_ns_delete_namespace_subtree(walk_state->
 							 method_node);
+			(void)acpi_ex_enter_interpreter();
 
 			/*
 			 * Delete any objects that were created by this method
@@ -769,9 +771,11 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 			 */
 			if (method_desc->method.
 			    info_flags & ACPI_METHOD_MODIFIED_NAMESPACE) {
+				(void)acpi_ex_exit_interpreter();
 				acpi_ns_delete_namespace_by_owner(method_desc->
 								  method.
 								  owner_id);
+				(void)acpi_ex_enter_interpreter();
 				method_desc->method.info_flags &=
 				    ~ACPI_METHOD_MODIFIED_NAMESPACE;
 			}
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 762db3f..028b22a 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -605,16 +605,13 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 				if (ACPI_FAILURE(status)) {
 					return_ACPI_STATUS(status);
 				}
-
-				acpi_ex_exit_interpreter();
 			}
 
+			acpi_ex_exit_interpreter();
 			status =
 			    acpi_ev_initialize_region
 			    (acpi_ns_get_attached_object(node), FALSE);
-			if (walk_state->method_node) {
-				acpi_ex_enter_interpreter();
-			}
+			acpi_ex_enter_interpreter();
 
 			if (ACPI_FAILURE(status)) {
 				/*
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 74dd5ba..578d5c8 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -198,9 +198,10 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 		 * Find the node referenced by the root_path_string. This is the
 		 * location within the namespace where the table will be loaded.
 		 */
-		status =
-		    acpi_ns_get_node(start_node, operand[3]->string.pointer,
-				     ACPI_NS_SEARCH_PARENT, &parent_node);
+		status = acpi_ns_get_node_unlocked(start_node,
+						   operand[3]->string.pointer,
+						   ACPI_NS_SEARCH_PARENT,
+						   &parent_node);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
@@ -220,9 +221,10 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 		/* Find the node referenced by the parameter_path_string */
 
-		status =
-		    acpi_ns_get_node(start_node, operand[4]->string.pointer,
-				     ACPI_NS_SEARCH_PARENT, &parameter_node);
+		status = acpi_ns_get_node_unlocked(start_node,
+						   operand[4]->string.pointer,
+						   ACPI_NS_SEARCH_PARENT,
+						   &parameter_node);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 6ae19cb..0073004 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -891,14 +891,16 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				 *    Field, so we need to resolve the node to a value.
 				 */
 				status =
-				    acpi_ns_get_node(walk_state->scope_info->
-						     scope.node,
-						     operand[0]->string.pointer,
-						     ACPI_NS_SEARCH_PARENT,
-						     ACPI_CAST_INDIRECT_PTR
-						     (struct
-						      acpi_namespace_node,
-						      &return_desc));
+				    acpi_ns_get_node_unlocked(walk_state->
+							      scope_info->scope.
+							      node,
+							      operand[0]->
+							      string.pointer,
+							      ACPI_NS_SEARCH_PARENT,
+							      ACPI_CAST_INDIRECT_PTR
+							      (struct
+							       acpi_namespace_node,
+							       &return_desc));
 				if (ACPI_FAILURE(status)) {
 					goto cleanup;
 				}
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index b52e848..c9ca826 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -201,7 +201,6 @@ acpi_ex_start_trace_method(struct acpi_namespace_node *method_node,
 			   union acpi_operand_object *obj_desc,
 			   struct acpi_walk_state *walk_state)
 {
-	acpi_status status;
 	char *pathname = NULL;
 	u8 enabled = FALSE;
 
@@ -211,11 +210,6 @@ acpi_ex_start_trace_method(struct acpi_namespace_node *method_node,
 		pathname = acpi_ns_get_normalized_pathname(method_node, TRUE);
 	}
 
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		goto exit;
-	}
-
 	enabled = acpi_ex_interpreter_trace_enabled(pathname);
 	if (enabled && !acpi_gbl_trace_method_object) {
 		acpi_gbl_trace_method_object = obj_desc;
@@ -233,9 +227,6 @@ acpi_ex_start_trace_method(struct acpi_namespace_node *method_node,
 		}
 	}
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-
-exit:
 	if (enabled) {
 		ACPI_TRACE_POINT(ACPI_TRACE_AML_METHOD, TRUE,
 				 obj_desc ? obj_desc->method.aml_start : NULL,
@@ -267,7 +258,6 @@ acpi_ex_stop_trace_method(struct acpi_namespace_node *method_node,
 			  union acpi_operand_object *obj_desc,
 			  struct acpi_walk_state *walk_state)
 {
-	acpi_status status;
 	char *pathname = NULL;
 	u8 enabled;
 
@@ -277,26 +267,14 @@ acpi_ex_stop_trace_method(struct acpi_namespace_node *method_node,
 		pathname = acpi_ns_get_normalized_pathname(method_node, TRUE);
 	}
 
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		goto exit_path;
-	}
-
 	enabled = acpi_ex_interpreter_trace_enabled(NULL);
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-
 	if (enabled) {
 		ACPI_TRACE_POINT(ACPI_TRACE_AML_METHOD, FALSE,
 				 obj_desc ? obj_desc->method.aml_start : NULL,
 				 pathname);
 	}
 
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		goto exit_path;
-	}
-
 	/* Check whether the tracer should be stopped */
 
 	if (acpi_gbl_trace_method_object == obj_desc) {
@@ -312,9 +290,6 @@ acpi_ex_stop_trace_method(struct acpi_namespace_node *method_node,
 		acpi_gbl_trace_method_object = NULL;
 	}
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-
-exit_path:
 	if (pathname) {
 		ACPI_FREE(pathname);
 	}
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 425f133..a8b857a 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -94,6 +94,10 @@ void acpi_ex_enter_interpreter(void)
 		ACPI_ERROR((AE_INFO,
 			    "Could not acquire AML Interpreter mutex"));
 	}
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not acquire AML Namespace mutex"));
+	}
 
 	return_VOID;
 }
@@ -127,6 +131,10 @@ void acpi_ex_exit_interpreter(void)
 
 	ACPI_FUNCTION_TRACE(ex_exit_interpreter);
 
+	status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not release AML Namespace mutex"));
+	}
 	status = acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 2daa9a09..334d3c5 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -46,6 +46,7 @@
 #include "acnamesp.h"
 #include "acdispat.h"
 #include "actables.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsload")
@@ -78,20 +79,6 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 
 	ACPI_FUNCTION_TRACE(ns_load_table);
 
-	/*
-	 * Parse the table and load the namespace with all named
-	 * objects found within. Control methods are NOT parsed
-	 * at this time. In fact, the control methods cannot be
-	 * parsed until the entire namespace is loaded, because
-	 * if a control method makes a forward reference (call)
-	 * to another control method, we can't continue parsing
-	 * because we don't know how many arguments to parse next!
-	 */
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* If table already loaded into namespace, just return */
 
 	if (acpi_tb_is_table_loaded(table_index)) {
@@ -107,6 +94,15 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 		goto unlock;
 	}
 
+	/*
+	 * Parse the table and load the namespace with all named
+	 * objects found within. Control methods are NOT parsed
+	 * at this time. In fact, the control methods cannot be
+	 * parsed until the entire namespace is loaded, because
+	 * if a control method makes a forward reference (call)
+	 * to another control method, we can't continue parsing
+	 * because we don't know how many arguments to parse next!
+	 */
 	status = acpi_ns_parse_table(table_index, node);
 	if (ACPI_SUCCESS(status)) {
 		acpi_tb_set_table_loaded_flag(table_index, TRUE);
@@ -120,7 +116,6 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 		 * exist. This target of Scope must already exist in the
 		 * namespace, as per the ACPI specification.
 		 */
-		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 		acpi_ns_delete_namespace_by_owner(acpi_gbl_root_table_list.
 						  tables[table_index].owner_id);
 
@@ -129,8 +124,6 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	}
 
 unlock:
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index e51012b..4f14e92 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -47,6 +47,7 @@
 #include "acparser.h"
 #include "acdispat.h"
 #include "actables.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsparse")
@@ -234,7 +235,9 @@ acpi_ns_one_complete_parse(u32 pass_number,
 
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
 			  "*PARSE* pass %u parse\n", pass_number));
+	acpi_ex_enter_interpreter();
 	status = acpi_ps_parse_aml(walk_state);
+	acpi_ex_exit_interpreter();
 
 cleanup:
 	acpi_ps_delete_parse_tree(parse_root);
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 22a52c28..8d7e5b5 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -308,7 +308,9 @@ acpi_status acpi_ps_execute_table(struct acpi_evaluate_info *info)
 	/*
 	 * Parse the AML, walk_state will be deleted by parse_aml
 	 */
+	acpi_ex_enter_interpreter();
 	status = acpi_ps_parse_aml(walk_state);
+	acpi_ex_exit_interpreter();
 	walk_state = NULL;
 
 cleanup:
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index c986ec6..433d822 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -77,7 +77,6 @@ acpi_ut_add_address_range(acpi_adr_space_type space_id,
 			  u32 length, struct acpi_namespace_node *region_node)
 {
 	struct acpi_address_range *range_info;
-	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ut_add_address_range);
 
@@ -97,12 +96,6 @@ acpi_ut_add_address_range(acpi_adr_space_type space_id,
 	range_info->end_address = (address + length - 1);
 	range_info->region_node = region_node;
 
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		ACPI_FREE(range_info);
-		return_ACPI_STATUS(status);
-	}
-
 	range_info->next = acpi_gbl_address_range_list[space_id];
 	acpi_gbl_address_range_list[space_id] = range_info;
 
@@ -112,7 +105,6 @@ acpi_ut_add_address_range(acpi_adr_space_type space_id,
 			  ACPI_FORMAT_UINT64(address),
 			  ACPI_FORMAT_UINT64(range_info->end_address)));
 
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(AE_OK);
 }
 
-- 
1.7.10

