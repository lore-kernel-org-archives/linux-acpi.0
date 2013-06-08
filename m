From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/16] ACPICA: Add option to disable loading of SSDTs from the RSDT/XSDT
Date: Sat,  8 Jun 2013 08:58:48 +0800
Message-ID: <b71cf83618769ae2c866466364ce87c0e9ee8449.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28483 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717Ab3FHA7N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 20:59:13 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

Optionally do not load any SSDTs from the RSDT/XSDT during
initialization.  This can be useful for overriding SSDTs
using DSDT overriding, thus useful for debugging ACPI
problems on some machines.  Lv Zheng. ACPICA BZ 1005.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1005
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    6 ++++++
 drivers/acpi/acpica/tbxfload.c |   25 ++++++++++---------------
 drivers/acpi/osl.c             |   11 +++++++++++
 include/acpi/acpixf.h          |    1 +
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 0716092..b8d3811 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -132,6 +132,12 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_truncate_io_addresses, FALSE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_disable_auto_repair, FALSE);
 
+/*
+ * Optionally do not load any SSDTs from the RSDT/XSDT during initialization.
+ * This can be useful for debugging ACPI problems on some machines.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_disable_ssdt_table_load, FALSE);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 67e046e..0ba9e32 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -53,8 +53,6 @@ ACPI_MODULE_NAME("tbxfload")
 /* Local prototypes */
 static acpi_status acpi_tb_load_namespace(void);
 
-static int no_auto_ssdt;
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_load_tables
@@ -180,8 +178,16 @@ static acpi_status acpi_tb_load_namespace(void)
 			continue;
 		}
 
-		if (no_auto_ssdt) {
-			printk(KERN_WARNING "ACPI: SSDT ignored due to \"acpi_no_auto_ssdt\"\n");
+		/*
+		 * Optionally do not load any SSDTs from the RSDT/XSDT. This can
+		 * be useful for debugging ACPI problems on some machines.
+		 */
+		if (acpi_gbl_disable_ssdt_table_load) {
+			ACPI_INFO((AE_INFO, "Ignoring %4.4s at %p",
+				   acpi_gbl_root_table_list.tables[i].signature.
+				   ascii, ACPI_CAST_PTR(void,
+							acpi_gbl_root_table_list.
+							tables[i].address)));
 			continue;
 		}
 
@@ -376,14 +382,3 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_unload_parent_table)
-
-static int __init acpi_no_auto_ssdt_setup(char *s) {
-
-        printk(KERN_NOTICE "ACPI: SSDT auto-load disabled\n");
-
-        no_auto_ssdt = 1;
-
-        return 1;
-}
-
-__setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e721863..da6b663 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1715,6 +1715,17 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 }
 #endif
 
+static int __init acpi_no_auto_ssdt_setup(char *s)
+{
+        printk(KERN_NOTICE PREFIX "SSDT auto-load disabled\n");
+
+        acpi_gbl_disable_ssdt_table_load = TRUE;
+
+        return 1;
+}
+
+__setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
+
 acpi_status __init acpi_os_initialize(void)
 {
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1561264..5d9bf46 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -80,6 +80,7 @@ extern bool acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_truncate_io_addresses;
 extern u8 acpi_gbl_disable_auto_repair;
+extern u8 acpi_gbl_disable_ssdt_table_load;
 
 /*
  * Hardware-reduced prototypes. All interfaces that use these macros will
-- 
1.7.10

