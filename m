From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
Subject: Re: ACPI errors on Dell Latitude E5430
Date: Tue, 02 Oct 2012 11:22:37 +0200
Message-ID: <506AB25D.7000900@hundeboll.net>
References: <5069E332.9060109@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040300040706040101080609"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.hundeboll.net ([95.211.44.99]:53645 "EHLO
	mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab2JBJX6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2012 05:23:58 -0400
In-Reply-To: <5069E332.9060109@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

This is a multi-part message in MIME format.
--------------040300040706040101080609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hans,

On 2012-10-01 20:38, Hans de Goede wrote:
> 2) Even with a 3.6 which shows the problematic behavior, I can
> make things work by adding acpi.ec_delay=2000 to the kernel cmdline,
> the debug traces show that the EC takes it sweet time to respond
> (sometime close to 2 seconds) but it does eventually respond in all
> cases I've seen sofar.
>
> This also seems to fix a sporadic occurence of:
> "ACPI: EC: input buffer is not empty aborting transaction"
> Which I'm seeing with 3.5 / 3.6 in a non debug build.
>
> Martin, can you see if adding that helps you with the E5430 problems
> too ?

As far as I can tell from the attached dmesg, the errors are gone after 
setting acpi.ec_delay=2000. Thanks a lot!

The only remaining issue is the fan control, which works as expected 
initially, but then fails to spin down after a few minutes. Is this ACPI 
related? And if so, please instruct me how to debug further.

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net

--------------040300040706040101080609
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.4-1-ARCH (tobias@T-POWA-LX) (gcc version 4.7.1 20120721 (prerelease) (GCC) ) #1 SMP PREEMPT Sat Sep 15 08:12:04 CEST 2012
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=ef14a89c-443d-4d51-99b8-bff7a90f1015 ro quiet acpi.ec_delay=2000
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
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=ef14a89c-443d-4d51-99b8-bff7a90f1015 ro quiet acpi.ec_delay=2000
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
[    0.003333] Detected 2591.634 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 5185.23 BogoMIPS (lpj=8638780)
[    0.000004] pid_max: default: 32768 minimum: 301
[    0.000023] Security Framework initialized
[    0.000026] AppArmor: AppArmor disabled by boot time parameter
[    0.000447] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.002307] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003134] Mount-cache hash table entries: 256
[    0.003273] Initializing cgroup subsys cpuacct
[    0.003275] Initializing cgroup subsys memory
[    0.003281] Initializing cgroup subsys devices
[    0.003282] Initializing cgroup subsys freezer
[    0.003283] Initializing cgroup subsys net_cls
[    0.003284] Initializing cgroup subsys blkio
[    0.003305] CPU: Physical Processor ID: 0
[    0.003306] CPU: Processor Core ID: 0
[    0.003310] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.003651] mce: CPU supports 7 MCE banks
[    0.003658] CPU0: Thermal monitoring handled by SMI
[    0.003664] using mwait in idle threads.
[    0.004563] ACPI: Core revision 20120320
[    0.013014] ftrace: allocating 17970 entries in 71 pages
[    0.020431] DMAR: Host address width 36
[    0.020433] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.020440] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
[    0.020441] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.020446] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.020447] DMAR: RMRR base: 0x000000d9fe7000 end: 0x000000da005fff
[    0.020448] DMAR: RMRR base: 0x000000db800000 end: 0x000000df9fffff
[    0.020521] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.020522] HPET id 0 under DRHD base 0xfed91000
[    0.020654] Enabled IRQ remapping in x2apic mode
[    0.020655] Enabling x2apic
[    0.020656] Enabled x2apic
[    0.020664] Switched APIC routing to cluster x2apic.
[    0.021121] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.054114] CPU0: Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz stepping 09
[    0.160297] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, Intel PMU driver.
[    0.160302] ... version:                3
[    0.160302] ... bit width:              48
[    0.160303] ... generic registers:      4
[    0.160304] ... value mask:             0000ffffffffffff
[    0.160305] ... max period:             000000007fffffff
[    0.160305] ... fixed-purpose events:   3
[    0.160306] ... event mask:             000000070000000f
[    0.180370] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.205017] CPU1: Thermal monitoring handled by SMI
[    0.231671] CPU2: Thermal monitoring handled by SMI
[    0.193634] Booting Node   0, Processors  #1 #2 #3 Ok.
[    0.258328] CPU3: Thermal monitoring handled by SMI
[    0.260410] Brought up 4 CPUs
[    0.260413] Total of 4 processors activated (20741.95 BogoMIPS).
[    0.263407] devtmpfs: initialized
[    0.264459] PM: Registering ACPI NVS region [mem 0xda067000-0xda2a9fff] (2371584 bytes)
[    0.264486] PM: Registering ACPI NVS region [mem 0xda2b7000-0xda2e6fff] (196608 bytes)
[    0.264489] PM: Registering ACPI NVS region [mem 0xda2ec000-0xda32efff] (274432 bytes)
[    0.265166] NET: Registered protocol family 16
[    0.265263] ACPI: bus type pci registered
[    0.265311] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.265313] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.272145] PCI: Using configuration type 1 for base access
[    0.272152] dmi type 0xB1 record - unknown flag
[    0.272580] bio: create slab <bio-0> at 0
[    0.272617] ACPI: Added _OSI(Module Device)
[    0.272618] ACPI: Added _OSI(Processor Device)
[    0.272619] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.272621] ACPI: Added _OSI(Processor Aggregator Device)
[    0.273869] ACPI: EC: Look up EC in DSDT
[    0.275094] ACPI: Executed 1 blocks of module-level executable AML code
[    0.280343] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.320745] ACPI: SSDT 00000000da00e598 00523 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    0.321059] ACPI: Dynamic OEM Table Load:
[    0.321061] ACPI: SSDT           (null) 00523 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    0.321266] ACPI: SSDT 00000000da00fa98 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    0.321603] ACPI: Dynamic OEM Table Load:
[    0.321605] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    0.321699] ACPI: SSDT 00000000da015c18 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    0.322006] ACPI: Dynamic OEM Table Load:
[    0.322008] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    0.324515] ACPI: Interpreter enabled
[    0.324517] ACPI: (supports S0 S3 S4 S5)
[    0.324538] ACPI: Using IOAPIC for interrupt routing
[    0.336531] ACPI: EC: GPE = 0x10, I/O: command/status = 0x934, data = 0x930
[    0.336694] ACPI: No dock devices found.
[    0.336697] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.336935] \_SB_.PCI0:_OSC invalid UUID
[    0.336936] _OSC request data:1 8 1f 
[    0.336939] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.337310] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.337312] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.337313] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.337315] pci_root PNP0A08:00: host bridge window [mem 0x000dc000-0x000dffff]
[    0.337316] pci_root PNP0A08:00: host bridge window [mem 0x000e0000-0x000e3fff]
[    0.337317] pci_root PNP0A08:00: host bridge window [mem 0x000e4000-0x000e7fff]
[    0.337319] pci_root PNP0A08:00: host bridge window [mem 0xdfa00000-0xfeafffff]
[    0.337344] PCI host bridge to bus 0000:00
[    0.337346] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.337348] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.337349] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.337350] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.337352] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.337353] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
[    0.337354] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff]
[    0.337362] pci 0000:00:00.0: [8086:0154] type 00 class 0x060000
[    0.337400] pci 0000:00:02.0: [8086:0166] type 00 class 0x030000
[    0.337409] pci 0000:00:02.0: reg 10: [mem 0xf6400000-0xf67fffff 64bit]
[    0.337414] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.337418] pci 0000:00:02.0: reg 20: [io  0xf000-0xf03f]
[    0.337470] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
[    0.337491] pci 0000:00:14.0: reg 10: [mem 0xf7e20000-0xf7e2ffff 64bit]
[    0.337561] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.337585] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
[    0.337608] pci 0000:00:16.0: reg 10: [mem 0xf7e3c000-0xf7e3c00f 64bit]
[    0.337683] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.337707] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
[    0.337725] pci 0000:00:16.3: reg 10: [io  0xf0e0-0xf0e7]
[    0.337734] pci 0000:00:16.3: reg 14: [mem 0xf7e3a000-0xf7e3afff]
[    0.337831] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
[    0.337848] pci 0000:00:19.0: reg 10: [mem 0xf7e00000-0xf7e1ffff]
[    0.337857] pci 0000:00:19.0: reg 14: [mem 0xf7e39000-0xf7e39fff]
[    0.337864] pci 0000:00:19.0: reg 18: [io  0xf080-0xf09f]
[    0.337926] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.337952] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
[    0.337972] pci 0000:00:1a.0: reg 10: [mem 0xf7e38000-0xf7e383ff]
[    0.338061] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.338087] pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
[    0.338101] pci 0000:00:1b.0: reg 10: [mem 0xf7e30000-0xf7e33fff 64bit]
[    0.338167] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.338196] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
[    0.338324] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.338361] pci 0000:00:1c.1: [8086:1e12] type 01 class 0x060400
[    0.338490] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.338528] pci 0000:00:1c.2: [8086:1e14] type 01 class 0x060400
[    0.338659] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.338697] pci 0000:00:1c.3: [8086:1e16] type 01 class 0x060400
[    0.338825] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.338865] pci 0000:00:1c.5: [8086:1e1a] type 01 class 0x060400
[    0.338995] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.339035] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
[    0.339055] pci 0000:00:1d.0: reg 10: [mem 0xf7e37000-0xf7e373ff]
[    0.339144] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.339168] pci 0000:00:1f.0: [8086:1e55] type 00 class 0x060100
[    0.339291] pci 0000:00:1f.2: [8086:282a] type 00 class 0x010400
[    0.339309] pci 0000:00:1f.2: reg 10: [io  0xf0d0-0xf0d7]
[    0.339317] pci 0000:00:1f.2: reg 14: [io  0xf0c0-0xf0c3]
[    0.339325] pci 0000:00:1f.2: reg 18: [io  0xf0b0-0xf0b7]
[    0.339333] pci 0000:00:1f.2: reg 1c: [io  0xf0a0-0xf0a3]
[    0.339341] pci 0000:00:1f.2: reg 20: [io  0xf060-0xf07f]
[    0.339349] pci 0000:00:1f.2: reg 24: [mem 0xf7e36000-0xf7e367ff]
[    0.339393] pci 0000:00:1f.2: PME# supported from D3hot
[    0.339412] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
[    0.339427] pci 0000:00:1f.3: reg 10: [mem 0xf7e35000-0xf7e350ff 64bit]
[    0.339448] pci 0000:00:1f.3: reg 20: [io  0xf040-0xf05f]
[    0.339542] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.339739] pci 0000:02:00.0: [8086:422b] type 00 class 0x028000
[    0.339853] pci 0000:02:00.0: reg 10: [mem 0xf7d00000-0xf7d01fff 64bit]
[    0.340446] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.347138] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.347146] pci 0000:00:1c.1:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.347224] pci 0000:00:1c.2: PCI bridge to [bus 03-06]
[    0.347228] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    0.347233] pci 0000:00:1c.2:   bridge window [mem 0xf7200000-0xf7bfffff]
[    0.347242] pci 0000:00:1c.2:   bridge window [mem 0xf0a00000-0xf13fffff 64bit pref]
[    0.347312] pci 0000:00:1c.3: PCI bridge to [bus 07-0a]
[    0.347317] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.347322] pci 0000:00:1c.3:   bridge window [mem 0xf6800000-0xf71fffff]
[    0.347330] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf09fffff 64bit pref]
[    0.347539] pci 0000:0b:00.0: [1217:8221] type 00 class 0x080501
[    0.347584] pci 0000:0b:00.0: reg 10: [mem 0xf7c00000-0xf7c001ff]
[    0.347903] pci 0000:0b:00.0: supports D1 D2
[    0.347904] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.353814] pci 0000:00:1c.5: PCI bridge to [bus 0b-0b]
[    0.353821] pci 0000:00:1c.5:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.353862] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.353953] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.353977] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.354001] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    0.354034] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.354054] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.354128] \_SB_.PCI0:_OSC invalid UUID
[    0.354129] _OSC request data:1 1f 1f 
[    0.354132]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.354164] \_SB_.PCI0:_OSC invalid UUID
[    0.354165] _OSC request data:1 0 1d 
[    0.354167]  pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control mask: 0x1d
[    0.354168] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.358173] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.358214] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 10 11 12 14 15)
[    0.358250] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.358289] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.358328] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.358367] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.358402] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.358441] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.358506] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.358511] vgaarb: loaded
[    0.358512] vgaarb: bridge control possible 0000:00:02.0
[    0.358540] PCI: Using ACPI for IRQ routing
[    0.360192] PCI: pci_cache_line_size set to 64 bytes
[    0.360431] e820: reserve RAM buffer [mem 0x00090800-0x0009ffff]
[    0.360433] e820: reserve RAM buffer [mem 0x40004000-0x43ffffff]
[    0.360434] e820: reserve RAM buffer [mem 0xd9a3e000-0xdbffffff]
[    0.360436] e820: reserve RAM buffer [mem 0xdb000000-0xdbffffff]
[    0.360437] e820: reserve RAM buffer [mem 0x21e600000-0x21fffffff]
[    0.360505] NetLabel: Initializing
[    0.360506] NetLabel:  domain hash size = 128
[    0.360506] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.360515] NetLabel:  unlabeled traffic allowed by default
[    0.360532] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.360536] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.362549] Switching to clocksource hpet
[    0.366412] pnp: PnP ACPI init
[    0.366424] ACPI: bus type pnp registered
[    0.366648] pnp 00:00: [bus 00-3e]
[    0.366651] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.366652] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.366653] pnp 00:00: [io  0x0d00-0xffff window]
[    0.366655] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.366656] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.366657] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.366659] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.366660] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.366661] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.366662] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.366664] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.366665] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.366666] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.366667] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.366669] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.366670] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.366671] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.366672] pnp 00:00: [mem 0xdfa00000-0xfeafffff window]
[    0.366674] pnp 00:00: [mem 0x00010000-0x0001ffff window]
[    0.366732] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.366749] pnp 00:01: [mem 0xfed40000-0xfed44fff]
[    0.366777] system 00:01: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.366780] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.366789] pnp 00:02: [io  0x0000-0x001f]
[    0.366790] pnp 00:02: [io  0x0081-0x0091]
[    0.366791] pnp 00:02: [io  0x0093-0x009f]
[    0.366792] pnp 00:02: [io  0x00c0-0x00df]
[    0.366794] pnp 00:02: [dma 4]
[    0.366809] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.366814] pnp 00:03: [mem 0xff000000-0xffffffff]
[    0.366827] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
[    0.366896] pnp 00:04: [mem 0xfed00000-0xfed003ff]
[    0.366912] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.366920] pnp 00:05: [io  0x002e-0x002f]
[    0.366921] pnp 00:05: [io  0x004e-0x004f]
[    0.366922] pnp 00:05: [io  0x0061]
[    0.366923] pnp 00:05: [io  0x0063]
[    0.366925] pnp 00:05: [io  0x0065]
[    0.366926] pnp 00:05: [io  0x0067]
[    0.366927] pnp 00:05: [io  0x0070]
[    0.366928] pnp 00:05: [io  0x0080]
[    0.366929] pnp 00:05: [io  0x0092]
[    0.366930] pnp 00:05: [io  0x00b2-0x00b3]
[    0.366931] pnp 00:05: [io  0x0680-0x069f]
[    0.366932] pnp 00:05: [io  0x0200-0x020f]
[    0.366933] pnp 00:05: [io  0x0900-0x0903]
[    0.366935] pnp 00:05: [io  0xffff]
[    0.366937] pnp 00:05: [io  0x0400-0x0453]
[    0.366938] pnp 00:05: [io  0x0458-0x047f]
[    0.366939] pnp 00:05: [io  0x0500-0x057f]
[    0.366940] pnp 00:05: [io  0x164e-0x164f]
[    0.366967] system 00:05: [io  0x0680-0x069f] has been reserved
[    0.366968] system 00:05: [io  0x0200-0x020f] has been reserved
[    0.366970] system 00:05: [io  0x0900-0x0903] has been reserved
[    0.366972] system 00:05: [io  0xffff] has been reserved
[    0.366973] system 00:05: [io  0x0400-0x0453] has been reserved
[    0.366974] system 00:05: [io  0x0458-0x047f] has been reserved
[    0.366976] system 00:05: [io  0x0500-0x057f] has been reserved
[    0.366977] system 00:05: [io  0x164e-0x164f] has been reserved
[    0.366979] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.366985] pnp 00:06: [io  0x0070-0x0077]
[    0.366996] pnp 00:06: [irq 8]
[    0.367011] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.367030] pnp 00:07: [io  0x0454-0x0457]
[    0.367053] system 00:07: [io  0x0454-0x0457] has been reserved
[    0.367055] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.367070] pnp 00:08: [io  0x0010-0x001f]
[    0.367072] pnp 00:08: [io  0x0022-0x003f]
[    0.367073] pnp 00:08: [io  0x0044-0x005f]
[    0.367074] pnp 00:08: [io  0x0072-0x007f]
[    0.367075] pnp 00:08: [io  0x0080]
[    0.367076] pnp 00:08: [io  0x0084-0x0086]
[    0.367077] pnp 00:08: [io  0x0088]
[    0.367078] pnp 00:08: [io  0x008c-0x008e]
[    0.367080] pnp 00:08: [io  0x0090-0x009f]
[    0.367081] pnp 00:08: [io  0x00a2-0x00bf]
[    0.367082] pnp 00:08: [io  0x00e0-0x00ef]
[    0.367083] pnp 00:08: [io  0x04d0-0x04d1]
[    0.367109] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.367111] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.367116] pnp 00:09: [io  0x00f0-0x00ff]
[    0.367122] pnp 00:09: [irq 13]
[    0.367138] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.367169] pnp 00:0a: [io  0x0060]
[    0.367170] pnp 00:0a: [io  0x0064]
[    0.367179] pnp 00:0a: [irq 1]
[    0.367195] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.367207] pnp 00:0b: [irq 12]
[    0.367224] pnp 00:0b: Plug and Play ACPI device, IDs DLL0549 PNP0f13 (active)
[    0.368152] pnp 00:0c: Plug and Play ACPI device, IDs PNP0401 (disabled)
[    0.368303] pnp 00:0d: [mem 0xfed1c000-0xfed1ffff]
[    0.368305] pnp 00:0d: [mem 0xfed10000-0xfed17fff]
[    0.368306] pnp 00:0d: [mem 0xfed18000-0xfed18fff]
[    0.368307] pnp 00:0d: [mem 0xfed19000-0xfed19fff]
[    0.368308] pnp 00:0d: [mem 0xf8000000-0xfbffffff]
[    0.368311] pnp 00:0d: [mem 0xfed20000-0xfed3ffff]
[    0.368312] pnp 00:0d: [mem 0xfed90000-0xfed93fff]
[    0.368313] pnp 00:0d: [mem 0xfed45000-0xfed8ffff]
[    0.368315] pnp 00:0d: [mem 0xff000000-0xffffffff]
[    0.368316] pnp 00:0d: [mem 0xfee00000-0xfeefffff]
[    0.368317] pnp 00:0d: [mem 0xdfa00000-0xdfa00fff]
[    0.368358] system 00:0d: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.368360] system 00:0d: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.368361] system 00:0d: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.368363] system 00:0d: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.368365] system 00:0d: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.368366] system 00:0d: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.368368] system 00:0d: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.368369] system 00:0d: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.368371] system 00:0d: [mem 0xff000000-0xffffffff] has been reserved
[    0.368372] system 00:0d: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.368374] system 00:0d: [mem 0xdfa00000-0xdfa00fff] has been reserved
[    0.368376] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.368423] pnp 00:0e: [irq 23]
[    0.368454] pnp 00:0e: Plug and Play ACPI device, IDs SMO8810 (active)
[    0.368566] pnp 00:0f: [mem 0x20000000-0x201fffff]
[    0.368567] pnp 00:0f: [mem 0x40004000-0x40004fff]
[    0.368608] system 00:0f: [mem 0x20000000-0x201fffff] has been reserved
[    0.368609] system 00:0f: [mem 0x40004000-0x40004fff] has been reserved
[    0.368611] system 00:0f: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.370674] pnp: PnP ACPI: found 16 devices
[    0.370676] ACPI: ACPI bus type pnp unregistered
[    0.376934] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.376955] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.376962] pci 0000:00:1c.1:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.376974] pci 0000:00:1c.2: PCI bridge to [bus 03-06]
[    0.376976] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    0.376983] pci 0000:00:1c.2:   bridge window [mem 0xf7200000-0xf7bfffff]
[    0.376987] pci 0000:00:1c.2:   bridge window [mem 0xf0a00000-0xf13fffff 64bit pref]
[    0.376995] pci 0000:00:1c.3: PCI bridge to [bus 07-0a]
[    0.376999] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.377005] pci 0000:00:1c.3:   bridge window [mem 0xf6800000-0xf71fffff]
[    0.377009] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf09fffff 64bit pref]
[    0.377017] pci 0000:00:1c.5: PCI bridge to [bus 0b-0b]
[    0.377024] pci 0000:00:1c.5:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.377083] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.377085] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.377086] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.377088] pci_bus 0000:00: resource 7 [mem 0x000dc000-0x000dffff]
[    0.377089] pci_bus 0000:00: resource 8 [mem 0x000e0000-0x000e3fff]
[    0.377090] pci_bus 0000:00: resource 9 [mem 0x000e4000-0x000e7fff]
[    0.377092] pci_bus 0000:00: resource 10 [mem 0xdfa00000-0xfeafffff]
[    0.377093] pci_bus 0000:02: resource 1 [mem 0xf7d00000-0xf7dfffff]
[    0.377095] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.377096] pci_bus 0000:03: resource 1 [mem 0xf7200000-0xf7bfffff]
[    0.377098] pci_bus 0000:03: resource 2 [mem 0xf0a00000-0xf13fffff 64bit pref]
[    0.377099] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.377100] pci_bus 0000:07: resource 1 [mem 0xf6800000-0xf71fffff]
[    0.377102] pci_bus 0000:07: resource 2 [mem 0xf0000000-0xf09fffff 64bit pref]
[    0.377103] pci_bus 0000:0b: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    0.377126] NET: Registered protocol family 2
[    0.377252] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.377809] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.378767] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.378876] TCP: Hash tables configured (established 524288 bind 65536)
[    0.378878] TCP: reno registered
[    0.378887] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.378910] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.378973] NET: Registered protocol family 1
[    0.378983] pci 0000:00:02.0: Boot video device
[    0.412751] PCI: CLS 64 bytes, default 64
[    0.412785] Unpacking initramfs...
[    0.464186] Freeing initrd memory: 3356k freed
[    0.464538] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.464541] software IO TLB [mem 0xd5a3e000-0xd9a3dfff] (64MB) mapped at [ffff8800d5a3e000-ffff8800d9a3dfff]
[    0.464940] audit: initializing netlink socket (disabled)
[    0.464951] type=2000 audit(1349169074.326:1): initialized
[    0.475224] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.476644] VFS: Disk quotas dquot_6.5.2
[    0.476677] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.476747] msgmni has been set to 15741
[    0.476899] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.476928] io scheduler noop registered
[    0.476930] io scheduler deadline registered
[    0.476965] io scheduler cfq registered (default)
[    0.477398] vesafb: mode is 1600x900x32, linelength=6400, pages=0
[    0.477399] vesafb: scrolling: redraw
[    0.477400] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.478034] vesafb: framebuffer at 0xe0000000, mapped to 0xffffc90005800000, using 5632k, total 5632k
[    0.566775] Console: switching to colour frame buffer device 200x56
[    0.655252] fb0: VESA VGA frame buffer device
[    0.655259] intel_idle: does not run on family 6 model 58
[    0.655281] GHES: HEST is not enabled!
[    0.655328] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.676018] 0000:00:16.3: ttyS0 at I/O 0xf0e0 (irq = 19) is a 16550A
[    0.676236] Linux agpgart interface v0.103
[    0.676293] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.676621] i8042: Warning: Keylock active
[    0.679255] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.679276] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.679363] mousedev: PS/2 mouse device common for all mice
[    0.679404] rtc_cmos 00:06: RTC can wake from S4
[    0.679538] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    0.679574] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.679580] cpuidle: using governor ladder
[    0.679581] cpuidle: using governor menu
[    0.679661] drop_monitor: Initializing network drop monitor service
[    0.679724] TCP: cubic registered
[    0.679791] NET: Registered protocol family 10
[    0.679915] NET: Registered protocol family 17
[    0.679937] Key type dns_resolver registered
[    0.680031] PM: Hibernation image not present or could not be loaded.
[    0.680038] registered taskstats version 1
[    0.680708] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.681067] rtc_cmos 00:06: setting system clock to 2012-10-02 09:11:15 UTC (1349169075)
[    0.682058] Freeing unused kernel memory: 760k freed
[    0.682129] Write protecting the kernel read-only data: 8192k
[    0.685801] Freeing unused kernel memory: 1488k freed
[    0.687274] Freeing unused kernel memory: 612k freed
[    0.692657] systemd-udevd[48]: starting version 189
[    0.694551] [drm] Initialized drm 1.1.0 20060810
[    0.695129] agpgart-intel 0000:00:00.0: Intel Ivybridge Chipset
[    0.695216] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    0.696104] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    0.696211] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[    0.696586] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[    0.697097] ACPI: Lid Switch [LID0]
[    0.697153] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    0.697157] ACPI: Power Button [PBTN]
[    0.697203] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[    0.697206] ACPI: Sleep Button [SBTN]
[    0.697253] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    0.697256] ACPI: Power Button [PWRF]
[    0.700075] checking generic (e0000000 580000) vs hw (e0000000 10000000)
[    0.700077] fb: conflicting fb hw usage inteldrmfb vs VESA VGA - removing generic driver
[    0.700088] Console: switching to colour dummy device 80x25
[    0.700163] i915 0000:00:02.0: setting latency timer to 64
[    0.733310] i915 0000:00:02.0: irq 42 for MSI/MSI-X
[    0.733322] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    0.733323] [drm] Driver supports precise vblank timestamp query.
[    0.733749] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.229254] [drm] Enabling RC6 states: RC6 on, RC6p on, RC6pp off
[    1.465579] Refined TSC clocksource calibration: 2591.573 MHz.
[    1.465584] Switching to clocksource tsc
[    1.695106] fbcon: inteldrmfb (fb0) is primary device
[    2.025292] Console: switching to colour frame buffer device 200x56
[    2.028879] fb0: inteldrmfb frame buffer device
[    2.028880] drm: registered panic notifier
[    2.092661] acpi device:4c: registered as cooling_device0
[    2.135653] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[    2.135693] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    2.135713] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    2.162930] ACPI: bus type usb registered
[    2.163280] usbcore: registered new interface driver usbfs
[    2.163290] usbcore: registered new interface driver hub
[    2.163428] usbcore: registered new device driver usb
[    2.163849] xhci_hcd 0000:00:14.0: setting latency timer to 64
[    2.163853] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.163858] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.163949] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.163963] xhci_hcd 0000:00:14.0: irq 16, io mem 0xf7e20000
[    2.164014] xhci_hcd 0000:00:14.0: irq 43 for MSI/MSI-X
[    2.164134] xHCI xhci_add_endpoint called for root hub
[    2.164136] xHCI xhci_check_bandwidth called for root hub
[    2.164156] hub 1-0:1.0: USB hub found
[    2.164166] hub 1-0:1.0: 4 ports detected
[    2.164220] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.164224] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.164297] xHCI xhci_add_endpoint called for root hub
[    2.164298] xHCI xhci_check_bandwidth called for root hub
[    2.164326] hub 2-0:1.0: USB hub found
[    2.164335] hub 2-0:1.0: 4 ports detected
[    2.164715] SCSI subsystem initialized
[    2.166365] libata version 3.00 loaded.
[    2.169265] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.172134] ahci 0000:00:1f.2: version 3.0
[    2.172216] ahci 0000:00:1f.2: irq 44 for MSI/MSI-X
[    2.172247] ahci: SSS flag set, parallel bus scan disabled
[    2.185367] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x31 impl RAID mode
[    2.185374] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part ems sxs apst 
[    2.185394] ahci 0000:00:1f.2: setting latency timer to 64
[    2.199082] scsi0 : ahci
[    2.199146] scsi1 : ahci
[    2.199194] scsi2 : ahci
[    2.199239] scsi3 : ahci
[    2.199284] scsi4 : ahci
[    2.199328] scsi5 : ahci
[    2.199555] ata1: SATA max UDMA/133 abar m2048@0xf7e36000 port 0xf7e36100 irq 44
[    2.199557] ata2: DUMMY
[    2.199558] ata3: DUMMY
[    2.199558] ata4: DUMMY
[    2.199562] ata5: SATA max UDMA/133 abar m2048@0xf7e36000 port 0xf7e36300 irq 44
[    2.199565] ata6: SATA max UDMA/133 abar m2048@0xf7e36000 port 0xf7e36380 irq 44
[    2.199646] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.199650] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    2.199657] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.199686] ehci_hcd 0000:00:1a.0: debug port 2
[    2.203577] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    2.203587] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf7e38000
[    2.212002] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.212160] hub 3-0:1.0: USB hub found
[    2.212166] hub 3-0:1.0: 3 ports detected
[    2.212245] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    2.212248] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    2.212252] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    2.212272] ehci_hcd 0000:00:1d.0: debug port 2
[    2.216144] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    2.216155] ehci_hcd 0000:00:1d.0: irq 21, io mem 0xf7e37000
[    2.225332] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.225470] hub 4-0:1.0: USB hub found
[    2.225474] hub 4-0:1.0: 3 ports detected
[    2.368653] usb 2-4: new SuperSpeed USB device number 2 using xhci_hcd
[    2.383876] hub 2-4:1.0: USB hub found
[    2.383914] hub 2-4:1.0: 3 ports detected
[    2.518578] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.518981] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    2.518987] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    2.518990] ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    2.519046] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.519209] ata1.00: ATA-8: LITEONIT LCT-128M3S, VQDC, max UDMA/133
[    2.519212] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.519613] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    2.519617] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    2.519621] ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    2.519678] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.519834] ata1.00: configured for UDMA/133
[    2.525354] scsi 0:0:0:0: Direct-Access     ATA      LITEONIT LCT-128 VQDC PQ: 0 ANSI: 5
[    2.541909] usb 1-4: new high-speed USB device number 2 using xhci_hcd
[    2.555630] hub 1-4:1.0: USB hub found
[    2.555653] hub 1-4:1.0: 3 ports detected
[    2.661858] usb 3-1: new high-speed USB device number 2 using ehci_hcd
[    2.785873] hub 3-1:1.0: USB hub found
[    2.785944] hub 3-1:1.0: 6 ports detected
[    2.845142] ata5: SATA link down (SStatus 0 SControl 300)
[    2.891786] usb 4-1: new high-speed USB device number 2 using ehci_hcd
[    3.015634] hub 4-1:1.0: USB hub found
[    3.015738] hub 4-1:1.0: 8 ports detected
[    3.095074] usb 1-4.1: new high-speed USB device number 3 using xhci_hcd
[    3.108741] hub 1-4.1:1.0: USB hub found
[    3.108807] hub 1-4.1:1.0: 4 ports detected
[    3.165036] ata6: SATA link down (SStatus 0 SControl 300)
[    3.168964] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    3.169023] sd 0:0:0:0: [sda] Write Protect is off
[    3.169026] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.169046] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.175211] usb 3-1.4: new full-speed USB device number 3 using ehci_hcd
[    3.211621]  sda: sda1 sda2
[    3.211877] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.252554] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    3.328398] usb 3-1.5: new high-speed USB device number 4 using ehci_hcd
[    3.349685] systemd-udevd[146]: starting version 193
[    3.373992] i8k: unable to get SMM BIOS version
[    3.386270] Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
[    3.412414] ACPI: Requesting acpi_cpufreq
[    3.422513] Monitor-Mwait will be used to enter C-1 state
[    3.422545] Monitor-Mwait will be used to enter C-2 state
[    3.422567] Monitor-Mwait will be used to enter C-3 state
[    3.422620] ACPI: acpi_idle registered with cpuidle
[    3.456691] e1000e: Intel(R) PRO/1000 Network Driver - 2.0.0-k
[    3.456693] e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
[    3.458931] e1000e 0000:00:19.0: setting latency timer to 64
[    3.458992] e1000e 0000:00:19.0: (unregistered net_device): Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.459025] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[    3.499489] Bluetooth: Core ver 2.16
[    3.499509] NET: Registered protocol family 31
[    3.499511] Bluetooth: HCI device and connection manager initialized
[    3.499513] Bluetooth: HCI socket layer initialized
[    3.499514] Bluetooth: L2CAP socket layer initialized
[    3.499518] Bluetooth: SCO socket layer initialized
[    3.505429] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    3.505438] thermal LNXTHERM:00: registered as thermal_zone0
[    3.505440] ACPI: Thermal Zone [THM] (49 C)
[    3.506201] usbcore: registered new interface driver btusb
[    3.534717] Linux media interface: v0.10
[    3.578326] usb 3-1.6: new full-speed USB device number 5 using ehci_hcd
[    3.594968] psmouse serio1: alps: E6 report: 00 00 64
[    3.614441] psmouse serio1: alps: E7 report: 73 03 0a
[    3.652717] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1) d4:be:d9:4c:60:97
[    3.652721] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    3.652764] e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: A011FF-0FF
[    3.652810] ACPI Warning: 0x000000000000f040-0x000000000000f05f SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1 (20120320/utaddress-251)
[    3.652815] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    3.741688] usb 4-1.6: new high-speed USB device number 3 using ehci_hcd
[    3.869047] cdc_wdm 4-1.6:1.5: cdc-wdm0: USB WDM device
[    3.869622] cdc_wdm 4-1.6:1.8: cdc-wdm1: USB WDM device
[    3.869643] usbcore: registered new interface driver cdc_wdm
[    3.869788] cdc_acm 4-1.6:1.1: ttyACM0: USB ACM device
[    3.870491] cdc_acm 4-1.6:1.3: ttyACM1: USB ACM device
[    3.878457] cdc_acm 4-1.6:1.9: ttyACM2: USB ACM device
[    3.886481] usbcore: registered new interface driver cdc_acm
[    3.886487] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    3.928401] usb 4-1.8: new high-speed USB device number 4 using ehci_hcd
[    4.012285] hub 4-1.8:1.0: USB hub found
[    4.012423] hub 4-1.8:1.0: 3 ports detected
[    4.063919] psmouse serio1: alps: E6 report: 00 00 64
[    4.082678] psmouse serio1: alps: E7 report: 73 03 0a
[    4.091536] usb 1-4.1.1: new low-speed USB device number 4 using xhci_hcd
[    4.118533] usb 1-4.1.1: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    4.118538] usb 1-4.1.1: ep 0x82 - rounding interval to 64 microframes, ep desc says 80 microframes
[    4.185340] usbcore: registered new interface driver usbhid
[    4.185343] usbhid: USB HID core driver
[    4.198182] usb 1-4.1.2: new low-speed USB device number 5 using xhci_hcd
[    4.216116] usb 1-4.1.2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    4.223389] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1.2/1-4.1.2:1.0/input/input6
[    4.223597] hid-generic 0003:04B3:310C.0003: input,hidraw0: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-4.1.2/input0
[    4.298134] usb 1-4.1.3: new full-speed USB device number 6 using xhci_hcd
[    4.327321] usblp 1-4.1.3:1.0: usblp2: USB Bidirectional printer dev 6 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0027
[    4.327347] usbcore: registered new interface driver usblp
[    4.444865] ACPI: AC Adapter [AC] (on-line)
[    5.104254] ACPI: Battery Slot [BAT0] (battery present)
[    5.109424] ACPI: Battery Slot [BAT1] (battery absent)
[    5.109754] wmi: Mapper loaded
[    5.154846] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1.1/1-4.1.1:1.0/input/input7
[    5.154863] parport_pc 00:0c: [io  0x0378-0x037b]
[    5.155048] parport_pc 00:0c: [irq 5]
[    5.155925] cherry 0003:046A:0023.0001: input,hidraw1: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:14.0-4.1.1/input0
[    5.157003] Linux video capture interface: v2.00
[    5.158010] input: HID 046a:0023 as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1.1/1-4.1.1:1.1/input/input8
[    5.158121] cherry 0003:046A:0023.0002: input,hidraw2: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:14.0-4.1.1/input1
[    5.158329] sdhci: Secure Digital Host Controller Interface driver
[    5.158331] sdhci: Copyright(c) Pierre Ossman
[    5.159383] sdhci-pci 0000:0b:00.0: SDHCI controller found [1217:8221] (rev 5)
[    5.159799] cfg80211: Calling CRDA to update world regulatory domain
[    5.164060] uvcvideo: Found UVC 1.00 device Laptop_Integrated_Webcam_E4HD (0c45:6449)
[    5.164548] microcode: CPU0 sig=0x306a9, pf=0x10, revision=0x12
[    5.170567] usb 4-1.6: MAC-Address: 02:15:e0:ec:01:00
[    5.170729] cdc_ncm 4-1.6:1.6: usb0: register 'cdc_ncm' at usb-0000:00:1d.0-1.6, CDC NCM, 02:15:e0:ec:01:00
[    5.170759] usbcore: registered new interface driver cdc_ncm
[    5.171098] ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts with Region \PMIO 1 (20120320/utaddress-251)
[    5.171108] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.171120] ACPI Warning: 0x0000000000000500-0x000000000000053f SystemIO conflicts with Region \GPIO 1 (20120320/utaddress-251)
[    5.171126] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.171127] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    5.171275] sdhci-pci 0000:0b:00.0: Invalid iomem size. You may experience problems.
[    5.171400] Registered led device: mmc0::
[    5.177059] iwlwifi: Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
[    5.177062] iwlwifi: Copyright(c) 2003-2012 Intel Corporation
[    5.181346] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
[    5.181451] iwlwifi 0000:02:00.0: pci_resource_len = 0x00002000
[    5.181453] iwlwifi 0000:02:00.0: pci_resource_base = ffffc900057a4000
[    5.181455] iwlwifi 0000:02:00.0: HW Revision ID = 0x35
[    5.181701] iwlwifi 0000:02:00.0: irq 47 for MSI/MSI-X
[    5.186398] parport_pc 00:0c: activated
[    5.186406] parport_pc 00:0c: reported by Plug and Play ACPI
[    5.186491] parport_pc 00:0c: disabled
[    5.189591] input: Laptop_Integrated_Webcam_E4HD as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.5/3-1.5:1.0/input/input9
[    5.189803] usbcore: registered new interface driver uvcvideo
[    5.189805] USB Video Class driver (1.1.1)
[    5.197781] mmc0: SDHCI controller on PCI [0000:0b:00.0] using DMA
[    5.257033] input: DualPoint Stick as /devices/platform/i8042/serio1/input/input10
[    5.273433] input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input11
[    5.491474] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[    5.564278] microcode: CPU1 sig=0x306a9, pf=0x10, revision=0x12
[    5.565406] ppdev: user-space parallel port driver
[    5.565524] microcode: CPU2 sig=0x306a9, pf=0x10, revision=0x12
[    5.565574] iTCO_vendor_support: vendor-support=0
[    5.565693] input: Dell WMI hotkeys as /devices/virtual/input/input12
[    5.565997] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
[    5.566036] iTCO_wdt: Found a Panther Point TCO device (Version=2, TCOBASE=0x0460)
[    5.566456] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    5.567252] microcode: CPU3 sig=0x306a9, pf=0x10, revision=0x12
[    5.568966] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    5.570538] iwlwifi 0000:02:00.0: loaded firmware version 9.221.4.1 build 25532
[    5.570664] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUG disabled
[    5.570667] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[    5.570668] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TRACING enabled
[    5.570670] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE enabled
[    5.570672] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_P2P disabled
[    5.570674] iwlwifi 0000:02:00.0: Detected Intel(R) Centrino(R) Ultimate-N 6300 AGN, REV=0x74
[    5.570774] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[    5.587959] iwlwifi 0000:02:00.0: device EEPROM VER=0x43a, CALIB=0x6
[    5.587960] iwlwifi 0000:02:00.0: Device SKU: 0x1F0
[    5.587961] iwlwifi 0000:02:00.0: Valid Tx ant: 0x7, Valid Rx ant: 0x7
[    5.587972] iwlwifi 0000:02:00.0: Tunable channels: 13 802.11bg, 24 802.11a channels
[    5.588159] Registered led device: phy0-led
[    5.590537] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[    5.747379] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input13
[    5.763725] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[    5.763912] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[    5.764057] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[    5.764225] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[    5.764354] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[    5.764490] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input19
[    5.764623] input: HDA Intel PCH Dock Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input20
[    7.599123] EXT4-fs (sda2): re-mounted. Opts: data=ordered
[    8.092559] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    8.097830] Bluetooth: RFCOMM TTY layer initialized
[    8.097836] Bluetooth: RFCOMM socket layer initialized
[    8.097837] Bluetooth: RFCOMM ver 1.11
[    8.207089] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[    8.310236] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[    8.311484] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    8.315794] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[    8.322346] iwlwifi 0000:02:00.0: Radio type=0x0-0x3-0x1
[    8.559212] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[    8.565756] iwlwifi 0000:02:00.0: Radio type=0x0-0x3-0x1
[    8.678960] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    8.685623] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[    8.694304] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[    9.869282] fuse init (API version 7.19)
[   10.475871] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no TDs queued?
[   12.522659] EXT4-fs (sda2): re-mounted. Opts: data=ordered,commit=0
[   15.259007] wlan0: authenticate with 80:c6:ab:2c:76:3a
[   15.321888] wlan0: send auth to 80:c6:ab:2c:76:3a (try 1/3)
[   15.323906] wlan0: authenticated
[   15.324072] wlan0: waiting for beacon from 80:c6:ab:2c:76:3a
[   15.354485] wlan0: associate with 80:c6:ab:2c:76:3a (try 1/3)
[   15.357953] wlan0: RX AssocResp from 80:c6:ab:2c:76:3a (capab=0x411 status=0 aid=2)
[   15.361155] wlan0: associated
[   15.362257] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

--------------040300040706040101080609--
