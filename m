From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v2 5/5] ACPICA: Tables: Add deferred table verification support
Date: Tue, 16 May 2017 15:13:55 +0800
Message-ID: <91f88cf7614fa7169a0650ddb1133069448c0fb6.1494916766.git.lv.zheng@intel.com>
References: <20170227093432.3308-1-hdegoede@redhat.com> <cover.1494916766.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16537 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbdEPHOB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 03:14:01 -0400
In-Reply-To: <cover.1494916766.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

This patch allows tables not verified in early stage verfied in
acpi_reallocate_root_table(). This is useful for OSPMs like linux where tables
cannot be verified in early stage due to early ioremp limitations on some
architectures. Reported by Hans de Geode, fixed by Lv Zheng.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbdata.c   | 31 ++++++++++++++++++++++++-------
 drivers/acpi/acpica/tbinstal.c |  1 +
 drivers/acpi/acpica/tbxface.c  | 28 +++++++++++++++++++++++-----
 drivers/acpi/bus.c             |  3 ---
 include/acpi/actbl.h           |  1 +
 5 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 2dee2cd..f58e209 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -426,12 +426,18 @@ acpi_status
 acpi_tb_check_duplication(struct acpi_table_desc *table_desc, u32 *table_index)
 {
 	u32 i;
+	u32 max_table_index;
 
 	ACPI_FUNCTION_TRACE(tb_check_duplication);
 
 	/* Check if table is already registered */
 
-	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
+	if (table_index) {
+		max_table_index = *table_index;
+	} else {
+		max_table_index = acpi_gbl_root_table_list.current_table_count;
+	}
+	for (i = 0; i < max_table_index; ++i) {
 		/*
 		 * Check for a table match on the entire table length,
 		 * not just the header.
@@ -551,6 +557,8 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc,
 				goto invalidate_and_exit;
 			}
 		}
+
+		table_desc->flags |= ACPI_TABLE_IS_VERIFIED;
 	}
 
 	return_ACPI_STATUS(status);
@@ -576,6 +584,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 {
 	struct acpi_table_desc *tables;
 	u32 table_count;
+	u32 current_table_count, max_table_count;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(tb_resize_root_table_list);
 
@@ -595,8 +605,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 		table_count = acpi_gbl_root_table_list.current_table_count;
 	}
 
-	tables = ACPI_ALLOCATE_ZEROED(((acpi_size)table_count +
-				       ACPI_ROOT_TABLE_SIZE_INCREMENT) *
+	max_table_count = table_count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	tables = ACPI_ALLOCATE_ZEROED(((acpi_size)max_table_count) *
 				      sizeof(struct acpi_table_desc));
 	if (!tables) {
 		ACPI_ERROR((AE_INFO,
@@ -606,9 +616,16 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 	/* Copy and free the previous table array */
 
+	current_table_count = 0;
 	if (acpi_gbl_root_table_list.tables) {
-		memcpy(tables, acpi_gbl_root_table_list.tables,
-		       (acpi_size)table_count * sizeof(struct acpi_table_desc));
+		for (i = 0; i < table_count; i++) {
+			if (acpi_gbl_root_table_list.tables[i].address) {
+				memcpy(tables + current_table_count,
+				       acpi_gbl_root_table_list.tables + i,
+				       sizeof(struct acpi_table_desc));
+				current_table_count++;
+			}
+		}
 
 		if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 			ACPI_FREE(acpi_gbl_root_table_list.tables);
@@ -616,8 +633,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 	}
 
 	acpi_gbl_root_table_list.tables = tables;
-	acpi_gbl_root_table_list.max_table_count =
-	    table_count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	acpi_gbl_root_table_list.max_table_count = max_table_count;
+	acpi_gbl_root_table_list.current_table_count = current_table_count;
 	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ORIGIN_ALLOCATED;
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9404801..5ef0f91 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -167,6 +167,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 	/* Validate and verify a table before installation */
 
+	i = acpi_gbl_root_table_list.current_table_count;
 	status = acpi_tb_verify_temp_table(&new_table_desc, NULL, &i);
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_CTRL_TERMINATE) {
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index b0dc841..a6da41d 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -167,7 +167,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_tables)
 acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 {
 	acpi_status status;
-	u32 i;
+	struct acpi_table_desc *table_desc;
+	u32 i, j;
 
 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
 
@@ -179,6 +180,8 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
 	/*
 	 * Ensure OS early boot logic, which is required by some hosts. If the
 	 * table state is reported to be wrong, developers should fix the
@@ -186,11 +189,11 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 	 * early stage.
 	 */
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
-		if (acpi_gbl_root_table_list.tables[i].pointer) {
+		table_desc = &acpi_gbl_root_table_list.tables[i];
+		if (table_desc->pointer) {
 			ACPI_ERROR((AE_INFO,
 				    "Table [%4.4s] is not invalidated during early boot stage",
-				    acpi_gbl_root_table_list.tables[i].
-				    signature.ascii));
+				    table_desc->signature.ascii));
 		}
 	}
 
@@ -200,11 +203,26 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 		 * table initilization here once the flag is set.
 		 */
 		acpi_gbl_enable_table_validation = TRUE;
+		for (i = 0; i < acpi_gbl_root_table_list.current_table_count;
+		     ++i) {
+			table_desc = &acpi_gbl_root_table_list.tables[i];
+			if (!(table_desc->flags & ACPI_TABLE_IS_VERIFIED)) {
+				j = i;
+				status =
+				    acpi_tb_verify_temp_table(table_desc, NULL,
+							      &j);
+				if (ACPI_FAILURE(status)) {
+					acpi_tb_uninstall_table(table_desc);
+				}
+			}
+		}
 	}
 
 	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ALLOW_RESIZE;
-
 	status = acpi_tb_resize_root_table_list();
+	acpi_gbl_root_table_list.flags |= ACPI_ROOT_ORIGIN_ALLOCATED;
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c26342f..93c7c5b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1009,9 +1009,6 @@ void __init acpi_early_init(void)
 
 	printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);
 
-	/* It's safe to verify table checksums during late stage */
-	acpi_gbl_enable_table_validation = TRUE;
-
 	/* enable workarounds, unless strict ACPI spec. compliance */
 	if (!acpi_strict)
 		acpi_gbl_enable_interpreter_slack = TRUE;
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index d92543f..d10a172 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -380,6 +380,7 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL (1)	/* Physical address, internally mapped */
 #define ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL  (2)	/* Virtual address, internallly allocated */
 #define ACPI_TABLE_ORIGIN_MASK              (3)
+#define ACPI_TABLE_IS_VERIFIED              (4)
 #define ACPI_TABLE_IS_LOADED                (8)
 
 /*
-- 
2.7.4

