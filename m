From: Nicholas Kudriavtsev <nkudriavtsev@gmail.com>
Subject: Acer Switch 12: ACPI errors while booting kernel
Date: Thu, 13 Aug 2015 14:22:45 +0300
Message-ID: <1439464965.3439.13.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34809 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbbHMLXM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2015 07:23:12 -0400
Received: by lbbtg9 with SMTP id tg9so25344057lbb.1
        for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2015 04:23:11 -0700 (PDT)
Received: from switch12 ([83.220.237.53])
        by smtp.gmail.com with ESMTPSA id j2sm468337lbs.24.2015.08.13.04.23.10
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 04:23:10 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

While booting kernel (4.1.3, Fedora 22) I've got errors regarding to ACPI in dmesg:

[    0.000000] BIOS-e820: [mem 0x000000009cebf000-0x000000009cfbefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009cfbf000-0x000000009cffefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000009cebf000-0x000000009cfbefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000009cfbf000-0x000000009cffefff] ACPI data
[    0.000000] efi:  SMBIOS=0x9c743000  ESRT=0x9c84f018  ACPI 2.0=0x9cffe014 
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000009CFFE014 000024 (v02 ACRSYS)
[    0.000000] ACPI: XSDT 0x000000009CFCB188 0000DC (v01 ACRSYS ACRPRDCT 00000001      01000013)
[    0.000000] ACPI: FACP 0x000000009CFEF000 00010C (v05 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: DSDT 0x000000009CFD7000 01110B (v02 ACRSYS ACRPRDCT 00000000 1025 00040000)
[    0.000000] ACPI: FACS 0x000000009CFB8000 000040
[    0.000000] ACPI: UEFI 0x000000009CFFD000 000236 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: UEFI 0x000000009CFFC000 000042 (v01 ACRSYS ACRPRDCT 00000000 1025 00040000)
[    0.000000] ACPI: SSDT 0x000000009CFF8000 0031AA (v01 ACRSYS ACRPRDCT 00001000 1025 00040000)
[    0.000000] ACPI: MSDM 0x000000009CFF7000 000055 (v03 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: SSDT 0x000000009CFF4000 002FDE (v02 ACRSYS ACRPRDCT 00001000 1025 00040000)
[    0.000000] ACPI: ASF! 0x000000009CFF3000 0000A5 (v32 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: ASPT 0x000000009CFF2000 000034 (v07 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: BOOT 0x000000009CFF1000 000028 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: DBGP 0x000000009CFF0000 000034 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: HPET 0x000000009CFEE000 000038 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: LPIT 0x000000009CFED000 000094 (v01 ACRSYS ACRPRDCT 00000000 1025 00040000)
[    0.000000] ACPI: APIC 0x000000009CFEC000 00008C (v03 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: MCFG 0x000000009CFEB000 00003C (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: WDAT 0x000000009CFEA000 000224 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: SSDT 0x000000009CFD5000 0013C4 (v02 ACRSYS ACRPRDCT 00001000 1025 00040000)
[    0.000000] ACPI: SSDT 0x000000009CFE9000 000250 (v02 ACRSYS ACRPRDCT 00000000 1025 00040000)
[    0.000000] ACPI: SSDT 0x000000009CFD4000 000410 (v02 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: SSDT 0x000000009CFD3000 000B74 (v02 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: SSDT 0x000000009CFCD000 005CEB (v02 ACRSYS ACRPRDCT 00003000 1025 00040000)
[    0.000000] ACPI: DMAR 0x000000009CFCC000 0000B0 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: FPDT 0x000000009CFCA000 000044 (v01 ACRSYS ACRPRDCT 00000002 1025 00040000)
[    0.000000] ACPI: BGRT 0x000000009CFC9000 000038 (v01 ACRSYS ACRPRDCT 00000001 1025 00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000099] ACPI: Core revision 20150410
[    0.057414] ACPI: All ACPI Tables successfully acquired
[    0.189884] PM: Registering ACPI NVS region [mem 0x9cebf000-0x9cfbefff] (1048576 bytes)
[    0.193400] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.193403] ACPI: bus type PCI registered
[    0.193407] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.200986] ACPI: Added _OSI(Module Device)
[    0.200991] ACPI: Added _OSI(Processor Device)
[    0.200994] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.200997] ACPI: Added _OSI(Processor Aggregator Device)
[    0.208510] ACPI Error: No handler for Region [RAM_] (ffff88015a0bb3a8) [EmbeddedControl]
(20150410/evregion-163)
[    0.208521] ACPI Error: Region EmbeddedControl (ID=3) has no handler (20150410/exfldio-297)
[    0.208529] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_._REG] (Node
ffff88015a0bac80), AE_NOT_EXIST (20150410/psparse-536)
[    0.208904] ACPI Error: No handler for Region [RAM_] (ffff88015a0bb3a8) [EmbeddedControl]
(20150410/evregion-163)
[    0.208910] ACPI Error: Region EmbeddedControl (ID=3) has no handler (20150410/exfldio-297)
[    0.208916] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_._REG] (Node
ffff88015a0bac80), AE_NOT_EXIST (20150410/psparse-536)
[    0.213145] ACPI: Executed 17 blocks of module-level executable AML code
[    0.227644] ACPI: Dynamic OEM Table Load:
[    0.227674] ACPI: SSDT 0xFFFF88015917A000 0003D3 (v02 PmRef  Cpu0Cst  00003001 INTL 20130117)
[    0.230079] ACPI: Dynamic OEM Table Load:
[    0.230107] ACPI: SSDT 0xFFFF8801590C3000 0005AA (v02 PmRef  ApIst    00003000 INTL 20130117)
[    0.232651] ACPI: Dynamic OEM Table Load:
[    0.232674] ACPI: SSDT 0xFFFF880159173A00 000119 (v02 PmRef  ApCst    00003000 INTL 20130117)
[    0.237040] ACPI : EC: EC started
[    0.244783] ACPI: Interpreter enabled
[    0.244810] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface
-580)
[    0.244830] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface
-580)
[    0.244893] ACPI: (supports S0 S3 S4 S5)
[    0.244896] ACPI: Using IOAPIC for interrupt routing
[    0.244984] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a
bug
[    0.246253] ACPI: Power Resource [PG00] (on)
[    0.247312] ACPI: Power Resource [PG01] (on)
[    0.248340] ACPI: Power Resource [PG02] (on)
[    0.292948] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.292964] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.502567] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.502573] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.507942] pci 0000:00:14.0: System wakeup disabled by ACPI
[    3.509521] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    3.510351] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    3.513413] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    3.516960] pci 0000:01:00.0: System wakeup disabled by ACPI
[    3.524015] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.524137] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.524254] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.524361] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.524470] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.524575] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.524680] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.524784] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    3.531080] ACPI: Enabled 6 GPEs in block 00 to 7F
[    3.531167] ACPI : EC: GPE = 0x2f, I/O: command/status = 0x66, data = 0x62
[    3.531800] ACPI: bus type USB registered
[    3.532262] PCI: Using ACPI for IRQ routing
[    3.560201] pnp: PnP ACPI init
[    3.560661] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.560784] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.560876] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    3.562674] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.564318] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.570443] pnp: PnP ACPI: found 5 devices
[    3.578803] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.292732] ACPI: AC Adapter [ADP1] (on-line)
[    4.292918] ACPI: Sleep Button [SLPB]
[    4.293009] ACPI: Power Button [PWRF]
[    4.295546] ACPI: Thermal Zone [TZS0] (51 C)
[    4.295978] ACPI: Thermal Zone [TZS1] (45 C)
[    4.297704] ACPI: Battery Slot [BAT0] (battery present)
[    5.187366] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    7.473691] ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F conflicts with
OpRegion 0x0000000000003040-0x000000000000304F (\_SB_.PCI0.SBUS.SMBI) (20150410/utaddress-254)
[    7.473703] ACPI: If an ACPI driver is available for this device, you should use it instead of
the native driver
[    7.650149] acer_wmi: Acer Laptop ACPI-WMI Extras
[    7.758367] acer_wmi: Brightness must be controlled by acpi video driver

I filled in a bug report on the subject https://bugzilla.kernel.org/show_bug.cgi?id=102421
and attached acpidump output there.

I know little about ACPI but if someone can make a patch to eliminate the errors (or can prompt me
where and what to change in the kernel source), I can apply the patch and test corrected kernel on
the hardware.

-- 
Regards,
Nicholas Kudriavtsev
