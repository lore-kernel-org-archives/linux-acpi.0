From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/22] ACPICA: Add detection of corrupted/replaced DSDT
Date: Thu, 20 May 2010 01:18:37 -0400
Message-ID: <729df0f848daf2f17d02107199fa92efe909d995.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49068 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab0ETFS7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:18:59 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P008LVDFJZQV1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:18:56 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

This change adds support to detect a DSDT that has been corrupted
and/or replaced from outside the OS (by firmware). This is
typically catastrophic for the system, but has been seen on
some machines.

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    5 +++++
 drivers/acpi/acpica/actables.h |    2 ++
 drivers/acpi/acpica/psxface.c  |    4 ++++
 drivers/acpi/acpica/tbutils.c  |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbxface.c  |   32 ++++++++++++--------------------
 5 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 2b2e61e..a419fe9 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -165,6 +165,11 @@ ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_enable;
 ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_status;
 ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
 
+/* DSDT information. Used to check for DSDT corruption */
+
+ACPI_EXTERN struct acpi_table_desc *acpi_gbl_DSDT;
+ACPI_EXTERN struct acpi_table_header acpi_gbl_original_dsdt_header;
+
 /*
  * Handle both ACPI 1.0 and ACPI 2.0 Integer widths. The integer width is
  * determined by the revision of the DSDT: If the DSDT revision is less than
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 8ff3b74..fc52b6f 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -107,6 +107,8 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length);
 acpi_status
 acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
+void acpi_tb_check_dsdt_header(void);
+
 void
 acpi_tb_install_table(acpi_physical_address address,
 		      char *signature, u32 table_index);
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 6064dd4..67e7ad5 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -220,6 +220,10 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 
 	ACPI_FUNCTION_TRACE(ps_execute_method);
 
+	/* Quick validation of DSDT header */
+
+	acpi_tb_check_dsdt_header();
+
 	/* Validate the Info and method Node */
 
 	if (!info || !info->resolved_node) {
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index f47a70e..07bc743 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -349,6 +349,44 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_check_dsdt_header
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Quick compare to check validity of the DSDT. This will detect
+ *              if the DSDT has been replaced from outside the OS and/or if
+ *              the DSDT header has been corrupted.
+ *
+ ******************************************************************************/
+
+void acpi_tb_check_dsdt_header(void)
+{
+
+	/* Compare original length and checksum to current values */
+
+	if (acpi_gbl_original_dsdt_header.length !=
+	    acpi_gbl_DSDT->pointer->length
+	    || acpi_gbl_original_dsdt_header.checksum !=
+	    acpi_gbl_DSDT->pointer->checksum) {
+		ACPI_ERROR((AE_INFO,
+			    "The DSDT has been corrupted or replaced - old, new headers below"));
+		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
+		acpi_tb_print_table_header(acpi_gbl_DSDT->address,
+					   acpi_gbl_DSDT->pointer);
+
+		/* Disable further error messages */
+
+		acpi_gbl_original_dsdt_header.length =
+		    acpi_gbl_DSDT->pointer->length;
+		acpi_gbl_original_dsdt_header.checksum =
+		    acpi_gbl_DSDT->pointer->checksum;
+	}
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_install_table
  *
  * PARAMETERS:  Address                 - Physical address of DSDT or FACS
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 684614d..3056510 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -518,33 +518,25 @@ static acpi_status acpi_tb_load_namespace(void)
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
+	acpi_gbl_DSDT = &acpi_gbl_root_table_list.tables[ACPI_TABLE_INDEX_DSDT];
+
 	/*
-	 * Load the namespace. The DSDT is required, but any SSDT and PSDT tables
-	 * are optional.
+	 * Load the namespace. The DSDT is required, but any SSDT and
+	 * PSDT tables are optional. Verify the DSDT.
 	 */
 	if (!acpi_gbl_root_table_list.count ||
-	    !ACPI_COMPARE_NAME(&
-			       (acpi_gbl_root_table_list.
-				tables[ACPI_TABLE_INDEX_DSDT].signature),
-			       ACPI_SIG_DSDT)
-	    ||
-	    ACPI_FAILURE(acpi_tb_verify_table
-			 (&acpi_gbl_root_table_list.
-			  tables[ACPI_TABLE_INDEX_DSDT]))) {
+	    !ACPI_COMPARE_NAME(&acpi_gbl_DSDT->signature, ACPI_SIG_DSDT) ||
+	    ACPI_FAILURE(acpi_tb_verify_table(acpi_gbl_DSDT))) {
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
 	}
 
-	/* A valid DSDT is required */
-
-	status =
-	    acpi_tb_verify_table(&acpi_gbl_root_table_list.
-				 tables[ACPI_TABLE_INDEX_DSDT]);
-	if (ACPI_FAILURE(status)) {
-
-		status = AE_NO_ACPI_TABLES;
-		goto unlock_and_exit;
-	}
+	/*
+	 * Save the original DSDT header for detection of table corruption
+	 * and/or replacement of the DSDT from outside the OS.
+	 */
+	ACPI_MEMCPY(&acpi_gbl_original_dsdt_header, acpi_gbl_DSDT->pointer,
+		    sizeof(struct acpi_table_header));
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 
-- 
1.6.0.6

