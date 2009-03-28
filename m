From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/98] ACPICA: Allow OS override of all ACPI tables
Date: Sat, 28 Mar 2009 00:30:50 -0400
Message-ID: <ac5f98db7be34cefc244026f882cf030debb7431.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8294 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbZC1EdM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:12 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700B3X8M6HWBK@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:31 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Previously, the table override mechanism was implemented for the
DSDT only. Now, any table in the RSDT/XSDT can be replaced by
the host OS. (including the DSDT).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 -
 drivers/acpi/acpica/tbutils.c  |   59 +++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/tbxface.c  |   31 +--------------------
 include/acpi/actbl.h           |    5 ++-
 4 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ddb40f5..634fb07 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -371,7 +371,6 @@ ACPI_EXTERN char *acpi_gbl_db_buffer;
 ACPI_EXTERN char *acpi_gbl_db_filename;
 ACPI_EXTERN u32 acpi_gbl_db_debug_level;
 ACPI_EXTERN u32 acpi_gbl_db_console_debug_level;
-ACPI_EXTERN struct acpi_table_header *acpi_gbl_db_table_ptr;
 ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_db_scope_node;
 
 /*
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 22ce489..e285bed 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -287,7 +287,10 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Install an ACPI table into the global data structure.
+ * DESCRIPTION: Install an ACPI table into the global data structure. The
+ *              table override mechanism is implemented here to allow the host
+ *              OS to replace any table before it is installed in the root
+ *              table array.
  *
  ******************************************************************************/
 
@@ -295,7 +298,10 @@ void
 acpi_tb_install_table(acpi_physical_address address,
 		      u8 flags, char *signature, u32 table_index)
 {
-	struct acpi_table_header *table;
+	acpi_status status;
+	struct acpi_table_header *table_to_install;
+	struct acpi_table_header *mapped_table;
+	struct acpi_table_header *override_table = NULL;
 
 	if (!address) {
 		ACPI_ERROR((AE_INFO,
@@ -306,41 +312,68 @@ acpi_tb_install_table(acpi_physical_address address,
 
 	/* Map just the table header */
 
-	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
-	if (!table) {
+	mapped_table =
+	    acpi_os_map_memory(address, sizeof(struct acpi_table_header));
+	if (!mapped_table) {
 		return;
 	}
 
-	/* If a particular signature is expected, signature must match */
+	/* If a particular signature is expected (DSDT/FACS), it must match */
 
-	if (signature && !ACPI_COMPARE_NAME(table->signature, signature)) {
+	if (signature && !ACPI_COMPARE_NAME(mapped_table->signature, signature)) {
 		ACPI_ERROR((AE_INFO,
-			    "Invalid signature 0x%X for ACPI table [%s]",
-			    *ACPI_CAST_PTR(u32, table->signature), signature));
+			    "Invalid signature 0x%X for ACPI table, expected [%s]",
+			    *ACPI_CAST_PTR(u32, mapped_table->signature),
+			    signature));
 		goto unmap_and_exit;
 	}
 
+	/*
+	 * ACPI Table Override:
+	 *
+	 * Before we install the table, let the host OS override it with a new
+	 * one if desired. Any table within the RSDT/XSDT can be replaced,
+	 * including the DSDT which is pointed to by the FADT.
+	 */
+	status = acpi_os_table_override(mapped_table, &override_table);
+	if (ACPI_SUCCESS(status) && override_table) {
+		ACPI_INFO((AE_INFO,
+			   "%4.4s @ 0x%p Table override, replaced with:",
+			   mapped_table->signature, ACPI_CAST_PTR(void,
+								  address)));
+
+		acpi_gbl_root_table_list.tables[table_index].pointer =
+		    override_table;
+		flags = ACPI_TABLE_ORIGIN_OVERRIDE;
+		address = ACPI_PTR_TO_PHYSADDR(override_table);
+
+		table_to_install = override_table;
+	} else {
+		table_to_install = mapped_table;
+	}
+
 	/* Initialize the table entry */
 
 	acpi_gbl_root_table_list.tables[table_index].address = address;
-	acpi_gbl_root_table_list.tables[table_index].length = table->length;
+	acpi_gbl_root_table_list.tables[table_index].length =
+	    table_to_install->length;
 	acpi_gbl_root_table_list.tables[table_index].flags = flags;
 
 	ACPI_MOVE_32_TO_32(&
 			   (acpi_gbl_root_table_list.tables[table_index].
-			    signature), table->signature);
+			    signature), table_to_install->signature);
 
-	acpi_tb_print_table_header(address, table);
+	acpi_tb_print_table_header(address, table_to_install);
 
 	if (table_index == ACPI_TABLE_INDEX_DSDT) {
 
 		/* Global integer width is based upon revision of the DSDT */
 
-		acpi_ut_set_integer_width(table->revision);
+		acpi_ut_set_integer_width(table_to_install->revision);
 	}
 
       unmap_and_exit:
-	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+	acpi_os_unmap_memory(mapped_table, sizeof(struct acpi_table_header));
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index c3e841f..f3f95e3 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -491,7 +491,6 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_by_index)
 static acpi_status acpi_tb_load_namespace(void)
 {
 	acpi_status status;
-	struct acpi_table_header *table;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(tb_load_namespace);
@@ -515,41 +514,13 @@ static acpi_status acpi_tb_load_namespace(void)
 		goto unlock_and_exit;
 	}
 
-	/*
-	 * Find DSDT table
-	 */
-	status =
-	    acpi_os_table_override(acpi_gbl_root_table_list.
-				   tables[ACPI_TABLE_INDEX_DSDT].pointer,
-				   &table);
-	if (ACPI_SUCCESS(status) && table) {
-		/*
-		 * DSDT table has been found
-		 */
-		acpi_tb_delete_table(&acpi_gbl_root_table_list.
-				     tables[ACPI_TABLE_INDEX_DSDT]);
-		acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].pointer =
-		    table;
-		acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].length =
-		    table->length;
-		acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].flags =
-		    ACPI_TABLE_ORIGIN_UNKNOWN;
-
-		ACPI_INFO((AE_INFO, "Table DSDT replaced by host OS"));
-		acpi_tb_print_table_header(0, table);
-
-		if (no_auto_ssdt == 0) {
-			printk(KERN_WARNING "ACPI: DSDT override uses original SSDTs unless \"acpi_no_auto_ssdt\"\n");
-		}
-	}
+	/* A valid DSDT is required */
 
 	status =
 	    acpi_tb_verify_table(&acpi_gbl_root_table_list.
 				 tables[ACPI_TABLE_INDEX_DSDT]);
 	if (ACPI_FAILURE(status)) {
 
-		/* A valid DSDT is required */
-
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
 	}
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index bf8d4cf..1f3dfdb 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -310,8 +310,9 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_UNKNOWN       (0)
 #define ACPI_TABLE_ORIGIN_MAPPED        (1)
 #define ACPI_TABLE_ORIGIN_ALLOCATED     (2)
-#define ACPI_TABLE_ORIGIN_MASK          (3)
-#define ACPI_TABLE_IS_LOADED            (4)
+#define ACPI_TABLE_ORIGIN_OVERRIDE      (4)
+#define ACPI_TABLE_ORIGIN_MASK          (7)
+#define ACPI_TABLE_IS_LOADED            (8)
 
 /*
  * Get the remaining ACPI tables
-- 
1.6.0.6

