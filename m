From: Len Brown <lenb@kernel.org>
Subject: [PATCH 77/140] ACPICA: New common routine for creating and verifying a local FADT.
Date: Wed,  7 Feb 2007 13:51:31 -0500
Message-ID: <11708744911989-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:26503 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422812AbXBGSyw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:52 -0500
In-Reply-To: <11708744903381-git-send-email-lenb@kernel.org>
Message-Id: <7139284460fba90c4dfcfae76680ad36b45f5982.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
@@ -178,13 +182,47 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
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
@@ -192,27 +230,16 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
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
@@ -244,7 +271,7 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
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
@@ -351,10 +378,14 @@ void acpi_tb_validate_fadt(struct acpi_table_fadt *table)
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
@@ -51,9 +51,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count);
  */
 void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
 
-void acpi_tb_convert_fadt(void);
-
-void acpi_tb_validate_fadt(struct acpi_table_fadt *table);
+void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
 
 /*
  * tbfind - find ACPI table
-- 
1.5.0.rc3.39.gec804
