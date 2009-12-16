From: Len Brown <lenb@kernel.org>
Subject: [PATCH 078/103] ipmi: remove unused PCI probe code
Date: Wed, 16 Dec 2009 03:36:29 -0500
Message-ID: <ad497680a5ff646e645752e3e065a752f32f12f8.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62434 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761886AbZLPJGN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:13 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:57 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index d2e6980..aaf6ead 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2202,7 +2202,6 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
 	int rv;
 	int class_type = pdev->class & PCI_ERMC_CLASSCODE_TYPE_MASK;
 	struct smi_info *info;
-	int first_reg_offset = 0;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -2241,9 +2240,6 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
 	info->addr_source_cleanup = ipmi_pci_cleanup;
 	info->addr_source_data = pdev;
 
-	if (pdev->subsystem_vendor == PCI_HP_VENDOR_ID)
-		first_reg_offset = 1;
-
 	if (pci_resource_flags(pdev, 0) & IORESOURCE_IO) {
 		info->io_setup = port_setup;
 		info->io.addr_type = IPMI_IO_ADDR_SPACE;
-- 
1.6.0.6

