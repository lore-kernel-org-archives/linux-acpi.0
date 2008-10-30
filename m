From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 5/6] ACPI,
	PCI: PCI MSI _OSC support capabilities called when root bridge added
Date: Wed, 29 Oct 2008 23:28:12 -0600
Message-ID: <20081030052812.10259.39568.stgit@bob.kio>
References: <20081030052746.10259.22045.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:32773 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbYJ3F2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Oct 2008 01:28:13 -0400
In-Reply-To: <20081030052746.10259.22045.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com

ACPI, PCI: PCI MSI _OSC support capabilities called when root bridge added

The _OSC capabilityy OSC_MSI_SUPPORT is set when the root
bridge is added with pci_acpi_osc_support(), so we no longer
need to do it in the PCI MSI driver.

Added the function pci_msi_enabled, which returns true if pci=nomsi is not
on the kernel command-line.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

 drivers/acpi/pci_root.c |    2 ++
 drivers/pci/msi.c       |   31 +++++++++++--------------------
 drivers/pci/pci.c       |    2 --
 drivers/pci/pci.h       |    2 --
 include/linux/pci.h     |    5 +++++
 5 files changed, 18 insertions(+), 24 deletions(-)


diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c36dc1d..69d637a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -218,6 +218,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	if (pcie_aspm_enabled())
 		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
 			OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
+	if (pci_msi_enabled())
+		flags |= OSC_MSI_SUPPORT;
 	pci_acpi_osc_support(device->handle, flags);
 
 	/* 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 74801f7..0e8dae1 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -755,28 +755,19 @@ void pci_no_msi(void)
 	pci_msi_enable = 0;
 }
 
-void pci_msi_init_pci_dev(struct pci_dev *dev)
-{
-	INIT_LIST_HEAD(&dev->msi_list);
-}
-
-#ifdef CONFIG_ACPI
-#include <linux/acpi.h>
-#include <linux/pci-acpi.h>
-static void __devinit msi_acpi_init(void)
+/**
+ * pci_msi_enabled - is MSI enabled?
+ *
+ * Returns true if MSI has not been disabled by the command-line option
+ * pci=nomsi.
+ **/
+int pci_msi_enabled(void)
 {
-	if (acpi_pci_disabled)
-		return;
-	pci_osc_support_set(OSC_MSI_SUPPORT);
-	pcie_osc_support_set(OSC_MSI_SUPPORT);
+	return pci_msi_enable;
 }
-#else
-static inline void msi_acpi_init(void) { }
-#endif /* CONFIG_ACPI */
+EXPORT_SYMBOL(pci_msi_enabled);
 
-void __devinit msi_init(void)
+void pci_msi_init_pci_dev(struct pci_dev *dev)
 {
-	if (!pci_msi_enable)
-		return;
-	msi_acpi_init();
+	INIT_LIST_HEAD(&dev->msi_list);
 }
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 682033c..9ea6bdc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -767,6 +767,10 @@ static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev)
 
 static inline void pci_restore_msi_state(struct pci_dev *dev)
 { }
+static inline int pci_msi_enabled(void)
+{
+	return 0;
+}
 #else
 extern int pci_enable_msi(struct pci_dev *dev);
 extern void pci_msi_shutdown(struct pci_dev *dev);
@@ -777,6 +781,7 @@ extern void pci_msix_shutdown(struct pci_dev *dev);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 extern void pci_restore_msi_state(struct pci_dev *dev);
+extern int pci_msi_enabled(void);
 #endif
 
 #ifndef CONFIG_PCIEASPM

