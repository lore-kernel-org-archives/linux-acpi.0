From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 14/54] PNPACPI: hoist dma_flags() out of pnpacpi_parse_allocated_dmaresource()
Date: Fri, 25 Apr 2008 12:38:21 -0600
Message-ID: <20080425183926.959327413@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:16261 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762434AbYDYSjn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:39:43 -0400
Content-Disposition: inline; filename=pnpacpi-hoist-dma-flags
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Hoist dma_flags() out of pnpacpi_parse_allocated_dmaresource() into its
caller.  This makes pnpacpi_parse_allocated_dmaresource() more similar
to pnpbios_parse_allocated_dmaresource().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work10.orig/drivers/pnp/pnpacpi/rsparser.c	2008-04-25 11:14:53.000000000 -0600
+++ work10/drivers/pnp/pnpacpi/rsparser.c	2008-04-25 11:14:53.000000000 -0600
@@ -169,8 +169,7 @@
 }
 
 static void pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res,
-						u32 dma, int type,
-						int bus_master, int transfer)
+						u32 dma, int flags)
 {
 	int i = 0;
 	static unsigned char warned;
@@ -180,8 +179,7 @@
 		i++;
 	if (i < PNP_MAX_DMA) {
 		res->dma_resource[i].flags = IORESOURCE_DMA;	// Also clears _UNSET flag
-		res->dma_resource[i].flags |=
-		    dma_flags(type, bus_master, transfer);
+		res->dma_resource[i].flags |= flags;
 		if (dma == -1) {
 			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
@@ -311,9 +309,8 @@
 		if (dma->channel_count > 0)
 			pnpacpi_parse_allocated_dmaresource(res_table,
 				dma->channels[0],
-				dma->type,
-				dma->bus_master,
-				dma->transfer);
+				dma_flags(dma->type, dma->bus_master,
+					  dma->transfer));
 		break;
 
 	case ACPI_RESOURCE_TYPE_IO:

-- 
