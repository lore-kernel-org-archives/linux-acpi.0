From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/10] PCI / PCIe/ AER: Introduce pci_aer_available()
Date: Sat, 21 Aug 2010 01:50:52 +0200
Message-ID: <201008210150.52589.rjw@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl> <201008210149.39576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59482 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab0HUABd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Aug 2010 20:01:33 -0400
In-Reply-To: <201008210149.39576.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pm@lists.linux-foundation.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce a function allowing the caller to check whether to try to
enable PCIe AER.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.h             |    2 ++
 drivers/pci/pcie/aer/aerdrv.c |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -140,8 +140,10 @@ static inline void pci_msi_init_pci_dev(
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+bool pci_aer_available(void);
 #else
 static inline void pci_no_aer(void) { }
+static inline bool pci_aer_available(void) { return false; }
 #endif
 
 static inline int pci_no_d1d2(struct pci_dev *dev)
Index: linux-2.6/drivers/pci/pcie/aer/aerdrv.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv.c
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv.c
@@ -72,6 +72,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = 1;	/* has priority over 'forceload' */
 }
 
+bool pci_aer_available(void)
+{
+	return !pcie_aer_disable && pci_msi_enabled();
+}
+
 static int set_device_error_reporting(struct pci_dev *dev, void *data)
 {
 	bool enable = *((bool *)data);
@@ -411,9 +416,7 @@ static void aer_error_resume(struct pci_
  */
 static int __init aer_service_init(void)
 {
-	if (pcie_aer_disable)
-		return -ENXIO;
-	if (!pci_msi_enabled())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }

