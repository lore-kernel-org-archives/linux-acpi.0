From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 6/7] ACPI,
	PCI: PCI MSI _OSC support capabilities called when root bridge added
Date: Tue, 04 Nov 2008 22:30:05 -0700
Message-ID: <20081105053005.15722.56569.stgit@bob.kio>
References: <20081105052934.15722.98580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:9693 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYKEFaG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 00:30:06 -0500
In-Reply-To: <20081105052934.15722.98580.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com

ACPI, PCI: PCI MSI _OSC support capabilities called when root bridge added

The _OSC capability OSC_MSI_SUPPORT is set when the root
bridge is added with pci_acpi_osc_support(), so we no longer
need to do it in the PCI MSI driver.

Added the function pci_msi_enabled, which returns true if pci=nomsi is not
on the kernel command-line.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e2c88fb..579efa9 100644
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
index c22a31d..61b19b3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2063,8 +2063,6 @@ static int __devinit pci_init(void)
 		pci_fixup_device(pci_fixup_final, dev);
 	}
 
-	msi_init();
-
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d3e65e2..9162e24 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -102,11 +102,9 @@ extern unsigned int pci_pm_d3_delay;
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
index c4f0859..c70f999 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -774,6 +774,10 @@ static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev)
 
 static inline void pci_restore_msi_state(struct pci_dev *dev)
 { }
+static inline int pci_msi_enabled(void)
+{
+	return 0;
+}
 #else
 extern int pci_enable_msi(struct pci_dev *dev);
 extern void pci_msi_shutdown(struct pci_dev *dev);
@@ -784,6 +788,7 @@ extern void pci_msix_shutdown(struct pci_dev *dev);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 extern void pci_restore_msi_state(struct pci_dev *dev);
+extern int pci_msi_enabled(void);
 #endif
 
 #ifndef CONFIG_PCIEASPM

