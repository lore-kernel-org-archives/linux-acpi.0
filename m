From: Ian Chilton <mailinglist-j6IF9zbmE2e9FHfhHBbuYA@public.gmane.org>
Subject: [ACPI-sppt] ACPI Battery Problems
Date: Fri, 4 Jul 2003 20:52:41 +0100
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030704195241.GC7074@roadrunner.ichilton.net>
Reply-To: Ian Chilton <ian-j6IF9zbmE2e9FHfhHBbuYA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I have a new Dell Inspiron 5100 notebook and I am using 2.4.21 with the
ACPI patch from http://acpi.sourceforge.net.

I can't get it to show the battery status - all I get is this:

[root@delta:~]# acpi -V
     Thermal 1: ok, 40.0 degrees C
  AC Adapter 1: off-line

Also, I have had a few times running on power or battey where I have
been working away and the machine has either powered off or hard reset.


I have the folowing options in my kernel:

[root@delta:~]# grep ACPI /usr/src/linux/.config
# CONFIG_HOTPLUG_PCI_ACPI is not set
# ACPI Support                  
CONFIG_ACPI=y                   
# CONFIG_ACPI_HT_ONLY is not set
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
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set


I get the following at boot:

[root@delta:~]# dmesg |grep -i acpi
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f78e0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x1ff76dd0
ACPI: FADT (v001 INTEL  NBGV     01540.00000) @ 0x1ff7af64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x1ff7afd8
ACPI: DSDT (v001  INTEL Brkdle_G 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Subsystem revision 20030619
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.SLOT._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
ACPI: AC Adapter [ACAD] (off-line)
    ACPI-0352: *** Error: Looking up [Z000] in namespace, AE_NOT_FOUND
    ACPI-1121: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BIF] (Node c1594a80), AE_NOT_FOUND
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (50 C)


Any ideas?


Thanks!

--ian



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
