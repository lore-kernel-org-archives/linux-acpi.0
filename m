From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 09/10] acpi, gicv3, msi: Factor out code that might be reused for ACPI equivalent.
Date: Thu, 15 Oct 2015 16:05:18 +0200
Message-ID: <1444917919-21152-10-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com
Cc: will.deacon@arm.com, Catalin.Marinas@arm.com, hanjun.guo@linaro.org, graeme.gregory@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, Suravee.Suthikulpanit@amd.com, Tomasz Nowicki <tn@semihalf.com>
List-Id: linux-acpi@vger.kernel.org

Firmware agnostic code lands in separate function which do necessary
domain initialization based on unequal domain handler.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 43 +++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 693c2f9..cfd35da 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -108,34 +108,47 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_pci_msi_init(void)
+static int __init its_pci_msi_init_one(struct fwnode_handle *handle)
 {
-	struct device_node *np;
 	struct irq_domain *parent;
 
+	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("Unable to locate ITS domain\n");
+		return -ENXIO;
+	}
+
+	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
+				       parent)) {
+		pr_err("Unable to create PCI domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __init its_pci_of_msi_init(void)
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
+		if (its_pci_msi_init_one(of_node_to_fwnode(np)))
 			continue;
-		}
-
-		if (!pci_msi_create_irq_domain(of_node_to_fwnode(np),
-					       &its_pci_msi_domain_info,
-					       parent)) {
-			pr_err("%s: unable to create PCI domain\n",
-			       np->full_name);
-			continue;
-		}
 
 		pr_info("PCI/MSI: %s domain created\n", np->full_name);
 	}
 
 	return 0;
 }
+
+static int __init its_pci_msi_init(void)
+{
+	its_pci_of_msi_init();
+	return 0;
+}
+
 early_initcall(its_pci_msi_init);
-- 
1.9.1
