From: Melkor <sfnet-mail-8gZPSnQ9TUZeoWH0uzbU5w@public.gmane.org>
Subject: Fan spinning speed
Date: Sun, 12 Sep 2004 02:31:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040912021310.0838.SFNET-MAIL@melkor.st>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I have a strange problem and it may be ACPI related (well, I think it is ;)

I own an ASUS P4P800-SE running Linux (Debian) with kernel 2.6.8.1 with
built-in ACPI support (button, fan, processor and thermal_zone).

At boot, only processor and button are recognized as the excerpt of dmesg
show (see below). My motherboard have the BIOS feature Q-Fan enabled which
is controled by ACPI. What it does is adapting the fan speed according to CPU
temperature. If disabled, the fan is always at max speed. When enabled, fan is
at max speed during the boot process and after 15/20 seconds, it decreases fan
speed by steps. I can distinctly hear 3 steps where fan spins slower and
slower until it becomes hardly noticeable.

But, as thermal_zone isn't working, I'd like at least to use the lm-sensors.
To achieve that, I have to load 4 modules :

i2c-dev
i2c-i801
i2c-isa
w83627hf

By itself, lm-sensors works perfectly but there's a drawback. When the module "w83627hf"
is loaded (modprobe w83627hf) the fan switches to max speed and never
decreases again (tested on about 1 hour delay).

Has anyone already experienced a similar issue and would be in position to
give any clue ? I've tried lots of configurations (removing ACPI 2.0 support
in BIOS, removing thermal_zone support in kernel) but nothing seems to have
any influence on this behaviour !

Subsidiary question : All the motherboard I have access to (PII, PIII, P4 and
AthlonXP) and supporting ACPI always show (kernel 2.6.8.1) processor only
supporting C1 ! Are C2 and C3 only reserved for laptop machines ?


Excerpt of DMESG : dmesg | grep -i acpi

 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x000fad60
ACPI: XSDT (v001 A M I  OEMXSDT  0x03000426 MSFT 0x00000097) @ 0x3ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x03000426 MSFT 0x00000097) @ 0x3ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x03000426 MSFT 0x00000097) @ 0x3ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x03000426 MSFT 0x00000097) @ 0x3ffc0040
ACPI: DSDT (v001  A0049 A0049000 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22

-- 
Melkor



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
