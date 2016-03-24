From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 7/8] ACPICA: Tables: Add acpi_uninstall_table() to remove ACPI tables
Date: Thu, 24 Mar 2016 16:31:09 +0800
Message-ID: <692a4ea076f263f1967bedcd37fe83d8bbf2fd07.1458808078.git.lv.zheng@intel.com>
References: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:4314 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbcCXIbS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:31:18 -0400
In-Reply-To: <cover.1458808078.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

There are existing internal functions that allow the removal of ACPI
tables, but they are not exposed to OS in any useful way.

Introduce acpi_uninstall_table() which allows table states to be
"UNINSTALLED" in the global table list, resulting in failures of subsequent
calls to acpi_get_table() for those tables.

The rationale for this change is the ability to remove the BGRT table
during kexec boot. The BGRT table refers to memory regions that are no
longer reserved by the firmware once the kexec kernel boots, having been
released for general allocation by the previous kernel.

Note that acpi_tb_uninstall_table() is designed with limitation that it must
only be called after an acpi_tb_install_table() call as it doesn't handle
table reference count synchronizations. So it is only safe in a
single-threaded early booting environment.

Original-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbxfload.c |   42 ++++++++++++++++++++++++++++++++++++----
 drivers/acpi/osl.c             |    3 ++-
 include/acpi/acpixf.h          |    4 +++-
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 47b8b82..a4475f3 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -263,6 +263,7 @@ unlock_and_exit:
  * PARAMETERS:  address             - Address of the ACPI table to be installed.
  *              physical            - Whether the address is a physical table
  *                                    address or not
+ *              out_table_index     - Where the table index is returned
  *
  * RETURN:      Status
  *
@@ -272,12 +273,12 @@ unlock_and_exit:
  *
  ******************************************************************************/
 
-acpi_status __init
-acpi_install_table(acpi_physical_address address, u8 physical)
+acpi_status
+acpi_install_table(acpi_physical_address address,
+		   u8 physical, u32 *out_table_index)
 {
 	acpi_status status;
 	u8 flags;
-	u32 table_index;
 
 	ACPI_FUNCTION_TRACE(acpi_install_table);
 
@@ -288,7 +289,8 @@ acpi_install_table(acpi_physical_address address, u8 physical)
 	}
 
 	status = acpi_tb_verify_and_install_table(address, flags,
-						  FALSE, FALSE, &table_index);
+						  FALSE, FALSE,
+						  out_table_index);
 
 	return_ACPI_STATUS(status);
 }
@@ -297,6 +299,38 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_uninstall_table
+ *
+ * PARAMETERS:  table_index         - Table index
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dynamically uninstall an ACPI table.
+ *              Note: This function should only be invoked after
+ *                    acpi_initialize_tables() and before acpi_load_tables().
+ *
+ ******************************************************************************/
+void acpi_uninstall_table(u32 table_index)
+{
+
+	ACPI_FUNCTION_TRACE(acpi_uninstall_table);
+
+	/*
+	 * This function can only be used during early stage, so the table mutex
+	 * isn't required to be held.
+	 */
+	if (table_index < acpi_gbl_root_table_list.current_table_count) {
+		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.
+					tables[table_index]);
+	}
+
+	return_VOID;
+}
+
+ACPI_EXPORT_SYMBOL_INIT(acpi_uninstall_table)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_load_table
  *
  * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index bef06c9..e8c0737 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -809,6 +809,7 @@ void __init acpi_initrd_initialize_tables(void)
 	int table_offset = 0;
 	int table_index = 0;
 	u32 table_length;
+	u32 ddb;
 	struct acpi_table_header *table;
 
 	if (!acpi_tables_addr)
@@ -835,7 +836,7 @@ void __init acpi_initrd_initialize_tables(void)
 
 		acpi_table_taint(table);
 		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-		acpi_install_table(acpi_tables_addr + table_offset, TRUE);
+		acpi_install_table(acpi_tables_addr + table_offset, TRUE, &ddb);
 		set_bit(table_index, acpi_initrd_installed);
 next_table:
 		table_offset += table_length;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index cef1223..e41a99c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -469,7 +469,9 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
  */
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
 			    acpi_install_table(acpi_physical_address address,
-					       u8 physical))
+					       u8 physical,
+					       u32 *out_table_index))
+ACPI_EXTERNAL_RETURN_VOID(void acpi_uninstall_table(u32 table_index))
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_load_table(struct acpi_table_header *table))
-- 
1.7.10

