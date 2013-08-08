From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/2] ACPI / PCI: remove an extra check from acpi_pci_irq_enable()
Date: Thu,  8 Aug 2013 15:35:14 +0300
Message-ID: <1375965314-24232-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:10439 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964805Ab3HHMcD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 08:32:03 -0400
In-Reply-To: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org

acpi_isa_irq_to_gsi() will check if the irq is within
accepted rage so there is no need to check it separately.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/pci_irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 902ed1c..e71e7fa 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -427,9 +427,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 			return -ENOENT;
 		}
 
-		/* Interrupt Line values above 0xF are forbidden */
-		if ((dev->irq <= 0xF) &&
-		    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
+		if (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0) {
 			dev_warn(&dev->dev, "PCI INT %c: no GSI - using ISA IRQ %d\n",
 				 pin_name(pin), dev->irq);
 			acpi_register_gsi(&dev->dev, dev_gsi,
-- 
1.8.3.2

