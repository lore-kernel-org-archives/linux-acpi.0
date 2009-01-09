From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/94] ACPICA: Add global pointer for FACS table to simplify
 FACS access
Date: Fri, 09 Jan 2009 04:26:29 -0500
Message-ID: <009c4cbe99bea2da53f29ad685975a36f38c001c.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbZAIJ2b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:31 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700MII6ANW493@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:00 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Use a global pointer instead of using AcpiGetTableByIndex for
each FACS access. This simplifies the code for the Global Lock
and the Firmware Waking Vector(s).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c      |   22 ++++++----------------
 drivers/acpi/hardware/hwsleep.c   |   37 ++++++-------------------------------
 drivers/acpi/tables/tbutils.c     |   24 ++++++++++++++++++++++++
 drivers/acpi/utilities/utglobal.c |    1 +
 drivers/acpi/utilities/utxface.c  |   11 +++++++++++
 include/acpi/acglobal.h           |    1 +
 include/acpi/actables.h           |    2 ++
 7 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 1d5670b..82c457f 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -49,11 +49,7 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evmisc")
 
-/* Pointer to FACS needed for the Global Lock */
-static struct acpi_table_facs *facs = NULL;
-
 /* Local prototypes */
-
 static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context);
 
 static u32 acpi_ev_global_lock_handler(void *context);
@@ -299,7 +295,7 @@ static u32 acpi_ev_global_lock_handler(void *context)
 	 * If we don't get it now, it will be marked pending and we will
 	 * take another interrupt when it becomes free.
 	 */
-	ACPI_ACQUIRE_GLOBAL_LOCK(facs, acquired);
+	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
 	if (acquired) {
 
 		/* Got the lock, now wake all threads waiting for it */
@@ -336,15 +332,8 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 
 	ACPI_FUNCTION_TRACE(ev_init_global_lock_handler);
 
-	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-					 ACPI_CAST_INDIRECT_PTR(struct
-								acpi_table_header,
-								&facs));
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	/* Attempt installation of the global lock handler */
 
-	acpi_gbl_global_lock_present = TRUE;
 	status = acpi_install_fixed_event_handler(ACPI_EVENT_GLOBAL,
 						  acpi_ev_global_lock_handler,
 						  NULL);
@@ -361,9 +350,10 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 			    "No response from Global Lock hardware, disabling lock"));
 
 		acpi_gbl_global_lock_present = FALSE;
-		status = AE_OK;
+		return_ACPI_STATUS(AE_OK);
 	}
 
+	acpi_gbl_global_lock_present = TRUE;
 	return_ACPI_STATUS(status);
 }
 
@@ -472,7 +462,7 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 
 	/* Attempt to acquire the actual hardware lock */
 
-	ACPI_ACQUIRE_GLOBAL_LOCK(facs, acquired);
+	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
 	if (acquired) {
 
 		/* We got the lock */
@@ -536,7 +526,7 @@ acpi_status acpi_ev_release_global_lock(void)
 
 		/* Allow any thread to release the lock */
 
-		ACPI_RELEASE_GLOBAL_LOCK(facs, pending);
+		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
 
 		/*
 		 * If the pending bit was set, we must write GBL_RLS to the control
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 6a30c80..5ec727f 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -63,20 +63,8 @@ ACPI_MODULE_NAME("hwsleep")
 acpi_status
 acpi_set_firmware_waking_vector(u32 physical_address)
 {
-	struct acpi_table_facs *facs;
-	acpi_status status;
-
 	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
 
-	/* Get the FACS */
-
-	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-					 ACPI_CAST_INDIRECT_PTR(struct
-								acpi_table_header,
-								&facs));
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 
 	/*
 	 * According to the ACPI specification 2.0c and later, the 64-bit
@@ -88,12 +76,12 @@ acpi_set_firmware_waking_vector(u32 physical_address)
 
 	/* Set the 32-bit vector */
 
-	facs->firmware_waking_vector = physical_address;
+	acpi_gbl_FACS->firmware_waking_vector = physical_address;
 
 	/* Clear the 64-bit vector if it exists */
 
-	if ((facs->length > 32) && (facs->version >= 1)) {
-		facs->xfirmware_waking_vector = 0;
+	if ((acpi_gbl_FACS->length > 32) && (acpi_gbl_FACS->version >= 1)) {
+		acpi_gbl_FACS->xfirmware_waking_vector = 0;
 	}
 
 	return_ACPI_STATUS(AE_OK);
@@ -117,32 +105,19 @@ ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 acpi_status
 acpi_set_firmware_waking_vector64(u64 physical_address)
 {
-	struct acpi_table_facs *facs;
-	acpi_status status;
-
 	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
 
 
-	/* Get the FACS */
-
-	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-					 ACPI_CAST_INDIRECT_PTR(struct
-								acpi_table_header,
-								&facs));
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Determine if the 64-bit vector actually exists */
 
-	if ((facs->length <= 32) || (facs->version < 1)) {
+	if ((acpi_gbl_FACS->length <= 32) || (acpi_gbl_FACS->version < 1)) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
 	/* Clear 32-bit vector, set the 64-bit X_ vector */
 
-	facs->firmware_waking_vector = 0;
-	facs->xfirmware_waking_vector = physical_address;
+	acpi_gbl_FACS->firmware_waking_vector = 0;
+	acpi_gbl_FACS->xfirmware_waking_vector = physical_address;
 
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 0cc92ef..50e6777 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -113,6 +113,30 @@ acpi_tb_check_xsdt(acpi_physical_address address)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_initialize_facs
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Create a permanent mapping for the FADT and save it in a global
+ *              for accessing the Global Lock and Firmware Waking Vector
+ *
+ ******************************************************************************/
+
+acpi_status acpi_tb_initialize_facs(void)
+{
+	acpi_status status;
+
+	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+					 ACPI_CAST_INDIRECT_PTR(struct
+								acpi_table_header,
+								&acpi_gbl_FACS));
+	return status;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_tables_loaded
  *
  * PARAMETERS:  None
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 3dc5311..211d621 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -771,6 +771,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_global_lock_mutex = NULL;
 	acpi_gbl_global_lock_acquired = FALSE;
 	acpi_gbl_global_lock_handle = 0;
+	acpi_gbl_global_lock_present = FALSE;
 
 	/* Miscellaneous variables */
 
diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index c198a4d..7ca8952 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -45,6 +45,7 @@
 #include <acpi/acevents.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acdebug.h>
+#include <acpi/actables.h>
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utxface")
@@ -148,6 +149,16 @@ acpi_status acpi_enable_subsystem(u32 flags)
 	}
 
 	/*
+	 * Obtain a permanent mapping for the FACS. This is required for the
+	 * Global Lock and the Firmware Waking Vector
+	 */
+	status = acpi_tb_initialize_facs();
+	if (ACPI_FAILURE(status)) {
+		ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
+		return_ACPI_STATUS(status);
+	}
+
+	/*
 	 * Install the default op_region handlers. These are installed unless
 	 * other handlers have already been installed via the
 	 * install_address_space_handler interface.
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 15dda46..77d73a4 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -140,6 +140,7 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
+ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
 extern u8 acpi_gbl_permanent_mmap;
 
 /* These addresses are calculated from FADT address values */
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 0cbe1b9..7ce6e33 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -94,6 +94,8 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded);
 /*
  * tbutils - table manager utilities
  */
+acpi_status acpi_tb_initialize_facs(void);
+
 u8 acpi_tb_tables_loaded(void);
 
 void
-- 
1.5.6.6

