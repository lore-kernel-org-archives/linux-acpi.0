From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 37/53] PNP: add pnp_resource index for ISAPNP
Date: Fri, 18 Apr 2008 14:50:32 -0600
Message-ID: <20080418205054.712464428@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763310AbYDRVG1@vger.kernel.org>
Content-Disposition: inline; filename=pnp-add-pnp_resource-index
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Save the ISAPNP config register index in the struct pnp_resource.

We need this because it is important to write ISAPNP configuration
back to the same registers we read it from.  For example, if we
read valid regions from memory descriptors 0, 1, and 3, we'd
better write them back to the same registers, without compressing
them to descriptors 0, 1, and 2.

This was previously guaranteed by using the index into the
pnp_resource_table array as the ISAPNP config register index.
However, I am removing those fixed-size arrays, so we need to
save the ISAPNP register index elsewhere.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

---
 drivers/pnp/base.h        |    1 +
 drivers/pnp/isapnp/core.c |   18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

Index: work8/drivers/pnp/base.h
===================================================================
--- work8.orig/drivers/pnp/base.h	2008-04-16 11:20:08.000000000 -0600
+++ work8/drivers/pnp/base.h	2008-04-16 11:20:45.000000000 -0600
@@ -26,6 +26,7 @@
 
 struct pnp_resource {
 	struct resource res;
+	unsigned int index;		/* ISAPNP config register index */
 };
 
 struct pnp_resource_table {
Index: work8/drivers/pnp/isapnp/core.c
===================================================================
--- work8.orig/drivers/pnp/isapnp/core.c	2008-04-16 11:21:05.000000000 -0600
+++ work8/drivers/pnp/isapnp/core.c	2008-04-16 11:22:57.000000000 -0600
@@ -934,6 +934,7 @@
 			if (!ret)
 				continue;
 			pnp_res = &dev->res->port[tmp];
+			pnp_res->index = tmp;
 			res = &pnp_res->res;
 			res->start = ret;
 			res->flags = IORESOURCE_IO;
@@ -944,6 +945,7 @@
 			if (!ret)
 				continue;
 			pnp_res = &dev->res->mem[tmp];
+			pnp_res->index = tmp;
 			res = &pnp_res->res;
 			res->start = ret;
 			res->flags = IORESOURCE_MEM;
@@ -955,6 +957,7 @@
 			if (!ret)
 				continue;
 			pnp_res = &dev->res->irq[tmp];
+			pnp_res->index = tmp;
 			res = &pnp_res->res;
 			res->start = res->end = ret;
 			res->flags = IORESOURCE_IRQ;
@@ -964,6 +967,7 @@
 			if (ret == 4)
 				continue;
 			pnp_res = &dev->res->dma[tmp];
+			pnp_res->index = tmp;
 			res = &pnp_res->res;
 			res->start = res->end = ret;
 			res->flags = IORESOURCE_DMA;
@@ -987,42 +991,46 @@
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	int tmp;
+	int tmp, index;
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
 	for (tmp = 0; tmp < ISAPNP_MAX_PORT; tmp++) {
 		pnp_res = &dev->res->port[tmp];
+		index = pnp_res->index;
 		res = &pnp_res->res;
 		if ((res->flags & (IORESOURCE_IO | IORESOURCE_UNSET)) ==
 				IORESOURCE_IO)
-			isapnp_write_word(ISAPNP_CFG_PORT + (tmp << 1),
+			isapnp_write_word(ISAPNP_CFG_PORT + (index << 1),
 					  res->start);
 	}
 	for (tmp = 0; tmp < ISAPNP_MAX_IRQ; tmp++) {
 		pnp_res = &dev->res->irq[tmp];
+		index = pnp_res->index;
 		res = &pnp_res->res;
 		if ((res->flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) ==
 				IORESOURCE_IRQ) {
 			int irq = res->start;
 			if (irq == 2)
 				irq = 9;
-			isapnp_write_byte(ISAPNP_CFG_IRQ + (tmp << 1), irq);
+			isapnp_write_byte(ISAPNP_CFG_IRQ + (index << 1), irq);
 		}
 	}
 	for (tmp = 0; tmp < ISAPNP_MAX_DMA; tmp++) {
 		pnp_res = &dev->res->dma[tmp];
+		index = pnp_res->index;
 		res = &pnp_res->res;
 		if ((res->flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) ==
 				IORESOURCE_DMA)
-			isapnp_write_byte(ISAPNP_CFG_DMA + tmp, res->start);
+			isapnp_write_byte(ISAPNP_CFG_DMA + index, res->start);
 	}
 	for (tmp = 0; tmp < ISAPNP_MAX_MEM; tmp++) {
 		pnp_res = &dev->res->mem[tmp];
+		index = pnp_res->index;
 		res = &pnp_res->res;
 		if ((res->flags & (IORESOURCE_MEM | IORESOURCE_UNSET)) ==
 				IORESOURCE_MEM)
-			isapnp_write_word(ISAPNP_CFG_MEM + (tmp << 3),
+			isapnp_write_word(ISAPNP_CFG_MEM + (index << 3),
 				  (res->start >> 8) & 0xffff);
 	}
 	/* FIXME: We aren't handling 32bit mems properly here */

-- 
