From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 10/15] PNP: remove redundant pnp_can_configure() check
Date: Fri, 30 May 2008 16:49:03 -0600
Message-ID: <20080530224933.357252074@ldl.fc.hp.com>
References: <20080530224853.976744229@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:18600 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbYE3Wti (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2008 18:49:38 -0400
Content-Disposition: inline; filename=pnp-remove-assign-configurability-check
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

pnp_assign_resources() is static and the only caller checks
pnp_can_configure() before calling it, so no need to do it
again.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/manager.c
===================================================================
--- work10.orig/drivers/pnp/manager.c	2008-05-13 13:29:57.000000000 -0600
+++ work10/drivers/pnp/manager.c	2008-05-13 13:30:21.000000000 -0600
@@ -231,9 +231,6 @@ static int pnp_assign_resources(struct p
 	struct pnp_dma *dma;
 	int nport = 0, nmem = 0, nirq = 0, ndma = 0;
 
-	if (!pnp_can_configure(dev))
-		return -ENODEV;
-
 	dbg_pnp_show_resources(dev, "before pnp_assign_resources");
 	mutex_lock(&pnp_res_mutex);
 	pnp_clean_resource_table(dev);

-- 
