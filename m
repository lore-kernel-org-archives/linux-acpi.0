From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/60] Subject: [PATCH] ACPICA: Fix Scope() op in module level
 code
Date: Mon, 25 Oct 2010 02:20:51 -0400
Message-ID: <8df3fc981dc12d9fdcaef4100a2193b605024d7a.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38306 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab0JYJLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:03 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:03 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some Panasonic Toughbooks create nodes in module level code.
Module level code is the executable AML code outside of control method,
for example, below AML code creates a node \_SB.PCI0.GFX0.DD02.CUBL

        If (\_OSI ("Windows 2006"))
        {
            Scope (\_SB.PCI0.GFX0.DD02)
            {
                Name (CUBL, Ones)
                ...
            }
        }

Scope() op does not actually create a new object, it refers to an
existing object(\_SB.PCI0.GFX0.DD02 in above example). However, for
Scope(), we want to indeed open a new scope, so the child nodes(CUBL in
above example) can be created correctly under it.

https://bugzilla.kernel.org/show_bug.cgi?id=19462

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dswexec.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index d555b37..6b0b5d0 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -300,10 +300,25 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
 			 * we must enter this object into the namespace.  The created
 			 * object is temporary and will be deleted upon completion of
 			 * the execution of this method.
+			 *
+			 * Note 10/2010: Except for the Scope() op. This opcode does
+			 * not actually create a new object, it refers to an existing
+			 * object. However, for Scope(), we want to indeed open a
+			 * new scope.
 			 */
-			status = acpi_ds_load2_begin_op(walk_state, NULL);
+			if (op->common.aml_opcode != AML_SCOPE_OP) {
+				status =
+				    acpi_ds_load2_begin_op(walk_state, NULL);
+			} else {
+				status =
+				    acpi_ds_scope_stack_push(op->named.node,
+							     op->named.node->
+							     type, walk_state);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+			}
 		}
-
 		break;
 
 	case AML_CLASS_EXECUTE:
-- 
1.7.3.2.90.gd4c43

