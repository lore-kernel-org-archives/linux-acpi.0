From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 44/54] PNP: add pnp_new_resource() to find a new unset pnp_resource
Date: Fri, 25 Apr 2008 12:38:51 -0600
Message-ID: <20080425183933.066428168@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:16495 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762378AbYDYSkb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:40:31 -0400
Content-Disposition: inline; filename=pnp-add-pnp_new_resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This encapsulates the code to locate a new pnp_resource of the
desired type.  Currently this uses the pnp_resource_table, but
it will soon change to find a resource in a linked list.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-04-25 11:15:09.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-04-25 11:15:11.000000000 -0600
@@ -526,6 +526,49 @@
 }
 EXPORT_SYMBOL(pnp_get_resource);
 
+static struct pnp_resource *pnp_new_resource(struct pnp_dev *dev, int type)
+{
+	struct pnp_resource *pnp_res;
+	struct resource *res;
+	int i;
+
+	switch (type) {
+	case IORESOURCE_IO:
+		for (i = 0; i < PNP_MAX_PORT; i++) {
+			pnp_res = &dev->res->port[i];
+			res = &pnp_res->res;
+			if (res->flags & IORESOURCE_UNSET)
+				return pnp_res;
+		}
+		break;
+	case IORESOURCE_MEM:
+		for (i = 0; i < PNP_MAX_MEM; i++) {
+			pnp_res = &dev->res->mem[i];
+			res = &pnp_res->res;
+			if (res->flags & IORESOURCE_UNSET)
+				return pnp_res;
+		}
+		break;
+	case IORESOURCE_IRQ:
+		for (i = 0; i < PNP_MAX_IRQ; i++) {
+			pnp_res = &dev->res->irq[i];
+			res = &pnp_res->res;
+			if (res->flags & IORESOURCE_UNSET)
+				return pnp_res;
+		}
+		break;
+	case IORESOURCE_DMA:
+		for (i = 0; i < PNP_MAX_DMA; i++) {
+			pnp_res = &dev->res->dma[i];
+			res = &pnp_res->res;
+			if (res->flags & IORESOURCE_UNSET)
+				return pnp_res;
+		}
+		break;
+	}
+	return NULL;
+}
+
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
 static int __init pnp_setup_reserve_irq(char *str)
 {

-- 
