From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 4/6] PNP: use dev_info() in system driver
Date: Fri, 28 Sep 2007 10:39:15 -0600
Message-ID: <20070928164350.276228354@ldl.fc.hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:55143 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXI1Qn6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2007 12:43:58 -0400
Content-Disposition: inline; filename=pnp-system-messages
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Use dev_info() for a little consistency.  Changes this:

    pnp: 00:01: ioport range 0xf50-0xf58 has been reserved
    pnp: 00:01: ioport range 0x408-0x40f has been reserved
    pnp: 00:01: ioport range 0x900-0x903 has been reserved

to this:

    system 00:01: ioport range 0xf50-0xf58 has been reserved
    system 00:01: ioport range 0x408-0x40f has been reserved
    system 00:01: ioport range 0x900-0x903 has been reserved

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/system.c
===================================================================
--- w.orig/drivers/pnp/system.c	2007-09-13 16:27:50.000000000 -0600
+++ w/drivers/pnp/system.c	2007-09-13 16:49:24.000000000 -0600
@@ -22,36 +22,39 @@
 	{"", 0}
 };
 
-static void reserve_range(const char *pnpid, resource_size_t start,
+static void reserve_range(struct pnp_dev *dev, resource_size_t start,
 			  resource_size_t end, int port)
 {
-	struct resource *res;
 	char *regionid;
+	const char *pnpid = dev->dev.bus_id;
+	struct resource *res;
 
 	regionid = kmalloc(16, GFP_KERNEL);
-	if (regionid == NULL)
+	if (!regionid)
 		return;
+
 	snprintf(regionid, 16, "pnp %s", pnpid);
 	if (port)
 		res = request_region(start, end - start + 1, regionid);
 	else
 		res = request_mem_region(start, end - start + 1, regionid);
-	if (res == NULL)
-		kfree(regionid);
-	else
+	if (res)
 		res->flags &= ~IORESOURCE_BUSY;
+	else
+		kfree(regionid);
+
 	/*
 	 * Failures at this point are usually harmless. pci quirks for
 	 * example do reserve stuff they know about too, so we may well
 	 * have double reservations.
 	 */
-	printk(KERN_INFO "pnp: %s: %s range 0x%llx-0x%llx %s reserved\n",
-	       pnpid, port ? "ioport" : "iomem",
-	       (unsigned long long)start, (unsigned long long)end,
-	       NULL != res ? "has been" : "could not be");
+	dev_info(&dev->dev, "%s range 0x%llx-0x%llx %s reserved\n",
+		port ? "ioport" : "iomem",
+		(unsigned long long) start, (unsigned long long) end,
+		res ? "has been" : "could not be");
 }
 
-static void reserve_resources_of_dev(const struct pnp_dev *dev)
+static void reserve_resources_of_dev(struct pnp_dev *dev)
 {
 	int i;
 
@@ -73,7 +76,7 @@
 		if (pnp_port_end(dev, i) < pnp_port_start(dev, i))
 			continue;	/* invalid */
 
-		reserve_range(dev->dev.bus_id, pnp_port_start(dev, i),
+		reserve_range(dev, pnp_port_start(dev, i),
 			      pnp_port_end(dev, i), 1);
 	}
 
@@ -81,7 +84,7 @@
 		if (!pnp_mem_valid(dev, i))
 			continue;
 
-		reserve_range(dev->dev.bus_id, pnp_mem_start(dev, i),
+		reserve_range(dev, pnp_mem_start(dev, i),
 			      pnp_mem_end(dev, i), 0);
 	}
 }

--
