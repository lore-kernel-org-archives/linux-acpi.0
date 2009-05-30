From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/65] ACPICA: Fix implementation of AML BreakPoint operator
 (break to debugger)
Date: Fri, 29 May 2009 21:41:56 -0400
Message-ID: <2b09ce98a25e467455ecd81354cc18381628be75.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40265 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbZE3Bmu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:50 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF0058JORFUAT3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:52 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The AML BreakPoint opcode will now cause a break into the AML
debugger if it is present/configured. This matches the expected
behavior per the ACPI specification. Previously, only a message
was output.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsopcode.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index b4c87b5..584d766 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -1386,14 +1386,19 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 	case AML_BREAK_POINT_OP:
 
-		/* Call up to the OS service layer to handle this */
-
-		status =
-		    acpi_os_signal(ACPI_SIGNAL_BREAKPOINT,
-				   "Executed AML Breakpoint opcode");
+		/*
+		 * Set the single-step flag. This will cause the debugger (if present)
+		 * to break to the console within the AML debugger at the start of the
+		 * next AML instruction.
+		 */
+		ACPI_DEBUGGER_EXEC(acpi_gbl_cm_single_step = TRUE);
+		ACPI_DEBUGGER_EXEC(acpi_os_printf
+				   ("**break** Executed AML BreakPoint opcode\n"));
 
-		/* If and when it returns, all done. */
+		/* Call to the OSL in case OS wants a piece of the action */
 
+		status = acpi_os_signal(ACPI_SIGNAL_BREAKPOINT,
+					"Executed AML Breakpoint opcode");
 		break;
 
 	case AML_BREAK_OP:
-- 
1.6.0.6

