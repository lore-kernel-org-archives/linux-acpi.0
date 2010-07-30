From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 6/6] PCI: portdrv: remove module_exit
Date: Fri, 30 Jul 2010 15:25:06 +0900
Message-ID: <4C527042.6000806@jp.fujitsu.com>
References: <201007282323.56351.rjw@sisk.pl> <20100728144358.5e2c12ce@virtuousgeek.org> <4C510B90.9070302@jp.fujitsu.com> <201007291745.39285.rjw@sisk.pl> <4C526A85.3070902@jp.fujitsu.com> <4C526E3E.3000600@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:33152 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab0G3GZn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jul 2010 02:25:43 -0400
In-Reply-To: <4C526E3E.3000600@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Remove unnecessary pcie_portdrv_exit().

The PCIe port bus driver is built-in kernel module. So the module will
never be unloaded.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pcie/portdrv_pci.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-2.6.35-rc6/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.35-rc6.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2.6.35-rc6/drivers/pci/pcie/portdrv_pci.c
@@ -345,11 +345,4 @@ static int __init pcie_portdrv_init(void
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

