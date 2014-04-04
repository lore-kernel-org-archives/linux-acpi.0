From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/28] ACPICA: Tables: Add acpi_install_table() API to be invoked by OSPM early table installation.
Date: Fri,  4 Apr 2014 12:39:18 +0800
Message-ID: <a5f3fca97db68338eeaeb0d251d0df4aadf4e775.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48358 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbaDDEjq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:39:46 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Bob Moore <robert.moore@intel.com>

This patch adds a new API - acpi_install_table(). OSPMs can use this API
to install tables during early boot stage.  Lv Zheng.

Reference: https://lkml.org/lkml/2014/2/28/372
Cc: Thomas Renninger <trenn@suse.de>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h |    6 ++++--
 drivers/acpi/acpica/exconfig.c |    2 +-
 drivers/acpi/acpica/tbinstal.c |   16 ++++++++++-----
 drivers/acpi/acpica/tbutils.c  |    2 +-
 drivers/acpi/acpica/tbxfload.c |   42 ++++++++++++++++++++++++++++++++++++++--
 include/acpi/acpixf.h          |    3 +++
 6 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 32aec48..3d20a96 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -92,7 +92,8 @@ acpi_tb_release_table(struct acpi_table_header *table,
 
 acpi_status
 acpi_tb_install_non_fixed_table(acpi_physical_address address,
-				u8 flags, u8 reload, u32 *table_index);
+				u8 flags,
+				u8 reload, u8 override, u32 *table_index);
 
 acpi_status
 acpi_tb_store_table(acpi_physical_address address,
@@ -142,7 +143,8 @@ acpi_tb_install_table(struct acpi_table_desc *table_desc,
 
 void
 acpi_tb_install_and_override_table(u32 table_index,
-				   struct acpi_table_desc *new_table_desc);
+				   struct acpi_table_desc *new_table_desc,
+				   u8 override);
 
 acpi_status
 acpi_tb_install_fixed_table(acpi_physical_address address,
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 4dfe6c0..815003d 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -484,7 +484,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
 						 ACPI_TABLE_ORIGIN_INTERN_VIRTUAL,
-						 TRUE, &table_index);
+						 TRUE, TRUE, &table_index);
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index de10d32..9835213 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -394,6 +394,7 @@ static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc)
  *
  * PARAMETERS:  table_index             - Index into root table array
  *              new_table_desc          - New table descriptor to install
+ *              override                - Whether override should be performed
  *
  * RETURN:      None
  *
@@ -406,7 +407,8 @@ static void acpi_tb_release_temporal_table(struct acpi_table_desc *table_desc)
 
 void
 acpi_tb_install_and_override_table(u32 table_index,
-				   struct acpi_table_desc *new_table_desc)
+				   struct acpi_table_desc *new_table_desc,
+				   u8 override)
 {
 	if (table_index >= acpi_gbl_root_table_list.current_table_count) {
 		return;
@@ -419,7 +421,9 @@ acpi_tb_install_and_override_table(u32 table_index,
 	 * one if desired. Any table within the RSDT/XSDT can be replaced,
 	 * including the DSDT which is pointed to by the FADT.
 	 */
-	acpi_tb_override_table(new_table_desc);
+	if (override) {
+		acpi_tb_override_table(new_table_desc);
+	}
 
 	acpi_tb_install_table(&acpi_gbl_root_table_list.tables[table_index],
 			      new_table_desc->address, new_table_desc->flags,
@@ -484,7 +488,7 @@ acpi_tb_install_fixed_table(acpi_physical_address address,
 		goto release_and_exit;
 	}
 
-	acpi_tb_install_and_override_table(table_index, &new_table_desc);
+	acpi_tb_install_and_override_table(table_index, &new_table_desc, TRUE);
 
 release_and_exit:
 
@@ -547,6 +551,7 @@ acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc, u32 table_index)
  *                                    address depending on the table_flags)
  *              flags               - Flags for the table
  *              reload              - Whether reload should be performed
+ *              override            - Whether override should be performed
  *              table_index         - Where the table index is returned
  *
  * RETURN:      Status
@@ -562,7 +567,8 @@ acpi_tb_is_equivalent_table(struct acpi_table_desc *table_desc, u32 table_index)
 
 acpi_status
 acpi_tb_install_non_fixed_table(acpi_physical_address address,
-				u8 flags, u8 reload, u32 *table_index)
+				u8 flags,
+				u8 reload, u8 override, u32 *table_index)
 {
 	u32 i;
 	acpi_status status = AE_OK;
@@ -687,7 +693,7 @@ acpi_tb_install_non_fixed_table(acpi_physical_address address,
 		goto release_and_exit;
 	}
 	*table_index = i;
-	acpi_tb_install_and_override_table(i, &new_table_desc);
+	acpi_tb_install_and_override_table(i, &new_table_desc, override);
 
 release_and_exit:
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 1bf9de7..aa11949 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -474,7 +474,7 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 						    (table_entry,
 						     table_entry_size),
 						    ACPI_TABLE_ORIGIN_INTERN_PHYSICAL,
-						    FALSE, &table_index);
+						    FALSE, TRUE, &table_index);
 
 		if (ACPI_SUCCESS(status) &&
 		    ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 3f9eaf5..529f633 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -195,6 +195,45 @@ unlock_and_exit:
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_install_table
+ *
+ * PARAMETERS:  address             - Address of the ACPI table to be installed.
+ *              physical            - Whether the address is a physical table
+ *                                    address or not
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Dynamically install an ACPI table.
+ *              Note: This function should only be invoked after
+ *                    acpi_initialize_tables() and before acpi_load_tables().
+ *
+ ******************************************************************************/
+
+acpi_status __init
+acpi_install_table(acpi_physical_address address, u8 physical)
+{
+	acpi_status status;
+	u8 flags;
+	u32 table_index;
+
+	ACPI_FUNCTION_TRACE(acpi_install_table);
+
+	if (physical) {
+		flags = ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL;
+	} else {
+		flags = ACPI_TABLE_ORIGIN_INTERN_PHYSICAL;
+	}
+
+	status = acpi_tb_install_non_fixed_table(address, flags,
+						 FALSE, FALSE, &table_index);
+
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_load_table
  *
  * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
@@ -209,7 +248,6 @@ unlock_and_exit:
  *              to ensure that the table is not deleted or unmapped.
  *
  ******************************************************************************/
-
 acpi_status acpi_load_table(struct acpi_table_header *table)
 {
 	acpi_status status;
@@ -236,7 +274,7 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	status = acpi_tb_install_non_fixed_table(ACPI_PTR_TO_PHYSADDR(table),
 						 ACPI_TABLE_ORIGIN_EXTERN_VIRTUAL,
-						 TRUE, &table_index);
+						 TRUE, FALSE, &table_index);
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2280c19..8dc9340 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -164,6 +164,9 @@ acpi_decode_pld_buffer(u8 *in_buffer,
 /*
  * ACPI table load/unload interfaces
  */
+acpi_status __init
+acpi_install_table(acpi_physical_address address, u8 physical);
+
 acpi_status acpi_load_table(struct acpi_table_header *table);
 
 acpi_status acpi_unload_parent_table(acpi_handle object);
-- 
1.7.10

