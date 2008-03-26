From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 35/37] rtc: dont reference pnp_resource_table directly
Date: Wed, 26 Mar 2008 11:11:33 -0600
Message-ID: <20080326171230.371823262@ldl.fc.hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:32725 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758380AbYCZRJV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:09:21 -0400
Content-Disposition: inline; filename=rtc-remove-pnp_resource_table-use
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

pnp_resource_table is going away soon, so use the more
generic public interfaces instead.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/rtc/rtc-cmos.c
===================================================================
--- work7.orig/drivers/rtc/rtc-cmos.c	2008-03-25 17:04:44.000000000 -0600
+++ work7/drivers/rtc/rtc-cmos.c	2008-03-25 17:04:45.000000000 -0600
@@ -855,11 +855,12 @@
 		 * don't define the IRQ. It should always be safe to
 		 * hardcode it in these cases
 		 */
-		return cmos_do_probe(&pnp->dev, &pnp->res.port_resource[0], 8);
+		return cmos_do_probe(&pnp->dev,
+				pnp_get_resource(pnp, IORESOURCE_IO, 0), 8);
 	else
 		return cmos_do_probe(&pnp->dev,
-				     &pnp->res.port_resource[0],
-				     pnp->res.irq_resource[0].start);
+				pnp_get_resource(pnp, IORESOURCE_IO, 0),
+				pnp_irq(pnp, 0));
 }
 
 static void __exit cmos_pnp_remove(struct pnp_dev *pnp)

-- 
