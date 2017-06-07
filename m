From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5] ACPICA: Tables: Add mechanism to allow to balance late stage acpi_get_table() independently
Date: Wed,  7 Jun 2017 12:54:58 +0800
Message-ID: <cb1126b2eb1b83a5a97a33c1c5c37a02c32fd688.1496811175.git.lv.zheng@intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62681 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbdFGEzC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jun 2017 00:55:02 -0400
In-Reply-To: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Considering this case:
1. A program opens a sysfs table file 65535 times, it can increase
   validation_count and first increment cause the table to be mapped:
    validation_count = 65535
2. AML execution causes "Load" to be executed on the same table, this time
   it cannot increase validation_count, so validation_count remains:
    validation_count = 65535
3. The program closes sysfs table file 65535 times, it can decrease
   validation_count and the last decrement cause the table to be unmapped:
    validation_count = 0
4. AML code still accessing the loaded table, kernel crash can be observed.

This is because orginally ACPICA doesn't support unmapping tables during
OS late stage. So the current code only allows unmapping tables during OS
early stage, and for late stage, no acpi_put_table() clones should be
invoked, especially cases that can trigger frequent invocations of
acpi_get_table()/acpi_put_table() are forbidden:
1. sysfs table accesses
2. dynamic Load/Unload opcode executions
3. acpi_load_table()
4. etc.
Such frequent acpi_put_table() balance changes have to be done altogether.

This philosophy is not convenient for Linux driver writers. Since the API
is just there, developers will start to use acpi_put_table() during late
stage. So we need to consider a better mechanism to allow them to safely
invoke acpi_put_table().

This patch provides such a mechanism by adding a validation_count
threashold. When it is reached, the validation_count can no longer be
incremented/decremented to invalidate the table descriptor (means
preventing table unmappings) so that acpi_put_table() balance changes can be
done independently to each others.

Note: code added in acpi_tb_put_table() is actually a no-op but changes the
warning message into a warning once message. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbutils.c | 36 +++++++++++++++++++++++++++---------
 include/acpi/actbl.h          | 13 +++++++++++++
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index cd96026..4048523 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -416,9 +416,19 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
 		}
 	}
 
-	table_desc->validation_count++;
-	if (table_desc->validation_count == 0) {
-		table_desc->validation_count--;
+	if (table_desc->validation_count < ACPI_MAX_TABLE_VALIDATIONS) {
+		table_desc->validation_count++;
+
+		/*
+		 * Ensure the warning message can only be displayed once. The
+		 * warning message occurs when the "get" operations are performed
+		 * more than "put" operations, causing count overflow.
+		 */
+		if (table_desc->validation_count >= ACPI_MAX_TABLE_VALIDATIONS) {
+			ACPI_WARNING((AE_INFO,
+				      "Table %p, Validation count overflows\n",
+				      table_desc));
+		}
 	}
 
 	*out_table = table_desc->pointer;
@@ -445,13 +455,21 @@ void acpi_tb_put_table(struct acpi_table_desc *table_desc)
 
 	ACPI_FUNCTION_TRACE(acpi_tb_put_table);
 
-	if (table_desc->validation_count == 0) {
-		ACPI_WARNING((AE_INFO,
-			      "Table %p, Validation count is zero before decrement\n",
-			      table_desc));
-		return_VOID;
+	if (table_desc->validation_count < ACPI_MAX_TABLE_VALIDATIONS) {
+		table_desc->validation_count--;
+
+		/*
+		 * Ensure the warning message can only be displayed once. The
+		 * warning message occurs when the "put" operations are performed
+		 * more than "get" operations, causing count underflow.
+		 */
+		if (table_desc->validation_count >= ACPI_MAX_TABLE_VALIDATIONS) {
+			ACPI_WARNING((AE_INFO,
+				      "Table %p, Validation count underflows\n",
+				      table_desc));
+			return_VOID;
+		}
 	}
-	table_desc->validation_count--;
 
 	if (table_desc->validation_count == 0) {
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index d92543f..f42e6d5 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -374,6 +374,19 @@ struct acpi_table_desc {
 	u16 validation_count;
 };
 
+/*
+ * Maximum validation count, when it is reached, validation count can no
+ * longer be changed. Which means, the table can no longer be invalidated.
+ * This mechanism is implemented for backward compatibility, where in OS
+ * late stage, old drivers are not facilitated with paired validations and
+ * invalidations.
+ * The maximum validation count can be defined to any value, but should be
+ * greater than the maximum number of OS early stage mapping slots as it
+ * must be ensured that no early stage mappings can be leaked to the late
+ * stage.
+ */
+#define ACPI_MAX_TABLE_VALIDATIONS          ACPI_UINT16_MAX
+
 /* Masks for Flags field above */
 
 #define ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL  (0)	/* Virtual address, external maintained */
-- 
2.7.4

