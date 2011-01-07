From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / ACPICA: Fix global lock acquisition
Date: Fri, 7 Jan 2011 21:47:04 +0100
Message-ID: <201101072147.04391.rjw@sisk.pl>
References: <201012281105.39478.rjw@sisk.pl> <4911F71203A09E4D9981D27F9D830858BFD9B10E@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40429 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab1AGUri (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jan 2011 15:47:38 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858BFD9B10E@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Thomas Renninger <trenn@suse.de>

On Friday, January 07, 2011, Moore, Robert wrote:
> Hi Rafael,
> 
> We are integrating this change into ACPICA. So far, looks good, I like the
> solution.  I will send you the integrated functions when I'm finished, for
> your review.

OK, thanks a lot!

> As always, it is a little tricky because of various Linux<->ACPICA divergences.

Understood.

Rafael

 
> >-----Original Message-----
> >From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> >Sent: Tuesday, December 28, 2010 2:06 AM
> >To: ACPI Devel Maling List
> >Cc: Len Brown; Lin, Ming M; Moore, Robert; Thomas Renninger
> >Subject: [PATCH] ACPI / ACPICA: Fix global lock acquisition
> >
> >From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> >There are two problems with the ACPICA's current implementation of
> >the global lock acquisition.  First, acpi_ev_global_lock_handler(),
> >which in fact is an interface to the outside of the kernel, doesn't
> >validate its input, so it only works correctly if the other side
> >(i.e. the ACPI firmware) is fully specification-compliant (as far
> >as the global lock is concerned).  Unfortunately, that's known not
> >to be the case on some systems (i.e. we get spurious global lock
> >signaling interrupts without the pending flag set on some systems).
> >Second, acpi_ev_global_lock_handler() attempts to acquire the global
> >lock on behalf of a thread waiting for it without checking if there
> >actually is such a thread.  Both of these shortcomings need to be
> >addressed to prevent all possible race conditions from happening.
> >
> >Rework acpi_ev_global_lock_handler() so that it doesn't try to
> >acquire the global lock and make it signal the availability of the
> >global lock to the waiting thread instead.  Make sure that the
> >availability of the global lock can only be signaled when there
> >is a thread waiting for it and that it can't be signaled more than
> >once in a row (to keep acpi_gbl_global_lock_semaphore in balance).
> >
> >Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >---
> > drivers/acpi/acpica/evmisc.c |   94 +++++++++++++++++++++++++-------------
> >-----
> > 1 file changed, 55 insertions(+), 39 deletions(-)
> >
> >Index: linux-2.6/drivers/acpi/acpica/evmisc.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/acpica/evmisc.c
> >+++ linux-2.6/drivers/acpi/acpica/evmisc.c
> >@@ -284,41 +284,41 @@ static void ACPI_SYSTEM_XFACE acpi_ev_no
> >  * RETURN:      ACPI_INTERRUPT_HANDLED
> >  *
> >  * DESCRIPTION: Invoked directly from the SCI handler when a global lock
> >- *              release interrupt occurs. Attempt to acquire the global
> >lock,
> >- *              if successful, signal the thread waiting for the lock.
> >+ *              release interrupt occurs.  If there's a thread waiting for
> >+ *              the global lock, signal it.
> >  *
> >  * NOTE: Assumes that the semaphore can be signaled from interrupt level.
> >If
> >  * this is not possible for some reason, a separate thread will have to be
> >  * scheduled to do this.
> >  *
> >
> >***************************************************************************
> >***/
> >+static u8 acpi_ev_global_lock_pending;
> >+static spinlock_t _acpi_ev_global_lock_pending_lock;
> >+#define acpi_ev_global_lock_pending_lock
> >&_acpi_ev_global_lock_pending_lock
> >
> > static u32 acpi_ev_global_lock_handler(void *context)
> > {
> >-	u8 acquired = FALSE;
> >+	acpi_status status;
> >+	acpi_cpu_flags flags;
> >
> >-	/*
> >-	 * Attempt to get the lock.
> >-	 *
> >-	 * If we don't get it now, it will be marked pending and we will
> >-	 * take another interrupt when it becomes free.
> >-	 */
> >-	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
> >-	if (acquired) {
> >+	flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
> >
> >-		/* Got the lock, now wake all threads waiting for it */
> >+	if (!acpi_ev_global_lock_pending) {
> >+		goto out;
> >+	}
> >
> >-		acpi_gbl_global_lock_acquired = TRUE;
> >-		/* Send a unit to the semaphore */
> >+	/* Send a unit to the semaphore */
> >
> >-		if (ACPI_FAILURE
> >-		    (acpi_os_signal_semaphore
> >-		     (acpi_gbl_global_lock_semaphore, 1))) {
> >-			ACPI_ERROR((AE_INFO,
> >-				    "Could not signal Global Lock semaphore"));
> >-		}
> >+	status = acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
> >+	if (ACPI_FAILURE(status)) {
> >+		ACPI_ERROR((AE_INFO, "Could not signal Global Lock
> >semaphore"));
> > 	}
> >
> >+	acpi_ev_global_lock_pending = FALSE;
> >+
> >+ out:
> >+	acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
> >+
> > 	return (ACPI_INTERRUPT_HANDLED);
> > }
> >
> >@@ -415,6 +415,7 @@ static int acpi_ev_global_lock_acquired;
> >
> > acpi_status acpi_ev_acquire_global_lock(u16 timeout)
> > {
> >+	acpi_cpu_flags flags;
> > 	acpi_status status = AE_OK;
> > 	u8 acquired = FALSE;
> >
> >@@ -467,32 +468,47 @@ acpi_status acpi_ev_acquire_global_lock(
> > 		return_ACPI_STATUS(AE_OK);
> > 	}
> >
> >-	/* Attempt to acquire the actual hardware lock */
> >+	flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
> >+
> >+	do {
> >+
> >+		/* Attempt to acquire the actual hardware lock */
> >
> >-	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
> >-	if (acquired) {
> >+		ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
> >+		if (acquired) {
> >+			acpi_gbl_global_lock_acquired = TRUE;
> >
> >-		/* We got the lock */
> >+			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
> >+					  "Acquired hardware Global Lock\n"));
> >+			break;
> >+		}
> >+
> >+		acpi_ev_global_lock_pending = TRUE;
> >+
> >+		acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
> >
> >+		/*
> >+		 * Did not get the lock. The pending bit was set above, and we
> >+		 * must wait until we get the global lock released interrupt.
> >+		 */
> > 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
> >-				  "Acquired hardware Global Lock\n"));
> >+				  "Waiting for hardware Global Lock\n"));
> >
> >-		acpi_gbl_global_lock_acquired = TRUE;
> >-		return_ACPI_STATUS(AE_OK);
> >-	}
> >+		/*
> >+		 * Wait for handshake with the global lock interrupt handler.
> >+		 * This interface releases the interpreter if we must wait.
> >+		 */
> >+		status = acpi_ex_system_wait_semaphore(
> >+						acpi_gbl_global_lock_semaphore,
> >+						ACPI_WAIT_FOREVER);
> >
> >-	/*
> >-	 * Did not get the lock. The pending bit was set above, and we must
> >now
> >-	 * wait until we get the global lock released interrupt.
> >-	 */
> >-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Waiting for hardware Global
> >Lock\n"));
> >+		flags = acpi_os_acquire_lock(acpi_ev_global_lock_pending_lock);
> >
> >-	/*
> >-	 * Wait for handshake with the global lock interrupt handler.
> >-	 * This interface releases the interpreter if we must wait.
> >-	 */
> >-	status =
> >acpi_ex_system_wait_semaphore(acpi_gbl_global_lock_semaphore,
> >-					       ACPI_WAIT_FOREVER);
> >+	} while (ACPI_SUCCESS(status));
> >+
> >+	acpi_ev_global_lock_pending = FALSE;
> >+
> >+	acpi_os_release_lock(acpi_ev_global_lock_pending_lock, flags);
> >
> > 	return_ACPI_STATUS(status);
> > }
> 
> 

