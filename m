From: Len Brown <lenb@kernel.org>
Subject: Re: [Patch] ACPI: ignore processors that doesn't support hot plug
Date: Sat, 23 Feb 2008 01:53:56 -0500
Message-ID: <200802230153.56710.lenb@kernel.org>
References: <1203664638.3210.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46153 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbYBWGyK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Feb 2008 01:54:10 -0500
In-Reply-To: <1203664638.3210.54.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: zhangrui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Friday 22 February 2008 02:17, zhangrui wrote:
> is_processor_present is only called in the processor hotplug case,
> and _STA method is mandatory at this time.
> 
> We should ignore those processors that are disabled in the MADT
> and don't have _STA methods.
> Because they will never exist in this system.
> For the processors that don't physically exist but can be
> hot plugged later, we still need this debug info.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8570
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Okay.  As the original patch shipped in rc1,
below is the incremental.

thanks,
-Len

Subject: ACPI Exception (): AE_NOT_FOUND, Processor Device is not present (update)
From: Zhang Rui <rui.zhang@intel.com>

update cfaf3747ff3d431fba33f75083b7f50f58ae22ff
ACPI: ACPI Exception (): AE_NOT_FOUND, Processor Device is not present

is_processor_present is only called in the processor hotplug case,
and _STA method is mandatory at this time.

We should ignore those processors that are disabled in the MADT
and don't have _STA methods.
Because they will never exist in this system.
For the processors that don't physically exist but can be
hot plugged later, we still need this debug info.

http://bugzilla.kernel.org/show_bug.cgi?id=8570

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a3cc8a9..d9316ab 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -840,17 +840,19 @@ static int is_processor_present(acpi_handle handle)
 
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	/*
-	 * if a processor object does not have an _STA object,
-	 * OSPM assumes that the processor is present.
-	 */
-	if (status == AE_NOT_FOUND)
-		return 1;
 
 	if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_PRESENT))
 		return 1;
 
-	ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
+	/*
+	 * _STA is mandatory for a processor that supports hot plug
+	 */
+	if (status == AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				"Processor does not support hot plug\n"));
+	else
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Processor Device is not present"));
 	return 0;
 }
 
