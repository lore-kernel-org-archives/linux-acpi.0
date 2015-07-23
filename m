From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/22] ACPICA: Parser: Cleanup aml_offset in union acpi_operand_object.
Date: Thu, 23 Jul 2015 12:52:18 +0800
Message-ID: <66170958c141d11f28eddf53e8d7a6d491423269.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29191 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbbGWEwY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:52:24 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 61b360074fde2bb8282722579410f5d1fb12f84d

This patch converts aml_offset in union acpi_operand_object to AML address.

AML offset is actually only used by the debugger, using AML address is more
direct and efficient during the parsing stage so that we don't need to
calculate the offset during the parsing stage and will not have
difficulities in converting it into other offset attributes.

Sometimes, aml_offset is not an indication of the offset from the table
header but the offset from the entry of a list of terms, which requires
additional efforts to convert it into an offset from the table header. By
using AML address directly, there is no such difficulty.
Thus this patch also deletes a logic in disassembler that is trying to
convert the aml_offset from
  "offset from the start address of Method/Package/Buffer"
into the
  "offset from the start address of the ACPI table"
(Sample code deletion can be seen in acpi_dm_deferred_parse(), but the
function is not in the Linux kernel). Lv Zheng.

Link: https://github.com/acpica/acpica/commit/61b36007
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    2 +-
 drivers/acpi/acpica/psargs.c  |    7 +++----
 drivers/acpi/acpica/psloop.c  |   15 ++++-----------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index bc60096..607e628 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -726,7 +726,7 @@ union acpi_parse_value {
 	u8                              descriptor_type; /* To differentiate various internal objs */\
 	u8                              flags;          /* Type of Op */\
 	u16                             aml_opcode;     /* AML opcode */\
-	u32                             aml_offset;     /* Offset of declaration in AML */\
+	u8                              *aml;           /* Address of declaration in AML */\
 	union acpi_parse_object         *next;          /* Next op */\
 	struct acpi_namespace_node      *node;          /* For use by interpreter */\
 	union acpi_parse_value          value;          /* Value or args associated with the opcode */\
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 6d03877..0bee946 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -484,7 +484,7 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 						       *parser_state)
 {
-	u32 aml_offset;
+	u8 *aml;
 	union acpi_parse_object *field;
 	union acpi_parse_object *arg = NULL;
 	u16 opcode;
@@ -498,8 +498,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 	ACPI_FUNCTION_TRACE(ps_get_next_field);
 
-	aml_offset =
-	    (u32)ACPI_PTR_DIFF(parser_state->aml, parser_state->aml_start);
+	aml = parser_state->aml;
 
 	/* Determine field type */
 
@@ -541,7 +540,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 		return_PTR(NULL);
 	}
 
-	field->common.aml_offset = aml_offset;
+	field->common.aml = aml;
 
 	/* Decode the field type */
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index ce66e73..d584383 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -137,10 +137,7 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 			}
 
 			if (arg) {
-				arg->common.aml_offset =
-				    (u32)ACPI_PTR_DIFF(walk_state->aml,
-						       walk_state->parser_state.
-						       aml_start);
+				arg->common.aml = walk_state->aml;
 				acpi_ps_append_arg(op, arg);
 			}
 
@@ -494,18 +491,14 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 				continue;
 			}
 
-			op->common.aml_offset =
-			    (u32)ACPI_PTR_DIFF(walk_state->aml,
-					       walk_state->parser_state.
-					       aml_start);
+			op->common.aml = walk_state->aml;
 
 			if (walk_state->op_info) {
 				ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-						  "Opcode %4.4X [%s] Op %p Aml %p AmlOffset %5.5X\n",
+						  "Opcode %4.4X [%s] Op %p Aml %p\n",
 						  (u32)op->common.aml_opcode,
 						  walk_state->op_info->name, op,
-						  parser_state->aml,
-						  op->common.aml_offset));
+						  op->common.aml));
 			}
 		}
 
-- 
1.7.10

