From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 19/37] PNP: remove pnp_resource_table from internal pnp_clean_resource_table interface
Date: Tue, 01 Apr 2008 09:16:53 -0600
Message-ID: <20080401151739.431338792@ldl.fc.hp.com>
References: <20080401151634.730901933@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:11884 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759363AbYDAPSK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 11:18:10 -0400
Content-Disposition: inline; filename=pnp-remove-pnp_resource_table-from-clean
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This changes pnp_clean_resource_table() to take a pnp_dev pointer
rather than a pnp_resource_table pointer.  This reduces the visibility
of pnp_resource_table and removes an opportunity for error in the
caller.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/pnp/manager.c
===================================================================
--- work7.orig/drivers/pnp/manager.c	2008-03-25 11:03:59.000000000 -0600
+++ work7/drivers/pnp/manager.c	2008-03-25 11:04:52.000000000 -0600
@@ -247,8 +247,9 @@
  * pnp_clean_resources - clears resources that were not manually set
  * @res: the resources to clean
  */
-static void pnp_clean_resource_table(struct pnp_resource_table *res)
+static void pnp_clean_resource_table(struct pnp_dev *dev)
 {
+	struct pnp_resource_table *res = &dev->res;
 	int idx;
 
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
@@ -304,7 +305,7 @@
 		return -ENODEV;
 
 	mutex_lock(&pnp_res_mutex);
-	pnp_clean_resource_table(&dev->res);	/* start with a fresh slate */
+	pnp_clean_resource_table(dev);
 	if (dev->independent) {
 		port = dev->independent->port;
 		mem = dev->independent->mem;
@@ -376,7 +377,7 @@
 	return 1;
 
 fail:
-	pnp_clean_resource_table(&dev->res);
+	pnp_clean_resource_table(dev);
 	mutex_unlock(&pnp_res_mutex);
 	return 0;
 }
@@ -554,7 +555,7 @@
 
 	/* release the resources so that other devices can use them */
 	mutex_lock(&pnp_res_mutex);
-	pnp_clean_resource_table(&dev->res);
+	pnp_clean_resource_table(dev);
 	mutex_unlock(&pnp_res_mutex);
 
 	return 0;

-- 
