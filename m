From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/8] PCI / PCIe: Remove the port driver module exit routine
Date: Mon, 2 Aug 2010 23:58:40 +0200
Message-ID: <201008022358.41208.rjw@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57740 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042Ab0HBWCt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 18:02:49 -0400
In-Reply-To: <201008022351.31406.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>

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

