From: Len Brown <lenb@kernel.org>
Subject: [PATCH 032/122] PNP: fix debug formatting (cosmetic)
Date: Thu, 23 Oct 2008 02:38:06 -0400
Message-ID: <6a0b93bae96f292b6c091cce5abfb9a644e649e9.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:46342 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbYJWGj4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:56 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600K9MIIIT2E2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:54 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch just fixes indentation of a couple debug messages.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/resource.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 4cfe3a1..e0206da 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -294,7 +294,7 @@ static int pci_dev_uses_irq(struct pnp_dev *pnp, struct pci_dev *pci,
 	u8 progif;
 
 	if (pci->irq == irq) {
-		dev_dbg(&pnp->dev, "device %s using irq %d\n",
+		dev_dbg(&pnp->dev, "  device %s using irq %d\n",
 			pci_name(pci), irq);
 		return 1;
 	}
@@ -316,7 +316,7 @@ static int pci_dev_uses_irq(struct pnp_dev *pnp, struct pci_dev *pci,
 		if ((progif & 0x5) != 0x5)
 			if (pci_get_legacy_ide_irq(pci, 0) == irq ||
 			    pci_get_legacy_ide_irq(pci, 1) == irq) {
-				dev_dbg(&pnp->dev, "legacy IDE device %s "
+				dev_dbg(&pnp->dev, "  legacy IDE device %s "
 					"using irq %d\n", pci_name(pci), irq);
 				return 1;
 			}
-- 
1.5.5.1

