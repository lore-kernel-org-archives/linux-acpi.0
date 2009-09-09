From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/9] PM: Allow PCI devices to suspend/resume asynchronously
Date: Thu, 10 Sep 2009 01:36:56 +0200
Message-ID: <200909100136.56111.rjw@sisk.pl>
References: <200909100127.11252.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35989 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541AbZIIXl4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Sep 2009 19:41:56 -0400
In-Reply-To: <200909100127.11252.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>

From: Rafael J. Wysocki <rjw@sisk.pl>

Set async_suspend for all PCI devices and PCIe port services, so that
they can be suspended and resumed asynchronously with other devices
they don't depend on in a known way (i.e. devices which are not their
parents or children and to which they are not connected via struct
pm_link objects).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c               |    1 +
 drivers/pci/pcie/portdrv_core.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1373,6 +1373,7 @@ void pci_pm_init(struct pci_dev *dev)
 	int pm;
 	u16 pmc;
 
+	device_enable_async_suspend(&dev->dev, true);
 	dev->wakeup_prepared = false;
 	dev->pm_cap = 0;
 
Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -280,6 +280,7 @@ static void pcie_device_init(struct pci_
 	dev_set_name(device, "%s:pcie%02x",
 		 pci_name(parent), get_descriptor_id(port_type, service_type));
 	device->parent = &parent->dev;
+	device_enable_async_suspend(device, true);
 }
 
 /**
