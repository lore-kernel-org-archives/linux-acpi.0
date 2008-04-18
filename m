From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 28/53] PNP: convert resource assign functions to use pnp_get_resource(), not pnp_resource_table
Date: Fri, 18 Apr 2008 14:50:23 -0600
Message-ID: <20080418205052.945315681@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761512AbYDRVDj@vger.kernel.org>
Content-Disposition: inline; filename=pnp-convert-assign-to-pnp_get_resource
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

This removes more direct references to pnp_resource_table.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work8/drivers/pnp/manager.c
===================================================================
--- work8.orig/drivers/pnp/manager.c	2008-04-10 15:20:30.000000000 -0600
+++ work8/drivers/pnp/manager.c	2008-04-10 15:36:06.000000000 -0600
@@ -19,22 +19,24 @@
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
-	if (idx >= PNP_MAX_PORT) {
+	res = pnp_get_resource(dev, IORESOURCE_IO, idx);
+	if (!res) {
 		dev_err(&dev->dev, "too many I/O port resources\n");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
 
 	/* check if this resource has been manually set, if so skip */
-	if (!(dev->res.port_resource[idx].flags & IORESOURCE_AUTO))
+	if (!(res->flags & IORESOURCE_AUTO))
 		return 1;
 
-	start = &dev->res.port_resource[idx].start;
-	end = &dev->res.port_resource[idx].end;
-	flags = &dev->res.port_resource[idx].flags;
+	start = &res->start;
+	end = &res->end;
+	flags = &res->flags;
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_IO;
@@ -60,22 +62,24 @@
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
-	if (idx >= PNP_MAX_MEM) {
+	res = pnp_get_resource(dev, IORESOURCE_MEM, idx);
+	if (!res) {
 		dev_err(&dev->dev, "too many memory resources\n");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
 
 	/* check if this resource has been manually set, if so skip */
-	if (!(dev->res.mem_resource[idx].flags & IORESOURCE_AUTO))
+	if (!(res->flags & IORESOURCE_AUTO))
 		return 1;
 
-	start = &dev->res.mem_resource[idx].start;
-	end = &dev->res.mem_resource[idx].end;
-	flags = &dev->res.mem_resource[idx].flags;
+	start = &res->start;
+	end = &res->end;
+	flags = &res->flags;
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_MEM;
@@ -111,6 +115,7 @@
 
 static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 	int i;
@@ -120,19 +125,20 @@
 		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
 	};
 
-	if (idx >= PNP_MAX_IRQ) {
+	res = pnp_get_resource(dev, IORESOURCE_IRQ, idx);
+	if (!res) {
 		dev_err(&dev->dev, "too many IRQ resources\n");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
 
 	/* check if this resource has been manually set, if so skip */
-	if (!(dev->res.irq_resource[idx].flags & IORESOURCE_AUTO))
+	if (!(res->flags & IORESOURCE_AUTO))
 		return 1;
 
-	start = &dev->res.irq_resource[idx].start;
-	end = &dev->res.irq_resource[idx].end;
-	flags = &dev->res.irq_resource[idx].flags;
+	start = &res->start;
+	end = &res->end;
+	flags = &res->flags;
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_IRQ;
@@ -161,6 +167,7 @@
 
 static void pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 	int i;
@@ -170,18 +177,19 @@
 		1, 3, 5, 6, 7, 0, 2, 4
 	};
 
-	if (idx >= PNP_MAX_DMA) {
+	res = pnp_get_resource(dev, IORESOURCE_DMA, idx);
+	if (!res) {
 		dev_err(&dev->dev, "too many DMA resources\n");
 		return;
 	}
 
 	/* check if this resource has been manually set, if so skip */
-	if (!(dev->res.dma_resource[idx].flags & IORESOURCE_AUTO))
+	if (!(res->flags & IORESOURCE_AUTO))
 		return;
 
-	start = &dev->res.dma_resource[idx].start;
-	end = &dev->res.dma_resource[idx].end;
-	flags = &dev->res.dma_resource[idx].flags;
+	start = &res->start;
+	end = &res->end;
+	flags = &res->flags;
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_DMA;

-- 
