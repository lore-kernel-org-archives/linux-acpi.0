From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: acpi_memhotplug driver is not working for me. Any ideas?
Date: Mon, 07 Nov 2005 13:44:04 -0800
Message-ID: <1131399845.6313.73.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,
  I have recently acquired an IBM x460 to work with.  The hardware is
completing it's hot add memory event just fine but the acpi code is
retuning errors. (I implemented some stub functions the acpi code
expects the arch to have)

My kernel is 2.6.14-get7 using x86_64...  

With acpi debugging off saw the 

" driver data not found"

with acpi debugging on I see

"acpi_bus-0072 [03] bus_get_device        : No context for object
[ffff810037e82df0]"

(in acpi_memhotplug.c)
I run  acpi_memory_get_device and fail the acpi_bus_get_device call. 

The last of the acpi function call trace output is 

Nov  7 13:24:57 elm3a153 kernel:  utalloc-0526 [09] ut_free_and_track     : ----Entry ffff81027a41d030
Nov  7 13:24:57 elm3a153 kernel:  utalloc-0686 [10] ut_remove_allocation  : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0794 [11] os_wait_semaphore     : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0863 [11] os_wait_semaphore     : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:      osl-0875 [11] os_signal_semaphore   : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0888 [11] os_signal_semaphore   : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:  utalloc-0723 [10] ut_remove_allocation  : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:  utalloc-0553 [09] ut_free_and_track     : ----Exit-
Nov  7 13:24:57 elm3a153 kernel: dswstate-0869 [08] ds_delete_walk_state  : ----Exit-
Nov  7 13:24:57 elm3a153 kernel:  utstate-0329 [08] ut_delete_generic_stat: ----Entry
Nov  7 13:24:57 elm3a153 kernel:  utstate-0332 [08] ut_delete_generic_stat: ----Exit-
Nov  7 13:24:57 elm3a153 kernel:  psparse-0643 [07] ps_parse_aml          : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:   pswalk-0067 [07] ps_delete_parse_tree  : ----Entry ffff810279a754e0
Nov  7 13:24:57 elm3a153 kernel:   pswalk-0096 [07] ps_delete_parse_tree  : ----Exit-
Nov  7 13:24:57 elm3a153 kernel:  psxface-0246 [06] ps_execute_pass       : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:  psxface-0155 [05] ps_execute_method     : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:  exutils-0126 [05] ex_exit_interpreter   : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0875 [06] os_signal_semaphore   : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0888 [06] os_signal_semaphore   : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:  exutils-0133 [05] ex_exit_interpreter   : ----Exit-
Nov  7 13:24:57 elm3a153 kernel:   nseval-0414 [04] ns_execute_control_met: ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:   nseval-0338 [03] ns_evaluate_by_handle : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:    evgpe-0568 [02] ev_asynch_execute_gpe_: ----Exit-
Nov  7 13:24:57 elm3a153 kernel:      osl-0633 [01] os_execute_deferred   : ----Exit-
Nov  7 13:24:57 elm3a153 kernel:      osl-0621 [01] os_execute_deferred   : ----Entry
Nov  7 13:24:57 elm3a153 kernel: acpi_bus-0461 [02] bus_notify            : ----Entry
Nov  7 13:24:57 elm3a153 kernel: acpi_bus-0062 [03] bus_get_device        : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0794 [04] os_wait_semaphore     : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0863 [04] os_wait_semaphore     : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel:      osl-0875 [04] os_signal_semaphore   : ----Entry
Nov  7 13:24:57 elm3a153 kernel:      osl-0888 [04] os_signal_semaphore   : ----Exit- AE_OK
Nov  7 13:24:57 elm3a153 kernel: acpi_bus-0072 [03] bus_get_device        : No context for object [ffff810037e82df0]
Nov  7 13:24:57 elm3a153 kernel: acpi_bus-0073 [03] bus_get_device        : ----Exit- FFFFFFFFFFFFFFED
Nov  7 13:24:57 elm3a153 kernel: acpi_bus-0464 [02] bus_notify            : ----Exit-
Nov  7 13:24:57 elm3a153 kernel:  utstate-0329 [02] ut_delete_generic_stat: ----Entry
Nov  7 13:24:57 elm3a153 kernel:  utstate-0332 [02] ut_delete_generic_stat: ----Exit-
Nov  7 13:24:57 elm3a153 kernel:      osl-0633 [01] os_execute_deferred   : ----Exit-


This is known to work in other OS's.... 

I am not sure where to start looking.    

-- 
keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
