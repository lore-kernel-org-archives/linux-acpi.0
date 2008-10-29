From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 3/8] ACPI,
	PCI: PCIe ASPM _OSC support capabilities called when root bridge added
Date: Tue, 28 Oct 2008 23:48:31 -0600
Message-ID: <20081029054831.2263.81405.stgit@bob.kio>
References: <20081029054815.2263.40833.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081029054815.2263.40833.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx
List-Id: linux-acpi@vger.kernel.org

ACPI, PCI: PCIe ASPM _OSC support capabilities called when root bridge added

The _OSC capabilities OSC_ACTIVE_STATE_PWR_SUPPORT and
OSC_CLOCK_PWR_CAPABILITY_SUPPORT are set when the root bridge is added
with pci_acpi_osc_support(), so we no longer need to do it in the
ASPM driver.
---

 drivers/acpi/pci_root.c |    4 ++++
 drivers/pci/pcie/aspm.c |   22 ----------------------
 2 files changed, 4 insertions(+), 22 deletions(-)


diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 47df4a8..4d60629 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -214,6 +214,10 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	pci_acpi_osc_support(device->handle,
 			     OSC_EXT_PCI_CONFIG_SUPPORT |
 			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
+#ifdef CONFIG_PCIEASPM
+			     OSC_ACTIVE_STATE_PWR_SUPPORT |
+			     OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
+#endif
 			     0);
 
 	/* 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 8f63f4c..2c87883 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -833,25 +833,3 @@ void pcie_no_aspm(void)
 	if (!aspm_force)
 		aspm_disabled = 1;
 }
-
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
-{
-	if (aspm_disabled)
-		return 0;
-	pcie_aspm_platform_init();
-	return 0;
-}
-
-fs_initcall(pcie_aspm_init);
