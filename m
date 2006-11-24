From: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/65] ACPICA: Release global lock from interrupt handler
Date: Fri, 24 Nov 2006 02:18:15 -0500
Message-ID: <11643527604195-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50244 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757608AbWKXHPW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:22 -0500
In-Reply-To: <11643527591227-git-send-email-len.brown@intel.com>
Message-Id: <66534596d22c36a673afc16e8842de3e5d1b99c5.1164352287.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

The ACPI Global Lock interrupt handler no longer
queues the execution of a separate thread to signal the
global lock semaphore. Instead, the semaphore is signaled
directly from the interrupt handler.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c |   51 +++++++++++++----------------------------
 1 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 60c7fbd..66cd71b 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -67,8 +67,6 @@ static const char *acpi_notify_value_nam
 
 static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context);
 
-static void ACPI_SYSTEM_XFACE acpi_ev_global_lock_thread(void *context);
-
 static u32 acpi_ev_global_lock_handler(void *context);
 
 /*******************************************************************************
@@ -282,43 +280,19 @@ static void ACPI_SYSTEM_XFACE acpi_ev_no
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_global_lock_thread
- *
- * PARAMETERS:  Context         - From thread interface, not used
- *
- * RETURN:      None
- *
- * DESCRIPTION: Invoked by SCI interrupt handler upon acquisition of the
- *              Global Lock.  Simply signal all threads that are waiting
- *              for the lock.
- *
- ******************************************************************************/
-
-static void ACPI_SYSTEM_XFACE acpi_ev_global_lock_thread(void *context)
-{
-	acpi_status status;
-
-	/* Signal the thread that is waiting for the lock */
-
-	/* Send a unit to the semaphore */
-
-	status = acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
-	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Could not signal Global Lock semaphore"));
-	}
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ev_global_lock_handler
  *
  * PARAMETERS:  Context         - From thread interface, not used
  *
- * RETURN:      ACPI_INTERRUPT_HANDLED or ACPI_INTERRUPT_NOT_HANDLED
+ * RETURN:      ACPI_INTERRUPT_HANDLED
  *
  * DESCRIPTION: Invoked directly from the SCI handler when a global lock
- *              release interrupt occurs.  Grab the global lock and queue
- *              the global lock thread for execution
+ *              release interrupt occurs. Attempt to acquire the global lock,
+ *              if successful, signal the thread waiting for the lock.
+ *
+ * NOTE: Assumes that the semaphore can be signaled from interrupt level. If
+ * this is not possible for some reason, a separate thread will have to be
+ * scheduled to do this.
  *
  ******************************************************************************/
 
@@ -339,7 +313,14 @@ static u32 acpi_ev_global_lock_handler(v
 		/* Got the lock, now wake all threads waiting for it */
 
 		acpi_gbl_global_lock_acquired = TRUE;
-		acpi_ev_global_lock_thread(context);
+		/* Send a unit to the semaphore */
+
+		status =
+		    acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
+		if (ACPI_FAILURE(status)) {
+			ACPI_ERROR((AE_INFO,
+				    "Could not signal Global Lock semaphore"));
+		}
 	}
 
 	return (ACPI_INTERRUPT_HANDLED);
@@ -481,7 +462,7 @@ acpi_status acpi_ev_release_global_lock(
 
 	ACPI_FUNCTION_TRACE(ev_release_global_lock);
 
-	/* Lock must be acquired */
+	/* Lock must be already acquired */
 
 	if (!acpi_gbl_global_lock_acquired) {
 		ACPI_WARNING((AE_INFO,
-- 
1.4.4.1
