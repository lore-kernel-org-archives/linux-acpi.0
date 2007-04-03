From: Len Brown <lenb@kernel.org>
Subject: Re: system freeze with acpi
Date: Mon, 2 Apr 2007 22:12:20 -0400
Message-ID: <200704022212.21104.lenb@kernel.org>
References: <20070331121551.2b9c5dce@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40953 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966151AbXDCCU3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Apr 2007 22:20:29 -0400
In-Reply-To: <20070331121551.2b9c5dce@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominique Michel <dominique.michel@citycable.ch>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Saturday 31 March 2007 06:15, Dominique Michel wrote:
> Hi,
> 
> My whole system freeze from time to time when using acpi. I don't get this
> problem without acpi. My motherboard is an asus P4S8X
> 
>  # cat /proc/version
> Linux version 2.6.20-rt8 (root@localhost) (gcc version 4.1.1 (Gentoo 4.1.1-r3))
> #1 SMP PREEMPT Fri Mar 30 23:15:59 CEST 2007

Just a random question -- does it work any better w/o PREEMPT?

> lspci -vvv:
...
> 00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller
> (rev 0f) (prog-if 10 [OHCI]) Subsystem: ASUSTeK Computer Inc. Unknown device
> 8087 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B- Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 32 (20000ns
> max), Cache Line Size: 32 bytes Interrupt: pin A routed to IRQ 20

Here is your USB controller on IRQ20.
We'd actually need to dis-assemble the _PRT in your DSDT from an acpidump
to verify that this is the right interrupt for USB.
But as there are no Link targets above 16 below, I expect the PRT
to be hard-coded and have no reason to suspect this is wrong.
(indeed, you'd see it on IRQ20 in windows too -- though you'd
have to compare the GSI numbers below to Windows IRQ numbers,
because Linux still compresses its IRQ numbers above 15 on i386)

> 
> # cat /proc/interrupts
>            CPU0       
>   0:        283   IO-APIC-edge      timer
>   1:        691   IO-APIC-edge      i8042
>   6:          5   IO-APIC-edge      floppy
>   7:          0   IO-APIC-edge      parport0
>   8:          2   IO-APIC-edge      rtc
>  12:          4   IO-APIC-edge      i8042
>  14:      20344   IO-APIC-edge      ide0
>  15:      24156   IO-APIC-edge      ide1
>  17:        108   IO-APIC-fasteoi   ohci_hcd:usb2
>  18:          1   IO-APIC-fasteoi   ohci_hcd:usb3
>  19:       1043   IO-APIC-fasteoi   ohci1394, eth0
>  20:      23230   IO-APIC-fasteoi   acpi, ohci_hcd:usb1

atypical, yes, but not unusual to have the ACPI SCI on an upper input.
less typical still to have it shared w/ another motherboard device,
but not unheard of.

>  21:        781   IO-APIC-fasteoi   ehci_hcd:usb4
>  22:          4   IO-APIC-fasteoi   bttv0
>  23:    1943588   IO-APIC-fasteoi   EMU10K1
> NMI:          0 
> LOC:     548999 
> ERR:          0
> MIS:          0
> 
> Is it normal at acpi use the same IRQ as ohci_hcd:usb1? I don't think so, but I
> can be wrong.
> 
> # cat .config|grep ACPI
> # Power management options (ACPI, APM)
> # ACPI (Advanced Configuration and Power Interface) Support
> CONFIG_ACPI=y
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> # CONFIG_ACPI_BUTTON is not set

CONFIG_ACPI_BUTTON will allow the OS to notice when
you press the power button -- check it out.

> # CONFIG_ACPI_VIDEO is not set
> # CONFIG_ACPI_HOTKEY is not set
> # CONFIG_ACPI_FAN is not set
> # CONFIG_ACPI_DOCK is not set
> # CONFIG_ACPI_PROCESSOR is not set
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_BLACKLIST_YEAR=2001
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_ACPI_CONTAINER is not set
> # CONFIG_ACPI_SBS is not set
> CONFIG_PNPACPI=y
> 
> # dmesg|grep ACPI
>  BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
>  BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
> ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5810
> ACPI: RSDT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc000
> ACPI: FADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc0c0
> ACPI: BOOT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc030
> ACPI: MADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc058
> ACPI: DSDT (v001   ASUS P4S8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
> ACPI: PM-Timer IO Port: 0xe408
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)

Here is your acpi SCI interrupt being attached to GSI 20 in IOAPIC mode.

> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> Using ACPI (MADT) for SMP configuration information
> ACPI: Core revision 20060707
> ACPI: bus type pci registered
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9

These are all legacy-mode links, so it appears that the OS
is given no choice what pins to route things to in IOAPIC mode.
Simple is good:-)

> ACPI: PCI Root Bridge [PCI0] (0000:00)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 16 devices
> PCI: Using ACPI for IRQ routing
> ACPI: PCI Interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
> ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 18
> ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
> ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 21
> ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 22
> ACPI: PCI Interrupt 0000:00:0a.2[B] -> GSI 19 (level, low) -> IRQ 19
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 23
> 
> It is with the last bios revison, 1005.
> 
> With a 2.6.19.1-rt15 that have antother configuration and work fine, I get
> when running it with pci=noacpi:
> # cat /proc/interrupts
>            CPU0       
>   0:     228789    XT-PIC-XT        timer
>   1:        229    XT-PIC-XT        i8042
>   2:          0    XT-PIC-XT        cascade
>   5:     148178    XT-PIC-XT        EMU10K1
>   6:          5    XT-PIC-XT        floppy
>   7:          1    XT-PIC-XT        parport0
>   8:          2    XT-PIC-XT        rtc
>   9:       4641    XT-PIC-XT        acpi, ohci_hcd:usb1, ehci_hcd:usb2,
> ohci1394, ohci_hcd:usb3, ohci_hcd:usb4, eth0 
>  10:          4    XT-PIC-XT        bttv0
>  11:      10019    XT-PIC-XT        nvidia
>  12:          4    XT-PIC-XT        i8042
>  14:      19935    XT-PIC-XT        ide0
>  15:       3605    XT-PIC-XT        ide1
> NMI:     729962 
> LOC:     228630 
> ERR:          0
> MIS:          0

Why all the NMIs -- do you have nmi_watchdog running?

> My problem is at I really want to use CONFIG_X86_PM_TIMER in the ACPI config.

You will not be able to run in IOAPIC mode w/o having ACPI configure interrupts.
Firstly, because there appears to be no MPS on this board -- or pci=noacpi
above would have been in IOAPIC mode instead of legacy mode.  Secondly,
only ACPI knows about the interrupt source override for the ACPI SCI
from 9->20 on this board.

> CONFIG_X86_PM_TIMER 

So your problem is that to build this in, you need to build in CONFIG_ACPI,
but when you run in full (default) ACPI mode your system hangs so it is unusable?

I have no idea what is behind the hang, there are no clues to it above that I see.
However, if you think that running in PIC mode is more stable than IOAPIC mode
on this box, then try running with just "noapic" which will give you ACPI mode
without the IOAPIC.  pci=noacpi and acpi=noirq will probably give you the
same result.

-Len
