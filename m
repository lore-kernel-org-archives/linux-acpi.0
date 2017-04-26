From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/15] ACPICA: iasl: Fix IORT SMMU GSI disassembling
Date: Wed, 26 Apr 2017 16:18:49 +0800
Message-ID: <63b0875a5374260513152f35d1d85fc32b4cdf25.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:15031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952817AbdDZISx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:53 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

ACPICA commit 637b88de24a78c20478728d9d66632b06fcaa5bf

If the IORT template is compiled and then iort.aml binary disassembled to
iort.dsl, SMMUv1 node lists incorrect offset for SMMU_Nsg_cfg_irpt Interrupt:
[0ECh 0236   8]       SMMU_Nsg_irpt Interrupt : 0000000000000000
[0ECh 0236   8]    SMMU_Nsg_cfg_irpt Interrupt : 0000000000000000
This is because iasl hasn't implemented SMMU GSI decoding yet.

This patch fixes this issue by preparing structures for decoding IORT SMMU
GSI. ACPICA BZ 1340, reported by Alexei Fedorov, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/637b88de
Link: https://bugs.acpica.org/show_bug.cgi?id=1340
Reported-by: Alexei Fedorov <Alexei.Fedorov@arm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 7aee9fb..83666cb 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -783,6 +783,15 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
 #define ACPI_IORT_SMMU_COHERENT_WALK    (1<<1)
 
+/* Global interrupt format */
+
+struct acpi_iort_smmu_gsi {
+	u32 nsg_irpt;
+	u32 nsg_irpt_flags;
+	u32 nsg_cfg_irpt;
+	u32 nsg_cfg_irpt_flags;
+};
+
 struct acpi_iort_smmu_v3 {
 	u64 base_address;	/* SMMUv3 base address */
 	u32 flags;
-- 
2.7.4

