From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI / OSL: Cleanup initrd table override code.
Date: Sun, 26 Jul 2015 21:54:22 +0800
Message-ID: <1437918863-3582-2-git-send-email-rui.zhang@intel.com>
References: <1437918863-3582-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51022 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754202AbbGZNy3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Jul 2015 09:54:29 -0400
In-Reply-To: <1437918863-3582-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lv.zheng@intel.com

From: Lv Zheng <lv.zheng@intel.com>

This patch cleans up initrd table override code, merging redundant logics
and re-ordering code blocks. No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/osl.c | 100 +++++++++++++++++++++++------------------------------
 1 file changed, 44 insertions(+), 56 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3b8963f..5643f51 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -576,6 +576,14 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 	return AE_OK;
 }
 
+static void acpi_table_taint(struct acpi_table_header *table)
+{
+	pr_warn(PREFIX
+		"Override [%4.4s-%8.8s], this is unsafe: tainting kernel\n",
+		table->signature, table->oem_table_id);
+	add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
+}
+
 #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
 #include <linux/earlycpio.h>
 #include <linux/memblock.h>
@@ -720,96 +728,76 @@ void __init acpi_initrd_override(void *data, size_t size)
 		}
 	}
 }
-#endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
-
-static void acpi_table_taint(struct acpi_table_header *table)
-{
-	pr_warn(PREFIX
-		"Override [%4.4s-%8.8s], this is unsafe: tainting kernel\n",
-		table->signature, table->oem_table_id);
-	add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
-}
-
-
-acpi_status
-acpi_os_table_override(struct acpi_table_header * existing_table,
-		       struct acpi_table_header ** new_table)
-{
-	if (!existing_table || !new_table)
-		return AE_BAD_PARAMETER;
-
-	*new_table = NULL;
-
-#ifdef CONFIG_ACPI_CUSTOM_DSDT
-	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
-		*new_table = (struct acpi_table_header *)AmlCode;
-#endif
-	if (*new_table != NULL)
-		acpi_table_taint(existing_table);
-	return AE_OK;
-}
 
 acpi_status
 acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 				acpi_physical_address *address,
 				u32 *table_length)
 {
-#ifndef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
-	*table_length = 0;
-	*address = 0;
-	return AE_OK;
-#else
 	int table_offset = 0;
 	struct acpi_table_header *table;
 
 	*table_length = 0;
 	*address = 0;
-
 	if (!acpi_tables_addr)
 		return AE_OK;
 
-	do {
-		if (table_offset + ACPI_HEADER_SIZE > all_tables_size) {
-			WARN_ON(1);
-			return AE_OK;
-		}
-
+	while (table_offset + ACPI_HEADER_SIZE < all_tables_size) {
 		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
 					   ACPI_HEADER_SIZE);
-
 		if (table_offset + table->length > all_tables_size) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			WARN_ON(1);
 			return AE_OK;
 		}
 
-		table_offset += table->length;
-
-		if (memcmp(existing_table->signature, table->signature, 4)) {
-			acpi_os_unmap_memory(table,
-				     ACPI_HEADER_SIZE);
-			continue;
-		}
-
-		/* Only override tables with matching oem id */
-		if (memcmp(table->oem_table_id, existing_table->oem_table_id,
+		/* Only override tables matched */
+		if (memcmp(existing_table->signature, table->signature, 4) ||
+		    memcmp(table->oem_table_id, existing_table->oem_table_id,
 			   ACPI_OEM_TABLE_ID_SIZE)) {
+			table_offset += table->length;
 			acpi_os_unmap_memory(table,
 				     ACPI_HEADER_SIZE);
 			continue;
 		}
 
-		table_offset -= table->length;
 		*table_length = table->length;
-		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 		*address = acpi_tables_addr + table_offset;
+		acpi_table_taint(existing_table);
+
+		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 		break;
-	} while (table_offset + ACPI_HEADER_SIZE < all_tables_size);
+	}
+	return AE_OK;
+}
+#else
+acpi_status
+acpi_os_physical_table_override(struct acpi_table_header *existing_table,
+				acpi_physical_address *address,
+				u32 *table_length)
+{
+	*table_length = 0;
+	*address = 0;
+	return AE_OK;
+}
+#endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
 
-	if (*address != 0)
+acpi_status
+acpi_os_table_override(struct acpi_table_header * existing_table,
+		       struct acpi_table_header ** new_table)
+{
+	if (!existing_table || !new_table)
+		return AE_BAD_PARAMETER;
+
+	*new_table = NULL;
+
+#ifdef CONFIG_ACPI_CUSTOM_DSDT
+	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
+		*new_table = (struct acpi_table_header *)AmlCode;
+#endif
+	if (*new_table != NULL)
 		acpi_table_taint(existing_table);
 	return AE_OK;
-#endif
 }
 
 static irqreturn_t acpi_irq(int irq, void *dev_id)
-- 
1.9.1

