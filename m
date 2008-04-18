From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 30/53] PNP: convert resource initializers to use pnp_get_resource(), not pnp_resource_table
Date: Fri, 18 Apr 2008 14:50:25 -0600
Message-ID: <20080418205053.333482627@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:26253 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761114AbYDRUwP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 16:52:15 -0400
Content-Disposition: inline; filename=pnp-convert-inits-to-pnp_get_resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This removes more direct references to pnp_resource_table.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pnp/manager.c
===================================================================
--- work8.orig/drivers/pnp/manager.c	2008-04-10 16:50:03.000000000 -0600
+++ work8/drivers/pnp/manager.c	2008-04-10 16:59:08.000000000 -0600
@@ -232,17 +232,17 @@
  */
 void pnp_init_resources(struct pnp_dev *dev)
 {
-	struct pnp_resource_table *table = &dev->res;
-	int idx;
+	struct resource *res;
+	int i;
 
-	for (idx = 0; idx < PNP_MAX_IRQ; idx++)
-		pnp_init_resource(&table->irq_resource[idx]);
-	for (idx = 0; idx < PNP_MAX_DMA; idx++)
-		pnp_init_resource(&table->dma_resource[idx]);
-	for (idx = 0; idx < PNP_MAX_PORT; idx++)
-		pnp_init_resource(&table->port_resource[idx]);
-	for (idx = 0; idx < PNP_MAX_MEM; idx++)
-		pnp_init_resource(&table->mem_resource[idx]);
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IRQ, i)); i++)
+		pnp_init_resource(res);
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_DMA, i)); i++)
+		pnp_init_resource(res);
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++)
+		pnp_init_resource(res);
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_MEM, i)); i++)
+		pnp_init_resource(res);
 }
 
 /**
@@ -251,24 +251,24 @@
  */
 static void pnp_clean_resource_table(struct pnp_dev *dev)
 {
-	struct pnp_resource_table *table = &dev->res;
-	int idx;
+	struct resource *res;
+	int i;
 
-	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
-		if (table->irq_resource[idx].flags & IORESOURCE_AUTO)
-			pnp_init_resource(&table->irq_resource[idx]);
-	}
-	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
-		if (table->dma_resource[idx].flags & IORESOURCE_AUTO)
-			pnp_init_resource(&table->dma_resource[idx]);
-	}
-	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
-		if (table->port_resource[idx].flags & IORESOURCE_AUTO)
-			pnp_init_resource(&table->port_resource[idx]);
-	}
-	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
-		if (table->mem_resource[idx].flags & IORESOURCE_AUTO)
-			pnp_init_resource(&table->mem_resource[idx]);
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IRQ, i)); i++) {
+		if (res->flags & IORESOURCE_AUTO)
+			pnp_init_resource(res);
+	}
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_DMA, i)); i++) {
+		if (res->flags & IORESOURCE_AUTO)
+			pnp_init_resource(res);
+	}
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
+		if (res->flags & IORESOURCE_AUTO)
+			pnp_init_resource(res);
+	}
+	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_MEM, i)); i++) {
+		if (res->flags & IORESOURCE_AUTO)
+			pnp_init_resource(res);
 	}
 }
 

-- 
