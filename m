From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] ACPICA: Detect duplicate SSDT tables
Date: Tue, 14 Mar 2017 21:45:56 +0100
Message-ID: <20170314204556.16099-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753063AbdCNUqH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 16:46:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

Some machines have the exact (byte for byte) same SSDT tables multiple
times in the root_table_list. Detect this and silently skip the duplicates
rather then printing a scary looking set of errors.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use existing acpi_tb_compare_tables helper
---
 drivers/acpi/acpica/actables.h |  2 ++
 drivers/acpi/acpica/tbinstal.c |  6 +-----
 drivers/acpi/acpica/tbxfload.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index c8da453..d50437c 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -99,6 +99,8 @@ acpi_tb_find_table(char *signature,
 /*
  * tbinstal - Table removal and deletion
  */
+u8 acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
+
 acpi_status acpi_tb_resize_root_table_list(void);
 
 acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 4620f3c..1431bfa 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -48,10 +48,6 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbinstal")
 
-/* Local prototypes */
-static u8
-acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_compare_tables
@@ -66,7 +62,7 @@ acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
  *
  ******************************************************************************/
 
-static u8
+u8
 acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
 {
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index b71ce3b..2f718b0 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -125,6 +125,30 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_find_duplicate_ssdt
+ *
+ * PARAMETERS:  table         - validated acpi_table_desc of table to check
+ *              index         - index of table to find a duplicate of
+ *
+ * RETURN:      TRUE if a duplicate is found, FALSE if not
+ *
+ * DESCRIPTION: Private helper function for acpi_tb_load_namespace to
+ *              avoid trying to load duplicate ssdt tables
+ *
+ ******************************************************************************/
+static u8 acpi_tb_find_duplicate_ssdt(struct acpi_table_desc *table, u32 index)
+{
+	u32 i;
+
+	for (i = 0; i < index; ++i)
+		if (acpi_tb_compare_tables(table, i))
+			return TRUE;
+
+	return FALSE;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_load_namespace
  *
  * PARAMETERS:  None
@@ -212,7 +236,8 @@ acpi_status acpi_tb_load_namespace(void)
 					   ACPI_SIG_PSDT)
 		     && !ACPI_COMPARE_NAME(table->signature.ascii,
 					   ACPI_SIG_OSDT))
-		    || ACPI_FAILURE(acpi_tb_validate_table(table))) {
+		    || ACPI_FAILURE(acpi_tb_validate_table(table))
+		    || acpi_tb_find_duplicate_ssdt(table, i)) {
 			continue;
 		}
 
-- 
2.9.3

