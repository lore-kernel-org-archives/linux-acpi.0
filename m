From: Lars Noschinski <CebeWee-Mmb7MZpHnFY@public.gmane.org>
Subject: Fwd: [ACPI-sppt] Kernel panic on IBM R40
Date: Sat, 28 Jun 2003 16:33:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <376282325.20030628163355@gmx.de>
References: <173266067.20030626161102@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <173266067.20030626161102-Mmb7MZpHnFY@public.gmane.org>
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

Maybe this list is more appropriate than acpi-support:

===8<==============Original message text===============
Hello!

I hope, this is the correct list for reporting this problem:
After upgrading the BIOS of my IBM R40 NB, booting 2.5.72 or 2.5.73
with ACPI enabled results in a Kernel panic. The original version booted
without problems, but I got no /proc/acpi, but battery, processor etc.
directly under /proc.
As the error message is too long, I can't provide the full error messages:
(I typed it from hand, so there may be typing errors)

---------
[...]
CPU:    0
EIP:    0060:[<c021fd1d0]    Not tainted
EFLAGS: 00010202
EIP is at acpi_ut_remove_allocation+0x93/0x12d
eax: 00000000   ebx: dfdb8898   ecx: 00000000   edx: 0073656d
esi: 00000000   edi: 00000000   dbp: c15ff8ec   esp: c15ff8d0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c15fe000 task=c151d880)
Stack: 00000001 c039c64b c039c5a9 00200000 dfdb8898 c15ff908 dfdb88c0 c15ff924
       c021ef56 00000000 dfdb8898 00000004 c0398f4f 00000131 00000001 c039c5f3
       c039c5a9 c0399dfa 00000000 00000000 c15bfba8 c15ff968 c0203c29 dfdb88c0
Call Trace:
 [<c021ef56>] acpi_ut_free_and_track+0x5f/0xd5
 [<c9293c28>] acpi_ev_address_space_dispatch+0x1e3/0x2b5
 [<c92986ea>] acpi_ex_access_region+0xc8/0x175
 [<c020980a>] acpi_ex_access_region+0xe8/0x175
 [<c0209b17>] acpi_ex_field_datum_io+0x245/0x274
 [<c0223150>] acpi_ut_allocate_object_desc_dbg+0x63/0x95
 [<c0209ebe>] acpi_ex_extract_from_field+0xf4/0x2e3
 [<c020dff7>] acpi_ex_acquire_gloal_lock+0x4e/0x8e
 [<c0207a21>] acpi_ex_read_data_from_field+0xdd/0x235
 [<c0207a33>] acpi_ex_read_data_from_field+0xef/0x235
 [<c020f722>] acpi_ex_resolve_node_to_value+0x242/0x2cc
 [<c02086f2>] acpi_ex_resolve_to_value+0x94/0xcd
 [<c929b5cv>] acpi_ex_resolve_operands+0xfa/0x687
 [<c92992f2>] acpi_ds_exec_end_op+0x35c/0x412
 [<c0216e9a>] acpi_ps_parse_loop+0x476+0xb77
 [<c021eb2e>] acpi_ut_acquire_from_cache+0x7d/0xe3
 [<c021f6a7>] acpi_ut_exit+0x1e/0x26
 [<c0202f67>] acpi_ds_push_walk_state+0x4a/0x52
 [<c021762a>] acpi_ps_parse_aml+0x8f/0x285
 [<c02177fe>] acpi_ps_parse_aml+0x263/0x285
 [<c0218386>] acpi_psx_execute+0x1b2/0x2b8
 [<c0213682>] acpi_ns_execute_control_method+0xb8/0xf5
 [<c021357e>] acpi_ns_evaluate_by_handle+0xce/0x11a
 [<c021332c>] acpi_ns_evaluate_relative+0x134/0x17d
 [<c021f6e3>] acpi_ut_status_exit+0x33/0x59
 [<c021f5fe>] acpi_ut_trace+0x29/0x2b
 [<c021271e>] acpi_evaluate_object+0x91/0x26a
 [<c021f5fe>] acpi_ut_trace+0x29/02b
 [<c021d9b4>] acpi_evaluate_integer+0x62/0x1a5
 [<c021f6a8>] acpi_ut_exit+0x1e/0x26
 [<c021f6e3>] acpi_ut_status_exit+0x33/0x59
 [<c021f5fe>] acpi_zt_trace+0x29/0x2b
 [<c0226f8d>] acpi_power_get_state+0x4b/0xc8
 [<c02279d8>] acpi_power_add+0x123/0x1d4
 [<c02285a0>] acpi_bus_driver_init+0x71/0x141
 [<c0228a49>] acpi_bus_find_driver+0xd6/0xe8
 [<c0228f44>] acpi_bus_add+0x14a/0x1de
 [<c02290da>] acpi_bus_scan+0x102/0x196
 [<c0482308>] acpi_scan_init+0xa3/0xbb
 [<c04725f9>] do_initcalls+0x2b/0x98
 [<c012b07e>] init_workqueues+0x12/0x2c
 [<c01050a3>] init+0x39/0x196
 [<c010507a>] init+0x0/0x196
 [<c0107291>] kernel_thread_helper+0x5/0xb
 
Code 89 42 04 8b 53 04 85 d2 74 04 8b 03 89 02 8b 73 08 8d 7b 28
 <0>Kernel panic: Attempted to kill init!
---------

Which additional informations can I provide?
 

-- 
CU Lars Noschinski



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
