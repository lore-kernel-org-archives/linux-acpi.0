From: Thomas Renninger <trenn@suse.de>
Subject: Suppress acpi_pci_irq_derive "Unable to derive IRQ" msg
Date: Tue, 7 Mar 2006 07:49:50 +0100
Message-ID: <200603070749.51249.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:17853 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752014AbWCGGtx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2006 01:49:53 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: edwardsg@sgi.com, "Brown, Len" <len.brown@intel.com>

This message:
ACPI Warning (pci_irq-0383): Unable to derive IRQ for device 0001:00:04.0
[20060127]

seem to appear on a couple of machines which don't provide IRQ info via ACPI.
There should appear a message like:

printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
	       pci_name(dev), ('A' + pin));

in this case anyway, therefore just reverting this message to Debug/Info message should
be OK...

Subject: Suppress acpi_irq_derive failed message.

Suppress acpi_irq_derive failed message as a warning is printed
out in a higher function anyway if no irq could be derived

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/pci_irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.15/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/pci_irq.c
+++ linux-2.6.15/drivers/acpi/pci_irq.c
@@ -379,8 +379,8 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	}
 
 	if (irq < 0) {
-		ACPI_WARNING((AE_INFO, "Unable to derive IRQ for device %s",
-			      pci_name(dev)));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unable to derive IRQ for device %s",
+				  pci_name(dev)));
 		return_VALUE(-1);
 	}
 
