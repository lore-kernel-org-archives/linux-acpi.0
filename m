From: "Chris A. Giorgi" <chrisgio-1OhbsFfdgBm22U/x3OLdhw@public.gmane.org>
Subject: RE: CALL FOR TESTING
Date: Mon, 23 Sep 2002 14:17:18 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0209231335100.17148-100000@triton.phosphor.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello, just joined the list, I guess I should have quite a while ago
because I'm having an um, interesting time getting kernels to work
properly on my machine.

My current -working- configuration is a hand patched 2.4.19-rc1-ac2 kernel
with the 20020702 ACPI patch, without the ACPI patch, the 2.4.19-rc1-ac2
kernel couldn't properly route IRQs. With it the kernel has been relativley
stable.

I compiled 2.4.20-pre7 with the 20020918 ACPI patch, and I'm seeing problems
with IRQ routing again. The IDE driver is seeing a resource conflict for
device 00:1f.1.

I have appended the relevant parts from dmesg on both kernels, sorry for the
excessivly long post. My machine is a Sager 8880 (OEM for CLEVO/KAPOK of TW)
http://www.sagernotebooks.com for info, basics are:
Proc: 2.4GHz P4 (not mobile, full cache)
RAM: 1024MB DDR
Chipset: Intel i845 + 82801CA/CAM
IDE: Off 82801CAM, U100
Video: ATI Radeon Mobility 7500 (M7 LW)
Capture: BT878 rev 11 (audio and video)
IEEE1394: TI TSB43AB21
Cardbus: TI PCI 1250
Ethernet: Realtek TRL-8139C
USB, Modem, Sound, ISA  are all on the 82801CA/CAM

If anyone has any insight as to what's going on, it would be much
appreciated before I start doing incremental upgrades by hand from
2.4.19-rc1 until something breaks :) TIA!

			~~~~~Chris Giorgi~~~~~

---------------------------------------------------------------------
Chris A. Giorgi     chrisgio-WtoKEk6Q2Yu22U/x3OLdhw@public.gmane.org, chris@giorgi.com
530.367.5367  (Home)    831.277.1556  (Cell)
ICQ: 9493888 "Tempest"         Linux - Choice of a GNU generation.
AIM: "CAGiorgi"
---------------------------------------------------------------------


2.4.19-rc1-ac2+acpi20020702

>From dmesg:

-------------------------------------------------------------------------------
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fffffc0 (ACPI data)
 BIOS-e820: 000000003fffffc0 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.

ACPI: RSDP (v000 OID_00                     ) @ 0x000e4010
ACPI: RSDT (v001 OID_00 RSDT_000 12336.12336) @ 0x3ffffbd0
ACPI: FADT (v001 INSYDE FACP_000 00000.00256) @ 0x3ffffb20
ACPI: BOOT (v001 INSYDE SYS_BOOT 00000.00256) @ 0x3ffffba0

ACPI: Subsystem revision 20020702
PCI: PCI BIOS revision 2.10 entry at 0xeb920, last bus=2
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:................................................................
....................................................................
Table [DSDT] - 494 Objects with 52 Devices 132 Methods 17 Regions
ACPI Namespace successfully loaded at root c038f95c
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:......................................
[ACPI Debug] String: FDC_STA
.[ACPI Debug] String: ECP_STA
.[ACPI Debug] String: LPT_STA
.[ACPI Debug] String: COM1_STA
.[ACPI Debug] String: COM2_STA
.[ACPI Debug] String: IRDA_STA
.[ACPI Debug] String: FIR_STA
........
52 Devices found containing: 52 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:..........................
.......................................
Initialized 14/17 Regions 1/1 Fields 35/35 Buffers 15/15 Packages (494 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
[ACPI Debug] String: PCI0_CRS
[ACPI Debug] Buffer: Length BC
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
[ACPI Debug] String: FDC_STA
[ACPI Debug] String: FDC_STA
[ACPI Debug] String: ECP_STA
[ACPI Debug] String: ECP_STA
[ACPI Debug] String: LPT_STA
[ACPI Debug] String: COM1_STA
[ACPI Debug] String: COM1_STA
[ACPI Debug] String: COM2_STA
[ACPI Debug] String: IRDA_STA
[ACPI Debug] String: FIR_STA
[ACPI Debug] String: FIR_STA
ACPI: Power Resource [PUT2] (on)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11, disabled)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10


ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID0]
ACPI: Processor [CPU0] (supports C1, 8 throttling states)

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4018GAP, ATA DISK drive
hdc: DW-28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
-------------------------------------------------------------------------------


vs 2.4.20-pre7+acpi20020918

-------------------------------------------------------------------------------
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fffffc0 (ACPI data)
 BIOS-e820: 000000003fffffc0 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0001000

ACPI: RSDP (v000 OID_00                     ) @ 0x000e4010
ACPI: RSDT (v001 OID_00 RSDT_000 12336.12336) @ 0x3ffffbd0
ACPI: FADT (v001 INSYDE FACP_000 00000.00256) @ 0x3ffffb20
ACPI: BOOT (v001 INSYDE SYS_BOOT 00000.00256) @ 0x3ffffba0
ACPI: DSDT (v001 INSYDE KENORAA3 00000.04100) @ 0x00000000
ACPI: BIOS passes blacklist

ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xeb920, last bus=2
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:................................................................
....................................................................
Table [DSDT] - 494 Objects with 52 Devices 132 Methods 17 Regions
ACPI Namespace successfully loaded at root c036e19c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:......................................
[ACPI Debug] String: FDC_STA
.[ACPI Debug] String: ECP_STA
.[ACPI Debug] String: LPT_STA
.[ACPI Debug] String: COM1_STA
.[ACPI Debug] String: COM2_STA
.[ACPI Debug] String: IRDA_STA
.[ACPI Debug] String: FIR_STA
........
52 Devices found containing: 52 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:..........................
.......................................
Initialized 14/17 Regions 1/1 Fields 35/35 Buffers 15/15 Packages (494 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
[ACPI Debug] String: PCI0_CRS
[ACPI Debug] Buffer: Length BC
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
[ACPI Debug] String: FDC_STA
[ACPI Debug] String: FDC_STA
[ACPI Debug] String: ECP_STA
[ACPI Debug] String: ECP_STA
[ACPI Debug] String: LPT_STA
[ACPI Debug] String: COM1_STA
[ACPI Debug] String: COM1_STA
[ACPI Debug] String: COM2_STA
[ACPI Debug] String: IRDA_STA
[ACPI Debug] String: FIR_STA
[ACPI Debug] String: FIR_STA
ACPI: Power Resource [PUT2] (on)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'

ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID0]
ACPI: Processor [CPU0] (supports C1, 8 throttling states)

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH3M: BIOS setup was incomplete.
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4018GAP, ATA DISK drive
hdc: DW-28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
-------------------------------------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
