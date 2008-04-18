From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 33/53] rtc: dont reference pnp_resource_table directly
Date: Fri, 18 Apr 2008 14:50:28 -0600
Message-ID: <20080418205053.924308082@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763062AbYDRVEd@vger.kernel.org>
Content-Disposition: inline; filename=rtc-remove-pnp_resource_table-use
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

pnp_resource_table is going away soon, so use the more
generic public interfaces instead.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work9/drivers/rtc/rtc-cmos.c
===================================================================
--- work9.orig/drivers/rtc/rtc-cmos.c	2008-04-18 12:47:21.000000000 -0600
+++ work9/drivers/rtc/rtc-cmos.c	2008-04-18 12:52:19.000000000 -0600
@@ -854,11 +854,12 @@
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
