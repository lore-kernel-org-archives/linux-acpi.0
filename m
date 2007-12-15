From: Jan Willies <jan@willies.info>
Subject: Re: No battery status with 2.6.24-rcX anymore
Date: Sat, 15 Dec 2007 18:03:14 +0100
Message-ID: <476408D2.1060205@willies.info>
References: <4762C081.4010000@willies.info> <200712141504.41707.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from will39.synserver.de ([212.40.172.10]:58803 "EHLO
	will39.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbXLOREO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Dec 2007 12:04:14 -0500
In-Reply-To: <200712141504.41707.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len Brown wrote:
> On Friday 14 December 2007 12:42, Jan Willies wrote:
> 
>> ACPI: Table DSDT replaced by host OS
> 
> Sorry, can't help you if you are running a modified BIOS.

Uh sorry, I totally forgot about that. It's just some compile errors fixed with intel compiler [1] and a little undervolting [2], don't know if it matters at all. Here is a clean log:

 BIOS-e820: 0000000037f40000 - 0000000037f50000 (ACPI data)
 BIOS-e820: 0000000037f50000 - 0000000038000000 (ACPI NVS)
ACPI: RSDP 000F8360, 0014 (r0 MSI   )
ACPI: RSDT 37F40000, 003C (r1 MSI    1013      9262005 MSFT       97)
ACPI: FACP 37F40200, 0081 (r2 MSI    1013      9262005 MSFT       97)
ACPI: DSDT 37F403F0, 31EC (r1    MSI     1013  9262005 INTL  2002026)
ACPI: FACS 37F50000, 0040
ACPI: APIC 37F40300, 0054 (r1 MSI    OEMAPIC   9262005 MSFT       97)
ACPI: WDRT 37F40360, 0047 (r1 MSI    MSI_OEM   9262005 MSFT       97)
ACPI: MCFG 37F403B0, 003C (r1 MSI    OEMMCFG   9262005 MSFT       97)
ACPI: SSDT 37F435E0, 002B (r1 OEM_ID OEMTBLID        1 INTL  2002026)
ACPI: OEMB 37F50040, 0049 (r1 MSI    MSI_OEM   9262005 MSFT       97)
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: Core revision 20070126
ACPI: bus type pci registered
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: GPE = 0x6, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in poll mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnpacpi: exceeded the max number of IO resources: 24 
pnpacpi: exceeded the max number of IO resources: 24 
pnpacpi: exceeded the max number of IO resources: 24 
pnpacpi: exceeded the max number of IO resources: 24 
pnpacpi: exceeded the max number of IO resources: 24 
ACPI: EC: non-query interrupt received, switching to interrupt mode
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
ACPI: RTC can wake from S4
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:00:14.6 disabled
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 18 (level, low) -> IRQ 20
ACPI: duty_cycle spans bit 4
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Time: acpi_pm clocksource has been installed.
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [THRM] (66 C)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 18

What else information is needed?


Thanks for looking into it,

- Jan

[1] http://katherina.student.utwente.nl/~matthijs/cgi-bin/blosxom/Hardware/S270/BrandNew.html -> Fixing ACPI
[2] http://katherina.student.utwente.nl/~matthijs/cgi-bin/blosxom/Hardware/S270/Undervolting.html
