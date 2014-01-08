From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/21] ACPICA: Tables: Add full support for the PCCT table, update table definition.
Date: Wed,  8 Jan 2014 13:43:57 +0800
Message-ID: <0c863dbd5944d4ebc07b662caf88c0856574116b.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11476 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFoH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:07 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Updates the PCCT table definition in the actbl3.h header.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index e2c0931..01c2a90 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -374,16 +374,22 @@ struct acpi_mpst_shared {
 struct acpi_table_pcct {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u32 flags;
-	u32 latency;
-	u32 reserved;
+	u64 reserved;
 };
 
 /* Values for Flags field above */
 
 #define ACPI_PCCT_DOORBELL              1
 
+/* Values for subtable type in struct acpi_subtable_header */
+
+enum acpi_pcct_type {
+	ACPI_PCCT_TYPE_GENERIC_SUBSPACE = 0,
+	ACPI_PCCT_TYPE_RESERVED = 1	/* 1 and greater are reserved */
+};
+
 /*
- * PCCT subtables
+ * PCCT Subtables, correspond to Type in struct acpi_subtable_header
  */
 
 /* 0: Generic Communications Subspace */
@@ -396,6 +402,9 @@ struct acpi_pcct_subspace {
 	struct acpi_generic_address doorbell_register;
 	u64 preserve_mask;
 	u64 write_mask;
+	u32 latency;
+	u32 max_access_rate;
+	u16 min_turnaround_time;
 };
 
 /*
-- 
1.7.10

