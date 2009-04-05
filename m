From: Heinz Dittmar <heinzdittmar@hedi-elektronic.de>
Subject: If "acpi_osi=Linux" works better
Date: Sun, 5 Apr 2009 15:25:10 +0200
Message-ID: <200904051525.11164.heinzdittmar@hedi-elektronic.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3EL2Jt7U+ycTByF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65399 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbZDENZc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Apr 2009 09:25:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_3EL2Jt7U+ycTByF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

SuSE 11.1
Hallo,
This Problem begin with SuSE 11.1. By 11.0 bevor is thies Ok.
Best Regart
Heinz Dittmar


--Boundary-00=_3EL2Jt7U+ycTByF
Content-Type: text/plain;
  charset="UTF-8";
  name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="boot.msg"

Inspecting /boot/System.map-2.6.27.19-3.2-default
Cannot find map file.
No module symbols loaded - kernel modules not enabled.

Cannot build symbol table - disabling symbol lookups
klogd 1.4.1, log source = ksyslog started.
<6>Initializing cgroup subsys cpuset
<6>Initializing cgroup subsys cpu
<5>Linux version 2.6.27.19-3.2-default (geeko@buildhost) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP 2009-02-25 15:40:44 +0100
<6>Command line: root=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 resume=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part5 splash=verbose vga=0x345
<4>KERNEL supported cpus:
<4>  Intel GenuineIntel
<4>  AMD AuthenticAMD
<4>  Centaur CentaurHauls
<6>BIOS-provided physical RAM map:
<6> BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
<6> BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
<6> BIOS-e820: 00000000000e1000 - 0000000000100000 (reserved)
<6> BIOS-e820: 0000000000100000 - 00000000bff80000 (usable)
<6> BIOS-e820: 00000000bff80000 - 00000000bff8f000 (ACPI data)
<6> BIOS-e820: 00000000bff8f000 - 00000000bffe0000 (ACPI NVS)
<6> BIOS-e820: 00000000bffe0000 - 00000000c0000000 (reserved)
<6> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<6> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
<6> BIOS-e820: 0000000100000000 - 000000013c000000 (usable)
<6>DMI 2.5 present.
<5>AMI BIOS detected: BIOS may corrupt low RAM, working it around.
<6>last_pfn = 0x13c000 max_arch_pfn = 0x3ffffffff
<6>x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
<6>last_pfn = 0xbff80 max_arch_pfn = 0x3ffffffff
<6>init_memory_mapping
<7> 0000000000 - 00bfe00000 page 2M
<7> 00bfe00000 - 00bff80000 page 4k
<7>kernel direct mapping tables up to bff80000 @ 10000-15000
<6>last_map_addr: bff80000 end: bff80000
<6>init_memory_mapping
<7> 0100000000 - 013c000000 page 2M
<7>kernel direct mapping tables up to 13c000000 @ 13000-19000
<6>last_map_addr: 13c000000 end: 13c000000
<6>RAMDISK: 379d4000 - 37fef3c1
<4>ACPI: RSDP 000F93A0, 0024 (r2 ACPIAM)
<4>ACPI: XSDT BFF80100, 007C (r1 _ASUS_ Notebook 20080909 MSFT       97)
<4>ACPI: FACP BFF80290, 00F4 (r3 090908 FACP1856 20080909 MSFT       97)
<4>ACPI: DSDT BFF80680, D106 (r1  V1V00 V1V00209      209 INTL 20051117)
<4>ACPI: FACS BFF8F000, 0040
<4>ACPI: APIC BFF80390, 005C (r1 090908 APIC1856 20080909 MSFT       97)
<4>ACPI: MCFG BFF80430, 003C (r1 090908 OEMMCFG  20080909 MSFT       97)
<4>ACPI: SLIC BFF80470, 0176 (r1 _ASUS_ Notebook 20080909 MSFT       97)
<4>ACPI: ECDT BFF80620, 0054 (r1 090908 OEMECDT  20080909 MSFT       97)
<4>ACPI: DBGP BFF803F0, 0034 (r1 090908 DBGP1856 20080909 MSFT       97)
<4>ACPI: BOOT BFF805F0, 0028 (r1 090908 BOOT1856 20080909 MSFT       97)
<4>ACPI: OEMB BFF8F040, 0071 (r1 090908 OEMB1856 20080909 MSFT       97)
<4>ACPI: HPET BFF8D790, 0038 (r1 090908 OEMHPET  20080909 MSFT       97)
<4>ACPI: ATKG BFF8F2C0, 8024 (r1 090908  OEMATKG 20080909 MSFT       97)
<4>ACPI: SSDT BFF97E10, 04F0 (r1  PmRef    CpuPm     3000 INTL 20051117)
<7>ACPI: Local APIC address 0xfee00000
<6>No NUMA configuration found
<6>Faking a node at 0000000000000000-000000013c000000
<6>Bootmem setup node 0 0000000000000000-000000013c000000
<6>  NODE_DATA [0000000000014000 - 000000000002bfff]
<6>  bootmap [000000000002c000 -  00000000000537ff] pages 28
<6>(7 early reservations) ==> bootmem [0000000000 - 013c000000]
<6>  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
<6>  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
<6>  #2 [0000200000 - 0000bc98b8]    TEXT DATA BSS ==> [0000200000 - 0000bc98b8]
<6>  #3 [00379d4000 - 0037fef3c1]          RAMDISK ==> [00379d4000 - 0037fef3c1]
<6>  #4 [000009ec00 - 0000100000]    BIOS reserved ==> [000009ec00 - 0000100000]
<6>  #5 [0000010000 - 0000013000]          PGTABLE ==> [0000010000 - 0000013000]
<6>  #6 [0000013000 - 0000014000]          PGTABLE ==> [0000013000 - 0000014000]
<6>found SMP MP-table at [ffff8800000ff780] 000ff780
<7> [ffffe20000000000-ffffe20004ffffff] PMD -> [ffff880028200000-ffff88002c1fffff] on node 0
<4>Zone PFN ranges:
<4>  DMA      0x00000010 -> 0x00001000
<4>  DMA32    0x00001000 -> 0x00100000
<4>  Normal   0x00100000 -> 0x0013c000
<4>Movable zone start PFN for each node
<4>early_node_map[3] active PFN ranges
<4>    0: 0x00000010 -> 0x0000009e
<4>    0: 0x00000100 -> 0x000bff80
<4>    0: 0x00100000 -> 0x0013c000
<7>On node 0 totalpages: 1031950
<7>  DMA zone: 1307 pages, LIFO batch:0
<7>  DMA32 zone: 765888 pages, LIFO batch:31
<7>  Normal zone: 241920 pages, LIFO batch:31
<6>ACPI: PM-Timer IO Port: 0x808
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
<6>IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<6>ACPI: HPET id: 0x8086a301 base: 0xfed00000
<6>Using ACPI (MADT) for SMP configuration information
<6>SMP: Allowing 2 CPUs, 0 hotplug CPUs
<6>PM: Registered nosave memory: 000000000009e000 - 000000000009f000
<6>PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
<6>PM: Registered nosave memory: 00000000000a0000 - 00000000000e1000
<6>PM: Registered nosave memory: 00000000000e1000 - 0000000000100000
<6>PM: Registered nosave memory: 00000000bff80000 - 00000000bff8f000
<6>PM: Registered nosave memory: 00000000bff8f000 - 00000000bffe0000
<6>PM: Registered nosave memory: 00000000bffe0000 - 00000000c0000000
<6>PM: Registered nosave memory: 00000000c0000000 - 00000000fee00000
<6>PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
<6>PM: Registered nosave memory: 00000000fee01000 - 00000000ffb00000
<6>PM: Registered nosave memory: 00000000ffb00000 - 0000000100000000
<6>Allocating PCI resources starting at c4000000 (gap: c0000000:3ee00000)
<6>PERCPU: Allocating 61344 bytes of per cpu data
<7>NR_CPUS: 512, nr_cpu_ids: 2, nr_node_ids 1
<4>Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1009115
<4>Policy zone: Normal
<5>Kernel command line: root=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 resume=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part5 splash=verbose vga=0x345
<6>bootsplash: verbose mode.
<6>Initializing CPU#0
<4>PID hash table entries: 4096 (order: 12, 32768 bytes)
<6>Extended CMOS year: 2000
<6>TSC: PIT calibration confirmed by PMTIMER.
<6>TSC: using PIT calibration value
<4>Detected 2393.986 MHz processor.
<4>Console: colour dummy device 80x25
<6>console [tty0] enabled
<6>Checking aperture...
<6>No AGP bridge found
<6>PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
<6>Placing software IO TLB between 0x20000000 - 0x24000000
<6>Memory: 3979428k/5177344k available (2699k kernel code, 148372k reserved, 3164k data, 788k init)
<7>CPA: page pool initialized 1 of 1 pages preallocated
<7>hpet clockevent registered
<6>Calibrating delay loop (skipped), value calculated using timer frequency.. 4787.97 BogoMIPS (lpj=9575944)
<4>kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
<6>Security Framework initialized
<6>AppArmor: AppArmor initialized
<6>Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
<6>Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
<4>Mount-cache hash table entries: 256
<6>Initializing cgroup subsys ns
<6>Initializing cgroup subsys cpuacct
<6>Initializing cgroup subsys memory
<6>Initializing cgroup subsys devices
<6>Initializing cgroup subsys freezer
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 3072K
<6>CPU 0/0 -> Node 0
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 0
<7>CPU0: Thermal monitoring handled by SMI
<6>using mwait in idle threads.
<6>ACPI: Core revision 20080609
<6>ACPI: Checking initramfs for custom DSDT
<4>Parsing all Control Methods:
<4>Table [DSDT](id 0001) - 1950 Objects with 88 Devices 622 Methods 73 Regions
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0002) - 15 Objects with 0 Devices 4 Methods 0 Regions
<4> tbxface-0596 [00] tb_load_namespace     : ACPI Tables successfully acquired
<4>evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
<6>Setting APIC routing to flat
<6>..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
<6>CPU0: Intel(R) Core(TM)2 Duo CPU     P8600  @ 2.40GHz stepping 06
<6>Using local APIC timer interrupts.
<7>APIC timer calibration result 16624937
<6>Detected 16.624 MHz APIC timer.
<6>Booting processor 1/1 ip 6000
<6>Initializing CPU#1
<6>Calibrating delay using timer specific routine.. 4788.00 BogoMIPS (lpj=9576018)
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 3072K
<6>CPU 1/1 -> Node 0
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 1
<6>CPU1: Thermal monitoring enabled (TM2)
<6>x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
<6>CPU1: Intel(R) Core(TM)2 Duo CPU     P8600  @ 2.40GHz stepping 06
<6>checking TSC synchronization [CPU#0 -> CPU#1]: passed.
<6>Brought up 2 CPUs
<6>Total of 2 processors activated (9575.98 BogoMIPS).
<7>CPU0 attaching sched-domain:
<7> domain 0: span 0-1 level MC
<7>  groups: 0 1
<7>  domain 1: span 0-1 level NODE
<7>   groups: 0-1
<7>CPU1 attaching sched-domain:
<7> domain 0: span 0-1 level MC
<7>  groups: 1 0
<7>  domain 1: span 0-1 level NODE
<7>   groups: 0-1
<6>net_namespace: 1936 bytes
<6>NET: Registered protocol family 16
<6>ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
<6>ACPI: bus type pci registered
<5>PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
<6>PCI: Not using MMCONFIG.
<6>PCI: Using configuration type 1 for base access
<5>perfmon: version 2.82
<5>perfmon: CPU hotplug support enabled
<4>evgpeblk-0957 [00] ev_create_gpe_block   : GPE 00 to 3F [_GPE] 8 regs on int 0x9
<6>ACPI: EC: EC description table is found, configuring boot EC
<4>Completing Region/Field/Buffer/Package initialization:............................................................................................................................................................................................................................ACPI Error (nsaccess-0434): ACPI path has too many parent prefixes (^) - reached beyond root node [20080609]
<4>ACPI Error (nsaccess-0434): ACPI path has too many parent prefixes (^) - reached beyond root node [20080609]
<4>ACPI Error (nsaccess-0434): ACPI path has too many parent prefixes (^) - reached beyond root node [20080609]
<4>........
<4>Initialized 73/73 Regions 50/50 Fields 60/60 Buffers 45/45 Packages (1974 nodes)
<4>Initializing Device/Processor/Thermal objects by executing _INI methods:.<5>ACPI: BIOS _OSI(Linux) query ignored
<5>ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
<4>...
<4>Executed 4 _INI methods requiring 0 _STA executions (examined 93 objects)
<4>evgpeblk-1054 [00] ev_initialize_gpe_bloc: Found 9 Wake, Enabled 7 Runtime GPEs in this block
<6>ACPI: Interpreter enabled
<6>ACPI: (supports S0 S1 S3 S4 S5)
<6>ACPI: Using IOAPIC for interrupt routing
<5>PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
<5>PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
<6>PCI: Using MMCONFIG at e0000000 - efffffff
<6>ACPI: EC: GPE = 0x1b, I/O: command/status = 0x66, data = 0x62
<6>ACPI: EC: driver started in poll mode
<6>ACPI: PCI Root Bridge [PCI0] (0000:00)
<6>pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:01.0: PME# disabled
<7>PCI: 0000:00:03.0 reg 10 64bit mmio: [fd5ffc00, fd5ffc0f]
<6>pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:03.0: PME# disabled
<7>PCI: 0000:00:03.2 reg 10 io port: [bc00, bc07]
<7>PCI: 0000:00:03.2 reg 14 io port: [b880, b883]
<7>PCI: 0000:00:03.2 reg 18 io port: [b800, b807]
<7>PCI: 0000:00:03.2 reg 1c io port: [b480, b483]
<7>PCI: 0000:00:03.2 reg 20 io port: [b400, b40f]
<7>PCI: 0000:00:03.3 reg 10 io port: [b080, b087]
<7>PCI: 0000:00:03.3 reg 14 32bit mmio: [fd5fe000, fd5fefff]
<7>PCI: 0000:00:19.0 reg 10 32bit mmio: [fd5c0000, fd5dffff]
<7>PCI: 0000:00:19.0 reg 14 32bit mmio: [fd5fd000, fd5fdfff]
<7>PCI: 0000:00:19.0 reg 18 io port: [b000, b01f]
<6>pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:19.0: PME# disabled
<7>PCI: 0000:00:1a.0 reg 20 io port: [ac00, ac1f]
<7>PCI: 0000:00:1a.1 reg 20 io port: [a880, a89f]
<7>PCI: 0000:00:1a.2 reg 20 io port: [a800, a81f]
<7>PCI: 0000:00:1a.7 reg 10 32bit mmio: [fd5ff800, fd5ffbff]
<6>pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1a.7: PME# disabled
<7>PCI: 0000:00:1b.0 reg 10 64bit mmio: [fd5f4000, fd5f7fff]
<6>pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1b.0: PME# disabled
<6>pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1c.0: PME# disabled
<6>pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1c.1: PME# disabled
<6>pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1c.2: PME# disabled
<6>pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1c.3: PME# disabled
<6>pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1c.4: PME# disabled
<7>PCI: 0000:00:1d.0 reg 20 io port: [a480, a49f]
<7>PCI: 0000:00:1d.1 reg 20 io port: [a400, a41f]
<7>PCI: 0000:00:1d.2 reg 20 io port: [a080, a09f]
<7>PCI: 0000:00:1d.7 reg 10 32bit mmio: [fd5ff400, fd5ff7ff]
<6>pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
<6>pci 0000:00:1d.7: PME# disabled
<7>PCI: 0000:00:1f.2 reg 10 io port: [a000, a007]
<7>PCI: 0000:00:1f.2 reg 14 io port: [9c00, 9c03]
<7>PCI: 0000:00:1f.2 reg 18 io port: [9880, 9887]
<7>PCI: 0000:00:1f.2 reg 1c io port: [9800, 9803]
<7>PCI: 0000:00:1f.2 reg 20 io port: [9480, 949f]
<7>PCI: 0000:00:1f.2 reg 24 32bit mmio: [fd5fc800, fd5fcfff]
<6>pci 0000:00:1f.2: PME# supported from D3hot
<6>pci 0000:00:1f.2: PME# disabled
<7>PCI: 0000:01:00.0 reg 10 32bit mmio: [d0000000, dfffffff]
<7>PCI: 0000:01:00.0 reg 14 io port: [c000, c0ff]
<7>PCI: 0000:01:00.0 reg 18 32bit mmio: [fd6f0000, fd6fffff]
<7>PCI: 0000:01:00.0 reg 30 32bit mmio: [0, 1ffff]
<7>pci 0000:01:00.0: supports D1
<7>pci 0000:01:00.0: supports D2
<7>PCI: 0000:01:00.1 reg 10 32bit mmio: [fd6ec000, fd6effff]
<7>pci 0000:01:00.1: supports D1
<7>pci 0000:01:00.1: supports D2
<7>PCI: bridge 0000:00:01.0 io port: [c000, cfff]
<7>PCI: bridge 0000:00:01.0 32bit mmio: [fd600000, fd6fffff]
<7>PCI: bridge 0000:00:01.0 64bit mmio pref: [d0000000, dfffffff]
<7>PCI: 0000:03:00.0 reg 10 64bit mmio: [fd7fe000, fd7fffff]
<6>pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
<6>pci 0000:03:00.0: PME# disabled
<7>PCI: bridge 0000:00:1c.1 32bit mmio: [fd700000, fd7fffff]
<7>PCI: bridge 0000:00:1c.2 io port: [d000, dfff]
<7>PCI: bridge 0000:00:1c.2 32bit mmio: [fd800000, fdffffff]
<7>PCI: bridge 0000:00:1c.2 64bit mmio pref: [f8000000, f9ffffff]
<7>PCI: bridge 0000:00:1c.4 io port: [e000, efff]
<7>PCI: bridge 0000:00:1c.4 32bit mmio: [fe000000, feafffff]
<7>PCI: bridge 0000:00:1c.4 64bit mmio pref: [fa000000, fcffffff]
<7>PCI: 0000:08:01.0 reg 10 32bit mmio: [febff800, febfffff]
<6>pci 0000:08:01.0: PME# supported from D0 D3hot D3cold
<6>pci 0000:08:01.0: PME# disabled
<7>PCI: 0000:08:01.1 reg 10 32bit mmio: [febff400, febff4ff]
<7>pci 0000:08:01.1: supports D1
<7>pci 0000:08:01.1: supports D2
<6>pci 0000:08:01.1: PME# supported from D0 D1 D2 D3hot D3cold
<6>pci 0000:08:01.1: PME# disabled
<7>PCI: 0000:08:01.2 reg 10 32bit mmio: [febff000, febff0ff]
<7>pci 0000:08:01.2: supports D1
<7>pci 0000:08:01.2: supports D2
<6>pci 0000:08:01.2: PME# supported from D0 D1 D2 D3hot D3cold
<6>pci 0000:08:01.2: PME# disabled
<7>PCI: 0000:08:01.3 reg 10 32bit mmio: [febfec00, febfecff]
<7>pci 0000:08:01.3: supports D1
<7>pci 0000:08:01.3: supports D2
<6>pci 0000:08:01.3: PME# supported from D0 D1 D2 D3hot D3cold
<6>pci 0000:08:01.3: PME# disabled
<7>PCI: 0000:08:01.4 reg 10 32bit mmio: [febfe800, febfe8ff]
<7>pci 0000:08:01.4: supports D1
<7>pci 0000:08:01.4: supports D2
<6>pci 0000:08:01.4: PME# supported from D0 D1 D2 D3hot D3cold
<6>pci 0000:08:01.4: PME# disabled
<6>pci 0000:00:1e.0: transparent bridge
<7>PCI: bridge 0000:00:1e.0 32bit mmio: [feb00000, febfffff]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
<6>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12)
<6>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *10 12)
<6>ACPI: PCI Interrupt Link [LNKC] (IRQs *6)
<6>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *7 10 12)
<6>ACPI: PCI Interrupt Link [LNKE] (IRQs *6)
<6>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 12)
<6>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 12)
<6>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 12)
<4>ACPI Warning (tbutils-0217): Incorrect checksum in table [ATKG] - 17, should be E7 [20080609]
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>pnp: PnP ACPI init
<6>ACPI: bus type pnp registered
<6>pnp: PnP ACPI: found 17 devices
<6>ACPI: ACPI bus type pnp unregistered
<6>PCI: Using ACPI for IRQ routing
<6>PCI-GART: No AMD northbridge found.
<6>hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
<6>hpet0: 4 64-bit timers, 14318180 Hz
<6>AppArmor: AppArmor Filesystem Enabled
<4>ACPI: RTC can wake from S4
<7>Switched to high resolution mode on CPU 0
<7>Switched to high resolution mode on CPU 1
<6>system 00:01: iomem range 0xfed10000-0xfed19fff has been reserved
<6>system 00:09: ioport range 0x162e-0x162f has been reserved
<6>system 00:09: ioport range 0x6c0-0x6cf has been reserved
<6>system 00:09: ioport range 0x680-0x680 has been reserved
<6>system 00:0a: ioport range 0x4d0-0x4d1 has been reserved
<6>system 00:0a: ioport range 0x800-0x87f has been reserved
<6>system 00:0a: ioport range 0x400-0x41f has been reserved
<6>system 00:0a: ioport range 0x500-0x57f has been reserved
<6>system 00:0a: iomem range 0xfed1c000-0xfed1ffff has been reserved
<6>system 00:0a: iomem range 0xfed20000-0xfed3ffff has been reserved
<6>system 00:0a: iomem range 0xfed45000-0xfed89fff has been reserved
<6>system 00:0a: iomem range 0xfed90000-0xfed90fff has been reserved
<6>system 00:0a: iomem range 0xfed91000-0xfed91fff has been reserved
<6>system 00:0a: iomem range 0xfed92000-0xfed92fff has been reserved
<6>system 00:0a: iomem range 0xfed93000-0xfed93fff has been reserved
<6>system 00:0a: iomem range 0xffb00000-0xffbfffff could not be reserved
<6>system 00:0a: iomem range 0xfff00000-0xffffffff could not be reserved
<6>system 00:0c: iomem range 0xffa00000-0xffbfffff could not be reserved
<6>system 00:0c: iomem range 0xffe00000-0xffffffff could not be reserved
<6>system 00:0d: iomem range 0xffc00000-0xffdfffff could not be reserved
<6>system 00:0e: ioport range 0x250-0x253 has been reserved
<6>system 00:0e: ioport range 0x256-0x25f has been reserved
<6>system 00:0e: iomem range 0xfec00000-0xfec00fff has been reserved
<6>system 00:0e: iomem range 0xfee00000-0xfee00fff could not be reserved
<6>system 00:0e: iomem range 0xfec10000-0xfec17fff has been reserved
<6>system 00:0e: iomem range 0xfec18000-0xfec1ffff has been reserved
<6>system 00:0e: iomem range 0xfec20000-0xfec27fff has been reserved
<6>system 00:0e: iomem range 0xfec28000-0xfec2ffff has been reserved
<6>system 00:0e: iomem range 0xfec30000-0xfec37fff has been reserved
<6>system 00:0f: iomem range 0xe0000000-0xefffffff has been reserved
<6>system 00:10: iomem range 0x0-0x9ffff could not be reserved
<6>system 00:10: iomem range 0xc0000-0xcffff has been reserved
<6>system 00:10: iomem range 0xe0000-0xfffff could not be reserved
<6>system 00:10: iomem range 0x100000-0xbfffffff could not be reserved
<6>pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
<6>pci 0000:00:01.0:   IO window: 0xc000-0xcfff
<6>pci 0000:00:01.0:   MEM window: 0xfd600000-0xfd6fffff
<6>pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
<6>pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
<6>pci 0000:00:1c.0:   IO window: disabled
<6>pci 0000:00:1c.0:   MEM window: disabled
<6>pci 0000:00:1c.0:   PREFETCH window: disabled
<6>pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
<6>pci 0000:00:1c.1:   IO window: disabled
<6>pci 0000:00:1c.1:   MEM window: 0xfd700000-0xfd7fffff
<6>pci 0000:00:1c.1:   PREFETCH window: disabled
<6>pci 0000:00:1c.2: PCI bridge, secondary bus 0000:04
<6>pci 0000:00:1c.2:   IO window: 0xd000-0xdfff
<6>pci 0000:00:1c.2:   MEM window: 0xfd800000-0xfdffffff
<6>pci 0000:00:1c.2:   PREFETCH window: 0x000000f8000000-0x000000f9ffffff
<6>pci 0000:00:1c.3: PCI bridge, secondary bus 0000:06
<6>pci 0000:00:1c.3:   IO window: disabled
<6>pci 0000:00:1c.3:   MEM window: disabled
<6>pci 0000:00:1c.3:   PREFETCH window: disabled
<6>pci 0000:00:1c.4: PCI bridge, secondary bus 0000:07
<6>pci 0000:00:1c.4:   IO window: 0xe000-0xefff
<6>pci 0000:00:1c.4:   MEM window: 0xfe000000-0xfeafffff
<6>pci 0000:00:1c.4:   PREFETCH window: 0x000000fa000000-0x000000fcffffff
<6>pci 0000:00:1e.0: PCI bridge, secondary bus 0000:08
<6>pci 0000:00:1e.0:   IO window: disabled
<6>pci 0000:00:1e.0:   MEM window: 0xfeb00000-0xfebfffff
<6>pci 0000:00:1e.0:   PREFETCH window: disabled
<6>pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<7>pci 0000:00:01.0: setting latency timer to 64
<6>pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<7>pci 0000:00:1c.0: setting latency timer to 64
<6>pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
<7>pci 0000:00:1c.1: setting latency timer to 64
<6>pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
<7>pci 0000:00:1c.2: setting latency timer to 64
<6>pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
<7>pci 0000:00:1c.3: setting latency timer to 64
<6>pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<7>pci 0000:00:1c.4: setting latency timer to 64
<7>pci 0000:00:1e.0: setting latency timer to 64
<6>bus: 00 index 0 io port: [0, ffff]
<6>bus: 00 index 1 mmio: [0, ffffffffffffffff]
<6>bus: 01 index 0 io port: [c000, cfff]
<6>bus: 01 index 1 mmio: [fd600000, fd6fffff]
<6>bus: 01 index 2 mmio: [d0000000, dfffffff]
<6>bus: 01 index 3 mmio: [0, 0]
<6>bus: 02 index 0 mmio: [0, 0]
<6>bus: 02 index 1 mmio: [0, 0]
<6>bus: 02 index 2 mmio: [0, 0]
<6>bus: 02 index 3 mmio: [0, 0]
<6>bus: 03 index 0 mmio: [0, 0]
<6>bus: 03 index 1 mmio: [fd700000, fd7fffff]
<6>bus: 03 index 2 mmio: [0, 0]
<6>bus: 03 index 3 mmio: [0, 0]
<6>bus: 04 index 0 io port: [d000, dfff]
<6>bus: 04 index 1 mmio: [fd800000, fdffffff]
<6>bus: 04 index 2 mmio: [f8000000, f9ffffff]
<6>bus: 04 index 3 mmio: [0, 0]
<6>bus: 06 index 0 mmio: [0, 0]
<6>bus: 06 index 1 mmio: [0, 0]
<6>bus: 06 index 2 mmio: [0, 0]
<6>bus: 06 index 3 mmio: [0, 0]
<6>bus: 07 index 0 io port: [e000, efff]
<6>bus: 07 index 1 mmio: [fe000000, feafffff]
<6>bus: 07 index 2 mmio: [fa000000, fcffffff]
<6>bus: 07 index 3 mmio: [0, 0]
<6>bus: 08 index 0 mmio: [0, 0]
<6>bus: 08 index 1 mmio: [feb00000, febfffff]
<6>bus: 08 index 2 mmio: [0, 0]
<6>bus: 08 index 3 io port: [0, ffff]
<6>bus: 08 index 4 mmio: [0, ffffffffffffffff]
<6>NET: Registered protocol family 2
<6>IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
<6>TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
<6>TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
<6>TCP: Hash tables configured (established 524288 bind 65536)
<6>TCP reno registered
<6>NET: Registered protocol family 1
<6>Unpacking initramfs... done
<6>Freeing initrd memory: 6252k freed
<6>Simple Boot Flag at 0x51 set to 0x1
<6>audit: initializing netlink socket (disabled)
<5>type=2000 audit(1238935991.916:1): initialized
<6>HugeTLB registered 2 MB page size, pre-allocated 0 pages
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
<6>msgmni has been set to 1946
<6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<6>perfmon: added sampling format default
<7>pci 0000:01:00.0: Boot video device
<7>pcieport-driver 0000:00:01.0: setting latency timer to 64
<6>pcieport-driver 0000:00:01.0: found MSI capability
<7>pci_express 0000:00:01.0:pcie00: allocate port service
<7>pci_express 0000:00:01.0:pcie02: allocate port service
<7>pci_express 0000:00:01.0:pcie03: allocate port service
<7>pcieport-driver 0000:00:1c.0: setting latency timer to 64
<6>pcieport-driver 0000:00:1c.0: found MSI capability
<7>pci_express 0000:00:1c.0:pcie00: allocate port service
<7>pci_express 0000:00:1c.0:pcie02: allocate port service
<7>pci_express 0000:00:1c.0:pcie03: allocate port service
<7>pcieport-driver 0000:00:1c.1: setting latency timer to 64
<6>pcieport-driver 0000:00:1c.1: found MSI capability
<7>pci_express 0000:00:1c.1:pcie00: allocate port service
<7>pci_express 0000:00:1c.1:pcie03: allocate port service
<7>pcieport-driver 0000:00:1c.2: setting latency timer to 64
<6>pcieport-driver 0000:00:1c.2: found MSI capability
<7>pci_express 0000:00:1c.2:pcie00: allocate port service
<7>pci_express 0000:00:1c.2:pcie02: allocate port service
<7>pci_express 0000:00:1c.2:pcie03: allocate port service
<7>pcieport-driver 0000:00:1c.3: setting latency timer to 64
<6>pcieport-driver 0000:00:1c.3: found MSI capability
<7>pci_express 0000:00:1c.3:pcie00: allocate port service
<7>pci_express 0000:00:1c.3:pcie02: allocate port service
<7>pci_express 0000:00:1c.3:pcie03: allocate port service
<7>pcieport-driver 0000:00:1c.4: setting latency timer to 64
<6>pcieport-driver 0000:00:1c.4: found MSI capability
<7>pci_express 0000:00:1c.4:pcie00: allocate port service
<7>pci_express 0000:00:1c.4:pcie02: allocate port service
<7>pci_express 0000:00:1c.4:pcie03: allocate port service
<6>vesafb: framebuffer at 0xd0000000, mapped to 0xffffc20011100000, using 11550k, total 16384k
<6>vesafb: mode is 1400x1050x16, linelength=2816, pages=4
<6>vesafb: scrolling: redraw
<6>vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
<6>bootsplash 3.1.6-2004/03/31: looking for picture...
<6>bootsplash: silentjpeg size 113987 bytes
<6>bootsplash: ...found (1400x1050, 45904 bytes, v3).
<4>Console: switching to colour frame buffer device 171x61
<6>fb0: VESA VGA frame buffer device
<7>hpet_resources: 0xfed00000 is busy
<6>Non-volatile memory driver v1.2
<6>Linux agpgart interface v0.103
<6>Serial: 8250/16550 driver8 ports, IRQ sharing disabled
<6>serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<6>serial 0000:00:03.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
<6>0000:00:03.3: ttyS4 at I/O 0xb080 (irq = 17) is a 16550A
<6>PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
<6>i8042.c: Detected active multiplexing controller, rev 1.1.
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>mice: PS/2 mouse device common for all mice
<6>input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
<6>cpuidle: using governor ladder
<6>cpuidle: using governor menu
<6>TCP cubic registered
<4>registered taskstats version 1
<6>Freeing unused kernel memory: 788k freed
<6>Write protecting the kernel read-only data: 4932k
<6>ACPI: ACPI Dock Station Driver: 2 docks/bays found
<5>SCSI subsystem initialized
<7>libata version 3.00 loaded.
<7>ahci 0000:00:1f.2: version 3.0
<6>ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
<6>ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 0x23 impl SATA mode
<6>ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems 
<7>ahci 0000:00:1f.2: setting latency timer to 64
<6>scsi0 : ahci
<6>scsi1 : ahci
<6>scsi2 : ahci
<6>scsi3 : ahci
<6>scsi4 : ahci
<6>scsi5 : ahci
<6>ata1: SATA max UDMA/133 abar m2048@0xfd5fc800 port 0xfd5fc900 irq 4345
<6>ata2: SATA max UDMA/133 abar m2048@0xfd5fc800 port 0xfd5fc980 irq 4345
<6>ata3: DUMMY
<6>ata4: DUMMY
<6>ata5: DUMMY
<6>ata6: SATA max UDMA/133 abar m2048@0xfd5fc800 port 0xfd5fcb80 irq 4345
<6>ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
<7>ata1.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
<6>ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
<6>ata1.00: ATA-8: WDC WD3200BEVT-22ZCT0, 11.01A11, max UDMA/133
<6>ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
<6>ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
<7>ata1.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
<6>ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
<6>ata1.00: configured for UDMA/133
<6>Synaptics Touchpad, model: 1, fw: 6.2, id: 0xa580b1, caps: 0xa04711/0x200000
<6>input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input1
<6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
<7>ata2.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
<6>ata2.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
<6>ata2.00: ATAPI: HL-DT-ST DVDRAM GSA-T50N, RR07, max UDMA/133
<7>ata2.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
<6>ata2.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
<6>ata2.00: configured for UDMA/133
<6>ata6: SATA link down (SStatus 0 SControl 300)
<5>scsi 0:0:0:0: Direct-Access     ATA      WDC WD3200BEVT-2 11.0 PQ: 0 ANSI: 5
<5>scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T50N  RR07 PQ: 0 ANSI: 5
<4>ACPI: SSDT BFF973C0, 0248 (r1  PmRef  Cpu0Ist     3000 INTL 20051117)
<4>Parsing all Control Methods:
<4>Table [SSDT](id 003E) - 6 Objects with 0 Devices 4 Methods 0 Regions
<4>ACPI: SSDT BFF976A0, 0765 (r1  PmRef  Cpu0Cst     3001 INTL 20051117)
<4>Parsing all Control Methods:
<4>Table [SSDT](id 003F) - 1 Objects with 0 Devices 1 Methods 0 Regions
<7>Monitor-Mwait will be used to enter C-1 state
<7>Monitor-Mwait will be used to enter C-2 state
<7>Monitor-Mwait will be used to enter C-3 state
<6>ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
<6>processor ACPI_CPU:00: registered as cooling_device0
<6>ACPI: Processor [P001] (supports 8 throttling states)
<4>ACPI: SSDT BFF972F0, 00CC (r1  PmRef  Cpu1Ist     3000 INTL 20051117)
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0045) - 4 Objects with 0 Devices 4 Methods 0 Regions
<4>ACPI: SSDT BFF97610, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20051117)
<4>Parsing all Control Methods:
<4>Table [SSDT](id 0046) - 1 Objects with 0 Devices 1 Methods 0 Regions
<6>ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
<4>Marking TSC unstable due to TSC halts in idle
<6>processor ACPI_CPU:01: registered as cooling_device1
<6>ACPI: Processor [P002] (supports 8 throttling states)
<6>ACPI: EC: non-query interrupt received, switching to interrupt mode
<6>thermal LNXTHERM:01: registered as thermal_zone0
<6>ACPI: Thermal Zone [THRM] (49 C)
<6>Uniform Multi-Platform E-IDE driver
<6>SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
<6>SGI XFS Quota Management subsystem
<6>BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
<6>udevd version 128 started
<6>usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
<5>sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors: (320GB/298GiB)
<5>sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
<5>sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors: (320GB/298GiB)
<5>sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
<6> sda:<6>USB Universal Host Controller Interface driver v3.0
<6>uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<7>uhci_hcd 0000:00:1a.0: setting latency timer to 64
<6>uhci_hcd 0000:00:1a.0: UHCI Host Controller
<6>uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
<6>uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ac00
<6>usb usb1: configuration #1 chosen from 1 choice
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
<4> sda1 sda2 sda3 sda4 <<4>Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
<4> sda5 sda6 sda7 >
<5>sd 0:0:0:0: [sda] Attached SCSI disk
<6>usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
<6>usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb1: Product: UHCI Host Controller
<6>usb usb1: Manufacturer: Linux 2.6.27.19-3.2-default uhci_hcd
<6>usb usb1: SerialNumber: 0000:00:1a.0
<6>uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
<7>uhci_hcd 0000:00:1a.1: setting latency timer to 64
<6>uhci_hcd 0000:00:1a.1: UHCI Host Controller
<6>uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
<6>uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
<6>usb usb2: configuration #1 chosen from 1 choice
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 2 ports detected
<6>usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
<6>usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb2: Product: UHCI Host Controller
<6>usb usb2: Manufacturer: Linux 2.6.27.19-3.2-default uhci_hcd
<6>usb usb2: SerialNumber: 0000:00:1a.1
<6>uhci_hcd 0000:00:1a.2: PCI INT D -> GSI 19 (level, low) -> IRQ 19
<7>uhci_hcd 0000:00:1a.2: setting latency timer to 64
<6>uhci_hcd 0000:00:1a.2: UHCI Host Controller
<6>uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 3
<6>uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000a800
<6>usb usb3: configuration #1 chosen from 1 choice
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<6>usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
<6>usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<4>Clocksource tsc unstable (delta = -167000063 ns)
<6>usb usb3: Product: UHCI Host Controller
<6>usb usb3: Manufacturer: Linux 2.6.27.19-3.2-default uhci_hcd
<6>usb usb3: SerialNumber: 0000:00:1a.2
<6>ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
<7>ehci_hcd 0000:00:1a.7: setting latency timer to 64
<6>ehci_hcd 0000:00:1a.7: EHCI Host Controller
<6>ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 4
<6>ehci_hcd 0000:00:1a.7: debug port 1
<7>ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
<6>ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfd5ff800
<6>usb 3-1: new full speed USB device using uhci_hcd and address 2
<6>ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
<6>usb usb4: configuration #1 chosen from 1 choice
<6>hub 4-0:1.0: USB hub found
<6>hub 4-0:1.0: 6 ports detected
<3>hub 3-0:1.0: unable to enumerate USB device on port 1
<6>usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
<6>usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb4: Product: EHCI Host Controller
<6>usb usb4: Manufacturer: Linux 2.6.27.19-3.2-default ehci_hcd
<6>usb usb4: SerialNumber: 0000:00:1a.7
<6>uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
<7>uhci_hcd 0000:00:1d.0: setting latency timer to 64
<6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
<6>uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a480
<6>usb usb5: configuration #1 chosen from 1 choice
<6>hub 5-0:1.0: USB hub found
<6>hub 5-0:1.0: 2 ports detected
<6>usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
<6>usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb5: Product: UHCI Host Controller
<6>usb usb5: Manufacturer: Linux 2.6.27.19-3.2-default uhci_hcd
<6>usb usb5: SerialNumber: 0000:00:1d.0
<6>uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
<7>uhci_hcd 0000:00:1d.1: setting latency timer to 64
<6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
<6>uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
<6>usb usb6: configuration #1 chosen from 1 choice
<6>hub 6-0:1.0: USB hub found
<6>hub 6-0:1.0: 2 ports detected
<6>usb 3-1: new full speed USB device using uhci_hcd and address 3
<6>usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
<6>usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb6: Product: UHCI Host Controller
<6>usb usb6: Manufacturer: Linux 2.6.27.19-3.2-default uhci_hcd
<6>usb usb6: SerialNumber: 0000:00:1d.1
<6>uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
<7>uhci_hcd 0000:00:1d.2: setting latency timer to 64
<6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
<6>uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a080
<6>usb usb7: configuration #1 chosen from 1 choice
<6>hub 7-0:1.0: USB hub found
<6>hub 7-0:1.0: 2 ports detected
<6>usb 3-1: configuration #1 chosen from 1 choice
<6>usb 3-1: New USB device found, idVendor=0b05, idProduct=1751
<6>usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
<6>usb 3-1: Product: BT-253
<6>usb 3-1: Manufacturer: Broadcom Corp
<6>usb 3-1: SerialNumber: 002243A45ADF
<6>usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
<6>usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb7: Product: UHCI Host Controller
<6>usb usb7: Manufacturer: Linux 2.6.27.19-3.2-default uhci_hcd
<6>usb usb7: SerialNumber: 0000:00:1d.2
<6>ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
<7>ehci_hcd 0000:00:1d.7: setting latency timer to 64
<6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
<6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 8
<6>ehci_hcd 0000:00:1d.7: debug port 1
<7>ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
<6>ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfd5ff400
<6>usb 3-2: new full speed USB device using uhci_hcd and address 4
<6>ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
<6>usb usb8: configuration #1 chosen from 1 choice
<6>hub 8-0:1.0: USB hub found
<6>hub 8-0:1.0: 6 ports detected
<6>usb 3-2: configuration #1 chosen from 1 choice
<6>usb 3-2: New USB device found, idVendor=08ff, idProduct=1600
<6>usb 3-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
<6>usb 3-2: Product: Fingerprint Sensor
<6>usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
<6>usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb8: Product: EHCI Host Controller
<6>usb usb8: Manufacturer: Linux 2.6.27.19-3.2-default ehci_hcd
<6>usb usb8: SerialNumber: 0000:00:1d.7
<6>PM: Starting manual resume from disk
<5>XFS mounting filesystem sda6
<6>usb 8-5: new high speed USB device using ehci_hcd and address 3
<7>Ending clean XFS mount for filesystem: sda6
<6>usb 8-5: configuration #1 chosen from 1 choice
<6>usb 8-5: New USB device found, idVendor=04f2, idProduct=b033
<6>usb 8-5: New USB device strings: Mfr=0, Product=1, SerialNumber=0
<6>usb 8-5: Product: USB2.0 1.3M UVC WebCam
<6>usb 6-1: new low speed USB device using uhci_hcd and address 2
<6>usb 6-1: configuration #1 chosen from 1 choice
<6>usb 6-1: New USB device found, idVendor=046d, idProduct=c016
<6>usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 6-1: Product: Optical USB Mouse
<6>usb 6-1: Manufacturer: Logitech
<6>udevd version 128 started
<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
<5>scsi 1:0:0:0: Attached scsi generic sg1 type 5
<6>input: PC Speaker as /devices/platform/pcspkr/input/input2
<4>sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.20
<7>sr 1:0:0:0: Attached scsi CD-ROM sr0
<6>e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6
<6>e1000e: Copyright (c) 1999-2008 Intel Corporation.
<6>e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
<7>e1000e 0000:00:19.0: setting latency timer to 64
<6>0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:22:15:b3:34:b4
<6>0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
<6>0000:00:19.0: eth0: MAC: 6, PHY: 8, PBA No: ffffff-0ff
<4>fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
<6>[fglrx] Maximum main memory to use for locked dma buffers: 3732 MBytes.
<6>[fglrx]   vendor: 1002 device: 9591 count: 1
<6>[fglrx] ioport: bar 1, base 0xc000, size: 0x100
<6>vendor=8086 device=2a41
<6>pci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<7>pci 0000:01:00.0: setting latency timer to 64
<6>[fglrx] Kernel PAT support detected, disabling driver built-in PAT support
<6>[fglrx] module loaded - fglrx 8.58.2 [Feb  4 2009] with 1 minors
<6>Bluetooth: Core ver 2.13
<6>NET: Registered protocol family 31
<6>Bluetooth: HCI device and connection manager initialized
<6>Bluetooth: HCI socket layer initialized
<6>ricoh-mmc: Ricoh MMC Controller disabling driver
<6>ricoh-mmc: Copyright(c) Philip Langdale
<6>ricoh-mmc: Ricoh MMC controller found at 0000:08:01.2 [1180:0843] (rev 12)
<6>ricoh-mmc: Controller is now disabled.
<6>ACPI: Battery Slot [BAT0] (battery present)
<6>ACPI: Battery Slot [BAT1] (battery absent)
<6>input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
<6>ACPI: Power Button (FF) [PWRF]
<6>input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
<6>NET: Registered protocol family 23
<6>ACPI: Sleep Button (CM) [SLPB]
<6>input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input5
<6>ACPI: Lid Switch [LID]
<6>ACPI: AC Adapter [AC0] (off-line)
<6>rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
<6>rtc0: alarms up to one month, y3k, hpet irqs
<5>asus-laptop: Asus Laptop Support version 0.42
<5>asus-laptop:   V1V model detected
<6>asus-laptop: Brightness ignored, must be controlled by ACPI video driver
<6>Registered led device: asus::mail
<6>Bluetooth: Generic Bluetooth USB driver ver 0.3
<6>usbcore: registered new interface driver btusb
<6>Linux video capture interface: v2.00
<6>usbcore: registered new interface driver hiddev
<6>acpi device:1d: registered as cooling_device2
<6>input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:18/device:19/input/input6
<6>input: Logitech Optical USB Mouse as /devices/pci0000:00/0000:00:1d.1/usb6/6-1/6-1:1.0/input/input7
<6>sdhci: Secure Digital Host Controller Interface driver
<6>sdhci: Copyright(c) Pierre Ossman
<6>vendor=8086 device=2448
<6>ohci1394 0000:08:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
<6>ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[febff800-febfffff]  Max Packet=[2048]  IR/IT contexts=[4/4]
<6>ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
<6>input,hidraw0: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.1-1
<6>usbcore: registered new interface driver usbhid
<6>usbhid: v2.6:USB HID core driver
<6>HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
<7>HDA Intel 0000:00:1b.0: setting latency timer to 64
<6>uvcvideo: Found UVC 1.00 device USB2.0 1.3M UVC WebCam (04f2:b033)
<6>input: USB2.0 1.3M UVC WebCam as /devices/pci0000:00/0000:00:1d.7/usb8/8-5/8-5:1.0/input/input8
<6>usbcore: registered new interface driver uvcvideo
<6>USB Video Class driver (v0.1.0)
<6>vendor=8086 device=2a41
<6>HDA Intel 0000:01:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
<7>HDA Intel 0000:01:00.1: setting latency timer to 64
<6>sdhci-pci 0000:08:01.1: SDHCI controller found [1180:0822] (rev 22)
<6>vendor=8086 device=2448
<6>sdhci-pci 0000:08:01.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
<4>sdhci-pci 0000:08:01.1: Will use DMA mode even though HW doesn't fully claim to support it.
<6>mmc0: SDHCI controller on PCI [0000:08:01.1] using DMA
<6>iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, 1.3.27ks
<6>iwlagn: Copyright(c) 2003-2008 Intel Corporation
<6>vendor=8086 device=2942
<6>iwlagn 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
<7>iwlagn 0000:03:00.0: setting latency timer to 64
<6>iwlagn: Detected Intel Wireless WiFi Link 5100AGN REV=0x54
<6>iwlagn: Tunable channels: 13 802.11bg, 24 802.11a channels
<7>phy0: Selected rate control algorithm 'iwl-agn-rs'
<7>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001e8c000183081d]
<6>Bluetooth: L2CAP ver 2.11
<6>Bluetooth: L2CAP socket layer initialized
<6>Bluetooth: RFCOMM socket layer initialized
<6>Bluetooth: RFCOMM TTY layer initialized
<6>Bluetooth: RFCOMM ver 1.10
<6>Bluetooth: BNEP (Ethernet Emulation) ver 1.3
<6>Bluetooth: BNEP filters: protocol multicast
<6>Adding 8385888k swap on /dev/sda5.  Priority:-1 extents:1 across:8385888k
<6>device-mapper: uevent: version 1.0.3
<6>device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
<6>loop: module loaded
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda3, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<5>XFS mounting filesystem sda7
<7>Ending clean XFS mount for filesystem: sda7
<4>fuse init (API version 7.9)
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Sun Apr  5 12:53:16 2009

Trying manual resume from /dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part5
Invoking userspace resume from /dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part5
resume: libgcrypt version: 1.4.1
Trying manual resume from /dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part5
Invoking in-kernel resume from /dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part5
Waiting for device /dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 to appear:  ok
fsck 1.41.1 (01-Sep-2008)
[/sbin/fsck.xfs (1) -- /] fsck.xfs -a /dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 
/sbin/fsck.xfs: XFS file system.
fsck succeeded. Mounting root device read-write.
Mounting root /dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6

Boot logging started on /dev/tty1(/dev/console (deleted)) at Sun Apr  5 14:53:19 2009

done
Starting udevd: done
Loading drivers, configuring devices: done
Loading required kernel modules
doneActivating swap-devices in /etc/fstab...
doneSetting up the hardware clockdone
Activating device mapper...
done
done
Mounting local file systems...
/proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
debugfs on /sys/kernel/debug type debugfs (rw)
udev on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/sda3 on /boot type ext3 (rw,noacl)
/dev/sda7 on /home type xfs (rw,usrquota,grpquota)
doneFuse filesystem already availabledone
Mounting fuse control filesystemdone
Configuring serial ports...
/dev/ttyS1 at 0x02f8 (irq = 3) is a 16550A
/dev/ttyS4 at 0xb080 (irq = 17) is a 16550A
Configured serial ports
doneSetting current sysctl status from /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.rp_filter = 1
fs.inotify.max_user_watches = 65536
net.ipv4.conf.default.promote_secondaries = 1
net.ipv4.conf.all.promote_secondaries = 1
done
Enabling syn flood protectiondone
Disabling IP forwardingdone
done
Activating remaining swap-devices in /etc/fstab...
done<notice>killproc: kill(739,29)
Creating /var/log/boot.msg
doneExecuting storage fixups...done
Turning quota on
Checking quotas. This may take some time.
quotacheck: Mountpoint (or device) / not found or has no quota enabled.
quotacheck: Cannot find filesystem to check or filesystem not mounted with quota option.
quotacheck: Skipping /dev/sda7 [/home]
quotacheck: Cannot find filesystem to check or filesystem not mounted with quota option.
done
Setting up hostname 'hedi-2'done
Setting up loopback interface     lo        
    lo        IP address: 127.0.0.1/8   
              IP address: 127.0.0.2/8   
done
Mounting securityfs on /sys/kernel/security done
Loading AppArmor profiles done
System Boot Control: The system has been set up
Skipped features: boot.cycle
System Boot Control: Running /etc/init.d/boot.local
done<notice>killproc: kill(739,3)

INIT: Entering runlevel: 5



Boot logging started on /dev/tty1(/dev/console) at Sun Apr  5 14:53:32 2009

Master Resource Control: previous runlevel: N, switching to runlevel: 5
<notice>startproc: execve (/sbin/acpid) [ /sbin/acpid ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/sbin/acpid ]
acpid: starting up


Starting acpid done
<notice>startproc: execve (/usr/sbin/atd) [ /usr/sbin/atd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/atd ]
Starting service at daemondone
acpid: 4 rules loaded


<notice>startproc: execve (/sbin/syslog-ng) [ /sbin/syslog-ng ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs TERM=linux SHELL=/bin/sh ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin DO_CONFIRM= vga=0x345 RUNLEVEL=5 SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PWD=/ PREVLEVEL=N LINES=61 SHLVL=2 HOME=/ SPLASH=yes splash=verbose ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/sbin/syslog-ng ]
<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -x ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs TERM=linux SHELL=/bin/sh ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin DO_CONFIRM= vga=0x345 RUNLEVEL=5 SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PWD=/ PREVLEVEL=N LINES=61 SHLVL=2 HOME=/ SPLASH=yes splash=verbose ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/sbin/klogd ]
Starting syslog servicesdone
Starting D-Bus daemondone
Starting Firewall Initialization (phase 1 of 2) done
Starting hddtemp daemon for /dev/sda<notice>startproc: execve (/usr/sbin/hddtemp) [ /usr/sbin/hddtemp -d -f /etc/hddtemp.db -p 7634 /dev/sda ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/hddtemp ]
done
Loading console font lat9w-16.psfu  -m trivial G0:loadable
doneLoading keymap assuming iso-8859-15 euro
Loading /usr/share/kbd/keymaps/i386/qwertz/de-latin1-nodeadkeys.map.gz
doneLoading compose table latin1.adddone
Start Unicode mode
doneNo active profileunused
Neither the variables MOUSEDEVICE and MOUSETYPE nor the variable GPM_PARAM
is set in /etc/sysconfig/mouse
Run 'yast mouse' to set up gpm
Initializing random number generatordone
<notice>startproc: execve (/sbin/auditd) [ /sbin/auditd -s disable ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/sbin/auditd ]
<notice>checkproc: /usr/sbin/hcid 1853
<notice>startproc: execve (/usr/sbin/irqbalance) [ /usr/sbin/irqbalance ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/irqbalance ]
Starting irqbalance done
Starting up sensors: done
<notice>checkproc: /usr/bin/opd 1860
<notice>checkproc: /usr/bin/pand 1880
<notice>checkproc: /usr/bin/dund 1883
Starting bluetooth:  hcid hid2hci opd rfcomm pand dunddone
Starting auditd done
Starting hotkey-setup done
JAVA_EXECUTABLE or HSQLDB_JAR_PATH in '/etc/sysconfig/hsqldb' is set to a non-file.
Searching for unresolved configuration files<notice>startproc: execve (/usr/bin/kdm) [ /usr/bin/kdm ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs TERM=linux SHELL=/bin/sh ROOTFS_FSCK=0 INIT_VERSION=sysvinit-2.86 KDEROOTHOME=/root/.kdm REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin DO_CONFIRM= vga=0x345 RUNLEVEL=5 SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PWD=/ LANG=de_DE.UTF-8 PREVLEVEL=N LINES=61 QT_SYSTEM_DIR=/usr/share/desktop-data SHLVL=2 HOME=/ XCURSOR_THEME=DMZ WINDOWMANAGER=/usr/bin/startkde SPLASH=yes splash=verbose ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/bin/kdm ]
<notice>checkproc: /usr/bin/kdm 3569
done
Please check the following files (see /var/adm/rpmconfigcheck):
    /opt/kde3/share/config/kdm/kdmrc.rpmnew
Loading CPUFreq modulesdone
Starting HAL daemondone
Starting service MySQL done
Starting service kdmdone
Starting service kdmdone
Starting httpd2 (prefork) <notice>startproc: execve (/usr/sbin/httpd2-prefork) [ /usr/sbin/httpd2-prefork -f /etc/apache2/httpd.conf ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 get_module_list_done=true LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 get_includes_done=true PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/var/lib/apache2 SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/httpd2-prefork ]
done
Starting ivman done
<notice>startproc: execve (/usr/sbin/nscd) [ /usr/sbin/nscd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/nscd ]
<notice>startproc: execve (/usr/sbin/NetworkManager) [ /usr/sbin/NetworkManager ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs TERM=linux SHELL=/bin/sh ROOTFS_FSCK=0 OLDPWD=/etc/sysconfig/network LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/sbin:/usr/sbin:/bin:/usr/bin:/etc/sysconfig/network/scripts DO_CONFIRM= vga=0x345 RUNLEVEL=5 SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PWD=/etc/sysconfig/network PREVLEVEL=N LINES=61 SHLVL=2 HOME=/ SPLASH=yes splash=verbose ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/NetworkManager ]
Starting Name Service Cache Daemondone
Starting the NetworkManagerdone
Laptop mode enabled, active.done
Starting network time protocol daemon (NTPD)<notice>startproc: execve (/usr/sbin/ntpd) [ /usr/sbin/ntpd -p /var/run/ntp/ntpd.pid -g -u ntp:ntp -i /var/lib/ntp -c /etc/ntp.conf ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/ntpd ]
done
Starting smart card terminal framework: OpenCTdone
Starting mail service (Postfix)<notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/sshd -o PidFile=/var/run/sshd.init.pid ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/sshd ]
<notice>Starting uuidd (on demand only)unused
Enabling monthly Smolt checkin: done
startproc: execve (/usr/sbin/smpppd) [ /usr/sbin/smpppd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/smpppd ]
Starting SSH daemondone
<notice>startproc: execve (/usr/sbin/xinetd) [ /usr/sbin/xinetd -pidfile /var/run/xinetd.init.pid ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/xinetd ]
Starting SMPPPDdone
<notice>startproc: execve (/usr/sbin/snmpd) [ /usr/sbin/snmpd -r -A -LF d /var/log/net-snmpd.log -p /var/run/snmpd.pid ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/snmpd ]
Starting snmpddone
Starting INET services. (xinetd)done
Starting smartd done
done
<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/cron ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=171 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x345 DO_CONFIRM= RUNLEVEL=5 PWD=/ SPLASHCFG=/etc/bootsplash/themes/openSUSE/config/bootsplash-1400x1050.cfg PREVLEVEL=N LINES=61 HOME=/ SHLVL=2 splash=verbose SPLASH=yes ROOTFS_BLKDEV=/dev/disk/by-id/ata-WDC_WD3200BEVT-22ZCT0_WD-WXE608LU2859-part6 _=/sbin/startproc DAEMON=/usr/sbin/cron ]
Starting CRON daemondone

Connecting                  30s
Connecting.                 29s
Connecting.                 28s
Connecting..                27s
<progress bar skipped>
done
done
Starting Firewall Initialization (phase 2 of 2) done
Master Resource Control: runlevel 5 has been reached
Failed services in runlevel 5: hsqldb
Skipped services in runlevel 5: gpm uuidd
<notice>killproc: kill(2579,3)

--Boundary-00=_3EL2Jt7U+ycTByF--
