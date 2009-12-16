From: Len Brown <lenb@kernel.org>
Subject: [PATCH 068/103] ACPICA: Fix mutex errors when running _REG methods
Date: Wed, 16 Dec 2009 03:36:19 -0500
Message-ID: <d97659112044c0c77b93c6199eee7ee884eb3cca.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47226 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762011AbZLPLGK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:10 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:59 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes a problem where mutex errors can occur when running a _REG
method that is in the same scope as a method-defined operation
region or an operation region under a module-level IF block.
This is rare, so the problem has not been seen before.
ACPICA BZ 826.

http://www.acpica.org/bugzilla/show_bug.cgi?id=826

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dswload.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 9cc2289..b40513d 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -1052,9 +1052,22 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 			}
 
 			/*
-			 * If we are executing a method, initialize the region
+			 * The op_region is not fully parsed at this time. The only valid
+			 * argument is the space_id. (We must save the address of the
+			 * AML of the address and length operands)
+			 *
+			 * If we have a valid region, initialize it. The namespace is
+			 * unlocked at this point.
+			 *
+			 * Need to unlock interpreter if it is locked (if we are running
+			 * a control method), in order to allow _REG methods to be run
+			 * during acpi_ev_initialize_region.
 			 */
 			if (walk_state->method_node) {
+				/*
+				 * Executing a method: initialize the region and unlock
+				 * the interpreter
+				 */
 				status =
 				    acpi_ex_create_region(op->named.data,
 							  op->named.length,
@@ -1063,21 +1076,17 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 				if (ACPI_FAILURE(status)) {
 					return (status);
 				}
-			}
 
-			/*
-			 * The op_region is not fully parsed at this time. Only valid
-			 * argument is the space_id. (We must save the address of the
-			 * AML of the address and length operands)
-			 */
+				acpi_ex_exit_interpreter();
+			}
 
-			/*
-			 * If we have a valid region, initialize it
-			 * Namespace is NOT locked at this point.
-			 */
 			status =
 			    acpi_ev_initialize_region
 			    (acpi_ns_get_attached_object(node), FALSE);
+			if (walk_state->method_node) {
+				acpi_ex_enter_interpreter();
+			}
+
 			if (ACPI_FAILURE(status)) {
 				/*
 				 *  If AE_NOT_EXIST is returned, it is not fatal
-- 
1.6.0.6

