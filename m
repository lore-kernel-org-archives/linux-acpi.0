From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
Subject: ACPI errors on Dell Latitude E5430
Date: Fri, 21 Sep 2012 14:10:50 +0200
Message-ID: <505C594A.60903@hundeboll.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090806060901040806090402"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.hundeboll.net ([95.211.44.99]:32771 "EHLO
	mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab2IUMcm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2012 08:32:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hundeboll.net (Postfix) with ESMTP id 2B3CF1F2107
	for <linux-acpi@vger.kernel.org>; Fri, 21 Sep 2012 14:13:00 +0200 (CEST)
Received: from mail.hundeboll.net ([127.0.0.1])
	by localhost (mail.hundeboll.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MSCrK8PUEgmS for <linux-acpi@vger.kernel.org>;
	Fri, 21 Sep 2012 14:11:02 +0200 (CEST)
Received: from [192.168.87.101] (unknown [178.155.132.201])
	(Authenticated sender: martin@hundeboll.net)
	by mail.hundeboll.net (Postfix) with ESMTPSA id A434A1F2105
	for <linux-acpi@vger.kernel.org>; Fri, 21 Sep 2012 14:10:52 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090806060901040806090402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

ACPI encouters a lot of errors on my shiny new Dell E5430 with BIOS 
version A03 and has the following noticable problems:
   - Unable to detect battery and AC adapter.
   - Doesn't spin down fans when CPU temperature drops.

I tried several options on the kernel commandline, although I am not 
100% familiar with the effects of all of them:
   - acpi_osi=Linux
   - acpi_enforce_resources={off,lax}
   - acpi.power_nocheck=1

i8k gives access to fan control, but this is overwritten by BIOS or similar.

Attached is dmesg log. Please let me know if there is anything I can do 
to help debugging/testing.

-- 
Thanks,
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net


--------------090806060901040806090402
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.4-1-ARCH (tobias@T-POWA-LX) (gcc version 4.7.1 20120721 (prerelease) (GCC) ) #1 SMP PREEMPT Sat Sep 15 08:12:04 CEST 2012
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=ef14a89c-443d-4d51-99b8-bff7a90f1015 ro quiet acpi_enforce_resources=off acpi_osi=Linux
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000907ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000090800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x0000000040003fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040004000-0x0000000040004fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040005000-0x00000000d9a3dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d9a3e000-0x00000000da066fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000da067000-0x00000000da2a9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000da2aa000-0x00000000da2b6fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000da2b7000-0x00000000da2e6fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000da2e7000-0x00000000da2ebfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000da2ec000-0x00000000da32efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000da32f000-0x00000000daffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000db800000-0x00000000df9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021e5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] DMI: Dell Inc. Latitude E5430 vPro/04V77Y, BIOS A03 06/03/2012
[    0.000000] e820: update [mem 0x00000000-0x0000ffff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x21e600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DBFFF write-protect
[    0.000000]   DC000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask FE0000000 write-back
[    0.000000]   2 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   3 base 0DC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0DB800000 mask FFF800000 uncachable
[    0.000000]   5 base 21F000000 mask FFF000000 uncachable
[    0.000000]   6 base 21E800000 mask FFF800000 uncachable
[    0.000000]   7 base 21E600000 mask FFFE00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: update [mem 0xdb800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xdb000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fce70-0x000fce7f] mapped at [ffff8800000fce70]
[    0.000000] initial memory mapped: [mem 0x00000000-0x1fffffff]
[    0.000000] Base memory trampoline at [ffff88000008a000] 8a000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0xdaffffff]
[    0.000000]  [mem 0x00000000-0xdaffffff] page 2M
[    0.000000] kernel direct mapping tables up to 0xdaffffff @ [mem 0x1f923000-0x1fffffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x21e5fffff]
[    0.000000]  [mem 0x100000000-0x21e5fffff] page 2M
[    0.000000] kernel direct mapping tables up to 0x21e5fffff @ [mem 0xdaff6000-0xdaffffff]
[    0.000000] RAMDISK: [mem 0x37962000-0x37ca8fff]
[    0.000000] ACPI: RSDP 00000000000f0450 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000da2aa078 00074 (v01 DELL    CBX3    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000da2b4800 000F4 (v04 DELL    CBX3    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 00000000da2aa180 0A680 (v02 DELL    CBX3    00000117 INTL 20091112)
[    0.000000] ACPI: FACS 00000000da2e5f80 00040
[    0.000000] ACPI: APIC 00000000da2b48f8 00072 (v03 DELL    CBX3    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000da2b4970 0003C (v01 DELL    CBX3    01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000da2b49b0 00038 (v01 DELL    CBX3    01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 00000000da2b49e8 00415 (v01 SataRe SataTabl 00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000da2b4e00 009B9 (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000da2b57c0 00A92 (v01  PmRef    CpuPm 00003000 INTL 20051117)
[    0.000000] ACPI: DMAR 00000000da2b6258 000B8 (v01 INTEL      SNB  00000001 INTL 00000001)
[    0.000000] ACPI: ASF! 00000000da2b6310 000A5 (v32 INTEL       HCG 00000001 TFSM 000F4240)
[    0.000000] ACPI: SLIC 00000000da2b63b8 00176 (v03 DELL    CBX3    01072009 MSFT 00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021e5fffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x21e5fffff]
[    0.000000]   NODE_DATA [mem 0x21e5fc000-0x21e5fffff]
[    0.000000]  [ffffea0000000000-ffffea00087fffff] PMD -> [ffff880215c00000-ffff88021dbfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x21e5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0008ffff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
[    0.000000]   node   0: [mem 0x20200000-0x40003fff]
[    0.000000]   node   0: [mem 0x40005000-0xd9a3dfff]
[    0.000000]   node   0: [mem 0xda32f000-0xdaffffff]
[    0.000000]   node   0: [mem 0x100000000-0x21e5fffff]
[    0.000000] On node 0 totalpages: 2067086
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 6 pages reserved
[    0.000000]   DMA zone: 3898 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 16320 pages used for memmap
[    0.000000]   DMA32 zone: 873806 pages, LIFO batch:31
[    0.000000]   Normal zone: 18328 pages used for memmap
[    0.000000]   Normal zone: 1154664 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 0000000000090000 - 0000000000091000
[    0.000000] PM: Registered nosave memory: 0000000000091000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000020200000
[    0.000000] PM: Registered nosave memory: 0000000040004000 - 0000000040005000
[    0.000000] PM: Registered nosave memory: 00000000d9a3e000 - 00000000da067000
[    0.000000] PM: Registered nosave memory: 00000000da067000 - 00000000da2aa000
[    0.000000] PM: Registered nosave memory: 00000000da2aa000 - 00000000da2b7000
[    0.000000] PM: Registered nosave memory: 00000000da2b7000 - 00000000da2e7000
[    0.000000] PM: Registered nosave memory: 00000000da2e7000 - 00000000da2ec000
[    0.000000] PM: Registered nosave memory: 00000000da2ec000 - 00000000da32f000
[    0.000000] PM: Registered nosave memory: 00000000db000000 - 00000000db800000
[    0.000000] PM: Registered nosave memory: 00000000db800000 - 00000000dfa00000
[    0.000000] PM: Registered nosave memory: 00000000dfa00000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed04000
[    0.000000] PM: Registered nosave memory: 00000000fed04000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 0000000100000000
[    0.000000] e820: [mem 0xdfa00000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88021e200000 s83392 r8192 d23104 u524288
[    0.000000] pcpu-alloc: s83392 r8192 d23104 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2032368
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=ef14a89c-443d-4d51-99b8-bff7a90f1015 ro quiet acpi_enforce_resources=off acpi_osi=Linux
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8056168k/8886272k available (4645k kernel code, 617928k absent, 212176k reserved, 4207k data, 760k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000] NR_IRQS:4352 nr_irqs:712 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.003333] Detected 2591.463 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 5185.88 BogoMIPS (lpj=8638210)
[    0.000004] pid_max: default: 32768 minimum: 301
[    0.000022] Security Framework initialized
[    0.000025] AppArmor: AppArmor disabled by boot time parameter
[    0.000445] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.002304] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003132] Mount-cache hash table entries: 256
[    0.003272] Initializing cgroup subsys cpuacct
[    0.003273] Initializing cgroup subsys memory
[    0.003279] Initializing cgroup subsys devices
[    0.003280] Initializing cgroup subsys freezer
[    0.003281] Initializing cgroup subsys net_cls
[    0.003282] Initializing cgroup subsys blkio
[    0.003303] CPU: Physical Processor ID: 0
[    0.003304] CPU: Processor Core ID: 0
[    0.003308] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.003308] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.003651] mce: CPU supports 7 MCE banks
[    0.003659] CPU0: Thermal monitoring handled by SMI
[    0.003664] using mwait in idle threads.
[    0.004566] ACPI: Core revision 20120320
[    0.012850] ftrace: allocating 17970 entries in 71 pages
[    0.020264] DMAR: Host address width 36
[    0.020266] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.020273] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
[    0.020274] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.020279] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.020280] DMAR: RMRR base: 0x000000d9fe7000 end: 0x000000da005fff
[    0.020282] DMAR: RMRR base: 0x000000db800000 end: 0x000000df9fffff
[    0.020364] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.020364] HPET id 0 under DRHD base 0xfed91000
[    0.020496] Enabled IRQ remapping in x2apic mode
[    0.020497] Enabling x2apic
[    0.020497] Enabled x2apic
[    0.020506] Switched APIC routing to cluster x2apic.
[    0.020960] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.053952] CPU0: Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz stepping 09
[    0.160296] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, Intel PMU driver.
[    0.160301] ... version:                3
[    0.160302] ... bit width:              48
[    0.160302] ... generic registers:      4
[    0.160303] ... value mask:             0000ffffffffffff
[    0.160304] ... max period:             000000007fffffff
[    0.160305] ... fixed-purpose events:   3
[    0.160306] ... event mask:             000000070000000f
[    0.180370] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.205016] CPU1: Thermal monitoring handled by SMI
[    0.231672] CPU2: Thermal monitoring handled by SMI
[    0.193633] Booting Node   0, Processors  #1 #2 #3 Ok.
[    0.258327] CPU3: Thermal monitoring handled by SMI
[    0.260410] Brought up 4 CPUs
[    0.260413] Total of 4 processors activated (20740.52 BogoMIPS).
[    0.263407] devtmpfs: initialized
[    0.264466] PM: Registering ACPI NVS region [mem 0xda067000-0xda2a9fff] (2371584 bytes)
[    0.264493] PM: Registering ACPI NVS region [mem 0xda2b7000-0xda2e6fff] (196608 bytes)
[    0.264496] PM: Registering ACPI NVS region [mem 0xda2ec000-0xda32efff] (274432 bytes)
[    0.265170] NET: Registered protocol family 16
[    0.265274] ACPI: bus type pci registered
[    0.265322] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.265323] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.272149] PCI: Using configuration type 1 for base access
[    0.272156] dmi type 0xB1 record - unknown flag
[    0.272586] bio: create slab <bio-0> at 0
[    0.272623] ACPI: Added _OSI(Module Device)
[    0.272625] ACPI: Added _OSI(Processor Device)
[    0.272626] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.272627] ACPI: Added _OSI(Processor Aggregator Device)
[    0.272628] ACPI: Added _OSI(Linux)
[    0.273878] ACPI: EC: Look up EC in DSDT
[    0.275101] ACPI: Executed 1 blocks of module-level executable AML code
[    0.280345] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query honored via cmdline
[    0.300711] ACPI: SSDT 00000000da00e598 00523 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    0.301025] ACPI: Dynamic OEM Table Load:
[    0.301027] ACPI: SSDT           (null) 00523 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    0.301230] ACPI: SSDT 00000000da00fa98 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    0.301567] ACPI: Dynamic OEM Table Load:
[    0.301569] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    0.301662] ACPI: SSDT 00000000da015c18 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    0.301970] ACPI: Dynamic OEM Table Load:
[    0.301972] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    0.304456] ACPI: Interpreter enabled
[    0.304458] ACPI: (supports S0 S3 S4 S5)
[    0.304479] ACPI: Using IOAPIC for interrupt routing
[    0.316470] ACPI: EC: GPE = 0x10, I/O: command/status = 0x934, data = 0x930
[    0.316632] ACPI: No dock devices found.
[    0.316635] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.316873] \_SB_.PCI0:_OSC invalid UUID
[    0.316875] _OSC request data:1 8 1f 
[    0.316878] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.317248] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.317250] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.317252] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.317253] pci_root PNP0A08:00: host bridge window [mem 0x000dc000-0x000dffff]
[    0.317255] pci_root PNP0A08:00: host bridge window [mem 0x000e0000-0x000e3fff]
[    0.317256] pci_root PNP0A08:00: host bridge window [mem 0x000e4000-0x000e7fff]
[    0.317257] pci_root PNP0A08:00: host bridge window [mem 0xdfa00000-0xfeafffff]
[    0.317283] PCI host bridge to bus 0000:00
[    0.317285] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.317286] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.317288] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.317289] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.317290] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.317292] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
[    0.317293] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff]
[    0.317300] pci 0000:00:00.0: [8086:0154] type 00 class 0x060000
[    0.317338] pci 0000:00:02.0: [8086:0166] type 00 class 0x030000
[    0.317347] pci 0000:00:02.0: reg 10: [mem 0xf6400000-0xf67fffff 64bit]
[    0.317352] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.317356] pci 0000:00:02.0: reg 20: [io  0xf000-0xf03f]
[    0.317406] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
[    0.317428] pci 0000:00:14.0: reg 10: [mem 0xf7e20000-0xf7e2ffff 64bit]
[    0.317497] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.317522] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
[    0.317544] pci 0000:00:16.0: reg 10: [mem 0xf7e3c000-0xf7e3c00f 64bit]
[    0.317619] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.317642] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
[    0.317660] pci 0000:00:16.3: reg 10: [io  0xf0e0-0xf0e7]
[    0.317669] pci 0000:00:16.3: reg 14: [mem 0xf7e3a000-0xf7e3afff]
[    0.317767] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
[    0.317784] pci 0000:00:19.0: reg 10: [mem 0xf7e00000-0xf7e1ffff]
[    0.317793] pci 0000:00:19.0: reg 14: [mem 0xf7e39000-0xf7e39fff]
[    0.317801] pci 0000:00:19.0: reg 18: [io  0xf080-0xf09f]
[    0.317863] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.317888] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
[    0.317908] pci 0000:00:1a.0: reg 10: [mem 0xf7e38000-0xf7e383ff]
[    0.317997] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.318022] pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
[    0.318037] pci 0000:00:1b.0: reg 10: [mem 0xf7e30000-0xf7e33fff 64bit]
[    0.318103] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.318130] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
[    0.318261] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.318299] pci 0000:00:1c.1: [8086:1e12] type 01 class 0x060400
[    0.318428] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.318465] pci 0000:00:1c.2: [8086:1e14] type 01 class 0x060400
[    0.318595] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.318633] pci 0000:00:1c.3: [8086:1e16] type 01 class 0x060400
[    0.318762] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.318800] pci 0000:00:1c.5: [8086:1e1a] type 01 class 0x060400
[    0.318930] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.318970] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
[    0.318991] pci 0000:00:1d.0: reg 10: [mem 0xf7e37000-0xf7e373ff]
[    0.319080] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.319105] pci 0000:00:1f.0: [8086:1e55] type 00 class 0x060100
[    0.319227] pci 0000:00:1f.2: [8086:282a] type 00 class 0x010400
[    0.319245] pci 0000:00:1f.2: reg 10: [io  0xf0d0-0xf0d7]
[    0.319253] pci 0000:00:1f.2: reg 14: [io  0xf0c0-0xf0c3]
[    0.319260] pci 0000:00:1f.2: reg 18: [io  0xf0b0-0xf0b7]
[    0.319268] pci 0000:00:1f.2: reg 1c: [io  0xf0a0-0xf0a3]
[    0.319276] pci 0000:00:1f.2: reg 20: [io  0xf060-0xf07f]
[    0.319284] pci 0000:00:1f.2: reg 24: [mem 0xf7e36000-0xf7e367ff]
[    0.319328] pci 0000:00:1f.2: PME# supported from D3hot
[    0.319347] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
[    0.319361] pci 0000:00:1f.3: reg 10: [mem 0xf7e35000-0xf7e350ff 64bit]
[    0.319382] pci 0000:00:1f.3: reg 20: [io  0xf040-0xf05f]
[    0.319478] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.319724] pci 0000:02:00.0: [8086:422b] type 00 class 0x028000
[    0.319874] pci 0000:02:00.0: reg 10: [mem 0xf7d00000-0xf7d01fff 64bit]
[    0.320518] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.327143] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.327152] pci 0000:00:1c.1:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.327229] pci 0000:00:1c.2: PCI bridge to [bus 03-06]
[    0.327234] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    0.327238] pci 0000:00:1c.2:   bridge window [mem 0xf7200000-0xf7bfffff]
[    0.327246] pci 0000:00:1c.2:   bridge window [mem 0xf0a00000-0xf13fffff 64bit pref]
[    0.327317] pci 0000:00:1c.3: PCI bridge to [bus 07-0a]
[    0.327321] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.327326] pci 0000:00:1c.3:   bridge window [mem 0xf6800000-0xf71fffff]
[    0.327334] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf09fffff 64bit pref]
[    0.327548] pci 0000:0b:00.0: [1217:8221] type 00 class 0x080501
[    0.327592] pci 0000:0b:00.0: reg 10: [mem 0xf7c00000-0xf7c001ff]
[    0.327915] pci 0000:0b:00.0: supports D1 D2
[    0.327917] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.333816] pci 0000:00:1c.5: PCI bridge to [bus 0b-0b]
[    0.333823] pci 0000:00:1c.5:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.333862] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.333953] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.333977] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.334001] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.334033] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.334053] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.334128] \_SB_.PCI0:_OSC invalid UUID
[    0.334129] _OSC request data:1 1f 1f 
[    0.334132]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.334164] \_SB_.PCI0:_OSC invalid UUID
[    0.334165] _OSC request data:1 0 1d 
[    0.334168]  pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control mask: 0x1d
[    0.334168] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.338176] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.338218] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 10 11 12 14 15)
[    0.338252] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.338290] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.338326] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.338365] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.338402] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.338441] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.338507] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.338512] vgaarb: loaded
[    0.338512] vgaarb: bridge control possible 0000:00:02.0
[    0.338540] PCI: Using ACPI for IRQ routing
[    0.340178] PCI: pci_cache_line_size set to 64 bytes
[    0.340414] e820: reserve RAM buffer [mem 0x00090800-0x0009ffff]
[    0.340416] e820: reserve RAM buffer [mem 0x40004000-0x43ffffff]
[    0.340417] e820: reserve RAM buffer [mem 0xd9a3e000-0xdbffffff]
[    0.340419] e820: reserve RAM buffer [mem 0xdb000000-0xdbffffff]
[    0.340420] e820: reserve RAM buffer [mem 0x21e600000-0x21fffffff]
[    0.340488] NetLabel: Initializing
[    0.340489] NetLabel:  domain hash size = 128
[    0.340490] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.340498] NetLabel:  unlabeled traffic allowed by default
[    0.340518] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.340523] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.342535] Switching to clocksource hpet
[    0.346390] pnp: PnP ACPI init
[    0.346402] ACPI: bus type pnp registered
[    0.346626] pnp 00:00: [bus 00-3e]
[    0.346628] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.346630] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.346631] pnp 00:00: [io  0x0d00-0xffff window]
[    0.346632] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.346634] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.346635] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.346636] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.346638] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.346639] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.346640] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.346641] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.346643] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.346644] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.346645] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.346646] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.346648] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.346649] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.346650] pnp 00:00: [mem 0xdfa00000-0xfeafffff window]
[    0.346651] pnp 00:00: [mem 0x00010000-0x0001ffff window]
[    0.346710] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.346727] pnp 00:01: [mem 0xfed40000-0xfed44fff]
[    0.346755] system 00:01: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.346758] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.346766] pnp 00:02: [io  0x0000-0x001f]
[    0.346767] pnp 00:02: [io  0x0081-0x0091]
[    0.346769] pnp 00:02: [io  0x0093-0x009f]
[    0.346770] pnp 00:02: [io  0x00c0-0x00df]
[    0.346771] pnp 00:02: [dma 4]
[    0.346786] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.346791] pnp 00:03: [mem 0xff000000-0xffffffff]
[    0.346804] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
[    0.346874] pnp 00:04: [mem 0xfed00000-0xfed003ff]
[    0.346890] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.346898] pnp 00:05: [io  0x002e-0x002f]
[    0.346900] pnp 00:05: [io  0x004e-0x004f]
[    0.346901] pnp 00:05: [io  0x0061]
[    0.346902] pnp 00:05: [io  0x0063]
[    0.346903] pnp 00:05: [io  0x0065]
[    0.346904] pnp 00:05: [io  0x0067]
[    0.346905] pnp 00:05: [io  0x0070]
[    0.346906] pnp 00:05: [io  0x0080]
[    0.346907] pnp 00:05: [io  0x0092]
[    0.346908] pnp 00:05: [io  0x00b2-0x00b3]
[    0.346910] pnp 00:05: [io  0x0680-0x069f]
[    0.346911] pnp 00:05: [io  0x0200-0x020f]
[    0.346912] pnp 00:05: [io  0x0900-0x0903]
[    0.346913] pnp 00:05: [io  0xffff]
[    0.346915] pnp 00:05: [io  0x0400-0x0453]
[    0.346916] pnp 00:05: [io  0x0458-0x047f]
[    0.346917] pnp 00:05: [io  0x0500-0x057f]
[    0.346919] pnp 00:05: [io  0x164e-0x164f]
[    0.346945] system 00:05: [io  0x0680-0x069f] has been reserved
[    0.346947] system 00:05: [io  0x0200-0x020f] has been reserved
[    0.346948] system 00:05: [io  0x0900-0x0903] has been reserved
[    0.346950] system 00:05: [io  0xffff] has been reserved
[    0.346952] system 00:05: [io  0x0400-0x0453] has been reserved
[    0.346953] system 00:05: [io  0x0458-0x047f] has been reserved
[    0.346954] system 00:05: [io  0x0500-0x057f] has been reserved
[    0.346956] system 00:05: [io  0x164e-0x164f] has been reserved
[    0.346958] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.346963] pnp 00:06: [io  0x0070-0x0077]
[    0.346977] pnp 00:06: [irq 8]
[    0.346993] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.347011] pnp 00:07: [io  0x0454-0x0457]
[    0.347034] system 00:07: [io  0x0454-0x0457] has been reserved
[    0.347036] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.347052] pnp 00:08: [io  0x0010-0x001f]
[    0.347053] pnp 00:08: [io  0x0022-0x003f]
[    0.347054] pnp 00:08: [io  0x0044-0x005f]
[    0.347055] pnp 00:08: [io  0x0072-0x007f]
[    0.347057] pnp 00:08: [io  0x0080]
[    0.347058] pnp 00:08: [io  0x0084-0x0086]
[    0.347059] pnp 00:08: [io  0x0088]
[    0.347060] pnp 00:08: [io  0x008c-0x008e]
[    0.347061] pnp 00:08: [io  0x0090-0x009f]
[    0.347062] pnp 00:08: [io  0x00a2-0x00bf]
[    0.347063] pnp 00:08: [io  0x00e0-0x00ef]
[    0.347064] pnp 00:08: [io  0x04d0-0x04d1]
[    0.347090] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.347093] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.347098] pnp 00:09: [io  0x00f0-0x00ff]
[    0.347106] pnp 00:09: [irq 13]
[    0.347122] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.347153] pnp 00:0a: [io  0x0060]
[    0.347154] pnp 00:0a: [io  0x0064]
[    0.347162] pnp 00:0a: [irq 1]
[    0.347178] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.347190] pnp 00:0b: [irq 12]
[    0.347207] pnp 00:0b: Plug and Play ACPI device, IDs DLL0549 PNP0f13 (active)
[    0.348135] pnp 00:0c: Plug and Play ACPI device, IDs PNP0401 (disabled)
[    0.348286] pnp 00:0d: [mem 0xfed1c000-0xfed1ffff]
[    0.348287] pnp 00:0d: [mem 0xfed10000-0xfed17fff]
[    0.348288] pnp 00:0d: [mem 0xfed18000-0xfed18fff]
[    0.348289] pnp 00:0d: [mem 0xfed19000-0xfed19fff]
[    0.348291] pnp 00:0d: [mem 0xf8000000-0xfbffffff]
[    0.348293] pnp 00:0d: [mem 0xfed20000-0xfed3ffff]
[    0.348295] pnp 00:0d: [mem 0xfed90000-0xfed93fff]
[    0.348296] pnp 00:0d: [mem 0xfed45000-0xfed8ffff]
[    0.348297] pnp 00:0d: [mem 0xff000000-0xffffffff]
[    0.348298] pnp 00:0d: [mem 0xfee00000-0xfeefffff]
[    0.348299] pnp 00:0d: [mem 0xdfa00000-0xdfa00fff]
[    0.348341] system 00:0d: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.348342] system 00:0d: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.348344] system 00:0d: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.348345] system 00:0d: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.348347] system 00:0d: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.348348] system 00:0d: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.348350] system 00:0d: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.348351] system 00:0d: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.348353] system 00:0d: [mem 0xff000000-0xffffffff] has been reserved
[    0.348355] system 00:0d: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.348356] system 00:0d: [mem 0xdfa00000-0xdfa00fff] has been reserved
[    0.348358] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.348401] pnp 00:0e: [irq 23]
[    0.348432] pnp 00:0e: Plug and Play ACPI device, IDs SMO8810 (active)
[    0.348541] pnp 00:0f: [mem 0x20000000-0x201fffff]
[    0.348542] pnp 00:0f: [mem 0x40004000-0x40004fff]
[    0.348583] system 00:0f: [mem 0x20000000-0x201fffff] has been reserved
[    0.348585] system 00:0f: [mem 0x40004000-0x40004fff] has been reserved
[    0.348587] system 00:0f: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.350517] pnp: PnP ACPI: found 16 devices
[    0.350518] ACPI: ACPI bus type pnp unregistered
[    0.356766] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.356787] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.356794] pci 0000:00:1c.1:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.356805] pci 0000:00:1c.2: PCI bridge to [bus 03-06]
[    0.356808] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    0.356815] pci 0000:00:1c.2:   bridge window [mem 0xf7200000-0xf7bfffff]
[    0.356820] pci 0000:00:1c.2:   bridge window [mem 0xf0a00000-0xf13fffff 64bit pref]
[    0.356828] pci 0000:00:1c.3: PCI bridge to [bus 07-0a]
[    0.356831] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.356837] pci 0000:00:1c.3:   bridge window [mem 0xf6800000-0xf71fffff]
[    0.356842] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf09fffff 64bit pref]
[    0.356850] pci 0000:00:1c.5: PCI bridge to [bus 0b-0b]
[    0.356856] pci 0000:00:1c.5:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.356916] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.356918] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.356919] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.356920] pci_bus 0000:00: resource 7 [mem 0x000dc000-0x000dffff]
[    0.356922] pci_bus 0000:00: resource 8 [mem 0x000e0000-0x000e3fff]
[    0.356923] pci_bus 0000:00: resource 9 [mem 0x000e4000-0x000e7fff]
[    0.356924] pci_bus 0000:00: resource 10 [mem 0xdfa00000-0xfeafffff]
[    0.356926] pci_bus 0000:02: resource 1 [mem 0xf7d00000-0xf7dfffff]
[    0.356928] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.356929] pci_bus 0000:03: resource 1 [mem 0xf7200000-0xf7bfffff]
[    0.356931] pci_bus 0000:03: resource 2 [mem 0xf0a00000-0xf13fffff 64bit pref]
[    0.356932] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.356933] pci_bus 0000:07: resource 1 [mem 0xf6800000-0xf71fffff]
[    0.356935] pci_bus 0000:07: resource 2 [mem 0xf0000000-0xf09fffff 64bit pref]
[    0.356936] pci_bus 0000:0b: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    0.356959] NET: Registered protocol family 2
[    0.357084] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.357639] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.358597] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.358707] TCP: Hash tables configured (established 524288 bind 65536)
[    0.358709] TCP: reno registered
[    0.358718] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.358740] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.358802] NET: Registered protocol family 1
[    0.358812] pci 0000:00:02.0: Boot video device
[    0.392732] PCI: CLS 64 bytes, default 64
[    0.392765] Unpacking initramfs...
[    0.444158] Freeing initrd memory: 3356k freed
[    0.444508] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.444511] software IO TLB [mem 0xd5a3e000-0xd9a3dfff] (64MB) mapped at [ffff8800d5a3e000-ffff8800d9a3dfff]
[    0.444912] audit: initializing netlink socket (disabled)
[    0.444924] type=2000 audit(1348212893.326:1): initialized
[    0.455193] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.456610] VFS: Disk quotas dquot_6.5.2
[    0.456644] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.456712] msgmni has been set to 15741
[    0.456868] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.456896] io scheduler noop registered
[    0.456898] io scheduler deadline registered
[    0.456933] io scheduler cfq registered (default)
[    0.457363] vesafb: mode is 1600x900x32, linelength=6400, pages=0
[    0.457364] vesafb: scrolling: redraw
[    0.457366] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.457999] vesafb: framebuffer at 0xe0000000, mapped to 0xffffc90005800000, using 5632k, total 5632k
[    0.546737] Console: switching to colour frame buffer device 200x56
[    0.635211] fb0: VESA VGA frame buffer device
[    0.635218] intel_idle: does not run on family 6 model 58
[    0.635239] GHES: HEST is not enabled!
[    0.635286] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.655972] 0000:00:16.3: ttyS0 at I/O 0xf0e0 (irq = 19) is a 16550A
[    0.656191] Linux agpgart interface v0.103
[    0.656247] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.656737] i8042: Warning: Keylock active
[    0.659035] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.659055] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.659152] mousedev: PS/2 mouse device common for all mice
[    0.659195] rtc_cmos 00:06: RTC can wake from S4
[    0.659331] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    0.659359] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.659365] cpuidle: using governor ladder
[    0.659366] cpuidle: using governor menu
[    0.659445] drop_monitor: Initializing network drop monitor service
[    0.659505] TCP: cubic registered
[    0.659586] NET: Registered protocol family 10
[    0.659724] NET: Registered protocol family 17
[    0.659730] Key type dns_resolver registered
[    0.659827] PM: Hibernation image not present or could not be loaded.
[    0.659834] registered taskstats version 1
[    0.660531] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.660747] rtc_cmos 00:06: setting system clock to 2012-09-21 07:34:54 UTC (1348212894)
[    0.661741] Freeing unused kernel memory: 760k freed
[    0.661812] Write protecting the kernel read-only data: 8192k
[    0.665581] Freeing unused kernel memory: 1488k freed
[    0.667061] Freeing unused kernel memory: 612k freed
[    0.672442] systemd-udevd[48]: starting version 189
[    0.674351] [drm] Initialized drm 1.1.0 20060810
[    0.674932] agpgart-intel 0000:00:00.0: Intel Ivybridge Chipset
[    0.675020] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    0.675919] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    0.676007] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[    0.676376] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[    0.676866] ACPI: Lid Switch [LID0]
[    0.676904] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    0.676907] ACPI: Power Button [PBTN]
[    0.676936] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[    0.676938] ACPI: Sleep Button [SBTN]
[    0.676977] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    0.676979] ACPI: Power Button [PWRF]
[    0.679967] checking generic (e0000000 580000) vs hw (e0000000 10000000)
[    0.679969] fb: conflicting fb hw usage inteldrmfb vs VESA VGA - removing generic driver
[    0.679980] Console: switching to colour dummy device 80x25
[    0.680054] i915 0000:00:02.0: setting latency timer to 64
[    0.713208] i915 0000:00:02.0: irq 42 for MSI/MSI-X
[    0.713221] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    0.713222] [drm] Driver supports precise vblank timestamp query.
[    0.713638] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.202570] [drm] Enabling RC6 states: RC6 on, RC6p on, RC6pp off
[    1.445577] Refined TSC clocksource calibration: 2591.583 MHz.
[    1.445582] Switching to clocksource tsc
[    1.667822] fbcon: inteldrmfb (fb0) is primary device
[    1.995283] Console: switching to colour frame buffer device 200x56
[    1.998870] fb0: inteldrmfb frame buffer device
[    1.998871] drm: registered panic notifier
[    2.012563] acpi device:4c: registered as cooling_device0
[    2.032279] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[    2.032323] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    2.032346] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    2.059914] ACPI: bus type usb registered
[    2.059935] usbcore: registered new interface driver usbfs
[    2.059943] usbcore: registered new interface driver hub
[    2.060843] usbcore: registered new device driver usb
[    2.062060] xhci_hcd 0000:00:14.0: setting latency timer to 64
[    2.062067] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.062075] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.062175] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.062199] xhci_hcd 0000:00:14.0: irq 16, io mem 0xf7e20000
[    2.062251] SCSI subsystem initialized
[    2.062261] xhci_hcd 0000:00:14.0: irq 43 for MSI/MSI-X
[    2.062475] xHCI xhci_add_endpoint called for root hub
[    2.062478] xHCI xhci_check_bandwidth called for root hub
[    2.062517] hub 1-0:1.0: USB hub found
[    2.062528] hub 1-0:1.0: 4 ports detected
[    2.062579] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.062627] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.062632] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.062877] xHCI xhci_add_endpoint called for root hub
[    2.062879] xHCI xhci_check_bandwidth called for root hub
[    2.062921] hub 2-0:1.0: USB hub found
[    2.062933] hub 2-0:1.0: 4 ports detected
[    2.063719] libata version 3.00 loaded.
[    2.068766] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.068773] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    2.068780] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.068814] ehci_hcd 0000:00:1a.0: debug port 2
[    2.072712] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    2.072730] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf7e38000
[    2.082060] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.082203] hub 3-0:1.0: USB hub found
[    2.082206] hub 3-0:1.0: 3 ports detected
[    2.082363] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    2.082367] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    2.082379] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    2.082411] ehci_hcd 0000:00:1d.0: debug port 2
[    2.086286] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    2.086299] ehci_hcd 0000:00:1d.0: irq 21, io mem 0xf7e37000
[    2.095356] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.095482] hub 4-0:1.0: USB hub found
[    2.095484] hub 4-0:1.0: 3 ports detected
[    2.095539] ahci 0000:00:1f.2: version 3.0
[    2.095603] ahci 0000:00:1f.2: irq 44 for MSI/MSI-X
[    2.095654] ahci: SSS flag set, parallel bus scan disabled
[    2.108715] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x31 impl RAID mode
[    2.108721] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part ems sxs apst 
[    2.108742] ahci 0000:00:1f.2: setting latency timer to 64
[    2.122568] scsi0 : ahci
[    2.122633] scsi1 : ahci
[    2.122680] scsi2 : ahci
[    2.122727] scsi3 : ahci
[    2.122772] scsi4 : ahci
[    2.122819] scsi5 : ahci
[    2.123042] ata1: SATA max UDMA/133 abar m2048@0xf7e36000 port 0xf7e36100 irq 44
[    2.123043] ata2: DUMMY
[    2.123044] ata3: DUMMY
[    2.123045] ata4: DUMMY
[    2.123049] ata5: SATA max UDMA/133 abar m2048@0xf7e36000 port 0xf7e36300 irq 44
[    2.123052] ata6: SATA max UDMA/133 abar m2048@0xf7e36000 port 0xf7e36380 irq 44
[    2.268664] usb 2-4: new SuperSpeed USB device number 2 using xhci_hcd
[    2.283832] hub 2-4:1.0: USB hub found
[    2.283871] hub 2-4:1.0: 3 ports detected
[    2.441920] usb 1-4: new high-speed USB device number 2 using xhci_hcd
[    2.441926] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.442323] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    2.442329] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    2.442333] ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    2.442389] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.442551] ata1.00: ATA-8: LITEONIT LCT-128M3S, VQDC, max UDMA/133
[    2.442555] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.442953] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    2.442957] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    2.442961] ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    2.443016] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.443172] ata1.00: configured for UDMA/133
[    2.448692] scsi 0:0:0:0: Direct-Access     ATA      LITEONIT LCT-128 VQDC PQ: 0 ANSI: 5
[    2.455689] hub 1-4:1.0: USB hub found
[    2.455718] hub 1-4:1.0: 3 ports detected
[    2.561876] usb 3-1: new high-speed USB device number 2 using ehci_hcd
[    2.685864] hub 3-1:1.0: USB hub found
[    2.685945] hub 3-1:1.0: 6 ports detected
[    2.768480] ata5: SATA link down (SStatus 0 SControl 300)
[    2.791801] usb 4-1: new high-speed USB device number 2 using ehci_hcd
[    2.915772] hub 4-1:1.0: USB hub found
[    2.915872] hub 4-1:1.0: 8 ports detected
[    2.995090] usb 1-4.1: new high-speed USB device number 3 using xhci_hcd
[    3.008754] hub 1-4.1:1.0: USB hub found
[    3.008777] hub 1-4.1:1.0: 4 ports detected
[    3.075210] usb 3-1.4: new full-speed USB device number 3 using ehci_hcd
[    3.088377] ata6: SATA link down (SStatus 0 SControl 300)
[    3.091429] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    3.091468] sd 0:0:0:0: [sda] Write Protect is off
[    3.091470] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.091481] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.133809]  sda: sda1 sda2
[    3.134066] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.175297] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    3.228550] usb 3-1.5: new high-speed USB device number 4 using ehci_hcd
[    3.275929] systemd-udevd[168]: starting version 189
[    3.301165] i8k: unable to get SMM BIOS version
[    3.313695] Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
[    3.338048] ACPI: Requesting acpi_cpufreq
[    3.347797] Monitor-Mwait will be used to enter C-1 state
[    3.347825] Monitor-Mwait will be used to enter C-2 state
[    3.347905] Monitor-Mwait will be used to enter C-3 state
[    3.347921] ACPI: acpi_idle registered with cpuidle
[    3.384049] e1000e: Intel(R) PRO/1000 Network Driver - 2.0.0-k
[    3.384052] e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
[    3.385058] e1000e 0000:00:19.0: setting latency timer to 64
[    3.385145] e1000e 0000:00:19.0: (unregistered net_device): Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.385183] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[    3.423259] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    3.428135] Bluetooth: Core ver 2.16
[    3.428147] NET: Registered protocol family 31
[    3.428148] Bluetooth: HCI device and connection manager initialized
[    3.428149] Bluetooth: HCI socket layer initialized
[    3.428150] Bluetooth: L2CAP socket layer initialized
[    3.428153] Bluetooth: SCO socket layer initialized
[    3.429920] usbcore: registered new interface driver btusb
[    3.454701] Linux media interface: v0.10
[    3.455169] thermal LNXTHERM:00: registered as thermal_zone0
[    3.455171] ACPI: Thermal Zone [THM] (62 C)
[    3.461693] usb 3-1.6: new full-speed USB device number 5 using ehci_hcd
[    3.578923] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1) d4:be:d9:4c:60:97
[    3.578926] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    3.578969] e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: A011FF-0FF
[    3.579002] ACPI Warning: 0x000000000000f040-0x000000000000f05f SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1 (20120320/utaddress-251)
[    3.579008] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    3.625070] usb 4-1.6: new high-speed USB device number 3 using ehci_hcd
[    3.909808] cdc_acm 4-1.6:1.1: ttyACM0: USB ACM device
[    3.910430] cdc_acm 4-1.6:1.3: ttyACM1: USB ACM device
[    3.920792] cdc_wdm 4-1.6:1.5: cdc-wdm0: USB WDM device
[    3.920853] cdc_wdm 4-1.6:1.8: cdc-wdm1: USB WDM device
[    3.920914] cdc_acm 4-1.6:1.9: ttyACM2: USB ACM device
[    3.920930] usbcore: registered new interface driver cdc_wdm
[    3.928733] usbcore: registered new interface driver cdc_acm
[    3.928735] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    4.208083] usb 4-1.8: new high-speed USB device number 4 using ehci_hcd
[    4.321603] hub 4-1.8:1.0: USB hub found
[    4.321663] hub 4-1.8:1.0: 3 ports detected
[    4.397963] usb 1-4.1.1: new low-speed USB device number 4 using xhci_hcd
[    4.424072] usb 1-4.1.1: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    4.424077] usb 1-4.1.1: ep 0x82 - rounding interval to 64 microframes, ep desc says 80 microframes
[    4.715088] usbcore: registered new interface driver usbhid
[    4.715091] usbhid: USB HID core driver
[    4.747950] usb 1-4.1.2: new low-speed USB device number 5 using xhci_hcd
[    4.766039] usb 1-4.1.2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    4.773318] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1.2/1-4.1.2:1.0/input/input6
[    4.773490] hid-generic 0003:04B3:310C.0003: input,hidraw0: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-4.1.2/input0
[    4.847935] usb 1-4.1.3: new full-speed USB device number 6 using xhci_hcd
[    4.877157] usblp 1-4.1.3:1.0: usblp2: USB Bidirectional printer dev 6 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0027
[    4.877193] usbcore: registered new interface driver usblp
[    4.894713] ACPI: AC Adapter [AC] (on-line)
[    5.394310] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20120320/evregion-501)
[    5.394320] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880212864b40), AE_TIME (20120320/psparse-536)
[    5.394327] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880212864ca8), AE_TIME (20120320/psparse-536)
[    5.394331] ACPI Error: Method parse/execution failed [\ECG5] (Node ffff880212864dc0), AE_TIME (20120320/psparse-536)
[    5.394334] ACPI Error: Method parse/execution failed [\_SB_.AC__._PSR] (Node ffff8802128664b0), AE_TIME (20120320/psparse-536)
[    5.394344] ACPI Exception: AE_TIME, Error reading AC Adapter state (20120320/ac-118)
[    5.416707] psmouse serio1: Failed to enable mouse on isa0060/serio1
[    5.470807] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[    5.894144] ACPI: EC: input buffer is not empty, aborting transaction
[    5.894185] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20120320/evregion-501)
[    5.894190] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880212864b40), AE_TIME (20120320/psparse-536)
[    5.894196] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880212864ca8), AE_TIME (20120320/psparse-536)
[    5.894200] ACPI Error: Method parse/execution failed [\ECG5] (Node ffff880212864dc0), AE_TIME (20120320/psparse-536)
[    5.894203] ACPI Error: Method parse/execution failed [\_SB_.BAT0._STA] (Node ffff8802128665c8), AE_TIME (20120320/psparse-536)
[    5.894211] ACPI Exception: AE_ERROR, Evaluating _STA (20120320/battery-396)
[    6.687303] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20120320/evregion-501)
[    6.687316] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880212864b40), AE_TIME (20120320/psparse-536)
[    6.687325] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880212864ca8), AE_TIME (20120320/psparse-536)
[    6.687330] ACPI Error: Method parse/execution failed [\ECG5] (Node ffff880212864dc0), AE_TIME (20120320/psparse-536)
[    6.687333] ACPI Error: Method parse/execution failed [\_SB_.AC__._PSR] (Node ffff8802128664b0), AE_TIME (20120320/psparse-536)
[    6.687422] ACPI Exception: AE_TIME, Error reading AC Adapter state (20120320/ac-118)
[    7.207061] ACPI: EC: input buffer is not empty, aborting transaction
[    7.207098] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20120320/evregion-501)
[    7.207107] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880212864b40), AE_TIME (20120320/psparse-536)
[    7.207115] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880212864ca8), AE_TIME (20120320/psparse-536)
[    7.207119] ACPI Error: Method parse/execution failed [\ECG5] (Node ffff880212864dc0), AE_TIME (20120320/psparse-536)
[    7.207123] ACPI Error: Method parse/execution failed [\_SB_.BAT1._STA] (Node ffff8802128666e0), AE_TIME (20120320/psparse-536)
[    7.207131] ACPI Exception: AE_ERROR, Evaluating _STA (20120320/battery-396)
[    7.207648] wmi: Mapper loaded
[    7.249906] parport_pc 00:0c: [io  0x0378-0x037b]
[    7.250097] parport_pc 00:0c: [irq 5]
[    7.252821] ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts with Region \PMIO 1 (20120320/utaddress-251)
[    7.252828] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    7.252832] ACPI Warning: 0x0000000000000500-0x000000000000053f SystemIO conflicts with Region \GPIO 1 (20120320/utaddress-251)
[    7.252836] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    7.252837] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    7.254747] sdhci: Secure Digital Host Controller Interface driver
[    7.254749] sdhci: Copyright(c) Pierre Ossman
[    7.255308] sdhci-pci 0000:0b:00.0: SDHCI controller found [1217:8221] (rev 5)
[    7.255500] sdhci-pci 0000:0b:00.0: Invalid iomem size. You may experience problems.
[    7.262273] cfg80211: Calling CRDA to update world regulatory domain
[    7.264999] Linux video capture interface: v2.00
[    7.265882] microcode: CPU0 sig=0x306a9, pf=0x10, revision=0x12
[    7.271371] uvcvideo: Found UVC 1.00 device Laptop_Integrated_Webcam_E4HD (0c45:6449)
[    7.280207] usb 4-1.6: MAC-Address: 02:15:e0:ec:01:00
[    7.280338] cdc_ncm 4-1.6:1.6: usb0: register 'cdc_ncm' at usb-0000:00:1d.0-1.6, CDC NCM, 02:15:e0:ec:01:00
[    7.280371] usbcore: registered new interface driver cdc_ncm
[    7.285308] iwlwifi: Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
[    7.285310] iwlwifi: Copyright(c) 2003-2012 Intel Corporation
[    7.649764] iwlwifi 0000:02:00.0: pci_resource_len = 0x00002000
[    7.649767] iwlwifi 0000:02:00.0: pci_resource_base = ffffc900059b4000
[    7.649768] iwlwifi 0000:02:00.0: HW Revision ID = 0x35
[    7.650024] Registered led device: mmc0::
[    7.650279] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
[    7.650671] iwlwifi 0000:02:00.0: irq 46 for MSI/MSI-X
[    7.651105] input: Laptop_Integrated_Webcam_E4HD as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.5/3-1.5:1.0/input/input7
[    7.651201] usbcore: registered new interface driver uvcvideo
[    7.651202] USB Video Class driver (1.1.1)
[    7.665750] parport_pc 00:0c: activated
[    7.665756] parport_pc 00:0c: reported by Plug and Play ACPI
[    7.665834] parport_pc 00:0c: disabled
[    7.673599] mmc0: SDHCI controller on PCI [0000:0b:00.0] using DMA
[    7.726648] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input8
[    8.107288] iTCO_vendor_support: vendor-support=0
[    8.107682] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1.1/1-4.1.1:1.0/input/input9
[    8.107948] cherry 0003:046A:0023.0001: input,hidraw1: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:14.0-4.1.1/input0
[    8.108204] input: Dell WMI hotkeys as /devices/virtual/input/input10
[    8.108451] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
[    8.108495] iTCO_wdt: Found a Panther Point TCO device (Version=2, TCOBASE=0x0460)
[    8.108785] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    8.108884] ppdev: user-space parallel port driver
[    8.109070] microcode: CPU1 sig=0x306a9, pf=0x10, revision=0x12
[    8.110861] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1.1/1-4.1.1:1.1/input/input11
[    8.110956] cherry 0003:046A:0023.0002: input,hidraw2: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:14.0-4.1.1/input1
[    8.111509] microcode: CPU2 sig=0x306a9, pf=0x10, revision=0x12
[    8.113341] microcode: CPU3 sig=0x306a9, pf=0x10, revision=0x12
[    8.114125] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    8.116440] iwlwifi 0000:02:00.0: loaded firmware version 9.221.4.1 build 25532
[    8.116600] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUG disabled
[    8.116603] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[    8.116605] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TRACING enabled
[    8.116607] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE enabled
[    8.116609] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_P2P disabled
[    8.116611] iwlwifi 0000:02:00.0: Detected Intel(R) Centrino(R) Ultimate-N 6300 AGN, REV=0x74
[    8.116744] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[    8.134137] iwlwifi 0000:02:00.0: device EEPROM VER=0x43a, CALIB=0x6
[    8.134139] iwlwifi 0000:02:00.0: Device SKU: 0x1F0
[    8.134141] iwlwifi 0000:02:00.0: Valid Tx ant: 0x7, Valid Rx ant: 0x7
[    8.134155] iwlwifi 0000:02:00.0: Tunable channels: 13 802.11bg, 24 802.11a channels
[    8.134234] Registered led device: phy0-led
[    8.136297] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[    8.213011] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input12
[    8.229192] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    8.229423] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[    8.229542] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[    8.229654] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[    8.229756] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[    8.229864] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[    8.229960] input: HDA Intel PCH Dock Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input19
[   10.146090] EXT4-fs (sda2): re-mounted. Opts: data=ordered
[   10.721614] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.726526] Bluetooth: RFCOMM TTY layer initialized
[   10.726532] Bluetooth: RFCOMM socket layer initialized
[   10.726533] Bluetooth: RFCOMM ver 1.11
[   10.816135] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[   10.919360] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[   10.920580] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.926152] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[   10.932666] iwlwifi 0000:02:00.0: Radio type=0x0-0x3-0x1
[   11.171924] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[   11.178459] iwlwifi 0000:02:00.0: Radio type=0x0-0x3-0x1
[   11.291211] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   11.297784] cdc_ncm: usb0: network connection: disconnected
[   11.298538] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[   11.306083] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[   12.575875] fuse init (API version 7.19)
[   13.455239] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[   14.461379] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   14.461834] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   14.711526] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[   14.814724] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[   14.815600] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   15.054452] EXT4-fs (sda2): re-mounted. Opts: data=ordered,commit=0
[   18.340240] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   18.340762] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  733.207130] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[ 1352.036127] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[ 1374.022575] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[ 7814.970044] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[11970.910568] usblp2: removed
[11974.167495] usblp 1-4.1.3:1.0: usblp2: USB Bidirectional printer dev 6 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0027
[11974.634967] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[11977.640763] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[14430.369661] tmpfs: Bad value '8GB' for mount option 'size'


--------------090806060901040806090402--
