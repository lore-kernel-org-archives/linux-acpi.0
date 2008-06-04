From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 10/18] PNP: make resource assignment functions return 0 (success) or -EBUSY (failure)
Date: Wed, 04 Jun 2008 16:09:43 -0600
Message-ID: <20080604221128.775325519@ldl.fc.hp.com>
References: <20080604220933.168145536@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:21102 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762713AbYFDWL5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 18:11:57 -0400
Content-Disposition: inline; filename=pnp-change-assignment-return-values
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

This patch doesn't change any behavior; it just makes the return
values more conventional.

This changes pnp_assign_dma() from a void function to one that
returns an int, just like the other assignment functions.  For
now, at least, pnp_assign_dma() always returns 0 (success), so
it appears to never fail, just like before.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/manager.c
===================================================================
--- work10.orig/drivers/pnp/manager.c	2008-05-13 13:27:01.000000000 -0600
+++ work10/drivers/pnp/manager.c	2008-05-13 13:29:05.000000000 -0600
@@ -26,7 +26,7 @@ static int pnp_assign_port(struct pnp_de
 		dev_dbg(&dev->dev, "  io %d already set to %#llx-%#llx "
 			"flags %#lx\n", idx, (unsigned long long) res->start,
 			(unsigned long long) res->end, res->flags);
-		return 1;
+		return 0;
 	}
 
 	res = &local_res;
@@ -51,13 +51,13 @@ static int pnp_assign_port(struct pnp_de
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
@@ -69,7 +69,7 @@ static int pnp_assign_mem(struct pnp_dev
 		dev_dbg(&dev->dev, "  mem %d already set to %#llx-%#llx "
 			"flags %#lx\n", idx, (unsigned long long) res->start,
 			(unsigned long long) res->end, res->flags);
-		return 1;
+		return 0;
 	}
 
 	res = &local_res;
@@ -103,13 +103,13 @@ static int pnp_assign_mem(struct pnp_dev
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
@@ -126,7 +126,7 @@ static int pnp_assign_irq(struct pnp_dev
 	if (res) {
 		dev_dbg(&dev->dev, "  irq %d already set to %d flags %#lx\n",
 			idx, (int) res->start, res->flags);
-		return 1;
+		return 0;
 	}
 
 	res = &local_res;
@@ -154,14 +154,14 @@ static int pnp_assign_irq(struct pnp_dev
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
@@ -175,7 +175,7 @@ static void pnp_assign_dma(struct pnp_de
 	if (res) {
 		dev_dbg(&dev->dev, "  dma %d already set to %d flags %#lx\n",
 			idx, (int) res->start, res->flags);
-		return;
+		return 0;
 	}
 
 	res = &local_res;
@@ -198,6 +198,7 @@ static void pnp_assign_dma(struct pnp_de
 
 __add:
 	pnp_add_dma_resource(dev, res->start, res->flags);
+	return 0;
 }
 
 void pnp_init_resources(struct pnp_dev *dev)
@@ -243,25 +244,26 @@ static int pnp_assign_resources(struct p
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
@@ -281,25 +283,26 @@ static int pnp_assign_resources(struct p
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
