From: munich@gmx.li
Subject: 2nd CPU core ist not recognized due to faulty MADT;
 Possibility to load custom MADT ?
Date: Fri, 30 May 2008 09:34:31 +0200
Message-ID: <20080530073431.17960@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751457AbYE3Hee (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 May 2008 03:34:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear Sir or Madam,

I recently upgraded my home server mainboard (Gigabyte K8NNXP-940) with=
 a dual core processor AMD Opteron 275. Everything runs great, the BIOS=
 recognizes the CPU and prints the correct CPU name string while bootin=
g. However, I cannot use the 2nd CPU core, although dmesg writes:

[ 0.000000] Scanning NUMA topology in Northbridge 24
[ 0.000000] CPU has 2 num_cores=20

Curiously, I was looking for the reason and found out that my BIOS' MAD=
T/APIC table lacks the entry for the LAPIC of the 2nd core. I checked t=
he manufacturer's website for BIOS updates, but of course there are not=
 any :(

Just to test things out, I also installed windows xp and opensolaris. T=
he former runs fine, though again with one core only, the latter crashe=
s / reboots while booting.=20

After I found some information about loading custom DSDTs and SSDTs at
http://gaugusch.at/kernel.shtml

I rewrote my MADT table to make use of the 2nd core. However I recogniz=
ed later, while browsing through the ACPI specifications on acpi.info t=
hat DSDT and SSDT do not include the MADTs :(

Please let me know if there is any possibility to load a custom MADT an=
d/or if there is anything else I could do.

Thank you very much

Alex

Debug information:
dmesg ( please ignore the autoloaded DSDT, the result without it is the=
 same :( )

[ 0.000000] Linux version 2.6.24-16-generic (buildd@yellow) (gcc versio=
n 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Thu Apr 10 12:47:45 UTC 2008 (U=
buntu 2.6.24-16.30-generic)
[ 0.000000] Command line: root=3DUUID=3D424037A340379C9B loop=3D/ubuntu=
/disks/root.disk ro
[ 0.000000] BIOS-provided physical RAM map:
[ 0.000000] BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[ 0.000000] BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[ 0.000000] BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
[ 0.000000] BIOS-e820: 00000000dfff0000 - 00000000dfff3000 (ACPI NVS)
[ 0.000000] BIOS-e820: 00000000dfff3000 - 00000000e0000000 (ACPI data)
[ 0.000000] BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[ 0.000000] BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[ 0.000000] BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[ 0.000000] BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
[ 0.000000] Entering add_active_range(0, 0, 160) 0 entries of 3200 used
[ 0.000000] Entering add_active_range(0, 256, 91748 1 entries of 3200 u=
sed
[ 0.000000] Entering add_active_range(0, 1048576, 117964 2 entries of 3=
200 used
[ 0.000000] end_pfn_map =3D 1179648
[ 0.000000] DMI 2.3 present.
[ 0.000000] ACPI: RSDP signature @ 0xFFFF8100000F66D0 checksum 0
[ 0.000000] ACPI: RSDP 000F66D0, 0014 (r0 Nvidia)
[ 0.000000] ACPI: RSDT DFFF3000, 002C (r1 Nvidia AWRDACPI 42302E31 AWRD=
 1010101)
[ 0.000000] ACPI: FACP DFFF3040, 0074 (r1 Nvidia AWRDACPI 42302E31 AWRD=
 1010101)
[ 0.000000] ACPI: DSDT DFFF30C0, 4C15 (r1 NVIDIA AWRDACPI 1000 MSFT 100=
000C)
[ 0.000000] ACPI: FACS DFFF0000, 0040
[ 0.000000] ACPI: APIC DFFF7D00, 006E (r1 Nvidia AWRDACPI 42302E31 AWRD=
 1010101)
[ 0.000000] Scanning NUMA topology in Northbridge 24
[ 0.000000] CPU has 2 num_cores
[ 0.000000] No NUMA configuration found
[ 0.000000] Faking a node at 0000000000000000-0000000120000000
[ 0.000000] Entering add_active_range(0, 0, 160) 0 entries of 3200 used
[ 0.000000] Entering add_active_range(0, 256, 91748 1 entries of 3200 u=
sed
[ 0.000000] Entering add_active_range(0, 1048576, 117964 2 entries of 3=
200 used
[ 0.000000] Bootmem setup node 0 0000000000000000-0000000120000000
[ 0.000000] Zone PFN ranges:
[ 0.000000] DMA 0 -> 4096
[ 0.000000] DMA32 4096 -> 1048576
[ 0.000000] Normal 1048576 -> 1179648
[ 0.000000] Movable zone start PFN for each node
[ 0.000000] early_node_map[3] active PFN ranges
[ 0.000000] 0: 0 -> 160
[ 0.000000] 0: 256 -> 917488
[ 0.000000] 0: 1048576 -> 1179648
[ 0.000000] On node 0 totalpages: 1048464
[ 0.000000] DMA zone: 56 pages used for memmap
[ 0.000000] DMA zone: 1209 pages reserved
[ 0.000000] DMA zone: 2735 pages, LIFO batch:0
[ 0.000000] DMA32 zone: 14280 pages used for memmap
[ 0.000000] DMA32 zone: 899112 pages, LIFO batch:31
[ 0.000000] Normal zone: 1792 pages used for memmap
[ 0.000000] Normal zone: 129280 pages, LIFO batch:31
[ 0.000000] Movable zone: 0 pages used for memmap
[ 0.000000] Nvidia board detected. Ignoring ACPI timer override.
[ 0.000000] If you got timer trouble try acpi_use_timer_override
[ 0.000000] ACPI: PM-Timer IO Port: 0x1008
[ 0.000000] ACPI: Local APIC address 0xfee00000
[ 0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[ 0.000000] Processor #0 (Bootup-CPU)
[ 0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[ 0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[ 0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[ 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[ 0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[ 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[ 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge=
)
[ 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge=
)
[ 0.000000] ACPI: IRQ9 used by override.
[ 0.000000] ACPI: IRQ14 used by override.
[ 0.000000] ACPI: IRQ15 used by override.
[ 0.000000] Setting APIC routing to flat
[ 0.000000] Using ACPI (MADT) for SMP configuration information
[ 0.000000] swsusp: Registered nosave memory region: 00000000000a0000 -=
 00000000000f0000
[ 0.000000] swsusp: Registered nosave memory region: 00000000000f0000 -=
 0000000000100000
[ 0.000000] swsusp: Registered nosave memory region: 00000000dfff0000 -=
 00000000dfff3000
[ 0.000000] swsusp: Registered nosave memory region: 00000000dfff3000 -=
 00000000e0000000
[ 0.000000] swsusp: Registered nosave memory region: 00000000e0000000 -=
 00000000fec00000
[ 0.000000] swsusp: Registered nosave memory region: 00000000fec00000 -=
 00000000fec01000
[ 0.000000] swsusp: Registered nosave memory region: 00000000fec01000 -=
 00000000fee00000
[ 0.000000] swsusp: Registered nosave memory region: 00000000fee00000 -=
 00000000fee01000
[ 0.000000] swsusp: Registered nosave memory region: 00000000fee01000 -=
 00000000ffff0000
[ 0.000000] swsusp: Registered nosave memory region: 00000000ffff0000 -=
 0000000100000000
[ 0.000000] Allocating PCI resources starting at e2000000 (gap: e000000=
0:1ec00000)
[ 0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
[ 0.000000] PERCPU: Allocating 34656 bytes of per cpu data
[ 0.000000] Built 1 zonelists in Node order, mobility grouping on. Tota=
l pages: 1031127
[ 0.000000] Policy zone: Normal
[ 0.000000] Kernel command line: root=3DUUID=3D424037A340379C9B loop=3D=
/ubuntu/disks/root.disk ro
[ 0.000000] Initializing CPU#0
[ 0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[ 0.000000] TSC calibrated against PM_TIMER
[ 49.414974] time.c: Detected 1890.003 MHz processor.
[ 49.417075] Console: colour VGA+ 80x25
[ 49.417078] console [tty0] enabled
[ 49.421420] Checking aperture...
[ 49.421479] CPU 0: aperture @ e8000000 size 128 MB
[ 49.460794] Memory: 4116752k/4718592k available (2466k kernel code, 77=
104k reserved, 1309k data, 316k init)
[ 49.460910] SLUB: Genslabs=3D12, HWalign=3D64, Order=3D0-1, MinObjects=
=3D4, CPUs=3D1, Nodes=3D1
[ 49.540782] Calibrating delay using timer specific routine.. 3782.47 B=
ogoMIPS (lpj=3D7564959)
[ 49.540928] Security Framework initialized
[ 49.540992] SELinux: Disabled at boot.
[ 49.541062] AppArmor: AppArmor initialized
[ 49.541124] Failure registering capabilities with primary security mod=
ule.
[ 49.541503] Dentry cache hash table entries: 524288 (order: 10, 419430=
4 bytes)
[ 49.543946] Inode-cache hash table entries: 262144 (order: 9, 2097152 =
bytes)
[ 49.545229] Mount-cache hash table entries: 256
[ 49.545410] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 byte=
s/line)
[ 49.545474] CPU: L2 Cache: 1024K (64 bytes/line)
[ 49.545535] CPU 0/0 -> Node 0
[ 49.545610] SMP alternatives: switching to UP code
[ 49.546105] Freeing SMP alternatives: 24k freed
[ 49.546501] Early unpacking initramfs... done
[ 49.864793] ACPI: Core revision 20070126
[ 49.864900] ACPI: Looking for DSDT in initramfs... successfully read 2=
2520 bytes from /DSDT.aml.
[ 49.865040] ACPI: Table DSDT replaced by host OS
[ 49.865186] ACPI: DSDT 00000000, 57F8 (r1 NVIDIA AWRDACPI 1000 INTL 20=
080514)
[ 49.865347] ACPI: DSDT override uses original SSDTs unless "acpi_no_au=
to_ssdt"<6>Using local APIC timer interrupts.
[ 49.961675] APIC timer calibration result 13125011
[ 49.961677] Detected 13.125 MHz APIC timer.
[ 49.961784] Brought up 1 CPUs

Current MADT (commented format by iasl):
--------
/*
* Intel ACPI Component Architecture
* AML Disassembler version 20080514
*
* Disassembly of original_old.bin, Thu May 28 11:37:46 2008
*
* ACPI Data Table [APIC]
*
* Format: [HexOffset DecimalOffset ByteLength] FieldName : FieldValue
*/

[000h 000 4] Signature : "APIC" /* Multiple APIC Description Table */
[004h 004 4] Table Length : 0000006E
[008h 008 1] Revision : 01
[009h 009 1] Checksum : 76
[00Ah 010 6] Oem ID : "Nvidia"
[010h 016 8] Oem Table ID : "AWRDACPI"
[018h 024 4] Oem Revision : 42302E31
[01Ch 028 4] Asl Compiler ID : "AWRD"
[020h 032 4] Asl Compiler Revision : 01010101

[024h 036 4] Local Apic Address : FEE00000
[028h 040 4] Flags (decoded below) : 00000001
PC-AT Compatibility : 1

[02Ch 044 1] Subtable Type : 00 -Processor Local APIC-
[02Dh 045 1] Length : 08
[02Eh 046 1] Processor ID : 00
[02Fh 047 1] Local Apic ID : 00
[030h 048 4] Flags (decoded below) : 00000001
Processor Enabled : 1

[034h 052 1] Subtable Type : 01 -I/O APIC-
[035h 053 1] Length : 0C
[036h 054 1] I/O Apic ID : 02
[037h 055 1] Reserved : 00
[038h 056 4] Address : FEC00000
[03Ch 060 4] Interrupt : 00000000

[040h 064 1] Subtable Type : 02 -Interrupt Source Override-
[041h 065 1] Length : 0A
[042h 066 1] Bus : 00
[043h 067 1] Source : 00
[044h 068 4] Interrupt : 00000002
[048h 072 2] Flags (decoded below) : 0000
Polarity : 0
Trigger Mode : 0

[04Ah 074 1] Subtable Type : 02 -Interrupt Source Override-
[04Bh 075 1] Length : 0A
[04Ch 076 1] Bus : 00
[04Dh 077 1] Source : 09
[04Eh 078 4] Interrupt : 00000009
[052h 082 2] Flags (decoded below) : 000D
Polarity : 1
Trigger Mode : 3

[054h 084 1] Subtable Type : 02 -Interrupt Source Override-
[055h 085 1] Length : 0A
[056h 086 1] Bus : 00
[057h 087 1] Source : 0E
[058h 088 4] Interrupt : 0000000E
[05Ch 092 2] Flags (decoded below) : 0005
Polarity : 1
Trigger Mode : 1

[05Eh 094 1] Subtable Type : 02 -Interrupt Source Override-
[05Fh 095 1] Length : 0A
[060h 096 1] Bus : 00
[061h 097 1] Source : 0F
[062h 098 4] Interrupt : 0000000F
[066h 102 2] Flags (decoded below) : 0005
Polarity : 1
Trigger Mode : 1

[068h 104 1] Subtable Type : 04 -Local APIC NMI-
[069h 105 1] Length : 06
[06Ah 106 1] Processor ID : 00
[06Bh 107 2] Flags (decoded below) : 0000
Polarity : 0
Trigger Mode : 0
[06Dh 109 1] Interrupt Input LINT : 01

Raw Table Data

0000: 41 50 49 43 6E 00 00 00 01 76 4E 76 69 64 69 61 APICn....vNvidia
0010: 41 57 52 44 41 43 50 49 31 2E 30 42 41 57 52 44 AWRDACPI1.0BAWRD
0020: 01 01 01 01 00 00 E0 FE 01 00 00 00 00 08 00 00 ................
0030: 01 00 00 00 01 0C 02 00 00 00 C0 FE 00 00 00 00 ................
0040: 02 0A 00 00 02 00 00 00 00 00 02 0A 00 09 09 00 ................
0050: 00 00 0D 00 02 0A 00 0E 0E 00 00 00 05 00 02 0A ................
0060: 00 0F 0F 00 00 00 05 00 04 06 00 00 00 01 ..............

--------

My suggested "new" MADT:
-------
/*
* Intel ACPI Component Architecture
* AML Disassembler version 20080514
*
* Disassembly of NEW.BIN, Wed May 28 18:28:28 2008
*
* ACPI Data Table [APIC]
*
* Format: [HexOffset DecimalOffset ByteLength] FieldName : FieldValue
*/

[000h 000 4] Signature : "APIC" /* Multiple APIC Description Table */
[004h 004 4] Table Length : 0000007C
[008h 008 1] Revision : 01
[009h 009 1] Checksum : 51
[00Ah 010 6] Oem ID : "Nvidia"
[010h 016 8] Oem Table ID : "AWRDACPI"
[018h 024 4] Oem Revision : 42302E31
[01Ch 028 4] Asl Compiler ID : "AWRD"
[020h 032 4] Asl Compiler Revision : 01010101

[024h 036 4] Local Apic Address : FEE00000
[028h 040 4] Flags (decoded below) : 00000001
PC-AT Compatibility : 1

[02Ch 044 1] Subtable Type : 00 -Processor Local APIC-
[02Dh 045 1] Length : 08
[02Eh 046 1] Processor ID : 00
[02Fh 047 1] Local Apic ID : 00
[030h 048 4] Flags (decoded below) : 00000001
Processor Enabled : 1

[034h 052 1] Subtable Type : 00 -Processor Local APIC-
[035h 053 1] Length : 08
[036h 054 1] Processor ID : 01
[037h 055 1] Local Apic ID : 01
[038h 056 4] Flags (decoded below) : 00000001
Processor Enabled : 1

[03Ch 060 1] Subtable Type : 01 -I/O APIC-
[03Dh 061 1] Length : 0C
[03Eh 062 1] I/O Apic ID : 02
[03Fh 063 1] Reserved : 00
[040h 064 4] Address : FEC00000
[044h 068 4] Interrupt : 00000000

[048h 072 1] Subtable Type : 02 -Interrupt Source Override-
[049h 073 1] Length : 0A
[04Ah 074 1] Bus : 00
[04Bh 075 1] Source : 00
[04Ch 076 4] Interrupt : 00000002
[050h 080 2] Flags (decoded below) : 0000
Polarity : 0
Trigger Mode : 0

[052h 082 1] Subtable Type : 02 -Interrupt Source Override-
[053h 083 1] Length : 0A
[054h 084 1] Bus : 00
[055h 085 1] Source : 09
[056h 086 4] Interrupt : 00000009
[05Ah 090 2] Flags (decoded below) : 000D
Polarity : 1
Trigger Mode : 3

[05Ch 092 1] Subtable Type : 02 -Interrupt Source Override-
[05Dh 093 1] Length : 0A
[05Eh 094 1] Bus : 00
[05Fh 095 1] Source : 0E
[060h 096 4] Interrupt : 0000000E
[064h 100 2] Flags (decoded below) : 0005
Polarity : 1
Trigger Mode : 1

[066h 102 1] Subtable Type : 02 -Interrupt Source Override-
[067h 103 1] Length : 0A
[068h 104 1] Bus : 00
[069h 105 1] Source : 0F
[06Ah 106 4] Interrupt : 0000000F
[06Eh 110 2] Flags (decoded below) : 0005
Polarity : 1
Trigger Mode : 1

[070h 112 1] Subtable Type : 04 -Local APIC NMI-
[071h 113 1] Length : 06
[072h 114 1] Processor ID : 00
[073h 115 2] Flags (decoded below) : 0000
Polarity : 0
Trigger Mode : 0
[075h 117 1] Interrupt Input LINT : 01

[076h 118 1] Subtable Type : 04 -Local APIC NMI-
[077h 119 1] Length : 06
[078h 120 1] Processor ID : 01
[079h 121 2] Flags (decoded below) : 0000
Polarity : 0
Trigger Mode : 0
[07Bh 123 1] Interrupt Input LINT : 01

Raw Table Data

0000: 41 50 49 43 7C 00 00 00 01 51 4E 76 69 64 69 61 APIC|....QNvidia
0010: 41 57 52 44 41 43 50 49 31 2E 30 42 41 57 52 44 AWRDACPI1.0BAWRD
0020: 01 01 01 01 00 00 E0 FE 01 00 00 00 00 08 00 00 ................
0030: 01 00 00 00 00 08 01 01 01 00 00 00 01 0C 02 00 ................
0040: 00 00 C0 FE 00 00 00 00 02 0A 00 00 02 00 00 00 ................
0050: 00 00 02 0A 00 09 09 00 00 00 0D 00 02 0A 00 0E ................
0060: 0E 00 00 00 05 00 02 0A 00 0F 0F 00 00 00 05 00 ................
0070: 04 06 00 00 00 01 04 06 01 00 00 01 ............
-------
--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
