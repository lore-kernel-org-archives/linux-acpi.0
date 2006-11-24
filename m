From: Len Brown <len.brown@intel.com>
Subject: [PATCH 59/65] ACPICA: Miscellaneous table manager updates and optimizations
Date: Fri, 24 Nov 2006 02:19:09 -0500
Message-ID: <1164352819583-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com> <11643528141248-git-send-email-len.brown@intel.com> <11643528153363-git-send-email-len.brown@intel.com> <11643528161204-git-send-email-len.brown@intel.com> <11643528173586-git-send-email-len.brown@intel.com> <11643528181135-git-send-email-len.brown@intel.com> <11643528181927-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58137 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934507AbWKXHQV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:21 -0500
In-Reply-To: <11643528181927-git-send-email-len.brown@intel.com>
Message-Id: <e446515cc751f48675116855f4bec723896da94d.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Robert Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c       |   12 +++---
 drivers/acpi/tables/tbinstal.c |   91 +++++++++++++++++++++++----------------
 drivers/acpi/tables/tbutils.c  |   46 --------------------
 drivers/acpi/tables/tbxface.c  |   39 ++++++++++++-----
 include/acpi/acpixf.h          |    2 +-
 include/acpi/actables.h        |    8 +---
 6 files changed, 90 insertions(+), 108 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index c8f4cac..f289fd4 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -103,7 +103,7 @@ int __init acpi_blacklisted(void)
 {
 	int i = 0;
 	int blacklisted = 0;
-	struct acpi_table_header *table_header;
+	struct acpi_table_header table_header;
 
 	while (acpi_blacklist[i].oem_id[0] != '\0') {
 		if (acpi_get_table_header(acpi_blacklist[i].table, 0, &table_header)) {
@@ -111,13 +111,13 @@ int __init acpi_blacklisted(void)
 			continue;
 		}
 
-		if (strncmp(acpi_blacklist[i].oem_id, table_header->oem_id, 6)) {
+		if (strncmp(acpi_blacklist[i].oem_id, table_header.oem_id, 6)) {
 			i++;
 			continue;
 		}
 
 		if (strncmp
-		    (acpi_blacklist[i].oem_table_id, table_header->oem_table_id,
+		    (acpi_blacklist[i].oem_table_id, table_header.oem_table_id,
 		     8)) {
 			i++;
 			continue;
@@ -126,14 +126,14 @@ int __init acpi_blacklisted(void)
 		if ((acpi_blacklist[i].oem_revision_predicate == all_versions)
 		    || (acpi_blacklist[i].oem_revision_predicate ==
 			less_than_or_equal
-			&& table_header->oem_revision <=
+			&& table_header.oem_revision <=
 			acpi_blacklist[i].oem_revision)
 		    || (acpi_blacklist[i].oem_revision_predicate ==
 			greater_than_or_equal
-			&& table_header->oem_revision >=
+			&& table_header.oem_revision >=
 			acpi_blacklist[i].oem_revision)
 		    || (acpi_blacklist[i].oem_revision_predicate == equal
-			&& table_header->oem_revision ==
+			&& table_header.oem_revision ==
 			acpi_blacklist[i].oem_revision)) {
 
 			printk(KERN_ERR PREFIX
diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/tables/tbinstal.c
index 9e0b3ce..b07d9c8 100644
--- a/drivers/acpi/tables/tbinstal.c
+++ b/drivers/acpi/tables/tbinstal.c
@@ -61,16 +61,19 @@ ACPI_MODULE_NAME("tbinstal")
  *****************************************************************************/
 acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE(tb_verify_table);
 
 	/* Map the table if necessary */
 
 	if (!table_desc->pointer) {
-		table_desc->pointer =
-		    acpi_tb_map(table_desc->address, table_desc->length,
-				table_desc->flags & ACPI_TABLE_ORIGIN_MASK);
+		if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
+		    ACPI_TABLE_ORIGIN_MAPPED) {
+			table_desc->pointer =
+			    acpi_os_map_memory(table_desc->address,
+					       table_desc->length);
+		}
 		if (!table_desc->pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
@@ -78,14 +81,15 @@ acpi_status acpi_tb_verify_table(struct
 
 	/* FACS is the odd table, has no standard ACPI header and no checksum */
 
-	if (ACPI_COMPARE_NAME(&(table_desc->signature), ACPI_SIG_FACS)) {
-		return_ACPI_STATUS(AE_OK);
-	}
+	if (!ACPI_COMPARE_NAME(&table_desc->signature, ACPI_SIG_FACS)) {
 
-	/* Always calculate checksum, ignore bad checksum if requested */
+		/* Always calculate checksum, ignore bad checksum if requested */
+
+		status =
+		    acpi_tb_verify_checksum(table_desc->pointer,
+					    table_desc->length);
+	}
 
-	status =
-	    acpi_tb_verify_checksum(table_desc->pointer, table_desc->length);
 	return_ACPI_STATUS(status);
 }
 
@@ -93,7 +97,7 @@ acpi_status acpi_tb_verify_table(struct
  *
  * FUNCTION:    acpi_tb_add_table
  *
- * PARAMETERS:  Table               - Pointer to the table header
+ * PARAMETERS:  table_desc          - Table descriptor
  *              table_index         - Where the table index is returned
  *
  * RETURN:      Status
@@ -103,7 +107,7 @@ acpi_status acpi_tb_verify_table(struct
  ******************************************************************************/
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_header *table,
+acpi_tb_add_table(struct acpi_table_desc *table_desc,
 		  acpi_native_uint * table_index)
 {
 	acpi_native_uint i;
@@ -112,6 +116,25 @@ acpi_tb_add_table(struct acpi_table_head
 
 	ACPI_FUNCTION_TRACE(tb_add_table);
 
+	if (!table_desc->pointer) {
+		status = acpi_tb_verify_table(table_desc);
+		if (ACPI_FAILURE(status) || !table_desc->pointer) {
+			return_ACPI_STATUS(status);
+		}
+	}
+
+	/* The table must be either an SSDT or a PSDT */
+
+	if ((!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_PSDT))
+	    &&
+	    (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT)))
+	{
+		ACPI_ERROR((AE_INFO,
+			    "Table has invalid signature [%4.4s], must be SSDT or PSDT",
+			    table_desc->pointer->signature));
+		return_ACPI_STATUS(AE_BAD_SIGNATURE);
+	}
+
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 	/* Check if table is already registered */
@@ -127,18 +150,17 @@ acpi_tb_add_table(struct acpi_table_head
 			}
 		}
 
-		length = ACPI_MIN(table->length,
-				  acpi_gbl_root_table_list.tables[i].pointer->
-				  length);
-		if (ACPI_MEMCMP
-		    (table, acpi_gbl_root_table_list.tables[i].pointer,
-		     length)) {
+		length = ACPI_MIN(table_desc->length,
+				  acpi_gbl_root_table_list.tables[i].length);
+		if (ACPI_MEMCMP(table_desc->pointer,
+				acpi_gbl_root_table_list.tables[i].pointer,
+				length)) {
 			continue;
 		}
 
 		/* Table is already registered */
 
-		ACPI_FREE(table);
+		acpi_tb_delete_table(table_desc);
 		*table_index = i;
 		goto release;
 	}
@@ -146,14 +168,14 @@ acpi_tb_add_table(struct acpi_table_head
 	/*
 	 * Add the table to the global table list
 	 */
-	status = acpi_tb_store_table(ACPI_TO_INTEGER(table),
-				     table, table->length,
-				     ACPI_TABLE_ORIGIN_ALLOCATED, table_index);
+	status = acpi_tb_store_table(table_desc->address, table_desc->pointer,
+				     table_desc->length, table_desc->flags,
+				     table_index);
 	if (ACPI_FAILURE(status)) {
 		goto release;
 	}
 
-	acpi_tb_print_table_header(0, table);
+	acpi_tb_print_table_header(table_desc->address, table_desc->pointer);
 
       release:
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
@@ -282,25 +304,20 @@ acpi_tb_store_table(acpi_physical_addres
  *
  ******************************************************************************/
 
-void acpi_tb_delete_table(acpi_native_uint table_index)
+void acpi_tb_delete_table(struct acpi_table_desc *table_desc)
 {
-	struct acpi_table_desc *table_desc;
-
-	/* table_index assumed valid */
-
-	table_desc = &acpi_gbl_root_table_list.tables[table_index];
-
 	/* Table must be mapped or allocated */
-
 	if (!table_desc->pointer) {
 		return;
 	}
-
-	if (table_desc->flags & ACPI_TABLE_ORIGIN_MAPPED) {
-		acpi_tb_unmap(table_desc->pointer, table_desc->length,
-			      table_desc->flags & ACPI_TABLE_ORIGIN_MASK);
-	} else if (table_desc->flags & ACPI_TABLE_ORIGIN_ALLOCATED) {
+	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
+	case ACPI_TABLE_ORIGIN_MAPPED:
+		acpi_os_unmap_memory(table_desc->pointer, table_desc->length);
+		break;
+	case ACPI_TABLE_ORIGIN_ALLOCATED:
 		ACPI_FREE(table_desc->pointer);
+		break;
+	default:;
 	}
 
 	table_desc->pointer = NULL;
@@ -329,7 +346,7 @@ void acpi_tb_terminate(void)
 	/* Delete the individual tables */
 
 	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
-		acpi_tb_delete_table(i);
+		acpi_tb_delete_table(&acpi_gbl_root_table_list.tables[i]);
 	}
 
 	/*
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index f97b70e..a456e6c 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -460,49 +460,3 @@ acpi_tb_parse_root_table(acpi_physical_a
 
 	return_ACPI_STATUS(AE_OK);
 }
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_tb_map
- *
- * PARAMETERS:  Address             - Address to be mapped
- *              Length              - Length to be mapped
- *              Flags               - Logical or physical addressing mode
- *
- * RETURN:      Pointer to mapped region
- *
- * DESCRIPTION: Maps memory according to flag
- *
- *****************************************************************************/
-
-void *acpi_tb_map(acpi_physical_address address, u32 length, u32 flags)
-{
-
-	if (flags == ACPI_TABLE_ORIGIN_MAPPED) {
-		return (acpi_os_map_memory(address, length));
-	} else {
-		return (ACPI_CAST_PTR(void, address));
-	}
-}
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_tb_unmap
- *
- * PARAMETERS:  Pointer             - To mapped region
- *              Length              - Length to be unmapped
- *              Flags               - Logical or physical addressing mode
- *
- * RETURN:      None
- *
- * DESCRIPTION: Unmaps memory according to flag
- *
- *****************************************************************************/
-
-void acpi_tb_unmap(void *pointer, u32 length, u32 flags)
-{
-
-	if (flags == ACPI_TABLE_ORIGIN_MAPPED) {
-		acpi_os_unmap_memory(pointer, length);
-	}
-}
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index c5009f5..5b63c12 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -212,8 +212,7 @@ ACPI_EXPORT_SYMBOL(acpi_reallocate_root_
  *
  * PARAMETERS:  Signature           - ACPI signature of needed table
  *              Instance            - Which instance (for SSDTs)
- *              out_table_header    - Where the pointer to the table header
- *                                    is returned
+ *              out_table_header    - The pointer to the table header to fill
  *
  * RETURN:      Status and pointer to mapped table header
  *
@@ -226,10 +225,11 @@ ACPI_EXPORT_SYMBOL(acpi_reallocate_root_
 acpi_status
 acpi_get_table_header(char *signature,
 		      acpi_native_uint instance,
-		      struct acpi_table_header **out_table_header)
+		      struct acpi_table_header *out_table_header)
 {
 	acpi_native_uint i;
 	acpi_native_uint j;
+	struct acpi_table_header *header;
 
 	/* Parameter validation */
 
@@ -251,16 +251,31 @@ acpi_get_table_header(char *signature,
 			continue;
 		}
 
-		*out_table_header =
-		    acpi_tb_map(acpi_gbl_root_table_list.tables[i].address,
-				(u32) sizeof(struct acpi_table_header),
-				acpi_gbl_root_table_list.tables[i].
-				flags & ACPI_TABLE_ORIGIN_MASK);
-
-		if (!(*out_table_header)) {
-			return (AE_NO_MEMORY);
+		if (!acpi_gbl_root_table_list.tables[i].pointer) {
+			if ((acpi_gbl_root_table_list.tables[i].
+			     flags & ACPI_TABLE_ORIGIN_MASK) ==
+			    ACPI_TABLE_ORIGIN_MAPPED) {
+				header =
+				    acpi_os_map_memory(acpi_gbl_root_table_list.
+						       tables[i].address,
+						       sizeof(struct
+							      acpi_table_header));
+				if (!header) {
+					return AE_NO_MEMORY;
+				}
+				ACPI_MEMCPY(out_table_header, header,
+					    sizeof(struct acpi_table_header));
+				acpi_os_unmap_memory(header,
+						     sizeof(struct
+							    acpi_table_header));
+			} else {
+				return AE_NOT_FOUND;
+			}
+		} else {
+			ACPI_MEMCPY(out_table_header,
+				    acpi_gbl_root_table_list.tables[i].pointer,
+				    sizeof(struct acpi_table_header));
 		}
-
 		return (AE_OK);
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 035a5a8..b4190c7 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -105,7 +105,7 @@ acpi_status acpi_load_tables(void);
 acpi_status
 acpi_get_table_header(acpi_string signature,
 		      acpi_native_uint instance,
-		      struct acpi_table_header **out_table_header);
+		      struct acpi_table_header *out_table_header);
 
 acpi_status
 acpi_get_table(acpi_string signature,
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 4079f8a..5ef1b69 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -69,7 +69,7 @@ acpi_status acpi_tb_resize_root_table_li
 acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc);
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_header *table,
+acpi_tb_add_table(struct acpi_table_desc *table_desc,
 		  acpi_native_uint * table_index);
 
 acpi_status
@@ -77,7 +77,7 @@ acpi_tb_store_table(acpi_physical_addres
 		    struct acpi_table_header *table,
 		    u32 length, u8 flags, acpi_native_uint * table_index);
 
-void acpi_tb_delete_table(acpi_native_uint table_index);
+void acpi_tb_delete_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_terminate(void);
 
@@ -113,8 +113,4 @@ acpi_tb_install_table(acpi_physical_addr
 acpi_status
 acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags);
 
-void *acpi_tb_map(acpi_physical_address address, u32 length, u32 flags);
-
-void acpi_tb_unmap(void *pointer, u32 length, u32 flags);
-
 #endif				/* __ACTABLES_H__ */
-- 
1.4.4.1
