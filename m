From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Event loop: DSDT or ACPI bug?
Date: Wed, 05 Nov 2003 14:12:45 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067994765.1765.41.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all.

If I generate a lid event during suspend I end up with keventd sucking
CPU post-resume (2.4 kernel). If set a breakpoint at
acpi_os_queue_for_execution, I see:

while(1) {
	trace 1 (below)
	trace 2
	trace 3
	trace 2
}

I'm not sure whether this is because some aspect of the hardware state
doesn't match the kernel or if there's a bug in my DSDT or in ACPI, and
I wonder if it's related to some of the other event problems people have
been reporting. If there are things I can do to generate more useful
info, feel free to ask.

(If I add a line in acpi_os_queue_for_execution, making it not queue
events when suspending, I don't get the loop, but neither do I get any
further acpi events.)

Regards,

Nigel

traces (hand recorded, excuse typos please. I left out arguments but can
send them too if desired):

1.
acpi_os_queue_for_execution
acpi_ev_gpedispatch
acpi_ev_gpe_detect
acpi_ev_sci_xrupt_handler
handle_IRQ_event
do_IRQ
call_do_IRQ
acpi_ev_address_space_dispatch
acpi_ex_access_region
acpi_ex_field_datum_io
acpi_ex_write_with_update_rule
acpi_ex_insert_into_field
acpi_ex_write_data_to_field
acpi_ex_store_object_to_node
acpi_ex_store
acpi_ex_opcode_1A_1T_1R
acpi_ps_parse_loop
acpi_ps_parse_aml
acpi_psx_execute
acpi_ns_execute_control_method
acpi_ns_evaluate_by_handle
acpi_ev_asynch_execute_gpe_method
acpi_os_execute_deferred
__run_task_queue
context_thread
arch_kernel_thread

2.
acpi_os_queue_for_execution
acpi_ev_queue_notify_request
acpi_ex_opcode_2A_0T_0R
acpi_ps_parse_loop
acpi_ps_parse_aml
acpi_psx_execute
acpi_ns_execute_control_method
acpi_ns_evaluate_by_handle
acpi_ev_asynch_execute_gpe_method
acpi_os_execute_deferred
__run_task_queue
context_thread
arch_kernel_thread

3.
acpi_os_queue_for_execution
acpi_ev_gpedispatch
acpi_ev_gpe_detect
acpi_ev_sci_xrupt_handler
handle_IRQ_event
do_IRQ
call_do_IRQ
acpi_os_execute_deferred
__run_task_queue
context_thread
arch_kernel_thread

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
