From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 2/7] PCI/MSI: Setup MSI domain on a per-devices basis using
 IORT ACPI table
Date: Mon, 13 Jun 2016 16:41:08 +0200
Message-ID: <1465828873-23498-3-git-send-email-tn@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465828873-23498-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org, linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>, mw@semihalf.com, andrea.gallo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

It is possible to provide information about which MSI controller to
use on a per-device basis for DT. This patch supply this with ACPI support.

Currently, IORT is the only one ACPI table which can provide such mapping.
In order to plug IORT into MSI infrastructure we are adding ACPI
equivalents for finding PCI device domain and its RID translation
(pci_msi_domain_get_msi_rid and pci_msi_domain_get_msi_rid calls).

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/msi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..1d45e81 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/iort.h>
 #include <linux/slab.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
@@ -1364,8 +1365,8 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	if (of_node)
-		rid = of_msi_map_rid(&pdev->dev, of_node, rid);
+	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
+			iort_msi_map_rid(&pdev->dev, rid);
 
 	return rid;
 }
@@ -1381,9 +1382,13 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
  */
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
+	struct irq_domain *dom;
 	u32 rid = 0;
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	return of_msi_map_get_device_domain(&pdev->dev, rid);
+	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
+	if (!dom)
+		dom = iort_get_device_domain(&pdev->dev, rid);
+	return dom;
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
-- 
1.9.1
