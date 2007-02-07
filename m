From: Len Brown <lenb@kernel.org>
Subject: [PATCH 110/140] ACPICA: Fail AcpiEnable if ACPI tables not loaded.
Date: Wed,  7 Feb 2007 13:52:04 -0500
Message-ID: <11708745262321-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <c857303ad496e1f52955e95994a67869882e89f9.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422849AbXBGSzb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:31 -0500
In-Reply-To: <11708745253629-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
index 0cb7439..0874ab2 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -54,6 +54,29 @@ acpi_tb_get_root_table_entry(u8 * table_entry,
 
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
@@ -97,6 +97,8 @@ void acpi_tb_set_table_loaded_flag(acpi_native_uint table_index, u8 is_loaded);
 /*
  * tbutils - table manager utilities
  */
+u8 acpi_tb_tables_loaded(void);
+
 void
 acpi_tb_print_table_header(acpi_physical_address address,
 			   struct acpi_table_header *header);
-- 
1.5.0.rc3.39.gec804
