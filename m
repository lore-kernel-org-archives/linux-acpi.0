From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 2/4] PCI ACPI: AER driver should only register PCIe devices
	with _OSC.
Date: Tue, 22 Jan 2008 17:18:17 -0700
Message-ID: <20080123001817.28190.42322.stgit@bluto.andrew>
References: <20080123001807.28190.32648.stgit@bluto.andrew>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:22203 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbYAWASS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 19:18:18 -0500
In-Reply-To: <20080123001807.28190.32648.stgit@bluto.andrew>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, gregkh@suse.de, matthew@wil.cx, tom.l.nguyen@intel.com, linux-acpi@vger.kernel.org, Andrew Patterson <andrew.patterson@hp.com>

From: Andrew Patterson <andrew.patterson@hp.com>

AER is only used with PCIe devices so we should only check PCIe devices for
_OSC support.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

 drivers/pci/pcie/aer/aerdrv_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index 1a1eb45..f685bf5 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -50,7 +50,7 @@ int aer_osc_setup(struct pcie_device *pciedev)
 	}
 
 	if (handle) {
-		pci_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
+		pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
 		status = pci_osc_control_set(handle,
 					OSC_PCI_EXPRESS_AER_CONTROL |
 					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);

