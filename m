From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/31] ACPICA: Tables: Move an iasl specific table function to iasl source file.
Date: Mon, 13 Apr 2015 11:49:30 +0800
Message-ID: <95eb730a01baed96d7ba80cf1465b9a935c81a92.1428893937.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 6eb364d790dd103bd4990f808e0095a421c437cb

acpi_tb_store_table() implements a logic that is only correct to iasl. So it
won't be used by any other utilities except iasl. This function is
complained by the kernel users as an unused function. The best choice to
stop releasing it to the Linux kernel should be moving it to adisasm.c.

ACPI table manager can use both struct acpi_table_desc (direct referencing)
and table index (indirect referencing) as the descriptor to the table, so
acpi_tb_get_next_root_index() is extended to return both of them to allow
maximum usability from the callers. NOTE that indirect referencing is a
design result to meet the boot stage static allocation requirement for the
table descriptors.

This is a linuxized acpi_tb_store_table() removing result, there should be
no functional changes introduced to the Linux kernel by this patch except
the additonal kernel unused argument for acpi_tb_get_next_root_index()
(renamed to acpi_tb_get_next_root_index()). This argument is used in the
ACPICA upstream.

Link: https://github.com/acpica/acpica/commit/6eb364d7
Reported-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h |    9 +++------
 drivers/acpi/acpica/tbdata.c   |   20 ++++++++++++++++----
 drivers/acpi/acpica/tbinstal.c |   39 +--------------------------------------
 3 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 1c127a4..7e0b6f1 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -58,7 +58,9 @@ u8 *acpi_tb_scan_memory_for_rsdp(u8 *start_address, u32 length);
 /*
  * tbdata - table data structure management
  */
-acpi_status acpi_tb_get_next_root_index(u32 *table_index);
+acpi_status
+acpi_tb_get_next_table_descriptor(u32 *table_index,
+				  struct acpi_table_desc **table_desc);
 
 void
 acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
@@ -119,11 +121,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 			       u8 flags,
 			       u8 reload, u8 override, u32 *table_index);
 
-acpi_status
-acpi_tb_store_table(acpi_physical_address address,
-		    struct acpi_table_header *table,
-		    u32 length, u8 flags, u32 *table_index);
-
 void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_terminate(void);
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index fd5998b..d7f8386 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -484,19 +484,23 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_get_next_root_index
+ * FUNCTION:    acpi_tb_get_next_table_descriptor
  *
  * PARAMETERS:  table_index         - Where table index is returned
+ *              table_desc          - Where table descriptor is returned
  *
- * RETURN:      Status and table index.
+ * RETURN:      Status and table index/descriptor.
  *
  * DESCRIPTION: Allocate a new ACPI table entry to the global table list
  *
  ******************************************************************************/
 
-acpi_status acpi_tb_get_next_root_index(u32 *table_index)
+acpi_status
+acpi_tb_get_next_table_descriptor(u32 *table_index,
+				  struct acpi_table_desc **table_desc)
 {
 	acpi_status status;
+	u32 i;
 
 	/* Ensure that there is room for the table in the Root Table List */
 
@@ -508,8 +512,16 @@ acpi_status acpi_tb_get_next_root_index(u32 *table_index)
 		}
 	}
 
-	*table_index = acpi_gbl_root_table_list.current_table_count;
+	i = acpi_gbl_root_table_list.current_table_count;
 	acpi_gbl_root_table_list.current_table_count++;
+
+	if (table_index) {
+		*table_index = i;
+	}
+	if (table_desc) {
+		*table_desc = &acpi_gbl_root_table_list.tables[i];
+	}
+
 	return (AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 7e69bc7..008a251 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -356,7 +356,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 	/* Add the table to the global root table list */
 
-	status = acpi_tb_get_next_root_index(&i);
+	status = acpi_tb_get_next_table_descriptor(&i, NULL);
 	if (ACPI_FAILURE(status)) {
 		goto release_and_exit;
 	}
@@ -457,43 +457,6 @@ finish_override:
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_tb_store_table
- *
- * PARAMETERS:  address             - Table address
- *              table               - Table header
- *              length              - Table length
- *              flags               - Install flags
- *              table_index         - Where the table index is returned
- *
- * RETURN:      Status and table index.
- *
- * DESCRIPTION: Add an ACPI table to the global table list
- *
- ******************************************************************************/
-
-acpi_status
-acpi_tb_store_table(acpi_physical_address address,
-		    struct acpi_table_header * table,
-		    u32 length, u8 flags, u32 *table_index)
-{
-	acpi_status status;
-	struct acpi_table_desc *table_desc;
-
-	status = acpi_tb_get_next_root_index(table_index);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	/* Initialize added table */
-
-	table_desc = &acpi_gbl_root_table_list.tables[*table_index];
-	acpi_tb_init_table_descriptor(table_desc, address, flags, table);
-	table_desc->pointer = table;
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_tb_uninstall_table
  *
  * PARAMETERS:  table_desc          - Table descriptor
-- 
1.7.10
