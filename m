From: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: Changing IRQ`s at DSDT
Date: Mon, 29 Sep 2003 12:44:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F780D1A.20908@paceblade.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090909030704030805090608"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------090909030704030805090608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

for the history : i am having a issue with ACPI and IRQ`s ( i believe )
i have a configuration where sound ( ali5451 ) , eth0( realtek 8139) and 
usb ( usb-ohci) are using IRQ 5 .
Until now what happens is that when i used 2 out of these 3 devices at 
the same time the unit locked hard .

Now i am able to set eth0 to IRQ7 and a first stress test with 600MB 
dowload and playing songs worked fine .

I am using now 2.4.22 + acpi20030916  + the initrd patch to use my own 
DSDT .

I reached that now in sent the LNK1 in my DSDT to IRQ 7 .

Unfortunatly the systems still uses IRQ 5 for the other 2 devices 
although i also did change the LNK8 and LNKU  at the DSDT ( tryed 6  and 
11 and 7 ) .

find attached my data of the unit ..

can somebody tell me why it ignores my changes to LNK8 and LNKU in my 
DSDT and still uses IRQ5 ?
i am also curious why certain LNK`s are parsed twice ???

thanks

Rob

-- 
_____________________________________
*Robert Woerle
Linux & Customer Support*
*PaceBlade Technology Europe SA*
phone: 	+49 89 552 99935
fax: 	+49 89 552 99910
mobile: 	+49 179 474 45 27
email: 	robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org <mailto:robert@paceblade.com>
web: 	http://www.paceblade.com
_____________________________________




--------------090909030704030805090608
Content-Type: application/x-gzip;
 name="dsdt.dsl.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dsdt.dsl.tar.gz"

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
pmOqlf4fQzvXewCQAQA=
--------------090909030704030805090608
Content-Type: text/plain;
 name="lspci+dmesg+interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci+dmesg+interrupts"

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:04.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04)
00:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
00:06.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev b1)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 01)
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)

Looking for DSDT in initrd ... found (at offset 445158)!
   tbget-0292: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................................................................................
Table [DSDT](id F004) - 403 Objects with 37 Devices 111 Methods 16 Regions
ACPI Namespace successfully loaded at root c036dffc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 63 [_GPE] 8 regs at 0000000000008018 on int 9
Completing Region/Field/Buffer/Package initialization:.......................................................................
Initialized 16/16 Regions 0/0 Fields 33/33 Buffers 22/22 Packages (411 nodes)
Executing all Device _STA and_INI methods:.........[ACPI Debug] String: LNK2_STA
.[ACPI Debug] String: LNK3_STA
.[ACPI Debug] String: LNK4_STA
.[ACPI Debug] String: LNK5_STA
.[ACPI Debug] String: LNK6_STA
.[ACPI Debug] String: LNK7_STA
.[ACPI Debug] String: LNK8_STA
.......................
38 Devices found containing: 38 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 (swsusp) S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 7)
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_CRS
ACPI: PCI Interrupt Link [LNK2] (IRQs *10)
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_STA
ACPI: PCI Interrupt Link [LNK3] (IRQs 10)
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_CRS
ACPI: PCI Interrupt Link [LNK4] (IRQs 6 7 10 11)
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK5_STA
ACPI: PCI Interrupt Link [LNK5] (IRQs 6 7 10 11)
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_CRS
ACPI: PCI Interrupt Link [LNK6] (IRQs 11)
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_CRS
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_CRS
ACPI: PCI Interrupt Link [LNK8] (IRQs 6)
ACPI: PCI Interrupt Link [LNKU] (IRQs 11)
ACPI: Power Resource [LRP0] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 7
[ACPI Debug] String: LNK6_SRS
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_CRS
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
[ACPI Debug] String: LNK3_SRS
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_CRS
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
[ACPI Debug] String: LNK2_SRS
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_CRS
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
[ACPI Debug] String: LNK8_SRS
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_CRS
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 5
 pci_irq-0302 [32] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0 - using IRQ 255
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (66 C)
vesafb: framebuffer at 0xf8200000, mapped to 0xd6802000, size 3072k
...


           CPU0
  0:     170374          XT-PIC  timer
  1:       2498          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        817          XT-PIC  usb-ohci, ALI 5451
  7:        760          XT-PIC  eth0
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:        757          XT-PIC  ohci1394, i82365
 14:       4363          XT-PIC  ide0
NMI:          0
ERR:          0

--------------090909030704030805090608--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
