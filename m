From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA / Interpreter: Fix a regression triggered because of wrong Linux ECDT support
Date: Thu, 10 Mar 2016 10:54:29 +0800
Message-ID: <1457578469-1859-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47470 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbcCJCyp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Mar 2016 21:54:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It is reported that the following commit triggers regressions:
 Linux commit: efaed9be998b5ae0afb7458e057e5f4402b43fa0
 ACPICA commit: 31178590dde82368fdb0f6b0e466b6c0add96c57
 Subject: ACPICA: Events: Enhance acpi_ev_execute_reg_method() to
          ensure no _REG evaluations can happen during OS early boot
          stages

This is because that the ECDT support is not corrected in Linux, and Linux
requires to execute _REG for ECDT (though this sounds so wrong), we need to
ensure acpi_gbl_namespace_initialized is set before ECDT probing in order
for _REG to be executed. Since we have to move
"acpi_gbl_namespace_initialized = TRUE" to the initialization step
happening before ECDT probing, acpi_load_tables() is the best candidate for
now. Thus this patch fixes the regression by doing so.

But if the ECDT support is fixed, Linux will not execute _REG for ECDT, and
ECDT probing will happen before acpi_load_tables(). At that time, we still
want to ensure acpi_gbl_namespace_initialized is set after executing
acpi_ns_initialize_objects() (under the condition of
acpi_gbl_group_module_level_code = FALSE), this patch also moves
acpi_ns_initialize_objects() to acpi_load_tables() accordingly.

Since acpi_ns_initialize_objects() doesn't seem to be skippable, this
patch also removes ACPI_NO_OBJECT_INIT for the one invoked in
acpi_load_tables(). And since the default region handlers should always be
installed before loading the tables, this patch also removes useless
acpi_gbl_group_module_level_code check accordingly. Reported by Chris
Bainbridge, Fixed by Lv Zheng.

Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsinit.c   |    2 ++
 drivers/acpi/acpica/tbxfload.c |   26 +++++++++++++++++-------
 drivers/acpi/acpica/utxfinit.c |   43 ++++++++++------------------------------
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index f029a3d..d4aa8b6 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -84,6 +84,8 @@ acpi_status acpi_ns_initialize_objects(void)
 
 	ACPI_FUNCTION_TRACE(ns_initialize_objects);
 
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "[Init] Completing Initialization of ACPI Objects\n"));
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "**** Starting initialization of namespace objects ****\n"));
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 9496b84..3151968 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -81,13 +81,11 @@ acpi_status __init acpi_load_tables(void)
 	 * between acpi_initialize_subsystem() and acpi_load_tables() to use
 	 * their customized default region handlers.
 	 */
-	if (acpi_gbl_group_module_level_code) {
-		status = acpi_ev_install_region_handlers();
-		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"During Region initialization"));
-			return_ACPI_STATUS(status);
-		}
+	status = acpi_ev_install_region_handlers();
+	if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During Region initialization"));
+		return_ACPI_STATUS(status);
 	}
 
 	/* Load the namespace from the tables */
@@ -105,6 +103,20 @@ acpi_status __init acpi_load_tables(void)
 				"While loading namespace from ACPI tables"));
 	}
 
+	if (!acpi_gbl_group_module_level_code) {
+		/*
+		 * Initialize the objects that remain uninitialized. This
+		 * runs the executable AML that may be part of the
+		 * declaration of these objects:
+		 * operation_regions, buffer_fields, Buffers, and Packages.
+		 */
+		status = acpi_ns_initialize_objects();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	}
+
+	acpi_gbl_namespace_initialized = TRUE;
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index d70649d..75b5f27 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -154,23 +154,6 @@ acpi_status __init acpi_enable_subsystem(u32 flags)
 	 */
 	acpi_gbl_early_initialization = FALSE;
 
-	/*
-	 * Install the default operation region handlers. These are the
-	 * handlers that are defined by the ACPI specification to be
-	 * "always accessible" -- namely, system_memory, system_IO, and
-	 * PCI_Config. This also means that no _REG methods need to be
-	 * run for these address spaces. We need to have these handlers
-	 * installed before any AML code can be executed, especially any
-	 * module-level code (11/2015).
-	 */
-	if (!acpi_gbl_group_module_level_code) {
-		status = acpi_ev_install_region_handlers();
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"During Region initialization"));
-			return_ACPI_STATUS(status);
-		}
-	}
 #if (!ACPI_REDUCED_HARDWARE)
 
 	/* Enable ACPI mode */
@@ -284,25 +267,21 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 	 */
 	if (acpi_gbl_group_module_level_code) {
 		acpi_ns_exec_module_code_list();
-	}
 
-	/*
-	 * Initialize the objects that remain uninitialized. This runs the
-	 * executable AML that may be part of the declaration of these objects:
-	 * operation_regions, buffer_fields, Buffers, and Packages.
-	 */
-	if (!(flags & ACPI_NO_OBJECT_INIT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "[Init] Completing Initialization of ACPI Objects\n"));
-
-		status = acpi_ns_initialize_objects();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+		/*
+		 * Initialize the objects that remain uninitialized. This
+		 * runs the executable AML that may be part of the
+		 * declaration of these objects:
+		 * operation_regions, buffer_fields, Buffers, and Packages.
+		 */
+		if (!(flags & ACPI_NO_OBJECT_INIT)) {
+			status = acpi_ns_initialize_objects();
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
 		}
 	}
 
-	acpi_gbl_namespace_initialized = TRUE;
-
 	/*
 	 * Initialize all device/region objects in the namespace. This runs
 	 * the device _STA and _INI methods and region _REG methods.
-- 
1.7.10

