From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/98] ACPICA: Add override for dynamic tables
Date: Sat, 28 Mar 2009 00:30:52 -0400
Message-ID: <d3ccaff827cef5a5c5a0f3c97e1e2e6d99f618cb.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:34719 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbZC1Ece (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:34 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7001M88M70316@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:32 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add a call to acpi_os_table_override during the installation of a
dynamic table (loaded via the Load or LoadTable AML operators).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 37374b2..ef269a2 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -103,7 +103,9 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This function is called to add the ACPI table
+ * DESCRIPTION: This function is called to add an ACPI table. It is used to
+ *              dynamically load tables via the Load and load_table AML
+ *              operators.
  *
  ******************************************************************************/
 
@@ -112,6 +114,7 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 {
 	u32 i;
 	acpi_status status = AE_OK;
+	struct acpi_table_header *override_table = NULL;
 
 	ACPI_FUNCTION_TRACE(tb_add_table);
 
@@ -201,6 +204,29 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 		}
 	}
 
+	/*
+	 * ACPI Table Override:
+	 * Allow the host to override dynamically loaded tables.
+	 */
+	status = acpi_os_table_override(table_desc->pointer, &override_table);
+	if (ACPI_SUCCESS(status) && override_table) {
+		ACPI_INFO((AE_INFO,
+			   "%4.4s @ 0x%p Table override, replaced with:",
+			   table_desc->pointer->signature,
+			   ACPI_CAST_PTR(void, table_desc->address)));
+
+		/* We can delete the table that was passed as a parameter */
+
+		acpi_tb_delete_table(table_desc);
+
+		/* Setup descriptor for the new table */
+
+		table_desc->address = ACPI_PTR_TO_PHYSADDR(override_table);
+		table_desc->pointer = override_table;
+		table_desc->length = override_table->length;
+		table_desc->flags = ACPI_TABLE_ORIGIN_OVERRIDE;
+	}
+
 	/* Add the table to the global root table list */
 
 	status = acpi_tb_store_table(table_desc->address, table_desc->pointer,
-- 
1.6.0.6

