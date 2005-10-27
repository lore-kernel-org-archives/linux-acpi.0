From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 2/3] apci: use stored value of pin from pci_dev
Date: Thu, 27 Oct 2005 12:30:12 -0700
Message-ID: <1130441412.5996.25.camel@whizzy>
References: <20051027192603.488616000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751563AbVJ0TaX@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

plain text document attachment (patch-interrupt-pin-acpi)
Use the stored value of the Interrupt Pin, rather than try to read
it again.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
 
 drivers/acpi/pci_irq.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.13/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.13.orig/drivers/acpi/pci_irq.c
+++ linux-2.6.13/drivers/acpi/pci_irq.c
@@ -361,8 +361,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
 			/* PC card has the same IRQ as its cardbridge */
-			pci_read_config_byte(bridge, PCI_INTERRUPT_PIN,
-					     &bridge_pin);
+			bridge_pin = bridge->pin;
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "No interrupt pin configured for device %s\n",
@@ -412,7 +411,7 @@ int acpi_pci_irq_enable(struct pci_dev *
 	if (!dev)
 		return_VALUE(-EINVAL);
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No interrupt pin configured for device %s\n",
@@ -503,7 +502,7 @@ void acpi_pci_irq_disable(struct pci_dev
 	if (!dev || !dev->bus)
 		return_VOID;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin)
 		return_VOID;
 	pin--;

--
