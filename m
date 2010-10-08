From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Do not hang at mutex forever if BIOS tries to
 release global lock
Date: Fri, 8 Oct 2010 07:54:13 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858BB85F060@orsmsx503.amr.corp.intel.com>
References: <201010081240.15203.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5007 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758316Ab0JHOyP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2010 10:54:15 -0400
In-Reply-To: <201010081240.15203.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: "devel@acpica.org" <devel@acpica.org>, "stuart_hayes@dell.com" <stuart_hayes@dell.com>, "Lin, Ming M" <ming.m.lin@intel.com>

We will take a look at this, and probably have a few more questions.

+	/* This must not happen: BIOS must only release the lock if OS has set
+	 * it pending. Such inconsistancies could happen if the global lock bits
+	 * survived through a kexec boot. */


We're going to need a non-OS-specific comment here.



>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Friday, October 08, 2010 3:40 AM
>To: Moore, Robert; ACPI Devel Maling List
>Cc: devel@acpica.org; stuart_hayes@dell.com
>Subject: [PATCH] ACPICA: Do not hang at mutex forever if BIOS tries to
>release global lock
>
>Hi,
>
>find the code against the Linux kernel pasted at the end
>of the mail for review.
>Find the code adjusted for ACPICA inclusion in the
>attachement.
>
>Bob: If you are ok with the patch, it would be great
>if you could push it. Be aware that I did not compile
>tested it in ACPICA environment.
>
>Thanks,
>
>       Thomas
>
>From: Stuart Hayes <stuart_hayes@dell.com>
>
>ACPICA: Do not hang at mutex forever if BIOS tries to release global lock
>
>and OS did not request the lock (means the pending bit was not set).
>Which in fact is a BIOS/HW bug (compare with ACPI Spec 3.0b):
>
>5.2.10.1 Global Lock:
>..
>This signal only occurs when the other environment attempted to acquire
>ownership while the lock was owned.
>..
>or
>4.7.3.1.1 PM1 Status Registers
>GBL_STS:
>..
>This bit is set in response to the BIOS releasing control of the Global
>Lock
>and having seen the pending bit set.
>..
>
>There seem to be chipsets which can get this wrong (especially after a
>kexec
>boot on Linux).
>
>Also one could theoretically run into this if a new kernel got booted
>without
>proper reboot and BIOS re-initialization (like kexec) while:
>  1) The OS hold the global lock
>  2) The BIOS hold the global lock
>This patch would handle condition 1.
>
>To make sure condition 2. cannot happen, it should get stated in the ACPI
>spec
>that the global lock needs to be zeroed by BIOS everytime the OS tries to
>(re-)enable ACPI mode.
>
>Modifications by trenn:
>  - Add a message -> This should not happen and if it happens it should not
>    be ignored/handled silently
>  - Adjusted from Linux kernel to acpica sources
>
>
>Signed-off-by: Thomas Renninger <trenn@suse.de>
>
>diff -purN '--exclude=*orig' linux-2.6.36-
>rc6_orig/drivers/acpi/acpica/acglobal.h linux-2.6.36-
>rc6/drivers/acpi/acpica/acglobal.h
>--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/acglobal.h	2010-06-02
>09:16:14.000000000 -0500
>+++ linux-2.6.36-rc6/drivers/acpi/acpica/acglobal.h	2010-06-02
>09:24:44.000000000 -0500
>@@ -213,6 +213,7 @@ ACPI_EXTERN acpi_semaphore acpi_gbl_glob
> ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
> ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
> ACPI_EXTERN u8 acpi_gbl_global_lock_present;
>+ACPI_EXTERN u32 acpi_gbl_global_lock_pending;
>
> /*
>  * Spinlocks are used for interfaces that can be possibly called at
>diff -purN '--exclude=*orig' linux-2.6.36-
>rc6_orig/drivers/acpi/acpica/evmisc.c linux-2.6.36-
>rc6/drivers/acpi/acpica/evmisc.c
>--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/evmisc.c	2010-06-02
>09:16:11.000000000 -0500
>+++ linux-2.6.36-rc6/drivers/acpi/acpica/evmisc.c	2010-06-02
>09:24:45.000000000 -0500
>@@ -297,6 +297,17 @@ static u32 acpi_ev_global_lock_handler(v
> {
> 	u8 acquired = FALSE;
>
>+	/* This must not happen: BIOS must only release the lock if OS has
>set
>+	 * it pending. Such inconsistancies could happen if the global lock
>bits
>+	 * survived through a kexec boot. */
>+
>+	if (!acpi_gbl_global_lock_pending) {
>+		u8 pending;
>+		/* Clear lock bits. BIOS released lock and OS isn't waiting. */
>+		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
>+		return (ACPI_INTERRUPT_HANDLED);
>+	}
>+
> 	/*
> 	 * Attempt to get the lock.
> 	 *
>@@ -309,6 +320,7 @@ static u32 acpi_ev_global_lock_handler(v
> 		/* Got the lock, now wake all threads waiting for it */
>
> 		acpi_gbl_global_lock_acquired = TRUE;
>+		acpi_gbl_global_lock_pending--;
> 		/* Send a unit to the semaphore */
>
> 		if (ACPI_FAILURE
>@@ -479,6 +491,8 @@ acpi_status acpi_ev_acquire_global_lock(
>
> 		acpi_gbl_global_lock_acquired = TRUE;
> 		return_ACPI_STATUS(AE_OK);
>+	} else {
>+		acpi_gbl_global_lock_pending++;
> 	}
>
> 	/*
>diff -purN '--exclude=*orig' linux-2.6.36-
>rc6_orig/drivers/acpi/acpica/utglobal.c linux-2.6.36-
>rc6/drivers/acpi/acpica/utglobal.c
>--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/utglobal.c	2010-06-02
>09:16:14.000000000 -0500
>+++ linux-2.6.36-rc6/drivers/acpi/acpica/utglobal.c	2010-06-02
>09:24:45.000000000 -0500
>@@ -782,6 +782,7 @@ acpi_status acpi_ut_init_globals(void)
> 	acpi_gbl_global_lock_acquired = FALSE;
> 	acpi_gbl_global_lock_handle = 0;
> 	acpi_gbl_global_lock_present = FALSE;
>+	acpi_gbl_global_lock_pending = 0;
>
> 	/* Miscellaneous variables */
>
