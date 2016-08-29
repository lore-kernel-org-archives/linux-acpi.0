From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 3/9] arm64: pmu: Hoist pmu platform device name
Date: Mon, 29 Aug 2016 16:48:14 -0500
Message-ID: <1472507300-9844-4-git-send-email-jeremy.linton@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756417AbcH2VsZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Aug 2016 17:48:25 -0400
In-Reply-To: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, will.deacon@arm.com, punit.agrawal@arm.com, linux-acpi@vger.kernel.org, mlangsdorf@redhat.com, steve.capper@arm.com

Move the PMU name into a common header file so it may
be referenced by other users.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 include/linux/perf/arm_pmu.h   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f650548..356fa6c 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1099,7 +1099,7 @@ static int armv8_pmu_device_probe(struct platform_device *pdev)
 
 static struct platform_driver armv8_pmu_driver = {
 	.driver		= {
-		.name	= "armv8-pmu",
+		.name	= ARMV8_PMU_PDEV_NAME,
 		.of_match_table = armv8_pmu_of_device_ids,
 	},
 	.probe		= armv8_pmu_device_probe,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index e188438..eab9014 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -151,6 +151,8 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
 
+#define ARMV8_PMU_PDEV_NAME "armv8-pmu"
+
 #endif /* CONFIG_ARM_PMU */
 
 #endif /* __ARM_PMU_H__ */
-- 
2.5.5

