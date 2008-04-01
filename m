From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 02/37] PNPACPI: continue after _CRS and _PRS errors
Date: Tue, 01 Apr 2008 09:16:36 -0600
Message-ID: <20080401151736.002980393@ldl.fc.hp.com>
References: <20080401151634.730901933@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:16793 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758638AbYDAPRm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 11:17:42 -0400
Content-Disposition: inline; filename=pnpacpi-ignore-errors
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Keep going and register the device even if we have trouble parsing
_CRS or _PRS.  A parsing problem might mean we ignore some resources
the device is using, or we might not be able to change its resources.
But we should still take note of anything we *could* parse correctly.

Also remove reference to dev_id because I plan to remove it soon.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/pnp/pnpacpi/core.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/core.c	2008-03-21 15:12:19.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/core.c	2008-03-21 15:12:20.000000000 -0600
@@ -213,8 +213,7 @@
 							  &dev->res);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 			pnp_err("PnPACPI: METHOD_NAME__CRS failure for %s",
-				dev_id->id);
-			goto err1;
+				acpi_device_hid(device));
 		}
 	}
 
@@ -223,8 +222,7 @@
 							    dev);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s",
-				dev_id->id);
-			goto err1;
+				acpi_device_hid(device));
 		}
 	}
 
@@ -252,8 +250,6 @@
 	num++;
 
 	return AE_OK;
-err1:
-	kfree(dev_id);
 err:
 	kfree(dev);
 	return -EINVAL;

-- 
