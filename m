From: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Subject: Weird ACPI-related error in system logs
Date: Fri, 6 Feb 2004 11:01:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206110121.445f4433.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: ACPI Support <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi, Guys!

I'm running a HiGrade laptop with SiS chipset; I haven't tried playing
with sleep modes yet, but there's a funny error which I don't understand
that jumps out during boot-up. I'm posting the relevant log part:

 BIOS-e820: 000000000dff0000 - 000000000dffffc0 (ACPI data)
 BIOS-e820: 000000000dffffc0 - 000000000e000000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e5010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 & 0x00010007) @ 0x0dfffbc0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 & 0x00010007) @ 0x0dfffac0
ACPI: BOOT (v001 INSYDE ISC_BOOT 0x00000100 & 0x00010007) @ 0x0dfffb50
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000001 & 0x00010007) @ 0x0dfffb80
ACPI: DSDT (v001 INSYDE     8575 0x00001002 INTL 0x02002025) @ 0x00000000
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 (swsusp) S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 25)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *6 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: AC Adapter [AC] (on-line)
    ACPI-0352: *** Error: Looking up [ACST] in namespace, AE_NOT_FOUND
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._BTP] (Node cdf39500), AE_NOT_FOUND
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]

So, I'm just wondering what this error means? Resetting and poweroff *are*
working properly.

I'm running 2.4.24 kernel with ACPI patch 20040116.

Best wishes,

Andrej


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
