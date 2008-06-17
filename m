From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 08/28] PNP: remove ratelimit on add resource failures
Date: Tue, 17 Jun 2008 16:58:31 -0600
Message-ID: <20080617225909.260022434@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:24359 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759636AbYFQW7o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 18:59:44 -0400
Content-Disposition: inline; filename=pnp-remove-warning-ratelimit
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

We used to have a fixed-size resource table.  If a device had
twenty resources when the table only had space for ten, we didn't
need ten warnings, so we added the ratelimit.

Now that we can dynamically allocate new resources, we should
only get failures if the allocation fails.  That should be
rare enough that we don't need to ratelimit the messages.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-05-05 11:38:16.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-05-05 11:49:05.000000000 -0600
@@ -537,15 +537,10 @@ struct pnp_resource *pnp_add_irq_resourc
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for IRQ %d\n",
-				irq);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for IRQ %d\n", irq);
 		return NULL;
 	}
 
@@ -563,15 +558,10 @@ struct pnp_resource *pnp_add_dma_resourc
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for DMA %d\n",
-				dma);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for DMA %d\n", dma);
 		return NULL;
 	}
 
@@ -590,16 +580,12 @@ struct pnp_resource *pnp_add_io_resource
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for IO "
-				"%#llx-%#llx\n",(unsigned long long) start,
-				(unsigned long long) end);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for IO %#llx-%#llx\n",
+			(unsigned long long) start,
+			(unsigned long long) end);
 		return NULL;
 	}
 
@@ -619,16 +605,12 @@ struct pnp_resource *pnp_add_mem_resourc
 {
 	struct pnp_resource *pnp_res;
 	struct resource *res;
-	static unsigned char warned;
 
 	pnp_res = pnp_new_resource(dev);
 	if (!pnp_res) {
-		if (!warned) {
-			dev_err(&dev->dev, "can't add resource for MEM "
-				"%#llx-%#llx\n",(unsigned long long) start,
-				(unsigned long long) end);
-			warned = 1;
-		}
+		dev_err(&dev->dev, "can't add resource for MEM %#llx-%#llx\n",
+			(unsigned long long) start,
+			(unsigned long long) end);
 		return NULL;
 	}
 

-- 
