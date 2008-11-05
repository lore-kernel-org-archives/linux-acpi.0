From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 5/7] ACPI,
	PCI: PCIe AER _OSC support capabilities called when root bridge added
Date: Tue, 04 Nov 2008 22:30:00 -0700
Message-ID: <20081105053000.15722.62602.stgit@bob.kio>
References: <20081105052934.15722.98580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:34875 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYKEFaA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 00:30:00 -0500
In-Reply-To: <20081105052934.15722.98580.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com

ACPI, PCI: PCIe AER _OSC support capabilities called when root bridge added

The _OSC capability OSC_EXT_PCI_CONFIG_SUPPORT is set when the root
bridge is added with pci_acpi_osc_support(), so we no longer need to do
it in the PCIe AER driver.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

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

