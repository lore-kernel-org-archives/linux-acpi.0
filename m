From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 23/55] PNP: remove pnp_resource_table from internal pnp_clean_resource_table interface
Date: Mon, 28 Apr 2008 16:34:10 -0600
Message-ID: <20080428223621.155256735@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:30561 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965169AbYD1Wgt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:36:49 -0400
Content-Disposition: inline; filename=pnp-remove-pnp_resource_table-from-clean
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This changes pnp_clean_resource_table() to take a pnp_dev pointer
rather than a pnp_resource_table pointer.  This reduces the visibility
of pnp_resource_table and removes an opportunity for error in the
caller.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/manager.c
===================================================================
--- work10.orig/drivers/pnp/manager.c	2008-04-28 16:09:22.000000000 -0600
+++ work10/drivers/pnp/manager.c	2008-04-28 16:09:23.000000000 -0600
@@ -281,8 +281,9 @@
  * pnp_clean_resources - clears resources that were not manually set
  * @res: the resources to clean
  */
-static void pnp_clean_resource_table(struct pnp_resource_table *res)
+static void pnp_clean_resource_table(struct pnp_dev *dev)
 {
+	struct pnp_resource_table *res = &dev->res;
 	int idx;
 
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
@@ -339,7 +340,7 @@
 
 	dbg_pnp_show_resources(dev, "before pnp_assign_resources");
 	mutex_lock(&pnp_res_mutex);
-	pnp_clean_resource_table(&dev->res);	/* start with a fresh slate */
+	pnp_clean_resource_table(dev);
 	if (dev->independent) {
 		dev_dbg(&dev->dev, "assigning independent options\n");
 		port = dev->independent->port;
@@ -415,7 +416,7 @@
 	return 1;
 
 fail:
-	pnp_clean_resource_table(&dev->res);
+	pnp_clean_resource_table(dev);
 	mutex_unlock(&pnp_res_mutex);
 	dbg_pnp_show_resources(dev, "after pnp_assign_resources (failed)");
 	return 0;
@@ -595,7 +596,7 @@
 
 	/* release the resources so that other devices can use them */
 	mutex_lock(&pnp_res_mutex);
-	pnp_clean_resource_table(&dev->res);
+	pnp_clean_resource_table(dev);
 	mutex_unlock(&pnp_res_mutex);
 
 	return 0;

-- 
