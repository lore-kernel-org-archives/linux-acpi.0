From: Jan Willies <jan@willies.info>
Subject: No battery status with 2.6.24-rcX anymore
Date: Fri, 14 Dec 2007 18:42:25 +0100
Message-ID: <4762C081.4010000@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from will39.synserver.de ([212.40.172.10]:46934 "EHLO
	will39.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbXLNS0N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Dec 2007 13:26:13 -0500
Received: from f051071072.adsl.alicedsl.de ([78.51.71.72] helo=[192.168.2.101])
	by will39.synserver.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <jan@willies.info>)
	id 1J3EZD-0003c7-GI
	for linux-acpi@vger.kernel.org; Fri, 14 Dec 2007 18:43:19 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

Since the 2.6.24-rcs my ACPI doesn't work correctly anymore. For instance, battery level is not reported and wakeup from S3 (s2ram) doesn't work anymore. My laptop is a Medion MD 96400 (MSI S270 equivalent).

My menuconfig looks like this:

[ ]   Deprecated /proc/acpi files
[ ]   Deprecated power /proc/acpi folders
[ ]   Deprecated /proc/acpi/event support
<M>   AC Adapter
<M>   Battery

--- Power supply class support
[ ]   Power supply debug
< >   Generic PDA/phone power driver
< >   DS2760 battery driver (HP iPAQ & others)

dmesg output:

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
ACPI: Core revision 20070126
ACPI: Table DSDT replaced by host OS
ACPI: DSDT 00000000, 2D03 (r1    MSI     1013  9262005 INTL 20061109)
ACPI: DSDT override uses original SSDTs unless "acpi_no_auto_ssdt"ACPI: setting ELCR to 0200 (from 0ce0)
ACPI: bus type pci registered
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using PIC for interrupt routing
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
pnp: PnP ACPI: found 9 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
ACPI: RTC can wake from S4
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 6
ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNKE] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:14.6 disabled
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ACPI: duty_cycle spans bit 4
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Time: acpi_pm clocksource has been installed.
ACPI: AC Adapter [ADP1] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [THRM] (62 C)
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LNKG] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Clocksource tsc unstable (delta = -78349667 ns)
spurious 8259A interrupt: IRQ7.

root@jan ~ # find /sys/ -name \*acpi\*
/sys/bus/acpi
/sys/firmware/acpi
/sys/module/pci_hotplug/parameters/debug_acpi
/sys/module/acpi
/sys/module/acpi/parameters/acpica_version
/sys/module/libata/parameters/noacpi

root@jan ~ # find /sys/ -name \*battery\*
/sys/bus/acpi/drivers/battery
/sys/module/battery

I have to boot with 'nolapic' to not run into a 10000+ wakeup/s issue but those notes above were made without 'nolapic'.


- Jan




