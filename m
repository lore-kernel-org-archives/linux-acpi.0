From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/140] PNP: reserve system board iomem resources as well as ioport resources
Date: Wed,  7 Feb 2007 13:50:36 -0500
Message-ID: <11708744032427-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:34715 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422738AbXBGSx0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:26 -0500
In-Reply-To: <11708744023872-git-send-email-lenb@kernel.org>
Message-Id: <a8c78f7fb1571764f48b8af5459abdd2c66a765f.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Most x86 boxes have no iomem system board resources, but some ia64
boxes do.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/system.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
index d42015c..fd17c71 100644
--- a/drivers/pnp/system.c
+++ b/drivers/pnp/system.c
@@ -3,7 +3,8 @@
  *
  * Some code is based on pnpbios_core.c
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
- *
+ * (c) Copyright 2007 Hewlett-Packard Development Company, L.P.
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  */
 
 #include <linux/pnp.h>
@@ -21,7 +22,7 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{	"",			0	}
 };
 
-static void reserve_ioport_range(char *pnpid, int start, int end)
+static void reserve_range(char *pnpid, int start, int end, int port)
 {
 	struct resource *res;
 	char *regionid;
@@ -30,7 +31,10 @@ static void reserve_ioport_range(char *pnpid, int start, int end)
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
@@ -41,8 +45,8 @@ static void reserve_ioport_range(char *pnpid, int start, int end)
 	 * have double reservations.
 	 */
 	printk(KERN_INFO
-		"pnp: %s: ioport range 0x%x-0x%x %s reserved\n",
-		pnpid, start, end,
+		"pnp: %s: %s range 0x%x-0x%x %s reserved\n",
+		pnpid, port ? "ioport" : "iomem", start, end,
 		NULL != res ? "has been" : "could not be"
 	);
 
@@ -75,13 +79,21 @@ static void reserve_resources_of_dev( struct pnp_dev *dev )
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
 
-- 
1.5.0.rc3.39.gec804
