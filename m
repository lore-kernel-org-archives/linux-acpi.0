From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 2/4] irqchip/exiu: preparatory refactor for ACPI support
Date: Mon, 29 Apr 2019 15:12:06 +0200
Message-ID: <20190429131208.3620-3-ard.biesheuvel@linaro.org>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-gpio@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Masahisa Kojima <masahisa.kojima@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

In preparation of adding support for EXIU controller devices described
via ACPI, split the DT init function in a DT specific and a generic part,
where the latter will be reused for ACPI support later.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-sni-exiu.c | 77 ++++++++++++--------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 1927b2f36ff6..52ce662334d4 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -1,7 +1,7 @@
 /*
  * Driver for Socionext External Interrupt Unit (EXIU)
  *
- * Copyright (c) 2017 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (c) 2017-2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
  *
  * Based on irq-tegra.c:
  *   Copyright (C) 2011 Google, Inc.
@@ -167,35 +167,25 @@ static const struct irq_domain_ops exiu_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int __init exiu_init(struct device_node *node,
-			    struct device_node *parent)
+static struct irq_domain *exiu_init(struct irq_domain *parent_domain,
+				    struct fwnode_handle *fwnode,
+				    struct resource *res)
 {
-	struct irq_domain *parent_domain, *domain;
+	struct irq_domain *domain;
 	struct exiu_irq_data *data;
 	int err;
 
-	if (!parent) {
-		pr_err("%pOF: no parent, giving up\n", node);
-		return -ENODEV;
-	}
-
-	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("%pOF: unable to obtain parent domain\n", node);
-		return -ENXIO;
-	}
-
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	if (of_property_read_u32(node, "socionext,spi-base", &data->spi_base)) {
-		pr_err("%pOF: failed to parse 'spi-base' property\n", node);
+	if (fwnode_property_read_u32_array(fwnode, "socionext,spi-base",
+					   &data->spi_base, 1)) {
 		err = -ENODEV;
 		goto out_free;
 	}
 
-	data->base = of_iomap(node, 0);
+	data->base = ioremap(res->start, resource_size(res));
 	if (!data->base) {
 		err = -ENODEV;
 		goto out_free;
@@ -205,23 +195,52 @@ static int __init exiu_init(struct device_node *node,
 	writel_relaxed(0xFFFFFFFF, data->base + EIREQCLR);
 	writel_relaxed(0xFFFFFFFF, data->base + EIMASK);
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_IRQS, node,
-					  &exiu_domain_ops, data);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, NUM_IRQS,
+					     fwnode, &exiu_domain_ops, data);
 	if (!domain) {
-		pr_err("%pOF: failed to allocate domain\n", node);
 		err = -ENOMEM;
 		goto out_unmap;
 	}
+	return domain;
+out_unmap:
+	iounmap(data->base);
+out_free:
+	kfree(data);
+	return ERR_PTR(err);
+}
+
+static int __init exiu_dt_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct resource res;
+
+	if (!parent) {
+		pr_err("%pOF: no parent, giving up\n", node);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: unable to obtain parent domain\n", node);
+		return -ENXIO;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("%pOF: failed to parse memory resource\n", node);
+		return -ENXIO;
+	}
+
+	domain = exiu_init(parent_domain, of_node_to_fwnode(node), &res);
+	if (IS_ERR(domain)) {
+		pr_err("%pOF: failed to create IRQ domain (%ld)\n", node,
+		       PTR_ERR(domain));
+		return PTR_ERR(domain);
+	}
 
 	pr_info("%pOF: %d interrupts forwarded to %pOF\n", node, NUM_IRQS,
 		parent);
 
 	return 0;
-
-out_unmap:
-	iounmap(data->base);
-out_free:
-	kfree(data);
-	return err;
 }
-IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_init);
+IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_dt_init);
-- 
2.20.1
