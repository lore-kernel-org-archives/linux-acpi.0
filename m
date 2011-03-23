From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 3/3] ACPICA: Fix code divergence of global lock handling
Date: Wed, 23 Mar 2011 17:26:36 +0800
Message-ID: <1300872396-16522-4-git-send-email-ming.m.lin@intel.com>
References: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5458 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755943Ab1CWJSw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2011 05:18:52 -0400
In-Reply-To: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Commit 9cd0314(ACPI / ACPICA: Fix global lock acquisition) was backported
into ACPICA code base, and some divergence was introduced.

This patch fixed it,
- rename acpi_ev_global_lock_pending/acpi_ev_global_lock_pending_lock
  to acpi_gbl_global_lock_pending/acpi_gbl_global_lock_pending_lock.

- move the initialization of acpi_gbl_global_lock_pending_lock from
  acpi_ut_mutex_initialize to acpi_ev_init_global_lock_handler.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    6 ++-
 drivers/acpi/acpica/evmisc.c   |   74 +++++++++++++++++++++------------------
 drivers/acpi/acpica/utmutex.c  |    5 ---
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 6d512fc..73863d8 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -214,13 +214,16 @@ ACPI_EXTERN struct acpi_mutex_info acpi_gbl_mutex_info[ACPI_NUM_MUTEX];
 
 /*
  * Global lock mutex is an actual AML mutex object
- * Global lock semaphore works in conjunction with the HW global lock
+ * Global lock semaphore works in conjunction with the actual global lock
+ * Global lock spinlock is used for "pending" handshake
  */
 ACPI_EXTERN union acpi_operand_object *acpi_gbl_global_lock_mutex;
 ACPI_EXTERN acpi_semaphore acpi_gbl_global_lock_semaphore;
+ACPI_EXTERN acpi_spinlock acpi_gbl_global_lock_pending_lock;
 ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
 ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
 ACPI_EXTERN u8 acpi_gbl_global_lock_present;
+ACPI_EXTERN u8 acpi_gbl_global_lock_pending;
 
 /*
  * Spinlocks are used for interfaces that can be possibly called at
@@ -228,7 +231,6 @@ ACPI_EXTERN u8 acpi_gbl_global_lock_present;
  */
 ACPI_EXTERN acpi_spinlock acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
 ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
-ACPI_EXTERN acpi_spinlock acpi_ev_global_lock_pending_lock; /* For global lock */
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 7dc8094..69a3b4a 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -284,39 +284,41 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
  * RETURN:      ACPI_INTERRUPT_HANDLED
  *
  * DESCRIPTION: Invoked directly from the SCI handler when a global lock
- *              release interrupt occurs.  If there's a thread waiting for
- *              the global lock, signal it.
- *
- * NOTE: Assumes that the semaphore can be signaled from interrupt level. If
- * this is not possible for some reason, a separate thread will have to be
- * scheduled to do this.
+ *              release interrupt occurs. If there is actually a pending
+ *              request for the lock, signal the waiting thread.
  *
  ******************************************************************************/
-static u8 acpi_ev_global_lock_pending;
 
 static u32 acpi_ev_global_lock_handler(void *context)
 {
 	acpi_status status;
 	acpi_cpu_flags flags;
 
-	flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
+	flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
 
-	if (!acpi_ev_global_lock_pending) {
-		goto out;
+	/*
+	 * If a request for the global lock is not actually pending,
+	 * we are done. This handles "spurious" global lock interrupts
+	 * which are possible (and have been seen) with bad BIOSs.
+	 */
+	if (!acpi_gbl_global_lock_pending) {
+		goto cleanup_and_exit;
 	}
 
-	/* Send a unit to the semaphore */
-
+	/*
+	 * Send a unit to the global lock semaphore. The actual acquisition
+	 * of the global lock will be performed by the waiting thread.
+	 */
 	status = acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Could not signal Global Lock semaphore"));
 	}
 
-	acpi_ev_global_lock_pending = FALSE;
+	acpi_gbl_global_lock_pending = FALSE;
 
- out:
-	acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
+cleanup_and_exit:
 
+	acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
 	return (ACPI_INTERRUPT_HANDLED);
 }
 
@@ -350,14 +352,20 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 	 * Map to AE_OK, but mark global lock as not present. Any attempt to
 	 * actually use the global lock will be flagged with an error.
 	 */
+	acpi_gbl_global_lock_present = FALSE;
 	if (status == AE_NO_HARDWARE_RESPONSE) {
 		ACPI_ERROR((AE_INFO,
 			    "No response from Global Lock hardware, disabling lock"));
 
-		acpi_gbl_global_lock_present = FALSE;
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	status = acpi_os_create_lock(&acpi_gbl_global_lock_pending_lock);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	acpi_gbl_global_lock_pending = FALSE;
 	acpi_gbl_global_lock_present = TRUE;
 	return_ACPI_STATUS(status);
 }
@@ -414,7 +422,7 @@ static int acpi_ev_global_lock_acquired;
 acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 {
 	acpi_cpu_flags flags;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	u8 acquired = FALSE;
 
 	ACPI_FUNCTION_TRACE(ev_acquire_global_lock);
@@ -458,15 +466,15 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	}
 
 	/*
-	 * Make sure that a global lock actually exists. If not, just treat the
-	 * lock as a standard mutex.
+	 * Make sure that a global lock actually exists. If not, just
+	 * treat the lock as a standard mutex.
 	 */
 	if (!acpi_gbl_global_lock_present) {
 		acpi_gbl_global_lock_acquired = TRUE;
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
+	flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
 
 	do {
 
@@ -475,20 +483,19 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 		ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
 		if (acquired) {
 			acpi_gbl_global_lock_acquired = TRUE;
-
 			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 					  "Acquired hardware Global Lock\n"));
 			break;
 		}
 
-		acpi_ev_global_lock_pending = TRUE;
-
-		acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
-
 		/*
-		 * Did not get the lock. The pending bit was set above, and we
-		 * must wait until we get the global lock released interrupt.
+		 * Did not get the lock. The pending bit was set above, and
+		 * we must now wait until we receive the global lock
+		 * released interrupt.
 		 */
+		acpi_gbl_global_lock_pending = TRUE;
+		acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
+
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "Waiting for hardware Global Lock\n"));
 
@@ -496,17 +503,16 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 		 * Wait for handshake with the global lock interrupt handler.
 		 * This interface releases the interpreter if we must wait.
 		 */
-		status = acpi_ex_system_wait_semaphore(
-						acpi_gbl_global_lock_semaphore,
-						ACPI_WAIT_FOREVER);
+		status =
+		    acpi_ex_system_wait_semaphore
+		    (acpi_gbl_global_lock_semaphore, ACPI_WAIT_FOREVER);
 
-		flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
+		flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
 
 	} while (ACPI_SUCCESS(status));
 
-	acpi_ev_global_lock_pending = FALSE;
-
-	acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
+	acpi_gbl_global_lock_pending = FALSE;
+	acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 519d4ee..7d797e2 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -93,11 +93,6 @@ acpi_status acpi_ut_mutex_initialize(void)
 		return_ACPI_STATUS (status);
 	}
 
-	status = acpi_os_create_lock (&acpi_ev_global_lock_pending_lock);
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
 	/* Mutex for _OSI support */
 	status = acpi_os_create_mutex(&acpi_gbl_osi_mutex);
 	if (ACPI_FAILURE(status)) {
-- 
1.7.3

