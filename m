From: Stefan Assmann <sassmann@kpanic.de>
Subject: [PATCH] ACPI: skip boot interrupt rerouting when index is zero
Date: Fri, 10 Feb 2017 12:45:17 +0100
Message-ID: <20170210114517.14812-1-sassmann@kpanic.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdBJLrc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Feb 2017 06:47:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@rjwysocki.net, sassmann@kpanic.de

When checking for boot interrupts and PRT index is zero avoid doing
any interrupt rerouting since the code currently does not handle
determining the IRQ via _CRS method.

Fixes:
https://bugzilla.kernel.org/show_bug.cgi?id=43074

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/acpi/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index c576a6f..6ecbde0 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -280,7 +280,7 @@ static int bridge_has_boot_interrupt_variant(struct pci_bus *bus)
 static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
 				       struct acpi_prt_entry *entry)
 {
-	if (noioapicquirk || noioapicreroute) {
+	if (noioapicquirk || noioapicreroute || entry->index == 0) {
 		return 0;
 	} else {
 		switch (bridge_has_boot_interrupt_variant(dev->bus)) {
-- 
2.9.3

