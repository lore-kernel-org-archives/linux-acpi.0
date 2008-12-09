From: Marcel-Titus MARGINEAN <mtm@mezonix.com>
Subject: Gateway DX4720-03
Date: Mon, 08 Dec 2008 20:02:15 -0500
Message-ID: <493DC397.7090606@mezonix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030507020505030007000508"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:56807 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884AbYLIBCV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Dec 2008 20:02:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507020505030007000508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Works better with the boot param "acpi_osi=Linux"
Without it, the PS/2 keyboard and USB mouse does not work at all.

Here is the rest of the info:

[    0.456522] ACPI: DMI System Vendor: Gateway
[    0.456523] ACPI: DMI Product Name: DX4720-03
[    0.456524] ACPI: DMI Product Version: To Be Filled By O.E.M.
[    0.456525] ACPI: DMI Board Name: MS-7399
[    0.456526] ACPI: DMI BIOS Vendor: American Megatrends Inc.
[    0.456528] ACPI: DMI BIOS Date: 08/06/2008
[    0.456529] ACPI: Please send DMI info above to
linux-acpi@vger.kernel.org

..............

[    0.506485] ACPI Error (uteval-0289): Return object type is incorrect
[\_SB_.LATA._CRS] (Node ffff88013fa39160), AE_TYPE
[    0.506492] ACPI Error (uteval-0295): Type returned from _CRS was
incorrect: Integer, expected Btypes: 4 [20080609]
[    0.506496] ACPI Exception (pci_link-0291): AE_TYPE, Evaluating _CRS
[20080609]
[    0.506498] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0,
disabled.
[    0.506550] ACPI Warning (tbutils-0217): Incorrect checksum in table
[OEMB] - 1E, should be 1D [20080609]


Attached is all the dmesg.


All the best and thank you for your effort,
M.T.M.


--------------030507020505030007000508
Content-Type: text/plain;
 name="gateway-DX4720-03-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gateway-DX4720-03-dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27-9-generic (buildd@yellow) (gcc version 4.3.2 (Ubuntu 4.3.2-1ubuntu11) ) #1 SMP Thu Nov 20 22:15:32 UTC 2008 (Ubuntu 2.6.27-9.19-generic)
[    0.000000] Command line: root=UUID=eea2505d-ad28-4408-b7c1-d2b54eb38e06 ro quiet splash acpi_osi=Linux
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000affa0000 (usable)
[    0.000000]  BIOS-e820: 00000000affa0000 - 00000000affae000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000affae000 - 00000000affe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000affe0000 - 00000000affee000 (reserved)
[    0.000000]  BIOS-e820: 00000000afff0000 - 00000000b0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
[    0.000000] last_pfn = 0x140000 max_arch_pfn = 0x3ffffffff
[    0.000000] last_pfn = 0xaffa0 max_arch_pfn = 0x3ffffffff
[    0.000000] init_memory_mapping
[    0.000000]  0000000000 - 00afe00000 page 2M
[    0.000000]  00afe00000 - 00affa0000 page 4k
[    0.000000] kernel direct mapping tables up to affa0000 @ 8000-d000
[    0.000000] last_map_addr: affa0000 end: affa0000
[    0.000000] init_memory_mapping
[    0.000000]  0100000000 - 0140000000 page 2M
[    0.000000] kernel direct mapping tables up to 140000000 @ b000-11000
[    0.000000] last_map_addr: 140000000 end: 140000000
[    0.000000] RAMDISK: 377a9000 - 37fef7a0
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000FA620, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT AFFA0000, 004C (r1 GATEWA SYSTEM   20080806 MSFT       97)
[    0.000000] ACPI: FACP AFFA0200, 0084 (r1 080608 FACP1142 20080806 MSFT       97)
[    0.000000] ACPI: DSDT AFFA0620, 635F (r1  A7399 A7399202      202 INTL 20051117)
[    0.000000] ACPI: FACS AFFAE000, 0040
[    0.000000] ACPI: APIC AFFA0390, 0080 (r1 080608 APIC1142 20080806 MSFT       97)
[    0.000000] ACPI: MCFG AFFA0410, 003C (r1 080608 OEMMCFG  20080806 MSFT       97)
[    0.000000] ACPI: SLIC AFFA0450, 0176 (r1 GATEWA SYSTEM   20080806 MSFT       97)
[    0.000000] ACPI: WDRT AFFA05D0, 0047 (r1 080608 NV-WDRT  20080806 MSFT       97)
[    0.000000] ACPI: OEMB AFFAE040, 0071 (r1 080608 OEMB1142 20080806 MSFT       97)
[    0.000000] ACPI: HPET AFFA6980, 0038 (r1 080608 OEMHPET0 20080806 MSFT       97)
[    0.000000] ACPI: NVHD AFFAE0C0, 0554 (r1 080608  NVHDCP  20080806 MSFT       97)
[    0.000000] ACPI: AWMI AFFAE620, 004E (r1 080608 OEMB1142 20080806 MSFT       97)
[    0.000000] ACPI: SSDT AFFAEF90, 0A7C (r1 DpgPmm    CpuPm       12 INTL 20051117)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000140000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000140000000
[    0.000000]   NODE_DATA [0000000000001000 - 0000000000005fff]
[    0.000000]   bootmap [000000000000c000 -  0000000000033fff] pages 28
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 0140000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 00008b8f9c]    TEXT DATA BSS ==> [0000200000 - 00008b8f9c]
[    0.000000]   #3 [00377a9000 - 0037fef7a0]          RAMDISK ==> [00377a9000 - 0037fef7a0]
[    0.000000]   #4 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #5 [0000008000 - 000000b000]          PGTABLE ==> [0000008000 - 000000b000]
[    0.000000]   #6 [000000b000 - 000000c000]          PGTABLE ==> [000000b000 - 000000c000]
[    0.000000] found SMP MP-table at [ffff8800000ff780] 000ff780
[    0.000000]  [ffffe20000000000-ffffe20004ffffff] PMD -> [ffff880028200000-ffff88002bdfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00140000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000affa0
[    0.000000]     0: 0x00100000 -> 0x00140000
[    0.000000] On node 0 totalpages: 982847
[    0.000000]   DMA zone: 2110 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 700384 pages, LIFO batch:31
[    0.000000]   Normal zone: 258048 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000affa0000 - 00000000affae000
[    0.000000] PM: Registered nosave memory: 00000000affae000 - 00000000affe0000
[    0.000000] PM: Registered nosave memory: 00000000affe0000 - 00000000affee000
[    0.000000] PM: Registered nosave memory: 00000000affee000 - 00000000afff0000
[    0.000000] PM: Registered nosave memory: 00000000afff0000 - 00000000b0000000
[    0.000000] PM: Registered nosave memory: 00000000b0000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at b8000000 (gap: b0000000:4ec00000)
[    0.000000] PERCPU: Allocating 64928 bytes of per cpu data
[    0.000000] NR_CPUS: 64, nr_cpu_ids: 4, nr_node_ids 1
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 960542
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=UUID=eea2505d-ad28-4408-b7c1-d2b54eb38e06 ro quiet splash acpi_osi=Linux
[    0.000000] ACPI: Added _OSI(Linux)
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC: PIT calibration confirmed by PMTIMER.
[    0.000000] TSC: using PIT calibration value
[    0.000000] Detected 2499.880 MHz processor.
[    0.004000] spurious 8259A interrupt: IRQ7.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.004000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.004000] Placing software IO TLB between 0x20000000 - 0x24000000
[    0.004000] Memory: 3788124k/5242880k available (3112k kernel code, 143264k reserved, 1575k data, 536k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.004000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.004000] hpet clockevent registered
[    0.004000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4999.76 BogoMIPS (lpj=9999520)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] AppArmor: AppArmor initialized
[    0.004000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.004000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.004166] Mount-cache hash table entries: 256
[    0.004360] Initializing cgroup subsys ns
[    0.004365] Initializing cgroup subsys cpuacct
[    0.004367] Initializing cgroup subsys memory
[    0.004382] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004383] CPU: L2 cache: 2048K
[    0.004386] CPU 0/0 -> Node 0
[    0.004387] CPU: Physical Processor ID: 0
[    0.004388] CPU: Processor Core ID: 0
[    0.004395] CPU0: Thermal monitoring enabled (TM2)
[    0.004396] using mwait in idle threads.
[    0.006289] ACPI: Core revision 20080609
[    0.007725] ACPI: Checking initramfs for custom DSDT
[    0.317781] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.357909] CPU0: Pentium(R) Dual-Core  CPU      E5200  @ 2.50GHz stepping 06
[    0.357912] Using local APIC timer interrupts.
[    0.360023] APIC timer calibration result 12499443
[    0.360024] Detected 12.499 MHz APIC timer.
[    0.360135] Booting processor 1/1 ip 6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 4999.76 BogoMIPS (lpj=9999522)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 2048K
[    0.004000] CPU 1/1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] CPU1: Thermal monitoring enabled (TM2)
[    0.448416] CPU1: Pentium(R) Dual-Core  CPU      E5200  @ 2.50GHz stepping 06
[    0.448436] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.452063] Brought up 2 CPUs
[    0.452065] Total of 2 processors activated (9999.52 BogoMIPS).
[    0.452123] CPU0 attaching sched-domain:
[    0.452125]  domain 0: span 0-1 level MC
[    0.452127]   groups: 0 1
[    0.452130]   domain 1: span 0-1 level NODE
[    0.452131]    groups: 0-1
[    0.452135] CPU1 attaching sched-domain:
[    0.452136]  domain 0: span 0-1 level MC
[    0.452137]   groups: 1 0
[    0.452139]   domain 1: span 0-1 level NODE
[    0.452141]    groups: 0-1
[    0.452218] net_namespace: 1552 bytes
[    0.452218] Booting paravirtualized kernel on bare hardware
[    0.452264] Time: 19:47:51  Date: 12/08/08
[    0.452290] NET: Registered protocol family 16
[    0.452305] ACPI: bus type pci registered
[    0.452305] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.452305] PCI: Not using MMCONFIG.
[    0.452305] PCI: Using configuration type 1 for base access
[    0.452796] ACPI: EC: Look up EC in DSDT
[    0.456520] ACPI: BIOS _OSI(Linux) query honored via cmdline
[    0.456522] ACPI: DMI System Vendor: Gateway
[    0.456523] ACPI: DMI Product Name: DX4720-03
[    0.456524] ACPI: DMI Product Version: To Be Filled By O.E.M.
[    0.456525] ACPI: DMI Board Name: MS-7399
[    0.456526] ACPI: DMI BIOS Vendor: American Megatrends Inc.
[    0.456528] ACPI: DMI BIOS Date: 08/06/2008
[    0.456529] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[    0.464796] ACPI: Interpreter enabled
[    0.464798] ACPI: (supports S0 S1 S3 S4 S5)
[    0.464811] ACPI: Using IOAPIC for interrupt routing
[    0.464918] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.471674] PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
[    0.478607] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.488101] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.488922] PCI: 0000:00:03.0 reg 10 io port: [4f00, 4fff]
[    0.488966] PCI: 0000:00:03.1 reg 10 io port: [4900, 493f]
[    0.488979] PCI: 0000:00:03.1 reg 20 io port: [4d00, 4d3f]
[    0.488983] PCI: 0000:00:03.1 reg 24 io port: [4e00, 4e3f]
[    0.489000] pci 0000:00:03.1: PME# supported from D3hot D3cold
[    0.489005] pci 0000:00:03.1: PME# disabled
[    0.489061] PCI: 0000:00:03.3 reg 10 32bit mmio: [fea80000, feafffff]
[    0.489232] PCI: 0000:00:04.0 reg 10 32bit mmio: [fea7f000, fea7ffff]
[    0.489258] pci 0000:00:04.0: supports D1
[    0.489259] pci 0000:00:04.0: supports D2
[    0.489260] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.489263] pci 0000:00:04.0: PME# disabled
[    0.489286] PCI: 0000:00:04.1 reg 10 32bit mmio: [fea7ec00, fea7ecff]
[    0.489316] pci 0000:00:04.1: supports D1
[    0.489317] pci 0000:00:04.1: supports D2
[    0.489318] pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.489321] pci 0000:00:04.1: PME# disabled
[    0.489360] PCI: 0000:00:08.0 reg 20 io port: [ffa0, ffaf]
[    0.489395] PCI: 0000:00:09.0 reg 10 32bit mmio: [fea78000, fea7bfff]
[    0.489422] pci 0000:00:09.0: PME# supported from D3hot D3cold
[    0.489425] pci 0000:00:09.0: PME# disabled
[    0.489478] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.489481] pci 0000:00:0b.0: PME# disabled
[    0.489509] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.489511] pci 0000:00:0c.0: PME# disabled
[    0.489540] pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.489542] pci 0000:00:0d.0: PME# disabled
[    0.489562] PCI: 0000:00:0e.0 reg 10 io port: [d480, d487]
[    0.489566] PCI: 0000:00:0e.0 reg 14 io port: [d400, d403]
[    0.489569] PCI: 0000:00:0e.0 reg 18 io port: [d080, d087]
[    0.489573] PCI: 0000:00:0e.0 reg 1c io port: [d000, d003]
[    0.489576] PCI: 0000:00:0e.0 reg 20 io port: [cc00, cc0f]
[    0.489580] PCI: 0000:00:0e.0 reg 24 32bit mmio: [fea7c000, fea7dfff]
[    0.489613] PCI: 0000:00:0f.0 reg 10 32bit mmio: [fea73000, fea73fff]
[    0.489617] PCI: 0000:00:0f.0 reg 14 io port: [c880, c887]
[    0.489621] PCI: 0000:00:0f.0 reg 18 32bit mmio: [fea7e800, fea7e8ff]
[    0.489625] PCI: 0000:00:0f.0 reg 1c 32bit mmio: [fea7e400, fea7e40f]
[    0.489644] pci 0000:00:0f.0: supports D1
[    0.489645] pci 0000:00:0f.0: supports D2
[    0.489646] pci 0000:00:0f.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.489650] pci 0000:00:0f.0: PME# disabled
[    0.489666] PCI: 0000:00:10.0 reg 10 32bit mmio: [fd000000, fdffffff]
[    0.489670] PCI: 0000:00:10.0 reg 14 32bit mmio: [d0000000, dfffffff]
[    0.489677] PCI: 0000:00:10.0 reg 1c 64bit mmio: [fc000000, fcffffff]
[    0.489683] PCI: 0000:00:10.0 reg 30 32bit mmio: [fea40000, fea5ffff]
[    0.489736] PCI: 0000:01:05.0 reg 10 32bit mmio: [febf0000, febfffff]
[    0.489742] PCI: 0000:01:05.0 reg 14 io port: [ec00, ec07]
[    0.489772] pci 0000:01:05.0: PME# supported from D3hot D3cold
[    0.489775] pci 0000:01:05.0: PME# disabled
[    0.489800] PCI: 0000:01:07.0 reg 10 32bit mmio: [febef800, febeffff]
[    0.489806] PCI: 0000:01:07.0 reg 14 io port: [e880, e8ff]
[    0.489839] pci 0000:01:07.0: supports D2
[    0.489840] pci 0000:01:07.0: PME# supported from D2 D3hot D3cold
[    0.489844] pci 0000:01:07.0: PME# disabled
[    0.489870] pci 0000:00:0a.0: transparent bridge
[    0.489873] PCI: bridge 0000:00:0a.0 io port: [e000, efff]
[    0.489875] PCI: bridge 0000:00:0a.0 32bit mmio: [feb00000, febfffff]
[    0.490020] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.490280] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.490442] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR10._PRT]
[    0.490553] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[    0.490667] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR12._PRT]
[    0.500439] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disabled.
[    0.500521] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *10
[    0.500765] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
[    0.501013] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *11
[    0.501256] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disabled.
[    0.501499] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *0, disabled.
[    0.504062] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disabled.
[    0.504307] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *0, disabled.
[    0.504554] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *10
[    0.504801] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *11
[    0.505048] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *7
[    0.505295] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *7
[    0.505541] ACPI: PCI Interrupt Link [SGRU] (IRQs 20 21 22 23) *10
[    0.505794] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *11
[    0.506045] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *7
[    0.506295] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *5
[    0.506485] ACPI Error (uteval-0289): Return object type is incorrect [\_SB_.LATA._CRS] (Node ffff88013fa39160), AE_TYPE
[    0.506492] ACPI Error (uteval-0295): Type returned from _CRS was incorrect: Integer, expected Btypes: 4 [20080609]
[    0.506496] ACPI Exception (pci_link-0291): AE_TYPE, Evaluating _CRS [20080609]
[    0.506498] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
[    0.506550] ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] - 1E, should be 1D [20080609]
[    0.506550] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.506550] pnp: PnP ACPI init
[    0.506550] ACPI: bus type pnp registered
[    0.512357] pnp: PnP ACPI: found 12 devices
[    0.512359] ACPI: ACPI bus type pnp unregistered
[    0.512375] PCI: Using ACPI for IRQ routing
[    0.532059] NET: Registered protocol family 8
[    0.532062] NET: Registered protocol family 20
[    0.532085] NetLabel: Initializing
[    0.532085] NetLabel:  domain hash size = 128
[    0.532085] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.532085] NetLabel:  unlabeled traffic allowed by default
[    0.532107] PCI-GART: No AMD northbridge found.
[    0.532113] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.532116] hpet0: 3 32-bit timers, 25000000 Hz
[    0.535033] tracer: 1286 pages allocated for 65536 entries of 80 bytes
[    0.535035]    actual entries 65586
[    0.535187] AppArmor: AppArmor Filesystem Enabled
[    0.535211] ACPI: RTC can wake from S4
[    0.536041] Switched to high resolution mode on CPU 0
[    0.536469] Switched to high resolution mode on CPU 1
[    0.548037] system 00:04: ioport range 0x4d0-0x4d1 has been reserved
[    0.548041] system 00:04: ioport range 0x800-0x80f has been reserved
[    0.548045] system 00:04: ioport range 0x4000-0x407f has been reserved
[    0.548049] system 00:04: ioport range 0x4080-0x40ff has been reserved
[    0.548053] system 00:04: ioport range 0x4400-0x447f has been reserved
[    0.548056] system 00:04: ioport range 0x4480-0x44ff has been reserved
[    0.548060] system 00:04: ioport range 0x4800-0x487f has been reserved
[    0.548064] system 00:04: ioport range 0x4880-0x48ff has been reserved
[    0.548067] system 00:04: ioport range 0x4900-0x493f has been reserved
[    0.548071] system 00:04: ioport range 0x4c00-0x4c7f has been reserved
[    0.548075] system 00:04: ioport range 0x4c80-0x4cff has been reserved
[    0.548079] system 00:04: iomem range 0xfec80000-0xfed3ffff has been reserved
[    0.548084] system 00:04: iomem range 0xfed45000-0x1fd93ffff could not be reserved
[    0.548088] system 00:04: iomem range 0xfefe0000-0xfefe01ff has been reserved
[    0.548091] system 00:04: iomem range 0xfefe1000-0xfefe1fff has been reserved
[    0.548095] system 00:04: iomem range 0xfee01000-0xfeefffff has been reserved
[    0.548106] system 00:06: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.548110] system 00:06: iomem range 0xfee00000-0xfee00fff could not be reserved
[    0.548120] system 00:08: ioport range 0xa00-0xa0f has been reserved
[    0.548128] system 00:08: ioport range 0xa10-0xa1f has been reserved
[    0.548137] system 00:08: ioport range 0xa20-0xa2f has been reserved
[    0.548138] system 00:08: ioport range 0xa30-0xa3f has been reserved
[    0.548143] system 00:0a: iomem range 0xe0000000-0xefffffff has been reserved
[    0.548147] system 00:0b: iomem range 0x0-0x9ffff could not be reserved
[    0.548149] system 00:0b: iomem range 0xe0000-0xfffff could not be reserved
[    0.548151] system 00:0b: iomem range 0x100000-0xbfffffff could not be reserved
[    0.548153] system 00:0b: iomem range 0xfec00000-0xffffffff could not be reserved
[    0.553114] pci 0000:00:0a.0: PCI bridge, secondary bus 0000:01
[    0.553117] pci 0000:00:0a.0:   IO window: 0xe000-0xefff
[    0.553121] pci 0000:00:0a.0:   MEM window: 0xfeb00000-0xfebfffff
[    0.553124] pci 0000:00:0a.0:   PREFETCH window: disabled
[    0.553128] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:02
[    0.553129] pci 0000:00:0b.0:   IO window: disabled
[    0.553132] pci 0000:00:0b.0:   MEM window: disabled
[    0.553134] pci 0000:00:0b.0:   PREFETCH window: disabled
[    0.553137] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:03
[    0.553139] pci 0000:00:0c.0:   IO window: disabled
[    0.553141] pci 0000:00:0c.0:   MEM window: disabled
[    0.553144] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.553147] pci 0000:00:0d.0: PCI bridge, secondary bus 0000:04
[    0.553148] pci 0000:00:0d.0:   IO window: disabled
[    0.553151] pci 0000:00:0d.0:   MEM window: disabled
[    0.553153] pci 0000:00:0d.0:   PREFETCH window: disabled
[    0.553162] pci 0000:00:0a.0: setting latency timer to 64
[    0.553167] pci 0000:00:0b.0: setting latency timer to 64
[    0.553172] pci 0000:00:0c.0: setting latency timer to 64
[    0.553176] pci 0000:00:0d.0: setting latency timer to 64
[    0.553179] bus: 00 index 0 io port: [0, ffff]
[    0.553180] bus: 00 index 1 mmio: [0, ffffffffffffffff]
[    0.553182] bus: 01 index 0 io port: [e000, efff]
[    0.553183] bus: 01 index 1 mmio: [feb00000, febfffff]
[    0.553184] bus: 01 index 2 mmio: [0, 0]
[    0.553185] bus: 01 index 3 io port: [0, ffff]
[    0.553187] bus: 01 index 4 mmio: [0, ffffffffffffffff]
[    0.553188] bus: 02 index 0 mmio: [0, 0]
[    0.553189] bus: 02 index 1 mmio: [0, 0]
[    0.553190] bus: 02 index 2 mmio: [0, 0]
[    0.553191] bus: 02 index 3 mmio: [0, 0]
[    0.553192] bus: 03 index 0 mmio: [0, 0]
[    0.553193] bus: 03 index 1 mmio: [0, 0]
[    0.553194] bus: 03 index 2 mmio: [0, 0]
[    0.553195] bus: 03 index 3 mmio: [0, 0]
[    0.553197] bus: 04 index 0 mmio: [0, 0]
[    0.553198] bus: 04 index 1 mmio: [0, 0]
[    0.553199] bus: 04 index 2 mmio: [0, 0]
[    0.553200] bus: 04 index 3 mmio: [0, 0]
[    0.553209] NET: Registered protocol family 2
[    0.592195] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.593697] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.598207] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.598776] TCP: Hash tables configured (established 524288 bind 65536)
[    0.598778] TCP reno registered
[    0.608159] NET: Registered protocol family 1
[    0.608267] checking if image is initramfs... it is
[    1.234690] Freeing initrd memory: 8473k freed
[    1.241385] audit: initializing netlink socket (disabled)
[    1.241413] type=2000 audit(1228765671.240:1): initialized
[    1.246298] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.248215] VFS: Disk quotas dquot_6.5.1
[    1.248280] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.248367] msgmni has been set to 7415
[    1.248462] io scheduler noop registered
[    1.248464] io scheduler anticipatory registered
[    1.248465] io scheduler deadline registered
[    1.248564] io scheduler cfq registered (default)
[    1.271070] pci 0000:00:10.0: Boot video device
[    1.271174] pcieport-driver 0000:00:0b.0: setting latency timer to 64
[    1.271202] pcieport-driver 0000:00:0b.0: found MSI capability
[    1.271228] pci_express 0000:00:0b.0:pcie00: allocate port service
[    1.271261] pci_express 0000:00:0b.0:pcie03: allocate port service
[    1.271327] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    1.271354] pcieport-driver 0000:00:0c.0: found MSI capability
[    1.271377] pci_express 0000:00:0c.0:pcie00: allocate port service
[    1.271407] pci_express 0000:00:0c.0:pcie03: allocate port service
[    1.271473] pcieport-driver 0000:00:0d.0: setting latency timer to 64
[    1.271500] pcieport-driver 0000:00:0d.0: found MSI capability
[    1.271522] pci_express 0000:00:0d.0:pcie00: allocate port service
[    1.271555] pci_express 0000:00:0d.0:pcie03: allocate port service
[    1.296616] Linux agpgart interface v0.103
[    1.296621] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    1.296752] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.297303] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.298624] brd: module loaded
[    1.298680] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[    1.298764] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.298765] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.298873] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.316761] mice: PS/2 mouse device common for all mice
[    1.316857] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.316890] rtc0: alarms up to one year, y3k, hpet irqs
[    1.316919] cpuidle: using governor ladder
[    1.316920] cpuidle: using governor menu
[    1.317225] TCP cubic registered
[    1.317379] registered taskstats version 1
[    1.317502]   Magic number: 4:888:798
[    1.317574] tty ptyr6: hash matches
[    1.317646] rtc_cmos 00:05: setting system clock to 2008-12-08 19:47:52 UTC (1228765672)
[    1.317648] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.317649] EDD information not available.
[    1.317684] Freeing unused kernel memory: 536k freed
[    1.317964] Write protecting the kernel read-only data: 4348k
[    1.338743] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.432374] fuse init (API version 7.9)
[    1.526274] ACPI: SSDT AFFAE670, 0277 (r1 DpgPmm  P001Ist       11 INTL 20051117)
[    1.526602] processor ACPI0007:00: registered as cooling_device0
[    1.526605] ACPI: Processor [P001] (supports 8 throttling states)
[    1.526916] ACPI: SSDT AFFAEB00, 0277 (r1 DpgPmm  P002Ist       12 INTL 20051117)
[    1.527220] processor ACPI0007:01: registered as cooling_device1
[    1.528818] ACPI: Expecting a [Reference] package element, found type C
[    1.528945] thermal LNXTHERM:01: registered as thermal_zone0
[    1.529137] ACPI: Thermal Zone [THRM] (33 C)
[    1.754216] No dock devices found.
[    1.763177] SCSI subsystem initialized
[    1.780888] libata version 3.00 loaded.
[    1.782108] usbcore: registered new interface driver usbfs
[    1.782137] usbcore: registered new interface driver hub
[    1.782189] usbcore: registered new device driver usb
[    1.782417] pata_acpi 0000:00:08.0: setting latency timer to 64
[    1.784516] pata_amd 0000:00:08.0: version 0.3.10
[    1.784587] pata_amd 0000:00:08.0: setting latency timer to 64
[    1.786258] scsi0 : pata_amd
[    1.786443] scsi1 : pata_amd
[    1.787826] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
[    1.787828] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
[    1.789454] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.955072] ata2: port disabled. ignoring.
[    1.957550] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 23
[    1.957559] ohci_hcd 0000:00:04.0: PCI INT A -> Link[LUB0] -> GSI 23 (level, low) -> IRQ 23
[    1.957572] ohci_hcd 0000:00:04.0: setting latency timer to 64
[    1.957574] ohci_hcd 0000:00:04.0: OHCI Host Controller
[    1.957623] ohci_hcd 0000:00:04.0: new USB bus registered, assigned bus number 1
[    1.957644] ohci_hcd 0000:00:04.0: irq 23, io mem 0xfea7f000
[    2.014227] usb usb1: configuration #1 chosen from 1 choice
[    2.014252] hub 1-0:1.0: USB hub found
[    2.014262] hub 1-0:1.0: 10 ports detected
[    2.220687] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
[    2.220698] ehci_hcd 0000:00:04.1: PCI INT B -> Link[LUB2] -> GSI 22 (level, low) -> IRQ 22
[    2.220716] ehci_hcd 0000:00:04.1: setting latency timer to 64
[    2.220719] ehci_hcd 0000:00:04.1: EHCI Host Controller
[    2.220743] ehci_hcd 0000:00:04.1: new USB bus registered, assigned bus number 2
[    2.220779] ehci_hcd 0000:00:04.1: debug port 1
[    2.220783] ehci_hcd 0000:00:04.1: cache line size of 32 is not supported
[    2.220801] ehci_hcd 0000:00:04.1: irq 22, io mem 0xfea7ec00
[    2.232012] ehci_hcd 0000:00:04.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    2.232142] usb usb2: configuration #1 chosen from 1 choice
[    2.232162] hub 2-0:1.0: USB hub found
[    2.232168] hub 2-0:1.0: 10 ports detected
[    2.440267] ahci 0000:00:0e.0: version 3.0
[    2.440638] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 21
[    2.440643] ahci 0000:00:0e.0: PCI INT A -> Link[LSA0] -> GSI 21 (level, low) -> IRQ 21
[    2.440727] ahci 0000:00:0e.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl RAID mode
[    2.440730] ahci 0000:00:0e.0: flags: 64bit sntf led clo pmp pio 
[    2.440733] ahci 0000:00:0e.0: setting latency timer to 64
[    2.441012] scsi2 : ahci
[    2.441071] scsi3 : ahci
[    2.441118] scsi4 : ahci
[    2.441166] scsi5 : ahci
[    2.441235] ata3: SATA max UDMA/133 abar m8192@0xfea7c000 port 0xfea7c100 irq 2300
[    2.441237] ata4: SATA max UDMA/133 abar m8192@0xfea7c000 port 0xfea7c180 irq 2300
[    2.441239] ata5: SATA max UDMA/133 abar m8192@0xfea7c000 port 0xfea7c200 irq 2300
[    2.441240] ata6: SATA max UDMA/133 abar m8192@0xfea7c000 port 0xfea7c280 irq 2300
[    2.884017] usb 2-7: new high speed USB device using ehci_hcd and address 4
[    2.924518] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.925326] ata3.00: ATA-8: WDC WD6400AAKS-22A7B0, 01.03B01, max UDMA/133
[    2.925328] ata3.00: 1250263728 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.926207] ata3.00: configured for UDMA/133
[    3.052970] usb 2-7: configuration #1 chosen from 1 choice
[    3.244517] ata4: SATA link down (SStatus 0 SControl 300)
[    3.356018] usb 1-3: new low speed USB device using ohci_hcd and address 2
[    3.565171] usb 1-3: configuration #1 chosen from 1 choice
[    3.872030] usb 1-4: new full speed USB device using ohci_hcd and address 3
[    4.081185] usb 1-4: configuration #1 chosen from 1 choice
[    4.132515] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.133877] ata5.00: ATAPI: Optiarc DVD RW AD-7203S, 1-B0, max UDMA/100
[    4.135253] ata5.00: configured for UDMA/100
[    4.452016] ata6: SATA link down (SStatus 0 SControl 300)
[    4.452153] scsi 2:0:0:0: Direct-Access     ATA      WDC WD6400AAKS-2 01.0 PQ: 0 ANSI: 5
[    4.453733] scsi 4:0:0:0: CD-ROM            Optiarc  DVD RW AD-7203S  1-B0 PQ: 0 ANSI: 5
[    4.453862] forcedeth: Reverse Engineered nForce ethernet driver. Version 0.61.
[    4.454249] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 20
[    4.454256] forcedeth 0000:00:0f.0: PCI INT A -> Link[LMAC] -> GSI 20 (level, low) -> IRQ 20
[    4.454260] forcedeth 0000:00:0f.0: setting latency timer to 64
[    4.972767] forcedeth 0000:00:0f.0: ifname eth0, PHY OUI 0x732 @ 1, addr 00:21:85:71:19:35
[    4.972770] forcedeth 0000:00:0f.0: highdma pwrctl mgmt timirq gbit lnktim msi desc-v3
[    4.973161] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 19
[    4.973167] ohci1394 0000:01:07.0: PCI INT A -> Link[LNKD] -> GSI 19 (level, low) -> IRQ 19
[    5.025864] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[febef800-febeffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[    5.036731] scsi 2:0:0:0: Attached scsi generic sg0 type 0
[    5.036758] scsi 4:0:0:0: Attached scsi generic sg1 type 5
[    5.052489] usbcore: registered new interface driver libusual
[    5.057857] Initializing USB Mass Storage driver...
[    5.059269] scsi6 : SCSI emulation for USB Mass Storage devices
[    5.061309] usbcore: registered new interface driver usb-storage
[    5.061312] USB Mass Storage support registered.
[    5.061327] usb-storage: device found at 4
[    5.061328] usb-storage: waiting for device to settle before scanning
[    5.061412] usbcore: registered new interface driver hiddev
[    5.080326] Driver 'sd' needs updating - please use bus_type methods
[    5.081163] sd 2:0:0:0: [sda] 1250263728 512-byte hardware sectors (640135 MB)
[    5.081481] sd 2:0:0:0: [sda] Write Protect is off
[    5.081484] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.081511] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.081578] sd 2:0:0:0: [sda] 1250263728 512-byte hardware sectors (640135 MB)
[    5.081591] sd 2:0:0:0: [sda] Write Protect is off
[    5.081592] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.081614] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.081617]  sda:<4>Driver 'sr' needs updating - please use bus_type methods
[    5.102194]  sda1 sda2 sda3 < sda5 >
[    5.122070] sd 2:0:0:0: [sda] Attached SCSI disk
[    5.128471] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    5.128475] Uniform CD-ROM driver Revision: 3.20
[    5.128556] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    6.301358] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00dc100091926d01]
[   11.060172] usb-storage: device scan complete
[   11.065924] scsi 6:0:0:0: Direct-Access     IOI CF/M icroDrive Disk.. 1.09 PQ: 0 ANSI: 0 CCS
[   11.067099] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[   11.067205] sd 6:0:0:0: Attached scsi generic sg2 type 0
[   15.064116] usbhid: timeout initializing reports
[   15.064254] hiddev96hidraw0: USB HID v1.11 Device [Generic USB2.0-CRW] on usb-0000:00:04.1-7
[   15.069608] input: USB Optical Mouse as /devices/pci0000:00/0000:00:04.0/usb1/1-3/1-3:1.0/input/input2
[   15.092123] input,hidraw1: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:04.0-3
[   15.092151] usbcore: registered new interface driver usbhid
[   15.092153] usbhid: v2.6:USB HID core driver
[   20.227499] kjournald starting.  Commit interval 5 seconds
[   20.227513] EXT3-fs: mounted filesystem with ordered data mode.
[   23.938643] udevd version 124 started
[   24.259423] input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   24.276534] ACPI: Power Button (FF) [PWRF]
[   24.276633] input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input4
[   24.308531] ACPI: Power Button (CM) [PWRB]
[   24.403836] ACPI: WMI: Mapper loaded
[   24.694978] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   24.717442] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   24.905737] Linux video capture interface: v2.00
[   25.005761] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   25.148910] nvidia: module license 'NVIDIA' taints kernel.
[   25.403612] ACPI: PCI Interrupt Link [SGRU] enabled at IRQ 23
[   25.403617] nvidia 0000:00:10.0: PCI INT A -> Link[SGRU] -> GSI 23 (level, low) -> IRQ 23
[   25.403622] nvidia 0000:00:10.0: setting latency timer to 64
[   25.404026] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  177.80  Wed Oct  1 14:43:46 PDT 2008
[   25.432593] gspca: main v2.2.0 registered
[   25.452036] gspca: probing 0c45:608f
[   25.459700] gspca: probe ok
[   25.459713] gspca: probing 0c45:608f
[   25.459719] gspca: probing 0c45:608f
[   25.459736] usbcore: registered new interface driver sonixb
[   25.459738] sonixb: registered
[   25.612797] usbcore: registered new interface driver snd-usb-audio
[   25.649584] HDA Intel 0000:00:09.0: power state changed by ACPI to D0
[   25.649953] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 22
[   25.649957] HDA Intel 0000:00:09.0: PCI INT A -> Link[LAZA] -> GSI 22 (level, low) -> IRQ 22
[   25.649978] HDA Intel 0000:00:09.0: setting latency timer to 64
[   26.942024] lp: driver loaded but no devices found
[   27.415887] EXT3 FS on sda5, internal journal
[   28.037585] type=1505 audit(1228783699.196:2): operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" name2="default" pid=4185
[   28.037735] type=1505 audit(1228783699.196:3): operation="profile_load" name="/usr/sbin/cupsd" name2="default" pid=4185
[   28.143573] ip_tables: (C) 2000-2006 Netfilter Core Team
[   29.136648] warning: `avahi-daemon' uses 32-bit capabilities (legacy support in use)
[   29.376681] NET: Registered protocol family 10
[   29.378265] lo: Disabled Privacy Extensions
[   29.514910] ppdev: user-space parallel port driver
[   35.204363] NET: Registered protocol family 17
[   45.280010] eth0: no IPv6 routers present

--------------030507020505030007000508--
