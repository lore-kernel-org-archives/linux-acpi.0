From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPICA: Drop Linux-specific waking vector functions
Date: Sun, 03 Jan 2016 02:51:12 +0100
Message-ID: <1672897.3KviH2SFad@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61258 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751047AbcACBUh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jan 2016 20:20:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit f06147f9fbf1 (ACPICA: Hardware: Enable firmware waking vector
for both 32-bit and 64-bit FACS) added three functions that aren't
present in upstream ACPICA, acpi_hw_set_firmware_waking_vectors(),
acpi_set_firmware_waking_vectors() and acpi_set_firmware_waking_vector64(),
to allow Linux to use the previously existing API for setting the
platform firmware waking vector.

However, that wasn't necessary, since the ACPI sleep support code
in Linux can be modified to use the upstream ACPICA's API easily
and the additional functions may be dropped which reduces the code
size and puts the kernel's ACPICA code more in line with the upstream.

Make the changes as per the above.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c |   88 ++++++----------------------------------
 drivers/acpi/sleep.c            |    4 -
 drivers/acpi/sleep.h            |    6 ++
 include/acpi/acpixf.h           |   10 ----
 4 files changed, 24 insertions(+), 84 deletions(-)

Index: linux-pm/drivers/acpi/acpica/hwxfsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwxfsleep.c
+++ linux-pm/drivers/acpi/acpica/hwxfsleep.c
@@ -52,9 +52,9 @@ ACPI_MODULE_NAME("hwxfsleep")
 /* Local prototypes */
 #if (!ACPI_REDUCED_HARDWARE)
 static acpi_status
-acpi_hw_set_firmware_waking_vectors(struct acpi_table_facs *facs,
-				    acpi_physical_address physical_address,
-				    acpi_physical_address physical_address64);
+acpi_hw_set_firmware_waking_vector(struct acpi_table_facs *facs,
+				   acpi_physical_address physical_address,
+				   acpi_physical_address physical_address64);
 #endif
 
 static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
@@ -79,16 +79,14 @@ static struct acpi_sleep_functions acpi_
 
 /*
  * These functions are removed for the ACPI_REDUCED_HARDWARE case:
- *      acpi_set_firmware_waking_vectors
  *      acpi_set_firmware_waking_vector
- *      acpi_set_firmware_waking_vector64
  *      acpi_enter_sleep_state_s4bios
  */
 
 #if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
- * FUNCTION:    acpi_hw_set_firmware_waking_vectors
+ * FUNCTION:    acpi_hw_set_firmware_waking_vector
  *
  * PARAMETERS:  facs                - Pointer to FACS table
  *              physical_address    - 32-bit physical address of ACPI real mode
@@ -103,11 +101,11 @@ static struct acpi_sleep_functions acpi_
  ******************************************************************************/
 
 static acpi_status
-acpi_hw_set_firmware_waking_vectors(struct acpi_table_facs *facs,
-				    acpi_physical_address physical_address,
-				    acpi_physical_address physical_address64)
+acpi_hw_set_firmware_waking_vector(struct acpi_table_facs *facs,
+				   acpi_physical_address physical_address,
+				   acpi_physical_address physical_address64)
 {
-	ACPI_FUNCTION_TRACE(acpi_hw_set_firmware_waking_vectors);
+	ACPI_FUNCTION_TRACE(acpi_hw_set_firmware_waking_vector);
 
 
 	/*
@@ -140,7 +138,7 @@ acpi_hw_set_firmware_waking_vectors(stru
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_set_firmware_waking_vectors
+ * FUNCTION:    acpi_set_firmware_waking_vector
  *
  * PARAMETERS:  physical_address    - 32-bit physical address of ACPI real mode
  *                                    entry point.
@@ -154,79 +152,23 @@ acpi_hw_set_firmware_waking_vectors(stru
  ******************************************************************************/
 
 acpi_status
-acpi_set_firmware_waking_vectors(acpi_physical_address physical_address,
-				 acpi_physical_address physical_address64)
+acpi_set_firmware_waking_vector(acpi_physical_address physical_address,
+				acpi_physical_address physical_address64)
 {
 
-	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vectors);
+	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
 
 	if (acpi_gbl_FACS) {
-		(void)acpi_hw_set_firmware_waking_vectors(acpi_gbl_FACS,
-							  physical_address,
-							  physical_address64);
+		(void)acpi_hw_set_firmware_waking_vector(acpi_gbl_FACS,
+							 physical_address,
+							 physical_address64);
 	}
 
 	return_ACPI_STATUS(AE_OK);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vectors)
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_set_firmware_waking_vector
- *
- * PARAMETERS:  physical_address    - 32-bit physical address of ACPI real mode
- *                                    entry point.
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Sets the 32-bit firmware_waking_vector field of the FACS
- *
- ******************************************************************************/
-acpi_status acpi_set_firmware_waking_vector(u32 physical_address)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
-
-	status = acpi_set_firmware_waking_vectors((acpi_physical_address)
-						  physical_address, 0);
-
-	return_ACPI_STATUS(status);
-}
-
 ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 
-#if ACPI_MACHINE_WIDTH == 64
-/*******************************************************************************
- *
- * FUNCTION:    acpi_set_firmware_waking_vector64
- *
- * PARAMETERS:  physical_address    - 64-bit physical address of ACPI protected
- *                                    mode entry point.
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Sets the 64-bit X_firmware_waking_vector field of the FACS, if
- *              it exists in the table. This function is intended for use with
- *              64-bit host operating systems.
- *
- ******************************************************************************/
-acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
-
-	status = acpi_set_firmware_waking_vectors(0,
-						  (acpi_physical_address)
-						  physical_address);
-
-	return_ACPI_STATUS(status);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
-#endif
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state_s4bios
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -863,17 +863,9 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status acpi_leave_sleep_state(u8 sleep_state))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_set_firmware_waking_vectors
+				acpi_set_firmware_waking_vector
 				(acpi_physical_address physical_address,
 				 acpi_physical_address physical_address64))
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_set_firmware_waking_vector(u32
-								 physical_address))
-#if ACPI_MACHINE_WIDTH == 64
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_set_firmware_waking_vector64(u64
-								  physical_address))
-#endif
 /*
  * ACPI Timer interfaces
  */
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -61,7 +61,7 @@ static int acpi_sleep_prepare(u32 acpi_s
 	if (acpi_state == ACPI_STATE_S3) {
 		if (!acpi_wakeup_address)
 			return -EFAULT;
-		acpi_set_firmware_waking_vector(acpi_wakeup_address);
+		acpi_set_waking_vector(acpi_wakeup_address);
 
 	}
 	ACPI_FLUSH_CPU_CACHE();
@@ -410,7 +410,7 @@ static void acpi_pm_finish(void)
 	acpi_leave_sleep_state(acpi_state);
 
 	/* reset firmware waking vector */
-	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
+	acpi_set_waking_vector(0);
 
 	acpi_target_sleep_state = ACPI_STATE_S0;
 
Index: linux-pm/drivers/acpi/sleep.h
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.h
+++ linux-pm/drivers/acpi/sleep.h
@@ -6,3 +6,9 @@ extern struct list_head acpi_wakeup_devi
 extern struct mutex acpi_device_lock;
 
 extern void acpi_resume_power_resources(void);
+
+static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
+{
+	return acpi_set_firmware_waking_vector(
+				(acpi_physical_address)wakeup_address, 0);
+}

