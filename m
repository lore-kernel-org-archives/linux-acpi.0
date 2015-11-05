From: Ben Gardner <gardner.ben@gmail.com>
Subject: BayTrial: 137 sec delay on boot - power button resumes
Date: Thu, 5 Nov 2015 11:06:17 -0600
Message-ID: <CAE7DoPYi=GJknqTYG34v9H0gS8pp_TgNxTbr6Mi5PikTYmHHvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35965 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030549AbbKERGS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2015 12:06:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi all,

I have an BayTrail-I E3845 SoC that will occasionally (~5%) pause for
137 seconds on cold boot.

The first log after it continues is this one:
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x372ab6ee016,
max_idle_ns: 881590685180 ns

The typical logs before the hang are below.
This is with Linux 4.2.4, x86_64.

There are two data points that I think are relevant to this problem.

1) If I press the power button while it is in this "hung" state, it immediately
resumes booting.  The power button is configured to generate an ACPI interrupt.

2) If I turn up logging to the console by adding "debug" to the kernel command
line, this hang does not occur.

3) HPET is (incorrectly?) disabled in early-quirks.c for this CPU due
to S0ix issues.
This CPU (Bay Trail-I) does not support S0ix.

It sounds to me like some sort of race condition that leads to a dropped
interrupt.

I haven't yet tracked down where it is stuck waiting, but I suspect some
sort of clock calibration loop using the ACPI timer.

Any ideas where I should start looking?

I'm hoping the "137 seconds" will be an obvious clue to someone.

Thanks,
Ben

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.2.4cpu1900
(bgardner@wcrdsk1072.wcr.wabtec.com) (gcc version 4.8.4 (Buildroot
2015.05-dirty) ) #21 SMP PREEMPT Tue Oct 27 15:11:05 CDT 2015
[    0.000000] Command line: root=/dev/sda1 ro,noatime console=tty
console=ttyS0,115200 loglevel=6
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ad8dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ad8e000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed05000-0x00000000fed05fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed0c000-0x00000000fed0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Wabtec CPU-1903-W/CPU-1903-W, BIOS BNG 10/30/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x180000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-back
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FF800000 mask FFF800000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 07B000000 mask FFF000000 uncachable
[    0.000000]   3 base 07C000000 mask FFC000000 uncachable
[    0.000000]   4 base 100000000 mask F80000000 write-back
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT
[    0.000000] e820: last_pfn = 0x7ad8e max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x00bd9000, 0x00bd9fff] PGTABLE
[    0.000000] BRK [0x00bda000, 0x00bdafff] PGTABLE
[    0.000000] BRK [0x00bdb000, 0x00bdbfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x17fe00000-0x17fffffff]
[    0.000000]  [mem 0x17fe00000-0x17fffffff] page 2M
[    0.000000] BRK [0x00bdc000, 0x00bdcfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x160000000-0x17fdfffff]
[    0.000000]  [mem 0x160000000-0x17fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x7ad8dfff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x7abfffff] page 2M
[    0.000000]  [mem 0x7ac00000-0x7ad8dfff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x15fffffff]
[    0.000000]  [mem 0x100000000-0x15fffffff] page 2M
[    0.000000] BRK [0x00bdd000, 0x00bddfff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6F90 000024 (v02 CORE  )
[    0.000000] ACPI: XSDT 0x000000007ADB80E0 000054 (v01 CORE
COREBOOT 00000000 CORE 00000000)
[    0.000000] ACPI: FACP 0x000000007ADBB1B0 0000F4 (v04 CORE
COREBOOT 00000000 CORE 00000001)
[    0.000000] ACPI: DSDT 0x000000007ADB8280 002F24 (v02 COREv4
COREBOOT 20110725 INTL 20150619)
[    0.000000] ACPI: FACS 0x000000007ADB8240 000040
[    0.000000] ACPI: FACS 0x000000007ADB8240 000040
[    0.000000] ACPI: SSDT 0x000000007ADBB2B0 000E64 (v02 CORE
COREBOOT 0000002A CORE 0000002A)
[    0.000000] ACPI: MCFG 0x000000007ADBC120 00003C (v01 CORE
COREBOOT 00000000 CORE 00000000)
[    0.000000] ACPI: TCPA 0x000000007ADBC160 000032 (v02 CORE
COREBOOT 00000000 CORE 00000000)
[    0.000000] ACPI: APIC 0x000000007ADBC1A0 00006C (v01 CORE
COREBOOT 00000000 CORE 00000000)
[    0.000000] ACPI: HPET 0x000000007ADBC210 000038 (v01 CORE
COREBOOT 00000000 CORE 00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea00053fffff] PMD ->
[ffff88017b600000-ffff88017edfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007ad8dfff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000017fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000017fffffff]
[    0.000000] On node 0 totalpages: 1027372
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 2548 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6824 pages used for memmap
[    0.000000]   DMA32 zone: 499086 pages, LIFO batch:31
[    0.000000]   Normal zone: 7168 pages used for memmap
[    0.000000]   Normal zone: 524288 pages, LIFO batch:31
[    0.000000] x86/hpet: Will disable the HPET for this platform
because it's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x7c000000-0x7fffffff
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x80000000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4
nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff88017fc00000 s83608
r8192 d31080 u524288
[    0.000000] pcpu-alloc: s83608 r8192 d31080 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 1010776
[    0.000000] Kernel command line: root=/dev/sda1 ro,noatime
console=tty console=ttyS0,115200 loglevel=6
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Memory: 3969164K/4109488K available (4899K kernel code,
451K rwdata, 1596K rodata, 784K init, 628K bss, 140324K reserved, 0K
cma-reserved)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] Additional per-CPU info printed with stalls.
[    0.000000] Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:1024 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x17
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1913600 KHz
[    0.000000] lapic_timer_frequency = 83200
[    0.000000] tsc: Detected 1913.600 MHz processor
[    0.000038] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3827.20 BogoMIPS (lpj=1913600)
[    0.000044] pid_max: default: 32768 minimum: 301
[    0.000062] ACPI: Core revision 20150619
[    0.007585] ACPI: All ACPI Tables successfully acquired
[    0.013647] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.013653] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.013973] Initializing cgroup subsys blkio
[    0.013995] Initializing cgroup subsys devices
[    0.014002] Initializing cgroup subsys freezer
[    0.014010] Initializing cgroup subsys net_cls
[    0.014015] Initializing cgroup subsys perf_event
[    0.014059] CPU: Physical Processor ID: 0
[    0.014062] CPU: Processor Core ID: 0
[    0.014068] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.020852] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.033619] mce: CPU supports 6 MCE banks
[    0.033630] CPU0: Thermal monitoring enabled (TM1)
[    0.033635] process: using mwait in idle threads
[    0.033641] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.033644] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.034012] Freeing SMP alternatives memory: 20K (ffffffff80b36000
- ffffffff80b3b000)
[    0.035820] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.045843] TSC deadline timer enabled
[    0.045848] smpboot: CPU0: Intel(R) Atom(TM) CPU  E3845  @ 1.91GHz
(fam: 06, model: 37, stepping: 09)
[    0.045874] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont
events, full-width counters, Intel PMU driver.
[    0.045891] ... version:                3
[    0.045893] ... bit width:              40
[    0.045896] ... generic registers:      2
[    0.045899] ... value mask:             000000ffffffffff
[    0.045901] ... max period:             000000ffffffffff
[    0.045903] ... fixed-purpose events:   3
[    0.045906] ... event mask:             0000000700000003
[    0.049015] x86: Booting SMP configuration:
[    0.049020] .... node  #0, CPUs:      #1 #2 #3
[    0.074869] x86: Booted up 1 node, 4 CPUs
[    0.074876] smpboot: Total of 4 processors activated (15308.80 BogoMIPS)
[    0.075666] devtmpfs: initialized
[    0.076203] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.076344] pinctrl core: initialized pinctrl subsystem
[    0.076691] NET: Registered protocol family 16
[    0.081886] cpuidle: using governor ladder
[    0.085901] cpuidle: using governor menu
[    0.085990] ACPI: bus type PCI registered
[    0.086126] PCI: Using configuration type 1 for base access
[    0.093093] ACPI: Added _OSI(Module Device)
[    0.093099] ACPI: Added _OSI(Processor Device)
[    0.093103] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.093106] ACPI: Added _OSI(Processor Aggregator Device)
[    0.103891] ACPI: Interpreter enabled
[    0.103906] ACPI: (supports S0 S5)
[    0.103911] ACPI: Using IOAPIC for interrupt routing
[    0.104032] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.115477] ACPI: Power Resource [PLPE] (on)
[    0.117188] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.117202] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.117267] acpi PNP0A08:00: _OSC: not requesting OS control; OS
requires [ExtendedConfig ASPM ClockPM MSI]
[    0.117512] PCI host bridge to bus 0000:00
[    0.117519] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.117525] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.117530] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.117534] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.117538] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000c3fff window]
[    0.117543] pci_bus 0000:00: root bus resource [mem
0x000c4000-0x000c7fff window]
[    0.117547] pci_bus 0000:00: root bus resource [mem
0x000c8000-0x000cbfff window]
[    0.117552] pci_bus 0000:00: root bus resource [mem
0x000cc000-0x000cffff window]
[    0.117556] pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000d3fff window]
[    0.117560] pci_bus 0000:00: root bus resource [mem
0x000d4000-0x000d7fff window]
[    0.117565] pci_bus 0000:00: root bus resource [mem
0x000d8000-0x000dbfff window]
[    0.117569] pci_bus 0000:00: root bus resource [mem
0x000dc000-0x000dffff window]
[    0.117573] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000e3fff window]
[    0.117578] pci_bus 0000:00: root bus resource [mem
0x000e4000-0x000e7fff window]
[    0.117582] pci_bus 0000:00: root bus resource [mem
0x000e8000-0x000ebfff window]
[    0.117586] pci_bus 0000:00: root bus resource [mem
0x000ec000-0x000effff window]
[    0.117591] pci_bus 0000:00: root bus resource [mem
0x000f0000-0x000fffff window]
[    0.117595] pci_bus 0000:00: root bus resource [mem
0x7ae00000-0xdfffffff window]
[    0.117599] pci_bus 0000:00: root bus resource [mem
0xfed40000-0xfed44fff window]
[    0.117616] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.117889] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.117912] pci 0000:00:02.0: reg 0x10: [mem 0xd0000000-0xd03fffff]
[    0.117927] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff pref]
[    0.117941] pci 0000:00:02.0: reg 0x20: [io  0x4040-0x4047]
[    0.118234] pci 0000:00:13.0: [8086:0f23] type 00 class 0x010601
[    0.118265] pci 0000:00:13.0: reg 0x10: [io  0x4048-0x404f]
[    0.118278] pci 0000:00:13.0: reg 0x14: [io  0x4058-0x405b]
[    0.118289] pci 0000:00:13.0: reg 0x18: [io  0x4050-0x4057]
[    0.118301] pci 0000:00:13.0: reg 0x1c: [io  0x405c-0x405f]
[    0.118312] pci 0000:00:13.0: reg 0x20: [io  0x4000-0x401f]
[    0.118325] pci 0000:00:13.0: reg 0x24: [mem 0xd072c000-0xd072c7ff]
[    0.118364] pci 0000:00:13.0: PME# supported from D3hot
[    0.118612] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.118643] pci 0000:00:14.0: reg 0x10: [mem 0xd0700000-0xd070ffff 64bit]
[    0.118701] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.118952] pci 0000:00:17.0: [8086:0f50] type 00 class 0x080501
[    0.118980] pci 0000:00:17.0: reg 0x10: [mem 0xd071c000-0xd071cfff]
[    0.118992] pci 0000:00:17.0: reg 0x14: [mem 0xd071d000-0xd071dfff]
[    0.119067] pci 0000:00:17.0: PME# supported from D0 D3hot
[    0.119310] pci 0000:00:18.0: [8086:0f40] type 00 class 0x080102
[    0.119338] pci 0000:00:18.0: reg 0x10: [mem 0xd0710000-0xd0713fff]
[    0.119351] pci 0000:00:18.0: reg 0x14: [mem 0xd071e000-0xd071efff]
[    0.119657] pci 0000:00:18.1: [8086:0f41] type 00 class 0x0c8000
[    0.119685] pci 0000:00:18.1: reg 0x10: [mem 0xd071f000-0xd071ffff]
[    0.119698] pci 0000:00:18.1: reg 0x14: [mem 0xd0720000-0xd0720fff]
[    0.119999] pci 0000:00:18.2: [8086:0f42] type 00 class 0x0c8000
[    0.120038] pci 0000:00:18.2: reg 0x10: [mem 0xd0721000-0xd0721fff]
[    0.120051] pci 0000:00:18.2: reg 0x14: [mem 0xd0722000-0xd0722fff]
[    0.120357] pci 0000:00:18.3: [8086:0f43] type 00 class 0x0c8000
[    0.120385] pci 0000:00:18.3: reg 0x10: [mem 0xd0723000-0xd0723fff]
[    0.120398] pci 0000:00:18.3: reg 0x14: [mem 0xd0724000-0xd0724fff]
[    0.120705] pci 0000:00:1b.0: [8086:0f04] type 00 class 0x040300
[    0.120741] pci 0000:00:1b.0: reg 0x10: [mem 0xd0714000-0xd0717fff 64bit]
[    0.120808] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.121066] pci 0000:00:1c.0: [8086:0f48] type 01 class 0x060400
[    0.121130] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.121382] pci 0000:00:1c.2: [8086:0f4c] type 01 class 0x060400
[    0.121445] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.121698] pci 0000:00:1c.3: [8086:0f4e] type 01 class 0x060400
[    0.121761] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.122020] pci 0000:00:1e.0: [8086:0f06] type 00 class 0x080102
[    0.122058] pci 0000:00:1e.0: reg 0x10: [mem 0xd0718000-0xd071bfff]
[    0.122072] pci 0000:00:1e.0: reg 0x14: [mem 0xd0725000-0xd0725fff]
[    0.122379] pci 0000:00:1e.3: [8086:0f0a] type 00 class 0x078000
[    0.122406] pci 0000:00:1e.3: reg 0x10: [mem 0xd0726000-0xd0726fff]
[    0.122419] pci 0000:00:1e.3: reg 0x14: [mem 0xd0727000-0xd0727fff]
[    0.122724] pci 0000:00:1e.4: [8086:0f0c] type 00 class 0x078000
[    0.122752] pci 0000:00:1e.4: reg 0x10: [mem 0xd0728000-0xd0728fff]
[    0.122765] pci 0000:00:1e.4: reg 0x14: [mem 0xd0729000-0xd0729fff]
[    0.123078] pci 0000:00:1e.5: [8086:0f0e] type 00 class 0x0c8000
[    0.123105] pci 0000:00:1e.5: reg 0x10: [mem 0xd072a000-0xd072afff]
[    0.123118] pci 0000:00:1e.5: reg 0x14: [mem 0xd072b000-0xd072bfff]
[    0.123421] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.123750] pci 0000:00:1f.3: [8086:0f12] type 00 class 0x0c0500
[    0.123801] pci 0000:00:1f.3: reg 0x10: [mem 0xd072c800-0xd072c81f]
[    0.123876] pci 0000:00:1f.3: reg 0x20: [io  0x4020-0x403f]
[    0.124264] pci 0000:01:00.0: [8086:157b] type 00 class 0x020000
[    0.124312] pci 0000:01:00.0: reg 0x10: [mem 0xd0400000-0xd041ffff]
[    0.124343] pci 0000:01:00.0: reg 0x18: [io  0x2000-0x201f]
[    0.124360] pci 0000:01:00.0: reg 0x1c: [mem 0xd0420000-0xd0423fff]
[    0.124450] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.127075] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.127082] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.127088] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd04fffff]
[    0.127176] pci 0000:02:00.0: [168c:002b] type 00 class 0x028000
[    0.127218] pci 0000:02:00.0: reg 0x10: [mem 0xd0500000-0xd050ffff 64bit]
[    0.127310] pci 0000:02:00.0: supports D1
[    0.127315] pci 0000:02:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.130079] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    0.130088] pci 0000:00:1c.2:   bridge window [mem 0xd0500000-0xd05fffff]
[    0.130173] pci 0000:03:00.0: [8086:157b] type 00 class 0x020000
[    0.130221] pci 0000:03:00.0: reg 0x10: [mem 0xd0600000-0xd061ffff]
[    0.130252] pci 0000:03:00.0: reg 0x18: [io  0x3000-0x301f]
[    0.130269] pci 0000:03:00.0: reg 0x1c: [mem 0xd0620000-0xd0623fff]
[    0.130359] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.133095] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    0.133102] pci 0000:00:1c.3:   bridge window [io  0x3000-0x3fff]
[    0.133108] pci 0000:00:1c.3:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.133138] pci_bus 0000:00: on NUMA node 0
[    0.133524] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *4 5 6 7 10 12 14 15)
[    0.133738] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 11 12 14 15)
[    0.133949] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 12 14 15)
[    0.134169] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 11 12 14 15) *10
[    0.134381] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 12 14 15) *11
[    0.134593] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 11 *12 14 15)
[    0.134802] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 12 *14 15)
[    0.135013] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 11 12 14 *15)
[    0.138362] SCSI subsystem initialized
[    0.142725] libata version 3.00 loaded.
[    0.142738] ACPI: bus type USB registered
[    0.142797] usbcore: registered new interface driver usbfs
[    0.142826] usbcore: registered new interface driver hub
[    0.142873] usbcore: registered new device driver usb
[    0.143074] PCI: Using ACPI for IRQ routing
[    0.143080] PCI: pci_cache_line_size set to 64 bytes
[    0.143170] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.151028] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.151033] e820: reserve RAM buffer [mem 0x7ad8e000-0x7bffffff]
[    0.151372] clocksource: Switched to clocksource refined-jiffies
[    0.151567] pnp: PnP ACPI init
[    0.151740] system 00:00: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.151747] system 00:00: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.151752] system 00:00: [mem 0xfed03000-0xfed033ff] has been reserved
[    0.151757] system 00:00: [mem 0xfed08000-0xfed083ff] has been reserved
[    0.151762] system 00:00: [mem 0xfed01000-0xfed013ff] has been reserved
[    0.151767] system 00:00: [mem 0xfef00000-0xfeffffff] has been reserved
[    0.151771] system 00:00: [mem 0xfed05000-0xfed057ff] has been reserved
[    0.151776] system 00:00: [mem 0xfed1c000-0xfed1c3ff] has been reserved
[    0.151783] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.152299] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.152307] system 00:01: Plug and Play ACPI device, IDs PNP0103
PNP0c01 (active)
[    0.152415] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.152472] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.152564] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.153242] pnp: PnP ACPI: found 5 devices
[    0.161411] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.161442] clocksource: Switched to clocksource acpi_pm
[    0.161471] pci 0000:00:1c.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000
add_align 100000
[    0.161483] pci 0000:00:1c.2: bridge window [io  0x1000-0x0fff] to
[bus 02] add_size 1000
[    0.161490] pci 0000:00:1c.2: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000
add_align 100000
[    0.161502] pci 0000:00:1c.3: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000
add_align 100000
[    0.161517] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x000fffff
64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.161522] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x002fffff
64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.161528] pci 0000:00:1c.2: res[9]=[mem 0x00100000-0x000fffff
64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.161533] pci 0000:00:1c.2: res[9]=[mem 0x00100000-0x002fffff
64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.161538] pci 0000:00:1c.3: res[9]=[mem 0x00100000-0x000fffff
64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.161543] pci 0000:00:1c.3: res[9]=[mem 0x00100000-0x002fffff
64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.161549] pci 0000:00:1c.2: res[7]=[io  0x1000-0x0fff]
res_to_dev_res add_size 1000 min_align 1000
[    0.161553] pci 0000:00:1c.2: res[7]=[io  0x1000-0x1fff]
res_to_dev_res add_size 1000 min_align 1000
[    0.161579] pci 0000:00:1c.0: BAR 9: assigned [mem
0x80000000-0x801fffff 64bit pref]
[    0.161600] pci 0000:00:1c.2: BAR 9: assigned [mem
0x80200000-0x803fffff 64bit pref]
[    0.161619] pci 0000:00:1c.3: BAR 9: assigned [mem
0x80400000-0x805fffff 64bit pref]
[    0.161626] pci 0000:00:1c.2: BAR 7: assigned [io  0x5000-0x5fff]
[    0.161633] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.161638] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.161646] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd04fffff]
[    0.161652] pci 0000:00:1c.0:   bridge window [mem
0x80000000-0x801fffff 64bit pref]
[    0.161684] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    0.161690] pci 0000:00:1c.2:   bridge window [io  0x5000-0x5fff]
[    0.161697] pci 0000:00:1c.2:   bridge window [mem 0xd0500000-0xd05fffff]
[    0.161704] pci 0000:00:1c.2:   bridge window [mem
0x80200000-0x803fffff 64bit pref]
[    0.161711] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    0.161716] pci 0000:00:1c.3:   bridge window [io  0x3000-0x3fff]
[    0.161723] pci 0000:00:1c.3:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.161729] pci 0000:00:1c.3:   bridge window [mem
0x80400000-0x805fffff 64bit pref]
[    0.161738] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.161742] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.161747] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.161752] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.161756] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.161761] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.161765] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.161770] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.161774] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.161779] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.161783] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.161788] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    0.161792] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    0.161797] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    0.161801] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    0.161806] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[    0.161810] pci_bus 0000:00: resource 20 [mem 0x7ae00000-0xdfffffff window]
[    0.161815] pci_bus 0000:00: resource 21 [mem 0xfed40000-0xfed44fff window]
[    0.161820] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.161824] pci_bus 0000:01: resource 1 [mem 0xd0400000-0xd04fffff]
[    0.161828] pci_bus 0000:01: resource 2 [mem 0x80000000-0x801fffff
64bit pref]
[    0.161833] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.161837] pci_bus 0000:02: resource 1 [mem 0xd0500000-0xd05fffff]
[    0.161842] pci_bus 0000:02: resource 2 [mem 0x80200000-0x803fffff
64bit pref]
[    0.161846] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.161850] pci_bus 0000:03: resource 1 [mem 0xd0600000-0xd06fffff]
[    0.161855] pci_bus 0000:03: resource 2 [mem 0x80400000-0x805fffff
64bit pref]
[    0.162005] NET: Registered protocol family 2
[    0.162315] TCP established hash table entries: 32768 (order: 6,
262144 bytes)
[    0.162415] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.162625] TCP: Hash tables configured (established 32768 bind 32768)
[    0.162683] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.162718] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.162877] NET: Registered protocol family 1
[    0.162910] pci 0000:00:02.0: Video device with shadowed ROM
[    0.165006] PCI: CLS 64 bytes, default 64
[    0.165126] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.165132] software IO TLB [mem 0x76d8e000-0x7ad8e000] (64MB)
mapped at [ffff880076d8e000-ffff88007ad8dfff]
[    0.166216] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.168500] bounce: pool size: 64 pages
[    0.168548] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 250)
[    0.168638] io scheduler noop registered
[    0.168644] io scheduler deadline registered
[    0.168681] io scheduler cfq registered (default)
[    0.169876] pcieport 0000:00:1c.2: enabling device (0106 -> 0107)
[    0.171948] intel_idle: MWAIT substates: 0x3000020
[    0.171953] intel_idle: v0.4 model 0x37
[    0.171955] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.172353] input: Power Button as
/devices/LNXSYSTM:00/PNP0C0C:00/input/input0
[    0.172361] ACPI: Power Button [PWRB]
[    0.172447] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.172525] ACPI: Power Button [PWRF]
[    0.172692] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.192991] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200)
is a 16550A
[    0.194574] 0000:00:1e.3: ttyS1 at MMIO 0xd0726000 (irq = 20,
base_baud = 2764800) is a 16550A
[    0.195710] 0000:00:1e.4: ttyS2 at MMIO 0xd0728000 (irq = 21,
base_baud = 2764800) is a 16550A
[    0.199619] brd: module loaded
[    0.200677] loop: module loaded
[    0.200944] ahci 0000:00:13.0: version 3.0
[    0.202009] ahci 0000:00:13.0: controller can't do DEVSLP, turning off
[    0.202066] ahci 0000:00:13.0: SSS flag set, parallel bus scan disabled
 -- hangs here --
