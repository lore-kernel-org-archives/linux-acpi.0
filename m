From: linucherian@gmail.com
Subject: [RFC PATCH 2/7] iommu/arm-smmu-v3: Do resource size checks based on smmu option PAGE0_REGS_ONLY
Date: Tue, 11 Apr 2017 20:12:40 +0530
Message-ID: <1491921765-29475-3-git-send-email-linucherian@gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34984 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbdDKOnV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Apr 2017 10:43:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so5541810pfa.2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Apr 2017 07:43:21 -0700 (PDT)
In-Reply-To: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com

From: Linu Cherian <linu.cherian@cavium.com>

With implementations supporting only page 0 of register space,
resource size can be 64k as well and hence perform size checks
based on smmu option PAGE0_REGS_ONLY.

For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
platform_get_resource call, so that smmu options are set beforehand.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
---
 drivers/iommu/arm-smmu-v3.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index df9f27b..b326195 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2669,6 +2669,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return ret;
 }
 
+static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
+{
+	if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
+		return SZ_64K;
+	else
+		return SZ_128K;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -2685,9 +2693,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	if (dev->of_node) {
+		ret = arm_smmu_device_dt_probe(pdev, smmu);
+	} else {
+		ret = arm_smmu_device_acpi_probe(pdev, smmu);
+		if (ret == -ENODEV)
+			return ret;
+	}
+
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) + 1 < SZ_128K) {
+	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
@@ -2714,14 +2730,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (irq > 0)
 		smmu->gerr_irq = irq;
 
-	if (dev->of_node) {
-		ret = arm_smmu_device_dt_probe(pdev, smmu);
-	} else {
-		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-		if (ret == -ENODEV)
-			return ret;
-	}
-
 	/* Set bypass mode according to firmware probing result */
 	bypass = !!ret;
 
-- 
1.9.1

