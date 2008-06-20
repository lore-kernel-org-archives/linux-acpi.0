From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/70] PNP: remove ratelimit on add resource failures
Date: Fri, 20 Jun 2008 03:43:48 -0400
Message-ID: <62394f6f292d4111a8b210e7efb5d9ed3c53de5e.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40470 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYFTHos (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:48 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00EKE46I1LE2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:43 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

We used to have a fixed-size resource table.  If a device had
twenty resources when the table only had space for ten, we didn't
need ten warnings, so we added the ratelimit.

Now that we can dynamically allocate new resources, we should
only get failures if the allocation fails.  That should be
rare enough that we don't need to ratelimit the messages.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/resource.c |   34 ++++++++--------------------------
 1 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 0797a77..ff79aa6 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -537,15 +537,10 @@ struct pnp_resource *pnp_add_irq_resource(struct pnp_dev *dev, int irq,
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for IRQ %d\n",
-				irq);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for IRQ %d\n", irq);
 		return NULL;
 	}
 
@@ -563,15 +558,10 @@ struct pnp_resource *pnp_add_dma_resource(struct pnp_dev *dev, int dma,
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for DMA %d\n",
-				dma);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for DMA %d\n", dma);
 		return NULL;
 	}
 
@@ -590,16 +580,12 @@ struct pnp_resource *pnp_add_io_resource(struct pnp_dev *dev,
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for IO "
-				"%#llx-%#llx\n",(unsigned long long) start,
-				(unsigned long long) end);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for IO %#llx-%#llx\n",
+			(unsigned long long) start,
+			(unsigned long long) end);
 		return NULL;
 	}
 
@@ -619,16 +605,12 @@ struct pnp_resource *pnp_add_mem_resource(struct pnp_dev *dev,
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for MEM "
-				"%#llx-%#llx\n",(unsigned long long) start,
-				(unsigned long long) end);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for MEM %#llx-%#llx\n",
+			(unsigned long long) start,
+			(unsigned long long) end);
 		return NULL;
 	}
 
-- 
1.5.6

