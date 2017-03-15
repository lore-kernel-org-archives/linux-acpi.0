From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 3/7] ACPICA: Tables: Add sanity check for table install
Date: Wed, 15 Mar 2017 14:37:10 +0800
Message-ID: <f6eca5630bbe6233345da81b46ae3d4940350dff.1489558845.git.lv.zheng@intel.com>
References: <cover.1489558845.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13117 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbdCOGhP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 02:37:15 -0400
In-Reply-To: <cover.1489558845.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

This patch adds sanity check for table install process, avoid installing
same tables to the global table list. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/actables.h |  2 +-
 drivers/acpi/acpica/tbinstal.c | 33 +++++++++++++++++++++++++++------
 include/acpi/actbl.h           |  1 +
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 1509797..db78af4 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -162,7 +162,7 @@ void acpi_tb_check_dsdt_header(void);
 
 struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index);
 
-void
+acpi_status
 acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 				    u8 override, u32 *table_index);
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 5e3d445..fa82962 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -56,7 +56,7 @@ ACPI_MODULE_NAME("tbinstal")
  *              override                - Whether override should be performed
  *              table_index             - Where the table index is returned
  *
- * RETURN:      None
+ * RETURN:      Status
  *
  * DESCRIPTION: Install an ACPI table into the global data structure. The
  *              table override mechanism is called to allow the host
@@ -64,12 +64,13 @@ ACPI_MODULE_NAME("tbinstal")
  *              table array.
  *
  ******************************************************************************/
-void
+acpi_status
 acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 				    u8 override, u32 *table_index)
 {
 	u32 i;
-	acpi_status status;
+	acpi_status status = AE_OK;
+	struct acpi_table_desc *table_desc;
 
 	/*
 	 * ACPI Table Override:
@@ -86,9 +87,22 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
+	/* Check if the table has already been installed */
+
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
+		table_desc = &acpi_gbl_root_table_list.tables[i];
+		if (table_desc->address &&
+		    new_table_desc->address == table_desc->address &&
+		    ACPI_TABLE_ORIGIN(new_table_desc) ==
+		    ACPI_TABLE_ORIGIN(table_desc)) {
+			*table_index = i;
+			goto unlock_and_exit;
+		}
+	}
+
 	status = acpi_tb_get_next_table_descriptor(&i, NULL);
 	if (ACPI_FAILURE(status)) {
-		return;
+		goto unlock_and_exit;
 	}
 
 	acpi_tb_init_table_descriptor(&acpi_gbl_root_table_list.tables[i],
@@ -109,9 +123,12 @@ acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
 		acpi_ut_set_integer_width(new_table_desc->pointer->revision);
 	}
 
+unlock_and_exit:
+
 	/* Release the table lock */
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+	return (status);
 }
 
 /*******************************************************************************
@@ -177,8 +194,12 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 
 	/* Add the table to the global root table list */
 
-	acpi_tb_install_table_with_override(&new_table_desc, override,
-					    table_index);
+	status =
+	    acpi_tb_install_table_with_override(&new_table_desc, override,
+						table_index);
+	if (ACPI_FAILURE(status)) {
+		goto release_and_exit;
+	}
 
 	/* Invoke table handler */
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index d92543f..7ebaa07 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -380,6 +380,7 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL (1)	/* Physical address, internally mapped */
 #define ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL  (2)	/* Virtual address, internallly allocated */
 #define ACPI_TABLE_ORIGIN_MASK              (3)
+#define ACPI_TABLE_ORIGIN(desc)             ((desc)->flags & ACPI_TABLE_ORIGIN_MASK)
 #define ACPI_TABLE_IS_LOADED                (8)
 
 /*
-- 
2.7.4

