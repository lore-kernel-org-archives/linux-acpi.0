From: helgaas@ldl.fc.hp.com
Subject: [patch 05/17] PNP: Lindent manager.c
Date: Mon, 23 Jul 2007 15:28:02 -0600
Message-ID: <20070723213241.345296018@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:52724 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbXGWVdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:09 -0400
Content-Disposition: inline; filename=pnp-format-manager
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/manager.c
===================================================================
--- work2.orig/drivers/pnp/manager.c	2007-07-20 15:43:31.000000000 -0600
+++ work2/drivers/pnp/manager.c	2007-07-20 15:47:04.000000000 -0600
@@ -3,7 +3,6 @@
  *
  * based on isapnp.c resource management (c) Jaroslav Kysela <perex@suse.cz>
  * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
- *
  */
 
 #include <linux/errno.h>
@@ -26,7 +25,8 @@
 		return -EINVAL;
 
 	if (idx >= PNP_MAX_PORT) {
-		pnp_err("More than 4 ports is incompatible with pnp specifications.");
+		pnp_err
+		    ("More than 4 ports is incompatible with pnp specifications.");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -41,11 +41,11 @@
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_IO;
-	*flags &=  ~IORESOURCE_UNSET;
+	*flags &= ~IORESOURCE_UNSET;
 
 	if (!rule->size) {
 		*flags |= IORESOURCE_DISABLED;
-		return 1; /* skip disabled resource requests */
+		return 1;	/* skip disabled resource requests */
 	}
 
 	*start = rule->min;
@@ -70,7 +70,8 @@
 		return -EINVAL;
 
 	if (idx >= PNP_MAX_MEM) {
-		pnp_err("More than 8 mems is incompatible with pnp specifications.");
+		pnp_err
+		    ("More than 8 mems is incompatible with pnp specifications.");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -85,7 +86,7 @@
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_MEM;
-	*flags &=  ~IORESOURCE_UNSET;
+	*flags &= ~IORESOURCE_UNSET;
 
 	/* convert pnp flags to standard Linux flags */
 	if (!(rule->flags & IORESOURCE_MEM_WRITEABLE))
@@ -99,11 +100,11 @@
 
 	if (!rule->size) {
 		*flags |= IORESOURCE_DISABLED;
-		return 1; /* skip disabled resource requests */
+		return 1;	/* skip disabled resource requests */
 	}
 
 	*start = rule->min;
-	*end = *start + rule->size -1;
+	*end = *start + rule->size - 1;
 
 	/* run through until pnp_check_mem is happy */
 	while (!pnp_check_mem(dev, idx)) {
@@ -115,7 +116,7 @@
 	return 1;
 }
 
-static int pnp_assign_irq(struct pnp_dev * dev, struct pnp_irq *rule, int idx)
+static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 {
 	resource_size_t *start, *end;
 	unsigned long *flags;
@@ -130,7 +131,8 @@
 		return -EINVAL;
 
 	if (idx >= PNP_MAX_IRQ) {
-		pnp_err("More than 2 irqs is incompatible with pnp specifications.");
+		pnp_err
+		    ("More than 2 irqs is incompatible with pnp specifications.");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -145,11 +147,11 @@
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_IRQ;
-	*flags &=  ~IORESOURCE_UNSET;
+	*flags &= ~IORESOURCE_UNSET;
 
 	if (bitmap_empty(rule->map, PNP_IRQ_NR)) {
 		*flags |= IORESOURCE_DISABLED;
-		return 1; /* skip disabled resource requests */
+		return 1;	/* skip disabled resource requests */
 	}
 
 	/* TBD: need check for >16 IRQ */
@@ -159,9 +161,9 @@
 		return 1;
 	}
 	for (i = 0; i < 16; i++) {
-		if(test_bit(xtab[i], rule->map)) {
+		if (test_bit(xtab[i], rule->map)) {
 			*start = *end = xtab[i];
-			if(pnp_check_irq(dev, idx))
+			if (pnp_check_irq(dev, idx))
 				return 1;
 		}
 	}
@@ -183,7 +185,8 @@
 		return -EINVAL;
 
 	if (idx >= PNP_MAX_DMA) {
-		pnp_err("More than 2 dmas is incompatible with pnp specifications.");
+		pnp_err
+		    ("More than 2 dmas is incompatible with pnp specifications.");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -198,17 +201,17 @@
 
 	/* set the initial values */
 	*flags |= rule->flags | IORESOURCE_DMA;
-	*flags &=  ~IORESOURCE_UNSET;
+	*flags &= ~IORESOURCE_UNSET;
 
 	if (!rule->map) {
 		*flags |= IORESOURCE_DISABLED;
-		return 1; /* skip disabled resource requests */
+		return 1;	/* skip disabled resource requests */
 	}
 
 	for (i = 0; i < 8; i++) {
-		if(rule->map & (1<<xtab[i])) {
+		if (rule->map & (1 << xtab[i])) {
 			*start = *end = xtab[i];
-			if(pnp_check_dma(dev, idx))
+			if (pnp_check_dma(dev, idx))
 				return 1;
 		}
 	}
@@ -218,72 +221,80 @@
 /**
  * pnp_init_resources - Resets a resource table to default values.
  * @table: pointer to the desired resource table
- *
  */
 void pnp_init_resource_table(struct pnp_resource_table *table)
 {
 	int idx;
+
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
 		table->irq_resource[idx].name = NULL;
 		table->irq_resource[idx].start = -1;
 		table->irq_resource[idx].end = -1;
-		table->irq_resource[idx].flags = IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->irq_resource[idx].flags =
+		    IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		table->dma_resource[idx].name = NULL;
 		table->dma_resource[idx].start = -1;
 		table->dma_resource[idx].end = -1;
-		table->dma_resource[idx].flags = IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->dma_resource[idx].flags =
+		    IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		table->port_resource[idx].name = NULL;
 		table->port_resource[idx].start = 0;
 		table->port_resource[idx].end = 0;
-		table->port_resource[idx].flags = IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->port_resource[idx].flags =
+		    IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		table->mem_resource[idx].name = NULL;
 		table->mem_resource[idx].start = 0;
 		table->mem_resource[idx].end = 0;
-		table->mem_resource[idx].flags = IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->mem_resource[idx].flags =
+		    IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 }
 
 /**
  * pnp_clean_resources - clears resources that were not manually set
  * @res: the resources to clean
- *
  */
-static void pnp_clean_resource_table(struct pnp_resource_table * res)
+static void pnp_clean_resource_table(struct pnp_resource_table *res)
 {
 	int idx;
+
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
 		if (!(res->irq_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->irq_resource[idx].start = -1;
 		res->irq_resource[idx].end = -1;
-		res->irq_resource[idx].flags = IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->irq_resource[idx].flags =
+		    IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		if (!(res->dma_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->dma_resource[idx].start = -1;
 		res->dma_resource[idx].end = -1;
-		res->dma_resource[idx].flags = IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->dma_resource[idx].flags =
+		    IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		if (!(res->port_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->port_resource[idx].start = 0;
 		res->port_resource[idx].end = 0;
-		res->port_resource[idx].flags = IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->port_resource[idx].flags =
+		    IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		if (!(res->mem_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->mem_resource[idx].start = 0;
 		res->mem_resource[idx].end = 0;
-		res->mem_resource[idx].flags = IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->mem_resource[idx].flags =
+		    IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 }
 
@@ -306,7 +317,7 @@
 		return -ENODEV;
 
 	down(&pnp_res_mutex);
-	pnp_clean_resource_table(&dev->res); /* start with a fresh slate */
+	pnp_clean_resource_table(&dev->res);	/* start with a fresh slate */
 	if (dev->independent) {
 		port = dev->independent->port;
 		mem = dev->independent->mem;
@@ -341,10 +352,11 @@
 	if (depnum) {
 		struct pnp_option *dep;
 		int i;
-		for (i=1,dep=dev->dependent; i<depnum; i++, dep=dep->next)
-			if(!dep)
+		for (i = 1, dep = dev->dependent; i < depnum;
+		     i++, dep = dep->next)
+			if (!dep)
 				goto fail;
-		port =dep->port;
+		port = dep->port;
 		mem = dep->mem;
 		irq = dep->irq;
 		dma = dep->dma;
@@ -378,7 +390,7 @@
 	up(&pnp_res_mutex);
 	return 1;
 
-fail:
+      fail:
 	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 	return 0;
@@ -392,10 +404,12 @@
  *
  * This function can be used by drivers that want to manually set thier resources.
  */
-int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table * res, int mode)
+int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
+			  int mode)
 {
 	int i;
-	struct pnp_resource_table * bak;
+	struct pnp_resource_table *bak;
+
 	if (!dev || !res)
 		return -EINVAL;
 	if (!pnp_can_configure(dev))
@@ -409,19 +423,19 @@
 	dev->res = *res;
 	if (!(mode & PNP_CONFIG_FORCE)) {
 		for (i = 0; i < PNP_MAX_PORT; i++) {
-			if(!pnp_check_port(dev,i))
+			if (!pnp_check_port(dev, i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_MEM; i++) {
-			if(!pnp_check_mem(dev,i))
+			if (!pnp_check_mem(dev, i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_IRQ; i++) {
-			if(!pnp_check_irq(dev,i))
+			if (!pnp_check_irq(dev, i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_DMA; i++) {
-			if(!pnp_check_dma(dev,i))
+			if (!pnp_check_dma(dev, i))
 				goto fail;
 		}
 	}
@@ -430,7 +444,7 @@
 	kfree(bak);
 	return 0;
 
-fail:
+      fail:
 	dev->res = *bak;
 	up(&pnp_res_mutex);
 	kfree(bak);
@@ -440,18 +454,18 @@
 /**
  * pnp_auto_config_dev - automatically assigns resources to a device
  * @dev: pointer to the desired device
- *
  */
 int pnp_auto_config_dev(struct pnp_dev *dev)
 {
 	struct pnp_option *dep;
 	int i = 1;
 
-	if(!dev)
+	if (!dev)
 		return -EINVAL;
 
-	if(!pnp_can_configure(dev)) {
-		pnp_dbg("Device %s does not support resource configuration.", dev->dev.bus_id);
+	if (!pnp_can_configure(dev)) {
+		pnp_dbg("Device %s does not support resource configuration.",
+			dev->dev.bus_id);
 		return -ENODEV;
 	}
 
@@ -476,23 +490,22 @@
  * pnp_start_dev - low-level start of the PnP device
  * @dev: pointer to the desired device
  *
- * assumes that resources have alread been allocated
+ * assumes that resources have already been allocated
  */
-
 int pnp_start_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_write(dev)) {
-		pnp_dbg("Device %s does not support activation.", dev->dev.bus_id);
+		pnp_dbg("Device %s does not support activation.",
+			dev->dev.bus_id);
 		return -EINVAL;
 	}
 
-	if (dev->protocol->set(dev, &dev->res)<0) {
+	if (dev->protocol->set(dev, &dev->res) < 0) {
 		pnp_err("Failed to activate device %s.", dev->dev.bus_id);
 		return -EIO;
 	}
 
 	pnp_info("Device %s activated.", dev->dev.bus_id);
-
 	return 0;
 }
 
@@ -502,20 +515,19 @@
  *
  * does not free resources
  */
-
 int pnp_stop_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_disable(dev)) {
-		pnp_dbg("Device %s does not support disabling.", dev->dev.bus_id);
+		pnp_dbg("Device %s does not support disabling.",
+			dev->dev.bus_id);
 		return -EINVAL;
 	}
-	if (dev->protocol->disable(dev)<0) {
+	if (dev->protocol->disable(dev) < 0) {
 		pnp_err("Failed to disable device %s.", dev->dev.bus_id);
 		return -EIO;
 	}
 
 	pnp_info("Device %s disabled.", dev->dev.bus_id);
-
 	return 0;
 }
 
@@ -531,9 +543,8 @@
 
 	if (!dev)
 		return -EINVAL;
-	if (dev->active) {
-		return 0; /* the device is already active */
-	}
+	if (dev->active)
+		return 0;	/* the device is already active */
 
 	/* ensure resources are allocated */
 	if (pnp_auto_config_dev(dev))
@@ -544,7 +555,6 @@
 		return error;
 
 	dev->active = 1;
-
 	return 1;
 }
 
@@ -558,11 +568,10 @@
 {
 	int error;
 
-        if (!dev)
-                return -EINVAL;
-	if (!dev->active) {
-		return 0; /* the device is already disabled */
-	}
+	if (!dev)
+		return -EINVAL;
+	if (!dev->active)
+		return 0;	/* the device is already disabled */
 
 	error = pnp_stop_dev(dev);
 	if (error)
@@ -583,10 +592,9 @@
  * @resource: pointer to resource to be changed
  * @start: start of region
  * @size: size of region
- *
  */
 void pnp_resource_change(struct resource *resource, resource_size_t start,
-				resource_size_t size)
+			 resource_size_t size)
 {
 	if (resource == NULL)
 		return;
@@ -595,11 +603,7 @@
 	resource->end = start + size - 1;
 }
 
-
 EXPORT_SYMBOL(pnp_manual_config_dev);
-#if 0
-EXPORT_SYMBOL(pnp_auto_config_dev);
-#endif
 EXPORT_SYMBOL(pnp_start_dev);
 EXPORT_SYMBOL(pnp_stop_dev);
 EXPORT_SYMBOL(pnp_activate_dev);

--
