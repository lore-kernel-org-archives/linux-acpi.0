From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPICA: Cleanup table handler naming conflicts.
Date: Fri, 11 Jan 2013 07:29:54 +0000 (UTC)
Message-ID: <7eb271f678434d6da767a3a78726240af521de64.1357982088.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com> <cover.1357982088.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13299 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab3AKH3v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2013 02:29:51 -0500
Date: Sat, 12 Jan 2013 23:29:38 +0800
In-Reply-To: <cover.1357982088.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This is a cosmetic patch only. Comparison of the resulting binary showed
only line number differences.

This patch does not affect the generation of the Linux binary.
This patch decreases 44 lines of 20121114 divergence.diff.

There are naming conflicts between Linux and ACPICA on table handlers. This
patch cleans up this conflicts to reduce the source code diff between Linux
and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Binary comparision result:
  None
---
Divergences fixing result:
  Before applying: 1963 Lines, 70.0 Kbytes
  After applying: 1919 Lines, 68.3 Kbytes
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/tbxface.c  |    4 ++--
 drivers/acpi/numa.c            |    2 +-
 drivers/acpi/tables.c          |    6 +++---
 include/acpi/acpixf.h          |    4 ++--
 include/acpi/actypes.h         |    2 +-
 include/linux/acpi.h           |   15 ++++++++++-----
 7 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 864806e..585d364 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -252,7 +252,7 @@ ACPI_EXTERN acpi_cache_t *acpi_gbl_operand_cache;
 ACPI_EXTERN struct acpi_global_notify_handler acpi_gbl_global_notify[2];
 ACPI_EXTERN acpi_exception_handler acpi_gbl_exception_handler;
 ACPI_EXTERN acpi_init_handler acpi_gbl_init_handler;
-ACPI_EXTERN acpi_tbl_handler acpi_gbl_table_handler;
+ACPI_EXTERN acpi_table_handler acpi_gbl_table_handler;
 ACPI_EXTERN void *acpi_gbl_table_handler_context;
 ACPI_EXTERN struct acpi_walk_state *acpi_gbl_breakpoint_walk;
 ACPI_EXTERN acpi_interface_handler acpi_gbl_interface_handler;
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index d102fe7..2115f22 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -436,7 +436,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_by_index)
  *
  ******************************************************************************/
 acpi_status
-acpi_install_table_handler(acpi_tbl_handler handler, void *context)
+acpi_install_table_handler(acpi_table_handler handler, void *context)
 {
 	acpi_status status;
 
@@ -482,7 +482,7 @@ ACPI_EXPORT_SYMBOL(acpi_install_table_handler)
  * DESCRIPTION: Remove table event handler
  *
  ******************************************************************************/
-acpi_status acpi_remove_table_handler(acpi_tbl_handler handler)
+acpi_status acpi_remove_table_handler(acpi_table_handler handler)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index cb31298..5ddbc65 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -273,7 +273,7 @@ static int __init acpi_parse_srat(struct acpi_table_header *table)
 
 static int __init
 acpi_table_parse_srat(enum acpi_srat_type id,
-		      acpi_table_entry_handler handler, unsigned int max_entries)
+		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
 	return acpi_table_parse_entries(ACPI_SIG_SRAT,
 					    sizeof(struct acpi_table_srat), id,
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2572d97..d67a1fe 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -204,7 +204,7 @@ int __init
 acpi_table_parse_entries(char *id,
 			     unsigned long table_size,
 			     int entry_id,
-			     acpi_table_entry_handler handler,
+			     acpi_tbl_entry_handler handler,
 			     unsigned int max_entries)
 {
 	struct acpi_table_header *table_header = NULL;
@@ -269,7 +269,7 @@ err:
 
 int __init
 acpi_table_parse_madt(enum acpi_madt_type id,
-		      acpi_table_entry_handler handler, unsigned int max_entries)
+		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
 	return acpi_table_parse_entries(ACPI_SIG_MADT,
 					    sizeof(struct acpi_table_madt), id,
@@ -285,7 +285,7 @@ acpi_table_parse_madt(enum acpi_madt_type id,
  * Scan the ACPI System Descriptor Table (STD) for a table matching @id,
  * run @handler on it.  Return 0 if table found, return on if not.
  */
-int __init acpi_table_parse(char *id, acpi_table_handler handler)
+int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
 	acpi_size tbl_size;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b86364d..d8b2ea6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -197,9 +197,9 @@ acpi_status
 acpi_get_table_by_index(u32 table_index, struct acpi_table_header **out_table);
 
 acpi_status
-acpi_install_table_handler(acpi_tbl_handler handler, void *context);
+acpi_install_table_handler(acpi_table_handler handler, void *context);
 
-acpi_status acpi_remove_table_handler(acpi_tbl_handler handler);
+acpi_status acpi_remove_table_handler(acpi_table_handler handler);
 
 /*
  * Namespace and name interfaces
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index cd89810..3d4e09c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -984,7 +984,7 @@ acpi_status(*acpi_exception_handler) (acpi_status aml_status,
 /* Table Event handler (Load, load_table, etc.) and types */
 
 typedef
-acpi_status(*acpi_tbl_handler) (u32 event, void *table, void *context);
+acpi_status(*acpi_table_handler) (u32 event, void *table, void *context);
 
 #define ACPI_TABLE_LOAD             0x0
 #define ACPI_TABLE_UNLOAD           0x1
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8c1d6f2..1e33ea0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -74,9 +74,10 @@ enum acpi_address_range_id {
 
 /* Table Handlers */
 
-typedef int (*acpi_table_handler) (struct acpi_table_header *table);
+typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
 
-typedef int (*acpi_table_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
+typedef int (*acpi_tbl_entry_handler)(struct acpi_subtable_header *header,
+				      const unsigned long end);
 
 #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
 void acpi_initrd_override(void *data, size_t size);
@@ -95,10 +96,14 @@ int acpi_mps_check (void);
 int acpi_numa_init (void);
 
 int acpi_table_init (void);
-int acpi_table_parse (char *id, acpi_table_handler handler);
+int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
-	int entry_id, acpi_table_entry_handler handler, unsigned int max_entries);
-int acpi_table_parse_madt (enum acpi_madt_type id, acpi_table_entry_handler handler, unsigned int max_entries);
+				    int entry_id,
+				    acpi_tbl_entry_handler handler,
+				    unsigned int max_entries);
+int acpi_table_parse_madt(enum acpi_madt_type id,
+			  acpi_tbl_entry_handler handler,
+			  unsigned int max_entries);
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
-- 
1.7.10

