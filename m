From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/42] ACPICA: Split large dsopcode and dsload.c files.
Date: Wed, 23 Mar 2011 02:42:35 -0400
Message-ID: <9ad19ac456a5f097f7cbbfef820b95297d6a934f.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab1CWIHu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:50 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:39 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Split dsopcode.c into dsargs.c and dscontrol.c.
Split dsload.c into dsload2.c.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/Makefile    |    2 +-
 drivers/acpi/acpica/acdispat.h  |   38 ++-
 drivers/acpi/acpica/dsargs.c    |  391 +++++++++++++++++++++
 drivers/acpi/acpica/dscontrol.c |  410 ++++++++++++++++++++++
 drivers/acpi/acpica/dsopcode.c  |  725 +--------------------------------------
 drivers/acpi/acpica/dswload.c   |  670 +------------------------------------
 drivers/acpi/acpica/dswload2.c  |  720 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 1549 insertions(+), 1407 deletions(-)
 create mode 100644 drivers/acpi/acpica/dsargs.c
 create mode 100644 drivers/acpi/acpica/dscontrol.c
 create mode 100644 drivers/acpi/acpica/dswload2.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index b1706aa..a122471 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -10,7 +10,7 @@ obj-y	+= acpi.o
 
 acpi-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
 	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o \
-	 dsinit.o
+	 dsinit.o dsargs.o dscontrol.o dswload2.o
 
 acpi-y += evevent.o  evregion.o  evsci.o    evxfevnt.o \
 	 evmisc.o   evrgnini.o  evxface.o  evxfregn.o \
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 666271b..2d1b7ff 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -48,7 +48,7 @@
 #define NAMEOF_ARG_NTE      "__A0"
 
 /*
- * dsopcode - support for late evaluation
+ * dsargs - execution of dynamic arguments for static objects
  */
 acpi_status
 acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc);
@@ -62,6 +62,20 @@ acpi_status acpi_ds_get_buffer_arguments(union acpi_operand_object *obj_desc);
 
 acpi_status acpi_ds_get_package_arguments(union acpi_operand_object *obj_desc);
 
+/*
+ * dscontrol - support for execution control opcodes
+ */
+acpi_status
+acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
+			      union acpi_parse_object *op);
+
+acpi_status
+acpi_ds_exec_end_control_op(struct acpi_walk_state *walk_state,
+			    union acpi_parse_object *op);
+
+/*
+ * dsopcode - support for late operand evaluation
+ */
 acpi_status
 acpi_ds_eval_buffer_field_operands(struct acpi_walk_state *walk_state,
 				   union acpi_parse_object *op);
@@ -86,17 +100,6 @@ acpi_ds_eval_bank_field_operands(struct acpi_walk_state *walk_state,
 acpi_status acpi_ds_initialize_region(acpi_handle obj_handle);
 
 /*
- * dsctrl - Parser/Interpreter interface, control stack routines
- */
-acpi_status
-acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
-			      union acpi_parse_object *op);
-
-acpi_status
-acpi_ds_exec_end_control_op(struct acpi_walk_state *walk_state,
-			    union acpi_parse_object *op);
-
-/*
  * dsexec - Parser/Interpreter interface, method execution callbacks
  */
 acpi_status
@@ -136,23 +139,26 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 			   struct acpi_walk_state *walk_state);
 
 /*
- * dsload - Parser/Interpreter interface, namespace load callbacks
+ * dsload - Parser/Interpreter interface, pass 1 namespace load callbacks
  */
 acpi_status
+acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number);
+
+acpi_status
 acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
 		       union acpi_parse_object **out_op);
 
 acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state);
 
+/*
+ * dsload - Parser/Interpreter interface, pass 2 namespace load callbacks
+ */
 acpi_status
 acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 		       union acpi_parse_object **out_op);
 
 acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state);
 
-acpi_status
-acpi_ds_init_callbacks(struct acpi_walk_state *walk_state, u32 pass_number);
-
 /*
  * dsmthdat - method data (locals/args)
  */
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
new file mode 100644
index 0000000..8c7b997
--- /dev/null
+++ b/drivers/acpi/acpica/dsargs.c
@@ -0,0 +1,391 @@
+/******************************************************************************
+ *
+ * Module Name: dsargs - Support for execution of dynamic arguments for static
+ *                       objects (regions, fields, buffer fields, etc.)
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2011, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acnamesp.h"
+
+#define _COMPONENT          ACPI_DISPATCHER
+ACPI_MODULE_NAME("dsargs")
+
+/* Local prototypes */
+static acpi_status
+acpi_ds_execute_arguments(struct acpi_namespace_node *node,
+			  struct acpi_namespace_node *scope_node,
+			  u32 aml_length, u8 *aml_start);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_execute_arguments
+ *
+ * PARAMETERS:  Node                - Object NS node
+ *              scope_node          - Parent NS node
+ *              aml_length          - Length of executable AML
+ *              aml_start           - Pointer to the AML
+ *
+ * RETURN:      Status.
+ *
+ * DESCRIPTION: Late (deferred) execution of region or field arguments
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ds_execute_arguments(struct acpi_namespace_node *node,
+			  struct acpi_namespace_node *scope_node,
+			  u32 aml_length, u8 *aml_start)
+{
+	acpi_status status;
+	union acpi_parse_object *op;
+	struct acpi_walk_state *walk_state;
+
+	ACPI_FUNCTION_TRACE(ds_execute_arguments);
+
+	/* Allocate a new parser op to be the root of the parsed tree */
+
+	op = acpi_ps_alloc_op(AML_INT_EVAL_SUBTREE_OP);
+	if (!op) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	/* Save the Node for use in acpi_ps_parse_aml */
+
+	op->common.node = scope_node;
+
+	/* Create and initialize a new parser state */
+
+	walk_state = acpi_ds_create_walk_state(0, NULL, NULL, NULL);
+	if (!walk_state) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	status = acpi_ds_init_aml_walk(walk_state, op, NULL, aml_start,
+				       aml_length, NULL, ACPI_IMODE_LOAD_PASS1);
+	if (ACPI_FAILURE(status)) {
+		acpi_ds_delete_walk_state(walk_state);
+		goto cleanup;
+	}
+
+	/* Mark this parse as a deferred opcode */
+
+	walk_state->parse_flags = ACPI_PARSE_DEFERRED_OP;
+	walk_state->deferred_node = node;
+
+	/* Pass1: Parse the entire declaration */
+
+	status = acpi_ps_parse_aml(walk_state);
+	if (ACPI_FAILURE(status)) {
+		goto cleanup;
+	}
+
+	/* Get and init the Op created above */
+
+	op->common.node = node;
+	acpi_ps_delete_parse_tree(op);
+
+	/* Evaluate the deferred arguments */
+
+	op = acpi_ps_alloc_op(AML_INT_EVAL_SUBTREE_OP);
+	if (!op) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	op->common.node = scope_node;
+
+	/* Create and initialize a new parser state */
+
+	walk_state = acpi_ds_create_walk_state(0, NULL, NULL, NULL);
+	if (!walk_state) {
+		status = AE_NO_MEMORY;
+		goto cleanup;
+	}
+
+	/* Execute the opcode and arguments */
+
+	status = acpi_ds_init_aml_walk(walk_state, op, NULL, aml_start,
+				       aml_length, NULL, ACPI_IMODE_EXECUTE);
+	if (ACPI_FAILURE(status)) {
+		acpi_ds_delete_walk_state(walk_state);
+		goto cleanup;
+	}
+
+	/* Mark this execution as a deferred opcode */
+
+	walk_state->deferred_node = node;
+	status = acpi_ps_parse_aml(walk_state);
+
+      cleanup:
+	acpi_ps_delete_parse_tree(op);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_get_buffer_field_arguments
+ *
+ * PARAMETERS:  obj_desc        - A valid buffer_field object
+ *
+ * RETURN:      Status.
+ *
+ * DESCRIPTION: Get buffer_field Buffer and Index. This implements the late
+ *              evaluation of these field attributes.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
+{
+	union acpi_operand_object *extra_desc;
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_get_buffer_field_arguments, obj_desc);
+
+	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Get the AML pointer (method object) and buffer_field node */
+
+	extra_desc = acpi_ns_get_secondary_object(obj_desc);
+	node = obj_desc->buffer_field.node;
+
+	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname(ACPI_TYPE_BUFFER_FIELD,
+						      node, NULL));
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] BufferField Arg Init\n",
+			  acpi_ut_get_node_name(node)));
+
+	/* Execute the AML code for the term_arg arguments */
+
+	status = acpi_ds_execute_arguments(node, node->parent,
+					   extra_desc->extra.aml_length,
+					   extra_desc->extra.aml_start);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_get_bank_field_arguments
+ *
+ * PARAMETERS:  obj_desc        - A valid bank_field object
+ *
+ * RETURN:      Status.
+ *
+ * DESCRIPTION: Get bank_field bank_value. This implements the late
+ *              evaluation of these field attributes.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
+{
+	union acpi_operand_object *extra_desc;
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_get_bank_field_arguments, obj_desc);
+
+	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Get the AML pointer (method object) and bank_field node */
+
+	extra_desc = acpi_ns_get_secondary_object(obj_desc);
+	node = obj_desc->bank_field.node;
+
+	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
+			(ACPI_TYPE_LOCAL_BANK_FIELD, node, NULL));
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] BankField Arg Init\n",
+			  acpi_ut_get_node_name(node)));
+
+	/* Execute the AML code for the term_arg arguments */
+
+	status = acpi_ds_execute_arguments(node, node->parent,
+					   extra_desc->extra.aml_length,
+					   extra_desc->extra.aml_start);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_get_buffer_arguments
+ *
+ * PARAMETERS:  obj_desc        - A valid Buffer object
+ *
+ * RETURN:      Status.
+ *
+ * DESCRIPTION: Get Buffer length and initializer byte list. This implements
+ *              the late evaluation of these attributes.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ds_get_buffer_arguments(union acpi_operand_object *obj_desc)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_get_buffer_arguments, obj_desc);
+
+	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Get the Buffer node */
+
+	node = obj_desc->buffer.node;
+	if (!node) {
+		ACPI_ERROR((AE_INFO,
+			    "No pointer back to namespace node in buffer object %p",
+			    obj_desc));
+		return_ACPI_STATUS(AE_AML_INTERNAL);
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Buffer Arg Init\n"));
+
+	/* Execute the AML code for the term_arg arguments */
+
+	status = acpi_ds_execute_arguments(node, node,
+					   obj_desc->buffer.aml_length,
+					   obj_desc->buffer.aml_start);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_get_package_arguments
+ *
+ * PARAMETERS:  obj_desc        - A valid Package object
+ *
+ * RETURN:      Status.
+ *
+ * DESCRIPTION: Get Package length and initializer byte list. This implements
+ *              the late evaluation of these attributes.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ds_get_package_arguments(union acpi_operand_object *obj_desc)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_get_package_arguments, obj_desc);
+
+	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Get the Package node */
+
+	node = obj_desc->package.node;
+	if (!node) {
+		ACPI_ERROR((AE_INFO,
+			    "No pointer back to namespace node in package %p",
+			    obj_desc));
+		return_ACPI_STATUS(AE_AML_INTERNAL);
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Package Arg Init\n"));
+
+	/* Execute the AML code for the term_arg arguments */
+
+	status = acpi_ds_execute_arguments(node, node,
+					   obj_desc->package.aml_length,
+					   obj_desc->package.aml_start);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_get_region_arguments
+ *
+ * PARAMETERS:  obj_desc        - A valid region object
+ *
+ * RETURN:      Status.
+ *
+ * DESCRIPTION: Get region address and length. This implements the late
+ *              evaluation of these region attributes.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+	union acpi_operand_object *extra_desc;
+
+	ACPI_FUNCTION_TRACE_PTR(ds_get_region_arguments, obj_desc);
+
+	if (obj_desc->region.flags & AOPOBJ_DATA_VALID) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	extra_desc = acpi_ns_get_secondary_object(obj_desc);
+	if (!extra_desc) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
+	/* Get the Region node */
+
+	node = obj_desc->region.node;
+
+	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
+			(ACPI_TYPE_REGION, node, NULL));
+
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] OpRegion Arg Init at AML %p\n",
+			  acpi_ut_get_node_name(node),
+			  extra_desc->extra.aml_start));
+
+	/* Execute the argument AML */
+
+	status = acpi_ds_execute_arguments(node, node->parent,
+					   extra_desc->extra.aml_length,
+					   extra_desc->extra.aml_start);
+	return_ACPI_STATUS(status);
+}
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
new file mode 100644
index 0000000..26c49ff
--- /dev/null
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -0,0 +1,410 @@
+/******************************************************************************
+ *
+ * Module Name: dscontrol - Support for execution control opcodes -
+ *                          if/else/while/return
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2011, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+
+#define _COMPONENT          ACPI_DISPATCHER
+ACPI_MODULE_NAME("dscontrol")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_exec_begin_control_op
+ *
+ * PARAMETERS:  walk_list       - The list that owns the walk stack
+ *              Op              - The control Op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Handles all control ops encountered during control method
+ *              execution.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
+			      union acpi_parse_object *op)
+{
+	acpi_status status = AE_OK;
+	union acpi_generic_state *control_state;
+
+	ACPI_FUNCTION_NAME(ds_exec_begin_control_op);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Op=%p Opcode=%2.2X State=%p\n",
+			  op, op->common.aml_opcode, walk_state));
+
+	switch (op->common.aml_opcode) {
+	case AML_WHILE_OP:
+
+		/*
+		 * If this is an additional iteration of a while loop, continue.
+		 * There is no need to allocate a new control state.
+		 */
+		if (walk_state->control_state) {
+			if (walk_state->control_state->control.
+			    aml_predicate_start ==
+			    (walk_state->parser_state.aml - 1)) {
+
+				/* Reset the state to start-of-loop */
+
+				walk_state->control_state->common.state =
+				    ACPI_CONTROL_CONDITIONAL_EXECUTING;
+				break;
+			}
+		}
+
+		/*lint -fallthrough */
+
+	case AML_IF_OP:
+
+		/*
+		 * IF/WHILE: Create a new control state to manage these
+		 * constructs. We need to manage these as a stack, in order
+		 * to handle nesting.
+		 */
+		control_state = acpi_ut_create_control_state();
+		if (!control_state) {
+			status = AE_NO_MEMORY;
+			break;
+		}
+		/*
+		 * Save a pointer to the predicate for multiple executions
+		 * of a loop
+		 */
+		control_state->control.aml_predicate_start =
+		    walk_state->parser_state.aml - 1;
+		control_state->control.package_end =
+		    walk_state->parser_state.pkg_end;
+		control_state->control.opcode = op->common.aml_opcode;
+
+		/* Push the control state on this walk's control stack */
+
+		acpi_ut_push_generic_state(&walk_state->control_state,
+					   control_state);
+		break;
+
+	case AML_ELSE_OP:
+
+		/* Predicate is in the state object */
+		/* If predicate is true, the IF was executed, ignore ELSE part */
+
+		if (walk_state->last_predicate) {
+			status = AE_CTRL_TRUE;
+		}
+
+		break;
+
+	case AML_RETURN_OP:
+
+		break;
+
+	default:
+		break;
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_exec_end_control_op
+ *
+ * PARAMETERS:  walk_list       - The list that owns the walk stack
+ *              Op              - The control Op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Handles all control ops encountered during control method
+ *              execution.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
+			    union acpi_parse_object * op)
+{
+	acpi_status status = AE_OK;
+	union acpi_generic_state *control_state;
+
+	ACPI_FUNCTION_NAME(ds_exec_end_control_op);
+
+	switch (op->common.aml_opcode) {
+	case AML_IF_OP:
+
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "[IF_OP] Op=%p\n", op));
+
+		/*
+		 * Save the result of the predicate in case there is an
+		 * ELSE to come
+		 */
+		walk_state->last_predicate =
+		    (u8)walk_state->control_state->common.value;
+
+		/*
+		 * Pop the control state that was created at the start
+		 * of the IF and free it
+		 */
+		control_state =
+		    acpi_ut_pop_generic_state(&walk_state->control_state);
+		acpi_ut_delete_generic_state(control_state);
+		break;
+
+	case AML_ELSE_OP:
+
+		break;
+
+	case AML_WHILE_OP:
+
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "[WHILE_OP] Op=%p\n", op));
+
+		control_state = walk_state->control_state;
+		if (control_state->common.value) {
+
+			/* Predicate was true, the body of the loop was just executed */
+
+			/*
+			 * This loop counter mechanism allows the interpreter to escape
+			 * possibly infinite loops. This can occur in poorly written AML
+			 * when the hardware does not respond within a while loop and the
+			 * loop does not implement a timeout.
+			 */
+			control_state->control.loop_count++;
+			if (control_state->control.loop_count >
+			    ACPI_MAX_LOOP_ITERATIONS) {
+				status = AE_AML_INFINITE_LOOP;
+				break;
+			}
+
+			/*
+			 * Go back and evaluate the predicate and maybe execute the loop
+			 * another time
+			 */
+			status = AE_CTRL_PENDING;
+			walk_state->aml_last_while =
+			    control_state->control.aml_predicate_start;
+			break;
+		}
+
+		/* Predicate was false, terminate this while loop */
+
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+				  "[WHILE_OP] termination! Op=%p\n", op));
+
+		/* Pop this control state and free it */
+
+		control_state =
+		    acpi_ut_pop_generic_state(&walk_state->control_state);
+		acpi_ut_delete_generic_state(control_state);
+		break;
+
+	case AML_RETURN_OP:
+
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+				  "[RETURN_OP] Op=%p Arg=%p\n", op,
+				  op->common.value.arg));
+
+		/*
+		 * One optional operand -- the return value
+		 * It can be either an immediate operand or a result that
+		 * has been bubbled up the tree
+		 */
+		if (op->common.value.arg) {
+
+			/* Since we have a real Return(), delete any implicit return */
+
+			acpi_ds_clear_implicit_return(walk_state);
+
+			/* Return statement has an immediate operand */
+
+			status =
+			    acpi_ds_create_operands(walk_state,
+						    op->common.value.arg);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+
+			/*
+			 * If value being returned is a Reference (such as
+			 * an arg or local), resolve it now because it may
+			 * cease to exist at the end of the method.
+			 */
+			status =
+			    acpi_ex_resolve_to_value(&walk_state->operands[0],
+						     walk_state);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+
+			/*
+			 * Get the return value and save as the last result
+			 * value.  This is the only place where walk_state->return_desc
+			 * is set to anything other than zero!
+			 */
+			walk_state->return_desc = walk_state->operands[0];
+		} else if (walk_state->result_count) {
+
+			/* Since we have a real Return(), delete any implicit return */
+
+			acpi_ds_clear_implicit_return(walk_state);
+
+			/*
+			 * The return value has come from a previous calculation.
+			 *
+			 * If value being returned is a Reference (such as
+			 * an arg or local), resolve it now because it may
+			 * cease to exist at the end of the method.
+			 *
+			 * Allow references created by the Index operator to return
+			 * unchanged.
+			 */
+			if ((ACPI_GET_DESCRIPTOR_TYPE
+			     (walk_state->results->results.obj_desc[0]) ==
+			     ACPI_DESC_TYPE_OPERAND)
+			    && ((walk_state->results->results.obj_desc[0])->
+				common.type == ACPI_TYPE_LOCAL_REFERENCE)
+			    && ((walk_state->results->results.obj_desc[0])->
+				reference.class != ACPI_REFCLASS_INDEX)) {
+				status =
+				    acpi_ex_resolve_to_value(&walk_state->
+							     results->results.
+							     obj_desc[0],
+							     walk_state);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+			}
+
+			walk_state->return_desc =
+			    walk_state->results->results.obj_desc[0];
+		} else {
+			/* No return operand */
+
+			if (walk_state->num_operands) {
+				acpi_ut_remove_reference(walk_state->
+							 operands[0]);
+			}
+
+			walk_state->operands[0] = NULL;
+			walk_state->num_operands = 0;
+			walk_state->return_desc = NULL;
+		}
+
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+				  "Completed RETURN_OP State=%p, RetVal=%p\n",
+				  walk_state, walk_state->return_desc));
+
+		/* End the control method execution right now */
+
+		status = AE_CTRL_TERMINATE;
+		break;
+
+	case AML_NOOP_OP:
+
+		/* Just do nothing! */
+		break;
+
+	case AML_BREAK_POINT_OP:
+
+		/*
+		 * Set the single-step flag. This will cause the debugger (if present)
+		 * to break to the console within the AML debugger at the start of the
+		 * next AML instruction.
+		 */
+		ACPI_DEBUGGER_EXEC(acpi_gbl_cm_single_step = TRUE);
+		ACPI_DEBUGGER_EXEC(acpi_os_printf
+				   ("**break** Executed AML BreakPoint opcode\n"));
+
+		/* Call to the OSL in case OS wants a piece of the action */
+
+		status = acpi_os_signal(ACPI_SIGNAL_BREAKPOINT,
+					"Executed AML Breakpoint opcode");
+		break;
+
+	case AML_BREAK_OP:
+	case AML_CONTINUE_OP:	/* ACPI 2.0 */
+
+		/* Pop and delete control states until we find a while */
+
+		while (walk_state->control_state &&
+		       (walk_state->control_state->control.opcode !=
+			AML_WHILE_OP)) {
+			control_state =
+			    acpi_ut_pop_generic_state(&walk_state->
+						      control_state);
+			acpi_ut_delete_generic_state(control_state);
+		}
+
+		/* No while found? */
+
+		if (!walk_state->control_state) {
+			return (AE_AML_NO_WHILE);
+		}
+
+		/* Was: walk_state->aml_last_while = walk_state->control_state->Control.aml_predicate_start; */
+
+		walk_state->aml_last_while =
+		    walk_state->control_state->control.package_end;
+
+		/* Return status depending on opcode */
+
+		if (op->common.aml_opcode == AML_BREAK_OP) {
+			status = AE_CTRL_BREAK;
+		} else {
+			status = AE_CTRL_CONTINUE;
+		}
+		break;
+
+	default:
+
+		ACPI_ERROR((AE_INFO, "Unknown control opcode=0x%X Op=%p",
+			    op->common.aml_opcode, op));
+
+		status = AE_AML_BAD_OPCODE;
+		break;
+	}
+
+	return (status);
+}
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index bbecf29..c627a28 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -1,7 +1,6 @@
 /******************************************************************************
  *
- * Module Name: dsopcode - Dispatcher Op Region support and handling of
- *                         "control" opcodes
+ * Module Name: dsopcode - Dispatcher suport for regions and fields
  *
  *****************************************************************************/
 
@@ -57,11 +56,6 @@ ACPI_MODULE_NAME("dsopcode")
 
 /* Local prototypes */
 static acpi_status
-acpi_ds_execute_arguments(struct acpi_namespace_node *node,
-			  struct acpi_namespace_node *scope_node,
-			  u32 aml_length, u8 * aml_start);
-
-static acpi_status
 acpi_ds_init_buffer_field(u16 aml_opcode,
 			  union acpi_operand_object *obj_desc,
 			  union acpi_operand_object *buffer_desc,
@@ -71,361 +65,6 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ds_execute_arguments
- *
- * PARAMETERS:  Node                - Object NS node
- *              scope_node          - Parent NS node
- *              aml_length          - Length of executable AML
- *              aml_start           - Pointer to the AML
- *
- * RETURN:      Status.
- *
- * DESCRIPTION: Late (deferred) execution of region or field arguments
- *
- ******************************************************************************/
-
-static acpi_status
-acpi_ds_execute_arguments(struct acpi_namespace_node *node,
-			  struct acpi_namespace_node *scope_node,
-			  u32 aml_length, u8 * aml_start)
-{
-	acpi_status status;
-	union acpi_parse_object *op;
-	struct acpi_walk_state *walk_state;
-
-	ACPI_FUNCTION_TRACE(ds_execute_arguments);
-
-	/*
-	 * Allocate a new parser op to be the root of the parsed tree
-	 */
-	op = acpi_ps_alloc_op(AML_INT_EVAL_SUBTREE_OP);
-	if (!op) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	/* Save the Node for use in acpi_ps_parse_aml */
-
-	op->common.node = scope_node;
-
-	/* Create and initialize a new parser state */
-
-	walk_state = acpi_ds_create_walk_state(0, NULL, NULL, NULL);
-	if (!walk_state) {
-		status = AE_NO_MEMORY;
-		goto cleanup;
-	}
-
-	status = acpi_ds_init_aml_walk(walk_state, op, NULL, aml_start,
-				       aml_length, NULL, ACPI_IMODE_LOAD_PASS1);
-	if (ACPI_FAILURE(status)) {
-		acpi_ds_delete_walk_state(walk_state);
-		goto cleanup;
-	}
-
-	/* Mark this parse as a deferred opcode */
-
-	walk_state->parse_flags = ACPI_PARSE_DEFERRED_OP;
-	walk_state->deferred_node = node;
-
-	/* Pass1: Parse the entire declaration */
-
-	status = acpi_ps_parse_aml(walk_state);
-	if (ACPI_FAILURE(status)) {
-		goto cleanup;
-	}
-
-	/* Get and init the Op created above */
-
-	op->common.node = node;
-	acpi_ps_delete_parse_tree(op);
-
-	/* Evaluate the deferred arguments */
-
-	op = acpi_ps_alloc_op(AML_INT_EVAL_SUBTREE_OP);
-	if (!op) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	op->common.node = scope_node;
-
-	/* Create and initialize a new parser state */
-
-	walk_state = acpi_ds_create_walk_state(0, NULL, NULL, NULL);
-	if (!walk_state) {
-		status = AE_NO_MEMORY;
-		goto cleanup;
-	}
-
-	/* Execute the opcode and arguments */
-
-	status = acpi_ds_init_aml_walk(walk_state, op, NULL, aml_start,
-				       aml_length, NULL, ACPI_IMODE_EXECUTE);
-	if (ACPI_FAILURE(status)) {
-		acpi_ds_delete_walk_state(walk_state);
-		goto cleanup;
-	}
-
-	/* Mark this execution as a deferred opcode */
-
-	walk_state->deferred_node = node;
-	status = acpi_ps_parse_aml(walk_state);
-
-      cleanup:
-	acpi_ps_delete_parse_tree(op);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_get_buffer_field_arguments
- *
- * PARAMETERS:  obj_desc        - A valid buffer_field object
- *
- * RETURN:      Status.
- *
- * DESCRIPTION: Get buffer_field Buffer and Index. This implements the late
- *              evaluation of these field attributes.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
-{
-	union acpi_operand_object *extra_desc;
-	struct acpi_namespace_node *node;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE_PTR(ds_get_buffer_field_arguments, obj_desc);
-
-	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Get the AML pointer (method object) and buffer_field node */
-
-	extra_desc = acpi_ns_get_secondary_object(obj_desc);
-	node = obj_desc->buffer_field.node;
-
-	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
-			(ACPI_TYPE_BUFFER_FIELD, node, NULL));
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] BufferField Arg Init\n",
-			  acpi_ut_get_node_name(node)));
-
-	/* Execute the AML code for the term_arg arguments */
-
-	status = acpi_ds_execute_arguments(node, node->parent,
-					   extra_desc->extra.aml_length,
-					   extra_desc->extra.aml_start);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_get_bank_field_arguments
- *
- * PARAMETERS:  obj_desc        - A valid bank_field object
- *
- * RETURN:      Status.
- *
- * DESCRIPTION: Get bank_field bank_value. This implements the late
- *              evaluation of these field attributes.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
-{
-	union acpi_operand_object *extra_desc;
-	struct acpi_namespace_node *node;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE_PTR(ds_get_bank_field_arguments, obj_desc);
-
-	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Get the AML pointer (method object) and bank_field node */
-
-	extra_desc = acpi_ns_get_secondary_object(obj_desc);
-	node = obj_desc->bank_field.node;
-
-	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
-			(ACPI_TYPE_LOCAL_BANK_FIELD, node, NULL));
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] BankField Arg Init\n",
-			  acpi_ut_get_node_name(node)));
-
-	/* Execute the AML code for the term_arg arguments */
-
-	status = acpi_ds_execute_arguments(node, node->parent,
-					   extra_desc->extra.aml_length,
-					   extra_desc->extra.aml_start);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_get_buffer_arguments
- *
- * PARAMETERS:  obj_desc        - A valid Buffer object
- *
- * RETURN:      Status.
- *
- * DESCRIPTION: Get Buffer length and initializer byte list.  This implements
- *              the late evaluation of these attributes.
- *
- ******************************************************************************/
-
-acpi_status acpi_ds_get_buffer_arguments(union acpi_operand_object *obj_desc)
-{
-	struct acpi_namespace_node *node;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE_PTR(ds_get_buffer_arguments, obj_desc);
-
-	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Get the Buffer node */
-
-	node = obj_desc->buffer.node;
-	if (!node) {
-		ACPI_ERROR((AE_INFO,
-			    "No pointer back to namespace node in buffer object %p",
-			    obj_desc));
-		return_ACPI_STATUS(AE_AML_INTERNAL);
-	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Buffer Arg Init\n"));
-
-	/* Execute the AML code for the term_arg arguments */
-
-	status = acpi_ds_execute_arguments(node, node,
-					   obj_desc->buffer.aml_length,
-					   obj_desc->buffer.aml_start);
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_get_package_arguments
- *
- * PARAMETERS:  obj_desc        - A valid Package object
- *
- * RETURN:      Status.
- *
- * DESCRIPTION: Get Package length and initializer byte list.  This implements
- *              the late evaluation of these attributes.
- *
- ******************************************************************************/
-
-acpi_status acpi_ds_get_package_arguments(union acpi_operand_object *obj_desc)
-{
-	struct acpi_namespace_node *node;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE_PTR(ds_get_package_arguments, obj_desc);
-
-	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Get the Package node */
-
-	node = obj_desc->package.node;
-	if (!node) {
-		ACPI_ERROR((AE_INFO,
-			    "No pointer back to namespace node in package %p",
-			    obj_desc));
-		return_ACPI_STATUS(AE_AML_INTERNAL);
-	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Package Arg Init\n"));
-
-	/* Execute the AML code for the term_arg arguments */
-
-	status = acpi_ds_execute_arguments(node, node,
-					   obj_desc->package.aml_length,
-					   obj_desc->package.aml_start);
-	return_ACPI_STATUS(status);
-}
-
-/*****************************************************************************
- *
- * FUNCTION:    acpi_ds_get_region_arguments
- *
- * PARAMETERS:  obj_desc        - A valid region object
- *
- * RETURN:      Status.
- *
- * DESCRIPTION: Get region address and length.  This implements the late
- *              evaluation of these region attributes.
- *
- ****************************************************************************/
-
-acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
-{
-	struct acpi_namespace_node *node;
-	acpi_status status;
-	union acpi_operand_object *extra_desc;
-
-	ACPI_FUNCTION_TRACE_PTR(ds_get_region_arguments, obj_desc);
-
-	if (obj_desc->region.flags & AOPOBJ_DATA_VALID) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	extra_desc = acpi_ns_get_secondary_object(obj_desc);
-	if (!extra_desc) {
-		return_ACPI_STATUS(AE_NOT_EXIST);
-	}
-
-	/* Get the Region node */
-
-	node = obj_desc->region.node;
-
-	ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
-			(ACPI_TYPE_REGION, node, NULL));
-
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "[%4.4s] OpRegion Arg Init at AML %p\n",
-			  acpi_ut_get_node_name(node),
-			  extra_desc->extra.aml_start));
-
-	/* Execute the argument AML */
-
-	status = acpi_ds_execute_arguments(node, node->parent,
-					   extra_desc->extra.aml_length,
-					   extra_desc->extra.aml_start);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Validate the region address/length via the host OS */
-
-	status = acpi_os_validate_address(obj_desc->region.space_id,
-					  obj_desc->region.address,
-					  (acpi_size) obj_desc->region.length,
-					  acpi_ut_get_node_name(node));
-
-	if (ACPI_FAILURE(status)) {
-		/*
-		 * Invalid address/length. We will emit an error message and mark
-		 * the region as invalid, so that it will cause an additional error if
-		 * it is ever used. Then return AE_OK.
-		 */
-		ACPI_EXCEPTION((AE_INFO, status,
-				"During address validation of OpRegion [%4.4s]",
-				node->name.ascii));
-		obj_desc->common.flags |= AOPOBJ_INVALID;
-		status = AE_OK;
-	}
-
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ds_initialize_region
  *
  * PARAMETERS:  obj_handle      - Region namespace node
@@ -826,8 +465,9 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Get region address and length
- *              Called from acpi_ds_exec_end_op during data_table_region parse tree walk
+ * DESCRIPTION: Get region address and length.
+ *              Called from acpi_ds_exec_end_op during data_table_region parse
+ *              tree walk.
  *
  ******************************************************************************/
 
@@ -1114,360 +754,3 @@ acpi_ds_eval_bank_field_operands(struct acpi_walk_state *walk_state,
 	acpi_ut_remove_reference(operand_desc);
 	return_ACPI_STATUS(status);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_exec_begin_control_op
- *
- * PARAMETERS:  walk_list       - The list that owns the walk stack
- *              Op              - The control Op
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Handles all control ops encountered during control method
- *              execution.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
-			      union acpi_parse_object *op)
-{
-	acpi_status status = AE_OK;
-	union acpi_generic_state *control_state;
-
-	ACPI_FUNCTION_NAME(ds_exec_begin_control_op);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Op=%p Opcode=%2.2X State=%p\n", op,
-			  op->common.aml_opcode, walk_state));
-
-	switch (op->common.aml_opcode) {
-	case AML_WHILE_OP:
-
-		/*
-		 * If this is an additional iteration of a while loop, continue.
-		 * There is no need to allocate a new control state.
-		 */
-		if (walk_state->control_state) {
-			if (walk_state->control_state->control.aml_predicate_start
-				== (walk_state->parser_state.aml - 1)) {
-
-				/* Reset the state to start-of-loop */
-
-				walk_state->control_state->common.state =
-				    ACPI_CONTROL_CONDITIONAL_EXECUTING;
-				break;
-			}
-		}
-
-		/*lint -fallthrough */
-
-	case AML_IF_OP:
-
-		/*
-		 * IF/WHILE: Create a new control state to manage these
-		 * constructs. We need to manage these as a stack, in order
-		 * to handle nesting.
-		 */
-		control_state = acpi_ut_create_control_state();
-		if (!control_state) {
-			status = AE_NO_MEMORY;
-			break;
-		}
-		/*
-		 * Save a pointer to the predicate for multiple executions
-		 * of a loop
-		 */
-		control_state->control.aml_predicate_start =
-		    walk_state->parser_state.aml - 1;
-		control_state->control.package_end =
-		    walk_state->parser_state.pkg_end;
-		control_state->control.opcode = op->common.aml_opcode;
-
-		/* Push the control state on this walk's control stack */
-
-		acpi_ut_push_generic_state(&walk_state->control_state,
-					   control_state);
-		break;
-
-	case AML_ELSE_OP:
-
-		/* Predicate is in the state object */
-		/* If predicate is true, the IF was executed, ignore ELSE part */
-
-		if (walk_state->last_predicate) {
-			status = AE_CTRL_TRUE;
-		}
-
-		break;
-
-	case AML_RETURN_OP:
-
-		break;
-
-	default:
-		break;
-	}
-
-	return (status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_exec_end_control_op
- *
- * PARAMETERS:  walk_list       - The list that owns the walk stack
- *              Op              - The control Op
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Handles all control ops encountered during control method
- *              execution.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
-			    union acpi_parse_object * op)
-{
-	acpi_status status = AE_OK;
-	union acpi_generic_state *control_state;
-
-	ACPI_FUNCTION_NAME(ds_exec_end_control_op);
-
-	switch (op->common.aml_opcode) {
-	case AML_IF_OP:
-
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "[IF_OP] Op=%p\n", op));
-
-		/*
-		 * Save the result of the predicate in case there is an
-		 * ELSE to come
-		 */
-		walk_state->last_predicate =
-		    (u8) walk_state->control_state->common.value;
-
-		/*
-		 * Pop the control state that was created at the start
-		 * of the IF and free it
-		 */
-		control_state =
-		    acpi_ut_pop_generic_state(&walk_state->control_state);
-		acpi_ut_delete_generic_state(control_state);
-		break;
-
-	case AML_ELSE_OP:
-
-		break;
-
-	case AML_WHILE_OP:
-
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "[WHILE_OP] Op=%p\n", op));
-
-		control_state = walk_state->control_state;
-		if (control_state->common.value) {
-
-			/* Predicate was true, the body of the loop was just executed */
-
-			/*
-			 * This loop counter mechanism allows the interpreter to escape
-			 * possibly infinite loops. This can occur in poorly written AML
-			 * when the hardware does not respond within a while loop and the
-			 * loop does not implement a timeout.
-			 */
-			control_state->control.loop_count++;
-			if (control_state->control.loop_count >
-				ACPI_MAX_LOOP_ITERATIONS) {
-				status = AE_AML_INFINITE_LOOP;
-				break;
-			}
-
-			/*
-			 * Go back and evaluate the predicate and maybe execute the loop
-			 * another time
-			 */
-			status = AE_CTRL_PENDING;
-			walk_state->aml_last_while =
-			    control_state->control.aml_predicate_start;
-			break;
-		}
-
-		/* Predicate was false, terminate this while loop */
-
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "[WHILE_OP] termination! Op=%p\n", op));
-
-		/* Pop this control state and free it */
-
-		control_state =
-		    acpi_ut_pop_generic_state(&walk_state->control_state);
-		acpi_ut_delete_generic_state(control_state);
-		break;
-
-	case AML_RETURN_OP:
-
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "[RETURN_OP] Op=%p Arg=%p\n", op,
-				  op->common.value.arg));
-
-		/*
-		 * One optional operand -- the return value
-		 * It can be either an immediate operand or a result that
-		 * has been bubbled up the tree
-		 */
-		if (op->common.value.arg) {
-
-			/* Since we have a real Return(), delete any implicit return */
-
-			acpi_ds_clear_implicit_return(walk_state);
-
-			/* Return statement has an immediate operand */
-
-			status =
-			    acpi_ds_create_operands(walk_state,
-						    op->common.value.arg);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
-
-			/*
-			 * If value being returned is a Reference (such as
-			 * an arg or local), resolve it now because it may
-			 * cease to exist at the end of the method.
-			 */
-			status =
-			    acpi_ex_resolve_to_value(&walk_state->operands[0],
-						     walk_state);
-			if (ACPI_FAILURE(status)) {
-				return (status);
-			}
-
-			/*
-			 * Get the return value and save as the last result
-			 * value.  This is the only place where walk_state->return_desc
-			 * is set to anything other than zero!
-			 */
-			walk_state->return_desc = walk_state->operands[0];
-		} else if (walk_state->result_count) {
-
-			/* Since we have a real Return(), delete any implicit return */
-
-			acpi_ds_clear_implicit_return(walk_state);
-
-			/*
-			 * The return value has come from a previous calculation.
-			 *
-			 * If value being returned is a Reference (such as
-			 * an arg or local), resolve it now because it may
-			 * cease to exist at the end of the method.
-			 *
-			 * Allow references created by the Index operator to return unchanged.
-			 */
-			if ((ACPI_GET_DESCRIPTOR_TYPE
-			     (walk_state->results->results.obj_desc[0]) ==
-			     ACPI_DESC_TYPE_OPERAND)
-			    && ((walk_state->results->results.obj_desc[0])->
-				common.type == ACPI_TYPE_LOCAL_REFERENCE)
-			    && ((walk_state->results->results.obj_desc[0])->
-				reference.class != ACPI_REFCLASS_INDEX)) {
-				status =
-				    acpi_ex_resolve_to_value(&walk_state->
-							     results->results.
-							     obj_desc[0],
-							     walk_state);
-				if (ACPI_FAILURE(status)) {
-					return (status);
-				}
-			}
-
-			walk_state->return_desc =
-			    walk_state->results->results.obj_desc[0];
-		} else {
-			/* No return operand */
-
-			if (walk_state->num_operands) {
-				acpi_ut_remove_reference(walk_state->
-							 operands[0]);
-			}
-
-			walk_state->operands[0] = NULL;
-			walk_state->num_operands = 0;
-			walk_state->return_desc = NULL;
-		}
-
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "Completed RETURN_OP State=%p, RetVal=%p\n",
-				  walk_state, walk_state->return_desc));
-
-		/* End the control method execution right now */
-
-		status = AE_CTRL_TERMINATE;
-		break;
-
-	case AML_NOOP_OP:
-
-		/* Just do nothing! */
-		break;
-
-	case AML_BREAK_POINT_OP:
-
-		/*
-		 * Set the single-step flag. This will cause the debugger (if present)
-		 * to break to the console within the AML debugger at the start of the
-		 * next AML instruction.
-		 */
-		ACPI_DEBUGGER_EXEC(acpi_gbl_cm_single_step = TRUE);
-		ACPI_DEBUGGER_EXEC(acpi_os_printf
-				   ("**break** Executed AML BreakPoint opcode\n"));
-
-		/* Call to the OSL in case OS wants a piece of the action */
-
-		status = acpi_os_signal(ACPI_SIGNAL_BREAKPOINT,
-					"Executed AML Breakpoint opcode");
-		break;
-
-	case AML_BREAK_OP:
-	case AML_CONTINUE_OP:	/* ACPI 2.0 */
-
-		/* Pop and delete control states until we find a while */
-
-		while (walk_state->control_state &&
-		       (walk_state->control_state->control.opcode !=
-			AML_WHILE_OP)) {
-			control_state =
-			    acpi_ut_pop_generic_state(&walk_state->
-						      control_state);
-			acpi_ut_delete_generic_state(control_state);
-		}
-
-		/* No while found? */
-
-		if (!walk_state->control_state) {
-			return (AE_AML_NO_WHILE);
-		}
-
-		/* Was: walk_state->aml_last_while = walk_state->control_state->Control.aml_predicate_start; */
-
-		walk_state->aml_last_while =
-		    walk_state->control_state->control.package_end;
-
-		/* Return status depending on opcode */
-
-		if (op->common.aml_opcode == AML_BREAK_OP) {
-			status = AE_CTRL_BREAK;
-		} else {
-			status = AE_CTRL_CONTINUE;
-		}
-		break;
-
-	default:
-
-		ACPI_ERROR((AE_INFO, "Unknown control opcode=0x%X Op=%p",
-			    op->common.aml_opcode, op));
-
-		status = AE_AML_BAD_OPCODE;
-		break;
-	}
-
-	return (status);
-}
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 52566ff..23a3b1a 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Module Name: dswload - Dispatcher namespace load callbacks
+ * Module Name: dswload - Dispatcher first pass namespace load callbacks
  *
  *****************************************************************************/
 
@@ -48,7 +48,6 @@
 #include "acdispat.h"
 #include "acinterp.h"
 #include "acnamesp.h"
-#include "acevents.h"
 
 #ifdef ACPI_ASL_COMPILER
 #include <acpi/acdisasm.h>
@@ -537,670 +536,3 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 
 	return_ACPI_STATUS(status);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_load2_begin_op
- *
- * PARAMETERS:  walk_state      - Current state of the parse tree walk
- *              out_op          - Wher to return op if a new one is created
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Descending callback used during the loading of ACPI tables.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
-		       union acpi_parse_object **out_op)
-{
-	union acpi_parse_object *op;
-	struct acpi_namespace_node *node;
-	acpi_status status;
-	acpi_object_type object_type;
-	char *buffer_ptr;
-	u32 flags;
-
-	ACPI_FUNCTION_TRACE(ds_load2_begin_op);
-
-	op = walk_state->op;
-	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Op=%p State=%p\n", op,
-			  walk_state));
-
-	if (op) {
-		if ((walk_state->control_state) &&
-		    (walk_state->control_state->common.state ==
-		     ACPI_CONTROL_CONDITIONAL_EXECUTING)) {
-
-			/* We are executing a while loop outside of a method */
-
-			status = acpi_ds_exec_begin_op(walk_state, out_op);
-			return_ACPI_STATUS(status);
-		}
-
-		/* We only care about Namespace opcodes here */
-
-		if ((!(walk_state->op_info->flags & AML_NSOPCODE) &&
-		     (walk_state->opcode != AML_INT_NAMEPATH_OP)) ||
-		    (!(walk_state->op_info->flags & AML_NAMED))) {
-			return_ACPI_STATUS(AE_OK);
-		}
-
-		/* Get the name we are going to enter or lookup in the namespace */
-
-		if (walk_state->opcode == AML_INT_NAMEPATH_OP) {
-
-			/* For Namepath op, get the path string */
-
-			buffer_ptr = op->common.value.string;
-			if (!buffer_ptr) {
-
-				/* No name, just exit */
-
-				return_ACPI_STATUS(AE_OK);
-			}
-		} else {
-			/* Get name from the op */
-
-			buffer_ptr = ACPI_CAST_PTR(char, &op->named.name);
-		}
-	} else {
-		/* Get the namestring from the raw AML */
-
-		buffer_ptr =
-		    acpi_ps_get_next_namestring(&walk_state->parser_state);
-	}
-
-	/* Map the opcode into an internal object type */
-
-	object_type = walk_state->op_info->object_type;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "State=%p Op=%p Type=%X\n", walk_state, op,
-			  object_type));
-
-	switch (walk_state->opcode) {
-	case AML_FIELD_OP:
-	case AML_BANK_FIELD_OP:
-	case AML_INDEX_FIELD_OP:
-
-		node = NULL;
-		status = AE_OK;
-		break;
-
-	case AML_INT_NAMEPATH_OP:
-		/*
-		 * The name_path is an object reference to an existing object.
-		 * Don't enter the name into the namespace, but look it up
-		 * for use later.
-		 */
-		status =
-		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
-				   object_type, ACPI_IMODE_EXECUTE,
-				   ACPI_NS_SEARCH_PARENT, walk_state, &(node));
-		break;
-
-	case AML_SCOPE_OP:
-
-		/* Special case for Scope(\) -> refers to the Root node */
-
-		if (op && (op->named.node == acpi_gbl_root_node)) {
-			node = op->named.node;
-
-			status =
-			    acpi_ds_scope_stack_push(node, object_type,
-						     walk_state);
-			if (ACPI_FAILURE(status)) {
-				return_ACPI_STATUS(status);
-			}
-		} else {
-			/*
-			 * The Path is an object reference to an existing object.
-			 * Don't enter the name into the namespace, but look it up
-			 * for use later.
-			 */
-			status =
-			    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
-					   object_type, ACPI_IMODE_EXECUTE,
-					   ACPI_NS_SEARCH_PARENT, walk_state,
-					   &(node));
-			if (ACPI_FAILURE(status)) {
-#ifdef ACPI_ASL_COMPILER
-				if (status == AE_NOT_FOUND) {
-					status = AE_OK;
-				} else {
-					ACPI_ERROR_NAMESPACE(buffer_ptr,
-							     status);
-				}
-#else
-				ACPI_ERROR_NAMESPACE(buffer_ptr, status);
-#endif
-				return_ACPI_STATUS(status);
-			}
-		}
-
-		/*
-		 * We must check to make sure that the target is
-		 * one of the opcodes that actually opens a scope
-		 */
-		switch (node->type) {
-		case ACPI_TYPE_ANY:
-		case ACPI_TYPE_LOCAL_SCOPE:	/* Scope */
-		case ACPI_TYPE_DEVICE:
-		case ACPI_TYPE_POWER:
-		case ACPI_TYPE_PROCESSOR:
-		case ACPI_TYPE_THERMAL:
-
-			/* These are acceptable types */
-			break;
-
-		case ACPI_TYPE_INTEGER:
-		case ACPI_TYPE_STRING:
-		case ACPI_TYPE_BUFFER:
-
-			/*
-			 * These types we will allow, but we will change the type.
-			 * This enables some existing code of the form:
-			 *
-			 *  Name (DEB, 0)
-			 *  Scope (DEB) { ... }
-			 */
-			ACPI_WARNING((AE_INFO,
-				      "Type override - [%4.4s] had invalid type (%s) "
-				      "for Scope operator, changed to type ANY\n",
-				      acpi_ut_get_node_name(node),
-				      acpi_ut_get_type_name(node->type)));
-
-			node->type = ACPI_TYPE_ANY;
-			walk_state->scope_info->common.value = ACPI_TYPE_ANY;
-			break;
-
-		default:
-
-			/* All other types are an error */
-
-			ACPI_ERROR((AE_INFO,
-				    "Invalid type (%s) for target of "
-				    "Scope operator [%4.4s] (Cannot override)",
-				    acpi_ut_get_type_name(node->type),
-				    acpi_ut_get_node_name(node)));
-
-			return (AE_AML_OPERAND_TYPE);
-		}
-		break;
-
-	default:
-
-		/* All other opcodes */
-
-		if (op && op->common.node) {
-
-			/* This op/node was previously entered into the namespace */
-
-			node = op->common.node;
-
-			if (acpi_ns_opens_scope(object_type)) {
-				status =
-				    acpi_ds_scope_stack_push(node, object_type,
-							     walk_state);
-				if (ACPI_FAILURE(status)) {
-					return_ACPI_STATUS(status);
-				}
-			}
-
-			return_ACPI_STATUS(AE_OK);
-		}
-
-		/*
-		 * Enter the named type into the internal namespace. We enter the name
-		 * as we go downward in the parse tree. Any necessary subobjects that
-		 * involve arguments to the opcode must be created as we go back up the
-		 * parse tree later.
-		 *
-		 * Note: Name may already exist if we are executing a deferred opcode.
-		 */
-		if (walk_state->deferred_node) {
-
-			/* This name is already in the namespace, get the node */
-
-			node = walk_state->deferred_node;
-			status = AE_OK;
-			break;
-		}
-
-		flags = ACPI_NS_NO_UPSEARCH;
-		if (walk_state->pass_number == ACPI_IMODE_EXECUTE) {
-
-			/* Execution mode, node cannot already exist, node is temporary */
-
-			flags |= ACPI_NS_ERROR_IF_FOUND;
-
-			if (!
-			    (walk_state->
-			     parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
-				flags |= ACPI_NS_TEMPORARY;
-			}
-		}
-
-		/* Add new entry or lookup existing entry */
-
-		status =
-		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
-				   object_type, ACPI_IMODE_LOAD_PASS2, flags,
-				   walk_state, &node);
-
-		if (ACPI_SUCCESS(status) && (flags & ACPI_NS_TEMPORARY)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-					  "***New Node [%4.4s] %p is temporary\n",
-					  acpi_ut_get_node_name(node), node));
-		}
-		break;
-	}
-
-	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR_NAMESPACE(buffer_ptr, status);
-		return_ACPI_STATUS(status);
-	}
-
-	if (!op) {
-
-		/* Create a new op */
-
-		op = acpi_ps_alloc_op(walk_state->opcode);
-		if (!op) {
-			return_ACPI_STATUS(AE_NO_MEMORY);
-		}
-
-		/* Initialize the new op */
-
-		if (node) {
-			op->named.name = node->name.integer;
-		}
-		*out_op = op;
-	}
-
-	/*
-	 * Put the Node in the "op" object that the parser uses, so we
-	 * can get it again quickly when this scope is closed
-	 */
-	op->common.node = node;
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ds_load2_end_op
- *
- * PARAMETERS:  walk_state      - Current state of the parse tree walk
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Ascending callback used during the loading of the namespace,
- *              both control methods and everything else.
- *
- ******************************************************************************/
-
-acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
-{
-	union acpi_parse_object *op;
-	acpi_status status = AE_OK;
-	acpi_object_type object_type;
-	struct acpi_namespace_node *node;
-	union acpi_parse_object *arg;
-	struct acpi_namespace_node *new_node;
-#ifndef ACPI_NO_METHOD_EXECUTION
-	u32 i;
-	u8 region_space;
-#endif
-
-	ACPI_FUNCTION_TRACE(ds_load2_end_op);
-
-	op = walk_state->op;
-	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Opcode [%s] Op %p State %p\n",
-			  walk_state->op_info->name, op, walk_state));
-
-	/* Check if opcode had an associated namespace object */
-
-	if (!(walk_state->op_info->flags & AML_NSOBJECT)) {
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	if (op->common.aml_opcode == AML_SCOPE_OP) {
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "Ending scope Op=%p State=%p\n", op,
-				  walk_state));
-	}
-
-	object_type = walk_state->op_info->object_type;
-
-	/*
-	 * Get the Node/name from the earlier lookup
-	 * (It was saved in the *op structure)
-	 */
-	node = op->common.node;
-
-	/*
-	 * Put the Node on the object stack (Contains the ACPI Name of
-	 * this object)
-	 */
-	walk_state->operands[0] = (void *)node;
-	walk_state->num_operands = 1;
-
-	/* Pop the scope stack */
-
-	if (acpi_ns_opens_scope(object_type) &&
-	    (op->common.aml_opcode != AML_INT_METHODCALL_OP)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "(%s) Popping scope for Op %p\n",
-				  acpi_ut_get_type_name(object_type), op));
-
-		status = acpi_ds_scope_stack_pop(walk_state);
-		if (ACPI_FAILURE(status)) {
-			goto cleanup;
-		}
-	}
-
-	/*
-	 * Named operations are as follows:
-	 *
-	 * AML_ALIAS
-	 * AML_BANKFIELD
-	 * AML_CREATEBITFIELD
-	 * AML_CREATEBYTEFIELD
-	 * AML_CREATEDWORDFIELD
-	 * AML_CREATEFIELD
-	 * AML_CREATEQWORDFIELD
-	 * AML_CREATEWORDFIELD
-	 * AML_DATA_REGION
-	 * AML_DEVICE
-	 * AML_EVENT
-	 * AML_FIELD
-	 * AML_INDEXFIELD
-	 * AML_METHOD
-	 * AML_METHODCALL
-	 * AML_MUTEX
-	 * AML_NAME
-	 * AML_NAMEDFIELD
-	 * AML_OPREGION
-	 * AML_POWERRES
-	 * AML_PROCESSOR
-	 * AML_SCOPE
-	 * AML_THERMALZONE
-	 */
-
-	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "Create-Load [%s] State=%p Op=%p NamedObj=%p\n",
-			  acpi_ps_get_opcode_name(op->common.aml_opcode),
-			  walk_state, op, node));
-
-	/* Decode the opcode */
-
-	arg = op->common.value.arg;
-
-	switch (walk_state->op_info->type) {
-#ifndef ACPI_NO_METHOD_EXECUTION
-
-	case AML_TYPE_CREATE_FIELD:
-		/*
-		 * Create the field object, but the field buffer and index must
-		 * be evaluated later during the execution phase
-		 */
-		status = acpi_ds_create_buffer_field(op, walk_state);
-		break;
-
-	case AML_TYPE_NAMED_FIELD:
-		/*
-		 * If we are executing a method, initialize the field
-		 */
-		if (walk_state->method_node) {
-			status = acpi_ds_init_field_objects(op, walk_state);
-		}
-
-		switch (op->common.aml_opcode) {
-		case AML_INDEX_FIELD_OP:
-
-			status =
-			    acpi_ds_create_index_field(op,
-						       (acpi_handle) arg->
-						       common.node, walk_state);
-			break;
-
-		case AML_BANK_FIELD_OP:
-
-			status =
-			    acpi_ds_create_bank_field(op, arg->common.node,
-						      walk_state);
-			break;
-
-		case AML_FIELD_OP:
-
-			status =
-			    acpi_ds_create_field(op, arg->common.node,
-						 walk_state);
-			break;
-
-		default:
-			/* All NAMED_FIELD opcodes must be handled above */
-			break;
-		}
-		break;
-
-	case AML_TYPE_NAMED_SIMPLE:
-
-		status = acpi_ds_create_operands(walk_state, arg);
-		if (ACPI_FAILURE(status)) {
-			goto cleanup;
-		}
-
-		switch (op->common.aml_opcode) {
-		case AML_PROCESSOR_OP:
-
-			status = acpi_ex_create_processor(walk_state);
-			break;
-
-		case AML_POWER_RES_OP:
-
-			status = acpi_ex_create_power_resource(walk_state);
-			break;
-
-		case AML_MUTEX_OP:
-
-			status = acpi_ex_create_mutex(walk_state);
-			break;
-
-		case AML_EVENT_OP:
-
-			status = acpi_ex_create_event(walk_state);
-			break;
-
-		case AML_ALIAS_OP:
-
-			status = acpi_ex_create_alias(walk_state);
-			break;
-
-		default:
-			/* Unknown opcode */
-
-			status = AE_OK;
-			goto cleanup;
-		}
-
-		/* Delete operands */
-
-		for (i = 1; i < walk_state->num_operands; i++) {
-			acpi_ut_remove_reference(walk_state->operands[i]);
-			walk_state->operands[i] = NULL;
-		}
-
-		break;
-#endif				/* ACPI_NO_METHOD_EXECUTION */
-
-	case AML_TYPE_NAMED_COMPLEX:
-
-		switch (op->common.aml_opcode) {
-#ifndef ACPI_NO_METHOD_EXECUTION
-		case AML_REGION_OP:
-		case AML_DATA_REGION_OP:
-
-			if (op->common.aml_opcode == AML_REGION_OP) {
-				region_space = (acpi_adr_space_type)
-				    ((op->common.value.arg)->common.value.
-				     integer);
-			} else {
-				region_space = REGION_DATA_TABLE;
-			}
-
-			/*
-			 * The op_region is not fully parsed at this time. The only valid
-			 * argument is the space_id. (We must save the address of the
-			 * AML of the address and length operands)
-			 *
-			 * If we have a valid region, initialize it. The namespace is
-			 * unlocked at this point.
-			 *
-			 * Need to unlock interpreter if it is locked (if we are running
-			 * a control method), in order to allow _REG methods to be run
-			 * during acpi_ev_initialize_region.
-			 */
-			if (walk_state->method_node) {
-				/*
-				 * Executing a method: initialize the region and unlock
-				 * the interpreter
-				 */
-				status =
-				    acpi_ex_create_region(op->named.data,
-							  op->named.length,
-							  region_space,
-							  walk_state);
-				if (ACPI_FAILURE(status)) {
-					return (status);
-				}
-
-				acpi_ex_exit_interpreter();
-			}
-
-			status =
-			    acpi_ev_initialize_region
-			    (acpi_ns_get_attached_object(node), FALSE);
-			if (walk_state->method_node) {
-				acpi_ex_enter_interpreter();
-			}
-
-			if (ACPI_FAILURE(status)) {
-				/*
-				 *  If AE_NOT_EXIST is returned, it is not fatal
-				 *  because many regions get created before a handler
-				 *  is installed for said region.
-				 */
-				if (AE_NOT_EXIST == status) {
-					status = AE_OK;
-				}
-			}
-			break;
-
-		case AML_NAME_OP:
-
-			status = acpi_ds_create_node(walk_state, node, op);
-			break;
-
-		case AML_METHOD_OP:
-			/*
-			 * method_op pkg_length name_string method_flags term_list
-			 *
-			 * Note: We must create the method node/object pair as soon as we
-			 * see the method declaration. This allows later pass1 parsing
-			 * of invocations of the method (need to know the number of
-			 * arguments.)
-			 */
-			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-					  "LOADING-Method: State=%p Op=%p NamedObj=%p\n",
-					  walk_state, op, op->named.node));
-
-			if (!acpi_ns_get_attached_object(op->named.node)) {
-				walk_state->operands[0] =
-				    ACPI_CAST_PTR(void, op->named.node);
-				walk_state->num_operands = 1;
-
-				status =
-				    acpi_ds_create_operands(walk_state,
-							    op->common.value.
-							    arg);
-				if (ACPI_SUCCESS(status)) {
-					status =
-					    acpi_ex_create_method(op->named.
-								  data,
-								  op->named.
-								  length,
-								  walk_state);
-				}
-				walk_state->operands[0] = NULL;
-				walk_state->num_operands = 0;
-
-				if (ACPI_FAILURE(status)) {
-					return_ACPI_STATUS(status);
-				}
-			}
-			break;
-
-#endif				/* ACPI_NO_METHOD_EXECUTION */
-
-		default:
-			/* All NAMED_COMPLEX opcodes must be handled above */
-			break;
-		}
-		break;
-
-	case AML_CLASS_INTERNAL:
-
-		/* case AML_INT_NAMEPATH_OP: */
-		break;
-
-	case AML_CLASS_METHOD_CALL:
-
-		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "RESOLVING-MethodCall: State=%p Op=%p NamedObj=%p\n",
-				  walk_state, op, node));
-
-		/*
-		 * Lookup the method name and save the Node
-		 */
-		status =
-		    acpi_ns_lookup(walk_state->scope_info,
-				   arg->common.value.string, ACPI_TYPE_ANY,
-				   ACPI_IMODE_LOAD_PASS2,
-				   ACPI_NS_SEARCH_PARENT |
-				   ACPI_NS_DONT_OPEN_SCOPE, walk_state,
-				   &(new_node));
-		if (ACPI_SUCCESS(status)) {
-			/*
-			 * Make sure that what we found is indeed a method
-			 * We didn't search for a method on purpose, to see if the name
-			 * would resolve
-			 */
-			if (new_node->type != ACPI_TYPE_METHOD) {
-				status = AE_AML_OPERAND_TYPE;
-			}
-
-			/* We could put the returned object (Node) on the object stack for
-			 * later, but for now, we will put it in the "op" object that the
-			 * parser uses, so we can get it again at the end of this scope
-			 */
-			op->common.node = new_node;
-		} else {
-			ACPI_ERROR_NAMESPACE(arg->common.value.string, status);
-		}
-		break;
-
-	default:
-		break;
-	}
-
-      cleanup:
-
-	/* Remove the Node pushed at the very beginning */
-
-	walk_state->operands[0] = NULL;
-	walk_state->num_operands = 0;
-	return_ACPI_STATUS(status);
-}
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
new file mode 100644
index 0000000..4be4e92
--- /dev/null
+++ b/drivers/acpi/acpica/dswload2.c
@@ -0,0 +1,720 @@
+/******************************************************************************
+ *
+ * Module Name: dswload2 - Dispatcher second pass namespace load callbacks
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2011, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acparser.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acinterp.h"
+#include "acnamesp.h"
+#include "acevents.h"
+
+#define _COMPONENT          ACPI_DISPATCHER
+ACPI_MODULE_NAME("dswload2")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_load2_begin_op
+ *
+ * PARAMETERS:  walk_state      - Current state of the parse tree walk
+ *              out_op          - Wher to return op if a new one is created
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Descending callback used during the loading of ACPI tables.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
+		       union acpi_parse_object **out_op)
+{
+	union acpi_parse_object *op;
+	struct acpi_namespace_node *node;
+	acpi_status status;
+	acpi_object_type object_type;
+	char *buffer_ptr;
+	u32 flags;
+
+	ACPI_FUNCTION_TRACE(ds_load2_begin_op);
+
+	op = walk_state->op;
+	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Op=%p State=%p\n", op,
+			  walk_state));
+
+	if (op) {
+		if ((walk_state->control_state) &&
+		    (walk_state->control_state->common.state ==
+		     ACPI_CONTROL_CONDITIONAL_EXECUTING)) {
+
+			/* We are executing a while loop outside of a method */
+
+			status = acpi_ds_exec_begin_op(walk_state, out_op);
+			return_ACPI_STATUS(status);
+		}
+
+		/* We only care about Namespace opcodes here */
+
+		if ((!(walk_state->op_info->flags & AML_NSOPCODE) &&
+		     (walk_state->opcode != AML_INT_NAMEPATH_OP)) ||
+		    (!(walk_state->op_info->flags & AML_NAMED))) {
+			return_ACPI_STATUS(AE_OK);
+		}
+
+		/* Get the name we are going to enter or lookup in the namespace */
+
+		if (walk_state->opcode == AML_INT_NAMEPATH_OP) {
+
+			/* For Namepath op, get the path string */
+
+			buffer_ptr = op->common.value.string;
+			if (!buffer_ptr) {
+
+				/* No name, just exit */
+
+				return_ACPI_STATUS(AE_OK);
+			}
+		} else {
+			/* Get name from the op */
+
+			buffer_ptr = ACPI_CAST_PTR(char, &op->named.name);
+		}
+	} else {
+		/* Get the namestring from the raw AML */
+
+		buffer_ptr =
+		    acpi_ps_get_next_namestring(&walk_state->parser_state);
+	}
+
+	/* Map the opcode into an internal object type */
+
+	object_type = walk_state->op_info->object_type;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+			  "State=%p Op=%p Type=%X\n", walk_state, op,
+			  object_type));
+
+	switch (walk_state->opcode) {
+	case AML_FIELD_OP:
+	case AML_BANK_FIELD_OP:
+	case AML_INDEX_FIELD_OP:
+
+		node = NULL;
+		status = AE_OK;
+		break;
+
+	case AML_INT_NAMEPATH_OP:
+		/*
+		 * The name_path is an object reference to an existing object.
+		 * Don't enter the name into the namespace, but look it up
+		 * for use later.
+		 */
+		status =
+		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
+				   object_type, ACPI_IMODE_EXECUTE,
+				   ACPI_NS_SEARCH_PARENT, walk_state, &(node));
+		break;
+
+	case AML_SCOPE_OP:
+
+		/* Special case for Scope(\) -> refers to the Root node */
+
+		if (op && (op->named.node == acpi_gbl_root_node)) {
+			node = op->named.node;
+
+			status =
+			    acpi_ds_scope_stack_push(node, object_type,
+						     walk_state);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
+		} else {
+			/*
+			 * The Path is an object reference to an existing object.
+			 * Don't enter the name into the namespace, but look it up
+			 * for use later.
+			 */
+			status =
+			    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
+					   object_type, ACPI_IMODE_EXECUTE,
+					   ACPI_NS_SEARCH_PARENT, walk_state,
+					   &(node));
+			if (ACPI_FAILURE(status)) {
+#ifdef ACPI_ASL_COMPILER
+				if (status == AE_NOT_FOUND) {
+					status = AE_OK;
+				} else {
+					ACPI_ERROR_NAMESPACE(buffer_ptr,
+							     status);
+				}
+#else
+				ACPI_ERROR_NAMESPACE(buffer_ptr, status);
+#endif
+				return_ACPI_STATUS(status);
+			}
+		}
+
+		/*
+		 * We must check to make sure that the target is
+		 * one of the opcodes that actually opens a scope
+		 */
+		switch (node->type) {
+		case ACPI_TYPE_ANY:
+		case ACPI_TYPE_LOCAL_SCOPE:	/* Scope */
+		case ACPI_TYPE_DEVICE:
+		case ACPI_TYPE_POWER:
+		case ACPI_TYPE_PROCESSOR:
+		case ACPI_TYPE_THERMAL:
+
+			/* These are acceptable types */
+			break;
+
+		case ACPI_TYPE_INTEGER:
+		case ACPI_TYPE_STRING:
+		case ACPI_TYPE_BUFFER:
+
+			/*
+			 * These types we will allow, but we will change the type.
+			 * This enables some existing code of the form:
+			 *
+			 *  Name (DEB, 0)
+			 *  Scope (DEB) { ... }
+			 */
+			ACPI_WARNING((AE_INFO,
+				      "Type override - [%4.4s] had invalid type (%s) "
+				      "for Scope operator, changed to type ANY\n",
+				      acpi_ut_get_node_name(node),
+				      acpi_ut_get_type_name(node->type)));
+
+			node->type = ACPI_TYPE_ANY;
+			walk_state->scope_info->common.value = ACPI_TYPE_ANY;
+			break;
+
+		default:
+
+			/* All other types are an error */
+
+			ACPI_ERROR((AE_INFO,
+				    "Invalid type (%s) for target of "
+				    "Scope operator [%4.4s] (Cannot override)",
+				    acpi_ut_get_type_name(node->type),
+				    acpi_ut_get_node_name(node)));
+
+			return (AE_AML_OPERAND_TYPE);
+		}
+		break;
+
+	default:
+
+		/* All other opcodes */
+
+		if (op && op->common.node) {
+
+			/* This op/node was previously entered into the namespace */
+
+			node = op->common.node;
+
+			if (acpi_ns_opens_scope(object_type)) {
+				status =
+				    acpi_ds_scope_stack_push(node, object_type,
+							     walk_state);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+			}
+
+			return_ACPI_STATUS(AE_OK);
+		}
+
+		/*
+		 * Enter the named type into the internal namespace. We enter the name
+		 * as we go downward in the parse tree. Any necessary subobjects that
+		 * involve arguments to the opcode must be created as we go back up the
+		 * parse tree later.
+		 *
+		 * Note: Name may already exist if we are executing a deferred opcode.
+		 */
+		if (walk_state->deferred_node) {
+
+			/* This name is already in the namespace, get the node */
+
+			node = walk_state->deferred_node;
+			status = AE_OK;
+			break;
+		}
+
+		flags = ACPI_NS_NO_UPSEARCH;
+		if (walk_state->pass_number == ACPI_IMODE_EXECUTE) {
+
+			/* Execution mode, node cannot already exist, node is temporary */
+
+			flags |= ACPI_NS_ERROR_IF_FOUND;
+
+			if (!
+			    (walk_state->
+			     parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
+				flags |= ACPI_NS_TEMPORARY;
+			}
+		}
+
+		/* Add new entry or lookup existing entry */
+
+		status =
+		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
+				   object_type, ACPI_IMODE_LOAD_PASS2, flags,
+				   walk_state, &node);
+
+		if (ACPI_SUCCESS(status) && (flags & ACPI_NS_TEMPORARY)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+					  "***New Node [%4.4s] %p is temporary\n",
+					  acpi_ut_get_node_name(node), node));
+		}
+		break;
+	}
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR_NAMESPACE(buffer_ptr, status);
+		return_ACPI_STATUS(status);
+	}
+
+	if (!op) {
+
+		/* Create a new op */
+
+		op = acpi_ps_alloc_op(walk_state->opcode);
+		if (!op) {
+			return_ACPI_STATUS(AE_NO_MEMORY);
+		}
+
+		/* Initialize the new op */
+
+		if (node) {
+			op->named.name = node->name.integer;
+		}
+		*out_op = op;
+	}
+
+	/*
+	 * Put the Node in the "op" object that the parser uses, so we
+	 * can get it again quickly when this scope is closed
+	 */
+	op->common.node = node;
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ds_load2_end_op
+ *
+ * PARAMETERS:  walk_state      - Current state of the parse tree walk
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Ascending callback used during the loading of the namespace,
+ *              both control methods and everything else.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
+{
+	union acpi_parse_object *op;
+	acpi_status status = AE_OK;
+	acpi_object_type object_type;
+	struct acpi_namespace_node *node;
+	union acpi_parse_object *arg;
+	struct acpi_namespace_node *new_node;
+#ifndef ACPI_NO_METHOD_EXECUTION
+	u32 i;
+	u8 region_space;
+#endif
+
+	ACPI_FUNCTION_TRACE(ds_load2_end_op);
+
+	op = walk_state->op;
+	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Opcode [%s] Op %p State %p\n",
+			  walk_state->op_info->name, op, walk_state));
+
+	/* Check if opcode had an associated namespace object */
+
+	if (!(walk_state->op_info->flags & AML_NSOBJECT)) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	if (op->common.aml_opcode == AML_SCOPE_OP) {
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+				  "Ending scope Op=%p State=%p\n", op,
+				  walk_state));
+	}
+
+	object_type = walk_state->op_info->object_type;
+
+	/*
+	 * Get the Node/name from the earlier lookup
+	 * (It was saved in the *op structure)
+	 */
+	node = op->common.node;
+
+	/*
+	 * Put the Node on the object stack (Contains the ACPI Name of
+	 * this object)
+	 */
+	walk_state->operands[0] = (void *)node;
+	walk_state->num_operands = 1;
+
+	/* Pop the scope stack */
+
+	if (acpi_ns_opens_scope(object_type) &&
+	    (op->common.aml_opcode != AML_INT_METHODCALL_OP)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+				  "(%s) Popping scope for Op %p\n",
+				  acpi_ut_get_type_name(object_type), op));
+
+		status = acpi_ds_scope_stack_pop(walk_state);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+	}
+
+	/*
+	 * Named operations are as follows:
+	 *
+	 * AML_ALIAS
+	 * AML_BANKFIELD
+	 * AML_CREATEBITFIELD
+	 * AML_CREATEBYTEFIELD
+	 * AML_CREATEDWORDFIELD
+	 * AML_CREATEFIELD
+	 * AML_CREATEQWORDFIELD
+	 * AML_CREATEWORDFIELD
+	 * AML_DATA_REGION
+	 * AML_DEVICE
+	 * AML_EVENT
+	 * AML_FIELD
+	 * AML_INDEXFIELD
+	 * AML_METHOD
+	 * AML_METHODCALL
+	 * AML_MUTEX
+	 * AML_NAME
+	 * AML_NAMEDFIELD
+	 * AML_OPREGION
+	 * AML_POWERRES
+	 * AML_PROCESSOR
+	 * AML_SCOPE
+	 * AML_THERMALZONE
+	 */
+
+	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+			  "Create-Load [%s] State=%p Op=%p NamedObj=%p\n",
+			  acpi_ps_get_opcode_name(op->common.aml_opcode),
+			  walk_state, op, node));
+
+	/* Decode the opcode */
+
+	arg = op->common.value.arg;
+
+	switch (walk_state->op_info->type) {
+#ifndef ACPI_NO_METHOD_EXECUTION
+
+	case AML_TYPE_CREATE_FIELD:
+		/*
+		 * Create the field object, but the field buffer and index must
+		 * be evaluated later during the execution phase
+		 */
+		status = acpi_ds_create_buffer_field(op, walk_state);
+		break;
+
+	case AML_TYPE_NAMED_FIELD:
+		/*
+		 * If we are executing a method, initialize the field
+		 */
+		if (walk_state->method_node) {
+			status = acpi_ds_init_field_objects(op, walk_state);
+		}
+
+		switch (op->common.aml_opcode) {
+		case AML_INDEX_FIELD_OP:
+
+			status =
+			    acpi_ds_create_index_field(op,
+						       (acpi_handle) arg->
+						       common.node, walk_state);
+			break;
+
+		case AML_BANK_FIELD_OP:
+
+			status =
+			    acpi_ds_create_bank_field(op, arg->common.node,
+						      walk_state);
+			break;
+
+		case AML_FIELD_OP:
+
+			status =
+			    acpi_ds_create_field(op, arg->common.node,
+						 walk_state);
+			break;
+
+		default:
+			/* All NAMED_FIELD opcodes must be handled above */
+			break;
+		}
+		break;
+
+	case AML_TYPE_NAMED_SIMPLE:
+
+		status = acpi_ds_create_operands(walk_state, arg);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+
+		switch (op->common.aml_opcode) {
+		case AML_PROCESSOR_OP:
+
+			status = acpi_ex_create_processor(walk_state);
+			break;
+
+		case AML_POWER_RES_OP:
+
+			status = acpi_ex_create_power_resource(walk_state);
+			break;
+
+		case AML_MUTEX_OP:
+
+			status = acpi_ex_create_mutex(walk_state);
+			break;
+
+		case AML_EVENT_OP:
+
+			status = acpi_ex_create_event(walk_state);
+			break;
+
+		case AML_ALIAS_OP:
+
+			status = acpi_ex_create_alias(walk_state);
+			break;
+
+		default:
+			/* Unknown opcode */
+
+			status = AE_OK;
+			goto cleanup;
+		}
+
+		/* Delete operands */
+
+		for (i = 1; i < walk_state->num_operands; i++) {
+			acpi_ut_remove_reference(walk_state->operands[i]);
+			walk_state->operands[i] = NULL;
+		}
+
+		break;
+#endif				/* ACPI_NO_METHOD_EXECUTION */
+
+	case AML_TYPE_NAMED_COMPLEX:
+
+		switch (op->common.aml_opcode) {
+#ifndef ACPI_NO_METHOD_EXECUTION
+		case AML_REGION_OP:
+		case AML_DATA_REGION_OP:
+
+			if (op->common.aml_opcode == AML_REGION_OP) {
+				region_space = (acpi_adr_space_type)
+				    ((op->common.value.arg)->common.value.
+				     integer);
+			} else {
+				region_space = REGION_DATA_TABLE;
+			}
+
+			/*
+			 * The op_region is not fully parsed at this time. The only valid
+			 * argument is the space_id. (We must save the address of the
+			 * AML of the address and length operands)
+			 *
+			 * If we have a valid region, initialize it. The namespace is
+			 * unlocked at this point.
+			 *
+			 * Need to unlock interpreter if it is locked (if we are running
+			 * a control method), in order to allow _REG methods to be run
+			 * during acpi_ev_initialize_region.
+			 */
+			if (walk_state->method_node) {
+				/*
+				 * Executing a method: initialize the region and unlock
+				 * the interpreter
+				 */
+				status =
+				    acpi_ex_create_region(op->named.data,
+							  op->named.length,
+							  region_space,
+							  walk_state);
+				if (ACPI_FAILURE(status)) {
+					return (status);
+				}
+
+				acpi_ex_exit_interpreter();
+			}
+
+			status =
+			    acpi_ev_initialize_region
+			    (acpi_ns_get_attached_object(node), FALSE);
+			if (walk_state->method_node) {
+				acpi_ex_enter_interpreter();
+			}
+
+			if (ACPI_FAILURE(status)) {
+				/*
+				 *  If AE_NOT_EXIST is returned, it is not fatal
+				 *  because many regions get created before a handler
+				 *  is installed for said region.
+				 */
+				if (AE_NOT_EXIST == status) {
+					status = AE_OK;
+				}
+			}
+			break;
+
+		case AML_NAME_OP:
+
+			status = acpi_ds_create_node(walk_state, node, op);
+			break;
+
+		case AML_METHOD_OP:
+			/*
+			 * method_op pkg_length name_string method_flags term_list
+			 *
+			 * Note: We must create the method node/object pair as soon as we
+			 * see the method declaration. This allows later pass1 parsing
+			 * of invocations of the method (need to know the number of
+			 * arguments.)
+			 */
+			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+					  "LOADING-Method: State=%p Op=%p NamedObj=%p\n",
+					  walk_state, op, op->named.node));
+
+			if (!acpi_ns_get_attached_object(op->named.node)) {
+				walk_state->operands[0] =
+				    ACPI_CAST_PTR(void, op->named.node);
+				walk_state->num_operands = 1;
+
+				status =
+				    acpi_ds_create_operands(walk_state,
+							    op->common.value.
+							    arg);
+				if (ACPI_SUCCESS(status)) {
+					status =
+					    acpi_ex_create_method(op->named.
+								  data,
+								  op->named.
+								  length,
+								  walk_state);
+				}
+				walk_state->operands[0] = NULL;
+				walk_state->num_operands = 0;
+
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+			}
+			break;
+
+#endif				/* ACPI_NO_METHOD_EXECUTION */
+
+		default:
+			/* All NAMED_COMPLEX opcodes must be handled above */
+			break;
+		}
+		break;
+
+	case AML_CLASS_INTERNAL:
+
+		/* case AML_INT_NAMEPATH_OP: */
+		break;
+
+	case AML_CLASS_METHOD_CALL:
+
+		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+				  "RESOLVING-MethodCall: State=%p Op=%p NamedObj=%p\n",
+				  walk_state, op, node));
+
+		/*
+		 * Lookup the method name and save the Node
+		 */
+		status =
+		    acpi_ns_lookup(walk_state->scope_info,
+				   arg->common.value.string, ACPI_TYPE_ANY,
+				   ACPI_IMODE_LOAD_PASS2,
+				   ACPI_NS_SEARCH_PARENT |
+				   ACPI_NS_DONT_OPEN_SCOPE, walk_state,
+				   &(new_node));
+		if (ACPI_SUCCESS(status)) {
+			/*
+			 * Make sure that what we found is indeed a method
+			 * We didn't search for a method on purpose, to see if the name
+			 * would resolve
+			 */
+			if (new_node->type != ACPI_TYPE_METHOD) {
+				status = AE_AML_OPERAND_TYPE;
+			}
+
+			/* We could put the returned object (Node) on the object stack for
+			 * later, but for now, we will put it in the "op" object that the
+			 * parser uses, so we can get it again at the end of this scope
+			 */
+			op->common.node = new_node;
+		} else {
+			ACPI_ERROR_NAMESPACE(arg->common.value.string, status);
+		}
+		break;
+
+	default:
+		break;
+	}
+
+      cleanup:
+
+	/* Remove the Node pushed at the very beginning */
+
+	walk_state->operands[0] = NULL;
+	walk_state->num_operands = 0;
+	return_ACPI_STATUS(status);
+}
-- 
1.7.4.1.343.ga91df

