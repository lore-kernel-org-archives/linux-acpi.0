From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH part3 04/11] PCI: Use __pci_bus_size_bridges() directly in pci_assign_unassigned_bus_resources()
Date: Sun,  2 Sep 2012 14:52:14 -0700
Message-ID: <1346622741-30799-5-git-send-email-yinghai@kernel.org>
References: <1346622741-30799-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346622741-30799-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Now __pci_bus_size_bridges() will not include self bridge.
So we don't need to have our own version in
 pci_assign_unassigned_bus_resources anymore.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 70d6292..054d54b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1519,17 +1519,11 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 {
-	struct pci_dev *dev;
 	LIST_HEAD(add_list); /* list of resources that
 					want additional resources */
 
 	down_read(&pci_bus_sem);
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
-			if (dev->subordinate)
-				__pci_bus_size_bridges(dev->subordinate,
-						 &add_list, true);
+	__pci_bus_size_bridges(bus, &add_list, false);
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 	BUG_ON(!list_empty(&add_list));
-- 
1.7.7
