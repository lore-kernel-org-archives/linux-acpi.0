From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: [PATCH] ACPI: fix memleak in drivers/acpi/utils.c
Date: Wed, 5 Jul 2006 22:18:11 +0200
Message-ID: <200607052218.12328.daniel.ritz-ml@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxout.hispeed.ch ([62.2.95.247]:46045 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S965018AbWGEUQy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2006 16:16:54 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

[PATCH] ACPI: fix memleak in drivers/acpi/utils.c

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f48227f..7b74b5b 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -386,7 +386,11 @@ acpi_evaluate_reference(acpi_handle hand
 	}
 
 	if (package->package.count > ACPI_MAX_HANDLES) {
-		return AE_NO_MEMORY;
+		printk(KERN_ERR PREFIX "[Package] has elements > ACPI_MAX_HANDLES (%p)\n",
+			    package);
+		status = AE_NO_MEMORY;
+		acpi_util_eval_error(handle, pathname, status);
+		goto end;
 	}
 	list->count = package->package.count;
 
