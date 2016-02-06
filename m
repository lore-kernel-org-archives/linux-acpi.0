From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/14] ACPI 2.0 / AML: Ensure \_SB._INI executed before any _REG
Date: Sat,  6 Feb 2016 11:53:00 +0800
Message-ID: <3aa5a4fa1f741d85ed57ec48c2fb8788bf3fad9e.1454730659.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 8ae25b8d128b6b8509010be321ff6bf2760f3807
ACPICA commit 19f84c249267fab0bfb138bd14d12510fb4faf24

There is BIOS code relying on the fact that \_SB._INI should get evaluated
before any other control methods. This may imply a gap in ACPICA/Linux
initialization/enumeration process.

Before revealing Windows true behavior by more validations, this patch only
ensures \_SB._INI evaluated before any _REG control methods. This can help
to make progress to other initialization order fixes. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/8ae25b8d
Link: https://github.com/acpica/acpica/commit/19f84c24
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |    2 +-
 drivers/acpi/acpica/nsinit.c   |  135 ++++++++++++++++++++++++----------------
 drivers/acpi/acpica/utxfinit.c |   27 ++------
 3 files changed, 86 insertions(+), 78 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 9684ed6..022d69c 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -88,7 +88,7 @@
  */
 acpi_status acpi_ns_initialize_objects(void);
 
-acpi_status acpi_ns_initialize_devices(void);
+acpi_status acpi_ns_initialize_devices(u32 flags);
 
 /*
  * nsload -  Namespace loading
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index bd75d46..f029a3d 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -46,6 +46,7 @@
 #include "acnamesp.h"
 #include "acdispat.h"
 #include "acinterp.h"
+#include "acevents.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsinit")
@@ -133,82 +134,108 @@ acpi_status acpi_ns_initialize_objects(void)
  *
  ******************************************************************************/
 
-acpi_status acpi_ns_initialize_devices(void)
+acpi_status acpi_ns_initialize_devices(u32 flags)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 	struct acpi_device_walk_info info;
 
 	ACPI_FUNCTION_TRACE(ns_initialize_devices);
 
-	/* Init counters */
+	if (!(flags & ACPI_NO_DEVICE_INIT)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "[Init] Initializing ACPI Devices\n"));
 
-	info.device_count = 0;
-	info.num_STA = 0;
-	info.num_INI = 0;
+		/* Init counters */
 
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "Initializing Device/Processor/Thermal objects "
-			      "and executing _INI/_STA methods:\n"));
+		info.device_count = 0;
+		info.num_STA = 0;
+		info.num_INI = 0;
 
-	/* Tree analysis: find all subtrees that contain _INI methods */
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
+				      "Initializing Device/Processor/Thermal objects "
+				      "and executing _INI/_STA methods:\n"));
 
-	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-					ACPI_UINT32_MAX, FALSE,
-					acpi_ns_find_ini_methods, NULL, &info,
-					NULL);
-	if (ACPI_FAILURE(status)) {
-		goto error_exit;
-	}
+		/* Tree analysis: find all subtrees that contain _INI methods */
+
+		status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+						ACPI_UINT32_MAX, FALSE,
+						acpi_ns_find_ini_methods, NULL,
+						&info, NULL);
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
+		}
+
+		/* Allocate the evaluation information block */
 
-	/* Allocate the evaluation information block */
+		info.evaluate_info =
+		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
+		if (!info.evaluate_info) {
+			status = AE_NO_MEMORY;
+			goto error_exit;
+		}
 
-	info.evaluate_info =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
-	if (!info.evaluate_info) {
-		status = AE_NO_MEMORY;
-		goto error_exit;
+		/*
+		 * Execute the "global" _INI method that may appear at the root.
+		 * This support is provided for Windows compatibility (Vista+) and
+		 * is not part of the ACPI specification.
+		 */
+		info.evaluate_info->prefix_node = acpi_gbl_root_node;
+		info.evaluate_info->relative_pathname = METHOD_NAME__INI;
+		info.evaluate_info->parameters = NULL;
+		info.evaluate_info->flags = ACPI_IGNORE_RETURN_VALUE;
+
+		status = acpi_ns_evaluate(info.evaluate_info);
+		if (ACPI_SUCCESS(status)) {
+			info.num_INI++;
+		}
 	}
 
 	/*
-	 * Execute the "global" _INI method that may appear at the root. This
-	 * support is provided for Windows compatibility (Vista+) and is not
-	 * part of the ACPI specification.
+	 * Run all _REG methods
+	 *
+	 * Note: Any objects accessed by the _REG methods will be automatically
+	 * initialized, even if they contain executable AML (see the call to
+	 * acpi_ns_initialize_objects below).
 	 */
-	info.evaluate_info->prefix_node = acpi_gbl_root_node;
-	info.evaluate_info->relative_pathname = METHOD_NAME__INI;
-	info.evaluate_info->parameters = NULL;
-	info.evaluate_info->flags = ACPI_IGNORE_RETURN_VALUE;
+	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "[Init] Executing _REG OpRegion methods\n"));
 
-	status = acpi_ns_evaluate(info.evaluate_info);
-	if (ACPI_SUCCESS(status)) {
-		info.num_INI++;
+		status = acpi_ev_initialize_op_regions();
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
+		}
 	}
 
-	/* Walk namespace to execute all _INIs on present devices */
+	if (!(flags & ACPI_NO_DEVICE_INIT)) {
 
-	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-					ACPI_UINT32_MAX, FALSE,
-					acpi_ns_init_one_device, NULL, &info,
-					NULL);
+		/* Walk namespace to execute all _INIs on present devices */
 
-	/*
-	 * Any _OSI requests should be completed by now. If the BIOS has
-	 * requested any Windows OSI strings, we will always truncate
-	 * I/O addresses to 16 bits -- for Windows compatibility.
-	 */
-	if (acpi_gbl_osi_data >= ACPI_OSI_WIN_2000) {
-		acpi_gbl_truncate_io_addresses = TRUE;
-	}
+		status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+						ACPI_UINT32_MAX, FALSE,
+						acpi_ns_init_one_device, NULL,
+						&info, NULL);
 
-	ACPI_FREE(info.evaluate_info);
-	if (ACPI_FAILURE(status)) {
-		goto error_exit;
-	}
+		/*
+		 * Any _OSI requests should be completed by now. If the BIOS has
+		 * requested any Windows OSI strings, we will always truncate
+		 * I/O addresses to 16 bits -- for Windows compatibility.
+		 */
+		if (acpi_gbl_osi_data >= ACPI_OSI_WIN_2000) {
+			acpi_gbl_truncate_io_addresses = TRUE;
+		}
 
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "    Executed %u _INI methods requiring %u _STA executions "
-			      "(examined %u objects)\n",
-			      info.num_INI, info.num_STA, info.device_count));
+		ACPI_FREE(info.evaluate_info);
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
+		}
+
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
+				      "    Executed %u _INI methods requiring %u _STA executions "
+				      "(examined %u objects)\n",
+				      info.num_INI, info.num_STA,
+				      info.device_count));
+	}
 
 	return_ACPI_STATUS(status);
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 2caaec7..6a0c2ee 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -301,33 +301,14 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 		}
 	}
 
-	/*
-	 * Run all _REG methods
-	 *
-	 * Note: Any objects accessed by the _REG methods will be automatically
-	 * initialized, even if they contain executable AML (see the call to
-	 * acpi_ns_initialize_objects below).
-	 */
 	acpi_gbl_reg_methods_enabled = TRUE;
-	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "[Init] Executing _REG OpRegion methods\n"));
-
-		status = acpi_ev_initialize_op_regions();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
 
 	/*
-	 * Initialize all device objects in the namespace. This runs the device
-	 * _STA and _INI methods.
+	 * Initialize all device/region objects in the namespace. This runs
+	 * the device _STA and _INI methods and region _REG methods.
 	 */
-	if (!(flags & ACPI_NO_DEVICE_INIT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "[Init] Initializing ACPI Devices\n"));
-
-		status = acpi_ns_initialize_devices();
+	if (!(flags & (ACPI_NO_DEVICE_INIT | ACPI_NO_ADDRESS_SPACE_INIT))) {
+		status = acpi_ns_initialize_devices(flags);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
-- 
1.7.10
