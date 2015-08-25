From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/20] ACPICA: Debugger: Split debugger initialization/termination APIs.
Date: Tue, 25 Aug 2015 10:30:19 +0800
Message-ID: <7d8634a7cfd3102ed44aa7da7f96a7b36515c6fe.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 7a3f22baab000b186779dac64ad71d9776b8f432

It is likely that the debugger is enabled only when a userspace program
explicitly tells a kernel to do so, so it shouldn't be initialized as
early as current implementation.

The only tool requiring ACPI_DEBUGGER is acpiexec, so acpiexec need to call
the new APIs by itself. And BSD developers may also get notified to invoke
the APIs for DDB enabling. Lv Zheng.

This patch doesn't affect Linux kernel as debugger is currently not enabled
in the Linux kernel.

Link: https://github.com/acpica/acpica/commit/7a3f22ba
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |    4 ----
 drivers/acpi/acpica/utxface.c  |    7 -------
 drivers/acpi/acpica/utxfinit.c |   11 -----------
 include/acpi/acpixf.h          |    3 +++
 4 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index b5a9c51..447f6d3 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -77,10 +77,6 @@ struct acpi_db_execute_walk {
 /*
  * dbxface - external debugger interfaces
  */
-acpi_status acpi_db_initialize(void);
-
-void acpi_db_terminate(void);
-
 acpi_status
 acpi_db_single_step(struct acpi_walk_state *walk_state,
 		    union acpi_parse_object *op, u32 op_type);
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index c2bd5e2..4f33281 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -92,13 +92,6 @@ acpi_status __init acpi_terminate(void)
 
 	acpi_ut_mutex_terminate();
 
-#ifdef ACPI_DEBUGGER
-
-	/* Shut down the debugger */
-
-	acpi_db_terminate();
-#endif
-
 	/* Now we can shutdown the OS-dependent layer */
 
 	status = acpi_os_terminate();
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 42a32a6..a7137ec 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -124,17 +124,6 @@ acpi_status __init acpi_initialize_subsystem(void)
 		return_ACPI_STATUS(status);
 	}
 
-	/* If configured, initialize the AML debugger */
-
-#ifdef ACPI_DEBUGGER
-	status = acpi_db_initialize();
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"During Debugger initialization"));
-		return_ACPI_STATUS(status);
-	}
-#endif
-
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f2e2327..d3d7ea0 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -917,6 +917,9 @@ ACPI_DBG_DEPENDENT_RETURN_VOID(void
 ACPI_APP_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(1)
 				void ACPI_INTERNAL_VAR_XFACE
 				acpi_log_error(const char *format, ...))
+ acpi_status acpi_initialize_debugger(void);
+
+void acpi_terminate_debugger(void);
 
 /*
  * Divergences
-- 
1.7.10
