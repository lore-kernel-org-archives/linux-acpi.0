From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/23] ACPICA: Fix for Load operator,
 load table at the namespace root
Date: Wed, 11 Jun 2008 03:59:22 -0400
Message-ID: <415067baafd391c9e82fdf8a0274638ea9cf2108.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:57809 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbYFKH7l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:41 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A00KUJGVBESV2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:35 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This reverts a change introduced in version 20071019. The table
is now loaded at the namespace root even though this goes against
the ACPI specification.  This provides compatibility with other
ACPI implementations.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 24da921..39d7421 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -375,9 +375,15 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		goto cleanup;
 	}
 
+	/*
+	 * Add the table to the namespace.
+	 *
+	 * Note: We load the table objects relative to the root of the namespace.
+	 * This appears to go against the ACPI specification, but we do it for
+	 * compatibility with other ACPI implementations.
+	 */
 	status =
-	    acpi_ex_add_table(table_index, walk_state->scope_info->scope.node,
-			      &ddb_handle);
+	    acpi_ex_add_table(table_index, acpi_gbl_root_node, &ddb_handle);
 	if (ACPI_FAILURE(status)) {
 
 		/* On error, table_ptr was deallocated above */
-- 
1.5.6.rc2.23.gea81e

