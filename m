From: Jan Tammen <jan.tammen-049YEbzBPRy2DcrEJY9i8Q@public.gmane.org>
Subject: Problems with Acer TravelMate 4002LMi
Date: Sat, 12 Mar 2005 21:19:54 +0100
Message-ID: <1110658794.42334eea6d62d@webmail.fh-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bonjour.

I am trying to setup ACPI correctly on my laptop; but all I seem to get
out of
/proc/acpi/* is some thermal information. There is no info on the
battery status
nor the AC adapter.

# ls  /proc/acpi/*
/proc/acpi/alarm  /proc/acpi/dsdt  /proc/acpi/event  /proc/acpi/fadt=20
/proc/acpi/info  /proc/acpi/sleep  /proc/acpi/wakeup

/proc/acpi/ac_adapter:

/proc/acpi/battery:

/proc/acpi/button:
lid  power  sleep

/proc/acpi/embedded_controller:
EC0

/proc/acpi/fan:
FAN0  FAN1

/proc/acpi/power_resource:
PFN0  PFN1

/proc/acpi/processor:
CPU0

/proc/acpi/thermal_zone:
THRM

/proc/acpi/video:
VGA

So one can see that both ac_adapter and battery are empty -- the most
important pieces of
information ;-)

Some facts:
Distribution: Gentoo
Kernel: 2.6.11 (also tried 2.6.10 before)
Compiled ACPI-modules directly into the kernel (also tried using
modules)
Some logfile-entries from dmesg (everything related to ACPI):

CPI: RSDP (v000 ACER                                  ) @ 0x000f62c0
ACPI: RSDT (v001 ACER   Kestrel  0x20021012  LTP 0x00000000) @
0x3fee6205
ACPI: FADT (v001 ACER   Kestrel  0x20021012 PTL  0x00000050) @
0x3feebf2c
ACPI: HPET (v001 ACER   Kestrel  0x20021012 PTL  0x00000000) @
0x3feebfa0
ACPI: BOOT (v001 ACER   Kestrel  0x20021012  LTP 0x00000001) @
0x3feebfd8
ACPI: DSDT (v001 ACER   Kestrel  0x20021012 MSFT 0x0100000e) @
0x00000000
ACPI: HPET id: 0x8086a201 base: 0x0
[...]
ACPI: setting ELCR to 0200 (from 0440)
[...]
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
[...]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *6)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *6)
ACPI: PCI Interrupt Link [LNKD] (IRQs *6)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
PCI: Using ACPI for IRQ routing
[...]
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 6 (level, low) -> IRQ 6
[...]
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (51 C)
[...]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
[...]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
[...]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
[...]
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
[...]
ACPI wakeup devices:
GLAN MPCI T394 MDM0 USB1 USB2 USB3
ACPI: (supports S0 S3 S4 S5)
[...]

Any chance that I can get this to work or is this a hardware-specific
problem?
Thanks for any hints (and sorry for that rather longish mail...)!
Jan.






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
