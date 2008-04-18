From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 52/53] PNP: fill in generic pnp_dev fields earlier
Date: Fri, 18 Apr 2008 14:50:47 -0600
Message-ID: <20080418205057.753579689@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:21914 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761100AbYDRUwn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 16:52:43 -0400
Content-Disposition: inline; filename=pnp-init-pnp_dev-generic-stuff-earlier
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This makes dev_printk() work better because we have a default driver.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pnp/core.c
===================================================================
--- work8.orig/drivers/pnp/core.c	2008-04-17 15:05:18.000000000 -0600
+++ work8/drivers/pnp/core.c	2008-04-17 17:13:12.000000000 -0600
@@ -132,8 +132,13 @@
 	INIT_LIST_HEAD(&dev->resources);
 	dev->protocol = protocol;
 	dev->number = id;
+	dev->dma_mask = DMA_24BIT_MASK;
 
 	dev->dev.parent = &dev->protocol->dev;
+	dev->dev.bus = &pnp_bus_type;
+	dev->dev.dma_mask = &dev->dma_mask;
+	dev->dev.coherent_dma_mask = dev->dma_mask;
+	dev->dev.release = &pnp_release_device;
 	sprintf(dev->dev.bus_id, "%02x:%02x", dev->protocol->number,
 		dev->number);
 
@@ -151,10 +156,6 @@
 	int ret;
 
 	pnp_fixup_device(dev);
-	dev->dev.bus = &pnp_bus_type;
-	dev->dev.dma_mask = &dev->dma_mask;
-	dev->dma_mask = dev->dev.coherent_dma_mask = DMA_24BIT_MASK;
-	dev->dev.release = &pnp_release_device;
 	dev->status = PNP_READY;
 	spin_lock(&pnp_lock);
 	list_add_tail(&dev->global_list, &pnp_global);

-- 
