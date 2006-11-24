From: Len Brown <len.brown@intel.com>
Subject: [PATCH 30/65] ACPICA: re-factor table init routines for benefit of iASL
Date: Fri, 24 Nov 2006 02:18:40 -0500
Message-ID: <1164352792447-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934474AbWKXHPy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:54 -0500
In-Reply-To: <1164352791852-git-send-email-len.brown@intel.com>
Message-Id: <ff81896d6f21cfd03e168b175a6bce110fb73983.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Required new table init interface since iASL does not use RSDP/XSDT.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbxface.c |   30 +++++++++++++++++++++++++-----
 include/acpi/actables.h       |    2 ++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index 3540fe6..c5009f5 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -54,6 +54,29 @@ static acpi_status acpi_tb_load_namespac
 
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
@@ -79,7 +102,7 @@ static acpi_status acpi_tb_load_namespac
  ******************************************************************************/
 
 acpi_status
-acpi_initialize_tables(struct acpi_table_desc *initial_table_array,
+acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 		       u32 initial_table_count, u8 allow_resize)
 {
 	acpi_physical_address rsdp_address;
@@ -92,10 +115,7 @@ acpi_initialize_tables(struct acpi_table
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
1.4.4.1
