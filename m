From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 3/8] gicv2m: Convert to use GIC irq_domain_ops.init_alloc_info
Date: Mon, 13 Jul 2015 16:14:19 +0700
Message-ID: <1436778864-17645-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0120.outbound.protection.outlook.com ([65.55.169.120]:10176
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751892AbbGMJPa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Jul 2015 05:15:30 -0400
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org
Cc: rjw@rjwysocki.net, al.stone@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, msalter@redhat.com, grant.likely@linaro.org, leo.duran@amd.com, sherry.hurwitz@amd.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch converts the current call to irq_domain_alloc_irqs_parent()
to use structure initilized by irq_domain_ops.init_alloc_info()
instead of of_phandle_args.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic-v2m.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index bf5082d..e4e2a92 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -22,6 +22,10 @@
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/irqchip/arm-gic.h>
+#ifdef CONFIG_ARM_GIC_ACPI
+#include <linux/irqchip/arm-gic-acpi.h>
+#endif
 
 /*
 * MSI_TYPER:
@@ -114,17 +118,20 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 				       unsigned int virq,
 				       irq_hw_number_t hwirq)
 {
-	struct of_phandle_args args;
 	struct irq_data *d;
 	int err;
+	void *info;
+	struct irq_domain *parent = domain->parent;
+	uint32_t data[3] = {GIC_INT_TYPE_GSI, hwirq, IRQ_TYPE_EDGE_RISING};
+
+	if (parent->ops->init_alloc_info) {
+		err = parent->ops->init_alloc_info(data, 3, parent->of_node,
+						   &info);
+		if (err)
+			return err;
+	}
 
-	args.np = domain->parent->of_node;
-	args.args_count = 3;
-	args.args[0] = 0;
-	args.args[1] = hwirq - 32;
-	args.args[2] = IRQ_TYPE_EDGE_RISING;
-
-	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &args);
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, info);
 	if (err)
 		return err;
 
-- 
2.1.0

