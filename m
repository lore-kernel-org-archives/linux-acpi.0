From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 06/13] PCI: shpchp: Remove pci_configure_slot() usage
Date: Fri, 12 Sep 2014 12:03:28 -0600
Message-ID: <20140912180328.1630.45550.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

We now configure each PCI device as it is enumerated, in pci_device_add(),
so remove the configuration done in shpchp.

That configuration, in pci_configure_device(), does not include the
MPS/MRRS configuration done by pcie_bus_configure_settings(), so keep
that here.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/shpchp_pci.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 469454e0cc48..f8cd3a27e351 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -69,13 +69,7 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
-
-	list_for_each_entry(dev, &parent->devices, bus_list) {
-		if (PCI_SLOT(dev->devfn) != p_slot->device)
-			continue;
-		pci_configure_slot(dev);
-	}
-
+	pcie_bus_configure_settings(parent);
 	pci_bus_add_devices(parent);
 
  out:
