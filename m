From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 3/5] PNP: system.c whitespace cleanup
Date: Thu, 18 Jan 2007 16:43:46 -0700
Message-ID: <200701181643.46746.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:51486 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932772AbXARXnx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jan 2007 18:43:53 -0500
In-Reply-To: <200701181636.45590.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

No functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: mm-work3/drivers/pnp/system.c
===================================================================
--- mm-work3.orig/drivers/pnp/system.c	2007-01-12 12:14:53.000000000 -0700
+++ mm-work3/drivers/pnp/system.c	2007-01-12 12:16:59.000000000 -0700
@@ -28,15 +28,15 @@
 	char *regionid;
 
 	regionid = kmalloc(16, GFP_KERNEL);
-	if ( regionid == NULL )
+	if (regionid == NULL)
 		return;
 	snprintf(regionid, 16, "pnp %s", pnpid);
 	if (port)
 		res = request_region(start,end-start+1,regionid);
 	else
 		res = request_mem_region(start,end-start+1,regionid);
-	if ( res == NULL )
-		kfree( regionid );
+	if (res == NULL)
+		kfree(regionid);
 	else
 		res->flags &= ~IORESOURCE_BUSY;
 	/*
@@ -47,24 +47,18 @@
 	printk(KERN_INFO
 		"pnp: %s: %s range 0x%x-0x%x %s reserved\n",
 		pnpid, port ? "ioport" : "iomem", start, end,
-		NULL != res ? "has been" : "could not be"
-	);
-
-	return;
+		NULL != res ? "has been" : "could not be");
 }
 
-static void reserve_resources_of_dev( struct pnp_dev *dev )
+static void reserve_resources_of_dev(struct pnp_dev *dev)
 {
 	int i;
 
-	for (i=0;i<PNP_MAX_PORT;i++) {
+	for (i = 0; i < PNP_MAX_PORT; i++) {
 		if (!pnp_port_valid(dev, i))
-			/* end of resources */
 			continue;
 		if (pnp_port_start(dev, i) == 0)
-			/* disabled */
-			/* Do nothing */
-			continue;
+			continue;	/* disabled */
 		if (pnp_port_start(dev, i) < 0x100)
 			/*
 			 * Below 0x100 is only standard PC hardware
@@ -76,14 +70,10 @@
 			 */
 			continue;
 		if (pnp_port_end(dev, i) < pnp_port_start(dev, i))
-			/* invalid endpoint */
-			/* Do nothing */
-			continue;
-		reserve_range(
-			dev->dev.bus_id,
-			pnp_port_start(dev, i),
-			pnp_port_end(dev, i), 1
-		);
+			continue;	/* invalid */
+
+		reserve_range(dev->dev.bus_id, pnp_port_start(dev, i),
+			pnp_port_end(dev, i), 1);
 	}
 
 	for (i = 0; i < PNP_MAX_MEM; i++) {
