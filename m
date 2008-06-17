From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 04/28] PNP: add pnp_resource_type_name() helper function
Date: Tue, 17 Jun 2008 16:58:27 -0600
Message-ID: <20080617225908.383391287@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:15125 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759439AbYFQW7g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 18:59:36 -0400
Content-Disposition: inline; filename=pnp-add-resource-type-name
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

This patch adds a "pnp_resource_type_name(struct resource *)" that
returns the string resource type.  This will be used by the sysfs
"show resources" function and the debug resource dump function.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/base.h
===================================================================
--- work10.orig/drivers/pnp/base.h	2008-05-15 15:23:27.000000000 -0600
+++ work10/drivers/pnp/base.h	2008-05-15 15:23:29.000000000 -0600
@@ -43,6 +43,7 @@ int pnp_check_mem(struct pnp_dev *dev, s
 int pnp_check_irq(struct pnp_dev *dev, struct resource *res);
 int pnp_check_dma(struct pnp_dev *dev, struct resource *res);
 
+char *pnp_resource_type_name(struct resource *res);
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc);
 
 void pnp_init_resource(struct resource *res);
Index: work10/drivers/pnp/support.c
===================================================================
--- work10.orig/drivers/pnp/support.c	2008-05-15 15:23:23.000000000 -0600
+++ work10/drivers/pnp/support.c	2008-05-15 15:23:29.000000000 -0600
@@ -52,6 +52,21 @@ void pnp_eisa_id_to_string(u32 id, char 
 	str[7] = '\0';
 }
 
+char *pnp_resource_type_name(struct resource *res)
+{
+	switch (pnp_resource_type(res)) {
+	case IORESOURCE_IO:
+		return "io";
+	case IORESOURCE_MEM:
+		return "mem";
+	case IORESOURCE_IRQ:
+		return "irq";
+	case IORESOURCE_DMA:
+		return "dma";
+	}
+	return NULL;
+}
+
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 {
 #ifdef DEBUG

-- 
