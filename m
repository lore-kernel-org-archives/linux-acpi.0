From: Tobias Matzner <tobias.matzner@rechnerpost.de>
Subject: no acpi event when plugging or unplugging ac
Date: Sun, 28 May 2006 21:35:32 +0200
Message-ID: <20060528193532.GA1175@omicron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:62893 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1750863AbWE1Tit (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 May 2006 15:38:49 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6584136D98B4
	for <linux-acpi@vger.kernel.org>; Sun, 28 May 2006 21:35:23 +0200 (CEST)
Received: from [84.56.239.31] (helo=omicron)
	by smtp07.web.de with asmtp (WEB.DE 4.107 #114)
	id 1FkR2o-0002mW-00
	for linux-acpi@vger.kernel.org; Sun, 28 May 2006 21:35:22 +0200
Received: from tobias by omicron with local (Exim 3.36 #1 (Debian))
	id 1FkR2y-0000JA-00
	for <linux-acpi@vger.kernel.org>; Sun, 28 May 2006 21:35:32 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, I got a MSI S260 laptop running a 2.6.25 kernel.
Acpi works fine, apart from the fact that plugging and unplugging the
AC adapter does not trigger an acpi-event. I get a key event instead:
from /var/log/messages:

May 28 21:20:07 theta kernel: [4295050.250000] atkbd.c: Unknown key pressed (translated set 2, code 0xf2 on isa0060/serio0).
May 28 21:20:07 theta kernel: [4295050.250000] atkbd.c: Use 'setkeycodes e072 <keycode>'to make it known.
May 28 21:20:07 theta kernel: [4295050.252000] atkbd.c: Unknown key released (translated set 2, code 0xf2 on isa0060/serio0).
May 28 21:20:07 theta kernel: [4295050.252000] atkbd.c: Use 'setkeycodes e072 <keycode>'to make it known.

This is for unplugging. Plugging in is the same with another key code.

I'm rather at a loss here, because other acpi-related things like for example lid closing or suspending and resuming work without any problems and when booting it is correctly determined if the laptop is running on battery or AC.

Tobias

Some more information:
dmesg | grep -i acpi:

[4294667.296000]  BIOS-e820: 000000003f7d0000 - 000000003f7de000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000003f7de000 - 000000003f800000 (ACPI NVS)
[4294667.296000] ACPI: RSDP (v000 MSI                                   ) @ 0x000f79b0
[4294667.296000] ACPI: RSDT (v001 MSI    1012     0x12212005 MSFT 0x00000097) @ 0x3f7d0000
[4294667.296000] ACPI: FADT (v002 MSI    1012     0x12212005 MSFT 0x00000097) @ 0x3f7d0200
[4294667.296000] ACPI: MADT (v001 MSI    1012     0x12212005 MSFT 0x00000097) @ 0x3f7d0390
[4294667.296000] ACPI: MCFG (v001 MSI    1012     0x12212005 MSFT 0x00000097) @ 0x3f7d03f0
[4294667.296000] ACPI: OEMB (v001 MSI    1012     0x12212005 MSFT 0x00000097) @ 0x3f7de040
[4294667.296000] ACPI: MCFG (v001 MSI    1012     0x12212005 MSFT 0x00000097) @ 0x3f7d4120
[4294667.296000] ACPI: SSDT (v001    AMI   CPU1PM 0x00000001 INTL 0x02002026) @ 0x3f7d4160
[4294667.296000] ACPI: DSDT (v001    MSI 1012     0x12212005 INTL 0x02002026) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x808
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[4294667.296000] ACPI: IRQ0 used by override.
[4294667.296000] ACPI: IRQ2 used by override.
[4294667.296000] ACPI: IRQ9 used by override.
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294668.879000] ACPI: Looking for DSDT ... not found!
[4294669.023000] ACPI: bus type pci registered
[4294669.023000] ACPI: 2 duplicate MCFG table ignored.
[4294669.023000] ACPI: Subsystem revision 20051216
[4294669.026000] ACPI: Interpreter enabled
[4294669.026000] ACPI: Using IOAPIC for interrupt routing
[4294669.027000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294669.028000] PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
[4294669.029000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294669.038000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[4294669.040000] ACPI: Embedded Controller [EC] (gpe 29) interrupt mode.
[4294669.044000] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 6 7 *10 11 12 14 15)
[4294669.045000] ACPI: PCI Interrupt Link [LNKB] (IRQs *4 5 6 7 10 11 12 14 15)
[4294669.045000] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 6 *7 10 11 12 14 15)
[4294669.045000] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 *5 6 7 10 11 12 14 15)
[4294669.045000] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 *6 7 10 11 12 14 15)
[4294669.046000] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 *5 6 7 10 11 12 14 15)
[4294669.046000] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 *5 6 7 10 11 12 14 15)
[4294669.046000] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 10 *11 12 14 15)
[4294669.046000] pnp: PnP ACPI init
[4294669.048000] pnp: PnP ACPI: found 13 devices
[4294669.048000] PnPBIOS: Disabled by ACPI PNP
[4294669.048000] PCI: Using ACPI for IRQ routing
[4294669.055000] ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 19 (level, low) -> IRQ 169
[4294669.055000] ACPI: PCI Interrupt 0000:01:04.1[B] -> GSI 20 (level, low) -> IRQ 177
[4294669.439000] ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 20 (level, low) -> IRQ 177
[4294669.439000] ACPI: PCI interrupt for device 0000:00:1e.3 disabled
[4294669.456000] ACPI wakeup devices: 
[4294669.456000] ACPI: (supports S0 S3 S4 S5)
[4294670.725000] ACPI: CPU0 (power states: C1[C1] C2[C2])
[4294670.725000] ACPI: Processor [CPU1] (supports 8 throttling states)
[4294670.731000] ACPI: Thermal Zone [THRM] (38 C)
[4294671.094000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
[4294673.052000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 193
[4294673.155000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 169
[4294673.257000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
[4294673.359000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 201
[4294673.463000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 193
[4294673.569000] ACPI: PCI Interrupt 0000:01:04.2[C] -> GSI 21 (level, low) -> IRQ 209
[4294684.612000] ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 17 (level, low) -> IRQ 217
[4294685.428000] ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 22 (level, low) -> IRQ 225
[4294685.434000] ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 19 (level, low) -> IRQ 169
[4294685.557000] ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 217
[4294685.558000] ACPI: PCI Interrupt 0000:01:04.1[B] -> GSI 20 (level, low) -> IRQ 177
[4294690.377000] ACPI: AC Adapter [ADP1] (on-line)
[4294690.394000] ACPI: Battery Slot [BAT1] (battery present)
[4294690.449000] ACPI: Power Button (FF) [PWRF]
[4294690.449000] ACPI: Power Button (CM) [PWRB]
[4294690.449000] ACPI: Lid Switch [LID0]
[4294690.449000] ACPI: Sleep Button (CM) [SLPB]
[4294690.520000] ibm_acpi: ec object not found
[4294690.537000] pcc_acpi: loading...
[4294690.605000] ACPI: Video Device [IGFX] (multi-head: yes  rom: no  post: no)
[4294696.642000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 201



grep -i acpi config-2.6.15:

# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_SLEEP_PROC_SLEEP=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_SBS=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_PCC=m
CONFIG_ACPI_SONY=m
CONFIG_ACPI_BLACKLIST_YEAR=2000
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m
CONFIG_ACPI_TC1100=m
CONFIG_ACPI_INITRD=y
CONFIG_ACPI_DEV=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_PNPACPI=y
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_SCSI_SATA_ACPI=y
# CONFIG_SERIAL_8250_ACPI is not set

