From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/22] ACPICA: Fix for acpi_reallocate_root_table for incorrect
 root table copy
Date: Thu, 20 May 2010 01:18:35 -0400
Message-ID: <333b04ae338e3421297d46c508f053a6767d2883.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:64217 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab0ETFTi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:19:38 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P004RGDFJX524@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:18:55 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

When copying the root table to the new allocation, the length
used was incorrect. The new size was used instead of the current
table size, meaning too much data was copied.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbxface.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 5217a61..684614d 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -172,6 +172,7 @@ acpi_status acpi_reallocate_root_table(void)
 {
 	struct acpi_table_desc *tables;
 	acpi_size new_size;
+	acpi_size current_size;
 
 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
 
@@ -183,9 +184,15 @@ acpi_status acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
-	new_size = ((acpi_size) acpi_gbl_root_table_list.count +
-		    ACPI_ROOT_TABLE_SIZE_INCREMENT) *
-	    sizeof(struct acpi_table_desc);
+	/*
+	 * Get the current size of the root table and add the default
+	 * increment to create the new table size.
+	 */
+	current_size = (acpi_size)
+	    acpi_gbl_root_table_list.count * sizeof(struct acpi_table_desc);
+
+	new_size = current_size +
+	    (ACPI_ROOT_TABLE_SIZE_INCREMENT * sizeof(struct acpi_table_desc));
 
 	/* Create new array and copy the old array */
 
@@ -194,10 +201,16 @@ acpi_status acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables, new_size);
+	ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables, current_size);
 
-	acpi_gbl_root_table_list.size = acpi_gbl_root_table_list.count;
+	/*
+	 * Update the root table descriptor. The new size will be the current
+	 * number of tables plus the increment, independent of the reserved
+	 * size of the original table list.
+	 */
 	acpi_gbl_root_table_list.tables = tables;
+	acpi_gbl_root_table_list.size =
+	    acpi_gbl_root_table_list.count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
 	acpi_gbl_root_table_list.flags =
 	    ACPI_ROOT_ORIGIN_ALLOCATED | ACPI_ROOT_ALLOW_RESIZE;
 
-- 
1.6.0.6

