From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 05/11] ACPICA: Dispatcher: Introduce timeout mechanism for infinite loop detection
Date: Fri, 17 Nov 2017 15:40:18 -0800
Message-ID: <20171117234024.833-6-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29666 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbdKQXpX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:23 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Lv Zheng <lv.zheng@intel.com>

ACPICA commit 9605023e7e6d1f05581502766c8cf2905bcc03d9

This patch implements a new infinite loop detection mechanism to replace
the old one, it uses acpi_os_get_timer() to limit loop execution into a
determined time slice.
This is useful in case some hardware/firmware operations really require the
AML interpreter to wait while the old mechanism could expire too fast on
recent machines.

The new mechanism converts old acpi_gbl_max_loop_iterations to store the user
configurable value for the new mechanism in order to allow users to be
still able to configure this value for acpiexec via command line. This
patch also removes wrong initilization code of acpi_gbl_max_loop_iterations
accordingly (it should have been initialized by ACPI_INIT_GLOBAL, and the
default value is also properly tuned for acpiexec). Reported by M. Foronda,
fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/9605023e
Link: https://bugzilla.kernel.org/show_bug.cgi?id=156501
Reported-by: M. Foronda <josemauricioforonda@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |  2 +-
 drivers/acpi/acpica/dscontrol.c | 16 +++++++++-------
 drivers/acpi/acpica/utinit.c    |  1 -
 include/acpi/acconfig.h         |  4 ++--
 include/acpi/acpixf.h           |  4 ++--
 include/acpi/actypes.h          |  2 ++
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 0d45b8bb1678..bed041d41596 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -622,7 +622,7 @@ struct acpi_control_state {
 	union acpi_parse_object *predicate_op;
 	u8 *aml_predicate_start;	/* Start of if/while predicate */
 	u8 *package_end;	/* End of if/while block */
-	u32 loop_count;		/* While() loop counter */
+	u64 loop_timeout;	/* While() loop timeout */
 };
 
 /*
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index f470e81b0499..244075dbc03a 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -118,6 +118,8 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 		control_state->control.package_end =
 		    walk_state->parser_state.pkg_end;
 		control_state->control.opcode = op->common.aml_opcode;
+		control_state->control.loop_timeout = acpi_os_get_timer() +
+		    (u64)(acpi_gbl_max_loop_iterations * ACPI_100NSEC_PER_SEC);
 
 		/* Push the control state on this walk's control stack */
 
@@ -206,14 +208,14 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state *walk_state,
 			/* Predicate was true, the body of the loop was just executed */
 
 			/*
-			 * This loop counter mechanism allows the interpreter to escape
-			 * possibly infinite loops. This can occur in poorly written AML
-			 * when the hardware does not respond within a while loop and the
-			 * loop does not implement a timeout.
+			 * This infinite loop detection mechanism allows the interpreter
+			 * to escape possibly infinite loops. This can occur in poorly
+			 * written AML when the hardware does not respond within a while
+			 * loop and the loop does not implement a timeout.
 			 */
-			control_state->control.loop_count++;
-			if (control_state->control.loop_count >
-			    acpi_gbl_max_loop_iterations) {
+			if (ACPI_TIME_AFTER(acpi_os_get_timer(),
+					    control_state->control.
+					    loop_timeout)) {
 				status = AE_AML_INFINITE_LOOP;
 				break;
 			}
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 23e766d1691d..45eeb0dcf283 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -206,7 +206,6 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_next_owner_id_offset = 0;
 	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
 	acpi_gbl_osi_mutex = NULL;
-	acpi_gbl_max_loop_iterations = ACPI_MAX_LOOP_COUNT;
 
 	/* Hardware oriented */
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 6db3b4668b1a..ffe364fa4040 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -145,9 +145,9 @@
 
 #define ACPI_ADDRESS_RANGE_MAX          2
 
-/* Maximum number of While() loops before abort */
+/* Maximum time (default 30s) of While() loops before abort */
 
-#define ACPI_MAX_LOOP_COUNT             0x000FFFFF
+#define ACPI_MAX_LOOP_TIMEOUT           30
 
 /******************************************************************************
  *
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e1dd1a8d42b6..1a4322db0274 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -260,11 +260,11 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_osi_data, 0);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_reduced_hardware, FALSE);
 
 /*
- * Maximum number of While() loop iterations before forced method abort.
+ * Maximum timeout for While() loop iterations before forced method abort.
  * This mechanism is intended to prevent infinite loops during interpreter
  * execution within a host kernel.
  */
-ACPI_INIT_GLOBAL(u32, acpi_gbl_max_loop_iterations, ACPI_MAX_LOOP_COUNT);
+ACPI_INIT_GLOBAL(u32, acpi_gbl_max_loop_iterations, ACPI_MAX_LOOP_TIMEOUT);
 
 /*
  * This mechanism is used to trace a specified AML method. The method is
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4f077edb9b81..ddde2790a54a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -468,6 +468,8 @@ typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
 #define ACPI_NSEC_PER_MSEC              1000000L
 #define ACPI_NSEC_PER_SEC               1000000000L
 
+#define ACPI_TIME_AFTER(a, b)           ((s64)((b) - (a)) < 0)
+
 /* Owner IDs are used to track namespace nodes for selective deletion */
 
 typedef u8 acpi_owner_id;
-- 
2.13.6

