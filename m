From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/4] usb: dwc3: pci: Add PCI ID for Intel Braswell
Date: Wed, 20 Aug 2014 14:55:25 +0300
Message-ID: <1408535728-10518-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

The device controller is the same but it has different PCI ID. Add this new
ID to the driver's list of supported IDs.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index a60bab7..3eb0229 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -30,6 +30,7 @@
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3	0xabcd
 #define PCI_DEVICE_ID_INTEL_BYT		0x0f37
 #define PCI_DEVICE_ID_INTEL_MRFLD	0x119e
+#define PCI_DEVICE_ID_INTEL_BSW		0x22B7
 
 struct dwc3_pci {
 	struct device		*dev;
@@ -183,6 +184,7 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS,
 				PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3),
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BSW), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRFLD), },
 	{  }	/* Terminating Entry */
-- 
2.1.0
