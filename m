From: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/65] ACPICA: Lint changes
Date: Fri, 24 Nov 2006 02:18:25 -0500
Message-ID: <11643527752251-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14089 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934465AbWKXHPh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:37 -0500
In-Reply-To: <11643527743390-git-send-email-len.brown@intel.com>
Message-Id: <ec604624c47740c2516cf8a4f2fa33a04956b810.1164352291.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Lint changes
Move RSDT/XSDT pointer extraction to separate function
Warning on 32-bit platforms if XSDT pointers use more than 32 bits.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbutils.c |  121 ++++++++++++++++++++++++++++-------------
 drivers/acpi/tables/tbxface.c |    4 +-
 2 files changed, 84 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 77c7e87..8e44f83 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -60,6 +60,10 @@ static void inline
 acpi_tb_init_generic_address(struct acpi_generic_address *new_gas_struct,
 			     u8 bit_width, u64 address);
 
+static acpi_physical_address
+acpi_tb_get_root_table_entry(u8 * table_entry,
+			     acpi_native_uint table_entry_size);
+
 /* Table used for conversion of FADT to common format */
 
 typedef struct acpi_fadt_conversion {
@@ -126,10 +130,14 @@ acpi_tb_print_table_header(acpi_physical
 
 		ACPI_INFO((AE_INFO, "RSDP @ 0x%p/0x%04X (v%3.3d %6.6s)",
 			   ACPI_CAST_PTR(void, address),
-			   (((struct acpi_table_rsdp *)header)->revision > 0) ?
-			   ((struct acpi_table_rsdp *)header)->length : 20,
-			   ((struct acpi_table_rsdp *)header)->revision,
-			   ((struct acpi_table_rsdp *)header)->oem_id));
+			   (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
+			    revision >
+			    0) ? ACPI_CAST_PTR(struct acpi_table_rsdp,
+					       header)->length : 20,
+			   ACPI_CAST_PTR(struct acpi_table_rsdp,
+					 header)->revision,
+			   ACPI_CAST_PTR(struct acpi_table_rsdp,
+					 header)->oem_id));
 	} else {
 		/* Standard ACPI table with full common header */
 
@@ -278,8 +286,8 @@ static void acpi_tb_convert_fadt(void)
 	}
 
 	/*
-	 * Expand the V1.0 addresses to the "X" generic address structs,
-	 * as necessary.
+	 * Expand the 32-bit V1.0 addresses to the 64-bit "X" generic address
+	 * structures as necessary.
 	 */
 	for (i = 0; i < ACPI_FADT_CONVERSION_ENTRIES; i++) {
 		target =
@@ -294,10 +302,11 @@ static void acpi_tb_convert_fadt(void)
 								   &acpi_gbl_FADT,
 								   fadt_conversion_table
 								   [i].length),
-						     *ACPI_ADD_PTR(u32,
-								   &acpi_gbl_FADT,
-								   fadt_conversion_table
-								   [i].source));
+						     (u64) * ACPI_ADD_PTR(u32,
+									  &acpi_gbl_FADT,
+									  fadt_conversion_table
+									  [i].
+									  source));
 		}
 	}
 
@@ -444,7 +453,7 @@ static void acpi_tb_parse_fadt(acpi_nati
 
 	/* Copy the entire FADT locally */
 
-	ACPI_MEMSET(&acpi_gbl_FADT, sizeof(struct acpi_table_fadt), 0);
+	ACPI_MEMSET(&acpi_gbl_FADT, 0, sizeof(struct acpi_table_fadt));
 
 	ACPI_MEMCPY(&acpi_gbl_FADT, table,
 		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
@@ -465,6 +474,61 @@ static void acpi_tb_parse_fadt(acpi_nati
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_get_root_table_entry
+ *
+ * PARAMETERS:  table_entry         - Pointer to the RSDT/XSDT table entry
+ *              table_entry_size    - sizeof 32 or 64 (RSDT or XSDT)
+ *
+ * RETURN:      Physical address extracted from the root table
+ *
+ * DESCRIPTION: Get one root table entry. Handles 32-bit and 64-bit cases on
+ *              both 32-bit and 64-bit platforms
+ *
+ * NOTE:        acpi_physical_address is 32-bit on 32-bit platforms, 64-bit on
+ *              64-bit platforms.
+ *
+ ******************************************************************************/
+
+static acpi_physical_address
+acpi_tb_get_root_table_entry(u8 * table_entry,
+			     acpi_native_uint table_entry_size)
+{
+	u64 address64;
+
+	/*
+	 * Get the table physical address (32-bit for RSDT, 64-bit for XSDT):
+	 * Note: Addresses are 32-bit aligned (not 64) in both RSDT and XSDT
+	 */
+	if (table_entry_size == sizeof(u32)) {
+		/*
+		 * 32-bit platform, RSDT: Return 32-bit table entry
+		 * 64-bit platform, RSDT: Expand 32-bit to 64-bit and return
+		 */
+		return ((acpi_physical_address)
+			(*ACPI_CAST_PTR(u32, table_entry)));
+	} else {
+		/*
+		 * 32-bit platform, XSDT: Truncate 64-bit to 32-bit and return
+		 * 64-bit platform, XSDT: Move (unaligned) 64-bit to local, return 64-bit
+		 */
+		ACPI_MOVE_64_TO_64(&address64, table_entry);
+
+#if ACPI_MACHINE_WIDTH == 32
+		if (address64 > ACPI_UINT32_MAX) {
+
+			/* Will truncate 64-bit address to 32 bits */
+
+			ACPI_WARNING((AE_INFO,
+				      "64-bit Physical Address in XSDT is too large (%8.8X%8.8X), truncating",
+				      ACPI_FORMAT_UINT64(address64)));
+		}
+#endif
+		return ((acpi_physical_address) (address64));
+	}
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_parse_root_table
  *
  * PARAMETERS:  Rsdp                    - Pointer to the RSDP
@@ -567,8 +631,8 @@ acpi_tb_parse_root_table(acpi_physical_a
 	/* Calculate the number of tables described in the root table */
 
 	table_count =
-	    (table->length -
-	     sizeof(struct acpi_table_header)) / table_entry_size;
+	    (u32) ((table->length -
+		    sizeof(struct acpi_table_header)) / table_entry_size);
 
 	/*
 	 * First two entries in the table array are reserved for the DSDT and FACS,
@@ -599,32 +663,11 @@ acpi_tb_parse_root_table(acpi_physical_a
 			}
 		}
 
-		/*
-		 * Get the table physical address (32-bit for RSDT, 64-bit for XSDT)
-		 */
-		if ((table_entry_size == sizeof(u32)) ||
-		    (sizeof(acpi_physical_address) == sizeof(u32))) {
-			/*
-			 * 32-bit platform, RSDT: Move 32-bit to 32-bit
-			 * 32-bit platform, XSDT: Truncate 64-bit to 32-bit
-			 * 64-bit platform, RSDT: Expand 32-bit to 64-bit
-			 *
-			 * Note: Addresses are 32-bit aligned in both RSDT and XSDT
-			 */
-			acpi_gbl_root_table_list.
-			    tables[acpi_gbl_root_table_list.count].address =
-			    (acpi_physical_address) (*ACPI_CAST_PTR
-						     (u32, table_entry));
-		} else {
-			/*
-			 * 64-bit platform, XSDT: Move 64-bit to 64-bit
-			 *
-			 * Note: 64-bit addresses are only 32-bit aligned in the XSDT
-			 */
-			ACPI_MOVE_64_TO_64(&acpi_gbl_root_table_list.
-					   tables[acpi_gbl_root_table_list.
-						  count].address, table_entry);
-		}
+		/* Get the table physical address (32-bit for RSDT, 64-bit for XSDT) */
+
+		acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
+		    address =
+		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
 
 		table_entry += table_entry_size;
 		acpi_gbl_root_table_list.count++;
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index c697d6d..6a401c2 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -102,9 +102,9 @@ acpi_initialize_tables(struct acpi_table
 	} else {
 		/* Root Table Array has been statically allocated by the host */
 
-		ACPI_MEMSET(initial_table_array,
+		ACPI_MEMSET(initial_table_array, 0,
 			    initial_table_count *
-			    sizeof(struct acpi_table_desc), 0);
+			    sizeof(struct acpi_table_desc));
 
 		acpi_gbl_root_table_list.tables = initial_table_array;
 		acpi_gbl_root_table_list.size = initial_table_count;
-- 
1.4.4.1
