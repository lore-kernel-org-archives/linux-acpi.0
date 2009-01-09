From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/94] ACPICA: Add a mechanism to escape infinite AML While()
 loops
Date: Fri, 09 Jan 2009 04:26:25 -0500
Message-ID: <fc37445733aeae4fd1a20385850620354263b1d5.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbZAIJ16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:58 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700E866ALPOV2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:58 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add a loop counter to force exit from AML While loops if the
count becomes too large. This can occur in poorly written AML
when the hardware does not respond within a while loop and the
loop does not implement a timeout. The maximum loop count is
configurable. A new exception code is returned when a loop is
broken, AE_AML_INFINITE_LOOP.  Bob Moore, Alexey Starikovskiy.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsopcode.c |   26 ++++++++++++++++++++++----
 include/acpi/acconfig.h            |    4 ++++
 include/acpi/acexcep.h             |    4 +++-
 include/acpi/aclocal.h             |    1 +
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 5cd4066..50c892a 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -1262,13 +1262,31 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "[WHILE_OP] Op=%p\n", op));
 
-		if (walk_state->control_state->common.value) {
+		control_state = walk_state->control_state;
+		if (control_state->common.value) {
 
-			/* Predicate was true, go back and evaluate it again! */
+			/* Predicate was true, the body of the loop was just executed */
 
+			/*
+			 * This loop counter mechanism allows the interpreter to escape
+			 * possibly infinite loops. This can occur in poorly written AML
+			 * when the hardware does not respond within a while loop and the
+			 * loop does not implement a timeout.
+			 */
+			control_state->control.loop_count++;
+			if (control_state->control.loop_count >
+				ACPI_MAX_LOOP_ITERATIONS) {
+				status = AE_AML_INFINITE_LOOP;
+				break;
+			}
+
+			/*
+			 * Go back and evaluate the predicate and maybe execute the loop
+			 * another time
+			 */
 			status = AE_CTRL_PENDING;
 			walk_state->aml_last_while =
-			    walk_state->control_state->control.aml_predicate_start;
+			    control_state->control.aml_predicate_start;
 			break;
 		}
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 29feee2..e50fe71 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -119,6 +119,10 @@
 
 #define ACPI_ROOT_TABLE_SIZE_INCREMENT  4
 
+/* Maximum number of While() loop iterations before forced abort */
+
+#define ACPI_MAX_LOOP_ITERATIONS        0xFFFF
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 84f5cb2..a1ae105 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -153,8 +153,9 @@
 #define AE_AML_CIRCULAR_REFERENCE       (acpi_status) (0x001E | AE_CODE_AML)
 #define AE_AML_BAD_RESOURCE_LENGTH      (acpi_status) (0x001F | AE_CODE_AML)
 #define AE_AML_ILLEGAL_ADDRESS          (acpi_status) (0x0020 | AE_CODE_AML)
+#define AE_AML_INFINITE_LOOP            (acpi_status) (0x0021 | AE_CODE_AML)
 
-#define AE_CODE_AML_MAX                 0x0020
+#define AE_CODE_AML_MAX                 0x0021
 
 /*
  * Internal exceptions used for control
@@ -267,6 +268,7 @@ char const *acpi_gbl_exception_names_aml[] = {
 	"AE_AML_CIRCULAR_REFERENCE",
 	"AE_AML_BAD_RESOURCE_LENGTH",
 	"AE_AML_ILLEGAL_ADDRESS",
+	"AE_AML_INFINITE_LOOP"
 };
 
 char const *acpi_gbl_exception_names_ctrl[] = {
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index ecab527..0323fa9 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -566,6 +566,7 @@ struct acpi_control_state {
 	union acpi_parse_object *predicate_op;
 	u8 *aml_predicate_start;	/* Start of if/while predicate */
 	u8 *package_end;	/* End of if/while block */
+	u32 loop_count;		/* While() loop counter */
 };
 
 /*
-- 
1.5.6.6

