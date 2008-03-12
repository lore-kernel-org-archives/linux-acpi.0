From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] [2.6.25-rc5] Warn if packages with invalid references
	are evaluated
Date: Wed, 12 Mar 2008 01:06:24 +0100
Message-ID: <1205280384.8194.45.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34117 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670AbYCLAGN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 20:06:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Warn if packages with invalid references are evaluated

And return an error to avoid NULL pointer access by the caller
Lin Ming's patch avoids corrupted mem access when
BIOS has invalid references included, the handle is now zero
instead of corrupted.


Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>

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




