From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 27/55] PNP: add pnp_get_resource() interface
Date: Mon, 28 Apr 2008 16:34:14 -0600
Message-ID: <20080428223622.006658098@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:30619 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966666AbYD1Wg4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:36:56 -0400
Content-Disposition: inline; filename=pnp-add-get-resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This adds a pnp_get_resource() that works the same way as
platform_get_resource().  This will enable us to consolidate
many pnp_resource_table references in one place, which will
make it easier to make the table dynamic.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

---
 drivers/pnp/resource.c |   27 +++++++++++++++++++++++++++
 include/linux/pnp.h    |    1 +
 2 files changed, 28 insertions(+)

Index: work10/include/linux/pnp.h
===================================================================
--- work10.orig/include/linux/pnp.h	2008-04-28 16:09:24.000000000 -0600
+++ work10/include/linux/pnp.h	2008-04-28 16:09:26.000000000 -0600
@@ -25,6 +25,7 @@
 /*
  * Resource Management
  */
+struct resource *pnp_get_resource(struct pnp_dev *, unsigned int, unsigned int);
 
 /* Use these instead of directly reading pnp_dev to get resource information */
 #define pnp_port_start(dev,bar)   ((dev)->res.port_resource[(bar)].start)
Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-04-28 16:09:19.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-04-28 16:09:26.000000000 -0600
@@ -487,6 +487,33 @@
 #endif
 }
 
+struct resource *pnp_get_resource(struct pnp_dev *dev,
+				  unsigned int type, unsigned int num)
+{
+	struct pnp_resource_table *res = &dev->res;
+
+	switch (type) {
+	case IORESOURCE_IO:
+		if (num >= PNP_MAX_PORT)
+			return NULL;
+		return &res->port_resource[num];
+	case IORESOURCE_MEM:
+		if (num >= PNP_MAX_MEM)
+			return NULL;
+		return &res->mem_resource[num];
+	case IORESOURCE_IRQ:
+		if (num >= PNP_MAX_IRQ)
+			return NULL;
+		return &res->irq_resource[num];
+	case IORESOURCE_DMA:
+		if (num >= PNP_MAX_DMA)
+			return NULL;
+		return &res->dma_resource[num];
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(pnp_get_resource);
+
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
 static int __init pnp_setup_reserve_irq(char *str)
 {

-- 
