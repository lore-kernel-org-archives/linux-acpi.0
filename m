From: Chip Salzenberg <chip-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: ThinkPad A30 vs. 2.6.3rc2 - ACPI errors on boot
Date: Tue, 17 Feb 2004 10:42:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040217154218.GH1696@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

(I don't know if SourceForge is broken temporarily or permanently, but
I was unable to find list archives.  So I can't see whether anyonee
else has reported these issues, or read any answers unless I'm copied.)

Booting with ACPI in kernel 2.6.3rc2 on a ThinkPad A30 (2652-36U)
produces these errors.  Most things seem OK at runtime, except of
course that there's no working suspend, which is a killer.  :-(

=====================================================================================
ACPI: RSDP (v002 IBM                                       ) @ 0x000f7440
ACPI: XSDT (v001 IBM    TP-1E    0x00001152  LTP 0x00000000) @ 0x27f6f070
ACPI: FADT (v001 IBM    TP-1E    0x00001152 IBM  0x00000001) @ 0x27f6f0b4
ACPI: SSDT (v001 IBM    TP-1E    0x00001152 MSFT 0x0100000d) @ 0x27f6f168
ACPI: ECDT (v001 IBM    TP-1E    0x00001152 IBM  0x00000001) @ 0x27f79f87
ACPI: BOOT (v001 IBM    TP-1E    0x00001152  LTP 0x00000001) @ 0x27f79fd8
ACPI: DSDT (v001 IBM    TP-1E    0x00001152 MSFT 0x0100000d) @ 0x00000000
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Found ECDT
ACPI: Could not use ECDT
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__._INI] (Node e7ea9ce0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node e7ea8500), AE_NOT_EXIST
    ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node e7ea8500), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node e7ea8380), AE_NOT_EXIST
    ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node e7ea8380), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLID] (Node e7ea1320), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLII] (Node e7ea1340), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLPC] (Node e7ea1380), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.IDE0.PRIM.SLAV._STA] (Node e7ea1d20), AE_NOT_EXIST
    ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.IDE0.PRIM.SLAV._STA] (Node e7ea1d20), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BRID] (Node e7ea1f00), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BRII] (Node e7ea1f20), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BRPC] (Node e7ea1f60), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.IDE0.SCND.MSTR._STA] (Node e7ea1ce0), AE_NOT_EXIST
    ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.IDE0.SCND.MSTR._STA] (Node e7ea1ce0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLID] (Node e7ea1320), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLII] (Node e7ea1340), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLPC] (Node e7ea1380), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BSTA] (Node e7ea1580), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.USB0.URTH.UNST._STA] (Node e7ea18c0), AE_NOT_EXIST
    ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.USB0.URTH.UNST._STA] (Node e7ea18c0), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACP5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3)
ACPI: Thermal Zone [THM0] (56 C)
=====================================================================================

Here's the .config:

# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

-- 
Chip Salzenberg               - a.k.a. -               <chip-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
