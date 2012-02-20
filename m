From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Correct irq in ACPI PCI routing table for IBM 3850 M2 and x3950 M2
Date: Mon, 20 Feb 2012 17:45:04 +0100
Message-ID: <1329756304-52877-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48326 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab2BTQp3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2012 11:45:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

This is a quirk for a broken BIOS.

Without this patch and with KMS enabled, the radeon driver will grab irq 16,
which is wrongly defined in the ACPI PRT of the BIOS.
The interrupts for the graphics card happen on irq 18.
This will result in a disabled interupt #18 served by the USB driver:

irq 18: nobody cared (try booting with the "irqpoll" option)
Call Trace:
  [<ffffffff81004402>] dump_trace+0x72/0x300
  ...
handlers:
[<ffffffffa00addf0>] usb_hcd_irq
Disabling IRQ #18

By IBM:
Everything looks good with the patch, in both the broken BIOS case and the
'fixed' BIOS case. I saw no issues simulating a fixed BIOS (custom DSDT).
I tested the patch in 1N and 4N configurations with and without the ATI
IRQ routing fixed.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: lcm@us.ibm.com
---
 drivers/acpi/pci_irq.c |   63 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 0eefa12..5f3591d 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -124,6 +124,28 @@ static const struct dmi_system_id hp_t5710[] = {
 	{ }
 };
 
+static const struct dmi_system_id ibm_3850_M2[] = {
+	{
+		.ident = "IBM 3850 M2 / x3950 M2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "IBM 3850 M2 / x3950 M2"),
+		},
+	},
+	{ }
+};
+
+/*
+ * There are two ways that _PRT can be used
+ * (6.2.11 in ACPI spec)
+ * Either you want to fix the source field, then
+ * provide 2 valid namepath values (broken and fixed)
+ * or
+ * you want to fix a hardwired defined irq in the
+ * source index field then define the broken (BIOS)
+ * and fixed irq values in the index fields.
+ * The {actual_}source fields must be set to NULL then.
+*/
 struct prt_quirk {
 	const struct dmi_system_id *system;
 	unsigned int		segment;
@@ -132,6 +154,8 @@ struct prt_quirk {
 	unsigned char		pin;
 	const char		*source;	/* according to BIOS */
 	const char		*actual_source;
+	unsigned int            index;		/* hardwired irq */
+	unsigned int            actual_index;
 };
 
 #define PCI_INTX_PIN(c)		(c - 'A' + 1)
@@ -151,6 +175,9 @@ static const struct prt_quirk prt_quirks[] = {
 	{ hp_t5710, 0, 0, 1, PCI_INTX_PIN('A'),
 		"\\_SB_.PCI0.LNK1",
 		"\\_SB_.PCI0.LNK3"},
+	{ ibm_3850_M2, 0, 0, 0x1e, PCI_INTX_PIN('A'),
+		NULL, NULL,
+		16, 18},
 };
 
 static void do_prt_fixups(struct acpi_prt_entry *entry,
@@ -170,16 +197,29 @@ static void do_prt_fixups(struct acpi_prt_entry *entry,
 		    entry->id.segment == quirk->segment &&
 		    entry->id.bus == quirk->bus &&
 		    entry->id.device == quirk->device &&
-		    entry->pin == quirk->pin &&
-		    !strcmp(prt->source, quirk->source) &&
-		    strlen(prt->source) >= strlen(quirk->actual_source)) {
-			printk(KERN_WARNING PREFIX "firmware reports "
-				"%04x:%02x:%02x PCI INT %c connected to %s; "
-				"changing to %s\n",
-				entry->id.segment, entry->id.bus,
-				entry->id.device, pin_name(entry->pin),
-				prt->source, quirk->actual_source);
-			strcpy(prt->source, quirk->actual_source);
+		    entry->pin == quirk->pin) {
+			if (quirk->source && quirk->actual_source) {
+				if (!strcmp(prt->source, quirk->source) &&
+				    strlen(prt->source) >= strlen(quirk->actual_source)) {
+					pr_warn(FW_WARN PREFIX "firmware reports "
+						"%04x:%02x:%02x PCI INT %c connected to %s; "
+						"changing to %s\n",
+						entry->id.segment, entry->id.bus,
+						entry->id.device, pin_name(entry->pin),
+						prt->source, quirk->actual_source);
+					strcpy(prt->source, quirk->actual_source);
+				}
+			} else {
+				if (entry->index == quirk->index) {
+					pr_warn(FW_BUG PREFIX "firmware reports "
+						"%04x:%02x:%02x PCI has INT %u, "
+						"changing it to %u\n",
+						entry->id.segment, entry->id.bus,
+						entry->id.device, entry->index,
+						quirk->actual_index);
+					entry->index = quirk->actual_index;
+				}
+			}
 		}
 	}
 }
@@ -202,11 +242,10 @@ static int acpi_pci_irq_add_entry(acpi_handle handle, struct pci_bus *bus,
 	entry->id.bus = bus->number;
 	entry->id.device = (prt->address >> 16) & 0xFFFF;
 	entry->pin = prt->pin + 1;
+	entry->index = prt->source_index;
 
 	do_prt_fixups(entry, prt);
 
-	entry->index = prt->source_index;
-
 	/*
 	 * Type 1: Dynamic
 	 * ---------------
-- 
1.7.6.1

