From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI processor: introduce module parameter
	processor.ignore_tpc
Date: Mon, 11 May 2009 09:35:57 +0800
Message-ID: <1242005757.15284.119.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52976 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756869AbZEKBf0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 May 2009 21:35:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, theholyettlz@googlemail.com

Introduce module parameter processor.ignore_tpc.
Some laptops are shipped with buggy _TPC implemented,
this module parameter is used to workaround this kind of issues.
http://bugzilla.kernel.org/show_bug.cgi?id=13259

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: James Ettle <theholyettlz@googlemail.com>
---
 drivers/acpi/processor_throttling.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: linux-2.6/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6/drivers/acpi/processor_throttling.c
@@ -45,6 +45,16 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
+/* ignore_tpc:
+ *  0 -> acpi processor driver doesn't ignore _TPC values
+ *  1 -> acpi processor driver ignores _TPC values
+ */
+static int ignore_tpc;
+module_param(ignore_tpc, int, 0644);
+MODULE_PARM_DESC(ignore_tpc, "If the processor throttling state of your machine gets wrongly" \
+		"limited by BIOS, this should help");
+
+
 struct throttling_tstate {
 	unsigned int cpu;		/* cpu nr */
 	int target_state;		/* target T-state */
@@ -283,6 +293,10 @@ static int acpi_processor_get_platform_l
 
 	if (!pr)
 		return -EINVAL;
+
+	if (ignore_tpc)
+		goto end;
+
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND) {
@@ -290,6 +304,8 @@ static int acpi_processor_get_platform_l
 		}
 		return -ENODEV;
 	}
+
+end:
 	pr->throttling_platform_limit = (int)tpc;
 	return 0;
 }
@@ -302,6 +318,9 @@ int acpi_processor_tstate_has_changed(st
 	struct acpi_processor_limit *limit;
 	int target_state;
 
+	if (ignore_tpc)
+		return 0;
+
 	result = acpi_processor_get_platform_limit(pr);
 	if (result) {
 		/* Throttling Limit is unsupported */


