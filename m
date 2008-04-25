From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 36/54] PNP: convert resource checks to use pnp_get_resource(), not pnp_resource_table
Date: Fri, 25 Apr 2008 12:38:43 -0600
Message-ID: <20080425183931.427378637@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:7331 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759181AbYDYSkW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:40:22 -0400
Content-Disposition: inline; filename=pnp-convert-checks-to-pnp_get_resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This removes more direct references to pnp_resource_table.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

---
 drivers/pnp/resource.c |   96 +++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 38 deletions(-)

Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-04-25 11:15:05.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-04-25 11:15:06.000000000 -0600
@@ -270,8 +270,8 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_PORT; i++) {
-		tres = &dev->res.port_resource[i];
-		if (tres != res && tres->flags & IORESOURCE_IO) {
+		tres = pnp_get_resource(dev, IORESOURCE_IO, i);
+		if (tres && tres != res && tres->flags & IORESOURCE_IO) {
 			tport = &tres->start;
 			tend = &tres->end;
 			if (ranged_conflict(port, end, tport, tend))
@@ -284,8 +284,8 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_PORT; i++) {
-			tres = &tdev->res.port_resource[i];
-			if (tres->flags & IORESOURCE_IO) {
+			tres = pnp_get_resource(tdev, IORESOURCE_IO, i);
+			if (tres && tres->flags & IORESOURCE_IO) {
 				if (cannot_compare(tres->flags))
 					continue;
 				tport = &tres->start;
@@ -330,8 +330,8 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_MEM; i++) {
-		tres = &dev->res.mem_resource[i];
-		if (tres != res && tres->flags & IORESOURCE_MEM) {
+		tres = pnp_get_resource(dev, IORESOURCE_MEM, i);
+		if (tres && tres != res && tres->flags & IORESOURCE_MEM) {
 			taddr = &tres->start;
 			tend = &tres->end;
 			if (ranged_conflict(addr, end, taddr, tend))
@@ -344,8 +344,8 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_MEM; i++) {
-			tres = &tdev->res.mem_resource[i];
-			if (tres->flags & IORESOURCE_MEM) {
+			tres = pnp_get_resource(tdev, IORESOURCE_MEM, i);
+			if (tres && tres->flags & IORESOURCE_MEM) {
 				if (cannot_compare(tres->flags))
 					continue;
 				taddr = &tres->start;
@@ -389,8 +389,8 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
-		tres = &dev->res.irq_resource[i];
-		if (tres != res && tres->flags & IORESOURCE_IRQ) {
+		tres = pnp_get_resource(dev, IORESOURCE_IRQ, i);
+		if (tres && tres != res && tres->flags & IORESOURCE_IRQ) {
 			if (tres->start == *irq)
 				return 0;
 		}
@@ -423,8 +423,8 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_IRQ; i++) {
-			tres = &tdev->res.irq_resource[i];
-			if (tres->flags & IORESOURCE_IRQ) {
+			tres = pnp_get_resource(tdev, IORESOURCE_IRQ, i);
+			if (tres && tres->flags & IORESOURCE_IRQ) {
 				if (cannot_compare(tres->flags))
 					continue;
 				if (tres->start == *irq)
@@ -462,8 +462,8 @@
 
 	/* check for internal conflicts */
 	for (i = 0; i < PNP_MAX_DMA; i++) {
-		tres = &dev->res.dma_resource[i];
-		if (tres != res && tres->flags & IORESOURCE_DMA) {
+		tres = pnp_get_resource(dev, IORESOURCE_DMA, i);
+		if (tres && tres != res && tres->flags & IORESOURCE_DMA) {
 			if (tres->start == *dma)
 				return 0;
 		}
@@ -482,8 +482,8 @@
 		if (tdev == dev)
 			continue;
 		for (i = 0; i < PNP_MAX_DMA; i++) {
-			tres = &tdev->res.dma_resource[i];
-			if (tres->flags & IORESOURCE_DMA) {
+			tres = pnp_get_resource(tdev, IORESOURCE_DMA, i);
+			if (tres && tres->flags & IORESOURCE_DMA) {
 				if (cannot_compare(tres->flags))
 					continue;
 				if (tres->start == *dma)

-- 
