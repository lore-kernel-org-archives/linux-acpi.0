From: akpm@linux-foundation.org
Subject: [patch 4/7] acpi_pci_irq_find_prt_entry(): use list_for_each_entry() instead of list_for_each()
Date: Mon, 04 Feb 2008 23:31:20 -0800
Message-ID: <200802050731.m157V1CU009687@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56847 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753401AbYBEHbr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 02:31:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, matthias.kaehlcke@gmail.com

From: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

acpi_pci_irq_find_prt_entry(): use list_for_each_entry() instead of
list_for_each()

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/pci_irq.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff -puN drivers/acpi/pci_irq.c~acpi_pci_irq_find_prt_entry-use-list_for_each_entry-instead-of-list_for_each drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c~acpi_pci_irq_find_prt_entry-use-list_for_each_entry-instead-of-list_for_each
+++ a/drivers/acpi/pci_irq.c
@@ -51,10 +51,8 @@ static struct acpi_prt_entry *acpi_pci_i
 							  int bus,
 							  int device, int pin)
 {
-	struct list_head *node = NULL;
 	struct acpi_prt_entry *entry = NULL;
 
-
 	if (!acpi_prt.count)
 		return NULL;
 
@@ -64,8 +62,7 @@ static struct acpi_prt_entry *acpi_pci_i
 	 *
 	 */
 	spin_lock(&acpi_prt_lock);
-	list_for_each(node, &acpi_prt.entries) {
-		entry = list_entry(node, struct acpi_prt_entry, node);
+	list_for_each_entry(entry, &acpi_prt.entries, node) {
 		if ((segment == entry->id.segment)
 		    && (bus == entry->id.bus)
 		    && (device == entry->id.device)
_
