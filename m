From: Len Brown <lenb@kernel.org>
Subject: [PATCH 73/73] ACPICA: Fix for some local named nodes not marked temporary and to disallow duplicates
Date: Sat, 12 Apr 2008 00:25:56 -0400
Message-ID: <8b56e6a8add356fb9c9cc9c3ac93240b9c9d4e4e.1207973801.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757165AbYDLE2S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:18 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the CreateField, CreateXXXField (Bit, Byte,
Word, Dword, Qword), Field, BankField, and IndexField operators
when invoked from inside an executing control method. In this case,
these operators created namespace nodes that were incorrectly
left marked as permanent nodes instead of temporary nodes. This
could cause a problem if there is race condition between an
exiting control method and a running namespace walk. (Reported
by Linn Crosetto). Fixed a problem where the CreateField and
CreateXXXField operators would incorrectly allow duplicate names
(the name of the field) with no exception generated.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsfield.c |  121 ++++++++++++++++++++++---------------
 drivers/acpi/dispatcher/dswload.c |    6 ++
 2 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsfield.c b/drivers/acpi/dispatcher/dsfield.c
index e87f6bf..0befcff 100644
--- a/drivers/acpi/dispatcher/dsfield.c
+++ b/drivers/acpi/dispatcher/dsfield.c
@@ -89,12 +89,16 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 
 	ACPI_FUNCTION_TRACE(ds_create_buffer_field);
 
-	/* Get the name_string argument */
-
+	/*
+	 * Get the name_string argument (name of the new buffer_field)
+	 */
 	if (op->common.aml_opcode == AML_CREATE_FIELD_OP) {
+
+		/* For create_field, name is the 4th argument */
+
 		arg = acpi_ps_get_arg(op, 3);
 	} else {
-		/* Create Bit/Byte/Word/Dword field */
+		/* For all other create_xXXField operators, name is the 3rd argument */
 
 		arg = acpi_ps_get_arg(op, 2);
 	}
@@ -107,26 +111,30 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 		node = walk_state->deferred_node;
 		status = AE_OK;
 	} else {
-		/*
-		 * During the load phase, we want to enter the name of the field into
-		 * the namespace.  During the execute phase (when we evaluate the size
-		 * operand), we want to lookup the name
-		 */
-		if (walk_state->parse_flags & ACPI_PARSE_EXECUTE) {
-			flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE;
-		} else {
-			flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE |
-			    ACPI_NS_ERROR_IF_FOUND;
+		/* Execute flag should always be set when this function is entered */
+
+		if (!(walk_state->parse_flags & ACPI_PARSE_EXECUTE)) {
+			return_ACPI_STATUS(AE_AML_INTERNAL);
 		}
 
-		/*
-		 * Enter the name_string into the namespace
-		 */
+		/* Creating new namespace node, should not already exist */
+
+		flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE |
+		    ACPI_NS_ERROR_IF_FOUND;
+
+		/* Mark node temporary if we are executing a method */
+
+		if (walk_state->method_node) {
+			flags |= ACPI_NS_TEMPORARY;
+		}
+
+		/* Enter the name_string into the namespace */
+
 		status =
 		    acpi_ns_lookup(walk_state->scope_info,
 				   arg->common.value.string, ACPI_TYPE_ANY,
 				   ACPI_IMODE_LOAD_PASS1, flags, walk_state,
-				   &(node));
+				   &node);
 		if (ACPI_FAILURE(status)) {
 			ACPI_ERROR_NAMESPACE(arg->common.value.string, status);
 			return_ACPI_STATUS(status);
@@ -136,13 +144,13 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 	/*
 	 * We could put the returned object (Node) on the object stack for later,
 	 * but for now, we will put it in the "op" object that the parser uses,
-	 * so we can get it again at the end of this scope
+	 * so we can get it again at the end of this scope.
 	 */
 	op->common.node = node;
 
 	/*
 	 * If there is no object attached to the node, this node was just created
-	 * and we need to create the field object.  Otherwise, this was a lookup
+	 * and we need to create the field object. Otherwise, this was a lookup
 	 * of an existing node and we don't want to create the field object again.
 	 */
 	obj_desc = acpi_ns_get_attached_object(node);
@@ -164,9 +172,8 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 	}
 
 	/*
-	 * Remember location in AML stream of the field unit
-	 * opcode and operands -- since the buffer and index
-	 * operands must be evaluated.
+	 * Remember location in AML stream of the field unit opcode and operands --
+	 * since the buffer and index operands must be evaluated.
 	 */
 	second_desc = obj_desc->common.next_object;
 	second_desc->extra.aml_start = op->named.data;
@@ -261,7 +268,7 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 
 		case AML_INT_NAMEDFIELD_OP:
 
-			/* Lookup the name */
+			/* Lookup the name, it should already exist */
 
 			status = acpi_ns_lookup(walk_state->scope_info,
 						(char *)&arg->named.name,
@@ -272,19 +279,16 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 			if (ACPI_FAILURE(status)) {
 				ACPI_ERROR_NAMESPACE((char *)&arg->named.name,
 						     status);
-				if (status != AE_ALREADY_EXISTS) {
-					return_ACPI_STATUS(status);
-				}
-
-				/* Already exists, ignore error */
+				return_ACPI_STATUS(status);
 			} else {
 				arg->common.node = info->field_node;
 				info->field_bit_length = arg->common.value.size;
 
 				/*
-				 * If there is no object attached to the node, this node was just created
-				 * and we need to create the field object.  Otherwise, this was a lookup
-				 * of an existing node and we don't want to create the field object again.
+				 * If there is no object attached to the node, this node was
+				 * just created and we need to create the field object.
+				 * Otherwise, this was a lookup of an existing node and we
+				 * don't want to create the field object again.
 				 */
 				if (!acpi_ns_get_attached_object
 				    (info->field_node)) {
@@ -409,18 +413,23 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 
 	ACPI_FUNCTION_TRACE_PTR(ds_init_field_objects, op);
 
-	/*
-	 * During the load phase, we want to enter the name of the field into
-	 * the namespace. During the execute phase (when we evaluate the bank_value
-	 * operand), we want to lookup the name.
-	 */
-	if (walk_state->deferred_node) {
-		flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE;
-	} else {
-		flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE |
-		    ACPI_NS_ERROR_IF_FOUND;
+	/* Execute flag should always be set when this function is entered */
+
+	if (!(walk_state->parse_flags & ACPI_PARSE_EXECUTE)) {
+		if (walk_state->parse_flags & ACPI_PARSE_DEFERRED_OP) {
+
+			/* bank_field Op is deferred, just return OK */
+
+			return_ACPI_STATUS(AE_OK);
+		}
+
+		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
 
+	/*
+	 * Get the field_list argument for this opcode. This is the start of the
+	 * list of field elements.
+	 */
 	switch (walk_state->opcode) {
 	case AML_FIELD_OP:
 		arg = acpi_ps_get_arg(op, 2);
@@ -441,18 +450,34 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
+	if (!arg) {
+		return_ACPI_STATUS(AE_AML_NO_OPERAND);
+	}
+
+	/* Creating new namespace node(s), should not already exist */
+
+	flags = ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE |
+	    ACPI_NS_ERROR_IF_FOUND;
+
+	/* Mark node(s) temporary if we are executing a method */
+
+	if (walk_state->method_node) {
+		flags |= ACPI_NS_TEMPORARY;
+	}
+
 	/*
 	 * Walk the list of entries in the field_list
 	 */
 	while (arg) {
-
-		/* Ignore OFFSET and ACCESSAS terms here */
-
+		/*
+		 * Ignore OFFSET and ACCESSAS terms here; we are only interested in the
+		 * field names in order to enter them into the namespace.
+		 */
 		if (arg->common.aml_opcode == AML_INT_NAMEDFIELD_OP) {
 			status = acpi_ns_lookup(walk_state->scope_info,
-						(char *)&arg->named.name,
-						type, ACPI_IMODE_LOAD_PASS1,
-						flags, walk_state, &node);
+						(char *)&arg->named.name, type,
+						ACPI_IMODE_LOAD_PASS1, flags,
+						walk_state, &node);
 			if (ACPI_FAILURE(status)) {
 				ACPI_ERROR_NAMESPACE((char *)&arg->named.name,
 						     status);
@@ -468,7 +493,7 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 			arg->common.node = node;
 		}
 
-		/* Move to next field in the list */
+		/* Get the next field element in the list */
 
 		arg = arg->common.next;
 	}
diff --git a/drivers/acpi/dispatcher/dswload.c b/drivers/acpi/dispatcher/dswload.c
index ec68c1d..775b183 100644
--- a/drivers/acpi/dispatcher/dswload.c
+++ b/drivers/acpi/dispatcher/dswload.c
@@ -776,6 +776,12 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 		    acpi_ns_lookup(walk_state->scope_info, buffer_ptr,
 				   object_type, ACPI_IMODE_LOAD_PASS2, flags,
 				   walk_state, &node);
+
+		if (ACPI_SUCCESS(status) && (flags & ACPI_NS_TEMPORARY)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+					  "***New Node [%4.4s] %p is temporary\n",
+					  acpi_ut_get_node_name(node), node));
+		}
 		break;
 	}
 
-- 
1.5.5.29.g7134

