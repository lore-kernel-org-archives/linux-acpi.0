From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Masking issue somewhere?
Date: Fri, 20 Jun 2003 21:43:52 +1200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1056102228.2279.13.camel@laptop-linux>
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

I've been meaning for a while to send this bug report. Here's an extra
from my /var/log/messages (Omnibook XE3, over-ridden DSDT).

As you'll see from the BIOS's RAM map, the ACPI data is at 276f0000. By
the time we get to execing the _STA and _INI methods, however, the
system is trying to find the information at 76f0000. Could there be a
mask incorrectly applied somewhere?

Regards,

Nigel


klogd 1.4.1, log source = /proc/kmsg started.
Inspecting /boot/System.map
Symbol table has incorrect version number. 
Cannot find map file.
Loaded 308 symbols from 17 modules.
Linux version 2.4.21 (root-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #2 Fri Jun 20 21:10:47 NZST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000276f0000 (usable)
 BIOS-e820: 00000000276f0000 - 00000000276ff000 (ACPI data)
 BIOS-e820: 00000000276ff000 - 0000000027700000 (ACPI NVS)
 BIOS-e820: 0000000027700000 - 0000000027780000 (usable)
 BIOS-e820: 0000000027780000 - 0000000028000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
631MB LOWMEM available.
On node 0 totalpages: 161664
zone(0): 4096 pages.
zone(1): 157568 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 HP-MCD                     ) @ 0x000f6190
ACPI: RSDT (v001 HP-MCD   RSDT   01540.00000) @ 0x276f9cf3
ACPI: FADT (v001 HP-MCD GF DSDT  01540.00000) @ 0x276fef8c
ACPI: DSDT (v001 HP-MCD GF DSDT  01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: auto BOOT_IMAGE=test ro root=305 quiet devfs=mount resume=/dev/hda1
Local APIC disabled by BIOS -- reenabling.

[deletia]

ACPI: Subsystem revision 20030522
PCI: PCI BIOS revision 2.10 entry at 0xfd98a, last bus=2
PCI: Using configuration type 1
   tbget-0291: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...........................................................................................................................................................................
Table [DSDT](id F004) - 590 Objects with 52 Devices 171 Methods 22 Regions
ACPI Namespace successfully loaded at root c02e8e3c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0735 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000001028 on int 9
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L03 as GPE number 0x03
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L04 as GPE number 0x04
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L08 as GPE number 0x08
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L0B as GPE number 0x0B
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L0C as GPE number 0x0C
evgpeblk-0735 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000102C on int 9
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L1D as GPE number 0x1D
Completing Region/Field/Buffer/Package initialization:.......................................................................
Initialized 22/22 Regions 0/0 Fields 33/33 Buffers 16/16 Packages (598 nodes)
Executing all Device _STA and_INI methods:.....exregion-0163 [23] ex_system_memory_space: Could not map memory at 00000000076FFFAC, size 10
evregion-0343: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node e76de5e8), AE_NO_MEMORY
  nsinit-0396 [06] ns_init_one_device    : \_SB_.PCI0._INI failed: AE_NO_MEMORY
................................exregion-0163 [25] ex_system_memory_space: Could not map memory at 00000000076FFEAD, size 90
evregion-0343: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.PHSS] (Node e76d56e8), AE_NO_MEMORY
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.COMA._STA] (Node e76ce188), AE_NO_MEMORY
  uteval-0097: *** Error: Method execution failed [\_SB_.PCI0.LPCB.COMA._STA] (Node e76ce188), AE_NO_MEMORY
................
53 Devices found containing: 52 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 (swsusp) S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
exregion-0163 [40] ex_system_memory_space: Could not map memory at 00000000076FFEAD, size 90
evregion-0343: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.PHSS] (Node e76d56e8), AE_NO_MEMORY
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.COMA._STA] (Node e76ce188), AE_NO_MEMORY
ACPI: Embedded Controller [EC0] (gpe 28)
PCI: Probing PCI hardware




-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
