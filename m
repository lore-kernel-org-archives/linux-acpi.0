From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPICA: Add hard limit to while loop
Date: Thu, 09 Oct 2008 14:35:39 +0400
Message-ID: <20081009103539.1238.81357.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:50467 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752753AbYJIKfQ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 06:35:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

We need to prevent infinite loops and lockups

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/dispatcher/dsopcode.c |    9 +++++++--
 include/acpi/acstruct.h            |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 6a81c44..e2a3535 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -1246,8 +1246,13 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 		if (walk_state->control_state->common.value) {
 
 			/* Predicate was true, go back and evaluate it again! */
-
-			status = AE_CTRL_PENDING;
+			/* Use hard limit to prevent infinite loops and lockups */
+			if (++walk_state->cycle_count > 0xFFFF) {
+				status = AE_LIMIT;
+				ACPI_ERROR ((AE_INFO, "Infinite loop detected"));
+			} else {
+				status = AE_CTRL_PENDING;
+			}
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
diff --git a/include/acpi/acstruct.h b/include/acpi/acstruct.h
index 7980a26..fb4405e 100644
--- a/include/acpi/acstruct.h
+++ b/include/acpi/acstruct.h
@@ -94,6 +94,7 @@ struct acpi_walk_state {
 	u32 method_breakpoint;	/* For single stepping */
 	u32 user_breakpoint;	/* User AML breakpoint */
 	u32 parse_flags;
+	u32 cycle_count;	/* While loop cycle count */
 
 	struct acpi_parse_state parser_state;	/* Current state of parser */
 	u32 prev_arg_types;

