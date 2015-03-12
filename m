From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 2/4] PCI: Mark invalid BARs as unassigned
Date: Thu, 12 Mar 2015 12:35:33 -0500
Message-ID: <20150312173533.1052.46464.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:42840 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964788AbbCLRff (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 13:35:35 -0400
Received: by oiav63 with SMTP id v63so15828801oia.9
        for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2015 10:35:35 -0700 (PDT)
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

If a BAR is not inside any upstream bridge window, or if it conflicts with
another resource, mark it as IORESOURCE_UNSET so we don't try to use it.
We may be able to assign a different address for it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index b7c3a5ea1fca..232f9254c11a 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -120,6 +120,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 	if (!root) {
 		dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible bridge window\n",
 			 resource, res);
+		res->flags |= IORESOURCE_UNSET;
 		return -EINVAL;
 	}
 
@@ -127,6 +128,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 	if (conflict) {
 		dev_info(&dev->dev, "can't claim BAR %d %pR: address conflict with %s %pR\n",
 			 resource, res, conflict->name, conflict);
+		res->flags |= IORESOURCE_UNSET;
 		return -EBUSY;
 	}
 

