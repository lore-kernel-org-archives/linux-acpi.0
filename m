From: Stefan Assmann <sassmann@redhat.com>
Subject: [PATCH 3/5 v2] PCI: Add locking to pci_find_upstream_pcie_bridge()
Date: Thu, 2 Dec 2010 10:33:45 -0500
Message-ID: <20101202153411.29125.10231.sendpatchset@localhost6.localdomain6>
References: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118Ab0LBPfD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Dec 2010 10:35:03 -0500
In-Reply-To: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, JBeulich@novell.com, jbarnes@virtuousgeek.org, Stefan Assmann <sassmann@redhat.com>, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, Olaf.Dabrunz@gmx.net

From: Stefan Assmann <sassmann@redhat.com>

pci_find_upstream_pcie_bridge() should take the pci_bus_sem semaphore while
reading global PCI structures.

Signed-off-by: Stefan Assmann <sassmann@redhat.com>
Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/pci/search.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 9d75dc8..c8159b0 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -29,6 +29,8 @@ pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
 
 	if (pci_is_pcie(pdev))
 		return NULL;
+
+	down_read(&pci_bus_sem);
 	while (1) {
 		if (pci_is_root_bus(pdev->bus))
 			break;
@@ -38,6 +40,7 @@ pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
 			tmp = pdev;
 			continue;
 		}
+		up_read(&pci_bus_sem);
 		/* PCI device should connect to a PCIe bridge */
 		if (pdev->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE) {
 			/* Busted hardware? */
@@ -46,6 +49,7 @@ pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
 		}
 		return pdev;
 	}
+	up_read(&pci_bus_sem);
 
 	return tmp;
 }
-- 
1.7.3.2
