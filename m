From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 01/28] PNP: add detail to debug resource dump
Date: Tue, 17 Jun 2008 16:58:24 -0600
Message-ID: <20080617225907.642544594@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:15104 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271AbYFQW7d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 18:59:33 -0400
Content-Disposition: inline; filename=pnp-better-resource-dump
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

In the debug resource dump, decode the flags and indicate when
a resource is disabled or has been automatically assigned.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/support.c
===================================================================
--- work10.orig/drivers/pnp/support.c	2008-05-02 11:18:50.000000000 -0600
+++ work10/drivers/pnp/support.c	2008-05-05 09:39:03.000000000 -0600
@@ -63,28 +63,46 @@ void dbg_pnp_show_resources(struct pnp_d
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		res = pnp_get_resource(dev, IORESOURCE_IRQ, i);
 		if (res && !(res->flags & IORESOURCE_UNSET))
-			dev_dbg(&dev->dev, "  irq %lld flags %#lx\n",
-				(unsigned long long) res->start, res->flags);
+			dev_dbg(&dev->dev, "  irq %lld flags %#lx%s%s\n",
+				(unsigned long long) res->start, res->flags,
+				res->flags & IORESOURCE_DISABLED ?
+					" DISABLED" : "",
+				res->flags & IORESOURCE_AUTO ?
+					" AUTO" : "");
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
 		res = pnp_get_resource(dev, IORESOURCE_DMA, i);
 		if (res && !(res->flags & IORESOURCE_UNSET))
-			dev_dbg(&dev->dev, "  dma %lld flags %#lx\n",
-				(unsigned long long) res->start, res->flags);
+			dev_dbg(&dev->dev, "  dma %lld flags %#lx%s%s\n",
+				(unsigned long long) res->start, res->flags,
+				res->flags & IORESOURCE_DISABLED ?
+					" DISABLED" : "",
+				res->flags & IORESOURCE_AUTO ?
+					" AUTO" : "");
 	}
 	for (i = 0; i < PNP_MAX_PORT; i++) {
 		res = pnp_get_resource(dev, IORESOURCE_IO, i);
 		if (res && !(res->flags & IORESOURCE_UNSET))
-			dev_dbg(&dev->dev, "  io  %#llx-%#llx flags %#lx\n",
+			dev_dbg(&dev->dev, "  io  %#llx-%#llx flags %#lx"
+				"%s%s\n",
 				(unsigned long long) res->start,
-				(unsigned long long) res->end, res->flags);
+				(unsigned long long) res->end, res->flags,
+				res->flags & IORESOURCE_DISABLED ?
+					" DISABLED" : "",
+				res->flags & IORESOURCE_AUTO ?
+					" AUTO" : "");
 	}
 	for (i = 0; i < PNP_MAX_MEM; i++) {
 		res = pnp_get_resource(dev, IORESOURCE_MEM, i);
 		if (res && !(res->flags & IORESOURCE_UNSET))
-			dev_dbg(&dev->dev, "  mem %#llx-%#llx flags %#lx\n",
+			dev_dbg(&dev->dev, "  mem %#llx-%#llx flags %#lx"
+				"%s%s\n",
 				(unsigned long long) res->start,
-				(unsigned long long) res->end, res->flags);
+				(unsigned long long) res->end, res->flags,
+				res->flags & IORESOURCE_DISABLED ?
+					" DISABLED" : "",
+				res->flags & IORESOURCE_AUTO ?
+					" AUTO" : "");
 	}
 #endif
 }

-- 
