From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [20030321] Failed to acquire semaphore
Date: Sun, 23 Mar 2003 21:30:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030323203025.GA13039@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I recently managed to compile a (hopefully) stable 2.4.21-pre5 with latest
ACPI. Since this kernel required heavy loads of manual patching (the XFS
patch comes only for 2.4.20, swsusp-beta19 was for earlier ACPI, CPUfreq
doesn't get on well with the latter), and furthermore, I wasn't always sure
of what I was doing, I'm curious whether the error below is something
specific. I'm particularly interested in the following changes I made to
drivers/acpi/system.c. It was originally
#v+ (around line 340)
        /* disable interrupts and flush caches */
        ACPI_DISABLE_IRQS();
        ACPI_FLUSH_CPU_CACHE();

        /* perform OS-specific sleep actions */
        if(swsusp) { /* we just ignore acpi architecture for the moment */
                software_suspend_pending(); /* when we return, this is
resume */
                status = AE_OK;
        } else {
        status = acpi_system_suspend(state);

        /* Even if we failed to go to sleep, all of the devices are in an
 * suspended
         * mode. So, we run these unconditionaly to make sure we have a
         * usable system
         * no matter what.
         */
        acpi_leave_sleep_state(state);
        acpi_system_restore_state(state);

        /* make sure interrupts are enabled */
        ACPI_ENABLE_IRQS();
#v-

And what I changed was:
#v+
        if(swsusp) { /* we just ignore acpi architecture for the moment */
                software_suspend_pending(); /* when we return, this is
resume */
+                acpi_leave_sleep_state(state);
                status = AE_OK;
        } else {
        status = acpi_system_suspend(state);

        /* Even if we failed to go to sleep, all of the devices are in an
 * suspended
         * mode. So, we run these unconditionaly to make sure we have a
         * usable system
         * no matter what.
         */
        acpi_leave_sleep_state(state);
        acpi_system_restore_state(state);
+        }

        /* make sure interrupts are enabled */
#v-

Ad.1 swsusp-beta19 expects this, but since the patch is against a previous
version, and the code has changed, I had to do it that way. I don't know if
it's the right way...
Ad.2 The code won't compile without the bracket.

Well, the particular error I'm seeing at boot time is:
#v+
Mar 23 20:12:30 nadir kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
Mar 23 20:12:30 nadir kernel: schedule_task(): keventd has not started
Mar 23 20:12:30 nadir kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
Mar 23 20:12:30 nadir kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
Mar 23 20:12:30 nadir kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
Mar 23 20:12:30 nadir kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
Mar 23 20:12:30 nadir kernel: Initializing RT netlink socket
Mar 23 20:12:30 nadir kernel:      osl-0888 [24] os_wait_semaphore     : Failed to acquire semaphore[cfff74c0|1|0], AE_TIME
Mar 23 20:12:30 nadir kernel:   utmisc-0743 [23] ut_acquire_mutex      : Thread 0 could not acquire Mutex [ACPI_MTX_Events] AE_TIME
#v-

Occasionally (e.g. upon a notify or event), the two last lines reappear,
and ACPI events are not handled otherwise (i.e. acpid fails to notice
them). Furthermore, resuming from S1 floods the screen with the above
messages, but the system is working nonetheless. All the ACPI subsystem I
rely on (i.e. performance / cooling method switching, readings, etc.) seems
to be working fine besides that.
I'll be grateful for any help, TIA, best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
