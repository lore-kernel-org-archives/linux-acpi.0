From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: stack overflow
Date: 09 Mar 2004 23:33:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078893223.2346.585.camel@dhcppc4>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA4@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA4-novRXWwkcpil7xnNSM18fRtLTTO9Z+wMojBamW5iJbs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stuart_Hayes-DYMqY+WieiM@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-03-08 at 11:43, Stuart_Hayes-DYMqY+WieiM@public.gmane.org wrote:

> If I disable local interrupts while the ACPI stuff is being initialized, it 
> seems to make it through without failing.

hmmm, i wonder if the failure happens when ACPI is interrupted, or if
there is an issue with some ACPI code running in an interrupt?

re: the stack trace
I'm sure if Bob gets your DSDT he'll be able to address the recursion
issue at hand.

More interesting, perhaps, would be adding debugging code to
"gracefully" check for this failure.  There must be such DEBUG code
already built into the kernel someplace.

Sorting the list of stack frame sizes below shows
acpi_evaluate_integer() is the winner with 320 bytes on the stack.  Note
that this isn't from passing structures, but from allocating local
structures.  On i386 acpi_parse_object is 124 bytes, on x86_64 it will
be bigger...

 ./foo <stack.txt |sort -n
0 acpi_init
64 acpi_initialize_objects
64 ds_resolve_operands
64 ex_enter_interpreter
80 acpi_bus_init
80 ex_resolve_to_value
80 ex_resolve_to_value
80 ex_resolve_to_value
80 ns_execute_control_method
80 ns_execute_control_method
80 ns_execute_control_method
80 ns_initialize_devices
80 os_wait_semaphore
80 ps_parse_aml
80 ps_parse_aml
80 ps_parse_aml
96 ds_exec_end_op
96 ds_exec_end_op
96 ds_exec_end_op
96 ex_resolve_node_to_value
96 ex_resolve_node_to_value
96 ex_resolve_node_to_value
96 ns_init_one_device
96 ut_acquire_mutex
96 ut_evaluate_numeric_object
96 ut_execute_STA
112 ex_access_region
112 ex_access_region
112 ex_access_region
112 ns_evaluate_by_handle
112 ns_evaluate_by_handle
112 ns_evaluate_by_handle
112 psx_execute
112 psx_execute
112 psx_execute
112 ut_evaluate_object
112 ut_evaluate_object
128 acpi_evaluate_object
128 ev_address_space_dispatch
128 ev_address_space_dispatch
128 ev_address_space_dispatch
128 ev_pci_config_region_setup
128 ev_pci_config_region_setup
128 ex_extract_from_field
128 ex_extract_from_field
128 ex_extract_from_field
128 ex_field_datum_io
128 ex_field_datum_io
128 ex_field_datum_io
128 ex_resolve_operands
128 ex_resolve_operands
144 ex_read_data_from_field
144 ex_read_data_from_field
144 ex_read_data_from_field
144 ns_walk_namespace
208 ns_evaluate_relative
208 ns_evaluate_relative
208 ns_evaluate_relative
272 ps_parse_loop
272 ps_parse_loop
272 ps_parse_loop
320 acpi_evaluate_integer

#include <stdio.h>
#include <stdlib.h>

main()
{
        char name[512];
        unsigned long long number;
        unsigned long long previous = 0;

        while (EOF != scanf("%s %llx", &name, &number))
        {
                unsigned long long delta;
                if (previous == 0) previous = number;

                delta = previous - number;
                printf("%lld %s\n", delta, name);
        }
}




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
