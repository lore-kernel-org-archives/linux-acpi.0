From: linucherian@gmail.com
Subject: [RFC PATCH 4/7] ACPICA: IORT: Add SMMuV3 model definitions.
Date: Tue, 11 Apr 2017 20:12:42 +0530
Message-ID: <1491921765-29475-5-git-send-email-linucherian@gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34029 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbdDKOnc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Apr 2017 10:43:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id o123so30404851pga.1
        for <linux-acpi@vger.kernel.org>; Tue, 11 Apr 2017 07:43:32 -0700 (PDT)
In-Reply-To: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com

From: Linu Cherian <linu.cherian@cavium.com>

Add SMMuV3 model definitions.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
---
 include/acpi/actbl2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2b4af07..9db67d6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -778,6 +778,11 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002	/* ARM Corelink MMU-400 */
 #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003	/* ARM Corelink MMU-500 */
 
+#define ACPI_IORT_SMMU_V3               0x00000000      /* Generic SMMUv3 */
+#define ACPI_IORT_SMMU_CORELINK_MMU600  0x00000001      /* ARM Corelink MMU-600 */
+#define ACPI_IORT_SMMU_V3_HISILICON     0x00000002      /* HiSilicon SMMUv3 */
+#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000003      /* Cavium CN99xx SMMUv3 */
+
 /* Masks for Flags field above */
 
 #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
-- 
1.9.1

