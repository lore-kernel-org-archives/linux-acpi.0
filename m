From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/8] ACPI : Not register gsi for PCI IDE controller in legacy mode
Date: Fri, 11 Jan 2008 15:11:31 -0500
Message-ID: <96c2a8766bf4fe91abac863749c11637fabcc64f.1200082104.git.len.brown@intel.com>
References: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:42745 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760464AbYAKUke (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 15:40:34 -0500
In-Reply-To: <1200082294-29742-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
References: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

When PCI IDE controller works in legacy mode and no PRT entry is found
in ACPI PRT table, OSPM will neither read the irq number from the IDE
PCI configuration space nor call the function of acpi_register_gsi to
register gsi.

http://bugzilla.kernel.org/show_bug.cgi?id=5637

Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index dd3186a..62010c2 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -429,6 +429,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 					  &polarity, &link,
 					  acpi_pci_allocate_irq);
 
+	if (irq < 0) {
+		/*
+		 * IDE legacy mode controller IRQs are magic. Why do compat
+		 * extensions always make such a nasty mess.
+		 */
+		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE &&
+				(dev->class & 0x05) == 0)
+			return 0;
+	}
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
-- 
1.5.4.rc2.84.gf85fd

