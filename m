From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 5/8] ACPI,
	PCI: PCI MSI _OSC support capabilities called when root bridge added
Date: Tue, 28 Oct 2008 23:48:41 -0600
Message-ID: <20081029054841.2263.3863.stgit@bob.kio>
References: <20081029054815.2263.40833.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:22270 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYJ2Fsm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 01:48:42 -0400
In-Reply-To: <20081029054815.2263.40833.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx

ACPI, PCI: PCI MSI _OSC support capabilities called when root bridge added

The _OSC capabilityy OSC_MSI_SUPPORT is set when the root
bridge is added with pci_acpi_osc_support(), so we no longer
need to do it in the PCI MSI driver.
---

 drivers/acpi/pci_root.c |    3 +++
 drivers/pci/msi.c       |   21 ---------------------
 drivers/pci/pci.c       |    2 --
 drivers/pci/pci.h       |    2 --
 4 files changed, 3 insertions(+), 25 deletions(-)


diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4d60629..75a59ea 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -214,6 +214,9 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	pci_acpi_osc_support(device->handle,
 			     OSC_EXT_PCI_CONFIG_SUPPORT |
 			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
+#ifdef CONFIG_PCI_MSI
+			     OSC_MSI_SUPPORT |
+#endif
 #ifdef CONFIG_PCIEASPM
 			     OSC_ACTIVE_STATE_PWR_SUPPORT |
 			     OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 74801f7..d281201 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -759,24 +759,3 @@ void pci_msi_init_pci_dev(struct pci_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->msi_list);
 }
-
-#ifdef CONFIG_ACPI
-#include <linux/acpi.h>
-#include <linux/pci-acpi.h>
-static void __devinit msi_acpi_init(void)
-{
-	if (acpi_pci_disabled)
-		return;
-	pci_osc_support_set(OSC_MSI_SUPPORT);
-	pcie_osc_support_set(OSC_MSI_SUPPORT);
-}
-#else
-static inline void msi_acpi_init(void) { }
-#endif /* CONFIG_ACPI */
-
-void __devinit msi_init(void)
-{
-	if (!pci_msi_enable)
-		return;
-	msi_acpi_init();
-}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 533aeb5..d77e477 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2032,8 +2032,6 @@ static int __devinit pci_init(void)
 		pci_fixup_device(pci_fixup_final, dev);
 	}
 
-	msi_init();
-
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9de87e9..b205ab8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -98,11 +98,9 @@ extern unsigned int pci_pm_d3_delay;
 #ifdef CONFIG_PCI_MSI
 void pci_no_msi(void);
 extern void pci_msi_init_pci_dev(struct pci_dev *dev);
-extern void __devinit msi_init(void);
 #else
 static inline void pci_no_msi(void) { }
 static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
-static inline void msi_init(void) { }
 #endif
 
 #ifdef CONFIG_PCIEAER

