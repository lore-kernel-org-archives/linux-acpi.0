From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 2/5] PNP: reserve system board iomem resources as well as ioport resources
Date: Tue, 16 Jan 2007 10:34:10 -0700
Message-ID: <200701161034.10970.bjorn.helgaas@hp.com>
References: <200701161028.10109.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:43438 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbXAPRej (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jan 2007 12:34:39 -0500
In-Reply-To: <200701161028.10109.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

Most x86 boxes have no iomem system board resources, but some ia64
boxes do.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: mm-work3/drivers/pnp/system.c
===================================================================
--- mm-work3.orig/drivers/pnp/system.c	2007-01-11 15:56:57.000000000 -0700
+++ mm-work3/drivers/pnp/system.c	2007-01-12 12:14:53.000000000 -0700
@@ -3,7 +3,8 @@
  *
  * Some code is based on pnpbios_core.c
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
- *
+ * (c) Copyright 2007 Hewlett-Packard Development Company, L.P.
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  */
 
 #include <linux/pnp.h>
@@ -21,7 +22,7 @@
 	{	"",			0	}
 };
 
-static void reserve_ioport_range(char *pnpid, int start, int end)
+static void reserve_range(char *pnpid, int start, int end, int port)
 {
 	struct resource *res;
 	char *regionid;
@@ -30,7 +31,10 @@
 	if ( regionid == NULL )
 		return;
 	snprintf(regionid, 16, "pnp %s", pnpid);
-	res = request_region(start,end-start+1,regionid);
+	if (port)
+		res = request_region(start,end-start+1,regionid);
+	else
+		res = request_mem_region(start,end-start+1,regionid);
 	if ( res == NULL )
 		kfree( regionid );
 	else
@@ -41,8 +45,8 @@
 	 * have double reservations.
 	 */
 	printk(KERN_INFO
-		"pnp: %s: ioport range 0x%x-0x%x %s reserved\n",
-		pnpid, start, end,
+		"pnp: %s: %s range 0x%x-0x%x %s reserved\n",
+		pnpid, port ? "ioport" : "iomem", start, end,
 		NULL != res ? "has been" : "could not be"
 	);
 
@@ -75,13 +79,21 @@
 			/* invalid endpoint */
 			/* Do nothing */
 			continue;
-		reserve_ioport_range(
+		reserve_range(
 			dev->dev.bus_id,
 			pnp_port_start(dev, i),
-			pnp_port_end(dev, i)
+			pnp_port_end(dev, i), 1
 		);
 	}
 
+	for (i = 0; i < PNP_MAX_MEM; i++) {
+		if (!pnp_mem_valid(dev, i))
+			continue;
+
+		reserve_range(dev->dev.bus_id, pnp_mem_start(dev, i),
+			pnp_mem_end(dev, i), 0);
+	}
+
 	return;
 }
 
