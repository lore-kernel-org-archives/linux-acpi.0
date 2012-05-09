From: Martin Lucina <martin@lucina.net>
Subject: ACPI Warning: 32/64 FACS address mismatch in FADT
Date: Wed, 9 May 2012 17:08:20 +0200
Message-ID: <20120509150818.GA5923@nodbug.moloch.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chrocht.moloch.sk ([62.176.169.44]:40270 "EHLO mail.moloch.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758243Ab2EIPI2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2012 11:08:28 -0400
Received: from nodbug.moloch.sk (unknown [118.131.79.166])
	by mail.moloch.sk (Postfix) with ESMTPSA id D96FD182B0DC
	for <linux-acpi@vger.kernel.org>; Wed,  9 May 2012 17:08:25 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I get the following interesting messages on boot:

[    0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two FACS ta
bles! (20120111/tbfadt-378)
[    0.000000] ACPI Warning: 32/64X FACS address mismatch in FADT - 0xDAFD4E40
/0x00000000DAFD4D40, using 32 (20120111/tbfadt-502)

and

[    0.263092] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored

This is with a mainline 3.3.5 kernel, Panasonic CF-S10 (Sandy Bridge, Core
i5-2540M) laptop.

Just reporting these in case they're useful to Linux ACPI developers,
although from my limited understanding of ACPI it looks like these are BIOS
bugs?

Full dmesg for your perusal follows.

-mato

---cut here---
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.3.5+cf-s10 (root@nodbug) (gcc version 4.6.3 (Debian 4.6.3-1) ) #3 SMP Wed May 9 16:35:00 CEST 2012
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.3.5+cf-s10 root=/dev/sda5 ro intel_iommu=on quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
[    0.000000]  BIOS-e820: 0000000020000000 - 0000000020200000 (reserved)
[    0.000000]  BIOS-e820: 0000000020200000 - 0000000040000000 (usable)
[    0.000000]  BIOS-e820: 0000000040000000 - 0000000040200000 (reserved)
[    0.000000]  BIOS-e820: 0000000040200000 - 00000000dac34000 (usable)
[    0.000000]  BIOS-e820: 00000000dac34000 - 00000000dad8e000 (reserved)
[    0.000000]  BIOS-e820: 00000000dad8e000 - 00000000dad9e000 (usable)
[    0.000000]  BIOS-e820: 00000000dad9e000 - 00000000dada0000 (reserved)
[    0.000000]  BIOS-e820: 00000000dada0000 - 00000000dada1000 (usable)
[    0.000000]  BIOS-e820: 00000000dada1000 - 00000000dade8000 (reserved)
[    0.000000]  BIOS-e820: 00000000dade8000 - 00000000daf3a000 (usable)
[    0.000000]  BIOS-e820: 00000000daf3a000 - 00000000daf81000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000daf81000 - 00000000daf88000 (reserved)
[    0.000000]  BIOS-e820: 00000000daf88000 - 00000000dafe8000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dafe8000 - 00000000dafec000 (usable)
[    0.000000]  BIOS-e820: 00000000dafec000 - 00000000dfa00000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed14000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed18000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff980000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffd80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000021e600000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Panasonic Corporation CF-S10EYADR/CFS10-3, BIOS V3.00L10 07/22/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x21e600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask FE0000000 write-back
[    0.000000]   2 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   3 base 0DC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0DB000000 mask FFF000000 uncachable
[    0.000000]   5 base 21F000000 mask FFF000000 uncachable
[    0.000000]   6 base 21E800000 mask FFF800000 uncachable
[    0.000000]   7 base 21E600000 mask FFFE00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000db000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xdafec max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000fd710] fd710
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000dafec000
[    0.000000]  0000000000 - 00dae00000 page 2M
[    0.000000]  00dae00000 - 00dafec000 page 4k
[    0.000000] kernel direct mapping tables up to dafec000 @ 1fffa000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-000000021e600000
[    0.000000]  0100000000 - 021e600000 page 2M
[    0.000000] kernel direct mapping tables up to 21e600000 @ daf30000-daf3a000
[    0.000000] RAMDISK: 37a08000 - 37cfc000
[    0.000000] ACPI: RSDP 00000000000f0430 00024 (v02 MATBIO)
[    0.000000] ACPI: XSDT 00000000daffee18 00094 (v01 MATBIO CFS10-3  06222004 MSFT 00010013)
[    0.000000] ACPI: FACP 00000000daffdc18 000F4 (v04 MATBIO CFS10-3  06222004 MSFT 00010013)
[    0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two FACS tables! (20120111/tbfadt-378)
[    0.000000] ACPI Warning: 32/64X FACS address mismatch in FADT - 0xDAFD4E40/0x00000000DAFD4D40, using 32 (20120111/tbfadt-502)
[    0.000000] ACPI: DSDT 00000000daff1018 0B278 (v01 MATBIO CFS10-3  00000000 INTL 20091112)
[    0.000000] ACPI: FACS 00000000dafd4e40 00040
[    0.000000] ACPI: APIC 00000000daffdf18 000CC (v02 MATBIO CFS10-3  06222004 MSFT 00010013)
[    0.000000] ACPI: HPET 00000000daffff18 00038 (v01 MATBIO CFS10-3  06222004 AMI. 00000003)
[    0.000000] ACPI: SLIC 00000000daff0e18 00176 (v01 MATBIO CFS10-3  06222004 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000dafffe98 0003C (v01 MATBIO CFS10-3  06222004 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000dafef018 00846 (v01  PmRef  Cpu0Ist 00003000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000dafee018 009A0 (v01  PmRef    CpuPm 00003000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000dafeda98 002EC (v01  PmRef  Cpu0Tst 00003000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000dafec918 00452 (v01  PmRef    ApTst 00003000 INTL 20091112)
[    0.000000] ACPI: DMAR 00000000daffda98 000E8 (v01 INTEL      SNB  00000001 INTL 00000001)
[    0.000000] ACPI: SSDT 00000000daf81018 06DF3 (v01 DppmRe  OemDppm 00001000 INTL 20091112)
[    0.000000] ACPI: TCPA 00000000dafffe18 00032 (v02 MATBIO CFS10-3  00000001 MSFT 01000013)
[    0.000000] ACPI: ASF! 00000000daffea18 00074 (v32 MATBIO CFS10-3  06222004 INTL 000F4240)
[    0.000000] ACPI: SSDT 00000000dafed718 002DB (v01 SataRe SataTabl 00001000 INTL 20091112)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea00077fffff] PMD -> [ffff880215c00000-ffff88021cdfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0021e600
[    0.000000] Movable zone start PFN for each node
[    0.000000] Early memory PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x00020000
[    0.000000]     0: 0x00020200 -> 0x00040000
[    0.000000]     0: 0x00040200 -> 0x000dac34
[    0.000000]     0: 0x000dad8e -> 0x000dad9e
[    0.000000]     0: 0x000dada0 -> 0x000dada1
[    0.000000]     0: 0x000dade8 -> 0x000daf3a
[    0.000000]     0: 0x000dafe8 -> 0x000dafec
[    0.000000]     0: 0x00100000 -> 0x0021e600
[    0.000000] On node 0 totalpages: 2068265
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3921 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 877011 pages, LIFO batch:31
[    0.000000]   Normal zone: 16037 pages used for memmap
[    0.000000]   Normal zone: 1156955 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x08] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x09] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] 16 Processors exceeds NR_CPUS limit of 8
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 000000000009f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000020200000
[    0.000000] PM: Registered nosave memory: 0000000040000000 - 0000000040200000
[    0.000000] PM: Registered nosave memory: 00000000dac34000 - 00000000dad8e000
[    0.000000] PM: Registered nosave memory: 00000000dad9e000 - 00000000dada0000
[    0.000000] PM: Registered nosave memory: 00000000dada1000 - 00000000dade8000
[    0.000000] PM: Registered nosave memory: 00000000daf3a000 - 00000000daf81000
[    0.000000] PM: Registered nosave memory: 00000000daf81000 - 00000000daf88000
[    0.000000] PM: Registered nosave memory: 00000000daf88000 - 00000000dafe8000
[    0.000000] PM: Registered nosave memory: 00000000dafec000 - 00000000dfa00000
[    0.000000] PM: Registered nosave memory: 00000000dfa00000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed14000
[    0.000000] PM: Registered nosave memory: 00000000fed14000 - 00000000fed18000
[    0.000000] PM: Registered nosave memory: 00000000fed18000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ff980000
[    0.000000] PM: Registered nosave memory: 00000000ff980000 - 00000000ffc00000
[    0.000000] PM: Registered nosave memory: 00000000ffc00000 - 00000000ffd80000
[    0.000000] PM: Registered nosave memory: 00000000ffd80000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at dfa00000 (gap: dfa00000:18600000)
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 26 pages/cpu @ffff88021e200000 s76672 r8192 d21632 u262144
[    0.000000] pcpu-alloc: s76672 r8192 d21632 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2037887
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.3.5+cf-s10 root=/dev/sda5 ro intel_iommu=on quiet
[    0.000000] Intel-IOMMU: enabled
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 8066124k/8886272k available (3732k kernel code, 613212k absent, 206936k reserved, 2817k data, 440k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:4352 nr_irqs:744 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 2594.215 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 5188.43 BogoMIPS (lpj=2594215)
[    0.000005] pid_max: default: 32768 minimum: 301
[    0.000037] Security Framework initialized
[    0.000048] Mount-cache hash table entries: 256
[    0.000124] Initializing cgroup subsys cpuacct
[    0.000125] Initializing cgroup subsys memory
[    0.000132] Initializing cgroup subsys devices
[    0.000133] Initializing cgroup subsys freezer
[    0.000135] Initializing cgroup subsys net_cls
[    0.000136] Initializing cgroup subsys blkio
[    0.000140] Initializing cgroup subsys perf_event
[    0.000161] CPU: Physical Processor ID: 0
[    0.000161] CPU: Processor Core ID: 0
[    0.000165] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.000166] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.000168] mce: CPU supports 7 MCE banks
[    0.000179] CPU0: Thermal monitoring enabled (TM1)
[    0.000184] using mwait in idle threads.
[    0.000240] ACPI: Core revision 20120111
[    0.031822] DMAR: Host address width 36
[    0.031824] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.031829] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
[    0.031831] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.031835] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.031837] DMAR: RMRR base: 0x000000dadcd000 end: 0x000000dade3fff
[    0.031838] DMAR: RMRR base: 0x000000db800000 end: 0x000000df9fffff
[    0.031910] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.031911] HPET id 0 under DRHD base 0xfed91000
[    0.031912] HPET id 0 under DRHD base 0xfed91000
[    0.031913] HPET id 0 under DRHD base 0xfed91000
[    0.031914] HPET id 0 under DRHD base 0xfed91000
[    0.031915] HPET id 0 under DRHD base 0xfed91000
[    0.031916] HPET id 0 under DRHD base 0xfed91000
[    0.031917] HPET id 0 under DRHD base 0xfed91000
[    0.031918] HPET id 0 under DRHD base 0xfed91000
[    0.032116] Enabled IRQ remapping in x2apic mode
[    0.032118] Enabling x2apic
[    0.032119] Enabled x2apic
[    0.032124] Switched APIC routing to cluster x2apic.
[    0.032584] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.042568] CPU0: Intel(R) Core(TM) i5-2540M CPU @ 2.60GHz stepping 07
[    0.144097] Performance Events: PEBS fmt1+, SandyBridge events, Intel PMU driver.
[    0.144102] PEBS disabled due to CPU errata.
[    0.144104] ... version:                3
[    0.144105] ... bit width:              48
[    0.144106] ... generic registers:      4
[    0.144107] ... value mask:             0000ffffffffffff
[    0.144108] ... max period:             000000007fffffff
[    0.144109] ... fixed-purpose events:   3
[    0.144110] ... event mask:             000000070000000f
[    0.144241] NMI watchdog enabled, takes one hw-pmu counter.
[    0.144327] Booting Node   0, Processors  #1
[    0.144329] smpboot cpu 1: start_ip = 99000
[    0.175411] NMI watchdog enabled, takes one hw-pmu counter.
[    0.175494]  #2
[    0.175495] smpboot cpu 2: start_ip = 99000
[    0.206575] NMI watchdog enabled, takes one hw-pmu counter.
[    0.206664]  #3
[    0.206665] smpboot cpu 3: start_ip = 99000
[    0.237747] NMI watchdog enabled, takes one hw-pmu counter.
[    0.237773] Brought up 4 CPUs
[    0.237774] Total of 4 processors activated (20753.72 BogoMIPS).
[    0.240414] devtmpfs: initialized
[    0.240538] PM: Registering ACPI NVS region at daf3a000 (290816 bytes)
[    0.240543] PM: Registering ACPI NVS region at daf88000 (393216 bytes)
[    0.240640] NET: Registered protocol family 16
[    0.240689] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.240691] ACPI: bus type pci registered
[    0.240783] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.240786] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.254417] PCI: Using configuration type 1 for base access
[    0.254724] bio: create slab <bio-0> at 0
[    0.254786] ACPI: Added _OSI(Module Device)
[    0.254788] ACPI: Added _OSI(Processor Device)
[    0.254789] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.254791] ACPI: Added _OSI(Processor Aggregator Device)
[    0.256326] ACPI: EC: Look up EC in DSDT
[    0.258104] ACPI: Executed 5 blocks of module-level executable AML code
[    0.262619] ACPI: SSDT 00000000dafd5d18 00056 (v01 DynTbl VistaTbl 00000001 INTL 20091112)
[    0.263004] ACPI: Dynamic OEM Table Load:
[    0.263007] ACPI: SSDT           (null) 00056 (v01 DynTbl VistaTbl 00000001 INTL 20091112)
[    0.263092] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.270725] ACPI: SSDT 00000000dadcb018 00869 (v01  PmRef  Cpu0Cst 00003001 INTL 20091112)
[    0.271131] ACPI: Dynamic OEM Table Load:
[    0.271133] ACPI: SSDT           (null) 00869 (v01  PmRef  Cpu0Cst 00003001 INTL 20091112)
[    0.271356] ACPI: SSDT 00000000dadcca98 00303 (v01  PmRef    ApIst 00003000 INTL 20091112)
[    0.271789] ACPI: Dynamic OEM Table Load:
[    0.271791] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20091112)
[    0.271887] ACPI: SSDT 00000000dadcad98 00119 (v01  PmRef    ApCst 00003000 INTL 20091112)
[    0.272287] ACPI: Dynamic OEM Table Load:
[    0.272289] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20091112)
[    0.675562] ACPI: Interpreter enabled
[    0.675566] ACPI: (supports S0 S3 S4 S5)
[    0.675585] ACPI: Using IOAPIC for interrupt routing
[    0.683891] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.684204] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    0.684208] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.684627] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.684877] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.684879] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.684881] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.684884] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-0x000d7fff]
[    0.684885] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-0x000dbfff]
[    0.684887] pci_root PNP0A08:00: host bridge window [mem 0x000dc000-0x000dffff]
[    0.684889] pci_root PNP0A08:00: host bridge window [mem 0xdfa00000-0xfeafffff]
[    0.684890] pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
[    0.684915] PCI host bridge to bus 0000:00
[    0.684917] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.684918] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.684920] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.684922] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.684923] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.684925] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.684926] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff]
[    0.684928] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
[    0.684935] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    0.684969] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
[    0.684978] pci 0000:00:02.0: reg 10: [mem 0xf5400000-0xf57fffff 64bit]
[    0.684984] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.684988] pci 0000:00:02.0: reg 20: [io  0xe000-0xe03f]
[    0.685019] pci 0000:00:04.0: [8086:0103] type 0 class 0x001180
[    0.685028] pci 0000:00:04.0: reg 10: [mem 0xfed98000-0xfed9ffff 64bit]
[    0.685086] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    0.685108] pci 0000:00:16.0: reg 10: [mem 0xf7c34000-0xf7c3400f 64bit]
[    0.685182] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.685206] pci 0000:00:16.3: [8086:1c3d] type 0 class 0x000700
[    0.685224] pci 0000:00:16.3: reg 10: [io  0xe0e0-0xe0e7]
[    0.685234] pci 0000:00:16.3: reg 14: [mem 0xf7c32000-0xf7c32fff]
[    0.685331] pci 0000:00:19.0: [8086:1502] type 0 class 0x000200
[    0.685349] pci 0000:00:19.0: reg 10: [mem 0xf7c00000-0xf7c1ffff]
[    0.685358] pci 0000:00:19.0: reg 14: [mem 0xf7c31000-0xf7c31fff]
[    0.685367] pci 0000:00:19.0: reg 18: [io  0xe080-0xe09f]
[    0.685429] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.685455] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    0.685476] pci 0000:00:1a.0: reg 10: [mem 0xf7c30000-0xf7c303ff]
[    0.685565] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.685593] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    0.685609] pci 0000:00:1b.0: reg 10: [mem 0xf7c28000-0xf7c2bfff 64bit]
[    0.685677] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.685702] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    0.685780] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.685807] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    0.685885] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.685912] pci 0000:00:1c.2: [8086:1c14] type 1 class 0x000604
[    0.685990] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.686019] pci 0000:00:1c.3: [8086:2448] type 1 class 0x000604
[    0.686098] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.686128] pci 0000:00:1c.4: [8086:1c18] type 1 class 0x000604
[    0.686258] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.686302] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    0.686322] pci 0000:00:1d.0: reg 10: [mem 0xf7c2f000-0xf7c2f3ff]
[    0.686412] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.686439] pci 0000:00:1f.0: [8086:1c4f] type 0 class 0x000601
[    0.686563] pci 0000:00:1f.2: [8086:1c03] type 0 class 0x000106
[    0.686581] pci 0000:00:1f.2: reg 10: [io  0xe0d0-0xe0d7]
[    0.686589] pci 0000:00:1f.2: reg 14: [io  0xe0c0-0xe0c3]
[    0.686598] pci 0000:00:1f.2: reg 18: [io  0xe0b0-0xe0b7]
[    0.686606] pci 0000:00:1f.2: reg 1c: [io  0xe0a0-0xe0a3]
[    0.686614] pci 0000:00:1f.2: reg 20: [io  0xe060-0xe07f]
[    0.686622] pci 0000:00:1f.2: reg 24: [mem 0xf7c2e000-0xf7c2e7ff]
[    0.686667] pci 0000:00:1f.2: PME# supported from D3hot
[    0.686686] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    0.686701] pci 0000:00:1f.3: reg 10: [mem 0xf7c2d000-0xf7c2d0ff 64bit]
[    0.686722] pci 0000:00:1f.3: reg 20: [io  0xe040-0xe05f]
[    0.686758] pci 0000:00:1f.6: [8086:1c24] type 0 class 0x001180
[    0.686779] pci 0000:00:1f.6: reg 10: [mem 0xf7c2c000-0xf7c2cfff 64bit]
[    0.686891] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.686896] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.686900] pci 0000:00:1c.0:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.686906] pci 0000:00:1c.0:   bridge window [mem 0xf2700000-0xf27fffff 64bit pref]
[    0.686989] pci 0000:02:00.0: [1033:0194] type 0 class 0x000c03
[    0.687025] pci 0000:02:00.0: reg 10: [mem 0xf7a00000-0xf7a01fff 64bit]
[    0.687215] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.689040] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.689049] pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
[    0.689059] pci 0000:00:1c.1:   bridge window [mem 0xf7a00000-0xf7afffff]
[    0.689074] pci 0000:00:1c.1:   bridge window [mem 0xf2500000-0xf25fffff 64bit pref]
[    0.689291] pci 0000:03:00.0: [8086:0087] type 0 class 0x000280
[    0.689438] pci 0000:03:00.0: reg 10: [mem 0xf7900000-0xf7901fff 64bit]
[    0.690101] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.692121] pci 0000:00:1c.2: PCI bridge to [bus 03-03]
[    0.692125] pci 0000:00:1c.2:   bridge window [io  0xb000-0xbfff]
[    0.692129] pci 0000:00:1c.2:   bridge window [mem 0xf7900000-0xf79fffff]
[    0.692135] pci 0000:00:1c.2:   bridge window [mem 0xf2300000-0xf23fffff 64bit pref]
[    0.692256] pci 0000:04:00.0: [1180:e476] type 2 class 0x000607
[    0.692282] pci 0000:04:00.0: reg 10: [mem 0xf6c00000-0xf6c00fff]
[    0.692372] pci 0000:04:00.0: supports D1 D2
[    0.692373] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.694083] pci 0000:00:1c.3: PCI bridge to [bus 04-0c] (subtractive decode)
[    0.694087] pci 0000:00:1c.3:   bridge window [io  0x8000-0x9fff]
[    0.694091] pci 0000:00:1c.3:   bridge window [mem 0xf5800000-0xf77fffff]
[    0.694097] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff 64bit pref]
[    0.694099] pci 0000:00:1c.3:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.694101] pci 0000:00:1c.3:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.694103] pci 0000:00:1c.3:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.694105] pci 0000:00:1c.3:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
[    0.694107] pci 0000:00:1c.3:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
[    0.694109] pci 0000:00:1c.3:   bridge window [mem 0x000dc000-0x000dffff] (subtractive decode)
[    0.694111] pci 0000:00:1c.3:   bridge window [mem 0xdfa00000-0xfeafffff] (subtractive decode)
[    0.694112] pci 0000:00:1c.3:   bridge window [mem 0xfed40000-0xfed44fff] (subtractive decode)
[    0.694371] pci 0000:0d:00.0: [10ec:5209] type 0 class 0x00ff00
[    0.694433] pci 0000:0d:00.0: reg 10: [mem 0xf7801000-0xf7801fff]
[    0.694916] pci 0000:0d:00.0: supports D1 D2
[    0.694917] pci 0000:0d:00.0: PME# supported from D1 D2 D3hot
[    0.695089] pci 0000:0d:00.1: [10ec:5209] type 0 class 0x000805
[    0.695151] pci 0000:0d:00.1: reg 10: [mem 0xf7800000-0xf78000ff]
[    0.695631] pci 0000:0d:00.1: supports D1 D2
[    0.695632] pci 0000:0d:00.1: PME# supported from D1 D2 D3hot
[    0.697090] pci 0000:00:1c.4: PCI bridge to [bus 0d-0d]
[    0.697094] pci 0000:00:1c.4:   bridge window [io  0xa000-0xafff]
[    0.697098] pci 0000:00:1c.4:   bridge window [mem 0xf7800000-0xf78fffff]
[    0.697105] pci 0000:00:1c.4:   bridge window [mem 0xf2100000-0xf21fffff 64bit pref]
[    0.697129] pci_bus 0000:00: on NUMA node 0
[    0.697132] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.697241] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.697268] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.697296] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.697325] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.697354] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.697611]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.698038]  pci0000:00: ACPI _OSC control (0x1d) granted
[    0.701914] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.701954] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 10 11 12 14 15)
[    0.701994] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.702030] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.702067] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.702103] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.702141] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.702178] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.702236] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.702243] vgaarb: loaded
[    0.702244] vgaarb: bridge control possible 0000:00:02.0
[    0.702263] PCI: Using ACPI for IRQ routing
[    0.704082] PCI: pci_cache_line_size set to 64 bytes
[    0.704090] pci 0000:00:04.0: no compatible bridge window for [mem 0xfed98000-0xfed9ffff 64bit]
[    0.704185] reserve RAM buffer: 000000000009e800 - 000000000009ffff 
[    0.704187] reserve RAM buffer: 00000000dac34000 - 00000000dbffffff 
[    0.704190] reserve RAM buffer: 00000000dad9e000 - 00000000dbffffff 
[    0.704193] reserve RAM buffer: 00000000dada1000 - 00000000dbffffff 
[    0.704195] reserve RAM buffer: 00000000daf3a000 - 00000000dbffffff 
[    0.704197] reserve RAM buffer: 00000000dafec000 - 00000000dbffffff 
[    0.704199] reserve RAM buffer: 000000021e600000 - 000000021fffffff 
[    0.704281] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.704285] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.706300] Switching to clocksource hpet
[    0.707257] pnp: PnP ACPI init
[    0.707268] ACPI: bus type pnp registered
[    0.707427] pnp 00:00: [bus 00-3e]
[    0.707429] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.707431] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.707433] pnp 00:00: [io  0x0d00-0xffff window]
[    0.707435] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.707437] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.707438] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.707440] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.707441] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.707443] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.707444] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.707446] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.707447] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.707449] pnp 00:00: [mem 0xdfa00000-0xfeafffff window]
[    0.707451] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    0.707494] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.708250] pnp 00:01: [mem 0x000cf200-0x000cf7ff]
[    0.708252] pnp 00:01: [mem 0x000d0800-0x000d3fff]
[    0.708282] system 00:01: [mem 0x000cf200-0x000cf7ff] has been reserved
[    0.708284] system 00:01: [mem 0x000d0800-0x000d3fff] has been reserved
[    0.708287] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.708308] pnp 00:02: [io  0x0000-0x001f]
[    0.708309] pnp 00:02: [io  0x0081-0x0091]
[    0.708311] pnp 00:02: [io  0x0093-0x009f]
[    0.708312] pnp 00:02: [io  0x00c0-0x00df]
[    0.708314] pnp 00:02: [dma 4]
[    0.708330] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.708403] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    0.708420] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.708427] pnp 00:04: [io  0x00f0]
[    0.708438] pnp 00:04: [irq 13]
[    0.708453] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.708460] pnp 00:05: [io  0x0061]
[    0.708462] pnp 00:05: [io  0x0063]
[    0.708463] pnp 00:05: [io  0x0065]
[    0.708464] pnp 00:05: [io  0x0067]
[    0.708465] pnp 00:05: [io  0x0080]
[    0.708467] pnp 00:05: [io  0x0092]
[    0.708468] pnp 00:05: [io  0x00b2-0x00b3]
[    0.708469] pnp 00:05: [io  0x1000-0x100f]
[    0.708471] pnp 00:05: [io  0xffff]
[    0.708473] pnp 00:05: [io  0xffff]
[    0.708474] pnp 00:05: [io  0x0400-0x0453]
[    0.708475] pnp 00:05: [io  0x0458-0x047f]
[    0.708477] pnp 00:05: [io  0x0500-0x057f]
[    0.708478] pnp 00:05: [io  0x0900-0x097f]
[    0.708509] system 00:05: [io  0x1000-0x100f] has been reserved
[    0.708511] system 00:05: [io  0xffff] has been reserved
[    0.708513] system 00:05: [io  0xffff] has been reserved
[    0.708515] system 00:05: [io  0x0400-0x0453] has been reserved
[    0.708517] system 00:05: [io  0x0458-0x047f] has been reserved
[    0.708519] system 00:05: [io  0x0500-0x057f] has been reserved
[    0.708521] system 00:05: [io  0x0900-0x097f] has been reserved
[    0.708523] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.708529] pnp 00:06: [io  0x0070-0x0077]
[    0.708535] pnp 00:06: [irq 8]
[    0.708551] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.708567] pnp 00:07: [io  0x0454-0x0457]
[    0.708593] system 00:07: [io  0x0454-0x0457] has been reserved
[    0.708596] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.708881] pnp 00:08: [io  0x0060]
[    0.708882] pnp 00:08: [io  0x0064]
[    0.708889] pnp 00:08: [irq 1]
[    0.708908] pnp 00:08: Plug and Play ACPI device, IDs PNP0320 PNP0303 (active)
[    0.709105] pnp 00:09: [irq 12]
[    0.709134] pnp 00:09: Plug and Play ACPI device, IDs SYN0502 PNP0f13 (active)
[    0.709160] pnp 00:0a: [io  0x004e-0x004f]
[    0.709161] pnp 00:0a: [mem 0xfed40000-0xfed44fff]
[    0.709182] pnp 00:0a: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
[    0.709362] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    0.709364] pnp 00:0b: [mem 0xfed10000-0xfed17fff]
[    0.709365] pnp 00:0b: [mem 0xfed18000-0xfed18fff]
[    0.709367] pnp 00:0b: [mem 0xfed19000-0xfed19fff]
[    0.709368] pnp 00:0b: [mem 0xf8000000-0xfbffffff]
[    0.709369] pnp 00:0b: [mem 0xfed20000-0xfed3ffff]
[    0.709371] pnp 00:0b: [mem 0xfed90000-0xfed93fff]
[    0.709381] pnp 00:0b: [mem 0xfed45000-0xfed8ffff]
[    0.709382] pnp 00:0b: [mem 0xff000000-0xffffffff]
[    0.709383] pnp 00:0b: [mem 0xfee00000-0xfeefffff]
[    0.709385] pnp 00:0b: [mem 0xfed08000-0xfed08fff]
[    0.709433] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.709435] system 00:0b: [mem 0xfed10000-0xfed17fff] could not be reserved
[    0.709437] system 00:0b: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.709439] system 00:0b: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.709441] system 00:0b: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.709443] system 00:0b: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.709445] system 00:0b: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.709447] system 00:0b: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.709449] system 00:0b: [mem 0xff000000-0xffffffff] could not be reserved
[    0.709451] system 00:0b: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.709453] system 00:0b: [mem 0xfed08000-0xfed08fff] has been reserved
[    0.709455] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.709472] pnp 00:0c: [mem 0x000e0000-0x000effff]
[    0.709474] pnp 00:0c: [mem 0x000f0000-0x000fffff]
[    0.709513] system 00:0c: [mem 0x000e0000-0x000effff] could not be reserved
[    0.709515] system 00:0c: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.709517] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.709606] pnp 00:0d: [mem 0x20000000-0x201fffff]
[    0.709608] pnp 00:0d: [mem 0x40000000-0x401fffff]
[    0.709653] system 00:0d: [mem 0x20000000-0x201fffff] has been reserved
[    0.709655] system 00:0d: [mem 0x40000000-0x401fffff] has been reserved
[    0.709657] system 00:0d: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.709699] pnp 00:0e: [mem 0xfed98000-0xfed9ffff]
[    0.709744] system 00:0e: [mem 0xfed98000-0xfed9ffff] has been reserved
[    0.709746] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.709758] pnp: PnP ACPI: found 15 devices
[    0.709759] ACPI: ACPI bus type pnp unregistered
[    0.715828] PCI: max bus depth: 2 pci_try_num: 3
[    0.715880] pci 0000:00:04.0: BAR 0: assigned [mem 0xdfa00000-0xdfa07fff 64bit]
[    0.715883] pci 0000:00:04.0: BAR 0: error updating (0xdfa00004 != 0xfed98004)
[    0.715939] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    0.715942] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.715947] pci 0000:00:1c.0:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.715952] pci 0000:00:1c.0:   bridge window [mem 0xf2700000-0xf27fffff 64bit pref]
[    0.715958] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    0.715961] pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
[    0.715967] pci 0000:00:1c.1:   bridge window [mem 0xf7a00000-0xf7afffff]
[    0.715971] pci 0000:00:1c.1:   bridge window [mem 0xf2500000-0xf25fffff 64bit pref]
[    0.715977] pci 0000:00:1c.2: PCI bridge to [bus 03-03]
[    0.715980] pci 0000:00:1c.2:   bridge window [io  0xb000-0xbfff]
[    0.715985] pci 0000:00:1c.2:   bridge window [mem 0xf7900000-0xf79fffff]
[    0.715990] pci 0000:00:1c.2:   bridge window [mem 0xf2300000-0xf23fffff 64bit pref]
[    0.716001] pci 0000:04:00.0: BAR 16: can't assign mem (size 0x4000000)
[    0.716006] pci 0000:04:00.0: BAR 15: can't assign mem pref (size 0x4000000)
[    0.716008] pci 0000:04:00.0: BAR 14: assigned [io  0x8000-0x80ff]
[    0.716010] pci 0000:04:00.0: BAR 13: assigned [io  0x8400-0x84ff]
[    0.716012] pci 0000:04:00.0: CardBus bridge to [bus 05-08]
[    0.716014] pci 0000:04:00.0:   bridge window [io  0x8400-0x84ff]
[    0.716020] pci 0000:04:00.0:   bridge window [io  0x8000-0x80ff]
[    0.716026] pci 0000:00:1c.3: PCI bridge to [bus 04-0c]
[    0.716029] pci 0000:00:1c.3:   bridge window [io  0x8000-0x9fff]
[    0.716034] pci 0000:00:1c.3:   bridge window [mem 0xf5800000-0xf77fffff]
[    0.716038] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff 64bit pref]
[    0.716045] pci 0000:00:1c.4: PCI bridge to [bus 0d-0d]
[    0.716048] pci 0000:00:1c.4:   bridge window [io  0xa000-0xafff]
[    0.716053] pci 0000:00:1c.4:   bridge window [mem 0xf7800000-0xf78fffff]
[    0.716057] pci 0000:00:1c.4:   bridge window [mem 0xf2100000-0xf21fffff 64bit pref]
[    0.716115] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.716117] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.716119] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.716120] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.716122] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.716124] pci_bus 0000:00: resource 9 [mem 0x000dc000-0x000dffff]
[    0.716125] pci_bus 0000:00: resource 10 [mem 0xdfa00000-0xfeafffff]
[    0.716127] pci_bus 0000:00: resource 11 [mem 0xfed40000-0xfed44fff]
[    0.716129] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.716130] pci_bus 0000:01: resource 1 [mem 0xf7b00000-0xf7bfffff]
[    0.716132] pci_bus 0000:01: resource 2 [mem 0xf2700000-0xf27fffff 64bit pref]
[    0.716134] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.716136] pci_bus 0000:02: resource 1 [mem 0xf7a00000-0xf7afffff]
[    0.716137] pci_bus 0000:02: resource 2 [mem 0xf2500000-0xf25fffff 64bit pref]
[    0.716139] pci_bus 0000:03: resource 0 [io  0xb000-0xbfff]
[    0.716141] pci_bus 0000:03: resource 1 [mem 0xf7900000-0xf79fffff]
[    0.716142] pci_bus 0000:03: resource 2 [mem 0xf2300000-0xf23fffff 64bit pref]
[    0.716144] pci_bus 0000:04: resource 0 [io  0x8000-0x9fff]
[    0.716146] pci_bus 0000:04: resource 1 [mem 0xf5800000-0xf77fffff]
[    0.716147] pci_bus 0000:04: resource 2 [mem 0xf0000000-0xf1ffffff 64bit pref]
[    0.716149] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    0.716151] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    0.716152] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    0.716154] pci_bus 0000:04: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.716155] pci_bus 0000:04: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.716157] pci_bus 0000:04: resource 9 [mem 0x000dc000-0x000dffff]
[    0.716159] pci_bus 0000:04: resource 10 [mem 0xdfa00000-0xfeafffff]
[    0.716160] pci_bus 0000:04: resource 11 [mem 0xfed40000-0xfed44fff]
[    0.716162] pci_bus 0000:05: resource 0 [io  0x8400-0x84ff]
[    0.716163] pci_bus 0000:05: resource 1 [io  0x8000-0x80ff]
[    0.716165] pci_bus 0000:0d: resource 0 [io  0xa000-0xafff]
[    0.716167] pci_bus 0000:0d: resource 1 [mem 0xf7800000-0xf78fffff]
[    0.716168] pci_bus 0000:0d: resource 2 [mem 0xf2100000-0xf21fffff 64bit pref]
[    0.716228] NET: Registered protocol family 2
[    0.716279] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.716588] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.717174] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.717324] TCP: Hash tables configured (established 262144 bind 65536)
[    0.717326] TCP reno registered
[    0.717329] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.717352] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.717467] NET: Registered protocol family 1
[    0.717479] pci 0000:00:02.0: Boot video device
[    1.064802] pci 0000:02:00.0: power state changed by ACPI to D0
[    1.064807] pci 0000:02:00.0: power state changed by ACPI to D0
[    1.064864] PCI: CLS 64 bytes, default 64
[    1.064899] Unpacking initramfs...
[    1.111364] Freeing initrd memory: 3024k freed
[    1.111766] DMAR: No ATSR found
[    1.111806] IOMMU 0 0xfed90000: using Queued invalidation
[    1.111808] IOMMU 1 0xfed91000: using Queued invalidation
[    1.111810] IOMMU: Setting RMRR:
[    1.111824] IOMMU: Setting identity map for device 0000:00:02.0 [0xdb800000 - 0xdf9fffff]
[    1.112190] IOMMU: Setting identity map for device 0000:00:1d.0 [0xdadcd000 - 0xdade3fff]
[    1.112212] IOMMU: Setting identity map for device 0000:00:1a.0 [0xdadcd000 - 0xdade3fff]
[    1.112225] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    1.112234] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    1.112463] PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
[    1.129474] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.129945] VFS: Disk quotas dquot_6.5.2
[    1.129974] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.130035] msgmni has been set to 15888
[    1.130185] alg: No test for stdrng (krng)
[    1.130216] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.130219] io scheduler noop registered
[    1.130222] io scheduler deadline registered
[    1.130245] io scheduler cfq registered (default)
[    1.130357] pcieport 0000:00:1c.0: irq 42 for MSI/MSI-X
[    1.130461] pcieport 0000:00:1c.1: irq 43 for MSI/MSI-X
[    1.130560] pcieport 0000:00:1c.2: irq 44 for MSI/MSI-X
[    1.130690] pcieport 0000:00:1c.4: irq 45 for MSI/MSI-X
[    1.130778] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    1.130783] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    1.130794] pcieport 0000:00:1c.1: Signaling PME through PCIe PME interrupt
[    1.130796] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    1.130800] pcie_pme 0000:00:1c.1:pcie01: service driver pcie_pme loaded
[    1.130813] pcieport 0000:00:1c.2: Signaling PME through PCIe PME interrupt
[    1.130815] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    1.130819] pcie_pme 0000:00:1c.2:pcie01: service driver pcie_pme loaded
[    1.130831] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    1.130833] pci 0000:0d:00.0: Signaling PME through PCIe PME interrupt
[    1.130834] pci 0000:0d:00.1: Signaling PME through PCIe PME interrupt
[    1.130838] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    1.130860] intel_idle: MWAIT substates: 0x21120
[    1.130861] intel_idle: v0.4 model 0x2A
[    1.130862] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.130896] GHES: HEST is not enabled!
[    1.130934] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.151556] 0000:00:16.3: ttyS0 at I/O 0xe0e0 (irq = 19) is a 16550A
[    1.151758] Linux agpgart interface v0.103
[    1.151809] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.151944] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    1.153047] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.153162] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[    1.153228] i8042: PNP: PS/2 Controller [PNP0303:K106,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.161300] i8042: Detected active multiplexing controller, rev 1.0
[    1.164995] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.164999] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.165019] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.165033] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.165047] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.165133] mousedev: PS/2 mouse device common for all mice
[    1.165171] rtc_cmos 00:06: RTC can wake from S4
[    1.165267] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    1.165293] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.165354] cpuidle: using governor ladder
[    1.165430] cpuidle: using governor menu
[    1.165567] TCP cubic registered
[    1.165653] NET: Registered protocol family 10
[    1.166007] Mobile IPv6
[    1.166009] NET: Registered protocol family 17
[    1.166011] Registering the dns_resolver key type
[    1.166275] PM: Hibernation image not present or could not be loaded.
[    1.166289] registered taskstats version 1
[    1.166819] rtc_cmos 00:06: setting system clock to 2012-05-09 16:45:27 UTC (1336581927)
[    1.167460] Freeing unused kernel memory: 440k freed
[    1.167507] Write protecting the kernel read-only data: 6144k
[    1.168417] Freeing unused kernel memory: 348k freed
[    1.169473] Freeing unused kernel memory: 432k freed
[    1.173110] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.180090] udevd[57]: starting version 175
[    1.212049] SCSI subsystem initialized
[    1.214107] libata version 3.00 loaded.
[    1.214755] ahci 0000:00:1f.2: version 3.0
[    1.214822] ahci 0000:00:1f.2: irq 46 for MSI/MSI-X
[    1.214856] ahci: SSS flag set, parallel bus scan disabled
[    1.214886] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3 impl SATA mode
[    1.214890] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems apst 
[    1.214895] ahci 0000:00:1f.2: setting latency timer to 64
[    1.214986] thermal LNXTHERM:00: registered as thermal_zone0
[    1.214988] ACPI: Thermal Zone [TZ00] (72 C)
[    1.218307] thermal LNXTHERM:01: registered as thermal_zone1
[    1.218311] ACPI: Thermal Zone [TZ01] (72 C)
[    1.219188] scsi0 : ahci
[    1.219931] scsi1 : ahci
[    1.220493] scsi2 : ahci
[    1.221505] scsi3 : ahci
[    1.221778] scsi4 : ahci
[    1.222263] scsi5 : ahci
[    1.222669] ata1: SATA max UDMA/133 abar m2048@0xf7c2e000 port 0xf7c2e100 irq 46
[    1.222674] ata2: SATA max UDMA/133 abar m2048@0xf7c2e000 port 0xf7c2e180 irq 46
[    1.222677] ata3: DUMMY
[    1.222678] ata4: DUMMY
[    1.222680] ata5: DUMMY
[    1.222681] ata6: DUMMY
[    1.526956] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.528040] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    1.528051] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    1.538356] ata1.00: ATA-9: INTEL SSDSC2CW240A3, 400i, max UDMA/133
[    1.538366] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.547875] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    1.547886] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    1.558322] ata1.00: configured for UDMA/133
[    1.558591] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2CW24 400i PQ: 0 ANSI: 5
[    1.863324] ata2: SATA link down (SStatus 0 SControl 300)
[    1.866993] sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/223 GiB)
[    1.867095] sd 0:0:0:0: [sda] Write Protect is off
[    1.867098] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.867130] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.868175]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    1.868760] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.113821] Refined TSC clocksource calibration: 2594.106 MHz.
[    2.113832] Switching to clocksource tsc
[    2.131727] PM: Marking nosave pages: 000000000009e000 - 0000000000100000
[    2.131731] PM: Marking nosave pages: 0000000020000000 - 0000000020200000
[    2.131739] PM: Marking nosave pages: 0000000040000000 - 0000000040200000
[    2.131747] PM: Marking nosave pages: 00000000dac34000 - 00000000dad8e000
[    2.131752] PM: Marking nosave pages: 00000000dad9e000 - 00000000dada0000
[    2.131754] PM: Marking nosave pages: 00000000dada1000 - 00000000dade8000
[    2.131756] PM: Marking nosave pages: 00000000daf3a000 - 00000000dafe8000
[    2.131760] PM: Marking nosave pages: 00000000dafec000 - 0000000100000000
[    2.132312] PM: Basic memory bitmaps created
[    2.158150] PM: Basic memory bitmaps freed
[    2.166388] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[    2.300013] udevd[326]: starting version 175
[    2.344831] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[    2.346913] ACPI: Lid Switch [LID]
[    2.346986] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    2.346991] ACPI: Power Button [PWRB]
[    2.347913] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    2.347919] ACPI: Power Button [PWRF]
[    2.358923] rts_pstor: module is from the staging directory, the quality is unknown, you have been warned.
[    2.359528] Initializing Realtek PCIE storage driver...
[    2.362909] e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k
[    2.362912] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    2.362960] e1000e 0000:00:19.0: setting latency timer to 64
[    2.363094] e1000e 0000:00:19.0: irq 47 for MSI/MSI-X
[    2.365002] usbcore: registered new interface driver usbfs
[    2.365014] usbcore: registered new interface driver hub
[    2.366099] Resource length: 0x1000
[    2.366121] Original address: 0xf7801000, remapped address: 0xffffc9000003e000
[    2.366155] pci->irq = 16
[    2.366157] rtsx_acquire_irq: chip->msi_en = 0, pci->irq = 16
[    2.368792] usbcore: registered new device driver usb
[    2.383071] xhci_hcd 0000:02:00.0: power state changed by ACPI to D0
[    2.383078] xhci_hcd 0000:02:00.0: power state changed by ACPI to D0
[    2.383115] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    2.383123] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
[    2.383372] xhci_hcd 0000:02:00.0: irq 17, io mem 0xf7a00000
[    2.383451] xhci_hcd 0000:02:00.0: irq 48 for MSI/MSI-X
[    2.383458] xhci_hcd 0000:02:00.0: irq 49 for MSI/MSI-X
[    2.383467] xhci_hcd 0000:02:00.0: irq 50 for MSI/MSI-X
[    2.383474] xhci_hcd 0000:02:00.0: irq 51 for MSI/MSI-X
[    2.383481] xhci_hcd 0000:02:00.0: irq 52 for MSI/MSI-X
[    2.383616] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.383620] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.383622] usb usb1: Product: xHCI Host Controller
[    2.383624] usb usb1: Manufacturer: Linux 3.3.5+cf-s10 xhci_hcd
[    2.383627] usb usb1: SerialNumber: 0000:02:00.0
[    2.383724] xHCI xhci_add_endpoint called for root hub
[    2.383726] xHCI xhci_check_bandwidth called for root hub
[    2.383760] hub 1-0:1.0: USB hub found
[    2.383769] hub 1-0:1.0: 2 ports detected
[    2.383837] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    2.383841] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[    2.386790] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.386793] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.386796] usb usb2: Product: xHCI Host Controller
[    2.386798] usb usb2: Manufacturer: Linux 3.3.5+cf-s10 xhci_hcd
[    2.386801] usb usb2: SerialNumber: 0000:02:00.0
[    2.386893] xHCI xhci_add_endpoint called for root hub
[    2.386896] xHCI xhci_check_bandwidth called for root hub
[    2.386934] hub 2-0:1.0: USB hub found
[    2.386944] hub 2-0:1.0: 2 ports detected
[    2.389926] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    2.390105] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    2.390113] ACPI: Battery Slot [BAT1] (battery present)
[    2.391131] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.391140] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    2.391536] sdhci: Secure Digital Host Controller Interface driver
[    2.391538] sdhci: Copyright(c) Pierre Ossman
[    2.393817] cfg80211: Calling CRDA to update world regulatory domain
[    2.393865] ACPI: AC Adapter [AC] (on-line)
[    2.394125] yenta_cardbus 0000:04:00.0: CardBus bridge found [10f7:8338]
[    2.394159] yenta_cardbus 0000:04:00.0: address space collision: [mem 0xf0000000-0xf13fffff] conflicts with PCI Bus 0000:04 [mem 0xf0000000-0xf1ffffff 64bit pref]
[    2.394163] yenta_cardbus 0000:04:00.0: Preassigned resource 3 busy or not available, reconfiguring...
[    2.394167] yenta_cardbus 0000:04:00.0: CardBus bridge to [bus 05-08]
[    2.394170] yenta_cardbus 0000:04:00.0:   bridge window [io  0x8400-0x84ff]
[    2.394176] yenta_cardbus 0000:04:00.0:   bridge window [io  0x8000-0x80ff]
[    2.394183] yenta_cardbus 0000:04:00.0:   bridge window [mem 0xf5800000-0xf6bfffff pref]
[    2.394190] yenta_cardbus 0000:04:00.0:   bridge window [mem 0xf7000000-0xf73fffff]
[    2.394789] input: Panasonic Laptop Support as /devices/virtual/input/input5
[    2.396052] [drm] Initialized drm 1.1.0 20060810
[    2.408544] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
[    2.408548] Copyright(c) 2003-2011 Intel Corporation
[    2.408755] iwlwifi 0000:03:00.0: pci_resource_len = 0x00002000
[    2.408759] iwlwifi 0000:03:00.0: pci_resource_base = ffffc90000060000
[    2.408762] iwlwifi 0000:03:00.0: HW Revision ID = 0x5E
[    2.408839] iwlwifi 0000:03:00.0: irq 53 for MSI/MSI-X
[    2.408870] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUG disabled
[    2.408872] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[    2.408873] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
[    2.408875] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE disabled
[    2.408876] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_P2P enabled
[    2.408881] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN, REV=0x84
[    2.408951] iwlwifi 0000:03:00.0: L1 Disabled; Enabling L0S
[    2.419964] iwlwifi 0000:03:00.0: device EEPROM VER=0x540, CALIB=0x6
[    2.419968] iwlwifi 0000:03:00.0: Device SKU: 0x1F0
[    2.419991] iwlwifi 0000:03:00.0: Tunable channels: 13 802.11bg, 24 802.11a channels
[    2.438999] iwlwifi 0000:03:00.0: loaded firmware version 41.28.5.1 build 33926
[    2.439146] Registered led device: phy0-led
[    2.442148] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[    2.516842] yenta_cardbus 0000:04:00.0: ISA IRQ mask 0x0000, PCI irq 19
[    2.516847] yenta_cardbus 0000:04:00.0: Socket status: 30000006
[    2.516852] yenta_cardbus 0000:04:00.0: pcmcia: parent PCI bridge window: [io  0x8000-0x9fff]
[    2.516855] yenta_cardbus 0000:04:00.0: pcmcia: parent PCI bridge window: [mem 0xf5800000-0xf77fffff]
[    2.516857] pcmcia_socket pcmcia_socket0: cs: memory probe 0xf5800000-0xf77fffff: excluding 0xf5800000-0xf6dfffff 0xf7000000-0xf73fffff
[    2.516867] yenta_cardbus 0000:04:00.0: pcmcia: parent PCI bridge window: [mem 0xf0000000-0xf1ffffff 64bit pref]
[    2.516869] pcmcia_socket pcmcia_socket0: cs: memory probe 0xf0000000-0xf1ffffff: excluding 0xf0000000-0xf1ffffff
[    2.520680] pcmcia_socket pcmcia_socket0: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe0000-0xfffff
[    2.520700] pcmcia_socket pcmcia_socket0: cs: memory probe 0xa0000000-0xa0ffffff: excluding 0xa0000000-0xa0ffffff
[    2.520715] pcmcia_socket pcmcia_socket0: cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
[    2.559265] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1) 70:58:12:dd:45:b5
[    2.559268] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    2.559305] e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
[    2.559392] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.559396] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    2.559402] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.559435] ehci_hcd 0000:00:1a.0: debug port 2
[    2.563329] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    2.563339] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf7c30000
[    2.566122] scsi6 : SCSI emulation for PCI-Express Mass Storage devices
[    2.566204] rts_pstor: waiting for device to settle before scanning
[    2.566232] sdhci-pci 0000:0d:00.1: SDHCI controller found [10ec:5209] (rev 1)
[    2.566289] sdhci-pci 0000:0d:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.566311] sdhci-pci 0000:0d:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.566339] Registered led device: mmc0::
[    2.566372] sdhci-pci 0000:0d:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.567888] mmc0: SDHCI controller on PCI [0000:0d:00.1] using DMA
[    2.568892] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.568919] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.568921] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.568924] usb usb3: Product: EHCI Host Controller
[    2.568926] usb usb3: Manufacturer: Linux 3.3.5+cf-s10 ehci_hcd
[    2.568928] usb usb3: SerialNumber: 0000:00:1a.0
[    2.569048] hub 3-0:1.0: USB hub found
[    2.569053] hub 3-0:1.0: 3 ports detected
[    2.569164] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    2.569168] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    2.569175] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    2.569213] ehci_hcd 0000:00:1d.0: debug port 2
[    2.573103] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    2.573126] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf7c2f000
[    2.578992] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.579030] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    2.579032] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.579034] usb usb4: Product: EHCI Host Controller
[    2.579036] usb usb4: Manufacturer: Linux 3.3.5+cf-s10 ehci_hcd
[    2.579037] usb usb4: SerialNumber: 0000:00:1d.0
[    2.579213] hub 4-0:1.0: USB hub found
[    2.579217] hub 4-0:1.0: 3 ports detected
[    2.579294] ACPI Warning: 0x000000000000e040-0x000000000000e05f SystemIO conflicts with Region \_SB_.PCI0.SBUS.SMBI 1 (20120111/utaddress-251)
[    2.579300] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    2.579331] i915 0000:00:02.0: setting latency timer to 64
[    2.595981] sdhci-pci 0000:0d:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.625920] sdhci-pci 0000:0d:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.646244] mtrr: type mismatch for e0000000,10000000 old: write-back new: write-combining
[    2.646247] [drm] MTRR allocation failed.  Graphics performance may suffer.
[    2.646570] i915 0000:00:02.0: irq 54 for MSI/MSI-X
[    2.646577] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    2.646579] [drm] Driver supports precise vblank timestamp query.
[    2.646611] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.655865] sdhci-pci 0000:0d:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.684773] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    2.686177] sdhci-pci 0000:0d:00.1: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.730246] usb 1-1: New USB device found, idVendor=046d, idProduct=c526
[    2.730256] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.730262] usb 1-1: Product: USB Receiver
[    2.730266] usb 1-1: Manufacturer: Logitech
[    2.763365] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1c.1/0000:02:00.0/usb1/1-1/1-1:1.0/input/input6
[    2.763528] generic-usb 0003:046D:C526.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:02:00.0-1/input0
[    2.783292] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1c.1/0000:02:00.0/usb1/1-1/1-1:1.1/input/input7
[    2.784026] generic-usb 0003:046D:C526.0002: input,hiddev0,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:02:00.0-1/input1
[    2.784049] usbcore: registered new interface driver usbhid
[    2.784051] usbhid: USB HID core driver
[    2.870419] usb 3-1: new high-speed USB device number 2 using ehci_hcd
[    2.984500] usb 3-1: New USB device found, idVendor=8087, idProduct=0024
[    2.984503] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.984777] hub 3-1:1.0: USB hub found
[    2.984838] hub 3-1:1.0: 6 ports detected
[    3.004260] fbcon: inteldrmfb (fb0) is primary device
[    3.004875] [drm] Changing LVDS panel from (+hsync, +vsync) to (-hsync, -vsync)
[    3.058803] psmouse serio2: synaptics: Touchpad model: 1, fw: 6.2, id: 0x39a0b2, caps: 0xa04751/0x200000/0x0
[    3.087022] usb 4-1: new high-speed USB device number 2 using ehci_hcd
[    3.101141] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio2/input/input8
[    3.201281] usb 4-1: New USB device found, idVendor=8087, idProduct=0024
[    3.201283] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.201592] hub 4-1:1.0: USB hub found
[    3.201674] hub 4-1:1.0: 8 ports detected
[    3.275703] usb 3-1.3: new high-speed USB device number 3 using ehci_hcd
[    3.361156] usb 3-1.3: New USB device found, idVendor=8086, idProduct=0186
[    3.361163] usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.361168] usb 3-1.3: Product: Intel(R) Centrino(R) Advanced-N + WiMAX 6250
[    3.361172] usb 3-1.3: Manufacturer: Intel(R) Corporation
[    3.489480] Console: switching to colour frame buffer device 160x50
[    3.491627] fb0: inteldrmfb frame buffer device
[    3.491629] drm: registered panic notifier
[    3.497361] acpi device:33: registered as cooling_device4
[    3.497563] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input9
[    3.497625] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    3.497673] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    3.497707] snd_hda_intel 0000:00:1b.0: power state changed by ACPI to D0
[    3.497712] snd_hda_intel 0000:00:1b.0: power state changed by ACPI to D0
[    3.497803] snd_hda_intel 0000:00:1b.0: irq 55 for MSI/MSI-X
[    3.564161] rts_pstor: device scan complete
[    3.564308] scsi 6:0:0:0: Direct-Access     Generic- xD/SD/M.S.       1.00 PQ: 0 ANSI: 0 CCS
[    3.564366] Bad LUN (0:1)
[    3.564478] Bad target number (1:0)
[    3.564569] Bad target number (2:0)
[    3.564652] Bad target number (3:0)
[    3.564783] Bad target number (4:0)
[    3.564950] Bad target number (5:0)
[    3.565074] Bad target number (6:0)
[    3.565129] Bad target number (7:0)
[    3.565412] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[    4.014428] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input10
[    4.019037] HDMI status: Codec=3 Pin=6 Presence_Detect=0 ELD_Valid=0
[    4.019090] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    4.019155] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[    4.019208] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    7.313092] Adding 8103932k swap on /dev/sda6.  Priority:-1 extents:1 across:8103932k SS
[    7.323318] EXT4-fs (sda5): re-mounted. Opts: (null)
[    7.359230] EXT4-fs (sda5): re-mounted. Opts: errors=remount-ro
[    7.372814] loop: module loaded
[    7.559561] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    7.759675] RPC: Registered named UNIX socket transport module.
[    7.759678] RPC: Registered udp transport module.
[    7.759679] RPC: Registered tcp transport module.
[    7.759680] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.763975] FS-Cache: Loaded
[    7.769593] FS-Cache: Netfs 'nfs' registered for caching
[    7.773740] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    7.847925] fuse init (API version 7.18)
[    9.013765] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input14

-- 
Martin Lucina
http://lucina.net/ (interwebs/blogs/rants/consulting)
martin@lucina.net  (smtp/xmpp/jabber/gtalk)
@matolucina        (twitter)
