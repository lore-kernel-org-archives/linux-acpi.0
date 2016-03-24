From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 2/8] ACPICA: Tables: Invoke acpi_tb_validate_tableby_index() instead of acpi_get_table_by_index()
Date: Thu, 24 Mar 2016 16:30:36 +0800
Message-ID: <aad2ce9fdbe6bc5aa07fbe30d2f59eaf434725f3.1458808078.git.lv.zheng@intel.com>
References: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1900 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbcCXIal (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:30:41 -0400
In-Reply-To: <cover.1458808078.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Serving for the external users, acpi_get_table_by_index() should be restricted
not to map the tables into struct acpi_table_desc.Pointer or it is likely to be
changed into reference couting based style so that the mappings can be
freed when there is no reference to make OS early/late APIs combined.

While all internal acpi_get_table_by_index() usages should be changed to be an
internal validatation based API so that the tables are always mapped to
.Pointer as long as they are referenced inside of ACPICA. From the
reference counting's point of view, the internal reference should be
increased/decreased only once.

Except the flag to ensure the new API is not invoked inside of ACPICA
twice, there is no functional change in this patch. This patch just copies
acpi_get_tableby_index() to form a new API for internal usage so that further
patches can safely modify acpi_get_table_by_index() to make it an external only
API.

Link: https://bugs.acpica.org/show_bug.cgi?id=1253
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/actables.h |    4 +++
 drivers/acpi/acpica/dsinit.c   |    2 +-
 drivers/acpi/acpica/dsopcode.c |    2 +-
 drivers/acpi/acpica/exconfig.c |    4 +--
 drivers/acpi/acpica/nsparse.c  |    2 +-
 drivers/acpi/acpica/tbutils.c  |   73 +++++++++++++++++++++++++++++++++++-----
 drivers/acpi/acpica/tbxface.c  |    2 +-
 include/acpi/actbl.h           |    1 +
 8 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 848ad3a..9310cb4 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -163,6 +163,10 @@ acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
 u8 acpi_is_valid_signature(char *signature);
 
+acpi_status
+acpi_tb_validate_table_by_index(u32 table_index,
+				struct acpi_table_header **out_table);
+
 /*
  * tbxfload
  */
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 5aa1c5f..71d700a 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -232,7 +232,7 @@ acpi_ds_initialize_objects(u32 table_index,
 	}
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
-	status = acpi_get_table_by_index(table_index, &table);
+	status = acpi_tb_validate_table_by_index(table_index, &table);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 4cc9d98..22eea92 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -535,7 +535,7 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 		goto cleanup;
 	}
 
-	status = acpi_get_table_by_index(table_index, &table);
+	status = acpi_tb_validate_table_by_index(table_index, &table);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index a1d177d..98102af 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -252,7 +252,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 		}
 	}
 
-	status = acpi_get_table_by_index(table_index, &table);
+	status = acpi_tb_validate_table_by_index(table_index, &table);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_INFO(("Dynamic OEM Table Load:"));
 		acpi_tb_print_table_header(0, table);
@@ -601,7 +601,7 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	/* Invoke table handler if present */
 
 	if (acpi_gbl_table_handler) {
-		status = acpi_get_table_by_index(table_index, &table);
+		status = acpi_tb_validate_table_by_index(table_index, &table);
 		if (ACPI_SUCCESS(status)) {
 			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
 						     table,
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index f631a47..de76a1d 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -78,7 +78,7 @@ acpi_ns_one_complete_parse(u32 pass_number,
 
 	ACPI_FUNCTION_TRACE(ns_one_complete_parse);
 
-	status = acpi_get_table_by_index(table_index, &table);
+	status = acpi_tb_validate_table_by_index(table_index, &table);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 9240c76..b64fbe3 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -78,16 +78,16 @@ acpi_status acpi_tb_initialize_facs(void)
 	} else if (acpi_gbl_FADT.Xfacs &&
 		   (!acpi_gbl_FADT.facs
 		    || !acpi_gbl_use32_bit_facs_addresses)) {
-		(void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
-					      ACPI_CAST_INDIRECT_PTR(struct
-								     acpi_table_header,
-								     &facs));
+		(void)acpi_tb_validate_table_by_index(acpi_gbl_xfacs_index,
+						      ACPI_CAST_INDIRECT_PTR
+						      (struct acpi_table_header,
+						       &facs));
 		acpi_gbl_FACS = facs;
 	} else if (acpi_gbl_FADT.facs) {
-		(void)acpi_get_table_by_index(acpi_gbl_facs_index,
-					      ACPI_CAST_INDIRECT_PTR(struct
-								     acpi_table_header,
-								     &facs));
+		(void)acpi_tb_validate_table_by_index(acpi_gbl_facs_index,
+						      ACPI_CAST_INDIRECT_PTR
+						      (struct acpi_table_header,
+						       &facs));
 		acpi_gbl_FACS = facs;
 	}
 
@@ -407,3 +407,60 @@ u8 acpi_is_valid_signature(char *signature)
 
 	return (TRUE);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_tb_validate_table_by_index
+ *
+ * PARAMETERS:  table_index         - Table index
+ *              out_table           - Where the pointer to the table is returned
+ *
+ * RETURN:      Status and pointer to the requested table
+ *
+ * DESCRIPTION: Obtain a table by an index into the global table list. Used
+ *              internally only as the table will be put into the state of
+ *              "VALIDATED" by internal references.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_tb_validate_table_by_index(u32 table_index,
+				struct acpi_table_header ** out_table)
+{
+	acpi_status status = AE_OK;
+	struct acpi_table_desc *table_desc;
+
+	ACPI_FUNCTION_TRACE(acpi_tb_validate_table_by_index);
+
+	/* Parameter validation */
+
+	if (!out_table) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
+	/* Validate index */
+
+	if (table_index >= acpi_gbl_root_table_list.current_table_count) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+	table_desc = &acpi_gbl_root_table_list.tables[table_index];
+
+	if (!(table_desc->flags & ACPI_TABLE_IS_VALIDATED)) {
+
+		/* Table is not validated, validate it */
+
+		status = acpi_tb_validate_table(table_desc);
+		if (ACPI_FAILURE(status)) {
+			goto unlock_and_exit;
+		}
+		table_desc->flags |= ACPI_TABLE_IS_VALIDATED;
+	}
+	*out_table = table_desc->pointer;
+
+unlock_and_exit:
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	return_ACPI_STATUS(status);
+}
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 5700e72..ef2c5f9 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -364,7 +364,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table)
  * RETURN:      Status and pointer to the requested table
  *
  * DESCRIPTION: Obtain a table by an index into the global table list. Used
- *              internally also.
+ *              externally only.
  *
  ******************************************************************************/
 acpi_status
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index c19700e..9513849 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -379,6 +379,7 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL (1)	/* Physical address, internally mapped */
 #define ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL  (2)	/* Virtual address, internallly allocated */
 #define ACPI_TABLE_ORIGIN_MASK              (3)
+#define ACPI_TABLE_IS_VALIDATED             (4)	/* Internal validated */
 #define ACPI_TABLE_IS_LOADED                (8)
 
 /*
-- 
1.7.10

