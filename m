From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Sat,  8 Jun 2013 09:01:19 +0800
Message-ID: <f941986213920b382a8f43af43caec298cd16a5a.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65500 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445Ab3FHBBq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:01:46 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

Sort package only after null/bad elements have been removed.
Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 029816e..c84603e 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -452,18 +452,7 @@ acpi_ns_repair_CST(struct acpi_evaluate_info *info,
 	ACPI_FUNCTION_NAME(ns_repair_CST);
 
 	/*
-	 * Entries (subpackages) in the _CST Package must be sorted by the
-	 * C-state type, in ascending order.
-	 */
-	status = acpi_ns_check_sorted_list(info, return_object, 1, 4, 1,
-					   ACPI_SORT_ASCENDING, "C-State Type");
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	/*
-	 * We now know the list is correctly sorted by C-state type. Check if
-	 * the C-state type values are proportional.
+	 * Check if the C-state type values are proportional.
 	 */
 	outer_element_count = return_object->package.count - 1;
 	i = 0;
@@ -502,6 +491,17 @@ acpi_ns_repair_CST(struct acpi_evaluate_info *info,
 
 	obj_desc = return_object->package.elements[0];
 	obj_desc->integer.value = outer_element_count;
+
+	/*
+	 * Entries (subpackages) in the _CST Package must be sorted by the
+	 * C-state type, in ascending order.
+	 */
+	status = acpi_ns_check_sorted_list(info, return_object, 1, 4, 1,
+					   ACPI_SORT_ASCENDING, "C-State Type");
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
 	return (AE_OK);
 }
 
-- 
1.7.10

