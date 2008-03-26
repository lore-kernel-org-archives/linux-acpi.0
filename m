From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 25/37] PNPACPI: remove redundant warnings about _CRS/_PRS failures
Date: Wed, 26 Mar 2008 11:11:23 -0600
Message-ID: <20080326171228.361913798@ldl.fc.hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:15719 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760995AbYCZRJH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:09:07 -0400
Content-Disposition: inline; filename=pnpacpi-remove-redundant-warnings
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Any errors should already be reported inside
pnpacpi_parse_allocated_resource() and
pnpacpi_parse_resource_option_data(), so no
need to report them again.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/pnp/pnpacpi/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/core.c	2008-03-21 15:22:09.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/core.c	2008-03-21 15:22:51.000000000 -0600
@@ -180,22 +180,11 @@
 	else
 		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
 
-	if (dev->active) {
-		/* parse allocated resource */
-		status = pnpacpi_parse_allocated_resource(dev);
-		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-			pnp_err("PnPACPI: METHOD_NAME__CRS failure for %s",
-				acpi_device_hid(device));
-		}
-	}
+	if (dev->active)
+		pnpacpi_parse_allocated_resource(dev);
 
-	if (dev->capabilities & PNP_CONFIGURABLE) {
-		status = pnpacpi_parse_resource_option_data(dev);
-		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s",
-				acpi_device_hid(device));
-		}
-	}
+	if (dev->capabilities & PNP_CONFIGURABLE)
+		pnpacpi_parse_resource_option_data(dev);
 
 	if (device->flags.compatible_ids) {
 		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;

-- 
