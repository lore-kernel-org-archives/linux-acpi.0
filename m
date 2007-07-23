From: helgaas@ldl.fc.hp.com
Subject: [patch 08/17] PNP: Lindent support.c
Date: Mon, 23 Jul 2007 15:28:05 -0600
Message-ID: <20070723213241.950348237@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56461 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758991AbXGWVda (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:30 -0400
Content-Disposition: inline; filename=pnp-format-support
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/support.c
===================================================================
--- work2.orig/drivers/pnp/support.c	2007-07-20 15:51:34.000000000 -0600
+++ work2/drivers/pnp/support.c	2007-07-20 15:52:21.000000000 -0600
@@ -1,8 +1,7 @@
 /*
- * support.c - provides standard pnp functions for the use of pnp protocol drivers,
+ * support.c - standard functions for the use of pnp protocol drivers
  *
  * Copyright 2003 Adam Belay <ambx1@neo.rr.com>
- *
  */
 
 #include <linux/module.h>
@@ -11,22 +10,18 @@
 #include "base.h"
 
 /**
- * pnp_is_active - Determines if a device is active based on its current resources
+ * pnp_is_active - Determines if a device is active based on its current
+ *	resources
  * @dev: pointer to the desired PnP device
- *
  */
-
-int pnp_is_active(struct pnp_dev * dev)
+int pnp_is_active(struct pnp_dev *dev)
 {
 	if (!pnp_port_start(dev, 0) && pnp_port_len(dev, 0) <= 1 &&
 	    !pnp_mem_start(dev, 0) && pnp_mem_len(dev, 0) <= 1 &&
-	    pnp_irq(dev, 0) == -1 &&
-	    pnp_dma(dev, 0) == -1)
-	    	return 0;
+	    pnp_irq(dev, 0) == -1 && pnp_dma(dev, 0) == -1)
+		return 0;
 	else
 		return 1;
 }
 
-
-
 EXPORT_SYMBOL(pnp_is_active);

--
