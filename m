From: Richie Bielak <richieb-wlNknbtBlifR7s880joybQ@public.gmane.org>
Subject: RE: ACPI on Fujitsu S-Lifebook
Date: Fri, 03 Jan 2003 18:17:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1041635876.1217.2.camel@fuji>
References: <F760B14C9561B941B89469F59BA3A847137F20@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <F760B14C9561B941B89469F59BA3A847137F20-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: apci <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-01-03 at 14:02, Grover, Andrew wrote:

> 
> Do you see any messages about found thermal zones in your dmesg? If not,
> then it is as simple as no thermal zones or fans were detected on your
> system.
> 
> Regards -- Andy
> 

Here is the ACPI messages from dmesg. There are no messages about
thermal entries. Should these be detected? Where is the code that does
the detection?

Thanks!

...richie

ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 FUJ                        ) @ 0x000f6200
ACPI: RSDT (v001 FUJ    CLOVE    00261.00000) @ 0x0f6ea447
ACPI: FADT (v001 FUJ    CLOVE    00261.00000) @ 0x0f6efb8c
ACPI: DSDT (v001 FUJ    CLOVE    00261.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Subsystem revision 20021212
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully
acquired
ACPI Namespace successfully loaded at root c032fe3c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode
successful
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 23)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [CMB1] (battery present)
ACPI: Battery Slot [CMB2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states)




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
