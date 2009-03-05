From: Thomas Raschbacher <lordvan@lordvan.com>
Subject: CPI message on bootup for kernel .. CPU AMD Phenom II X3 (ACPI _PSS
 objects)
Date: Thu, 05 Mar 2009 13:32:24 +0100
Message-ID: <49AFC658.2010002@lordvan.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070302030500010303020703"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server88-208-201-184.live-servers.net ([88.208.201.184]:35898
	"EHLO lordvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbZCEMdB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2009 07:33:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070302030500010303020703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I got a message about ACPI _PSS objects on bootup and that I should =
contact
the ACPI Maintainers.. So I'm doing this now.
dmesg as attachment ..
I got an ASUS M4A78T-E mainboard and an AMD Phenom II X3 cpu (AM3 socket)

If u need more info please let me know.

Regards
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkmvxcIACgkQv20tKfoYgelJzQCdHLTQhH72ECvANp7+eaU2A9xF
dFoAnRTDoyO//juDlOpVFRt3QdoqHB6B
=38I0
-----END PGP SIGNATURE-----

--------------070302030500010303020703
Content-Type: text/plain;
 name="desktopX3_dmesg2009-03-05.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="desktopX3_dmesg2009-03-05.txt"

[    0.000000] BIOS EBDA/lowmem at: 0009fc00/0009fc00
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.28-gentoo-r2ATH64 (root@livecd) (gcc version 4.3.3 (Gentoo 4.3.3 p1.0, pie-10.1.5) ) #2 SMP Tue Mar 3 19:57:28 Local time zone must be set--see zic m
[    0.000000] Command line: root=/dev/sda1 
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000d7f90000 (usable)
[    0.000000]  BIOS-e820: 00000000d7f90000 - 00000000d7fa8000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000d7fa8000 - 00000000d7fd0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000d7fd0000 - 00000000d8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working it around.
[    0.000000] last_pfn = 0x128000 max_arch_pfn = 0x3ffffffff
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xd7f90 max_arch_pfn = 0x3ffffffff
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009fc00 (usable)
[    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000d7f90000 (usable)
[    0.000000]  modified: 00000000d7f90000 - 00000000d7fa8000 (ACPI data)
[    0.000000]  modified: 00000000d7fa8000 - 00000000d7fd0000 (ACPI NVS)
[    0.000000]  modified: 00000000d7fd0000 - 00000000d8000000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] init_memory_mapping: 0000000000000000-00000000d7f90000
[    0.000000]  0000000000 - 00d7e00000 page 2M
[    0.000000]  00d7e00000 - 00d7f90000 page 4k
[    0.000000] kernel direct mapping tables up to d7f90000 @ 10000-16000
[    0.000000] last_map_addr: d7f90000 end: d7f90000
[    0.000000] init_memory_mapping: 0000000100000000-0000000128000000
[    0.000000]  0100000000 - 0128000000 page 2M
[    0.000000] kernel direct mapping tables up to 128000000 @ 14000-1a000
[    0.000000] last_map_addr: 128000000 end: 128000000
[    0.000000] ACPI: RSDP 000FB8B0, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT D7F90000, 0038 (r1 011009 RSDT1456 20090110 MSFT       97)
[    0.000000] ACPI: FACP D7F90200, 0084 (r1 011009 FACP1456 20090110 MSFT       97)
[    0.000000] ACPI Warning (tbfadt-0460): Optional field "Pm2ControlBlock" has zero address or length: 0000000000000000/1 [20080926]
[    0.000000] ACPI: DSDT D7F90440, D92D (r1  A1152 A1152000        0 INTL 20060113)
[    0.000000] ACPI: FACS D7FA8000, 0040
[    0.000000] ACPI: APIC D7F90390, 006C (r1 011009 APIC1456 20090110 MSFT       97)
[    0.000000] ACPI: MCFG D7F90400, 003C (r1 011009 OEMMCFG  20090110 MSFT       97)
[    0.000000] ACPI: OEMB D7FA8040, 0072 (r1 011009 OEMB1456 20090110 MSFT       97)
[    0.000000] ACPI: HPET D7F9F440, 0038 (r1 011009 OEMHPET  20090110 MSFT       97)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000128000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000128000000
[    0.000000]   NODE_DATA [0000000000015000 - 0000000000019fff]
[    0.000000]   bootmap [000000000001a000 -  000000000003efff] pages 25
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 0128000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 000095333c]    TEXT DATA BSS ==> [0000200000 - 000095333c]
[    0.000000]   #3 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #4 [0000010000 - 0000014000]          PGTABLE ==> [0000010000 - 0000014000]
[    0.000000]   #5 [0000014000 - 0000015000]          PGTABLE ==> [0000014000 - 0000015000]
[    0.000000] found SMP MP-table at [ffff8800000ff780] 000ff780
[    0.000000]  [ffffe20000000000-ffffe200041fffff] PMD -> [ffff880028200000-ffff88002bbfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00128000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000d7f90
[    0.000000]     0: 0x00100000 -> 0x00128000
[    0.000000] On node 0 totalpages: 1048351
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1981 pages reserved
[    0.000000]   DMA zone: 1946 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 866248 pages, LIFO batch:31
[    0.000000]   Normal zone: 2240 pages used for memmap
[    0.000000]   Normal zone: 161600 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 3, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 4 CPUs, 1 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e6000
[    0.000000] PM: Registered nosave memory: 00000000000e6000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000d7f90000 - 00000000d7fa8000
[    0.000000] PM: Registered nosave memory: 00000000d7fa8000 - 00000000d7fd0000
[    0.000000] PM: Registered nosave memory: 00000000d7fd0000 - 00000000d8000000
[    0.000000] PM: Registered nosave memory: 00000000d8000000 - 00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at dc000000 (gap: d8000000:27f00000)
[    0.000000] PERCPU: Allocating 57344 bytes of per cpu data
[    0.000000] per cpu data for cpu0 on node0 at 0000000028022000
[    0.000000] per cpu data for cpu1 on node0 at 0000000028030000
[    0.000000] per cpu data for cpu2 on node0 at 000000002803e000
[    0.000000] per cpu data for cpu3 on node0 at 000000002804c000
[    0.000000] NR_CPUS: 64, nr_cpu_ids: 4, nr_node_ids 1
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1029794
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/sda1 
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2809.631 MHz processor.
[    0.000999] Console: colour VGA+ 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Scanning for low memory corruption every 60 seconds
[    0.000999] Checking aperture...
[    0.000999] No AGP bridge found
[    0.000999] Node 0: aperture @ 20000000 size 32 MB
[    0.000999] Aperture pointing to e820 RAM. Ignoring.
[    0.000999] Your BIOS doesn't leave a aperture memory hole
[    0.000999] Please enable the IOMMU option in the BIOS setup
[    0.000999] This costs you 64 MB of RAM
[    0.000999] Mapping aperture over 65536 KB of RAM @ 20000000
[    0.000999] PM: Registered nosave memory: 0000000020000000 - 0000000024000000
[    0.000999] Memory: 4060432k/4849664k available (3399k kernel code, 656260k absent, 132972k reserved, 2371k data, 508k init)
[    0.000999] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000999] hpet clockevent registered
[    0.000999] HPET: 4 timers in total, 1 timers will be used for per-cpu timer
[    0.001006] Calibrating delay loop (skipped), value calculated using timer frequency.. 5619.25 BogoMIPS (lpj=2809627)
[    0.001567] Security Framework initialized
[    0.002003] SELinux:  Disabled at boot.
[    0.002524] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.004232] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.004978] Mount-cache hash table entries: 256
[    0.005089] Initializing cgroup subsys ns
[    0.005364] Initializing cgroup subsys cpuacct
[    0.005647] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.006001] CPU: L2 Cache: 512K (64 bytes/line)
[    0.006275] CPU 0/0x0 -> Node 0
[    0.006547] tseg: 0000000000
[    0.006553] CPU: Physical Processor ID: 0
[    0.007000] CPU: Processor Core ID: 0
[    0.007277] using C1E aware idle routine
[    0.007558] ACPI: Core revision 20080926
[    0.021030] Setting APIC routing to flat
[    0.022144] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.032423] CPU0: AMD Phenom(tm) II X3 720 Processor stepping 02
[    0.032994] Booting processor 1 APIC 0x1 ip 0x6000
[    0.000999] Initializing CPU#1
[    0.000999] Calibrating delay using timer specific routine.. 5619.17 BogoMIPS (lpj=2809589)
[    0.000999] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.000999] CPU: L2 Cache: 512K (64 bytes/line)
[    0.000999] CPU 1/0x1 -> Node 0
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 1
[    0.000999] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.103785] CPU1: AMD Phenom(tm) II X3 720 Processor stepping 02
[    0.104296] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.105044] Booting processor 2 APIC 0x2 ip 0x6000
[    0.000999] Initializing CPU#2
[    0.000999] Calibrating delay using timer specific routine.. 5619.19 BogoMIPS (lpj=2809595)
[    0.000999] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.000999] CPU: L2 Cache: 512K (64 bytes/line)
[    0.000999] CPU 2/0x2 -> Node 0
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 2
[    0.000999] x86 PAT enabled: cpu 2, old 0x7040600070406, new 0x7010600070106
[    0.177843] CPU2: AMD Phenom(tm) II X3 720 Processor stepping 02
[    0.178284] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.178994] Brought up 3 CPUs
[    0.179974] Total of 3 processors activated (16857.62 BogoMIPS).
[    0.180304] khelper used greatest stack depth: 5968 bytes left
[    0.181025] net_namespace: 1344 bytes
[    0.181446] Time:  8:19:05  Date: 03/05/09
[    0.181738] NET: Registered protocol family 16
[    0.181999] node 0 link 0: io port [1000, ffffff]
[    0.181999] TOM: 00000000d8000000 aka 3456M
[    0.182252] Fam 10h mmconf [e0000000, efffffff]
[    0.182254] node 0 link 0: mmio [a0000, bffff]
[    0.182256] node 0 link 0: mmio [d8000000, dfffffff]
[    0.182257] node 0 link 0: mmio [e0000000, efffffff] ==> none
[    0.182259] node 0 link 0: mmio [f0000000, ffefffff]
[    0.182261] TOM2: 0000000128000000 aka 4736M
[    0.182534] bus: [00,07] on node 0 link 0
[    0.182535] bus: 00 index 0 io port: [0, ffff]
[    0.182537] bus: 00 index 1 mmio: [a0000, bffff]
[    0.182538] bus: 00 index 2 mmio: [d8000000, dfffffff]
[    0.182539] bus: 00 index 3 mmio: [f0000000, ffffffff]
[    0.182541] bus: 00 index 4 mmio: [128000000, fcffffffff]
[    0.182554] ACPI: bus type pci registered
[    0.182998] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.183268] PCI: Not using MMCONFIG.
[    0.183540] PCI: Using configuration type 1 for base access
[    0.183973] PCI: Using configuration type 1 for extended access
[    0.184999] mtrr: your CPUs had inconsistent fixed MTRR settings
[    0.185251] mtrr: probably your BIOS does not setup all CPUs.
[    0.185525] mtrr: corrected configuration.
[    0.189382] ACPI: EC: Look up EC in DSDT
[    0.222513] ACPI: Interpreter enabled
[    0.222789] ACPI: (supports S0 S1 S3 S4 S5)
[    0.223235] ACPI: Using IOAPIC for interrupt routing
[    0.223568] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.229591] PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
[    0.235524] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.245068] ACPI: No dock devices found.
[    0.245409] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.246011] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.246288] pci 0000:00:02.0: PME# disabled
[    0.246583] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.246860] pci 0000:00:06.0: PME# disabled
[    0.246979] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.247256] pci 0000:00:07.0: PME# disabled
[    0.247574] pci 0000:00:11.0: reg 10 io port: [0xb000-0xb007]
[    0.247580] pci 0000:00:11.0: reg 14 io port: [0xa000-0xa003]
[    0.247586] pci 0000:00:11.0: reg 18 io port: [0x9000-0x9007]
[    0.247592] pci 0000:00:11.0: reg 1c io port: [0x8000-0x8003]
[    0.247597] pci 0000:00:11.0: reg 20 io port: [0x7000-0x700f]
[    0.247603] pci 0000:00:11.0: reg 24 32bit mmio: [0xf3fffc00-0xf3ffffff]
[    0.247619] pci 0000:00:11.0: set SATA to AHCI mode
[    0.247988] pci 0000:00:12.0: reg 10 32bit mmio: [0xf3ffd000-0xf3ffdfff]
[    0.248034] pci 0000:00:12.1: reg 10 32bit mmio: [0xf3ffe000-0xf3ffefff]
[    0.248096] pci 0000:00:12.2: reg 10 32bit mmio: [0xf3fff800-0xf3fff8ff]
[    0.248130] pci 0000:00:12.2: supports D1 D2
[    0.248131] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.248409] pci 0000:00:12.2: PME# disabled
[    0.248709] pci 0000:00:13.0: reg 10 32bit mmio: [0xf3ffb000-0xf3ffbfff]
[    0.248755] pci 0000:00:13.1: reg 10 32bit mmio: [0xf3ffc000-0xf3ffcfff]
[    0.248817] pci 0000:00:13.2: reg 10 32bit mmio: [0xf3fff400-0xf3fff4ff]
[    0.248965] pci 0000:00:13.2: supports D1 D2
[    0.248966] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.249244] pci 0000:00:13.2: PME# disabled
[    0.249611] pci 0000:00:14.1: reg 10 io port: [0x00-0x07]
[    0.249616] pci 0000:00:14.1: reg 14 io port: [0x00-0x03]
[    0.249622] pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
[    0.249627] pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
[    0.249633] pci 0000:00:14.1: reg 20 io port: [0xff00-0xff0f]
[    0.249682] pci 0000:00:14.2: reg 10 64bit mmio: [0xf3ff4000-0xf3ff7fff]
[    0.249712] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.249964] pci 0000:00:14.2: PME# disabled
[    0.250324] pci 0000:00:14.5: reg 10 32bit mmio: [0xf3ffa000-0xf3ffafff]
[    0.250434] pci 0000:01:00.0: reg 10 32bit mmio: [0xf4000000-0xf7ffffff]
[    0.250441] pci 0000:01:00.0: reg 14 64bit mmio: [0xd8000000-0xdfffffff]
[    0.250449] pci 0000:01:00.0: reg 1c 64bit mmio: [0xfa000000-0xfaffffff]
[    0.250456] pci 0000:01:00.0: reg 30 32bit mmio: [0xfbce0000-0xfbcfffff]
[    0.250505] pci 0000:00:02.0: bridge 32bit mmio: [0xf4000000-0xfbcfffff]
[    0.250508] pci 0000:00:02.0: bridge 64bit mmio pref: [0xd8000000-0xdfffffff]
[    0.250548] pci 0000:02:00.0: reg 10 64bit mmio: [0xfbdc0000-0xfbdfffff]
[    0.250554] pci 0000:02:00.0: reg 18 io port: [0xcc00-0xcc7f]
[    0.250582] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.250860] pci 0000:02:00.0: PME# disabled
[    0.251008] pci 0000:00:06.0: bridge io port: [0xc000-0xcfff]
[    0.251010] pci 0000:00:06.0: bridge 32bit mmio: [0xfbd00000-0xfbdfffff]
[    0.251071] pci 0000:03:00.0: reg 10 64bit mmio: [0xfbeff800-0xfbefffff]
[    0.251080] pci 0000:03:00.0: reg 18 io port: [0xd800-0xd8ff]
[    0.251124] pci 0000:03:00.0: supports D2
[    0.251125] pci 0000:03:00.0: PME# supported from D2 D3hot D3cold
[    0.251405] pci 0000:03:00.0: PME# disabled
[    0.251732] pci 0000:00:07.0: bridge io port: [0xd000-0xdfff]
[    0.251734] pci 0000:00:07.0: bridge 32bit mmio: [0xfbe00000-0xfbefffff]
[    0.251987] pci 0000:04:05.0: reg 10 io port: [0xe800-0xe8ff]
[    0.251994] pci 0000:04:05.0: reg 14 32bit mmio: [0xfbfffc00-0xfbfffcff]
[    0.252034] pci 0000:04:05.0: supports D1 D2
[    0.252035] pci 0000:04:05.0: PME# supported from D1 D2 D3hot
[    0.252314] pci 0000:04:05.0: PME# disabled
[    0.252612] pci 0000:04:06.0: reg 10 32bit mmio: [0xfbffe000-0xfbffefff]
[    0.252688] pci 0000:00:14.4: transparent bridge
[    0.252964] pci 0000:00:14.4: bridge io port: [0xe000-0xefff]
[    0.252967] pci 0000:00:14.4: bridge 32bit mmio: [0xfbf00000-0xfbffffff]
[    0.252985] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.253362] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE2._PRT]
[    0.253478] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE6._PRT]
[    0.253585] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
[    0.253710] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.257058] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 *7 10 11 12 14 15)
[    0.257780] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 *10 11 12 14 15)
[    0.258497] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 *10 12 14 15)
[    0.259085] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 *11 12 14 15)
[    0.259802] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 *10 11 12 14 15)
[    0.260602] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 *10 11 12 14 15)
[    0.261085] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 10 *11 12 14 15)
[    0.262031] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 12 14 15) *0, disabled.
[    0.263004] ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] - D9, should be D0 [20080926]
[    0.263608] SCSI subsystem initialized
[    0.264001] libata version 3.00 loaded.
[    0.264016] usbcore: registered new interface driver usbfs
[    0.264248] usbcore: registered new interface driver hub
[    0.264961] usbcore: registered new device driver usb
[    0.265241] PCI: Using ACPI for IRQ routing
[    0.271984] cfg80211: Using static regulatory domain info
[    0.272238] cfg80211: Regulatory domain: US
[    0.272512] 	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[    0.272960] 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
[    0.273237] 	(5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    0.273515] 	(5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    0.273793] 	(5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    0.273959] 	(5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    0.274236] 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
[    0.274513] cfg80211: Calling CRDA for country: US
[    0.274973] NetLabel: Initializing
[    0.275232] NetLabel:  domain hash size = 128
[    0.275507] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.275789] NetLabel:  unlabeled traffic allowed by default
[    0.276065] PCI-DMA: Disabling AGP.
[    0.276391] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    0.276958] PCI-DMA: using GART IOMMU.
[    0.277233] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.279059] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 2303, 0
[    0.279514] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    0.280978] hpet: hpet2 irq 2303 for MSI
[    0.285980] pnp: PnP ACPI init
[    0.286265] ACPI: bus type pnp registered
[    0.291690] pnp: PnP ACPI: found 16 devices
[    0.291968] ACPI: ACPI bus type pnp unregistered
[    0.292251] system 00:09: iomem range 0xfec00000-0xfec00fff has been reserved
[    0.292529] system 00:09: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.292810] system 00:0a: ioport range 0x4d0-0x4d1 has been reserved
[    0.293090] system 00:0a: ioport range 0x40b-0x40b has been reserved
[    0.293368] system 00:0a: ioport range 0x4d6-0x4d6 has been reserved
[    0.293645] system 00:0a: ioport range 0xc00-0xc01 has been reserved
[    0.293922] system 00:0a: ioport range 0xc14-0xc14 has been reserved
[    0.294202] system 00:0a: ioport range 0xc50-0xc51 has been reserved
[    0.294479] system 00:0a: ioport range 0xc52-0xc52 has been reserved
[    0.294756] system 00:0a: ioport range 0xc6c-0xc6c has been reserved
[    0.295035] system 00:0a: ioport range 0xc6f-0xc6f has been reserved
[    0.295312] system 00:0a: ioport range 0xcd0-0xcd1 has been reserved
[    0.295589] system 00:0a: ioport range 0xcd2-0xcd3 has been reserved
[    0.295866] system 00:0a: ioport range 0xcd4-0xcd5 has been reserved
[    0.296146] system 00:0a: ioport range 0xcd6-0xcd7 has been reserved
[    0.296423] system 00:0a: ioport range 0xcd8-0xcdf has been reserved
[    0.296700] system 00:0a: ioport range 0xb00-0xb3f has been reserved
[    0.296979] system 00:0a: ioport range 0x800-0x89f has been reserved
[    0.297256] system 00:0a: ioport range 0xb00-0xb0f has been reserved
[    0.297534] system 00:0a: ioport range 0xb20-0xb3f has been reserved
[    0.297810] system 00:0a: ioport range 0x900-0x90f has been reserved
[    0.298090] system 00:0a: ioport range 0x910-0x91f has been reserved
[    0.298367] system 00:0a: ioport range 0xfe00-0xfefe has been reserved
[    0.298645] system 00:0a: iomem range 0xffb80000-0xffbfffff has been reserved
[    0.298924] system 00:0a: iomem range 0xfec10000-0xfec1001f has been reserved
[    0.299206] system 00:0d: ioport range 0x230-0x23f has been reserved
[    0.299483] system 00:0d: ioport range 0x290-0x29f has been reserved
[    0.299762] system 00:0d: ioport range 0xf40-0xf4f has been reserved
[    0.300042] system 00:0d: ioport range 0xa30-0xa3f has been reserved
[    0.300321] system 00:0e: iomem range 0xe0000000-0xefffffff has been reserved
[    0.300600] system 00:0f: iomem range 0x0-0x9ffff could not be reserved
[    0.300877] system 00:0f: iomem range 0xc0000-0xcffff has been reserved
[    0.301158] system 00:0f: iomem range 0xe0000-0xfffff could not be reserved
[    0.301435] system 00:0f: iomem range 0x100000-0xd7ffffff could not be reserved
[    0.301947] system 00:0f: iomem range 0xfec00000-0xffffffff could not be reserved
[    0.307150] pci 0000:00:02.0: PCI bridge, secondary bus 0000:01
[    0.307427] pci 0000:00:02.0:   IO window: disabled
[    0.307704] pci 0000:00:02.0:   MEM window: 0xf4000000-0xfbcfffff
[    0.307984] pci 0000:00:02.0:   PREFETCH window: 0x000000d8000000-0x000000dfffffff
[    0.308496] pci 0000:00:06.0: PCI bridge, secondary bus 0000:02
[    0.308773] pci 0000:00:06.0:   IO window: 0xc000-0xcfff
[    0.309052] pci 0000:00:06.0:   MEM window: 0xfbd00000-0xfbdfffff
[    0.309329] pci 0000:00:06.0:   PREFETCH window: disabled
[    0.309606] pci 0000:00:07.0: PCI bridge, secondary bus 0000:03
[    0.309883] pci 0000:00:07.0:   IO window: 0xd000-0xdfff
[    0.310162] pci 0000:00:07.0:   MEM window: 0xfbe00000-0xfbefffff
[    0.310439] pci 0000:00:07.0:   PREFETCH window: disabled
[    0.310716] pci 0000:00:14.4: PCI bridge, secondary bus 0000:04
[    0.310996] pci 0000:00:14.4:   IO window: 0xe000-0xefff
[    0.311274] pci 0000:00:14.4:   MEM window: 0xfbf00000-0xfbffffff
[    0.311552] pci 0000:00:14.4:   PREFETCH window: disabled
[    0.311837] pci 0000:00:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    0.312119] pci 0000:00:02.0: setting latency timer to 64
[    0.312122] pci 0000:00:06.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    0.312400] pci 0000:00:06.0: setting latency timer to 64
[    0.312404] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    0.312681] pci 0000:00:07.0: setting latency timer to 64
[    0.312687] bus: 00 index 0 io port: [0x00-0xffff]
[    0.312964] bus: 00 index 1 mmio: [0x000000-0xffffffffffffffff]
[    0.313241] bus: 01 index 0 mmio: [0x0-0x0]
[    0.313514] bus: 01 index 1 mmio: [0xf4000000-0xfbcfffff]
[    0.313790] bus: 01 index 2 mmio: [0xd8000000-0xdfffffff]
[    0.314068] bus: 01 index 3 mmio: [0x0-0x0]
[    0.314342] bus: 02 index 0 io port: [0xc000-0xcfff]
[    0.314618] bus: 02 index 1 mmio: [0xfbd00000-0xfbdfffff]
[    0.314893] bus: 02 index 2 mmio: [0x0-0x0]
[    0.315169] bus: 02 index 3 mmio: [0x0-0x0]
[    0.315442] bus: 03 index 0 io port: [0xd000-0xdfff]
[    0.315717] bus: 03 index 1 mmio: [0xfbe00000-0xfbefffff]
[    0.315995] bus: 03 index 2 mmio: [0x0-0x0]
[    0.316269] bus: 03 index 3 mmio: [0x0-0x0]
[    0.316542] bus: 04 index 0 io port: [0xe000-0xefff]
[    0.316817] bus: 04 index 1 mmio: [0xfbf00000-0xfbffffff]
[    0.317095] bus: 04 index 2 mmio: [0x0-0x0]
[    0.317369] bus: 04 index 3 io port: [0x00-0xffff]
[    0.317643] bus: 04 index 4 mmio: [0x000000-0xffffffffffffffff]
[    0.317927] NET: Registered protocol family 2
[    0.328067] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.329365] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.331784] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.332315] TCP: Hash tables configured (established 524288 bind 65536)
[    0.332593] TCP reno registered
[    0.335032] NET: Registered protocol family 1
[    0.336624] microcode: collect_cpu_info_amd : patch_id=0x1000086
[    0.336909] microcode: collect_cpu_info_amd : patch_id=0x1000086
[    0.337201] microcode: collect_cpu_info_amd : patch_id=0x1000086
[    0.337481] Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.338062] alg: cipher: Test 1 failed on encryption for aes-asm
[    0.338341] 00000000: 00 01 02 03 04 05 06 07 08 08 08 08 08 08 08 08 
[    0.338831] audit: initializing netlink socket (disabled)
[    0.339123] type=2000 audit(1236241144.338:1): initialized
[    0.344248] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.346384] VFS: Disk quotas dquot_6.5.1
[    0.346708] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.347325] msgmni has been set to 7930
[    0.348039] alg: No test for stdrng (krng)
[    0.348408] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.348922] io scheduler noop registered
[    0.349195] io scheduler anticipatory registered
[    0.349469] io scheduler deadline registered
[    0.349862] io scheduler cfq registered (default)
[    0.480946] pci 0000:01:00.0: Boot video device
[    0.485750] pcieport-driver 0000:00:02.0: setting latency timer to 64
[    0.485766] pcieport-driver 0000:00:02.0: found MSI capability
[    0.486057] pcieport-driver 0000:00:02.0: irq 2302 for MSI/MSI-X
[    0.486063] pci_express 0000:00:02.0:pcie00: allocate port service
[    0.486093] pci_express 0000:00:02.0:pcie03: allocate port service
[    0.486138] pcieport-driver 0000:00:06.0: setting latency timer to 64
[    0.486154] pcieport-driver 0000:00:06.0: found MSI capability
[    0.486439] pcieport-driver 0000:00:06.0: irq 2301 for MSI/MSI-X
[    0.486444] pci_express 0000:00:06.0:pcie00: allocate port service
[    0.486475] pci_express 0000:00:06.0:pcie03: allocate port service
[    0.486519] pcieport-driver 0000:00:07.0: setting latency timer to 64
[    0.486534] pcieport-driver 0000:00:07.0: found MSI capability
[    0.492666] pcieport-driver 0000:00:07.0: irq 2300 for MSI/MSI-X
[    0.492671] pci_express 0000:00:07.0:pcie00: allocate port service
[    0.492727] pci_express 0000:00:07.0:pcie03: allocate port service
[    0.495127] Non-volatile memory driver v1.2
[    0.495412] Linux agpgart interface v0.103
[    0.495738] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[    0.496253] Hangcheck: Using get_cycles().
[    0.496624] input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.501922] ACPI: Power Button (FF) [PWRF]
[    0.502286] input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    0.504928] ACPI: Power Button (CM) [PWRB]
[    0.505421] processor ACPI_CPU:00: registered as cooling_device0
[    0.505700] ACPI: Processor [P001] (supports 8 throttling states)
[    0.506118] processor ACPI_CPU:01: registered as cooling_device1
[    0.506435] processor ACPI_CPU:02: registered as cooling_device2
[    0.509493] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    0.568851] Switched to high resolution mode on CPU 1
[    0.568909] Switched to high resolution mode on CPU 2
[    0.568956] Switched to high resolution mode on CPU 0
[    0.693188] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.693851] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.695224] brd: module loaded
[    0.695499] Uniform Multi-Platform E-IDE driver
[    0.695865] atiixp 0000:00:14.1: IDE controller (0x1002:0x439c rev 0x00)
[    0.696154] pci 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.696445] atiixp 0000:00:14.1: not 100% native mode: will probe irqs later
[    0.696725]     ide0: BM-DMA at 0xff00-0xff07
[    0.697012]     ide1: BM-DMA at 0xff08-0xff0f
[    0.697288] Probing IDE interface ide0...
[    1.369337] hda: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
[    1.675099] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    1.675212] hda: UDMA/33 mode selected
[    1.675597] Probing IDE interface ide1...
[    2.194106] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.196022] ide1 at 0x170-0x177,0x376 on irq 15
[    2.196514] ide-gd driver 1.18
[    2.196864] Loading iSCSI transport class v2.0-870.
[    2.197313] Driver 'sd' needs updating - please use bus_type methods
[    2.197615] Driver 'sr' needs updating - please use bus_type methods
[    2.197924] ahci 0000:00:11.0: version 3.0
[    2.197933] ahci 0000:00:11.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    2.198294] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    2.198806] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.199535] scsi0 : ahci
[    2.199916] scsi1 : ahci
[    2.200269] scsi2 : ahci
[    2.200616] scsi3 : ahci
[    2.200983] ata1: SATA max UDMA/133 irq_stat 0x00400000, PHY RDY changed irq 22
[    2.201503] ata2: SATA max UDMA/133 abar m1024@0xf3fffc00 port 0xf3fffd80 irq 22
[    2.202018] ata3: SATA max UDMA/133 abar m1024@0xf3fffc00 port 0xf3fffe00 irq 22
[    2.202532] ata4: SATA max UDMA/133 abar m1024@0xf3fffc00 port 0xf3fffe80 irq 22
[    3.078033] ata1: softreset failed (device not ready)
[    3.078318] ata1: failed due to HW bug, retry pmp=0
[    3.231042] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.259972] ata1.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
[    3.260263] ata1.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    3.302382] ata1.00: configured for UDMA/133
[    3.618033] ata2: SATA link down (SStatus 0 SControl 300)
[    3.934033] ata3: SATA link down (SStatus 0 SControl 300)
[    4.250034] ata4: SATA link down (SStatus 0 SControl 300)
[    4.261088] scsi 0:0:0:0: Direct-Access     ATA      ST31500341AS     CC1H PQ: 0 ANSI: 5
[    4.261762] sd 0:0:0:0: [sda] 2930277168 512-byte hardware sectors: (1.50 TB/1.36 TiB)
[    4.262286] sd 0:0:0:0: [sda] Write Protect is off
[    4.262562] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.262574] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.263125] sd 0:0:0:0: [sda] 2930277168 512-byte hardware sectors: (1.50 TB/1.36 TiB)
[    4.263648] sd 0:0:0:0: [sda] Write Protect is off
[    4.263923] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.263935] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.264456]  sda: sda1 sda2 sda3
[    4.283947] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.284487] usbcore: registered new interface driver libusual
[    4.284826] PNP: PS/2 Controller [PNP0303:PSKE,PNP0f03:PSMS] at 0x60,0x64 irq 1,12
[    4.285662] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.285939] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.286270] mice: PS/2 mouse device common for all mice
[    4.293440] rtc_cmos 00:05: RTC can wake from S4
[    4.293756] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    4.294054] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    4.294369] EDAC MC: Ver: 2.1.0 Mar  3 2009
[    4.294827] cpuidle: using governor ladder
[    4.295104] cpuidle: using governor menu
[    4.295382] No iBFT detected.
[    4.296309] usbcore: registered new interface driver hiddev
[    4.296612] usbcore: registered new interface driver usbhid
[    4.296888] usbhid: v2.6:USB HID core driver
[    4.297245] Netfilter messages via NETLINK v0.30.
[    4.297529] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    4.297982] ctnetlink v0.93: registering with nfnetlink.
[    4.298629] ip_tables: (C) 2000-2006 Netfilter Core Team
[    4.298920] TCP cubic registered
[    4.299195] Initializing XFRM netlink socket
[    4.299552] NET: Registered protocol family 10
[    4.300264] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    4.300575] IPv6 over IPv4 tunneling driver
[    4.301244] NET: Registered protocol family 17
[    4.301529] NET: Registered protocol family 15
[    4.301843] powernow-k8: Found 1 AMD Phenom(tm) II X3 720 Processor processors (3 cpu cores) (version 2.20.00)
[    4.302373] [Firmware Bug]: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
[    4.303152] [Firmware Bug]: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
[    4.303932] [Firmware Bug]: powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that Linux understands. Please report this to the Linux ACPI maintainers and complain to your BIOS vendor.
[    4.304843] registered taskstats version 1
[    4.305204]   Magic number: 1:473:320
[    4.305488] tty tty45: hash matches
[    4.305766] platform microcode: hash matches
[    4.306041] misc microcode: hash matches
[    4.408132] EXT3-fs: INFO: recovery required on readonly filesystem.
[    4.408413] EXT3-fs: write access will be enabled during recovery.
[    8.589226] kjournald starting.  Commit interval 5 seconds
[    8.589234] EXT3-fs: recovery complete.
[    8.597987] EXT3-fs: mounted filesystem with ordered data mode.
[    8.598282] VFS: Mounted root (ext3 filesystem) readonly.
[    8.598570] Freeing unused kernel memory: 508k freed
[    8.598952] Write protecting the kernel read-only data: 5252k
[    8.738778] khelper used greatest stack depth: 5184 bytes left
[    9.128556] init-early.sh used greatest stack depth: 3936 bytes left
[   10.484134] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   10.492171] 8139too Fast Ethernet driver 0.9.28
[   10.492200] 8139too 0000:04:05.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[   10.493309] eth0: RealTek RTL8139 at 0xe800, 00:00:21:fe:11:67, IRQ 20
[   10.493311] eth0:  Identified 8139 chip type 'RTL-8139B'
[   10.494496] ATL1E 0000:02:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   10.494503] ATL1E 0000:02:00.0: setting latency timer to 64
[   10.520142] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   10.746967] ohci1394 0000:03:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   10.746974] ohci1394 0000:03:00.0: setting latency timer to 64
[   10.758860] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   10.758862] ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
[   10.758891] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   10.758917] ehci_hcd 0000:00:12.2: EHCI Host Controller
[   10.758944] drivers/usb/core/inode.c: creating file 'devices'
[   10.758947] drivers/usb/core/inode.c: creating file '001'
[   10.758975] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
[   10.758981] ehci_hcd 0000:00:12.2: reset hcs_params 0x102306 dbg=1 cc=2 pcc=3 ordered !ppc ports=6
[   10.758984] ehci_hcd 0000:00:12.2: reset hcc_params a072 thresh 7 uframes 256/512/1024
[   10.759009] ehci_hcd 0000:00:12.2: applying AMD SB600/SB700 USB freeze workaround
[   10.759015] ehci_hcd 0000:00:12.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[   10.759027] ehci_hcd 0000:00:12.2: debug port 1
[   10.759032] ehci_hcd 0000:00:12.2: MWI active
[   10.759033] ehci_hcd 0000:00:12.2: supports USB remote wakeup
[   10.759044] ehci_hcd 0000:00:12.2: irq 17, io mem 0xf3fff800
[   10.759047] ehci_hcd 0000:00:12.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[   10.759052] ehci_hcd 0000:00:12.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
[   10.765020] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[   10.765039] usb usb1: default language 0x0409
[   10.765068] usb usb1: uevent
[   10.765077] usb usb1: usb_probe_device
[   10.765079] usb usb1: configuration #1 chosen from 1 choice
[   10.765083] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[   10.765091] usb 1-0:1.0: uevent
[   10.765098] hub 1-0:1.0: usb_probe_interface
[   10.765099] hub 1-0:1.0: usb_probe_interface - got id
[   10.765101] hub 1-0:1.0: USB hub found
[   10.765105] hub 1-0:1.0: 6 ports detected
[   10.765106] hub 1-0:1.0: standalone hub
[   10.765107] hub 1-0:1.0: no power switching (usb 1.0)
[   10.765108] hub 1-0:1.0: individual port over-current protection
[   10.765110] hub 1-0:1.0: power on to power good time: 20ms
[   10.765112] hub 1-0:1.0: local power source is good
[   10.765114] hub 1-0:1.0: trying to enable port power on non-switchable hub
[   10.765159] drivers/usb/core/inode.c: creating file '001'
[   10.765180] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   10.765182] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.765183] usb usb1: Product: EHCI Host Controller
[   10.765185] usb usb1: Manufacturer: Linux 2.6.28-gentoo-r2ATH64 ehci_hcd
[   10.765186] usb usb1: SerialNumber: 0000:00:12.2
[   10.765199] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[   10.765214] ehci_hcd 0000:00:13.2: EHCI Host Controller
[   10.765230] drivers/usb/core/inode.c: creating file '002'
[   10.765246] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
[   10.765251] ehci_hcd 0000:00:13.2: reset hcs_params 0x102306 dbg=1 cc=2 pcc=3 ordered !ppc ports=6
[   10.765254] ehci_hcd 0000:00:13.2: reset hcc_params a072 thresh 7 uframes 256/512/1024
[   10.765268] ehci_hcd 0000:00:13.2: applying AMD SB600/SB700 USB freeze workaround
[   10.765274] ehci_hcd 0000:00:13.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[   10.765286] ehci_hcd 0000:00:13.2: debug port 1
[   10.765290] ehci_hcd 0000:00:13.2: MWI active
[   10.765291] ehci_hcd 0000:00:13.2: supports USB remote wakeup
[   10.765301] ehci_hcd 0000:00:13.2: irq 19, io mem 0xf3fff400
[   10.765304] ehci_hcd 0000:00:13.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[   10.765309] ehci_hcd 0000:00:13.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
[   10.765809] ACPI: WMI: Mapper loaded
[   10.772022] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[   10.772037] usb usb2: default language 0x0409
[   10.772065] usb usb2: uevent
[   10.772073] usb usb2: usb_probe_device
[   10.772075] usb usb2: configuration #1 chosen from 1 choice
[   10.772078] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[   10.772086] usb 2-0:1.0: uevent
[   10.772092] hub 2-0:1.0: usb_probe_interface
[   10.772094] hub 2-0:1.0: usb_probe_interface - got id
[   10.772095] hub 2-0:1.0: USB hub found
[   10.772099] hub 2-0:1.0: 6 ports detected
[   10.772100] hub 2-0:1.0: standalone hub
[   10.772101] hub 2-0:1.0: no power switching (usb 1.0)
[   10.772102] hub 2-0:1.0: individual port over-current protection
[   10.772103] hub 2-0:1.0: power on to power good time: 20ms
[   10.772106] hub 2-0:1.0: local power source is good
[   10.772107] hub 2-0:1.0: trying to enable port power on non-switchable hub
[   10.772149] drivers/usb/core/inode.c: creating file '001'
[   10.772174] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[   10.772176] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.772177] usb usb2: Product: EHCI Host Controller
[   10.772178] usb usb2: Manufacturer: Linux 2.6.28-gentoo-r2ATH64 ehci_hcd
[   10.772180] usb usb2: SerialNumber: 0000:00:13.2
[   10.780447] Linux video capture interface: v2.00
[   10.786080] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   10.786082] ohci_hcd: block sizes: ed 80 td 96
[   10.786099] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   10.786117] ohci_hcd 0000:00:12.0: OHCI Host Controller
[   10.786139] drivers/usb/core/inode.c: creating file '003'
[   10.786158] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 3
[   10.786165] ohci_hcd 0000:00:12.0: enabled AMD ISO transfers quirk
[   10.786178] ohci_hcd 0000:00:12.0: created debug files
[   10.786179] ohci_hcd 0000:00:12.0: supports USB remote wakeup
[   10.786189] ohci_hcd 0000:00:12.0: irq 16, io mem 0xf3ffd000
[   10.800111] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[fbeff800-fbefffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   10.832627] Linux video codec intermediate layer: v0.2
[   10.840156] ohci_hcd 0000:00:12.0: OHCI controller state
[   10.840160] ohci_hcd 0000:00:12.0: OHCI 1.0, NO legacy support registers
[   10.840163] ohci_hcd 0000:00:12.0: control 0x083 HCFS=operational CBSR=3
[   10.840166] ohci_hcd 0000:00:12.0: cmdstatus 0x00000 SOC=0
[   10.840169] ohci_hcd 0000:00:12.0: intrstatus 0x00000004 SF
[   10.840172] ohci_hcd 0000:00:12.0: intrenable 0x8000001a MIE UE RD WDH
[   10.840181] ohci_hcd 0000:00:12.0: hcca frame #0005
[   10.840185] ohci_hcd 0000:00:12.0: roothub.a 02001203 POTPGT=2 NOCP NPS NDP=3(3)
[   10.840187] ohci_hcd 0000:00:12.0: roothub.b 00000000 PPCM=0000 DR=0000
[   10.840190] ohci_hcd 0000:00:12.0: roothub.status 00008000 DRWE
[   10.840193] ohci_hcd 0000:00:12.0: roothub.portstatus [0] 0x00000100 PPS
[   10.840196] ohci_hcd 0000:00:12.0: roothub.portstatus [1] 0x00000100 PPS
[   10.840199] ohci_hcd 0000:00:12.0: roothub.portstatus [2] 0x00000100 PPS
[   10.840210] usb usb3: default language 0x0409
[   10.840240] usb usb3: uevent
[   10.840254] usb usb3: usb_probe_device
[   10.840256] usb usb3: configuration #1 chosen from 1 choice
[   10.840260] usb usb3: adding 3-0:1.0 (config #1, interface 0)
[   10.840272] usb 3-0:1.0: uevent
[   10.840279] hub 3-0:1.0: usb_probe_interface
[   10.840280] hub 3-0:1.0: usb_probe_interface - got id
[   10.840281] hub 3-0:1.0: USB hub found
[   10.840289] hub 3-0:1.0: 3 ports detected
[   10.840290] hub 3-0:1.0: standalone hub
[   10.840291] hub 3-0:1.0: no power switching (usb 1.0)
[   10.840292] hub 3-0:1.0: no over-current protection
[   10.840293] hub 3-0:1.0: power on to power good time: 4ms
[   10.840297] hub 3-0:1.0: local power source is good
[   10.840298] hub 3-0:1.0: trying to enable port power on non-switchable hub
[   10.840321] drivers/usb/core/inode.c: creating file '001'
[   10.840343] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[   10.840345] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.840347] usb usb3: Product: OHCI Host Controller
[   10.840348] usb usb3: Manufacturer: Linux 2.6.28-gentoo-r2ATH64 ohci_hcd
[   10.840349] usb usb3: SerialNumber: 0000:00:12.0
[   10.840369] ohci_hcd 0000:00:12.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   10.840387] ohci_hcd 0000:00:12.1: OHCI Host Controller
[   10.840404] drivers/usb/core/inode.c: creating file '004'
[   10.840421] ohci_hcd 0000:00:12.1: new USB bus registered, assigned bus number 4
[   10.840426] ohci_hcd 0000:00:12.1: enabled AMD ISO transfers quirk
[   10.840436] ohci_hcd 0000:00:12.1: created debug files
[   10.840437] ohci_hcd 0000:00:12.1: supports USB remote wakeup
[   10.840441] ohci_hcd 0000:00:12.1: irq 16, io mem 0xf3ffe000
[   10.864033] ehci_hcd 0000:00:12.2: GetStatus port 1 status 001403 POWER sig=k CSC CONNECT
[   10.864037] hub 1-0:1.0: port 1: status 0501 change 0001
[   10.864044] ehci_hcd 0000:00:12.2: GetStatus port 2 status 001403 POWER sig=k CSC CONNECT
[   10.864046] hub 1-0:1.0: port 2: status 0501 change 0001
[   10.871054] hub 2-0:1.0: state 7 ports 6 chg 0000 evt 0000
[   10.895033] ohci_hcd 0000:00:12.1: OHCI controller state
[   10.895037] ohci_hcd 0000:00:12.1: OHCI 1.0, NO legacy support registers
[   10.895040] ohci_hcd 0000:00:12.1: control 0x083 HCFS=operational CBSR=3
[   10.895043] ohci_hcd 0000:00:12.1: cmdstatus 0x00000 SOC=0
[   10.895046] ohci_hcd 0000:00:12.1: intrstatus 0x00000004 SF
[   10.895049] ohci_hcd 0000:00:12.1: intrenable 0x8000001a MIE UE RD WDH
[   10.895058] ohci_hcd 0000:00:12.1: hcca frame #0005
[   10.895061] ohci_hcd 0000:00:12.1: roothub.a 02001203 POTPGT=2 NOCP NPS NDP=3(3)
[   10.895064] ohci_hcd 0000:00:12.1: roothub.b 00000000 PPCM=0000 DR=0000
[   10.895067] ohci_hcd 0000:00:12.1: roothub.status 00008000 DRWE
[   10.895070] ohci_hcd 0000:00:12.1: roothub.portstatus [0] 0x00000100 PPS
[   10.895073] ohci_hcd 0000:00:12.1: roothub.portstatus [1] 0x00000100 PPS
[   10.895075] ohci_hcd 0000:00:12.1: roothub.portstatus [2] 0x00000100 PPS
[   10.895085] usb usb4: default language 0x0409
[   10.895116] usb usb4: uevent
[   10.895129] usb usb4: usb_probe_device
[   10.895131] usb usb4: configuration #1 chosen from 1 choice
[   10.895135] usb usb4: adding 4-0:1.0 (config #1, interface 0)
[   10.895146] usb 4-0:1.0: uevent
[   10.895153] hub 4-0:1.0: usb_probe_interface
[   10.895154] hub 4-0:1.0: usb_probe_interface - got id
[   10.895155] hub 4-0:1.0: USB hub found
[   10.895163] hub 4-0:1.0: 3 ports detected
[   10.895164] hub 4-0:1.0: standalone hub
[   10.895165] hub 4-0:1.0: no power switching (usb 1.0)
[   10.895166] hub 4-0:1.0: no over-current protection
[   10.895167] hub 4-0:1.0: power on to power good time: 4ms
[   10.895171] hub 4-0:1.0: local power source is good
[   10.895172] hub 4-0:1.0: trying to enable port power on non-switchable hub
[   10.895195] drivers/usb/core/inode.c: creating file '001'
[   10.895219] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[   10.895221] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.895223] usb usb4: Product: OHCI Host Controller
[   10.895224] usb usb4: Manufacturer: Linux 2.6.28-gentoo-r2ATH64 ohci_hcd
[   10.895225] usb usb4: SerialNumber: 0000:00:12.1
[   10.895247] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   10.895271] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   10.895287] drivers/usb/core/inode.c: creating file '005'
[   10.895306] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
[   10.895310] ohci_hcd 0000:00:13.0: enabled AMD ISO transfers quirk
[   10.895322] ohci_hcd 0000:00:13.0: created debug files
[   10.895323] ohci_hcd 0000:00:13.0: supports USB remote wakeup
[   10.895334] ohci_hcd 0000:00:13.0: irq 18, io mem 0xf3ffb000
[   10.940037] hub 3-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   10.950034] ohci_hcd 0000:00:13.0: OHCI controller state
[   10.950039] ohci_hcd 0000:00:13.0: OHCI 1.0, NO legacy support registers
[   10.950042] ohci_hcd 0000:00:13.0: control 0x083 HCFS=operational CBSR=3
[   10.950045] ohci_hcd 0000:00:13.0: cmdstatus 0x00000 SOC=0
[   10.950048] ohci_hcd 0000:00:13.0: intrstatus 0x00000004 SF
[   10.950051] ohci_hcd 0000:00:13.0: intrenable 0x8000001a MIE UE RD WDH
[   10.950060] ohci_hcd 0000:00:13.0: hcca frame #0005
[   10.950064] ohci_hcd 0000:00:13.0: roothub.a 02001203 POTPGT=2 NOCP NPS NDP=3(3)
[   10.950067] ohci_hcd 0000:00:13.0: roothub.b 00000000 PPCM=0000 DR=0000
[   10.950069] ohci_hcd 0000:00:13.0: roothub.status 00008000 DRWE
[   10.950073] ohci_hcd 0000:00:13.0: roothub.portstatus [0] 0x00000100 PPS
[   10.950075] ohci_hcd 0000:00:13.0: roothub.portstatus [1] 0x00000100 PPS
[   10.950078] ohci_hcd 0000:00:13.0: roothub.portstatus [2] 0x00000100 PPS
[   10.950094] usb usb5: default language 0x0409
[   10.950155] usb usb5: uevent
[   10.950169] usb usb5: usb_probe_device
[   10.950171] usb usb5: configuration #1 chosen from 1 choice
[   10.950178] usb usb5: adding 5-0:1.0 (config #1, interface 0)
[   10.950187] usb 5-0:1.0: uevent
[   10.950195] hub 5-0:1.0: usb_probe_interface
[   10.950197] hub 5-0:1.0: usb_probe_interface - got id
[   10.950198] hub 5-0:1.0: USB hub found
[   10.950208] hub 5-0:1.0: 3 ports detected
[   10.950209] hub 5-0:1.0: standalone hub
[   10.950210] hub 5-0:1.0: no power switching (usb 1.0)
[   10.950211] hub 5-0:1.0: no over-current protection
[   10.950212] hub 5-0:1.0: power on to power good time: 4ms
[   10.950217] hub 5-0:1.0: local power source is good
[   10.950219] hub 5-0:1.0: trying to enable port power on non-switchable hub
[   10.950248] drivers/usb/core/inode.c: creating file '001'
[   10.950277] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[   10.950279] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.950281] usb usb5: Product: OHCI Host Controller
[   10.950282] usb usb5: Manufacturer: Linux 2.6.28-gentoo-r2ATH64 ohci_hcd
[   10.950284] usb usb5: SerialNumber: 0000:00:13.0
[   10.950313] ohci_hcd 0000:00:13.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   10.950335] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   10.950351] drivers/usb/core/inode.c: creating file '006'
[   10.950373] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 6
[   10.950378] ohci_hcd 0000:00:13.1: enabled AMD ISO transfers quirk
[   10.950392] ohci_hcd 0000:00:13.1: created debug files
[   10.950393] ohci_hcd 0000:00:13.1: supports USB remote wakeup
[   10.950399] ohci_hcd 0000:00:13.1: irq 18, io mem 0xf3ffc000
[   10.957576] nvidia: module license 'NVIDIA' taints kernel.
[   10.965030] hub 1-0:1.0: state 7 ports 6 chg 0006 evt 0000
[   10.965039] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[   10.965045] ehci_hcd 0000:00:12.2: port 1 low speed --> companion
[   11.005309] ohci_hcd 0000:00:13.1: OHCI controller state
[   11.005312] ohci_hcd 0000:00:13.1: OHCI 1.0, NO legacy support registers
[   11.005316] ohci_hcd 0000:00:13.1: control 0x083 HCFS=operational CBSR=3
[   11.005319] ohci_hcd 0000:00:13.1: cmdstatus 0x00000 SOC=0
[   11.005322] ohci_hcd 0000:00:13.1: intrstatus 0x00000004 SF
[   11.005325] ohci_hcd 0000:00:13.1: intrenable 0x8000001a MIE UE RD WDH
[   11.005334] ohci_hcd 0000:00:13.1: hcca frame #0005
[   11.005337] ohci_hcd 0000:00:13.1: roothub.a 02001203 POTPGT=2 NOCP NPS NDP=3(3)
[   11.005340] ohci_hcd 0000:00:13.1: roothub.b 00000000 PPCM=0000 DR=0000
[   11.005343] ohci_hcd 0000:00:13.1: roothub.status 00008000 DRWE
[   11.005346] ohci_hcd 0000:00:13.1: roothub.portstatus [0] 0x00000100 PPS
[   11.005348] ohci_hcd 0000:00:13.1: roothub.portstatus [1] 0x00000100 PPS
[   11.005351] ohci_hcd 0000:00:13.1: roothub.portstatus [2] 0x00000100 PPS
[   11.005362] usb usb6: default language 0x0409
[   11.005403] usb usb6: uevent
[   11.005413] usb usb6: usb_probe_device
[   11.005415] usb usb6: configuration #1 chosen from 1 choice
[   11.005419] usb usb6: adding 6-0:1.0 (config #1, interface 0)
[   11.005427] usb 6-0:1.0: uevent
[   11.005435] hub 6-0:1.0: usb_probe_interface
[   11.005436] hub 6-0:1.0: usb_probe_interface - got id
[   11.005438] hub 6-0:1.0: USB hub found
[   11.005446] hub 6-0:1.0: 3 ports detected
[   11.005447] hub 6-0:1.0: standalone hub
[   11.005448] hub 6-0:1.0: no power switching (usb 1.0)
[   11.005449] hub 6-0:1.0: no over-current protection
[   11.005450] hub 6-0:1.0: power on to power good time: 4ms
[   11.005454] hub 6-0:1.0: local power source is good
[   11.005455] hub 6-0:1.0: trying to enable port power on non-switchable hub
[   11.005482] drivers/usb/core/inode.c: creating file '001'
[   11.005506] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[   11.005508] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.005510] usb usb6: Product: OHCI Host Controller
[   11.005511] usb usb6: Manufacturer: Linux 2.6.28-gentoo-r2ATH64 ohci_hcd
[   11.005512] usb usb6: SerialNumber: 0000:00:13.1
[   11.005538] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   11.005598] ohci_hcd 0000:00:14.5: OHCI Host Controller
[   11.005615] drivers/usb/core/inode.c: creating file '007'
[   11.005635] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 7
[   11.005639] ohci_hcd 0000:00:14.5: enabled AMD ISO transfers quirk
[   11.005650] ohci_hcd 0000:00:14.5: created debug files
[   11.005652] ohci_hcd 0000:00:14.5: supports USB remote wakeup
[   11.005656] ohci_hcd 0000:00:14.5: irq 18, io mem 0xf3ffa000
[   11.016027] ehci_hcd 0000:00:12.2: GetStatus port 1 status 003002 POWER OWNER sig=se0 CSC
[   11.016046] hub 1-0:1.0: port 2, status 0501, change 0000, 480 Mb/s
[   11.016050] ehci_hcd 0000:00:12.2: port 2 low speed --> companion
[   11.053055] Zoran MJPEG board driver version 0.9.5
[   11.053076] pci 0000:04:06.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[   11.053080] MJPEG[0]: Zoran ZR36067 (rev 2) irq: 21, memory: 0xfbffe000
[   11.053081] MJPEG[0]: subsystem vendor=0x1031 id=0x7efe
[   11.060287] ohci_hcd 0000:00:14.5: OHCI controller state
[   11.060290] ohci_hcd 0000:00:14.5: OHCI 1.0, NO legacy support registers
[   11.060293] ohci_hcd 0000:00:14.5: control 0x083 HCFS=operational CBSR=3
[   11.060296] ohci_hcd 0000:00:14.5: cmdstatus 0x00000 SOC=0
[   11.060299] ohci_hcd 0000:00:14.5: intrstatus 0x00000004 SF
[   11.060302] ohci_hcd 0000:00:14.5: intrenable 0x8000001a MIE UE RD WDH
[   11.060311] ohci_hcd 0000:00:14.5: hcca frame #0005
[   11.060314] ohci_hcd 0000:00:14.5: roothub.a 02001202 POTPGT=2 NOCP NPS NDP=2(2)
[   11.060317] ohci_hcd 0000:00:14.5: roothub.b 00000000 PPCM=0000 DR=0000
[   11.060320] ohci_hcd 0000:00:14.5: roothub.status 00008000 DRWE
[   11.060323] ohci_hcd 0000:00:14.5: roothub.portstatus [0] 0x00000100 PPS
[   11.060325] ohci_hcd 0000:00:14.5: roothub.portstatus [1] 0x00000100 PPS
[   11.060336] usb usb7: default language 0x0409
[   11.060364] usb usb7: uevent
[   11.060373] usb usb7: usb_probe_device
[   11.060375] usb usb7: configuration #1 chosen from 1 choice
[   11.060378] usb usb7: adding 7-0:1.0 (config #1, interface 0)
[   11.060388] usb 7-0:1.0: uevent
[   11.060394] hub 7-0:1.0: usb_probe_interface
[   11.060396] hub 7-0:1.0: usb_probe_interface - got id
[   11.060397] hub 7-0:1.0: USB hub found
[   11.060405] hub 7-0:1.0: 2 ports detected
[   11.060406] hub 7-0:1.0: standalone hub
[   11.060407] hub 7-0:1.0: no power switching (usb 1.0)
[   11.060408] hub 7-0:1.0: no over-current protection
[   11.060409] hub 7-0:1.0: power on to power good time: 4ms
[   11.060413] hub 7-0:1.0: local power source is good
[   11.060414] hub 7-0:1.0: trying to enable port power on non-switchable hub
[   11.060436] drivers/usb/core/inode.c: creating file '001'
[   11.060458] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[   11.060460] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.060461] usb usb7: Product: OHCI Host Controller
[   11.060462] usb usb7: Manufacturer: Linux 2.6.28-gentoo-r2ATH64 ohci_hcd
[   11.060464] usb usb7: SerialNumber: 0000:00:14.5
[   11.067026] ehci_hcd 0000:00:12.2: GetStatus port 2 status 003002 POWER OWNER sig=se0 CSC
[   11.067044] hub 3-0:1.0: state 7 ports 3 chg 0000 evt 0002
[   11.067050] ohci_hcd 0000:00:12.0: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS
[   11.067053] hub 3-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
[   11.132871] saa7110' 0-004e: chip found @ 0x9c (DC10plus[0])
[   11.154601] adv7175' 0-002b: chip found @ 0x56 (DC10plus[0])
[   11.171026] hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
[   11.192050] ohci_hcd 0000:00:12.0: port[0] reset timeout, stat 00000311
[   11.205680] ZORAN: 1 card(s) found
[   11.205682] DC10plus[0]: zr36057_init() - initializing card[0], zr=ffff88011f878000
[   11.212047] nvidia 0000:01:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   11.212053] nvidia 0000:01:00.0: setting latency timer to 64
[   11.212173] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  180.29  Wed Feb  4 23:39:47 PST 2009
[   11.213425] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   11.242033] ohci_hcd 0000:00:12.0: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
[   11.293031] usb 3-1: new low speed USB device using ohci_hcd and address 2
[   11.315052] ohci_hcd 0000:00:12.0: port[0] reset timeout, stat 00000313
[   11.365269] ohci_hcd 0000:00:12.0: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
[   11.436170] usb 3-1: skipped 1 descriptor after interface
[   11.436173] usb 3-1: skipped 1 descriptor after interface
[   11.438169] usb 3-1: default language 0x0409
[   11.443202] usb 3-1: uevent
[   11.443331] usb 3-1: usb_probe_device
[   11.443333] usb 3-1: configuration #1 chosen from 1 choice
[   11.445168] usb 3-1: adding 3-1:1.0 (config #1, interface 0)
[   11.445183] usb 3-1:1.0: uevent
[   11.445307] usbhid 3-1:1.0: usb_probe_interface
[   11.445309] usbhid 3-1:1.0: usb_probe_interface - got id
[   11.451419] input: Logitech Logitech USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/input/input3
[   11.458505] generic-usb 0003:046D:C316.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:12.0-1/input0
[   11.459033] usb 3-1: adding 3-1:1.1 (config #1, interface 1)
[   11.459046] usb 3-1:1.1: uevent
[   11.459056] usbhid 3-1:1.1: usb_probe_interface
[   11.459057] usbhid 3-1:1.1: usb_probe_interface - got id
[   11.469218] input: Logitech Logitech USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.1/input/input4
[   11.475299] generic-usb 0003:046D:C316.0002: input,hidraw1: USB HID v1.10 Device [Logitech Logitech USB Keyboard] on usb-0000:00:12.0-1/input1
[   11.475324] drivers/usb/core/inode.c: creating file '002'
[   11.475350] usb 3-1: New USB device found, idVendor=046d, idProduct=c316
[   11.475351] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   11.475353] usb 3-1: Product: Logitech USB Keyboard
[   11.475354] usb 3-1: Manufacturer: Logitech
[   11.475359] ohci_hcd 0000:00:12.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
[   11.475362] hub 3-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
[   11.579020] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
[   11.600044] ohci_hcd 0000:00:12.0: port[1] reset timeout, stat 00000311
[   11.650021] ohci_hcd 0000:00:12.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
[   11.701019] usb 3-2: new low speed USB device using ohci_hcd and address 3
[   11.723043] ohci_hcd 0000:00:12.0: port[1] reset timeout, stat 00000313
[   11.773021] ohci_hcd 0000:00:12.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
[   11.843161] usb 3-2: skipped 1 descriptor after interface
[   11.845160] usb 3-2: default language 0x0409
[   11.850191] usb 3-2: uevent
[   11.850315] usb 3-2: usb_probe_device
[   11.850317] usb 3-2: configuration #1 chosen from 1 choice
[   11.852158] usb 3-2: adding 3-2:1.0 (config #1, interface 0)
[   11.852173] usb 3-2:1.0: uevent
[   11.852298] usbhid 3-2:1.0: usb_probe_interface
[   11.852300] usbhid 3-2:1.0: usb_probe_interface - got id
[   11.858402] input: B16_b_02 USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb3/3-2/3-2:1.0/input/input5
[   11.865303] generic-usb 0003:046D:C025.0003: input,hidraw2: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:12.0-2/input0
[   11.865330] drivers/usb/core/inode.c: creating file '003'
[   11.865357] usb 3-2: New USB device found, idVendor=046d, idProduct=c025
[   11.865359] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   11.865360] usb 3-2: Product: USB-PS/2 Optical Mouse
[   11.865361] usb 3-2: Manufacturer: B16_b_02
[   11.865364] hub 1-0:1.0: state 7 ports 6 chg 0000 evt 0004
[   11.865371] hub 6-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   11.865373] hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   11.865376] hub 3-0:1.0: state 7 ports 3 chg 0000 evt 0004
[   11.865379] hub 4-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   11.865382] hub 5-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   11.954035] ohci_hcd 0000:00:12.1: auto-stop root hub
[   11.954055] ohci_hcd 0000:00:13.0: auto-stop root hub
[   12.063090] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001e8c0001c1c3e1]
[   12.204023] ohci_hcd 0000:00:13.1: auto-stop root hub
[   12.204036] ohci_hcd 0000:00:14.5: auto-stop root hub
[   12.871018] hub 2-0:1.0: hub_suspend
[   12.871024] usb usb2: bus auto-suspend
[   12.871026] ehci_hcd 0000:00:13.2: suspend root hub
[   13.070089] EXT3 FS on sda1, internal journal
[   13.154797] kjournald starting.  Commit interval 5 seconds
[   13.155187] EXT3 FS on sda3, internal journal
[   13.155189] EXT3-fs: recovery complete.
[   13.155192] EXT3-fs: mounted filesystem with ordered data mode.
[   13.865019] hub 1-0:1.0: hub_suspend
[   13.865025] usb usb1: bus auto-suspend
[   13.865027] ehci_hcd 0000:00:12.2: suspend root hub
[   13.865587] hub 6-0:1.0: hub_suspend
[   13.865589] usb usb6: bus auto-suspend
[   13.865593] ohci_hcd 0000:00:13.1: suspend root hub
[   13.865597] hub 7-0:1.0: hub_suspend
[   13.865599] usb usb7: bus auto-suspend
[   13.865601] ohci_hcd 0000:00:14.5: suspend root hub
[   13.865605] hub 4-0:1.0: hub_suspend
[   13.865607] usb usb4: bus auto-suspend
[   13.865610] ohci_hcd 0000:00:12.1: suspend root hub
[   13.865614] hub 5-0:1.0: hub_suspend
[   13.865615] usb usb5: bus auto-suspend
[   13.865618] ohci_hcd 0000:00:13.0: suspend root hub
[   13.975612] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   18.868189] Adding 3911816k swap on /dev/sda2.  Priority:-1 extents:1 across:3911816k
[   19.610818] usb usb3: uevent
[   19.610851] usb 3-0:1.0: uevent
[   19.610904] usb 3-1: uevent
[   19.610936] usb 3-1:1.0: uevent
[   19.611100] usb 3-1:1.1: uevent
[   19.611299] usb 3-2: uevent
[   19.611331] usb 3-2:1.0: uevent
[   19.611642] usb usb4: uevent
[   19.611673] usb 4-0:1.0: uevent
[   19.611811] usb usb1: uevent
[   19.611841] usb 1-0:1.0: uevent
[   19.611976] usb usb5: uevent
[   19.612008] usb 5-0:1.0: uevent
[   19.612142] usb usb6: uevent
[   19.612172] usb 6-0:1.0: uevent
[   19.612321] usb usb2: uevent
[   19.612352] usb 2-0:1.0: uevent
[   19.612872] usb usb7: uevent
[   19.612903] usb 7-0:1.0: uevent
[   21.232856] RPC: Registered udp transport module.
[   21.232857] RPC: Registered tcp transport module.
[   21.280055] mount.nfs used greatest stack depth: 3736 bytes left
[   24.302039] eth0: no IPv6 routers present
[   77.113906] DC10plus[0]: zoran_open(mplayer, pid=[2255]), users(-)=0
[   77.196939] DC10plus[0]: setup_window() - frame buffer has to be set first
[   77.198484] DC10plus[0]: zoran_close(mplayer, pid=[2255]), users(+)=1
[   93.068035] DC10plus[0]: zoran_open(mplayer, pid=[2256]), users(-)=0
[   93.139111] DC10plus[0]: v4l_set_format() - video buffer size (128 kB) is too small
[   93.139137] DC10plus[0]: zoran_close(mplayer, pid=[2256]), users(+)=1
[  102.268297] DC10plus[0]: zoran_open(mplayer, pid=[2257]), users(-)=0
[  102.339104] DC10plus[0]: v4l_set_format() - video buffer size (128 kB) is too small
[  102.339129] DC10plus[0]: zoran_close(mplayer, pid=[2257]), users(+)=1
[  107.091192] DC10plus[0]: zoran_open(mplayer, pid=[2258]), users(-)=0
[  107.164659] DC10plus[0]: setup_window() - frame buffer has to be set first
[  107.164763] DC10plus[0]: zoran_close(mplayer, pid=[2258]), users(+)=1
[  120.779242] DC10plus[0]: zoran_open(mplayer, pid=[2259]), users(-)=0
[  120.852687] DC10plus[0]: setup_window() - frame buffer has to be set first
[  151.414445] DC10plus[0]: zoran_close(mplayer, pid=[2259]), users(+)=1
[  157.003380] DC10plus[0]: zoran_open(mplayer, pid=[2261]), users(-)=0
[  157.074112] DC10plus[0]: v4l_set_format() - video buffer size (128 kB) is too small
[  157.074138] DC10plus[0]: zoran_close(mplayer, pid=[2261]), users(+)=1
[  162.866528] DC10plus[0]: zoran_open(mplayer, pid=[2262]), users(-)=0
[  162.938134] DC10plus[0]: v4l_set_format() - video buffer size (128 kB) is too small
[  162.938166] DC10plus[0]: zoran_close(mplayer, pid=[2262]), users(+)=1
[  166.299321] DC10plus[0]: zoran_open(mplayer, pid=[2263]), users(-)=0
[  166.370105] DC10plus[0]: v4l_set_format() - video buffer size (128 kB) is too small
[  166.370130] DC10plus[0]: zoran_close(mplayer, pid=[2263]), users(+)=1
[  710.974015] pci 0000:04:06.0: PCI INT A disabled
[  720.048293] Zoran MJPEG board driver version 0.9.5
[  720.048313] pci 0000:04:06.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  720.048317] MJPEG[0]: Zoran ZR36067 (rev 2) irq: 21, memory: 0xfbffe000
[  720.048319] MJPEG[0]: subsystem vendor=0x1031 id=0x7efe
[  720.050410] DC10plus[0]: Initializing i2c bus...
[  720.052307] saa7110' 0-004e: chip found @ 0x9c (DC10plus[0])
[  720.069419] DC10plus[0]: i2c_client_register() - driver id = 22
[  720.073817] adv7175' 0-002b: chip found @ 0x56 (DC10plus[0])
[  720.080285] DC10plus[0]: i2c_client_register() - driver id = 48
[  720.080287] DC10plus[0]: Initializing videocodec bus...
[  720.088544] ZORAN: 1 card(s) found
[  720.088546] DC10plus[0]: zr36057_init() - initializing card[0], zr=ffff88011f878000
[  720.156885] DC10plus[0]: enable_jpg(IDLE)
[  721.156018] DC10plus[0]: interrupts received: GIRQ1:50 queue_state=0/0/0/0
[  721.159370] DC10plus[0]: procfs entry /proc/zoran0 allocated. data=ffff88011f878000
[ 1034.727084] bzip2 used greatest stack depth: 3536 bytes left

--------------070302030500010303020703
Content-Type: application/octet-stream;
 name="desktopX3_dmesg2009-03-05.txt.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="desktopX3_dmesg2009-03-05.txt.sig"

iEYEABECAAYFAkmvxcIACgkQv20tKfoYgenNnACgi7kWBGoUUnJSzkG92S21DsmSDFIAnjy7
cGPce3nkkfHr5IQcsEcecwRA
--------------070302030500010303020703--
