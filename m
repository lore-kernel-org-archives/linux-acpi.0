From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 06/16] irqdomain: Introduce irq_create_fwspec_mapping
Date: Tue,  6 Oct 2015 18:36:19 +0100
Message-ID: <1444152989-31726-7-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Jake Oshins <jakeo@microsoft.com>, Graeme Gregory <graeme@xora.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Just like we have irq_create_of_mapping, irq_create_fwspec_mapping
creates a IRQ domain mapping for an interrupt described in a
struct irq_fwspec.

irq_create_of_mapping gets rewritten in terms of the new function,
and the hack we introduced before gets removed (now that no stacked
irqchip uses of_phandle_args anymore).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h |  1 +
 kernel/irq/irqdomain.c    | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 533c974..7e7842e 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -267,6 +267,7 @@ extern void irq_domain_disassociate(struct irq_domain *domain,
 
 extern unsigned int irq_create_mapping(struct irq_domain *host,
 				       irq_hw_number_t hwirq);
+extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 extern void irq_dispose_mapping(unsigned int virq);
 
 /**
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3f07055..2adc84e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -514,37 +514,28 @@ static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
 		fwspec->param[i] = irq_data->args[i];
 }
 
-unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
+unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 {
-	struct irq_fwspec fwspec;
 	struct irq_domain *domain;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	int virq;
 
-	of_phandle_args_to_fwspec(irq_data, &fwspec);
-
-	if (fwspec.fwnode)
-		domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
+	if (fwspec->fwnode)
+		domain = irq_find_matching_fwnode(fwspec->fwnode, DOMAIN_BUS_ANY);
 	else
 		domain = irq_default_domain;
 
 	if (!domain) {
 		pr_warn("no irq domain found for %s !\n",
-			of_node_full_name(to_of_node(fwspec.fwnode)));
+			of_node_full_name(to_of_node(fwspec->fwnode)));
 		return 0;
 	}
 
-	if (irq_domain_translate(domain, &fwspec, &hwirq, &type))
+	if (irq_domain_translate(domain, fwspec, &hwirq, &type))
 		return 0;
 
 	if (irq_domain_is_hierarchy(domain)) {
-		/* Temporary hack */
-		void *desc = &fwspec;
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-		if (!domain->ops->translate)
-			desc = irq_data;
-#endif
 		/*
 		 * If we've already configured this interrupt,
 		 * don't do it again, or hell will break loose.
@@ -553,7 +544,7 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 		if (virq)
 			return virq;
 
-		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, desc);
+		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
 		if (virq <= 0)
 			return 0;
 	} else {
@@ -569,6 +560,15 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 		irq_set_irq_type(virq, type);
 	return virq;
 }
+EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
+
+unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
+{
+	struct irq_fwspec fwspec;
+
+	of_phandle_args_to_fwspec(irq_data, &fwspec);
+	return irq_create_fwspec_mapping(&fwspec);
+}
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
 
 /**
-- 
2.1.4
