From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 5/8] irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
Date: Fri, 10 Jul 2015 18:45:11 +0800
Message-ID: <1436525114-14425-6-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33086 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbbGJKqG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2015 06:46:06 -0400
Received: by padck2 with SMTP id ck2so2250245pad.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2015 03:46:06 -0700 (PDT)
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Isolate hardware abstraction (FDT) code to gic_of_init().
Rest of the logic goes to gic_init_bases() and expects well
defined data to initialize GIC properly. The same solution
is used for GICv2 driver.

This is needed for ACPI initialization later.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 105 +++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 44 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c52f7ba..aeba1cc 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -766,17 +766,69 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.free = gic_irq_domain_free,
 };
 
+static int __init gic_init_bases(void __iomem *dist_base,
+			    struct redist_region *rdist_regs,
+			    u32 nr_redist_regions,
+			    u64 redist_stride,
+			    struct device_node *node)
+{
+	u32 typer;
+	int gic_irqs;
+	int err;
+
+	gic_data.dist_base = dist_base;
+	gic_data.redist_regions = rdist_regs;
+	gic_data.nr_redist_regions = nr_redist_regions;
+	gic_data.redist_stride = redist_stride;
+
+	/*
+	 * Find out how many interrupts are supported.
+	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
+	 */
+	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
+	gic_data.rdists.id_bits = GICD_TYPER_ID_BITS(typer);
+	gic_irqs = GICD_TYPER_IRQS(typer);
+	if (gic_irqs > 1020)
+		gic_irqs = 1020;
+	gic_data.irq_nr = gic_irqs;
+
+	gic_data.domain = irq_domain_add_tree(node, &gic_irq_domain_ops,
+					      &gic_data);
+	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
+
+	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	set_handle_irq(gic_handle_irq);
+
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
+		its_init(node, &gic_data.rdists, gic_data.domain);
+
+	gic_smp_init();
+	gic_dist_init();
+	gic_cpu_init();
+	gic_cpu_pm_init();
+
+	return 0;
+
+out_free:
+	if (gic_data.domain)
+		irq_domain_remove(gic_data.domain);
+	free_percpu(gic_data.rdists.rdist);
+	return err;
+}
+
+#ifdef CONFIG_OF
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
 	u64 redist_stride;
 	u32 nr_redist_regions;
-	u32 typer;
 	u32 reg;
-	int gic_irqs;
-	int err;
-	int i;
+	int err, i;
 
 	dist_base = of_iomap(node, 0);
 	if (!dist_base) {
@@ -820,47 +872,11 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
 		redist_stride = 0;
 
-	gic_data.dist_base = dist_base;
-	gic_data.redist_regions = rdist_regs;
-	gic_data.nr_redist_regions = nr_redist_regions;
-	gic_data.redist_stride = redist_stride;
-
-	/*
-	 * Find out how many interrupts are supported.
-	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
-	 */
-	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
-	gic_data.rdists.id_bits = GICD_TYPER_ID_BITS(typer);
-	gic_irqs = GICD_TYPER_IRQS(typer);
-	if (gic_irqs > 1020)
-		gic_irqs = 1020;
-	gic_data.irq_nr = gic_irqs;
+	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
+			     redist_stride, node);
+	if (!err)
+		return 0;
 
-	gic_data.domain = irq_domain_add_tree(node, &gic_irq_domain_ops,
-					      &gic_data);
-	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
-
-	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-
-	set_handle_irq(gic_handle_irq);
-
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_init(node, &gic_data.rdists, gic_data.domain);
-
-	gic_smp_init();
-	gic_dist_init();
-	gic_cpu_init();
-	gic_cpu_pm_init();
-
-	return 0;
-
-out_free:
-	if (gic_data.domain)
-		irq_domain_remove(gic_data.domain);
-	free_percpu(gic_data.rdists.rdist);
 out_unmap_rdist:
 	for (i = 0; i < nr_redist_regions; i++)
 		if (rdist_regs[i].redist_base)
@@ -872,3 +888,4 @@ out_unmap_dist:
 }
 
 IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
+#endif
-- 
1.9.1

