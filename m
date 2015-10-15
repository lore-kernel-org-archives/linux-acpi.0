From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/13] ACPICA: Debugger: Fix "terminate" command by cleaning up subsystem shutdown logic
Date: Thu, 15 Oct 2015 10:08:47 +0800
Message-ID: <baf6b066707f300d5a3508e2f86fcca2ba019899.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 7e823714911480be47e310fb1b3590d289b9fd99

Segmentation fault can be seen for executing the "terminate" command. This
is because acpi_ut_subsystem_shutdown() is errnously called multiple times.

This patch cleans up acpi_ut_subsystem_shutdown() logics to fix this
issue. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/7e823714
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbinput.c |    3 ++-
 drivers/acpi/acpica/utinit.c  |   13 +++++++++++++
 drivers/acpi/acpica/utxface.c |   13 -------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index f8cddd6..0480254 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -1074,6 +1074,7 @@ acpi_db_command_dispatch(char *input_buffer,
 		 * re-creating the semaphores!
 		 */
 
+		acpi_gbl_db_terminate_loop = TRUE;
 		/*  acpi_initialize (NULL); */
 		break;
 
@@ -1151,7 +1152,7 @@ void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context)
 	acpi_status status = AE_OK;
 	acpi_status Mstatus;
 
-	while (status != AE_CTRL_TERMINATE) {
+	while (status != AE_CTRL_TERMINATE && !acpi_gbl_db_terminate_loop) {
 		acpi_gbl_method_executing = FALSE;
 		acpi_gbl_step_to_next_call = FALSE;
 
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index d8699df..ccd0745 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -282,6 +282,19 @@ void acpi_ut_subsystem_shutdown(void)
 {
 	ACPI_FUNCTION_TRACE(ut_subsystem_shutdown);
 
+	/* Just exit if subsystem is already shutdown */
+
+	if (acpi_gbl_shutdown) {
+		ACPI_ERROR((AE_INFO, "ACPI Subsystem is already terminated"));
+		return_VOID;
+	}
+
+	/* Subsystem appears active, go ahead and shut it down */
+
+	acpi_gbl_shutdown = TRUE;
+	acpi_gbl_startup_flags = 0;
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Shutting down ACPI Subsystem\n"));
+
 #ifndef ACPI_ASL_COMPILER
 
 	/* Close the acpi_event Handling */
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index f183daf..a6b0eb0 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -67,19 +67,6 @@ acpi_status __init acpi_terminate(void)
 
 	ACPI_FUNCTION_TRACE(acpi_terminate);
 
-	/* Just exit if subsystem is already shutdown */
-
-	if (acpi_gbl_shutdown) {
-		ACPI_ERROR((AE_INFO, "ACPI Subsystem is already terminated"));
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	/* Subsystem appears active, go ahead and shut it down */
-
-	acpi_gbl_shutdown = TRUE;
-	acpi_gbl_startup_flags = 0;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Shutting down ACPI Subsystem\n"));
-
 	/* Shutdown and free all resources */
 
 	acpi_ut_subsystem_shutdown();
-- 
1.7.10
