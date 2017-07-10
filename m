From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/16] ACPICA: IORT: Update SMMU models for revision C
Date: Mon, 10 Jul 2017 15:22:51 +0800
Message-ID: <ffbfb9f6b101cbdea3c2abdeecca16a4087905a4.1499671181.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:6795 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdGJHW7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:22:59 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Bob Moore <robert.moore@intel.com>

From: Robin Murphy <robin.murphy@arm.com>

ACPICA commit d00a4eb86e64bb4fa70f57ab5e5ca0a4ca2ad8ef

IORT revision C has been published with a number of new SMMU
implementation identifiers; define them.

Link: https://github.com/acpica/acpica/commit/d00a4eb8
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 707dda74..5829eed 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -664,7 +664,7 @@ struct acpi_ibft_target {
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049B, October 2015
+ * Document number: ARM DEN 0049C, May 2017
  *
  ******************************************************************************/
 
@@ -779,6 +779,8 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_V2               0x00000001	/* Generic SMMUv2 */
 #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002	/* ARM Corelink MMU-400 */
 #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003	/* ARM Corelink MMU-500 */
+#define ACPI_IORT_SMMU_CORELINK_MMU401  0x00000004	/* ARM Corelink MMU-401 */
+#define ACPI_IORT_SMMU_CAVIUM_THUNDERX  0x00000005	/* Cavium thunder_x SMMUv2 */
 
 /* Masks for Flags field above */
 
@@ -799,13 +801,19 @@ struct acpi_iort_smmu_v3 {
 	u32 flags;
 	u32 reserved;
 	u64 vatos_address;
-	u32 model;		/* O: generic SMMUv3 */
+	u32 model;
 	u32 event_gsiv;
 	u32 pri_gsiv;
 	u32 gerr_gsiv;
 	u32 sync_gsiv;
 };
 
+/* Values for Model field above */
+
+#define ACPI_IORT_SMMU_V3_GENERIC           0x00000000	/* Generic SMMUv3 */
+#define ACPI_IORT_SMMU_V3_HISILICON_HI161X  0x00000001	/* hi_silicon Hi161x SMMUv3 */
+#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX     0x00000002	/* Cavium CN99xx SMMUv3 */
+
 /* Masks for Flags field above */
 
 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
-- 
2.7.4

