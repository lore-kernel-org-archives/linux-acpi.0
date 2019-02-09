From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date: Fri,  8 Feb 2019 18:47:17 -0600
Message-ID: <20190209004718.3292087-3-jeremy.linton@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190209004718.3292087-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-acpi@vger.kernel.org

ACPI 6.3 adds additional fields to the MADT GICC
structure to describe SPE PPI's. We pick these out
of the cached reference to the madt_gicc structure
similarly to the core PMU code. We then create a platform
device referring to the IRQ and let the user/module loader
decide whether to load the SPE driver.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/perf/arm_pmu_acpi.c   | 67 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 2def77ec14be..f9f9f2eb5d54 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -40,6 +40,9 @@
 	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
 	(unsigned long)(entry) + (entry)->header.length > (end))
 
+#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
+	spe_overflow_interrupt) + sizeof(u16))
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0f197516d708..725d413b47dc 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -74,6 +74,71 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 	acpi_unregister_gsi(gsi);
 }
 
+static struct resource spe_resources[] = {
+	{
+		/* irq */
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device spe_dev = {
+	.name = "arm,spe-v1",
+	.id = -1,
+	.resource = spe_resources,
+	.num_resources = ARRAY_SIZE(spe_resources)
+};
+
+/*
+ * For lack of a better place, hook the normal PMU MADT walk
+ * and create a SPE device if we detect a recent MADT with
+ * a homogeneous PPI mapping.
+ */
+static int arm_spe_acpi_parse_irqs(void)
+{
+	int cpu, ret, irq;
+	u16 gsi = 0;
+	bool first = true;
+
+	struct acpi_madt_generic_interrupt *gicc;
+
+	/*
+	 * sanity check all the GICC tables for the same interrupt number
+	 * for now we only support homogeneous ACPI/SPE machines.
+	 */
+	for_each_possible_cpu(cpu) {
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+
+		if (gicc->header.length < ACPI_MADT_GICC_SPE)
+			return -ENODEV;
+
+		if (first) {
+			gsi = gicc->spe_overflow_interrupt;
+			if (!gsi)
+				return -ENODEV;
+			first = false;
+		} else if (gsi != gicc->spe_overflow_interrupt) {
+			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
+			return -EINVAL;
+		}
+	}
+
+	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
+				ACPI_ACTIVE_HIGH);
+	if (irq < 0) {
+		pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
+		return irq;
+	}
+
+	spe_resources[0].start = irq;
+	ret = platform_device_register(&spe_dev);
+	if (ret < 0) {
+		pr_warn("ACPI: SPE: Unable to register device\n");
+		acpi_unregister_gsi(gsi);
+	}
+
+	return ret;
+}
+
 static int arm_pmu_acpi_parse_irqs(void)
 {
 	int irq, cpu, irq_cpu, err;
@@ -279,6 +344,8 @@ static int arm_pmu_acpi_init(void)
 	if (acpi_disabled)
 		return 0;
 
+	arm_spe_acpi_parse_irqs(); /* failures are expected */
+
 	ret = arm_pmu_acpi_parse_irqs();
 	if (ret)
 		return ret;
-- 
2.17.2
