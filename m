From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND] [RFC PATCH 5/6] ACPI: install all valid FACS tables
Date: Wed, 12 Nov 2008 16:29:09 +0800
Message-ID: <1226478549.15014.175.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36172 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbYKLIbu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 03:31:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

For some laptops,
the acpi_gbl_FADT.Xfacs and acpi_gbl_FADT.facs may point to
two different but valid FACS tables.

The waking vector on only one of them actually works,
but unfortunately we do not know which one to use.

Add acpi_gbl_FADT.facs table to the acp_gbl_root_table_list
if it exists and is different from acpi_gbl_FADT.XfacsFACS.

This is needed by the next patch, which set the waking vectors
in all the FACS tables in acpi_gbl_root_table_list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbfadt.c  |   17 +++++++++++++++++
 drivers/acpi/tables/tbutils.c |    3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

Index: linux-acpi-2.6/drivers/acpi/tables/tbfadt.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/tables/tbfadt.c
+++ linux-acpi-2.6/drivers/acpi/tables/tbfadt.c
@@ -159,6 +159,7 @@ void acpi_tb_parse_fadt(u32 table_index,
 {
 	u32 length;
 	struct acpi_table_header *table;
+	acpi_status status;
 
 	/*
 	 * The FADT has multiple versions with different lengths,
@@ -197,6 +198,22 @@ void acpi_tb_parse_fadt(u32 table_index,
 
 	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
 			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
+
+	/*
+	 * install the acpi_gbl_FADT.facs if it's not null
+	 * and it's different from acpi_gbl_FADT.Xfacs
+	 */
+	if (!acpi_gbl_FADT.facs || acpi_gbl_FADT.facs == acpi_gbl_FADT.Xfacs)
+		return;
+
+	if (acpi_gbl_root_table_list.count >= acpi_gbl_root_table_list.size) {
+		status = acpi_tb_resize_root_table_list();
+		if (ACPI_FAILURE(status))
+			return;
+	}
+	acpi_tb_install_table((acpi_physical_address)acpi_gbl_FADT.facs, flags,
+				ACPI_SIG_FACS, acpi_gbl_root_table_list.count);
+	acpi_gbl_root_table_list.count++;
 }
 
 /*******************************************************************************
Index: linux-acpi-2.6/drivers/acpi/tables/tbutils.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/tables/tbutils.c
+++ linux-acpi-2.6/drivers/acpi/tables/tbutils.c
@@ -546,7 +546,8 @@ acpi_tb_parse_root_table(acpi_physical_a
 	 * Complete the initialization of the root table array by examining
 	 * the header of each table
 	 */
-	for (i = 2; i < acpi_gbl_root_table_list.count; i++) {
+	for (i = 2, table_count = acpi_gbl_root_table_list.count;
+		i < table_count; i++) {
 		acpi_tb_install_table(acpi_gbl_root_table_list.tables[i].
 				      address, flags, NULL, i);
 


