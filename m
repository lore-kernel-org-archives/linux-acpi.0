From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/94] ACPICA: Optimize execution of AML While loops
Date: Fri, 09 Jan 2009 04:26:24 -0500
Message-ID: <96411a630412f057d365aa1e9de7d23c069d627a.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZAIJ2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:16 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LFE6ALLFF7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:58 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Previously, a control state object was allocated and freed for
each execution of the loop. The optimization is to simply reuse
the control state for each iteration. This speeds up the raw loop
execution time by about 5%.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsopcode.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 69fae59..5cd4066 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -1140,10 +1140,29 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 			  op->common.aml_opcode, walk_state));
 
 	switch (op->common.aml_opcode) {
-	case AML_IF_OP:
 	case AML_WHILE_OP:
 
 		/*
+		 * If this is an additional iteration of a while loop, continue.
+		 * There is no need to allocate a new control state.
+		 */
+		if (walk_state->control_state) {
+			if (walk_state->control_state->control.aml_predicate_start
+				== (walk_state->parser_state.aml - 1)) {
+
+				/* Reset the state to start-of-loop */
+
+				walk_state->control_state->common.state =
+				    ACPI_CONTROL_CONDITIONAL_EXECUTING;
+				break;
+			}
+		}
+
+		/*lint -fallthrough */
+
+	case AML_IF_OP:
+
+		/*
 		 * IF/WHILE: Create a new control state to manage these
 		 * constructs. We need to manage these as a stack, in order
 		 * to handle nesting.
@@ -1248,8 +1267,13 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 			/* Predicate was true, go back and evaluate it again! */
 
 			status = AE_CTRL_PENDING;
+			walk_state->aml_last_while =
+			    walk_state->control_state->control.aml_predicate_start;
+			break;
 		}
 
+		/* Predicate was false, terminate this while loop */
+
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 				  "[WHILE_OP] termination! Op=%p\n", op));
 
@@ -1257,9 +1281,6 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 		control_state =
 		    acpi_ut_pop_generic_state(&walk_state->control_state);
-
-		walk_state->aml_last_while =
-		    control_state->control.aml_predicate_start;
 		acpi_ut_delete_generic_state(control_state);
 		break;
 
-- 
1.5.6.6

