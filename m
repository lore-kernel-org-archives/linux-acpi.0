From: Len Brown <lenb@kernel.org>
Subject: [PATCH 086/122] ACPICA: Fix table compare code, length then data
Date: Thu, 23 Oct 2008 02:39:00 -0400
Message-ID: <a6f30539f31a8129288b0e5640d3eb1174848c15.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYJWGoU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:13 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Split the ACPI table compare. First check that the lengths match
exactly. Then compare the data.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbinstal.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/tables/tbinstal.c
index 905dc38..18747ce 100644
--- a/drivers/acpi/tables/tbinstal.c
+++ b/drivers/acpi/tables/tbinstal.c
@@ -110,7 +110,6 @@ acpi_status
 acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 {
 	u32 i;
-	u32 length;
 	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE(tb_add_table);
@@ -145,13 +144,18 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 			}
 		}
 
-		/* Check for a table match on the entire table length */
+		/*
+		 * Check for a table match on the entire table length,
+		 * not just the header.
+		 */
+		if (table_desc->length !=
+		    acpi_gbl_root_table_list.tables[i].length) {
+			continue;
+		}
 
-		length = ACPI_MIN(table_desc->length,
-				  acpi_gbl_root_table_list.tables[i].length);
 		if (ACPI_MEMCMP(table_desc->pointer,
 				acpi_gbl_root_table_list.tables[i].pointer,
-				length)) {
+				acpi_gbl_root_table_list.tables[i].length)) {
 			continue;
 		}
 
-- 
1.5.5.1

