From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/6] ACPI: fix Medion _PRT quirk (use "ISA_", not "ISA")
Date: Wed, 26 Mar 2008 01:13:36 -0400
Message-ID: <d8fcfa43c6f4d4371c17cdcae1770bef74899d73.1206508358.git.len.brown@intel.com>
References: <1206508420-2755-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:44118 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753330AbYCZFVf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 01:21:35 -0400
In-Reply-To: <1206508420-2755-1-git-send-email-lenb@kernel.org>
In-Reply-To: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
References: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This fixes the builtin RTL8139 NIC on the Medion MD9580-F laptop.  The BIOS
reports the interrupt routing incorrectly.  I recently added a quirk to work
around this, and this patch fixes a typo in the quirk.

We pad every ACPI pathname component to four characters, so ".ISA." will never
match anything.  We need ".ISA_." instead.

Thank you Johann-Nikolaus Andreae for patiently testing this patch.

See http://bugzilla.kernel.org/show_bug.cgi?id=4773

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 7af414a..89022a7 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -131,8 +131,8 @@ struct prt_quirk {
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
-- 
1.5.5.rc1.6.g5cc8f

