From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 10/10] acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain initialization.
Date: Thu, 15 Oct 2015 16:05:19 +0200
Message-ID: <1444917919-21152-11-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33275 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbbJOOGQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2015 10:06:16 -0400
Received: by lbbpp2 with SMTP id pp2so40821995lbb.0
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2015 07:06:14 -0700 (PDT)
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com
Cc: will.deacon@arm.com, Catalin.Marinas@arm.com, hanjun.guo@linaro.org, graeme.gregory@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, Suravee.Suthikulpanit@amd.com, Tomasz Nowicki <tn@semihalf.com>

After refactoring DT code, we let ACPI to build ITS PCI MSI domain
and do requester ID to device ID translation using IORT table.

We have now full PCI MSI domain stack, thus we can enable ITS initialization
from GICv3 core driver for ACPI scenario.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 48 ++++++++++++++++++++++++++++++--
 drivers/irqchip/irq-gic-v3.c             |  3 +-
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index cfd35da..09ae2d8 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -15,6 +15,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
+#include <linux/iort.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -59,8 +61,10 @@ static int its_pci_msi_vec_count(struct pci_dev *pdev)
 static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct its_pci_alias *dev_alias = data;
+	u32 dev_id;
 
-	dev_alias->dev_id = alias;
+	dev_alias->dev_id = iort_find_pci_id(pdev, alias, &dev_id) == 0 ?
+								dev_id : alias;
 	if (pdev != dev_alias->pdev)
 		dev_alias->count += its_pci_msi_vec_count(pdev);
 
@@ -145,10 +149,50 @@ static int __init its_pci_of_msi_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+static int __init
+its_pci_msi_parse_madt(struct acpi_subtable_header *header,
+		    const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *domain_handle;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	domain_handle = iort_find_its_domain_token(its_entry->translation_id);
+	if (!domain_handle) {
+		pr_err("ITS@0x%lx: Unable to locate ITS domain handle\n",
+		       (long)its_entry->base_address);
+		return 0;
+	}
+
+	if (its_pci_msi_init_one(domain_handle))
+		return 0;
+
+	pci_msi_register_fwnode_provider(&iort_find_pci_domain_token);
+	pr_info("PCI/MSI: ITS@0x%lx domain created\n",
+		(long)its_entry->base_address);
+	return 0;
+}
+
+static int __init its_pci_acpi_msi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_pci_msi_parse_madt, 0);
+	return 0;
+}
+#else
+inline static int __init its_pci_acpi_msi_init(void)
+{
+	return 0;
+}
+#endif
+
 static int __init its_pci_msi_init(void)
 {
 	its_pci_of_msi_init();
+	its_pci_acpi_msi_init();
+
 	return 0;
 }
-
 early_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 27a6b79..b498947 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -894,8 +894,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
-	    to_of_node(handle)) /* Temp hack to prevent ITS init for ACPI */
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
-- 
1.9.1

