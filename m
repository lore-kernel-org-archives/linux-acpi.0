From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/10] PCI / PCIe: Remove the port driver module exit routine
Date: Fri, 6 Aug 2010 03:10:20 +0200
Message-ID: <201008060310.20754.rjw@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43667 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934287Ab0HFBRp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Aug 2010 21:17:45 -0400
In-Reply-To: <201008060303.51224.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org

From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

The PCIe port driver's module exit routine is never used, so drop it.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 drivers/pci/pcie/portdrv_pci.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
@@ -343,11 +343,4 @@ static int __init pcie_portdrv_init(void
 	return retval;
 }
 
-static void __exit pcie_portdrv_exit(void)
-{
-	pci_unregister_driver(&pcie_portdriver);
-	pcie_port_bus_unregister();
-}
-
 module_init(pcie_portdrv_init);
-module_exit(pcie_portdrv_exit);

