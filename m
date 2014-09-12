From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 08/13] PCI: Remove unused pci_configure_slot()
Date: Fri, 12 Sep 2014 12:03:41 -0600
Message-ID: <20140912180341.1630.25395.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatxjain@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

All pci_configure_slot() uses have been removed, so remove the definition
as well.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c         |   27 ---------------------------
 include/linux/pci_hotplug.h |    2 --
 2 files changed, 29 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 93d2b41163fa..4b3b29bc7a82 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1358,33 +1358,6 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
-void pci_configure_slot(struct pci_dev *dev)
-{
-	struct pci_dev *cdev;
-	struct hotplug_params hpp;
-
-	if (!(dev->hdr_type == PCI_HEADER_TYPE_NORMAL ||
-			(dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
-			(dev->class >> 8) == PCI_CLASS_BRIDGE_PCI)))
-		return;
-
-	pcie_bus_configure_settings(dev->bus);
-
-	memset(&hpp, 0, sizeof(hpp));
-	pci_get_hp_params(dev, &hpp);
-
-	program_hpp_type2(dev, hpp.t2);
-	program_hpp_type1(dev, hpp.t1);
-	program_hpp_type0(dev, hpp.t0);
-
-	if (dev->subordinate) {
-		list_for_each_entry(cdev, &dev->subordinate->devices,
-				    bus_list)
-			pci_configure_slot(cdev);
-	}
-}
-EXPORT_SYMBOL_GPL(pci_configure_slot);
-
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 5f2e559af6b0..2706ee9a4327 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -187,6 +187,4 @@ static inline int pci_get_hp_params(struct pci_dev *dev,
 	return -ENODEV;
 }
 #endif
-
-void pci_configure_slot(struct pci_dev *dev);
 #endif
