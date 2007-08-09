From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: fan problem on new mainboard
Date: Thu, 09 Aug 2007 18:01:29 +0800
Message-ID: <1186653689.6830.37.camel@rzhang-asus.sh.intel.com>
References: <20070809085429.GA22070@semistable.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51977 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759852AbXHIKAd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 06:00:33 -0400
In-Reply-To: <20070809085429.GA22070@semistable.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Lemmen <robertle@semistable.com>
Cc: linux-acpi@vger.kernel.org

On Thu, 2007-08-09 at 10:54 +0200, Robert Lemmen wrote:
> hi folks,
> 
> i got a new mainboard, an asrock conroe1333 (intel socket 775 thing). so
> far everything is nice except the cpu fan, which is always spinning at
> top speed. from what i understand, it should be possible to change this
> with acpi, or even make it spin depending on the cpu temperature.
> (right?) acpi on this box however doesn't seem to do this, i have got no
> entries in /proc/acpi/fan or .../thermal_zone. i googled around a bit
> and thought it might be the dsdt, so i de- and recompiled it, a few
> warnings but no errors. i am running out of ideas how to go on, so if
> anyone could give me a hint on how to get this working, or where to
> look, i'd appreciate it. the kernel is 2.6.22 (amd64), and the output of
> dmesg | grep -i acpi is attached. if you need any other info, holler!
> 
> oh, and i tried with and without the acpi_os_name line, of course.
> 
Hi, Robert,
Please attach the full _dmesg_ output as well as the acpidump.

Thanks,
Rui

> 
> Command line: root=/dev/mapper/cryptroot cryptopts=source=/dev/md0 acpi_os_name="Microsoft Windows XP" ro 
>  BIOS-e820: 000000007f7b0000 - 000000007f7c0000 (ACPI data)
>  BIOS-e820: 000000007f7c0000 - 000000007f7f0000 (ACPI NVS)
> ACPI: RSDP 000F91B0, 0014 (r0 ACPIAM)
> ACPI: RSDT 7F7B0000, 0038 (r1 A_M_I  OEMRSDT   5000702 MSFT       97)
> ACPI: FACP 7F7B0200, 0084 (r2 A M I  OEMFACP  12000601 MSFT       97)
> ACPI: DSDT 7F7B0440, 4B0B (r1  ASR18 ASR18032       32 INTL  2002026)
> ACPI: FACS 7F7C0000, 0040
> ACPI: APIC 7F7B0390, 006C (r1 A_M_I  OEMAPIC   5000702 MSFT       97)
> ACPI: MCFG 7F7B0400, 003C (r1 A_M_I  OEMMCFG   5000702 MSFT       97)
> ACPI: OEMB 7F7C0040, 0046 (r1 A_M_I  AMI_OEM   5000702 MSFT       97)
> ACPI: HPET 7F7B4F50, 0038 (r1 A_M_I  OEMHPET   5000702 MSFT       97)
> ACPI: PM-Timer IO Port: 0x808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> ACPI: HPET id: 0x8086a201 base: 0xfed00000
> Using ACPI (MADT) for SMP configuration information
> Kernel command line: root=/dev/mapper/cryptroot cryptopts=source=/dev/md0 acpi_os_name="Microsoft Windows XP" ro 
> ACPI: Core revision 20070126
> ACPI: Overriding _OS definition to 'Microsoft Windows XP'
> ACPI: bus type pci registered
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 *15)
> pnp: PnP ACPI init
> ACPI: bus type pnp registered
> pnp: ACPI device : hid PNP0A08
> pnp: ACPI device : hid PNP0C01
> pnp: ACPI device : hid PNP0200
> pnp: ACPI device : hid PNP0B00
> pnp: ACPI device : hid PNP0800
> pnp: ACPI device : hid PNP0C04
> pnp: ACPI device : hid PNP0510
> pnp: ACPI device : hid PNP0700
> pnp: ACPI device : hid PNP0401
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0103
> pnp: ACPI device : hid INT0800
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0303
> pnp: ACPI device : hid PNP0F03
> pnp: ACPI device : hid PNP0501
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0C01
> pnp: PnP ACPI: found 20 devices
> ACPI: ACPI bus type pnp unregistered
> PCI: Using ACPI for IRQ routing
> ACPI: RTC can wake from S4
> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
> ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
> ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
> ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
> ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
> ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
> ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 17 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
> parport_pc 00:08: reported by Plug and Play ACPI
> ACPI: Power Button (FF) [PWRF]
> ACPI: Power Button (CM) [PWRB]
> ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
> 
