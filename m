From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/53] ACPICA: Tables: Add HMAT table definitions
Date: Mon,  5 Jun 2017 16:37:16 +0800
Message-ID: <278c0445732719260d456f9ef8d3adac214bcf45.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbdFEIhZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:37:25 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 3dae756631c8c2baddfa19f43a379aee42b28312

This patch adds unified HMAT table structure definitions so that ACPICA
users can develop HMAT related OS features based on the ACPICA standard
structures. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/3dae7566
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl1.h | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b4ce55c..49d5487 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -65,6 +65,7 @@
 #define ACPI_SIG_ECDT           "ECDT"	/* Embedded Controller Boot Resources Table */
 #define ACPI_SIG_EINJ           "EINJ"	/* Error Injection table */
 #define ACPI_SIG_ERST           "ERST"	/* Error Record Serialization Table */
+#define ACPI_SIG_HMAT           "HMAT"	/* Heterogeneous Memory Attributes Table */
 #define ACPI_SIG_HEST           "HEST"	/* Hardware Error Source Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
@@ -688,6 +689,122 @@ struct acpi_hest_generic_data_v300 {
 
 /*******************************************************************************
  *
+ * HMAT - Heterogeneous Memory Attributes Table (ACPI 6.2)
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_hmat {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 reserved;
+};
+
+/* Values for HMAT structure types */
+
+enum acpi_hmat_type {
+	ACPI_HMAT_TYPE_ADDRESS_RANGE = 0,	/* Memory subystem address range */
+	ACPI_HMAT_TYPE_LOCALITY = 1,	/* System locality latency and bandwidth information */
+	ACPI_HMAT_TYPE_CACHE = 2,	/* Memory side cache information */
+	ACPI_HMAT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
+};
+
+struct acpi_hmat_structure {
+	u16 type;
+	u16 reserved;
+	u32 length;
+};
+
+/*
+ * HMAT Structures, correspond to Type in struct acpi_hmat_structure
+ */
+
+/* 0: Memory subystem address range */
+
+struct acpi_hmat_address_range {
+	struct acpi_hmat_structure header;
+	u16 flags;
+	u16 reserved1;
+	u32 processor_PD;	/* Processor proximity domain */
+	u32 memory_PD;		/* Memory proximity domain */
+	u32 reserved2;
+	u64 physical_address_base;	/* Physical address range base */
+	u64 physical_address_length;	/* Physical address range length */
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_HMAT_PROCESSOR_PD_VALID    (1)	/* 1: processor_PD field is valid */
+#define ACPI_HMAT_MEMORY_PD_VALID       (1<<1)	/* 1: memory_PD field is valid */
+#define ACPI_HMAT_RESERVATION_HINT      (1<<2)	/* 1: Reservation hint */
+
+/* 1: System locality latency and bandwidth information */
+
+struct acpi_hmat_locality {
+	struct acpi_hmat_structure header;
+	u8 flags;
+	u8 data_type;
+	u16 reserved1;
+	u32 number_of_initiator_Pds;
+	u32 number_of_target_Pds;
+	u32 reserved2;
+	u64 entry_base_unit;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_HMAT_MEMORY_HIERARCHY  (0x0F)
+
+/* Values for Memory Hierarchy flag */
+
+#define ACPI_HMAT_MEMORY            0
+#define ACPI_HMAT_LAST_LEVEL_CACHE  1
+#define ACPI_HMAT_1ST_LEVEL_CACHE   2
+#define ACPI_HMAT_2ND_LEVEL_CACHE   3
+#define ACPI_HMAT_3RD_LEVEL_CACHE   4
+
+/* Values for data_type field above */
+
+#define ACPI_HMAT_ACCESS_LATENCY    0
+#define ACPI_HMAT_READ_LATENCY      1
+#define ACPI_HMAT_WRITE_LATENCY     2
+#define ACPI_HMAT_ACCESS_BANDWIDTH  3
+#define ACPI_HMAT_READ_BANDWIDTH    4
+#define ACPI_HMAT_WRITE_BANDWIDTH   5
+
+/* 2: Memory side cache information */
+
+struct acpi_hmat_cache {
+	struct acpi_hmat_structure header;
+	u32 memory_PD;
+	u32 reserved1;
+	u64 cache_size;
+	u32 cache_attributes;
+	u16 reserved2;
+	u16 number_of_SMBIOShandles;
+};
+
+/* Masks for cache_attributes field above */
+
+#define ACPI_HMAT_TOTAL_CACHE_LEVEL     (0x0000000F)
+#define ACPI_HMAT_CACHE_LEVEL           (0x000000F0)
+#define ACPI_HMAT_CACHE_ASSOCIATIVITY   (0x00000F00)
+#define ACPI_HMAT_WRITE_POLICY          (0x0000F000)
+#define ACPI_HMAT_CACHE_LINE_SIZE       (0xFFFF0000)
+
+/* Values for cache associativity flag */
+
+#define ACPI_HMAT_CA_NONE                     (0)
+#define ACPI_HMAT_CA_DIRECT_MAPPED            (1)
+#define ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING   (2)
+
+/* Values for write policy flag */
+
+#define ACPI_HMAT_CP_NONE   (0)
+#define ACPI_HMAT_CP_WB     (1)
+#define ACPI_HMAT_CP_WT     (2)
+
+/*******************************************************************************
+ *
  * MADT - Multiple APIC Description Table
  *        Version 3
  *
-- 
2.7.4

