From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 1/2] PCI/AER: Do not use APEI/HEST to disable AER services globally
Date: Thu, 15 Nov 2018 17:16:02 -0600
Message-ID: <20181115231605.24352-2-mr.nuke.me@gmail.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, Alexandru Gagniuc <mr.nuke.me@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI). HEST is tightly coupled to ownership
of AER, however the correct way to determine AER ownership is the _OSC
method.

_OSC is negotiated per root bus. It's possible to have one HEST
descriptor for all root busses where AER is owned by firmware, and
still have root busses that are not firmware-first. In that case we
would incorrectly disable AER services globally.

Instead of using HEST in making the determination, always request AER
control via _OSC, and only disable AER when firmware denies control.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/pci_root.c  |  9 ++-------
 drivers/pci/pcie/aer.c   | 25 +------------------------
 include/linux/pci-acpi.h |  6 ------
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..32b2053bb0fa 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -491,13 +491,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
-	}
+	if (pci_aer_available())
+		control |= OSC_PCI_EXPRESS_AER_CONTROL;
 
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a90a9194ac4a..ac014151b7a6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -316,29 +316,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	return dev->__aer_firmware_first;
 }
 
-static bool aer_firmware_first;
-
-/**
- * aer_acpi_firmware_first - Check if APEI should control AER.
- */
-bool aer_acpi_firmware_first(void)
-{
-	static bool parsed = false;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= NULL,	/* Check all PCIe devices */
-		.firmware_first	= 0,
-	};
-
-	if (pcie_ports_native)
-		return false;
-
-	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
-		aer_firmware_first = info.firmware_first;
-		parsed = true;
-	}
-	return aer_firmware_first;
-}
 #endif
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
@@ -1453,7 +1430,7 @@ static struct pcie_port_service_driver aerdriver = {
  */
 int __init pcie_aer_init(void)
 {
-	if (!pci_aer_available() || aer_acpi_firmware_first())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8082b612f561..2e9c0b973eba 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -116,10 +116,4 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
-#ifdef CONFIG_ACPI_APEI
-extern bool aer_acpi_firmware_first(void);
-#else
-static inline bool aer_acpi_firmware_first(void) { return false; }
-#endif
-
 #endif	/* _PCI_ACPI_H_ */
-- 
2.17.1
