From: Johannes Schanda <johannes.schanda-1R9WWMedIqeELgA04lAiVw@public.gmane.org>
Subject: Fan and Temperature problem
Date: Mon, 13 Sep 2004 19:35:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409131935.59226.johannes.schanda@schanda.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi all,
I have another problem with my laptop, an Acer Extensa 3001. When I run lin=
ux=20
the fan runs at full speed all the time, and=20
cat /proc/acpi/thermal_zone/THRM0/temperature reports around 90C=B0, no mat=
ter=20
what the load is. The air that comes out of the fan exhaust is quite cool,=
=20
however, which makes me think it isn't really running at that temperature. =
In=20
windows the fan only turns on when there is a lot of activity, so I don't=20
think it's a hardware problem. Fan, cpu and thermal zone are all properly=20
recognised. Is it possibel that the temperature is somehow interpreted=20
incorrectly by the kernel and makes the system think it has to cool a lot? =
Or=20
is this done without any os interference? Any help wpould be greatly=20
appreciated!

Thanks
Johannes


dmesg | grep ACPI
 BIOS-e820: 000000001fee0000 - 000000001feec000 (ACPI data)
 BIOS-e820: 000000001feec000 - 000000001ff00000 (ACPI NVS)
ACPI: RSDP (v000 ACER                                      ) @ 0x000f62c0
ACPI: RSDT (v001 ACER   Kestrel  0x20020707  LTP 0x00000000) @ 0x1fee6235
ACPI: FADT (v001 ACER   Kestrel  0x20020707 PTL  0x00000050) @ 0x1feebf2c
ACPI: HPET (v001 ACER   Kestrel  0x20020707 PTL  0x00000000) @ 0x1feebfa0
ACPI: BOOT (v001 ACER   Kestrel  0x20020707  LTP 0x00000001) @ 0x1feebfd8
ACPI: DSDT (v001 ACER   Kestrel  0x20020707 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: HPET id: 0x8086a201 base: 0x0
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
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
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.3[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (90 C)
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
cpufreq: CPU0 - ACPI performance management activated.
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
