From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 4/8] ACPI,
	PCI: PCIe AER _OSC support capabilities called when root bridge added
Date: Tue, 28 Oct 2008 23:48:36 -0600
Message-ID: <20081029054836.2263.48337.stgit@bob.kio>
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

ACPI, PCI: PCIe AER _OSC support capabilities called when root bridge added

The _OSC capability OSC_EXT_PCI_CONFIG_SUPPORT is set when the root
bridge is added with pci_acpi_osc_support(), so we no longer need to do
it in the PCIe AER driver.
---

 drivers/pci/pcie/aer/aerdrv_acpi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index 6dd7b13..ebce26c 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -38,7 +38,6 @@ int aer_osc_setup(struct pcie_device *pciedev)
 
 	handle = acpi_find_root_bridge_handle(pdev);
 	if (handle) {
-		pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
 		status = pci_osc_control_set(handle,
 					OSC_PCI_EXPRESS_AER_CONTROL |
 					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
