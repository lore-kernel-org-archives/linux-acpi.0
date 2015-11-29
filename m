From: Sebastian Herbszt <herbszt@gmx.de>
Subject: 4.4-rc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
Date: Sun, 29 Nov 2015 15:52:13 +0100
Message-ID: <20151129155213.00004e71@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:63998 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbbK2Owf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Nov 2015 09:52:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>, Sebastian Herbszt <herbszt@gmx.de>

Linux kernel 4.4-rc2 (openSUSE:Kernel of the day) fails to boot on my
FUJITSU SIEMENS ESPRIMO E. Both kernel-default-4.4.rc2-1.1.g7eabae5.i586
and kernel-vanilla-4.4.rc2-1.1.g7eabae5.i686 generate the following
transcribed log:

[ 0.159147] SCSI subsystem initialized
[content scrolled of screen?]
[28.076000] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0
[content scrolled of screen]
[28.076000] 0003f6ee f623d760 3f6ee000 f000c000 f68e5eec c0249225 00000173
[28.076000] 00000002 f68e5edc 00000000 c09d2644 f60e5ed4 3f6ee000 00000173
[28.076000] Call Trace:
[28.076000]  [<c051742f>] ? ioremap_page_range+0xef/0x160
[28.076000]  [<c0249225>] __ioremap_caller+0x285/0x350
[28.076000]  [<c0b2c293>] ? print_filtered+0x5c/0x5c
[28.076000]  [<c024930b>] ioremap_nocache+0x1b/0x20
[28.076000]  [<c0b2c2eb>] ? dmi_init+0x58/0xec
[28.076000]  [<c0b2c2eb>] dmi_init+0x58/0xec
[28.076000]  [<c0b2c293>] ? print_filtered+0x5c/0x5c
[28.076000]  [<c020048a>] do_one_initcall+0xaa/0x200
[28.076000]  [<c0b2c293>] ? print_filtered+0x5c/0x5c
[28.076000]  [<c027187f>] ? parse_args+0x2bf/0x560
[28.076000]  [<c0aeec81>] kernel_init_freeable+0x137/0x1b9
[28.076000]  [<c07dd890>] kernel_init+0x10/0xe0
[28.076000]  [<c027df81>] ? schedule_tail+0x11/0x50
[28.076000]  [<c07e3051>] ret_from_kernel_thread+0x21/0x40
[28.076000]  [<c07dd880>] ? rest_init+0x70/0x70

kernel-debug-4.4.rc2-1.1.g7eabae5.i686 does not exhibit this issue.
kernel-vanilla-4.4.rc2-1.1.g7eabae5.i686 with acpi=off also boots fine.

Sebastian


[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.0-rc2-1.g7eabae5-vanilla (geeko@buildhost) (gcc version 5.2.1 20151008 [gcc-5-branch revision 228597] (SUSE Linux) ) #1 SMP Mon Nov 23 19:32:47 UTC 2015 (7eabae5)
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003f6dffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003f6e0000-0x000000003f6ecfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003f6ed000-0x000000003f6fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000003f700000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fecfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb80000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] SMBIOS 2.34 present.
[    0.000000] DMI: FUJITSU SIEMENS ESPRIMO E           /D2164-A1, BIOS 5.00 R1.10.2164.A1               05/08/2006
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x3f6e0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-E3FFF uncachable
[    0.000000]   E4000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 03F700000 mask FFFF00000 uncachable
[    0.000000]   2 base 03F800000 mask FFF800000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] found SMP MP-table at [mem 0x000f75a0-0x000f75af] mapped at [c00f75a0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x00ffffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x00c9c000, 0x00c9cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x37811000-0x37feffff]
[    0.000000] Allocated new RAMDISK: [mem 0x3701f000-0x377fdd20]
[    0.000000] Move RAMDISK from [mem 0x37811000-0x37fefd20] to [mem 0x3701f000-0x377fdd20]
[    0.000000] 126MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.000000]   HighMem  [mem 0x00000000377fe000-0x000000003f6dffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000003f6dffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003f6dffff]
[    0.000000] On node 0 totalpages: 259710
[    0.000000] free_area_init_node: node 0, pgdat c0ad4500, node_mem_map f6731024
[    0.000000]   DMA zone: 36 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 1962 pages used for memmap
[    0.000000]   Normal zone: 223230 pages, LIFO batch:31
[    0.000000]   HighMem zone: 32482 pages, LIFO batch:7
[    0.000000] Using APIC driver default
[    0.000000] Reserving Intel graphics stolen memory at 0x3f800000-0x3fffffff
[    0.000000] Intel MultiProcessor Specification v1.1
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] MPTABLE: OEM ID:         
[    0.000000] MPTABLE: Product ID:             
[    0.000000] MPTABLE: APIC at: 0xFEE00000
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] Processors: 1
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] e820: [mem 0x40000000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] PERCPU: Embedded 18 pages/cpu @f6719000 s44172 r0 d29556 u73728
[    0.000000] pcpu-alloc: s44172 r0 d29556 u73728 alloc=18*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257712
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-ST340014AS_4MQ0MSJR-part1 acpi=off
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000377fe:0003f6e0)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 1009796K/1038840K available (6035K kernel code, 621K rwdata, 2472K rodata, 768K init, 908K bss, 29044K reserved, 0K cma-reserved, 129928K highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffd35000 - 0xfffff000   (2856 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000000]       .init : 0xc0aee000 - 0xc0bae000   ( 768 kB)
[    0.000000]       .data : 0xc07e50e0 - 0xc0aec580   (3101 kB)
[    0.000000]       .text : 0xc0200000 - 0xc07e50e0   (6036 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:2304 nr_irqs:256 16
[    0.000000] CPU 0 irqstacks, hard=f602e000 soft=f6030000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2793.246 MHz processor
[    0.008016] Calibrating delay loop (skipped), value calculated using timer frequency.. 5586.49 BogoMIPS (lpj=11172984)
[    0.008159] pid_max: default: 32768 minimum: 301
[    0.008267] Security Framework initialized
[    0.008346] AppArmor: AppArmor initialized
[    0.008483] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.008556] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.008989] Initializing cgroup subsys io
[    0.009064] Initializing cgroup subsys memory
[    0.009147] Initializing cgroup subsys devices
[    0.012010] Initializing cgroup subsys freezer
[    0.012086] Initializing cgroup subsys net_cls
[    0.012158] Initializing cgroup subsys perf_event
[    0.012231] Initializing cgroup subsys net_prio
[    0.012303] Initializing cgroup subsys hugetlb
[    0.012374] Initializing cgroup subsys pids
[    0.012477] CPU: Physical Processor ID: 0
[    0.012548] CPU: Processor Core ID: 0
[    0.012623] mce: CPU supports 4 MCE banks
[    0.012705] CPU0: Thermal monitoring enabled (TM1)
[    0.012778] process: using mwait in idle threads
[    0.012857] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 64
[    0.012930] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 64, 1GB 0
[    0.026979] Freeing SMP alternatives memory: 24K (c0bae000 - c0bb4000)
[    0.028500] ftrace: allocating 24719 entries in 49 pages
[    0.040150] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.040293] ExtINT not setup in hardware but reported by MP table
[    0.040721] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.188015] smpboot: CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz (family: 0xf, model: 0x4, stepping: 0x9)
[    0.188233] Performance Events: Netburst events, Netburst P4/Xeon PMU driver.
[    0.188366] ... version:                0
[    0.188435] ... bit width:              40
[    0.188503] ... generic registers:      18
[    0.188573] ... value mask:             000000ffffffffff
[    0.188643] ... max period:             0000007fffffffff
[    0.188713] ... fixed-purpose events:   0
[    0.188781] ... event mask:             000000000003ffff
[    0.189762] x86: Booted up 1 node, 1 CPUs
[    0.189836] smpboot: Total of 1 processors activated (5586.49 BogoMIPS)
[    0.190548] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.190757] devtmpfs: initialized
[    0.191348] PM: Registering ACPI NVS region [mem 0x3f6ed000-0x3f6fffff] (77824 bytes)
[    0.191628] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.191853] pinctrl core: initialized pinctrl subsystem
[    0.191983] RTC time: 13:12:33, date: 11/29/15
[    0.192216] NET: Registered protocol family 16
[    0.192558] cpuidle: using governor ladder
[    0.192630] cpuidle: using governor menu
[    0.192934] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xd0000000-0xdfffffff] (base 0xd0000000)
[    0.193049] PCI: Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub with MMCONFIG support
[    0.193169] PCI: not using MMCONFIG
[    0.194623] PCI: PCI BIOS revision 2.10 entry at 0xfd89b, last bus=11
[    0.194695] PCI: Using configuration type 1 for base access
[    0.197746] ACPI: Interpreter disabled.
[    0.197926] vgaarb: loaded
[    0.198155] SCSI subsystem initialized
[    0.198385] PCI: Probing PCI hardware
[    0.198455] PCI: root bus 00: using default resources
[    0.198459] PCI: Probing PCI hardware (bus 00)
[    0.198531] PCI host bridge to bus 0000:00
[    0.198605] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.198677] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.198750] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.198879] pci 0000:00:00.0: [8086:2770] type 00 class 0x060000
[    0.199028] pci 0000:00:01.0: [8086:2771] type 01 class 0x060400
[    0.199094] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.199203] pci 0000:00:02.0: [8086:2772] type 00 class 0x030000
[    0.199229] pci 0000:00:02.0: reg 0x10: [mem 0xf0080000-0xf00fffff]
[    0.199239] pci 0000:00:02.0: reg 0x14: [io  0x2000-0x2007]
[    0.199250] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff pref]
[    0.199260] pci 0000:00:02.0: reg 0x1c: [mem 0xf0040000-0xf007ffff]
[    0.199364] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.199437] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.199606] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300
[    0.199642] pci 0000:00:1b.0: reg 0x10: [mem 0xf0000000-0xf0003fff 64bit]
[    0.199720] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.199835] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400
[    0.199916] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.200049] pci 0000:00:1c.1: [8086:27d2] type 01 class 0x060400
[    0.200136] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.200252] pci 0000:00:1c.2: [8086:27d4] type 01 class 0x060400
[    0.200332] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.200443] pci 0000:00:1c.3: [8086:27d6] type 01 class 0x060400
[    0.200524] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.200640] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300
[    0.200698] pci 0000:00:1d.0: reg 0x20: [io  0x2400-0x241f]
[    0.200816] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300
[    0.200874] pci 0000:00:1d.1: reg 0x20: [io  0x2800-0x281f]
[    0.200992] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300
[    0.201050] pci 0000:00:1d.2: reg 0x20: [io  0x2c00-0x2c1f]
[    0.201167] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300
[    0.201225] pci 0000:00:1d.3: reg 0x20: [io  0x3000-0x301f]
[    0.201356] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320
[    0.201388] pci 0000:00:1d.7: reg 0x10: [mem 0xf0004000-0xf00043ff]
[    0.201475] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.201591] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.201752] pci 0000:00:1f.0: [8086:27b8] type 00 class 0x060100
[    0.201862] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.201877] pci 0000:00:1f.0: quirk: [io  0xf000-0xf07f] claimed by ICH6 ACPI/GPIO/TCO
[    0.201996] pci 0000:00:1f.0: quirk: [io  0xf180-0xf1bf] claimed by ICH6 GPIO
[    0.202073] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0800 (mask 00ff)
[    0.202304] pci 0000:00:1f.2: [8086:27c0] type 00 class 0x010180
[    0.202332] pci 0000:00:1f.2: reg 0x10: [io  0x0000-0x0007]
[    0.202345] pci 0000:00:1f.2: reg 0x14: [io  0x0000-0x0003]
[    0.202357] pci 0000:00:1f.2: reg 0x18: [io  0x0000-0x0007]
[    0.202369] pci 0000:00:1f.2: reg 0x1c: [io  0x0000-0x0003]
[    0.202381] pci 0000:00:1f.2: reg 0x20: [io  0x3800-0x380f]
[    0.202405] pci 0000:00:1f.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.202480] pci 0000:00:1f.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.202552] pci 0000:00:1f.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.202625] pci 0000:00:1f.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.202717] pci 0000:00:1f.2: PME# supported from D3hot
[    0.202830] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500
[    0.202899] pci 0000:00:1f.3: reg 0x20: [io  0x3400-0x341f]
[    0.203110] pci 0000:01:00.0: [10df:fe00] type 00 class 0x0c0400
[    0.203152] pci 0000:01:00.0: reg 0x10: [mem 0xf0100000-0xf0100fff 64bit]
[    0.203172] pci 0000:01:00.0: reg 0x18: [mem 0xf0102000-0xf01020ff 64bit]
[    0.203186] pci 0000:01:00.0: reg 0x20: [io  0x4000-0x40ff]
[    0.203211] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.203354] pci 0000:01:00.1: [10df:fe00] type 00 class 0x0c0400
[    0.203395] pci 0000:01:00.1: reg 0x10: [mem 0xf0101000-0xf0101fff 64bit]
[    0.203415] pci 0000:01:00.1: reg 0x18: [mem 0xf0102400-0xf01024ff 64bit]
[    0.203430] pci 0000:01:00.1: reg 0x20: [io  0x4400-0x44ff]
[    0.203454] pci 0000:01:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    0.203587] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.203717] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.203790] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.203796] pci 0000:00:01.0:   bridge window [mem 0xf0100000-0xf01fffff]
[    0.203883] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.204078] pci 0000:05:00.0: [14e4:1677] type 00 class 0x020000
[    0.204131] pci 0000:05:00.0: reg 0x10: [mem 0xf0200000-0xf020ffff 64bit]
[    0.204248] pci 0000:05:00.0: PME# supported from D3hot D3cold
[    0.204361] pci 0000:05:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.204486] pci 0000:00:1c.1: PCI bridge to [bus 05]
[    0.204561] pci 0000:00:1c.1:   bridge window [mem 0xf0200000-0xf02fffff]
[    0.204650] pci 0000:00:1c.2: PCI bridge to [bus 07]
[    0.204812] pci 0000:00:1c.3: PCI bridge to [bus 09]
[    0.204982] pci 0000:0b:05.0: [1077:2312] type 00 class 0x0c0400
[    0.205027] pci 0000:0b:05.0: reg 0x10: [io  0x5000-0x50ff]
[    0.205042] pci 0000:0b:05.0: reg 0x14: [mem 0xf0300000-0xf0300fff]
[    0.205097] pci 0000:0b:05.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.205239] pci 0000:0b:05.1: [1077:2312] type 00 class 0x0c0400
[    0.205284] pci 0000:0b:05.1: reg 0x10: [io  0x5400-0x54ff]
[    0.205299] pci 0000:0b:05.1: reg 0x14: [mem 0xf0301000-0xf0301fff]
[    0.205354] pci 0000:0b:05.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.205525] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.205601] pci 0000:00:1e.0:   bridge window [io  0x5000-0x5fff]
[    0.205608] pci 0000:00:1e.0:   bridge window [mem 0xf0300000-0xf03fffff]
[    0.205618] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.205622] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff] (subtractive decode)
[    0.205663] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 0b
[    0.205880] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:27b8]
[    0.205959] PCI: pci_cache_line_size set to 64 bytes
[    0.206036] e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
[    0.206040] e820: reserve RAM buffer [mem 0x3f6e0000-0x3fffffff]
[    0.206319] NetLabel: Initializing
[    0.206389] NetLabel:  domain hash size = 128
[    0.206458] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.206548] NetLabel:  unlabeled traffic allowed by default
[    0.206755] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.207814] hpet clockevent registered
[    0.207820] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.207898] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.208069] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.210212] clocksource: Switched to clocksource hpet
[    0.225917] AppArmor: AppArmor Filesystem Enabled
[    0.226098] pnp: PnP ACPI: disabled
[    0.226173] PnPBIOS: Scanning system for PnP BIOS support...
[    0.226261] PnPBIOS: Found PnP BIOS installation structure at 0xc00f7630
[    0.226334] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9fbf, dseg 0x400
[    0.226736] pnp 00:00: [io  0x0080]
[    0.226743] pnp 00:00: [io  0x0800-0x082f]
[    0.226747] pnp 00:00: [mem 0xfff00000-0xffffffff]
[    0.226751] pnp 00:00: [mem 0xfee00000-0xfeefffff]
[    0.226755] pnp 00:00: [mem 0xfed13000-0xfed13fff]
[    0.226758] pnp 00:00: [mem 0xfed14000-0xfed17fff]
[    0.226762] pnp 00:00: [mem 0xfed18000-0xfed18fff]
[    0.226766] pnp 00:00: [mem 0xfed19000-0xfed19fff]
[    0.226769] pnp 00:00: [io  0xfe00]
[    0.226878] system 00:00: [io  0x0800-0x082f] has been reserved
[    0.226952] system 00:00: [io  0xfe00] has been reserved
[    0.227027] system 00:00: [mem 0xfff00000-0xffffffff] has been reserved
[    0.227101] system 00:00: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.227177] system 00:00: [mem 0xfed13000-0xfed13fff] has been reserved
[    0.227251] system 00:00: [mem 0xfed14000-0xfed17fff] has been reserved
[    0.227324] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.227397] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.227475] system 00:00: Plug and Play BIOS device, IDs PNP0c02 (active)
[    0.227489] pnp 00:01: [mem 0x00000000-0x0009ffff]
[    0.227493] pnp 00:01: [mem 0x000e4000-0x000fffff]
[    0.227497] pnp 00:01: [mem 0x00100000-0x3f6fffff]
[    0.227566] system 00:01: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.227642] system 00:01: [mem 0x000e4000-0x000fffff] could not be reserved
[    0.227716] system 00:01: [mem 0x00100000-0x3f6fffff] could not be reserved
[    0.227792] system 00:01: Plug and Play BIOS device, IDs PNP0c01 (active)
[    0.227805] pnp 00:02: [io  0x0000-0x000f]
[    0.227810] pnp 00:02: [io  0x0081-0x008f]
[    0.227813] pnp 00:02: [io  0x00c0-0x00df]
[    0.227817] pnp 00:02: [dma 4]
[    0.227863] pnp 00:02: Plug and Play BIOS device, IDs PNP0200 (active)
[    0.227877] pnp 00:03: [io  0x0020-0x0021]
[    0.227882] pnp 00:03: [io  0x00a0-0x00a1]
[    0.227887] pnp 00:03: [irq 2]
[    0.227935] pnp 00:03: Plug and Play BIOS device, IDs PNP0000 (active)
[    0.227950] pnp 00:04: [io  0x0040-0x0043]
[    0.227955] pnp 00:04: [irq 0]
[    0.228000] pnp 00:04: Plug and Play BIOS device, IDs PNP0100 (active)
[    0.228035] pnp 00:05: [io  0x0070-0x0071]
[    0.228040] pnp 00:05: [irq 8]
[    0.228086] pnp 00:05: Plug and Play BIOS device, IDs PNP0b00 (active)
[    0.228100] pnp 00:06: [io  0x0060]
[    0.228104] pnp 00:06: [io  0x0064]
[    0.228108] pnp 00:06: [irq 1]
[    0.228156] pnp 00:06: Plug and Play BIOS device, IDs PNP0303 (active)
[    0.228168] pnp 00:07: [io  0x00f0-0x00ff]
[    0.228174] pnp 00:07: [irq 13]
[    0.228219] pnp 00:07: Plug and Play BIOS device, IDs PNP0c04 (active)
[    0.228235] pnp 00:08: [io  0x0061]
[    0.228281] pnp 00:08: Plug and Play BIOS device, IDs PNP0800 (active)
[    0.228294] pnp 00:09: [mem 0x000e2800-0x000e3f5f]
[    0.228366] system 00:09: [mem 0x000e2800-0x000e3f5f] could not be reserved
[    0.228443] system 00:09: Plug and Play BIOS device, IDs PNP0c02 (active)
[    0.228456] pnp 00:0a: [io  0x0cf8-0x0cff]
[    0.228504] pnp 00:0a: Plug and Play BIOS device, IDs PNP0a03 (active)
[    0.228517] pnp 00:0b: [io  0x04d0-0x04d1]
[    0.228522] pnp 00:0b: [io  0xf000-0xf05f]
[    0.228526] pnp 00:0b: [io  0xf060-0xf07f]
[    0.228529] pnp 00:0b: [io  0xf180-0xf1bf]
[    0.228533] pnp 00:0b: [mem 0xfec10000-0xfec17fff]
[    0.228537] pnp 00:0b: [mem 0xfec18000-0xfec1ffff]
[    0.228541] pnp 00:0b: [mem 0xfec20000-0xfec27fff]
[    0.228545] pnp 00:0b: [mem 0xfec28000-0xfec2ffff]
[    0.228550] pnp 00:0b: [mem 0xfec30000-0xfec37fff]
[    0.228553] pnp 00:0b: [mem 0xfec38000-0xfec3ffff]
[    0.228557] pnp 00:0b: [mem 0xfed00000-0xfed033ff]
[    0.228561] pnp 00:0b: [mem 0xfed20000-0xfed8ffff]
[    0.228564] pnp 00:0b: [mem 0xfef00000-0xfeffffff]
[    0.228568] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    0.228591] pnp 00:0b: disabling [io  0xf000-0xf05f] because it overlaps 0000:00:1f.0 BAR 13 [io  0xf000-0xf07f]
[    0.228708] pnp 00:0b: disabling [io  0xf060-0xf07f] because it overlaps 0000:00:1f.0 BAR 13 [io  0xf000-0xf07f]
[    0.228897] system 00:0b: [io  0x04d0-0x04d1] has been reserved
[    0.228972] system 00:0b: [io  0xf180-0xf1bf] has been reserved
[    0.229046] system 00:0b: [mem 0xfec10000-0xfec17fff] has been reserved
[    0.229119] system 00:0b: [mem 0xfec18000-0xfec1ffff] has been reserved
[    0.229192] system 00:0b: [mem 0xfec20000-0xfec27fff] has been reserved
[    0.229266] system 00:0b: [mem 0xfec28000-0xfec2ffff] has been reserved
[    0.229339] system 00:0b: [mem 0xfec30000-0xfec37fff] has been reserved
[    0.229413] system 00:0b: [mem 0xfec38000-0xfec3ffff] has been reserved
[    0.229486] system 00:0b: [mem 0xfed00000-0xfed033ff] has been reserved
[    0.229559] system 00:0b: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.229633] system 00:0b: [mem 0xfef00000-0xfeffffff] has been reserved
[    0.229707] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.229782] system 00:0b: Plug and Play BIOS device, IDs PNP0c02 (active)
[    0.229797] pnp 00:0c: [mem 0xffb00000-0xffbfffff]
[    0.229843] pnp 00:0c: Plug and Play BIOS device, IDs INT0800 (active)
[    0.229928] pnp 00:0d: [mem 0x000cac00-0x000cafff]
[    0.230005] system 00:0d: [mem 0x000cac00-0x000cafff] has been reserved
[    0.230082] system 00:0d: Plug and Play BIOS device, IDs PNP0c02 (active)
[    0.230361] pnp 00:0f: [io  0x03f8-0x03ff]
[    0.230366] pnp 00:0f: [irq 4]
[    0.230434] pnp 00:0f: Plug and Play BIOS device, IDs PNP0501 (active)
[    0.230767] pnp 00:10: [io  0x02f8-0x02ff]
[    0.230772] pnp 00:10: [irq 3]
[    0.230835] pnp 00:10: Plug and Play BIOS device, IDs PNP0501 (active)
[    0.231140] pnp 00:11: [io  0x03f0-0x03f5]
[    0.231145] pnp 00:11: [io  0x03f7]
[    0.231149] pnp 00:11: [irq 6]
[    0.231153] pnp 00:11: [dma 2]
[    0.231217] pnp 00:11: Plug and Play BIOS device, IDs PNP0700 (active)
[    0.231567] pnp 00:14: [io  0x0378-0x037f]
[    0.231572] pnp 00:14: [io  0x0778-0x077f]
[    0.231576] pnp 00:14: [irq 7]
[    0.231580] pnp 00:14: [dma 3]
[    0.231671] pnp 00:14: Plug and Play BIOS device, IDs PNP0401 (active)
[    0.231681] PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
[    0.236332] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    0.236340] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.236346] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
[    0.236359] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to [bus 05] add_size 1000
[    0.236364] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000 add_align 100000
[    0.236377] pci 0000:00:1c.2: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[    0.236382] pci 0000:00:1c.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 100000
[    0.236387] pci 0000:00:1c.2: bridge window [mem 0x00100000-0x000fffff] to [bus 07] add_size 200000 add_align 100000
[    0.236400] pci 0000:00:1c.3: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
[    0.236405] pci 0000:00:1c.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 09] add_size 200000 add_align 100000
[    0.236410] pci 0000:00:1c.3: bridge window [mem 0x00100000-0x000fffff] to [bus 09] add_size 200000 add_align 100000
[    0.236433] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.236438] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.236443] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236448] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236452] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236457] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236461] pci 0000:00:1c.2: res[14]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.236466] pci 0000:00:1c.2: res[14]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.236470] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236475] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236480] pci 0000:00:1c.3: res[14]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.236485] pci 0000:00:1c.3: res[14]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.236490] pci 0000:00:1c.3: res[15]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236494] pci 0000:00:1c.3: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.236499] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236504] pci 0000:00:1c.0: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236508] pci 0000:00:1c.1: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236512] pci 0000:00:1c.1: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236517] pci 0000:00:1c.2: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236521] pci 0000:00:1c.2: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236525] pci 0000:00:1c.3: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236530] pci 0000:00:1c.3: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.236539] pci 0000:00:1c.0: BAR 14: assigned [mem 0x40000000-0x401fffff]
[    0.236618] pci 0000:00:1c.0: BAR 15: assigned [mem 0x40200000-0x403fffff 64bit pref]
[    0.236733] pci 0000:00:1c.1: BAR 15: assigned [mem 0x40400000-0x405fffff 64bit pref]
[    0.236848] pci 0000:00:1c.2: BAR 14: assigned [mem 0x40600000-0x407fffff]
[    0.236922] pci 0000:00:1c.2: BAR 15: assigned [mem 0x40800000-0x409fffff 64bit pref]
[    0.237038] pci 0000:00:1c.3: BAR 14: assigned [mem 0x40a00000-0x40bfffff]
[    0.237113] pci 0000:00:1c.3: BAR 15: assigned [mem 0x40c00000-0x40dfffff 64bit pref]
[    0.237231] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.237306] pci 0000:00:1c.1: BAR 13: assigned [io  0x6000-0x6fff]
[    0.237379] pci 0000:00:1c.2: BAR 13: assigned [io  0x7000-0x7fff]
[    0.237453] pci 0000:00:1c.3: BAR 13: assigned [io  0x8000-0x8fff]
[    0.237532] pci 0000:01:00.0: BAR 6: assigned [mem 0xf0140000-0xf017ffff pref]
[    0.237646] pci 0000:01:00.1: BAR 6: assigned [mem 0xf0180000-0xf01bffff pref]
[    0.237760] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.237833] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.237908] pci 0000:00:01.0:   bridge window [mem 0xf0100000-0xf01fffff]
[    0.237987] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    0.238059] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    0.238135] pci 0000:00:1c.0:   bridge window [mem 0x40000000-0x401fffff]
[    0.238210] pci 0000:00:1c.0:   bridge window [mem 0x40200000-0x403fffff 64bit pref]
[    0.238329] pci 0000:00:1c.1: PCI bridge to [bus 05]
[    0.238401] pci 0000:00:1c.1:   bridge window [io  0x6000-0x6fff]
[    0.238477] pci 0000:00:1c.1:   bridge window [mem 0xf0200000-0xf02fffff]
[    0.238552] pci 0000:00:1c.1:   bridge window [mem 0x40400000-0x405fffff 64bit pref]
[    0.238671] pci 0000:00:1c.2: PCI bridge to [bus 07]
[    0.238743] pci 0000:00:1c.2:   bridge window [io  0x7000-0x7fff]
[    0.238819] pci 0000:00:1c.2:   bridge window [mem 0x40600000-0x407fffff]
[    0.238894] pci 0000:00:1c.2:   bridge window [mem 0x40800000-0x409fffff 64bit pref]
[    0.239013] pci 0000:00:1c.3: PCI bridge to [bus 09]
[    0.239085] pci 0000:00:1c.3:   bridge window [io  0x8000-0x8fff]
[    0.239160] pci 0000:00:1c.3:   bridge window [mem 0x40a00000-0x40bfffff]
[    0.239236] pci 0000:00:1c.3:   bridge window [mem 0x40c00000-0x40dfffff 64bit pref]
[    0.239357] pci 0000:0b:05.0: BAR 6: assigned [mem 0xf0320000-0xf033ffff pref]
[    0.239472] pci 0000:0b:05.1: BAR 6: assigned [mem 0xf0340000-0xf035ffff pref]
[    0.239585] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    0.239657] pci 0000:00:1e.0:   bridge window [io  0x5000-0x5fff]
[    0.239733] pci 0000:00:1e.0:   bridge window [mem 0xf0300000-0xf03fffff]
[    0.239814] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.239818] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.239822] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.239826] pci_bus 0000:01: resource 1 [mem 0xf0100000-0xf01fffff]
[    0.239830] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    0.239834] pci_bus 0000:03: resource 1 [mem 0x40000000-0x401fffff]
[    0.239838] pci_bus 0000:03: resource 2 [mem 0x40200000-0x403fffff 64bit pref]
[    0.239842] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    0.239846] pci_bus 0000:05: resource 1 [mem 0xf0200000-0xf02fffff]
[    0.239850] pci_bus 0000:05: resource 2 [mem 0x40400000-0x405fffff 64bit pref]
[    0.239854] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[    0.239857] pci_bus 0000:07: resource 1 [mem 0x40600000-0x407fffff]
[    0.239861] pci_bus 0000:07: resource 2 [mem 0x40800000-0x409fffff 64bit pref]
[    0.239865] pci_bus 0000:09: resource 0 [io  0x8000-0x8fff]
[    0.239869] pci_bus 0000:09: resource 1 [mem 0x40a00000-0x40bfffff]
[    0.239873] pci_bus 0000:09: resource 2 [mem 0x40c00000-0x40dfffff 64bit pref]
[    0.239877] pci_bus 0000:0b: resource 0 [io  0x5000-0x5fff]
[    0.239881] pci_bus 0000:0b: resource 1 [mem 0xf0300000-0xf03fffff]
[    0.239885] pci_bus 0000:0b: resource 4 [io  0x0000-0xffff]
[    0.239888] pci_bus 0000:0b: resource 5 [mem 0x00000000-0xffffffff]
[    0.239943] NET: Registered protocol family 2
[    0.240289] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.240385] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.240492] TCP: Hash tables configured (established 8192 bind 8192)
[    0.240604] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.240683] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.240836] NET: Registered protocol family 1
[    0.240936] pci 0000:00:02.0: Video device with shadowed ROM
[    1.840020] pci 0000:00:1d.7: EHCI: BIOS handoff failed (BIOS bug?) 01010001
[    1.840136] PCI: CLS 32 bytes, default 64
[    1.840244] Unpacking initramfs...
[    2.091085] Freeing initrd memory: 8060K (f701f000 - f77fe000)
[    2.091362] Scanning for low memory corruption every 60 seconds
[    2.092189] futex hash table entries: 256 (order: 2, 16384 bytes)
[    2.092300] audit: initializing netlink subsys (disabled)
[    2.092413] audit: type=2000 audit(1448802755.088:1): initialized
[    2.092973] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    2.093087] zbud: loaded
[    2.093256] VFS: Disk quotas dquot_6.6.0
[    2.093349] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.093718] Key type big_key registered
[    2.094303] Key type asymmetric registered
[    2.094377] Asymmetric key parser 'x509' registered
[    2.094473] bounce: pool size: 64 pages
[    2.094563] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.094723] io scheduler noop registered
[    2.094795] io scheduler deadline registered
[    2.094877] io scheduler cfq registered (default)
[    2.095144] pcieport 0000:00:01.0: PCI->APIC IRQ transform: INT A -> IRQ 16
[    2.095346] pcieport 0000:00:1c.0: PCI->APIC IRQ transform: INT A -> IRQ 17
[    2.095426] pcieport 0000:00:1c.0: enabling device (0000 -> 0003)
[    2.095658] pcieport 0000:00:1c.1: PCI->APIC IRQ transform: INT B -> IRQ 16
[    2.095892] pcieport 0000:00:1c.2: PCI->APIC IRQ transform: INT C -> IRQ 18
[    2.095970] pcieport 0000:00:1c.2: enabling device (0000 -> 0003)
[    2.096234] pcieport 0000:00:1c.3: PCI->APIC IRQ transform: INT D -> IRQ 19
[    2.096314] pcieport 0000:00:1c.3: enabling device (0000 -> 0003)
[    2.096616] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    2.096692] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    2.096765] pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
[    2.096840] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    2.096884] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    2.096962] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    2.097006] pcieport 0000:00:1c.1: Signaling PME through PCIe PME interrupt
[    2.097080] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    2.097156] pcie_pme 0000:00:1c.1:pcie01: service driver pcie_pme loaded
[    2.097199] pcieport 0000:00:1c.2: Signaling PME through PCIe PME interrupt
[    2.097276] pcie_pme 0000:00:1c.2:pcie01: service driver pcie_pme loaded
[    2.097320] pcieport 0000:00:1c.3: Signaling PME through PCIe PME interrupt
[    2.097397] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme loaded
[    2.097417] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.097511] pciehp 0000:00:1c.0:pcie04: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.097673] pciehp 0000:00:1c.0:pcie04: service driver pciehp loaded
[    2.097696] pciehp 0000:00:1c.1:pcie04: Slot #2 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.097854] pciehp 0000:00:1c.1:pcie04: service driver pciehp loaded
[    2.097873] pciehp 0000:00:1c.2:pcie04: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.098028] pciehp 0000:00:1c.2:pcie04: service driver pciehp loaded
[    2.098047] pciehp 0000:00:1c.3:pcie04: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    2.098201] pciehp 0000:00:1c.3:pcie04: service driver pciehp loaded
[    2.098216] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.098452] isapnp: Scanning for PnP cards...
[    2.451802] isapnp: No Plug & Play device found
[    2.451987] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
[    2.472689] 00:0f: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.493355] 00:10: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    2.497010] Non-volatile memory driver v1.3
[    2.497146] Linux agpgart interface v0.103
[    2.497437] agpgart-intel 0000:00:00.0: Intel 945G Chipset
[    2.497533] agpgart-intel 0000:00:00.0: detected gtt size: 262144K total, 262144K mappable
[    2.497838] agpgart-intel 0000:00:00.0: detected 8192K stolen memory
[    2.498081] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[    2.498338] Failed to find cpu0 device node
[    2.498408] Unable to detect cache hierarchy from DT for CPU 0
[    2.498759] i8042: PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1
[    2.498833] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    2.499659] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.499970] mousedev: PS/2 mouse device common for all mice
[    2.500446] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    2.500548] rtc_cmos 00:05: alarms up to one day, 114 bytes nvram, hpet irqs
[    2.500678] ledtrig-cpu: registered to indicate activity on CPUs
[    2.500784] hidraw: raw HID events driver (C) Jiri Kosina
[    2.501008] NET: Registered protocol family 10
[    2.501656] Using IPI No-Shortcut mode
[    2.502041] registered taskstats version 1
[    2.502158] zswap: loaded using pool lzo/zbud
[    2.509707] Key type encrypted registered
[    2.509795] AppArmor: AppArmor sha1 policy hashing enabled
[    2.510311]   Magic number: 7:756:231
[    2.510469] rtc_cmos 00:05: setting system clock to 2015-11-29 13:12:36 UTC (1448802756)
[    2.510722] PM: Hibernation image not present or could not be loaded.
[    2.511244] Freeing unused kernel memory: 768K (c0aee000 - c0bae000)
[    2.511579] Write protecting the kernel text: 6040k
[    2.511753] Write protecting the kernel read-only data: 2476k
[    2.523661] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    2.560690] libata version 3.00 loaded.
[    2.569870] ata_piix 0000:00:1f.2: PCI->APIC IRQ transform: INT B -> IRQ 19
[    2.569955] ata_piix 0000:00:1f.2: version 2.13
[    2.569975] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[    2.724795] scsi host0: ata_piix
[    2.725048] scsi host1: ata_piix
[    2.725226] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x3800 irq 14
[    2.725302] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x3808 irq 15
[    2.888483] ata2.00: ATAPI: LITE-ON COMBO LTC-48161H, KIH4, max UDMA/33
[    2.888667] ata1.00: ATA-6: ST340014AS, 3.00, max UDMA/133
[    2.888741] ata1.00: 78165360 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.896195] ata2.00: configured for UDMA/33
[    2.904276] ata1.00: configured for UDMA/133
[    2.904564] scsi 0:0:0:0: Direct-Access     ATA      ST340014AS       3.00 PQ: 0 ANSI: 5
[    2.905237] sd 0:0:0:0: [sda] 78165360 512-byte logical blocks: (40.0 GB/37.2 GiB)
[    2.905457] sd 0:0:0:0: [sda] Write Protect is off
[    2.905531] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.905580] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.907257] scsi 1:0:0:0: CD-ROM            LITE-ON  COMBO LTC-48161H KIH4 PQ: 0 ANSI: 5
[    2.921670]  sda: sda1
[    2.922218] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.948310] udev[101]: starting version 166
[    2.997476] usbcore: registered new interface driver usbfs
[    2.997588] usbcore: registered new interface driver hub
[    2.997696] usbcore: registered new device driver usb
[    3.031562] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.032477] uhci_hcd: USB Universal Host Controller Interface driver
[    3.032607] uhci_hcd 0000:00:1d.0: PCI->APIC IRQ transform: INT A -> IRQ 23
[    3.032715] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    3.032797] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    3.032918] uhci_hcd 0000:00:1d.0: detected 2 ports
[    3.033019] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002400
[    3.084852] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    3.084934] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.085046] usb usb1: Product: UHCI Host Controller
[    3.085116] usb usb1: Manufacturer: Linux 4.4.0-rc2-1.g7eabae5-vanilla uhci_hcd
[    3.085228] usb usb1: SerialNumber: 0000:00:1d.0
[    3.088057] tsc: Refined TSC clocksource calibration: 2793.072 MHz
[    3.088140] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2842b05730a, max_idle_ns: 440795313549 ns
[    3.101880] hub 1-0:1.0: USB hub found
[    3.107561] hub 1-0:1.0: 2 ports detected
[    3.108145] uhci_hcd 0000:00:1d.1: PCI->APIC IRQ transform: INT B -> IRQ 22
[    3.108244] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    3.108324] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    3.108448] uhci_hcd 0000:00:1d.1: detected 2 ports
[    3.108551] uhci_hcd 0000:00:1d.1: irq 22, io base 0x00002800
[    3.110140] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.110222] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.110336] usb usb2: Product: UHCI Host Controller
[    3.110408] usb usb2: Manufacturer: Linux 4.4.0-rc2-1.g7eabae5-vanilla uhci_hcd
[    3.110522] usb usb2: SerialNumber: 0000:00:1d.1
[    3.119543] hub 2-0:1.0: USB hub found
[    3.120225] hub 2-0:1.0: 2 ports detected
[    3.120595] uhci_hcd 0000:00:1d.2: PCI->APIC IRQ transform: INT C -> IRQ 21
[    3.120694] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    3.120775] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    3.120897] uhci_hcd 0000:00:1d.2: detected 2 ports
[    3.120999] uhci_hcd 0000:00:1d.2: irq 21, io base 0x00002c00
[    3.128834] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.128918] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.129035] usb usb3: Product: UHCI Host Controller
[    3.129106] usb usb3: Manufacturer: Linux 4.4.0-rc2-1.g7eabae5-vanilla uhci_hcd
[    3.129221] usb usb3: SerialNumber: 0000:00:1d.2
[    3.135888] hub 3-0:1.0: USB hub found
[    3.137564] hub 3-0:1.0: 2 ports detected
[    3.140351] uhci_hcd 0000:00:1d.3: PCI->APIC IRQ transform: INT D -> IRQ 20
[    3.140455] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    3.140539] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    3.140662] uhci_hcd 0000:00:1d.3: detected 2 ports
[    3.140765] uhci_hcd 0000:00:1d.3: irq 20, io base 0x00003000
[    3.147667] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.147748] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.147863] usb usb4: Product: UHCI Host Controller
[    3.147936] usb usb4: Manufacturer: Linux 4.4.0-rc2-1.g7eabae5-vanilla uhci_hcd
[    3.148084] usb usb4: SerialNumber: 0000:00:1d.3
[    3.155024] hub 4-0:1.0: USB hub found
[    3.155690] hub 4-0:1.0: 2 ports detected
[    3.649154] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[    3.711214] EXT4-fs (sda1): re-mounted. Opts: acl,user_xattr
[    4.088095] clocksource: Switched to clocksource tsc
[    5.061145] random: nonblocking pool is initialized
[    5.880266] udev[319]: starting version 166
[    6.372515] input: PC Speaker as /devices/platform/pcspkr/input/input1
[    6.505518] sr 1:0:0:0: [sr0] scsi3-mmc drive: 0x/48x writer cd/rw xa/form2 cdda tray
[    6.505644] cdrom: Uniform CD-ROM driver Revision: 3.20
[    6.506418] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    6.534018] intel_rng: FWH not detected
[    6.631108] pps_core: LinuxPPS API ver. 1 registered
[    6.631186] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    6.638490] PTP clock support registered
[    6.688675] i801_smbus 0000:00:1f.3: PCI->APIC IRQ transform: INT B -> IRQ 19
[    6.688810] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    6.857325] ehci-pci: EHCI PCI platform driver
[    6.857457] ehci-pci 0000:00:1d.7: PCI->APIC IRQ transform: INT A -> IRQ 23
[    6.891624] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.891853] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    6.952591] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    6.952682] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    6.956707] ehci-pci 0000:00:1d.7: cache line size of 32 is not supported
[    6.956723] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf0004000
[    6.968023] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    6.968214] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    6.968289] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.968403] usb usb5: Product: EHCI Host Controller
[    6.968474] usb usb5: Manufacturer: Linux 4.4.0-rc2-1.g7eabae5-vanilla ehci_hcd
[    6.968588] usb usb5: SerialNumber: 0000:00:1d.7
[    6.969079] hub 5-0:1.0: USB hub found
[    6.969211] hub 5-0:1.0: 8 ports detected
[    6.992291] hub 1-0:1.0: USB hub found
[    6.992386] hub 1-0:1.0: 2 ports detected
[    7.016166] hub 2-0:1.0: USB hub found
[    7.016812] hub 2-0:1.0: 2 ports detected
[    7.040173] hub 3-0:1.0: USB hub found
[    7.040798] hub 3-0:1.0: 2 ports detected
[    7.064159] hub 4-0:1.0: USB hub found
[    7.064776] hub 4-0:1.0: 2 ports detected
[    7.280672] snd_hda_intel 0000:00:1b.0: PCI->APIC IRQ transform: INT A -> IRQ 18
[    7.367865] tg3 0000:05:00.0: PCI->APIC IRQ transform: INT A -> IRQ 17
[    7.368930] tg3.c:v3.137 (May 11, 2014)
[    7.382799] tg3 0000:05:00.0 eth0: Tigon3 [partno(BCM95751) rev 4001] (PCI Express) MAC address 00:30:05:c5:7f:38
[    7.382928] tg3 0000:05:00.0 eth0: attached PHY is 5750 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    7.383048] tg3 0000:05:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    7.383164] tg3 0000:05:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    7.405853] snd_hda_codec_realtek hdaudioC0D2: autoconfig for ALC260: line_outs=1 (0xf/0x0/0x0/0x0/0x0) type:line
[    7.405981] snd_hda_codec_realtek hdaudioC0D2:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.406098] snd_hda_codec_realtek hdaudioC0D2:    hp_outs=2 (0x11/0x15/0x0/0x0/0x0)
[    7.406212] snd_hda_codec_realtek hdaudioC0D2:    mono: mono_out=0x0
[    7.406286] snd_hda_codec_realtek hdaudioC0D2:    inputs:
[    7.406359] snd_hda_codec_realtek hdaudioC0D2:      Mic=0x13
[    7.406432] snd_hda_codec_realtek hdaudioC0D2:      Line=0x14
[    7.406505] snd_hda_codec_realtek hdaudioC0D2:      CD=0x16
[    7.416274] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input2
[    7.420313] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input3
[    7.421866] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input4
[    7.422801] input: HDA Intel Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[    7.423715] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[    7.598068] leds_ss4200: no LED devices found
[    7.974833] iTCO_vendor_support: vendor-support=0
[    8.010686] gpio_ich: GPIO from 462 to 511 on gpio_ich
[    8.204364] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    8.204501] iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0xf060)
[    8.205261] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    9.386161] device-mapper: uevent: version 1.0.3
[    9.386773] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
[   11.197738] audit: type=1400 audit(1448802765.181:2): apparmor="STATUS" operation="profile_load" name="/bin/ping" pid=635 comm="apparmor_parser"
[   11.296291] audit: type=1400 audit(1448802765.281:3): apparmor="STATUS" operation="profile_load" name="/sbin/klogd" pid=658 comm="apparmor_parser"
[   11.757351] audit: type=1400 audit(1448802765.741:4): apparmor="STATUS" operation="profile_load" name="/sbin/syslog-ng" pid=662 comm="apparmor_parser"
[   11.963374] audit: type=1400 audit(1448802765.945:5): apparmor="STATUS" operation="profile_load" name="/sbin/syslogd" pid=676 comm="apparmor_parser"
[   12.768187] audit: type=1400 audit(1448802766.753:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/apache2/mpm-prefork/apache2" pid=701 comm="apparmor_parser"
[   12.768845] audit: type=1400 audit(1448802766.753:7): apparmor="STATUS" operation="profile_load" name="DEFAULT_URI" pid=701 comm="apparmor_parser"
[   12.769293] audit: type=1400 audit(1448802766.753:8): apparmor="STATUS" operation="profile_load" name="HANDLING_UNTRUSTED_INPUT" pid=701 comm="apparmor_parser"
[   12.769879] audit: type=1400 audit(1448802766.753:9): apparmor="STATUS" operation="profile_load" name="phpsysinfo" pid=701 comm="apparmor_parser"
[   12.977687] audit: type=1400 audit(1448802766.961:10): apparmor="STATUS" operation="profile_load" name="/usr/lib/dovecot/deliver" pid=727 comm="apparmor_parser"
[   13.283436] audit: type=1400 audit(1448802767.265:11): apparmor="STATUS" operation="profile_load" name="/usr/lib/dovecot/dovecot-auth" pid=741 comm="apparmor_parser"
[   19.412759] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   21.103778] tg3 0000:05:00.0 eth0: Link is up at 100 Mbps, full duplex
[   21.103787] tg3 0000:05:00.0 eth0: Flow control is on for TX and on for RX
[   21.103811] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   23.896573] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   24.685191] RPC: Registered named UNIX socket transport module.
[   24.685199] RPC: Registered udp transport module.
[   24.685203] RPC: Registered tcp transport module.
[   24.685207] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   24.828469] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   25.455166] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   25.465598] NFSD: starting 90-second grace period (net c0aca880)
