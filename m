From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 53/54] ISAPNP: remove unused pnp_dev->regs field
Date: Fri, 25 Apr 2008 12:39:00 -0600
Message-ID: <20080425183935.358126448@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:7538 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763167AbYDYSkv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:40:51 -0400
Content-Disposition: inline; filename=isapnp-remove-unused-pnp_dev-fields
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

The "regs" field in struct pnp_dev is set but never read, so remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/isapnp/core.c
===================================================================
--- work10.orig/drivers/pnp/isapnp/core.c	2008-04-25 11:15:14.000000000 -0600
+++ work10/drivers/pnp/isapnp/core.c	2008-04-25 11:15:17.000000000 -0600
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
--- work10.orig/include/linux/pnp.h	2008-04-25 11:15:16.000000000 -0600
+++ work10/include/linux/pnp.h	2008-04-25 11:15:17.000000000 -0600
@@ -256,7 +256,6 @@
 	struct pnp_resource_table *res;
 
 	char name[PNP_NAME_LEN];	/* contains a human-readable name */
-	unsigned short regs;		/* ISAPnP: supported registers */
 	int flags;			/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
 	void *data;

-- 
