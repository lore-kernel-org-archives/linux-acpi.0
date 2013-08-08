From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/2] ACPI / PCI: don't allow PCI devices without irq to be enabled
Date: Thu,  8 Aug 2013 15:35:13 +0300
Message-ID: <1375965314-24232-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28171 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964831Ab3HHMcD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 08:32:03 -0400
In-Reply-To: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org

If there is no ACPI entry for the irq, returning error from
acpi_pci_enable_irq() if the irq is 0.

Prarit Bhargava reported an issue where he noticed that his
Dell PowerEdge 840 has buggy BIOS that does not supply ACPI
entries for irq with some devices. That lead into kernel
generating a warning "genirq: Flags mismatch irq 0...". This
will fix that issue.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/acpi/pci_irq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 41c5e1b..902ed1c 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -419,8 +419,16 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 */
 	if (gsi < 0) {
 		u32 dev_gsi;
+
+		/* Not accepting 0 as valid PCI IRQ. */
+		if (!dev->irq) {
+			dev_err(&dev->dev, "PCI INT %c: no IRQ\n",
+				pin_name(pin));
+			return -ENOENT;
+		}
+
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq > 0 && (dev->irq <= 0xF) &&
+		if ((dev->irq <= 0xF) &&
 		    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
 			dev_warn(&dev->dev, "PCI INT %c: no GSI - using ISA IRQ %d\n",
 				 pin_name(pin), dev->irq);
-- 
1.8.3.2

