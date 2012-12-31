From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/27] ACPICA: Interpreter: Add warning if 64-bit constant appears in 32-bit table.
Date: Mon, 31 Dec 2012 08:07:18 +0800
Message-ID: <dfe2dfff8ba5815d58bde6e8bf2dfbe89e11129f.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59386 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab2LaAH3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:29 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some ASL compilers allow 64-bit constants within a 32-bit table
(DSDT version == 1). When encountered, emit a warning that the
constant will be truncated to 32 bits. This is potentially a
serious problem in the ACPI table(s).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acinterp.h |    2 +-
 drivers/acpi/acpica/dsobject.c |   14 ++++++++++++--
 drivers/acpi/acpica/dswexec.c  |    4 ++--
 drivers/acpi/acpica/exconvrt.c |    2 +-
 drivers/acpi/acpica/exstoren.c |    2 +-
 drivers/acpi/acpica/exutils.c  |   18 +++++++++++-------
 6 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index eb30863..16469b0 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -458,7 +458,7 @@ void acpi_ex_reacquire_interpreter(void);
 
 void acpi_ex_relinquish_interpreter(void);
 
-void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc);
+u8 acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc);
 
 void acpi_ex_acquire_global_lock(u32 rule);
 
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 13844a1..82050bc 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -703,7 +703,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 				/* Truncate value if we are executing from a 32-bit ACPI table */
 
 #ifndef ACPI_NO_METHOD_EXECUTION
-				acpi_ex_truncate_for32bit_table(obj_desc);
+				(void)acpi_ex_truncate_for32bit_table(obj_desc);
 #endif
 				break;
 
@@ -725,8 +725,18 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 		case AML_TYPE_LITERAL:
 
 			obj_desc->integer.value = op->common.value.integer;
+
 #ifndef ACPI_NO_METHOD_EXECUTION
-			acpi_ex_truncate_for32bit_table(obj_desc);
+			if (acpi_ex_truncate_for32bit_table(obj_desc)) {
+
+				/* Warn if we found a 64-bit constant in a 32-bit table */
+
+				ACPI_WARNING((AE_INFO,
+					      "Truncated 64-bit constant found in 32-bit table: %8.8X%8.8X => %8.8X",
+					      ACPI_FORMAT_UINT64(op->common.
+								 value.integer),
+					      (u32)obj_desc->integer.value));
+			}
 #endif
 			break;
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 5859393..9e0d210 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -149,7 +149,7 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
 
 	/* Truncate the predicate to 32-bits if necessary */
 
-	acpi_ex_truncate_for32bit_table(local_obj_desc);
+	(void)acpi_ex_truncate_for32bit_table(local_obj_desc);
 
 	/*
 	 * Save the result of the predicate evaluation on
@@ -706,7 +706,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 	 * ACPI 2.0 support for 64-bit integers: Truncate numeric
 	 * result value if we are executing from a 32-bit ACPI table
 	 */
-	acpi_ex_truncate_for32bit_table(walk_state->result_obj);
+	(void)acpi_ex_truncate_for32bit_table(walk_state->result_obj);
 
 	/*
 	 * Check if we just completed the evaluation of a
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 4492a4e..d6a7b6f 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -176,7 +176,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	/* Save the Result */
 
-	acpi_ex_truncate_for32bit_table(return_desc);
+	(void)acpi_ex_truncate_for32bit_table(return_desc);
 	*result_desc = return_desc;
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 87153bb..85a74b7 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -253,7 +253,7 @@ acpi_ex_store_object_to_object(union acpi_operand_object *source_desc,
 
 		/* Truncate value if we are executing from a 32-bit ACPI table */
 
-		acpi_ex_truncate_for32bit_table(dest_desc);
+		(void)acpi_ex_truncate_for32bit_table(dest_desc);
 		break;
 
 	case ACPI_TYPE_STRING:
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 02ddc4c..e624958 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -202,35 +202,39 @@ void acpi_ex_relinquish_interpreter(void)
  *
  * PARAMETERS:  obj_desc        - Object to be truncated
  *
- * RETURN:      none
+ * RETURN:      TRUE if a truncation was performed, FALSE otherwise.
  *
  * DESCRIPTION: Truncate an ACPI Integer to 32 bits if the execution mode is
  *              32-bit, as determined by the revision of the DSDT.
  *
  ******************************************************************************/
 
-void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc)
+u8 acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc)
 {
 
 	ACPI_FUNCTION_ENTRY();
 
 	/*
 	 * Object must be a valid number and we must be executing
-	 * a control method. NS node could be there for AML_INT_NAMEPATH_OP.
+	 * a control method. Object could be NS node for AML_INT_NAMEPATH_OP.
 	 */
 	if ((!obj_desc) ||
 	    (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) != ACPI_DESC_TYPE_OPERAND) ||
 	    (obj_desc->common.type != ACPI_TYPE_INTEGER)) {
-		return;
+		return (FALSE);
 	}
 
-	if (acpi_gbl_integer_byte_width == 4) {
+	if ((acpi_gbl_integer_byte_width == 4) &&
+	    (obj_desc->integer.value > (u64)ACPI_UINT32_MAX)) {
 		/*
-		 * We are running a method that exists in a 32-bit ACPI table.
+		 * We are executing in a 32-bit ACPI table.
 		 * Truncate the value to 32 bits by zeroing out the upper 32-bit field
 		 */
-		obj_desc->integer.value &= (u64) ACPI_UINT32_MAX;
+		obj_desc->integer.value &= (u64)ACPI_UINT32_MAX;
+		return (TRUE);
 	}
+
+	return (FALSE);
 }
 
 /*******************************************************************************
-- 
1.7.10

