From: Daniel Pekelharing <legendstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Battery not visible?
Date: Thu, 20 Oct 2005 21:07:55 +0200
Message-ID: <1129835275.5487.8.camel@AMD-2600>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3osCjND+/4FzqnvMW5z4"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-Devel-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-3osCjND+/4FzqnvMW5z4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I just bought a new laptop, an Acer Aspire 3613WLMI,

I have installed Fedora Core 4 on it (after erasing the XP-Home that it
came with).

I seem to have a problem with ACPI, the battery is not visible.
i.e. ls /proc/acpi/battery is empty, and the gnome charge monitor icon
reports battery status unknown.. it does however correctly report
whether the AC adapter is plugged in or not.

"dmesg | grep ACPI" reports some errors, but I have no idea what they
mean.. I have attached a text file with my output.

Any help/ideas appreciated,

Thanks!

-- 
Daniel Pekelharing
<legendstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--=-3osCjND+/4FzqnvMW5z4
Content-Disposition: attachment; filename=acpi.txt
Content-Type: text/plain; name=acpi.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

 BIOS-e820: 000000001f6e0000 - 000000001f6ea000 (ACPI data)
 BIOS-e820: 000000001f6ea000 - 000000001f700000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7a10
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1f6e5e41
ACPI: FADT (v002 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x1f6e9e78
ACPI: MADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x1f6e9efc
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1f6e9fd8
ACPI: MCFG (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x1f6e9f9c
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x1f6e6078
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x1f6e5e7d
ACPI: DSDT (v001 INTEL  ALVISO   0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: setting ELCR to 0200 (from 0c00)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
ACPI: Embedded Controller [EC0] (gpe 23)
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._STA] (Node c146ad60), AE_TIME
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._STA] (Node c146ad60), AE_TIME
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
PCI: Using ACPI for IRQ routing
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_TZ_.TZS0._TMP] (Node c1465b60), AE_TIME
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_TZ_.TZS1._TMP] (Node c1465a60), AE_TIME
ACPI: Thermal Zone [TZS1] (26 C)
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
ACPI wakeup devices: 
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt 0000:06:07.0[A] -> Link [LNKE] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt 0000:06:09.0[A] -> Link [LNKG] -> GSI 10 (level, low) -> IRQ 10
ACPI: AC Adapter [ADP1] (off-line)
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BIF] (Node c146ad40), AE_TIME
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)

--=-3osCjND+/4FzqnvMW5z4--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
