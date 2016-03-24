From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/30] ACPICA: IORT: Add in support for the SMMUv3 subtable
Date: Thu, 24 Mar 2016 09:39:07 +0800
Message-ID: <d4b1769e1cf64057817db6329c9dce009292a640.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Al Stone <ahs3@redhat.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Al Stone <ahs3@redhat.com>

ACPICA commit 9f7c3e148f440049615e2791d73b292f65692d7e

The most recent version of the IORT specification adds in a definition
for a subtable to describe SMMUv3 devices; there is already a subtable
for SMMUv1/v2 devices.

Add in the definition of the subtable, add in the code to compile it,
and add in a template for it.

Link: https://github.com/acpica/acpica/commit/9f7c3e14
Signed-off-by: Al Stone <ahs3@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e9d3cc1..d6bd377 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -660,7 +660,7 @@ struct acpi_ibft_target {
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049A, 2015
+ * Document number: ARM DEN 0049B, October 2015
  *
  ******************************************************************************/
 
@@ -690,7 +690,8 @@ enum acpi_iort_node_type {
 	ACPI_IORT_NODE_ITS_GROUP = 0x00,
 	ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
 	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
-	ACPI_IORT_NODE_SMMU = 0x03
+	ACPI_IORT_NODE_SMMU = 0x03,
+	ACPI_IORT_NODE_SMMU_V3 = 0x04
 };
 
 struct acpi_iort_id_mapping {
@@ -780,6 +781,23 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
 #define ACPI_IORT_SMMU_COHERENT_WALK    (1<<1)
 
+struct acpi_iort_smmu_v3 {
+	u64 base_address;	/* SMMUv3 base address */
+	u32 flags;
+	u32 reserved;
+	u64 vatos_address;
+	u32 model;		/* O: generic SMMUv3 */
+	u32 event_gsiv;
+	u32 pri_gsiv;
+	u32 gerr_gsiv;
+	u32 sync_gsiv;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
+#define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
+
 /*******************************************************************************
  *
  * IVRS - I/O Virtualization Reporting Structure
-- 
1.7.10
