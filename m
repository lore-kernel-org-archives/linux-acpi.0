From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 16/28] PNP: improve resource assignment debug
Date: Tue, 17 Jun 2008 16:58:39 -0600
Message-ID: <20080617225910.961415170@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:24425 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760310AbYFQW7z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 18:59:55 -0400
Content-Disposition: inline; filename=pnp-improve-assign-debug
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

When we fail to assign an I/O or MEM resource, include the min/max
in the debug output to help match it with the options.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/manager.c
===================================================================
--- work10.orig/drivers/pnp/manager.c	2008-05-13 12:01:17.000000000 -0600
+++ work10/drivers/pnp/manager.c	2008-05-13 12:50:57.000000000 -0600
@@ -47,7 +47,10 @@ static int pnp_assign_port(struct pnp_de
 		res->start += rule->align;
 		res->end = res->start + rule->size - 1;
 		if (res->start > rule->max || !rule->align) {
-			dev_dbg(&dev->dev, "  couldn't assign io %d\n", idx);
+			dev_dbg(&dev->dev, "  couldn't assign io %d "
+				"(min %#llx max %#llx)\n", idx,
+				(unsigned long long) rule->min,
+				(unsigned long long) rule->max);
 			return 0;
 		}
 	}
@@ -96,7 +99,10 @@ static int pnp_assign_mem(struct pnp_dev
 		res->start += rule->align;
 		res->end = res->start + rule->size - 1;
 		if (res->start > rule->max || !rule->align) {
-			dev_dbg(&dev->dev, "  couldn't assign mem %d\n", idx);
+			dev_dbg(&dev->dev, "  couldn't assign mem %d "
+				"(min %#llx max %#llx)\n", idx,
+				(unsigned long long) rule->min,
+				(unsigned long long) rule->max);
 			return 0;
 		}
 	}

-- 
