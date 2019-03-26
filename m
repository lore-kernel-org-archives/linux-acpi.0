From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v2 2/2] PCI/AER: Determine AER ownership based on _OSC instead of HEST
Date: Tue, 26 Mar 2019 12:23:42 -0500
Message-ID: <20190326172343.28946-3-mr.nuke.me@gmail.com>
References: <20190326172343.28946-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326172343.28946-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: austin_bolen@dell.com, alex_gagniuc@dellteam.com, keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org, scott.faasse@hpe.com, leo.duran@amd.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI), however the correct way to determine
AER ownership is the _OSC method.

The ACPI spec allows _OSC and HEST to say things that might not make
sense on a specific hardware implementation.
For example _OSC can say "OS has control" on the root bus, while HEST
says "This PCIe device is firmware-first". This is fine when the
platform can differentiate error sources at the root complex. On x86
platforms, AER errors can be routed to either to an MSI vector
(native AER), or to SMM (firmware-first). As this is done at the root
complex level, the example above would not make sense.

Notice that in neither case is it correct to go to HEST to determine
AER ownership. This is the conclusion of a six-months discussion in
the ACPI Software Working Group.

pci_dev->__aer_firmware_first is used to prevent modification of AER
registers when firmware owns AER. This is synonymous with the AER
ownership negotiated during _OSC. Thus _OSC is the correct way to
use to set this flag, not HEST.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 57 ++----------------------------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d029979e61f6..08cee30b3ef3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -237,66 +237,13 @@ static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
 	return false;
 }
 
-struct aer_hest_parse_info {
-	struct pci_dev *pci_dev;
-	int firmware_first;
-};
-
-static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
-{
-	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
-		return 1;
-	return 0;
-}
-
-static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
-{
-	struct aer_hest_parse_info *info = data;
-	struct acpi_hest_aer_common *p;
-	int ff;
-
-	if (!hest_source_is_pcie_aer(hest_hdr))
-		return 0;
-
-	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
-	ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
-
-	/*
-	 * If no specific device is supplied, determine whether
-	 * FIRMWARE_FIRST is set for *any* PCIe device.
-	 */
-	if (!info->pci_dev) {
-		info->firmware_first |= ff;
-		return 0;
-	}
 
-	/* Otherwise, check the specific device */
-	if (p->flags & ACPI_HEST_GLOBAL) {
-		if (hest_match_type(hest_hdr, info->pci_dev))
-			info->firmware_first = ff;
-	} else
-		if (hest_match_pci(p, info->pci_dev))
-			info->firmware_first = ff;
-
-	return 0;
-}
 
 static void aer_set_firmware_first(struct pci_dev *pci_dev)
 {
-	int rc;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= pci_dev,
-		.firmware_first	= 0,
-	};
+	struct pci_host_bridge *host = pci_find_host_bridge(pci_dev->bus);
 
-	rc = apei_hest_parse(aer_hest_parse, &info);
-
-	if (rc)
-		pci_dev->__aer_firmware_first = 0;
-	else
-		pci_dev->__aer_firmware_first = info.firmware_first;
+	pci_dev->__aer_firmware_first = !host->native_aer;
 	pci_dev->__aer_firmware_first_valid = 1;
 }
 
-- 
2.19.2
