From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?=
	<francois.valenduc@tvcablenet.be>
Subject: No thermal information on Toshiba Satellite L670
Date: Fri, 12 Nov 2010 16:36:39 +0100
Message-ID: <4CDD5F07.9010102@tvcablenet.be>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050406050305000207090407"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mirapoint7.brutele.be ([212.68.199.151]:52054 "EHLO
	mirapoint7.brutele.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab0KLPmq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Nov 2010 10:42:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050406050305000207090407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello everybody,

In don't know if it's the right place to post the following problem but
I have a Toshiba Satellite L670 laptop and I can't get any temperature
information. The /sys/class/thermal directory contains the files
cooling_device0 to 4, but not "thermal_zone". I don't know if i'ts
related but in the output of dmesg |
grep ACPI, I found the following error:

[    0.465758] ACPI: EC: Look up EC in DSDT
[    0.466331] ACPI Error: No handler for Region [ERAM]
(ffff8800b6c2dcf0) [EmbeddedControl] (20100702/evregion-369)
[    0.466471] ACPI Error: Region EmbeddedControl(0x3) has no handler
(20100702/exfldio-293)
[    0.466610] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.LPCB.EC0_._REG] (Node ffff8800b6c31208), AE_NOT_EXIST

The full result is in the attached file. Do you need any more
information ? I am not subscribed to this list so please answer also to
my e-mail adress.

Thanks in advance for your help,
François Valenduc



--------------050406050305000207090407
Content-Type: text/plain;
 name="acpi"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="acpi"

[    0.000000]  BIOS-e820: 00000000b766e000 - 00000000b767c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000b767f000 - 00000000b7682000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000b76ad000 - 00000000b76cd000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000b770f000 - 00000000b7710000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000b7715000 - 00000000b7719000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000b771a000 - 00000000b771b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000b771f000 - 00000000b779f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000b779f000 - 00000000b77ff000 (ACPI data)
[    0.000000] ACPI: RSDP 00000000000f00e0 00024 (v02 TOSCPL)
[    0.000000] ACPI: XSDT 00000000b77fe120 00074 (v01 TOSCPL TOSCPL00 00000074      01000013)
[    0.000000] ACPI: FACP 00000000b77fc000 000F4 (v03 TOSCPL TOSCPL00 00000074 LOHR 0000005F)
[    0.000000] ACPI: DSDT 00000000b77e7000 10BED (v02 TOSCPL CALPELLA 00000001 INTL 20050624)
[    0.000000] ACPI: FACS 00000000b771a000 00040
[    0.000000] ACPI: HPET 00000000b77fb000 00038 (v01 TOSCPL TOSCPL00 00000001 LOHR 0000005F)
[    0.000000] ACPI: APIC 00000000b77fa000 00098 (v01 TOSCPL TOSCPL00 00000001 LOHR 0000005F)
[    0.000000] ACPI: MCFG 00000000b77f9000 0003C (v01 TOSCPL TOSCPL00 00000001 LOHR 0000005F)
[    0.000000] ACPI: ASF! 00000000b77f8000 000A5 (v32 TOSCPL TOSCPL00 00000001 LOHR 0000005F)
[    0.000000] ACPI: SLIC 00000000b77e4000 00176 (v01 TOSCPL TOSCPL00 00000001 PTL  00000001)
[    0.000000] ACPI: SSDT 00000000b77e3000 009F1 (v01  PmRef    CpuPm 00003000 INTL 20050624)
[    0.000000] ACPI: UEFI 00000000b77e2000 0003E (v01 PTL    PTLBUFÕÿ 00000001 PTL  00000001)
[    0.000000] ACPI: UEFI 00000000b77e1000 00042 (v01 PTL      COMBUF 00000001 PTL  00000001)
[    0.000000] ACPI: UEFI 00000000b77e0000 000DA (v01  PTL     PTLSWI 00000001 PTL  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000]   #6 [0000003000 - 0000007000]     ACPI WAKEUP
[    0.001118] ACPI: Core revision 20100702
[    0.016225] ACPI: Forced DSDT copy: length 0x10BED copied locally, original unmapped
[    0.416430] ACPI: bus type pci registered
[    0.465758] ACPI: EC: Look up EC in DSDT
[    0.466331] ACPI Error: No handler for Region [ERAM] (ffff8800b6c2dcf0) [EmbeddedControl] (20100702/evregion-369)
[    0.466471] ACPI Error: Region EmbeddedControl(0x3) has no handler (20100702/exfldio-293)
[    0.466610] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_._REG] (Node ffff8800b6c31208), AE_NOT_EXIST
[    0.471471] ACPI: BIOS _OSI(Linux) query ignored
[    0.472322] ACPI: SSDT 00000000b7713918 003F0 (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.472801] ACPI: Dynamic OEM Table Load:
[    0.472902] ACPI: SSDT (null) 003F0 (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    0.473411] ACPI: SSDT 00000000b7711018 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.473868] ACPI: Dynamic OEM Table Load:
[    0.473969] ACPI: SSDT (null) 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    0.474517] ACPI: SSDT 00000000b7712a98 00303 (v01  PmRef    ApIst 00003000 INTL 20050624)
[    0.475030] ACPI: Dynamic OEM Table Load:
[    0.475131] ACPI: SSDT (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20050624)
[    0.475402] ACPI: SSDT 00000000b7710d98 00119 (v01  PmRef    ApCst 00003000 INTL 20050624)
[    0.475885] ACPI: Dynamic OEM Table Load:
[    0.475986] ACPI: SSDT (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20050624)
[    0.478052] ACPI: Interpreter enabled
[    0.478106] ACPI: (supports S0 S4 S5)
[    0.478245] ACPI: Using IOAPIC for interrupt routing
[    0.525317] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.525478] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.525928] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.531657] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.531812] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.531857] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.531906] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.535676] ACPI: PCI Root Bridge [CPBG] (domain 0000 [bus ff])
[    0.536147] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.536575] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.536954] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    0.537380] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    0.537800] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.538248] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.538702] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 *5 6 7 10 12 14 15)
[    0.539077] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    0.539873] PCI: Using ACPI for IRQ routing
[    0.541862] pnp: PnP ACPI init
[    0.541919] ACPI: bus type pnp registered
[    0.564042] pnp: PnP ACPI: found 10 devices
[    0.564097] ACPI: ACPI bus type pnp unregistered
[    0.751697] ACPI: Lid Switch [LID0]
[    0.751889] ACPI: Power Button [PWRB]
[    0.752080] ACPI: Power Button [PWRF]
[    1.810339] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   10.323856] ACPI: AC Adapter [ACAD] (on-line)
[   10.416982] ACPI: acpi_idle registered with cpuidle
[   10.525069] ACPI: Battery Slot [BAT1] (battery present)



--------------050406050305000207090407--

