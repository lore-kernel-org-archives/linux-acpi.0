From: Kronos <kronos-OwEdLhkac/ZLIFpYAn0waQ@public.gmane.org>
Subject: [2.5.45][ACPI] PM doesn't work
Date: Sat, 2 Nov 2002 15:29:48 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021102142948.GA2155@dreamland.darkstar.net>
Reply-To: kronos-OwEdLhkac/ZLIFpYAn0waQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,
in 2.5.45 ACPI  power management doesn't work anymore (fan  and CPU temp
disappeared and the  machine doesn't poweroff on  shutdown). This is the
bootlog:

Linux version 2.5.45 (root@dreamland) (gcc version 3.2) #3 Fri Nov 1 19:14:40 CET 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7550
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0

[cut]

ACPI: Subsystem revision 20021022
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:..................................................................................................................
Table [DSDT] - 471 Objects with 39 Devices 114 Methods 31 Regions
ACPI Namespace successfully loaded at root c04d323c
spurious 8259A interrupt: IRQ7.
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
 evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:.......................................
39 Devices found containing: 39 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:...................................................................
Initialized 26/31 Regions 11/13 Fields 17/20 Buffers 13/13 Packages (471 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.04 not present in PCI namespace
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf40, dseg 0xf0000
pnp: pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: 00:0b: ioport range 0x3f0-0x3f1 has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]


In /proc/acpi  there is  only a  directory called  'button' (no  fan nor
processor).

This is 2.5.41 bootlog:

ACPI: RSDP (v000 VIA694                     ) @ 0x000f7550
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present

[cut]

ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..................................................................................................................
Table [DSDT] - 471 Objects with 39 Devices 114 Methods 31 Regions
ACPI Namespace successfully loaded at root c045bb1c
spurious 8259A interrupt: IRQ7.
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:.......................................
39 Devices found containing: 39 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.....................................................................
Initialized 26/31 Regions 11/13 Fields 19/20 Buffers 13/13 Packages (471 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:11.04 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf40, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x3f0-0x3f1 has been reserved
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
[cut]
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1, 2 throttling states)
ACPI: Thermal Zone [THRM] (50 C)


>From .config:

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

I have a KT333 bases board, with the latest BIOS.

ciao,
Luca
-- 
Reply-To: kronos-OwEdLhkac/ZLIFpYAn0waQ@public.gmane.org
Home: http://kronoz.cjb.net
I went to God just to see
And I was looking at me
Saw heaven and hell were lies
When I'm God everyone dies
