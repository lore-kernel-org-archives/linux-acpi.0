From: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Subject: acpi on gateway 200x
Date: Sun, 19 Oct 2003 09:07:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031019130707.GA7924@masanjin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Dear ACPI gurus,

I'm trying to get ACPI to work on a new Gateway 200x laptop. I'm running
kernel 2.6.0-test7 with the ACPI stuff compiled in directly to the
kernel. Right now not a whole lot is working. I'm mainly concerned with
the battery for the moment, but /proc/acpi/battery is empty.

Here is the relevant portions of dmesg. Is this a broken DSDT a la some
other gateway laptops? Any help would be appreciated.

--- cut here --- 
Linux version 2.6.0-test7 (root@grappelli) (gcc version 3.3.2 20030908 (Debian prerelease)) #9 Sat Oct 18 09:47:12 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f6e0000 (usable)
 BIOS-e820: 000000001f6e0000 - 000000001f6ec000 (ACPI data)
 BIOS-e820: 000000001f6ec000 - 000000001f700000 (ACPI NVS)
 BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
502MB LOWMEM available.
On node 0 totalpages: 128736
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124640 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7c90
ACPI: RSDT (v001 PTLTD  Montara  0x06040000  LTP 0x00000000) @ 0x1f6e7d39
ACPI: FADT (v001 INTEL  MONTARA  0x06040000 PTL  0x00000050) @ 0x1f6ebed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1f6ebfd8
ACPI: SSDT (v001 INTEL  CPU0CST  0x00000001 INTL 0x20020725) @ 0x1f6e8182
ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x02012044) @ 0x1f6e7d6d
ACPI: DSDT (v001 INTEL  MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
[...]
ACPI: Subsystem revision 20030918
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................
Table [DSDT](id F006) - 521 Objects with 56 Devices 156 Methods 20 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
Parsing all Control Methods:....
Table [SSDT](id F004) - 7 Objects with 0 Devices 4 Methods 0 Regions
ACPI Namespace successfully loaded at root c03c7cbc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9
Completing Region/Field/Buffer/Package initialization:........................................................
Initialized 20/20 Regions 0/0 Fields 21/21 Buffers 15/15 Packages (537 nodes)
Executing all Device _STA and_INI methods:.........................................................
57 Devices found containing: 57 _STA, 4 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
evregion-0249 [21] ev_address_space_dispa: no handler for region(df667e28) [EmbeddedControl]
 exfldio-0269 [20] ex_access_region      : Region EmbeddedControl(3) has no handler
 dswexec-0422 [13] ds_exec_end_op        : [LEqual]: Could not resolve operands, AE_NOT_EXIST
dswstate-0273 [15] ds_result_pop_from_bot: No result objects! State=df653c28
 dsutils-0525 [15] ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 psparse-1120: *** Error: Method execution failed [\_SB_.ADP1._STA] (Node df66e1a8), AE_AML_NO_RETURN_VALUE
evregion-0249 [21] ev_address_space_dispa: no handler for region(df667e28) [EmbeddedControl]
 exfldio-0269 [20] ex_access_region      : Region EmbeddedControl(3) has no handler
 dswexec-0422 [13] ds_exec_end_op        : [LEqual]: Could not resolve operands, AE_NOT_EXIST
dswstate-0273 [15] ds_result_pop_from_bot: No result objects! State=df653c28
 dsutils-0525 [15] ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 psparse-1120: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node df66dca8), AE_AML_NO_RETURN_VALUE
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *5)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [H_EC] (gpe 28)
evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0422 [30] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.H_EC._REG] (Node df663e88), AE_BAD_PARAMETER
ACPI: Power Resource [PFAN] (on)
[...]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
[...]
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0422 [46] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1120: *** Error: Method execution failed [\_TZ_.THRM._TMP] (Node df66eec8), AE_BAD_PARAMETER
[...]
evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0422 [43] ds_exec_end_op        : [LEqual]: Could not resolve operands, AE_BAD_PARAMETER
dswstate-0273 [45] ds_result_pop_from_bot: No result objects! State=df653c28
 dsutils-0525 [45] ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 psparse-1120: *** Error: Method execution failed [\_SB_.LID0._LID] (Node df66ce68), AE_AML_NO_RETURN_VALUE
--- cut here --- 

Any ideas or suggestions? Thanks.

-- 
William


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
