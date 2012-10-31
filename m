From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/26] ACPICA: Remove extra spaces after periods within comments
Date: Wed, 31 Oct 2012 10:26:55 +0800
Message-ID: <19e5c58b5dd90ed7cd65bcc9f50589fdf9c231a7.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33465 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875Ab2JaC1E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:27:04 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

This makes all comments consistent.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h  |    2 +-
 drivers/acpi/acpica/aclocal.h   |    4 ++--
 drivers/acpi/acpica/acobject.h  |    4 ++--
 drivers/acpi/acpica/acopcode.h  |    6 +++---
 drivers/acpi/acpica/acstruct.h  |    2 +-
 drivers/acpi/acpica/dscontrol.c |    2 +-
 drivers/acpi/acpica/dsfield.c   |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    6 +++---
 drivers/acpi/acpica/dsmthdat.c  |   14 +++++++-------
 drivers/acpi/acpica/dsobject.c  |    6 +++---
 drivers/acpi/acpica/dsutils.c   |   30 +++++++++++++++---------------
 drivers/acpi/acpica/dswexec.c   |    8 ++++----
 drivers/acpi/acpica/dswstate.c  |    8 ++++----
 drivers/acpi/acpica/excreate.c  |    6 +++---
 drivers/acpi/acpica/exdump.c    |    2 +-
 drivers/acpi/acpica/exfield.c   |    4 ++--
 drivers/acpi/acpica/exfldio.c   |   12 ++++++------
 drivers/acpi/acpica/exmisc.c    |    4 ++--
 drivers/acpi/acpica/exnames.c   |    2 +-
 drivers/acpi/acpica/exoparg1.c  |   10 +++++-----
 drivers/acpi/acpica/exoparg2.c  |    2 +-
 drivers/acpi/acpica/exoparg3.c  |    2 +-
 drivers/acpi/acpica/exoparg6.c  |    2 +-
 drivers/acpi/acpica/exprep.c    |   12 ++++++------
 drivers/acpi/acpica/exregion.c  |    2 +-
 drivers/acpi/acpica/exresnte.c  |    8 ++++----
 drivers/acpi/acpica/exresolv.c  |    2 +-
 drivers/acpi/acpica/exresop.c   |    4 ++--
 drivers/acpi/acpica/exstore.c   |    4 ++--
 drivers/acpi/acpica/exstoren.c  |   10 +++++-----
 drivers/acpi/acpica/exstorob.c  |    4 ++--
 drivers/acpi/acpica/exsystem.c  |    8 ++++----
 drivers/acpi/acpica/exutils.c   |    4 ++--
 drivers/acpi/acpica/hwacpi.c    |    2 +-
 drivers/acpi/acpica/hwtimer.c   |    2 +-
 drivers/acpi/acpica/nsalloc.c   |    4 ++--
 drivers/acpi/acpica/nsdump.c    |    2 +-
 drivers/acpi/acpica/nsload.c    |   10 +++++-----
 drivers/acpi/acpica/nsobject.c  |    8 ++++----
 drivers/acpi/acpica/nsparse.c   |    8 ++++----
 drivers/acpi/acpica/nsutils.c   |    6 +++---
 drivers/acpi/acpica/nswalk.c    |   10 +++++-----
 drivers/acpi/acpica/nsxfeval.c  |   14 +++++++-------
 drivers/acpi/acpica/nsxfname.c  |    6 +++---
 drivers/acpi/acpica/nsxfobj.c   |    4 ++--
 drivers/acpi/acpica/psargs.c    |    8 ++++----
 drivers/acpi/acpica/psopcode.c  |    6 +++---
 drivers/acpi/acpica/psparse.c   |    8 ++++----
 drivers/acpi/acpica/psutils.c   |    4 ++--
 drivers/acpi/acpica/rscalc.c    |    2 +-
 drivers/acpi/acpica/tbxfroot.c  |    2 +-
 drivers/acpi/acpica/utcache.c   |    6 +++---
 drivers/acpi/acpica/utdebug.c   |   18 +++++++++---------
 drivers/acpi/acpica/utmath.c    |    2 +-
 drivers/acpi/acpica/utmisc.c    |   14 +++++++-------
 drivers/acpi/acpica/utmutex.c   |   12 ++++++------
 drivers/acpi/acpica/utobject.c  |    8 ++++----
 drivers/acpi/acpica/utstate.c   |    2 +-
 drivers/acpi/acpica/uttrack.c   |    6 +++---
 drivers/acpi/acpica/utxface.c   |    2 +-
 include/acpi/acexcep.h          |    2 +-
 61 files changed, 188 insertions(+), 188 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 35006d1..64472e4 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -70,7 +70,7 @@
 
 /*
  * Enable "slack" in the AML interpreter?  Default is FALSE, and the
- * interpreter strictly follows the ACPI specification.  Setting to TRUE
+ * interpreter strictly follows the ACPI specification. Setting to TRUE
  * allows the interpreter to ignore certain errors and/or bad AML constructs.
  *
  * Currently, these features are enabled by this flag:
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 5b5be40..ff8bd00 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -265,7 +265,7 @@ typedef
 acpi_status(*acpi_internal_method) (struct acpi_walk_state * walk_state);
 
 /*
- * Bitmapped ACPI types.  Used internally only
+ * Bitmapped ACPI types. Used internally only
  */
 #define ACPI_BTYPE_ANY                  0x00000000
 #define ACPI_BTYPE_INTEGER              0x00000001
@@ -584,7 +584,7 @@ struct acpi_pscope_state {
 };
 
 /*
- * Thread state - one per thread across multiple walk states.  Multiple walk
+ * Thread state - one per thread across multiple walk states. Multiple walk
  * states are created when there are nested control methods executing.
  */
 struct acpi_thread_state {
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index b83e46a..24eb9ea 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -197,7 +197,7 @@ struct acpi_object_method {
 
 /******************************************************************************
  *
- * Objects that can be notified.  All share a common notify_info area.
+ * Objects that can be notified. All share a common notify_info area.
  *
  *****************************************************************************/
 
@@ -234,7 +234,7 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 
 /******************************************************************************
  *
- * Fields.  All share a common header/info field.
+ * Fields. All share a common header/info field.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index 9440d05..d786a51 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -54,7 +54,7 @@
 #define _UNK                        0x6B
 
 /*
- * Reserved ASCII characters.  Do not use any of these for
+ * Reserved ASCII characters. Do not use any of these for
  * internal opcodes, since they are used to differentiate
  * name strings from AML opcodes
  */
@@ -63,7 +63,7 @@
 #define _PFX                        0x6D
 
 /*
- * All AML opcodes and the parse-time arguments for each.  Used by the AML
+ * All AML opcodes and the parse-time arguments for each. Used by the AML
  * parser  Each list is compressed into a 32-bit number and stored in the
  * master opcode table (in psopcode.c).
  */
@@ -193,7 +193,7 @@
 #define ARGP_ZERO_OP                    ARG_NONE
 
 /*
- * All AML opcodes and the runtime arguments for each.  Used by the AML
+ * All AML opcodes and the runtime arguments for each. Used by the AML
  * interpreter  Each list is compressed into a 32-bit number and stored
  * in the master opcode table (in psopcode.c).
  *
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index f196e2c..937e66c 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -53,7 +53,7 @@
  ****************************************************************************/
 
 /*
- * Walk state - current state of a parse tree walk.  Used for both a leisurely
+ * Walk state - current state of a parse tree walk. Used for both a leisurely
  * stroll through the tree (for whatever reason), and for control method
  * execution.
  */
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 465f021..57895db 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -280,7 +280,7 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 			/*
 			 * Get the return value and save as the last result
-			 * value.  This is the only place where walk_state->return_desc
+			 * value. This is the only place where walk_state->return_desc
 			 * is set to anything other than zero!
 			 */
 			walk_state->return_desc = walk_state->operands[0];
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 3da6fd8..b5b904e 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -277,7 +277,7 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Process all named fields in a field declaration.  Names are
+ * DESCRIPTION: Process all named fields in a field declaration. Names are
  *              entered into the namespace.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index aa9a5d4..52eb4e0 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -170,7 +170,7 @@ acpi_ds_create_method_mutex(union acpi_operand_object *method_desc)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Prepare a method for execution.  Parses the method if necessary,
+ * DESCRIPTION: Prepare a method for execution. Parses the method if necessary,
  *              increments the thread count, and waits at the method semaphore
  *              for clearance to execute.
  *
@@ -444,7 +444,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
  * RETURN:      Status
  *
  * DESCRIPTION: Restart a method that was preempted by another (nested) method
- *              invocation.  Handle the return value (if any) from the callee.
+ *              invocation. Handle the return value (if any) from the callee.
  *
  ******************************************************************************/
 
@@ -530,7 +530,7 @@ acpi_ds_restart_control_method(struct acpi_walk_state *walk_state,
  *
  * RETURN:      None
  *
- * DESCRIPTION: Terminate a control method.  Delete everything that the method
+ * DESCRIPTION: Terminate a control method. Delete everything that the method
  *              created, delete all locals and arguments, and delete the parse
  *              tree if requested.
  *
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 8d55ceb..9a83b7e 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -76,7 +76,7 @@ acpi_ds_method_data_get_type(u16 opcode,
  * RETURN:      Status
  *
  * DESCRIPTION: Initialize the data structures that hold the method's arguments
- *              and locals.  The data struct is an array of namespace nodes for
+ *              and locals. The data struct is an array of namespace nodes for
  *              each - this allows ref_of and de_ref_of to work properly for these
  *              special data types.
  *
@@ -129,7 +129,7 @@ void acpi_ds_method_data_init(struct acpi_walk_state *walk_state)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Delete method locals and arguments.  Arguments are only
+ * DESCRIPTION: Delete method locals and arguments. Arguments are only
  *              deleted if this method was called from another method.
  *
  ******************************************************************************/
@@ -183,7 +183,7 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Initialize arguments for a method.  The parameter list is a list
+ * DESCRIPTION: Initialize arguments for a method. The parameter list is a list
  *              of ACPI operand objects, either null terminated or whose length
  *              is defined by max_param_count.
  *
@@ -401,7 +401,7 @@ acpi_ds_method_data_get_value(u8 type,
 		 * This means that either 1) The expected argument was
 		 * not passed to the method, or 2) A local variable
 		 * was referenced by the method (via the ASL)
-		 * before it was initialized.  Either case is an error.
+		 * before it was initialized. Either case is an error.
 		 */
 
 		/* If slack enabled, init the local_x/arg_x to an Integer of value zero */
@@ -465,7 +465,7 @@ acpi_ds_method_data_get_value(u8 type,
  *
  * RETURN:      None
  *
- * DESCRIPTION: Delete the entry at Opcode:Index.  Inserts
+ * DESCRIPTION: Delete the entry at Opcode:Index. Inserts
  *              a null into the stack slot after the object is deleted.
  *
  ******************************************************************************/
@@ -523,7 +523,7 @@ acpi_ds_method_data_delete_value(u8 type,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Store a value in an Arg or Local.  The obj_desc is installed
+ * DESCRIPTION: Store a value in an Arg or Local. The obj_desc is installed
  *              as the new value for the Arg or Local and the reference count
  *              for obj_desc is incremented.
  *
@@ -566,7 +566,7 @@ acpi_ds_store_object_to_local(u8 type,
 
 	/*
 	 * If the reference count on the object is more than one, we must
-	 * take a copy of the object before we store.  A reference count
+	 * take a copy of the object before we store. A reference count
 	 * of exactly 1 means that the object was just created during the
 	 * evaluation of an expression, and we can safely use it since it
 	 * is not used anywhere else.
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 68592dd..c9f15d3 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -293,7 +293,7 @@ acpi_ds_build_internal_buffer_obj(struct acpi_walk_state *walk_state,
 
 	/*
 	 * Second arg is the buffer data (optional) byte_list can be either
-	 * individual bytes or a string initializer.  In either case, a
+	 * individual bytes or a string initializer. In either case, a
 	 * byte_list appears in the AML.
 	 */
 	arg = op->common.value.arg;	/* skip first arg */
@@ -568,7 +568,7 @@ acpi_ds_create_node(struct acpi_walk_state *walk_state,
 
 	/*
 	 * Because of the execution pass through the non-control-method
-	 * parts of the table, we can arrive here twice.  Only init
+	 * parts of the table, we can arrive here twice. Only init
 	 * the named object node the first time through
 	 */
 	if (acpi_ns_get_attached_object(node)) {
@@ -618,7 +618,7 @@ acpi_ds_create_node(struct acpi_walk_state *walk_state,
  * RETURN:      Status
  *
  * DESCRIPTION: Initialize a namespace object from a parser Op and its
- *              associated arguments.  The namespace object is a more compact
+ *              associated arguments. The namespace object is a more compact
  *              representation of the Op and its arguments.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 4bbdd6c..afeb99f 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("dsutils")
  *
  * RETURN:      None.
  *
- * DESCRIPTION: Clear and remove a reference on an implicit return value.  Used
+ * DESCRIPTION: Clear and remove a reference on an implicit return value. Used
  *              to delete "stale" return values (if enabled, the return value
  *              from every operator is saved at least momentarily, in case the
  *              parent method exits.)
@@ -107,7 +107,7 @@ void acpi_ds_clear_implicit_return(struct acpi_walk_state *walk_state)
  *
  * DESCRIPTION: Implements the optional "implicit return".  We save the result
  *              of every ASL operator and control method invocation in case the
- *              parent method exit.  Before storing a new return value, we
+ *              parent method exit. Before storing a new return value, we
  *              delete the previous return value.
  *
  ******************************************************************************/
@@ -198,7 +198,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 	 *
 	 * If there is no parent, or the parent is a scope_op, we are executing
 	 * at the method level. An executing method typically has no parent,
-	 * since each method is parsed separately.  A method invoked externally
+	 * since each method is parsed separately. A method invoked externally
 	 * via execute_control_method has a scope_op as the parent.
 	 */
 	if ((!op->common.parent) ||
@@ -223,7 +223,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 	}
 
 	/*
-	 * Decide what to do with the result based on the parent.  If
+	 * Decide what to do with the result based on the parent. If
 	 * the parent opcode will not use the result, delete the object.
 	 * Otherwise leave it as is, it will be deleted when it is used
 	 * as an operand later.
@@ -266,7 +266,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 
 		/*
 		 * These opcodes allow term_arg(s) as operands and therefore
-		 * the operands can be method calls.  The result is used.
+		 * the operands can be method calls. The result is used.
 		 */
 		goto result_used;
 
@@ -284,7 +284,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 			AML_BANK_FIELD_OP)) {
 			/*
 			 * These opcodes allow term_arg(s) as operands and therefore
-			 * the operands can be method calls.  The result is used.
+			 * the operands can be method calls. The result is used.
 			 */
 			goto result_used;
 		}
@@ -329,9 +329,9 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Used after interpretation of an opcode.  If there is an internal
+ * DESCRIPTION: Used after interpretation of an opcode. If there is an internal
  *              result descriptor, check if the parent opcode will actually use
- *              this result.  If not, delete the result now so that it will
+ *              this result. If not, delete the result now so that it will
  *              not become orphaned.
  *
  ******************************************************************************/
@@ -376,7 +376,7 @@ acpi_ds_delete_result_if_not_used(union acpi_parse_object *op,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Resolve all operands to their values.  Used to prepare
+ * DESCRIPTION: Resolve all operands to their values. Used to prepare
  *              arguments to a control method invocation (a call from one
  *              method to another.)
  *
@@ -391,7 +391,7 @@ acpi_status acpi_ds_resolve_operands(struct acpi_walk_state *walk_state)
 
 	/*
 	 * Attempt to resolve each of the valid operands
-	 * Method arguments are passed by reference, not by value.  This means
+	 * Method arguments are passed by reference, not by value. This means
 	 * that the actual objects are passed, not copies of the objects.
 	 */
 	for (i = 0; i < walk_state->num_operands; i++) {
@@ -451,7 +451,7 @@ void acpi_ds_clear_operands(struct acpi_walk_state *walk_state)
  * RETURN:      Status
  *
  * DESCRIPTION: Translate a parse tree object that is an argument to an AML
- *              opcode to the equivalent interpreter object.  This may include
+ *              opcode to the equivalent interpreter object. This may include
  *              looking up a name or entering a new name into the internal
  *              namespace.
  *
@@ -496,9 +496,9 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 		/*
 		 * Special handling for buffer_field declarations. This is a deferred
 		 * opcode that unfortunately defines the field name as the last
-		 * parameter instead of the first.  We get here when we are performing
+		 * parameter instead of the first. We get here when we are performing
 		 * the deferred execution, so the actual name of the field is already
-		 * in the namespace.  We don't want to attempt to look it up again
+		 * in the namespace. We don't want to attempt to look it up again
 		 * because we may be executing in a different scope than where the
 		 * actual opcode exists.
 		 */
@@ -605,8 +605,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 			/*
 			 * If the name is null, this means that this is an
 			 * optional result parameter that was not specified
-			 * in the original ASL.  Create a Zero Constant for a
-			 * placeholder.  (Store to a constant is a Noop.)
+			 * in the original ASL. Create a Zero Constant for a
+			 * placeholder. (Store to a constant is a Noop.)
 			 */
 			opcode = AML_ZERO_OP;	/* Has no arguments! */
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index fa44609..5859393 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -204,7 +204,7 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
  * RETURN:      Status
  *
  * DESCRIPTION: Descending callback used during the execution of control
- *              methods.  This is where most operators and operands are
+ *              methods. This is where most operators and operands are
  *              dispatched to the interpreter.
  *
  ****************************************************************************/
@@ -297,7 +297,7 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
 		if (walk_state->walk_type & ACPI_WALK_METHOD) {
 			/*
 			 * Found a named object declaration during method execution;
-			 * we must enter this object into the namespace.  The created
+			 * we must enter this object into the namespace. The created
 			 * object is temporary and will be deleted upon completion of
 			 * the execution of this method.
 			 *
@@ -348,7 +348,7 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
  * RETURN:      Status
  *
  * DESCRIPTION: Ascending callback used during the execution of control
- *              methods.  The only thing we really need to do here is to
+ *              methods. The only thing we really need to do here is to
  *              notice the beginning of IF, ELSE, and WHILE blocks.
  *
  ****************************************************************************/
@@ -432,7 +432,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 		if (ACPI_SUCCESS(status)) {
 			/*
 			 * Dispatch the request to the appropriate interpreter handler
-			 * routine.  There is one routine per opcode "type" based upon the
+			 * routine. There is one routine per opcode "type" based upon the
 			 * number of opcode arguments and return type.
 			 */
 			status =
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 8e62679..3e65a15 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -348,7 +348,7 @@ acpi_ds_obj_stack_push(void *object, struct acpi_walk_state * walk_state)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Pop this walk's object stack.  Objects on the stack are NOT
+ * DESCRIPTION: Pop this walk's object stack. Objects on the stack are NOT
  *              deleted by this routine.
  *
  ******************************************************************************/
@@ -492,7 +492,7 @@ acpi_ds_push_walk_state(struct acpi_walk_state *walk_state,
  * RETURN:      A walk_state object popped from the thread's stack
  *
  * DESCRIPTION: Remove and return the walkstate object that is at the head of
- *              the walk stack for the given walk list.  NULL indicates that
+ *              the walk stack for the given walk list. NULL indicates that
  *              the list is empty.
  *
  ******************************************************************************/
@@ -532,7 +532,7 @@ struct acpi_walk_state *acpi_ds_pop_walk_state(struct acpi_thread_state *thread)
  *
  * RETURN:      Pointer to the new walk state.
  *
- * DESCRIPTION: Allocate and initialize a new walk state.  The current walk
+ * DESCRIPTION: Allocate and initialize a new walk state. The current walk
  *              state is set to this new state.
  *
  ******************************************************************************/
@@ -657,7 +657,7 @@ acpi_ds_init_aml_walk(struct acpi_walk_state *walk_state,
 		/*
 		 * Setup the current scope.
 		 * Find a Named Op that has a namespace node associated with it.
-		 * search upwards from this Op.  Current scope is the first
+		 * search upwards from this Op. Current scope is the first
 		 * Op with a namespace node.
 		 */
 		extra_op = parser_state->start_op;
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 9f15270..66554bc 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -78,7 +78,7 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	    (target_node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS)) {
 		/*
 		 * Dereference an existing alias so that we don't create a chain
-		 * of aliases.  With this code, we guarantee that an alias is
+		 * of aliases. With this code, we guarantee that an alias is
 		 * always exactly one level of indirection away from the
 		 * actual aliased name.
 		 */
@@ -90,7 +90,7 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 	/*
 	 * For objects that can never change (i.e., the NS node will
 	 * permanently point to the same object), we can simply attach
-	 * the object to the new NS node.  For other objects (such as
+	 * the object to the new NS node. For other objects (such as
 	 * Integers, buffers, etc.), we have to point the Alias node
 	 * to the original Node.
 	 */
@@ -139,7 +139,7 @@ acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 
 		/*
 		 * The new alias assumes the type of the target, and it points
-		 * to the same object.  The reference count of the object has an
+		 * to the same object. The reference count of the object has an
 		 * additional reference to prevent deletion out from under either the
 		 * target node or the alias Node
 		 */
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 40608b3..3157f3b 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -778,7 +778,7 @@ acpi_ex_dump_operands(union acpi_operand_object **operands,
  * PARAMETERS:  title               - Descriptive text
  *              value               - Value to be displayed
  *
- * DESCRIPTION: Object dump output formatting functions.  These functions
+ * DESCRIPTION: Object dump output formatting functions. These functions
  *              reduce the number of format strings required and keeps them
  *              all in one place for easy modification.
  *
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index dc092f5..ebc55fb 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -59,7 +59,7 @@ ACPI_MODULE_NAME("exfield")
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Read from a named field.  Returns either an Integer or a
+ * DESCRIPTION: Read from a named field. Returns either an Integer or a
  *              Buffer, depending on the size of the field.
  *
  ******************************************************************************/
@@ -149,7 +149,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	 * Allocate a buffer for the contents of the field.
 	 *
 	 * If the field is larger than the current integer width, create
-	 * a BUFFER to hold it.  Otherwise, use an INTEGER.  This allows
+	 * a BUFFER to hold it. Otherwise, use an INTEGER. This allows
 	 * the use of arithmetic operators on the returned value if the
 	 * field size is equal or smaller than an Integer.
 	 *
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 419148a..aa2ccfb 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -154,7 +154,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 #endif
 
 	/*
-	 * Validate the request.  The entire request from the byte offset for a
+	 * Validate the request. The entire request from the byte offset for a
 	 * length of one field datum (access width) must fit within the region.
 	 * (Region length is specified in bytes)
 	 */
@@ -182,7 +182,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 		    obj_desc->common_field.access_byte_width) {
 			/*
 			 * This is the case where the access_type (acc_word, etc.) is wider
-			 * than the region itself.  For example, a region of length one
+			 * than the region itself. For example, a region of length one
 			 * byte, and a field with Dword access specified.
 			 */
 			ACPI_ERROR((AE_INFO,
@@ -320,7 +320,7 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
  *
  * DESCRIPTION: Check if a value is out of range of the field being written.
  *              Used to check if the values written to Index and Bank registers
- *              are out of range.  Normally, the value is simply truncated
+ *              are out of range. Normally, the value is simply truncated
  *              to fit the field, but this case is most likely a serious
  *              coding error in the ASL.
  *
@@ -369,7 +369,7 @@ acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Read or Write a single datum of a field.  The field_type is
+ * DESCRIPTION: Read or Write a single datum of a field. The field_type is
  *              demultiplexed here to handle the different types of fields
  *              (buffer_field, region_field, index_field, bank_field)
  *
@@ -859,7 +859,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.bit_length);
 	/*
 	 * We must have a buffer that is at least as long as the field
-	 * we are writing to.  This is because individual fields are
+	 * we are writing to. This is because individual fields are
 	 * indivisible and partial writes are not supported -- as per
 	 * the ACPI specification.
 	 */
@@ -874,7 +874,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 
 		/*
 		 * Copy the original data to the new buffer, starting
-		 * at Byte zero.  All unused (upper) bytes of the
+		 * at Byte zero. All unused (upper) bytes of the
 		 * buffer will be 0.
 		 */
 		ACPI_MEMCPY((char *)new_buffer, (char *)buffer, buffer_length);
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 15e1abd..8405870 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -253,7 +253,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 	ACPI_FUNCTION_TRACE(ex_do_concatenate);
 
 	/*
-	 * Convert the second operand if necessary.  The first operand
+	 * Convert the second operand if necessary. The first operand
 	 * determines the type of the second operand, (See the Data Types
 	 * section of the ACPI specification.)  Both object types are
 	 * guaranteed to be either Integer/String/Buffer by the operand
@@ -572,7 +572,7 @@ acpi_ex_do_logical_op(u16 opcode,
 	ACPI_FUNCTION_TRACE(ex_do_logical_op);
 
 	/*
-	 * Convert the second operand if necessary.  The first operand
+	 * Convert the second operand if necessary. The first operand
 	 * determines the type of the second operand, (See the Data Types
 	 * section of the ACPI 3.0+ specification.)  Both object types are
 	 * guaranteed to be either Integer/String/Buffer by the operand
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index a41c82f..2ff578a 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -62,7 +62,7 @@ static acpi_status acpi_ex_name_segment(u8 **in_aml_address, char *name_string);
  *                                    (-1)==root,  0==none
  *              num_name_segs       - count of 4-character name segments
  *
- * RETURN:      A pointer to the allocated string segment.  This segment must
+ * RETURN:      A pointer to the allocated string segment. This segment must
  *              be deleted by the caller.
  *
  * DESCRIPTION: Allocate a buffer for a name string. Ensure allocated name
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index c6490d6..bbf01e9 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -605,7 +605,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		}
 
 		/*
-		 * Set result to ONES (TRUE) if Value == 0.  Note:
+		 * Set result to ONES (TRUE) if Value == 0. Note:
 		 * return_desc->Integer.Value is initially == 0 (FALSE) from above.
 		 */
 		if (!operand[0]->integer.value) {
@@ -617,7 +617,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 	case AML_INCREMENT_OP:	/* Increment (Operand)  */
 
 		/*
-		 * Create a new integer.  Can't just get the base integer and
+		 * Create a new integer. Can't just get the base integer and
 		 * increment it because it may be an Arg or Field.
 		 */
 		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
@@ -685,7 +685,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 		/*
 		 * Note: The operand is not resolved at this point because we want to
-		 * get the associated object, not its value.  For example, we don't
+		 * get the associated object, not its value. For example, we don't
 		 * want to resolve a field_unit to its value, we want the actual
 		 * field_unit object.
 		 */
@@ -726,7 +726,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 		/*
 		 * The type of the base object must be integer, buffer, string, or
-		 * package.  All others are not supported.
+		 * package. All others are not supported.
 		 *
 		 * NOTE: Integer is not specifically supported by the ACPI spec,
 		 * but is supported implicitly via implicit operand conversion.
@@ -964,7 +964,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 				case ACPI_TYPE_PACKAGE:
 
 					/*
-					 * Return the referenced element of the package.  We must
+					 * Return the referenced element of the package. We must
 					 * add another reference to the referenced object, however.
 					 */
 					return_desc =
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 879e8a2..ee5634a 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -123,7 +123,7 @@ acpi_status acpi_ex_opcode_2A_0T_0R(struct acpi_walk_state *walk_state)
 		/*
 		 * Dispatch the notify to the appropriate handler
 		 * NOTE: the request is queued for execution after this method
-		 * completes.  The notify handlers are NOT invoked synchronously
+		 * completes. The notify handlers are NOT invoked synchronously
 		 * from this thread -- because handlers may in turn run other
 		 * control methods.
 		 */
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 00b19bf..2c89b46 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -157,7 +157,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 	case AML_MID_OP:	/* Mid (Source[0], Index[1], Length[2], Result[3]) */
 
 		/*
-		 * Create the return object.  The Source operand is guaranteed to be
+		 * Create the return object. The Source operand is guaranteed to be
 		 * either a String or a Buffer, so just use its type.
 		 */
 		return_desc = acpi_ut_create_internal_object((operand[0])->
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 9818855..3e08695 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -268,7 +268,7 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		 * and the next should be examined.
 		 *
 		 * Upon finding a match, the loop will terminate via "break" at
-		 * the bottom.  If it terminates "normally", match_value will be
+		 * the bottom. If it terminates "normally", match_value will be
 		 * ACPI_UINT64_MAX (Ones) (its initial value) indicating that no
 		 * match was found.
 		 */
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 9589248..ba9db4d 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -77,8 +77,8 @@ acpi_ex_generate_access(u32 field_bit_offset,
  *              any_acc keyword.
  *
  * NOTE: Need to have the region_length in order to check for boundary
- *       conditions (end-of-region).  However, the region_length is a deferred
- *       operation.  Therefore, to complete this implementation, the generation
+ *       conditions (end-of-region). However, the region_length is a deferred
+ *       operation. Therefore, to complete this implementation, the generation
  *       of this access width must be deferred until the region length has
  *       been evaluated.
  *
@@ -307,7 +307,7 @@ acpi_ex_decode_field_access(union acpi_operand_object *obj_desc,
  * RETURN:      Status
  *
  * DESCRIPTION: Initialize the areas of the field object that are common
- *              to the various types of fields.  Note: This is very "sensitive"
+ *              to the various types of fields. Note: This is very "sensitive"
  *              code because we are solving the general case for field
  *              alignment.
  *
@@ -335,13 +335,13 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 	obj_desc->common_field.bit_length = field_bit_length;
 
 	/*
-	 * Decode the access type so we can compute offsets.  The access type gives
+	 * Decode the access type so we can compute offsets. The access type gives
 	 * two pieces of information - the width of each field access and the
 	 * necessary byte_alignment (address granularity) of the access.
 	 *
 	 * For any_acc, the access_bit_width is the largest width that is both
 	 * necessary and possible in an attempt to access the whole field in one
-	 * I/O operation.  However, for any_acc, the byte_alignment is always one
+	 * I/O operation. However, for any_acc, the byte_alignment is always one
 	 * byte.
 	 *
 	 * For all Buffer Fields, the byte_alignment is always one byte.
@@ -362,7 +362,7 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 
 	/*
 	 * base_byte_offset is the address of the start of the field within the
-	 * region.  It is the byte address of the first *datum* (field-width data
+	 * region. It is the byte address of the first *datum* (field-width data
 	 * unit) of the field. (i.e., the first datum that contains at least the
 	 * first *bit* of the field.)
 	 *
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index b41e333..1db2c0b 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -201,7 +201,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 	 * Perform the memory read or write
 	 *
 	 * Note: For machines that do not support non-aligned transfers, the target
-	 * address was checked for alignment above.  We do not attempt to break the
+	 * address was checked for alignment above. We do not attempt to break the
 	 * transfer up into smaller (byte-size) chunks because the AML specifically
 	 * asked for a transfer width that the hardware may require.
 	 */
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 1cb057f..6239956 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -57,8 +57,8 @@ ACPI_MODULE_NAME("exresnte")
  * PARAMETERS:  object_ptr      - Pointer to a location that contains
  *                                a pointer to a NS node, and will receive a
  *                                pointer to the resolved object.
- *              walk_state      - Current state.  Valid only if executing AML
- *                                code.  NULL if simply resolving an object
+ *              walk_state      - Current state. Valid only if executing AML
+ *                                code. NULL if simply resolving an object
  *
  * RETURN:      Status
  *
@@ -66,7 +66,7 @@ ACPI_MODULE_NAME("exresnte")
  *
  * Note: for some of the data types, the pointer attached to the Node
  * can be either a pointer to an actual internal object or a pointer into the
- * AML stream itself.  These types are currently:
+ * AML stream itself. These types are currently:
  *
  *      ACPI_TYPE_INTEGER
  *      ACPI_TYPE_STRING
@@ -88,7 +88,7 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 	ACPI_FUNCTION_TRACE(ex_resolve_node_to_value);
 
 	/*
-	 * The stack pointer points to a struct acpi_namespace_node (Node).  Get the
+	 * The stack pointer points to a struct acpi_namespace_node (Node). Get the
 	 * object that is attached to the Node.
 	 */
 	node = *object_ptr;
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index ae199e7..cc176b2 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -326,7 +326,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Return the base object and type.  Traverse a reference list if
+ * DESCRIPTION: Return the base object and type. Traverse a reference list if
  *              necessary to get to the base object.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 04b70b3..b9ebff2 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -86,7 +86,7 @@ acpi_ex_check_object_type(acpi_object_type type_needed,
 	if (type_needed == ACPI_TYPE_LOCAL_REFERENCE) {
 		/*
 		 * Allow the AML "Constant" opcodes (Zero, One, etc.) to be reference
-		 * objects and thus allow them to be targets.  (As per the ACPI
+		 * objects and thus allow them to be targets. (As per the ACPI
 		 * specification, a store to a constant is a noop.)
 		 */
 		if ((this_type == ACPI_TYPE_INTEGER) &&
@@ -638,7 +638,7 @@ acpi_ex_resolve_operands(u16 opcode,
 				if (acpi_gbl_enable_interpreter_slack) {
 					/*
 					 * Enable original behavior of Store(), allowing any and all
-					 * objects as the source operand.  The ACPI spec does not
+					 * objects as the source operand. The ACPI spec does not
 					 * allow this, however.
 					 */
 					break;
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 5fffe7a..90431f1 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -374,7 +374,7 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
  *              with the input value.
  *
  *              When storing into an object the data is converted to the
- *              target object type then stored in the object.  This means
+ *              target object type then stored in the object. This means
  *              that the target object type (for an initialized target) will
  *              not be changed by a store operation.
  *
@@ -491,7 +491,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 				  acpi_ut_get_object_type_name(source_desc),
 				  source_desc, node));
 
-		/* No conversions for all other types.  Just attach the source object */
+		/* No conversions for all other types. Just attach the source object */
 
 		status = acpi_ns_attach_object(node, source_desc,
 					       source_desc->common.type);
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 6fe6eac..87153bb 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -60,7 +60,7 @@ ACPI_MODULE_NAME("exstoren")
  *
  * RETURN:      Status, resolved object in source_desc_ptr.
  *
- * DESCRIPTION: Resolve an object.  If the object is a reference, dereference
+ * DESCRIPTION: Resolve an object. If the object is a reference, dereference
  *              it and return the actual object in the source_desc_ptr.
  *
  ******************************************************************************/
@@ -92,7 +92,7 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
 
 		/*
 		 * Stores into a Field/Region or into a Integer/Buffer/String
-		 * are all essentially the same.  This case handles the
+		 * are all essentially the same. This case handles the
 		 * "interchangeable" types Integer, String, and Buffer.
 		 */
 		if (source_desc->common.type == ACPI_TYPE_LOCAL_REFERENCE) {
@@ -166,7 +166,7 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: "Store" an object to another object.  This may include
+ * DESCRIPTION: "Store" an object to another object. This may include
  *              converting the source type to the target type (implicit
  *              conversion), and a copy of the value of the source to
  *              the target.
@@ -177,14 +177,14 @@ acpi_ex_resolve_object(union acpi_operand_object **source_desc_ptr,
  *              with the input value.
  *
  *              When storing into an object the data is converted to the
- *              target object type then stored in the object.  This means
+ *              target object type then stored in the object. This means
  *              that the target object type (for an initialized target) will
  *              not be changed by a store operation.
  *
  *              This module allows destination types of Number, String,
  *              Buffer, and Package.
  *
- *              Assumes parameters are already validated.  NOTE: source_desc
+ *              Assumes parameters are already validated. NOTE: source_desc
  *              resolution (from a reference object) must be performed by
  *              the caller if necessary.
  *
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index b9ac30c..b5f339c 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -107,7 +107,7 @@ acpi_ex_store_buffer_to_buffer(union acpi_operand_object *source_desc,
 #ifdef ACPI_OBSOLETE_BEHAVIOR
 		/*
 		 * NOTE: ACPI versions up to 3.0 specified that the buffer must be
-		 * truncated if the string is smaller than the buffer.  However, "other"
+		 * truncated if the string is smaller than the buffer. However, "other"
 		 * implementations of ACPI never did this and thus became the defacto
 		 * standard. ACPI 3.0A changes this behavior such that the buffer
 		 * is no longer truncated.
@@ -116,7 +116,7 @@ acpi_ex_store_buffer_to_buffer(union acpi_operand_object *source_desc,
 		/*
 		 * OBSOLETE BEHAVIOR:
 		 * If the original source was a string, we must truncate the buffer,
-		 * according to the ACPI spec.  Integer-to-Buffer and Buffer-to-Buffer
+		 * according to the ACPI spec. Integer-to-Buffer and Buffer-to-Buffer
 		 * copy must not truncate the original buffer.
 		 */
 		if (original_src_type == ACPI_TYPE_STRING) {
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 2d6d8bc..c8a0ad5 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -58,7 +58,7 @@ ACPI_MODULE_NAME("exsystem")
  * RETURN:      Status
  *
  * DESCRIPTION: Implements a semaphore wait with a check to see if the
- *              semaphore is available immediately.  If it is not, the
+ *              semaphore is available immediately. If it is not, the
  *              interpreter is released before waiting.
  *
  ******************************************************************************/
@@ -103,7 +103,7 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
  * RETURN:      Status
  *
  * DESCRIPTION: Implements a mutex wait with a check to see if the
- *              mutex is available immediately.  If it is not, the
+ *              mutex is available immediately. If it is not, the
  *              interpreter is released before waiting.
  *
  ******************************************************************************/
@@ -151,7 +151,7 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
  * DESCRIPTION: Suspend running thread for specified amount of time.
  *              Note: ACPI specification requires that Stall() does not
  *              relinquish the processor, and delays longer than 100 usec
- *              should use Sleep() instead.  We allow stalls up to 255 usec
+ *              should use Sleep() instead. We allow stalls up to 255 usec
  *              for compatibility with other interpreters and existing BIOSs.
  *
  ******************************************************************************/
@@ -253,7 +253,7 @@ acpi_status acpi_ex_system_signal_event(union acpi_operand_object * obj_desc)
  * RETURN:      Status
  *
  * DESCRIPTION: Provides an access point to perform synchronization operations
- *              within the AML.  This operation is a request to wait for an
+ *              within the AML. This operation is a request to wait for an
  *              event.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index ff291e6..264d22d 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -44,12 +44,12 @@
 /*
  * DEFINE_AML_GLOBALS is tested in amlcode.h
  * to determine whether certain global names should be "defined" or only
- * "declared" in the current compilation.  This enhances maintainability
+ * "declared" in the current compilation. This enhances maintainability
  * by enabling a single header file to embody all knowledge of the names
  * in question.
  *
  * Exactly one module of any executable should #define DEFINE_GLOBALS
- * before #including the header files which use this convention.  The
+ * before #including the header files which use this convention. The
  * names in question will be defined and initialized in that module,
  * and declared as extern in all other modules which #include those
  * header files.
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index bcf931c..90a9aea 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -135,7 +135,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
  *
  * RETURN:      SYS_MODE_ACPI or SYS_MODE_LEGACY
  *
- * DESCRIPTION: Return current operating state of system.  Determined by
+ * DESCRIPTION: Return current operating state of system. Determined by
  *              querying the SCI_EN bit.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 19f6cce..bfdce22 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -127,7 +127,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_timer)
  *              a versatile and accurate timer.
  *
  *              Note that this function accommodates only a single timer
- *              rollover.  Thus for 24-bit timers, this function should only
+ *              rollover. Thus for 24-bit timers, this function should only
  *              be used for calculating durations less than ~4.6 seconds
  *              (~20 minutes for 32-bit timers) -- calculations below:
  *
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index ac389e5..15143c4 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -332,7 +332,7 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
  *
  * RETURN:      None.
  *
- * DESCRIPTION: Delete a subtree of the namespace.  This includes all objects
+ * DESCRIPTION: Delete a subtree of the namespace. This includes all objects
  *              stored within the subtree.
  *
  ******************************************************************************/
@@ -418,7 +418,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
  * RETURN:      Status
  *
  * DESCRIPTION: Delete entries within the namespace that are owned by a
- *              specific ID.  Used to delete entire ACPI tables.  All
+ *              specific ID. Used to delete entire ACPI tables. All
  *              reference counts are updated.
  *
  * MUTEX:       Locks namespace during deletion walk.
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 993b124..924b3c7 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -692,7 +692,7 @@ void acpi_ns_dump_entry(acpi_handle handle, u32 debug_level)
  *
  * PARAMETERS:  search_base         - Root of subtree to be dumped, or
  *                                    NS_ALL to dump the entire namespace
- *              max_depth           - Maximum depth of dump.  Use INT_MAX
+ *              max_depth           - Maximum depth of dump. Use INT_MAX
  *                                    for an effectively unlimited depth.
  *
  * RETURN:      None
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 76935ff..911f991 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -80,8 +80,8 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 
 	/*
 	 * Parse the table and load the namespace with all named
-	 * objects found within.  Control methods are NOT parsed
-	 * at this time.  In fact, the control methods cannot be
+	 * objects found within. Control methods are NOT parsed
+	 * at this time. In fact, the control methods cannot be
 	 * parsed until the entire namespace is loaded, because
 	 * if a control method makes a forward reference (call)
 	 * to another control method, we can't continue parsing
@@ -122,7 +122,7 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	}
 
 	/*
-	 * Now we can parse the control methods.  We always parse
+	 * Now we can parse the control methods. We always parse
 	 * them here for a sanity check, and if configured for
 	 * just-in-time parsing, we delete the control method
 	 * parse trees.
@@ -166,7 +166,7 @@ acpi_status acpi_ns_load_namespace(void)
 	}
 
 	/*
-	 * Load the namespace.  The DSDT is required,
+	 * Load the namespace. The DSDT is required,
 	 * but the SSDT and PSDT tables are optional.
 	 */
 	status = acpi_ns_load_table_by_type(ACPI_TABLE_ID_DSDT);
@@ -283,7 +283,7 @@ static acpi_status acpi_ns_delete_subtree(acpi_handle start_handle)
  *  RETURN:         Status
  *
  *  DESCRIPTION:    Shrinks the namespace, typically in response to an undocking
- *                  event.  Deletes an entire subtree starting from (and
+ *                  event. Deletes an entire subtree starting from (and
  *                  including) the given handle.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index d6c9a3c..e69f7fa 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("nsobject")
  * RETURN:      Status
  *
  * DESCRIPTION: Record the given object as the value associated with the
- *              name whose acpi_handle is passed.  If Object is NULL
+ *              name whose acpi_handle is passed. If Object is NULL
  *              and Type is ACPI_TYPE_ANY, set the name as having no value.
  *              Note: Future may require that the Node->Flags field be passed
  *              as a parameter.
@@ -133,7 +133,7 @@ acpi_ns_attach_object(struct acpi_namespace_node *node,
 		 ((struct acpi_namespace_node *)object)->object) {
 		/*
 		 * Value passed is a name handle and that name has a
-		 * non-null value.  Use that name's value and type.
+		 * non-null value. Use that name's value and type.
 		 */
 		obj_desc = ((struct acpi_namespace_node *)object)->object;
 		object_type = ((struct acpi_namespace_node *)object)->type;
@@ -321,7 +321,7 @@ union acpi_operand_object *acpi_ns_get_secondary_object(union
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Low-level attach data.  Create and attach a Data object.
+ * DESCRIPTION: Low-level attach data. Create and attach a Data object.
  *
  ******************************************************************************/
 
@@ -377,7 +377,7 @@ acpi_ns_attach_data(struct acpi_namespace_node *node,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Low-level detach data.  Delete the data node, but the caller
+ * DESCRIPTION: Low-level detach data. Delete the data node, but the caller
  *              is responsible for the actual data.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index ec7ba2d..233f756 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -168,11 +168,11 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	/*
 	 * AML Parse, pass 1
 	 *
-	 * In this pass, we load most of the namespace.  Control methods
-	 * are not parsed until later.  A parse tree is not created.  Instead,
-	 * each Parser Op subtree is deleted when it is finished.  This saves
+	 * In this pass, we load most of the namespace. Control methods
+	 * are not parsed until later. A parse tree is not created. Instead,
+	 * each Parser Op subtree is deleted when it is finished. This saves
 	 * a great deal of memory, and allows a small cache of parse objects
-	 * to service the entire parse.  The second pass of the parse then
+	 * to service the entire parse. The second pass of the parse then
 	 * performs another complete parse of the AML.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index ef753a4..16b3da8 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -530,7 +530,7 @@ acpi_ns_externalize_name(u32 internal_name_length,
 	    ((num_segments > 0) ? (num_segments - 1) : 0) + 1;
 
 	/*
-	 * Check to see if we're still in bounds.  If not, there's a problem
+	 * Check to see if we're still in bounds. If not, there's a problem
 	 * with internal_name (invalid format).
 	 */
 	if (required_length > internal_name_length) {
@@ -681,7 +681,7 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
  *                            \ (backslash) and ^ (carat) prefixes, and the
  *                            . (period) to separate segments are supported.
  *              prefix_node  - Root of subtree to be searched, or NS_ALL for the
- *                            root of the name space.  If Name is fully
+ *                            root of the name space. If Name is fully
  *                            qualified (first s8 is '\'), the passed value
  *                            of Scope will not be accessed.
  *              flags       - Used to indicate whether to perform upsearch or
@@ -689,7 +689,7 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
  *              return_node - Where the Node is returned
  *
  * DESCRIPTION: Look up a name relative to a given scope and return the
- *              corresponding Node.  NOTE: Scope can be null.
+ *              corresponding Node. NOTE: Scope can be null.
  *
  * MUTEX:       Locks namespace
  *
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 730bccc..0483877 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -60,8 +60,8 @@ ACPI_MODULE_NAME("nswalk")
  * RETURN:      struct acpi_namespace_node - Pointer to the NEXT child or NULL if
  *                                    none is found.
  *
- * DESCRIPTION: Return the next peer node within the namespace.  If Handle
- *              is valid, Scope is ignored.  Otherwise, the first node
+ * DESCRIPTION: Return the next peer node within the namespace. If Handle
+ *              is valid, Scope is ignored. Otherwise, the first node
  *              within Scope is returned.
  *
  ******************************************************************************/
@@ -97,8 +97,8 @@ struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
  * RETURN:      struct acpi_namespace_node - Pointer to the NEXT child or NULL if
  *                                    none is found.
  *
- * DESCRIPTION: Return the next peer node within the namespace.  If Handle
- *              is valid, Scope is ignored.  Otherwise, the first node
+ * DESCRIPTION: Return the next peer node within the namespace. If Handle
+ *              is valid, Scope is ignored. Otherwise, the first node
  *              within Scope is returned.
  *
  ******************************************************************************/
@@ -305,7 +305,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 
 		/*
 		 * Depth first search: Attempt to go down another level in the
-		 * namespace if we are allowed to.  Don't go any further if we have
+		 * namespace if we are allowed to. Don't go any further if we have
 		 * reached the caller specified maximum depth or if the user
 		 * function has specified that the maximum depth has been reached.
 		 */
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index ee4d873..d6a9f77 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -61,16 +61,16 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info);
  * PARAMETERS:  handle              - Object handle (optional)
  *              pathname            - Object pathname (optional)
  *              external_params     - List of parameters to pass to method,
- *                                    terminated by NULL.  May be NULL
+ *                                    terminated by NULL. May be NULL
  *                                    if no parameters are being passed.
  *              return_buffer       - Where to put method's return value (if
- *                                    any).  If NULL, no value is returned.
+ *                                    any). If NULL, no value is returned.
  *              return_type         - Expected type of return object
  *
  * RETURN:      Status
  *
  * DESCRIPTION: Find and evaluate the given object, passing the given
- *              parameters if necessary.  One of "Handle" or "Pathname" must
+ *              parameters if necessary. One of "Handle" or "Pathname" must
  *              be valid (non-null)
  *
  ******************************************************************************/
@@ -155,15 +155,15 @@ ACPI_EXPORT_SYMBOL(acpi_evaluate_object_typed)
  * PARAMETERS:  handle              - Object handle (optional)
  *              pathname            - Object pathname (optional)
  *              external_params     - List of parameters to pass to method,
- *                                    terminated by NULL.  May be NULL
+ *                                    terminated by NULL. May be NULL
  *                                    if no parameters are being passed.
  *              return_buffer       - Where to put method's return value (if
- *                                    any).  If NULL, no value is returned.
+ *                                    any). If NULL, no value is returned.
  *
  * RETURN:      Status
  *
  * DESCRIPTION: Find and evaluate the given object, passing the given
- *              parameters if necessary.  One of "Handle" or "Pathname" must
+ *              parameters if necessary. One of "Handle" or "Pathname" must
  *              be valid (non-null)
  *
  ******************************************************************************/
@@ -656,7 +656,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
  * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
  *              starting (and ending) at the object specified by start_handle.
  *              The user_function is called whenever an object of type
- *              Device is found.  If the user function returns
+ *              Device is found. If the user function returns
  *              a non-zero value, the search is terminated immediately and this
  *              value is returned to the caller.
  *
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 7bc4985..ce87897 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -69,8 +69,8 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
  * RETURN:      Status
  *
  * DESCRIPTION: This routine will search for a caller specified name in the
- *              name space.  The caller can restrict the search region by
- *              specifying a non NULL parent.  The parent value is itself a
+ *              name space. The caller can restrict the search region by
+ *              specifying a non NULL parent. The parent value is itself a
  *              namespace handle.
  *
  ******************************************************************************/
@@ -149,7 +149,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_handle)
  * RETURN:      Pointer to a string containing the fully qualified Name.
  *
  * DESCRIPTION: This routine returns the fully qualified name associated with
- *              the Handle parameter.  This and the acpi_pathname_to_handle are
+ *              the Handle parameter. This and the acpi_pathname_to_handle are
  *              complementary functions.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 6766fc4..9d029da 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -220,8 +220,8 @@ ACPI_EXPORT_SYMBOL(acpi_get_parent)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Return the next peer object within the namespace.  If Handle is
- *              valid, Scope is ignored.  Otherwise, the first object within
+ * DESCRIPTION: Return the next peer object within the namespace. If Handle is
+ *              valid, Scope is ignored. Otherwise, the first object within
  *              Scope is returned.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 844464c..cb79e2d 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -120,7 +120,7 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
  * RETURN:      Pointer to end-of-package +1
  *
  * DESCRIPTION: Get next package length and return a pointer past the end of
- *              the package.  Consumes the package length field
+ *              the package. Consumes the package length field
  *
  ******************************************************************************/
 
@@ -147,8 +147,8 @@ u8 *acpi_ps_get_next_package_end(struct acpi_parse_state *parser_state)
  * RETURN:      Pointer to the start of the name string (pointer points into
  *              the AML.
  *
- * DESCRIPTION: Get next raw namestring within the AML stream.  Handles all name
- *              prefix characters.  Set parser state to point past the string.
+ * DESCRIPTION: Get next raw namestring within the AML stream. Handles all name
+ *              prefix characters. Set parser state to point past the string.
  *              (Name is consumed from the AML.)
  *
  ******************************************************************************/
@@ -220,7 +220,7 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
  *
  * DESCRIPTION: Get next name (if method call, return # of required args).
  *              Names are looked up in the internal namespace to determine
- *              if the name represents a control method.  If a method
+ *              if the name represents a control method. If a method
  *              is found, the number of arguments to the method is returned.
  *              This information is critical for parsing to continue correctly.
  *
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index e5572a7..1793d93 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -59,7 +59,7 @@ static const u8 acpi_gbl_argument_count[] =
  *
  * DESCRIPTION: Opcode table. Each entry contains <opcode, type, name, operands>
  *              The name is a simple ascii string, the operand specifier is an
- *              ascii string with one letter per operand.  The letter specifies
+ *              ascii string with one letter per operand. The letter specifies
  *              the operand type.
  *
  ******************************************************************************/
@@ -183,7 +183,7 @@ static const u8 acpi_gbl_argument_count[] =
  ******************************************************************************/
 
 /*
- * Master Opcode information table.  A summary of everything we know about each
+ * Master Opcode information table. A summary of everything we know about each
  * opcode, all in one place.
  */
 const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
@@ -700,7 +700,7 @@ static const u8 acpi_gbl_short_op_index[256] = {
 
 /*
  * This table is indexed by the second opcode of the extended opcode
- * pair.  It returns an index into the opcode table (acpi_gbl_aml_op_info)
+ * pair. It returns an index into the opcode table (acpi_gbl_aml_op_info)
  */
 static const u8 acpi_gbl_long_op_index[NUM_EXTENDED_OPCODE] = {
 /*              0     1     2     3     4     5     6     7  */
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index dfdda00..2494caf 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -43,9 +43,9 @@
 
 /*
  * Parse the AML and build an operation tree as most interpreters,
- * like Perl, do.  Parsing is done by hand rather than with a YACC
+ * like Perl, do. Parsing is done by hand rather than with a YACC
  * generated parser to tightly constrain stack and dynamic memory
- * usage.  At the same time, parsing is kept flexible and the code
+ * usage. At the same time, parsing is kept flexible and the code
  * fairly compact by parsing based on a list of AML opcode
  * templates in aml_op_info[]
  */
@@ -379,7 +379,7 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 	case AE_CTRL_FALSE:
 		/*
 		 * Either an IF/WHILE Predicate was false or we encountered a BREAK
-		 * opcode.  In both cases, we do not execute the rest of the
+		 * opcode. In both cases, we do not execute the rest of the
 		 * package;  We simply close out the parent (finishing the walk of
 		 * this branch of the tree) and continue execution at the parent
 		 * level.
@@ -488,7 +488,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 	acpi_gbl_current_walk_list = thread;
 
 	/*
-	 * Execute the walk loop as long as there is a valid Walk State.  This
+	 * Execute the walk loop as long as there is a valid Walk State. This
 	 * handles nested control method invocations without recursion.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "State=%p\n", walk_state));
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 8736ad5..4137dcb 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -108,7 +108,7 @@ void acpi_ps_init_op(union acpi_parse_object *op, u16 opcode)
  * RETURN:      Pointer to the new Op, null on failure
  *
  * DESCRIPTION: Allocate an acpi_op, choose op type (and thus size) based on
- *              opcode.  A cache of opcodes is available for the pure
+ *              opcode. A cache of opcodes is available for the pure
  *              GENERIC_OP, since this is by far the most commonly used.
  *
  ******************************************************************************/
@@ -164,7 +164,7 @@ union acpi_parse_object *acpi_ps_alloc_op(u16 opcode)
  *
  * RETURN:      None.
  *
- * DESCRIPTION: Free an Op object.  Either put it on the GENERIC_OP cache list
+ * DESCRIPTION: Free an Op object. Either put it on the GENERIC_OP cache list
  *              or actually free it.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 4274567..6851779 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -601,7 +601,7 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 	/*
 	 * Calculate the size of the return buffer.
 	 * The base size is the number of elements * the sizes of the
-	 * structures.  Additional space for the strings is added below.
+	 * structures. Additional space for the strings is added below.
 	 * The minus one is to subtract the size of the u8 Source[1]
 	 * member because it is added below.
 	 *
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index f8ee9b3..28f3302 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -107,7 +107,7 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
  * RETURN:      Status, RSDP physical address
  *
  * DESCRIPTION: Search lower 1Mbyte of memory for the root system descriptor
- *              pointer structure.  If it is found, set *RSDP to point to it.
+ *              pointer structure. If it is found, set *RSDP to point to it.
  *
  * NOTE1:       The RSDP must be either in the first 1K of the Extended
  *              BIOS Data Area or between E0000 and FFFFF (From ACPI Spec.)
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index eacb9ba..e1d40ed 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -183,7 +183,7 @@ acpi_status acpi_os_delete_cache(struct acpi_memory_list * cache)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Release an object to the specified cache.  If cache is full,
+ * DESCRIPTION: Release an object to the specified cache. If cache is full,
  *              the object is deleted.
  *
  ******************************************************************************/
@@ -240,9 +240,9 @@ acpi_os_release_object(struct acpi_memory_list * cache, void *object)
  *
  * PARAMETERS:  cache           - Handle to cache object
  *
- * RETURN:      the acquired object.  NULL on error
+ * RETURN:      the acquired object. NULL on error
  *
- * DESCRIPTION: Get an object from the specified cache.  If cache is empty,
+ * DESCRIPTION: Get an object from the specified cache. If cache is empty,
  *              the object is allocated.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 2c21799..7a33270 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -223,7 +223,7 @@ ACPI_EXPORT_SYMBOL(acpi_debug_print)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Print message with no headers.  Has same interface as
+ * DESCRIPTION: Print message with no headers. Has same interface as
  *              debug_print so that the same macros can be used.
  *
  ******************************************************************************/
@@ -259,7 +259,7 @@ ACPI_EXPORT_SYMBOL(acpi_debug_print_raw)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function entry trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function entry trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level
  *
  ******************************************************************************/
@@ -291,7 +291,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_trace)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function entry trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function entry trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level
  *
  ******************************************************************************/
@@ -321,7 +321,7 @@ acpi_ut_trace_ptr(u32 line_number,
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function entry trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function entry trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level
  *
  ******************************************************************************/
@@ -352,7 +352,7 @@ acpi_ut_trace_str(u32 line_number,
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function entry trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function entry trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level
  *
  ******************************************************************************/
@@ -382,7 +382,7 @@ acpi_ut_trace_u32(u32 line_number,
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function exit trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function exit trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level
  *
  ******************************************************************************/
@@ -414,7 +414,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_exit)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function exit trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function exit trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level. Prints exit status also.
  *
  ******************************************************************************/
@@ -455,7 +455,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_status_exit)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function exit trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function exit trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level. Prints exit value also.
  *
  ******************************************************************************/
@@ -487,7 +487,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_value_exit)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Function exit trace.  Prints only if TRACE_FUNCTIONS bit is
+ * DESCRIPTION: Function exit trace. Prints only if TRACE_FUNCTIONS bit is
  *              set in debug_level. Prints exit value also.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index d88a8aa..4956367 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -81,7 +81,7 @@ typedef union uint64_overlay {
  * RETURN:      Status (Checks for divide-by-zero)
  *
  * DESCRIPTION: Perform a short (maximum 64 bits divided by 32 bits)
- *              divide and modulo.  The result is a 64-bit quotient and a
+ *              divide and modulo. The result is a 64-bit quotient and a
  *              32-bit remainder.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index beea1d4..fba6eba 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -250,7 +250,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
  *              control method or unloading a table. Either way, we would
  *              ignore any error anyway.
  *
- * DESCRIPTION: Release a table or method owner ID.  Valid IDs are 1 - 255
+ * DESCRIPTION: Release a table or method owner ID. Valid IDs are 1 - 255
  *
  ******************************************************************************/
 
@@ -534,8 +534,8 @@ u32 acpi_ut_dword_byte_swap(u32 value)
  * RETURN:      None
  *
  * DESCRIPTION: Set the global integer bit width based upon the revision
- *              of the DSDT.  For Revision 1 and 0, Integers are 32 bits.
- *              For Revision 2 and above, Integers are 64 bits.  Yes, this
+ *              of the DSDT. For Revision 1 and 0, Integers are 32 bits.
+ *              For Revision 2 and above, Integers are 64 bits. Yes, this
  *              makes a difference.
  *
  ******************************************************************************/
@@ -671,7 +671,7 @@ u8 acpi_ut_valid_acpi_char(char character, u32 position)
  *
  * RETURN:      TRUE if the name is valid, FALSE otherwise
  *
- * DESCRIPTION: Check for a valid ACPI name.  Each character must be one of:
+ * DESCRIPTION: Check for a valid ACPI name. Each character must be one of:
  *              1) Upper case alpha
  *              2) numeric
  *              3) underscore
@@ -1010,10 +1010,10 @@ acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 
 		/*
 		 * Check for:
-		 * 1) An uninitialized package element.  It is completely
+		 * 1) An uninitialized package element. It is completely
 		 *    legal to declare a package and leave it uninitialized
 		 * 2) Not an internal object - can be a namespace node instead
-		 * 3) Any type other than a package.  Packages are handled in else
+		 * 3) Any type other than a package. Packages are handled in else
 		 *    case below.
 		 */
 		if ((!this_source_obj) ||
@@ -1032,7 +1032,7 @@ acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 			       state->pkg.source_object->package.count) {
 				/*
 				 * We've handled all of the objects at this level,  This means
-				 * that we have just completed a package.  That package may
+				 * that we have just completed a package. That package may
 				 * have contained one or more packages itself.
 				 *
 				 * Delete this state and pop the previous state (package).
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 93a1191..5ccf57c 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -228,9 +228,9 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 		/*
 		 * Mutex debug code, for internal debugging only.
 		 *
-		 * Deadlock prevention.  Check if this thread owns any mutexes of value
-		 * greater than or equal to this one.  If so, the thread has violated
-		 * the mutex ordering rule.  This indicates a coding error somewhere in
+		 * Deadlock prevention. Check if this thread owns any mutexes of value
+		 * greater than or equal to this one. If so, the thread has violated
+		 * the mutex ordering rule. This indicates a coding error somewhere in
 		 * the ACPI subsystem code.
 		 */
 		for (i = mutex_id; i < ACPI_NUM_MUTEX; i++) {
@@ -321,9 +321,9 @@ acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 		/*
 		 * Mutex debug code, for internal debugging only.
 		 *
-		 * Deadlock prevention.  Check if this thread owns any mutexes of value
-		 * greater than this one.  If so, the thread has violated the mutex
-		 * ordering rule.  This indicates a coding error somewhere in
+		 * Deadlock prevention. Check if this thread owns any mutexes of value
+		 * greater than this one. If so, the thread has violated the mutex
+		 * ordering rule. This indicates a coding error somewhere in
 		 * the ACPI subsystem code.
 		 */
 		for (i = mutex_id; i < ACPI_NUM_MUTEX; i++) {
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 655f079..5c52ca7 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -77,7 +77,7 @@ acpi_ut_get_element_length(u8 object_type,
  *
  * NOTE:        We always allocate the worst-case object descriptor because
  *              these objects are cached, and we want them to be
- *              one-size-satisifies-any-request.  This in itself may not be
+ *              one-size-satisifies-any-request. This in itself may not be
  *              the most memory efficient, but the efficiency of the object
  *              cache should more than make up for this!
  *
@@ -370,9 +370,9 @@ u8 acpi_ut_valid_internal_object(void *object)
  *              line_number         - Caller's line number (for error output)
  *              component_id        - Caller's component ID (for error output)
  *
- * RETURN:      Pointer to newly allocated object descriptor.  Null on error
+ * RETURN:      Pointer to newly allocated object descriptor. Null on error
  *
- * DESCRIPTION: Allocate a new object descriptor.  Gracefully handle
+ * DESCRIPTION: Allocate a new object descriptor. Gracefully handle
  *              error conditions.
  *
  ******************************************************************************/
@@ -554,7 +554,7 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 
 	/*
 	 * Account for the space required by the object rounded up to the next
-	 * multiple of the machine word size.  This keeps each object aligned
+	 * multiple of the machine word size. This keeps each object aligned
 	 * on a machine word boundary. (preventing alignment faults on some
 	 * machines.)
 	 */
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index a1c9882..cee0473 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -147,7 +147,7 @@ union acpi_generic_state *acpi_ut_pop_generic_state(union acpi_generic_state
  *
  * RETURN:      The new state object. NULL on failure.
  *
- * DESCRIPTION: Create a generic state object.  Attempt to obtain one from
+ * DESCRIPTION: Create a generic state object. Attempt to obtain one from
  *              the global state cache;  If none available, create a new one.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index e79c49d..79f311c 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -45,9 +45,9 @@
  * These procedures are used for tracking memory leaks in the subsystem, and
  * they get compiled out when the ACPI_DBG_TRACK_ALLOCATIONS is not set.
  *
- * Each memory allocation is tracked via a doubly linked list.  Each
+ * Each memory allocation is tracked via a doubly linked list. Each
  * element contains the caller's component, module name, function name, and
- * line number.  acpi_ut_allocate and acpi_ut_allocate_zeroed call
+ * line number. acpi_ut_allocate and acpi_ut_allocate_zeroed call
  * acpi_ut_track_allocation to add an element to the list; deletion
  * occurs in the body of acpi_ut_free.
  */
@@ -499,7 +499,7 @@ void acpi_ut_dump_allocation_info(void)
  * FUNCTION:    acpi_ut_dump_allocations
  *
  * PARAMETERS:  component           - Component(s) to dump info for.
- *              module              - Module to dump info for.  NULL means all.
+ *              module              - Module to dump info for. NULL means all.
  *
  * RETURN:      None
  *
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 0c98d42..390db0c 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -147,7 +147,7 @@ ACPI_EXPORT_SYMBOL(acpi_subsystem_status)
  * RETURN:      status          - the status of the call
  *
  * DESCRIPTION: This function is called to get information about the current
- *              state of the ACPI subsystem.  It will return system information
+ *              state of the ACPI subsystem. It will return system information
  *              in the out_buffer.
  *
  *              If the function fails an appropriate status will be returned
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 1950344..6c3890e 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -122,7 +122,7 @@
 #define AE_CODE_TBL_MAX                 0x0005
 
 /*
- * AML exceptions.  These are caused by problems with
+ * AML exceptions. These are caused by problems with
  * the actual AML byte stream
  */
 #define AE_AML_BAD_OPCODE               (acpi_status) (0x0001 | AE_CODE_AML)
-- 
1.7.10

