From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/140] PNP: system.c whitespace cleanup
Date: Wed,  7 Feb 2007 13:50:37 -0500
Message-ID: <11708744053556-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:33413 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422740AbXBGSx1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:27 -0500
In-Reply-To: <11708744032427-git-send-email-lenb@kernel.org>
Message-Id: <5859554c3ad31b722f0b5a1d3a40e19d8ccedd0b.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/system.c |   32 +++++++++++---------------------
 1 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
index fd17c71..2065e74 100644
--- a/drivers/pnp/system.c
+++ b/drivers/pnp/system.c
@@ -28,15 +28,15 @@ static void reserve_range(char *pnpid, int start, int end, int port)
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
@@ -47,24 +47,18 @@ static void reserve_range(char *pnpid, int start, int end, int port)
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
@@ -76,14 +70,10 @@ static void reserve_resources_of_dev( struct pnp_dev *dev )
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
-- 
1.5.0.rc3.39.gec804
