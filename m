From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch]: ACPI: Force to use RSDT when XSDT has NULL entry
Date: Fri, 24 Aug 2007 16:18:16 +0800
Message-ID: <1187943496.3766.5.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34635 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbXHXIOX (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 04:14:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Subject: ACPI: Force to use RSDT when XSDT has NULL entry 
From: Zhao Yakui  <yakui.zhao@intel.com>

Maybe XSDT has NULL entry address. When it is found that
XSDT has NULL entry address, the promote info is given to user
("XSDT has NULL entry address, RSDT is used automatically  ") and 
RSDT is used automatically.

http://bugzilla.kernel.org/show_bug.cgi?id=8630

Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>

---
 drivers/acpi/tables/tbutils.c |   83
+++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

Index: linux-2.6.23-rc3/drivers/acpi/tables/tbutils.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/tables/tbutils.c
+++ linux-2.6.23-rc3/drivers/acpi/tables/tbutils.c
@@ -51,6 +51,71 @@ ACPI_MODULE_NAME("tbutils")
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 * table_entry,
 			     acpi_native_uint table_entry_size);
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_check_xsdt
+ *
+ * PARAMETERS:  address                    - Pointer to the XSDT
+ *
+ * RETURN:      status
+		AE_OK means that there exists XSDT
+		AE_NO_MEMORY means that it can't be mmaped to virt address
+		AE_INVALID_TABLE_LENGTH means uncorrect table length
+		AE_NULL_ENTRY means that XSDT has NULL entry
+ *
+ * DESCRIPTION: check whether the XSDT has NULL entry
+******************************************************************************/
+
+static acpi_status
+acpi_tb_check_xsdt(acpi_physical_address address)
+{
+	struct acpi_table_header *table;
+	acpi_native_uint table_entry_size;
+	u32 length;
+	u64 xsdt_entry_address;
+	u8 *table_entry;
+	u32 table_count;
+	int i;
+	acpi_status status = AE_OK;
+
+	table_entry_size = sizeof(u64);
+	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
+	if (!table) {
+		/* XSDT can't be mmaped to virt address space */
+		status = AE_NO_MEMORY;
+		return status;
+	}
+	/* Get the length of the full table, and map entire table */
+	length = table->length;
+	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+	if (length < sizeof(struct acpi_table_header)) {
+		/* the length of XSDT isn't correct */
+		status = AE_INVALID_TABLE_LENGTH;
+		return status;
+	}
+	table = acpi_os_map_memory(address, length);
+	if (!table) {
+		status = AE_NO_MEMORY;
+		return status;
+	}
+	/* Calculate the number of tables described in the root table */
+	table_count =
+		(u32) ((table->length -
+		sizeof(struct acpi_table_header)) / table_entry_size);
+	table_entry =
+		ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
+	for (i = 0; i < table_count; i++) {
+		ACPI_MOVE_64_TO_64(&xsdt_entry_address, table_entry);
+		if (!xsdt_entry_address) {
+			/* XSDT has NULL entry */
+			status = AE_NULL_ENTRY ;
+			break;
+		}
+		table_entry += table_entry_size;
+	}
+	acpi_os_unmap_memory(table, length);
+	return status;
+}
 
 /*******************************************************************************
  *
@@ -341,12 +406,12 @@ acpi_tb_parse_root_table(acpi_physical_a
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
+	acpi_physical_address rsdt_address;
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(tb_parse_root_table);
-
 	/*
 	 * Map the entire RSDP and extract the address of the RSDT or XSDT
 	 */
@@ -369,19 +434,29 @@ acpi_tb_parse_root_table(acpi_physical_a
 		 */
 		address = (acpi_physical_address) rsdp->xsdt_physical_address;
 		table_entry_size = sizeof(u64);
+		/* backup rsdt_address */
+		rsdt_address = (acpi_physical_address)
+					rsdp->rsdt_physical_address;
 	} else {
 		/* Root table is an RSDT (32-bit physical addresses) */
 
 		address = (acpi_physical_address) rsdp->rsdt_physical_address;
 		table_entry_size = sizeof(u32);
 	}
-
 	/*
 	 * It is not possible to map more than one entry in some environments,
 	 * so unmap the RSDP here before mapping other tables
 	 */
 	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
-
+	if (table_entry_size == sizeof(u64)) {
+		if (acpi_tb_check_xsdt(address) == AE_NULL_ENTRY) {
+			/* XSDT has NULL entry,RSDT is used */
+			address = rsdt_address;
+			table_entry_size = sizeof(u32);
+			ACPI_WARNING((AE_INFO, "XSDT has NULL entry,"
+					"RSDT is used automatically"));
+		}
+	}
 	/* Map the RSDT/XSDT table header to get the full table length */
 
 	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
@@ -455,11 +530,9 @@ acpi_tb_parse_root_table(acpi_physical_a
 		acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
 		    address =
 		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
-
 		table_entry += table_entry_size;
 		acpi_gbl_root_table_list.count++;
 	}
-
 	/*
 	 * It is not possible to map more than one entry in some environments,
 	 * so unmap the root table here before mapping other tables
