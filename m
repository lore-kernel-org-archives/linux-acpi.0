From: matt mercer <fl0yd-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Subject: hwclock ali1535 lockup debug info
Date: Tue, 13 May 2003 11:52:35 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EC114C3.8040607@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

Some of this might be dupped, can't tell if my earlier message made it 
to the list.

I have been experiencing similar problems with rtc accesses causing an 
apparent system freeze on a Progear tablet. I found another user with a 
toshiba laptop having the same problem with a commonality of the ALi 
1533/1535 Southbridge.  This chip also contains the acpi pmu, the M7101 
device. I have the datasheet on this chip for reference. I am currently 
working with linux 2.4.21-rc2 and acpi-20030509 on debian unstable.

I've been trying to pattern the bug's behavior, but I'm pretty much as 
far as I can go at this time.  I started debugging against the rtc 
module.  I traced the "freeze" positions to two places in 
drivers/char/rtc.c;

set_rtc_irq() + spin_unlock_irq(&rtc_lock);
or
rtc_read() + schedule();

If the system makes it through set_rtc_irq it will stall at rtc_read. 
These functions strace to the ioctl and read calls from hwclock 
respectively. The system seems to make it to rtc_read more often than not.

Now the part that brings me back to acpi is a bit of debug output to the 
console that occurs once the system is "frozen";

  evevent-0286: *** Error: No installed handler fo fixed event [00000000]

I was seeing this message repeated approximatly every 10 minutes. Timed 
it with a stopwatch, something strange about the period, maybe related 
to how often the TSC resets on this system (400Mhz Crusoe).

The change set that seems to have instigated this bug is BK 1.966.


Hope this helps.

Matt

p.s. I am looking for dsdts from other systems that contain the ALi 
1535/1533 chip.  My dsdt doesn't contain any of the descriptions for the 
buttons, lid, ec, battery, etc.



======

The ALi 1535 contains the following devices,

00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)

*note the pci id of the ALi 1535 is 1533, not to be confused with the 
older ALi 1533 chip...


/proc/interrupts
            CPU0
   0:     131307          XT-PIC  timer
   1:          2          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   3:        469          XT-PIC  orinoco_cs
   5:          0          XT-PIC  Texas Instruments PCI1410 PC card 
Cardbus Controller
   8:          0          XT-PIC  rtc
   9:          1          XT-PIC  acpi
  11:        548          XT-PIC  usb-ohci
  14:       4107          XT-PIC  ide0
NMI:          0
ERR:          0

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : ALi Corporation. [ALi] M5229 IDE
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ALi Corporation. [ALi] M5229 IDE
03c0-03df : vesafb
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1000-100f : ALi Corporation. [ALi] M5229 IDE
   1000-1007 : ide0
   1008-100f : ide1
1400-14ff : ALi Corporation. [ALi] M5451 PCI AC-Link Controller Audio Device
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
8000-803f : ALi Corporation. [ALi] M7101 PMU <== acpi range
8040-805f : ALi Corporation. [ALi] M7101 PMU <== smbus range

  /proc/iomem
00000000-0009b7ff : System RAM
0009b800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d8000-000d8fff : ALi Corporation. [ALi] USB 1.1 Controller
   000d8000-000d8fff : usb-ohci
000f0000-000fffff : System ROM
00100000-06feffff : System RAM
   00100000-0028ccc9 : Kernel code
   0028ccca-0031c2c3 : Kernel data
06ff0000-06fffbff : ACPI Tables
06fffc00-06ffffff : ACPI Non-volatile Storage
10000000-10000fff : Texas Instruments PCI1410 PC card Cardbus Controller
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
a0000000-a0000fff : card services
fc000000-fc0fffff : Transmeta Corporation Northbridge
fc100000-fc100fff : ALi Corporation. [ALi] M5451 PCI AC-Link Controller 
Audio Device
fd000000-fdffffff : Silicon Motion, Inc. SM710 LynxEM
   fd000000-fdbfffff : vesafb
fff80000-ffffffff : reserved

May 13 10:47:05 tab kernel: BIOS-provided physical RAM map:
May 13 10:47:05 tab kernel:  BIOS-e820: 0000000000000000 - 
000000000009b800 (usable)
May 13 10:47:05 tab kernel:  BIOS-e820: 000000000009b800 - 
00000000000a0000 (reserved)
May 13 10:47:05 tab kernel:  BIOS-e820: 00000000000e8000 - 
0000000000100000 (reserved)
May 13 10:47:05 tab kernel:  BIOS-e820: 0000000000100000 - 
0000000006ff0000 (usable)
May 13 10:47:05 tab kernel:  BIOS-e820: 0000000006ff0000 - 
0000000006fffc00 (ACPI data)
May 13 10:47:05 tab kernel:  BIOS-e820: 0000000006fffc00 - 
0000000007000000 (ACPI NVS)
May 13 10:47:05 tab kernel:  BIOS-e820: 00000000fff80000 - 
0000000100000000 (reserved)
May 13 10:47:05 tab kernel: 111MB LOWMEM available.
May 13 10:47:05 tab kernel: ACPI: have wakeup address 0xc0001000

May 13 10:47:05 tab kernel: ACPI: RSDP (v000 PTLTD 
) @ 0x000f7e80
May 13 10:47:05 tab kernel: ACPI: RSDT (v001 PTLTD  ^I RSDT 
01540.00003) @ 0x06ffcbcc
May 13 10:47:05 tab kernel: ACPI: FADT (v001 TMETA  PDB.ALI 
01540.00003) @ 0x06fffb8c
May 13 10:47:05 tab kernel: ACPI: DSDT (v001     TM GULP120_ 
01540.00003) @ 0x00000000
May 13 10:47:05 tab kernel: ACPI: BIOS passes blacklist

May 13 10:47:06 tab kernel: ACPI: Subsystem revision 20030509
May 13 10:47:06 tab kernel:    tbget-0292: *** Info: Table [DSDT] 
replaced by host OS
May 13 10:47:06 tab kernel:  tbxface-0117 [03] acpi_load_tables      : 
ACPI Tables successfully acqu
ired
May 13 10:47:06 tab kernel: Parsing all Control 
Methods:............................................
........................................................
May 13 10:47:06 tab kernel: Table [DSDT](id F004) - 371 Objects with 46 
Devices 100 Methods 10 Regio
ns
May 13 10:47:06 tab kernel: ACPI Namespace successfully loaded at root 
c034b15c
May 13 10:47:06 tab kernel: evxfevnt-0093 [04] acpi_enable           : 
Transition to ACPI mode succe
ssful
May 13 10:47:06 tab kernel: evgpeblk-0740 [06] ev_create_gpe_block   : 
GPE Block: [_GPE] 8 registers
  at 0000000000008018 on interrupt 9
May 13 10:47:06 tab kernel: evgpeblk-0745 [06] ev_create_gpe_block   : 
GPE Block defined as GPE 0x00
  to GPE 0x3F
May 13 10:47:06 tab kernel: Completing Region/Field/Buffer/Package 
initialization:..................
................................................
May 13 10:47:06 tab kernel: Initialized 10/10 Regions 0/0 Fields 39/39 
Buffers 17/17 Packages (379 n
odes)
May 13 10:47:06 tab kernel: Executing all Device _STA and_INI 
methods:............[ACPI Debug] Strin
g: LNK1_STA
May 13 10:47:06 tab kernel: .[ACPI Debug] String: LNK2_STA
May 13 10:47:06 tab kernel: .[ACPI Debug] String: LNK3_STA
May 13 10:47:06 tab kernel: .[ACPI Debug] String: LNK4_STA
May 13 10:47:06 tab kernel: .[ACPI Debug] String: LNK5_STA
May 13 10:47:06 tab kernel: .[ACPI Debug] String: LNK6_STA
May 13 10:47:06 tab kernel: .[ACPI Debug] String: LNK7_STA
May 13 10:47:06 tab kernel: .[ACPI Debug] String: LNK8_STA
May 13 10:47:06 tab kernel: ............................
May 13 10:47:06 tab kernel: 47 Devices found containing: 47 _STA, 0 _INI 
methods
May 13 10:47:06 tab kernel: ACPI: Interpreter enabled
May 13 10:47:06 tab kernel: ACPI: Using PIC for interrupt routing
May 13 10:47:06 tab kernel: ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
May 13 10:47:06 tab kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
May 13 10:47:06 tab kernel: PCI: Probing PCI hardware (bus 00)
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK1_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 
6 7 11, disabled)
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK2_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK2_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 13, 
enabled at IRQ 7)
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK3_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 
6 7 11, disabled)
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK4_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 
6 7 11, disabled)
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK5_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 
6 7 11, disabled)
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK6_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 
6 7 11, disabled)
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK7_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 
6 7 11, disabled)
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK8_STA
May 13 10:47:06 tab last message repeated 2 times
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK8_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 *5 
6 7 11)
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNKU] (IRQs 5 6 7 *11)
May 13 10:47:06 tab kernel: PCI: Probing PCI hardware
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK1_SRS
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK1_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK1_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK1_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK1] enabled at 
IRQ 11
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK3_SRS
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK3_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK3_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK3_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 5
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK4_SRS
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK4_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK4_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK4_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK4] enabled at 
IRQ 11
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK5_SRS
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK5_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK5_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK5_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 5
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK6_SRS
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK6_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK6_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK6_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK6] enabled at 
IRQ 11
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK7_SRS
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK7_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK7_STA
May 13 10:47:06 tab kernel: [ACPI Debug] String: LNK7_CRS
May 13 10:47:06 tab kernel: ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5

May 13 10:47:06 tab kernel: ACPI: AC Adapter [ADP0] (on-line)
May 13 10:47:06 tab kernel: ACPI: Power Button (FF) [PWRF]
May 13 10:47:06 tab kernel: ACPI: Lid Switch [LID]
May 13 10:47:06 tab kernel: ACPI: Sleep Button (CM) [SLPB]
May 13 10:47:06 tab kernel: ACPI: Processor [CPU0] (supports C1 C2 C3, 8 
throttling states)


#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y











-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
