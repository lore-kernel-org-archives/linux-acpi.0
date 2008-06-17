From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 03/28] PNP: add pnp_resource_type() internal interface
Date: Tue, 17 Jun 2008 16:58:26 -0600
Message-ID: <20080617225908.183042064@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:24302 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758959AbYFQW7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 18:59:35 -0400
Content-Disposition: inline; filename=pnp-add-pnp_resource_type
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

Given a struct resource, this returns the type (IO, MEM, IRQ, DMA).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/base.h
===================================================================
--- work10.orig/drivers/pnp/base.h	2008-05-15 15:23:24.000000000 -0600
+++ work10/drivers/pnp/base.h	2008-05-15 15:23:27.000000000 -0600
@@ -46,6 +46,7 @@ int pnp_check_dma(struct pnp_dev *dev, s
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc);
 
 void pnp_init_resource(struct resource *res);
+int pnp_resource_type(struct resource *res);
 
 struct pnp_resource *pnp_get_pnp_resource(struct pnp_dev *dev,
 					  unsigned int type, unsigned int num);
Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-05-15 15:22:36.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-05-15 15:23:27.000000000 -0600
@@ -499,6 +499,12 @@ int pnp_check_dma(struct pnp_dev *dev, s
 #endif
 }
 
+int pnp_resource_type(struct resource *res)
+{
+	return res->flags & (IORESOURCE_IO  | IORESOURCE_MEM |
+			     IORESOURCE_IRQ | IORESOURCE_DMA);
+}
+
 struct pnp_resource *pnp_get_pnp_resource(struct pnp_dev *dev,
 					  unsigned int type, unsigned int num)
 {

-- 
