From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/73] ACPICA: Cleanup of debug output
Date: Sat, 12 Apr 2008 00:25:18 -0400
Message-ID: <c9cf3ce8fbca0f6a67c80dca3a062736c720e44d.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:7534 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753353AbYDLE2K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:10 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Improved output of object dump routine.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exdump.c |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index e48d916..251d84b 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -514,8 +514,14 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 		case AML_REF_OF_OP:
 
-			acpi_os_printf("Reference: (RefOf) %p\n",
-				       obj_desc->reference.object);
+			acpi_os_printf("Reference: (RefOf) %p [%s]\n",
+				       obj_desc->reference.object,
+				       acpi_ut_get_type_name(((union
+							       acpi_operand_object
+							       *)obj_desc->
+							      reference.
+							      object)->common.
+							     type));
 			break;
 
 		case AML_ARG_OP:
@@ -556,8 +562,9 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 		case AML_INT_NAMEPATH_OP:
 
-			acpi_os_printf("Reference.Node->Name %X\n",
-				       obj_desc->reference.node->name.integer);
+			acpi_os_printf("Reference: Namepath %X [%4.4s]\n",
+				       obj_desc->reference.node->name.integer,
+				       obj_desc->reference.node->name.ascii);
 			break;
 
 		default:
@@ -874,20 +881,32 @@ static void acpi_ex_dump_reference_obj(union acpi_operand_object *obj_desc)
 	ret_buf.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 
 	if (obj_desc->reference.opcode == AML_INT_NAMEPATH_OP) {
-		acpi_os_printf("Named Object %p ", obj_desc->reference.node);
+		acpi_os_printf(" Named Object %p ", obj_desc->reference.node);
 
 		status =
 		    acpi_ns_handle_to_pathname(obj_desc->reference.node,
 					       &ret_buf);
 		if (ACPI_FAILURE(status)) {
-			acpi_os_printf("Could not convert name to pathname\n");
+			acpi_os_printf(" Could not convert name to pathname\n");
 		} else {
 			acpi_os_printf("%s\n", (char *)ret_buf.pointer);
 			ACPI_FREE(ret_buf.pointer);
 		}
 	} else if (obj_desc->reference.object) {
-		acpi_os_printf("\nReferenced Object: %p\n",
-			       obj_desc->reference.object);
+		if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) ==
+		    ACPI_DESC_TYPE_OPERAND) {
+			acpi_os_printf(" Target: %p [%s]\n",
+				       obj_desc->reference.object,
+				       acpi_ut_get_type_name(((union
+							       acpi_operand_object
+							       *)obj_desc->
+							      reference.
+							      object)->common.
+							     type));
+		} else {
+			acpi_os_printf(" Target: %p\n",
+				       obj_desc->reference.object);
+		}
 	}
 }
 
@@ -973,7 +992,9 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		acpi_os_printf("[Object Reference] ");
+		acpi_os_printf("[Object Reference] %s",
+			       (acpi_ps_get_opcode_info
+				(obj_desc->reference.opcode))->name);
 		acpi_ex_dump_reference_obj(obj_desc);
 		break;
 
-- 
1.5.5.29.g7134

