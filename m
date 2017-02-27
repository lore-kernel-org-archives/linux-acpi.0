From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPICA: Detect duplicate SSDT tables
Date: Mon, 27 Feb 2017 10:34:32 +0100
Message-ID: <20170227093432.3308-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbdB0JfN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Feb 2017 04:35:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Some machines have the exact (byte for byte) same SSDT tables multiple
times in the root_table_list. Detect this and silently skip the duplicates
rather then printing a scary looking set of errors.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/tbxfload.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 82019c0..1971cd7 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -125,6 +125,44 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
 
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
+	struct acpi_table_desc *dup;
+	u32 i;
+
+	for (i = 0; i < index; ++i) {
+		dup = &acpi_gbl_root_table_list.tables[i];
+
+		if (!acpi_gbl_root_table_list.tables[i].address ||
+		    (!ACPI_COMPARE_NAME(dup->signature.ascii, ACPI_SIG_SSDT)
+		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
+					   ACPI_SIG_PSDT)
+		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
+					   ACPI_SIG_OSDT))
+		    || ACPI_FAILURE(acpi_tb_validate_table(dup))
+		    || dup->length != table->length) {
+			continue;
+		}
+
+		if (memcmp(dup->pointer, table->pointer, table->length) == 0)
+			return TRUE;
+	}
+	return FALSE;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_load_namespace
  *
  * PARAMETERS:  None
@@ -212,7 +250,8 @@ acpi_status acpi_tb_load_namespace(void)
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

