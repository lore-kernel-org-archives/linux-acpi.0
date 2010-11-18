From: Stefan Assmann <sassmann@redhat.com>
Subject: [PATCH 3/4] PCI: fix locking for pci_find_upstream_pcie_bridge and add declaration
Date: Thu, 18 Nov 2010 08:52:28 -0500
Message-ID: <20101118135237.2269.96220.sendpatchset@localhost6.localdomain6>
References: <20101118135207.2269.2593.sendpatchset@localhost6.localdomain6>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101118135207.2269.2593.sendpatchset@localhost6.localdomain6>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: JBeulich@novell.com, linux-acpi@vger.kernel.org, Olaf.Dabrunz@gmx.net, Stefan Assmann <sassmann@redhat.com>, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Stefan Assmann <sassmann@redhat.com>

Add header declaration of pci_find_upstream_pcie_bridge to pci.h. This will
allow the boot interrupt reroute code, and others, to make use of this
implementation. Also pci_find_upstream_pcie_bridge should take the pci_bus_sem
semaphore while reading global PCI structures, so update the locking as well.

Signed-off-by: Stefan Assmann <sassmann@redhat.com>
---
 drivers/pci/search.c |    4 ++++
 include/linux/pci.h  |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7454408..7acb6b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -698,6 +698,7 @@ int pci_bus_find_ext_capability(struct pci_bus *bus, unsigned int devfn,
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
+struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
 
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 				struct pci_dev *from);
@@ -1208,6 +1209,8 @@ static inline void pci_unblock_user_cfg_access(struct pci_dev *dev)
 
 static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
 { return NULL; }
+static inline struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
+{ return NULL; }
 
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 						unsigned int devfn)
-- 
1.7.1
