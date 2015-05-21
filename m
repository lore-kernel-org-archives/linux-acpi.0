From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/19] ACPICA: ACPI 6.0: Add support for IORT table.
Date: Thu, 21 May 2015 10:31:30 +0800
Message-ID: <6c46dcce62c3e70859aab0f69aea6435b29c979d.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 5de82757aef5d6163e37064033aacbce193abbca

This patch adds support for IORT (IO Remapping Table) in iasl.

Note that some field names are modified to shrink their length or the
decompiled IORT ASL will contain fields with ugly ":" alignment.

The IORT contains field definitions around "Memory Access Properties". This
patch also adds support to encode/decode it using inline table.

This patch doesn't add inline table support for the SMMU interrupt fields
due to a limitation in current ACPICA data table support. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/5de82757
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h |  126 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 93f85e8..370d69d 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -69,6 +69,7 @@
 #define ACPI_SIG_DMAR           "DMAR"	/* DMA Remapping table */
 #define ACPI_SIG_HPET           "HPET"	/* High Precision Event Timer table */
 #define ACPI_SIG_IBFT           "IBFT"	/* iSCSI Boot Firmware Table */
+#define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
@@ -650,6 +651,131 @@ struct acpi_ibft_target {
 
 /*******************************************************************************
  *
+ * IORT - IO Remapping Table
+ *
+ * Conforms to "IO Remapping Table System Software on ARM Platforms",
+ * Document number: ARM DEN 0049A, 2015
+ *
+ ******************************************************************************/
+
+struct acpi_table_iort {
+	struct acpi_table_header header;
+	u32 node_count;
+	u32 node_offset;
+	u32 reserved;
+};
+
+/*
+ * IORT subtables
+ */
+struct acpi_iort_node {
+	u8 type;
+	u16 length;
+	u8 revision;
+	u32 reserved;
+	u32 mapping_count;
+	u32 mapping_offset;
+	char node_data[1];
+};
+
+/* Values for subtable Type above */
+
+enum acpi_iort_node_type {
+	ACPI_IORT_NODE_ITS_GROUP = 0x00,
+	ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
+	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
+	ACPI_IORT_NODE_SMMU = 0x03
+};
+
+struct acpi_iort_id_mapping {
+	u32 input_base;		/* Lowest value in input range */
+	u32 id_count;		/* Number of IDs */
+	u32 output_base;	/* Lowest value in output range */
+	u32 output_reference;	/* A reference to the output node */
+	u32 flags;
+};
+
+/* Masks for Flags field above for IORT subtable */
+
+#define ACPI_IORT_ID_SINGLE_MAPPING (1)
+
+struct acpi_iort_memory_access {
+	u32 cache_coherency;
+	u8 hints;
+	u16 reserved;
+	u8 memory_flags;
+};
+
+/* Values for cache_coherency field above */
+
+#define ACPI_IORT_NODE_COHERENT         0x00000001	/* The device node is fully coherent */
+#define ACPI_IORT_NODE_NOT_COHERENT     0x00000000	/* The device node is not coherent */
+
+/* Masks for Hints field above */
+
+#define ACPI_IORT_HT_TRANSIENT          (1)
+#define ACPI_IORT_HT_WRITE              (1<<1)
+#define ACPI_IORT_HT_READ               (1<<2)
+#define ACPI_IORT_HT_OVERRIDE           (1<<3)
+
+/* Masks for memory_flags field above */
+
+#define ACPI_IORT_MF_COHERENCY          (1)
+#define ACPI_IORT_MF_ATTRIBUTES         (1<<1)
+
+/*
+ * IORT node specific subtables
+ */
+struct acpi_iort_its_group {
+	u32 its_count;
+	u32 identifiers[1];	/* GIC ITS identifier arrary */
+};
+
+struct acpi_iort_named_component {
+	u32 node_flags;
+	u64 memory_properties;	/* Memory access properties */
+	u8 memory_address_limit;	/* Memory address size limit */
+	char device_name[1];	/* Path of namespace object */
+};
+
+struct acpi_iort_root_complex {
+	u64 memory_properties;	/* Memory access properties */
+	u32 ats_attribute;
+	u32 pci_segment_number;
+};
+
+/* Values for ats_attribute field above */
+
+#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root complex supports ATS */
+#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root complex doesn't support ATS */
+
+struct acpi_iort_smmu {
+	u64 base_address;	/* SMMU base address */
+	u64 span;		/* Length of memory range */
+	u32 model;
+	u32 flags;
+	u32 global_interrupt_offset;
+	u32 context_interrupt_count;
+	u32 context_interrupt_offset;
+	u32 pmu_interrupt_count;
+	u32 pmu_interrupt_offset;
+	u64 interrupts[1];	/* Interrupt array */
+};
+
+/* Values for Model field above */
+
+#define ACPI_IORT_SMMU_V1               0x00000000	/* Generic SMMUv1 */
+#define ACPI_IORT_SMMU_V2               0x00000001	/* Generic SMMUv2 */
+#define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002	/* ARM Corelink MMU-400 */
+#define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003	/* ARM Corelink MMU-500 */
+
+/* Masks for Flags field above */
+
+#define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
+#define ACPI_IORT_SMMU_COHERENT_WALK    (1<<1)
+
+/*******************************************************************************
+ *
  * IVRS - I/O Virtualization Reporting Structure
  *        Version 1
  *
-- 
1.7.10
