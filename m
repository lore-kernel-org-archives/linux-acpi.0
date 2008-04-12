From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/73] ACPICA: Removed unused code
Date: Sat, 12 Apr 2008 00:24:45 -0400
Message-ID: <92b5c24755773828274389da350d7abed4c94e21.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752089AbYDLE1z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:55 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Handling of AML_NAME_OP as a Reference.Opcode is no longer
needed. Kernel bugzilla 2874

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exdump.c   |    9 ---------
 drivers/acpi/executer/exresolv.c |   18 ------------------
 drivers/acpi/executer/exresop.c  |   11 -----------
 drivers/acpi/executer/exstore.c  |    1 -
 4 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 51c9c29..fcb1da0 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -500,15 +500,6 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 			acpi_os_printf("Reference: Debug\n");
 			break;
 
-		case AML_NAME_OP:
-
-			ACPI_DUMP_PATHNAME(obj_desc->reference.object,
-					   "Reference: Name: ", ACPI_LV_INFO,
-					   _COMPONENT);
-			ACPI_DUMP_ENTRY(obj_desc->reference.object,
-					ACPI_LV_INFO);
-			break;
-
 		case AML_INDEX_OP:
 
 			acpi_os_printf("Reference: Index %p\n",
diff --git a/drivers/acpi/executer/exresolv.c b/drivers/acpi/executer/exresolv.c
index 6c64e55..74ab220 100644
--- a/drivers/acpi/executer/exresolv.c
+++ b/drivers/acpi/executer/exresolv.c
@@ -140,7 +140,6 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 {
 	acpi_status status = AE_OK;
 	union acpi_operand_object *stack_desc;
-	void *temp_node;
 	union acpi_operand_object *obj_desc = NULL;
 	u16 opcode;
 
@@ -156,23 +155,6 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 		opcode = stack_desc->reference.opcode;
 
 		switch (opcode) {
-		case AML_NAME_OP:
-
-			/*
-			 * Convert name reference to a namespace node
-			 * Then, acpi_ex_resolve_node_to_value can be used to get the value
-			 */
-			temp_node = stack_desc->reference.object;
-
-			/* Delete the Reference Object */
-
-			acpi_ut_remove_reference(stack_desc);
-
-			/* Return the namespace node */
-
-			(*stack_ptr) = temp_node;
-			break;
-
 		case AML_LOCAL_OP:
 		case AML_ARG_OP:
 
diff --git a/drivers/acpi/executer/exresop.c b/drivers/acpi/executer/exresop.c
index 09d897b..259047a 100644
--- a/drivers/acpi/executer/exresop.c
+++ b/drivers/acpi/executer/exresop.c
@@ -137,7 +137,6 @@ acpi_ex_resolve_operands(u16 opcode,
 	union acpi_operand_object *obj_desc;
 	acpi_status status = AE_OK;
 	u8 object_type;
-	void *temp_node;
 	u32 arg_types;
 	const struct acpi_opcode_info *op_info;
 	u32 this_arg_type;
@@ -239,7 +238,6 @@ acpi_ex_resolve_operands(u16 opcode,
 
 					/*lint -fallthrough */
 
-				case AML_NAME_OP:
 				case AML_INDEX_OP:
 				case AML_REF_OF_OP:
 				case AML_ARG_OP:
@@ -332,15 +330,6 @@ acpi_ex_resolve_operands(u16 opcode,
 			if (ACPI_FAILURE(status)) {
 				return_ACPI_STATUS(status);
 			}
-
-			if (obj_desc->reference.opcode == AML_NAME_OP) {
-
-				/* Convert a named reference to the actual named object */
-
-				temp_node = obj_desc->reference.object;
-				acpi_ut_remove_reference(obj_desc);
-				(*stack_ptr) = temp_node;
-			}
 			goto next_operand;
 
 		case ARGI_DATAREFOBJ:	/* Store operator only */
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index f4b69a6..97cb188 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -313,7 +313,6 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 	 * 4) Store to the debug object
 	 */
 	switch (ref_desc->reference.opcode) {
-	case AML_NAME_OP:
 	case AML_REF_OF_OP:
 
 		/* Storing an object into a Name "container" */
-- 
1.5.5.29.g7134

