From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 04/13] PCI: pciehp: Configure hot-added display devices
Date: Fri, 12 Sep 2014 12:03:14 -0600
Message-ID: <20140912180314.1630.94483.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

We configure cache line size and other settings of hot-added devices, e.g.,
based on ACPI _HPP or _HPX methods.  Previously we skipped this
configuration for display devices, but there is no spec requirement for
that.

Remove the check so we configure display devices the same way we configure
other devices.

See also ac81860ea073 ("PCI: hotplug: pciehp: Removed check for hotplug of
display devices").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_pci.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 5f871f4c4af1..b66812703415 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -66,12 +66,8 @@ int pciehp_configure_device(struct slot *p_slot)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 
-	list_for_each_entry(dev, &parent->devices, bus_list) {
-		if ((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
-			continue;
-
+	list_for_each_entry(dev, &parent->devices, bus_list)
 		pci_configure_slot(dev);
-	}
 
 	pci_bus_add_devices(parent);
 
