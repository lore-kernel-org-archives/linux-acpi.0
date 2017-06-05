From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 46/53] ACPICA: Disassembler: add external op to namespace on first pass
Date: Mon,  5 Jun 2017 16:41:49 +0800
Message-ID: <cc9454fc5b6e3a475e97496e6c9d73c1b6666d10.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23851 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751640AbdFEIly (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:54 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 117be4819588df3b7146f6f01723639b1d61e775

By doing so, external control method resolutions can be resolved like
normal control methods. This eliminates the need to reparse the aml
all over again for external control methods that were encoded within
the aml with the 0x15 bytecode.

Link: https://github.com/acpica/acpica/commit/117be481
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dswload.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/dswload2.c | 10 ++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 1dd5a98..eaa859a 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -434,6 +434,10 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 	acpi_object_type object_type;
 	acpi_status status = AE_OK;
 
+#ifdef ACPI_ASL_COMPILER
+	u8 param_count;
+#endif
+
 	ACPI_FUNCTION_TRACE(ds_load1_end_op);
 
 	op = walk_state->op;
@@ -514,6 +518,38 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 			}
 		}
 	}
+#ifdef ACPI_ASL_COMPILER
+	/*
+	 * For external opcode, get the object type from the argument and
+	 * get the parameter count from the argument's next.
+	 */
+	if (acpi_gbl_disasm_flag &&
+	    op->common.node && op->common.aml_opcode == AML_EXTERNAL_OP) {
+		/*
+		 * Note, if this external is not a method
+		 * Op->Common.Value.Arg->Common.Next->Common.Value.Integer == 0
+		 * Therefore, param_count will be 0.
+		 */
+		param_count =
+		    (u8)op->common.value.arg->common.next->common.value.integer;
+		object_type = (u8)op->common.value.arg->common.value.integer;
+		op->common.node->flags |= ANOBJ_IS_EXTERNAL;
+		op->common.node->type = (u8)object_type;
+
+		acpi_dm_create_subobject_for_external((u8)object_type,
+						      &op->common.node,
+						      param_count);
+
+		/*
+		 * Add the external to the external list because we may be
+		 * emitting code based off of the items within the external list.
+		 */
+		acpi_dm_add_op_to_external_list(op, op->named.path,
+						(u8)object_type, param_count,
+						ACPI_EXT_ORIGIN_FROM_OPCODE |
+						ACPI_EXT_RESOLVED_REFERENCE);
+	}
+#endif
 
 	/*
 	 * If we are executing a method, do not create any namespace objects
@@ -563,7 +599,9 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 
 	/* Pop the scope stack (only if loading a table) */
 
-	if (!walk_state->method_node && acpi_ns_opens_scope(object_type)) {
+	if (!walk_state->method_node &&
+	    op->common.aml_opcode != AML_EXTERNAL_OP &&
+	    acpi_ns_opens_scope(object_type)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 				  "(%s): Popping scope for Op %p\n",
 				  acpi_ut_get_type_name(object_type), op));
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index ab5d318..aad83ef 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -313,8 +313,14 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 #ifdef ACPI_ASL_COMPILER
 
 		/*
-		 * Do not open a scope. This could be an external method
-		 * and open a scope.
+		 * Do not open a scope for AML_EXTERNAL_OP
+		 * acpi_ns_lookup can open a new scope based on the object type
+		 * of this op. AML_EXTERNAL_OP is a declaration rather than a
+		 * definition. In the case that this external is a method object,
+		 * acpi_ns_lookup will open a new scope. However, an AML_EXTERNAL_OP
+		 * associated with the ACPI_TYPE_METHOD is a declaration, rather than
+		 * a definition. Flags is set to avoid opening a scope for any
+		 * AML_EXTERNAL_OP.
 		 */
 		if (walk_state->opcode == AML_EXTERNAL_OP) {
 			flags |= ACPI_NS_DONT_OPEN_SCOPE;
-- 
2.7.4

