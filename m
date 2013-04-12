From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/11] ACPICA: Fix for some comments/headers
Date: Fri, 12 Apr 2013 08:24:53 +0800
Message-ID: <47d6a144349820df6ff40778c86fbe369c235eda.1365473142.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36936 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab3DLAZF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:25:05 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>, Lv Zheng <lv.zheng@intel.com>

From: Tang Chen <tangchen@cn.fujitsu.com>

No functional change.  Includes parameter rename from Tang Chen.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbxface.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index b35a5e6..ad11162 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Module Name: tbxface - ACPI table oriented external interfaces
+ * Module Name: tbxface - ACPI table-oriented external interfaces
  *
  *****************************************************************************/
 
@@ -80,7 +80,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count)
  *                                    array is dynamically allocated.
  *              initial_table_count - Size of initial_table_array, in number of
  *                                    struct acpi_table_desc structures
- *              allow_realloc       - Flag to tell Table Manager if resize of
+ *              allow_resize        - Flag to tell Table Manager if resize of
  *                                    pre-allocated array is allowed. Ignored
  *                                    if initial_table_array is NULL.
  *
@@ -107,8 +107,8 @@ acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 	ACPI_FUNCTION_TRACE(acpi_initialize_tables);
 
 	/*
-	 * Set up the Root Table Array
-	 * Allocate the table array if requested
+	 * Setup the Root Table Array and allocate the table array
+	 * if requested
 	 */
 	if (!initial_table_array) {
 		status = acpi_allocate_root_table(initial_table_count);
@@ -305,9 +305,10 @@ ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
  *              instance            - Which instance (for SSDTs)
  *              out_table           - Where the pointer to the table is returned
  *
- * RETURN:      Status and pointer to table
+ * RETURN:      Status and pointer to the requested table
  *
- * DESCRIPTION: Finds and verifies an ACPI table.
+ * DESCRIPTION: Finds and verifies an ACPI table. Table must be in the
+ *              RSDT/XSDT.
  *
  ******************************************************************************/
 acpi_status
@@ -375,9 +376,10 @@ ACPI_EXPORT_SYMBOL(acpi_get_table)
  * PARAMETERS:  table_index         - Table index
  *              table               - Where the pointer to the table is returned
  *
- * RETURN:      Status and pointer to the table
+ * RETURN:      Status and pointer to the requested table
  *
- * DESCRIPTION: Obtain a table by an index into the global table list.
+ * DESCRIPTION: Obtain a table by an index into the global table list. Used
+ *              internally also.
  *
  ******************************************************************************/
 acpi_status
@@ -432,7 +434,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table_by_index)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Install table event handler
+ * DESCRIPTION: Install a global table event handler.
  *
  ******************************************************************************/
 acpi_status
@@ -479,7 +481,7 @@ ACPI_EXPORT_SYMBOL(acpi_install_table_handler)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Remove table event handler
+ * DESCRIPTION: Remove a table event handler
  *
  ******************************************************************************/
 acpi_status acpi_remove_table_handler(acpi_table_handler handler)
-- 
1.7.10

