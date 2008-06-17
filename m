From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 17/28] PNP: in debug resource dump, make empty list obvious
Date: Tue, 17 Jun 2008 16:58:40 -0600
Message-ID: <20080617225911.166406993@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:24436 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760366AbYFQW74 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 18:59:56 -0400
Content-Disposition: inline; filename=pnp-improve-debug-resource-dump
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

If the resource list is empty, say that explicitly.  Previously,
it was confusing because often the heading was followed by zero
resource lines, then some "add resource" lines from auto-assignment,
so the "add" lines looked like current resources.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/support.c
===================================================================
--- work10.orig/drivers/pnp/support.c	2008-05-16 16:01:26.000000000 -0600
+++ work10/drivers/pnp/support.c	2008-05-16 16:13:42.000000000 -0600
@@ -77,7 +77,12 @@ void dbg_pnp_show_resources(struct pnp_d
 	struct pnp_resource *pnp_res;
 	struct resource *res;
 
-	dev_dbg(&dev->dev, "current resources: %s\n", desc);
+	if (list_empty(&dev->resources)) {
+		dev_dbg(&dev->dev, "%s: no current resources\n", desc);
+		return;
+	}
+
+	dev_dbg(&dev->dev, "%s: current resources:\n", desc);
 	list_for_each_entry(pnp_res, &dev->resources, list) {
 		res = &pnp_res->res;
 

-- 
