From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/8] PCI / PCIe/ AER: Introduce pci_aer_available()
Date: Mon, 2 Aug 2010 23:54:46 +0200
Message-ID: <201008022354.46369.rjw@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57754 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422Ab0HBWCw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 18:02:52 -0400
In-Reply-To: <201008022351.31406.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce a function allowing the caller to check if PCIe AER should
be enabled.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.h             |    2 ++
 drivers/pci/pcie/aer/aerdrv.c |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -131,8 +131,10 @@ static inline void pci_msi_init_pci_dev(
 
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
+	if (pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }

