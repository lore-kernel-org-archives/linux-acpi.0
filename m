From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: Re: ACPI failures on Dell Latitude E6220
Date: Thu, 22 Dec 2011 14:23:23 +0100
Message-ID: <7iipl8d9kk.fsf@lanthane.pps.jussieu.fr>
References: <87r50zzvf6.fsf@pirx.pps.jussieu.fr>
	<87vcp998us.fsf@pirx.pps.jussieu.fr>
	<20111222100849.GA6548@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shiva.jussieu.fr ([134.157.0.129]:56033 "EHLO shiva.jussieu.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab1LVNX3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Dec 2011 08:23:29 -0500
In-Reply-To: <20111222100849.GA6548@elie.Belkin> (Jonathan Nieder's message of
	"Thu, 22 Dec 2011 04:08:49 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain

> Thanks for the update.  Am I right in guessing that 3.1.4-1 is broken,
> too,

I'll try, but not right now (I'm in just a wee bit of a rush).

> and that with 3.1.5-1 the ACPI exceptions are gone?

There's still some, but they're different now.  The thermal zone still
doesn't work.

  [   10.510591] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
  [   10.510602] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880128e7a3d0), AE_TIME (20110623/psparse-536)
  [   10.510613] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880128e7a268), AE_TIME (20110623/psparse-536)
  [   10.510618] ACPI Error: Method parse/execution failed [\ECGB] (Node ffff880128e7adf8), AE_TIME (20110623/psparse-536)
  [   10.510623] ACPI Error: Method parse/execution failed [\_SB_.PCI0.VID_._DOD] (Node ffff880128e7e588), AE_TIME (20110623/psparse-536)
  [   10.510632] ACPI Exception: AE_TIME, Evaluating _DOD (20110623/video-1147)

> Could you attach "dmesg" output from booting a fixed kernel for
> reference?

Attached.

Thanks for caring,

-- Juliusz

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=dmesg-3.1.5.text

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.1.0-1-amd64 (Debian 3.1.5-1) (ben@decadent.org.uk) (gcc version 4.6.2 (Debian 4.6.2-7) ) #1 SMP Sun Dec 11 20:36:41 UTC 2011
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.1.0-1-amd64 root=/dev/mapper/pirx-root ro reboot=pci pcie_aspm=force i915.i915_enable_rc6=1 quiet
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
[    0.000000] RAMDISK: 36aa2000 - 37549000
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
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.1.0-1-amd64 root=/dev/mapper/pirx-root ro reboot=pci pcie_aspm=force i915.i915_enable_rc6=1 quiet
[    0.000000] PCIe ASPM is forcibly enabled
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.000000] Memory: 3925828k/4947968k available (3292k kernel code, 875564k absent, 146576k reserved, 3427k data, 556k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:808 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2494.852 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 4989.70 BogoMIPS (lpj=9979408)
[    0.000007] pid_max: default: 32768 minimum: 301
[    0.000043] Security Framework initialized
[    0.000365] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.001391] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.001834] Mount-cache hash table entries: 256
[    0.001948] Initializing cgroup subsys cpuacct
[    0.001954] Initializing cgroup subsys memory
[    0.001965] Initializing cgroup subsys devices
[    0.001968] Initializing cgroup subsys freezer
[    0.001969] Initializing cgroup subsys net_cls
[    0.001971] Initializing cgroup subsys blkio
[    0.002000] CPU: Physical Processor ID: 0
[    0.002001] CPU: Processor Core ID: 0
[    0.002006] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.002007] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.002009] mce: CPU supports 7 MCE banks
[    0.002020] CPU0: Thermal monitoring enabled (TM1)
[    0.002027] using mwait in idle threads.
[    0.002452] ACPI: Core revision 20110623
[    0.008852] DMAR: Host address width 36
[    0.008854] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.008860] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
[    0.008862] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.008867] IOMMU 1: reg_base_addr fed91000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.008869] DMAR: RMRR base: 0x000000cadc6000 end: 0x000000cadd5fff
[    0.008871] DMAR: RMRR base: 0x000000cb800000 end: 0x000000cf9fffff
[    0.008872] DMAR: No ATSR found
[    0.008942] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.008944] HPET id 0 under DRHD base 0xfed91000
[    0.008945] HPET id 0 under DRHD base 0xfed91000
[    0.008946] HPET id 0 under DRHD base 0xfed91000
[    0.008947] HPET id 0 under DRHD base 0xfed91000
[    0.008949] HPET id 0 under DRHD base 0xfed91000
[    0.008950] HPET id 0 under DRHD base 0xfed91000
[    0.008951] HPET id 0 under DRHD base 0xfed91000
[    0.008952] HPET id 0 under DRHD base 0xfed91000
[    0.009185] Enabled Interrupt-remapping
[    0.009187] Enabling x2apic
[    0.009188] Enabled x2apic
[    0.009194] Switched APIC routing to cluster x2apic.
[    0.009576] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.049217] CPU0: Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz stepping 07
[    0.155751] Performance Events: PEBS fmt1+, SandyBridge events, Intel PMU driver.
[    0.155757] ... version:                3
[    0.155758] ... bit width:              48
[    0.155759] ... generic registers:      4
[    0.155760] ... value mask:             0000ffffffffffff
[    0.155762] ... max period:             000000007fffffff
[    0.155763] ... fixed-purpose events:   3
[    0.155764] ... event mask:             000000070000000f
[    0.155999] NMI watchdog enabled, takes one hw-pmu counter.
[    0.156094] Booting Node   0, Processors  #1
[    0.156096] smpboot cpu 1: start_ip = 8c000
[    0.263755] NMI watchdog enabled, takes one hw-pmu counter.
[    0.263842]  #2
[    0.263843] smpboot cpu 2: start_ip = 8c000
[    0.371569] NMI watchdog enabled, takes one hw-pmu counter.
[    0.371667]  #3
[    0.371668] smpboot cpu 3: start_ip = 8c000
[    0.479419] NMI watchdog enabled, takes one hw-pmu counter.
[    0.479443] Brought up 4 CPUs
[    0.479445] Total of 4 processors activated (19955.03 BogoMIPS).
[    0.481757] devtmpfs: initialized
[    0.484608] PM: Registering ACPI NVS region at cade7000 (2097152 bytes)
[    0.484836] print_constraints: dummy: 
[    0.484888] NET: Registered protocol family 16
[    0.484970] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.484973] ACPI: bus type pci registered
[    0.485047] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.485049] PCI: not using MMCONFIG
[    0.485051] PCI: Using configuration type 1 for base access
[    0.485057] dmi type 0xB1 record - unknown flag
[    0.485542] bio: create slab <bio-0> at 0
[    0.485629] ACPI: Added _OSI(Module Device)
[    0.485631] ACPI: Added _OSI(Processor Device)
[    0.485633] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.485635] ACPI: Added _OSI(Processor Aggregator Device)
[    0.486781] ACPI: EC: Look up EC in DSDT
[    0.491615] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.619589] ACPI: SSDT 00000000cadd7798 00727 (v01  PmRef  Cpu0Cst 00003001 INTL 20090903)
[    0.619901] ACPI: Dynamic OEM Table Load:
[    0.619903] ACPI: SSDT           (null) 00727 (v01  PmRef  Cpu0Cst 00003001 INTL 20090903)
[    0.631462] ACPI: SSDT 00000000cadd8a98 00303 (v01  PmRef    ApIst 00003000 INTL 20090903)
[    0.631816] ACPI: Dynamic OEM Table Load:
[    0.631818] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20090903)
[    0.643272] ACPI: SSDT 00000000cadd6d98 00119 (v01  PmRef    ApCst 00003000 INTL 20090903)
[    0.643567] ACPI: Dynamic OEM Table Load:
[    0.643569] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20090903)
[    0.727093] ACPI: Interpreter enabled
[    0.727096] ACPI: (supports S0 S3 S4 S5)
[    0.727120] ACPI: Using IOAPIC for interrupt routing
[    0.727138] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.727593] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    1.382527] ACPI: EC: GPE = 0x10, I/O: command/status = 0x934, data = 0x930
[    1.430167] ACPI: No dock devices found.
[    1.430169] HEST: Table not found.
[    1.430171] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.430569] \_SB_.PCI0:_OSC invalid UUID
[    1.430570] _OSC request data:1 8 1f 
[    1.430574] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.431282] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.431285] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.431287] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.431290] pci_root PNP0A08:00: host bridge window [mem 0xcfa00000-0xfeafffff]
[    1.431291] pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
[    1.431302] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    1.431334] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
[    1.431344] pci 0000:00:02.0: reg 10: [mem 0xe0c00000-0xe0ffffff 64bit]
[    1.431350] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    1.431354] pci 0000:00:02.0: reg 20: [io  0x3000-0x303f]
[    1.431401] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    1.431425] pci 0000:00:16.0: reg 10: [mem 0xe1cb0000-0xe1cb000f 64bit]
[    1.431487] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.431491] pci 0000:00:16.0: PME# disabled
[    1.431520] pci 0000:00:19.0: [8086:1502] type 0 class 0x000200
[    1.431538] pci 0000:00:19.0: reg 10: [mem 0xe1c00000-0xe1c1ffff]
[    1.431547] pci 0000:00:19.0: reg 14: [mem 0xe1c80000-0xe1c80fff]
[    1.431556] pci 0000:00:19.0: reg 18: [io  0x3080-0x309f]
[    1.431604] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    1.431608] pci 0000:00:19.0: PME# disabled
[    1.431633] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    1.431654] pci 0000:00:1a.0: reg 10: [mem 0xe1c70000-0xe1c703ff]
[    1.431726] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.431730] pci 0000:00:1a.0: PME# disabled
[    1.431755] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    1.431770] pci 0000:00:1b.0: reg 10: [mem 0xe1c60000-0xe1c63fff 64bit]
[    1.431825] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.431829] pci 0000:00:1b.0: PME# disabled
[    1.431851] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    1.431912] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.431917] pci 0000:00:1c.0: PME# disabled
[    1.431940] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    1.432001] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.432006] pci 0000:00:1c.1: PME# disabled
[    1.432029] pci 0000:00:1c.2: [8086:1c14] type 1 class 0x000604
[    1.432090] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.432095] pci 0000:00:1c.2: PME# disabled
[    1.432124] pci 0000:00:1c.5: [8086:1c1a] type 1 class 0x000604
[    1.432222] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.432227] pci 0000:00:1c.5: PME# disabled
[    1.432264] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    1.432284] pci 0000:00:1d.0: reg 10: [mem 0xe1c50000-0xe1c503ff]
[    1.432356] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.432361] pci 0000:00:1d.0: PME# disabled
[    1.432385] pci 0000:00:1f.0: [8086:1c4f] type 0 class 0x000601
[    1.432501] pci 0000:00:1f.2: [8086:282a] type 0 class 0x000104
[    1.432519] pci 0000:00:1f.2: reg 10: [io  0x30d0-0x30d7]
[    1.432527] pci 0000:00:1f.2: reg 14: [io  0x30c0-0x30c3]
[    1.432535] pci 0000:00:1f.2: reg 18: [io  0x30b0-0x30b7]
[    1.432543] pci 0000:00:1f.2: reg 1c: [io  0x30a0-0x30a3]
[    1.432551] pci 0000:00:1f.2: reg 20: [io  0x3060-0x307f]
[    1.432559] pci 0000:00:1f.2: reg 24: [mem 0xe1c40000-0xe1c407ff]
[    1.432590] pci 0000:00:1f.2: PME# supported from D3hot
[    1.432594] pci 0000:00:1f.2: PME# disabled
[    1.432612] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    1.432627] pci 0000:00:1f.3: reg 10: [mem 0xe1c30000-0xe1c300ff 64bit]
[    1.432649] pci 0000:00:1f.3: reg 20: [io  0x3040-0x305f]
[    1.432718] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.432807] pci 0000:02:00.0: [8086:422b] type 0 class 0x000280
[    1.432851] pci 0000:02:00.0: reg 10: [mem 0xe1b00000-0xe1b01fff 64bit]
[    1.433021] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.433029] pci 0000:02:00.0: PME# disabled
[    1.438067] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    1.438082] pci 0000:00:1c.1:   bridge window [mem 0xe1b00000-0xe1bfffff]
[    1.438147] pci 0000:00:1c.2: PCI bridge to [bus 03-08]
[    1.438152] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
[    1.438156] pci 0000:00:1c.2:   bridge window [mem 0xe1000000-0xe19fffff]
[    1.438162] pci 0000:00:1c.2:   bridge window [mem 0xe0000000-0xe09fffff 64bit pref]
[    1.439982] pci 0000:09:00.0: [1217:8221] type 0 class 0x000805
[    1.440026] pci 0000:09:00.0: reg 10: [mem 0xe1a20000-0xe1a201ff]
[    1.440287] pci 0000:09:00.0: supports D1 D2
[    1.440288] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.440299] pci 0000:09:00.0: PME# disabled
[    1.440395] pci 0000:09:00.1: [1217:8231] type 0 class 0x000180
[    1.440439] pci 0000:09:00.1: reg 10: [mem 0xe1a10000-0xe1a10fff]
[    1.440498] pci 0000:09:00.1: reg 18: [mem 0xe1a00000-0xe1a007ff]
[    1.440701] pci 0000:09:00.1: supports D1 D2
[    1.440702] pci 0000:09:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    1.440713] pci 0000:09:00.1: PME# disabled
[    1.447771] pci 0000:00:1c.5: PCI bridge to [bus 09-09]
[    1.447777] pci 0000:00:1c.5:   bridge window [mem 0xe1a00000-0xe1afffff]
[    1.447805] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.448049] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.448093] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    1.448140] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
[    1.448197] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    1.448295] \_SB_.PCI0:_OSC invalid UUID
[    1.448296] _OSC request data:1 1f 1f 
[    1.448299]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.448338] \_SB_.PCI0:_OSC invalid UUID
[    1.448339] _OSC request data:1 0 1d 
[    1.448342]  pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control mask: 0x1d
[    1.448344] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.452434] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.452483] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    1.452531] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.452577] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.452624] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 *5 6 7 10 12 14 15)
[    1.452671] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.452717] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 *3 4 5 6 7 10 12 14 15)
[    1.452763] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.452851] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    1.452858] vgaarb: loaded
[    1.452860] vgaarb: bridge control possible 0000:00:02.0
[    1.452891] PCI: Using ACPI for IRQ routing
[    1.454441] PCI: pci_cache_line_size set to 64 bytes
[    1.456232] reserve RAM buffer: 0000000000091400 - 000000000009ffff 
[    1.456234] reserve RAM buffer: 00000000caa29000 - 00000000cbffffff 
[    1.456238] reserve RAM buffer: 00000000cadb7000 - 00000000cbffffff 
[    1.456241] reserve RAM buffer: 00000000cb000000 - 00000000cbffffff 
[    1.456243] reserve RAM buffer: 000000012e000000 - 000000012fffffff 
[    1.456336] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.456341] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.458357] Switching to clocksource hpet
[    1.459931] pnp: PnP ACPI init
[    1.459943] ACPI: bus type pnp registered
[    1.460312] pnp 00:00: [bus 00-3e]
[    1.460314] pnp 00:00: [io  0x0000-0x0cf7 window]
[    1.460316] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.460318] pnp 00:00: [io  0x0d00-0xffff window]
[    1.460320] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.460322] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    1.460323] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    1.460325] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    1.460327] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    1.460329] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    1.460331] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    1.460332] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    1.460334] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    1.460336] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    1.460338] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    1.460340] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    1.460342] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    1.460344] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    1.460346] pnp 00:00: [mem 0xcfa00000-0xfeafffff window]
[    1.460348] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    1.460391] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.460405] pnp 00:01: [io  0x0000-0x001f]
[    1.460406] pnp 00:01: [io  0x0081-0x0091]
[    1.460408] pnp 00:01: [io  0x0093-0x009f]
[    1.460409] pnp 00:01: [io  0x00c0-0x00df]
[    1.460411] pnp 00:01: [dma 4]
[    1.460431] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.460439] pnp 00:02: [mem 0xff000000-0xffffffff]
[    1.460458] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    1.460535] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    1.460571] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
[    1.460573] system 00:03: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    1.460583] pnp 00:04: [io  0x00f0]
[    1.460594] pnp 00:04: [irq 13]
[    1.460613] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.460623] pnp 00:05: [io  0x002e-0x002f]
[    1.460625] pnp 00:05: [io  0x004e-0x004f]
[    1.460626] pnp 00:05: [io  0x0061]
[    1.460628] pnp 00:05: [io  0x0063]
[    1.460629] pnp 00:05: [io  0x0065]
[    1.460631] pnp 00:05: [io  0x0067]
[    1.460632] pnp 00:05: [io  0x0070]
[    1.460633] pnp 00:05: [io  0x0080]
[    1.460635] pnp 00:05: [io  0x0092]
[    1.460636] pnp 00:05: [io  0x00b2-0x00b3]
[    1.460638] pnp 00:05: [io  0x0680-0x069f]
[    1.460639] pnp 00:05: [io  0x1000-0x100f]
[    1.460641] pnp 00:05: [io  0xffff]
[    1.460642] pnp 00:05: [io  0xffff]
[    1.460643] pnp 00:05: [io  0x0400-0x047f]
[    1.460645] pnp 00:05: [io  0x0500-0x057f]
[    1.460647] pnp 00:05: [io  0x164e-0x164f]
[    1.460682] system 00:05: [io  0x0680-0x069f] has been reserved
[    1.460685] system 00:05: [io  0x1000-0x100f] has been reserved
[    1.460687] system 00:05: [io  0xffff] has been reserved
[    1.460689] system 00:05: [io  0xffff] has been reserved
[    1.460691] system 00:05: [io  0x0400-0x047f] has been reserved
[    1.460693] system 00:05: [io  0x0500-0x057f] has been reserved
[    1.460695] system 00:05: [io  0x164e-0x164f] has been reserved
[    1.460697] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.460705] pnp 00:06: [io  0x0070-0x0077]
[    1.460711] pnp 00:06: [irq 8]
[    1.460732] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.460742] pnp 00:07: [io  0x0060]
[    1.460744] pnp 00:07: [io  0x0064]
[    1.460750] pnp 00:07: [irq 1]
[    1.460769] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.462013] Switched to NOHz mode on CPU #0
[    1.462101] Switched to NOHz mode on CPU #3
[    1.462108] Switched to NOHz mode on CPU #2
[    1.462141] Switched to NOHz mode on CPU #1
[    1.463208] pnp 00:08: Plug and Play ACPI device, IDs PNP0401 (disabled)
[    1.463222] pnp 00:09: [irq 12]
[    1.463245] pnp 00:09: Plug and Play ACPI device, IDs DLL04a9 PNP0f13 (active)
[    1.463400] pnp 00:0a: [mem 0xfed1c000-0xfed1ffff]
[    1.463402] pnp 00:0a: [mem 0xfed10000-0xfed17fff]
[    1.463403] pnp 00:0a: [mem 0xfed18000-0xfed18fff]
[    1.463405] pnp 00:0a: [mem 0xfed19000-0xfed19fff]
[    1.463406] pnp 00:0a: [mem 0xf8000000-0xfbffffff]
[    1.463408] pnp 00:0a: [mem 0xfed20000-0xfed3ffff]
[    1.463409] pnp 00:0a: [mem 0xfed90000-0xfed93fff]
[    1.463411] pnp 00:0a: [mem 0xfed45000-0xfed8ffff]
[    1.463413] pnp 00:0a: [mem 0xff000000-0xffffffff]
[    1.463414] pnp 00:0a: [mem 0xfee00000-0xfeefffff]
[    1.463416] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    1.463418] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    1.463463] system 00:0a: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.463465] system 00:0a: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.463468] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.463470] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.463472] system 00:0a: [mem 0xf8000000-0xfbffffff] has been reserved
[    1.463474] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.463477] system 00:0a: [mem 0xfed90000-0xfed93fff] has been reserved
[    1.463479] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.463481] system 00:0a: [mem 0xff000000-0xffffffff] could not be reserved
[    1.463484] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.463486] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.463869] pnp 00:0b: [irq 23]
[    1.463900] pnp 00:0b: Plug and Play ACPI device, IDs SMO8800 (active)
[    1.478397] pnp 00:0c: [mem 0x20000000-0x201fffff]
[    1.478399] pnp 00:0c: [mem 0x40000000-0x401fffff]
[    1.478456] system 00:0c: [mem 0x20000000-0x201fffff] has been reserved
[    1.478458] system 00:0c: [mem 0x40000000-0x401fffff] has been reserved
[    1.478461] system 00:0c: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.478469] pnp: PnP ACPI: found 13 devices
[    1.478470] ACPI: ACPI bus type pnp unregistered
[    1.485057] PCI: max bus depth: 1 pci_try_num: 2
[    1.485096] pci 0000:00:1c.0: PCI bridge to [bus 01-01]
[    1.485108] pci 0000:00:1c.1: PCI bridge to [bus 02-02]
[    1.485113] pci 0000:00:1c.1:   bridge window [mem 0xe1b00000-0xe1bfffff]
[    1.485122] pci 0000:00:1c.2: PCI bridge to [bus 03-08]
[    1.485125] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
[    1.485130] pci 0000:00:1c.2:   bridge window [mem 0xe1000000-0xe19fffff]
[    1.485135] pci 0000:00:1c.2:   bridge window [mem 0xe0000000-0xe09fffff 64bit pref]
[    1.485141] pci 0000:00:1c.5: PCI bridge to [bus 09-09]
[    1.485148] pci 0000:00:1c.5:   bridge window [mem 0xe1a00000-0xe1afffff]
[    1.485174] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.485180] pci 0000:00:1c.0: setting latency timer to 64
[    1.485192] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.485196] pci 0000:00:1c.1: setting latency timer to 64
[    1.485207] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.485211] pci 0000:00:1c.2: setting latency timer to 64
[    1.485218] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.485224] pci 0000:00:1c.5: setting latency timer to 64
[    1.485228] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.485230] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.485232] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.485233] pci_bus 0000:00: resource 7 [mem 0xcfa00000-0xfeafffff]
[    1.485235] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    1.485237] pci_bus 0000:02: resource 1 [mem 0xe1b00000-0xe1bfffff]
[    1.485239] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    1.485241] pci_bus 0000:03: resource 1 [mem 0xe1000000-0xe19fffff]
[    1.485243] pci_bus 0000:03: resource 2 [mem 0xe0000000-0xe09fffff 64bit pref]
[    1.485244] pci_bus 0000:09: resource 1 [mem 0xe1a00000-0xe1afffff]
[    1.485309] NET: Registered protocol family 2
[    1.485447] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.486332] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.488071] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.488288] TCP: Hash tables configured (established 524288 bind 65536)
[    1.488290] TCP reno registered
[    1.488300] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    1.488321] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    1.488458] NET: Registered protocol family 1
[    1.488470] pci 0000:00:02.0: Boot video device
[    1.490288] PCI: CLS 64 bytes, default 64
[    1.490325] Unpacking initramfs...
[    1.696257] Freeing initrd memory: 10908k freed
[    1.697618] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.697622] Placing 64MB software IO TLB between ffff8800c6a29000 - ffff8800caa29000
[    1.697624] software IO TLB at phys 0xc6a29000 - 0xcaa29000
[    1.697640] Simple Boot Flag at 0xf3 set to 0x1
[    1.698142] audit: initializing netlink socket (disabled)
[    1.698151] type=2000 audit(1324559388.544:1): initialized
[    1.716362] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.727980] VFS: Disk quotas dquot_6.5.2
[    1.728012] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.728081] msgmni has been set to 7688
[    1.728247] alg: No test for stdrng (krng)
[    1.728276] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.728279] io scheduler noop registered
[    1.728280] io scheduler deadline registered
[    1.728300] io scheduler cfq registered (default)
[    1.728642] intel_idle: MWAIT substates: 0x21120
[    1.728643] intel_idle: v0.4 model 0x2A
[    1.728645] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.728689] ERST: Table is not found!
[    1.728690] GHES: HEST is not enabled!
[    1.728749] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.902076] Linux agpgart interface v0.103
[    1.902142] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.902230] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    1.903183] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.903290] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    1.903392] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.903600] i8042: Warning: Keylock active
[    1.904830] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.904836] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.904935] mousedev: PS/2 mouse device common for all mice
[    1.904975] rtc_cmos 00:06: RTC can wake from S4
[    1.905091] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    1.905127] rtc0: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    1.905277] cpuidle: using governor ladder
[    1.905479] cpuidle: using governor menu
[    1.905639] TCP cubic registered
[    1.905735] NET: Registered protocol family 10
[    1.905810] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.906328] Mobile IPv6
[    1.906330] NET: Registered protocol family 17
[    1.906333] Registering the dns_resolver key type
[    1.906725] PM: Hibernation image not present or could not be loaded.
[    1.906736] registered taskstats version 1
[    1.914801] rtc_cmos 00:06: setting system clock to 2011-12-22 13:09:49 UTC (1324559389)
[    1.914856] Initializing network drop monitor service
[    1.915747] Freeing unused kernel memory: 556k freed
[    1.915813] Write protecting the kernel read-only data: 6144k
[    1.918258] Freeing unused kernel memory: 788k freed
[    1.920413] Freeing unused kernel memory: 696k freed
[    1.972459] udevd[61]: starting version 175
[    1.994053] e1000e: Intel(R) PRO/1000 Network Driver - 1.4.4-k
[    1.994056] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    1.994100] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    1.994111] e1000e 0000:00:19.0: setting latency timer to 64
[    1.994227] e1000e 0000:00:19.0: irq 42 for MSI/MSI-X
[    1.998164] sdhci: Secure Digital Host Controller Interface driver
[    1.998167] sdhci: Copyright(c) Pierre Ossman
[    1.998890] sdhci-pci 0000:09:00.0: SDHCI controller found [1217:8221] (rev 5)
[    2.000620] sdhci-pci 0000:09:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    2.000681] sdhci-pci 0000:09:00.0: Invalid iomem size. You may experience problems.
[    2.000785] sdhci-pci 0000:09:00.0: setting latency timer to 64
[    2.000816] mmc0: no vmmc regulator found
[    2.000857] Registered led device: mmc0::
[    2.004856] usbcore: registered new interface driver usbfs
[    2.004879] usbcore: registered new interface driver hub
[    2.011574] usbcore: registered new device driver usb
[    2.011988] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.012009] mmc0: SDHCI controller on PCI [0000:09:00.0] using DMA
[    2.016393] SCSI subsystem initialized
[    2.018386] libata version 3.00 loaded.
[    2.105636] thermal LNXTHERM:00: registered as thermal_zone0
[    2.105639] ACPI: Thermal Zone [THM] (25 C)
[    2.297266] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1) 84:8f:69:f0:33:bc
[    2.297269] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    2.297321] e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: 9041FF-0FF
[    2.297356] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.297391] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.297396] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    2.297424] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    2.297456] ehci_hcd 0000:00:1a.0: debug port 2
[    2.301337] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    2.301354] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xe1c70000
[    2.317287] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    2.317313] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.317316] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.317318] usb usb1: Product: EHCI Host Controller
[    2.317319] usb usb1: Manufacturer: Linux 3.1.0-1-amd64 ehci_hcd
[    2.317321] usb usb1: SerialNumber: 0000:00:1a.0
[    2.317458] hub 1-0:1.0: USB hub found
[    2.317462] hub 1-0:1.0: 2 ports detected
[    2.317528] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    2.317562] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    2.317566] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    2.317573] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    2.317600] ehci_hcd 0000:00:1d.0: debug port 2
[    2.321484] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    2.321490] ehci_hcd 0000:00:1d.0: irq 17, io mem 0xe1c50000
[    2.337271] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.337296] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.337299] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.337301] usb usb2: Product: EHCI Host Controller
[    2.337302] usb usb2: Manufacturer: Linux 3.1.0-1-amd64 ehci_hcd
[    2.337304] usb usb2: SerialNumber: 0000:00:1d.0
[    2.339149] hub 2-0:1.0: USB hub found
[    2.339153] hub 2-0:1.0: 2 ports detected
[    2.339223] ahci 0000:00:1f.2: version 3.0
[    2.339242] ahci 0000:00:1f.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    2.339318] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    2.339355] ahci: SSS flag set, parallel bus scan disabled
[    2.353278] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3b impl RAID mode
[    2.353282] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems sxs apst 
[    2.353289] ahci 0000:00:1f.2: setting latency timer to 64
[    2.385846] scsi0 : ahci
[    2.386014] scsi1 : ahci
[    2.386127] scsi2 : ahci
[    2.386278] scsi3 : ahci
[    2.386387] scsi4 : ahci
[    2.386499] scsi5 : ahci
[    2.601327] ata1: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40100 irq 43
[    2.601333] ata2: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40180 irq 43
[    2.601335] ata3: DUMMY
[    2.601338] ata4: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40280 irq 43
[    2.601341] ata5: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40300 irq 43
[    2.601344] ata6: SATA max UDMA/133 abar m2048@0xe1c40000 port 0xe1c40380 irq 43
[    2.628825] usb 1-1: new high speed USB device number 2 using ehci_hcd
[    2.692754] Refined TSC clocksource calibration: 2494.333 MHz.
[    2.692765] Switching to clocksource tsc
[    2.761188] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    2.761192] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.761469] hub 1-1:1.0: USB hub found
[    2.761555] hub 1-1:1.0: 6 ports detected
[    2.872564] usb 2-1: new high speed USB device number 2 using ehci_hcd
[    2.920507] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.961163] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.964543] ata1.00: ATA-8: SAMSUNG SSD PM810 2.5" 7mm 128GB, AXM08D1Q, max UDMA/133
[    2.964559] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.969140] ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected by device (Stat=0x51 Err=0x04)
[    2.970935] ata1.00: configured for UDMA/133
[    2.971116] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SSD PM81 AXM0 PQ: 0 ANSI: 5
[    3.006563] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    3.006582] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.006915] hub 2-1:1.0: USB hub found
[    3.006992] hub 2-1:1.0: 8 ports detected
[    3.080464] usb 1-1.4: new full speed USB device number 3 using ehci_hcd
[    3.177148] usb 1-1.4: New USB device found, idVendor=413c, idProduct=8187
[    3.177151] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.177154] usb 1-1.4: Product: DW375 Bluetooth Module
[    3.177155] usb 1-1.4: Manufacturer: Dell Computer Corp
[    3.177157] usb 1-1.4: SerialNumber: D0DF9AB482E6
[    3.248251] usb 1-1.5: new high speed USB device number 4 using ehci_hcd
[    3.295960] ata2: SATA link down (SStatus 0 SControl 300)
[    3.461537] usb 1-1.5: New USB device found, idVendor=1bcf, idProduct=2804
[    3.461540] usb 1-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.461543] usb 1-1.5: Product: Laptop_Integrated_Webcam_HD
[    3.461544] usb 1-1.5: Manufacturer: CN018T967248719N0BP8A01
[    3.615605] ata4: SATA link down (SStatus 0 SControl 300)
[    3.705381] usb 2-1.8: new full speed USB device number 3 using ehci_hcd
[    3.823779] usb 2-1.8: New USB device found, idVendor=0a5c, idProduct=5801
[    3.823782] usb 2-1.8: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.823784] usb 2-1.8: Product: 5880
[    3.823786] usb 2-1.8: Manufacturer: Broadcom Corp
[    3.823787] usb 2-1.8: SerialNumber: 0123456789ABCD
[    3.824004] usb 2-1.8: config 0 descriptor??
[    3.935188] ata5: SATA link down (SStatus 0 SControl 300)
[    4.254779] ata6: SATA link down (SStatus 0 SControl 300)
[    4.258226] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    4.258306] sd 0:0:0:0: [sda] Write Protect is off
[    4.258309] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.258337] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.260477]  sda: sda1 sda2 < sda5 >
[    4.261036] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.619868] device-mapper: uevent: version 1.0.3
[    4.619946] device-mapper: ioctl: 4.21.0-ioctl (2011-07-06) initialised: dm-devel@redhat.com
[    7.592082] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    7.593986] alg: No test for __cbc-aes-aesni (cryptd(__driver-cbc-aes-aesni))
[    8.235430] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[    8.466812] udevd[372]: starting version 175
[    8.522348] ACPI: acpi_idle yielding to intel_idle
[    8.523157] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[    8.525037] ACPI: Lid Switch [LID]
[    8.525113] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    8.525120] ACPI: Power Button [PBTN]
[    8.525205] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[    8.525209] ACPI: Sleep Button [SBTN]
[    8.525380] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    8.525385] ACPI: Power Button [PWRF]
[    8.555052] iTCO_vendor_support: vendor-support=0
[    8.556082] ACPI: Battery Slot [BAT0] (battery present)
[    8.569981] Bluetooth: Core ver 2.16
[    8.570001] NET: Registered protocol family 31
[    8.570003] Bluetooth: HCI device and connection manager initialized
[    8.570006] Bluetooth: HCI socket layer initialized
[    8.570008] Bluetooth: L2CAP socket layer initialized
[    8.570013] Bluetooth: SCO socket layer initialized
[    8.571141] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    8.596015] Bluetooth: Generic Bluetooth USB driver ver 0.6
[    8.606837] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    8.673519] ACPI: Battery Slot [BAT1] (battery absent)
[    8.673702] wmi: Mapper loaded
[    8.675063] usbcore: registered new interface driver btusb
[    8.675421] ACPI: AC Adapter [AC] (on-line)
[    8.676478] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[    8.676570] iTCO_wdt: Found a Cougar Point TCO device (Version=2, TCOBASE=0x0460)
[    8.676642] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    8.677185] parport_pc 00:08: [io  0x0378-0x037b]
[    8.678947] parport_pc 00:08: [irq 5]
[    8.688385] Linux media interface: v0.10
[    8.697926] cfg80211: Calling CRDA to update world regulatory domain
[    8.698707] Linux video capture interface: v2.00
[    8.702368] [drm] Initialized drm 1.1.0 20060810
[    8.703546] uvcvideo: Found UVC 1.00 device Laptop_Integrated_Webcam_HD (1bcf:2804)
[    8.705847] input: Dell WMI hotkeys as /devices/virtual/input/input5
[    8.714612] Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
[    8.714616] Copyright(c) 2003-2011 Intel Corporation
[    8.721348] input: Laptop_Integrated_Webcam_HD as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input6
[    8.721438] usbcore: registered new interface driver uvcvideo
[    8.721440] USB Video Class driver (1.1.1)
[    8.725013] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    8.725018] iwlagn 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    8.725029] iwlagn 0000:02:00.0: setting latency timer to 64
[    8.725031] i915 0000:00:02.0: setting latency timer to 64
[    8.725067] iwlagn 0000:02:00.0: pci_resource_len = 0x00002000
[    8.725069] iwlagn 0000:02:00.0: pci_resource_base = ffffc90000670000
[    8.725071] iwlagn 0000:02:00.0: HW Revision ID = 0x35
[    8.725150] iwlagn 0000:02:00.0: irq 44 for MSI/MSI-X
[    8.725184] iwlagn 0000:02:00.0: Detected Intel(R) Centrino(R) Ultimate-N 6300 AGN, REV=0x74
[    8.725231] iwlagn 0000:02:00.0: L1 Disabled; Enabling L0S
[    8.740244] iwlagn 0000:02:00.0: device EEPROM VER=0x43a, CALIB=0x6
[    8.740248] iwlagn 0000:02:00.0: Device SKU: 0X1f0
[    8.740250] iwlagn 0000:02:00.0: Valid Tx ant: 0X7, Valid Rx ant: 0X7
[    8.740271] iwlagn 0000:02:00.0: Tunable channels: 13 802.11bg, 24 802.11a channels
[    8.767745] i915 0000:00:02.0: irq 45 for MSI/MSI-X
[    8.767751] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    8.767752] [drm] Driver supports precise vblank timestamp query.
[    8.796987] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    8.805638] iwlagn 0000:02:00.0: loaded firmware version 9.221.4.1 build 25532
[    8.805937] Registered led device: phy0-led
[    8.808772] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[    9.432010] fbcon: inteldrmfb (fb0) is primary device
[    9.433482] [drm:ironlake_update_pch_refclk] *ERROR* enabling SSC on PCH
[    9.674901] Console: switching to colour frame buffer device 170x48
[    9.678129] fb0: inteldrmfb frame buffer device
[    9.678130] drm: registered panic notifier
[   10.007816] parport_pc 00:08: activated
[   10.007821] parport_pc 00:08: reported by Plug and Play ACPI
[   10.014100] parport_pc 00:08: disabled
[   10.510591] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
[   10.510602] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880128e7a3d0), AE_TIME (20110623/psparse-536)
[   10.510613] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880128e7a268), AE_TIME (20110623/psparse-536)
[   10.510618] ACPI Error: Method parse/execution failed [\ECGB] (Node ffff880128e7adf8), AE_TIME (20110623/psparse-536)
[   10.510623] ACPI Error: Method parse/execution failed [\_SB_.PCI0.VID_._DOD] (Node ffff880128e7e588), AE_TIME (20110623/psparse-536)
[   10.510632] ACPI Exception: AE_TIME, Evaluating _DOD (20110623/video-1147)
[   13.025907] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input7
[   13.115837] acpi device:37: registered as cooling_device4
[   13.195709] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input8
[   13.195769] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   13.195828] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   13.195880] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   13.195943] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
[   13.195970] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   13.743763] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input9
[   13.746610] HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
[   13.746945] HDMI status: Codec=3 Pin=6 Presence_Detect=0 ELD_Valid=0
[   13.747279] HDMI status: Codec=3 Pin=7 Presence_Detect=0 ELD_Valid=0
[   13.755584] input: HDA Intel PCH Mic at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   13.755668] input: HDA Intel PCH Mic at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   13.755728] input: HDA Intel PCH Line Out at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   13.755791] input: HDA Intel PCH HP Out at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   13.756067] input: HDA Intel PCH HDMI/DP as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   13.756122] input: HDA Intel PCH HDMI/DP as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   13.756176] input: HDA Intel PCH HDMI/DP as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   13.945338] EXT4-fs (dm-1): re-mounted. Opts: (null)
[   13.974062] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,commit=650
[   14.001873] loop: module loaded
[   14.111884] Adding 5099516k swap on /dev/mapper/pirx-swap_1.  Priority:-1 extents:1 across:5099516k 
[   14.233936] ip_tables: (C) 2000-2006 Netfilter Core Team
[   14.240913] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   14.245413] fuse init (API version 7.17)
[   15.591507] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input17
[   15.628272] TCP lp registered
[   29.481476] iwlagn 0000:02:00.0: L1 Disabled; Enabling L0S
[   29.487635] iwlagn 0000:02:00.0: Radio type=0x0-0x3-0x1
[   29.730486] iwlagn 0000:02:00.0: L1 Disabled; Enabling L0S
[   29.736670] iwlagn 0000:02:00.0: Radio type=0x0-0x3-0x1
[   29.849450] ADDRCONF(NETDEV_UP): wlan0: link is not ready

--=-=-=--
