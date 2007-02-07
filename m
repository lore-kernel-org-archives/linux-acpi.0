From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/140] ACPICA: Release global lock from interrupt handler
Date: Wed,  7 Feb 2007 13:51:00 -0500
Message-ID: <11708744353864-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:44007 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422773AbXBGSyD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:03 -0500
In-Reply-To: <1170874433382-git-send-email-lenb@kernel.org>
Message-Id: <a72d47563bce9542b9a83521a4e8175076278ee9.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The ACPI Global Lock interrupt handler no longer
queues the execution of a separate thread to signal the
global lock semaphore. Instead, the semaphore is signaled
directly from the interrupt handler.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c |   50 ++++++++++++-----------------------------
 1 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index f82b81c..00f33ed 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -67,8 +67,6 @@ static const char *acpi_notify_value_names[] = {
 
 static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context);
 
-static void ACPI_SYSTEM_XFACE acpi_ev_global_lock_thread(void *context);
-
 static u32 acpi_ev_global_lock_handler(void *context);
 
 /*******************************************************************************
@@ -282,43 +280,19 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 
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
 
@@ -338,7 +312,13 @@ static u32 acpi_ev_global_lock_handler(void *context)
 		/* Got the lock, now wake all threads waiting for it */
 
 		acpi_gbl_global_lock_acquired = TRUE;
-		acpi_ev_global_lock_thread(context);
+		/* Send a unit to the semaphore */
+
+		if (ACPI_FAILURE(acpi_os_signal_semaphore(
+			acpi_gbl_global_lock_semaphore, 1))) {
+			ACPI_ERROR((AE_INFO,
+				    "Could not signal Global Lock semaphore"));
+		}
 	}
 
 	return (ACPI_INTERRUPT_HANDLED);
@@ -480,7 +460,7 @@ acpi_status acpi_ev_release_global_lock(void)
 
 	ACPI_FUNCTION_TRACE(ev_release_global_lock);
 
-	/* Lock must be acquired */
+	/* Lock must be already acquired */
 
 	if (!acpi_gbl_global_lock_acquired) {
 		ACPI_WARNING((AE_INFO,
-- 
1.5.0.rc3.39.gec804
