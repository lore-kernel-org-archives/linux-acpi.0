From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: fix Medion _PRT quirk (use "ISA_", not "ISA")
Date: Tue, 25 Mar 2008 11:21:11 -0600
Message-ID: <200803251121.13050.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:11061 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbYCYRRU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 13:17:20 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>, Linus Torvalds <torvalds@linux-foundation.org>

[It would be nice to have this in 2.6.25.  It only affects the
builtin NIC on the Medion MD9580-F laptop, which is currently
broken due to an IRQ routing problem, and Johann-Nikolaus has
verified that this fixes the problem.]

This fixes the builtin RTL8139 NIC on the Medion MD9580-F laptop.
The BIOS reports the interrupt routing incorrectly.  I recently
added a quirk to work around this, and this patch fixes a typo
in the quirk.

We pad every ACPI pathname component to four characters, so ".ISA."
will never match anything.  We need ".ISA_." instead.

Thank you Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>
for patiently testing this patch.

See http://bugzilla.kernel.org/show_bug.cgi?id=4773

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/acpi/pci_irq.c
===================================================================
--- work7.orig/drivers/acpi/pci_irq.c	2008-03-25 08:51:42.000000000 -0600
+++ work7/drivers/acpi/pci_irq.c	2008-03-25 08:52:03.000000000 -0600
@@ -131,8 +131,8 @@
  */
 static struct prt_quirk prt_quirks[] = {
 	{ medion_md9580, 0, 0, 9, 'A',
-		"\\_SB_.PCI0.ISA.LNKA",
-		"\\_SB_.PCI0.ISA.LNKB"},
+		"\\_SB_.PCI0.ISA_.LNKA",
+		"\\_SB_.PCI0.ISA_.LNKB"},
 	{ dell_optiplex, 0, 0, 0xd, 'A',
 		"\\_SB_.LNKB",
 		"\\_SB_.LNKA"},
