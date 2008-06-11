From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/23] ACPICA: Fix for access to deleted object <regression>
Date: Wed, 11 Jun 2008 03:59:24 -0400
Message-ID: <21cd68744f9d37780e98e94072386c9062c7e8a8.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:37117 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbYFKH7g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:36 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A007K9GVB47R2@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:36 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes problem introduced in 20080123, with fix for Unload operator.
Parse tree object can be already deleted; must use the opcode
within the WalkState.

ACPI: kmemcheck: Caught 16-bit read from freed memory
http://bugzilla.kernel.org/show_bug.cgi?id=10669

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psargs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/parser/psargs.c b/drivers/acpi/parser/psargs.c
index f1e8bf6..e944637 100644
--- a/drivers/acpi/parser/psargs.c
+++ b/drivers/acpi/parser/psargs.c
@@ -268,7 +268,7 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 	 */
 	if (ACPI_SUCCESS(status) &&
 	    possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
-		if (walk_state->op->common.aml_opcode == AML_UNLOAD_OP) {
+		if (walk_state->opcode == AML_UNLOAD_OP) {
 			/*
 			 * acpi_ps_get_next_namestring has increased the AML pointer,
 			 * so we need to restore the saved AML pointer for method call.
@@ -691,7 +691,7 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 
 			/* To support super_name arg of Unload */
 
-			if (walk_state->op->common.aml_opcode == AML_UNLOAD_OP) {
+			if (walk_state->opcode == AML_UNLOAD_OP) {
 				status =
 				    acpi_ps_get_next_namepath(walk_state,
 							      parser_state, arg,
-- 
1.5.6.rc2.23.gea81e

