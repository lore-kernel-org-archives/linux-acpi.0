From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/6] ACPI: introduce new interface for inactive table
	management
Date: Mon, 13 Oct 2008 16:10:09 +0800
Message-ID: <1223885409.2735.185.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2423 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbYJMIMo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 04:12:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>


Introduce a new interface for inactive table management.
needed by the next patch, which creates sysfs I/F for inactive tables.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbxface.c |   47 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h         |    4 +++
 2 files changed, 51 insertions(+)

Index: linux-acpi-2.6/drivers/acpi/tables/tbxface.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/tables/tbxface.c
+++ linux-acpi-2.6/drivers/acpi/tables/tbxface.c
@@ -608,6 +608,53 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_by_ind
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_get_inactive_table_by_index
+ *
+ * PARAMETERS:  table_index         - Table index
+ *              Table               - Where the pointer to the table is returned
+ *
+ * RETURN:      Status and pointer to the table
+ *
+ * DESCRIPTION: Obtain a table by an index into the global inactive table list.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_get_inactive_table_by_index(u32 table_index,
+				 struct acpi_table_header **table)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_get_inactive_table_by_index);
+
+	/* Parameter validation */
+
+	if (!table)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	/* Validate index */
+	if (table_index >= acpi_gbl_inactive_root_table_list.count)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	if (!acpi_gbl_inactive_root_table_list.tables[table_index].flags)
+		return_ACPI_STATUS(AE_TABLE_NOT_SUPPORTED);
+
+	if (!acpi_gbl_inactive_root_table_list.tables[table_index].pointer) {
+
+		/* Table is not mapped, map it */
+
+		status =
+		    acpi_tb_verify_table(&acpi_gbl_inactive_root_table_list.
+					 tables[table_index]);
+		if (ACPI_FAILURE(status))
+			return_ACPI_STATUS(status);
+	}
+
+	*table = acpi_gbl_inactive_root_table_list.tables[table_index].pointer;
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_load_namespace
  *
  * PARAMETERS:  None
Index: linux-acpi-2.6/include/acpi/acpixf.h
===================================================================
--- linux-acpi-2.6.orig/include/acpi/acpixf.h
+++ linux-acpi-2.6/include/acpi/acpixf.h
@@ -122,6 +122,10 @@ acpi_get_table_by_index(u32 table_index,
 			struct acpi_table_header **out_table);
 
 acpi_status
+acpi_get_inactive_table_by_index(u32 table_index,
+			struct acpi_table_header **out_table);
+
+acpi_status
 acpi_install_table_handler(acpi_tbl_handler handler, void *context);
 
 acpi_status acpi_remove_table_handler(acpi_tbl_handler handler);


