From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/18] ACPICA: Split all internal Global Lock functions to new
 file - evglock
Date: Sun, 29 May 2011 05:44:02 -0400
Message-ID: <0f6896f195df014064014493c8287a8e2d18f938.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:43897 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab1E2JoY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:24 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY00CLXB1Y6U71@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:24 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

These functions were moved from evmisc.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/Makefile   |    2 +-
 drivers/acpi/acpica/acevents.h |   17 ++-
 drivers/acpi/acpica/evglock.c  |  335 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evmisc.c   |  309 ------------------------------------
 4 files changed, 347 insertions(+), 316 deletions(-)
 create mode 100644 drivers/acpi/acpica/evglock.c

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
-- 
1.7.5.3.367.ga9930.dirty

