From: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Subject: Re: [20030321] Failed to acquire semaphore
Date: Tue, 25 Mar 2003 16:52:38 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303252152.h2PLqcP25841@throb.netspace.org>
References: <F760B14C9561B941B89469F59BA3A847E96D5B@orsmsx401.jf.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Tue, 25 Mar 2003 13:13:16 PST."
             <F760B14C9561B941B89469F59BA3A847E96D5B-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Here's the stack trace from the error on bootup.
It's exaclty the same if I push a button, close a lid, chnage
brightness, etc.


Badness in acpi_os_wait_semaphore at drivers/acpi/osl.c:911
Call Trace:
 [<c0223a03>] acpi_os_wait_semaphore+0x125/0x20a
 [<c02470f4>] acpi_ut_acquire_mutex+0x92/0x164
 [<c022ad37>] acpi_disable_gpe+0x33/0x96
 [<c024cf63>] acpi_ec_gpe_handler+0x17/0x2a
 [<c022cc9d>] acpi_ev_gpe_dispatch+0x18f/0x1d0
 [<c022c9e6>] acpi_ev_gpe_detect+0x168/0x170
 [<c022a7e8>] acpi_ev_sci_xrupt_handler+0x38/0x50
 [<c0222f91>] acpi_irq+0xf/0x12
 [<c010b595>] handle_IRQ_event+0x37/0x5e
 [<c0222f82>] acpi_irq+0x0/0x12
 [<c010b7ff>] do_IRQ+0xc5/0x184
 [<c0109d9c>] common_interrupt+0x18/0x20
 [<c0223116>] acpi_os_write_port+0x2e/0x46
 [<c0237150>] acpi_hw_low_level_write+0xe6/0xee
 [<c0247120>] acpi_ut_acquire_mutex+0xbe/0x164
 [<c02362b5>] acpi_hw_enable_gpe+0x45/0x48
 [<c022abe3>] acpi_enable_gpe+0x6f/0x9c
 [<c024ced8>] acpi_ec_gpe_query+0xce/0x142
 [<c022346c>] acpi_os_execute_deferred+0x3a/0x6c
 [<c012f2cf>] worker_thread+0x1f9/0x2f4
 [<c0223432>] acpi_os_execute_deferred+0x0/0x6c
 [<c011b88a>] default_wake_function+0x0/0x12
 [<c0109306>] ret_from_fork+0x6/0x14
 [<c011b88a>] default_wake_function+0x0/0x12
 [<c012f0d6>] worker_thread+0x0/0x2f4
 [<c01072f1>] kernel_thread_helper+0x5/0xc

     osl-0913 [31] os_wait_semaphore     : Failed to acquire semaphore[cff62580|1|0], AE_TIME
  utmisc-0743 [30] ut_acquire_mutex      : Thread 0 could not acquire Mutex [ACPI_MTX_Events] AE_TIME


--
Pack my box with five dozen liquor jugs.
Brian Perkins                                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
