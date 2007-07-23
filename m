From: helgaas@ldl.fc.hp.com
Subject: [patch 06/17] PNP: Lindent quirks.c
Date: Mon, 23 Jul 2007 15:28:03 -0600
Message-ID: <20070723213241.545252561@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:52761 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903AbXGWVdS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:18 -0400
Content-Disposition: inline; filename=pnp-format-quirks
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/quirks.c
===================================================================
--- work2.orig/drivers/pnp/quirks.c	2007-07-20 15:47:30.000000000 -0600
+++ work2/drivers/pnp/quirks.c	2007-07-20 15:48:12.000000000 -0600
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include "base.h"
 
-
 static void quirk_awe32_resources(struct pnp_dev *dev)
 {
 	struct pnp_port *port, *port2, *port3;
@@ -31,7 +30,7 @@
 	 * two extra ports (at offset 0x400 and 0x800 from the one given) by
 	 * hand.
 	 */
-	for ( ; res ; res = res->next ) {
+	for (; res; res = res->next) {
 		port2 = pnp_alloc(sizeof(struct pnp_port));
 		if (!port2)
 			return;
@@ -58,18 +57,19 @@
 	struct pnp_option *res = dev->dependent;
 	unsigned long tmp;
 
-	for ( ; res ; res = res->next ) {
+	for (; res; res = res->next) {
 
 		struct pnp_irq *irq;
 		struct pnp_dma *dma;
 
-		for( irq = res->irq; irq; irq = irq->next ) {	// Valid irqs are 5, 7, 10
+		for (irq = res->irq; irq; irq = irq->next) {	// Valid irqs are 5, 7, 10
 			tmp = 0x04A0;
 			bitmap_copy(irq->map, &tmp, 16);	// 0000 0100 1010 0000
 		}
 
-		for( dma = res->dma; dma; dma = dma->next ) // Valid 8bit dma channels are 1,3
-			if( ( dma->flags & IORESOURCE_DMA_TYPE_MASK ) == IORESOURCE_DMA_8BIT )
+		for (dma = res->dma; dma; dma = dma->next)	// Valid 8bit dma channels are 1,3
+			if ((dma->flags & IORESOURCE_DMA_TYPE_MASK) ==
+			    IORESOURCE_DMA_8BIT)
 				dma->map = 0x000A;
 	}
 	printk(KERN_INFO "pnp: CMI8330 quirk - fixing interrupts and dma\n");
@@ -79,7 +79,7 @@
 {
 	struct pnp_port *port;
 	struct pnp_option *res = dev->dependent;
-	int    changed = 0;
+	int changed = 0;
 
 	/*
 	 * The default range on the mpu port for these devices is 0x388-0x388.
@@ -87,24 +87,24 @@
 	 * auto-configured.
 	 */
 
-	for( ; res ; res = res->next ) {
+	for (; res; res = res->next) {
 		port = res->port;
-		if(!port)
+		if (!port)
 			continue;
 		port = port->next;
-		if(!port)
+		if (!port)
 			continue;
 		port = port->next;
-		if(!port)
+		if (!port)
 			continue;
-		if(port->min != port->max)
+		if (port->min != port->max)
 			continue;
 		port->max += 0x70;
 		changed = 1;
 	}
-	if(changed)
-		printk(KERN_INFO "pnp: SB audio device quirk - increasing port range\n");
-	return;
+	if (changed)
+		printk(KERN_INFO
+		       "pnp: SB audio device quirk - increasing port range\n");
 }
 
 static int quirk_smc_fir_enabled(struct pnp_dev *dev)
@@ -124,7 +124,7 @@
 	outb(bank, firbase + 7);
 
 	high = inb(firbase + 0);
-	low  = inb(firbase + 1);
+	low = inb(firbase + 1);
 	chip = inb(firbase + 2);
 
 	/* This corresponds to the check in smsc_ircc_present() */
@@ -153,8 +153,8 @@
 	 */
 	dev_err(&dev->dev, "%s not responding at SIR 0x%lx, FIR 0x%lx; "
 		"auto-configuring\n", dev->id->id,
-		(unsigned long) pnp_port_start(dev, 0),
-		(unsigned long) pnp_port_start(dev, 1));
+		(unsigned long)pnp_port_start(dev, 0),
+		(unsigned long)pnp_port_start(dev, 1));
 
 	pnp_disable_dev(dev);
 	pnp_init_resource_table(&dev->res);
@@ -162,8 +162,8 @@
 	pnp_activate_dev(dev);
 	if (quirk_smc_fir_enabled(dev)) {
 		dev_err(&dev->dev, "responds at SIR 0x%lx, FIR 0x%lx\n",
-			(unsigned long) pnp_port_start(dev, 0),
-			(unsigned long) pnp_port_start(dev, 1));
+			(unsigned long)pnp_port_start(dev, 0),
+			(unsigned long)pnp_port_start(dev, 1));
 		return;
 	}
 
@@ -175,8 +175,8 @@
 	 */
 	dev_err(&dev->dev, "not responding at SIR 0x%lx, FIR 0x%lx; "
 		"swapping SIR/FIR and reconfiguring\n",
-		(unsigned long) pnp_port_start(dev, 0),
-		(unsigned long) pnp_port_start(dev, 1));
+		(unsigned long)pnp_port_start(dev, 0),
+		(unsigned long)pnp_port_start(dev, 1));
 
 	/*
 	 * Clear IORESOURCE_AUTO so pnp_activate_dev() doesn't reassign
@@ -200,8 +200,8 @@
 
 	if (quirk_smc_fir_enabled(dev)) {
 		dev_err(&dev->dev, "responds at SIR 0x%lx, FIR 0x%lx\n",
-			(unsigned long) pnp_port_start(dev, 0),
-			(unsigned long) pnp_port_start(dev, 1));
+			(unsigned long)pnp_port_start(dev, 0),
+			(unsigned long)pnp_port_start(dev, 1));
 		return;
 	}
 
@@ -209,7 +209,6 @@
 		"email bjorn.helgaas@hp.com\n");
 }
 
-
 /*
  *  PnP Quirks
  *  Cards or devices that need some tweaking due to incomplete resource info
@@ -217,21 +216,21 @@
 
 static struct pnp_fixup pnp_fixups[] = {
 	/* Soundblaster awe io port quirk */
-	{ "CTL0021", quirk_awe32_resources },
-	{ "CTL0022", quirk_awe32_resources },
-	{ "CTL0023", quirk_awe32_resources },
+	{"CTL0021", quirk_awe32_resources},
+	{"CTL0022", quirk_awe32_resources},
+	{"CTL0023", quirk_awe32_resources},
 	/* CMI 8330 interrupt and dma fix */
-	{ "@X@0001", quirk_cmi8330_resources },
+	{"@X@0001", quirk_cmi8330_resources},
 	/* Soundblaster audio device io port range quirk */
-	{ "CTL0001", quirk_sb16audio_resources },
-	{ "CTL0031", quirk_sb16audio_resources },
-	{ "CTL0041", quirk_sb16audio_resources },
-	{ "CTL0042", quirk_sb16audio_resources },
-	{ "CTL0043", quirk_sb16audio_resources },
-	{ "CTL0044", quirk_sb16audio_resources },
-	{ "CTL0045", quirk_sb16audio_resources },
-	{ "SMCf010", quirk_smc_enable },
-	{ "" }
+	{"CTL0001", quirk_sb16audio_resources},
+	{"CTL0031", quirk_sb16audio_resources},
+	{"CTL0041", quirk_sb16audio_resources},
+	{"CTL0042", quirk_sb16audio_resources},
+	{"CTL0043", quirk_sb16audio_resources},
+	{"CTL0044", quirk_sb16audio_resources},
+	{"CTL0045", quirk_sb16audio_resources},
+	{"SMCf010", quirk_smc_enable},
+	{""}
 };
 
 void pnp_fixup_device(struct pnp_dev *dev)
@@ -239,9 +238,8 @@
 	int i = 0;
 
 	while (*pnp_fixups[i].id) {
-		if (compare_pnp_id(dev->id,pnp_fixups[i].id)) {
-			pnp_dbg("Calling quirk for %s",
-		                  dev->dev.bus_id);
+		if (compare_pnp_id(dev->id, pnp_fixups[i].id)) {
+			pnp_dbg("Calling quirk for %s", dev->dev.bus_id);
 			pnp_fixups[i].quirk_function(dev);
 		}
 		i++;

--
