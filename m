From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/21] ACPICA: Update several debug statements - no functional change.
Date: Wed,  8 Jan 2014 13:44:15 +0800
Message-ID: <7227dae5f4500aa17fd742249858f63537628e1b.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48604 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFoY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:24 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Update the format and information emitted from several
debug output statements.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsutils.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index ade44e4..d7f53fb 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -727,27 +727,26 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 		index++;
 	}
 
-	index--;
+	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
+			  "NumOperands %d, ArgCount %d, Index %d\n",
+			  walk_state->num_operands, arg_count, index));
 
-	/* It is the appropriate order to get objects from the Result stack */
+	/* Create the interpreter arguments, in reverse order */
 
+	index--;
 	for (i = 0; i < arg_count; i++) {
 		arg = arguments[index];
-
-		/* Force the filling of the operand stack in inverse order */
-
-		walk_state->operand_index = (u8) index;
+		walk_state->operand_index = (u8)index;
 
 		status = acpi_ds_create_operand(walk_state, arg, index);
 		if (ACPI_FAILURE(status)) {
 			goto cleanup;
 		}
 
-		index--;
-
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "Arg #%u (%p) done, Arg1=%p\n", index, arg,
-				  first_arg));
+				  "Created Arg #%u (%p) %u args total\n",
+				  index, arg, arg_count));
+		index--;
 	}
 
 	return_ACPI_STATUS(status);
-- 
1.7.10

