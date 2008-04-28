From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 46/55] PNP: add pnp_new_resource() to find a new unset pnp_resource
Date: Mon, 28 Apr 2008 16:34:33 -0600
Message-ID: <20080428223625.934583696@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:41169 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966610AbYD1WhV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:37:21 -0400
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
--- work10.orig/drivers/pnp/resource.c	2008-04-28 16:09:43.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-04-28 16:09:45.000000000 -0600
@@ -538,6 +538,44 @@
 }
 EXPORT_SYMBOL(pnp_get_resource);
 
+static struct pnp_resource *pnp_new_resource(struct pnp_dev *dev, int type)
+{
+	struct pnp_resource *pnp_res;
+	int i;
+
+	switch (type) {
+	case IORESOURCE_IO:
+		for (i = 0; i < PNP_MAX_PORT; i++) {
+			pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_IO, i);
+			if (pnp_res && !pnp_resource_valid(&pnp_res->res))
+				return pnp_res;
+		}
+		break;
+	case IORESOURCE_MEM:
+		for (i = 0; i < PNP_MAX_MEM; i++) {
+			pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_MEM, i);
+			if (pnp_res && !pnp_resource_valid(&pnp_res->res))
+				return pnp_res;
+		}
+		break;
+	case IORESOURCE_IRQ:
+		for (i = 0; i < PNP_MAX_IRQ; i++) {
+			pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_IRQ, i);
+			if (pnp_res && !pnp_resource_valid(&pnp_res->res))
+				return pnp_res;
+		}
+		break;
+	case IORESOURCE_DMA:
+		for (i = 0; i < PNP_MAX_DMA; i++) {
+			pnp_res = pnp_get_pnp_resource(dev, IORESOURCE_DMA, i);
+			if (pnp_res && !pnp_resource_valid(&pnp_res->res))
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
