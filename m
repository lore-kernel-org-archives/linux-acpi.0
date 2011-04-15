From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20110413 linuxized patches
Date: Fri, 15 Apr 2011 09:10:03 +0800
Message-ID: <1302829803.28930.12.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4KDWNHMESMIeEGSdGgy8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3382 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902Ab1DOBKY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Apr 2011 21:10:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-4KDWNHMESMIeEGSdGgy8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA release 20110413 linuxized patches attached.
Build and tested on my notebook without problem.

[PATCH 1/6] ACPICA: Split all internal Global Lock functions to new file - evglock
[PATCH 2/6] ACPICA: Add more methods eligible for NULL package element removal
[PATCH 3/6] ACPICA: Update internal address SpaceID for DataTable regions
[PATCH 4/6] ACPICA: Move ACPI_NUM_PREDEFINED_REGIONS to a more appropriate place
[PATCH 5/6] ACPICA: Execute an orphan _REG method under the EC device
[PATCH 6/6] ACPICA: Update to version 20110413

Lin Ming

--=-4KDWNHMESMIeEGSdGgy8
Content-Disposition: attachment; filename="acpica-v20110413.patch"
Content-Type: text/x-patch; name="acpica-v20110413.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From c30d8e8305839ae0f36bc643374383cbf6cf2797 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 13 Apr 2011 11:33:17 +0800
Subject: [PATCH 1/6] ACPICA: Split all internal Global Lock functions to new file - evglock

These functions were moved from evmisc.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/Makefile   |    2 +-
 drivers/acpi/acpica/acevents.h |   17 ++-
 drivers/acpi/acpica/evglock.c  |  335 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evmisc.c   |  309 ------------------------------------
 4 files changed, 347 insertions(+), 316 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index a122471..301bd2d 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -14,7 +14,7 @@ acpi-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
 
 acpi-y += evevent.o  evregion.o  evsci.o    evxfevnt.o \
 	 evmisc.o   evrgnini.o  evxface.o  evxfregn.o \
-	 evgpe.o    evgpeblk.o evgpeinit.o  evgpeutil.o evxfgpe.o
+	 evgpe.o    evgpeblk.o evgpeinit.o  evgpeutil.o evxfgpe.o evglock.o
 
 acpi-y += exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
 	 exconvrt.o  exfldio.o  exoparg1.o  exprep.o    exresop.o   exsystem.o\
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 41d247d..bea3b48 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -58,12 +58,6 @@ u32 acpi_ev_fixed_event_detect(void);
  */
 u8 acpi_ev_is_notify_object(struct acpi_namespace_node *node);
 
-acpi_status acpi_ev_acquire_global_lock(u16 timeout);
-
-acpi_status acpi_ev_release_global_lock(void);
-
-acpi_status acpi_ev_init_global_lock_handler(void);
-
 u32 acpi_ev_get_gpe_number_index(u32 gpe_number);
 
 acpi_status
@@ -71,6 +65,17 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node,
 			     u32 notify_value);
 
 /*
+ * evglock - Global Lock support
+ */
+acpi_status acpi_ev_init_global_lock_handler(void);
+
+acpi_status acpi_ev_acquire_global_lock(u16 timeout);
+
+acpi_status acpi_ev_release_global_lock(void);
+
+acpi_status acpi_ev_remove_global_lock_handler(void);
+
+/*
  * evgpe - Low-level GPE support
  */
 u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list);
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
new file mode 100644
index 0000000..56a562a
--- /dev/null
+++ b/drivers/acpi/acpica/evglock.c
@@ -0,0 +1,335 @@
+/******************************************************************************
+ *
+ * Module Name: evglock - Global Lock support
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2011, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acinterp.h"
+
+#define _COMPONENT          ACPI_EVENTS
+ACPI_MODULE_NAME("evglock")
+
+/* Local prototypes */
+static u32 acpi_ev_global_lock_handler(void *context);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_init_global_lock_handler
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a handler for the global lock release event
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ev_init_global_lock_handler(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ev_init_global_lock_handler);
+
+	/* Attempt installation of the global lock handler */
+
+	status = acpi_install_fixed_event_handler(ACPI_EVENT_GLOBAL,
+						  acpi_ev_global_lock_handler,
+						  NULL);
+
+	/*
+	 * If the global lock does not exist on this platform, the attempt to
+	 * enable GBL_STATUS will fail (the GBL_ENABLE bit will not stick).
+	 * Map to AE_OK, but mark global lock as not present. Any attempt to
+	 * actually use the global lock will be flagged with an error.
+	 */
+	acpi_gbl_global_lock_present = FALSE;
+	if (status == AE_NO_HARDWARE_RESPONSE) {
+		ACPI_ERROR((AE_INFO,
+			    "No response from Global Lock hardware, disabling lock"));
+
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	status = acpi_os_create_lock(&acpi_gbl_global_lock_pending_lock);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	acpi_gbl_global_lock_pending = FALSE;
+	acpi_gbl_global_lock_present = TRUE;
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_remove_global_lock_handler
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove the handler for the Global Lock
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ev_remove_global_lock_handler(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ev_remove_global_lock_handler);
+
+	acpi_gbl_global_lock_present = FALSE;
+	status = acpi_remove_fixed_event_handler(ACPI_EVENT_GLOBAL,
+						 acpi_ev_global_lock_handler);
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_global_lock_handler
+ *
+ * PARAMETERS:  Context         - From thread interface, not used
+ *
+ * RETURN:      ACPI_INTERRUPT_HANDLED
+ *
+ * DESCRIPTION: Invoked directly from the SCI handler when a global lock
+ *              release interrupt occurs. If there is actually a pending
+ *              request for the lock, signal the waiting thread.
+ *
+ ******************************************************************************/
+
+static u32 acpi_ev_global_lock_handler(void *context)
+{
+	acpi_status status;
+	acpi_cpu_flags flags;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
+
+	/*
+	 * If a request for the global lock is not actually pending,
+	 * we are done. This handles "spurious" global lock interrupts
+	 * which are possible (and have been seen) with bad BIOSs.
+	 */
+	if (!acpi_gbl_global_lock_pending) {
+		goto cleanup_and_exit;
+	}
+
+	/*
+	 * Send a unit to the global lock semaphore. The actual acquisition
+	 * of the global lock will be performed by the waiting thread.
+	 */
+	status = acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not signal Global Lock semaphore"));
+	}
+
+	acpi_gbl_global_lock_pending = FALSE;
+
+      cleanup_and_exit:
+
+	acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
+	return (ACPI_INTERRUPT_HANDLED);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_acquire_global_lock
+ *
+ * PARAMETERS:  Timeout         - Max time to wait for the lock, in millisec.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Attempt to gain ownership of the Global Lock.
+ *
+ * MUTEX:       Interpreter must be locked
+ *
+ * Note: The original implementation allowed multiple threads to "acquire" the
+ * Global Lock, and the OS would hold the lock until the last thread had
+ * released it. However, this could potentially starve the BIOS out of the
+ * lock, especially in the case where there is a tight handshake between the
+ * Embedded Controller driver and the BIOS. Therefore, this implementation
+ * allows only one thread to acquire the HW Global Lock at a time, and makes
+ * the global lock appear as a standard mutex on the OS side.
+ *
+ *****************************************************************************/
+
+acpi_status acpi_ev_acquire_global_lock(u16 timeout)
+{
+	acpi_cpu_flags flags;
+	acpi_status status;
+	u8 acquired = FALSE;
+
+	ACPI_FUNCTION_TRACE(ev_acquire_global_lock);
+
+	/*
+	 * Only one thread can acquire the GL at a time, the global_lock_mutex
+	 * enforces this. This interface releases the interpreter if we must wait.
+	 */
+	status =
+	    acpi_ex_system_wait_mutex(acpi_gbl_global_lock_mutex->mutex.
+				      os_mutex, timeout);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/*
+	 * Update the global lock handle and check for wraparound. The handle is
+	 * only used for the external global lock interfaces, but it is updated
+	 * here to properly handle the case where a single thread may acquire the
+	 * lock via both the AML and the acpi_acquire_global_lock interfaces. The
+	 * handle is therefore updated on the first acquire from a given thread
+	 * regardless of where the acquisition request originated.
+	 */
+	acpi_gbl_global_lock_handle++;
+	if (acpi_gbl_global_lock_handle == 0) {
+		acpi_gbl_global_lock_handle = 1;
+	}
+
+	/*
+	 * Make sure that a global lock actually exists. If not, just
+	 * treat the lock as a standard mutex.
+	 */
+	if (!acpi_gbl_global_lock_present) {
+		acpi_gbl_global_lock_acquired = TRUE;
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
+
+	do {
+
+		/* Attempt to acquire the actual hardware lock */
+
+		ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
+		if (acquired) {
+			acpi_gbl_global_lock_acquired = TRUE;
+			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+					  "Acquired hardware Global Lock\n"));
+			break;
+		}
+
+		/*
+		 * Did not get the lock. The pending bit was set above, and
+		 * we must now wait until we receive the global lock
+		 * released interrupt.
+		 */
+		acpi_gbl_global_lock_pending = TRUE;
+		acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
+
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Waiting for hardware Global Lock\n"));
+
+		/*
+		 * Wait for handshake with the global lock interrupt handler.
+		 * This interface releases the interpreter if we must wait.
+		 */
+		status =
+		    acpi_ex_system_wait_semaphore
+		    (acpi_gbl_global_lock_semaphore, ACPI_WAIT_FOREVER);
+
+		flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
+
+	} while (ACPI_SUCCESS(status));
+
+	acpi_gbl_global_lock_pending = FALSE;
+	acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_release_global_lock
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Releases ownership of the Global Lock.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ev_release_global_lock(void)
+{
+	u8 pending = FALSE;
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE(ev_release_global_lock);
+
+	/* Lock must be already acquired */
+
+	if (!acpi_gbl_global_lock_acquired) {
+		ACPI_WARNING((AE_INFO,
+			      "Cannot release the ACPI Global Lock, it has not been acquired"));
+		return_ACPI_STATUS(AE_NOT_ACQUIRED);
+	}
+
+	if (acpi_gbl_global_lock_present) {
+
+		/* Allow any thread to release the lock */
+
+		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
+
+		/*
+		 * If the pending bit was set, we must write GBL_RLS to the control
+		 * register
+		 */
+		if (pending) {
+			status =
+			    acpi_write_bit_register
+			    (ACPI_BITREG_GLOBAL_LOCK_RELEASE,
+			     ACPI_ENABLE_EVENT);
+		}
+
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Released hardware Global Lock\n"));
+	}
+
+	acpi_gbl_global_lock_acquired = FALSE;
+
+	/* Release the local GL mutex */
+
+	acpi_os_release_mutex(acpi_gbl_global_lock_mutex->mutex.os_mutex);
+	return_ACPI_STATUS(status);
+}
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 69a3b4a..d0b3318 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -45,7 +45,6 @@
 #include "accommon.h"
 #include "acevents.h"
 #include "acnamesp.h"
-#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evmisc")
@@ -53,10 +52,6 @@ ACPI_MODULE_NAME("evmisc")
 /* Local prototypes */
 static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context);
 
-static u32 acpi_ev_global_lock_handler(void *context);
-
-static acpi_status acpi_ev_remove_global_lock_handler(void);
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_is_notify_object
@@ -275,310 +270,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 	acpi_ut_delete_generic_state(notify_info);
 }
 
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_global_lock_handler
- *
- * PARAMETERS:  Context         - From thread interface, not used
- *
- * RETURN:      ACPI_INTERRUPT_HANDLED
- *
- * DESCRIPTION: Invoked directly from the SCI handler when a global lock
- *              release interrupt occurs. If there is actually a pending
- *              request for the lock, signal the waiting thread.
- *
- ******************************************************************************/
-
-static u32 acpi_ev_global_lock_handler(void *context)
-{
-	acpi_status status;
-	acpi_cpu_flags flags;
-
-	flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
-
-	/*
-	 * If a request for the global lock is not actually pending,
-	 * we are done. This handles "spurious" global lock interrupts
-	 * which are possible (and have been seen) with bad BIOSs.
-	 */
-	if (!acpi_gbl_global_lock_pending) {
-		goto cleanup_and_exit;
-	}
-
-	/*
-	 * Send a unit to the global lock semaphore. The actual acquisition
-	 * of the global lock will be performed by the waiting thread.
-	 */
-	status = acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
-	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Could not signal Global Lock semaphore"));
-	}
-
-	acpi_gbl_global_lock_pending = FALSE;
-
-cleanup_and_exit:
-
-	acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
-	return (ACPI_INTERRUPT_HANDLED);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_init_global_lock_handler
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Install a handler for the global lock release event
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_init_global_lock_handler(void)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_init_global_lock_handler);
-
-	/* Attempt installation of the global lock handler */
-
-	status = acpi_install_fixed_event_handler(ACPI_EVENT_GLOBAL,
-						  acpi_ev_global_lock_handler,
-						  NULL);
-
-	/*
-	 * If the global lock does not exist on this platform, the attempt to
-	 * enable GBL_STATUS will fail (the GBL_ENABLE bit will not stick).
-	 * Map to AE_OK, but mark global lock as not present. Any attempt to
-	 * actually use the global lock will be flagged with an error.
-	 */
-	acpi_gbl_global_lock_present = FALSE;
-	if (status == AE_NO_HARDWARE_RESPONSE) {
-		ACPI_ERROR((AE_INFO,
-			    "No response from Global Lock hardware, disabling lock"));
-
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	status = acpi_os_create_lock(&acpi_gbl_global_lock_pending_lock);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	acpi_gbl_global_lock_pending = FALSE;
-	acpi_gbl_global_lock_present = TRUE;
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_remove_global_lock_handler
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Remove the handler for the Global Lock
- *
- ******************************************************************************/
-
-static acpi_status acpi_ev_remove_global_lock_handler(void)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_remove_global_lock_handler);
-
-	acpi_gbl_global_lock_present = FALSE;
-	status = acpi_remove_fixed_event_handler(ACPI_EVENT_GLOBAL,
-						 acpi_ev_global_lock_handler);
-
-	return_ACPI_STATUS(status);
-}
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_ev_acquire_global_lock
- *
- * PARAMETERS:  Timeout         - Max time to wait for the lock, in millisec.
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Attempt to gain ownership of the Global Lock.
- *
- * MUTEX:       Interpreter must be locked
- *
- * Note: The original implementation allowed multiple threads to "acquire" the
- * Global Lock, and the OS would hold the lock until the last thread had
- * released it. However, this could potentially starve the BIOS out of the
- * lock, especially in the case where there is a tight handshake between the
- * Embedded Controller driver and the BIOS. Therefore, this implementation
- * allows only one thread to acquire the HW Global Lock at a time, and makes
- * the global lock appear as a standard mutex on the OS side.
- *
- *****************************************************************************/
-static acpi_thread_id acpi_ev_global_lock_thread_id;
-static int acpi_ev_global_lock_acquired;
-
-acpi_status acpi_ev_acquire_global_lock(u16 timeout)
-{
-	acpi_cpu_flags flags;
-	acpi_status status;
-	u8 acquired = FALSE;
-
-	ACPI_FUNCTION_TRACE(ev_acquire_global_lock);
-
-	/*
-	 * Only one thread can acquire the GL at a time, the global_lock_mutex
-	 * enforces this. This interface releases the interpreter if we must wait.
-	 */
-	status = acpi_ex_system_wait_mutex(
-			acpi_gbl_global_lock_mutex->mutex.os_mutex, 0);
-	if (status == AE_TIME) {
-		if (acpi_ev_global_lock_thread_id == acpi_os_get_thread_id()) {
-			acpi_ev_global_lock_acquired++;
-			return AE_OK;
-		}
-	}
-
-	if (ACPI_FAILURE(status)) {
-		status = acpi_ex_system_wait_mutex(
-				acpi_gbl_global_lock_mutex->mutex.os_mutex,
-				timeout);
-	}
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	acpi_ev_global_lock_thread_id = acpi_os_get_thread_id();
-	acpi_ev_global_lock_acquired++;
-
-	/*
-	 * Update the global lock handle and check for wraparound. The handle is
-	 * only used for the external global lock interfaces, but it is updated
-	 * here to properly handle the case where a single thread may acquire the
-	 * lock via both the AML and the acpi_acquire_global_lock interfaces. The
-	 * handle is therefore updated on the first acquire from a given thread
-	 * regardless of where the acquisition request originated.
-	 */
-	acpi_gbl_global_lock_handle++;
-	if (acpi_gbl_global_lock_handle == 0) {
-		acpi_gbl_global_lock_handle = 1;
-	}
-
-	/*
-	 * Make sure that a global lock actually exists. If not, just
-	 * treat the lock as a standard mutex.
-	 */
-	if (!acpi_gbl_global_lock_present) {
-		acpi_gbl_global_lock_acquired = TRUE;
-		return_ACPI_STATUS(AE_OK);
-	}
-
-	flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
-
-	do {
-
-		/* Attempt to acquire the actual hardware lock */
-
-		ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
-		if (acquired) {
-			acpi_gbl_global_lock_acquired = TRUE;
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-					  "Acquired hardware Global Lock\n"));
-			break;
-		}
-
-		/*
-		 * Did not get the lock. The pending bit was set above, and
-		 * we must now wait until we receive the global lock
-		 * released interrupt.
-		 */
-		acpi_gbl_global_lock_pending = TRUE;
-		acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
-
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Waiting for hardware Global Lock\n"));
-
-		/*
-		 * Wait for handshake with the global lock interrupt handler.
-		 * This interface releases the interpreter if we must wait.
-		 */
-		status =
-		    acpi_ex_system_wait_semaphore
-		    (acpi_gbl_global_lock_semaphore, ACPI_WAIT_FOREVER);
-
-		flags = acpi_os_acquire_lock(acpi_gbl_global_lock_pending_lock);
-
-	} while (ACPI_SUCCESS(status));
-
-	acpi_gbl_global_lock_pending = FALSE;
-	acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
-
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ev_release_global_lock
- *
- * PARAMETERS:  None
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Releases ownership of the Global Lock.
- *
- ******************************************************************************/
-
-acpi_status acpi_ev_release_global_lock(void)
-{
-	u8 pending = FALSE;
-	acpi_status status = AE_OK;
-
-	ACPI_FUNCTION_TRACE(ev_release_global_lock);
-
-	/* Lock must be already acquired */
-
-	if (!acpi_gbl_global_lock_acquired) {
-		ACPI_WARNING((AE_INFO,
-			      "Cannot release the ACPI Global Lock, it has not been acquired"));
-		return_ACPI_STATUS(AE_NOT_ACQUIRED);
-	}
-
-	acpi_ev_global_lock_acquired--;
-	if (acpi_ev_global_lock_acquired > 0) {
-		return AE_OK;
-	}
-
-	if (acpi_gbl_global_lock_present) {
-
-		/* Allow any thread to release the lock */
-
-		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
-
-		/*
-		 * If the pending bit was set, we must write GBL_RLS to the control
-		 * register
-		 */
-		if (pending) {
-			status =
-			    acpi_write_bit_register
-			    (ACPI_BITREG_GLOBAL_LOCK_RELEASE,
-			     ACPI_ENABLE_EVENT);
-		}
-
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Released hardware Global Lock\n"));
-	}
-
-	acpi_gbl_global_lock_acquired = FALSE;
-
-	/* Release the local GL mutex */
-	acpi_ev_global_lock_thread_id = 0;
-	acpi_ev_global_lock_acquired = 0;
-	acpi_os_release_mutex(acpi_gbl_global_lock_mutex->mutex.os_mutex);
-	return_ACPI_STATUS(status);
-}
-
 /******************************************************************************
  *
  * FUNCTION:    acpi_ev_terminate

>From 7ee434325a84a262910780292dfef01617a6dbf9 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 13 Apr 2011 13:15:58 +0800
Subject: [PATCH 2/6] ACPICA: Add more methods eligible for NULL package element removal

This change adds another group of predefined names to the list
of names eligible to have NULL package elements dynamically
removed. This group is the names that return a single
variable-length package containing simple data types such
as integers, buffers, strings. This includes: _ALx,_BCL,_CID,
_DOD,_EDL,_FIX,_PCL,_PLD,_PMD,_PRx,_PSL,_Sx, and _TZD.

http://www.acpica.org/bugzilla/show_bug.cgi?id=914

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 1d76ac8..ac7b854 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -74,7 +74,6 @@ ACPI_MODULE_NAME("nsrepair")
  *
  * Additional possible repairs:
  *
- * Optional/unnecessary NULL package elements removed
  * Required package elements that are NULL replaced by Integer/String/Buffer
  * Incorrect standalone package wrapped with required outer package
  *
@@ -623,16 +622,12 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
 	ACPI_FUNCTION_NAME(ns_remove_null_elements);
 
 	/*
-	 * PTYPE1 packages contain no subpackages.
-	 * PTYPE2 packages contain a variable number of sub-packages. We can
-	 * safely remove all NULL elements from the PTYPE2 packages.
+	 * We can safely remove all NULL elements from these package types:
+	 * PTYPE1_VAR packages contain a variable number of simple data types.
+	 * PTYPE2 packages contain a variable number of sub-packages.
 	 */
 	switch (package_type) {
-	case ACPI_PTYPE1_FIXED:
 	case ACPI_PTYPE1_VAR:
-	case ACPI_PTYPE1_OPTION:
-		return;
-
 	case ACPI_PTYPE2:
 	case ACPI_PTYPE2_COUNT:
 	case ACPI_PTYPE2_PKG_COUNT:
@@ -642,6 +637,8 @@ acpi_ns_remove_null_elements(struct acpi_predefined_data *data,
 		break;
 
 	default:
+	case ACPI_PTYPE1_FIXED:
+	case ACPI_PTYPE1_OPTION:
 		return;
 	}
 

>From f7e204fbaacb0a2b4f913e80edeeeb14a37ffcf1 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 13 Apr 2011 13:19:35 +0800
Subject: [PATCH 3/6] ACPICA: Update internal address SpaceID for DataTable regions

Moved this internal space id in preparation for ACPI 5.0 changes
that will include some new space IDs.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acconfig.h |    2 +-
 drivers/acpi/acpica/amlcode.h  |   15 ---------------
 drivers/acpi/acpica/dswload.c  |    2 +-
 drivers/acpi/acpica/dswload2.c |    2 +-
 drivers/acpi/acpica/excreate.c |    3 ++-
 drivers/acpi/acpica/utdecode.c |    5 +++--
 include/acpi/actypes.h         |   13 +++++++++++--
 7 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index ab87396..c115bb9 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -187,7 +187,7 @@
 
 /* Operation regions */
 
-#define ACPI_NUM_PREDEFINED_REGIONS     9
+#define ACPI_NUM_PREDEFINED_REGIONS     8
 #define ACPI_USER_REGION_BEGIN          0x80
 
 /* Maximum space_ids for Operation Regions */
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index f4f0998..1077f17 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -394,21 +394,6 @@
 #define AML_CLASS_METHOD_CALL       0x09
 #define AML_CLASS_UNKNOWN           0x0A
 
-/* Predefined Operation Region space_iDs */
-
-typedef enum {
-	REGION_MEMORY = 0,
-	REGION_IO,
-	REGION_PCI_CONFIG,
-	REGION_EC,
-	REGION_SMBUS,
-	REGION_CMOS,
-	REGION_PCI_BAR,
-	REGION_IPMI,
-	REGION_DATA_TABLE,	/* Internal use only */
-	REGION_FIXED_HW = 0x7F
-} AML_REGION_TYPES;
-
 /* Comparison operation codes for match_op operator */
 
 typedef enum {
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 23a3b1a..324acec 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -450,7 +450,7 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 			status =
 			    acpi_ex_create_region(op->named.data,
 						  op->named.length,
-						  REGION_DATA_TABLE,
+						  ACPI_ADR_SPACE_DATA_TABLE,
 						  walk_state);
 			if (ACPI_FAILURE(status)) {
 				return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 4be4e92..9763181 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -562,7 +562,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 				    ((op->common.value.arg)->common.value.
 				     integer);
 			} else {
-				region_space = REGION_DATA_TABLE;
+				region_space = ACPI_ADR_SPACE_DATA_TABLE;
 			}
 
 			/*
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index e7b372d..110711a 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -305,7 +305,8 @@ acpi_ex_create_region(u8 * aml_start,
 	 * range
 	 */
 	if ((region_space >= ACPI_NUM_PREDEFINED_REGIONS) &&
-	    (region_space < ACPI_USER_REGION_BEGIN)) {
+	    (region_space < ACPI_USER_REGION_BEGIN) &&
+	    (region_space != ACPI_ADR_SPACE_DATA_TABLE)) {
 		ACPI_ERROR((AE_INFO, "Invalid AddressSpace type 0x%X",
 			    region_space));
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 136a814..97cb36f 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -170,8 +170,7 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"SMBus",
 	"SystemCMOS",
 	"PCIBARTarget",
-	"IPMI",
-	"DataTable"
+	"IPMI"
 };
 
 char *acpi_ut_get_region_name(u8 space_id)
@@ -179,6 +178,8 @@ char *acpi_ut_get_region_name(u8 space_id)
 
 	if (space_id >= ACPI_USER_REGION_BEGIN) {
 		return ("UserDefinedRegion");
+	} else if (space_id == ACPI_ADR_SPACE_DATA_TABLE) {
+		return ("DataTable");
 	} else if (space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
 		return ("FunctionalFixedHW");
 	} else if (space_id >= ACPI_NUM_PREDEFINED_REGIONS) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 64f838b..ad77c61 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -712,8 +712,17 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_CMOS             (acpi_adr_space_type) 5
 #define ACPI_ADR_SPACE_PCI_BAR_TARGET   (acpi_adr_space_type) 6
 #define ACPI_ADR_SPACE_IPMI             (acpi_adr_space_type) 7
-#define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 8
-#define ACPI_ADR_SPACE_FIXED_HARDWARE   (acpi_adr_space_type) 127
+
+/*
+ * Special region types
+ *
+ * Note: A Data Table region is a special type of operation region
+ * that has its own AML opcode. However, internally, the AML
+ * interpreter simply creates an operation region with an an address
+ * space type of ACPI_ADR_SPACE_DATA_TABLE.
+ */
+#define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 0x7E	/* Internal to ACPICA only */
+#define ACPI_ADR_SPACE_FIXED_HARDWARE   (acpi_adr_space_type) 0x7F
 
 /*
  * bit_register IDs

>From f6152269c625640891c5060bd0fa935dacb688b8 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 13 Apr 2011 13:20:49 +0800
Subject: [PATCH 4/6] ACPICA: Move ACPI_NUM_PREDEFINED_REGIONS to a more appropriate place

Moved to where the predefined regions are actually defined.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acconfig.h |    1 -
 include/acpi/actypes.h         |    4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index c115bb9..bc533dd 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -187,7 +187,6 @@
 
 /* Operation regions */
 
-#define ACPI_NUM_PREDEFINED_REGIONS     8
 #define ACPI_USER_REGION_BEGIN          0x80
 
 /* Maximum space_ids for Operation Regions */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ad77c61..f3b29fa 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -713,8 +713,10 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_PCI_BAR_TARGET   (acpi_adr_space_type) 6
 #define ACPI_ADR_SPACE_IPMI             (acpi_adr_space_type) 7
 
+#define ACPI_NUM_PREDEFINED_REGIONS     8
+
 /*
- * Special region types
+ * Special Address Spaces
  *
  * Note: A Data Table region is a special type of operation region
  * that has its own AML opcode. However, internally, the AML

>From fca77dafeb7c484628a8c9f427ea9d225fd3070d Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 13 Apr 2011 13:22:04 +0800
Subject: [PATCH 5/6] ACPICA: Execute an orphan _REG method under the EC device

This change will force the execution of a _REG method underneath
the EC device even if there is no corresponding operation region
of type EmbeddedControl. Fixes a problem seen on some machines
and apparently is compatible with Windows behavior.

http://www.acpica.org/bugzilla/show_bug.cgi?id=875

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/evregion.c |  121 +++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/evrgnini.c |    2 +-
 drivers/acpi/acpica/evxfregn.c |   13 ++--
 include/acpi/actypes.h         |    5 ++
 4 files changed, 132 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index bea7223..f0edf5c 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -55,6 +55,8 @@ static u8
 acpi_ev_has_default_handler(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id);
 
+static void acpi_ev_orphan_ec_reg_method(void);
+
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -561,7 +563,9 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 
 			/* Now stop region accesses by executing the _REG method */
 
-			status = acpi_ev_execute_reg_method(region_obj, 0);
+			status =
+			    acpi_ev_execute_reg_method(region_obj,
+						       ACPI_REG_DISCONNECT);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"from region _REG, [%s]",
@@ -1062,6 +1066,12 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 					ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run,
 					NULL, &space_id, NULL);
 
+	/* Special case for EC: handle "orphan" _REG methods with no region */
+
+	if (space_id == ACPI_ADR_SPACE_EC) {
+		acpi_ev_orphan_ec_reg_method();
+	}
+
 	return_ACPI_STATUS(status);
 }
 
@@ -1120,6 +1130,113 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	status = acpi_ev_execute_reg_method(obj_desc, 1);
+	status = acpi_ev_execute_reg_method(obj_desc, ACPI_REG_CONNECT);
 	return (status);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_orphan_ec_reg_method
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Execute an "orphan" _REG method that appears under the EC
+ *              device. This is a _REG method that has no corresponding region
+ *              within the EC device scope. The orphan _REG method appears to
+ *              have been enabled by the description of the ECDT in the ACPI
+ *              specification: "The availability of the region space can be
+ *              detected by providing a _REG method object underneath the
+ *              Embedded Controller device."
+ *
+ *              To quickly access the EC device, we use the EC_ID that appears
+ *              within the ECDT. Otherwise, we would need to perform a time-
+ *              consuming namespace walk, executing _HID methods to find the
+ *              EC device.
+ *
+ ******************************************************************************/
+
+static void acpi_ev_orphan_ec_reg_method(void)
+{
+	struct acpi_table_ecdt *table;
+	acpi_status status;
+	struct acpi_object_list args;
+	union acpi_object objects[2];
+	struct acpi_namespace_node *ec_device_node;
+	struct acpi_namespace_node *reg_method;
+	struct acpi_namespace_node *next_node;
+
+	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
+
+	/* Get the ECDT (if present in system) */
+
+	status = acpi_get_table(ACPI_SIG_ECDT, 0,
+				ACPI_CAST_INDIRECT_PTR(struct acpi_table_header,
+						       &table));
+	if (ACPI_FAILURE(status)) {
+		return_VOID;
+	}
+
+	/* We need a valid EC_ID string */
+
+	if (!(*table->id)) {
+		return_VOID;
+	}
+
+	/* Namespace is currently locked, must release */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+	/* Get a handle to the EC device referenced in the ECDT */
+
+	status = acpi_get_handle(NULL,
+				 ACPI_CAST_PTR(char, table->id),
+				 ACPI_CAST_PTR(acpi_handle, &ec_device_node));
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Get a handle to a _REG method immediately under the EC device */
+
+	status = acpi_get_handle(ec_device_node,
+				 METHOD_NAME__REG, ACPI_CAST_PTR(acpi_handle,
+								 &reg_method));
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/*
+	 * Execute the _REG method only if there is no Operation Region in
+	 * this scope with the Embedded Controller space ID. Otherwise, it
+	 * will already have been executed. Note, this allows for Regions
+	 * with other space IDs to be present; but the code below will then
+	 * execute the _REG method with the EC space ID argument.
+	 */
+	next_node = acpi_ns_get_next_node(ec_device_node, NULL);
+	while (next_node) {
+		if ((next_node->type == ACPI_TYPE_REGION) &&
+		    (next_node->object) &&
+		    (next_node->object->region.space_id == ACPI_ADR_SPACE_EC)) {
+			goto exit;	/* Do not execute _REG */
+		}
+		next_node = acpi_ns_get_next_node(ec_device_node, next_node);
+	}
+
+	/* Evaluate the _REG(EC,Connect) method */
+
+	args.count = 2;
+	args.pointer = objects;
+	objects[0].type = ACPI_TYPE_INTEGER;
+	objects[0].integer.value = ACPI_ADR_SPACE_EC;
+	objects[1].type = ACPI_TYPE_INTEGER;
+	objects[1].integer.value = ACPI_REG_CONNECT;
+
+	status = acpi_evaluate_object(reg_method, NULL, &args, NULL);
+
+      exit:
+	/* We ignore all errors from above, don't care */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	return_VOID;
+}
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 9659cee..55a5d35 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -637,7 +637,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 
 					status =
 					    acpi_ev_execute_reg_method
-					    (region_obj, 1);
+					    (region_obj, ACPI_REG_CONNECT);
 
 					if (acpi_ns_locked) {
 						status =
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index c85c8c4..00cd956 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -130,20 +130,21 @@ acpi_install_address_space_handler(acpi_handle device,
 	case ACPI_ADR_SPACE_PCI_CONFIG:
 	case ACPI_ADR_SPACE_DATA_TABLE:
 
-		if (acpi_gbl_reg_methods_executed) {
+		if (!acpi_gbl_reg_methods_executed) {
 
-			/* Run all _REG methods for this address space */
-
-			status = acpi_ev_execute_reg_methods(node, space_id);
+			/* We will defer execution of the _REG methods for this space */
+			goto unlock_and_exit;
 		}
 		break;
 
 	default:
-
-		status = acpi_ev_execute_reg_methods(node, space_id);
 		break;
 	}
 
+	/* Run all _REG methods for this address space */
+
+	status = acpi_ev_execute_reg_methods(node, space_id);
+
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f3b29fa..a6412b8 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -726,6 +726,11 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 0x7E	/* Internal to ACPICA only */
 #define ACPI_ADR_SPACE_FIXED_HARDWARE   (acpi_adr_space_type) 0x7F
 
+/* Values for _REG connection code */
+
+#define ACPI_REG_DISCONNECT             0
+#define ACPI_REG_CONNECT                1
+
 /*
  * bit_register IDs
  *

>From de0023085b126b337b0849949b8b0663906dc65f Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 15 Apr 2011 09:12:47 +0800
Subject: [PATCH 6/6] ACPICA: Update to version 20110413

Version 20110413

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f6ad63d..2ed0a84 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20110316
+#define ACPI_CA_VERSION                 0x20110413
 
 #include "actypes.h"
 #include "actbl.h"


--=-4KDWNHMESMIeEGSdGgy8--

