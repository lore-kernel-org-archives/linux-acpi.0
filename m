From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/14] ACPI / OSL: Add support to install tables via initrd
Date: Sat,  6 Feb 2016 11:52:41 +0800
Message-ID: <5f9ce37e18725cec00f72183a54df670d65bed3e.1454730659.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds support to install tables from initrd.

If a table in the initrd wasn't used by the override mechanism, the table
would be installed after initializing all RSDT/XSDT tables.

Reference: https://lkml.org/lkml/2014/2/28/368
Reported-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/internal.h |    1 +
 drivers/acpi/osl.c      |   50 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/tables.c   |    2 ++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 1e6833a..27c2cb9 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -20,6 +20,7 @@
 
 #define PREFIX "ACPI: "
 
+void acpi_initrd_initialize_tables(void);
 acpi_status acpi_os_initialize1(void);
 void init_acpi_device_notify(void);
 int acpi_scan_init(void);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index abfc06b..26f1dc8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -644,6 +644,7 @@ static const char * const table_sigs[] = {
 
 #define ACPI_OVERRIDE_TABLES 64
 static struct cpio_data __initdata acpi_initrd_files[ACPI_OVERRIDE_TABLES];
+static DECLARE_BITMAP(acpi_initrd_installed, ACPI_OVERRIDE_TABLES);
 
 #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
 
@@ -760,6 +761,7 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 				acpi_physical_address *address, u32 *length)
 {
 	int table_offset = 0;
+	int table_index = 0;
 	struct acpi_table_header *table;
 	u32 table_length;
 
@@ -780,7 +782,8 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 		table_length = table->length;
 
 		/* Only override tables matched */
-		if (memcmp(existing_table->signature, table->signature, 4) ||
+		if (test_bit(table_index, acpi_initrd_installed) ||
+		    memcmp(existing_table->signature, table->signature, 4) ||
 		    memcmp(table->oem_table_id, existing_table->oem_table_id,
 			   ACPI_OEM_TABLE_ID_SIZE)) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
@@ -791,13 +794,54 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 		*address = acpi_tables_addr + table_offset;
 		acpi_table_taint(existing_table);
 		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+		set_bit(table_index, acpi_initrd_installed);
 		break;
 
 next_table:
 		table_offset += table_length;
+		table_index++;
 	}
 	return AE_OK;
 }
+
+void __init acpi_initrd_initialize_tables(void)
+{
+	int table_offset = 0;
+	int table_index = 0;
+	u32 table_length;
+	struct acpi_table_header *table;
+
+	if (!acpi_tables_addr)
+		return;
+
+	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
+		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
+					   ACPI_HEADER_SIZE);
+		if (table_offset + table->length > all_tables_size) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			WARN_ON(1);
+			return;
+		}
+
+		table_length = table->length;
+
+		/* Skip RSDT/XSDT which should only be used for override */
+		if (test_bit(table_index, acpi_initrd_installed) ||
+		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_RSDT) ||
+		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_XSDT)) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			goto next_table;
+		}
+
+		acpi_table_taint(table);
+		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+		acpi_install_table(acpi_tables_addr + table_offset, TRUE);
+		set_bit(table_index, acpi_initrd_installed);
+next_table:
+		table_offset += table_length;
+		table_index++;
+	}
+}
 #else
 acpi_status
 acpi_os_physical_table_override(struct acpi_table_header *existing_table,
@@ -808,6 +852,10 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 	*address = 0;
 	return AE_OK;
 }
+
+void __init acpi_initrd_initialize_tables(void)
+{
+}
 #endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
 
 acpi_status
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 6c0f079..57c0a45 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include "internal.h"
 
 #define ACPI_MAX_TABLES		128
 
@@ -456,6 +457,7 @@ int __init acpi_table_init(void)
 	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
+	acpi_initrd_initialize_tables();
 
 	check_multiple_madt();
 	return 0;
-- 
1.7.10
