From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 51/55] ISAPNP: fold isapnp_read_resources() back into isapnp_get_resources()
Date: Mon, 28 Apr 2008 16:34:38 -0600
Message-ID: <20080428223626.937400641@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:49099 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966822AbYD1Wh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:37:28 -0400
Content-Disposition: inline; filename=isapnp-fold-isapnp_read_resources
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

isapnp_get_resources() does very little besides call
isapnp_read_resources(), so just fold them back together.

Based on a patch by Rene Herman <rene.herman@gmail.com>

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/isapnp/core.c
===================================================================
--- work10.orig/drivers/pnp/isapnp/core.c	2008-04-28 16:09:48.000000000 -0600
+++ work10/drivers/pnp/isapnp/core.c	2008-04-28 16:09:49.000000000 -0600
@@ -929,62 +929,54 @@
 EXPORT_SYMBOL(isapnp_cfg_end);
 EXPORT_SYMBOL(isapnp_write_byte);
 
-static int isapnp_read_resources(struct pnp_dev *dev)
+static int isapnp_get_resources(struct pnp_dev *dev)
 {
 	struct pnp_resource *pnp_res;
-	int tmp, ret;
+	int i, ret;
 
+	dev_dbg(&dev->dev, "get resources\n");
+	pnp_init_resources(dev);
+	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
-	if (dev->active) {
-		for (tmp = 0; tmp < ISAPNP_MAX_PORT; tmp++) {
-			ret = isapnp_read_word(ISAPNP_CFG_PORT + (tmp << 1));
-			if (!ret)
-				continue;
+	if (!dev->active)
+		goto __end;
+
+	for (i = 0; i < ISAPNP_MAX_PORT; i++) {
+		ret = isapnp_read_word(ISAPNP_CFG_PORT + (i << 1));
+		if (ret) {
 			pnp_res = pnp_add_io_resource(dev, ret, ret, 0);
 			if (pnp_res)
-				pnp_res->index = tmp;
+				pnp_res->index = i;
 		}
-		for (tmp = 0; tmp < ISAPNP_MAX_MEM; tmp++) {
-			ret =
-			    isapnp_read_word(ISAPNP_CFG_MEM + (tmp << 3)) << 8;
-			if (!ret)
-				continue;
+	}
+	for (i = 0; i < ISAPNP_MAX_MEM; i++) {
+		ret = isapnp_read_word(ISAPNP_CFG_MEM + (i << 3)) << 8;
+		if (ret) {
 			pnp_res = pnp_add_mem_resource(dev, ret, ret, 0);
 			if (pnp_res)
-				pnp_res->index = tmp;
+				pnp_res->index = i;
 		}
-		for (tmp = 0; tmp < ISAPNP_MAX_IRQ; tmp++) {
-			ret =
-			    (isapnp_read_word(ISAPNP_CFG_IRQ + (tmp << 1)) >>
-			     8);
-			if (!ret)
-				continue;
+	}
+	for (i = 0; i < ISAPNP_MAX_IRQ; i++) {
+		ret = isapnp_read_word(ISAPNP_CFG_IRQ + (i << 1)) >> 8;
+		if (ret) {
 			pnp_res = pnp_add_irq_resource(dev, ret, 0);
 			if (pnp_res)
-				pnp_res->index = tmp;
+				pnp_res->index = i;
 		}
-		for (tmp = 0; tmp < ISAPNP_MAX_DMA; tmp++) {
-			ret = isapnp_read_byte(ISAPNP_CFG_DMA + tmp);
-			if (ret == 4)
-				continue;
+	}
+	for (i = 0; i < ISAPNP_MAX_DMA; i++) {
+		ret = isapnp_read_byte(ISAPNP_CFG_DMA + i);
+		if (ret != 4) {
 			pnp_res = pnp_add_dma_resource(dev, ret, 0);
 			if  (pnp_res)
-				pnp_res->index = tmp;
+				pnp_res->index = i;
 		}
 	}
-	return 0;
-}
 
-static int isapnp_get_resources(struct pnp_dev *dev)
-{
-	int ret;
-
-	dev_dbg(&dev->dev, "get resources\n");
-	pnp_init_resources(dev);
-	isapnp_cfg_begin(dev->card->number, dev->number);
-	ret = isapnp_read_resources(dev);
+__end:
 	isapnp_cfg_end();
-	return ret;
+	return 0;
 }
 
 static int isapnp_set_resources(struct pnp_dev *dev)

-- 
