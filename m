From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/14] ACPI / OSL: Cleanup initrd table override code
Date: Sat,  6 Feb 2016 11:52:35 +0800
Message-ID: <a6aefa520c42da1c4735561a39057f585b471527.1454730659.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:15577 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbcBFDwl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Feb 2016 22:52:41 -0500
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch cleans up initrd table override code, merging redundant logics
and re-ordering code blocks. No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/osl.c |  114 ++++++++++++++++++++++++----------------------------
 1 file changed, 52 insertions(+), 62 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 67da6fb..abfc06b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -602,6 +602,14 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
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
@@ -746,96 +754,78 @@ void __init acpi_initrd_override(void *data, size_t size)
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
-				acpi_physical_address *address,
-				u32 *table_length)
+				acpi_physical_address *address, u32 *length)
 {
-#ifndef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
-	*table_length = 0;
-	*address = 0;
-	return AE_OK;
-#else
 	int table_offset = 0;
 	struct acpi_table_header *table;
+	u32 table_length;
 
-	*table_length = 0;
+	*length = 0;
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
+	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
 		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
 					   ACPI_HEADER_SIZE);
-
 		if (table_offset + table->length > all_tables_size) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			WARN_ON(1);
 			return AE_OK;
 		}
 
-		table_offset += table->length;
+		table_length = table->length;
 
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
-			acpi_os_unmap_memory(table,
-				     ACPI_HEADER_SIZE);
-			continue;
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			goto next_table;
 		}
 
-		table_offset -= table->length;
-		*table_length = table->length;
-		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+		*length = table_length;
 		*address = acpi_tables_addr + table_offset;
+		acpi_table_taint(existing_table);
+		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 		break;
-	} while (table_offset + ACPI_HEADER_SIZE < all_tables_size);
 
-	if (*address != 0)
-		acpi_table_taint(existing_table);
+next_table:
+		table_offset += table_length;
+	}
 	return AE_OK;
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
+
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
 #endif
+	if (*new_table != NULL)
+		acpi_table_taint(existing_table);
+	return AE_OK;
 }
 
 static irqreturn_t acpi_irq(int irq, void *dev_id)
-- 
1.7.10

