From: Len Brown <lenb@kernel.org>
Subject: [PATCH 47/94] ACPI: PCI: use 1-based encoding for _PRT quirks
Date: Fri, 09 Jan 2009 04:26:49 -0500
Message-ID: <c458033c9b72a81b890d97ec6339694bab252383.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbZAIJ2W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004VH68N1GW6@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:48 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Use the PCI INTx pin encoding (1=INTA, 2=INTB, etc) for _PRT quirks.
Then we can simply compare "entry->pin == quirk->pin".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 2c52cf0..c4a5c49 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -145,19 +145,21 @@ struct prt_quirk {
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
@@ -179,7 +181,7 @@ do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
 		    entry->id.segment == quirk->segment &&
 		    entry->id.bus == quirk->bus &&
 		    entry->id.device == quirk->device &&
-		    pin_name(entry->pin) == quirk->pin &&
+		    entry->pin == quirk->pin &&
 		    !strcmp(prt->source, quirk->source) &&
 		    strlen(prt->source) >= strlen(quirk->actual_source)) {
 			printk(KERN_WARNING PREFIX "firmware reports "
-- 
1.5.6.6

