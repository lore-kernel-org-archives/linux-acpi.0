From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [20030321] Failed to acquire semaphore
Date: Tue, 25 Mar 2003 23:01:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030325220154.GA19516@hell.org.pl>
References: <F760B14C9561B941B89469F59BA3A847E96D5B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96D5B-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Grover, Andrew:
> Hiya -- can you (or someone else experiencing the same problem - I know
> there are a few) stick a WARN_ON(1) where that error message is
> happening, and turn on CONFIG_KALLSYMS, so we can get a stack trace?

Sure, here it goes (WARN_ONs inserted before the coresponding functions):
#v+
Badness in acpi_os_wait_semaphore at drivers/acpi/osl.c:896
Call Trace:
 [<c01e6c8d>] acpi_os_wait_semaphore+0x10c/0x1de
 [<c020ae4a>] acpi_ut_acquire_mutex+0x94/0x18c
 [<c0209b9e>] acpi_ut_trace+0x28/0x2c
 [<c01ee2b2>] acpi_disable_gpe+0x31/0xa2
 [<c021190d>] acpi_ec_gpe_handler+0x15/0x27
 [<c01f030b>] acpi_ev_gpe_dispatch+0x19e/0x1df
 [<c01f0038>] acpi_ev_gpe_detect+0x174/0x17c
 [<c01edd43>] acpi_ev_sci_xrupt_handler+0x37/0x4d
 [<c01e6276>] acpi_irq+0xc/0xe
 [<c010a6aa>] handle_IRQ_event+0x38/0x5c
 [<c01e626a>] acpi_irq+0x0/0xe
 [<c010a81c>] do_IRQ+0x72/0xc8
 [<c0109148>] common_interrupt+0x18/0x20
 [<c01e63e3>] acpi_os_write_port+0x2d/0x47
 [<c01fab76>] acpi_hw_low_level_write+0xef/0xf9
 [<c020ae76>] acpi_ut_acquire_mutex+0xc0/0x18c
 [<c01f9c8b>] acpi_hw_enable_gpe+0x43/0x48
 [<c01ee14f>] acpi_enable_gpe+0x71/0xa7
 [<c0211895>] acpi_ec_gpe_query+0xbf/0x122
 [<c01e6763>] acpi_os_execute_deferred+0x39/0x75
 [<c0127907>] worker_thread+0x1a4/0x262
 [<c01e672a>] acpi_os_execute_deferred+0x0/0x75
 [<c0118364>] default_wake_function+0x0/0x12
 [<c0108eee>] ret_from_fork+0x6/0x14
 [<c0118364>] default_wake_function+0x0/0x12
 [<c0127763>] worker_thread+0x0/0x262
 [<c010720d>] kernel_thread_helper+0x5/0xb

     osl-0898 [24] os_wait_semaphore     : Failed to acquire semaphore[cffec740|1|0], AE_TIME
Badness in acpi_ut_acquire_mutex at drivers/acpi/utilities/utmisc.c:741
Call Trace:
 [<c020aeaa>] acpi_ut_acquire_mutex+0xf4/0x18c
 [<c0209b9e>] acpi_ut_trace+0x28/0x2c
 [<c01ee2b2>] acpi_disable_gpe+0x31/0xa2
 [<c021190d>] acpi_ec_gpe_handler+0x15/0x27
 [<c01f030b>] acpi_ev_gpe_dispatch+0x19e/0x1df
 [<c01f0038>] acpi_ev_gpe_detect+0x174/0x17c
 [<c01edd43>] acpi_ev_sci_xrupt_handler+0x37/0x4d
 [<c01e6276>] acpi_irq+0xc/0xe
 [<c010a6aa>] handle_IRQ_event+0x38/0x5c
 [<c01e626a>] acpi_irq+0x0/0xe
 [<c010a81c>] do_IRQ+0x72/0xc8
 [<c0109148>] common_interrupt+0x18/0x20
 [<c01e63e3>] acpi_os_write_port+0x2d/0x47
 [<c01fab76>] acpi_hw_low_level_write+0xef/0xf9
 [<c020ae76>] acpi_ut_acquire_mutex+0xc0/0x18c
 [<c01f9c8b>] acpi_hw_enable_gpe+0x43/0x48
 [<c01ee14f>] acpi_enable_gpe+0x71/0xa7
 [<c0211895>] acpi_ec_gpe_query+0xbf/0x122
 [<c01e6763>] acpi_os_execute_deferred+0x39/0x75
 [<c0127907>] worker_thread+0x1a4/0x262
 [<c01e672a>] acpi_os_execute_deferred+0x0/0x75
 [<c0118364>] default_wake_function+0x0/0x12
 [<c0108eee>] ret_from_fork+0x6/0x14
 [<c0118364>] default_wake_function+0x0/0x12
 [<c0127763>] worker_thread+0x0/0x262
 [<c010720d>] kernel_thread_helper+0x5/0xb

  utmisc-0744 [23] ut_acquire_mutex      : Thread 0 could not acquire Mutex [ACPI_MTX_Events] AE_TIME
#v-

As I said, it happens both on 2.4.21-pre5-acpi20030321, and 
2.5.65-acpi20030321. It doesn't neither on vanilla 2.5.65 (but there's the 
GPE bug), nor on acpi20021212. HTH.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
