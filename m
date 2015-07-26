From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 2/2] ACPI: Load OSDT tables from initrd at boot time
Date: Sun, 26 Jul 2015 21:54:23 +0800
Message-ID: <1437918863-3582-3-git-send-email-rui.zhang@intel.com>
References: <1437918863-3582-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51022 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754202AbbGZNyb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Jul 2015 09:54:31 -0400
In-Reply-To: <1437918863-3582-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lv.zheng@intel.com

This patch uses ACPI_INITRD_TABLE_OVERRIDE feature to load the OSDT
tables from initrd and install them at boot time.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/internal.h |  1 +
 drivers/acpi/osl.c      | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/tables.c   |  3 +++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4683a96..c00175e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -25,6 +25,7 @@
 
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
+int acpi_load_osdt(void);
 int acpi_scan_init(void);
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5643f51..e7b24f8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -612,7 +612,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
-	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
+	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_OSDT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
@@ -770,6 +770,47 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 	}
 	return AE_OK;
 }
+
+int __init acpi_load_osdt(void)
+{
+	int table_offset = 0;
+	struct acpi_table_header table, *p;
+	acpi_status status;
+
+	if (!acpi_tables_addr)
+		return 0;
+
+	do {
+		if (table_offset + ACPI_HEADER_SIZE > all_tables_size)
+			return 0;
+
+		p = acpi_os_map_memory(table_offset + acpi_tables_addr,
+				ACPI_HEADER_SIZE);
+		table = *p;
+		acpi_os_unmap_memory(p, ACPI_HEADER_SIZE);
+
+		if (table_offset + table.length > all_tables_size)
+			return 0;
+
+		if (memcmp(ACPI_SIG_OSDT, table.signature, 4)) {
+			table_offset += table.length;
+			continue;
+		}
+
+		status = acpi_install_table(table_offset + acpi_tables_addr,
+					ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL);
+		if (ACPI_FAILURE(status))
+			pr_warn(PREFIX "Override [%4.4s-%8.8s] failed!",
+				table.signature, table.oem_table_id);
+		else
+			acpi_table_taint(&table);
+
+		table_offset += table.length;
+	} while (table_offset + ACPI_HEADER_SIZE < all_tables_size);
+
+	return 0;
+}
+
 #else
 acpi_status
 acpi_os_physical_table_override(struct acpi_table_header *existing_table,
@@ -780,6 +821,11 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 	*address = 0;
 	return AE_OK;
 }
+
+int __init acpi_load_osdt(void)
+{
+	return 0;
+}
 #endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
 
 acpi_status
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2e19189..2c5b3fd 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -37,6 +37,7 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 
+#include "internal.h"
 #define ACPI_MAX_TABLES		128
 
 static char *mps_inti_flags_polarity[] = { "dfl", "high", "res", "low" };
@@ -403,6 +404,8 @@ int __init acpi_table_init(void)
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
 
+	acpi_load_osdt();
+
 	check_multiple_madt();
 	return 0;
 }
-- 
1.9.1

