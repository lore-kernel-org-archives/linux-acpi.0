From: Thomas Alderweireld <Thomas.Alderweireld-vJEk5272eHo@public.gmane.org>
Subject: echo -n * > /proc/acpi/sleep has no effect
Date: Thu, 20 Feb 2003 17:33:47 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0302201722000.4562-100000@lxplus086.cern.ch>
References: <3E54FA95.8020803@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E54FA95.8020803-VXdhtT5mjnY@public.gmane.org>
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

Hello;
Time is passing and problems are resolving .....
I could fix my DSDT table today and make acpi run properly [thanks to 
your mails]. (ACER TravelMate 427, Phoenix Bios)

No I can see my battery status and I do not have any error messages 
anymore. My machine runs now under the following os:
Linux laptom 2.4.21-pre4 #1 Thu Feb 20 15:49:58 CET 2003 i686 i686 i386 GNU/Linux
and acpi-20030218-2.4.21-pre4.diff 

Nevertheless, when I do:
echo -n * (*=1,2,3,4)  > /proc/acpi/sleep  does not do 
anything. 

I put the dmesg output related to acpi in the following:
BIOS-e820: 000000001fef0000 - 000000001fefc000 (ACPI data)
BIOS-e820: 000000001fefc000 - 000000001ff00000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6d20
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x1fef64a0
ACPI: FADT (v001 INTEL  845M     01540.00000) @ 0x1fefbf8c
ACPI: DSDT (v001 COMPAL 845M     01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Subsystem revision 20030122
PCI: PCI BIOS revision 2.10 entry at 0xfd9a4, last bus=2
PCI: Using configuration type 1
    ACPI-0292: *** Info: Table [DSDT] replaced by host OS
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 9, disabled)
ACPI: Embedded Controller [EC0] (gpe 28)
schedule_task(): keventd has not started
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)


Any idea, what I can do about this......

Thanks in advance,

Tom



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
