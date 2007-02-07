From: Len Brown <lenb@kernel.org>
Subject: [PATCH 71/140] ACPICA: re-factor table init routines for benefit of iASL
Date: Wed,  7 Feb 2007 13:51:25 -0500
Message-ID: <11708744813011-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:28120 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422802AbXBGSyq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:46 -0500
In-Reply-To: <11708744803527-git-send-email-lenb@kernel.org>
Message-Id: <77389e1263a7c9bc8040bda726e08b6501ba1c8b.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Required new table init interface since iASL does not use RSDP/XSDT.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbxface.c |   30 +++++++++++++++++++++++++-----
 include/acpi/actables.h       |    2 ++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index 94544a6..9d451e8 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -54,6 +54,29 @@ static acpi_status acpi_tb_load_namespace(void);
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_allocate_root_table
+ *
+ * PARAMETERS:  initial_table_count - Size of initial_table_array, in number of
+ *                                    struct acpi_table_desc structures
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Allocate a root table array. Used by i_aSL compiler and
+ *              acpi_initialize_tables.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_allocate_root_table(u32 initial_table_count)
+{
+
+	acpi_gbl_root_table_list.size = initial_table_count;
+	acpi_gbl_root_table_list.flags = ACPI_ROOT_ALLOW_RESIZE;
+
+	return (acpi_tb_resize_root_table_list());
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_initialize_tables
  *
  * PARAMETERS:  initial_table_array - Pointer to an array of pre-allocated
@@ -79,7 +102,7 @@ static acpi_status acpi_tb_load_namespace(void);
  ******************************************************************************/
 
 acpi_status __init
-acpi_initialize_tables(struct acpi_table_desc *initial_table_array,
+acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 		       u32 initial_table_count, u8 allow_resize)
 {
 	acpi_physical_address rsdp_address;
@@ -92,10 +115,7 @@ acpi_initialize_tables(struct acpi_table_desc *initial_table_array,
 	 * Allocate the table array if requested
 	 */
 	if (!initial_table_array) {
-		acpi_gbl_root_table_list.size = initial_table_count;
-		acpi_gbl_root_table_list.flags = ACPI_ROOT_ALLOW_RESIZE;
-
-		status = acpi_tb_resize_root_table_list();
+		status = acpi_allocate_root_table(initial_table_count);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 6294734..99fa51a 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -44,6 +44,8 @@
 #ifndef __ACTABLES_H__
 #define __ACTABLES_H__
 
+acpi_status acpi_allocate_root_table(u32 initial_table_count);
+
 /*
  * tbfadt - FADT parse/convert/validate
  */
-- 
1.5.0.rc3.39.gec804
