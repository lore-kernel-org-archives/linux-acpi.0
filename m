From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/6] ACPI:  introduce the inactive ACPI tables mangement
Date: Mon, 13 Oct 2008 16:10:07 +0800
Message-ID: <1223885407.2735.184.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9108 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575AbYJMIMF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 04:12:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>


RSDT and XSDT may export different tables.
Linux uses either RSDT or XSDT as the root table.
There are some inactive tables which exists but is not used,
e.g. Linux is using XSDT but the table is exported by RSDT only.

Sometimes we still need to dump these inactive tables for debugging.

This patch introduces the inactive table management in Linux.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbutils.c |   22 +++----
 drivers/acpi/tables/tbxface.c |  131 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acglobal.h       |    3 
 include/acpi/acpixf.h         |    2 
 include/acpi/actables.h       |    3 
 5 files changed, 151 insertions(+), 10 deletions(-)

Index: linux-acpi-2.6/include/acpi/acglobal.h
===================================================================
--- linux-acpi-2.6.orig/include/acpi/acglobal.h
+++ linux-acpi-2.6/include/acpi/acglobal.h
@@ -139,6 +139,9 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
  * acpi_gbl_FADT is a local copy of the FADT, converted to a common format.
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
+ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_inactive_root_table_list;
+ACPI_EXTERN acpi_physical_address acpi_inactive_tables_root_pointer;
+ACPI_EXTERN u32 acpi_inactive_tables_entry_size;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
 extern u8 acpi_gbl_permanent_mmap;
 
Index: linux-acpi-2.6/include/acpi/acpixf.h
===================================================================
--- linux-acpi-2.6.orig/include/acpi/acpixf.h
+++ linux-acpi-2.6/include/acpi/acpixf.h
@@ -54,6 +54,8 @@
 acpi_status
 acpi_initialize_tables(struct acpi_table_desc *initial_storage,
 		       u32 initial_table_count, u8 allow_resize);
+acpi_status
+acpi_initialize_inactive_tables(void);
 
 acpi_status __init acpi_initialize_subsystem(void);
 
Index: linux-acpi-2.6/drivers/acpi/tables/tbutils.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/tables/tbutils.c
+++ linux-acpi-2.6/drivers/acpi/tables/tbutils.c
@@ -47,10 +47,6 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbutils")
 
-/* Local prototypes */
-static acpi_physical_address
-acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_check_xsdt
@@ -335,7 +331,7 @@ acpi_tb_install_table(acpi_physical_addr
  *
  ******************************************************************************/
 
-static acpi_physical_address
+acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 {
 	u64 address64;
@@ -399,7 +395,7 @@ acpi_tb_parse_root_table(acpi_physical_a
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
-	acpi_physical_address uninitialized_var(rsdt_address);
+	acpi_physical_address rsdt_address, xsdt_address = 0;
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
@@ -426,14 +422,15 @@ acpi_tb_parse_root_table(acpi_physical_a
 		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
 		 * the ACPI specification.
 		 */
-		address = (acpi_physical_address) rsdp->xsdt_physical_address;
+		xsdt_address = (acpi_physical_address) rsdp->xsdt_physical_address;
+		address = xsdt_address;
 		table_entry_size = sizeof(u64);
-		rsdt_address = (acpi_physical_address)
-					rsdp->rsdt_physical_address;
+		rsdt_address = (acpi_physical_address) rsdp->rsdt_physical_address;
 	} else {
 		/* Root table is an RSDT (32-bit physical addresses) */
 
-		address = (acpi_physical_address) rsdp->rsdt_physical_address;
+		rsdt_address = (acpi_physical_address) rsdp->rsdt_physical_address;
+		address = rsdt_address;
 		table_entry_size = sizeof(u32);
 	}
 
@@ -452,6 +449,11 @@ acpi_tb_parse_root_table(acpi_physical_a
 					"using RSDT"));
 		}
 	}
+	acpi_inactive_tables_root_pointer =
+		(address == rsdt_address ? xsdt_address : rsdt_address);
+	acpi_inactive_tables_entry_size =
+		(table_entry_size == sizeof(u32) ? sizeof(u64) : sizeof(u32));
+
 	/* Map the RSDT/XSDT table header to get the full table length */
 
 	table = acpi_os_map_memory(address, sizeof(struct acpi_table_header));
Index: linux-acpi-2.6/include/acpi/actables.h
===================================================================
--- linux-acpi-2.6.orig/include/acpi/actables.h
+++ linux-acpi-2.6/include/acpi/actables.h
@@ -105,6 +105,9 @@ u8 acpi_tb_checksum(u8 *buffer, u32 leng
 acpi_status
 acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
+acpi_physical_address
+acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
+
 void
 acpi_tb_install_table(acpi_physical_address address,
 		      u8 flags, char *signature, u32 table_index);
Index: linux-acpi-2.6/drivers/acpi/tables/tbxface.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/tables/tbxface.c
+++ linux-acpi-2.6/drivers/acpi/tables/tbxface.c
@@ -156,6 +156,137 @@ acpi_initialize_tables(struct acpi_table
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_initialize_inactive_tables
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Initialize the inactive table manager.
+ * 		Get the unused root table pointer, parse all the inactive tables
+ * 		and install them to the global inactive table list.
+ *
+ ******************************************************************************/
+acpi_status __init
+acpi_initialize_inactive_tables(void)
+{
+	acpi_status status;
+	u32 length;
+	u32 table_count;
+	u8 *table_entry;
+	u32 i;
+	struct acpi_table_header *table;
+	struct acpi_table_fadt *fadt;
+
+	if (!acpi_inactive_tables_root_pointer)
+		return AE_NOT_EXIST;
+	/* Map the RSDT/XSDT table header to get the full table length */
+	table = acpi_os_map_memory(acpi_inactive_tables_root_pointer,
+				   sizeof(struct acpi_table_header));
+	if (!table)
+		return_ACPI_STATUS(AE_NO_MEMORY);
+
+	length = table->length;
+	acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+
+	if (length < sizeof(struct acpi_table_header))
+		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
+
+	table = acpi_os_map_memory(acpi_inactive_tables_root_pointer, length);
+	if (!table)
+		return_ACPI_STATUS(AE_NO_MEMORY);
+
+	status = acpi_tb_verify_checksum(table, length);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_unmap_memory(table, length);
+		return_ACPI_STATUS(status);
+	}
+
+	table_count = (u32) ((table->length - sizeof(struct acpi_table_header))
+				/ acpi_inactive_tables_entry_size);
+
+	/* talbe_count tables + XSDT/RSDT + FACP + DSDT */
+	acpi_gbl_inactive_root_table_list.size = table_count + 3;
+	acpi_gbl_inactive_root_table_list.tables = ACPI_ALLOCATE_ZEROED(
+					sizeof(struct acpi_table_desc) *
+					acpi_gbl_inactive_root_table_list.size);
+	if (!acpi_gbl_inactive_root_table_list.tables)
+		return_ACPI_STATUS(AE_NO_MEMORY);
+
+	acpi_gbl_inactive_root_table_list.tables[0].address =
+				acpi_inactive_tables_root_pointer;
+	acpi_gbl_inactive_root_table_list.count++;
+
+	table_entry =
+		ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
+
+	for (i = 0; i < table_count; i++) {
+		acpi_gbl_inactive_root_table_list.tables
+			[acpi_gbl_inactive_root_table_list.count].address =
+			acpi_tb_get_root_table_entry(table_entry,
+					acpi_inactive_tables_entry_size);
+
+		table_entry += acpi_inactive_tables_entry_size;
+		acpi_gbl_inactive_root_table_list.count++;
+	}
+	acpi_os_unmap_memory(table, length);
+
+	for (i = 0; i < acpi_gbl_inactive_root_table_list.count; i++) {
+		if (!acpi_gbl_inactive_root_table_list.tables[i].address) {
+			ACPI_WARNING((AE_INFO,
+					"Null table entry"));
+			continue;
+		}
+		/* install inactive ACPI tables */
+		table = acpi_os_map_memory(
+			acpi_gbl_inactive_root_table_list.tables[i].address,
+			sizeof(struct acpi_table_header));
+		if (!table)
+			return_ACPI_STATUS(AE_NO_MEMORY);
+
+		acpi_gbl_inactive_root_table_list.tables[i].length =
+								table->length;
+		acpi_gbl_inactive_root_table_list.tables[i].flags =
+							ACPI_TABLE_ORIGIN_MAPPED;
+		ACPI_MOVE_32_TO_32(&
+			(acpi_gbl_inactive_root_table_list.tables[i].
+			signature), table->signature);
+		acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+
+		/* Special case for FADT - get the DSDT and FACS */
+		if (!ACPI_COMPARE_NAME
+			(&acpi_gbl_inactive_root_table_list.tables[i].signature,
+			ACPI_SIG_FADT))
+			continue;
+
+		fadt = acpi_os_map_memory(
+			acpi_gbl_inactive_root_table_list.tables[i].address,
+			acpi_gbl_inactive_root_table_list.tables[i].length);
+		if (!fadt)
+			return_ACPI_STATUS(AE_NOT_FOUND);
+
+		acpi_gbl_inactive_root_table_list.tables
+			[acpi_gbl_inactive_root_table_list.count].address =
+				(acpi_physical_address)
+				(((fadt->header.length ==
+				sizeof(struct acpi_table_fadt)) &&
+				fadt->Xdsdt) ? fadt->Xdsdt : fadt->dsdt);
+		acpi_gbl_inactive_root_table_list.count++;
+
+		acpi_gbl_inactive_root_table_list.tables
+			[acpi_gbl_inactive_root_table_list.count].address =
+				(acpi_physical_address)
+				(((fadt->header.length ==
+				sizeof(struct acpi_table_fadt)) &&
+				fadt->Xfacs) ? fadt->Xfacs : fadt->facs);
+		acpi_gbl_inactive_root_table_list.count++;
+
+		acpi_os_unmap_memory(fadt,
+			acpi_gbl_inactive_root_table_list.tables[i].length);
+	}
+
+	return_ACPI_STATUS(status);
+}
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_reallocate_root_table
  *
  * PARAMETERS:  None


