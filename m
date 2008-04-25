From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 33/54] PNP: reduce redundancy in pnp_set_current_resources()
Date: Fri, 25 Apr 2008 12:38:40 -0600
Message-ID: <20080425183930.822331763@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:9995 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764669AbYDYSkM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:40:12 -0400
Content-Disposition: inline; filename=pnp-simplify-proc-functions
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Use a temporary "res" pointer to replace repeated lookups in
the pnp resource tables.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/interface.c
===================================================================
--- work10.orig/drivers/pnp/interface.c	2008-04-25 11:14:58.000000000 -0600
+++ work10/drivers/pnp/interface.c	2008-04-25 11:15:04.000000000 -0600
@@ -323,6 +323,7 @@
 			  const char *ubuf, size_t count)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct resource *res;
 	char *buf = (void *)ubuf;
 	int retval = 0;
 
@@ -382,21 +383,18 @@
 				buf += 2;
 				while (isspace(*buf))
 					++buf;
-				dev->res.port_resource[nport].start =
-				    simple_strtoul(buf, &buf, 0);
+				res = &dev->res.port_resource[nport];
+				res->start = simple_strtoul(buf, &buf, 0);
 				while (isspace(*buf))
 					++buf;
 				if (*buf == '-') {
 					buf += 1;
 					while (isspace(*buf))
 						++buf;
-					dev->res.port_resource[nport].end =
-					    simple_strtoul(buf, &buf, 0);
+					res->end = simple_strtoul(buf, &buf, 0);
 				} else
-					dev->res.port_resource[nport].end =
-					    dev->res.port_resource[nport].start;
-				dev->res.port_resource[nport].flags =
-				    IORESOURCE_IO;
+					res->end = res->start;
+				res->flags = IORESOURCE_IO;
 				nport++;
 				if (nport >= PNP_MAX_PORT)
 					break;
@@ -406,21 +404,18 @@
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
-				dev->res.mem_resource[nmem].start =
-				    simple_strtoul(buf, &buf, 0);
+				res = &dev->res.mem_resource[nmem];
+				res->start = simple_strtoul(buf, &buf, 0);
 				while (isspace(*buf))
 					++buf;
 				if (*buf == '-') {
 					buf += 1;
 					while (isspace(*buf))
 						++buf;
-					dev->res.mem_resource[nmem].end =
-					    simple_strtoul(buf, &buf, 0);
+					res->end = simple_strtoul(buf, &buf, 0);
 				} else
-					dev->res.mem_resource[nmem].end =
-					    dev->res.mem_resource[nmem].start;
-				dev->res.mem_resource[nmem].flags =
-				    IORESOURCE_MEM;
+					res->end = res->start;
+				res->flags = IORESOURCE_MEM;
 				nmem++;
 				if (nmem >= PNP_MAX_MEM)
 					break;
@@ -430,11 +425,10 @@
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
-				dev->res.irq_resource[nirq].start =
-				    dev->res.irq_resource[nirq].end =
+				res = &dev->res.irq_resource[nirq];
+				res->start = res->end =
 				    simple_strtoul(buf, &buf, 0);
-				dev->res.irq_resource[nirq].flags =
-				    IORESOURCE_IRQ;
+				res->flags = IORESOURCE_IRQ;
 				nirq++;
 				if (nirq >= PNP_MAX_IRQ)
 					break;
@@ -444,11 +438,10 @@
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
-				dev->res.dma_resource[ndma].start =
-				    dev->res.dma_resource[ndma].end =
+				res = &dev->res.dma_resource[ndma];
+				res->start = res->end =
 				    simple_strtoul(buf, &buf, 0);
-				dev->res.dma_resource[ndma].flags =
-				    IORESOURCE_DMA;
+				res->flags = IORESOURCE_DMA;
 				ndma++;
 				if (ndma >= PNP_MAX_DMA)
 					break;

-- 
