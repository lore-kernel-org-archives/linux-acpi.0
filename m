From: Dan <overridex-Kz9Au3A7zptBDgjK7y7TUQ@public.gmane.org>
Subject: RE: fan control based on temp
Date: Wed, 16 Jun 2004 22:03:32 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1087437811.20093.3.camel@nazgul.overridex.net>
References: <6E0C289723A0564F9A8279E236E8565F079AAB91@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6E0C289723A0564F9A8279E236E8565F079AAB91-4yWAQGcml64divtuJNk2fFDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-06-13 at 22:26, Wang, Zhenyu Z wrote:
>  Any debug message? dmesg...
> 
> What's the type of your laptop?
> 
> -zhen

While I'm waiting for the fan to stop, I figured I'd post all the info
in my dmesg about acpi, the laptop is a sager 8550v (aka prostar, clevo,
etc.) -Dan

 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                     ) @
0x000f6da0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
0x0fffc4ff
ACPI: FADT (v001 CLEVO  HOFFA    0x06040000 PTL_ 0x000f4240) @
0x0ffffb8c
ACPI: DSDT (v001  Clevo PTL_ACPI 0x06040000 MSFT 0x0100000b) @
0x00000000
ACPI: Looking for DSDT in initrd ... found (at offset 87794)!
ACPI: Subsystem revision 20040326
ACPI: IRQ10 SCI: Level Trigger.
    ACPI-1133: *** Error: Method execution failed
[\_SB_.PCI0.PIB_.SIRA._STA] (Node c12c91e0), AE_AML_NO_RETURN_VALUE
    ACPI-0154: *** Error: Method execution failed
[\_SB_.PCI0.PIB_.SIRA._STA] (Node c12c91e0), AE_AML_NO_RETURN_VALUE
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 11 13 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5 13 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10 13 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11 13 14 15)
ACPI: Embedded Controller [EC0] (gpe 12)
ACPI: Power Resource [PFNL] (on)
ACPI: Power Resource [PFNH] (on)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FANL] (on)
ACPI: Fan [FANH] (on)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: Thermal Zone [THM0] (44 C)
ACPI: (supports S0 S1 S4 S5)

============================
-Dan "OverrideX"-
ICQ: 7171522
AIM: OverrideX
Jabber: OverrideX-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org

Cold, adj.: When the politicians walk around with their hands in their
own pockets.




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
