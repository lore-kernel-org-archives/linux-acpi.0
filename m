From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/8] ACPI: acpi_tb_parse_root_table supports inactive tables
Date: Fri, 19 Dec 2008 15:57:48 +0800
Message-ID: <1229673468.562.137.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60600 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbYLSH7P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

support parsing the inactive root table in acpi_tb_parse_root_table.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbutils.c |  137 +++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 53 deletions(-)

Index: linux-2.6/drivers/acpi/tables/tbutils.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbutils.c
+++ linux-2.6/drivers/acpi/tables/tbutils.c
@@ -426,59 +426,78 @@ acpi_tb_parse_root_table(acpi_physical_a
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
-	acpi_physical_address uninitialized_var(rsdt_address);
+	acpi_physical_address rsdt_address, xsdt_address = 0;
+	static acpi_physical_address inactive_table_root_pointer;
+	static u32 inactive_table_entry_size;
+	struct acpi_internal_rsdt *root_table_list = get_root_table_list(flags);
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(tb_parse_root_table);
 
-	/*
-	 * Map the entire RSDP and extract the address of the RSDT or XSDT
-	 */
-	rsdp = acpi_os_map_memory(rsdp_address, sizeof(struct acpi_table_rsdp));
-	if (!rsdp) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	acpi_tb_print_table_header(rsdp_address,
-				   ACPI_CAST_PTR(struct acpi_table_header,
-						 rsdp));
-
-	/* Differentiate between RSDT and XSDT root tables */
-
-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
+	if (TABLE_IS_ACTIVE(flags)) {
 		/*
-		 * Root table is an XSDT (64-bit physical addresses). We must use the
-		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
-		 * the ACPI specification.
+		 * Map RSDP and extract the address of the RSDT or XSDT
 		 */
-		address = (acpi_physical_address) rsdp->xsdt_physical_address;
-		table_entry_size = sizeof(u64);
-		rsdt_address = (acpi_physical_address)
-					rsdp->rsdt_physical_address;
-	} else {
-		/* Root table is an RSDT (32-bit physical addresses) */
-
-		address = (acpi_physical_address) rsdp->rsdt_physical_address;
-		table_entry_size = sizeof(u32);
-	}
-
-	/*
-	 * It is not possible to map more than one entry in some environments,
-	 * so unmap the RSDP here before mapping other tables
-	 */
-	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
-
-	if (table_entry_size == sizeof(u64)) {
-		if (acpi_tb_check_xsdt(address) == AE_NULL_ENTRY) {
-			/* XSDT has NULL entry, RSDT is used */
+		rsdp = acpi_os_map_memory(rsdp_address,
+					sizeof(struct acpi_table_rsdp));
+		if (!rsdp)
+			return_ACPI_STATUS(AE_NO_MEMORY);
+
+		acpi_tb_print_table_header(rsdp_address,
+				ACPI_CAST_PTR(struct acpi_table_header,
+				rsdp));
+
+		/* Differentiate between RSDT and XSDT root tables */
+
+		rsdt_address =
+			(acpi_physical_address) rsdp->rsdt_physical_address;
+		if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
+			/*
+			 * Root table is an XSDT (64-bit physical addresses).
+			 * We must use the XSDT if the revision is > 1 and the
+			 * XSDT pointer is present, per the ACPI specification.
+			 */
+			xsdt_address = (acpi_physical_address)
+						rsdp->xsdt_physical_address;
+			address = xsdt_address;
+			table_entry_size = sizeof(u64);
+		} else {
+			/* Root table is an RSDT (32-bit physical addresses) */
+			xsdt_address = 0;
 			address = rsdt_address;
 			table_entry_size = sizeof(u32);
-			ACPI_WARNING((AE_INFO, "BIOS XSDT has NULL entry, "
-					"using RSDT"));
 		}
+
+		/*
+		 * It's not possible to map more than one entry in some
+		 * environments, so unmap the RSDP before mapping other tables
+		 */
+		acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
+
+		if (table_entry_size == sizeof(u64)) {
+			if (acpi_tb_check_xsdt(address) == AE_NULL_ENTRY) {
+				/* XSDT has NULL entry, RSDT is used */
+				address = rsdt_address;
+				table_entry_size = sizeof(u32);
+				ACPI_WARNING((AE_INFO, "XSDT has NULL entry, "
+						"using RSDT"));
+			}
+		}
+
+		inactive_table_root_pointer =
+			(address == rsdt_address ? xsdt_address : rsdt_address);
+		inactive_table_entry_size =
+					(table_entry_size == sizeof(u32) ?
+					sizeof(u64) : sizeof(u32));
+	} else {
+		if (!inactive_table_root_pointer)
+			return AE_NO_ACPI_TABLES;
+		address = inactive_table_root_pointer;
+		table_entry_size = inactive_table_entry_size;
 	}
+
 	/* Map the RSDT/XSDT table header to get the full table length */
 
 	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
@@ -486,7 +505,8 @@ acpi_tb_parse_root_table(acpi_physical_a
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	acpi_tb_print_table_header(address, table);
+	if (TABLE_IS_ACTIVE(flags))
+		acpi_tb_print_table_header(address, table);
 
 	/* Get the length of the full table, verify length and map entire table */
 
@@ -524,15 +544,26 @@ acpi_tb_parse_root_table(acpi_physical_a
 	 */
 	table_entry =
 	    ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
-	acpi_gbl_root_table_list.count = 2;
+	root_table_list->count = 2;
+
+	/* allocate memory for the inactive root table list */
+	if (!TABLE_IS_ACTIVE(flags)) {
+		if (!root_table_list->tables) {
+			root_table_list->size =
+				root_table_list->count + table_count;
+			root_table_list->tables = ACPI_ALLOCATE_ZEROED(
+					sizeof(struct acpi_table_desc) *
+					root_table_list->size);
+		}
+	}
 
 	/*
 	 * Initialize the root table array from the RSDT/XSDT
 	 */
 	for (i = 0; i < table_count; i++) {
-		if (acpi_gbl_root_table_list.count >=
-		    acpi_gbl_root_table_list.size) {
-
+		if (root_table_list->count >= root_table_list->size) {
+			if (!TABLE_IS_ACTIVE(flags))
+				break;
 			/* There is no more room in the root table array, attempt resize */
 
 			status = acpi_tb_resize_root_table_list();
@@ -549,12 +580,12 @@ acpi_tb_parse_root_table(acpi_physical_a
 
 		/* Get the table physical address (32-bit for RSDT, 64-bit for XSDT) */
 
-		acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
-		    address =
-		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
+		root_table_list->tables[root_table_list->count].address =
+				acpi_tb_get_root_table_entry(
+					table_entry, table_entry_size);
 
 		table_entry += table_entry_size;
-		acpi_gbl_root_table_list.count++;
+		root_table_list->count++;
 	}
 
 	/*
@@ -567,15 +598,15 @@ acpi_tb_parse_root_table(acpi_physical_a
 	 * Complete the initialization of the root table array by examining
 	 * the header of each table
 	 */
-	for (i = 2, table_count = acpi_gbl_root_table_list.count;
+	for (i = 2, table_count = root_table_list->count;
 		i < table_count; i++) {
-		acpi_tb_install_table(acpi_gbl_root_table_list.tables[i].
+		acpi_tb_install_table(root_table_list->tables[i].
 				      address, flags, NULL, i);
 
 		/* Special case for FADT - get the DSDT and FACS */
 
 		if (ACPI_COMPARE_NAME
-		    (&acpi_gbl_root_table_list.tables[i].signature,
+		    (&root_table_list->tables[i].signature,
 		     ACPI_SIG_FADT)) {
 			acpi_tb_parse_fadt(i, flags);
 		}


