From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: [OOPS] IBM ThinkPad R40 ...
Date: Tue, 9 Sep 2003 16:19:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309091619.42575.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
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


Hello!

2.4.22 kernel.

...
            Device (USB7)
            {
                Name (_ADR, 0x001D0007)
                Name (_S3D, 0x03)
                OperationRegion (U7CS, PCI_Config, 0x62, 0x02)
                Field (U7CS, DWordAcc, NoLock, Preserve)
==================^
                {
                    PWKI,   1,
                    PWUC,   6,
                    Offset (0x02)
                }

                Name (_PR0, Package (0x01)
...

OK, region size is 2, and it's long(size 4) access? OK, WRONG!

So it should be:

                Field (U7CS, ByteAcc, NoLock, Preserve)

BUT, after that:

ksymoops 2.4.9 on i686 2.4.20-20.9.  Options used
     -v /usr/src/linux-2.4.22/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.22-habi (specified)
     -m /boot/System.map-2.4.22-habi (specified)

No modules in ksyms, skipping objects
...
Unable to handle kernel paging request at virtual address 8b000005
c01aa85c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01aa85c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c6830c75   ebx: cfe6f6d8   ecx: 00000000   edx: 8b000001
esi: 00000000   edi: 00000000   ebp: c12fd884   esp: c12fd884
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c12fd000)
Stack: 00000001 c029db1b c029da79 c01ab642 cfe6f6d8 c12fd8bc cfe6f700 00000131
       c01aa5bd 00000000 cfe6f6d8 00000004 c029a614 00000131 00000001 c029dac3
       c029da79 c029b8b6 00000000 00000000 c12f4128 c12e1428 c018f959 cfe6f700
Call Trace:    [<c01ab642>] [<c01aa5bd>] [<c018f959>] [<c019464a>] [<c019466b>]
  [<c019498a>] [<c01ae432>] [<c0194d59>] [<c019a3bf>] [<c0193e81>] [<c0193e93>]
  [<c019f50f>] [<c01987e4>] [<c0198919>] [<c0198e95>] [<c018bd94>] [<c01a1ea9>]
  [<c01aa174>] [<c01ab6c3>] [<c018d597>] [<c01a25b9>] [<c01a2777>] [<c01a324d>]
  [<c019da9a>] [<c019d983>] [<c019d71c>] [<c01ab700>] [<c01a02eb>] [<c01ab782>]
  [<c0187b18>] [<c01abe3b>] [<c01ab700>] [<c01ab6c3>] [<c01ab700>] [<c01a0330>]
  [<c01b66da>] [<c01b7115>] [<c01afc2a>] [<c01b0006>] [<c01b06a2>] [<c01b0aa3>]
  [<c0105000>] [<c0105053>] [<c0105000>] [<c010577e>] [<c0105040>]
Code: 89 42 04 8b 53 04 85 d2 74 04 8b 03 89 02 8b 73 08 bd ea ea


>>EIP; c01aa85c <acpi_ut_remove_allocation+9b/13f>   <=====

Trace; c01ab642 <acpi_ut_trace_ptr+2c/30>
Trace; c01aa5bd <acpi_ut_free_and_track+69/ea>
Trace; c018f959 <acpi_ev_address_space_dispatch+1e2/2c9>
Trace; c019464a <acpi_ex_access_region+cd/17c>
Trace; c019466b <acpi_ex_access_region+ee/17c>
Trace; c019498a <acpi_ex_field_datum_io+257/287>
Trace; c01ae432 <acpi_ut_allocate_object_desc_dbg+61/9b>
Trace; c0194d59 <acpi_ex_extract_from_field+103/30e>
Trace; c019a3bf <acpi_ex_acquire_global_lock+4e/8a>
Trace; c0193e81 <acpi_ex_read_data_from_field+d1/224>
Trace; c0193e93 <acpi_ex_read_data_from_field+e3/224>
Trace; c019f50f <acpi_ns_get_type+47/86>
Trace; c01987e4 <acpi_ex_resolve_node_to_value+25c/2e8>
Trace; c0198919 <acpi_ex_resolve_to_value+a9/da>
Trace; c0198e95 <acpi_ex_resolve_operands+fc/6bf>
Trace; c018bd94 <acpi_ds_exec_end_op+36b/423>
Trace; c01a1ea9 <acpi_ps_parse_loop+41e/a9a>
Trace; c01aa174 <acpi_ut_acquire_from_cache+86/e4>
Trace; c01ab6c3 <acpi_ut_exit+1d/27>
Trace; c018d597 <acpi_ds_push_walk_state+4a/51>
Trace; c01a25b9 <acpi_ps_parse_aml+94/277>
Trace; c01a2777 <acpi_ps_parse_aml+252/277>
Trace; c01a324d <acpi_psx_execute+1b5/2d0>
Trace; c019da9a <acpi_ns_execute_control_method+bb/105>
Trace; c019d983 <acpi_ns_evaluate_by_handle+d4/130>
Trace; c019d71c <acpi_ns_evaluate_relative+154/1a0>
Trace; c01ab700 <acpi_ut_status_exit+33/55>
Trace; c01a02eb <acpi_evaluate_object+9e/29e>
Trace; c01ab782 <acpi_ut_ptr_exit+21/2b>
Trace; c0187b18 <acpi_evaluate_integer+72/1b0>
Trace; c01abe3b <acpi_ut_update_object_reference+c0/1b7>
Trace; c01ab700 <acpi_ut_status_exit+33/55>
Trace; c01ab6c3 <acpi_ut_exit+1d/27>
Trace; c01ab700 <acpi_ut_status_exit+33/55>
Trace; c01a0330 <acpi_evaluate_object+e3/29e>
Trace; c01b66da <acpi_power_get_state+4c/c2>
Trace; c01b7115 <acpi_power_add+10a/1a8>
Trace; c01afc2a <acpi_bus_driver_init+6f/134>
Trace; c01b0006 <acpi_bus_find_driver+ce/de>
Trace; c01b06a2 <acpi_bus_add+3cc/645>
Trace; c01b0aa3 <acpi_bus_scan+115/1ba>
Trace; c0105000 <_stext+0/0>
Trace; c0105053 <init+13/130>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <arch_kernel_thread+2e/40>
Trace; c0105040 <init+0/130>

Code;  c01aa85c <acpi_ut_remove_allocation+9b/13f>
00000000 <_EIP>:
Code;  c01aa85c <acpi_ut_remove_allocation+9b/13f>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01aa85f <acpi_ut_remove_allocation+9e/13f>
   3:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c01aa862 <acpi_ut_remove_allocation+a1/13f>
   6:   85 d2                     test   %edx,%edx
Code;  c01aa864 <acpi_ut_remove_allocation+a3/13f>
   8:   74 04                     je     e <_EIP+0xe>
Code;  c01aa866 <acpi_ut_remove_allocation+a5/13f>
   a:   8b 03                     mov    (%ebx),%eax
Code;  c01aa868 <acpi_ut_remove_allocation+a7/13f>
   c:   89 02                     mov    %eax,(%edx)
Code;  c01aa86a <acpi_ut_remove_allocation+a9/13f>
   e:   8b 73 08                  mov    0x8(%ebx),%esi
Code;  c01aa86d <acpi_ut_remove_allocation+ac/13f>
  11:   bd ea ea 00 00            mov    $0xeaea,%ebp

 <0>Kernel panic: Attempted to kill init!


Dmesg:

POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xfd936, last bus=5
PCI: Using configuration type 1
   tbget-0292: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.......................................................................................
Table [DSDT](id F005) - 1079 Objects with 57 Devices 324 Methods 15 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c035e21c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9
ACPI: Found ECDT
Completing Region/Field/Buffer/Package initialization:.............................................................
Initialized 15/15 Regions 110/110 Fields 63/63 Buffers 39/39 Packages (1088 nodes)
Executing all Device _STA and_INI methods:........................<3>schedule_task(): keventd has not started
..................................
58 Devices found containing: 58 _STA, 7 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: Embedded Controller [EC] (gpe 28)
Unable to handle kernel paging request at virtual address 8b000005


Any clues?


Hrvoje

p.s. http://free-zg.hinet.hr/HrvojeHabjanic/acpi/IBM_ThinkPad_R40




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
