From: zhangrui <rui.zhang@intel.com>
Subject: [Patch] ACPI: ignore processors that doesn't support hot plug
Date: Fri, 22 Feb 2008 15:17:18 +0800
Message-ID: <1203664638.3210.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16129 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbYBVHUW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 02:20:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Hi, Len,
will you please consider this patch as the fix for bug 8570,
rather than the one at http://bugzilla.kernel.org/show_bug.cgi?id=8570#c21 ?


is_processor_present is only called in the processor hotplug case,
and _STA method is mandatory at this time.

We should ignore those processors that are disabled in the MADT
and don't have _STA methods.
Because they will never exist in this system.
For the processors that don't physically exist but can be
hot plugged later, we still need this debug info.

http://bugzilla.kernel.org/show_bug.cgi?id=8570

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -812,11 +812,20 @@ static int is_processor_present(acpi_han
 
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
-		return 0;
-	}
-	return 1;
+
+	if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_PRESENT))
+		return 1;
+
+	/*
+	 * _STA is mandatory for a processor that supports hot plug
+	 */
+	if (status == AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				"Processor does not support hot plug\n"));
+	else
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Processor Device is not present"));
+	return 0;
 }
 
 static


