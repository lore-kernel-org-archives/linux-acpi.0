From: Hrvoje Habjanic <hrvoje.habjanic-ZeoyiJGIzEM@public.gmane.org>
Subject: [OOPS] Again IBM ... but not the same thing!
Date: Mon, 15 Sep 2003 21:00:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309152100.23458.hrvoje.habjanic@htnet.hr>
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


Hi!

Yes, it's IBM ThinkPad R40 ... and probably buggy bios ... or ...

Using previous patch (dealocating memory) i get this:
...
ACPI: RSDP (v002 IBM                                       ) @ 0x000f6d30
ACPI: XSDT (v001 IBM    TP-1O    0x00001090  LTP 0x00000000) @ 0x0ff6ee35
ACPI: FADT (v003 IBM    TP-1O    0x00001090 IBM  0x00000001) @ 0x0ff6ef00
ACPI: SSDT (v001 IBM    TP-1O    0x00001090 MSFT 0x0100000e) @ 0x0ff6f0b4
ACPI: ECDT (v001 IBM    TP-1O    0x00001090 IBM  0x00000001) @ 0x0ff77e54
ACPI: TCPA (v001 IBM    TP-1O    0x00001090 PTL  0x00000001) @ 0x0ff77ea6
ACPI: BOOT (v001 IBM    TP-1O    0x00001090  LTP 0x00000001) @ 0x0ff77fd8
ACPI: DSDT (v001 IBM    TP-1O    0x00001090 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
...
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
 utalloc-0586: *** Error: Trying to free unallocated segment
schedule_task(): keventd has not started
ACPI: Power Resource [PUBS] (on)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Unable to handle kernel paging request at virtual address 802db858
 printing eip:
c0186c83
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0186c83>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: cfe5ff28   ecx: c02db858   edx: c02db858
esi: 00000008   edi: cfe5ff28   ebp: 00000008   esp: cfe5fed0
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=cfe5f000)
Stack: c02db858 00000286 c12ff218 c019b6cb c02db858 c02db858 cfe5ff28 00000008
       7de82404 89ffff31 00000002 c029bb5a c029ba05 c01ab65a 00000286 cfe5ff28
       c12ff200 cfe5ff2c c01b35e2 00000008 cfe5ff28 c12ff218 00000000 00100000
Call Trace:    [<c019b6cb>] [<c01ab65a>] [<c01b35e2>] [<c0186f63>] [<c011f34a>]
  [<c0128093>] [<c0127f60>] [<c0105000>] [<c010577e>] [<c0127f60>]

Code: 0f b6 82 00 00 00 c0 88 03 eb ef 83 fe 20 75 e2 8b 82 00 00
 Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)


Now, what's odd is that computer is responding to ALT-sysrq commands, but stops after "TCP: ..." part. 
It correctly detect power, lid, buttons battery, cputemp. Deksymoopsed oops is:


ksymoops 2.4.9 on i686 2.4.20-20.9.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.22-habi (specified)
     -m /usr/src/linux-2.4.22/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 802db858
c0186c83
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0186c83>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: cfe5ff28   ecx: c02db858   edx: c02db858
esi: 00000008   edi: cfe5ff28   ebp: 00000008   esp: cfe5fed0
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=cfe5f000)
Stack: c02db858 00000286 c12ff218 c019b6cb c02db858 c02db858 cfe5ff28 00000008
       7de82404 89ffff31 00000002 c029bb5a c029ba05 c01ab65a 00000286 cfe5ff28
       c12ff200 cfe5ff2c c01b35e2 00000008 cfe5ff28 c12ff218 00000000 00100000
Call Trace:    [<c019b6cb>] [<c01ab65a>] [<c01b35e2>] [<c0186f63>] [<c011f34a>]
  [<c0128093>] [<c0127f60>] [<c0105000>] [<c010577e>] [<c0127f60>]
Code: 0f b6 82 00 00 00 c0 88 03 eb ef 83 fe 20 75 e2 8b 82 00 00


>>EIP; c0186c83 <acpi_os_read_memory+31/57>   <=====

>>ecx; c02db858 <pm_devs+0/8>
>>edx; c02db858 <pm_devs+0/8>

Trace; c019b6cb <acpi_hw_low_level_read+10f/122>
Trace; c01ab65a <acpi_ut_trace+28/2c>
Trace; c01b35e2 <acpi_ec_gpe_query+a3/11d>
Trace; c0186f63 <acpi_os_execute_deferred+39/75>
Trace; c011f34a <__run_task_queue+5a/70>
Trace; c0128093 <context_thread+133/1c0>
Trace; c0127f60 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <arch_kernel_thread+2e/40>
Trace; c0127f60 <context_thread+0/1c0>

Code;  c0186c83 <acpi_os_read_memory+31/57>
00000000 <_EIP>:
Code;  c0186c83 <acpi_os_read_memory+31/57>   <=====
   0:   0f b6 82 00 00 00 c0      movzbl 0xc0000000(%edx),%eax   <=====
Code;  c0186c8a <acpi_os_read_memory+38/57>
   7:   88 03                     mov    %al,(%ebx)
Code;  c0186c8c <acpi_os_read_memory+3a/57>
   9:   eb ef                     jmp    fffffffa <_EIP+0xfffffffa>
Code;  c0186c8e <acpi_os_read_memory+3c/57>
   b:   83 fe 20                  cmp    $0x20,%esi
Code;  c0186c91 <acpi_os_read_memory+3f/57>
   e:   75 e2                     jne    fffffff2 <_EIP+0xfffffff2>
Code;  c0186c93 <acpi_os_read_memory+41/57>
  10:   8b 82 00 00 00 00         mov    0x0(%edx),%eax


And I don't have any clue what to do! Error is in GPE part but how to fix it? Where to start?

Hrvoje



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
