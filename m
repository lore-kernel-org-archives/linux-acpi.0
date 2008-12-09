From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 09/20] ACPI: PCI: use 1-based encoding for _PRT quirks
Date: Mon, 08 Dec 2008 21:30:46 -0700
Message-ID: <20081209043046.26415.42237.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:39262 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYLIEaq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:46 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Use the PCI INTx pin encoding (1=INTA, 2=INTB, etc) for _PRT quirks.
Then we can simply compare "entry->pin == quirk->pin".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 0036055..eea15fd 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -147,19 +147,21 @@ struct prt_quirk {
 	char			*actual_source;
 };
 
+#define PCI_INTX_PIN(c)		(c - 'A' + 1)
+
 /*
  * These systems have incorrect _PRT entries.  The BIOS claims the PCI
  * interrupt at the listed segment/bus/device/pin is connected to the first
  * link device, but it is actually connected to the second.
  */
 static struct prt_quirk prt_quirks[] = {
-	{ medion_md9580, 0, 0, 9, 'A',
+	{ medion_md9580, 0, 0, 9, PCI_INTX_PIN('A'),
 		"\\_SB_.PCI0.ISA_.LNKA",
 		"\\_SB_.PCI0.ISA_.LNKB"},
-	{ dell_optiplex, 0, 0, 0xd, 'A',
+	{ dell_optiplex, 0, 0, 0xd, PCI_INTX_PIN('A'),
 		"\\_SB_.LNKB",
 		"\\_SB_.LNKA"},
-	{ hp_t5710, 0, 0, 1, 'A',
+	{ hp_t5710, 0, 0, 1, PCI_INTX_PIN('A'),
 		"\\_SB_.PCI0.LNK1",
 		"\\_SB_.PCI0.LNK3"},
 };
@@ -181,7 +183,7 @@ do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
 		    entry->id.segment == quirk->segment &&
 		    entry->id.bus == quirk->bus &&
 		    entry->id.device == quirk->device &&
-		    pin_name(entry->pin) == quirk->pin &&
+		    entry->pin == quirk->pin &&
 		    !strcmp(prt->source, quirk->source) &&
 		    strlen(prt->source) >= strlen(quirk->actual_source)) {
 			printk(KERN_WARNING PREFIX "firmware reports "

