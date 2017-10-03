From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/3] ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID guard
Date: Tue,  3 Oct 2017 14:53:29 +0100
Message-ID: <1507038811-23382-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdJCNu7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Oct 2017 09:50:59 -0400
In-Reply-To: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

The conditional ACPI_IORT_SMMU_V3_PXM_VALID guard around
arm_smmu_v3_set_proximity() was added to manage a cross tree
ACPICA merge dependency; with ACPICA changes merged in:

commit c944230064eb ("ACPICA: iasl: Update to IORT SMMUv3
disassembling")

the guard has become useless. Remove it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index de56394..69f21f3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,7 +968,7 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
 }
 
-#if defined(CONFIG_ACPI_NUMA) && defined(ACPI_IORT_SMMU_V3_PXM_VALID)
+#if defined(CONFIG_ACPI_NUMA)
 /*
  * set numa proximity domain for smmuv3 device
  */
-- 
2.4.12

