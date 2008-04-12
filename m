From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/73] ACPICA: Fixed a problem with CopyObject used in conjunction with the Index operator
Date: Sat, 12 Apr 2008 00:25:22 -0400
Message-ID: <19a563dab139f69d1d033623098f540b17876885.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20142 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753385AbYDLE2K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:10 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The reference was incorrectly dereferenced before the copy. The
reference is now correctly copied. BZ 5391 Lin Ming

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exresnte.c |    7 +++----
 drivers/acpi/executer/exresolv.c |   16 ++++++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/executer/exresnte.c b/drivers/acpi/executer/exresnte.c
index 79a0d28..42c8a0f 100644
--- a/drivers/acpi/executer/exresnte.c
+++ b/drivers/acpi/executer/exresnte.c
@@ -239,13 +239,12 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
 		switch (source_desc->reference.opcode) {
-		case AML_LOAD_OP:
+		case AML_LOAD_OP:	/* This is a ddb_handle */
+		case AML_REF_OF_OP:
+		case AML_INDEX_OP:
 
-			/* This is a ddb_handle */
 			/* Return an additional reference to the object */
 
-		case AML_REF_OF_OP:
-
 			obj_desc = source_desc;
 			acpi_ut_add_reference(obj_desc);
 			break;
diff --git a/drivers/acpi/executer/exresolv.c b/drivers/acpi/executer/exresolv.c
index 795ec8c..9c3cdf6 100644
--- a/drivers/acpi/executer/exresolv.c
+++ b/drivers/acpi/executer/exresolv.c
@@ -189,21 +189,25 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 			switch (stack_desc->reference.target_type) {
 			case ACPI_TYPE_BUFFER_FIELD:
 
-				/* Just return - leave the Reference on the stack */
+				/* Just return - do not dereference */
 				break;
 
 			case ACPI_TYPE_PACKAGE:
 
-				/* If method call - leave the Reference on the stack */
+				/* If method call or copy_object - do not dereference */
 
-				if (walk_state->opcode == AML_INT_METHODCALL_OP) {
+				if ((walk_state->opcode ==
+				     AML_INT_METHODCALL_OP)
+				    || (walk_state->opcode == AML_COPY_OP)) {
 					break;
 				}
 
+				/* Otherwise, dereference the package_index to a package element */
+
 				obj_desc = *stack_desc->reference.where;
 				if (obj_desc) {
 					/*
-					 * Valid obj descriptor, copy pointer to return value
+					 * Valid object descriptor, copy pointer to return value
 					 * (i.e., dereference the package index)
 					 * Delete the ref object, increment the returned object
 					 */
@@ -212,7 +216,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 					*stack_ptr = obj_desc;
 				} else {
 					/*
-					 * A NULL object descriptor means an unitialized element of
+					 * A NULL object descriptor means an uninitialized element of
 					 * the package, can't dereference it
 					 */
 					ACPI_ERROR((AE_INFO,
@@ -239,7 +243,7 @@ acpi_ex_resolve_object_to_value(union acpi_operand_object **stack_ptr,
 		case AML_DEBUG_OP:
 		case AML_LOAD_OP:
 
-			/* Just leave the object as-is */
+			/* Just leave the object as-is, do not dereference */
 
 			break;
 
-- 
1.5.5.29.g7134

