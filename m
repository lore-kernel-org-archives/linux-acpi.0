From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Issues with MSI EC ACPI
Date: Mon, 08 Jun 2009 09:00:45 +0800
Message-ID: <1244422845.3698.8.camel@localhost.localdomain>
References: <200906062126.03414.shicks37@uncc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57182 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbZFHA7b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Jun 2009 20:59:31 -0400
In-Reply-To: <200906062126.03414.shicks37@uncc.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Hicks <shicks37@uncc.edu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2009-06-07 at 09:26 +0800, Steven Hicks wrote:
> I've been having issues with the MSI VR705 ACPI functionality.
Will you please file a new bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the output of acpidump, lspci -vxxx, dmesg?
Thanks.
> 
> The chipset is an MCP79 and has an embedded controller that puts
> this out at boot:
>  BIOS-e820: 00000000cffa0000 - 00000000cffae000 (ACPI data)
>  BIOS-e820: 00000000cffae000 - 00000000cfff0000 (ACPI NVS)
> ACPI: RSDP 000FA450, 0014 (r0 MSI_NB)
> ACPI: RSDT CFFA0000, 004C (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: FACP CFFA0200, 0084 (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: DSDT CFFA0680, 9247 (r1 MSI_NB MEGABOOK       10 INTL
> 20051117)
> ACPI: FACS CFFAE000, 0040
> ACPI: APIC CFFA0390, 0080 (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: MCFG CFFA0410, 003C (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: SLIC CFFA0450, 0176 (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: WDRT CFFA05D0, 0047 (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: ECDT CFFA0620, 0055 (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: OEMB CFFAE040, 0078 (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: HPET CFFAA680, 0038 (r1 MSI_NB MEGABOOK  1092009 MSFT
> 97)
> ACPI: NVHD CFFAE0C0, 0284 (r1 010909  NVHDCP   1092009 MSFT
> 97)
> ACPI: SSDT CFFAEC50, 04F0 (r1 MSI_NB MEGABOOK  1092009 INTL
> 20051117)
> ACPI: Local APIC address 0xfee00000
> ACPI: PM-Timer IO Port: 0x4008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> ACPI: IRQ14 used by override.
> ACPI: IRQ15 used by override.
> ACPI: HPET id: 0x10de8201 base: 0xfed00000
> Using ACPI (MADT) for SMP configuration information
> ACPI: Core revision 20080926
> ACPI: bus type pci registered
> ACPI: EC: EC description table is found, configuring boot EC
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI Error (uteval-0232): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI Error (uteval-0232): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> PCI: MCFG area at fc000000 reserved in ACPI motherboard resources
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI: EC: GPE = 0x10, I/O: command/status = 0x62, data = 0x66
> ACPI: EC: driver started in poll mode
> ACPI: No dock devices found.
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IXVE._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN0A] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN0B] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN0C] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN0D] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN1A] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN1B] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN1C] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN1D] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN2A] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN2B] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN2C] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN2D] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN3A] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN3B] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN3C] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN3D] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN4A] (IRQs 16 17 18 19) *10
> ACPI: PCI Interrupt Link [LN4B] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN4C] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN4D] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN5A] (IRQs 16 17 18 19) *11
> ACPI: PCI Interrupt Link [LN5B] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN5C] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN5D] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN6A] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN6B] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN6C] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LN6D] (IRQs 16 17 18 19) *0, disabled.
> ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *11
> ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *9
> ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *15
> ACPI: PCI Interrupt Link [SGRU] (IRQs 20 21 22 23) *14
> ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *7
> ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *10
> ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *5
> ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [UB11] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [UB12] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LRP0] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LRP1] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LRP2] (IRQs 20 21 22 23) *0, disabled.
> ACPI: PCI Interrupt Link [LRP3] (IRQs 20 21 22 23) *10
> ACPI: PCI Interrupt Link [LRP4] (IRQs 20 21 22 23) *11
> ACPI: PCI Interrupt Link [LRP5] (IRQs 20 21 22 23) *9
> ACPI: PCI Interrupt Link [LRP6] (IRQs 20 21 22 23) *15
> PCI: Using ACPI for IRQ routing
> pnp: PnP ACPI init
> ACPI: bus type pnp registered
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI Error (uteval-0232): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> pnp: PnP ACPI: found 13 devices
> ACPI: ACPI bus type pnp unregistered
> ACPI: PCI Interrupt Link [LRP3] enabled at IRQ 23
> ACPI: PCI Interrupt Link [LRP4] enabled at IRQ 22
> ACPI: PCI Interrupt Link [LRP5] enabled at IRQ 21
> ACPI: PCI Interrupt Link [LRP6] enabled at IRQ 20
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI Error (uteval-0232): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI Error (uteval-0232): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.ADP1._PSR] (Node f7039c98), AE_TIME
> ACPI Exception (ac-0135): AE_TIME, Error reading AC Adapter state
> [20080926]
> ACPI: Power Button (FF) [PWRF]
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.LID0._LID] (Node f703c608), AE_TIME
> ACPI: Lid Switch [LID0]
> ACPI: Power Button (CM) [PWRB]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: SSDT CFFAE420, 01FA (r1 MSI_NB MEGABOOK  1092009 INTL
> 20051117)
> ACPI: SSDT CFFAE6B0, 0594 (r1 MSI_NB MEGABOOK  1092009 INTL
> 20051117)
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> processor ACPI_CPU:00: registered as cooling_device0
> ACPI: Processor [P001] (supports 8 throttling states)
> ACPI: SSDT CFFAE350, 00CC (r1 MSI_NB MEGABOOK  1092009 INTL
> 20051117)
> ACPI: SSDT CFFAE620, 0085 (r1 MSI_NB MEGABOOK  1092009 INTL
> 20051117)
> ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
> processor ACPI_CPU:01: registered as cooling_device1
> ACPI: Processor [P002] (supports 8 throttling states)
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI Error (uteval-0232): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node f703c734), AE_TIME
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI: EC: input buffer is not empty, aborting transaction
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_TZ_.THRM._TMP] (Node f703c5b8), AE_TIME
> ACPI: PCI Interrupt Link [LN4A] enabled at IRQ 19
> ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
> ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
> ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 21
> HDA Intel 0000:00:08.0: power state changed by ACPI to D0
> ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 20
> ACPI: PCI Interrupt Link [LN5A] enabled at IRQ 18
> ACPI: PCI Interrupt Link [SGRU] enabled at IRQ 23
> ACPI: EC: non-query interrupt received, switching to interrupt mode
> ACPI: EC: input buffer is not empty, aborting transaction
> 
> 
> Can anyone offer help? Do I need to post an ACPIdump? If so how
> would I do that?
> 
> -Steven
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

