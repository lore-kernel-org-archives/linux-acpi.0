From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/22] ACPICA: Update DSDT copy/detection.
Date: Thu, 20 May 2010 01:18:39 -0400
Message-ID: <43323cb4c4b619414913f54fef9d492aabadd033.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab0ETGPe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:34 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:15:01 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Move initialization of DSDT pointer. Emit address of DSDT
in the dump of both table headers (good/bad DSDT).
Now handles the case where the root table can be reallocated,
which would invalidate the original pointer.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/actables.h |    2 +-
 drivers/acpi/acpica/tbutils.c  |   23 ++++++++++++-----------
 drivers/acpi/acpica/tbxface.c  |   29 +++++++++++++++++++++++------
 drivers/acpi/acpica/utglobal.c |    1 +
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index e3813d2..87f21d9 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -175,7 +175,7 @@ ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
 
 /* DSDT information. Used to check for DSDT corruption */
 
-ACPI_EXTERN struct acpi_table_desc *acpi_gbl_DSDT;
+ACPI_EXTERN struct acpi_table_header *acpi_gbl_DSDT;
 ACPI_EXTERN struct acpi_table_header acpi_gbl_original_dsdt_header;
 
 /*
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index b7197bf..62a576e 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -109,7 +109,7 @@ acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
 void acpi_tb_check_dsdt_header(void);
 
-void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc);
+struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index);
 
 void
 acpi_tb_install_table(acpi_physical_address address,
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 1efb094..54a8712 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -366,22 +366,18 @@ void acpi_tb_check_dsdt_header(void)
 
 	/* Compare original length and checksum to current values */
 
-	if (acpi_gbl_original_dsdt_header.length !=
-	    acpi_gbl_DSDT->pointer->length
-	    || acpi_gbl_original_dsdt_header.checksum !=
-	    acpi_gbl_DSDT->pointer->checksum) {
+	if (acpi_gbl_original_dsdt_header.length != acpi_gbl_DSDT->length ||
+	    acpi_gbl_original_dsdt_header.checksum != acpi_gbl_DSDT->checksum) {
 		ACPI_ERROR((AE_INFO,
 			    "The DSDT has been corrupted or replaced - old, new headers below"));
 		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
-		acpi_tb_print_table_header(acpi_gbl_DSDT->address,
-					   acpi_gbl_DSDT->pointer);
+		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
 
 		/* Disable further error messages */
 
-		acpi_gbl_original_dsdt_header.length =
-		    acpi_gbl_DSDT->pointer->length;
+		acpi_gbl_original_dsdt_header.length = acpi_gbl_DSDT->length;
 		acpi_gbl_original_dsdt_header.checksum =
-		    acpi_gbl_DSDT->pointer->checksum;
+		    acpi_gbl_DSDT->checksum;
 	}
 }
 
@@ -399,15 +395,18 @@ void acpi_tb_check_dsdt_header(void)
  *
  ******************************************************************************/
 
-void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc)
+struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 {
 	struct acpi_table_header *new_table;
+	struct acpi_table_desc *table_desc;
+
+	table_desc = &acpi_gbl_root_table_list.tables[table_index];
 
 	new_table = ACPI_ALLOCATE(table_desc->length);
 	if (!new_table) {
 		ACPI_ERROR((AE_INFO, "Could not copy DSDT of length 0x%X",
 			    table_desc->length));
-		return;
+		return (NULL);
 	}
 
 	ACPI_MEMCPY(new_table, table_desc->pointer, table_desc->length);
@@ -418,6 +417,8 @@ void acpi_tb_copy_dsdt(struct acpi_table_desc *table_desc)
 	ACPI_INFO((AE_INFO,
 		   "Forced DSDT copy: length 0x%05X copied locally, original unmapped",
 		   new_table->length));
+
+	return (new_table);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index f5378fc..adb7f56 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -513,39 +513,56 @@ static acpi_status acpi_tb_load_namespace(void)
 {
 	acpi_status status;
 	u32 i;
+	struct acpi_table_header *new_dsdt;
 
 	ACPI_FUNCTION_TRACE(tb_load_namespace);
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
-	acpi_gbl_DSDT = &acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT];
-
 	/*
 	 * Load the namespace. The DSDT is required, but any SSDT and
 	 * PSDT tables are optional. Verify the DSDT.
 	 */
 	if (!acpi_gbl_root_table_list.count ||
-	    !ACPI_COMPARE_NAME(&acpi_gbl_DSDT->signature, ACPI_SIG_DSDT) ||
-	    ACPI_FAILURE(acpi_tb_verify_table(acpi_gbl_DSDT))) {
+	    !ACPI_COMPARE_NAME(&
+			       (acpi_gbl_root_table_list.
+				tables[ACPI_TABLE_INDEX_DSDT].signature),
+			       ACPI_SIG_DSDT)
+	    ||
+	    ACPI_FAILURE(acpi_tb_verify_table
+			 (&acpi_gbl_root_table_list.
+			  tables[ACPI_TABLE_INDEX_DSDT]))) {
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
 	}
 
 	/*
+	 * Save the DSDT pointer for simple access. This is the mapped memory
+	 * address. We must take care here because the address of the .Tables
+	 * array can change dynamically as tables are loaded at run-time. Note:
+	 * .Pointer field is not validated until after call to acpi_tb_verify_table.
+	 */
+	acpi_gbl_DSDT =
+	    acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT].pointer;
+
+	/*
 	 * Optionally copy the entire DSDT to local memory (instead of simply
 	 * mapping it.) There are some BIOSs that corrupt or replace the original
 	 * DSDT, creating the need for this option. Default is FALSE, do not copy
 	 * the DSDT.
 	 */
 	if (acpi_gbl_copy_dsdt_locally) {
-		acpi_tb_copy_dsdt(acpi_gbl_DSDT);
+		new_dsdt = acpi_tb_copy_dsdt(ACPI_TABLE_INDEX_DSDT);
+		if (new_dsdt) {
+			acpi_gbl_DSDT = new_dsdt;
+		}
 	}
 
 	/*
 	 * Save the original DSDT header for detection of table corruption
 	 * and/or replacement of the DSDT from outside the OS.
 	 */
-	ACPI_MEMCPY(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT->pointer,
+	ACPI_MEMCPY(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT,
 		    sizeof(struct acpi_table_header));
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index eda3e65..6611675 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -785,6 +785,7 @@ acpi_status acpi_ut_init_globals(void)
 
 	/* Miscellaneous variables */
 
+	acpi_gbl_DSDT = NULL;
 	acpi_gbl_cm_single_step = FALSE;
 	acpi_gbl_db_terminate_threads = FALSE;
 	acpi_gbl_shutdown = FALSE;
-- 
1.6.0.6

