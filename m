From: Len Brown <lenb@kernel.org>
Subject: [PATCH 65/70] PNP: avoid legacy IDE IRQs
Date: Fri, 20 Jun 2008 03:44:07 -0400
Message-ID: <a35f889f77f580f1faa545f91afbc55335910b33.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63340 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYFTHri (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:47:38 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00A9E4BDA6T2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:47:38 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

If an IDE controller is in compatibility mode, it expects to use
IRQs 14 and 15, so PNP should avoid them.

This patch should resolve this problem report:
  parallel driver grabs IRQ14 preventing legacy SFF ATA controller from working
  https://bugzilla.novell.com/show_bug.cgi?id=375836

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/resource.c |   69 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index d638897..e0e853d 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/libata.h>
 
 #include <linux/pnp.h>
 #include "base.h"
@@ -286,6 +287,61 @@ static irqreturn_t pnp_test_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_PCI
+static int pci_dev_uses_irq(struct pnp_dev *pnp, struct pci_dev *pci,
+			    unsigned int irq)
+{
+	u32 class;
+	u8 progif;
+
+	if (pci->irq == irq) {
+		dev_dbg(&pnp->dev, "device %s using irq %d\n",
+			pci_name(pci), irq);
+		return 1;
+	}
+
+	/*
+	 * See pci_setup_device() and ata_pci_sff_activate_host() for
+	 * similar IDE legacy detection.
+	 */
+	pci_read_config_dword(pci, PCI_CLASS_REVISION, &class);
+	class >>= 8;		/* discard revision ID */
+	progif = class & 0xff;
+	class >>= 8;
+
+	if (class == PCI_CLASS_STORAGE_IDE) {
+		/*
+		 * Unless both channels are native-PCI mode only,
+		 * treat the compatibility IRQs as busy.
+		 */
+		if ((progif & 0x5) != 0x5)
+			if (ATA_PRIMARY_IRQ(pci) == irq ||
+			    ATA_SECONDARY_IRQ(pci) == irq) {
+				dev_dbg(&pnp->dev, "legacy IDE device %s "
+					"using irq %d\n", pci_name(pci), irq);
+				return 1;
+			}
+	}
+
+	return 0;
+}
+#endif
+
+static int pci_uses_irq(struct pnp_dev *pnp, unsigned int irq)
+{
+#ifdef CONFIG_PCI
+	struct pci_dev *pci = NULL;
+
+	for_each_pci_dev(pci) {
+		if (pci_dev_uses_irq(pnp, pci, irq)) {
+			pci_dev_put(pci);
+			return 1;
+		}
+	}
+#endif
+	return 0;
+}
+
 int pnp_check_irq(struct pnp_dev *dev, struct resource *res)
 {
 	int i;
@@ -317,18 +373,9 @@ int pnp_check_irq(struct pnp_dev *dev, struct resource *res)
 		}
 	}
 
-#ifdef CONFIG_PCI
 	/* check if the resource is being used by a pci device */
-	{
-		struct pci_dev *pci = NULL;
-		for_each_pci_dev(pci) {
-			if (pci->irq == *irq) {
-				pci_dev_put(pci);
-				return 0;
-			}
-		}
-	}
-#endif
+	if (pci_uses_irq(dev, *irq))
+		return 0;
 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
-- 
1.5.6

