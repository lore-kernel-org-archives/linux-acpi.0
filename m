From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 4/8] PNP: add pnp_resource_type() internal interface
Date: Mon, 05 May 2008 16:36:34 -0600
Message-ID: <20080505223959.587664764@ldl.fc.hp.com>
References: <20080505223630.682082986@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:16653 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760818AbYEEWkE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2008 18:40:04 -0400
Content-Disposition: inline; filename=pnp-add-pnp_resource_type
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Given a struct resource, this returns the type (IO, MEM, IRQ, DMA).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/base.h
===================================================================
--- work10.orig/drivers/pnp/base.h	2008-05-02 14:23:13.000000000 -0600
+++ work10/drivers/pnp/base.h	2008-05-05 09:39:03.000000000 -0600
@@ -45,6 +45,7 @@ int pnp_check_dma(struct pnp_dev *dev, s
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc);
 
 void pnp_init_resource(struct resource *res);
+int pnp_resource_type(struct resource *res);
 
 struct pnp_resource *pnp_get_pnp_resource(struct pnp_dev *dev,
 					  unsigned int type, unsigned int num);
Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-05-02 14:23:13.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-05-05 09:38:57.000000000 -0600
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
