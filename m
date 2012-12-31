From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/27] ACPICA: Namespace: Eliminate dot...dot output during initialization.
Date: Mon, 31 Dec 2012 08:07:08 +0800
Message-ID: <e32a5e4d3c8f53e9356b910f1e5699e7d59c03bc.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21738 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab2LaAHS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:18 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

This feature no longer serves any good purpose and also confuses any error
messages during ACPICA initialization.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsinit.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 94c1500..59cd5b4 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -86,7 +86,7 @@ acpi_status acpi_ns_initialize_objects(void)
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "**** Starting initialization of namespace objects ****\n"));
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "Completing Region/Field/Buffer/Package initialization:"));
+			      "Completing Region/Field/Buffer/Package initialization:\n"));
 
 	/* Set all init info to zero */
 
@@ -102,7 +102,7 @@ acpi_status acpi_ns_initialize_objects(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nInitialized %u/%u Regions %u/%u Fields %u/%u "
+			      "Initialized %u/%u Regions %u/%u Fields %u/%u "
 			      "Buffers %u/%u Packages (%u nodes)\n",
 			      info.op_region_init, info.op_region_count,
 			      info.field_init, info.field_count,
@@ -149,7 +149,7 @@ acpi_status acpi_ns_initialize_devices(void)
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
 			      "Initializing Device/Processor/Thermal objects "
-			      "by executing _INI methods:"));
+			      "and executing _INI methods:\n"));
 
 	/* Tree analysis: find all subtrees that contain _INI methods */
 
@@ -207,7 +207,7 @@ acpi_status acpi_ns_initialize_devices(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nExecuted %u _INI methods requiring %u _STA executions "
+			      "Executed %u _INI methods requiring %u _STA executions "
 			      "(examined %u objects)\n",
 			      info.num_INI, info.num_STA, info.device_count));
 
@@ -349,14 +349,6 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 	}
 
 	/*
-	 * Print a dot for each object unless we are going to print the entire
-	 * pathname
-	 */
-	if (!(acpi_dbg_level & ACPI_LV_INIT_NAMES)) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT, "."));
-	}
-
-	/*
 	 * We ignore errors from above, and always return OK, since we don't want
 	 * to abort the walk on any single error.
 	 */
@@ -575,11 +567,6 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 
 	if (ACPI_SUCCESS(status)) {
 		walk_info->num_INI++;
-
-		if ((acpi_dbg_level <= ACPI_LV_ALL_EXCEPTIONS) &&
-		    (!(acpi_dbg_level & ACPI_LV_INFO))) {
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT, "."));
-		}
 	}
 #ifdef ACPI_DEBUG_OUTPUT
 	else if (status != AE_NOT_FOUND) {
-- 
1.7.10

