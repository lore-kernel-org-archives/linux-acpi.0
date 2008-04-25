From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 32/54] PNP: reduce redundancy in pnp_check_port() and others
Date: Fri, 25 Apr 2008 12:38:39 -0600
Message-ID: <20080425183930.626960666@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:48680 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764670AbYDYSkN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:40:13 -0400
Content-Disposition: inline; filename=pnp-simplify-check-functions
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Use a temporary "res" pointer to replace repeated lookups in
the pnp resource tables.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-04-25 11:15:02.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-04-25 11:15:03.000000000 -0600
@@ -243,13 +243,15 @@
 {
 	int i;
 	struct pnp_dev *tdev;
+	struct resource *res, *tres;
 	resource_size_t *port, *end, *tport, *tend;
 
-	port = &dev->res.port_resource[idx].start;
-	end = &dev->res.port_resource[idx].end;
+	res = &dev->res.port_resource[idx];
+	port = &res->start;
+	end = &res->end;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (cannot_compare(dev->res.port_resource[idx].flags))
+	if (cannot_compare(res->flags))
 		return 1;
 
 	/* check if the resource is already in use, skip if the
@@ -269,9 +271,10 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_PORT && i != idx; i++) {
-		if (dev->res.port_resource[i].flags & IORESOURCE_IO) {
-			tport = &dev->res.port_resource[i].start;
-			tend = &dev->res.port_resource[i].end;
+		tres = &dev->res.port_resource[i];
+		if (tres->flags & IORESOURCE_IO) {
+			tport = &tres->start;
+			tend = &tres->end;
 			if (ranged_conflict(port, end, tport, tend))
 				return 0;
 		}
@@ -282,12 +285,12 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_PORT; i++) {
-			if (tdev->res.port_resource[i].flags & IORESOURCE_IO) {
-				if (cannot_compare
-				    (tdev->res.port_resource[i].flags))
+			tres = &tdev->res.port_resource[i];
+			if (tres->flags & IORESOURCE_IO) {
+				if (cannot_compare(tres->flags))
 					continue;
-				tport = &tdev->res.port_resource[i].start;
-				tend = &tdev->res.port_resource[i].end;
+				tport = &tres->start;
+				tend = &tres->end;
 				if (ranged_conflict(port, end, tport, tend))
 					return 0;
 			}
@@ -301,13 +304,15 @@
 {
 	int i;
 	struct pnp_dev *tdev;
+	struct resource *res, *tres;
 	resource_size_t *addr, *end, *taddr, *tend;
 
-	addr = &dev->res.mem_resource[idx].start;
-	end = &dev->res.mem_resource[idx].end;
+	res = &dev->res.mem_resource[idx];
+	addr = &res->start;
+	end = &res->end;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (cannot_compare(dev->res.mem_resource[idx].flags))
+	if (cannot_compare(res->flags))
 		return 1;
 
 	/* check if the resource is already in use, skip if the
@@ -327,9 +332,10 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_MEM && i != idx; i++) {
-		if (dev->res.mem_resource[i].flags & IORESOURCE_MEM) {
-			taddr = &dev->res.mem_resource[i].start;
-			tend = &dev->res.mem_resource[i].end;
+		tres = &dev->res.mem_resource[i];
+		if (tres->flags & IORESOURCE_MEM) {
+			taddr = &tres->start;
+			tend = &tres->end;
 			if (ranged_conflict(addr, end, taddr, tend))
 				return 0;
 		}
@@ -340,12 +346,12 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_MEM; i++) {
-			if (tdev->res.mem_resource[i].flags & IORESOURCE_MEM) {
-				if (cannot_compare
-				    (tdev->res.mem_resource[i].flags))
+			tres = &tdev->res.mem_resource[i];
+			if (tres->flags & IORESOURCE_MEM) {
+				if (cannot_compare(tres->flags))
 					continue;
-				taddr = &tdev->res.mem_resource[i].start;
-				tend = &tdev->res.mem_resource[i].end;
+				taddr = &tres->start;
+				tend = &tres->end;
 				if (ranged_conflict(addr, end, taddr, tend))
 					return 0;
 			}
@@ -364,10 +370,14 @@
 {
 	int i;
 	struct pnp_dev *tdev;
-	resource_size_t *irq = &dev->res.irq_resource[idx].start;
+	struct resource *res, *tres;
+	resource_size_t *irq;
+
+	res = &dev->res.irq_resource[idx];
+	irq = &res->start;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (cannot_compare(dev->res.irq_resource[idx].flags))
+	if (cannot_compare(res->flags))
 		return 1;
 
 	/* check if the resource is valid */
@@ -382,8 +392,9 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_IRQ && i != idx; i++) {
-		if (dev->res.irq_resource[i].flags & IORESOURCE_IRQ) {
-			if (dev->res.irq_resource[i].start == *irq)
+		tres = &dev->res.irq_resource[i];
+		if (tres->flags & IORESOURCE_IRQ) {
+			if (tres->start == *irq)
 				return 0;
 		}
 	}
@@ -415,11 +426,11 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_IRQ; i++) {
-			if (tdev->res.irq_resource[i].flags & IORESOURCE_IRQ) {
-				if (cannot_compare
-				    (tdev->res.irq_resource[i].flags))
+			tres = &tdev->res.irq_resource[i];
+			if (tres->flags & IORESOURCE_IRQ) {
+				if (cannot_compare(tres->flags))
 					continue;
-				if ((tdev->res.irq_resource[i].start == *irq))
+				if (tres->start == *irq)
 					return 0;
 			}
 		}
@@ -433,10 +444,14 @@
 #ifndef CONFIG_IA64
 	int i;
 	struct pnp_dev *tdev;
-	resource_size_t *dma = &dev->res.dma_resource[idx].start;
+	struct resource *res, *tres;
+	resource_size_t *dma;
+
+	res = &dev->res.dma_resource[idx];
+	dma = &res->start;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (cannot_compare(dev->res.dma_resource[idx].flags))
+	if (cannot_compare(res->flags))
 		return 1;
 
 	/* check if the resource is valid */
@@ -451,8 +466,9 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_DMA && i != idx; i++) {
-		if (dev->res.dma_resource[i].flags & IORESOURCE_DMA) {
-			if (dev->res.dma_resource[i].start == *dma)
+		tres = &dev->res.dma_resource[i];
+		if (tres->flags & IORESOURCE_DMA) {
+			if (tres->start == *dma)
 				return 0;
 		}
 	}
@@ -470,11 +486,11 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_DMA; i++) {
-			if (tdev->res.dma_resource[i].flags & IORESOURCE_DMA) {
-				if (cannot_compare
-				    (tdev->res.dma_resource[i].flags))
+			tres = &tdev->res.dma_resource[i];
+			if (tres->flags & IORESOURCE_DMA) {
+				if (cannot_compare(tres->flags))
 					continue;
-				if ((tdev->res.dma_resource[i].start == *dma))
+				if (tres->start == *dma)
 					return 0;
 			}
 		}

-- 
