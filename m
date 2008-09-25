From: John Reiser <jreiser@BitWagon.com>
Subject: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way
 that Linux understands
Date: Thu, 25 Sep 2008 14:59:31 -0700
Message-ID: <48DC09C3.1060601@BitWagon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from jade.aracnet.com ([216.99.193.136]:37678 "EHLO jade.aracnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYIYWGt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 18:06:49 -0400
Received: from fu9-32.local (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by jade.aracnet.com (8.13.6/8.12.8) with ESMTP id m8PLxkUT021756
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 14:59:46 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I found these messages in kernel log.  I will try to complain to the BIOS vendor.
-----
Sep 25 07:00:43 fu9-32 kernel: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
Sep 25 07:00:43 fu9-32 kernel: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
-----

dmidecode reports the BIOS as:
-----
         Vendor: Phoenix Technologies, LTD
         Version: ASUS M2A-VM ACPI BIOS Revision 1604
         Release Date: 12/19/2007
-----

biosdecode 2.9 says:
-----
ACPI 2.0 present.
         OEM Identifier: ATI
         RSD Table 32-bit Address: 0xCFEE3040
         XSD Table 64-bit Address: 0x00000000CFEE3100
-----

grep ACPI /var/log/messages
-----
Sep 25 07:00:43 fu9-32 kernel: BIOS-e820: 00000000cfee0000 - 00000000cfee3000 (ACPI NVS)
Sep 25 07:00:43 fu9-32 kernel: BIOS-e820: 00000000cfee3000 - 00000000cfef0000 (ACPI data)
Sep 25 07:00:43 fu9-32 kernel: ACPI: RSDP 000F8210, 0024 (r2 ATI   )
Sep 25 07:00:43 fu9-32 kernel: ACPI: XSDT CFEE3100, 0044 (r1 ATI    ASUSACPI 42302E31 AWRD        0)
Sep 25 07:00:43 fu9-32 kernel: ACPI: FACP CFEE8440, 00F4 (r3 ATI    ASUSACPI 42302E31 AWRD        0)
Sep 25 07:00:43 fu9-32 kernel: ACPI: DSDT CFEE3280, 515D (r1 ATI    ASUSACPI     1000 MSFT  3000000)
Sep 25 07:00:43 fu9-32 kernel: ACPI: FACS CFEE0000, 0040
Sep 25 07:00:43 fu9-32 kernel: ACPI: HPET CFEE8680, 0038 (r1 ATI    ASUSACPI 42302E31 AWRD       98)
Sep 25 07:00:43 fu9-32 kernel: ACPI: MCFG CFEE8700, 003C (r1 ATI    ASUSACPI 42302E31 AWRD        0)
Sep 25 07:00:43 fu9-32 kernel: ACPI: APIC CFEE8580, 0084 (r1 ATI    ASUSACPI 42302E31 AWRD        0)
Sep 25 07:00:43 fu9-32 kernel: ACPI: PM-Timer IO Port: 0x4008
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Sep 25 07:00:43 fu9-32 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Sep 25 07:00:43 fu9-32 kernel: ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
Sep 25 07:00:43 fu9-32 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Sep 25 07:00:43 fu9-32 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Sep 25 07:00:43 fu9-32 kernel: ACPI: HPET id: 0x8200 base: 0xfed00000
Sep 25 07:00:43 fu9-32 kernel: Using ACPI (MADT) for SMP configuration information
Sep 25 07:00:43 fu9-32 kernel: ACPI: Core revision 20080321
Sep 25 07:00:43 fu9-32 kernel: ACPI: bus type pci registered
Sep 25 07:00:43 fu9-32 kernel: ACPI: Interpreter enabled
Sep 25 07:00:43 fu9-32 kernel: ACPI: (supports S0 S1 S3 S4 S5)
Sep 25 07:00:43 fu9-32 kernel: ACPI: Using IOAPIC for interrupt routing
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 *11)
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Sep 25 07:00:43 fu9-32 kernel: pnp: PnP ACPI init
Sep 25 07:00:43 fu9-32 kernel: ACPI: bus type pnp registered
Sep 25 07:00:43 fu9-32 kernel: pnp: PnP ACPI: found 11 devices
Sep 25 07:00:43 fu9-32 kernel: ACPI: ACPI bus type pnp unregistered
Sep 25 07:00:43 fu9-32 kernel: PCI: Using ACPI for IRQ routing
Sep 25 07:00:43 fu9-32 kernel: ACPI: RTC can wake from S4
Sep 25 07:00:43 fu9-32 kernel: ACPI: Power Button (FF) [PWRF]
Sep 25 07:00:43 fu9-32 kernel: ACPI: Power Button (CM) [PWRB]
Sep 25 07:00:43 fu9-32 kernel: ACPI: PNP0C0B:00 is registered as cooling_device0
Sep 25 07:00:43 fu9-32 kernel: ACPI: Fan [FAN] (on)
Sep 25 07:00:43 fu9-32 kernel: ACPI: ACPI0007:00 is registered as cooling_device1
Sep 25 07:00:43 fu9-32 kernel: ACPI: ACPI0007:01 is registered as cooling_device2
Sep 25 07:00:43 fu9-32 kernel: ACPI: Expecting a [Reference] package element, found type 0
Sep 25 07:00:43 fu9-32 kernel: ACPI: LNXTHERM:01 is registered as thermal_zone0
Sep 25 07:00:43 fu9-32 kernel: ACPI: Thermal Zone [THRM] (40 C)
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
Sep 25 07:00:43 fu9-32 kernel: ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 19 (level, low) -> IRQ 19
Sep 25 07:00:43 fu9-32 kernel: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
Sep 25 07:00:43 fu9-32 kernel: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
-----


-- 
