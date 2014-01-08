From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/21] ACPICA: Back port and refine validation of the XSDT root table.
Date: Wed,  8 Jan 2014 13:43:34 +0800
Message-ID: <1ca22a54cd8d2c52f88c6a608056bb489309b569.1387505702.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38945 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFnn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:43:43 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This feature is already in the Linux kernel.  When it is back ported to
ACPICA, code is refined to follow ACPICA coding style and this patch
is the generation of the integration.

Some platforms contain an XSDT that is ill-formed or otherwise invalid
(such as containing some or all entries that are NULL pointers).
This change adds a new function to validate the XSDT before actually
using it. If the XSDT is found to be invalid, ACPICA will now fall
back to using the RSDT instead.

Original-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbutils.c |  210 +++++++++++++++++++++++------------------
 include/acpi/actbl.h          |    3 +
 2 files changed, 123 insertions(+), 90 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 3d6bb83..ee60670 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -49,69 +49,11 @@
 ACPI_MODULE_NAME("tbutils")
 
 /* Local prototypes */
+static acpi_status acpi_tb_validate_xsdt(acpi_physical_address address);
+
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
 
-/*******************************************************************************
- *
- * FUNCTION:    acpi_tb_check_xsdt
- *
- * PARAMETERS:  address                    - Pointer to the XSDT
- *
- * RETURN:      status
- *		AE_OK - XSDT is okay
- *		AE_NO_MEMORY - can't map XSDT
- *		AE_INVALID_TABLE_LENGTH - invalid table length
- *		AE_NULL_ENTRY - XSDT has NULL entry
- *
- * DESCRIPTION: validate XSDT
-******************************************************************************/
-
-static acpi_status
-acpi_tb_check_xsdt(acpi_physical_address address)
-{
-	struct acpi_table_header *table;
-	u32 length;
-	u64 xsdt_entry_address;
-	u8 *table_entry;
-	u32 table_count;
-	int i;
-
-	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
-	if (!table)
-		return AE_NO_MEMORY;
-
-	length = table->length;
-	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
-	if (length < sizeof(struct acpi_table_header))
-		return AE_INVALID_TABLE_LENGTH;
-
-	table = acpi_os_map_memory(address, length);
-	if (!table)
-		return AE_NO_MEMORY;
-
-	/* Calculate the number of tables described in XSDT */
-	table_count =
-		(u32) ((table->length -
-		sizeof(struct acpi_table_header)) / sizeof(u64));
-	table_entry =
-		ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
-	for (i = 0; i < table_count; i++) {
-		ACPI_MOVE_64_TO_64(&xsdt_entry_address, table_entry);
-		if (!xsdt_entry_address) {
-			/* XSDT has NULL entry */
-			break;
-		}
-		table_entry += sizeof(u64);
-	}
-	acpi_os_unmap_memory(table, length);
-
-	if (i < table_count)
-		return AE_NULL_ENTRY;
-	else
-		return AE_OK;
-}
-
 #if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
@@ -383,7 +325,7 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 	 * Get the table physical address (32-bit for RSDT, 64-bit for XSDT):
 	 * Note: Addresses are 32-bit aligned (not 64) in both RSDT and XSDT
 	 */
-	if (table_entry_size == sizeof(u32)) {
+	if (table_entry_size == ACPI_RSDT_ENTRY_SIZE) {
 		/*
 		 * 32-bit platform, RSDT: Return 32-bit table entry
 		 * 64-bit platform, RSDT: Expand 32-bit to 64-bit and return
@@ -415,6 +357,87 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_validate_xsdt
+ *
+ * PARAMETERS:  address             - Physical address of the XSDT (from RSDP)
+ *
+ * RETURN:      Status. AE_OK if the table appears to be valid.
+ *
+ * DESCRIPTION: Validate an XSDT to ensure that it is of minimum size and does
+ *              not contain any NULL entries. A problem that is seen in the
+ *              field is that the XSDT exists, but is actually useless because
+ *              of one or more (or all) NULL entries.
+ *
+ ******************************************************************************/
+
+static acpi_status acpi_tb_validate_xsdt(acpi_physical_address xsdt_address)
+{
+	struct acpi_table_header *table;
+	u8 *next_entry;
+	acpi_physical_address address;
+	u32 length;
+	u32 entry_count;
+	acpi_status status;
+	u32 i;
+
+	/* Get the XSDT length */
+
+	table =
+	    acpi_os_map_memory(xsdt_address, sizeof(struct acpi_table_header));
+	if (!table) {
+		return (AE_NO_MEMORY);
+	}
+
+	length = table->length;
+	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+
+	/*
+	 * Minimum XSDT length is the size of the standard ACPI header
+	 * plus one physical address entry
+	 */
+	if (length < (sizeof(struct acpi_table_header) + ACPI_XSDT_ENTRY_SIZE)) {
+		return (AE_INVALID_TABLE_LENGTH);
+	}
+
+	/* Map the entire XSDT */
+
+	table = acpi_os_map_memory(xsdt_address, length);
+	if (!table) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Get the number of entries and pointer to first entry */
+
+	status = AE_OK;
+	next_entry = ACPI_ADD_PTR(u8, table, sizeof(struct acpi_table_header));
+	entry_count = (u32)((table->length - sizeof(struct acpi_table_header)) /
+			    ACPI_XSDT_ENTRY_SIZE);
+
+	/* Validate each entry (physical address) within the XSDT */
+
+	for (i = 0; i < entry_count; i++) {
+		address =
+		    acpi_tb_get_root_table_entry(next_entry,
+						 ACPI_XSDT_ENTRY_SIZE);
+		if (!address) {
+
+			/* Detected a NULL entry, XSDT is invalid */
+
+			status = AE_NULL_ENTRY;
+			break;
+		}
+
+		next_entry += ACPI_XSDT_ENTRY_SIZE;
+	}
+
+	/* Unmap table */
+
+	acpi_os_unmap_memory(table, length);
+	return (status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_parse_root_table
  *
  * PARAMETERS:  rsdp                    - Pointer to the RSDP
@@ -438,16 +461,14 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
-	acpi_physical_address uninitialized_var(rsdt_address);
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(tb_parse_root_table);
 
-	/*
-	 * Map the entire RSDP and extract the address of the RSDT or XSDT
-	 */
+	/* Map the entire RSDP and extract the address of the RSDT or XSDT */
+
 	rsdp = acpi_os_map_memory(rsdp_address, sizeof(struct acpi_table_rsdp));
 	if (!rsdp) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
@@ -459,22 +480,20 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 
 	/* Differentiate between RSDT and XSDT root tables */
 
-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
+	if ((rsdp->revision > 1) && rsdp->xsdt_physical_address
 			&& !acpi_rsdt_forced) {
 		/*
-		 * Root table is an XSDT (64-bit physical addresses). We must use the
-		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
-		 * the ACPI specification.
+		 * RSDP contains an XSDT (64-bit physical addresses). We must use
+		 * the XSDT if the revision is > 1 and the XSDT pointer is present,
+		 * as per the ACPI specification.
 		 */
 		address = (acpi_physical_address) rsdp->xsdt_physical_address;
-		table_entry_size = sizeof(u64);
-		rsdt_address = (acpi_physical_address)
-					rsdp->rsdt_physical_address;
+		table_entry_size = ACPI_XSDT_ENTRY_SIZE;
 	} else {
 		/* Root table is an RSDT (32-bit physical addresses) */
 
 		address = (acpi_physical_address) rsdp->rsdt_physical_address;
-		table_entry_size = sizeof(u32);
+		table_entry_size = ACPI_RSDT_ENTRY_SIZE;
 	}
 
 	/*
@@ -483,15 +502,25 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	 */
 	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
 
-	if (table_entry_size == sizeof(u64)) {
-		if (acpi_tb_check_xsdt(address) == AE_NULL_ENTRY) {
-			/* XSDT has NULL entry, RSDT is used */
-			address = rsdt_address;
-			table_entry_size = sizeof(u32);
-			ACPI_WARNING((AE_INFO, "BIOS XSDT has NULL entry, "
-					"using RSDT"));
+	/*
+	 * If it is present, validate the XSDT for access/size and ensure
+	 * that all table entries are at least non-NULL
+	 */
+	if (table_entry_size == ACPI_XSDT_ENTRY_SIZE) {
+		status = acpi_tb_validate_xsdt(address);
+		if (ACPI_FAILURE(status)) {
+			ACPI_BIOS_WARNING((AE_INFO,
+					   "XSDT is invalid (%s), using RSDT",
+					   acpi_format_exception(status)));
+
+			/* Fall back to the RSDT */
+
+			address =
+			    (acpi_physical_address) rsdp->rsdt_physical_address;
+			table_entry_size = ACPI_RSDT_ENTRY_SIZE;
 		}
 	}
+
 	/* Map the RSDT/XSDT table header to get the full table length */
 
 	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
@@ -501,12 +530,14 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 
 	acpi_tb_print_table_header(address, table);
 
-	/* Get the length of the full table, verify length and map entire table */
-
+	/*
+	 * Validate length of the table, and map entire table.
+	 * Minimum length table must contain at least one entry.
+	 */
 	length = table->length;
 	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
 
-	if (length < sizeof(struct acpi_table_header)) {
+	if (length < (sizeof(struct acpi_table_header) + table_entry_size)) {
 		ACPI_BIOS_ERROR((AE_INFO,
 				 "Invalid table length 0x%X in RSDT/XSDT",
 				 length));
@@ -526,22 +557,21 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Calculate the number of tables described in the root table */
+	/* Get the number of entries and pointer to first entry */
 
 	table_count = (u32)((table->length - sizeof(struct acpi_table_header)) /
 			    table_entry_size);
+	table_entry = ACPI_ADD_PTR(u8, table, sizeof(struct acpi_table_header));
+
 	/*
 	 * First two entries in the table array are reserved for the DSDT
 	 * and FACS, which are not actually present in the RSDT/XSDT - they
 	 * come from the FADT
 	 */
-	table_entry =
-	    ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
 	acpi_gbl_root_table_list.current_table_count = 2;
 
-	/*
-	 * Initialize the root table array from the RSDT/XSDT
-	 */
+	/* Initialize the root table array from the RSDT/XSDT */
+
 	for (i = 0; i < table_count; i++) {
 		if (acpi_gbl_root_table_list.current_table_count >=
 		    acpi_gbl_root_table_list.max_table_count) {
@@ -584,7 +614,7 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 		acpi_tb_install_table(acpi_gbl_root_table_list.tables[i].
 				      address, NULL, i);
 
-		/* Special case for FADT - get the DSDT and FACS */
+		/* Special case for FADT - validate it then get the DSDT and FACS */
 
 		if (ACPI_COMPARE_NAME
 		    (&acpi_gbl_root_table_list.tables[i].signature,
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 9497088..325aeae 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -182,6 +182,9 @@ struct acpi_table_xsdt {
 	u64 table_offset_entry[1];	/* Array of pointers to ACPI tables */
 };
 
+#define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
+#define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
+
 /*******************************************************************************
  *
  * FACS - Firmware ACPI Control Structure (FACS)
-- 
1.7.10

