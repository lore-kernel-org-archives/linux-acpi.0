From: Cam <camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Subject: acpi problems on Sharp PC-AR50 notebook
Date: Sat, 27 Mar 2004 22:21:15 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4065FE5B.8090903@mesias.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi ACPI list,

I'm trying to get ACPI working on my notebook - since upgrading to 
kernel 2.6 linux is trying to use ACPI. I know I can tell the kernel 
acpi=no but I would like to get ACPI to work if possible.

I have looked at web searches and FAQs and found this list, here are 
some details of the problem.

The battery/power info is missing. The lid switch doesn't trigger 
suspend. Also suspend (from apmd when acpi=no is set) can be entered but 
exited only by a reboot.

Here are highlights from the output of dmesg... I have put the full 
text, along with dmidecode and acpidmp output at:

   http://userca029.dsl.pipex.com/acpi

Any help gratefully received, if I can't fix this then it's back to good 
old APM...

Thanks in advance,

-Cam

The dmseg output, edited highlights...

Linux version 2.6.4-1.290 (bhcompile-D6sxawzOL17RXHVDFo1lHKfLeoKvNuZc@public.gmane.org) (gcc 
version 3.3.3 20040311 (Red Hat Linux 3.3.3-3)) #1 Thu Mar 25 08:43:52 
EST 2004
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7190
ACPI: RSDT (v001 SHARP  PC-XJ800 0x20000517  LTP 0x00000000) @ 0x17ffbc12
ACPI: FADT (v001 SHARP  QS1      0x20000517 PTL  0x000f4240) @ 0x17fffb65
ACPI: BOOT (v001 SHARP  PC-XJ820 0x20000517  LTP 0x00000001) @ 0x17fffbd9
ACPI: DSDT (v001 SHARP  QS1      0x20000517 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Built 1 zonelists
ACPI: Subsystem revision 20040311
ACPI: IRQ9 SCI: Level Trigger.
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.QSB_.WQS_] (Node 19eff9c4), AE_NOT_EXIST
     ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.QSB_.WENR] (Node 19effc2c), AE_NOT_EXIST
     ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0._INI] 
(Node 19fa7e3c), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 14 15)
ACPI: Embedded Controller [EC0] (gpe 0)
ACPI: Power Resource [PIDE] (on)
ACPI: Power Resource [PFN0] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Simple Boot Flag at 0x63 set to 0x1
cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
ACPI: Fan [FAN0] (off)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (50 C)
ACPI: (supports S0 S3 S4 S5)
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
