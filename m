From: Len Brown <len.brown@intel.com>
Subject: [PATCH 36/65] ACPICA: New common routine for creating and verifying a local FADT.
Date: Fri, 24 Nov 2006 02:18:46 -0500
Message-ID: <11643527982269-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10249 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934481AbWKXHQA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:00 -0500
In-Reply-To: <11643527973892-git-send-email-len.brown@intel.com>
Message-Id: <755518e665a471847860fece68e49ef7da20ed65.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |   71 ++++++++++++++++++++++++++++++------------
 include/acpi/actables.h      |    4 +--
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 8816bab..31a4a00 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -52,6 +52,10 @@ static void inline
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 bit_width, u64 address);
 
+static void acpi_tb_convert_fadt(void);
+
+static void acpi_tb_validate_fadt(void);
+
 /* Table for conversion of FADT to common internal format and FADT validation */
 
 typedef struct acpi_fadt_info {
@@ -178,13 +182,47 @@ void acpi_tb_parse_fadt(acpi_native_uint
 	 */
 	(void)acpi_tb_verify_checksum(table, length);
 
+	/* Obtain a local copy of the FADT in common ACPI 2.0+ format */
+
+	acpi_tb_create_local_fadt(table, length);
+
+	/* All done with the real FADT, unmap it */
+
+	acpi_os_unmap_memory(table, length);
+
+	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
+
+	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
+			      flags, ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
+
+	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
+			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_create_local_fadt
+ *
+ * PARAMETERS:  Table               - Pointer to BIOS FADT
+ *              Length              - Length of the table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Get a local copy of the FADT and convert it to a common format.
+ *              Performs validation on some important FADT fields.
+ *
+ ******************************************************************************/
+
+void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
+{
+
 	/*
-	 * If the FADT is larger than what we know about, we have a problem.
+	 * Check if the FADT is larger than what we know about (ACPI 2.0 version).
 	 * Truncate the table, but make some noise.
 	 */
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
-			      "FADT (revision %u) is too large, truncating length 0x%X to 0x%X",
+			      "FADT (revision %u) is longer than ACPI 2.0 version, truncating length 0x%X to 0x%X",
 			      table->revision, length,
 			      sizeof(struct acpi_table_fadt)));
 	}
@@ -192,27 +230,16 @@ void acpi_tb_parse_fadt(acpi_native_uint
 	/* Copy the entire FADT locally. Zero first for tb_convert_fadt */
 
 	ACPI_MEMSET(&acpi_gbl_FADT, 0, sizeof(struct acpi_table_fadt));
+
 	ACPI_MEMCPY(&acpi_gbl_FADT, table,
 		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
 
-	/* All done with the real FADT, unmap it */
-
-	acpi_os_unmap_memory(table, length);
-
 	/*
 	 * 1) Convert the local copy of the FADT to the common internal format
 	 * 2) Validate some of the important values within the FADT
 	 */
 	acpi_tb_convert_fadt();
-	acpi_tb_validate_fadt(&acpi_gbl_FADT);
-
-	/* Obtain the DSDT and FACS tables via their addresses within the FADT */
-
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
-			      flags, ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
-
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
-			      flags, ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
+	acpi_tb_validate_fadt();
 }
 
 /*******************************************************************************
@@ -244,7 +271,7 @@ void acpi_tb_parse_fadt(acpi_native_uint
  *
  ******************************************************************************/
 
-void acpi_tb_convert_fadt(void)
+static void acpi_tb_convert_fadt(void)
 {
 	u8 pm1_register_length;
 	struct acpi_generic_address *target;
@@ -337,7 +364,7 @@ void acpi_tb_convert_fadt(void)
  *
  ******************************************************************************/
 
-void acpi_tb_validate_fadt(struct acpi_table_fadt *table)
+static void acpi_tb_validate_fadt(void)
 {
 	u32 *address32;
 	struct acpi_generic_address *address64;
@@ -351,10 +378,14 @@ void acpi_tb_validate_fadt(struct acpi_t
 		/* Generate pointers to the 32-bit and 64-bit addresses and get the length */
 
 		address64 =
-		    ACPI_ADD_PTR(struct acpi_generic_address, table,
+		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
 				 fadt_info_table[i].target);
-		address32 = ACPI_ADD_PTR(u32, table, fadt_info_table[i].source);
-		length = *ACPI_ADD_PTR(u8, table, fadt_info_table[i].length);
+		address32 =
+		    ACPI_ADD_PTR(u32, &acpi_gbl_FADT,
+				 fadt_info_table[i].source);
+		length =
+		    *ACPI_ADD_PTR(u8, &acpi_gbl_FADT,
+				  fadt_info_table[i].length);
 
 		if (fadt_info_table[i].type & ACPI_FADT_REQUIRED) {
 			/*
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 65a69ca..4079f8a 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -51,9 +51,7 @@ acpi_status acpi_allocate_root_table(u32
  */
 void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
 
-void acpi_tb_convert_fadt(void);
-
-void acpi_tb_validate_fadt(struct acpi_table_fadt *table);
+void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
 
 /*
  * tbfind - find ACPI table
-- 
1.4.4.1
