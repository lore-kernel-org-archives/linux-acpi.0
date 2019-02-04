From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v6 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum 162001800 quirk
Date: Mon, 4 Feb 2019 12:13:24 +0000
Message-ID: <20190204121324.11460-5-shameerali.kolothum.thodi@huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, robin.murphy@arm.com
Cc: andrew.murray@arm.com, jean-philippe.brucker@arm.com, will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com, pabba@codeaurora.org, vkilari@codeaurora.org, rruigrok@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, neil.m.leeder@gmail.com
List-Id: linux-acpi@vger.kernel.org

HiSilicon erratum 162001800 describes the limitation of
SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.

On these platforms, the PMCG event counter registers
(SMMU_PMCG_EVCNTRn) are read only and as a result it
is not possible to set the initial counter period value
on event monitor start.

To work around this, the current value of the counter
is read and used for delta calculations. OEM information
from ACPI header is used to identify the affected hardware
platforms.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
 drivers/perf/arm_smmuv3_pmu.c | 48 ++++++++++++++++++++++++++++++++++++-------
 include/linux/acpi_iort.h     |  1 +
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e2c9b26..4dc68de 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1366,9 +1366,23 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 				       ACPI_EDGE_SENSITIVE, &res[2]);
 }
 
+static struct acpi_platform_list pmcg_plat_info[] __initdata = {
+	/* HiSilicon Hip08 Platform */
+	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal, 0,
+	 IORT_SMMU_V3_PMCG_HISI_HIP08},
+	{ }
+};
+
 static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
 {
-	u32 model = IORT_SMMU_V3_PMCG_GENERIC;
+	u32 model;
+	int idx;
+
+	idx = acpi_match_platform_list(pmcg_plat_info);
+	if (idx >= 0)
+		model = pmcg_plat_info[idx].data;
+	else
+		model = IORT_SMMU_V3_PMCG_GENERIC;
 
 	return platform_device_add_data(pdev, &model, sizeof(model));
 }
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index eeb9dee..95a3ed0 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -35,6 +35,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cpuhotplug.h>
@@ -93,6 +94,8 @@
 
 #define SMMU_PMCG_PA_SHIFT              12
 
+#define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+
 static int cpuhp_state_num;
 
 struct smmu_pmu {
@@ -107,6 +110,7 @@ struct smmu_pmu {
 	struct device *dev;
 	void __iomem *reg_base;
 	void __iomem *reloc_base;
+	u32 options;
 	u64 counter_mask;
 	bool global_filter;
 	u32 global_filter_span;
@@ -222,15 +226,27 @@ static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
 	u32 idx = hwc->idx;
 	u64 new;
 
-	/*
-	 * We limit the max period to half the max counter value of the counter
-	 * size, so that even in the case of extreme interrupt latency the
-	 * counter will (hopefully) not wrap past its initial value.
-	 */
-	new = smmu_pmu->counter_mask >> 1;
+	if (smmu_pmu->options & SMMU_PMCG_EVCNTR_RDONLY) {
+		/*
+		 * On platforms that require this quirk, if the counter starts
+		 * at < half_counter value and wraps, the current logic of
+		 * handling the overflow may not work. It is expected that,
+		 * those platforms will have full 64 counter bits implemented
+		 * so that such a possibility is remote(eg: HiSilicon HIP08).
+		 */
+		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
+	} else {
+		/*
+		 * We limit the max period to half the max counter value
+		 * of the counter size, so that even in the case of extreme
+		 * interrupt latency the counter will (hopefully) not wrap
+		 * past its initial value.
+		 */
+		new = smmu_pmu->counter_mask >> 1;
+		smmu_pmu_counter_set_value(smmu_pmu, idx, new);
+	}
 
 	local64_set(&hwc->prev_count, new);
-	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
 }
 
 static void smmu_pmu_set_event_filter(struct perf_event *event,
@@ -674,6 +690,22 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
 		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
 }
 
+static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
+{
+	u32 model;
+
+	model = *(u32 *)dev_get_platdata(smmu_pmu->dev);
+
+	switch (model) {
+	case IORT_SMMU_V3_PMCG_HISI_HIP08:
+		/* HiSilicon Erratum 162001800 */
+		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
+		break;
+	}
+
+	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
+}
+
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
@@ -752,6 +784,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	smmu_pmu_get_acpi_options(smmu_pmu);
+
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = get_cpu();
 	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 832bd6a..bdb6912 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -31,6 +31,7 @@
  * that, this is not part of the IORT specification.
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
-- 
2.7.4
