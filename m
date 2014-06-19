From: Thomas Richter <thor@math.tu-berlin.de>
Subject: Occasional kernel oops in acpi_ex_insert_into_field
Date: Thu, 19 Jun 2014 20:54:47 +0200
Message-ID: <53A331F7.2050309@math.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-2.alumni.tu-berlin.de ([130.149.5.29]:44142 "EHLO
	mail-2.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754100AbaFSTFO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2014 15:05:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org

Hi folks,

booting an HP EliteBook 6930p with a 3.12.20 kernel seems to result in a 
kernel oops once in a time. Unfortunately, the kernel oops does not show 
up in /var/log/messages, I can thus only report the problem from writing 
down the oops manually.

Apparently, the problem is a double divide-by-zero error generated from 
within acpi_ex_insert_into_field + 0xc7,called from 
acpi_ex_write_data_to_field.

 From the kernel sources, I suspect that this division by zero is due to 
the ACPI_ROUND_UP_TO() macro, line 919ff in exfldio.c. It seems that 
access_bit_width is zero when this happens.

 From the kernel log: (though this time booting without a problem)

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.12.20 (root@dewshine) (gcc version 4.7.2 
(Debian 4.7.2-5) ) #2 SMP Sun May 18 15:34:24 CEST 2014
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.12.20 
root=/dev/sda1 ro vga=792 quiet
[    0.000000] Disabled fast string operations
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000ef000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000076821fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076822000-0x0000000076823fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000076824000-0x000000007776ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000077770000-0x000000007777ffff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000077780000-0x0000000079e9afff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079e9b000-0x000000007a09afff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007a09b000-0x000000007b892fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007b893000-0x000000007b89afff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000007b89b000-0x000000007b8befff] usable
[    0.000000] BIOS-e820: [mem 0x000000007b8bf000-0x000000007b8cefff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000007b8cf000-0x000000007b9cefff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007b9cf000-0x000000007b9fefff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007b9ff000-0x000000007b9fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ba00000-0x000000007fffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed13fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed18000-0x00000000fed19fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe80000-0x00000000ffffffff] 
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Hewlett-Packard HP EliteBook 6930p/30DB, BIOS 68PCU 
Ver. F.20 12/08/2011
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x7ba00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFE00000 mask FFFE00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 077770000 mask FFFFF0000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 
0x7010600070106
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x0170c000, 0x0170cfff] PGTABLE
[    0.000000] BRK [0x0170d000, 0x0170dfff] PGTABLE
[    0.000000] BRK [0x0170e000, 0x0170efff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7b600000-0x7b7fffff]
[    0.000000]  [mem 0x7b600000-0x7b7fffff] page 2M
[    0.000000] BRK [0x0170f000, 0x0170ffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x78000000-0x79e9afff]
[    0.000000]  [mem 0x78000000-0x79dfffff] page 2M
[    0.000000]  [mem 0x79e00000-0x79e9afff] page 4k
[    0.000000] BRK [0x01710000, 0x01710fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7a09b000-0x7b5fffff]
[    0.000000]  [mem 0x7a09b000-0x7a1fffff] page 4k
[    0.000000]  [mem 0x7a200000-0x7b5fffff] page 2M
[    0.000000] BRK [0x01711000, 0x01711fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x00100000-0x76821fff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x767fffff] page 2M
[    0.000000]  [mem 0x76800000-0x76821fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x76824000-0x7776ffff]
[    0.000000]  [mem 0x76824000-0x769fffff] page 4k
[    0.000000]  [mem 0x76a00000-0x775fffff] page 2M
[    0.000000]  [mem 0x77600000-0x7776ffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x77780000-0x77ffffff]
[    0.000000]  [mem 0x77780000-0x777fffff] page 4k
[    0.000000]  [mem 0x77800000-0x77ffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x7b800000-0x7b892fff]
[    0.000000]  [mem 0x7b800000-0x7b892fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x7b89b000-0x7b8befff]
[    0.000000]  [mem 0x7b89b000-0x7b8befff] page 4k
[    0.000000] init_memory_mapping: [mem 0x7b9ff000-0x7b9fffff]
[    0.000000]  [mem 0x7b9ff000-0x7b9fffff] page 4k
[    0.000000] ACPI: RSDP 00000000000f68c0 00024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 000000007b9fe120 00084 (v01 HPQOEM SLIC-MPC 
0000000F      01000013)
[    0.000000] ACPI: FACP 000000007b9fc000 000F4 (v03 HPQOEM 30DB 
0000000F HP   00000001)
[    0.000000] ACPI: DSDT 000000007b9dc000 1A52F (v01 HPQOEM 30DB 
00000001 INTL 20060912)
[    0.000000] ACPI: FACS 000000007b99c000 00040
[    0.000000] ACPI: HPET 000000007b9fb000 00038 (v01 HPQOEM 30DB 
00000001 HP   00000001)
[    0.000000] ACPI: APIC 000000007b9fa000 00084 (v01 HPQOEM 30DB 
00000001 HP   00000001)
[    0.000000] ACPI: MCFG 000000007b9f9000 0003C (v01 HPQOEM 30DB 
00000001 HP   00000001)
[    0.000000] ACPI: ASF! 000000007b9f8000 00095 (v32 HPQOEM 30DB 
00000001 HP   00000001)
[    0.000000] ACPI: TCPA 000000007b9f7000 00032 (v02 HPQOEM 30DB 
00000000 HP   00000001)
[    0.000000] ACPI: SSDT 000000007b9d9000 002DD (v01 HPQOEM SataAhci 
00001000 INTL 20060912)
[    0.000000] ACPI: SLIC 000000007b9d7000 00176 (v01 HPQOEM SLIC-MPC 
00000001 HP   00000001)
[    0.000000] ACPI: DMAR 000000007b9d6000 000F8 (v01               ? 
00000001      00000000)
[    0.000000] ACPI: SSDT 000000007b9d5000 0066C (v01  PmRef    CpuPm 
00003000 INTL 20060912)
[    0.000000] ACPI: SSDT 000000007b9d4000 00288 (v01  PmRef  Cpu0Tst 
00003000 INTL 20060912)
[    0.000000] ACPI: SSDT 000000007b9d3000 00225 (v01  PmRef    ApTst 
00003000 INTL 20060912)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0001bfffff] PMD -> 
[ffff880077e00000-ffff8800799fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0x76821fff]
[    0.000000]   node   0: [mem 0x76824000-0x7776ffff]
[    0.000000]   node   0: [mem 0x77780000-0x79e9afff]
[    0.000000]   node   0: [mem 0x7a09b000-0x7b892fff]
[    0.000000]   node   0: [mem 0x7b89b000-0x7b8befff]
[    0.000000]   node   0: [mem 0x7b9ff000-0x7b9fffff]
[    0.000000] On node 0 totalpages: 505412
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6867 pages used for memmap
[    0.000000]   DMA32 zone: 501414 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000eefff]
[    0.000000] PM: Registered nosave memory: [mem 0x000ef000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x76822000-0x76823fff]
[    0.000000] PM: Registered nosave memory: [mem 0x77770000-0x7777ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x79e9b000-0x7a09afff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b893000-0x7b89afff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b8bf000-0x7b8cefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b8cf000-0x7b9cefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b9cf000-0x7b9fefff]
[    0.000000] e820: [mem 0x80000000-0xdfffffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 
nr_node_ids:1
[    0.000000] PERCPU: Embedded 26 pages/cpu @ffff88007b400000 s75136 
r8192 d23168 u524288
[    0.000000] pcpu-alloc: s75136 r8192 d23168 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 498468
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.12.20 
root=/dev/sda1 ro vga=792 quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 
2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 
bytes)
[    0.000000] xsave: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1982044K/2021648K available (4050K kernel code, 
433K rwdata, 1392K rodata, 780K init, 520K bss, 39604K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:4352 nr_irqs:712 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2261.180 MHz processor
[    0.004004] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 4522.36 BogoMIPS (lpj=9044720)
[    0.004007] pid_max: default: 32768 minimum: 301
[    0.004044] Mount-cache hash table entries: 256
[    0.004252] Initializing cgroup subsys blkio
[    0.004256] Initializing cgroup subsys perf_event
[    0.004273] Disabled fast string operations
[    0.004278] CPU: Physical Processor ID: 0
[    0.004279] CPU: Processor Core ID: 0
[    0.004281] mce: CPU supports 6 MCE banks
[    0.004289] CPU0: Thermal monitoring handled by SMI
[    0.004296] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.004296] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32
[    0.004296] tlb_flushall_shift: -1
[    0.004357] Freeing SMP alternatives memory: 16K (ffffffff81684000 - 
ffffffff81688000)
[    0.004359] ACPI: Core revision 20130725
[    0.010527] ACPI: All ACPI Tables successfully acquired
[    0.011318] dmar: Host address width 36
[    0.011321] dmar: DRHD base: 0x000000feb03000 flags: 0x0
[    0.011327] dmar: IOMMU 0: reg_base_addr feb03000 ver 1:0 cap 
c9008020e30260 ecap 1000
[    0.011329] dmar: DRHD base: 0x000000feb01000 flags: 0x0
[    0.011334] dmar: IOMMU 1: reg_base_addr feb01000 ver 1:0 cap 
c0000020630260 ecap 1000
[    0.011335] dmar: DRHD base: 0x000000feb02000 flags: 0x1
[    0.011339] dmar: IOMMU 2: reg_base_addr feb02000 ver 1:0 cap 
c9008020630260 ecap 1000
[    0.011341] dmar: RMRR base: 0x00000077770000 end: 0x0000007777ffff
[    0.011343] dmar: RMRR base: 0x0000007bc00000 end: 0x0000007fffffff
[    0.011854] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.051547] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     P8400  @ 
2.26GHz (fam: 06, model: 17, stepping: 0a)
[    0.052000] Performance Events: PEBS fmt0+, 4-deep LBR, Core2 events, 
Intel PMU driver.
[    0.052000] ... version:                2
[    0.052000] ... bit width:              40
[    0.052000] ... generic registers:      2
[    0.052000] ... value mask:             000000ffffffffff
[    0.052000] ... max period:             000000007fffffff
[    0.052000] ... fixed-purpose events:   3
[    0.052000] ... event mask:             0000000700000003
[    0.052000] smpboot: Booting Node   0, Processors  #   1 OK
[    0.008000] CPU1: Thermal monitoring handled by SMI
[    0.060031] Brought up 2 CPUs
[    0.060036] smpboot: Total of 2 processors activated (9044.72 BogoMIPS)
[    0.061772] devtmpfs: initialized
[    0.061772] PM: Registering ACPI NVS region [mem 
0x77770000-0x7777ffff] (65536 bytes)
[    0.061772] PM: Registering ACPI NVS region [mem 
0x79e9b000-0x7a09afff] (2097152 bytes)
[    0.061772] PM: Registering ACPI NVS region [mem 
0x7b8cf000-0x7b9cefff] (1048576 bytes)
[    0.061772] pinctrl core: initialized pinctrl subsystem
[    0.061772] regulator-dummy: no parameters
[    0.061772] NET: Registered protocol family 16
[    0.061772] cpuidle: using governor ladder
[    0.061772] cpuidle: using governor menu
[    0.061772] ACPI FADT declares the system doesn't support PCIe ASPM, 
so disable it
[    0.061772] ACPI: bus type PCI registered
[    0.061772] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.061772] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.092634] PCI: Using configuration type 1 for base access
[    0.093095] bio: create slab <bio-0> at 0
[    0.093095] ACPI: Added _OSI(Module Device)
[    0.093095] ACPI: Added _OSI(Processor Device)
[    0.093095] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.093095] ACPI: Added _OSI(Processor Aggregator Device)
[    0.093623] ACPI: EC: Look up EC in DSDT
[    0.112024] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.165172] ACPI: SSDT 000000007b8c7c18 00275 (v01  PmRef  Cpu0Ist 
00003000 INTL 20060912)
[    0.165545] ACPI: Dynamic OEM Table Load:
[    0.165548] ACPI: SSDT           (null) 00275 (v01  PmRef  Cpu0Ist 
00003000 INTL 20060912)
[    0.165648] ACPI: SSDT 000000007b8c5618 0057B (v01  PmRef  Cpu0Cst 
00003001 INTL 20060912)
[    0.166005] ACPI: Dynamic OEM Table Load:
[    0.166007] ACPI: SSDT           (null) 0057B (v01  PmRef  Cpu0Cst 
00003001 INTL 20060912)
[    0.184203] ACPI: SSDT 000000007b8c6e18 001D7 (v01  PmRef    ApIst 
00003000 INTL 20060912)
[    0.184587] ACPI: Dynamic OEM Table Load:
[    0.184589] ACPI: SSDT           (null) 001D7 (v01  PmRef    ApIst 
00003000 INTL 20060912)
[    0.196068] ACPI: SSDT 000000007b8c7f18 0008D (v01  PmRef    ApCst 
00003000 INTL 20060912)
[    0.196438] ACPI: Dynamic OEM Table Load:
[    0.196440] ACPI: SSDT           (null) 0008D (v01  PmRef    ApCst 
00003000 INTL 20060912)
[    0.448062] ACPI: Interpreter enabled
[    0.448069] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep 
State [\_S1_] (20130725/hwxface-571)
[    0.448074] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep 
State [\_S2_] (20130725/hwxface-571)
[    0.448087] ACPI: (supports S0 S3 S4 S5)
[    0.448089] ACPI: Using IOAPIC for interrupt routing
[    0.448111] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.448278] ACPI: No dock devices found.
[    0.449150] ACPI: Power Resource [APPR] (off)
[    0.474255] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.476418] acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
[    0.477558] acpi PNP0A08:00: ACPI _OSC control (0x1d) granted
[    0.478109] PCI host bridge to bus 0000:00
[    0.478112] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.478114] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.478116] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.478119] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff]
[    0.478120] pci_bus 0000:00: root bus resource [mem 
0x80000000-0xdfffffff]
[    0.478122] pci_bus 0000:00: root bus resource [mem 
0xf0000000-0xfedfffff]
[    0.478124] pci_bus 0000:00: root bus resource [mem 
0xfee01000-0xffffffff]
[    0.478134] pci 0000:00:00.0: [8086:2a40] type 00 class 0x060000
[    0.478153] DMAR: Forcing write-buffer flush capability
[    0.478154] DMAR: Disabling IOMMU for graphics on this chipset
[    0.478232] pci 0000:00:02.0: [8086:2a42] type 00 class 0x030000
[    0.478244] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff 64bit]
[    0.478252] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff 
64bit pref]
[    0.478257] pci 0000:00:02.0: reg 0x20: [io  0x7110-0x7117]
[    0.478341] pci 0000:00:02.1: [8086:2a43] type 00 class 0x038000
[    0.478351] pci 0000:00:02.1: reg 0x10: [mem 0x90400000-0x904fffff 64bit]
[    0.478488] pci 0000:00:19.0: [8086:10f5] type 00 class 0x020000
[    0.478513] pci 0000:00:19.0: reg 0x10: [mem 0x98800000-0x9881ffff]
[    0.478524] pci 0000:00:19.0: reg 0x14: [mem 0x98827000-0x98827fff]
[    0.478535] pci 0000:00:19.0: reg 0x18: [io  0x70e0-0x70ff]
[    0.478623] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.478675] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.478711] pci 0000:00:1a.0: [8086:2937] type 00 class 0x0c0300
[    0.478768] pci 0000:00:1a.0: reg 0x20: [io  0x70c0-0x70df]
[    0.478907] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.478944] pci 0000:00:1a.1: [8086:2938] type 00 class 0x0c0300
[    0.478999] pci 0000:00:1a.1: reg 0x20: [io  0x70a0-0x70bf]
[    0.479137] pci 0000:00:1a.1: System wakeup disabled by ACPI
[    0.479174] pci 0000:00:1a.2: [8086:2939] type 00 class 0x0c0300
[    0.479229] pci 0000:00:1a.2: reg 0x20: [io  0x7080-0x709f]
[    0.479364] pci 0000:00:1a.2: System wakeup disabled by ACPI
[    0.479412] pci 0000:00:1a.7: [8086:293c] type 00 class 0x0c0320
[    0.479437] pci 0000:00:1a.7: reg 0x10: [mem 0x98826000-0x988263ff]
[    0.479546] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.479599] pci 0000:00:1a.7: System wakeup disabled by ACPI
[    0.479642] pci 0000:00:1b.0: [8086:293e] type 00 class 0x040300
[    0.479663] pci 0000:00:1b.0: reg 0x10: [mem 0x98820000-0x98823fff 64bit]
[    0.479759] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.479813] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.479850] pci 0000:00:1c.0: [8086:2940] type 01 class 0x060400
[    0.479950] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.480039] pci 0000:00:1c.1: [8086:2942] type 01 class 0x060400
[    0.480138] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.480193] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.480231] pci 0000:00:1c.2: [8086:2944] type 01 class 0x060400
[    0.480330] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.480385] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    0.480423] pci 0000:00:1c.4: [8086:2948] type 01 class 0x060400
[    0.480523] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.480578] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.480617] pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300
[    0.480673] pci 0000:00:1d.0: reg 0x20: [io  0x7060-0x707f]
[    0.480807] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.480844] pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300
[    0.480900] pci 0000:00:1d.1: reg 0x20: [io  0x7040-0x705f]
[    0.481033] pci 0000:00:1d.1: System wakeup disabled by ACPI
[    0.481069] pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300
[    0.481125] pci 0000:00:1d.2: reg 0x20: [io  0x7020-0x703f]
[    0.481256] pci 0000:00:1d.2: System wakeup disabled by ACPI
[    0.481304] pci 0000:00:1d.7: [8086:293a] type 00 class 0x0c0320
[    0.481330] pci 0000:00:1d.7: reg 0x10: [mem 0x98825000-0x988253ff]
[    0.481438] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.481491] pci 0000:00:1d.7: System wakeup disabled by ACPI
[    0.481527] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.481638] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    0.481681] pci 0000:00:1f.0: [8086:2917] type 00 class 0x060100
[    0.481898] pci 0000:00:1f.2: [8086:2929] type 00 class 0x010601
[    0.481925] pci 0000:00:1f.2: reg 0x10: [io  0x7108-0x710f]
[    0.481936] pci 0000:00:1f.2: reg 0x14: [io  0x711c-0x711f]
[    0.481947] pci 0000:00:1f.2: reg 0x18: [io  0x7100-0x7107]
[    0.481958] pci 0000:00:1f.2: reg 0x1c: [io  0x7118-0x711b]
[    0.481969] pci 0000:00:1f.2: reg 0x20: [io  0x7000-0x701f]
[    0.481980] pci 0000:00:1f.2: reg 0x24: [mem 0x98824000-0x988247ff]
[    0.482048] pci 0000:00:1f.2: PME# supported from D3hot
[    0.482193] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.482200] pci 0000:00:1c.0:   bridge window [mem 0x98700000-0x987fffff]
[    0.482304] pci 0000:02:00.0: [8086:4236] type 00 class 0x028000
[    0.482344] pci 0000:02:00.0: reg 0x10: [mem 0x98600000-0x98601fff 64bit]
[    0.482537] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.482579] pci 0000:02:00.0: System wakeup disabled by ACPI
[    0.488023] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.488030] pci 0000:00:1c.1:   bridge window [mem 0x98600000-0x986fffff]
[    0.488103] pci 0000:00:1c.2: PCI bridge to [bus 03-43]
[    0.488108] pci 0000:00:1c.2:   bridge window [io  0x5000-0x6fff]
[    0.488113] pci 0000:00:1c.2:   bridge window [mem 0x94600000-0x985fffff]
[    0.488184] pci 0000:00:1c.4: PCI bridge to [bus 44-84]
[    0.488188] pci 0000:00:1c.4:   bridge window [io  0x3000-0x4fff]
[    0.488193] pci 0000:00:1c.4:   bridge window [mem 0x90600000-0x945fffff]
[    0.488269] pci 0000:85:09.0: [1180:0822] type 00 class 0x080500
[    0.488294] pci 0000:85:09.0: reg 0x10: [mem 0x90503000-0x905030ff]
[    0.488409] pci 0000:85:09.0: supports D1 D2
[    0.488411] pci 0000:85:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.488461] pci 0000:85:09.1: [1180:0843] type 00 class 0x088000
[    0.488487] pci 0000:85:09.1: reg 0x10: [mem 0x90502000-0x905020ff]
[    0.488601] pci 0000:85:09.1: supports D1 D2
[    0.488603] pci 0000:85:09.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.488652] pci 0000:85:09.2: [1180:0476] type 02 class 0x060700
[    0.488678] pci 0000:85:09.2: reg 0x10: [mem 0x90500000-0x90500fff]
[    0.488720] pci 0000:85:09.2: supports D1 D2
[    0.488721] pci 0000:85:09.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.488807] pci 0000:00:1e.0: PCI bridge to [bus 85-86] (subtractive 
decode)
[    0.488812] pci 0000:00:1e.0:   bridge window [io  0x2000-0x2fff]
[    0.488817] pci 0000:00:1e.0:   bridge window [mem 0x90500000-0x905fffff]
[    0.488824] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] 
(subtractive decode)
[    0.488826] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] 
(subtractive decode)
[    0.488828] pci 0000:00:1e.0:   bridge window [mem 
0x000a0000-0x000bffff] (subtractive decode)
[    0.488830] pci 0000:00:1e.0:   bridge window [mem 
0x80000000-0xdfffffff] (subtractive decode)
[    0.488832] pci 0000:00:1e.0:   bridge window [mem 
0xf0000000-0xfedfffff] (subtractive decode)
[    0.488834] pci 0000:00:1e.0:   bridge window [mem 
0xfee01000-0xffffffff] (subtractive decode)
[    0.488894] pci_bus 0000:86: busn_res: can not insert [bus 86-ff] 
under [bus 85-86] (conflicts with (null) [bus 85-86])
[    0.488899] pci_bus 0000:86: busn_res: [bus 86-ff] end is updated to 89
[    0.488902] pci_bus 0000:86: busn_res: can not insert [bus 86-89] 
under [bus 85-86] (conflicts with (null) [bus 85-86])
[    0.488906] pci_bus 0000:86: [bus 86-89] partially hidden behind 
transparent bridge 0000:85 [bus 85-86]
[    0.488943] pci_bus 0000:00: on NUMA node 0
[    0.488944] acpi PNP0A08:00: Disabling ASPM (FADT indicates it is 
unsupported)
[    0.489363] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 
14 15)
[    0.489419] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 
14 15) *10
[    0.489472] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 
14 15)
[    0.489525] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 
14 15) *10
[    0.489578] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 
14 15)
[    0.489630] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 
14 15) *10
[    0.489683] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 
14 15) *11
[    0.489737] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 
14 15) *0, disabled.
[    0.490379] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.490386] ACPI: \_SB_.PCI0: notify handler is installed
[    0.490448] Found 1 acpi root devices
[    0.490575] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    0.490618] vgaarb: device added: 
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.490618] vgaarb: loaded
[    0.490618] vgaarb: bridge control possible 0000:00:02.0
[    0.490618] SCSI subsystem initialized
[    0.490618] libata version 3.00 loaded.
[    0.490618] PCI: Using ACPI for IRQ routing
[    0.499253] PCI: pci_cache_line_size set to 64 bytes
[    0.499331] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.499333] e820: reserve RAM buffer [mem 0x76822000-0x77ffffff]
[    0.499335] e820: reserve RAM buffer [mem 0x77770000-0x77ffffff]
[    0.499336] e820: reserve RAM buffer [mem 0x79e9b000-0x7bffffff]
[    0.499338] e820: reserve RAM buffer [mem 0x7b893000-0x7bffffff]
[    0.499339] e820: reserve RAM buffer [mem 0x7b8bf000-0x7bffffff]
[    0.499341] e820: reserve RAM buffer [mem 0x7ba00000-0x7bffffff]
[    0.499449] HPET: 4 timers in total, 0 timers will be used for 
per-cpu timer
[    0.499455] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.499459] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.501007] Switched to clocksource hpet
[    0.501007] pnp: PnP ACPI init
[    0.501007] ACPI: bus type PNP registered
[    0.501007] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.501007] system 00:00: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.501007] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.501007] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.501007] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.501007] system 00:00: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[    0.501007] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.501007] system 00:00: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.501007] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.501007] pnp 00:01: [dma 4]
[    0.501007] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.501007] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    0.501007] pnp 00:03: Plug and Play ACPI device, IDs IFX0102 PNP0c31 
(active)
[    0.501007] system 00:04: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.501007] system 00:04: Plug and Play ACPI device, IDs PNP0103 
PNP0c01 (active)
[    0.501007] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.501007] system 00:06: [io  0x0200-0x027f] has been reserved
[    0.501007] system 00:06: [io  0x1000-0x1003] has been reserved
[    0.501007] system 00:06: [io  0x1010-0x101f] has been reserved
[    0.501007] system 00:06: [io  0xffff] has been reserved
[    0.501007] system 00:06: [io  0x0400-0x047f] could not be reserved
[    0.501007] system 00:06: [io  0x0500-0x057f] has been reserved
[    0.501007] system 00:06: [io  0xef80-0xef9f] has been reserved
[    0.501007] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.501007] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.501060] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.501095] pnp 00:09: Plug and Play ACPI device, IDs SYN0147 SYN0100 
SYN0002 PNP0f13 (active)
[    0.501152] pnp 00:0a: Plug and Play ACPI device, IDs HPQ0004 (active)
[    0.501274] pnp: PnP ACPI: found 11 devices
[    0.501275] ACPI: bus type PNP unregistered
[    0.507591] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to 
[bus 01] add_size 1000
[    0.507596] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000
[    0.507607] pci 0000:00:1c.1: bridge window [io  0x1000-0x0fff] to 
[bus 02] add_size 1000
[    0.507610] pci 0000:00:1c.1: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000
[    0.507620] pci 0000:00:1c.2: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 03-43] add_size 200000
[    0.507631] pci 0000:00:1c.4: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 44-84] add_size 200000
[    0.507650] pci 0000:85:09.2: res[15]=[mem 0x04000000-0x03ffffff 
pref] get_res_add_size add_size 4000000
[    0.507653] pci 0000:00:1e.0: bridge window [mem 
0x04000000-0x03ffffff pref] to [bus 85-86] add_size 4000000
[    0.507660] pci 0000:00:1e.0: res[15]=[mem 0x04000000-0x03ffffff 
pref] get_res_add_size add_size 4000000
[    0.507663] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 
64bit pref] get_res_add_size add_size 200000
[    0.507665] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff 
64bit pref] get_res_add_size add_size 200000
[    0.507667] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff 
64bit pref] get_res_add_size add_size 200000
[    0.507670] pci 0000:00:1c.4: res[15]=[mem 0x00100000-0x000fffff 
64bit pref] get_res_add_size add_size 200000
[    0.507672] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] 
get_res_add_size add_size 1000
[    0.507674] pci 0000:00:1c.1: res[13]=[io  0x1000-0x0fff] 
get_res_add_size add_size 1000
[    0.507678] pci 0000:00:1e.0: BAR 15: assigned [mem 
0x9c000000-0x9fffffff pref]
[    0.507682] pci 0000:00:1c.0: BAR 15: assigned [mem 
0x98900000-0x98afffff 64bit pref]
[    0.507685] pci 0000:00:1c.1: BAR 15: assigned [mem 
0x98b00000-0x98cfffff 64bit pref]
[    0.507688] pci 0000:00:1c.2: BAR 15: assigned [mem 
0x98d00000-0x98efffff 64bit pref]
[    0.507691] pci 0000:00:1c.4: BAR 15: assigned [mem 
0x98f00000-0x990fffff 64bit pref]
[    0.507694] pci 0000:00:1c.0: BAR 13: assigned [io  0x8000-0x8fff]
[    0.507696] pci 0000:00:1c.1: BAR 13: assigned [io  0x9000-0x9fff]
[    0.507699] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.507703] pci 0000:00:1c.0:   bridge window [io  0x8000-0x8fff]
[    0.507709] pci 0000:00:1c.0:   bridge window [mem 0x98700000-0x987fffff]
[    0.507713] pci 0000:00:1c.0:   bridge window [mem 
0x98900000-0x98afffff 64bit pref]
[    0.507721] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.507724] pci 0000:00:1c.1:   bridge window [io  0x9000-0x9fff]
[    0.507729] pci 0000:00:1c.1:   bridge window [mem 0x98600000-0x986fffff]
[    0.507734] pci 0000:00:1c.1:   bridge window [mem 
0x98b00000-0x98cfffff 64bit pref]
[    0.507741] pci 0000:00:1c.2: PCI bridge to [bus 03-43]
[    0.507744] pci 0000:00:1c.2:   bridge window [io  0x5000-0x6fff]
[    0.507749] pci 0000:00:1c.2:   bridge window [mem 0x94600000-0x985fffff]
[    0.507754] pci 0000:00:1c.2:   bridge window [mem 
0x98d00000-0x98efffff 64bit pref]
[    0.507761] pci 0000:00:1c.4: PCI bridge to [bus 44-84]
[    0.507764] pci 0000:00:1c.4:   bridge window [io  0x3000-0x4fff]
[    0.507770] pci 0000:00:1c.4:   bridge window [mem 0x90600000-0x945fffff]
[    0.507774] pci 0000:00:1c.4:   bridge window [mem 
0x98f00000-0x990fffff 64bit pref]
[    0.507782] pci 0000:85:09.2: res[15]=[mem 0x04000000-0x03ffffff 
pref] get_res_add_size add_size 4000000
[    0.507784] pci 0000:85:09.2: res[16]=[mem 0x04000000-0x03ffffff] 
get_res_add_size add_size 4000000
[    0.507787] pci 0000:85:09.2: res[13]=[io  0x0100-0x00ff] 
get_res_add_size add_size 100
[    0.507789] pci 0000:85:09.2: res[14]=[io  0x0100-0x00ff] 
get_res_add_size add_size 100
[    0.507791] pci 0000:85:09.2: BAR 15: assigned [mem 
0x9c000000-0x9fffffff pref]
[    0.507795] pci 0000:85:09.2: BAR 16: assigned [mem 
0xa0000000-0xa3ffffff]
[    0.507797] pci 0000:85:09.2: BAR 13: assigned [io  0x2000-0x20ff]
[    0.507799] pci 0000:85:09.2: BAR 14: assigned [io  0x2400-0x24ff]
[    0.507801] pci 0000:85:09.2: CardBus bridge to [bus 86-89]
[    0.507803] pci 0000:85:09.2:   bridge window [io  0x2000-0x20ff]
[    0.507808] pci 0000:85:09.2:   bridge window [io  0x2400-0x24ff]
[    0.507814] pci 0000:85:09.2:   bridge window [mem 
0x9c000000-0x9fffffff pref]
[    0.507819] pci 0000:85:09.2:   bridge window [mem 0xa0000000-0xa3ffffff]
[    0.507825] pci 0000:00:1e.0: PCI bridge to [bus 85-86]
[    0.507828] pci 0000:00:1e.0:   bridge window [io  0x2000-0x2fff]
[    0.507833] pci 0000:00:1e.0:   bridge window [mem 0x90500000-0x905fffff]
[    0.507837] pci 0000:00:1e.0:   bridge window [mem 
0x9c000000-0x9fffffff pref]
[    0.507845] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.507847] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.507849] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.507851] pci_bus 0000:00: resource 7 [mem 0x80000000-0xdfffffff]
[    0.507853] pci_bus 0000:00: resource 8 [mem 0xf0000000-0xfedfffff]
[    0.507854] pci_bus 0000:00: resource 9 [mem 0xfee01000-0xffffffff]
[    0.507856] pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
[    0.507858] pci_bus 0000:01: resource 1 [mem 0x98700000-0x987fffff]
[    0.507860] pci_bus 0000:01: resource 2 [mem 0x98900000-0x98afffff 
64bit pref]
[    0.507862] pci_bus 0000:02: resource 0 [io  0x9000-0x9fff]
[    0.507864] pci_bus 0000:02: resource 1 [mem 0x98600000-0x986fffff]
[    0.507866] pci_bus 0000:02: resource 2 [mem 0x98b00000-0x98cfffff 
64bit pref]
[    0.507868] pci_bus 0000:03: resource 0 [io  0x5000-0x6fff]
[    0.507870] pci_bus 0000:03: resource 1 [mem 0x94600000-0x985fffff]
[    0.507872] pci_bus 0000:03: resource 2 [mem 0x98d00000-0x98efffff 
64bit pref]
[    0.507874] pci_bus 0000:44: resource 0 [io  0x3000-0x4fff]
[    0.507876] pci_bus 0000:44: resource 1 [mem 0x90600000-0x945fffff]
[    0.507878] pci_bus 0000:44: resource 2 [mem 0x98f00000-0x990fffff 
64bit pref]
[    0.507880] pci_bus 0000:85: resource 0 [io  0x2000-0x2fff]
[    0.507882] pci_bus 0000:85: resource 1 [mem 0x90500000-0x905fffff]
[    0.507884] pci_bus 0000:85: resource 2 [mem 0x9c000000-0x9fffffff pref]
[    0.507886] pci_bus 0000:85: resource 4 [io  0x0000-0x0cf7]
[    0.507887] pci_bus 0000:85: resource 5 [io  0x0d00-0xffff]
[    0.507889] pci_bus 0000:85: resource 6 [mem 0x000a0000-0x000bffff]
[    0.507891] pci_bus 0000:85: resource 7 [mem 0x80000000-0xdfffffff]
[    0.507893] pci_bus 0000:85: resource 8 [mem 0xf0000000-0xfedfffff]
[    0.507895] pci_bus 0000:85: resource 9 [mem 0xfee01000-0xffffffff]
[    0.507897] pci_bus 0000:86: resource 0 [io  0x2000-0x20ff]
[    0.507899] pci_bus 0000:86: resource 1 [io  0x2400-0x24ff]
[    0.507901] pci_bus 0000:86: resource 2 [mem 0x9c000000-0x9fffffff pref]
[    0.507903] pci_bus 0000:86: resource 3 [mem 0xa0000000-0xa3ffffff]
