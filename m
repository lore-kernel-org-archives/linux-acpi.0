From: Hanna Hawa <hhhawa@amazon.com>
Subject: [PATCH 4/7] irqchip/al-msi: Update wrong parameter naming
Date: Sun, 31 Mar 2019 15:34:12 +0300
Message-ID: <1554035655-11352-5-git-send-email-hhhawa@amazon.com>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, zeev@amazon.com, alisaidi@amazon.com, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Update the naming of sgi parameter to be spi, and fix comments.

The message interrupts target the SPIs in the target GIC, and not the
SGIs.

No functional change in this patch.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/irqchip/irq-al-msi.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-al-msi.c b/drivers/irqchip/irq-al-msi.c
index a1bbefc..f04a311c 100644
--- a/drivers/irqchip/irq-al-msi.c
+++ b/drivers/irqchip/irq-al-msi.c
@@ -28,8 +28,8 @@
 struct al_msix_data {
 	spinlock_t msi_map_lock;
 	phys_addr_t addr;
-	u32 spi_first;		/* The SGI number that MSIs start */
-	u32 num_spis;		/* The number of SGIs for MSIs */
+	u32 spi_first;		/* The SPI number that MSIs start */
+	u32 num_spis;		/* The number of SPIs for MSIs */
 	unsigned long *msi_map;
 };
 
@@ -53,7 +53,7 @@ static struct irq_chip al_msix_irq_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static int al_msix_allocate_sgi(struct al_msix_data *priv, int num_req)
+static int al_msix_allocate_spi(struct al_msix_data *priv, int num_req)
 {
 	int first;
 
@@ -73,10 +73,10 @@ static int al_msix_allocate_sgi(struct al_msix_data *priv, int num_req)
 	return priv->spi_first + first;
 }
 
-static void al_msix_free_sgi(struct al_msix_data *priv, unsigned int sgi,
+static void al_msix_free_spi(struct al_msix_data *priv, unsigned int spi,
 			     int num_req)
 {
-	int first = sgi - priv->spi_first;
+	int first = spi - priv->spi_first;
 
 	spin_lock(&priv->msi_map_lock);
 
@@ -119,7 +119,7 @@ static struct irq_chip middle_irq_chip = {
 };
 
 static int al_msix_gic_domain_alloc(struct irq_domain *domain,
-				    unsigned int virq, int sgi)
+				    unsigned int virq, int spi)
 {
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
@@ -131,7 +131,7 @@ static int al_msix_gic_domain_alloc(struct irq_domain *domain,
 	fwspec.fwnode = domain->parent->fwnode;
 	fwspec.param_count = 3;
 	fwspec.param[0] = 0;
-	fwspec.param[1] = sgi;
+	fwspec.param[1] = spi;
 	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
@@ -149,27 +149,27 @@ static int al_msix_middle_domain_alloc(struct irq_domain *domain,
 				       unsigned int nr_irqs, void *args)
 {
 	struct al_msix_data *priv = domain->host_data;
-	int sgi, err, i;
+	int spi, err, i;
 
-	sgi = al_msix_allocate_sgi(priv, nr_irqs);
-	if (sgi < 0)
-		return sgi;
+	spi = al_msix_allocate_spi(priv, nr_irqs);
+	if (spi < 0)
+		return spi;
 
 	for (i = 0; i < nr_irqs; i++) {
-		err = al_msix_gic_domain_alloc(domain, virq + i, sgi + i);
+		err = al_msix_gic_domain_alloc(domain, virq + i, spi + i);
 		if (err)
-			goto err_sgi;
+			goto err_spi;
 
-		irq_domain_set_hwirq_and_chip(domain, virq + i, sgi + i,
+		irq_domain_set_hwirq_and_chip(domain, virq + i, spi + i,
 					      &middle_irq_chip, priv);
 	}
 
 	return 0;
 
-err_sgi:
+err_spi:
 	while (--i >= 0)
 		irq_domain_free_irqs_parent(domain, virq, i);
-	al_msix_free_sgi(priv, sgi, nr_irqs);
+	al_msix_free_spi(priv, spi, nr_irqs);
 	return err;
 }
 
@@ -181,7 +181,7 @@ static void al_msix_middle_domain_free(struct irq_domain *domain,
 	struct al_msix_data *priv = irq_data_get_irq_chip_data(d);
 
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
-	al_msix_free_sgi(priv, d->hwirq, nr_irqs);
+	al_msix_free_spi(priv, d->hwirq, nr_irqs);
 }
 
 static const struct irq_domain_ops al_msix_middle_domain_ops = {
-- 
2.7.4
