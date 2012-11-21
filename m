From: Daniel J Blueman <daniel@numascale-asia.com>
Subject: [PATCH RESEND] Fix printing when no interrupt is allocated
Date: Wed, 21 Nov 2012 16:43:21 +0800
Message-ID: <1353487401-10279-1-git-send-email-daniel@numascale-asia.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:41352 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab2KUIne (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Nov 2012 03:43:34 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1631063dak.19
        for <linux-acpi@vger.kernel.org>; Wed, 21 Nov 2012 00:43:34 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel J Blueman <daniel@numascale-asia.com>

Previously a new line is implicitly added in the no GSI case:

[    7.185182] pci 0001:00:12.0: can't derive routing for PCI INT A
[    7.191352] pci 0001:00:12.0: PCI INT A: no GSI
[    7.195956]  - using ISA IRQ 10

The code thus prints a blank line where no legacy IRQ is available:

[    1.650124] pci 0000:00:14.0: can't derive routing for PCI INT A
[    1.650126] pci 0000:00:14.0: PCI INT A: no GSI
[    1.650126] 
[    1.650180] pci 0000:00:14.0: can't derive routing for PCI INT A

Fix this by making the newline explicit and removing the superfluous
one.

Signed-off-by: Daniel J Blueman <daniel@numascale-asia.com>
---
 drivers/acpi/pci_irq.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 0eefa12..2c37996 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -459,7 +459,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 */
 	if (gsi < 0) {
 		u32 dev_gsi;
-		dev_warn(&dev->dev, "PCI INT %c: no GSI", pin_name(pin));
+		dev_warn(&dev->dev, "PCI INT %c: no GSI\n", pin_name(pin));
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq > 0 && (dev->irq <= 0xF) &&
 		    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
@@ -467,11 +467,9 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 			acpi_register_gsi(&dev->dev, dev_gsi,
 					  ACPI_LEVEL_SENSITIVE,
 					  ACPI_ACTIVE_LOW);
-			return 0;
-		} else {
-			printk("\n");
-			return 0;
 		}
+
+		return 0;
 	}
 
 	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
-- 
1.7.9.5

