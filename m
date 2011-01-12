From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/48] ACPI / ACPICA: Fix global lock acquisition
Date: Wed, 12 Jan 2011 05:19:13 -0500
Message-ID: <9cd031441a4fd09273b7c2beb337d0b2683d104c.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49319 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab1ALSAb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:31 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:31 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

There are two problems with the ACPICA's current implementation of
the global lock acquisition.  First, acpi_ev_global_lock_handler(),
which in fact is an interface to the outside of the kernel, doesn't
validate its input, so it only works correctly if the other side
(i.e. the ACPI firmware) is fully specification-compliant (as far
as the global lock is concerned).  Unfortunately, that's known not
to be the case on some systems (i.e. we get spurious global lock
signaling interrupts without the pending flag set on some systems).
Second, acpi_ev_global_lock_handler() attempts to acquire the global
lock on behalf of a thread waiting for it without checking if there
actually is such a thread.  Both of these shortcomings need to be
addressed to prevent all possible race conditions from happening.

Rework acpi_ev_global_lock_handler() so that it doesn't try to
acquire the global lock and make it signal the availability of the
global lock to the waiting thread instead.  Make sure that the
availability of the global lock can only be signaled when there
is a thread waiting for it and that it can't be signaled more than
once in a row (to keep acpi_gbl_global_lock_semaphore in balance).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evmisc.c |   94 ++++++++++++++++++++++++-----------------
 1 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index fcaed9f..8e31bb5 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -284,41 +284,41 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
  * RETURN:      ACPI_INTERRUPT_HANDLED
  *
  * DESCRIPTION: Invoked directly from the SCI handler when a global lock
- *              release interrupt occurs. Attempt to acquire the global lock,
- *              if successful, signal the thread waiting for the lock.
+ *              release interrupt occurs.  If there's a thread waiting for
+ *              the global lock, signal it.
  *
  * NOTE: Assumes that the semaphore can be signaled from interrupt level. If
  * this is not possible for some reason, a separate thread will have to be
  * scheduled to do this.
  *
  ******************************************************************************/
+static u8 acpi_ev_global_lock_pending;
+static spinlock_t _acpi_ev_global_lock_pending_lock;
+#define acpi_ev_global_lock_pending_lock &_acpi_ev_global_lock_pending_lock
 
 static u32 acpi_ev_global_lock_handler(void *context)
 {
-	u8 acquired = FALSE;
+	acpi_status status;
+	acpi_cpu_flags flags;
 
-	/*
-	 * Attempt to get the lock.
-	 *
-	 * If we don't get it now, it will be marked pending and we will
-	 * take another interrupt when it becomes free.
-	 */
-	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
-	if (acquired) {
+	flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
 
-		/* Got the lock, now wake all threads waiting for it */
+	if (!acpi_ev_global_lock_pending) {
+		goto out;
+	}
 
-		acpi_gbl_global_lock_acquired = TRUE;
-		/* Send a unit to the semaphore */
+	/* Send a unit to the semaphore */
 
-		if (ACPI_FAILURE
-		    (acpi_os_signal_semaphore
-		     (acpi_gbl_global_lock_semaphore, 1))) {
-			ACPI_ERROR((AE_INFO,
-				    "Could not signal Global Lock semaphore"));
-		}
+	status = acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
+	if (ACPI_FAILURE(status)) {
+		ACPI_ERROR((AE_INFO, "Could not signal Global Lock semaphore"));
 	}
 
+	acpi_ev_global_lock_pending = FALSE;
+
+ out:
+	acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
+
 	return (ACPI_INTERRUPT_HANDLED);
 }
 
@@ -415,6 +415,7 @@ static int acpi_ev_global_lock_acquired;
 
 acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 {
+	acpi_cpu_flags flags;
 	acpi_status status = AE_OK;
 	u8 acquired = FALSE;
 
@@ -467,32 +468,47 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* Attempt to acquire the actual hardware lock */
+	flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
+
+	do {
+
+		/* Attempt to acquire the actual hardware lock */
+
+		ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
+		if (acquired) {
+			acpi_gbl_global_lock_acquired = TRUE;
+
+			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+					  "Acquired hardware Global Lock\n"));
+			break;
+		}
 
-	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
-	if (acquired) {
+		acpi_ev_global_lock_pending = TRUE;
 
-		/* We got the lock */
+		acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
 
+		/*
+		 * Did not get the lock. The pending bit was set above, and we
+		 * must wait until we get the global lock released interrupt.
+		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Acquired hardware Global Lock\n"));
+				  "Waiting for hardware Global Lock\n"));
 
-		acpi_gbl_global_lock_acquired = TRUE;
-		return_ACPI_STATUS(AE_OK);
-	}
+		/*
+		 * Wait for handshake with the global lock interrupt handler.
+		 * This interface releases the interpreter if we must wait.
+		 */
+		status = acpi_ex_system_wait_semaphore(
+						acpi_gbl_global_lock_semaphore,
+						ACPI_WAIT_FOREVER);
 
-	/*
-	 * Did not get the lock. The pending bit was set above, and we must now
-	 * wait until we get the global lock released interrupt.
-	 */
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Waiting for hardware Global Lock\n"));
+		flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
 
-	/*
-	 * Wait for handshake with the global lock interrupt handler.
-	 * This interface releases the interpreter if we must wait.
-	 */
-	status = acpi_ex_system_wait_semaphore(acpi_gbl_global_lock_semaphore,
-					       ACPI_WAIT_FOREVER);
+	} while (ACPI_SUCCESS(status));
+
+	acpi_ev_global_lock_pending = FALSE;
+
+	acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
 
 	return_ACPI_STATUS(status);
 }
-- 
1.7.4.rc1.7.g2cf08

