From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 13/37] PNPACPI: hoist dma_flags() out of pnpacpi_parse_allocated_dmaresource()
Date: Tue, 01 Apr 2008 09:16:47 -0600
Message-ID: <20080401151738.255603896@ldl.fc.hp.com>
References: <20080401151634.730901933@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:27004 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759280AbYDAPSA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 11:18:00 -0400
Content-Disposition: inline; filename=pnpacpi-hoist-dma-flags
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Hoist dma_flags() out of pnpacpi_parse_allocated_dmaresource() into its
caller.  This makes pnpacpi_parse_allocated_dmaresource() more similar
to pnpbios_parse_allocated_dmaresource().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/rsparser.c	2008-03-21 15:08:36.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/rsparser.c	2008-03-21 15:10:22.000000000 -0600
@@ -167,8 +167,7 @@
 }
 
 static void pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res,
-						u32 dma, int type,
-						int bus_master, int transfer)
+						u32 dma, int flags)
 {
 	int i = 0;
 	static unsigned char warned;
@@ -178,8 +177,7 @@
 		i++;
 	if (i < PNP_MAX_DMA) {
 		res->dma_resource[i].flags = IORESOURCE_DMA;	// Also clears _UNSET flag
-		res->dma_resource[i].flags |=
-		    dma_flags(type, bus_master, transfer);
+		res->dma_resource[i].flags |= flags;
 		if (dma == -1) {
 			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
@@ -309,9 +307,8 @@
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
