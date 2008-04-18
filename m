From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 44/53] PNP: add pnp_resource_type() internal interface
Date: Fri, 18 Apr 2008 14:50:39 -0600
Message-ID: <20080418205056.178783428@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762701AbYDRVKb@vger.kernel.org>
Content-Disposition: inline; filename=pnp-add-pnp_resource_type
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Given a struct resource, this returns the type (IO, MEM, IRQ, DMA).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pnp/base.h
===================================================================
--- work8.orig/drivers/pnp/base.h	2008-04-17 14:07:25.000000000 -0600
+++ work8/drivers/pnp/base.h	2008-04-17 14:07:37.000000000 -0600
@@ -18,6 +18,7 @@
 int pnp_check_dma(struct pnp_dev * dev, int idx);
 
 void pnp_init_resource(struct resource *res);
+int pnp_resource_type(struct resource *res);
 
 #define PNP_MAX_PORT		40
 #define PNP_MAX_MEM		24
Index: work8/drivers/pnp/resource.c
===================================================================
--- work8.orig/drivers/pnp/resource.c	2008-04-17 14:07:48.000000000 -0600
+++ work8/drivers/pnp/resource.c	2008-04-17 14:09:25.000000000 -0600
@@ -489,6 +489,12 @@
 #endif
 }
 
+int pnp_resource_type(struct resource *res)
+{
+	return res->flags & (IORESOURCE_IO  | IORESOURCE_MEM |
+			     IORESOURCE_IRQ | IORESOURCE_DMA);
+}
+
 struct resource *pnp_get_resource(struct pnp_dev *dev,
 				  unsigned int type, unsigned int num)
 {

-- 
