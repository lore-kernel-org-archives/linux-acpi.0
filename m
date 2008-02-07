From: Len Brown <lenb@kernel.org>
Subject: [PATCH 018/112] ACPI: ACPI Exception (): AE_NOT_FOUND, Processor Device is not present
Date: Thu,  7 Feb 2008 04:33:40 -0500
Message-ID: <cfaf3747ff3d431fba33f75083b7f50f58ae22ff.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756096AbYBGJfl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:41 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

ACPI Exception (acpi_processor-0677): AE_NOT_FOUND, Processor Device is not
present [20060707]

According to the ACPI spec 6.3.7,
"If a device object (including the processor object) does not have an
_STA object, then OSPM assumes that all of the above bits are set,
(in other words, the device is present, enabled, shown in the UI
and funtioning)".

is_processor_present shoud return 1 if the processor device object exists
while it doesn't have an _STA object.

http://bugzilla.kernel.org/show_bug.cgi?id=8570

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index e48ee4f..c53113e 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -812,11 +812,18 @@ static int is_processor_present(acpi_handle handle)
 
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
-		return 0;
-	}
-	return 1;
+	/*
+	 * if a processor object does not have an _STA object,
+	 * OSPM assumes that the processor is present.
+	 */
+	if (status == AE_NOT_FOUND)
+		return 1;
+
+	if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_PRESENT))
+		return 1;
+
+	ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
+	return 0;
 }
 
 static
-- 
1.5.4.23.gef5b9

