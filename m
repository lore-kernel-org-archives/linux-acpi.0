From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/12] ACPI Exception (): AE_NOT_FOUND, Processor Device is not present (update)
Date: Tue, 11 Mar 2008 02:51:45 -0400
Message-ID: <d0ce46f550ebbd765881e8c48f43b66285d798b0.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:33378 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754216AbYCKGyz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:55 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

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
 
-- 
1.5.4.3.422.g34cd6

