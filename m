From: Len Brown <lenb@kernel.org>
Subject: [PATCH 105/140] ACPICA: Miscellaneous table manager updates and optimizations
Date: Wed,  7 Feb 2007 13:51:59 -0500
Message-ID: <11708745202061-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <428f211297bc95fd41f23830eab4180339020dd0.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422804AbXBGSz1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:27 -0500
In-Reply-To: <11708745193612-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c         |   12 +++---
 drivers/acpi/executer/exconfig.c |    8 +++-
 drivers/acpi/tables/tbinstal.c   |   91 ++++++++++++++++++++++---------------
 drivers/acpi/tables/tbutils.c    |   46 -------------------
 drivers/acpi/tables/tbxface.c    |   54 ++++++++++++++++------
 include/acpi/acpixf.h            |    2 +-
 include/acpi/actables.h          |    8 +---
 7 files changed, 108 insertions(+), 113 deletions(-)

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
diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 20a5ab8..7aa18f9 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -279,13 +279,14 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	acpi_native_uint table_index;
 	acpi_physical_address address;
 	struct acpi_table_header table_header;
+	struct acpi_table_desc table_desc;
 	acpi_integer temp;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(ex_load_op);
 
 	/* Object can be either an op_region or a Field */
-
+	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
 	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 	case ACPI_TYPE_REGION:
 
@@ -408,10 +409,13 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		goto cleanup;
 	}
 
+	table_desc.pointer = table_ptr;
+	table_desc.length = table_ptr->length;
+	table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 	/*
 	 * Install the new table into the local data structures
 	 */
-	status = acpi_tb_add_table(table_ptr, &table_index);
+	status = acpi_tb_add_table(&table_desc, &table_index);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
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
@@ -78,14 +81,15 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
 
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
 
@@ -93,7 +97,7 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
  *
  * FUNCTION:    acpi_tb_add_table
  *
- * PARAMETERS:  Table               - Pointer to the table header
+ * PARAMETERS:  table_desc          - Table descriptor
  *              table_index         - Where the table index is returned
  *
  * RETURN:      Status
@@ -103,7 +107,7 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
  ******************************************************************************/
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_header *table,
+acpi_tb_add_table(struct acpi_table_desc *table_desc,
 		  acpi_native_uint * table_index)
 {
 	acpi_native_uint i;
@@ -112,6 +116,25 @@ acpi_tb_add_table(struct acpi_table_header *table,
 
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
@@ -127,18 +150,17 @@ acpi_tb_add_table(struct acpi_table_header *table,
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
@@ -146,14 +168,14 @@ acpi_tb_add_table(struct acpi_table_header *table,
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
@@ -282,25 +304,20 @@ acpi_tb_store_table(acpi_physical_address address,
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
index 1033748..0cb7439 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -462,49 +462,3 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 
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
index 9d451e8..77224bd 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -220,16 +220,25 @@ acpi_status acpi_load_table(struct acpi_table_header *table_ptr)
 {
 	acpi_status status;
 	acpi_native_uint table_index;
+	struct acpi_table_desc table_desc;
+
+	if (!table_ptr)
+		return AE_BAD_PARAMETER;
+
+	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
+	table_desc.pointer = table_ptr;
+	table_desc.length = table_ptr->length;
+	table_desc.flags = ACPI_TABLE_ORIGIN_UNKNOWN;
 
 	/*
 	 * Install the new table into the local data structures
 	 */
-	status = acpi_tb_add_table(table_ptr, &table_index);
+	status = acpi_tb_add_table(&table_desc, &table_index);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		return status;
 	}
 	status = acpi_ns_load_table(table_index, acpi_gbl_root_node);
-	return_ACPI_STATUS(status);
+	return status;
 }
 
 ACPI_EXPORT_SYMBOL(acpi_load_table)
@@ -240,8 +249,7 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
  *
  * PARAMETERS:  Signature           - ACPI signature of needed table
  *              Instance            - Which instance (for SSDTs)
- *              out_table_header    - Where the pointer to the table header
- *                                    is returned
+ *              out_table_header    - The pointer to the table header to fill
  *
  * RETURN:      Status and pointer to mapped table header
  *
@@ -254,10 +262,11 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
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
 
@@ -279,16 +288,31 @@ acpi_get_table_header(char *signature,
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
index 9c26400..918280e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -109,7 +109,7 @@ acpi_status acpi_unload_table_id(acpi_owner_id id);
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
@@ -69,7 +69,7 @@ acpi_status acpi_tb_resize_root_table_list(void);
 acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc);
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_header *table,
+acpi_tb_add_table(struct acpi_table_desc *table_desc,
 		  acpi_native_uint * table_index);
 
 acpi_status
@@ -77,7 +77,7 @@ acpi_tb_store_table(acpi_physical_address address,
 		    struct acpi_table_header *table,
 		    u32 length, u8 flags, acpi_native_uint * table_index);
 
-void acpi_tb_delete_table(acpi_native_uint table_index);
+void acpi_tb_delete_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_terminate(void);
 
@@ -113,8 +113,4 @@ acpi_tb_install_table(acpi_physical_address address,
 acpi_status
 acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags);
 
-void *acpi_tb_map(acpi_physical_address address, u32 length, u32 flags);
-
-void acpi_tb_unmap(void *pointer, u32 length, u32 flags);
-
 #endif				/* __ACTABLES_H__ */
-- 
1.5.0.rc3.39.gec804
