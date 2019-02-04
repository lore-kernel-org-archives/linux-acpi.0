From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] acpi: get rid of acpi_sleep_dispatch
Date: Mon,  4 Feb 2019 16:32:10 +0100
Message-ID: <20190204153210.1817-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

No need for the array of structs of function pointers when we can just
call the handfull of functions directly.

This could be further cleaned up if acpi_gbl_reduced_hardware was defined
true in the ACPI_REDUCED_HARDWARE case, but that's material for the next
round.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/acpi/acpica/hwxfsleep.c | 96 +++++++--------------------------
 include/acpi/actypes.h          |  9 ----
 2 files changed, 18 insertions(+), 87 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 3f22f7dd4556..f58b78eaec65 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -23,33 +23,6 @@ acpi_hw_set_firmware_waking_vector(struct acpi_table_facs *facs,
 				   acpi_physical_address physical_address64);
 #endif
 
-static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
-
-/*
- * Dispatch table used to efficiently branch to the various sleep
- * functions.
- */
-#define ACPI_SLEEP_FUNCTION_ID         0
-#define ACPI_WAKE_PREP_FUNCTION_ID     1
-#define ACPI_WAKE_FUNCTION_ID          2
-
-/* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
-
-static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
-	{ACPI_STRUCT_INIT(legacy_function,
-			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep)),
-	 ACPI_STRUCT_INIT(extended_function,
-			  acpi_hw_extended_sleep)},
-	{ACPI_STRUCT_INIT(legacy_function,
-			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep)),
-	 ACPI_STRUCT_INIT(extended_function,
-			  acpi_hw_extended_wake_prep)},
-	{ACPI_STRUCT_INIT(legacy_function,
-			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake)),
-	 ACPI_STRUCT_INIT(extended_function,
-			  acpi_hw_extended_wake)}
-};
-
 /*
  * These functions are removed for the ACPI_REDUCED_HARDWARE case:
  *      acpi_set_firmware_waking_vector
@@ -209,53 +182,6 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios)
 #endif				/* !ACPI_REDUCED_HARDWARE */
-/*******************************************************************************
- *
- * FUNCTION:    acpi_hw_sleep_dispatch
- *
- * PARAMETERS:  sleep_state         - Which sleep state to enter/exit
- *              function_id         - Sleep, wake_prep, or Wake
- *
- * RETURN:      Status from the invoked sleep handling function.
- *
- * DESCRIPTION: Dispatch a sleep/wake request to the appropriate handling
- *              function.
- *
- ******************************************************************************/
-static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id)
-{
-	acpi_status status;
-	struct acpi_sleep_functions *sleep_functions =
-	    &acpi_sleep_dispatch[function_id];
-
-#if (!ACPI_REDUCED_HARDWARE)
-	/*
-	 * If the Hardware Reduced flag is set (from the FADT), we must
-	 * use the extended sleep registers (FADT). Note: As per the ACPI
-	 * specification, these extended registers are to be used for HW-reduced
-	 * platforms only. They are not general-purpose replacements for the
-	 * legacy PM register sleep support.
-	 */
-	if (acpi_gbl_reduced_hardware) {
-		status = sleep_functions->extended_function(sleep_state);
-	} else {
-		/* Legacy sleep */
-
-		status = sleep_functions->legacy_function(sleep_state);
-	}
-
-	return (status);
-
-#else
-	/*
-	 * For the case where reduced-hardware-only code is being generated,
-	 * we know that only the extended sleep registers are available
-	 */
-	status = sleep_functions->extended_function(sleep_state);
-	return (status);
-
-#endif				/* !ACPI_REDUCED_HARDWARE */
-}
 
 /*******************************************************************************
  *
@@ -362,7 +288,12 @@ acpi_status acpi_enter_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
 
-	status = acpi_hw_sleep_dispatch(sleep_state, ACPI_SLEEP_FUNCTION_ID);
+#if !ACPI_REDUCED_HARDWARE
+	if (!acpi_gbl_reduced_hardware)
+		status = acpi_hw_legacy_sleep(sleep_state);
+	else
+#endif
+		status = acpi_hw_extended_sleep(sleep_state);
 	return_ACPI_STATUS(status);
 }
 
@@ -388,8 +319,12 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state_prep);
 
-	status =
-	    acpi_hw_sleep_dispatch(sleep_state, ACPI_WAKE_PREP_FUNCTION_ID);
+#if !ACPI_REDUCED_HARDWARE
+	if (!acpi_gbl_reduced_hardware)
+		status = acpi_hw_legacy_wake_prep(sleep_state);
+	else
+#endif
+		status = acpi_hw_extended_wake_prep(sleep_state);
 	return_ACPI_STATUS(status);
 }
 
@@ -413,7 +348,12 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state);
 
-	status = acpi_hw_sleep_dispatch(sleep_state, ACPI_WAKE_FUNCTION_ID);
+#if !ACPI_REDUCED_HARDWARE
+	if (!acpi_gbl_reduced_hardware)
+		status = acpi_hw_legacy_wake(sleep_state);
+	else
+#endif
+		status = acpi_hw_extended_wake(sleep_state);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2590627dbfcc..9b11d07e4363 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -885,15 +885,6 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ENABLE_EVENT                       1
 #define ACPI_DISABLE_EVENT                      0
 
-/* Sleep function dispatch */
-
-typedef acpi_status (*acpi_sleep_function) (u8 sleep_state);
-
-struct acpi_sleep_functions {
-	acpi_sleep_function legacy_function;
-	acpi_sleep_function extended_function;
-};
-
 /*
  * External ACPI object definition
  */
-- 
2.20.1
