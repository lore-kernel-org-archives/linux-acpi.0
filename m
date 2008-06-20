From: Len Brown <lenb@kernel.org>
Subject: [PATCH 56/70] PNP: make resource assignment functions return 0
 (success) or -EBUSY (failure)
Date: Fri, 20 Jun 2008 03:43:58 -0400
Message-ID: <c88e59de89044d23ba04cab95b42e01f6e9073c5.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:62938 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYFTHpQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:45:16 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00A7A46X89S2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:45:03 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch doesn't change any behavior; it just makes the return
values more conventional.

This changes pnp_assign_dma() from a void function to one that
returns an int, just like the other assignment functions.  For
now, at least, pnp_assign_dma() always returns 0 (success), so
it appears to never fail, just like before.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/manager.c |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index c706dd2..1adc83f 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -26,7 +26,7 @@ static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 		dev_dbg(&dev->dev, "  io %d already set to %#llx-%#llx "
 			"flags %#lx\n", idx, (unsigned long long) res->start,
 			(unsigned long long) res->end, res->flags);
-		return 1;
+		return 0;
 	}
 
 	res = &local_res;
@@ -51,13 +51,13 @@ static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 				"(min %#llx max %#llx)\n", idx,
 				(unsigned long long) rule->min,
 				(unsigned long long) rule->max);
-			return 0;
+			return -EBUSY;
 		}
 	}
 
 __add:
 	pnp_add_io_resource(dev, res->start, res->end, res->flags);
-	return 1;
+	return 0;
 }
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
@@ -69,7 +69,7 @@ static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 		dev_dbg(&dev->dev, "  mem %d already set to %#llx-%#llx "
 			"flags %#lx\n", idx, (unsigned long long) res->start,
 			(unsigned long long) res->end, res->flags);
-		return 1;
+		return 0;
 	}
 
 	res = &local_res;
@@ -103,13 +103,13 @@ static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 				"(min %#llx max %#llx)\n", idx,
 				(unsigned long long) rule->min,
 				(unsigned long long) rule->max);
-			return 0;
+			return -EBUSY;
 		}
 	}
 
 __add:
 	pnp_add_mem_resource(dev, res->start, res->end, res->flags);
-	return 1;
+	return 0;
 }
 
 static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
@@ -126,7 +126,7 @@ static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 	if (res) {
 		dev_dbg(&dev->dev, "  irq %d already set to %d flags %#lx\n",
 			idx, (int) res->start, res->flags);
-		return 1;
+		return 0;
 	}
 
 	res = &local_res;
@@ -154,14 +154,14 @@ static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 		}
 	}
 	dev_dbg(&dev->dev, "  couldn't assign irq %d\n", idx);
-	return 0;
+	return -EBUSY;
 
 __add:
 	pnp_add_irq_resource(dev, res->start, res->flags);
-	return 1;
+	return 0;
 }
 
-static void pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
+static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
 	struct resource *res, local_res;
 	int i;
@@ -175,7 +175,7 @@ static void pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 	if (res) {
 		dev_dbg(&dev->dev, "  dma %d already set to %d flags %#lx\n",
 			idx, (int) res->start, res->flags);
-		return;
+		return 0;
 	}
 
 	res = &local_res;
@@ -198,6 +198,7 @@ static void pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 
 __add:
 	pnp_add_dma_resource(dev, res->start, res->flags);
+	return 0;
 }
 
 void pnp_init_resources(struct pnp_dev *dev)
@@ -243,25 +244,26 @@ static int pnp_assign_resources(struct pnp_dev *dev, int depnum)
 		irq = dev->independent->irq;
 		dma = dev->independent->dma;
 		while (port) {
-			if (!pnp_assign_port(dev, port, nport))
+			if (pnp_assign_port(dev, port, nport) < 0)
 				goto fail;
 			nport++;
 			port = port->next;
 		}
 		while (mem) {
-			if (!pnp_assign_mem(dev, mem, nmem))
+			if (pnp_assign_mem(dev, mem, nmem) < 0)
 				goto fail;
 			nmem++;
 			mem = mem->next;
 		}
 		while (irq) {
-			if (!pnp_assign_irq(dev, irq, nirq))
+			if (pnp_assign_irq(dev, irq, nirq) < 0)
 				goto fail;
 			nirq++;
 			irq = irq->next;
 		}
 		while (dma) {
-			pnp_assign_dma(dev, dma, ndma);
+			if (pnp_assign_dma(dev, dma, ndma) < 0)
+				goto fail;
 			ndma++;
 			dma = dma->next;
 		}
@@ -281,25 +283,26 @@ static int pnp_assign_resources(struct pnp_dev *dev, int depnum)
 		irq = dep->irq;
 		dma = dep->dma;
 		while (port) {
-			if (!pnp_assign_port(dev, port, nport))
+			if (pnp_assign_port(dev, port, nport) < 0)
 				goto fail;
 			nport++;
 			port = port->next;
 		}
 		while (mem) {
-			if (!pnp_assign_mem(dev, mem, nmem))
+			if (pnp_assign_mem(dev, mem, nmem) < 0)
 				goto fail;
 			nmem++;
 			mem = mem->next;
 		}
 		while (irq) {
-			if (!pnp_assign_irq(dev, irq, nirq))
+			if (pnp_assign_irq(dev, irq, nirq) < 0)
 				goto fail;
 			nirq++;
 			irq = irq->next;
 		}
 		while (dma) {
-			pnp_assign_dma(dev, dma, ndma);
+			if (pnp_assign_dma(dev, dma, ndma) < 0)
+				goto fail;
 			ndma++;
 			dma = dma->next;
 		}
-- 
1.5.6

