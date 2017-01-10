From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v12 4/7] arm: arm64: pmu: Assign platform PMU CPU affinity
Date: Tue, 10 Jan 2017 11:17:49 -0600
Message-ID: <1484068672-15852-5-git-send-email-jeremy.linton@arm.com>
References: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940644AbdAJRR4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Jan 2017 12:17:56 -0500
In-Reply-To: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, punit.agrawal@arm.com, steve.capper@arm.com, msalter@redhat.com, mlangsdorf@redhat.com, linux@armlinux.org.uk

On systems with multiple PMU types the PMU to CPU affinity
needs to be detected and set. The CPU to interrupt affinity
should also be set.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 6d93358..37e241f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt) "hw perfevents: " fmt
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -24,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/irq_regs.h>
 
@@ -889,25 +891,47 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 }
 
 /*
- * CPU PMU identification and probing.
+ * CPU PMU identification and probing. Its possible to have
+ * multiple CPU types in an ARM machine. Assure that we are
+ * picking the right PMU types based on the CPU in question
  */
-static int probe_current_pmu(struct arm_pmu *pmu,
-			     const struct pmu_probe_info *info)
+static int probe_plat_pmu(struct arm_pmu *pmu,
+			     const struct pmu_probe_info *info,
+			     unsigned int pmuid)
 {
-	int cpu = get_cpu();
-	unsigned int cpuid = read_cpuid_id();
 	int ret = -ENODEV;
+	int cpu;
+	int aff_ctr = 0;
+	struct platform_device *pdev = pmu->plat_device;
+	int irq = platform_get_irq(pdev, 0);
 
-	pr_info("probing PMU on CPU %d\n", cpu);
+	if (irq >= 0 && !irq_is_percpu(irq)) {
+		pmu->irq_affinity = kcalloc(pdev->num_resources, sizeof(int),
+					    GFP_KERNEL);
+		if (!pmu->irq_affinity)
+			return -ENOMEM;
+	}
+
+	for_each_possible_cpu(cpu) {
+		unsigned int cpuid = read_specific_cpuid(cpu);
+
+		if (cpuid == pmuid) {
+			cpumask_set_cpu(cpu, &pmu->supported_cpus);
+			if (pmu->irq_affinity) {
+				pmu->irq_affinity[aff_ctr] = cpu;
+				aff_ctr++;
+			}
+		}
+	}
 
+	/* find the type of PMU given the CPU */
 	for (; info->init != NULL; info++) {
-		if ((cpuid & info->mask) != info->cpuid)
+		if ((pmuid & info->mask) != info->cpuid)
 			continue;
 		ret = info->init(pmu);
 		break;
 	}
 
-	put_cpu();
 	return ret;
 }
 
@@ -1043,8 +1067,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		if (!ret)
 			ret = init_fn(pmu);
 	} else if (probe_table) {
-		cpumask_setall(&pmu->supported_cpus);
-		ret = probe_current_pmu(pmu, probe_table);
+		ret = probe_plat_pmu(pmu, probe_table, read_cpuid_id());
 	}
 
 	if (ret) {
-- 
2.5.5

