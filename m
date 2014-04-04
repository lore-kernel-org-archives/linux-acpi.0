From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/28] ACPICA: Tables: Cleanup ACPI_TABLE_ORIGIN_xxx flags.
Date: Fri,  4 Apr 2014 12:39:04 +0800
Message-ID: <925b0db61b1afecac377b6e2564a53306427f820.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43425 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbaDDEjI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:39:08 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch refines ACPI_TABLE_ORIGIN_xxx flags.  No functional changes.

The previous commits have introduced the following internal APIs:
1. acpi_tb_acquire_table: Acquire struct acpi_table_header according to
                       ACPI_TABLE_ORIGIN_xxx flags.
2. acpi_tb_release_table: Release struct acpi_table_header according to
                       ACPI_TABLE_ORIGIN_xxx flags.
3. acpi_tb_install_table: Make struct acpi_table_desc.Address not NULL according to
                       ACPI_TABLE_ORIGIN_xxx flags.
4. acpi_tb_uninstall_table: Make struct acpi_table_desc.Address NULL according to
                         ACPI_TABLE_ORIGIN_xxx flags.
5. acpi_tb_validate_table: Make struct acpi_table_desc.Pointer not NULL according to
                        ACPI_TABLE_ORIGIN_xxx flags.
6. acpi_tb_invalidate_table: Make struct acpi_table_desc.Pointer NULL according to
                          ACPI_TABLE_ORIGIN_xxx flags.
It thus detects that the ACPI_TABLE_ORIGIN_UNKNOWN is redundant to
ACPI_TABLE_ORIGIN_OVERRIDE.

The ACPI_TABLE_ORIGIN_xxTERN_VIRTUAL flags are named as VIRTUAL in order
not to confuse with x86 logical address, this patch also renames all
"logical override" into "virtual override".

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    2 +-
 drivers/acpi/acpica/tbinstal.c |   31 ++++++++++++++-----------------
 drivers/acpi/acpica/tbutils.c  |    4 ++--
 drivers/acpi/acpica/tbxface.c  |    2 +-
 drivers/acpi/acpica/tbxfload.c |    2 +-
 include/acpi/actbl.h           |   11 +++++------
 6 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 52ea900..4dfe6c0 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -483,7 +483,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
-						 ACPI_TABLE_ORIGIN_ALLOCATED,
+						 ACPI_TABLE_ORIGIN_INTERN_VIRTUAL,
 						 TRUE, &table_index);
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 099e678..cf1ccc5 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -86,15 +86,14 @@ acpi_tb_acquire_table(struct acpi_table_desc *table_desc,
 	struct acpi_table_header *table = NULL;
 
 	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
-	case ACPI_TABLE_ORIGIN_MAPPED:
+	case ACPI_TABLE_ORIGIN_INTERN_PHYSICAL:
 
 		table =
 		    acpi_os_map_memory(table_desc->address, table_desc->length);
 		break;
 
-	case ACPI_TABLE_ORIGIN_ALLOCATED:
-	case ACPI_TABLE_ORIGIN_UNKNOWN:
-	case ACPI_TABLE_ORIGIN_OVERRIDE:
+	case ACPI_TABLE_ORIGIN_INTERN_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL:
 
 		table =
 		    ACPI_CAST_PTR(struct acpi_table_header,
@@ -140,14 +139,13 @@ acpi_tb_release_table(struct acpi_table_header *table,
 		      u32 table_length, u8 table_flags)
 {
 	switch (table_flags & ACPI_TABLE_ORIGIN_MASK) {
-	case ACPI_TABLE_ORIGIN_MAPPED:
+	case ACPI_TABLE_ORIGIN_INTERN_PHYSICAL:
 
 		acpi_os_unmap_memory(table, table_length);
 		break;
 
-	case ACPI_TABLE_ORIGIN_ALLOCATED:
-	case ACPI_TABLE_ORIGIN_UNKNOWN:
-	case ACPI_TABLE_ORIGIN_OVERRIDE:
+	case ACPI_TABLE_ORIGIN_INTERN_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL:
 	default:
 
 		break;
@@ -333,7 +331,7 @@ acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
 	struct acpi_table_header *table_header;
 
 	switch (flags & ACPI_TABLE_ORIGIN_MASK) {
-	case ACPI_TABLE_ORIGIN_MAPPED:
+	case ACPI_TABLE_ORIGIN_INTERN_PHYSICAL:
 
 		/* Try to obtain the length of the table */
 
@@ -348,9 +346,8 @@ acpi_tb_acquire_temporal_table(struct acpi_table_desc *table_desc,
 				     sizeof(struct acpi_table_header));
 		return (AE_OK);
 
-	case ACPI_TABLE_ORIGIN_ALLOCATED:
-	case ACPI_TABLE_ORIGIN_UNKNOWN:
-	case ACPI_TABLE_ORIGIN_OVERRIDE:
+	case ACPI_TABLE_ORIGIN_INTERN_VIRTUAL:
+	case ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL:
 
 		table_header = ACPI_CAST_PTR(struct acpi_table_header, address);
 		if (!table_header) {
@@ -473,7 +470,7 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 	/* Fill a table descriptor for validation */
 
 	status = acpi_tb_acquire_temporal_table(&new_table_desc, address,
-						ACPI_TABLE_ORIGIN_MAPPED);
+						ACPI_TABLE_ORIGIN_INTERN_PHYSICAL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Could not acquire table length at %p",
 			    ACPI_CAST_PTR(void, address)));
@@ -546,7 +543,7 @@ acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc, u32 table_index)
  *
  * FUNCTION:    acpi_tb_install_non_fixed_table
  *
- * PARAMETERS:  address             - Address of the table (might be a logical
+ * PARAMETERS:  address             - Address of the table (might be a virtual
  *                                    address depending on the table_flags)
  *              flags               - Flags for the table
  *              reload              - Whether reload should be performed
@@ -720,7 +717,7 @@ void acpi_tb_override_table(struct acpi_table_desc *old_table_desc)
 	if (ACPI_SUCCESS(status) && table) {
 		acpi_tb_acquire_temporal_table(&new_table_desc,
 					       ACPI_PTR_TO_PHYSADDR(table),
-					       ACPI_TABLE_ORIGIN_OVERRIDE);
+					       ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL);
 		override_type = "Logical";
 		goto finish_override;
 	}
@@ -731,7 +728,7 @@ void acpi_tb_override_table(struct acpi_table_desc *old_table_desc)
 						 &address, &length);
 	if (ACPI_SUCCESS(status) && address && length) {
 		acpi_tb_acquire_temporal_table(&new_table_desc, address,
-					       ACPI_TABLE_ORIGIN_MAPPED);
+					       ACPI_TABLE_ORIGIN_INTERN_PHYSICAL);
 		override_type = "Physical";
 		goto finish_override;
 	}
@@ -928,7 +925,7 @@ void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc)
 	acpi_tb_invalidate_table(table_desc);
 
 	if ((table_desc->flags & ACPI_TABLE_ORIGIN_MASK) ==
-	    ACPI_TABLE_ORIGIN_ALLOCATED) {
+	    ACPI_TABLE_ORIGIN_INTERN_VIRTUAL) {
 		ACPI_FREE(ACPI_CAST_PTR(void, table_desc->address));
 	}
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index e58dfbf..1bf9de7 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -182,7 +182,7 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 	acpi_tb_install_table(&acpi_gbl_root_table_list.
 			      tables[ACPI_TABLE_INDEX_DSDT],
 			      ACPI_PTR_TO_PHYSADDR(new_table),
-			      ACPI_TABLE_ORIGIN_ALLOCATED, new_table);
+			      ACPI_TABLE_ORIGIN_INTERN_VIRTUAL, new_table);
 
 	ACPI_INFO((AE_INFO,
 		   "Forced DSDT copy: length 0x%05X copied locally, original unmapped",
@@ -473,7 +473,7 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 		    acpi_tb_install_non_fixed_table(acpi_tb_get_root_table_entry
 						    (table_entry,
 						     table_entry_size),
-						    ACPI_TABLE_ORIGIN_MAPPED,
+						    ACPI_TABLE_ORIGIN_INTERN_PHYSICAL,
 						    FALSE, &table_index);
 
 		if (ACPI_SUCCESS(status) &&
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index ae3fe4d..19c0b13 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -233,7 +233,7 @@ acpi_get_table_header(char *signature,
 		if (!acpi_gbl_root_table_list.tables[i].pointer) {
 			if ((acpi_gbl_root_table_list.tables[i].flags &
 			     ACPI_TABLE_ORIGIN_MASK) ==
-			    ACPI_TABLE_ORIGIN_MAPPED) {
+			    ACPI_TABLE_ORIGIN_INTERN_PHYSICAL) {
 				header =
 				    acpi_os_map_memory(acpi_gbl_root_table_list.
 						       tables[i].address,
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 77e8d26..62bbd38 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -248,7 +248,7 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	ACPI_INFO((AE_INFO, "Host-directed Dynamic ACPI Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
-						 ACPI_TABLE_ORIGIN_UNKNOWN,
+						 ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL,
 						 TRUE, &table_index);
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 3b30e36..0cdf4cc 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -367,12 +367,11 @@ struct acpi_table_desc {
 
 /* Masks for Flags field above */
 
-#define ACPI_TABLE_ORIGIN_UNKNOWN       (0)
-#define ACPI_TABLE_ORIGIN_MAPPED        (1)
-#define ACPI_TABLE_ORIGIN_ALLOCATED     (2)
-#define ACPI_TABLE_ORIGIN_OVERRIDE      (4)
-#define ACPI_TABLE_ORIGIN_MASK          (7)
-#define ACPI_TABLE_IS_LOADED            (8)
+#define ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL    (0)	/* Virtual address, external maintained */
+#define ACPI_TABLE_ORIGIN_INTERN_PHYSICAL   (1)	/* Physical address, internal mapped */
+#define ACPI_TABLE_ORIGIN_INTERN_VIRTUAL    (2)	/* Virtual address, internal allocated */
+#define ACPI_TABLE_ORIGIN_MASK              (3)
+#define ACPI_TABLE_IS_LOADED                (8)
 
 /*
  * Get the remaining ACPI tables
-- 
1.7.10

