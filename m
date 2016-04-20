From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA / Interpreter: Fix a regression triggered because of wrong Linux ECDT support
Date: Wed, 20 Apr 2016 10:39:56 +0800
Message-ID: <1461119996-1861-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10822 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbcDTCkW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Apr 2016 22:40:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org

4.5-stable review patch. If anyone has any objects, please let me know.

---------------

From: Lv Zheng <lv.zheng@intel.com>

commit 5508df89756f8378024828e185724a9bd2348985 upstream.

It is reported that the following commit triggers regressions:
 Linux commit: efaed9be998b5ae0afb7458e057e5f4402b43fa0
 ACPICA commit: 31178590dde82368fdb0f6b0e466b6c0add96c57
 Subject: ACPICA: Events: Enhance acpi_ev_execute_reg_method() to
          ensure no _REG evaluations can happen during OS early boot
          stages

This is because that the ECDT support is not corrected in Linux, and Linux
requires to execute _REG for ECDT (though this sounds so wrong), we need to
ensure acpi_gbl_reg_methods_enabled is set before ECDT probing in order
for _REG to be executed. Since we have to move
"acpi_gbl_reg_methods_enabled = TRUE" to the initialization step
happening before ECDT probing, acpi_load_tables() is the best candidate for
now. Thus this patch fixes the regression by doing so.

But if the ECDT support is fixed, Linux will not execute _REG for ECDT, and
ECDT probing will happen before acpi_load_tables(). At that time, we still
want to ensure acpi_gbl_reg_methods_enabled is set after executing
acpi_ns_initialize_objects() (under the condition of
acpi_gbl_group_module_level_code = FALSE), this patch also moves
acpi_ns_initialize_objects() to acpi_load_tables() accordingly.

Since acpi_ns_initialize_objects() doesn't seem to be skippable, this
patch also removes ACPI_NO_OBJECT_INIT for the one invoked in
acpi_load_tables(). Reported by Chris Bainbridge, Fixed by Lv Zheng.

Fixes: efaed9be998b (ACPICA: Events: Enhance acpi_ev_execute_reg_method() to ensure no _REG evaluations can happen during OS early boot stages)
Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/nsinit.c   |    2 ++
 drivers/acpi/acpica/tbxfload.c |   14 ++++++++++++++
 drivers/acpi/acpica/utxfinit.c |   25 +++++++++++--------------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index bd75d46..ddb436f 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -83,6 +83,8 @@ acpi_status acpi_ns_initialize_objects(void)
 
 	ACPI_FUNCTION_TRACE(ns_initialize_objects);
 
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+			  "[Init] Completing Initialization of ACPI Objects\n"));
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "**** Starting initialization of namespace objects ****\n"));
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 278666e..c37d479 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -83,6 +83,20 @@ acpi_status __init acpi_load_tables(void)
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
+	acpi_gbl_reg_methods_enabled = TRUE;
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 721b87c..638fbd4 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -267,7 +267,6 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 	 * initialized, even if they contain executable AML (see the call to
 	 * acpi_ns_initialize_objects below).
 	 */
-	acpi_gbl_reg_methods_enabled = TRUE;
 	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "[Init] Executing _REG OpRegion methods\n"));
@@ -299,20 +298,18 @@ acpi_status __init acpi_initialize_objects(u32 flags)
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
 
-- 
1.7.10

