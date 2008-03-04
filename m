From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNP: use dev_printk for quirk messages
Date: Tue, 4 Mar 2008 16:47:27 -0700
Message-ID: <200803041647.28298.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:12558 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbYCDXpS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:45:18 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Convert quirk printks to dev_printk().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: linux-mm/drivers/pnp/quirks.c
===================================================================
--- linux-mm.orig/drivers/pnp/quirks.c	2008-03-04 16:41:17.000000000 -0700
+++ linux-mm/drivers/pnp/quirks.c	2008-03-04 16:44:00.000000000 -0700
@@ -51,7 +51,8 @@
 		port3->min += 0x800;
 		port3->max += 0x800;
 	}
-	printk(KERN_INFO "pnp: AWE32 quirk - adding two ports\n");
+	dev_info(&dev->dev, "AWE32 quirk - added ioports 0x%lx and 0x%lx\n",
+		(unsigned long) port2->min, (unsigned long) port3->min);
 }
 
 static void quirk_cmi8330_resources(struct pnp_dev *dev)
@@ -74,7 +75,8 @@
 			    IORESOURCE_DMA_8BIT)
 				dma->map = 0x000A;
 	}
-	printk(KERN_INFO "pnp: CMI8330 quirk - fixing interrupts and dma\n");
+	dev_info(&dev->dev, "CMI8330 quirk - forced possible IRQs to 5, 7, 10 "
+		"and DMA channels to 1, 3\n");
 }
 
 static void quirk_sb16audio_resources(struct pnp_dev *dev)
@@ -105,8 +107,7 @@
 		changed = 1;
 	}
 	if (changed)
-		printk(KERN_INFO
-		       "pnp: SB audio device quirk - increasing port range\n");
+		dev_info(&dev->dev, "SB audio device quirk - increased port range\n");
 }
 
 static void quirk_supermicro_h8dce_system(struct pnp_dev *dev)
