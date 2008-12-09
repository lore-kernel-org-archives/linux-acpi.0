From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 04/20] ACPI: PCI: ignore _PRT function information
Date: Mon, 08 Dec 2008 21:30:20 -0700
Message-ID: <20081209043020.26415.55555.stgit@bob.kio>
References: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:18960 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbYLIEaW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:22 -0500
In-Reply-To: <20081209042833.26415.24906.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

_PRT entries don't contain any useful PCI function information (the
function part of the PCI address is supposed to be 0xffff), and we
don't ever look at it, so this patch just removes the reference to
it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_irq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 0a31527..579bf17 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -187,7 +187,6 @@ acpi_pci_irq_add_entry(acpi_handle handle,
 	entry->id.segment = segment;
 	entry->id.bus = bus;
 	entry->id.device = (prt->address >> 16) & 0xFFFF;
-	entry->id.function = prt->address & 0xFFFF;
 	entry->pin = prt->pin;
 
 	do_prt_fixups(entry, prt);

