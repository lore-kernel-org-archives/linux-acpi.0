From: Tom Gundersen <teg@jklm.no>
Subject: [BUG]: intel_idle: boot stalls without nolapic_timer
Date: Tue, 13 Sep 2011 21:07:39 +0200
Message-ID: <CAG-2HqVGO6tCrMwtAQLUpKjVZqX3_YMGHrkqg6TdfJf0Aofcwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45948 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab1IMTIB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2011 15:08:01 -0400
Received: by qyk7 with SMTP id 7so783372qyk.19
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 12:08:00 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

Hi guys,

For as long as I can remember I have been experiencing problems
similar to the ones described in
<https://bugzilla.kernel.org/show_bug.cgi?id=21032>. The main symptom
is that boot seems to stall, but repeatedly pressing a button nudges
it along.

My processor is an "Intel(R) Atom(TM) CPU N450 @ 1.66GHz stepping 0a",
and I'm on (an virtually unpatched) kernel 3.0.4 at the moment.

It looked like commit "intel_idle: do not use the LAPIC timer for ATOM
C2" should solve my problems, but it did not make a difference. When
the commit was first made I was not able to test patched kernels, as
the laptop was in "production use" by someone else, but now I should
be able to test whatever suggestion or patches you might have.

Some info requested in the original bug report, and dmesg below:

% grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*
/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/time:177487
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:44
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:MWAIT 0x00
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1-ATM
/sys/devices/system/cpu/cpu0/cpuidle/state1/power:4294967294
/sys/devices/system/cpu/cpu0/cpuidle/state1/time:305321378
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage:29189
/sys/devices/system/cpu/cpu0/cpuidle/state2/desc:MWAIT 0x10
/sys/devices/system/cpu/cpu0/cpuidle/state2/latency:20
/sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2-ATM
/sys/devices/system/cpu/cpu0/cpuidle/state2/power:4294967293
/sys/devices/system/cpu/cpu0/cpuidle/state2/time:253358440
/sys/devices/system/cpu/cpu0/cpuidle/state2/usage:99688
/sys/devices/system/cpu/cpu0/cpuidle/state3/desc:MWAIT 0x30
/sys/devices/system/cpu/cpu0/cpuidle/state3/latency:100
/sys/devices/system/cpu/cpu0/cpuidle/state3/name:C4-ATM
/sys/devices/system/cpu/cpu0/cpuidle/state3/power:4294967292
/sys/devices/system/cpu/cpu0/cpuidle/state3/time:472168388
/sys/devices/system/cpu/cpu0/cpuidle/state3/usage:548130
/sys/devices/system/cpu/cpu1/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
/sys/devices/system/cpu/cpu1/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu1/cpuidle/state0/name:POLL
/sys/devices/system/cpu/cpu1/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu1/cpuidle/state0/time:301569
/sys/devices/system/cpu/cpu1/cpuidle/state0/usage:40
/sys/devices/system/cpu/cpu1/cpuidle/state1/desc:MWAIT 0x00
/sys/devices/system/cpu/cpu1/cpuidle/state1/latency:1
/sys/devices/system/cpu/cpu1/cpuidle/state1/name:C1-ATM
/sys/devices/system/cpu/cpu1/cpuidle/state1/power:4294967294
/sys/devices/system/cpu/cpu1/cpuidle/state1/time:287629871
/sys/devices/system/cpu/cpu1/cpuidle/state1/usage:29895
/sys/devices/system/cpu/cpu1/cpuidle/state2/desc:MWAIT 0x10
/sys/devices/system/cpu/cpu1/cpuidle/state2/latency:20
/sys/devices/system/cpu/cpu1/cpuidle/state2/name:C2-ATM
/sys/devices/system/cpu/cpu1/cpuidle/state2/power:4294967293
/sys/devices/system/cpu/cpu1/cpuidle/state2/time:299063253
/sys/devices/system/cpu/cpu1/cpuidle/state2/usage:98597
/sys/devices/system/cpu/cpu1/cpuidle/state3/desc:MWAIT 0x30
/sys/devices/system/cpu/cpu1/cpuidle/state3/latency:100
/sys/devices/system/cpu/cpu1/cpuidle/state3/name:C4-ATM
/sys/devices/system/cpu/cpu1/cpuidle/state3/power:4294967292
/sys/devices/system/cpu/cpu1/cpuidle/state3/time:444689442
/sys/devices/system/cpu/cpu1/cpuidle/state3/usage:545674


[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0-ARCH (tobias@T-POWA-LX) (gcc version
4.6.1 20110819 (prerelease) (GCC) ) #1 SMP PREEMPT Tue Aug 30 08:53:25
CEST 2011
[    0.000000] Command line: root=/dev/sda3 ro init=/bin/systemd
initrd=../initramfs-linux.img BOOT_IMAGE=../vmlinuz-linux
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f5d0000 (usable)
[    0.000000]  BIOS-e820: 000000003f5d0000 - 000000003f5e0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003f5e0000 - 000000003f5e3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003f5e3000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] DMI: TOSHIBA TOSHIBA NB305/NPVAA, BIOS V1.40 03/16/2010
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000
(usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x3f5d0 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask 0C0000000 write-back
[    0.000000]   1 base 03F600000 mask 0FFE00000 uncachable
[    0.000000]   2 base 03F800000 mask 0FF800000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] found SMP MP-table at [ffff8800000f7da0] f7da0
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-000000003f5d0000
[    0.000000]  0000000000 - 003f400000 page 2M
[    0.000000]  003f400000 - 003f5d0000 page 4k
[    0.000000] kernel direct mapping tables up to 3f5d0000 @ 3f458000-3f45b000
[    0.000000] RAMDISK: 3f45b000 - 3f5cf000
[    0.000000] ACPI: RSDP 00000000000f7d00 00024 (v02 TOSCPL)
[    0.000000] ACPI: XSDT 000000003f5d4f25 00074 (v01 TOSCPL TOSCPL00
06040000  LTP 00000000)
[    0.000000] ACPI: FACP 000000003f5dfc60 000F4 (v03 TOSCPL TOSCPL00
06040000 PTL  00000002)
[    0.000000] ACPI: DSDT 000000003f5d60bb 09B31 (v01 TOSCPL TOSCPL00
06040000 MSFT 03000000)
[    0.000000] ACPI: FACS 000000003f5e2fc0 00040
[    0.000000] ACPI: TCPA 000000003f5dfd54 00032 (v01 Phoeni  x
06040000  TL  00000000)
[    0.000000] ACPI: HPET 000000003f5dfd86 00038 (v01 DELL   M09
06040000 LOHR 0000005A)
[    0.000000] ACPI: MCFG 000000003f5dfdbe 0003C (v01 INTEL  CRESTLNE
06040000 LOHR 0000005A)
[    0.000000] ACPI: SLIC 000000003f5dfdfa 00176 (v01 TOSCPL TOSCPL00
06040000 LOHR 00000000)
[    0.000000] ACPI: APIC 000000003f5dff70 00068 (v01 TOSCPL TOSCPL00
06040000  LTP 00000000)
[    0.000000] ACPI: BOOT 000000003f5dffd8 00028 (v01 TOSCPL TOSCPL00
06040000  LTP 00000001)
[    0.000000] ACPI: SSDT 000000003f5d551b 0025F (v01  PmRef  Cpu0Tst
00003000 INTL 20050624)
[    0.000000] ACPI: SSDT 000000003f5d5475 000A6 (v01  PmRef  Cpu1Tst
00003000 INTL 20050624)
[    0.000000] ACPI: SSDT 000000003f5d4f99 004DC (v02  PmRef    CpuPm
00003000 INTL 20050624)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000003f5d0000
[    0.000000] Initmem setup node 0 0000000000000000-000000003f5d0000
[    0.000000]   NODE_DATA [000000003f453000 - 000000003f457fff]
[    0.000000]  [ffffea0000000000-ffffea0000dfffff] PMD ->
[ffff88003dc00000-ffff88003e9fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x0003f5d0
[    0.000000] On node 0 totalpages: 259421
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3493 pages used for memmap
[    0.000000]   DMA32 zone: 251947 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 40000000 (gap:
40000000:a0000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64
nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88003f200000 s78464
r8192 d23936 u1048576
[    0.000000] pcpu-alloc: s78464 r8192 d23936 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 255867
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/sda3 ro
init=/bin/systemd initrd=../initramfs-linux.img
BOOT_IMAGE=../vmlinuz-linux
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1011952k/1038144k available (4065k kernel code,
460k absent, 25732k reserved, 3303k data, 712k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0,
CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:2304
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 8388608 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1662.210 MHz processor.
[    0.003341] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3325.93 BogoMIPS (lpj=5540700)
[    0.003352] pid_max: default: 32768 minimum: 301
[    0.003687] Security Framework initialized
[    0.003697] AppArmor: AppArmor disabled by boot time parameter
[    0.003979] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.004970] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.006704] Mount-cache hash table entries: 256
[    0.007870] Initializing cgroup subsys cpuacct
[    0.007975] Initializing cgroup subsys memory
[    0.008023] Initializing cgroup subsys devices
[    0.008029] Initializing cgroup subsys freezer
[    0.008035] Initializing cgroup subsys net_cls
[    0.008041] Initializing cgroup subsys blkio
[    0.008178] CPU: Physical Processor ID: 0
[    0.008183] CPU: Processor Core ID: 0
[    0.008189] mce: CPU supports 5 MCE banks
[    0.008201] CPU0: Thermal monitoring handled by SMI
[    0.008210] using mwait in idle threads.
[    0.009745] ACPI: Core revision 20110413
[    0.020029] ftrace: allocating 16145 entries in 64 pages
[    0.023809] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.057753] CPU0: Intel(R) Atom(TM) CPU N450   @ 1.66GHz stepping 0a
[    0.059996] Performance Events: PEBS fmt0+, Atom events, Intel PMU driver.
[    0.059996] ... version:                3
[    0.059996] ... bit width:              40
[    0.059996] ... generic registers:      2
[    0.059996] ... value mask:             000000ffffffffff
[    0.059996] ... max period:             000000007fffffff
[    0.059996] ... fixed-purpose events:   3
[    0.059996] ... event mask:             0000000700000003
[    0.076825] NMI watchdog enabled, takes one hw-pmu counter.
[    0.103371] Booting Node   0, Processors  #1 Ok.
[    0.103380] smpboot cpu 1: start_ip = 98000
[    0.006666] CPU0: Thermal monitoring enabled (TM1)
[    0.200046] NMI watchdog enabled, takes one hw-pmu counter.
[    0.206667] Brought up 2 CPUs
[    0.206676] Total of 2 processors activated (6652.46 BogoMIPS).
[    0.207885] devtmpfs: initialized
[    0.211534] PM: Registering ACPI NVS region at 3f5e0000 (12288 bytes)
[    0.214502] print_constraints: dummy:
[    0.214729] NET: Registered protocol family 16
[    0.215043] ACPI: bus type pci registered
[    0.215459] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.215468] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.257895] PCI: Using configuration type 1 for base access
[    0.258912] bio: create slab <bio-0> at 0
[    0.262221] ACPI: EC: Look up EC in DSDT
[    0.270823] ACPI: SSDT 000000003f5d5de4 00203 (v02  PmRef  Cpu0Ist
00003000 INTL 20050624)
[    0.271496] ACPI: Dynamic OEM Table Load:
[    0.271504] ACPI: SSDT           (null) 00203 (v02  PmRef  Cpu0Ist
00003000 INTL 20050624)
[    0.271814] ACPI: SSDT 000000003f5d577a 005E5 (v02  PmRef  Cpu0Cst
00003001 INTL 20050624)
[    0.272429] ACPI: Dynamic OEM Table Load:
[    0.272436] ACPI: SSDT           (null) 005E5 (v02  PmRef  Cpu0Cst
00003001 INTL 20050624)
[    0.272994] ACPI: SSDT 000000003f5d5fe7 000D4 (v02  PmRef  Cpu1Ist
00003000 INTL 20050624)
[    0.273649] ACPI: Dynamic OEM Table Load:
[    0.273657] ACPI: SSDT           (null) 000D4 (v02  PmRef  Cpu1Ist
00003000 INTL 20050624)
[    0.273873] ACPI: SSDT 000000003f5d5d5f 00085 (v02  PmRef  Cpu1Cst
00003000 INTL 20050624)
[    0.274491] ACPI: Dynamic OEM Table Load:
[    0.274498] ACPI: SSDT           (null) 00085 (v02  PmRef  Cpu1Cst
00003000 INTL 20050624)
[    0.276838] ACPI: Interpreter enabled
[    0.276847] ACPI: (supports S0 S3 S4 S5)
[    0.276894] ACPI: Using IOAPIC for interrupt routing
[    0.325825] ACPI: EC: GPE = 0x19, I/O: command/status = 0x66, data = 0x62
[    0.326181] ACPI: No dock devices found.
[    0.326187] HEST: Table not found.
[    0.326194] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.327917] ACPI Error: [CAPB] Namespace lookup failure,
AE_ALREADY_EXISTS (20110413/dsfield-143)
[    0.327935] ACPI Error: Method parse/execution failed
[\_SB_.PCI0._OSC] (Node ffff88003d1b2f00), AE_ALREADY_EXISTS
(20110413/psparse-536)
[    0.327955] ACPI: Marking method _OSC as Serialized because of
AE_ALREADY_EXISTS error
[    0.327973] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.331035] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.331043] pci_root PNP0A08:00: host bridge window [mem
0x000a0000-0x000bffff]
[    0.331050] pci_root PNP0A08:00: host bridge window [mem
0x000d0000-0x000d3fff]
[    0.331057] pci_root PNP0A08:00: host bridge window [mem
0x000d4000-0x000d7fff]
[    0.331063] pci_root PNP0A08:00: host bridge window [mem
0x000d8000-0x000dbfff]
[    0.331070] pci_root PNP0A08:00: host bridge window [mem
0x000e0000-0x000e3fff]
[    0.331077] pci_root PNP0A08:00: host bridge window [mem
0x40000000-0xf7ffffff]
[    0.331083] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xfdff]
[    0.331110] pci 0000:00:00.0: [8086:a010] type 0 class 0x000600
[    0.331168] pci 0000:00:02.0: [8086:a011] type 0 class 0x000300
[    0.331183] pci 0000:00:02.0: reg 10: [mem 0xf0200000-0xf027ffff]
[    0.331194] pci 0000:00:02.0: reg 14: [io  0x18d0-0x18d7]
[    0.331204] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff pref]
[    0.331214] pci 0000:00:02.0: reg 1c: [mem 0xf0000000-0xf00fffff]
[    0.331259] pci 0000:00:02.1: [8086:a012] type 0 class 0x000380
[    0.331273] pci 0000:00:02.1: reg 10: [mem 0xf0280000-0xf02fffff]
[    0.331371] pci 0000:00:1b.0: [8086:27d8] type 0 class 0x000403
[    0.331396] pci 0000:00:1b.0: reg 10: [mem 0xf0500000-0xf0503fff 64bit]
[    0.331476] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.331484] pci 0000:00:1b.0: PME# disabled
[    0.331517] pci 0000:00:1c.0: [8086:27d0] type 1 class 0x000604
[    0.331598] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.331607] pci 0000:00:1c.0: PME# disabled
[    0.331641] pci 0000:00:1c.1: [8086:27d2] type 1 class 0x000604
[    0.331728] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.331737] pci 0000:00:1c.1: PME# disabled
[    0.331772] pci 0000:00:1c.2: [8086:27d4] type 1 class 0x000604
[    0.331853] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.331860] pci 0000:00:1c.2: PME# disabled
[    0.331898] pci 0000:00:1d.0: [8086:27c8] type 0 class 0x000c03
[    0.331955] pci 0000:00:1d.0: reg 20: [io  0x1820-0x183f]
[    0.332008] pci 0000:00:1d.1: [8086:27c9] type 0 class 0x000c03
[    0.332065] pci 0000:00:1d.1: reg 20: [io  0x1840-0x185f]
[    0.332112] pci 0000:00:1d.2: [8086:27ca] type 0 class 0x000c03
[    0.332169] pci 0000:00:1d.2: reg 20: [io  0x1860-0x187f]
[    0.332215] pci 0000:00:1d.3: [8086:27cb] type 0 class 0x000c03
[    0.332271] pci 0000:00:1d.3: reg 20: [io  0x1880-0x189f]
[    0.332330] pci 0000:00:1d.7: [8086:27cc] type 0 class 0x000c03
[    0.332358] pci 0000:00:1d.7: reg 10: [mem 0xf0504000-0xf05043ff]
[    0.332452] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.332460] pci 0000:00:1d.7: PME# disabled
[    0.332490] pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
[    0.332574] pci 0000:00:1f.0: [8086:27bc] type 0 class 0x000601
[    0.332674] pci 0000:00:1f.0: [Firmware Bug]: TigerPoint LPC.BM_STS cleared
[    0.332727] pci 0000:00:1f.2: [8086:27c1] type 0 class 0x000106
[    0.332751] pci 0000:00:1f.2: reg 10: [io  0x18e8-0x18ef]
[    0.332766] pci 0000:00:1f.2: reg 14: [io  0x18dc-0x18df]
[    0.332780] pci 0000:00:1f.2: reg 18: [io  0x18e0-0x18e7]
[    0.332794] pci 0000:00:1f.2: reg 1c: [io  0x18d8-0x18db]
[    0.332808] pci 0000:00:1f.2: reg 20: [io  0x18c0-0x18cf]
[    0.332823] pci 0000:00:1f.2: reg 24: [mem 0xf0504400-0xf05047ff]
[    0.332864] pci 0000:00:1f.2: PME# supported from D3hot
[    0.332872] pci 0000:00:1f.2: PME# disabled
[    0.332897] pci 0000:00:1f.3: [8086:27da] type 0 class 0x000c05
[    0.332964] pci 0000:00:1f.3: reg 20: [io  0x18a0-0x18bf]
[    0.333067] pci 0000:00:1c.0: PCI bridge to [bus 05-05]
[    0.333076] pci 0000:00:1c.0:   bridge window [io  0x0000-0x0000] (disabled)
[    0.333085] pci 0000:00:1c.0:   bridge window [mem
0xfff00000-0x000fffff] (disabled)
[    0.333096] pci 0000:00:1c.0:   bridge window [mem
0xfff00000-0x000fffff pref] (disabled)
[    0.333189] pci 0000:07:00.0: [168c:002b] type 0 class 0x000280
[    0.333224] pci 0000:07:00.0: reg 10: [mem 0xf0100000-0xf010ffff 64bit]
[    0.333352] pci 0000:07:00.0: supports D1
[    0.333358] pci 0000:07:00.0: PME# supported from D0 D1 D3hot
[    0.333368] pci 0000:07:00.0: PME# disabled
[    0.340017] pci 0000:00:1c.1: PCI bridge to [bus 07-07]
[    0.340026] pci 0000:00:1c.1:   bridge window [io  0xf000-0x0000] (disabled)
[    0.340035] pci 0000:00:1c.1:   bridge window [mem 0xf0100000-0xf01fffff]
[    0.340046] pci 0000:00:1c.1:   bridge window [mem
0xfff00000-0x000fffff pref] (disabled)
[    0.340171] pci 0000:09:00.0: [10ec:8136] type 0 class 0x000200
[    0.340239] pci 0000:09:00.0: reg 10: [io  0x2000-0x20ff]
[    0.340353] pci 0000:09:00.0: reg 18: [mem 0xf0520000-0xf0520fff 64bit pref]
[    0.340425] pci 0000:09:00.0: reg 20: [mem 0xf0510000-0xf051ffff 64bit pref]
[    0.340474] pci 0000:09:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[    0.340632] pci 0000:09:00.0: supports D1 D2
[    0.340638] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.340655] pci 0000:09:00.0: PME# disabled
[    0.340808] pci 0000:00:1c.2: PCI bridge to [bus 09-09]
[    0.340817] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
[    0.340825] pci 0000:00:1c.2:   bridge window [mem
0xfff00000-0x000fffff] (disabled)
[    0.340837] pci 0000:00:1c.2:   bridge window [mem
0xf0500000-0xf05fffff 64bit pref]
[    0.340922] pci 0000:00:1e.0: PCI bridge to [bus 11-11] (subtractive decode)
[    0.340931] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    0.340940] pci 0000:00:1e.0:   bridge window [mem
0xfff00000-0x000fffff] (disabled)
[    0.340951] pci 0000:00:1e.0:   bridge window [mem
0xfff00000-0x000fffff pref] (disabled)
[    0.340958] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7]
(subtractive decode)
[    0.340965] pci 0000:00:1e.0:   bridge window [mem
0x000a0000-0x000bffff] (subtractive decode)
[    0.340971] pci 0000:00:1e.0:   bridge window [mem
0x000d0000-0x000d3fff] (subtractive decode)
[    0.340978] pci 0000:00:1e.0:   bridge window [mem
0x000d4000-0x000d7fff] (subtractive decode)
[    0.340985] pci 0000:00:1e.0:   bridge window [mem
0x000d8000-0x000dbfff] (subtractive decode)
[    0.340992] pci 0000:00:1e.0:   bridge window [mem
0x000e0000-0x000e3fff] (subtractive decode)
[    0.340999] pci 0000:00:1e.0:   bridge window [mem
0x40000000-0xf7ffffff] (subtractive decode)
[    0.341006] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xfdff]
(subtractive decode)
[    0.341041] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.341227] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.341320] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.341417] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
[    0.341518] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.341839] ACPI Error: [CAPB] Namespace lookup failure,
AE_ALREADY_EXISTS (20110413/dsfield-143)
[    0.341856] ACPI Error: Method parse/execution failed
[\_SB_.PCI0._OSC] (Node ffff88003d1b2f00), AE_ALREADY_EXISTS
(20110413/psparse-536)
[    0.341885]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.342028] ACPI Error: [CAPB] Namespace lookup failure,
AE_ALREADY_EXISTS (20110413/dsfield-143)
[    0.342043] ACPI Error: Method parse/execution failed
[\_SB_.PCI0._OSC] (Node ffff88003d1b2f00), AE_ALREADY_EXISTS
(20110413/psparse-536)
[    0.342071]  pci0000:00: ACPI _OSC request failed
(AE_ALREADY_EXISTS), returned control mask: 0x1d
[    0.342076] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.351403] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.351540] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.351673] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.351804] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.351944] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[    0.352086] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[    0.352228] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.352367] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.352648] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.352670] vgaarb: loaded
[    0.352674] vgaarb: bridge control possible 0000:00:02.0
[    0.352914] PCI: Using ACPI for IRQ routing
[    0.359515] PCI: pci_cache_line_size set to 64 bytes
[    0.359549] pci 0000:00:1b.0: address space collision: [mem
0xf0500000-0xf0503fff 64bit] conflicts with PCI Bus 0000:09 [mem
0xf0500000-0xf05fffff 64bit pref]
[    0.359585] pci 0000:00:1d.7: address space collision: [mem
0xf0504000-0xf05043ff] conflicts with PCI Bus 0000:09 [mem
0xf0500000-0xf05fffff 64bit pref]
[    0.359609] pci 0000:00:1f.2: address space collision: [mem
0xf0504400-0xf05047ff] conflicts with PCI Bus 0000:09 [mem
0xf0500000-0xf05fffff 64bit pref]
[    0.359688] reserve RAM buffer: 000000000009dc00 - 000000000009ffff
[    0.359694] reserve RAM buffer: 000000003f5d0000 - 000000003fffffff
[    0.360022] NetLabel: Initializing
[    0.360028] NetLabel:  domain hash size = 128
[    0.360032] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.360068] NetLabel:  unlabeled traffic allowed by default
[    0.360103] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.360113] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.360126] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.376682] Switching to clocksource hpet
[    0.379814] Switched to NOHz mode on CPU #0
[    0.379922] Switched to NOHz mode on CPU #1
[    0.393767] pnp: PnP ACPI init
[    0.393807] ACPI: bus type pnp registered
[    0.395403] pnp 00:00: [bus 00-3f]
[    0.395411] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.395417] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.395424] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.395429] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.395435] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.395441] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.395447] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.395453] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.395459] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.395464] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.395470] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.395476] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.395482] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.395488] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.395494] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.395500] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.395510] pnp 00:00: [mem 0x40000000-0xf7ffffff window]
[    0.395516] pnp 00:00: [io  0x0d00-0xfdff window]
[    0.395522] pnp 00:00: [mem 0x00000000 window]
[    0.395527] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.395667] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08
PNP0a03 (active)
[    0.395943] pnp 00:01: [io  0x0010-0x001f]
[    0.395950] pnp 00:01: [io  0x0024-0x0025]
[    0.395955] pnp 00:01: [io  0x0028-0x0029]
[    0.395960] pnp 00:01: [io  0x002c-0x002d]
[    0.395965] pnp 00:01: [io  0x0030-0x0031]
[    0.395970] pnp 00:01: [io  0x0034-0x0035]
[    0.395975] pnp 00:01: [io  0x0038-0x0039]
[    0.395980] pnp 00:01: [io  0x003c-0x003d]
[    0.395985] pnp 00:01: [io  0x0068]
[    0.395990] pnp 00:01: [io  0x006c]
[    0.395995] pnp 00:01: [io  0x0072-0x0077]
[    0.396000] pnp 00:01: [io  0x0080]
[    0.396005] pnp 00:01: [io  0x0090-0x009f]
[    0.396010] pnp 00:01: [io  0x00a4-0x00a5]
[    0.396015] pnp 00:01: [io  0x00a8-0x00a9]
[    0.396020] pnp 00:01: [io  0x00ac-0x00ad]
[    0.396025] pnp 00:01: [io  0x00b0-0x00b5]
[    0.396030] pnp 00:01: [io  0x00b8-0x00b9]
[    0.396035] pnp 00:01: [io  0x00bc-0x00bd]
[    0.396040] pnp 00:01: [io  0x0800-0x080f]
[    0.396045] pnp 00:01: [io  0x1000-0x107f]
[    0.396050] pnp 00:01: [io  0x1180-0x11bf]
[    0.396055] pnp 00:01: [io  0x002e-0x002f]
[    0.396060] pnp 00:01: [io  0x04d0-0x04d1]
[    0.396065] pnp 00:01: [io  0xfe00]
[    0.396070] pnp 00:01: [io  0x164e-0x174c]
[    0.396076] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    0.396081] pnp 00:01: [mem 0xfed14000-0xfed17fff]
[    0.396087] pnp 00:01: [mem 0xf8000000-0xfbffffff]
[    0.396092] pnp 00:01: [mem 0xfef00000-0xfeffffff]
[    0.396257] system 00:01: [io  0x0800-0x080f] has been reserved
[    0.396266] system 00:01: [io  0x1000-0x107f] has been reserved
[    0.396273] system 00:01: [io  0x1180-0x11bf] has been reserved
[    0.396280] system 00:01: [io  0x04d0-0x04d1] has been reserved
[    0.396287] system 00:01: [io  0xfe00] has been reserved
[    0.396293] system 00:01: [io  0x164e-0x174c] has been reserved
[    0.396301] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    0.396309] system 00:01: [mem 0xfed14000-0xfed17fff] has been reserved
[    0.396316] system 00:01: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.396323] system 00:01: [mem 0xfef00000-0xfeffffff] has been reserved
[    0.396333] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.396362] pnp 00:02: [io  0x0000-0x000f]
[    0.396368] pnp 00:02: [io  0x0081-0x008f]
[    0.396373] pnp 00:02: [io  0x00c0-0x00df]
[    0.396379] pnp 00:02: [dma 4]
[    0.396458] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.396486] pnp 00:03: [io  0x00f0-0x00fe]
[    0.396508] pnp 00:03: [irq 13]
[    0.396589] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.396718] pnp 00:04: [io  0x0070-0x0071]
[    0.396733] pnp 00:04: [irq 8]
[    0.396808] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.396840] pnp 00:05: [io  0x0061]
[    0.396918] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.416780] pnp 00:06: [io  0x0060]
[    0.416787] pnp 00:06: [io  0x0064]
[    0.416802] pnp 00:06: [irq 1]
[    0.416902] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.416938] pnp 00:07: [irq 12]
[    0.417021] pnp 00:07: Plug and Play ACPI device, IDs SYN071a
SYN0700 SYN0002 PNP0f13 (active)
[    0.417457] pnp: PnP ACPI: found 8 devices
[    0.417463] ACPI: ACPI bus type pnp unregistered
[    0.426882] PCI: max bus depth: 1 pci_try_num: 2
[    0.426958] pci 0000:00:1c.2: BAR 14: assigned [mem 0x40000000-0x400fffff]
[    0.426968] pci 0000:00:1b.0: BAR 0: assigned [mem
0x40100000-0x40103fff 64bit]
[    0.426983] pci 0000:00:1b.0: BAR 0: set to [mem
0x40100000-0x40103fff 64bit] (PCI address [0x40100000-0x40103fff])
[    0.426993] pci 0000:00:1d.7: BAR 0: assigned [mem 0x40104000-0x401043ff]
[    0.427004] pci 0000:00:1d.7: BAR 0: set to [mem
0x40104000-0x401043ff] (PCI address [0x40104000-0x401043ff])
[    0.427014] pci 0000:00:1f.2: BAR 5: assigned [mem 0x40104400-0x401047ff]
[    0.427024] pci 0000:00:1f.2: BAR 5: set to [mem
0x40104400-0x401047ff] (PCI address [0x40104400-0x401047ff])
[    0.427037] pci 0000:00:1c.1: BAR 15: assigned [mem
0x40200000-0x403fffff 64bit pref]
[    0.427048] pci 0000:00:1c.1: BAR 13: assigned [io  0x3000-0x3fff]
[    0.427058] pci 0000:00:1c.0: BAR 14: assigned [mem 0x40400000-0x405fffff]
[    0.427069] pci 0000:00:1c.0: BAR 15: assigned [mem
0x40600000-0x407fffff 64bit pref]
[    0.427078] pci 0000:00:1c.0: BAR 13: assigned [io  0x4000-0x4fff]
[    0.427086] pci 0000:00:1c.0: PCI bridge to [bus 05-05]
[    0.427093] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.427103] pci 0000:00:1c.0:   bridge window [mem 0x40400000-0x405fffff]
[    0.427112] pci 0000:00:1c.0:   bridge window [mem
0x40600000-0x407fffff 64bit pref]
[    0.427123] pci 0000:00:1c.1: PCI bridge to [bus 07-07]
[    0.427130] pci 0000:00:1c.1:   bridge window [io  0x3000-0x3fff]
[    0.427139] pci 0000:00:1c.1:   bridge window [mem 0xf0100000-0xf01fffff]
[    0.427148] pci 0000:00:1c.1:   bridge window [mem
0x40200000-0x403fffff 64bit pref]
[    0.427162] pci 0000:09:00.0: BAR 6: assigned [mem
0xf0540000-0xf055ffff pref]
[    0.427168] pci 0000:00:1c.2: PCI bridge to [bus 09-09]
[    0.427175] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
[    0.427185] pci 0000:00:1c.2:   bridge window [mem 0x40000000-0x400fffff]
[    0.427193] pci 0000:00:1c.2:   bridge window [mem
0xf0500000-0xf05fffff 64bit pref]
[    0.427205] pci 0000:00:1e.0: PCI bridge to [bus 11-11]
[    0.427209] pci 0000:00:1e.0:   bridge window [io  disabled]
[    0.427218] pci 0000:00:1e.0:   bridge window [mem disabled]
[    0.427225] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    0.427245] pci 0000:00:1c.0: enabling device (0000 -> 0003)
[    0.427269] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.427280] pci 0000:00:1c.0: setting latency timer to 64
[    0.427299] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.427308] pci 0000:00:1c.1: setting latency timer to 64
[    0.427325] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.427333] pci 0000:00:1c.2: setting latency timer to 64
[    0.427346] pci 0000:00:1e.0: setting latency timer to 64
[    0.427354] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.427361] pci_bus 0000:00: resource 5 [mem 0x000a0000-0x000bffff]
[    0.427367] pci_bus 0000:00: resource 6 [mem 0x000d0000-0x000d3fff]
[    0.427373] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.427379] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.427386] pci_bus 0000:00: resource 9 [mem 0x000e0000-0x000e3fff]
[    0.427392] pci_bus 0000:00: resource 10 [mem 0x40000000-0xf7ffffff]
[    0.427398] pci_bus 0000:00: resource 11 [io  0x0d00-0xfdff]
[    0.427405] pci_bus 0000:05: resource 0 [io  0x4000-0x4fff]
[    0.427411] pci_bus 0000:05: resource 1 [mem 0x40400000-0x405fffff]
[    0.427418] pci_bus 0000:05: resource 2 [mem 0x40600000-0x407fffff
64bit pref]
[    0.427424] pci_bus 0000:07: resource 0 [io  0x3000-0x3fff]
[    0.427430] pci_bus 0000:07: resource 1 [mem 0xf0100000-0xf01fffff]
[    0.427437] pci_bus 0000:07: resource 2 [mem 0x40200000-0x403fffff
64bit pref]
[    0.427444] pci_bus 0000:09: resource 0 [io  0x2000-0x2fff]
[    0.427450] pci_bus 0000:09: resource 1 [mem 0x40000000-0x400fffff]
[    0.427456] pci_bus 0000:09: resource 2 [mem 0xf0500000-0xf05fffff
64bit pref]
[    0.427463] pci_bus 0000:11: resource 4 [io  0x0000-0x0cf7]
[    0.427469] pci_bus 0000:11: resource 5 [mem 0x000a0000-0x000bffff]
[    0.427476] pci_bus 0000:11: resource 6 [mem 0x000d0000-0x000d3fff]
[    0.427482] pci_bus 0000:11: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.427488] pci_bus 0000:11: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.427494] pci_bus 0000:11: resource 9 [mem 0x000e0000-0x000e3fff]
[    0.427501] pci_bus 0000:11: resource 10 [mem 0x40000000-0xf7ffffff]
[    0.427507] pci_bus 0000:11: resource 11 [io  0x0d00-0xfdff]
[    0.427715] NET: Registered protocol family 2
[    0.428049] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.429094] TCP established hash table entries: 131072 (order: 9,
2097152 bytes)
[    0.430810] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.431571] TCP: Hash tables configured (established 131072 bind 65536)
[    0.431577] TCP reno registered
[    0.431600] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.431624] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.432293] NET: Registered protocol family 1
[    0.432335] pci 0000:00:02.0: Boot video device
[    0.432494] PCI: CLS 32 bytes, default 64
[    0.432623] Unpacking initramfs...
[    0.481329] Freeing initrd memory: 1488k freed
[    0.482460] Simple Boot Flag at 0x35 set to 0x1
[    0.483429] audit: initializing netlink socket (disabled)
[    0.483456] type=2000 audit(1315938646.483:1): initialized
[    0.487759] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.499890] VFS: Disk quotas dquot_6.5.2
[    0.500347] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.500794] msgmni has been set to 1979
[    0.501430] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    0.501537] io scheduler noop registered
[    0.501545] io scheduler deadline registered
[    0.501702] io scheduler cfq registered (default)
[    0.501961] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.502025] pcieport 0000:00:1c.0: irq 40 for MSI/MSI-X
[    0.502138] pcieport 0000:00:1c.1: setting latency timer to 64
[    0.502192] pcieport 0000:00:1c.1: irq 41 for MSI/MSI-X
[    0.502303] pcieport 0000:00:1c.2: setting latency timer to 64
[    0.502357] pcieport 0000:00:1c.2: irq 42 for MSI/MSI-X
[    0.502693] intel_idle: MWAIT substates: 0x20220
[    0.502713] intel_idle: v0.4 model 0x1C
[    0.502718] intel_idle: lapic_timer_reliable_states 0x2
[    0.502762] Marking TSC unstable due to TSC halts in idle states
deeper than C2
[    0.502801] ERST: Table is not found!
[    0.502957] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.540390] Linux agpgart interface v0.103
[    0.540581] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    0.594966] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.595050] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.595307] mousedev: PS/2 mouse device common for all mice
[    0.598573] rtc_cmos 00:04: RTC can wake from S4
[    0.598798] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.598840] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.599013] cpuidle: using governor ladder
[    0.599243] cpuidle: using governor menu
[    0.599839] TCP cubic registered
[    0.599847] NET: Registered protocol family 17
[    0.599866] Registering the dns_resolver key type
[    0.600206] PM: Hibernation image not present or could not be loaded.
[    0.600221] registered taskstats version 1
[    0.604413] rtc_cmos 00:04: setting system clock to 2011-09-13
18:30:46 UTC (1315938646)
[    0.604539] Initializing network drop monitor service
[    0.607947] Freeing unused kernel memory: 712k freed
[    0.608321] Write protecting the kernel read-only data: 6144k
[    0.608732] Freeing unused kernel memory: 12k freed
[    0.615948] Freeing unused kernel memory: 776k freed
[    0.641485] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    0.695996] SCSI subsystem initialized
[    0.706531] libata version 3.00 loaded.
[    0.709199] ahci 0000:00:1f.2: version 3.0
[    0.709237] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.709308] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    0.709409] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3
Gbps 0xf impl SATA mode
[    0.709418] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
[    0.709427] ahci 0000:00:1f.2: setting latency timer to 64
[    0.710910] scsi0 : ahci
[    0.711198] scsi1 : ahci
[    0.711403] scsi2 : ahci
[    0.711613] scsi3 : ahci
[    0.711926] ata1: SATA max UDMA/133 abar m1024@0x40104400 port
0x40104500 irq 43
[    0.711935] ata2: SATA max UDMA/133 abar m1024@0x40104400 port
0x40104580 irq 43
[    0.711942] ata3: SATA max UDMA/133 abar m1024@0x40104400 port
0x40104600 irq 43
[    0.711950] ata4: SATA max UDMA/133 abar m1024@0x40104400 port
0x40104680 irq 43
[    1.030126] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.030162] ata2: SATA link down (SStatus 0 SControl 300)
[    1.030208] ata3: SATA link down (SStatus 0 SControl 300)
[    1.030265] ata4: SATA link down (SStatus 0 SControl 300)
[    1.483506] ata1.00: ATA-8: TOSHIBA MK2565GSX, GJ003M, max UDMA/100
[    1.483514] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.496769] ata1.00: configured for UDMA/100
[    1.497227] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA
MK2565GS GJ00 PQ: 0 ANSI: 5
[    1.499878] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks:
(250 GB/232 GiB)
[    1.500110] sd 0:0:0:0: [sda] Write Protect is off
[    1.500119] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.500187] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.983510]  sda: sda1 sda2 sda3 sda4
[    1.984528] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.143836] EXT4-fs (sda3): mounted filesystem with ordered data
mode. Opts: (null)
[   17.406999] NET: Registered protocol family 10
[   52.481310] coretemp coretemp.0: Unable to read TjMax from CPU.
[   52.481324] coretemp coretemp.0: Using relative temperature scale!
[   52.484073] ACPI: acpi_idle yielding to intel_idle
[   65.003452] EXT4-fs (sda3): re-mounted. Opts: (null)
[   84.303564] input: Lid Switch as
/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:0d/PNP0C0D:00/input/input1
[   84.303662] ACPI: Lid Switch [LID0]
[   84.303921] input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0A08:00/PNP0C0C:00/input/input2
[   84.303940] ACPI: Power Button [PWRB]
[   84.304119] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   84.304135] ACPI: Power Button [PWRF]
[   84.344656] ACPI: Deprecated procfs I/F for AC is loaded, please
retry with CONFIG_ACPI_PROCFS_POWER cleared
[   84.349360] ACPI: AC Adapter [ACAD] (on-line)
[   84.387300] toshiba_bluetooth: Detected Toshiba ACPI Bluetooth
device - installing RFKill handler
[   84.388091] toshiba_bluetooth: Re-enabling Toshiba Bluetooth
[   84.489454] iTCO_vendor_support: vendor-support=0
[   84.511151] cfg80211: Calling CRDA to update world regulatory domain
[   84.522667] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   84.532788] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level,
low) -> IRQ 19
[   84.574132] usbcore: registered new interface driver usbfs
[   84.574215] usbcore: registered new interface driver hub
[   84.578596] usbcore: registered new device driver usb
[   84.587395] ACPI: Deprecated procfs I/F for battery is loaded,
please retry with CONFIG_ACPI_PROCFS_POWER cleared
[   84.587424] ACPI: Battery Slot [BAT1] (battery present)
[   84.594486] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[   84.594733] iTCO_wdt: Found a NM10 TCO device (Version=2, TCOBASE=0x1060)
[   84.594899] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   84.598423] agpgart-intel 0000:00:00.0: Intel GMA3150 Chipset
[   84.598646] agpgart-intel 0000:00:00.0: detected gtt size: 524288K
total, 262144K mappable
[   84.598896] agpgart-intel 0000:00:00.0: detected 8192K stolen memory
[   84.599242] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[   84.611761] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   84.611840] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[   84.611885] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[   84.611895] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   84.611974] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned
bus number 1
[   84.612032] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[   84.612053] ehci_hcd 0000:00:1d.7: debug port 1
[   84.619954] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   84.620104] r8169 0000:09:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   84.620385] r8169 0000:09:00.0: setting latency timer to 64
[   84.620474] r8169 0000:09:00.0: irq 44 for MSI/MSI-X
[   84.623610] r8169 0000:09:00.0: eth0: RTL8102e at
0xffffc90010558000, 70:5a:b6:ba:eb:0c, XID 04e00000 IRQ 44
[   84.639418] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[   84.639479] ehci_hcd 0000:00:1d.7: irq 23, io mem 0x40104000
[   84.674689] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[   84.675160] hub 1-0:1.0: USB hub found
[   84.675177] hub 1-0:1.0: 8 ports detected
[   84.734171] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   84.746557] [drm] Initialized drm 1.1.0 20060810
[   84.746592] uhci_hcd: USB Universal Host Controller Interface driver
[   84.746779] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[   84.746800] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[   84.746810] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   84.746848] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned
bus number 2
[   84.746911] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001820
[   84.758480] hub 2-0:1.0: USB hub found
[   84.758498] hub 2-0:1.0: 2 ports detected
[   84.758756] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[   84.758780] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[   84.758790] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   84.758826] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned
bus number 3
[   84.758920] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001840
[   84.759458] hub 3-0:1.0: USB hub found
[   84.759476] hub 3-0:1.0: 2 ports detected
[   84.759727] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   84.759748] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[   84.759759] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   84.759802] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned
bus number 4
[   84.759887] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
[   84.766425] ath9k 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   84.766575] ath9k 0000:07:00.0: setting latency timer to 64
[   84.777722] hub 4-0:1.0: USB hub found
[   84.777741] hub 4-0:1.0: 2 ports detected
[   84.778006] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
[   84.778030] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[   84.778047] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   84.778086] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned
bus number 5
[   84.778214] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001880
[   84.778683] hub 5-0:1.0: USB hub found
[   84.778702] hub 5-0:1.0: 2 ports detected
[   84.781446] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,
low) -> IRQ 22
[   84.781558] HDA Intel 0000:00:1b.0: irq 45 for MSI/MSI-X
[   84.781636] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   84.884993] hda_codec: ALC272: BIOS auto-probing.
[   84.886035] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1b.0/input/input5
[   84.893906] input: HDA Intel Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   84.906291] input: HDA Intel Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   84.907704] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   84.907720] i915 0000:00:02.0: setting latency timer to 64
[   84.979580] ath: EEPROM regdomain: 0x65
[   84.979589] ath: EEPROM indicates we should expect a direct regpair map
[   84.979600] ath: Country alpha2 being used: 00
[   84.979606] ath: Regpair used: 0x65
[   84.983405] usb 1-8: new high speed USB device number 2 using ehci_hcd
[   85.031440] ieee80211 phy0: Selected rate control algorithm
'ath9k_rate_control'
[   85.033399] Registered led device: ath9k-phy0
[   85.033460] ieee80211 phy0: Atheros AR9285 Rev:2
mem=0xffffc90010720000, irq=17
[   85.223735] i915 0000:00:02.0: irq 46 for MSI/MSI-X
[   85.223751] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   85.223758] [drm] Driver supports precise vblank timestamp query.
[   85.223869] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   85.524310] Linux media interface: v0.10
[   85.535867] Linux video capture interface: v2.00
[   85.543882] uvcvideo: Found UVC 1.00 device USB 2.0 Camera (064e:c211)
[   85.567193] input: USB 2.0 Camera as
/devices/pci0000:00/0000:00:1d.7/usb1/1-8/1-8:1.0/input/input8
[   85.567675] usbcore: registered new interface driver uvcvideo
[   85.567683] USB Video Class driver (v1.1.0)
[   85.568878] [drm] initialized overlay support
[   85.596977] fbcon: inteldrmfb (fb0) is primary device
[   85.639051] fixme: max PWM is zero.
[   85.647677] Console: switching to colour frame buffer device 128x37
[   85.654752] fb0: inteldrmfb frame buffer device
[   85.654758] drm: registered panic notifier
[   85.656513] acpi device:01: registered as cooling_device2
[   85.656833] input: Video Bus as
/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input9
[   85.657074] ACPI: Video Device [IGD0] (multi-head: yes  rom: no  post: no)
[   85.657265] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   85.826738] usb 3-1: new full speed USB device number 2 using uhci_hcd
[   86.002531] Adding 3145724k swap on /dev/sda1.  Priority:0
extents:1 across:3145724k
[   86.159331] Bluetooth: Core ver 2.16
[   86.159931] NET: Registered protocol family 31
[   86.159938] Bluetooth: HCI device and connection manager initialized
[   86.159946] Bluetooth: HCI socket layer initialized
[   86.159952] Bluetooth: L2CAP socket layer initialized
[   86.163041] Bluetooth: SCO socket layer initialized
[   86.168499] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   86.170183] usbcore: registered new interface driver btusb
[   86.453193] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c0b1,
caps: 0xd04733/0xa40000/0xa0000
[   86.599249] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input10
[   87.114198] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   87.132143] r8169 0000:09:00.0: eth0: link down
[   87.132782] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   89.894334] wlan0: authenticate with 5c:33:8e:ea:24:f3 (try 1)
[   89.898401] wlan0: authenticated
[   89.932529] wlan0: associate with 5c:33:8e:ea:24:f3 (try 1)
[   89.938160] wlan0: RX AssocResp from 5c:33:8e:ea:24:f3 (capab=0x431
status=0 aid=2)
[   89.938167] wlan0: associated
[   89.945723] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   89.973048] Intel AES-NI instructions are not detected.
[   89.985709] padlock_aes: VIA PadLock not detected.
[  100.216961] wlan0: no IPv6 routers present
[  148.723576] EXT4-fs (sda4): mounted filesystem with ordered data
mode. Opts: (null)
[  158.898484] EXT4-fs (sda3): re-mounted. Opts: commit=0
[  159.070891] EXT4-fs (sda4): re-mounted. Opts: commit=0
[  484.004021] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: (null)
