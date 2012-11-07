From: Marc Collin <marc.collin@yahoo.com>
Subject: Toshiba z830 bad autonomy
Date: Wed, 7 Nov 2012 12:52:58 -0800 (PST)
Message-ID: <1352321578.46771.YahooMailNeo@web112310.mail.gq1.yahoo.com>
Reply-To: Marc Collin <marc.collin@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm7-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.192]:22168 "EHLO
	nm7-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852Ab2KGUw7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2012 15:52:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

hi,

i have a toshiba z830 laptop. it use an intel i5-2467m.=A0
it have a bad autonomy, if i do a suspend to ram, 2 days without use an=
d the battery is dead.

i checked in /var/log/messages to see if they are some error.

=A0cat /var/log/messages | grep ACPI
Nov =A07 21:05:05 linux-rv3v kernel: BIOS-e820: [mem 0x00000000aa2ef000=
-0x00000000aa2ef1ff] ACPI NVS
Nov =A07 21:05:05 linux-rv3v kernel: BIOS-e820: [mem 0x00000000aa2f2000=
-0x00000000aa3eefff] ACPI NVS
Nov =A07 21:05:05 linux-rv3v kernel: BIOS-e820: [mem 0x00000000aa3ef000=
-0x00000000aa40efff] ACPI data
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: RSDP 00000000000f0030 00014 =
(v00 TOSHIB)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: RSDT 00000000aa40e038 00050 =
(v01 TOSHIB A0081 =A0 =A000000001 =A0 =A0 =A001000013)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: FACP 00000000aa40d000 00081 =
(v02 TOSHIB A0081 =A0 =A000000001 LOHR 0000005F)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: DSDT 00000000aa3fc000 08AEE =
(v02 TOSHIB A0081 =A0 =A020110909 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: FACS 00000000aa3dc000 00040
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: HPET 00000000aa40c000 00038 =
(v01 TOSHIB A0081 =A0 =A000000001 LOHR 0000005F)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: APIC 00000000aa40b000 000BC =
(v01 TOSHIB A0081 =A0 =A000000001 LOHR 0000005F)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: MCFG 00000000aa40a000 0003C =
(v01 TOSHIB A0081 =A0 =A000000001 LOHR 0000005F)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: ASF! 00000000aa409000 000A0 =
(v32 TOSHIB A0081 =A0 =A000000001 LOHR 0000005F)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: BOOT 00000000aa407000 00028 =
(v01 TOSHIB A0081 =A0 =A000000000 LOHR 0000005F)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SLIC 00000000aa406000 00176 =
(v01 TOSHIB A0081 =A0 =A000000000 LOHR 0000005F)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT 00000000aa3fb000 00395 =
(v01 TOSHIB SataAhci 00001000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT 00000000aa3f8000 00720 =
(v01 TOSHIB PtidDevc 00001000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT 00000000aa3f6000 00827 =
(v01 =A0PmRef =A0Cpu0Ist 00003000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT 00000000aa3f5000 00996 =
(v01 =A0PmRef =A0 =A0CpuPm 00003000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Local APIC address 0xfee0000=
0
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PM-Timer IO Port: 0x408
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Local APIC address 0xfee0000=
0
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x00] lapic_i=
d[0x00] enabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x01] lapic_i=
d[0x01] enabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x02] lapic_i=
d[0x02] enabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x03] lapic_i=
d[0x03] enabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x04] lapic_i=
d[0x00] disabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x05] lapic_i=
d[0x00] disabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x06] lapic_i=
d[0x00] disabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC (acpi_id[0x07] lapic_i=
d[0x00] disabled)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x00] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x01] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x02] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x03] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x04] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x05] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x06] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: LAPIC_NMI (acpi_id[0x07] hig=
h edge lint[0x1])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: IOAPIC (id[0x02] address[0xf=
ec00000] gsi_base[0])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0=
 global_irq 2 dfl dfl)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9=
 global_irq 9 high level)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: IRQ0 used by override.
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: IRQ2 used by override.
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: IRQ9 used by override.
Nov =A07 21:05:05 linux-rv3v kernel: Using ACPI (MADT) for SMP configur=
ation information
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: HPET id: 0x8086a201 base: 0x=
fed00000
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Core revision 20120711
Nov =A07 21:05:05 linux-rv3v kernel: PM: Registering ACPI NVS region [m=
em 0xaa2ef000-0xaa2ef1ff] (512 bytes)
Nov =A07 21:05:05 linux-rv3v kernel: PM: Registering ACPI NVS region [m=
em 0xaa2f2000-0xaa3eefff] (1036288 bytes)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: bus type pci registered
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Added _OSI(Module Device)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Added _OSI(Processor Device)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Added _OSI(3.0 _SCP Extensio=
ns)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Added _OSI(Processor Aggrega=
tor Device)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: EC: Look up EC in DSDT
Nov =A07 21:05:05 linux-rv3v kernel: [Firmware Bug]: ACPI: BIOS _OSI(Li=
nux) query ignored
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT 00000000aad45798 0071E =
(v01 =A0PmRef =A0Cpu0Cst 00003001 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Dynamic OEM Table Load:
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT =A0 =A0 =A0 =A0 =A0 (nu=
ll) 0071E (v01 =A0PmRef =A0Cpu0Cst 00003001 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT 00000000aad46a98 00303 =
(v01 =A0PmRef =A0 =A0ApIst 00003000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Dynamic OEM Table Load:
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT =A0 =A0 =A0 =A0 =A0 (nu=
ll) 00303 (v01 =A0PmRef =A0 =A0ApIst 00003000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT 00000000aad44d98 00119 =
(v01 =A0PmRef =A0 =A0ApCst 00003000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Dynamic OEM Table Load:
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: SSDT =A0 =A0 =A0 =A0 =A0 (nu=
ll) 00119 (v01 =A0PmRef =A0 =A0ApCst 00003000 INTL 20061109)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Interpreter enabled
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: (supports S0 S3 S4 S5)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: Using IOAPIC for interrupt r=
outing
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: ACPI Dock Station Driver: 1 =
docks/bays found
Nov =A07 21:05:05 linux-rv3v kernel: PCI: Using host bridge windows fro=
m ACPI; if necessary, use "pci=3Dnocrs" and report a bug
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Root Bridge [PCI0] (doma=
in 0000 [bus 00-3f])
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0._PRT]
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0.RP01._PRT]
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0.RP03._PRT]
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0.RP05._PRT]
Nov =A07 21:05:05 linux-rv3v kernel: =A0pci0000:00: ACPI _OSC support n=
otification failed, disabling PCIe ASPM
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKA] (I=
RQs 1 3 4 5 6 7 10 12 14 15) *11
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKB] (I=
RQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKC] (I=
RQs 1 3 4 *5 6 7 10 12 14 15)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKD] (I=
RQs 1 *3 4 5 6 7 11 12 14 15)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKE] (I=
RQs 1 3 4 5 6 7 *10 12 14 15)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKF] (I=
RQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKG] (I=
RQs 1 3 4 5 *6 7 10 12 14 15)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: PCI Interrupt Link [LNKH] (I=
RQs 1 3 4 5 6 7 *11 12 14 15)
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: bus type scsi registered
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: bus type usb registered
Nov =A07 21:05:05 linux-rv3v kernel: PCI: Using ACPI for IRQ routing
Nov =A07 21:05:05 linux-rv3v kernel: pnp: PnP ACPI init
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: bus type pnp registered
Nov =A07 21:05:05 linux-rv3v kernel: pnp 00:00: Plug and Play ACPI devi=
ce, IDs PNP0a08 PNP0a03 (active)
Nov =A07 21:05:05 linux-rv3v kernel: system 00:01: Plug and Play ACPI d=
evice, IDs PNP0c02 (active)
Nov =A07 21:05:05 linux-rv3v kernel: pnp 00:02: Plug and Play ACPI devi=
ce, IDs PNP0200 (active)
Nov =A07 21:05:05 linux-rv3v kernel: system 00:03: Plug and Play ACPI d=
evice, IDs PNP0103 PNP0c01 (active)
Nov =A07 21:05:05 linux-rv3v kernel: pnp 00:04: Plug and Play ACPI devi=
ce, IDs PNP0c04 (active)
Nov =A07 21:05:05 linux-rv3v kernel: system 00:05: Plug and Play ACPI d=
evice, IDs PNP0c02 (active)
Nov =A07 21:05:05 linux-rv3v kernel: system 00:06: Plug and Play ACPI d=
evice, IDs PNP0c02 (active)
Nov =A07 21:05:05 linux-rv3v kernel: pnp 00:07: Plug and Play ACPI devi=
ce, IDs PNP0b00 (active)
Nov =A07 21:05:05 linux-rv3v kernel: pnp 00:08: Plug and Play ACPI devi=
ce, IDs PNP0303 (active)
Nov =A07 21:05:05 linux-rv3v kernel: pnp 00:09: Plug and Play ACPI devi=
ce, IDs TOS0220 PNP0f13 (active)
Nov =A07 21:05:05 linux-rv3v kernel: system 00:0a: Plug and Play ACPI d=
evice, IDs PNP0c01 (active)
Nov =A07 21:05:05 linux-rv3v kernel: pnp: PnP ACPI: found 11 devices
Nov =A07 21:05:05 linux-rv3v kernel: ACPI: ACPI bus type pnp unregister=
ed
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: [GTF0] Namespace looku=
p failure, AE_NOT_FOUND (20120711/psargs-359)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: Method parse/execution=
 failed [\_SB_.PCI0.SAT0.PRT0._SDD] (Node ffff8802c1c9d650), AE_NOT_FOU=
ND (20120711/psparse-536)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: [GTF0] Namespace looku=
p failure, AE_NOT_FOUND (20120711/psargs-359)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: Method parse/execution=
 failed [\_SB_.PCI0.SAT0.PRT0._GTF] (Node ffff8802c1c9d628), AE_NOT_FOU=
ND (20120711/psparse-536)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: [GTF0] Namespace looku=
p failure, AE_NOT_FOUND (20120711/psargs-359)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: Method parse/execution=
 failed [\_SB_.PCI0.SAT0.PRT0._SDD] (Node ffff8802c1c9d650), AE_NOT_FOU=
ND (20120711/psparse-536)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: [GTF0] Namespace looku=
p failure, AE_NOT_FOUND (20120711/psargs-359)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI Error: Method parse/execution=
 failed [\_SB_.PCI0.SAT0.PRT0._GTF] (Node ffff8802c1c9d628), AE_NOT_FOU=
ND (20120711/psparse-536)
Nov =A07 21:05:06 linux-rv3v kernel: ACPI: Power Button [PWRB]
Nov =A07 21:05:06 linux-rv3v kernel: ACPI: Lid Switch [LID]
Nov =A07 21:05:06 linux-rv3v kernel: ACPI: Power Button [PWRF]
Nov =A07 21:05:06 linux-rv3v kernel: ACPI: Invalid Power Resource to re=
gister!
Nov =A07 21:05:06 linux-rv3v kernel: ACPI: Thermal Zone [TZ01] (16 C)
Nov =A07 21:05:07 linux-rv3v kernel: ACPI: Video Device [GFX0] (multi-h=
ead: yes =A0rom: yes =A0post: no)
Nov =A07 21:05:09 linux-rv3v kernel: ACPI: Deprecated procfs I/F for AC=
 is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
Nov =A07 21:05:09 linux-rv3v kernel: ACPI: AC Adapter [ADP1] (on-line)
Nov =A07 21:05:09 linux-rv3v kernel: ACPI: Deprecated procfs I/F for ba=
ttery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
Nov =A07 21:05:09 linux-rv3v kernel: ACPI: Battery Slot [BAT1] (battery=
 present)
Nov =A07 21:05:09 linux-rv3v kernel: toshiba_bluetooth: Detected Toshib=
a ACPI Bluetooth device - installing RFKill handler
Nov =A07 21:05:09 linux-rv3v kernel: toshiba_acpi: Toshiba Laptop ACPI =
Extras version 0.19
Nov =A07 21:05:09 linux-rv3v kernel: ACPI Warning: 0x0000000000000428-0=
x000000000000042f SystemIO conflicts with Region \PMIO 1 (20120711/utad=
dress-251)
Nov =A07 21:05:09 linux-rv3v kernel: ACPI: If an ACPI driver is availab=
le for this device, you should use it instead of the native driver
Nov =A07 21:05:09 linux-rv3v kernel: ACPI Warning: 0x0000000000000500-0=
x000000000000057f SystemIO conflicts with Region \GPIO 1 (20120711/utad=
dress-251)
Nov =A07 21:05:09 linux-rv3v kernel: ACPI: If an ACPI driver is availab=
le for this device, you should use it instead of the native driver

there are some errors.

i tried also to see if there are some error in the dsdp.

cat /sys/firmware/acpi/tables/DSDT > dsdt.dat

iasl -d dsdt.dat


iasl -tc dsdt.dsl


Intel ACPI Component Architecture
ASL Optimizing Compiler version 20120518-64
Copyright (c) 2000 - 2012 Intel Corporation

dsdt.dsl =A0 1012: =A0 =A0 =A0 =A0 If (LEqual (Arg0, One))
Warning =A01131 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^ Statement is un=
reachable

dsdt.dsl =A0 3052: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000000, =
=A0 =A0 =A0 =A0=A0
Error =A0 =A04043 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ^ Invalid combination of Length and Min/Max fixed flags

dsdt.dsl =A0 3059: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000000, =
=A0 =A0 =A0 =A0=A0
Error =A0 =A04043 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ^ Invalid combination of Length and Min/Max fixed flags

dsdt.dsl =A0 5405: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (_CRS=
, 0, NotSerialized)
Warning =A01114 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ^ Not all control paths return a value (_CRS)

dsdt.dsl =A0 5405: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (_CRS=
, 0, NotSerialized)
Warning =A01106 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ^ Reserved method must return a value (Buffer required for _CR=
S)

dsdt.dsl =A0 7091: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7108: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7125: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7142: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7159: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7176: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7193: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7210: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7282: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7299: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7316: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Name (_PLD, Buffer (0x10)
Error =A0 =A04105 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 Invalid object type for=
 reserved name ^ =A0(found BUFFER, requires Package)

dsdt.dsl =A0 7490: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Wait (DKSQ, 0x0BB8)
Warning =A01128 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^ Result is not used, poss=
ible operator timeout will be missed

dsdt.dsl =A0 7511: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Wait (DKSQ, 0x1388)
Warning =A01128 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^ Result is not used, poss=
ible operator timeout will be missed

dsdt.dsl =A0 8041: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (_CRS=
, 0, Serialized)
Warning =A01114 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ^ Not all control paths return a value (_CRS)

dsdt.dsl =A0 8041: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (_CRS=
, 0, Serialized)
Warning =A01106 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ^ Reserved method must return a value (Buffer required for _CR=
S)

dsdt.dsl =A0 9370: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Wait=
 (DKSQ, 0x0BB8)
Warning =A01128 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^ Result is not used, possible operator ti=
meout will be missed

dsdt.dsl =A0 9390: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Wait (DKSQ, =
0x1388)
Warning =A01128 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ^ Result is not used, possible operator timeout wi=
ll be missed

ASL Input: =A0 =A0 dsdt.dsl - 9937 lines, 321161 bytes, 3879 keywords
Hex Dump: =A0 =A0 =A0dsdt.hex - 333723 bytes

Compilation complete. 13 Errors, 9 Warnings, 0 Remarks, 44 Optimization=
s

i don't know if the error in the messages file and in the dsdt can have=
 an impact of the autonomy?

any info how to fix dsdt error?

thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
