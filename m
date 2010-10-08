From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPICA: Do not hang at mutex forever if BIOS tries to release global lock
Date: Fri, 8 Oct 2010 12:40:14 +0200
Message-ID: <201010081240.15203.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OUvrMvIP+mdTxqu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46516 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab0JHKkS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Oct 2010 06:40:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: devel@acpica.org, stuart_hayes@dell.com

--Boundary-00=_OUvrMvIP+mdTxqu
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

find the code against the Linux kernel pasted at the end
of the mail for review.
Find the code adjusted for ACPICA inclusion in the
attachement.

Bob: If you are ok with the patch, it would be great
if you could push it. Be aware that I did not compile
tested it in ACPICA environment.

Thanks,

       Thomas

From: Stuart Hayes <stuart_hayes@dell.com>

ACPICA: Do not hang at mutex forever if BIOS tries to release global lock

and OS did not request the lock (means the pending bit was not set).
Which in fact is a BIOS/HW bug (compare with ACPI Spec 3.0b):

5.2.10.1 Global Lock:
..
This signal only occurs when the other environment attempted to acquire
ownership while the lock was owned.
..
or
4.7.3.1.1 PM1 Status Registers
GBL_STS:
..
This bit is set in response to the BIOS releasing control of the Global Lock
and having seen the pending bit set.
..

There seem to be chipsets which can get this wrong (especially after a kexec
boot on Linux).

Also one could theoretically run into this if a new kernel got booted without
proper reboot and BIOS re-initialization (like kexec) while:
  1) The OS hold the global lock
  2) The BIOS hold the global lock
This patch would handle condition 1.

To make sure condition 2. cannot happen, it should get stated in the ACPI spec
that the global lock needs to be zeroed by BIOS everytime the OS tries to
(re-)enable ACPI mode.

Modifications by trenn:
  - Add a message -> This should not happen and if it happens it should not
    be ignored/handled silently
  - Adjusted from Linux kernel to acpica sources


Signed-off-by: Thomas Renninger <trenn@suse.de>

diff -purN '--exclude=*orig' linux-2.6.36-rc6_orig/drivers/acpi/acpica/acglobal.h linux-2.6.36-rc6/drivers/acpi/acpica/acglobal.h
--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/acglobal.h	2010-06-02 09:16:14.000000000 -0500
+++ linux-2.6.36-rc6/drivers/acpi/acpica/acglobal.h	2010-06-02 09:24:44.000000000 -0500
@@ -213,6 +213,7 @@ ACPI_EXTERN acpi_semaphore acpi_gbl_glob
 ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
 ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
 ACPI_EXTERN u8 acpi_gbl_global_lock_present;
+ACPI_EXTERN u32 acpi_gbl_global_lock_pending;
 
 /*
  * Spinlocks are used for interfaces that can be possibly called at
diff -purN '--exclude=*orig' linux-2.6.36-rc6_orig/drivers/acpi/acpica/evmisc.c linux-2.6.36-rc6/drivers/acpi/acpica/evmisc.c
--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/evmisc.c	2010-06-02 09:16:11.000000000 -0500
+++ linux-2.6.36-rc6/drivers/acpi/acpica/evmisc.c	2010-06-02 09:24:45.000000000 -0500
@@ -297,6 +297,17 @@ static u32 acpi_ev_global_lock_handler(v
 {
 	u8 acquired = FALSE;
 
+	/* This must not happen: BIOS must only release the lock if OS has set
+	 * it pending. Such inconsistancies could happen if the global lock bits
+	 * survived through a kexec boot. */
+
+	if (!acpi_gbl_global_lock_pending) {
+		u8 pending;
+		/* Clear lock bits. BIOS released lock and OS isn't waiting. */
+		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
+		return (ACPI_INTERRUPT_HANDLED);
+	}
+
 	/*
 	 * Attempt to get the lock.
 	 *
@@ -309,6 +320,7 @@ static u32 acpi_ev_global_lock_handler(v
 		/* Got the lock, now wake all threads waiting for it */
 
 		acpi_gbl_global_lock_acquired = TRUE;
+		acpi_gbl_global_lock_pending--;
 		/* Send a unit to the semaphore */
 
 		if (ACPI_FAILURE
@@ -479,6 +491,8 @@ acpi_status acpi_ev_acquire_global_lock(
 
 		acpi_gbl_global_lock_acquired = TRUE;
 		return_ACPI_STATUS(AE_OK);
+	} else {
+		acpi_gbl_global_lock_pending++;
 	}
 
 	/*
diff -purN '--exclude=*orig' linux-2.6.36-rc6_orig/drivers/acpi/acpica/utglobal.c linux-2.6.36-rc6/drivers/acpi/acpica/utglobal.c
--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/utglobal.c	2010-06-02 09:16:14.000000000 -0500
+++ linux-2.6.36-rc6/drivers/acpi/acpica/utglobal.c	2010-06-02 09:24:45.000000000 -0500
@@ -782,6 +782,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_global_lock_acquired = FALSE;
 	acpi_gbl_global_lock_handle = 0;
 	acpi_gbl_global_lock_present = FALSE;
+	acpi_gbl_global_lock_pending = 0;
 
 	/* Miscellaneous variables */
 

--Boundary-00=_OUvrMvIP+mdTxqu
Content-Type: text/x-patch;
  charset="UTF-8";
  name="acpi_global_lock_sanity_check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_global_lock_sanity_check.patch"

From: Stuart Hayes <stuart_hayes@dell.com>

ACPICA: Do not hang at mutex forever if BIOS tries to release global lock

and OS did not request the lock (means the pending bit was not set).
Which in fact is a BIOS/HW bug (compare with ACPI Spec 3.0b):

5.2.10.1 Global Lock:
..
This signal only occurs when the other environment attempted to acquire
ownership while the lock was owned.
..
or
4.7.3.1.1 PM1 Status Registers
GBL_STS:
..
This bit is set in response to the BIOS releasing control of the Global Lock
and having seen the pending bit set.
..

There seem to be chipsets which can get this wrong (especially after a kexec
boot on Linux).

Also one could theoretically run into this if a new kernel got booted without
proper reboot and BIOS re-initialization (like kexec) while:
  1) The OS hold the global lock
  2) The BIOS hold the global lock
This patch would handle condition 1.

To make sure condition 2. cannot happen, it should get stated in the ACPI spec
that the global lock needs to be zeroed by BIOS everytime the OS tries to
(re-)enable ACPI mode.

Modifications by trenn:
  - Add a message -> This should not happen and if it happens it should not
    be ignored/handled silently
  - Adjusted from Linux kernel to acpica sources


Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 source/components/events/evmisc.c      |   22 ++++++++++++++++++++--
 source/components/utilities/utglobal.c |    1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/source/components/events/evmisc.c b/source/components/events/evmisc.c
index b0e1cac..8c0f9b1 100644
--- a/source/components/events/evmisc.c
+++ b/source/components/events/evmisc.c
@@ -399,6 +399,23 @@ AcpiEvGlobalLockHandler (
 
 
     /*
+     * This must not happen: BIOS must only release the lock if OS has set
+     * it pending. Such inconsistancies could happen if another kernel is booted
+     * without a proper reboot and BIOS re-initialization and the global lock bits
+     * did not get cleared. But in general it's a BIOS bug if a gbl lock release
+     * GPE is triggered and OS has not tried to acquire the lock.
+     */
+    
+    if (!AcpiGbl_GlobalLockPending) {
+	u8 pending;
+	/* Clear lock bits. BIOS released lock and OS isn't waiting. */
+	ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending)
+            ACPI_WARNING ((AE_INFO, "Global lock release GPE, even OS did not try"
+			   "to acquire the lock"));
+	return (ACPI_INTERRUPT_HANDLED);
+    }
+
+    /*
      * Attempt to get the lock.
      *
      * If we don't get it now, it will be marked pending and we will
@@ -410,7 +427,7 @@ AcpiEvGlobalLockHandler (
         /* Got the lock, now wake the thread waiting for it */
 
         AcpiGbl_GlobalLockAcquired = TRUE;
-
+	AcpiGbl_GlobalLockPending--;
         /* Send a unit to the semaphore */
 
         Status = AcpiOsSignalSemaphore (AcpiGbl_GlobalLockSemaphore, 1);
@@ -579,7 +596,8 @@ AcpiEvAcquireGlobalLock (
 
         AcpiGbl_GlobalLockAcquired = TRUE;
         return_ACPI_STATUS (AE_OK);
-    }
+    } else
+	AcpiGbl_GlobalLockPending++;
 
     /*
      * Did not get the lock. The pending bit was set above, and we must now
diff --git a/source/components/utilities/utglobal.c b/source/components/utilities/utglobal.c
index a7e1baa..5f0f29f 100644
--- a/source/components/utilities/utglobal.c
+++ b/source/components/utilities/utglobal.c
@@ -916,6 +916,7 @@ AcpiUtInitGlobals (
     AcpiGbl_GlobalLockAcquired          = FALSE;
     AcpiGbl_GlobalLockHandle            = 0;
     AcpiGbl_GlobalLockPresent           = FALSE;
+    AcpiGbl_GlobalLockPending           = 0;
 
     /* Miscellaneous variables */
 

--Boundary-00=_OUvrMvIP+mdTxqu--
