From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/94] ACPI: PCI: ignore _PRT function information
Date: Fri, 09 Jan 2009 04:26:44 -0500
Message-ID: <b52b3f4af83571e86f910b07a61b177e2b7d8409.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbZAIJ2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:45 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700MJ06AWW493@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:09 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

_PRT entries don't contain any useful PCI function information (the
function part of the PCI address is supposed to be 0xffff), and we
don't ever look at it, so this patch just removes the reference to
it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 6a9f3dd..c6a0364 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -185,7 +185,6 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 	entry->id.segment = segment;
 	entry->id.bus = bus;
 	entry->id.device = (prt->address >> 16) & 0xFFFF;
-	entry->id.function = prt->address & 0xFFFF;
 	entry->pin = prt->pin;
 
 	do_prt_fixups(entry, prt);
-- 
1.5.6.6

