From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 3/7] ACPI,
	PCI: PCI extended config _OSC support called when root bridge added
Date: Tue, 04 Nov 2008 22:29:50 -0700
Message-ID: <20081105052950.15722.94409.stgit@bob.kio>
References: <20081105052934.15722.98580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081105052934.15722.98580.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

ACPI, PCI: PCI extended config _OSC support called when root bridge added

The _OSC capability OSC_EXT_PCI_CONFIG_SUPPORT is set when the root bridge
is added with pci_acpi_osc_support() if we can access PCI extended
config space.

Added the function pci_no_mmcfg_enabled which sets the variable
pci_mmcfg_disabled=1 if pci=nommconf is included on the kernel command-
line.

Added the function pci_ext_cfg_avail which returns true if we can
access PCI extended config space (offset greater than 0xff). It
currently only returns false if pci=nommconf is included on the kernel
command-line.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index b67732b..e714976 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -470,6 +470,7 @@ char * __devinit  pcibios_setup(char *str)
 #endif
 #ifdef CONFIG_PCI_MMCONFIG
 	else if (!strcmp(str, "nommconf")) {
+		pci_no_mmcfg();
 		pci_probe &= ~PCI_PROBE_MMCONF;
 		return NULL;
 	}
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e1cf2b7..1fcf40f 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -212,8 +212,9 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 
 	device->ops.bind = acpi_pci_bind;
 
-	flags = (OSC_PCI_SEGMENT_GROUPS_SUPPORT |
-		 0);
+	flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+	if (pci_ext_cfg_avail())
+		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
 	pci_acpi_osc_support(device->handle, flags);
 
 	/* 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 21f2ac6..c22a31d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -28,6 +28,10 @@ unsigned int pci_pm_d3_delay = 10;
 int pci_domains_supported = 1;
 #endif
 
+#ifdef CONFIG_PCI_MMCONFIG
+static int pci_mmcfg_disabled;
+#endif
+
 #define DEFAULT_CARDBUS_IO_SIZE		(256)
 #define DEFAULT_CARDBUS_MEM_SIZE	(64*1024*1024)
 /* pci=cbmemsize=nnM,cbiosize=nn can override this */
@@ -2029,6 +2033,28 @@ static void __devinit pci_no_domains(void)
 #endif
 }
 
+#ifdef CONFIG_PCI_MMCONFIG
+void pci_no_mmcfg(void)
+{
+	pci_mmcfg_disabled = 1;
+}
+#endif
+
+/**
+ * pci_ext_cfg_enabled - can we access extended PCI config space?
+ *
+ * Returns true if we can access PCI extended config space (offsets greater
+ * than 0xff).
+ */
+int pci_ext_cfg_avail(void)
+{
+#ifdef CONFIG_PCI_MMCONFIG
+	if (pci_mmcfg_disabled)
+		return 0;
+#endif
+	return 1;
+}
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c75b82b..ea2fb2b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1130,11 +1130,15 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev,
 #ifdef CONFIG_PCI_MMCONFIG
 extern void __init pci_mmcfg_early_init(void);
 extern void __init pci_mmcfg_late_init(void);
+void pci_no_mmcfg(void);
 #else
 static inline void pci_mmcfg_early_init(void) { }
 static inline void pci_mmcfg_late_init(void) { }
+static inline void pci_no_mmcfg(void) { }
 #endif
 
+int pci_ext_cfg_avail(void);
+
 #ifdef CONFIG_HAS_IOMEM
 static inline void * pci_ioremap_bar(struct pci_dev *pdev, int bar)
 {
