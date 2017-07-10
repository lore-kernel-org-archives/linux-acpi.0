From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/16] ACPICA: iasl: Update to IORT SMMUv3 disassembling
Date: Mon, 10 Jul 2017 15:24:15 +0800
Message-ID: <0c3d2dee0cb7c9727d207d4d353ecf1a6a69782a.1499671182.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:6895 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbdGJHYY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:24:24 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Bob Moore <robert.moore@intel.com>

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

ACPICA commit 8cadc4fb500e2aa52241e367c87a0f95d9760c58

ARM IORT specification has provision to define Proximity domain
in SMMUv3 IORT table. Adding required changes to decode
Proximity domain of SMMUv3 IORT table.

Link: https://github.com/acpica/acpica/commit/8cadc4fb
Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 5829eed..d568948 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -806,6 +806,9 @@ struct acpi_iort_smmu_v3 {
 	u32 pri_gsiv;
 	u32 gerr_gsiv;
 	u32 sync_gsiv;
+	u8 pxm;
+	u8 reserved1;
+	u16 reserved2;
 };
 
 /* Values for Model field above */
@@ -818,6 +821,7 @@ struct acpi_iort_smmu_v3 {
 
 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
 #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
+#define ACPI_IORT_SMMU_V3_PXM_VALID         (1<<3)
 
 /*******************************************************************************
  *
-- 
2.7.4

