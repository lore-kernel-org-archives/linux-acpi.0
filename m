From: Len Brown <len.brown@intel.com>
Subject: [PATCH 63/65] ACPICA: Fail AcpiEnable if ACPI tables not loaded.
Date: Fri, 24 Nov 2006 02:19:13 -0500
Message-ID: <1164352823403-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com> <11643528141248-git-send-email-len.brown@intel.com> <11643528153363-git-send-email-len.brown@intel.com> <11643528161204-git-send-email-len.brown@intel.com> <11643528173586-git-send-email-len.brown@intel.com> <11643528181135-git-send-email-len.brown@intel.com> <11643528181927-git-send-email-len.brown@intel.com> <1164352819583-git-send-email-len.brown@intel.com> <11643528201749-git-send-email-len.brown@intel.com> <11643528211744-git-send-email-len.brown@intel.com> <11643528221925-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52563 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934511AbWKXHQZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:25 -0500
In-Reply-To: <11643528221925-git-send-email-len.brown@intel.com>
Message-Id: <fdbad6e3a27eb5b8aca9cfa765748e7b9d0d860d.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

AcpiEnable will now fail if all of the required ACPI tables are not
loaded (FADT, FACS, DSDT). BZ 477

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evxfevnt.c |    8 ++++++++
 drivers/acpi/tables/tbutils.c  |   23 +++++++++++++++++++++++
 include/acpi/actables.h        |    2 ++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/events/evxfevnt.c b/drivers/acpi/events/evxfevnt.c
index a3d148e..4eab4f5 100644
--- a/drivers/acpi/events/evxfevnt.c
+++ b/drivers/acpi/events/evxfevnt.c
@@ -65,6 +65,14 @@ acpi_status acpi_enable(void)
 
 	ACPI_FUNCTION_TRACE(acpi_enable);
 
+	/* ACPI tables must be present */
+
+	if (!acpi_tb_tables_loaded()) {
+		return_ACPI_STATUS(AE_NO_ACPI_TABLES);
+	}
+
+	/* Check current mode */
+
 	if (acpi_hw_get_mode() == ACPI_SYS_MODE_ACPI) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INIT,
 				  "System is already in ACPI mode\n"));
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index a456e6c..d191920 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -54,6 +54,29 @@ acpi_tb_get_root_table_entry(u8 * table_
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_tables_loaded
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      TRUE if required ACPI tables are loaded
+ *
+ * DESCRIPTION: Determine if the minimum required ACPI tables are present
+ *              (FADT, FACS, DSDT)
+ *
+ ******************************************************************************/
+
+u8 acpi_tb_tables_loaded(void)
+{
+
+	if (acpi_gbl_root_table_list.count >= 3) {
+		return (TRUE);
+	}
+
+	return (FALSE);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_print_table_header
  *
  * PARAMETERS:  Address             - Table physical address
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 5ef1b69..e7efb8a 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -97,6 +97,8 @@ void acpi_tb_set_table_loaded_flag(acpi_
 /*
  * tbutils - table manager utilities
  */
+u8 acpi_tb_tables_loaded(void);
+
 void
 acpi_tb_print_table_header(acpi_physical_address address,
 			   struct acpi_table_header *header);
-- 
1.4.4.1
