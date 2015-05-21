From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/19] ACPICA: ACPI 6.0: Add changes for DRTM table.
Date: Thu, 21 May 2015 10:31:37 +0800
Message-ID: <f407007c5873762cb636dbca18fa2982511b48d6.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15834 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431AbbEUCb4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 May 2015 22:31:56 -0400
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit b02b754a2b7afcd0384cb3b31f29eb1be028fe90

This patch adds support for DRTM (Dynamic Root of Trust for Measurement
table) in iasl. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/b02b754a
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl3.h |   34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index e1aac82..4018986 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -119,6 +119,8 @@ struct acpi_table_bgrt {
 /*******************************************************************************
  *
  * DRTM - Dynamic Root of Trust for Measurement table
+ * Conforms to "TCG D-RTM Architecture" June 17 2013, Version 1.0.0
+ * Table version 1
  *
  ******************************************************************************/
 
@@ -135,22 +137,40 @@ struct acpi_table_drtm {
 	u32 flags;
 };
 
-/* 1) Validated Tables List */
+/* Flag Definitions for above */
 
-struct acpi_drtm_vtl_list {
-	u32 validated_table_list_count;
+#define ACPI_DRTM_ACCESS_ALLOWED            (1)
+#define ACPI_DRTM_ENABLE_GAP_CODE           (1<<1)
+#define ACPI_DRTM_INCOMPLETE_MEASUREMENTS   (1<<2)
+#define ACPI_DRTM_AUTHORITY_ORDER           (1<<3)
+
+/* 1) Validated Tables List (64-bit addresses) */
+
+struct acpi_drtm_vtable_list {
+	u32 validated_table_count;
+	u64 validated_tables[1];
 };
 
-/* 2) Resources List */
+/* 2) Resources List (of Resource Descriptors) */
+
+/* Resource Descriptor */
+
+struct acpi_drtm_resource {
+	u8 size[7];
+	u8 type;
+	u64 address;
+};
 
 struct acpi_drtm_resource_list {
-	u32 resource_list_count;
+	u32 resource_count;
+	struct acpi_drtm_resource resources[1];
 };
 
 /* 3) Platform-specific Identifiers List */
 
-struct acpi_drtm_id_list {
-	u32 id_list_count;
+struct acpi_drtm_dps_id {
+	u32 dps_id_length;
+	u8 dps_id[16];
 };
 
 /*******************************************************************************
-- 
1.7.10

