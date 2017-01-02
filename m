From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v6 06/14] irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to prepare for ACPI
Date: Mon,  2 Jan 2017 21:31:37 +0800
Message-ID: <1483363905-2806-7-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Introduce its_pmsi_init_one() to refactor the code to isolate
ACPI&DT common code to prepare for ACPI later.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Tested-by: Majun <majun258@huawei.com>
Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 45 ++++++++++++++++-----------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 16587a9..ff72704 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -84,34 +84,43 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	{},
 };
 
-static int __init its_pmsi_init(void)
+static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
+				const char *name)
 {
-	struct device_node *np;
 	struct irq_domain *parent;
 
+	parent = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("%s: unable to locate ITS domain\n", name);
+		return -ENXIO;
+	}
+
+	if (!platform_msi_create_irq_domain(fwnode, &its_pmsi_domain_info,
+					    parent)) {
+		pr_err("%s: unable to create platform domain\n", name);
+		return -ENXIO;
+	}
+
+	pr_info("Platform MSI: %s domain created\n", name);
+	return 0;
+}
+
+static void __init its_pmsi_of_init(void)
+{
+	struct device_node *np;
+
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
-		if (!parent || !msi_get_domain_info(parent)) {
-			pr_err("%s: unable to locate ITS domain\n",
-			       np->full_name);
-			continue;
-		}
-
-		if (!platform_msi_create_irq_domain(of_node_to_fwnode(np),
-						    &its_pmsi_domain_info,
-						    parent)) {
-			pr_err("%s: unable to create platform domain\n",
-			       np->full_name);
-			continue;
-		}
-
-		pr_info("Platform MSI: %s domain created\n", np->full_name);
+		its_pmsi_init_one(of_node_to_fwnode(np), np->full_name);
 	}
+}
 
+static int __init its_pmsi_init(void)
+{
+	its_pmsi_of_init();
 	return 0;
 }
 early_initcall(its_pmsi_init);
-- 
1.9.1
