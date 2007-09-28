From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 3/6] PNP: use dev_info(), dev_err(), etc in core
Date: Fri, 28 Sep 2007 10:39:14 -0600
Message-ID: <20070928164350.079891622@ldl.fc.hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:59341 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbXI1Qn5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2007 12:43:57 -0400
Content-Disposition: inline; filename=pnp-print
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

If we have the struct pnp_dev available, we can use dev_info(), dev_err(),
etc., to give a little more information and consistency.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/card.c
===================================================================
--- w.orig/drivers/pnp/card.c	2007-09-13 16:26:02.000000000 -0600
+++ w/drivers/pnp/card.c	2007-09-13 16:26:04.000000000 -0600
@@ -198,8 +198,7 @@
 	card->dev.release = &pnp_release_card;
 	error = device_register(&card->dev);
 	if (error) {
-		pnp_err("sysfs failure, card '%s' will be unavailable",
-			card->dev.bus_id);
+		dev_err(&card->dev, "could not register (err=%d)\n", error);
 		return error;
 	}
 
Index: w/drivers/pnp/driver.c
===================================================================
--- w.orig/drivers/pnp/driver.c	2007-09-13 16:25:48.000000000 -0600
+++ w/drivers/pnp/driver.c	2007-09-13 16:26:04.000000000 -0600
@@ -86,9 +86,6 @@
 	pnp_dev = to_pnp_dev(dev);
 	pnp_drv = to_pnp_driver(dev->driver);
 
-	pnp_dbg("match found with the PnP device '%s' and the driver '%s'",
-		dev->bus_id, pnp_drv->name);
-
 	error = pnp_device_attach(pnp_dev);
 	if (error < 0)
 		return error;
@@ -116,6 +113,8 @@
 		error = 0;
 	} else
 		goto fail;
+
+	dev_dbg(dev, "driver attached\n");
 	return error;
 
 fail:
Index: w/drivers/pnp/interface.c
===================================================================
--- w.orig/drivers/pnp/interface.c	2007-09-13 16:25:48.000000000 -0600
+++ w/drivers/pnp/interface.c	2007-09-13 16:26:04.000000000 -0600
@@ -327,8 +327,7 @@
 
 	if (dev->status & PNP_ATTACHED) {
 		retval = -EBUSY;
-		pnp_info("Device %s cannot be configured because it is in use.",
-			 dev->dev.bus_id);
+		dev_info(&dev->dev, "in use; can't configure\n");
 		goto done;
 	}
 
Index: w/drivers/pnp/manager.c
===================================================================
--- w.orig/drivers/pnp/manager.c	2007-09-13 16:25:48.000000000 -0600
+++ w/drivers/pnp/manager.c	2007-09-13 16:26:04.000000000 -0600
@@ -22,8 +22,7 @@
 	unsigned long *flags;
 
 	if (idx >= PNP_MAX_PORT) {
-		pnp_err
-		    ("More than 4 ports is incompatible with pnp specifications.");
+		dev_err(&dev->dev, "too many I/O port resources\n");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -64,8 +63,7 @@
 	unsigned long *flags;
 
 	if (idx >= PNP_MAX_MEM) {
-		pnp_err
-		    ("More than 8 mems is incompatible with pnp specifications.");
+		dev_err(&dev->dev, "too many memory resources\n");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -122,8 +120,7 @@
 	};
 
 	if (idx >= PNP_MAX_IRQ) {
-		pnp_err
-		    ("More than 2 irqs is incompatible with pnp specifications.");
+		dev_err(&dev->dev, "too many IRQ resources\n");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -173,8 +170,7 @@
 	};
 
 	if (idx >= PNP_MAX_DMA) {
-		pnp_err
-		    ("More than 2 dmas is incompatible with pnp specifications.");
+		dev_err(&dev->dev, "too many DMA resources\n");
 		/* pretend we were successful so at least the manager won't try again */
 		return 1;
 	}
@@ -447,8 +443,7 @@
 	int i = 1;
 
 	if (!pnp_can_configure(dev)) {
-		pnp_dbg("Device %s does not support resource configuration.",
-			dev->dev.bus_id);
+		dev_dbg(&dev->dev, "configuration not supported\n");
 		return -ENODEV;
 	}
 
@@ -465,7 +460,7 @@
 		} while (dep);
 	}
 
-	pnp_err("Unable to assign resources to device %s.", dev->dev.bus_id);
+	dev_err(&dev->dev, "unable to assign resources\n");
 	return -EBUSY;
 }
 
@@ -478,17 +473,16 @@
 int pnp_start_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_write(dev)) {
-		pnp_dbg("Device %s does not support activation.",
-			dev->dev.bus_id);
+		dev_dbg(&dev->dev, "activation not supported\n");
 		return -EINVAL;
 	}
 
 	if (dev->protocol->set(dev, &dev->res) < 0) {
-		pnp_err("Failed to activate device %s.", dev->dev.bus_id);
+		dev_err(&dev->dev, "activation failed\n");
 		return -EIO;
 	}
 
-	pnp_info("Device %s activated.", dev->dev.bus_id);
+	dev_info(&dev->dev, "activated\n");
 	return 0;
 }
 
@@ -501,16 +495,15 @@
 int pnp_stop_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_disable(dev)) {
-		pnp_dbg("Device %s does not support disabling.",
-			dev->dev.bus_id);
+		dev_dbg(&dev->dev, "disabling not supported\n");
 		return -EINVAL;
 	}
 	if (dev->protocol->disable(dev) < 0) {
-		pnp_err("Failed to disable device %s.", dev->dev.bus_id);
+		dev_err(&dev->dev, "disable failed\n");
 		return -EIO;
 	}
 
-	pnp_info("Device %s disabled.", dev->dev.bus_id);
+	dev_info(&dev->dev, "disabled\n");
 	return 0;
 }
 
Index: w/drivers/pnp/quirks.c
===================================================================
--- w.orig/drivers/pnp/quirks.c	2007-09-13 16:25:48.000000000 -0600
+++ w/drivers/pnp/quirks.c	2007-09-13 16:26:04.000000000 -0600
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/pnp.h>
 #include <linux/io.h>
+#include <linux/kallsyms.h>
 #include "base.h"
 
 static void quirk_awe32_resources(struct pnp_dev *dev)
@@ -133,11 +134,18 @@
 void pnp_fixup_device(struct pnp_dev *dev)
 {
 	int i = 0;
+	void (*quirk)(struct pnp_dev *);
 
 	while (*pnp_fixups[i].id) {
 		if (compare_pnp_id(dev->id, pnp_fixups[i].id)) {
-			pnp_dbg("Calling quirk for %s", dev->dev.bus_id);
-			pnp_fixups[i].quirk_function(dev);
+			quirk = pnp_fixups[i].quirk_function;
+
+#ifdef DEBUG
+			dev_dbg(&dev->dev, "calling quirk 0x%p", quirk);
+			print_fn_descriptor_symbol(": %s()\n",
+				(unsigned long) *quirk);
+#endif
+			(*quirk)(dev);
 		}
 		i++;
 	}
Index: w/drivers/pnp/resource.c
===================================================================
--- w.orig/drivers/pnp/resource.c	2007-09-13 16:25:48.000000000 -0600
+++ w/drivers/pnp/resource.c	2007-09-13 16:26:04.000000000 -0600
@@ -51,7 +51,7 @@
 
 	/* this should never happen but if it does we'll try to continue */
 	if (dev->independent)
-		pnp_err("independent resource already registered");
+		dev_err(&dev->dev, "independent resource already registered\n");
 	dev->independent = option;
 	return option;
 }
Index: w/include/linux/pnp.h
===================================================================
--- w.orig/include/linux/pnp.h	2007-09-13 16:25:48.000000000 -0600
+++ w/include/linux/pnp.h	2007-09-13 16:26:04.000000000 -0600
@@ -8,6 +8,10 @@
 
 #ifdef __KERNEL__
 
+#ifdef CONFIG_PNP_DEBUG
+#define DEBUG
+#endif
+
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/errno.h>

--
