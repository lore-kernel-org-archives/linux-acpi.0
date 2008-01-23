From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 4/4] PCI: Run ACPI _OSC method on root bridges only
Date: Tue, 22 Jan 2008 17:18:27 -0700
Message-ID: <20080123001827.28190.7908.stgit@bluto.andrew>
References: <20080123001807.28190.32648.stgit@bluto.andrew>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:6182 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbYAWAS3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 19:18:29 -0500
In-Reply-To: <20080123001807.28190.32648.stgit@bluto.andrew>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, gregkh@suse.de, matthew@wil.cx, tom.l.nguyen@intel.com, linux-acpi@vger.kernel.org, Andrew Patterson <andrew.patterson@hp.com>

From: Andrew Patterson <andrew.patterson@hp.com>

According to the PCI Firmware Specification Revision 3.0 section 4.5, _OSC
should only be called on a root brdige.  Here is the relevant passage: "The
_OSC interface defined in this section applies only to Host Bridge ACPI
devices that originate PCI, PCI-X, or PCI Express hierarchies". Changed the
code to find the parent root bridge of the device and call _OSC on that.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

 drivers/pci/pcie/aer/aerdrv_acpi.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index f685bf5..8c199ae 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -31,23 +31,13 @@ int aer_osc_setup(struct pcie_device *pciedev)
 {
 	acpi_status status = AE_NOT_FOUND;
 	struct pci_dev *pdev = pciedev->port;
-	acpi_handle handle = DEVICE_ACPI_HANDLE(&pdev->dev);
-	struct pci_bus *parent;
+	acpi_handle handle = 0;
 
-	while (!handle) {
-		if (!pdev || !pdev->bus->parent)
-			break;
-		parent = pdev->bus->parent;
-		if (!parent->self)
-			/* Parent must be a host bridge */
-			handle = acpi_get_pci_rootbridge_handle(
-					pci_domain_nr(parent),
-					parent->number);
-		else
-			handle = DEVICE_ACPI_HANDLE(
-					&(parent->self->dev));
-		pdev = parent->self;
-	}
+	/* Find root host bridge */
+	while (pdev->bus && pdev->bus->self)
+		pdev = pdev->bus->self;
+	handle = acpi_get_pci_rootbridge_handle(
+		pci_domain_nr(pdev->bus), pdev->bus->number);
 
 	if (handle) {
 		pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);

