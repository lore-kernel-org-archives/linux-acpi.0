From: "Roger Lucas" <roger@planbit.co.uk>
Subject: RE: Kernel eats memory with LG-81  motherboard , acpi_operand possible culprit?
Date: Sat, 16 Sep 2006 14:25:45 +0100
Message-ID: <20060916132550.62C5612EDE@bluewhale.planbit.co.uk>
References: <450ABB79.8050909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-71-36-240.dsl.in-addr.zen.co.uk ([82.71.36.240]:13483 "EHLO
	bluewhale.planbit.co.uk") by vger.kernel.org with ESMTP
	id S964806AbWIPNZw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Sep 2006 09:25:52 -0400
In-Reply-To: <450ABB79.8050909@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Alexey Starikovskiy' <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Alexey,

I have made the changes that you recommend and am also using the latest
2.6.17.13 kernel.  The output from IASL is now:

# iasl -tc ../dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20051216 [Jan  9 2006]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

../dsdt.dsl  5350:                 If (Or (PLCY, PLCY, Local7))
Warning  2097 -                         ^ Statement is unreachable

ASL Input:  ../dsdt.dsl - 5434 lines, 178315 bytes, 2003 keywords
AML Output: DSDT.aml - 17187 bytes 642 named objects 1361 executable opcodes

Compilation complete. 0 Errors, 1 Warnings, 0 Remarks, 534 Optimizations
#

I patched the kernel to allow a DSDT table to come from the initrd image as
per:
	http://gaugusch.at/kernel.shtml

This worked fine and I now see the corrected DSDT table being loaded.

# dmesg
Linux version 2.6.17.13.rwl2 (root@deb1) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #1 Fri Sep 15 21:18:15 BST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f7f0000 (usable)
 BIOS-e820: 000000001f7f0000 - 000000001f7f3000 (ACPI NVS)
 BIOS-e820: 000000001f7f3000 - 000000001f800000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
503MB LOWMEM available.
found SMP MP-table at 000f5400
On node 0 totalpages: 129008
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 124912 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f9540
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f3040
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f30c0
ACPI: BOOT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f79c0
ACPI: MCFG (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f7b40
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f7a40
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information

<snip>

Freeing initrd memory: 4600k freed
ACPI: Looking for DSDT in initramfs... successfully read 17187 bytes from
/DSDT.aml.
ACPI (tbget-0290): Table [DSDT] replaced by host OS [20060127]
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay

<snip>

Unfortunately, the "acpi_operand" field is still leaking.

# cat /proc/slabinfo | grep acpi
acpi_operand       11652  11684     40   92    1 : tunables  120   60    0 :
slabdata    127    127      0
acpi_parse_ext         3     84     44   84    1 : tunables  120   60    0 :
slabdata      1      1      0
acpi_parse            16    127     28  127    1 : tunables  120   60    0 :
slabdata      1      1      0
acpi_state            26     78     48   78    1 : tunables  120   60    0 :
slabdata      1      1      0
#

I'm a bit stuck as to what the problem is now.  I have brought everything
upt to the latest stable kernel and make the ACPI DSDT changes to allow it
to compile without errors. 

Any ideas?

Thanks,

Roger


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Alexey Starikovskiy
> Sent: 15 September 2006 15:41
> To: Roger Lucas
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: Kernel eats memory with LG-81 motherboard , acpi_operand
> possible culprit?
> 
> Roger,
> 
> Please try to change Store(Local0, Local0) to Store(Zero, Local0) and
> check if you still have a leak...
> 
> Thanks,
> Alex.
> 
> Roger Lucas wrote:
> > Some more information...
> >
> > It seems that there are bugs in the DSDT information.  I followed the
> > instructions on this link to analyse the DSDT table.
> >
> > http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems
> >
> > When I recompiled it, the following errors occurred.  I have no idea
> what
> > these mean or if they are important, but I suspect that they are not
> good.
> > The BIOS ASL was originally compiled with the Microsoft compiler.
> >
> > root@hydra:~# iasl -tc dsdt.dsl
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler version 20051216 [Jan  9 2006]
> > Copyright (C) 2000 - 2005 Intel Corporation
> > Supports ACPI Specification Revision 3.0
> >
> > dsdt.dsl   361:     Method (\_WAK, 1, NotSerialized)
> > Warning  2078 -                 ^ Reserved method must return a value
> (_WAK)
> >
> > dsdt.dsl   394:             Store (Local0, Local0)
> > Error    1048 -                         ^ Method local variable is not
> > initialized (Local0)
> >
> > dsdt.dsl   399:             Store (Local0, Local0)
> > Error    1048 -                         ^ Method local variable is not
> > initialized (Local0)
> >
> > dsdt.dsl  5349:                 If (Or (PLCY, PLCY, Local7))
> > Warning  2097 -                      ^ Statement is unreachable
> >
> > ASL Input:  dsdt.dsl - 5433 lines, 178284 bytes, 2002 keywords
> > Compilation complete. 2 Errors, 2 Warnings, 0 Remarks, 537 Optimizations
> > root@hydra:~#
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

