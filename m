From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v9 02/16] pci: clean up usages of pci_bus->is_added
Date: Fri, 12 Apr 2013 23:44:16 +0800
Message-ID: <1365781470-32379-3-git-send-email-jiang.liu@huawei.com>
References: <1365781470-32379-1-git-send-email-jiang.liu@huawei.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1365781470-32379-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Jiang Liu <jiang.liu@huawei.com>, Yinghai Lu <yinghai@kernel.org>, Yijing Wang <wangyijing@huawei.com>, Jiang Liu <liuj97@gmail.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Now pci_bus->is_added is only used to guard invoking of
pcibios_fixup_bus(), so clean up the code.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/bus.c   |   11 ++---------
 drivers/pci/probe.c |    3 +--
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8647dc6..bdc1e8b 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -206,16 +206,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		BUG_ON(!dev->is_added);
-
 		child = dev->subordinate;
-
-		if (!child)
-			continue;
-		pci_bus_add_devices(child);
-
-		if (child->is_added)
-			continue;
-		child->is_added = 1;
+		if (child)
+			pci_bus_add_devices(child);
 	}
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b494066..45c93b3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1627,8 +1627,7 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 	if (!bus->is_added) {
 		dev_dbg(&bus->dev, "fixups for bus\n");
 		pcibios_fixup_bus(bus);
-		if (pci_is_root_bus(bus))
-			bus->is_added = 1;
+		bus->is_added = 1;
 	}
 
 	for (pass=0; pass < 2; pass++)
-- 
1.7.9.5
