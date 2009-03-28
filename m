From: Len Brown <lenb@kernel.org>
Subject: [PATCH 48/98] ACPICA: Remove unused code, no functional change
Date: Sat, 28 Mar 2009 00:31:23 -0400
Message-ID: <91a56e631fc837852304ee7bc2876d6e444b7fdb.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22353 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbZC1Ecx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700JW78MPEKQP@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:50 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed unused code for dump of args and locals. General cleanup
and splitting of long lines.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exdump.c |   44 ++++++++---------------------------------
 1 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 193d233..89d141f 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -350,6 +350,7 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 			break;
 
 		case ACPI_EXD_TYPE:
+
 			acpi_ex_out_string("Type",
 					   acpi_ut_get_object_type_name
 					   (obj_desc));
@@ -422,6 +423,7 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 			break;
 
 		default:
+
 			acpi_os_printf("**** Invalid table opcode [%X] ****\n",
 				       info->opcode);
 			return;
@@ -527,44 +529,16 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 							     type));
 			break;
 
-		case ACPI_REFCLASS_ARG:
-
-			acpi_os_printf("%X", obj_desc->reference.value);
-
-			if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
-
-				/* Value is an Integer */
-
-				acpi_os_printf(" value is [%8.8X%8.8x]",
-					       ACPI_FORMAT_UINT64(obj_desc->
-								  integer.
-								  value));
-			}
+		case ACPI_REFCLASS_NAME:
 
-			acpi_os_printf("\n");
+			acpi_os_printf("- [%4.4s]\n",
+				       obj_desc->reference.node->name.ascii);
 			break;
 
+		case ACPI_REFCLASS_ARG:
 		case ACPI_REFCLASS_LOCAL:
 
-			acpi_os_printf("%X", obj_desc->reference.value);
-
-			if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
-
-				/* Value is an Integer */
-
-				acpi_os_printf(" value is [%8.8X%8.8x]",
-					       ACPI_FORMAT_UINT64(obj_desc->
-								  integer.
-								  value));
-			}
-
-			acpi_os_printf("\n");
-			break;
-
-		case ACPI_REFCLASS_NAME:
-
-			acpi_os_printf("- [%4.4s]\n",
-				       obj_desc->reference.node->name.ascii);
+			acpi_os_printf("%X\n", obj_desc->reference.value);
 			break;
 
 		default:	/* Unknown reference class */
@@ -661,8 +635,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 	case ACPI_TYPE_LOCAL_REGION_FIELD:
 
 		acpi_os_printf
-		    ("RegionField: Bits=%X AccWidth=%X Lock=%X Update=%X at byte=%X bit=%X of below:\n",
-		     obj_desc->field.bit_length,
+		    ("RegionField: Bits=%X AccWidth=%X Lock=%X Update=%X at "
+		     "byte=%X bit=%X of below:\n", obj_desc->field.bit_length,
 		     obj_desc->field.access_byte_width,
 		     obj_desc->field.field_flags & AML_FIELD_LOCK_RULE_MASK,
 		     obj_desc->field.field_flags & AML_FIELD_UPDATE_RULE_MASK,
-- 
1.6.0.6

