From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 3/4] PCI: Show driver, BAR#,
 and resource on pci_ioremap_bar() failure
Date: Thu, 12 Mar 2015 12:35:40 -0500
Message-ID: <20150312173540.1052.39833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Use dev_warn() to complain about a pci_ioremap_bar() failure so we can
include the driver name, BAR number, and the resource itself.  We could use
dev_WARN() to also get the backtrace as we did previously, but I think
that's more information than we need.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81f06e8dcc04..a6d191ad9743 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -126,15 +126,16 @@ EXPORT_SYMBOL_GPL(pci_bus_max_busnr);
 #ifdef CONFIG_HAS_IOMEM
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 {
+	struct resource *res = &pdev->resource[bar];
+
 	/*
 	 * Make sure the BAR is actually a memory resource, not an IO resource
 	 */
-	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
-		WARN_ON(1);
+	if (!(res->flags & IORESOURCE_MEM)) {
+		dev_warn(&pdev->dev, "can't ioremap BAR %d: %pR\n", bar, res);
 		return NULL;
 	}
-	return ioremap_nocache(pci_resource_start(pdev, bar),
-				     pci_resource_len(pdev, bar));
+	return ioremap_nocache(res->start, resource_size(res));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_bar);
 #endif
