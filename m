From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: acpi change between 2.6.8.1 and 2.6.17 breaks Tyan S2466N power
 button
Date: Wed, 07 Feb 2007 21:26:26 +0300
Message-ID: <45CA19D2.2090706@linux.intel.com>
References: <E1HEr0d-0004vX-Gz@mendel.bio.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30788 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965678AbXBGS0c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 13:26:32 -0500
In-Reply-To: <E1HEr0d-0004vX-Gz@mendel.bio.caltech.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Mathog <mathog@caltech.edu>
Cc: linux-acpi@vger.kernel.org

Could it be that you don't load button module?
Regards,
    Alex.
David Mathog wrote:
> I'm trying to upgrade a cluster from Mandrake 10.1 (with 2.6.8.1
> vanilla kernel) to Mandriva 2007 (2.6.17-8mdv kernel).  These machines
> have Tyan S2466N-4M motherboards, single AMD Athlon MP 2200+ processors,
> and the latest (and no doubt last) BIOS = 4.06.  ACPI is enabled in
> the BIOS.
>
> One test node was upgraded and worked correctly except for one
> annoying problem:  afterwards that node would
> no longer respond to the front power button following a
> "poweroff".  To reboot that system it is now necessary to pull
> the power cord, count to 20, plug it back in again, and then push
> the power button.
>
> There were a variety of changes to the acpi between those kernels
> versions, but the one that I think maybe indicates the problem
> is the new 
>
>   /proc/acpi/wakeup
>
> file, which on the problem machine contains only:
>
> Device    Sleep state     Status
> PCIO         5            disabled
> OP2P         5            disabled
> USB0         1            disabled
>
> So I tried: echo "OP2P" > /proc/acpi/wakeup
> which strangely enabled both of the first two
> entries, neither of which was "* enabled", just "enabled".  This
> was not enough to make the power button work following
> a "poweroff".  
>
> Those 3 wakeup devices were all that was listed in /var/log/dmesg,
> so it isn't that the OS dropped the power button after the BIOS
> reported its presence, it seems that the BIOS never told the OS
> that the power button exists.  (How this worked with the older
> OS I have no idea).  Sleep states listed in /var/log/dmesg are:
>
> ACPI:  (supports S0 S1 S4 S5)
>
> Here are all the ACPI lines in /var/log/dmesg:
>
>  BIOS-e820: 000000003fef0000 - 000000003feff000 (ACPI data)
>  BIOS-e820: 000000003feff000 - 000000003ff00000 (ACPI NVS)
> ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7100
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x3fefcf36
> ACPI: FADT (v001 AMD    TECATE   0x06040000 PTL  0x000f4240) @ 0x3fefef3c
> ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @
> 0x3fefefb0
> ACPI: DSDT (v001    AMD  AMDACPI 0x06040000 MSFT 0x0100000d) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x8008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Using ACPI (MADT) for SMP configuration information
> ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
> ACPI: bus type pci registered
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 13 devices
> PCI: Using ACPI for IRQ routing
> apm: overridden by ACPI.
> ACPI wakeup devices:
> ACPI: (supports S0 S1 S4 S5)
>
> On other systems (different motherboards and processors) with
> recent kernels this /proc/acpi/wakeup contains either
>
> PWRB   3   * enabled     (Mandriva 2006)
>
> or
>
> SLPB   4   * enabled     (Mandriva 2007)
>
> and those machines do boot from a power button push following
> "poweroff".
>
> Boot parameters for both the working and nonworking Mandriva 2007
> machines were the same (other than different partition numbers):
>
> image=/boot/vmlinuz
>         label="linux"
>         root=/dev/hda5
>         initrd=/boot/initrd.img
>         append="resume=/dev/hda2"
>
> The ACPI entries in config are:
>
> CONFIG_ACPI=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_VIDEO=m
> CONFIG_ACPI_HOTKEY=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_THERMAL=m
> CONFIG_ACPI_ASUS=m
> CONFIG_ACPI_IBM=m
> CONFIG_ACPI_IBM_DOCK=y
> CONFIG_ACPI_TOSHIBA=m
> CONFIG_ACPI_CUSTOM_DSDT_INITRD=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_ACPI_CONTAINER=m
>
> What steps do I have to take to get a power button 
> device into /proc/acpi/wakeup???
>
> Any idea why the older kernel's ACPI variant was happy start up
> from the front panel power switch following "poweroff", but the
> newer one isn't? (There were no specific acpi kernel switches).
>
> Thank you,
>
> David Mathog
> mathog@caltech.edu
> Manager, Sequence Analysis Facility, Biology Division, Caltech
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
