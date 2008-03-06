From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Warn if packages with invalid references are evaluated
Date: Thu, 06 Mar 2008 23:33:44 +0100
Message-ID: <1204842824.8741.6.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:40848 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933791AbYCFWdj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2008 17:33:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ming.m.lin@intel.com
Cc: rui.zhang@intel.com, linux-acpi <linux-acpi@vger.kernel.org>

Warn if packages with invalid references are evaluated

And return an error to avoid NULL pointer access.
Lin Ming's patch avoids corrupted mem access when
BIOS has invalid references included, the handle is now zero
instead of corrupted.


Signed-off-by: Thomas Renninger <trenn@suse.de>

---
Index: linux-2.6.24/drivers/acpi/utils.c
===================================================================
--- linux-2.6.24.orig/drivers/acpi/utils.c
+++ linux-2.6.24/drivers/acpi/utils.c
@@ -407,6 +407,12 @@ acpi_evaluate_reference(acpi_handle hand
 			break;
 		}
 
+		if (!element->reference.handle) {
+			printk(KERN_WARNING PREFIX "Invalid reference in"
+			       " package %s\n", pathname);
+			status = AE_NULL_ENTRY;
+			break;
+		}
 		/* Get the  acpi_handle. */
 
 		list->handles[i] = element->reference.handle;


