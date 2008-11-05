From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 4/7] ACPI,
	PCI: PCIe ASPM _OSC support capabilities called when root bridge added
Date: Tue, 04 Nov 2008 22:29:55 -0700
Message-ID: <20081105052955.15722.77936.stgit@bob.kio>
References: <20081105052934.15722.98580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:41876 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbYKEF34 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 00:29:56 -0500
In-Reply-To: <20081105052934.15722.98580.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com

ACPI, PCI: PCIe ASPM _OSC support capabilities called when root bridge added

The _OSC capabilities OSC_ACTIVE_STATE_PWR_SUPPORT and
OSC_CLOCK_PWR_CAPABILITY_SUPPORT are set when the root bridge is added
with pci_acpi_osc_support(), so we no longer need to do it in the
ASPM driver.

Added the function pcie_aspm_enabled, which returns true if pcie_aspm=off
is not on the kernel command-line.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 1fcf40f..e2c88fb 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -215,6 +215,9 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
 	if (pci_ext_cfg_avail())
 		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
+	if (pcie_aspm_enabled())
+		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
+			OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
 	pci_acpi_osc_support(device->handle, flags);
 
 	/* 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 8f63f4c..1089f86 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -834,24 +834,15 @@ void pcie_no_aspm(void)
 		aspm_disabled = 1;
 }
 
-#ifdef CONFIG_ACPI
-#include <acpi/acpi_bus.h>
-#include <linux/pci-acpi.h>
-static void pcie_aspm_platform_init(void)
-{
-	pcie_osc_support_set(OSC_ACTIVE_STATE_PWR_SUPPORT|
-		OSC_CLOCK_PWR_CAPABILITY_SUPPORT);
-}
-#else
-static inline void pcie_aspm_platform_init(void) { }
-#endif
-
-static int __init pcie_aspm_init(void)
+/**
+ * pcie_aspm_enabled - is PCIe ASPM enabled?
+ *
+ * Returns true if ASPM has not been disabled by the command-line option
+ * pcie_aspm=off.
+ **/
+int pcie_aspm_enabled(void)
 {
-	if (aspm_disabled)
-		return 0;
-	pcie_aspm_platform_init();
-	return 0;
+       return !aspm_disabled;
 }
+EXPORT_SYMBOL(pcie_aspm_enabled);
 
-fs_initcall(pcie_aspm_init);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ea2fb2b..c4f0859 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -786,6 +786,15 @@ extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 extern void pci_restore_msi_state(struct pci_dev *dev);
 #endif
 
+#ifndef CONFIG_PCIEASPM
+static inline int pcie_aspm_enabled(void)
+{
+	return 0;
+}
+#else
+extern int pcie_aspm_enabled(void);
+#endif
+
 #ifdef CONFIG_HT_IRQ
 /* The functions a driver should call */
 int  ht_create_irq(struct pci_dev *dev, int idx);

