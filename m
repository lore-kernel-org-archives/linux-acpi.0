From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/53] ACPICA: Add support for new HEST subtable
Date: Mon,  5 Jun 2017 16:38:41 +0800
Message-ID: <04546fb1ef3b9691c21b0a8e51d54095ba97c8a0.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15699 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbdFEIio (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:44 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a1f1056c9e44fd3de8cad3bde89cda5cbb2df466

IA-32 Deferred Machine Check (ACPI 6.2)

Link: https://github.com/acpica/acpica/commit/a1f1056c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 0673120..171fc51 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -432,7 +432,8 @@ enum acpi_hest_types {
 	ACPI_HEST_TYPE_AER_BRIDGE = 8,
 	ACPI_HEST_TYPE_GENERIC_ERROR = 9,
 	ACPI_HEST_TYPE_GENERIC_ERROR_V2 = 10,
-	ACPI_HEST_TYPE_RESERVED = 11	/* 11 and greater are reserved */
+	ACPI_HEST_TYPE_IA32_DEFERRED_CHECK = 11,
+	ACPI_HEST_TYPE_RESERVED = 12	/* 12 and greater are reserved */
 };
 
 /*
@@ -538,7 +539,7 @@ enum acpi_hest_notify_types {
 struct acpi_hest_ia_machine_check {
 	struct acpi_hest_header header;
 	u16 reserved1;
-	u8 flags;
+	u8 flags;		/* See flags ACPI_HEST_GLOBAL, etc. above */
 	u8 enabled;
 	u32 records_to_preallocate;
 	u32 max_sections_per_record;
@@ -553,7 +554,7 @@ struct acpi_hest_ia_machine_check {
 struct acpi_hest_ia_corrected {
 	struct acpi_hest_header header;
 	u16 reserved1;
-	u8 flags;
+	u8 flags;		/* See flags ACPI_HEST_GLOBAL, etc. above */
 	u8 enabled;
 	u32 records_to_preallocate;
 	u32 max_sections_per_record;
@@ -690,6 +691,20 @@ struct acpi_hest_generic_data_v300 {
 #define ACPI_HEST_GEN_VALID_FRU_STRING      (1<<1)
 #define ACPI_HEST_GEN_VALID_TIMESTAMP       (1<<2)
 
+/* 11: IA32 Deferred Machine Check Exception (ACPI 6.2) */
+
+struct acpi_hest_ia_deferred_check {
+	struct acpi_hest_header header;
+	u16 reserved1;
+	u8 flags;		/* See flags ACPI_HEST_GLOBAL, etc. above */
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	struct acpi_hest_notify notify;
+	u8 num_hardware_banks;
+	u8 reserved2[3];
+};
+
 /*******************************************************************************
  *
  * HMAT - Heterogeneous Memory Attributes Table (ACPI 6.2)
-- 
2.7.4

