From: Angelin Lalev <lalev.angelin@gmail.com>
Subject: dmesg from my kernel; mb: DG45IT; processor E6300
Date: Sun, 07 Jun 2009 22:08:02 +0300
Message-ID: <1244401682.3326.2.camel@debian.pppoe-56-networx.bg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:35436 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbZFGTOs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jun 2009 15:14:48 -0400
Received: by fg-out-1718.google.com with SMTP id d23so633170fga.17
        for <linux-acpi@vger.kernel.org>; Sun, 07 Jun 2009 12:14:47 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-amd64 (Debian 2.6.26-15lenny3)
(dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian
4.1.2-25)) #1 SMP Thu May 28 21:28:49 UTC 2009
[    0.000000] Command line:
root=UUID=a960bb83-ac0d-47c3-9cc1-79636b19bbb4 ro 
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007b92b000 (usable)
[    0.000000]  BIOS-e820: 000000007b92b000 - 000000007b94d000 (ACPI
NVS)
[    0.000000]  BIOS-e820: 000000007b94d000 - 000000007ba52000
(reserved)
[    0.000000]  BIOS-e820: 000000007ba52000 - 000000007ba55000 (ACPI
NVS)
[    0.000000]  BIOS-e820: 000000007ba55000 - 000000007bb50000
(reserved)
[    0.000000]  BIOS-e820: 000000007bb50000 - 000000007bb51000 (ACPI
NVS)
[    0.000000]  BIOS-e820: 000000007bb51000 - 000000007bb59000 (ACPI
data)
[    0.000000]  BIOS-e820: 000000007bb59000 - 000000007bb63000 (ACPI
NVS)
[    0.000000]  BIOS-e820: 000000007bb63000 - 000000007bb90000
(reserved)
[    0.000000]  BIOS-e820: 000000007bb90000 - 000000007bb96000 (ACPI
NVS)
[    0.000000]  BIOS-e820: 000000007bb96000 - 000000007bd00000 (usable)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000
(reserved)
[    0.000000]  BIOS-e820: 00000000ffa80000 - 00000000ffc00000
(reserved)
[    0.000000]  BIOS-e820: 00000000ffe80000 - 0000000100000000
(reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200
used
[    0.000000] Entering add_active_range(0, 256, 506155) 1 entries of
3200 used
[    0.000000] Entering add_active_range(0, 506774, 507136) 2 entries of
3200 used
[    0.000000] max_pfn_mapped = 1048576
[    0.000000] init_memory_mapping
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP 000F03C0, 0024 (r2  INTEL)
[    0.000000] ACPI: XSDT 7BB57E18, 0044 (r1 INTEL  DG45ID         4D
MSFT    10013)
[    0.000000] ACPI: FACP 7BB56D98, 00F4 (r4  INTEL    A M I  6222004
MSFT    10013)
[    0.000000] ACPI: DSDT 7BB51018, 48CD (r1 INTEL     A M I       4D
INTL 20051117)
[    0.000000] ACPI: FACS 7BB60E40, 0040
[    0.000000] ACPI: APIC 7BB56F18, 006C (r2 INTEL     A M I       4D
MSFT    10013)
[    0.000000] ACPI: MCFG 7BB61D98, 003C (r1 INTEL  DG45ID         4D
MSFT       97)
[    0.000000] ACPI: ASF! 7BB60C18, 00A0 (r32 INTEL      DG45       4D
TFSM    F4240)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007bd00000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 3200
used
[    0.000000] Entering add_active_range(0, 256, 506155) 1 entries of
3200 used
[    0.000000] Entering add_active_range(0, 506774, 507136) 2 entries of
3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-000000007bd00000
[    0.000000]   NODE_DATA [000000000000c000 - 0000000000010fff]
[    0.000000]   bootmap [0000000000011000 -  000000000002079f] pages 10
[    0.000000]   early res: 0 [0-fff] BIOS data page
[    0.000000]   early res: 1 [6000-7fff] TRAMPOLINE
[    0.000000]   early res: 2 [200000-673397] TEXT DATA BSS
[    0.000000]   early res: 3 [37886000-37fef464] RAMDISK
[    0.000000]   early res: 4 [9fc00-fffff] BIOS reserved
[    0.000000]   early res: 5 [8000-bfff] PGTABLE
[    0.000000]  [ffffe20000000000-ffffe20001bfffff] PMD ->
[ffff810001200000-ffff810002dfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   506155
[    0.000000]     0:   506774 ->   507136
[    0.000000] On node 0 totalpages: 506420
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1242 pages reserved
[    0.000000]   DMA zone: 2701 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6878 pages used for memmap
[    0.000000]   DMA32 zone: 495543 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 0, address 0xfec00000, GSI
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high
level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] PM: Registered nosave memory: 000000000009f000 -
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 -
00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 -
0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007b92b000 -
000000007b94d000
[    0.000000] PM: Registered nosave memory: 000000007b94d000 -
000000007ba52000
[    0.000000] PM: Registered nosave memory: 000000007ba52000 -
000000007ba55000
[    0.000000] PM: Registered nosave memory: 000000007ba55000 -
000000007bb50000
[    0.000000] PM: Registered nosave memory: 000000007bb50000 -
000000007bb51000
[    0.000000] PM: Registered nosave memory: 000000007bb51000 -
000000007bb59000
[    0.000000] PM: Registered nosave memory: 000000007bb59000 -
000000007bb63000
[    0.000000] PM: Registered nosave memory: 000000007bb63000 -
000000007bb90000
[    0.000000] PM: Registered nosave memory: 000000007bb90000 -
000000007bb96000
[    0.000000] Allocating PCI resources starting at 80000000 (gap:
7bd00000:8301c000)
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] PERCPU: Allocating 37168 bytes of per cpu data
[    0.000000] NR_CPUS: 32, nr_cpu_ids: 4
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 498244
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line:
root=UUID=a960bb83-ac0d-47c3-9cc1-79636b19bbb4 ro 
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] TSC calibrated against PM_TIMER
[    0.000000] time.c: Detected 2800.093 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA -
bailing!
[    0.004000] Memory: 1984500k/2028544k available (2225k kernel code,
41180k reserved, 1080k data, 392k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.084007] Calibrating delay using timer specific routine.. 5604.47
BogoMIPS (lpj=11208951)
[    0.084118] Security Framework initialized
[    0.084161] SELinux:  Disabled at boot.
[    0.084201] Capability LSM initialized
[    0.084386] Dentry cache hash table entries: 262144 (order: 9,
2097152 bytes)
[    0.085301] Inode-cache hash table entries: 131072 (order: 8, 1048576
bytes)
[    0.085839] Mount-cache hash table entries: 256
[    0.086012] Initializing cgroup subsys ns
[    0.086056] Initializing cgroup subsys cpuacct
[    0.086097] Initializing cgroup subsys devices
[    0.086154] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.086212] CPU: L2 cache: 2048K
[    0.086251] CPU 0/0 -> Node 0
[    0.086288] CPU: Physical Processor ID: 0
[    0.086328] CPU: Processor Core ID: 0
[    0.086371] CPU0: Thermal monitoring enabled (TM2)
[    0.086412] using mwait in idle threads.
[    0.087204] ACPI: Core revision 20080321
[    0.133739] CPU0: Pentium(R) Dual-Core  CPU      E6300  @ 2.80GHz
stepping 0a
[    0.133821] Using local APIC timer interrupts.
[    0.140008] APIC timer calibration result 16667214
[    0.140008] Detected 16.667 MHz APIC timer.
[    0.140008] Booting processor 1/1 ip 6000
[    0.148009] Initializing CPU#1
[    0.148009] Calibrating delay using timer specific routine.. 5600.16
BogoMIPS (lpj=11200326)
[    0.148009] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.148009] CPU: L2 cache: 2048K
[    0.148009] CPU 1/1 -> Node 0
[    0.148009] CPU: Physical Processor ID: 0
[    0.148009] CPU: Processor Core ID: 1
[    0.148009] CPU1: Thermal monitoring enabled (TM2)
[    0.228014] CPU1: Pentium(R) Dual-Core  CPU      E6300  @ 2.80GHz
stepping 0a
[    0.228014] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.232014] Brought up 2 CPUs
[    0.232014] Total of 2 processors activated (11204.63 BogoMIPS).
[    0.232014] CPU0 attaching sched-domain:
[    0.232014]  domain 0: span 0-1
[    0.232014]   groups: 0 1
[    0.232014]   domain 1: span 0-1
[    0.232014]    groups: 0-1
[    0.232014] CPU1 attaching sched-domain:
[    0.232014]  domain 0: span 0-1
[    0.232014]   groups: 1 0
[    0.232014]   domain 1: span 0-1
[    0.232014]    groups: 0-1
[    0.232014] net_namespace: 1224 bytes
[    0.232014] Booting paravirtualized kernel on bare hardware
[    0.232014] NET: Registered protocol family 16
[    0.232014] ACPI: bus type pci registered
[    0.232014] PCI: MCFG configuration 0: base e0000000 segment 0 buses
0 - 255
[    0.232014] PCI: Not using MMCONFIG.
[    0.232014] PCI: Using configuration type 1 for base access
[    0.232014] ACPI: EC: Look up EC in DSDT
[    0.235803] ACPI: BIOS _OSI(Linux) query ignored
[    0.235844] ACPI: DMI System Vendor:         
[    0.235884] ACPI: DMI Product Name:         
[    0.235924] ACPI: DMI Product Version:         
[    0.235965] ACPI: DMI Board Name: DG45ID
[    0.236004] ACPI: DMI BIOS Vendor: Intel Corp.
[    0.236014] ACPI: DMI BIOS Date: 07/25/2008
[    0.236014] ACPI: Please send DMI info above to
linux-acpi@vger.kernel.org
[    0.236014] ACPI: If "acpi_osi=Linux" works better, please notify
linux-acpi@vger.kernel.org
[    0.237993] ACPI: Interpreter enabled
[    0.238033] ACPI: (supports S0 S1 S3 S4 S5)
[    0.238170] ACPI: Using IOAPIC for interrupt routing
[    0.238313] PCI: MCFG configuration 0: base e0000000 segment 0 buses
0 - 255
[    0.238414] PCI: MCFG area at e0000000 reserved in ACPI motherboard
resources
[    0.249687] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.256136] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.256136] PCI: Transparent bridge - 0000:00:1e.0
[    0.256136] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.256136] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.260136] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12
14 15)
[    0.260136] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12
14 15) *0
[    0.260136] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12
14 15)
[    0.260136] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12
14 15)
[    0.260458] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12
14 15)
[    0.260794] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12
14 15)
[    0.263704] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 12
14 15)
[    0.264039] ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 12
14 15)
[    0.266129] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.266709] pnp: PnP ACPI init
[    0.266709] ACPI: bus type pnp registered
[    0.266709] pnp 00:00: parse allocated resources
[    0.266709] pnp 00:00:   add io  0xcf8-0xcff flags 0x1
[    0.266709] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03
(active)
[    0.266709] pnp 00:01: parse allocated resources
[    0.266709] pnp 00:01:   add mem 0xfed14000-0xfed19fff flags 0x1
[    0.266709] pnp 00:01:   add mem 0xe0000000-0xefffffff flags 0x1
[    0.266709] pnp 00:01:   add mem 0xfed08000-0xfed08fff flags 0x1
[    0.266709] pnp 00:01: PNP0c01: calling quirk_system_pci_resources
+0x0/0x15c
[    0.266709] pnp 00:01: Plug and Play ACPI device, IDs PNP0c01
(active)
[    0.266709] pnp 00:02: parse allocated resources
[    0.266709] pnp 00:02:   add io  0x0-0xffffffffffffffff flags
0x10000001
[    0.266709] pnp 00:02:   add io  0xa20-0xa3f flags 0x1
[    0.266709] pnp 00:02:   add io  0xa00-0xa1f flags 0x1
[    0.266709] pnp 00:02:   add io  0x0-0xffffffffffffffff flags
0x10000001
[    0.266709] pnp 00:02:   add io  0x0-0xffffffffffffffff flags
0x10000001
[    0.266709] pnp 00:02:   add io  0xb78-0xb7f flags 0x1
[    0.266709] pnp 00:02:   add io  0xf78-0xf7f flags 0x1
[    0.266709] pnp 00:02: PNP0c02: calling quirk_system_pci_resources
+0x0/0x15c
[    0.266709] pnp 00:02: Plug and Play ACPI device, IDs PNP0c02
(active)
[    0.266709] pnp 00:03: parse allocated resources
[    0.266709] pnp 00:03:   add io  0x3f8-0x3ff flags 0x1
[    0.266709] pnp 00:03:   add irq 4 flags 0x1
[    0.266709] pnp 00:03: parse resource options
[    0.266709] pnp 00:03: new independent option
[    0.266709] pnp 00:03: new dependent option (priority 0x0)
[    0.266709] pnp 00:03:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags
0x1
[    0.266709] pnp 00:03:   irq bitmask
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010
flags 0x1
[    0.266709] pnp 00:03: new dependent option (priority 0x1)
[    0.266709] pnp 00:03:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags
0x1
[    0.266709] pnp 00:03:   irq bitmask
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001cf8
flags 0x1
[    0.266709] pnp 00:03: new dependent option (priority 0x1)
[    0.266709] pnp 00:03:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags
0x1
[    0.266709] pnp 00:03:   irq bitmask
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001cf8
flags 0x1
[    0.266709] pnp 00:03: new dependent option (priority 0x1)
[    0.266709] pnp 00:03:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags
0x1
[    0.266709] pnp 00:03:   irq bitmask
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001cf8
flags 0x1
[    0.266709] pnp 00:03: new dependent option (priority 0x1)
[    0.266709] pnp 00:03:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags
0x1
[    0.266709] pnp 00:03:   irq bitmask
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00001cf8
flags 0x1
[    0.266709] pnp 00:03: end dependent options
[    0.266709] pnp 00:03: Plug and Play ACPI device, IDs PNP0501
(active)
[    0.266709] pnp 00:04: parse allocated resources
[    0.266709] pnp 00:04:   add dma 4 flags 0x4
[    0.266709] pnp 00:04:   add io  0x0-0xf flags 0x1
[    0.266709] pnp 00:04:   add io  0x81-0x83 flags 0x1
[    0.266709] pnp 00:04:   add io  0x87-0x87 flags 0x1
[    0.266709] pnp 00:04:   add io  0x89-0x8b flags 0x1
[    0.266709] pnp 00:04:   add io  0x8f-0x8f flags 0x1
[    0.266709] pnp 00:04:   add io  0xc0-0xdf flags 0x1
[    0.266709] pnp 00:04: Plug and Play ACPI device, IDs PNP0200
(active)
[    0.266709] pnp 00:05: parse allocated resources
[    0.266709] pnp 00:05:   add io  0x70-0x71 flags 0x1
[    0.266709] pnp 00:05:   add irq 8 flags 0x1
[    0.266709] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00
(active)
[    0.266709] pnp 00:06: parse allocated resources
[    0.266709] pnp 00:06:   add io  0x61-0x61 flags 0x1
[    0.266710] pnp 00:06: Plug and Play ACPI device, IDs PNP0800
(active)
[    0.266710] pnp 00:07: parse allocated resources
[    0.266710] pnp 00:07:   add io  0x10-0x1f flags 0x1
[    0.266710] pnp 00:07:   add io  0x22-0x3f flags 0x1
[    0.266710] pnp 00:07:   add io  0x44-0x5f flags 0x1
[    0.266710] pnp 00:07:   add io  0x62-0x63 flags 0x1
[    0.266710] pnp 00:07:   add io  0x65-0x6f flags 0x1
[    0.266710] pnp 00:07:   add io  0x72-0x7f flags 0x1
[    0.266710] pnp 00:07:   add io  0x80-0x80 flags 0x1
[    0.266710] pnp 00:07:   add io  0x84-0x86 flags 0x1
[    0.266710] pnp 00:07:   add io  0x88-0x88 flags 0x1
[    0.266710] pnp 00:07:   add io  0x8c-0x8e flags 0x1
[    0.266710] pnp 00:07:   add io  0x90-0x9f flags 0x1
[    0.266710] pnp 00:07:   add io  0xa2-0xbf flags 0x1
[    0.266710] pnp 00:07:   add io  0xe0-0xef flags 0x1
[    0.266710] pnp 00:07:   add io  0x4d0-0x4d1 flags 0x1
[    0.266710] pnp 00:07: PNP0c02: calling quirk_system_pci_resources
+0x0/0x15c
[    0.266710] pnp 00:07: Plug and Play ACPI device, IDs PNP0c02
(active)
[    0.266710] pnp 00:08: parse allocated resources
[    0.266710] pnp 00:08:   add io  0xf0-0xff flags 0x1
[    0.266710] pnp 00:08:   add irq 13 flags 0x1
[    0.266710] pnp 00:08: Plug and Play ACPI device, IDs PNP0c04
(active)
[    0.266710] pnp 00:09: parse allocated resources
[    0.266710] pnp 00:09:   add io  0x400-0x47f flags 0x1
[    0.266710] pnp 00:09:   add io  0x1180-0x119f flags 0x1
[    0.266710] pnp 00:09:   add io  0x500-0x57f flags 0x1
[    0.266710] pnp 00:09:   add io  0x60-0x60 flags 0x1
[    0.266710] pnp 00:09:   add io  0x64-0x64 flags 0x1
[    0.266710] pnp 00:09:   add mem 0xfed1c000-0xfed1ffff flags 0x1
[    0.266710] pnp 00:09:   add mem 0xfec00000-0xfecfffff flags 0x1
[    0.266710] pnp 00:09:   add mem 0xfee00000-0xfee0ffff flags 0x1
[    0.266710] pnp 00:09:   add mem 0xfed20000-0xfed9ffff flags 0x1
[    0.266710] pnp 00:09:   add mem 0xffe00000-0xffffffff flags 0x0
[    0.266710] pnp 00:09: PNP0c01: calling quirk_system_pci_resources
+0x0/0x15c
[    0.266710] pnp 00:09: Plug and Play ACPI device, IDs PNP0c01
(active)
[    0.266710] pnp: PnP ACPI: found 10 devices
[    0.266710] ACPI: ACPI bus type pnp unregistered
[    0.270710] usbcore: registered new interface driver usbfs
[    0.270710] usbcore: registered new interface driver hub
[    0.270710] usbcore: registered new device driver usb
[    0.270710] PCI: Using ACPI for IRQ routing
[    0.286122] PCI-GART: No AMD northbridge found.
[    0.286218] ACPI: RTC can wake from S4
[    0.302035] pnp: the driver 'system' has been registered
[    0.302048] system 00:01: iomem range 0xfed14000-0xfed19fff has been
reserved
[    0.302101] system 00:01: iomem range 0xe0000000-0xefffffff has been
reserved
[    0.302151] system 00:01: iomem range 0xfed08000-0xfed08fff has been
reserved
[    0.302201] system 00:01: driver attached
[    0.302207] system 00:02: ioport range 0xa20-0xa3f has been reserved
[    0.302260] system 00:02: ioport range 0xa00-0xa1f has been reserved
[    0.302304] system 00:02: ioport range 0xb78-0xb7f has been reserved
[    0.303551] system 00:02: ioport range 0xf78-0xf7f has been reserved
[    0.303551] system 00:02: driver attached
[    0.303551] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.303551] system 00:07: driver attached
[    0.303551] system 00:09: ioport range 0x400-0x47f has been reserved
[    0.303551] system 00:09: ioport range 0x1180-0x119f has been
reserved
[    0.303551] system 00:09: ioport range 0x500-0x57f has been reserved
[    0.303551] system 00:09: iomem range 0xfed1c000-0xfed1ffff could not
be reserved
[    0.303551] system 00:09: iomem range 0xfec00000-0xfecfffff has been
reserved
[    0.303551] system 00:09: iomem range 0xfee00000-0xfee0ffff has been
reserved
[    0.303551] system 00:09: iomem range 0xfed20000-0xfed9ffff has been
reserved
[    0.303551] system 00:09: iomem range 0xffe00000-0xffffffff could not
be reserved
[    0.303551] system 00:09: driver attached
[    0.303551] PCI: Bridge: 0000:00:1e.0
[    0.303551]   IO window: disabled.
[    0.303551]   MEM window: 0xff500000-0xff5fffff
[    0.303551]   PREFETCH window: 0x00000000d0000000-0x00000000d00fffff
[    0.303551] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.303551] NET: Registered protocol family 2
[    0.337576] IP route cache hash table entries: 65536 (order: 7,
524288 bytes)
[    0.338148] TCP established hash table entries: 262144 (order: 10,
4194304 bytes)
[    0.341436] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes)
[    0.341961] TCP: Hash tables configured (established 262144 bind
65536)
[    0.342006] TCP reno registered
[    0.350987] NET: Registered protocol family 1
[    0.351124] checking if image is initramfs... it is
[    0.794689] Freeing initrd memory: 7589k freed
[    0.799431] audit: initializing netlink socket (disabled)
[    0.799494] type=2000 audit(1244395979.791:1): initialized
[    0.799494] Total HugeTLB memory allocated, 0
[    0.799494] VFS: Disk quotas dquot_6.5.1
[    0.799494] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.799494] msgmni has been set to 3890
[    0.799495] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 253)
[    0.799495] io scheduler noop registered
[    0.799495] io scheduler anticipatory registered
[    0.799495] io scheduler deadline registered
[    0.799495] io scheduler cfq registered (default)
[    0.799504] pci 0000:00:02.0: Boot video device
[    0.806370] Switched to high resolution mode on CPU 1
[    0.810348] Switched to high resolution mode on CPU 0
[   10.888042] pci 0000:00:1a.7: EHCI: BIOS handoff failed (BIOS bug?)
01010001
[   20.993907] pci 0000:00:1d.7: EHCI: BIOS handoff failed (BIOS bug?)
01010001
[   20.998401] Linux agpgart interface v0.103
[   20.998401] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing enabled
[   20.998401] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   20.998401] pnp: the driver 'serial' has been registered
[   20.998401] 00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   20.998401] serial 00:03: driver attached
[   20.998402] brd: module loaded
[   20.998402] input: Macintosh mouse button emulation
as /class/input/input0
[   20.998402] pnp: the driver 'i8042 kbd' has been registered
[   20.998402] pnp: the driver 'i8042 aux' has been registered
[   20.998402] pnp: the driver 'i8042 kbd' has been unregistered
[   20.998402] pnp: the driver 'i8042 aux' has been unregistered
[   20.998402] PNP: No PS/2 controller found. Probing ports directly.
[   21.002401] serio: i8042 KBD port at 0x60,0x64 irq 1
[   21.002401] serio: i8042 AUX port at 0x60,0x64 irq 12
[   21.504373] mice: PS/2 mouse device common for all mice
[   21.505456] pnp: the driver 'rtc_cmos' has been registered
[   21.505873] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[   21.505873] rtc0: alarms up to one year, y3k
[   21.505873] rtc_cmos 00:05: driver attached
[   21.505873] cpuidle: using governor ladder
[   21.505873] cpuidle: using governor menu
[   21.505873] No iBFT detected.
[   21.505873] TCP cubic registered
[   21.505873] NET: Registered protocol family 17
[   21.505873] registered taskstats version 1
[   21.505873] rtc_cmos 00:05: setting system clock to 2009-06-07
17:33:16 UTC (1244395996)
[   21.505873] Freeing unused kernel memory: 392k freed
[   21.561883] ACPI: SSDT 7BB5AC18, 02CC (r1    AMI      IST        1
MSFT  3000001)
[   21.565876] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   21.565876] ACPI: ACPI0007:00 is registered as cooling_device0
[   21.565876] Marking TSC unstable due to TSC halts in idle
[   21.565905] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   21.565910] ACPI: ACPI0007:01 is registered as cooling_device1
[   21.738814] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k2
[   21.738814] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[   21.738814] ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level,
low) -> IRQ 20
[   21.738814] PCI: Setting latency timer of device 0000:00:19.0 to 64
[   21.746816] USB Universal Host Controller Interface driver v3.0
[   21.798814] No dock devices found.
[   21.802815] SCSI subsystem initialized
[   21.818817] libata version 3.00 loaded.
[   21.834817] eth0: (PCI Express:2.5GB/s:Width x1) 00:1c:c0:7f:95:4a
[   21.834817] eth0: Intel(R) PRO/1000 Network Connection
[   21.834817] eth0: MAC: 5, PHY: 8, PBA No: ffffff-0ff
[   21.834817] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   21.834817] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   21.834817] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   21.834817] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned
bus number 1
[   21.834817] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000f0c0
[   21.834817] usb usb1: configuration #1 chosen from 1 choice
[   21.834817] hub 1-0:1.0: USB hub found
[   21.834817] hub 1-0:1.0: 2 ports detected
[   21.935701] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0001
[   21.935749] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   21.935817] usb usb1: Product: UHCI Host Controller
[   21.935863] usb usb1: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   21.935914] usb usb1: SerialNumber: 0000:00:1a.0
[   21.939601] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level,
low) -> IRQ 21
[   21.939601] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   21.939601] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   21.939601] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned
bus number 2
[   21.939601] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000f0a0
[   21.939601] usb usb2: configuration #1 chosen from 1 choice
[   21.939601] hub 2-0:1.0: USB hub found
[   21.939601] hub 2-0:1.0: 2 ports detected
[   21.993818] Clocksource tsc unstable (delta = -122902096 ns)
[   22.041677] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0001
[   22.041723] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   22.041784] usb usb2: Product: UHCI Host Controller
[   22.041826] usb usb2: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   22.041869] usb usb2: SerialNumber: 0000:00:1a.1
[   22.043494] ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level,
low) -> IRQ 18
[   22.043494] PCI: Setting latency timer of device 0000:00:1a.2 to 64
[   22.043494] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[   22.043494] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned
bus number 3
[   22.043494] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000f080
[   22.043494] usb usb3: configuration #1 chosen from 1 choice
[   22.043494] hub 3-0:1.0: USB hub found
[   22.043494] hub 3-0:1.0: 2 ports detected
[   22.145677] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0001
[   22.145723] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   22.145783] usb usb3: Product: UHCI Host Controller
[   22.145824] usb usb3: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   22.145868] usb usb3: SerialNumber: 0000:00:1a.2
[   22.146475] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level,
low) -> IRQ 18
[   22.146475] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   22.146475] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   22.146475] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned
bus number 4
[   22.150901] ehci_hcd 0000:00:1a.7: debug port 1
[   22.150901] PCI: cache line size of 32 is not supported by device
0000:00:1a.7
[   22.150901] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xff625400
[   22.170974] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver
10 Dec 2004
[   22.170974] usb usb4: configuration #1 chosen from 1 choice
[   22.170974] hub 4-0:1.0: USB hub found
[   22.170974] hub 4-0:1.0: 6 ports detected
[   22.274990] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0002
[   22.274990] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   22.274990] usb usb4: Product: EHCI Host Controller
[   22.274990] usb usb4: Manufacturer: Linux 2.6.26-2-amd64 ehci_hcd
[   22.274990] usb usb4: SerialNumber: 0000:00:1a.7
[   22.274990] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level,
low) -> IRQ 23
[   22.274997] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   22.274999] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   22.275069] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned
bus number 5
[   22.275149] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000f060
[   22.275234] usb usb5: configuration #1 chosen from 1 choice
[   22.275293] hub 5-0:1.0: USB hub found
[   22.275336] hub 5-0:1.0: 2 ports detected
[   22.378202] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0001
[   22.378248] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   22.378308] usb usb5: Product: UHCI Host Controller
[   22.378350] usb usb5: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   22.378394] usb usb5: SerialNumber: 0000:00:1d.0
[   22.379913] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level,
low) -> IRQ 19
[   22.379920] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   22.379922] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   22.379988] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned
bus number 6
[   22.380070] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000f040
[   22.380157] usb usb6: configuration #1 chosen from 1 choice
[   22.380215] hub 6-0:1.0: USB hub found
[   22.380257] hub 6-0:1.0: 2 ports detected
[   22.483152] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0001
[   22.483197] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   22.483257] usb usb6: Product: UHCI Host Controller
[   22.483298] usb usb6: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   22.483343] usb usb6: SerialNumber: 0000:00:1d.1
[   22.483955] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level,
low) -> IRQ 18
[   22.483962] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   22.483964] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   22.484035] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned
bus number 7
[   22.484373] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000f020
[   22.484373] usb usb7: configuration #1 chosen from 1 choice
[   22.484373] hub 7-0:1.0: USB hub found
[   22.484373] hub 7-0:1.0: 2 ports detected
[   22.585923] usb usb7: New USB device found, idVendor=1d6b,
idProduct=0001
[   22.585968] usb usb7: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   22.586028] usb usb7: Product: UHCI Host Controller
[   22.586069] usb usb7: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   22.586113] usb usb7: SerialNumber: 0000:00:1d.2
[   22.587173] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level,
low) -> IRQ 23
[   22.587173] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   22.587173] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   22.587173] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned
bus number 8
[   22.592310] ehci_hcd 0000:00:1d.7: debug port 1
[   22.592310] PCI: cache line size of 32 is not supported by device
0000:00:1d.7
[   22.592310] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xff625000
[   22.608400] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver
10 Dec 2004
[   22.608400] usb usb8: configuration #1 chosen from 1 choice
[   22.608400] hub 8-0:1.0: USB hub found
[   22.608400] hub 8-0:1.0: 6 ports detected
[   22.712139] usb usb8: New USB device found, idVendor=1d6b,
idProduct=0002
[   22.712185] usb usb8: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[   22.712245] usb usb8: Product: EHCI Host Controller
[   22.712286] usb usb8: Manufacturer: Linux 2.6.26-2-amd64 ehci_hcd
[   22.712330] usb usb8: SerialNumber: 0000:00:1d.7
[   22.712385] ata_piix 0000:00:1f.2: version 2.12
[   22.712385] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level,
low) -> IRQ 19
[   22.712385] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   22.712385] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   22.712385] scsi0 : ata_piix
[   22.712385] scsi1 : ata_piix
[   22.712385] ata1: SATA max UDMA/133 cmd 0xf1b0 ctl 0xf1a0 bmdma
0xf170 irq 19
[   22.712385] ata2: SATA max UDMA/133 cmd 0xf190 ctl 0xf180 bmdma
0xf178 irq 19
[   23.601628] usb 8-6: new high speed USB device using ehci_hcd and
address 4
[   23.735855] usb 8-6: configuration #1 chosen from 1 choice
[   23.738009] usb 8-6: New USB device found, idVendor=3538,
idProduct=0059
[   23.738009] usb 8-6: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[   23.738009] usb 8-6: Product: PQI USB Flash Drive
[   23.738009] usb 8-6: Manufacturer: PQI
[   23.738009] usb 8-6: SerialNumber: 00000000000706
[   23.753763] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   23.757702] ata1.00: HPA detected: current 240119615, native
240121728
[   23.757702] ata1.00: ATA-7: Maxtor 6Y120M0, YAR51EW0, max UDMA/133
[   23.757702] ata1.00: 240119615 sectors, multi 0: LBA 
[   23.774414] ata1.00: configured for UDMA/133
[   23.979811] usb 6-1: new low speed USB device using uhci_hcd and
address 2
[   24.107559] ata2: SATA link down (SStatus 0 SControl 300)
[   24.107559] isa bounce pool size: 16 pages
[   24.107559] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y120M0
YAR5 PQ: 0 ANSI: 5
[   24.107565] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level,
low) -> IRQ 22
[   24.158843] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[22]
MMIO=[ff500000-ff5007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[   24.167841] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level,
low) -> IRQ 19
[   24.167841] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[   24.167841] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   24.167841] scsi2 : ata_piix
[   24.167841] scsi3 : ata_piix
[   24.167841] ata3: SATA max UDMA/133 cmd 0xf150 ctl 0xf140 bmdma
0xf110 irq 19
[   24.167841] ata4: SATA max UDMA/133 cmd 0xf130 ctl 0xf120 bmdma
0xf118 irq 19
[   24.174512] usb 6-1: configuration #1 chosen from 1 choice
[   24.182892] usb 6-1: New USB device found, idVendor=1241,
idProduct=1177
[   24.182944] usb 6-1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[   24.230800] Initializing USB Mass Storage driver...
[   24.420976] usb 6-2: new low speed USB device using uhci_hcd and
address 3
[   24.495672] ata3: SATA link down (SStatus 0 SControl 300)
[   24.599632] usb 6-2: configuration #1 chosen from 1 choice
[   24.603364] usb 6-2: New USB device found, idVendor=049f,
idProduct=0005
[   24.603411] usb 6-2: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[   24.603457] usb 6-2: Product: USB Keyboard 
[   24.603497] usb 6-2: Manufacturer: Silitek
[   24.603497] scsi4 : SCSI emulation for USB Mass Storage devices
[   24.603608] usbcore: registered new interface driver usb-storage
[   24.603652] USB Mass Storage support registered.
[   24.603768] usb-storage: device found at 4
[   24.603769] usb-storage: waiting for device to settle before scanning
[   24.603785] usbcore: registered new interface driver hiddev
[   24.637265] input: HID 1241:1177 as /class/input/input1
[   24.655299] input,hidraw0: USB HID v1.00 Mouse [HID 1241:1177] on
usb-0000:00:1d.1-1
[   24.670047] input: Silitek USB Keyboard  as /class/input/input2
[   24.683080] input,hidraw1: USB HID v1.00 Keyboard [Silitek USB
Keyboard ] on usb-0000:00:1d.1-2
[   24.719362] input: Silitek USB Keyboard  as /class/input/input3
[   24.730519] input,hiddev96,hidraw2: USB HID v1.00 Device [Silitek USB
Keyboard ] on usb-0000:00:1d.1-2
[   24.730845] usbcore: registered new interface driver usbhid
[   24.730890] usbhid: v2.6:USB HID core driver
[   24.827501] ata4: SATA link down (SStatus 0 SControl 300)
[   24.832385] Uniform Multi-Platform E-IDE driver
[   24.832385] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
[   24.842775] Driver 'sd' needs updating - please use bus_type methods
[   24.842775] sd 0:0:0:0: [sda] 240119615 512-byte hardware sectors
(122941 MB)
[   24.842775] sd 0:0:0:0: [sda] Write Protect is off
[   24.842775] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   24.842775] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   24.842775] sd 0:0:0:0: [sda] 240119615 512-byte hardware sectors
(122941 MB)
[   24.842775] sd 0:0:0:0: [sda] Write Protect is off
[   24.842775] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   24.842775] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   24.842775]  sda: sda1 sda2 sda4 < sda5 sda6 sda7 >
[   24.937794] sd 0:0:0:0: [sda] Attached SCSI disk
[   25.385062] PM: Starting manual resume from disk
[   25.438511] kjournald starting.  Commit interval 5 seconds
[   25.438511] EXT3-fs: mounted filesystem with ordered data mode.
[   25.446882] ieee1394: Host added: ID:BUS[0-00:1023]
GUID[0090270002370a93]
[   26.996639] udevd version 125 started
[   27.582831] input: Power Button (FF) as /class/input/input4
[   27.589332] agpgart: Detected an Intel G45/G43 Chipset.
[   27.589332] agpgart: Detected 32764K stolen memory.
[   27.601138] agpgart: AGP aperture is 256M @ 0xc0000000
[   27.718659] ACPI: Power Button (FF) [PWRF]
[   27.718758] input: Power Button (CM) as /class/input/input5
[   27.782162] ACPI: Power Button (CM) [PWRB]
[   28.336954] input: PC Speaker as /class/input/input6
[   28.489109] ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level,
low) -> IRQ 18
[   28.600269] Linux video capture interface: v2.00
[   28.684572] bttv: driver version 0.9.17 loaded
[   28.684572] bttv: using 8 buffers with 2080k (520 pages) each for
capture
[   28.684572] bttv: Bt8xx card found (0).
[   28.684572] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 21 (level,
low) -> IRQ 21
[   28.684572] bttv0: Bt878 (rev 17) at 0000:01:00.0, irq: 21, latency:
32, mmio: 0xd0001000
[   28.684572] bttv0: using:  *** UNKNOWN/GENERIC ***
[card=0,autodetected]
[   28.684572] bttv0: gpio: en=00000000, out=00000000 in=009fc0ff [init]
[   28.684572] tveeprom 1-0050: Huh, no eeprom present (err=-121)?
[   28.684572] bttv0: tuner type unset
[   28.684572] bttv0: i2c: checking for MSP34xx @ 0x80... not found
[   28.684572] bttv0: i2c: checking for TDA9875 @ 0xb0... not found
[   28.684572] bttv0: i2c: checking for TDA7432 @ 0x8a... not found
[   28.685082] bttv0: registered device video0
[   28.685151] bttv0: registered device vbi0
[   28.876039] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level,
low) -> IRQ 22
[   28.876039] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   29.642740] usb-storage: device scan complete
[   29.644310] scsi 4:0:0:0: Direct-Access     Generic  USB Flash Disk
0.00 PQ: 0 ANSI: 2
[   29.646659] sd 4:0:0:0: [sdb] 15794176 512-byte hardware sectors
(8087 MB)
[   29.647153] sd 4:0:0:0: [sdb] Write Protect is off
[   29.647153] sd 4:0:0:0: [sdb] Mode Sense: 00 00 00 00
[   29.647153] sd 4:0:0:0: [sdb] Assuming drive cache: write through
[   29.650281] sd 4:0:0:0: [sdb] 15794176 512-byte hardware sectors
(8087 MB)
[   29.650793] sd 4:0:0:0: [sdb] Write Protect is off
[   29.650793] sd 4:0:0:0: [sdb] Mode Sense: 00 00 00 00
[   29.650793] sd 4:0:0:0: [sdb] Assuming drive cache: write through
[   29.650793]  sdb:
[   29.761115] sd 4:0:0:0: [sdb] Attached SCSI removable disk
[   30.030499] Adding 3903752k swap on /dev/sda6.  Priority:-1 extents:1
across:3903752k
[   30.438148] EXT3 FS on sda5, internal journal
[   31.069796] loop: module loaded
[   33.591795] NET: Registered protocol family 10
[   33.591795] lo: Disabled Privacy Extensions
[   33.592121] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   34.151078] eth0: Link is Up 100 Mbps Full Duplex, Flow Control:
RX/TX
[   34.151153] eth0: 10/100 speed: disabling TSO
[   34.151442] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   35.222671] pnp: the driver 'parport_pc' has been registered
[   35.222671] parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
[   35.350963] parport0: irq 5 detected
[   35.446799] lp0: using parport0 (polling).
[   35.476307] ppdev: user-space parallel port driver
[   38.691839] Bluetooth: Core ver 2.11
[   38.691839] NET: Registered protocol family 31
[   38.691839] Bluetooth: HCI device and connection manager initialized
[   38.691839] Bluetooth: HCI socket layer initialized
[   38.753019] Bluetooth: L2CAP ver 2.9
[   38.753019] Bluetooth: L2CAP socket layer initialized
[   38.809624] Bluetooth: RFCOMM socket layer initialized
[   38.809624] Bluetooth: RFCOMM TTY layer initialized
[   38.809624] Bluetooth: RFCOMM ver 1.8
[   41.753916] [drm] Initialized drm 1.1.0 20060810
[   41.763020] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   41.763020] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   41.763020] [drm] Initialized i915 1.6.0 20060119 on minor 0
[   41.767058] [drm:i915_getparam] *ERROR* Unknown parameter 5
[   42.312416] set status page addr 0x030ca000
[   44.290875] eth0: no IPv6 routers present
[   57.939062] FAT: utf8 is not a recommended IO charset for FAT
filesystems, filesystem will be case sensitive!
[ 1928.857033] NTFS driver 2.1.29 [Flags: R/W MODULE].
[ 1928.927432] NTFS volume version 3.1.
[ 1928.927439] NTFS-fs error (device sda2): load_system_files(): Volume
is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
[ 3605.184069] NTFS volume version 3.1.
[ 3605.184075] NTFS-fs error (device sda2): load_system_files(): Volume
is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
[ 3622.046548] NTFS-fs error (device sda2): parse_options():
Unrecognized mount option force.
[ 3639.612883] NTFS volume version 3.1.
[ 3639.612889] NTFS-fs error (device sda2): load_system_files(): Volume
is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
[ 3677.277817] NTFS volume version 3.1.
[ 3677.277817] NTFS-fs error (device sda2): load_system_files(): Volume
is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
[ 4669.044171] NTFS volume version 3.1.
[ 4669.044171] NTFS-fs error (device sda2): load_system_files(): Volume
is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
[ 4860.873001] NTFS volume version 3.1.
[ 4860.873001] NTFS-fs error (device sda2): load_system_files(): Volume
is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
[ 5110.406643] NTFS volume version 3.1.
[ 5110.406643] NTFS-fs error (device sda2): load_system_files(): Volume
is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
[15462.498485] NTFS volume version 3.1.
[15462.498485] NTFS-fs warning (device sda1): load_system_files():
Unsupported volume flags 0x4000 encountered.
[15462.498485] NTFS-fs error (device sda1): load_system_files(): Volume
has unsupported flags set.  Mounting read-only.  Run chkdsk and mount in
Windows.
[16154.502118] usb 8-6: USB disconnect, address 4
[16233.119852] FAT: Directory bread(block 7744) failed
[16233.119852] FAT: Directory bread(block 7745) failed
[16233.119852] FAT: Directory bread(block 7746) failed
[16233.119852] FAT: Directory bread(block 7747) failed
[16233.119852] FAT: Directory bread(block 7748) failed
[16233.119852] FAT: Directory bread(block 7749) failed
[16233.119852] FAT: Directory bread(block 7750) failed
[16233.119852] FAT: Directory bread(block 7751) failed
[16233.119852] FAT: Directory bread(block 7752) failed
[16233.119852] FAT: Directory bread(block 7753) failed
[16233.119852] FAT: Directory bread(block 7754) failed
[16233.119852] FAT: Directory bread(block 7755) failed
[16233.119852] FAT: Directory bread(block 7756) failed
[16233.119852] FAT: Directory bread(block 7757) failed
[16233.119852] FAT: Directory bread(block 7758) failed
[16233.119852] FAT: Directory bread(block 7759) failed
[16233.119852] FAT: Directory bread(block 7760) failed
[16233.119852] FAT: Directory bread(block 7761) failed
[16233.119852] FAT: Directory bread(block 7762) failed
[16233.119852] FAT: Directory bread(block 7763) failed
[16233.119852] FAT: Directory bread(block 7764) failed
[16233.119852] FAT: Directory bread(block 7765) failed
[16233.119852] FAT: Directory bread(block 7766) failed
[16233.119852] FAT: Directory bread(block 7767) failed
[16233.119852] FAT: Directory bread(block 7768) failed
[16233.119852] FAT: Directory bread(block 7769) failed
[16233.119852] FAT: Directory bread(block 7770) failed
[16233.119852] FAT: Directory bread(block 7771) failed
[16233.119852] FAT: Directory bread(block 7772) failed
[16233.119852] FAT: Directory bread(block 7773) failed
[16233.119852] FAT: Directory bread(block 7774) failed
[16233.119852] FAT: Directory bread(block 7775) failed
[16415.030029] eth0: Link is Down
[16417.448229] eth0: Link is Up 100 Mbps Full Duplex, Flow Control:
RX/TX
[16417.448229] eth0: 10/100 speed: disabling TSO


