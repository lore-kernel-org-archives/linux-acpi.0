From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 34/55] PNP: check for conflicts with all resources, not just earlier ones
Date: Mon, 28 Apr 2008 16:34:21 -0600
Message-ID: <20080428223623.462892616@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:3748 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966715AbYD1WhC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:37:02 -0400
Content-Disposition: inline; filename=pnp-remove-idx-from-check-functions
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This patch removes a use of "idx" in pnp_check_port() and similar
functions, in preparation for replacing idx with a pointer to the
resource itself.

I split this out because it changes the behavior slightly: we used
to check for conflicts only with earlier resources, e.g., we checked
resource 2 against resources 0 and 1 but not against 3, 4, etc.  Now
we will check against all resources except 2.

Since resources are assigned in ascending order, the old behavior
was probably safe, but I don't like to depend on that ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/resource.c
===================================================================
--- work10.orig/drivers/pnp/resource.c	2008-04-28 16:09:32.000000000 -0600
+++ work10/drivers/pnp/resource.c	2008-04-28 16:09:33.000000000 -0600
@@ -270,9 +270,9 @@
 	}
 
 	/* check for internal conflicts */
-	for (i = 0; i < PNP_MAX_PORT && i != idx; i++) {
+	for (i = 0; i < PNP_MAX_PORT; i++) {
 		tres = &dev->res.port_resource[i];
-		if (tres->flags & IORESOURCE_IO) {
+		if (tres != res && tres->flags & IORESOURCE_IO) {
 			tport = &tres->start;
 			tend = &tres->end;
 			if (ranged_conflict(port, end, tport, tend))
@@ -331,9 +331,9 @@
 	}
 
 	/* check for internal conflicts */
-	for (i = 0; i < PNP_MAX_MEM && i != idx; i++) {
+	for (i = 0; i < PNP_MAX_MEM; i++) {
 		tres = &dev->res.mem_resource[i];
-		if (tres->flags & IORESOURCE_MEM) {
+		if (tres != res && tres->flags & IORESOURCE_MEM) {
 			taddr = &tres->start;
 			tend = &tres->end;
 			if (ranged_conflict(addr, end, taddr, tend))
@@ -391,9 +391,9 @@
 	}
 
 	/* check for internal conflicts */
-	for (i = 0; i < PNP_MAX_IRQ && i != idx; i++) {
+	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		tres = &dev->res.irq_resource[i];
-		if (tres->flags & IORESOURCE_IRQ) {
+		if (tres != res && tres->flags & IORESOURCE_IRQ) {
 			if (tres->start == *irq)
 				return 0;
 		}
@@ -465,9 +465,9 @@
 	}
 
 	/* check for internal conflicts */
-	for (i = 0; i < PNP_MAX_DMA && i != idx; i++) {
+	for (i = 0; i < PNP_MAX_DMA; i++) {
 		tres = &dev->res.dma_resource[i];
-		if (tres->flags & IORESOURCE_DMA) {
+		if (tres != res && tres->flags & IORESOURCE_DMA) {
 			if (tres->start == *dma)
 				return 0;
 		}

-- 
