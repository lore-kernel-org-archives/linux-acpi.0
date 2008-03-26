From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 32/37] PNP: convert resource assign functions to use pnp_get_resource(), not pnp_resource_table
Date: Wed, 26 Mar 2008 11:11:30 -0600
Message-ID: <20080326171229.768083784@ldl.fc.hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:32680 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758095AbYCZRJQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:09:16 -0400
Content-Disposition: inline; filename=pnp-convert-assign-to-pnp_get_resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This removes more direct references to pnp_resource_table.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/pnp/manager.c
===================================================================
--- work7.orig/drivers/pnp/manager.c	2008-03-25 09:11:25.000000000 -0600
+++ work7/drivers/pnp/manager.c	2008-03-25 09:18:54.000000000 -0600
@@ -19,6 +19,7 @@
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
@@ -28,13 +29,15 @@
 		return 1;
 	}
 
+	res = pnp_get_resource(dev, IORESOURCE_IO, idx);
+
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
@@ -60,6 +63,7 @@
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 
@@ -69,13 +73,15 @@
 		return 1;
 	}
 
+	res = pnp_get_resource(dev, IORESOURCE_MEM, idx);
+
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
@@ -111,6 +117,7 @@
 
 static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 	int i;
@@ -126,13 +133,15 @@
 		return 1;
 	}
 
+	res = pnp_get_resource(dev, IORESOURCE_IRQ, idx);
+
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
@@ -161,6 +170,7 @@
 
 static void pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
+	struct resource *res;
 	resource_size_t *start, *end;
 	unsigned long *flags;
 	int i;
@@ -175,13 +185,15 @@
 		return;
 	}
 
+	res = pnp_get_resource(dev, IORESOURCE_DMA, idx);
+
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
