From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 54/55] ISAPNP: remove unused pnp_dev->regs field
Date: Mon, 28 Apr 2008 16:34:41 -0600
Message-ID: <20080428223627.551087646@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:1032 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966820AbYD1Whd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:37:33 -0400
Content-Disposition: inline; filename=isapnp-remove-unused-pnp_dev-fields
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

The "regs" field in struct pnp_dev is set but never read, so remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/isapnp/core.c
===================================================================
--- work10.orig/drivers/pnp/isapnp/core.c	2008-04-28 16:09:49.000000000 -0600
+++ work10/drivers/pnp/isapnp/core.c	2008-04-28 16:09:51.000000000 -0600
@@ -416,10 +416,7 @@
 	if (!dev)
 		return NULL;
 
-	dev->regs = tmp[4];
 	dev->card = card;
-	if (size > 5)
-		dev->regs |= tmp[5] << 8;
 	dev->capabilities |= PNP_CONFIGURABLE;
 	dev->capabilities |= PNP_READ;
 	dev->capabilities |= PNP_WRITE;
Index: work10/include/linux/pnp.h
===================================================================
--- work10.orig/include/linux/pnp.h	2008-04-28 16:09:50.000000000 -0600
+++ work10/include/linux/pnp.h	2008-04-28 16:09:51.000000000 -0600
@@ -253,7 +253,6 @@
 	struct pnp_resource_table *res;
 
 	char name[PNP_NAME_LEN];	/* contains a human-readable name */
-	unsigned short regs;		/* ISAPnP: supported registers */
 	int flags;			/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
 	void *data;

-- 
