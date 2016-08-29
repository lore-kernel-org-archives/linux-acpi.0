From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 1/9] arm64: pmu: add fallback probe table
Date: Mon, 29 Aug 2016 16:48:12 -0500
Message-ID: <1472507300-9844-2-git-send-email-jeremy.linton@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756856AbcH2Vs2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Aug 2016 17:48:28 -0400
In-Reply-To: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, will.deacon@arm.com, punit.agrawal@arm.com, linux-acpi@vger.kernel.org, mlangsdorf@redhat.com, steve.capper@arm.com

From: Mark Salter <msalter@redhat.com>

In preparation for ACPI support, add a pmu_probe_info table to
the arm_pmu_device_probe() call. This table gets used when
probing in the absence of a devicetree node for PMU.

Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/perf_event.c | 13 ++++++++++++-
 drivers/perf/arm_pmu.c         |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 838ccf1..3aac598 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -24,6 +24,7 @@
 #include <asm/sysreg.h>
 #include <asm/virt.h>
 
+#include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
@@ -1044,9 +1045,19 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{},
 };
 
+static const struct pmu_probe_info armv8_pmu_probe_table[] = {
+	PMU_PROBE(0, 0, armv8_pmuv3_init), /* if all else fails... */
+	{ /* sentinel value */ }
+};
+
 static int armv8_pmu_device_probe(struct platform_device *pdev)
 {
-	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids, NULL);
+	if (acpi_disabled)
+		return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids,
+					    NULL);
+
+	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids,
+				    armv8_pmu_probe_table);
 }
 
 static struct platform_driver armv8_pmu_driver = {
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index c494613..f1aee26 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1028,7 +1028,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		ret = of_pmu_irq_cfg(pmu);
 		if (!ret)
 			ret = init_fn(pmu);
-	} else {
+	} else if (probe_table) {
 		cpumask_setall(&pmu->supported_cpus);
 		ret = probe_current_pmu(pmu, probe_table);
 	}
-- 
2.5.5

