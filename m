From: Stefan Assmann <sassmann@redhat.com>
Subject: [PATCH 4/5 v2] PCI: Add header declaration for pci_find_upstream_pcie_bridge()
Date: Thu, 2 Dec 2010 10:33:54 -0500
Message-ID: <20101202153420.29125.15774.sendpatchset@localhost6.localdomain6>
References: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101202153344.29125.86670.sendpatchset@localhost6.localdomain6>
Sender: linux-pci-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-pci@vger.kernel.org, jbarnes@virtuousgeek.org, JBeulich@novell.com, Olaf.Dabrunz@gmx.net, Stefan Assmann <sassmann@redhat.com>, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Stefan Assmann <sassmann@redhat.com>

Add header declaration for pci_find_upstream_pcie_bridge to pci.h. This will
allow the boot interrupt reroute code, and others, to make use of the
implementation.

Signed-off-by: Stefan Assmann <sassmann@redhat.com>
Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 include/linux/pci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

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
1.7.3.2
