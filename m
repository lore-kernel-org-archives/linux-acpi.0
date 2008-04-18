From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 38/53] PNP: add pnp_new_resource() to find a new unset pnp_resource
Date: Fri, 18 Apr 2008 14:50:33 -0600
Message-ID: <20080418205054.918890545@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933382AbYDRVIl@vger.kernel.org>
Content-Disposition: inline; filename=pnp-add-pnp_new_resource
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

This encapsulates the code to locate a new pnp_resource of the
desired type.  Currently this uses the pnp_resource_table, but
it will soon change to find a resource in a linked list.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pnp/resource.c
===================================================================
--- work8.orig/drivers/pnp/resource.c	2008-04-17 15:04:41.000000000 -0600
+++ work8/drivers/pnp/resource.c	2008-04-18 11:08:33.000000000 -0600
@@ -516,6 +516,49 @@
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
