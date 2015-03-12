From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 4/4] PCI: Fail pci_ioremap_bar() on unassigned resources
Date: Thu, 12 Mar 2015 12:35:46 -0500
Message-ID: <20150312173546.1052.76075.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42171 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030316AbbCLRfs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 13:35:48 -0400
Received: by obbnt9 with SMTP id nt9so15486750obb.9
        for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2015 10:35:48 -0700 (PDT)
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Make pci_ioremap_bar() fail if we're trying to map a BAR that hasn't been
assigned.

Normally pci_enable_device() will fail if a BAR hasn't been assigned, but a
driver can successfully call pci_enable_device_io() even if a memory BAR
hasn't been assigned.  That driver should not be able to use
pci_ioremap_bar() to map that unassigned memory BAR.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a6d191ad9743..28df200bc54c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -131,7 +131,7 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 	/*
 	 * Make sure the BAR is actually a memory resource, not an IO resource
 	 */
-	if (!(res->flags & IORESOURCE_MEM)) {
+	if (res->flags & IORESOURCE_UNSET || !(res->flags & IORESOURCE_MEM)) {
 		dev_warn(&pdev->dev, "can't ioremap BAR %d: %pR\n", bar, res);
 		return NULL;
 	}

