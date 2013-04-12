From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/11] ACPICA: Improve error message for Index() operator
Date: Fri, 12 Apr 2013 08:25:24 +0800
Message-ID: <982e9efce78cbfa9df7dd50ca9a213da51e740b7.1365473142.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29377 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3DLAZ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:25:27 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

For the case where an attempt is made to take an Index() beyond
the end of a String, Buffer, or Package, emit the actual length
of the object to the error message. Helpful for debugging.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exoparg2.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index e491e46..4a34d6d 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -257,7 +257,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 	union acpi_operand_object *return_desc = NULL;
 	u64 index;
 	acpi_status status = AE_OK;
-	acpi_size length;
+	acpi_size length = 0;
 
 	ACPI_FUNCTION_TRACE_STR(ex_opcode_2A_1T_1R,
 				acpi_ps_get_opcode_name(walk_state->opcode));
@@ -320,7 +320,6 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		 * NOTE: A length of zero is ok, and will create a zero-length, null
 		 *       terminated string.
 		 */
-		length = 0;
 		while ((length < operand[0]->buffer.length) &&
 		       (length < operand[1]->integer.value) &&
 		       (operand[0]->buffer.pointer[length])) {
@@ -376,6 +375,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		case ACPI_TYPE_STRING:
 
 			if (index >= operand[0]->string.length) {
+				length = operand[0]->string.length;
 				status = AE_AML_STRING_LIMIT;
 			}
 
@@ -386,6 +386,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		case ACPI_TYPE_BUFFER:
 
 			if (index >= operand[0]->buffer.length) {
+				length = operand[0]->buffer.length;
 				status = AE_AML_BUFFER_LIMIT;
 			}
 
@@ -396,6 +397,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		case ACPI_TYPE_PACKAGE:
 
 			if (index >= operand[0]->package.count) {
+				length = operand[0]->package.count;
 				status = AE_AML_PACKAGE_LIMIT;
 			}
 
@@ -414,8 +416,8 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Index (0x%8.8X%8.8X) is beyond end of object",
-					ACPI_FORMAT_UINT64(index)));
+					"Index (0x%X%8.8X) is beyond end of object (length 0x%X)",
+					ACPI_FORMAT_UINT64(index), length));
 			goto cleanup;
 		}
 
-- 
1.7.10

