From: akpm@linux-foundation.org
Subject: [patch 7/7] drivers/acpi/pci_link.c: lower printk severity
Date: Mon, 09 Jul 2007 11:33:18 -0700
Message-ID: <200707091833.l69IXIo8000354@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53396 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754545AbXGISdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 14:33:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, da-x@monatomic.org

From: Dan Aloni <da-x@monatomic.org>

Signed-off-by: Dan Aloni <da-x@monatomic.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/pci_link.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/pci_link.c~drivers-acpi-pci_linkc-lower-printk-severity drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c~drivers-acpi-pci_linkc-lower-printk-severity
+++ a/drivers/acpi/pci_link.c
@@ -733,7 +733,7 @@ static int acpi_pci_link_add(struct acpi
 	/* query and set link->irq.active */
 	acpi_pci_link_get_current(link);
 
-	printk(PREFIX "%s [%s] (IRQs", acpi_device_name(device),
+	printk(KERN_INFO PREFIX "%s [%s] (IRQs", acpi_device_name(device),
 	       acpi_device_bid(device));
 	for (i = 0; i < link->irq.possible_count; i++) {
 		if (link->irq.active == link->irq.possible[i]) {
_
