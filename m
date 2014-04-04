From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/28] ACPICA: Tables: Fix the issue that multiple ACPI_FREE()s are invoked for same pointer around acpi_tb_add_table().
Date: Fri,  4 Apr 2014 12:38:35 +0800
Message-ID: <06902e69bbf241c9732ccc8a69745ed5dbe24179.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47472 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbaDDEij (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:39 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

Currently there are following issues in acpi_tb_add_table():
Following logic is currently correct:
1. When a table is allocated in acpi_ex_load_op(), if a reloading happens,
   the allocated memory is freed by acpi_tb_add_table() and AE_OK is
   returned to the caller to avoid the caller to free it again.
Following logic is currently incorrect:
1. When a table is allocated in acpi_ex_load_op() or by the
   acpi_load_table() caller, if the table is already loaded, there will be
   twice ACPI_FREE() called for the same pointer when acpi_tb_add_table()
   returns AE_ALREADY_EXISTS.

This patch only fixes the above incorrect logic in acpi_tb_add_table():
1. Only invoke acpi_tb_delete_table() if AE_OK is going to be returned.
2. After doing so, we do not invoke ACPI_FREE() when returning AE_OK;

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    2 +-
 drivers/acpi/acpica/tbinstal.c |    7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 649a8ef..11a014c 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -504,7 +504,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 		/* Delete allocated table buffer */
 
-		acpi_tb_delete_table(&table_desc);
+		ACPI_FREE(table_desc.pointer);
 		return_ACPI_STATUS(status);
 	}
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 144076a..0040e19 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -203,12 +203,6 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 		 * need to be unregistered when they are unloaded, and slots in the
 		 * root table list should be reused when empty.
 		 */
-
-		/*
-		 * Table is already registered.
-		 * We can delete the table that was passed as a parameter.
-		 */
-		acpi_tb_delete_table(table_desc);
 		*table_index = i;
 
 		if (acpi_gbl_root_table_list.tables[i].
@@ -221,6 +215,7 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 		} else {
 			/* Table was unloaded, allow it to be reloaded */
 
+			acpi_tb_delete_table(table_desc);
 			table_desc->pointer =
 			    acpi_gbl_root_table_list.tables[i].pointer;
 			table_desc->address =
-- 
1.7.10

