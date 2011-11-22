From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: ACPI failures on Dell Latitude E6220
Date: Tue, 22 Nov 2011 02:29:48 +0100
Message-ID: <87r50zzvf6.fsf@pirx.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:42597 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758737Ab1KVVmK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Nov 2011 16:42:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: 649540@bugs.debian.org

--=-=-=
Content-Type: text/plain

Hi,

[CC-ing the relevant Debian bug report.]

Running on a Dell Latitude E6220 with BIOS A03, battery life is
surprisingly low, the thermal zone is always at 25 degrees (although
both coretemp and i8k indicate reasonable values), and reboot hangs
without reboot=pci.

With no parameters, the kernel complains:

> [  227.525937] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
> [  227.525946] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880128e7a3d0), AE_TIME (20110623/psparse-536)
> [  227.525957] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880128e7a268), AE_TIME (20110623/psparse-536)
> [  227.525963] ACPI Error: Method parse/execution failed [\ECGB] (Node ffff880128e7adf8), AE_TIME (20110623/psparse-536)
> [  227.525968] ACPI Error: Method parse/execution failed [\_SB_.PCI0.VID_.LCD_._ADR] (Node ffff880128e7e470), AE_TIME (20110623/psparse-536)
> [  227.526053] parport_pc 00:08: disabled
> [  228.025281] ACPI: EC: input buffer is not empty, aborting transaction

A full log is attached; the output of acpidump is on

  http://www.pps.jussieu.fr/~jch/private/latitude-e6220-acpidump.txt

(I cannot attach it since it apparently trips a virus scanner somewhere.)

Adding acpi_serialize causes udev to hang; if you wait for long enough,
udev enters a timeout loop (repeatedly timing out when trying to call
modprobe).

Adding reboot=pci makes reboot work.

Adding ec_delay=1000 has no apparent effect.

Adding pcie_aspm=force has no apparent effect.

-- Juliusz Chroboczek


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=latitude-e6220-dmesg.txt

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.1.0-1-amd64 (Debian 3.1.1-1) (ben@decadent.org.uk) (gcc version 4.6.2 (Debian 4.6.2-4) ) #1 SMP Mon Nov 14 08:02:25 UTC 2011
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.1.0-1-amd64 root=/dev/mapper/pirx-root ro reboot=pci pcie_aspm=force quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000091400 (usable)
[    0.000000]  BIOS-e820: 0000000000091400 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
[    0.000000]  BIOS-e820: 0000000020000000 - 0000000020200000 (reserved)
[    0.000000]  BIOS-e820: 0000000020200000 - 0000000040000000 (usable)
[    0.000000]  BIOS-e820: 0000000040000000 - 0000000040200000 (reserved)
[    0.000000]  BIOS-e820: 0000000040200000 - 00000000caa29000 (usable)
[    0.000000]  BIOS-e820: 00000000caa29000 - 00000000caa6d000 (reserved)
[    0.000000]  BIOS-e820: 00000000caa6d000 - 00000000cadb7000 (usable)
[    0.000000]  BIOS-e820: 00000000cadb7000 - 00000000cade7000 (reserved)
[    0.000000]  BIOS-e820: 00000000cade7000 - 00000000cafe7000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cafe7000 - 00000000cafff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cafff000 - 00000000cb000000 (usable)
[    0.000000]  BIOS-e820: 00000000cb800000 - 00000000cfa00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffc00000 - 00000000ffc20000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000012e000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Dell Inc. Latitude E6220/0R97MN, BIOS A03 09/19/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x12e000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 base 0C0000000 mask FF8000000 write-back
[    0.000000]   3 base 0C8000000 mask FFC000000 write-back
[    0.000000]   4 base 0CB000000 mask FFF000000 uncachable
[    0.000000]   5 base 100000000 mask FE0000000 write-back
[    0.000000]   6 base 120000000 mask FF0000000 write-back
[    0.000000]   7 base 12E000000 mask FFE000000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000cb000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xcb000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000f1c40] f1c40
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000008c000] 8c000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000cb000000
[    0.000000]  0000000000 - 00cb000000 page 2M
[    0.000000] kernel direct mapping tables up to cb000000 @ 1fffb000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-000000012e000000
[    0.000000]  0100000000 - 012e000000 page 2M
[    0.000000] kernel direct mapping tables up to 12e000000 @ cadb1000-cadb7000
[    0.000000] RAMDISK: 36ab8000 - 37554000
[    0.000000] ACPI: RSDP 00000000000fe300 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 00000000caffde18 00074 (v01 DELL    CBX3    06222004 MSFT 00010013)
[    0.000000] ACPI: FACP 00000000caf87d98 000F4 (v04 DELL    CBX3    06222004 MSFT 00010013)
[    0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two FACS tables! (20110623/tbfadt-369)
[    0.000000] ACPI Warning: 32/64X FACS address mismatch in FADT - 0xCAFE4E40/0x00000000CAFE4D40, using 32 (20110623/tbfadt-489)
[    0.000000] ACPI: DSDT 00000000caf7e018 08461 (v02 INT430 SYSFexxx 00001001 INTL 20090903)
[    0.000000] ACPI: FACS 00000000cafe4e40 00040
[    0.000000] ACPI: APIC 00000000caffcf18 000CC (v02 DELL    CBX3    06222004 MSFT 00010013)
[    0.000000] ACPI: TCPA 00000000cafe5d18 00032 (v02                 00000000      00000000)
[    0.000000] ACPI: SSDT 00000000caf88a98 002F9 (v01 DELLTP      TPM 00003000 INTL 20090903)
[    0.000000] ACPI: MCFG 00000000cafe5c98 0003C (v01 DELL   SNDYBRDG 06222004 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cafe5c18 00038 (v01 A M I   PCHHPET 06222004 AMI. 00000003)
[    0.000000] ACPI: BOOT 00000000cafe5b98 00028 (v01 DELL   CBX3     06222004 AMI  00010013)
[    0.000000] ACPI: SSDT 00000000caf7d018 00804 (v01  PmRef  Cpu0Ist 00003000 INTL 20090903)
[    0.000000] ACPI: SSDT 00000000caf7c018 00996 (v01  PmRef    CpuPm 00003000 INTL 20090903)
[    0.000000] ACPI: DMAR 00000000caf87c18 000E8 (v01 INTEL      SNB  00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000012e000000
[    0.000000] Initmem setup node 0 0000000000000000-000000012e000000
[    0.000000]   NODE_DATA [000000012dffb000 - 000000012dffffff]
[    0.000000]  [ffffea0000000000-ffffea00043fffff] PMD -> [ffff880129600000-ffff88012cffffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0012e000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x00000091
[    0.000000]     0: 0x00000100 -> 0x00020000
[    0.000000]     0: 0x00020200 -> 0x00040000
[    0.000000]     0: 0x00040200 -> 0x000caa29
[    0.000000]     0: 0x000caa6d -> 0x000cadb7
[    0.000000]     0: 0x000cafff -> 0x000cb000
[    0.000000]     0: 0x00100000 -> 0x0012e000
[    0.000000] On node 0 totalpages: 1018101
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3908 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 811436 pages, LIFO batch:31
[    0.000000]   Normal zone: 2576 pages used for memmap
[    0.000000]   Normal zone: 185840 pages, LIFO batch:31
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
[    0.000000] SMP: Allowing 16 CPUs, 12 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 0000000000091000 - 0000000000092000
[    0.000000] PM: Registered nosave memory: 0000000000092000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000020200000
[    0.000000] PM: Registered nosave memory: 0000000040000000 - 0000000040200000
[    0.000000] PM: Registered nosave memory: 00000000caa29000 - 00000000caa6d000
[    0.000000] PM: Registered nosave memory: 00000000cadb7000 - 00000000cade7000
[    0.000000] PM: Registered nosave memory: 00000000cade7000 - 00000000cafe7000
[    0.000000] PM: Registered nosave memory: 00000000cafe7000 - 00000000cafff000
[    0.000000] PM: Registered nosave memory: 00000000cb000000 - 00000000cb800000
[    0.000000] PM: Registered nosave memory: 00000000cb800000 - 00000000cfa00000
[    0.000000] PM: Registered nosave memory: 00000000cfa00000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000ffc00000
[    0.000000] PM: Registered nosave memory: 00000000ffc00000 - 00000000ffc20000
[    0.000000] PM: Registered nosave memory: 00000000ffc20000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at cfa00000 (gap: cfa00000:2f31c000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88012dc00000 s80768 r8192 d21632 u131072
[    0.000000] pcpu-alloc: s80768 r8192 d21632 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1001184
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.1.0-1-amd64 root=/dev/mapper/pirx-root ro reboot=pci pcie_aspm=force quiet
[    0.000000] PCIe ASPM is forcibly enabled
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.000000] Memory: 3925872k/4947968k available (3290k kernel code, 875564k absent, 146532k reserved, 3428k data, 556k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:808 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2494.801 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 4989.60 BogoMIPS (lpj=9979204)
[    0.000006] pid_max: default: 32768 minimum: 301
[    0.000044] Security Framework initialized
[    0.000367] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.001397] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.001837] Mount-cache hash table entries: 256
[    0.001952] Initializing cgroup subsys cpuacct
[    0.001958] Initializing cgroup subsys memory
[    0.001969] Initializing cgroup subsys devices
[    0.001972] Initializing cgroup subsys freezer
[    0.001974] Initializing cgroup subsys net_cls
[    0.001976] Initializing cgroup subsys blkio
[    0.002003] CPU: Physical Processor ID: 0
[    0.002005] CPU: Processor Core ID: 0
[    0.002009] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.002010] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.002013] mce: CPU supports 7 MCE banks
[    0.002024] CPU0: Thermal monitoring enabled (TM1)
[    0.002031] using mwait in idle threads.
[    0.002454] ACPI: Core revision 20110623
[    0.008849] DMAR: Host address width 36
[    0.008851] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.008858] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
[    0.008860] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.008865] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.008866] DMAR: RMRR base: 0x000000cadc6000 end: 0x000000cadd5fff
[    0.008868] DMAR: RMRR base: 0x000000cb800000 end: 0x000000cf9fffff
[    0.008870] DMAR: No ATSR found
[    0.008940] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.008942] HPET id 0 under DRHD base 0xfed91000
[    0.008943] HPET id 0 under DRHD base 0xfed91000
[    0.008944] HPET id 0 under DRHD base 0xfed91000
[    0.008945] HPET id 0 under DRHD base 0xfed91000
[    0.008947] HPET id 0 under DRHD base 0xfed91000
[    0.008948] HPET id 0 under DRHD base 0xfed91000
[    0.008949] HPET id 0 under DRHD base 0xfed91000
[    0.008950] HPET id 0 under DRHD base 0xfed91000
[    0.009185] Enabled Interrupt-remapping
[    0.009187] Enabling x2apic
[    0.009188] Enabled x2apic
[    0.009194] Switched APIC routing to cluster x2apic.
[    0.009568] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.049208] CPU0: Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz stepping 07
[    0.155752] Performance Events: PEBS fmt1+, SandyBridge events, Intel PMU driver.
[    0.155758] ... version:                3
[    0.155759] ... bit width:              48
[    0.155760] ... generic registers:      4
[    0.155761] ... value mask:             0000ffffffffffff
[    0.155763] ... max period:             000000007fffffff
[    0.155764] ... fixed-purpose events:   3
[    0.155765] ... event mask:             000000070000000f
[    0.156000] NMI watchdog enabled, takes one hw-pmu counter.
[    0.156094] Booting Node   0, Processors  #1
[    0.156097] smpboot cpu 1: start_ip = 8c000
[    0.263753] NMI watchdog enabled, takes one hw-pmu counter.
[    0.263839]  #2
[    0.263841] smpboot cpu 2: start_ip = 8c000
[    0.371562] NMI watchdog enabled, takes one hw-pmu counter.
[    0.371659]  #3
[    0.371661] smpboot cpu 3: start_ip = 8c000
[    0.479411] NMI watchdog enabled, takes one hw-pmu counter.
[    0.479435] Brought up 4 CPUs
[    0.479438] Total of 4 processors activated (19954.93 BogoMIPS).
[    0.481757] devtmpfs: initialized
[    0.484387] PM: Registering ACPI NVS region at cade7000 (2097152 bytes)
[    0.484599] print_constraints: dummy: 
[    0.484651] NET: Registered protocol family 16
[    0.484731] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.484734] ACPI: bus type pci registered
[    0.484806] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.484808] PCI: not using MMCONFIG
[    0.484810] PCI: Using configuration type 1 for base access
[    0.484817] dmi type 0xB1 record - unknown flag
[    0.485295] bio: create slab <bio-0> at 0
[    0.485382] ACPI: Added _OSI(Module Device)
[    0.485384] ACPI: Added _OSI(Processor Device)
[    0.485386] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.485387] ACPI: Added _OSI(Processor Aggregator Device)
[    0.486542] ACPI: EC: Look up EC in DSDT
[    0.491410] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.619593] ACPI: SSDT 00000000cadd7798 00727 (v01  PmRef  Cpu0Cst 00003001 INTL 20090903)
[    0.619912] ACPI: Dynamic OEM Table Load:
[    0.619914] ACPI: SSDT           (null) 00727 (v01  PmRef  Cpu0Cst 00003001 INTL 20090903)
[    0.631466] ACPI: SSDT 00000000cadd8a98 00303 (v01  PmRef    ApIst 00003000 INTL 20090903)
[    0.631824] ACPI: Dynamic OEM Table Load:
[    0.631826] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20090903)
[    0.643276] ACPI: SSDT 00000000cadd6d98 00119 (v01  PmRef    ApCst 00003000 INTL 20090903)
[    0.643574] ACPI: Dynamic OEM Table Load:
[    0.643576] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20090903)
[    0.727098] ACPI: Interpreter enabled
[    0.727101] ACPI: (supports S0 S3 S4 S5)
[    0.727124] ACPI: Using IOAPIC for interrupt routing
[    0.727143] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.727597] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    1.382531] ACPI: EC: GPE = 0x10, I/O: command/status = 0x934, data = 0x930
[    1.430170] ACPI: No dock devices found.
[    1.430172] HEST: Table not found.
[    1.430174] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.430576] \_SB_.PCI0:_OSC invalid UUID
[    1.430577] _OSC request data:1 8 1f 
[    1.430581] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.431297] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.431300] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.431302] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.431304] pci_root PNP0A08:00: host bridge window [mem 0xcfa00000-0xfeafffff]
[    1.431306] pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
[    1.431317] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    1.431350] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
[    1.431359] pci 0000:00:02.0: reg 10: [mem 0xe0c00000-0xe0ffffff 64bit]
[    1.431365] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    1.431369] pci 0000:00:02.0: reg 20: [io  0x3000-0x303f]
[    1.431417] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    1.431440] pci 0000:00:16.0: reg 10: [mem 0xe1cb0000-0xe1cb000f 64bit]
[    1.431502] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.431507] pci 0000:00:16.0: PME# disabled
[    1.431536] pci 0000:00:19.0: [8086:1502] type 0 class 0x000200
[    1.431554] pci 0000:00:19.0: reg 10: [mem 0xe1c00000-0xe1c1ffff]
[    1.431563] pci 0000:00:19.0: reg 14: [mem 0xe1c80000-0xe1c80fff]
[    1.431571] pci 0000:00:19.0: reg 18: [io  0x3080-0x309f]
[    1.431620] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    1.431625] pci 0000:00:19.0: PME# disabled
[    1.431649] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    1.431669] pci 0000:00:1a.0: reg 10: [mem 0xe1c70000-0xe1c703ff]
[    1.431742] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.431747] pci 0000:00:1a.0: PME# disabled
[    1.431771] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    1.431786] pci 0000:00:1b.0: reg 10: [mem 0xe1c60000-0xe1c63fff 64bit]
[    1.431841] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.431845] pci 0000:00:1b.0: PME# disabled
[    1.431871] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    1.431973] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.431978] pci 0000:00:1c.0: PME# disabled
[    1.432013] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    1.432110] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.432114] pci 0000:00:1c.1: PME# disabled
[    1.432150] pci 0000:00:1c.2: [8086:1c14] type 1 class 0x000604
[    1.432249] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.432254] pci 0000:00:1c.2: PME# disabled
[    1.432292] pci 0000:00:1c.5: [8086:1c1a] type 1 class 0x000604
[    1.432393] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.432397] pci 0000:00:1c.5: PME# disabled
[    1.432434] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    1.432455] pci 0000:00:1d.0: reg 10: [mem 0xe1c50000-0xe1c503ff]
[    1.432528] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.432532] pci 0000:00:1d.0: PME# disabled
[    1.432557] pci 0000:00:1f.0: [8086:1c4f] type 0 class 0x000601
[    1.432672] pci 0000:00:1f.2: [8086:282a] type 0 class 0x000104
[    1.432690] pci 0000:00:1f.2: reg 10: [io  0x30d0-0x30d7]
[    1.432698] pci 0000:00:1f.2: reg 14: [io  0x30c0-0x30c3]
[    1.432706] pci 0000:00:1f.2: reg 18: [io  0x30b0-0x30b7]
[    1.432714] pci 0000:00:1f.2: reg 1c: [io  0x30a0-0x30a3]
[    1.432722] pci 0000:00:1f.2: reg 20: [io  0x3060-0x307f]
[    1.432730] pci 0000:00:1f.2: reg 24: [mem 0xe1c40000-0xe1c407ff]
[    1.432762] pci 0000:00:1f.2: PME# supported from D3hot
[    1.432766] pci 0000:00:1f.2: PME# disabled
[    1.432784] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    1.432800] pci 0000:00:1f.3: reg 10: [mem 0xe1c30000-0xe1c300ff 64bit]
[    1.432821] pci 0000:00:1f.3: reg 20: [io  0x3040-0x305f]
[    1.432916] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.433162] pci 0000:02:00.0: [8086:422b] type 0 class 0x000280
[    1.433309] pci 0000:02:00.0: reg 10: [mem 0xe1b00000-0xe1b01fff 64bit]
[    1.433883] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.433918] pci 0000:02:00.0: PME# disabled
[    1.442175] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    1.442184] pci 0000:00:1c.1:   bridge window [mem 0xe1b00000-0xe1bfffff]
[    1.442263] pci 0000:00:1c.2: PCI bridge to [bus 03-08]
[    1.442268] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
[    1.442274] pci 0000:00:1c.2:   bridge window [mem 0xe1000000-0xe19fffff]
[    1.442282] pci 0000:00:1c.2:   bridge window [mem 0xe0000000-0xe09fffff 64bit pref]
[    1.444098] pci 0000:09:00.0: [1217:8221] type 0 class 0x000805
[    1.444141] pci 0000:09:00.0: reg 10: [mem 0xe1a20000-0xe1a201ff]
[    1.444401] pci 0000:09:00.0: supports D1 D2
[    1.444403] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.444413] pci 0000:09:00.0: PME# disabled
[    1.444510] pci 0000:09:00.1: [1217:8231] type 0 class 0x000180
[    1.444553] pci 0000:09:00.1: reg 10: [mem 0xe1a10000-0xe1a10fff]
[    1.444611] pci 0000:09:00.1: reg 18: [mem 0xe1a00000-0xe1a007ff]
[    1.444811] pci 0000:09:00.1: supports D1 D2
[    1.444813] pci 0000:09:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    1.444823] pci 0000:09:00.1: PME# disabled
[    1.451764] pci 0000:00:1c.5: PCI bridge to [bus 09-09]
[    1.451771] pci 0000:00:1c.5:   bridge window [mem 0xe1a00000-0xe1afffff]
[    1.451806] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.452050] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.452094] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    1.452142] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    1.452199] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    1.452296] \_SB_.PCI0:_OSC invalid UUID
[    1.452298] _OSC request data:1 1f 1f 
[    1.452301]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.452340] \_SB_.PCI0:_OSC invalid UUID
[    1.452341] _OSC request data:1 0 1d 
[    1.452344]  pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control mask: 0x1d
[    1.452345] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.456395] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.456444] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    1.456492] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.456539] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.456587] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 *5 6 7 10 12 14 15)
[    1.456633] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.456681] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 *3 4 5 6 7 10 12 14 15)
[    1.456728] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.456814] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    1.456822] vgaarb: loaded
[    1.456823] vgaarb: bridge control possible 0000:00:02.0
[    1.456854] PCI: Using ACPI for IRQ routing
[    1.458511] PCI: pci_cache_line_size set to 64 bytes
[    1.460347] reserve RAM buffer: 0000000000091400 - 000000000009ffff 
[    1.460350] reserve RAM buffer: 00000000caa29000 - 00000000cbffffff 
[    1.460353] reserve RAM buffer: 00000000cadb7000 - 00000000cbffffff 
[    1.460356] reserve RAM buffer: 00000000cb000000 - 00000000cbffffff 
[    1.460359] reserve RAM buffer: 000000012e000000 - 000000012fffffff 
[    1.460452] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.460457] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.462472] Switching to clocksource hpet
[    1.464040] pnp: PnP ACPI init
[    1.464051] ACPI: bus type pnp registered
[    1.464423] pnp 00:00: [bus 00-3e]
[    1.464425] pnp 00:00: [io  0x0000-0x0cf7 window]
[    1.464427] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.464429] pnp 00:00: [io  0x0d00-0xffff window]
[    1.464431] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.464433] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    1.464434] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    1.464436] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    1.464438] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    1.464439] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    1.464441] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    1.464443] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    1.464445] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    1.464446] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    1.464448] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    1.464451] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    1.464452] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    1.464454] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    1.464456] pnp 00:00: [mem 0xcfa00000-0xfeafffff window]
[    1.464458] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    1.464501] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.464514] pnp 00:01: [io  0x0000-0x001f]
[    1.464515] pnp 00:01: [io  0x0081-0x0091]
[    1.464517] pnp 00:01: [io  0x0093-0x009f]
[    1.464518] pnp 00:01: [io  0x00c0-0x00df]
[    1.464520] pnp 00:01: [dma 4]
[    1.464540] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.464548] pnp 00:02: [mem 0xff000000-0xffffffff]
[    1.464565] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    1.464644] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    1.464679] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
[    1.464681] system 00:03: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    1.464691] pnp 00:04: [io  0x00f0]
[    1.464702] pnp 00:04: [irq 13]
[    1.464721] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.464731] pnp 00:05: [io  0x002e-0x002f]
[    1.464733] pnp 00:05: [io  0x004e-0x004f]
[    1.464734] pnp 00:05: [io  0x0061]
[    1.464736] pnp 00:05: [io  0x0063]
[    1.464737] pnp 00:05: [io  0x0065]
[    1.464739] pnp 00:05: [io  0x0067]
[    1.464740] pnp 00:05: [io  0x0070]
[    1.464741] pnp 00:05: [io  0x0080]
[    1.464743] pnp 00:05: [io  0x0092]
[    1.464744] pnp 00:05: [io  0x00b2-0x00b3]
[    1.464746] pnp 00:05: [io  0x0680-0x069f]
[    1.464747] pnp 00:05: [io  0x1000-0x100f]
[    1.464749] pnp 00:05: [io  0xffff]
[    1.464750] pnp 00:05: [io  0xffff]
[    1.464751] pnp 00:05: [io  0x0400-0x047f]
[    1.464753] pnp 00:05: [io  0x0500-0x057f]
[    1.464755] pnp 00:05: [io  0x164e-0x164f]
[    1.464791] system 00:05: [io  0x0680-0x069f] has been reserved
[    1.464793] system 00:05: [io  0x1000-0x100f] has been reserved
[    1.464795] system 00:05: [io  0xffff] has been reserved
[    1.464797] system 00:05: [io  0xffff] has been reserved
[    1.464799] system 00:05: [io  0x0400-0x047f] has been reserved
[    1.464802] system 00:05: [io  0x0500-0x057f] has been reserved
[    1.464804] system 00:05: [io  0x164e-0x164f] has been reserved
[    1.464806] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.464814] pnp 00:06: [io  0x0070-0x0077]
[    1.464820] pnp 00:06: [irq 8]
[    1.464840] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.464851] pnp 00:07: [io  0x0060]
[    1.464852] pnp 00:07: [io  0x0064]
[    1.464858] pnp 00:07: [irq 1]
[    1.464877] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.466009] Switched to NOHz mode on CPU #0
[    1.466086] Switched to NOHz mode on CPU #3
[    1.466095] Switched to NOHz mode on CPU #2
[    1.466132] Switched to NOHz mode on CPU #1
[    1.470850] pnp 00:08: Plug and Play ACPI device, IDs PNP0401 (disabled)
[    1.470864] pnp 00:09: [irq 12]
[    1.470886] pnp 00:09: Plug and Play ACPI device, IDs DLL04a9 PNP0f13 (active)
[    1.471043] pnp 00:0a: [mem 0xfed1c000-0xfed1ffff]
[    1.471044] pnp 00:0a: [mem 0xfed10000-0xfed17fff]
[    1.471046] pnp 00:0a: [mem 0xfed18000-0xfed18fff]
[    1.471048] pnp 00:0a: [mem 0xfed19000-0xfed19fff]
[    1.471049] pnp 00:0a: [mem 0xf8000000-0xfbffffff]
[    1.471051] pnp 00:0a: [mem 0xfed20000-0xfed3ffff]
[    1.471053] pnp 00:0a: [mem 0xfed90000-0xfed93fff]
[    1.471054] pnp 00:0a: [mem 0xfed45000-0xfed8ffff]
[    1.471056] pnp 00:0a: [mem 0xff000000-0xffffffff]
[    1.471057] pnp 00:0a: [mem 0xfee00000-0xfeefffff]
[    1.471059] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    1.471061] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    1.471106] system 00:0a: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.471108] system 00:0a: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.471110] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.471113] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.471115] system 00:0a: [mem 0xf8000000-0xfbffffff] has been reserved
[    1.471117] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.471120] system 00:0a: [mem 0xfed90000-0xfed93fff] has been reserved
[    1.471122] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.471125] system 00:0a: [mem 0xff000000-0xffffffff] could not be reserved
[    1.471127] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.471129] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.471515] pnp 00:0b: [irq 23]
[    1.471546] pnp 00:0b: Plug and Play ACPI device, IDs SMO8800 (active)
[    1.486783] pnp 00:0c: [mem 0x20000000-0x201fffff]
[    1.486786] pnp 00:0c: [mem 0x40000000-0x401fffff]
[    1.486842] system 00:0c: [mem 0x20000000-0x201fffff] has been reserved
[    1.486844] system 00:0c: [mem 0x40000000-0x401fffff] has been reserved
[    1.486847] system 00:0c: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.486855] pnp: PnP ACPI: found 13 devices
[    1.486856] ACPI: ACPI bus type pnp unregistered
[    1.493369] PCI: max bus depth: 1 pci_try_num: 2
[    1.493419] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.493436] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    1.493443] pci 0000:00:1c.1:   bridge window [mem 0xe1b00000-0xe1bfffff]
[    1.493456] pci 0000:00:1c.2: PCI bridge to [bus 03-08]
[    1.493459] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
[    1.493466] pci 0000:00:1c.2:   bridge window [mem 0xe1000000-0xe19fffff]
[    1.493471] pci 0000:00:1c.2:   bridge window [mem 0xe0000000-0xe09fffff 64bit pref]
[    1.493480] pci 0000:00:1c.5: PCI bridge to [bus 09-09]
[    1.493487] pci 0000:00:1c.5:   bridge window [mem 0xe1a00000-0xe1afffff]
[    1.493513] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.493519] pci 0000:00:1c.0: setting latency timer to 64
[    1.493532] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.493538] pci 0000:00:1c.1: setting latency timer to 64
[    1.493549] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.493554] pci 0000:00:1c.2: setting latency timer to 64
[    1.493562] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.493567] pci 0000:00:1c.5: setting latency timer to 64
[    1.493571] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.493573] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.493574] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.493576] pci_bus 0000:00: resource 7 [mem 0xcfa00000-0xfeafffff]
[    1.493578] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    1.493580] pci_bus 0000:02: resource 1 [mem 0xe1b00000-0xe1bfffff]
[    1.493582] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    1.493583] pci_bus 0000:03: resource 1 [mem 0xe1000000-0xe19fffff]
[    1.493585] pci_bus 0000:03: resource 2 [mem 0xe0000000-0xe09fffff 64bit pref]
[    1.493587] pci_bus 0000:09: resource 1 [mem 0xe1a00000-0xe1afffff]
[    1.493650] NET: Registered protocol family 2
[    1.493787] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.494678] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.496416] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.496633] TCP: Hash tables configured (established 524288 bind 65536)
[    1.496635] TCP reno registered
[    1.496643] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    1.496665] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    1.496798] NET: Registered protocol family 1
[    1.496811] pci 0000:00:02.0: Boot video device
[    1.498648] PCI: CLS 64 bytes, default 64
[    1.498686] Unpacking initramfs...
[    1.702277] Freeing initrd memory: 10864k freed
[    1.703640] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.703645] Placing 64MB software IO TLB between ffff8800c6a29000 - ffff8800caa29000
[    1.703647] software IO TLB at phys 0xc6a29000 - 0xcaa29000
[    1.703662] Simple Boot Flag at 0xf3 set to 0x1
[    1.704133] audit: initializing netlink socket (disabled)
[    1.704142] type=2000 audit(1321922798.548:1): initialized
[    1.722244] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.733832] VFS: Disk quotas dquot_6.5.2
[    1.733865] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.733933] msgmni has been set to 7688
[    1.734117] alg: No test for stdrng (krng)
[    1.734147] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.734150] io scheduler noop registered
[    1.734152] io scheduler deadline registered
[    1.734172] io scheduler cfq registered (default)
[    1.734589] intel_idle: MWAIT substates: 0x21120
[    1.734591] intel_idle: v0.4 model 0x2A
[    1.734592] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.734636] ERST: Table is not found!
[    1.734638] GHES: HEST is not enabled!
[    1.734696] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.934159] Linux agpgart interface v0.103
[    1.934224] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.934304] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    1.935221] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.935325] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    1.935426] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.935632] i8042: Warning: Keylock active
[    1.936862] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.936867] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.936950] mousedev: PS/2 mouse device common for all mice
[    1.936991] rtc_cmos 00:06: RTC can wake from S4
[    1.937103] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    1.937129] rtc0: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    1.937281] cpuidle: using governor ladder
[    1.937485] cpuidle: using governor menu
[    1.937646] TCP cubic registered
[    1.937736] NET: Registered protocol family 10
[    1.937839] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.938334] Mobile IPv6
[    1.938336] NET: Registered protocol family 17
[    1.938339] Registering the dns_resolver key type
[    1.938620] PM: Hibernation image not present or could not be loaded.
[    1.938632] registered taskstats version 1
[    1.946768] rtc_cmos 00:06: setting system clock to 2011-11-22 00:46:39 UTC (1321922799)
[    1.946819] Initializing network drop monitor service
[    1.947714] Freeing unused kernel memory: 556k freed
[    1.947770] Write protecting the kernel read-only data: 6144k
[    1.950239] Freeing unused kernel memory: 788k freed
[    1.952407] Freeing unused kernel memory: 696k freed
[    2.004192] udevd[61]: starting version 172
[    2.027046] SCSI subsystem initialized
[    2.027640] e1000e: Intel(R) PRO/1000 Network Driver - 1.4.4-k
[    2.027642] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    2.027766] sdhci: Secure Digital Host Controller Interface driver
[    2.027769] sdhci: Copyright(c) Pierre Ossman
[    2.028004] sdhci-pci 0000:09:00.0: SDHCI controller found [1217:8221] (rev 5)
[    2.034577] usbcore: registered new interface driver usbfs
[    2.034603] usbcore: registered new interface driver hub
[    2.037964] usbcore: registered new device driver usb
[    2.038396] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.040990] libata version 3.00 loaded.
[    2.067544] sdhci-pci 0000:09:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    2.067554] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    2.067669] e1000e 0000:00:19.0: setting latency timer to 64
[    2.067704] sdhci-pci 0000:09:00.0: Invalid iomem size. You may experience problems.
[    2.067810] sdhci-pci 0000:09:00.0: setting latency timer to 64
[    2.067837] mmc0: no vmmc regulator found
[    2.067852] e1000e 0000:00:19.0: irq 42 for MSI/MSI-X
[    2.067887] Registered led device: mmc0::
[    2.067964] mmc0: SDHCI controller on PCI [0000:09:00.0] using DMA
[    2.121723] thermal LNXTHERM:00: registered as thermal_zone0
[    2.121726] ACPI: Thermal Zone [THM] (25 C)
[    2.360989] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1) 84:8f:69:f0:33:bc
[    2.360993] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    2.361045] e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: 9041FF-0FF
[    2.361112] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.361145] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.361149] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    2.361173] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    2.361204] ehci_hcd 0000:00:1a.0: debug port 2
[    2.365085] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    2.365101] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xe1c70000
[    2.377304] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.377352] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.377355] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.377357] usb usb1: Product: EHCI Host Controller
[    2.377358] usb usb1: Manufacturer: Linux 3.1.0-1-amd64 ehci_hcd
[    2.377360] usb usb1: SerialNumber: 0000:00:1a.0
[    2.377496] hub 1-0:1.0: USB hub found
[    2.377500] hub 1-0:1.0: 2 ports detected
[    2.377565] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    2.377590] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    2.377594] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    2.377600] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    2.377628] ehci_hcd 0000:00:1d.0: debug port 2
[    2.381513] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    2.381520] ehci_hcd 0000:00:1d.0: irq 17, io mem 0xe1c50000
[    2.397324] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.397350] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.397353] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.397355] usb usb2: Product: EHCI Host Controller
[    2.397356] usb usb2: Manufacturer: Linux 3.1.0-1-amd64 ehci_hcd
[    2.397358] usb usb2: SerialNumber: 0000:00:1d.0
[    2.399204] hub 2-0:1.0: USB hub found
[    2.399208] hub 2-0:1.0: 2 ports detected
[    2.399279] ahci 0000:00:1f.2: version 3.0
[    2.399297] ahci 0000:00:1f.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    2.399372] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    2.399408] ahci: SSS flag set, parallel bus scan disabled
[    2.413309] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3b impl RAID mode
[    2.413313] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems sxs apst 
[    2.413319] ahci 0000:00:1f.2: setting latency timer to 64
[    2.445874] scsi0 : ahci
[    2.446011] scsi1 : ahci
[    2.446111] scsi2 : ahci
[    2.446215] scsi3 : ahci
[    2.446316] scsi4 : ahci
[    2.446414] scsi5 : ahci
[    2.549951] ata1: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40100 irq 43
[    2.549956] ata2: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40180 irq 43
[    2.549958] ata3: DUMMY
[    2.549961] ata4: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40280 irq 43
[    2.549965] ata5: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40300 irq 43
[    2.549968] ata6: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40380 irq 43
[    2.688931] usb 1-1: new high speed USB device number 2 using ehci_hcd
[    2.700905] Refined TSC clocksource calibration: 2494.334 MHz.
[    2.700910] Switching to clocksource tsc
[    2.821391] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    2.821394] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.821729] hub 1-1:1.0: USB hub found
[    2.821807] hub 1-1:1.0: 6 ports detected
[    2.868702] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.932609] usb 2-1: new high speed USB device number 2 using ehci_hcd
[    2.966470] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.970090] ata1.00: ATA-8: SAMSUNG SSD PM810 2.5" 7mm 128GB, AXM08D1Q, max UDMA/133
[    2.970110] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.973185] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.974449] ata1.00: configured for UDMA/133
[    2.974626] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SSD PM81 AXM0 PQ: 0 ANSI: 5
[    3.066706] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    3.066710] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.067046] hub 2-1:1.0: USB hub found
[    3.067118] hub 2-1:1.0: 8 ports detected
[    3.140657] usb 1-1.4: new full speed USB device number 3 using ehci_hcd
[    3.237216] usb 1-1.4: New USB device found, idVendor=413c, idProduct=8187
[    3.237226] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.237232] usb 1-1.4: Product: DW375 Bluetooth Module
[    3.237237] usb 1-1.4: Manufacturer: Dell Computer Corp
[    3.237241] usb 1-1.4: SerialNumber: D0DF9AB482E6
[    3.292144] ata2: SATA link down (SStatus 0 SControl 300)
[    3.308251] usb 1-1.5: new high speed USB device number 4 using ehci_hcd
[    3.521291] usb 1-1.5: New USB device found, idVendor=1bcf, idProduct=2804
[    3.521295] usb 1-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.521297] usb 1-1.5: Product: Laptop_Integrated_Webcam_HD
[    3.521298] usb 1-1.5: Manufacturer: CN018T967248719N0BP8A01
[    3.611734] ata4: SATA link down (SStatus 0 SControl 300)
[    3.765571] usb 2-1.8: new full speed USB device number 3 using ehci_hcd
[    3.884285] usb 2-1.8: New USB device found, idVendor=0a5c, idProduct=5801
[    3.884288] usb 2-1.8: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.884290] usb 2-1.8: Product: 5880
[    3.884292] usb 2-1.8: Manufacturer: Broadcom Corp
[    3.884293] usb 2-1.8: SerialNumber: 0123456789ABCD
[    3.884442] usb 2-1.8: config 0 descriptor??
[    3.931341] ata5: SATA link down (SStatus 0 SControl 300)
[    4.250911] ata6: SATA link down (SStatus 0 SControl 300)
[    4.254204] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    4.254279] sd 0:0:0:0: [sda] Write Protect is off
[    4.254282] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.254305] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.256484]  sda: sda1 sda2 < sda5 >
[    4.257058] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.258408] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.575923] device-mapper: uevent: version 1.0.3
[    4.575986] device-mapper: ioctl: 4.21.0-ioctl (2011-07-06) initialised: dm-devel@redhat.com
[  224.594603] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[  224.597138] alg: No test for __cbc-aes-aesni (cryptd(__driver-cbc-aes-aesni))
[  225.183256] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[  225.445610] udevd[369]: starting version 172
[  225.509058] ACPI: acpi_idle yielding to intel_idle
[  225.510012] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[  225.510824] ACPI: Lid Switch [LID]
[  225.510896] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[  225.510902] ACPI: Power Button [PBTN]
[  225.510965] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[  225.510970] ACPI: Sleep Button [SBTN]
[  225.511023] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[  225.511027] ACPI: Power Button [PWRF]
[  225.522507] ACPI: AC Adapter [AC] (on-line)
[  225.547824] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[  225.553516] ACPI: Battery Slot [BAT0] (battery present)
[  225.554650] input: PC Speaker as /devices/platform/pcspkr/input/input5
[  225.563240] Bluetooth: Core ver 2.16
[  225.563259] NET: Registered protocol family 31
[  225.563262] Bluetooth: HCI device and connection manager initialized
[  225.563265] Bluetooth: HCI socket layer initialized
[  225.563267] Bluetooth: L2CAP socket layer initialized
[  225.563272] Bluetooth: SCO socket layer initialized
[  225.583870] Bluetooth: Generic Bluetooth USB driver ver 0.6
[  225.592542] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[  225.648926] ACPI: Battery Slot [BAT1] (battery absent)
[  225.649177] wmi: Mapper loaded
[  225.649775] usbcore: registered new interface driver btusb
[  225.650092] Linux media interface: v0.10
[  225.651995] parport_pc 00:08: [io  0x0378-0x037b]
[  225.653801] parport_pc 00:08: [irq 5]
[  225.664203] Linux video capture interface: v2.00
[  225.665856] cfg80211: Calling CRDA to update world regulatory domain
[  225.674115] [drm] Initialized drm 1.1.0 20060810
[  225.674590] uvcvideo: Found UVC 1.00 device Laptop_Integrated_Webcam_HD (1bcf:2804)
[  225.696012] input: Laptop_Integrated_Webcam_HD as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input6
[  225.696137] usbcore: registered new interface driver uvcvideo
[  225.696140] USB Video Class driver (1.1.1)
[  225.707617] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
[  225.707620] Copyright(c) 2003-2011 Intel Corporation
[  225.708352] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  225.708357] i915 0000:00:02.0: setting latency timer to 64
[  225.708566] iwlagn 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  225.708575] iwlagn 0000:02:00.0: setting latency timer to 64
[  225.708610] iwlagn 0000:02:00.0: pci_resource_len = 0x00002000
[  225.708613] iwlagn 0000:02:00.0: pci_resource_base = ffffc90000678000
[  225.708615] iwlagn 0000:02:00.0: HW Revision ID = 0x35
[  225.708700] iwlagn 0000:02:00.0: irq 44 for MSI/MSI-X
[  225.708732] iwlagn 0000:02:00.0: Detected Intel(R) Centrino(R) Ultimate-N 6300 AGN, REV=0x74
[  225.708781] iwlagn 0000:02:00.0: L1 Disabled; Enabling L0S
[  225.723816] iwlagn 0000:02:00.0: device EEPROM VER=0x43a, CALIB=0x6
[  225.723820] iwlagn 0000:02:00.0: Device SKU: 0X1f0
[  225.723822] iwlagn 0000:02:00.0: Valid Tx ant: 0X7, Valid Rx ant: 0X7
[  225.723844] iwlagn 0000:02:00.0: Tunable channels: 13 802.11bg, 24 802.11a channels
[  225.755743] i915 0000:00:02.0: irq 45 for MSI/MSI-X
[  225.755753] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[  225.755754] [drm] Driver supports precise vblank timestamp query.
[  225.757245] iwlagn 0000:02:00.0: loaded firmware version 9.221.4.1 build 25532
[  225.757534] Registered led device: phy0-led
[  225.762280] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[  225.764362] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[  225.828324] input: Dell WMI hotkeys as /devices/virtual/input/input7
[  226.399268] fbcon: inteldrmfb (fb0) is primary device
[  226.400751] [drm:ironlake_update_pch_refclk] *ERROR* enabling SSC on PCH
[  226.610766] Console: switching to colour frame buffer device 170x48
[  226.614413] fb0: inteldrmfb frame buffer device
[  226.614415] drm: registered panic notifier
[  227.026871] parport_pc 00:08: activated
[  227.026877] parport_pc 00:08: reported by Plug and Play ACPI
[  227.525937] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
[  227.525946] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880128e7a3d0), AE_TIME (20110623/psparse-536)
[  227.525957] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880128e7a268), AE_TIME (20110623/psparse-536)
[  227.525963] ACPI Error: Method parse/execution failed [\ECGB] (Node ffff880128e7adf8), AE_TIME (20110623/psparse-536)
[  227.525968] ACPI Error: Method parse/execution failed [\_SB_.PCI0.VID_.LCD_._ADR] (Node ffff880128e7e470), AE_TIME (20110623/psparse-536)
[  227.526053] parport_pc 00:08: disabled
[  228.025281] ACPI: EC: input buffer is not empty, aborting transaction
[  228.025331] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
[  228.025341] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880128e7a3d0), AE_TIME (20110623/psparse-536)
[  228.025351] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880128e7a268), AE_TIME (20110623/psparse-536)
[  228.025359] ACPI Error: Method parse/execution failed [\ECGB] (Node ffff880128e7adf8), AE_TIME (20110623/psparse-536)
[  228.025365] ACPI Error: Method parse/execution failed [\_SB_.PCI0.VID_._DOD] (Node ffff880128e7e588), AE_TIME (20110623/psparse-536)
[  228.025376] ACPI Exception: AE_TIME, Evaluating _DOD (20110623/video-1147)
[  230.037628] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input8
[  230.119123] acpi device:37: registered as cooling_device4
[  230.187742] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input9
[  230.188068] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[  230.188139] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[  230.188192] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[  230.188251] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
[  230.188277] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[  230.734860] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input10
[  230.737699] HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
[  230.738029] HDMI status: Codec=3 Pin=6 Presence_Detect=0 ELD_Valid=0
[  230.738364] HDMI status: Codec=3 Pin=7 Presence_Detect=0 ELD_Valid=0
[  230.746851] input: HDA Intel PCH Mic at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[  230.746923] input: HDA Intel PCH Mic at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[  230.746982] input: HDA Intel PCH Line Out at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[  230.747039] input: HDA Intel PCH HP Out at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[  230.747297] input: HDA Intel PCH HDMI/DP as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[  230.747352] input: HDA Intel PCH HDMI/DP as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[  230.747406] input: HDA Intel PCH HDMI/DP as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[  230.948804] EXT4-fs (dm-1): re-mounted. Opts: (null)
[  230.976031] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,commit=650
[  231.001177] loop: module loaded
[  231.110931] Adding 5099516k swap on /dev/mapper/pirx-swap_1.  Priority:-1 extents:1 across:5099516k 
[  231.247153] ip_tables: (C) 2000-2006 Netfilter Core Team
[  231.258335] ip6_tables: (C) 2000-2006 Netfilter Core Team
[  231.711429] Bluetooth: RFCOMM TTY layer initialized
[  231.711434] Bluetooth: RFCOMM socket layer initialized
[  231.711436] Bluetooth: RFCOMM ver 1.11
[  231.713657] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  231.713660] Bluetooth: BNEP filters: protocol multicast
[  232.568416] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input18
[  232.611072] TCP lp registered
[  271.487699] iwlagn 0000:02:00.0: L1 Disabled; Enabling L0S
[  271.493890] iwlagn 0000:02:00.0: Radio type=0x0-0x3-0x1
[  271.733813] iwlagn 0000:02:00.0: L1 Disabled; Enabling L0S
[  271.740047] iwlagn 0000:02:00.0: Radio type=0x0-0x3-0x1
[  271.843175] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[  275.367898] wlan0: authenticate with fa:86:f2:e1:5a:20 (try 1)
[  275.565870] wlan0: authenticate with fa:86:f2:e1:5a:20 (try 2)
[  275.571554] wlan0: authenticated
[  275.571722] wlan0: associate with fa:86:f2:e1:5a:20 (try 1)
[  275.586628] wlan0: RX AssocResp from fa:86:f2:e1:5a:20 (capab=0x411 status=0 aid=1)
[  275.586638] wlan0: associated
[  275.591149] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[  315.443248] iwlagn 0000:02:00.0: Tx aggregation enabled on ra = fa:86:f2:e1:5a:20 tid = 0

--=-=-=--
