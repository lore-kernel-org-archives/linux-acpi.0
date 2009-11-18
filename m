From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v1 3/5] ipmi: remove unused PCI probe code
Date: Tue, 17 Nov 2009 17:05:24 -0700
Message-ID: <20091118000524.14214.41587.stgit@bob.kio>
References: <20091118000427.14214.14043.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:1163 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZKRAFS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 19:05:18 -0500
In-Reply-To: <20091118000427.14214.14043.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

