From: Hanna Hawa <hhhawa@amazon.com>
Subject: [PATCH 6/7] irqchip/al-msi: Refactor in preparation to add ACPI support
Date: Sun, 31 Mar 2019 15:35:32 +0300
Message-ID: <1554035733-11827-2-git-send-email-hhhawa@amazon.com>
References: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, zeev@amazon.com, alisaidi@amazon.com, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Move common parts which will be shared between DT and ACPI parsing, to
a common function.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/irqchip/irq-al-msi.c | 87 +++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/drivers/irqchip/irq-al-msi.c b/drivers/irqchip/irq-al-msi.c
index f04a311c..ec27455 100644
--- a/drivers/irqchip/irq-al-msi.c
+++ b/drivers/irqchip/irq-al-msi.c
@@ -26,6 +26,7 @@
 #define AL_MSIX_SPI_TARGET_CLUSTER0		BIT(16)
 
 struct al_msix_data {
+	struct fwnode_handle *msi_domain_handle;
 	spinlock_t msi_map_lock;
 	phys_addr_t addr;
 	u32 spi_first;		/* The SPI number that MSIs start */
@@ -190,22 +191,9 @@ static const struct irq_domain_ops al_msix_middle_domain_ops = {
 };
 
 static int al_msix_init_domains(struct al_msix_data *priv,
-				struct device_node *node)
+				struct irq_domain *gic_domain)
 {
-	struct irq_domain *middle_domain, *msi_domain, *gic_domain;
-	struct device_node *gic_node;
-
-	gic_node = of_irq_find_parent(node);
-	if (!gic_node) {
-		pr_err("Failed to find the GIC node\n");
-		return -ENODEV;
-	}
-
-	gic_domain = irq_find_host(gic_node);
-	if (!gic_domain) {
-		pr_err("Failed to find the GIC domain\n");
-		return -ENXIO;
-	}
+	struct irq_domain *middle_domain, *msi_domain;
 
 	middle_domain = irq_domain_add_tree(NULL, &al_msix_middle_domain_ops,
 					    priv);
@@ -216,7 +204,7 @@ static int al_msix_init_domains(struct al_msix_data *priv,
 
 	middle_domain->parent = gic_domain;
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(priv->msi_domain_handle,
 					       &al_msix_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -228,34 +216,62 @@ static int al_msix_init_domains(struct al_msix_data *priv,
 	return 0;
 }
 
+static int al_msix_init_common(struct al_msix_data *priv, u64 base_address)
+{
+	spin_lock_init(&priv->msi_map_lock);
+
+	/*
+	 * The 20 least significant bits of addr provide direct information
+	 * regarding the interrupt destination.
+	 *
+	 * To select the primary GIC as the target GIC, bits [18:17] must be set
+	 * to 0x0. In this case, bit 16 (SPI_TARGET_CLUSTER0) must be set.
+	 */
+	priv->addr = base_address & GENMASK_ULL(63, 20);
+	priv->addr |= AL_MSIX_SPI_TARGET_CLUSTER0;
+
+	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
+				sizeof(*priv->msi_map),
+				GFP_KERNEL);
+	if (!priv->msi_map)
+		return -ENOMEM;
+
+	pr_debug("Registering %d msixs, starting at %d\n", priv->num_spis,
+		 priv->spi_first);
+
+	return 0;
+}
+
 static int al_msix_init(struct device_node *node, struct device_node *parent)
 {
 	struct al_msix_data *priv;
 	struct resource res;
+	struct device_node *gic_node;
+	struct irq_domain *gic_domain;
 	int ret;
 
+	gic_node = of_irq_find_parent(node);
+	if (!gic_node) {
+		pr_err("Failed to find the GIC node\n");
+		return -ENODEV;
+	}
+
+	gic_domain = irq_find_host(gic_node);
+	if (!gic_domain) {
+		pr_err("Failed to find the GIC domain\n");
+		return -ENXIO;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->msi_map_lock);
-
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
 		pr_err("Failed to allocate resource\n");
 		goto err_priv;
 	}
 
-	/*
-	 * The 20 least significant bits of addr provide direct information
-	 * regarding the interrupt destination.
-	 *
-	 * To select the primary GIC as the target GIC, bits [18:17] must be set
-	 * to 0x0. In this case, bit 16 (SPI_TARGET_CLUSTER0) must be set.
-	 */
-	priv->addr = res.start & GENMASK_ULL(63, 20);
-	priv->addr |= AL_MSIX_SPI_TARGET_CLUSTER0;
-
 	if (of_property_read_u32(node, "al,msi-base-spi", &priv->spi_first)) {
 		pr_err("Unable to parse MSI base\n");
 		ret = -EINVAL;
@@ -268,18 +284,13 @@ static int al_msix_init(struct device_node *node, struct device_node *parent)
 		goto err_priv;
 	}
 
-	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
-				sizeof(*priv->msi_map),
-				GFP_KERNEL);
-	if (!priv->msi_map) {
-		ret = -ENOMEM;
-		goto err_priv;
-	}
+	priv->msi_domain_handle = of_node_to_fwnode(node);
 
-	pr_debug("Registering %d msixs, starting at %d\n",
-		 priv->num_spis, priv->spi_first);
+	ret = al_msix_init_common(priv, res.start);
+	if (ret)
+		goto err_priv;
 
-	ret = al_msix_init_domains(priv, node);
+	ret = al_msix_init_domains(priv, gic_domain);
 	if (ret)
 		goto err_map;
 
-- 
2.7.4
