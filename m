From: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/16] ACPI: quiet ACPI Exceptions due to no _PTC or _TSS
Date: Wed, 25 Jul 2007 01:51:24 -0400
Message-ID: <11853427011270-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9155 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbXGYFvn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:43 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <c30c620ee1cc351bcc149c4280e1166998df0064.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

ACPI Exception (processor_throttling-0084): AE_NOT_FOUND, Evaluating _PTC [20070126]
ACPI Exception (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070126]

These methods are optional, so Linux should not
alarm users when they are not found.

http://bugzilla.kernel.org/show_bug.cgi?id=8802

Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Luming Yu <luming.yu@intel.com>
---
 drivers/acpi/processor_throttling.c |   53 ++++++++++++++++++++++++----------
 1 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index dc5b859..0b8204e 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -47,6 +47,9 @@ ACPI_MODULE_NAME("processor_throttling");
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 
+/*
+ * _TPC - Throttling Present Capabilities
+ */
 static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
@@ -55,8 +58,10 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 	if (!pr)
 		return -EINVAL;
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
+		}
 		return -ENODEV;
 	}
 	pr->throttling_platform_limit = (int)tpc;
@@ -68,9 +73,9 @@ int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
 	return acpi_processor_get_platform_limit(pr);
 }
 
-/* --------------------------------------------------------------------------
-                             _PTC, _TSS, _TSD support 
-   -------------------------------------------------------------------------- */
+/*
+ * _PTC - Processor Throttling Control (and status) register location
+ */
 static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -81,7 +86,9 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTC"));
+		if (status != AE_NOT_FOUND) {
+			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTC"));
+		}
 		return -ENODEV;
 	}
 
@@ -132,6 +139,10 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 
 	return result;
 }
+
+/*
+ * _TSS - Throttling Supported States
+ */
 static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -144,7 +155,9 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_TSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSS"));
+		if (status != AE_NOT_FOUND) {
+			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSS"));
+		}
 		return -ENODEV;
 	}
 
@@ -201,6 +214,10 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 	return result;
 }
+
+/*
+ * _TSD - T-State Dependencies
+ */
 static int acpi_processor_get_tsd(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -213,6 +230,9 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSD"));
+		}
 		return -ENODEV;
 	}
 
@@ -525,9 +545,6 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	int result = 0;
 	int step = 0;
 	int i = 0;
-	int no_ptc = 0;
-	int no_tss = 0;
-	int no_tsd = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
@@ -538,12 +555,14 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	if (!pr)
 		return -EINVAL;
 
-	/* TBD: Support ACPI 2.0 objects */
-	no_ptc = acpi_processor_get_throttling_control(pr);
-	no_tss = acpi_processor_get_throttling_states(pr);
-	no_tsd = acpi_processor_get_tsd(pr);
-
-	if (no_ptc || no_tss) {
+	/*
+	 * Evaluate _PTC, _TSS and _TPC
+	 * They must all be present or none of them can be used.
+	 */
+	if (acpi_processor_get_throttling_control(pr) ||
+		acpi_processor_get_throttling_states(pr) ||
+		acpi_processor_get_platform_limit(pr))
+	{
 		pr->throttling.acpi_processor_get_throttling =
 		    &acpi_processor_get_throttling_fadt;
 		pr->throttling.acpi_processor_set_throttling =
@@ -555,6 +574,8 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 		    &acpi_processor_set_throttling_ptc;
 	}
 
+	acpi_processor_get_tsd(pr);
+
 	if (!pr->throttling.address) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
 		return 0;
-- 
1.5.3.rc2.22.g69a9b
