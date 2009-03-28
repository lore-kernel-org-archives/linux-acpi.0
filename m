From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/98] ACPICA: Formatting update - no functional changes
Date: Sat, 28 Mar 2009 00:31:08 -0400
Message-ID: <ec41f193eadb6301f3c052b5e0dbc0b5636982e8.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbZC1Ecx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700MVD8MGTPCX@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:41 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Split some long lines.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c   |   33 ++++++++++++++++++++-------------
 drivers/acpi/acpica/tbinstal.c |    9 +++++----
 drivers/acpi/acpica/tbutils.c  |   17 +++++++++--------
 drivers/acpi/acpica/tbxface.c  |   37 ++++++++++++++++---------------------
 drivers/acpi/acpica/tbxfroot.c |    4 ++--
 drivers/acpi/acpica/utcopy.c   |    5 +++--
 drivers/acpi/acpica/uteval.c   |    5 ++---
 drivers/acpi/acpica/utglobal.c |    5 ++++-
 8 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 43fe886..af8fbe1 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -132,7 +132,8 @@ static struct acpi_fadt_info fadt_info_table[] = {
 	 ACPI_FADT_SEPARATE_LENGTH}
 };
 
-#define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
+#define ACPI_FADT_INFO_ENTRIES \
+			(sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
 
 /* Table used to split Event Blocks into separate status/enable registers */
 
@@ -161,7 +162,8 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
 	 1}
 };
 
-#define ACPI_FADT_PM_INFO_ENTRIES   (sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
+#define ACPI_FADT_PM_INFO_ENTRIES \
+			(sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
 
 /*******************************************************************************
  *
@@ -416,7 +418,7 @@ static void acpi_tb_convert_fadt(void)
 	}
 }
 
-/******************************************************************************
+/*******************************************************************************
  *
  * FUNCTION:    acpi_tb_validate_fadt
  *
@@ -503,7 +505,8 @@ static void acpi_tb_validate_fadt(void)
 			 */
 			if (!address64->address || !length) {
 				ACPI_ERROR((AE_INFO,
-					    "Required field %s has zero address and/or length: %8.8X%8.8X/%X",
+					    "Required field %s has zero address and/or length:"
+					    " %8.8X%8.8X/%X",
 					    name,
 					    ACPI_FORMAT_UINT64(address64->
 							       address),
@@ -512,12 +515,14 @@ static void acpi_tb_validate_fadt(void)
 		} else if (fadt_info_table[i].type & ACPI_FADT_SEPARATE_LENGTH) {
 			/*
 			 * Field is optional (PM2Control, GPE0, GPE1) AND has its own
-			 * length field. If present, both the address and length must be valid.
+			 * length field. If present, both the address and length must
+			 * be valid.
 			 */
-			if ((address64->address && !length)
-			    || (!address64->address && length)) {
+			if ((address64->address && !length) ||
+			    (!address64->address && length)) {
 				ACPI_WARNING((AE_INFO,
-					      "Optional field %s has zero address or length: %8.8X%8.8X/%X",
+					      "Optional field %s has zero address or length: "
+					      "%8.8X%8.8X/%X",
 					      name,
 					      ACPI_FORMAT_UINT64(address64->
 								 address),
@@ -525,8 +530,10 @@ static void acpi_tb_validate_fadt(void)
 			}
 		}
 
-		/* If both 32- and 64-bit addresses are valid (non-zero), they must match */
-
+		/*
+		 * If both 32- and 64-bit addresses are valid (non-zero),
+		 * they must match
+		 */
 		if (address64->address && *address32 &&
 		    (address64->address != (u64) * address32)) {
 			ACPI_ERROR((AE_INFO,
@@ -537,7 +544,7 @@ static void acpi_tb_validate_fadt(void)
 	}
 }
 
-/******************************************************************************
+/*******************************************************************************
  *
  * FUNCTION:    acpi_tb_setup_fadt_registers
  *
@@ -596,8 +603,8 @@ static void acpi_tb_setup_fadt_registers(void)
 	 * Each register is defined to be (event block length / 2). Extra divide
 	 * by 8 converts bits to bytes.
 	 */
-	pm1_register_byte_width =
-	    (u8)ACPI_DIV_16(acpi_gbl_FADT.xpm1a_event_block.bit_width);
+	pm1_register_byte_width = (u8)
+	    ACPI_DIV_16(acpi_gbl_FADT.xpm1a_event_block.bit_width);
 
 	/*
 	 * Calculate separate GAS structs for the PM1x (A/B) Status and Enable
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index ef269a2..c379930 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -273,8 +273,9 @@ acpi_status acpi_tb_resize_root_table_list(void)
 	/* Increase the Table Array size */
 
 	tables = ACPI_ALLOCATE_ZEROED(((acpi_size) acpi_gbl_root_table_list.
-				       size + ACPI_ROOT_TABLE_SIZE_INCREMENT)
-				      * sizeof(struct acpi_table_desc));
+				       size +
+				       ACPI_ROOT_TABLE_SIZE_INCREMENT) *
+				      sizeof(struct acpi_table_desc));
 	if (!tables) {
 		ACPI_ERROR((AE_INFO,
 			    "Could not allocate new root table array"));
@@ -561,8 +562,8 @@ u8 acpi_tb_is_table_loaded(u32 table_index)
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	if (table_index < acpi_gbl_root_table_list.count) {
 		is_loaded = (u8)
-		    (acpi_gbl_root_table_list.tables[table_index].
-		     flags & ACPI_TABLE_IS_LOADED);
+		    (acpi_gbl_root_table_list.tables[table_index].flags &
+		     ACPI_TABLE_IS_LOADED);
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index a0b4243..dc45b49 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -413,7 +413,8 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 	} else {
 		/*
 		 * 32-bit platform, XSDT: Truncate 64-bit to 32-bit and return
-		 * 64-bit platform, XSDT: Move (unaligned) 64-bit to local, return 64-bit
+		 * 64-bit platform, XSDT: Move (unaligned) 64-bit to local,
+		 *  return 64-bit
 		 */
 		ACPI_MOVE_64_TO_64(&address64, table_entry);
 
@@ -423,7 +424,8 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 			/* Will truncate 64-bit address to 32 bits, issue warning */
 
 			ACPI_WARNING((AE_INFO,
-				      "64-bit Physical Address in XSDT is too large (%8.8X%8.8X), truncating",
+				      "64-bit Physical Address in XSDT is too large (%8.8X%8.8X),"
+				      " truncating",
 				      ACPI_FORMAT_UINT64(address64)));
 		}
 #endif
@@ -546,13 +548,12 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 
 	/* Calculate the number of tables described in the root table */
 
-	table_count =
-	    (u32) ((table->length -
-		    sizeof(struct acpi_table_header)) / table_entry_size);
-
+	table_count = (u32)((table->length - sizeof(struct acpi_table_header)) /
+			    table_entry_size);
 	/*
-	 * First two entries in the table array are reserved for the DSDT and FACS,
-	 * which are not actually present in the RSDT/XSDT - they come from the FADT
+	 * First two entries in the table array are reserved for the DSDT
+	 * and FACS, which are not actually present in the RSDT/XSDT - they
+	 * come from the FADT
 	 */
 	table_entry =
 	    ACPI_CAST_PTR(u8, table) + sizeof(struct acpi_table_header);
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 416d01d..dbca226 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -246,7 +246,7 @@ acpi_status acpi_load_table(struct acpi_table_header *table_ptr)
 
 ACPI_EXPORT_SYMBOL(acpi_load_table)
 
-/******************************************************************************
+/*******************************************************************************
  *
  * FUNCTION:    acpi_get_table_header
  *
@@ -261,7 +261,7 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
  * NOTE:        Caller is responsible in unmapping the header with
  *              acpi_os_unmap_memory
  *
- *****************************************************************************/
+ ******************************************************************************/
 acpi_status
 acpi_get_table_header(char *signature,
 		      u32 instance, struct acpi_table_header *out_table_header)
@@ -276,9 +276,8 @@ acpi_get_table_header(char *signature,
 		return (AE_BAD_PARAMETER);
 	}
 
-	/*
-	 * Walk the root table list
-	 */
+	/* Walk the root table list */
+
 	for (i = 0, j = 0; i < acpi_gbl_root_table_list.count; i++) {
 		if (!ACPI_COMPARE_NAME
 		    (&(acpi_gbl_root_table_list.tables[i].signature),
@@ -291,8 +290,8 @@ acpi_get_table_header(char *signature,
 		}
 
 		if (!acpi_gbl_root_table_list.tables[i].pointer) {
-			if ((acpi_gbl_root_table_list.tables[i].
-			     flags & ACPI_TABLE_ORIGIN_MASK) ==
+			if ((acpi_gbl_root_table_list.tables[i].flags &
+			     ACPI_TABLE_ORIGIN_MASK) ==
 			    ACPI_TABLE_ORIGIN_MAPPED) {
 				header =
 				    acpi_os_map_memory(acpi_gbl_root_table_list.
@@ -323,7 +322,7 @@ acpi_get_table_header(char *signature,
 
 ACPI_EXPORT_SYMBOL(acpi_get_table_header)
 
-/******************************************************************************
+/*******************************************************************************
  *
  * FUNCTION:    acpi_unload_table_id
  *
@@ -374,7 +373,7 @@ ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
  *
  * DESCRIPTION: Finds and verifies an ACPI table.
  *
- *****************************************************************************/
+ ******************************************************************************/
 acpi_status
 acpi_get_table(char *signature,
 	       u32 instance, struct acpi_table_header **out_table)
@@ -389,9 +388,8 @@ acpi_get_table(char *signature,
 		return (AE_BAD_PARAMETER);
 	}
 
-	/*
-	 * Walk the root table list
-	 */
+	/* Walk the root table list */
+
 	for (i = 0, j = 0; i < acpi_gbl_root_table_list.count; i++) {
 		if (!ACPI_COMPARE_NAME
 		    (&(acpi_gbl_root_table_list.tables[i].signature),
@@ -526,17 +524,15 @@ static acpi_status acpi_tb_load_namespace(void)
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 
-	/*
-	 * Load and parse tables.
-	 */
+	/* Load and parse tables */
+
 	status = acpi_ns_load_table(ACPI_TABLE_INDEX_DSDT, acpi_gbl_root_node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
-	/*
-	 * Load any SSDT or PSDT tables. Note: Loop leaves tables locked
-	 */
+	/* Load any SSDT or PSDT tables. Note: Loop leaves tables locked */
+
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
 		if ((!ACPI_COMPARE_NAME
@@ -589,9 +585,8 @@ acpi_status acpi_load_tables(void)
 
 	ACPI_FUNCTION_TRACE(acpi_load_tables);
 
-	/*
-	 * Load the namespace from the tables
-	 */
+	/* Load the namespace from the tables */
+
 	status = acpi_tb_load_namespace();
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index b7fc8dd..85ea834 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -75,8 +75,8 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 	 * Note: Sometimes there exists more than one RSDP in memory; the valid
 	 * RSDP has a valid checksum, all others have an invalid checksum.
 	 */
-	if (ACPI_STRNCMP((char *)rsdp, ACPI_SIG_RSDP, sizeof(ACPI_SIG_RSDP) - 1)
-	    != 0) {
+	if (ACPI_STRNCMP((char *)rsdp, ACPI_SIG_RSDP,
+			 sizeof(ACPI_SIG_RSDP) - 1) != 0) {
 
 		/* Nope, BAD Signature */
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index cabe860..919624f 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -496,8 +496,9 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 	case ACPI_TYPE_STRING:
 
 		internal_object->string.pointer =
-		    ACPI_ALLOCATE_ZEROED((acpi_size) external_object->string.
-					 length + 1);
+		    ACPI_ALLOCATE_ZEROED((acpi_size)
+					 external_object->string.length + 1);
+
 		if (!internal_object->string.pointer) {
 			goto error_exit;
 		}
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 9c4ae6f..3b91525 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -124,9 +124,8 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	/* Compare input string to static table of supported interfaces */
 
 	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
-		if (!ACPI_STRCMP
-		    (string_desc->string.pointer,
-		     acpi_interfaces_supported[i])) {
+		if (!ACPI_STRCMP(string_desc->string.pointer,
+				 acpi_interfaces_supported[i])) {
 
 			/* The interface is supported */
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 7fc35d3..256ce77 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -746,7 +746,10 @@ acpi_status acpi_ut_init_globals(void)
 	for (i = 0; i < ACPI_NUM_OWNERID_MASKS; i++) {
 		acpi_gbl_owner_id_mask[i] = 0;
 	}
-	acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS - 1] = 0x80000000;	/* Last ID is never valid */
+
+	/* Last owner_iD is never valid */
+
+	acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS - 1] = 0x80000000;
 
 	/* GPE support */
 
-- 
1.6.0.6

