From: Hamie <hamish@travellingkiwi.com>
Subject: ACPI vs Asus A8v
Date: Fri, 04 Mar 2005 17:22:11 +0000
Message-ID: <42289943.6030303@travellingkiwi.com>
Reply-To: gentoo-amd64@lists.gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Post: <mailto:gentoo-amd64@gentoo.org>
List-Help: <mailto:gentoo-amd64-help@gentoo.org>
List-Unsubscribe: <mailto:gentoo-amd64-unsubscribe@gentoo.org>
List-Subscribe: <mailto:gentoo-amd64-subscribe@gentoo.org>
To: gentoo-amd64@lists.gentoo.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi all.

I have an athlon64 in an Asus A8V motherboard, running gentoo with 
kernel 2.6.11 (Also tried with 2.6.9 and 2.6.10). Although it works, and 
cool&quiet kicks in before boot, I can get no thermal or fan information 
from acpi... dmesg sees

damned acpi # dmesg | grep -i acpi
BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
ACPI: RSDP (v002 ACPIAM                                ) @ 
0x00000000000fa810
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000427 MSFT 0x00000097) @ 
0x000000003ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x10000427 MSFT 0x00000097) @ 
0x000000003ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000427 MSFT 0x00000097) @ 
0x000000003ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000427 MSFT 0x00000097) @ 
0x000000003ffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 
0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root ffffffff805b8f00
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode 
successful
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
pnp: PnP ACPI init
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for 
object [000001003ff8aa30]
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 177
ACPI wakeup devices:
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169
acpi_utils-0071 [04] acpi_extract_package  : Invalid 'package' argument
acpi_processor-1046 [03] acpi_processor_get_per: Invalid _PSS data

Modules are loaded...

damned acpi # lsmod
Module                  Size  Used by
fan                     4872  0
thermal                17676  0
powernow_k8             8712  0
freq_table              3720  1 powernow_k8
processor              25212  2 thermal,powernow_k8
ohci1394               27268  0
ieee1394              352280  1 ohci1394
ehci_hcd               26820  0
ohci_hcd               18888  0
sk98lin               148012  1
damned acpi #



But /proc/acpi/thermal_zone & fan are empty... (

Is there something else I should be doing? I've also trued the acpi4asus 
module, but it complains about missing hardware, so presumably that's 
only any good for their laptops...

What sort of info & control SHOULD I be able to see out of this 
motherboard? How can I get the level of control that Asus offer with 
their windoze applications?

TIA

hamish
