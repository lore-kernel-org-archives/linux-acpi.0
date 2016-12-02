From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v11 4/7] arm: arm64: pmu: Assign platform PMU CPU affinity
Date: Fri,  2 Dec 2016 12:55:58 -0600
Message-ID: <1480704961-6910-5-git-send-email-jeremy.linton@arm.com>
References: <1480704961-6910-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1480704961-6910-1-git-send-email-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, msalter@redhat.com
List-Id: linux-acpi@vger.kernel.org

On systems with multiple PMU types the PMU to CPU affinity
needs to be detected and set. The CPU to interrupt affinity
should also be set.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_pmu.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index b37b572..00e98c5 100644
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
