From: personal@grab-shot.com
Subject: DMI info as requested in DMESG
Date: Thu, 23 Oct 2008 17:19:10 -0500 (CDT)
Message-ID: <63800.74.128.204.62.1224800350.squirrel@grab-shot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20081023171910_34336"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server003.hostspectrum.com ([206.123.101.30]:58575 "EHLO
	server003.hostspectrum.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307AbYJXAEj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Oct 2008 20:04:39 -0400
Received: from localhost ([127.0.0.1] helo=grab-shot.com)
	by server003.hostspectrum.com with esmtpa (Exim 4.69)
	(envelope-from <personal@grab-shot.com>)
	id 1Kt8WM-0007ji-JC
	for linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 17:19:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

------=_20081023171910_34336
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

attached
Gateway P-7811 FX

Thanks for the great work.
------=_20081023171910_34336
Content-Type: text/plain; name="dmesg_102308.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmesg_102308.txt"

 BIOS EBDA/lowmem at: 0009f400/0009f400
 Linux version 2.6.27-git9 (drtyrell@Asskicker2.Linux-Laptop.com) (gcc version 4.3.2 (Ubuntu 4.3.2-1ubuntu10) ) #2 SMP PREEMPT Thu Oct 23 01:27:15 EDT 2008
 Command line: root=UUID=b1edd8da-628f-4937-a7ad-cc36a597253d ro quiet splash 
 KERNEL supported cpus:
   Intel GenuineIntel
   AMD AuthenticAMD
   Centaur CentaurHauls
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bf8b1000 (usable)
  BIOS-e820: 00000000bf8b1000 - 00000000bf8b7000 (reserved)
  BIOS-e820: 00000000bf8b7000 - 00000000bf9bc000 (usable)
  BIOS-e820: 00000000bf9bc000 - 00000000bfa0f000 (reserved)
  BIOS-e820: 00000000bfa0f000 - 00000000bfb08000 (usable)
  BIOS-e820: 00000000bfb08000 - 00000000bfd0f000 (reserved)
  BIOS-e820: 00000000bfd0f000 - 00000000bfd18000 (usable)
  BIOS-e820: 00000000bfd18000 - 00000000bfd1f000 (reserved)
  BIOS-e820: 00000000bfd1f000 - 00000000bfd64000 (usable)
  BIOS-e820: 00000000bfd64000 - 00000000bfd9f000 (ACPI NVS)
  BIOS-e820: 00000000bfd9f000 - 00000000bfde5000 (usable)
  BIOS-e820: 00000000bfde5000 - 00000000bfdfd000 (ACPI data)
  BIOS-e820: 00000000bfdfd000 - 00000000bfe00000 (usable)
  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
 DMI present.
 last_pfn = 0x140000 max_arch_pfn = 0x3ffffffff
 x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
 last_pfn = 0xbfe00 max_arch_pfn = 0x3ffffffff
 init_memory_mapping
  0000000000 - 00bfe00000 page 2M
 kernel direct mapping tables up to bfe00000 @ 8000-c000
 last_map_addr: bfe00000 end: bfe00000
 init_memory_mapping
  0100000000 - 0140000000 page 2M
 kernel direct mapping tables up to 140000000 @ a000-10000
 last_map_addr: 140000000 end: 140000000
 RAMDISK: 37b08000 - 37fefc92
 ACPI: RSDP 000F6EF0, 0024 (r2 PTLTD )
 ACPI: XSDT BFDF56E6, 005C (r1 GATEWA SYSTEM    6040000 BNWG        0)
 ACPI: FACP BFDE7000, 00F4 (r3 INTEL  CRESTLNE  6040000 ALAN        1)
 ACPI: DSDT BFDE8000, 74A4 (r2 Intel  CANTIGA   6040000 MSFT  3000000)
 ACPI: FACS BFD9EFC0, 0040
 ACPI: HPET BFDFCD86, 0038 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
 ACPI: MCFG BFDFCDBE, 003C (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
 ACPI: SLIC BFDFCDFA, 0176 (r1 GATEWA SYSTEM    6040000 GWNB        1)
 ACPI: APIC BFDFCF70, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
 ACPI: BOOT BFDFCFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
 ACPI: SSDT BFDE6000, 0655 (r1  PmRef    CpuPm     3000 INTL 20050624)
 ACPI: Local APIC address 0xfee00000
 (7 early reservations) ==> bootmem [0000000000 - 0140000000
   #0 [0000000000 - 0000001000
   #1 [0000006000 - 0000008000
   #2 [0000200000 - 000062fa78
   #3 [0037b08000 - 0037fefc92
   #4 [000009f400 - 0000100000
   #5 [0000008000 - 000000a000
   #6 [000000a000 - 000000b000
  [ffffe20000000000-ffffe200045fffff
 Zone PFN ranges:
   DMA      0x00000000 -> 0x00001000
   DMA32    0x00001000 -> 0x00100000
   Normal   0x00100000 -> 0x00140000
 Movable zone start PFN for each node
 early_node_map[9
     0: 0x00000000 -> 0x0000009f
     0: 0x00000100 -> 0x000bf8b1
     0: 0x000bf8b7 -> 0x000bf9bc
     0: 0x000bfa0f -> 0x000bfb08
     0: 0x000bfd0f -> 0x000bfd18
     0: 0x000bfd1f -> 0x000bfd64
     0: 0x000bfd9f -> 0x000bfde5
     0: 0x000bfdfd -> 0x000bfe00
     0: 0x00100000 -> 0x00140000
 On node 0 totalpages: 1047269
   DMA zone: 56 pages used for memmap
   DMA zone: 1173 pages reserved
   DMA zone: 2770 pages, LIFO batch:0
   DMA32 zone: 14280 pages used for memmap
   DMA32 zone: 766846 pages, LIFO batch:31
   Normal zone: 3584 pages used for memmap
   Normal zone: 258560 pages, LIFO batch:31
   Movable zone: 0 pages used for memmap
 ACPI: PM-Timer IO Port: 0x408
 ACPI: Local APIC address 0xfee00000
 ACPI: LAPIC (acpi_id[0x00
 ACPI: LAPIC (acpi_id[0x01
 ACPI: LAPIC_NMI (acpi_id[0x00
 ACPI: LAPIC_NMI (acpi_id[0x01
 ACPI: IOAPIC (id[0x02
 IOAPIC[0
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
 ACPI: IRQ0 used by override.
 ACPI: IRQ2 used by override.
 ACPI: IRQ9 used by override.
 ACPI: HPET id: 0x8086a201 base: 0xfed00000
 SMP: Allowing 2 CPUs, 0 hotplug CPUs
 Allocating PCI resources starting at c0000000 (gap: bfe00000:40200000)
 PERCPU: Allocating 49152 bytes of per cpu data
 NR_CPUS: 4, nr_cpu_ids: 2, nr_node_ids 1
 Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1028176
 Kernel command line: root=UUID=b1edd8da-628f-4937-a7ad-cc36a597253d ro quiet splash 
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 32768 bytes)
 Extended CMOS year: 2000
 Fast TSC calibration using PIT
 Detected 2261.164 MHz processor.
 Console: colour VGA+ 80x25
 console [tty0
 Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
 Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
 Checking aperture...
 No AGP bridge found
 PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
 Placing software IO TLB between 0x20000000 - 0x24000000
 Memory: 4034668k/5242880k available (2119k kernel code, 153412k reserved, 1320k data, 332k init)
 SLUB: Genslabs=12, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
 hpet clockevent registered
 HPET: 4 timers in total, 0 timers will be used for per-cpu timer
 Calibrating delay loop (skipped), value calculated using timer frequency.. 4524.75 BogoMIPS (lpj=7537213)
 Mount-cache hash table entries: 256
 CPU: L1 I cache: 32K, L1 D cache: 32K
 CPU: L2 cache: 3072K
 CPU: Physical Processor ID: 0
 CPU: Processor Core ID: 0
 CPU0: Thermal monitoring enabled (TM1)
 using mwait in idle threads.
 ACPI: Core revision 20080609
 Setting APIC routing to flat
 ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
 CPU0: Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz stepping 06
 APIC calibration not consistent with PM Timer: 301ms instead of 100ms
 APIC delta adjusted to PM-Timer: 1662497 (5015958)
 Booting processor 1 APIC 0x1 ip 0x6000
 Initializing CPU#1
 Calibrating delay using timer specific routine.. 4523.43 BogoMIPS (lpj=7536695)
 CPU: L1 I cache: 32K, L1 D cache: 32K
 CPU: L2 cache: 3072K
 CPU: Physical Processor ID: 0
 CPU: Processor Core ID: 1
 CPU1: Thermal monitoring enabled (TM1)
 x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
 CPU1: Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz stepping 06
 checking TSC synchronization [CPU#0 -> CPU#1
 Brought up 2 CPUs
 Total of 2 processors activated (9047.19 BogoMIPS).
 CPU0 attaching sched-domain:
  domain 0: span 0-1 level MC
   groups: 0 1
 CPU1 attaching sched-domain:
  domain 0: span 0-1 level MC
   groups: 1 0
 net_namespace: 912 bytes
 Time: 17:56:18  Date: 10/23/08
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: Using configuration type 1 for base access
 ACPI: EC: Look up EC in DSDT
 ACPI: BIOS _OSI(Linux) query ignored
 ACPI: DMI System Vendor: Gateway        
 ACPI: DMI Product Name: P-7811FX       
 ACPI: DMI Product Version: Gateway MG1    
 ACPI: DMI Board Name:         
 ACPI: DMI BIOS Vendor: Phoenix Technologies LTD
 ACPI: DMI BIOS Date: 08/28/2008
 ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
 ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
 ACPI: Interpreter enabled
 ACPI: (supports S0 S3 S5)
 ACPI: Using IOAPIC for interrupt routing
 ACPI: EC: non-query interrupt received, switching to interrupt mode
 ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
 ACPI: EC: driver started in interrupt mode
 ACPI: PCI Root Bridge [PCI0
 pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
 pci 0000:00:01.0: PME# disabled
 pci 0000:00:1a.0: reg 20 io port: [0x1800-0x181f
 pci 0000:00:1a.1: reg 20 io port: [0x1820-0x183f
 pci 0000:00:1a.2: reg 20 io port: [0x1840-0x185f
 pci 0000:00:1a.7: reg 10 32bit mmio: [0xf4504800-0xf4504bff
 pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
 pci 0000:00:1a.7: PME# disabled
 pci 0000:00:1b.0: reg 10 64bit mmio: [0xf4500000-0xf4503fff
 pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
 pci 0000:00:1b.0: PME# disabled
 pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
 pci 0000:00:1c.0: PME# disabled
 pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
 pci 0000:00:1c.1: PME# disabled
 pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
 pci 0000:00:1c.2: PME# disabled
 pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
 pci 0000:00:1c.4: PME# disabled
 pci 0000:00:1d.0: reg 20 io port: [0x1860-0x187f
 pci 0000:00:1d.1: reg 20 io port: [0x1880-0x189f
 pci 0000:00:1d.2: reg 20 io port: [0x18a0-0x18bf
 pci 0000:00:1d.7: reg 10 32bit mmio: [0xf4504c00-0xf4504fff
 pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
 pci 0000:00:1d.7: PME# disabled
 pci 0000:00:1f.2: reg 10 io port: [0x18f0-0x18f7
 pci 0000:00:1f.2: reg 14 io port: [0x18e4-0x18e7
 pci 0000:00:1f.2: reg 18 io port: [0x18e8-0x18ef
 pci 0000:00:1f.2: reg 1c io port: [0x18e0-0x18e3
 pci 0000:00:1f.2: reg 20 io port: [0x18c0-0x18df
 pci 0000:00:1f.2: reg 24 32bit mmio: [0xf4504000-0xf45047ff
 pci 0000:00:1f.2: PME# supported from D3hot
 pci 0000:00:1f.2: PME# disabled
 pci 0000:00:1f.3: reg 10 64bit mmio: [0x000000-0x0000ff
 pci 0000:00:1f.3: reg 20 io port: [0x1c00-0x1c1f
 pci 0000:01:00.0: reg 10 32bit mmio: [0xce000000-0xceffffff
 pci 0000:01:00.0: reg 14 64bit mmio: [0xd0000000-0xdfffffff
 pci 0000:01:00.0: reg 1c 64bit mmio: [0xcc000000-0xcdffffff
 pci 0000:01:00.0: reg 24 io port: [0x2000-0x207f
 pci 0000:01:00.0: reg 30 32bit mmio: [0x000000-0x07ffff
 pci 0000:00:01.0: bridge io port: [0x2000-0x2fff
 pci 0000:00:01.0: bridge 32bit mmio: [0xcc000000-0xceffffff
 pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff
 pci 0000:02:00.0: reg 10 64bit mmio: [0xf4000000-0xf4003fff
 pci 0000:02:00.0: reg 18 io port: [0x3000-0x30ff
 pci 0000:02:00.0: reg 30 32bit mmio: [0x000000-0x01ffff
 pci 0000:02:00.0: supports D1 D2
 pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
 pci 0000:02:00.0: PME# disabled
 pci 0000:00:1c.0: bridge io port: [0x3000-0x3fff
 pci 0000:00:1c.0: bridge 32bit mmio: [0xf4000000-0xf40fffff
 pci 0000:04:00.0: reg 10 64bit mmio: [0xf4100000-0xf4101fff
 pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:04:00.0: PME# disabled
 pci 0000:00:1c.2: bridge 32bit mmio: [0xf4100000-0xf41fffff
 pci 0000:00:1c.4: bridge io port: [0x4000-0x4fff
 pci 0000:00:1c.4: bridge 32bit mmio: [0xf2000000-0xf3ffffff
 pci 0000:00:1c.4: bridge 64bit mmio pref: [0xf0000000-0xf1ffffff
 pci 0000:0d:06.0: reg 10 32bit mmio: [0xf4200000-0xf4200fff
 pci 0000:0d:06.0: reg 14 32bit mmio: [0xf4202000-0xf42027ff
 pci 0000:0d:06.0: supports D1 D2
 pci 0000:0d:06.0: PME# supported from D0 D1 D2 D3hot D3cold
 pci 0000:0d:06.0: PME# disabled
 pci 0000:0d:06.2: reg 10 32bit mmio: [0xf4202800-0xf42028ff
 pci 0000:0d:06.2: supports D1 D2
 pci 0000:0d:06.2: PME# supported from D0 D1 D2 D3hot D3cold
 pci 0000:0d:06.2: PME# disabled
 pci 0000:0d:06.3: reg 10 32bit mmio: [0xf4201000-0xf4201fff
 pci 0000:0d:06.3: supports D1 D2
 pci 0000:0d:06.3: PME# supported from D0 D1 D2 D3hot D3cold
 pci 0000:0d:06.3: PME# disabled
 pci 0000:00:1e.0: transparent bridge
 pci 0000:00:1e.0: bridge 32bit mmio: [0xf4200000-0xf42fffff
 bus 00 -> node 0
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT
 ACPI: PCI Interrupt Link [LNKA
 ACPI: PCI Interrupt Link [LNKB
 ACPI: PCI Interrupt Link [LNKC
 ACPI: PCI Interrupt Link [LNKD
 ACPI: PCI Interrupt Link [LNKE
 ACPI: PCI Interrupt Link [LNKF
 ACPI: PCI Interrupt Link [LNKG
 ACPI: PCI Interrupt Link [LNKH
 PCI: Using ACPI for IRQ routing
 PCI-GART: No AMD northbridge found.
 hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
 hpet0: 4 comparators, 64-bit 14.318180 MHz counter
 Switched to high resolution mode on CPU 0
 Switched to high resolution mode on CPU 1
 pnp: PnP ACPI init
 ACPI: bus type pnp registered
 pnp: PnP ACPI: found 10 devices
 ACPI: ACPI bus type pnp unregistered
 system 00:05: iomem range 0xfed00000-0xfed003ff has been reserved
 system 00:07: ioport range 0x480-0x48f has been reserved
 system 00:07: ioport range 0xffff-0xffff has been reserved
 system 00:07: ioport range 0xffff-0xffff has been reserved
 system 00:07: ioport range 0x400-0x47f has been reserved
 system 00:07: ioport range 0x1180-0x11ff has been reserved
 system 00:07: ioport range 0xfe00-0xfe00 has been reserved
 system 00:07: iomem range 0xff800000-0xff800fff has been reserved
 system 00:09: iomem range 0xfed1c000-0xfed1ffff has been reserved
 system 00:09: iomem range 0xfed10000-0xfed13fff has been reserved
 system 00:09: iomem range 0xfed18000-0xfed18fff has been reserved
 system 00:09: iomem range 0xfed19000-0xfed19fff has been reserved
 system 00:09: iomem range 0xe0000000-0xefffffff has been reserved
 system 00:09: iomem range 0xfed20000-0xfed3ffff has been reserved
 pci 0000:01:00.0: BAR 6: can't allocate mem resource [0xe0000000-0xdfffffff
 pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
 pci 0000:00:01.0:   IO window: 0x2000-0x2fff
 pci 0000:00:01.0:   MEM window: 0xcc000000-0xceffffff
 pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
 pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
 pci 0000:00:1c.0:   IO window: 0x3000-0x3fff
 pci 0000:00:1c.0:   MEM window: 0xf4000000-0xf40fffff
 pci 0000:00:1c.0:   PREFETCH window: 0x000000c0000000-0x000000c00fffff
 pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
 pci 0000:00:1c.1:   IO window: disabled
 pci 0000:00:1c.1:   MEM window: disabled
 pci 0000:00:1c.1:   PREFETCH window: disabled
 pci 0000:00:1c.2: PCI bridge, secondary bus 0000:04
 pci 0000:00:1c.2:   IO window: disabled
 pci 0000:00:1c.2:   MEM window: 0xf4100000-0xf41fffff
 pci 0000:00:1c.2:   PREFETCH window: disabled
 pci 0000:00:1c.4: PCI bridge, secondary bus 0000:05
 pci 0000:00:1c.4:   IO window: 0x4000-0x4fff
 pci 0000:00:1c.4:   MEM window: 0xf2000000-0xf3ffffff
 pci 0000:00:1c.4:   PREFETCH window: 0x000000f0000000-0x000000f1ffffff
 pci 0000:00:1e.0: PCI bridge, secondary bus 0000:0d
 pci 0000:00:1e.0:   IO window: disabled
 pci 0000:00:1e.0:   MEM window: 0xf4200000-0xf42fffff
 pci 0000:00:1e.0:   PREFETCH window: disabled
 pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
 pci 0000:00:01.0: setting latency timer to 64
 pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
 pci 0000:00:1c.0: setting latency timer to 64
 pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
 pci 0000:00:1c.1: setting latency timer to 64
 pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
 pci 0000:00:1c.2: setting latency timer to 64
 pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
 pci 0000:00:1c.4: setting latency timer to 64
 pci 0000:00:1e.0: setting latency timer to 64
 bus: 00 index 0 io port: [0x00-0xffff
 bus: 00 index 1 mmio: [0x000000-0xffffffffffffffff
 bus: 01 index 0 io port: [0x2000-0x2fff
 bus: 01 index 1 mmio: [0xcc000000-0xceffffff
 bus: 01 index 2 mmio: [0xd0000000-0xdfffffff
 bus: 01 index 3 mmio: [0x0-0x0
 bus: 02 index 0 io port: [0x3000-0x3fff
 bus: 02 index 1 mmio: [0xf4000000-0xf40fffff
 bus: 02 index 2 mmio: [0xc0000000-0xc00fffff
 bus: 02 index 3 mmio: [0x0-0x0
 bus: 03 index 0 mmio: [0x0-0x0
 bus: 03 index 1 mmio: [0x0-0x0
 bus: 03 index 2 mmio: [0x0-0x0
 bus: 03 index 3 mmio: [0x0-0x0
 bus: 04 index 0 mmio: [0x0-0x0
 bus: 04 index 1 mmio: [0xf4100000-0xf41fffff
 bus: 04 index 2 mmio: [0x0-0x0
 bus: 04 index 3 mmio: [0x0-0x0
 bus: 05 index 0 io port: [0x4000-0x4fff
 bus: 05 index 1 mmio: [0xf2000000-0xf3ffffff
 bus: 05 index 2 mmio: [0xf0000000-0xf1ffffff
 bus: 05 index 3 mmio: [0x0-0x0
 bus: 0d index 0 mmio: [0x0-0x0
 bus: 0d index 1 mmio: [0xf4200000-0xf42fffff
 bus: 0d index 2 mmio: [0x0-0x0
 bus: 0d index 3 io port: [0x00-0xffff
 bus: 0d index 4 mmio: [0x000000-0xffffffffffffffff
 NET: Registered protocol family 2
 IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
 TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
 TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
 TCP: Hash tables configured (established 262144 bind 65536)
 TCP reno registered
 NET: Registered protocol family 1
 checking if image is initramfs... it is
 Freeing initrd memory: 5023k freed
 Simple Boot Flag at 0x57 set to 0x1
 audit: initializing netlink socket (disabled)
 type=2000 audit(1224784586.824:1): initialized
 HugeTLB registered 2 MB page size, pre-allocated 0 pages
 msgmni has been set to 7891
 alg: No test for stdrng (krng)
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered (default)
 pci 0000:01:00.0: Boot video device
 pcieport-driver 0000:00:01.0: setting latency timer to 64
 pcieport-driver 0000:00:01.0: found MSI capability
 pcieport-driver 0000:00:01.0: irq 47 for MSI/MSI-X
 pci_express 0000:00:01.0:pcie00: allocate port service
 pci_express 0000:00:01.0:pcie02: allocate port service
 pcieport-driver 0000:00:1c.0: setting latency timer to 64
 pcieport-driver 0000:00:1c.0: found MSI capability
 pcieport-driver 0000:00:1c.0: irq 46 for MSI/MSI-X
 pci_express 0000:00:1c.0:pcie00: allocate port service
 pci_express 0000:00:1c.0:pcie02: allocate port service
 pcieport-driver 0000:00:1c.1: setting latency timer to 64
 pcieport-driver 0000:00:1c.1: found MSI capability
 pcieport-driver 0000:00:1c.1: irq 45 for MSI/MSI-X
 pci_express 0000:00:1c.1:pcie00: allocate port service
 pci_express 0000:00:1c.1:pcie02: allocate port service
 pcieport-driver 0000:00:1c.2: setting latency timer to 64
 pcieport-driver 0000:00:1c.2: found MSI capability
 pcieport-driver 0000:00:1c.2: irq 44 for MSI/MSI-X
 pci_express 0000:00:1c.2:pcie00: allocate port service
 pci_express 0000:00:1c.2:pcie02: allocate port service
 pcieport-driver 0000:00:1c.4: setting latency timer to 64
 pcieport-driver 0000:00:1c.4: found MSI capability
 pcieport-driver 0000:00:1c.4: irq 43 for MSI/MSI-X
 pci_express 0000:00:1c.4:pcie00: allocate port service
 pci_express 0000:00:1c.4:pcie02: allocate port service
 Linux agpgart interface v0.103
 brd: module loaded
 Uniform Multi-Platform E-IDE driver
 ide-gd driver 1.18
 PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M
 i8042.c: Detected active multiplexing controller, rev 1.1.
 serio: i8042 KBD port at 0x60,0x64 irq 1
 serio: i8042 AUX0 port at 0x60,0x64 irq 12
 serio: i8042 AUX1 port at 0x60,0x64 irq 12
 serio: i8042 AUX2 port at 0x60,0x64 irq 12
 serio: i8042 AUX3 port at 0x60,0x64 irq 12
 mice: PS/2 mouse device common for all mice
 rtc_cmos 00:08: RTC can wake from S4
 rtc_cmos 00:08: rtc core: registered rtc_cmos as rtc0
 rtc0: alarms up to one month, y3k, 242 bytes nvram, , hpet irqs irqs
 cpuidle: using governor ladder
 cpuidle: using governor menu
 TCP cubic registered
 registered taskstats version 1
   Magic number: 12:447:947
 tty tty4: hash matches
 rtc_cmos 00:08: setting system clock to 2008-10-23 17:56:27 UTC (1224784587)
 BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
 EDD information not available.
 Freeing unused kernel memory: 332k freed
 fuse init (API version 7.10)
 ACPI: SSDT BFD1AC20, 0265 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
 ACPI: SSDT BFD18620, 0549 (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
 Monitor-Mwait will be used to enter C-1 state
 Monitor-Mwait will be used to enter C-2 state
 Monitor-Mwait will be used to enter C-3 state
 ACPI: CPU0 (power states: C1[C1
 input: AT Translated Set 2 keyboard as /class/input/input0
 processor ACPI0007:00: registered as cooling_device0
 ACPI: SSDT BFD19CA0, 01CF (r1  PmRef    ApIst     3000 INTL 20050624)
 ACPI: SSDT BFD19F20, 008D (r1  PmRef    ApCst     3000 INTL 20050624)
 ACPI: CPU1 (power states: C1[C1
 processor ACPI0007:01: registered as cooling_device1
 Marking TSC unstable due to TSC halts in idle
 thermal LNXTHERM:01: registered as thermal_zone0
 ACPI: Thermal Zone [TZS0
 thermal LNXTHERM:02: registered as thermal_zone1
 ACPI: Thermal Zone [TZS1
 usbcore: registered new interface driver usbfs
 usbcore: registered new interface driver hub
 usbcore: registered new device driver usb
 uhci_hcd: USB Universal Host Controller Interface driver
 uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
 uhci_hcd 0000:00:1a.0: setting latency timer to 64
 uhci_hcd 0000:00:1a.0: UHCI Host Controller
 uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001800
 usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
 uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 20 (level, low) -> IRQ 20
 uhci_hcd 0000:00:1a.1: setting latency timer to 64
 uhci_hcd 0000:00:1a.1: UHCI Host Controller
 uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
 uhci_hcd 0000:00:1a.1: irq 20, io base 0x00001820
 usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
 uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 20 (level, low) -> IRQ 20
 uhci_hcd 0000:00:1a.2: setting latency timer to 64
 uhci_hcd 0000:00:1a.2: UHCI Host Controller
 uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 3
 uhci_hcd 0000:00:1a.2: irq 20, io base 0x00001840
 usb usb3: configuration #1 chosen from 1 choice
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
 uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
 uhci_hcd 0000:00:1d.0: setting latency timer to 64
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
 uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001860
 usb usb4: configuration #1 chosen from 1 choice
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
 uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
 uhci_hcd 0000:00:1d.1: setting latency timer to 64
 uhci_hcd 0000:00:1d.1: UHCI Host Controller
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
 uhci_hcd 0000:00:1d.1: irq 17, io base 0x00001880
 usb usb5: configuration #1 chosen from 1 choice
 hub 5-0:1.0: USB hub found
 hub 5-0:1.0: 2 ports detected
 uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
 uhci_hcd 0000:00:1d.2: setting latency timer to 64
 uhci_hcd 0000:00:1d.2: UHCI Host Controller
 uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
 uhci_hcd 0000:00:1d.2: irq 18, io base 0x000018a0
 usb usb6: configuration #1 chosen from 1 choice
 hub 6-0:1.0: USB hub found
 hub 6-0:1.0: 2 ports detected
 ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
 Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
 ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 20 (level, low) -> IRQ 20
 ehci_hcd 0000:00:1a.7: setting latency timer to 64
 ehci_hcd 0000:00:1a.7: EHCI Host Controller
 ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 7
 ehci_hcd 0000:00:1a.7: debug port 1
 ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
 ehci_hcd 0000:00:1a.7: irq 20, io mem 0xf4504800
 sky2 driver version 1.22
 sky2 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
 sky2 0000:02:00.0: setting latency timer to 64
 sky2 0000:02:00.0: Yukon-2 (chip 0xba) chip revision 0
 No dock devices found.
 ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
 usb usb7: configuration #1 chosen from 1 choice
 hub 7-0:1.0: USB hub found
 hub 7-0:1.0: 6 ports detected
 ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
 ehci_hcd 0000:00:1d.7: setting latency timer to 64
 ehci_hcd 0000:00:1d.7: EHCI Host Controller
 ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 8
 ehci_hcd 0000:00:1d.7: debug port 1
 ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
 ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf4504c00
 SCSI subsystem initialized
 ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
 usb usb8: configuration #1 chosen from 1 choice
 hub 8-0:1.0: USB hub found
 hub 8-0:1.0: 6 ports detected
 sky2 0000:02:00.0: Marvell Yukon 88E8057 Gigabit Ethernet Controller
  Part Number: Yukon 88E8057
  Engineering Level: Rev. 1.1
  Manufacturer: Marvell
 sky2 0000:02:00.0: irq 42 for MSI/MSI-X
 sky2 eth0: addr 00:1d:72:c2:16:97
 libata version 3.00 loaded.
 ahci 0000:00:1f.2: version 3.0
 ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
 ahci 0000:00:1f.2: irq 41 for MSI/MSI-X
 ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
 ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp pio slum part 
 ahci 0000:00:1f.2: setting latency timer to 64
 scsi0 : ahci
 scsi1 : ahci
 scsi2 : ahci
 scsi3 : ahci
 scsi4 : ahci
 scsi5 : ahci
 ata1: SATA max UDMA/133 abar m2048@0xf4504000 port 0xf4504100 irq 41
 ata2: SATA max UDMA/133 abar m2048@0xf4504000 port 0xf4504180 irq 41
 ata3: DUMMY
 ata4: DUMMY
 ata5: SATA max UDMA/133 abar m2048@0xf4504000 port 0xf4504300 irq 41
 ata6: SATA max UDMA/133 abar m2048@0xf4504000 port 0xf4504380 irq 41
 usb 7-3: new high speed USB device using ehci_hcd and address 2
 Clocksource tsc unstable (delta = -159528579 ns)
 usb 7-3: configuration #1 chosen from 1 choice
 ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 ata1.00: ATA-7: ST9200420AS, 3.AAA, max UDMA/133
 ata1.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 31/32)
 ata1.00: configured for UDMA/133
 usb 5-1: new low speed USB device using uhci_hcd and address 2
 ata2: SATA link down (SStatus 0 SControl 300)
 usb 5-1: configuration #1 chosen from 1 choice
 usbcore: registered new interface driver hiddev
 input: Microsoft Microsoft Wireless Optical Mouse® 1.00 as /class/input/input1
 generic-usb 0003:045E:00E1.0001: input,hidraw0: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Mouse® 1.00
 usbcore: registered new interface driver usbhid
 usbhid: v2.6:USB HID core driver
 ata5: SATA link down (SStatus 0 SControl 300)
 ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 ata6.00: ATAPI: Optiarc DVD RW AD-7583S, LX01, max UDMA/100, ATAPI AN
 ata6.00: configured for UDMA/100
 scsi 0:0:0:0: Direct-Access     ATA      ST9200420AS      3.AA PQ: 0 ANSI: 5
 scsi 5:0:0:0: CD-ROM            Optiarc  DVD RW AD-7583S  LX01 PQ: 0 ANSI: 5
 Driver 'sr' needs updating - please use bus_type methods
 Driver 'sd' needs updating - please use bus_type methods
 sd 0:0:0:0: [sda
 sd 0:0:0:0: [sda
 sd 0:0:0:0: [sda
 sd 0:0:0:0: [sda
 sd 0:0:0:0: [sda
 sd 0:0:0:0: [sda
 sd 0:0:0:0: [sda
 sd 0:0:0:0: [sda
  sda:sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
 Uniform CD-ROM driver Revision: 3.20
 sr 5:0:0:0: Attached scsi CD-ROM sr0
  sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
 sd 0:0:0:0: [sda
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 udevd version 124 started
 input: Power Button (FF) as /class/input/input2
 ACPI: WMI: Mapper loaded
 ACPI: Power Button (FF) [PWRF
 input: Lid Switch as /class/input/input3
 ACPI: Lid Switch [LID0
 input: Sleep Button (CM) as /class/input/input4
 ACPI: Sleep Button (CM) [SLPB
 cfg80211: Calling CRDA to update world regulatory domain
 nvidia: module license 'NVIDIA' taints kernel.
 Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1280b1, caps: 0xa04711/0xa04000
 ACPI: Battery Slot [BAT0
 ACPI: AC Adapter [ADP1
 input: SynPS/2 Synaptics TouchPad as /class/input/input5
 Linux video capture interface: v2.00
 sdhci: Secure Digital Host Controller Interface driver
 sdhci: Copyright(c) Pierre Ossman
 sdhci-pci 0000:0d:06.2: SDHCI controller found [1217:7120
 sdhci-pci 0000:0d:06.2: PCI INT A -> GSI 22 (level, low) -> IRQ 22
 mmc0: Unknown controller version (2). You may experience problems.
 mmc0: SDHCI controller on PCI [0000:0d:06.2
 nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
 nvidia 0000:01:00.0: setting latency timer to 64
 NVRM: loading NVIDIA UNIX x86_64 Kernel Module  177.80  Wed Oct  1 14:43:46 PDT 2008
 uvcvideo: Found UVC 1.00 device Gateway USB 2.0 Webcam (04f2:b027)
 input: Gateway USB 2.0 Webcam as /class/input/input6
 usbcore: registered new interface driver uvcvideo
 USB Video Class driver (v0.1.0)
 iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, 1.3.27ks
 iwlagn: Copyright(c) 2003-2008 Intel Corporation
 iwlagn 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
 iwlagn 0000:04:00.0: setting latency timer to 64
 iwlagn: Detected Intel Wireless WiFi Link 5100AGN REV=0x54
 iwlagn: Tunable channels: 13 802.11bg, 24 802.11a channels
 iwlagn 0000:04:00.0: PCI INT A disabled
 phy0: Selected rate control algorithm 'iwl-agn-rs'
 HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
 HDA Intel 0000:00:1b.0: irq 40 for MSI/MSI-X
 HDA Intel 0000:00:1b.0: setting latency timer to 64
 i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) -> IRQ 19
 ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f
 ACPI: Device needs an ACPI driver
 i2c /dev entries driver
 Adding 4000144k swap on /dev/sda6.  Priority:-1 extents:1 across:4000144k
 EXT3 FS on sda5, internal journal
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sda9, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sda7, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sda8, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sda10, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sda11, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 platform microcode: firmware: requesting intel-ucode/06-17-06
 platform microcode: firmware: requesting intel-ucode/06-17-06
 Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk> <peter.oruba@amd.com>
 toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
 nvidia 0000:01:00.0: irq 39 for MSI/MSI-X
 sky2 eth0: enabling interface
 iwlagn 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
 iwlagn 0000:04:00.0: restoring config space at offset 0x1 (was 0x100102, writing 0x100106)
 iwlagn 0000:04:00.0: irq 38 for MSI/MSI-X
 iwlagn 0000:04:00.0: firmware: requesting iwlwifi-5000-1.ucode
 iwlagn: Radio disabled by HW RF Kill switch
 NET: Registered protocol family 17
 nvidia 0000:01:00.0: irq 39 for MSI/MSI-X
 nm-system-setti[5902
 sky2 eth0: disabling interface
 iwlagn 0000:04:00.0: PCI INT A disabled
 NetworkManager[5889
 toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
 nvidia 0000:01:00.0: irq 39 for MSI/MSI-X
 sky2 eth0: enabling interface
 iwlagn 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
 iwlagn 0000:04:00.0: restoring config space at offset 0x1 (was 0x100102, writing 0x100106)
 iwlagn 0000:04:00.0: irq 38 for MSI/MSI-X
 Registered led device: iwl-phy0:radio
 Registered led device: iwl-phy0:assoc
 Registered led device: iwl-phy0:RX
 Registered led device: iwl-phy0:TX
 iwlagn: Error sending REPLY_ADD_STA: time out after 500ms.
 iwlagn: Radio Frequency Kill Switch is On:
 Kill switch must be turned off for wireless networking to work.
 Registered led device: iwl-phy0:radio
 Registered led device: iwl-phy0:assoc
 Registered led device: iwl-phy0:RX
 Registered led device: iwl-phy0:TX
 sky2 eth0: disabling interface
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 1
 iwlagn 0000:04:00.0: PCI INT A disabled
 sky2 eth0: enabling interface
 iwlagn 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
 iwlagn 0000:04:00.0: restoring config space at offset 0x1 (was 0x100102, writing 0x100106)
 iwlagn 0000:04:00.0: irq 38 for MSI/MSI-X
 Registered led device: iwl-phy0:radio
 Registered led device: iwl-phy0:assoc
 Registered led device: iwl-phy0:RX
 Registered led device: iwl-phy0:TX
 iwlagn: Error sending REPLY_ADD_STA: time out after 500ms.
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 1
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 1
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 2
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 3
 wlan0: direct probe to AP 00:13:49:23:e2:6a timed out
 iwlagn: Radio Frequency Kill Switch is On:
 Kill switch must be turned off for wireless networking to work.
 Registered led device: iwl-phy0:radio
 Registered led device: iwl-phy0:assoc
 Registered led device: iwl-phy0:RX
 Registered led device: iwl-phy0:TX
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 1
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 2
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 3
 wlan0: direct probe to AP 00:13:49:23:e2:6a timed out
 iwlagn: Radio Frequency Kill Switch is On:
 Kill switch must be turned off for wireless networking to work.
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 1
 iwlagn: Error sending REPLY_STATISTICS_CMD: enqueue_hcmd failed: -5
 iwlagn 0000:04:00.0: PCI INT A disabled
 iwlagn 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
 iwlagn 0000:04:00.0: restoring config space at offset 0x1 (was 0x100102, writing 0x100106)
 iwlagn 0000:04:00.0: irq 38 for MSI/MSI-X
 Registered led device: iwl-phy0:radio
 Registered led device: iwl-phy0:assoc
 Registered led device: iwl-phy0:RX
 Registered led device: iwl-phy0:TX
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 1
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 2
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 3
 wlan0: direct probe to AP 00:13:49:23:e2:6a timed out
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 1
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 2
 wlan0: direct probe to AP 00:13:49:23:e2:6a try 3
 wlan0: direct probe to AP 00:13:49:23:e2:6a timed out
 wlan0: direct probe to AP 00:18:39:74:6f:ae try 1
 wlan0 direct probe responded
 wlan0: authenticate with AP 00:18:39:74:6f:ae
 wlan0: authenticated
 wlan0: associate with AP 00:18:39:74:6f:ae
 wlan0: RX AssocResp from 00:18:39:74:6f:ae (capab=0x411 status=0 aid=1)
 wlan0: associated
 wlan0: disassociating by local choice (reason=3)
 wlan0: deauthenticated
 wlan0: direct probe to AP 00:0d:14:00:98:92 try 1
 wlan0: direct probe to AP 00:0d:14:00:98:92 try 1
 wlan0 direct probe responded
 wlan0: authenticate with AP 00:0d:14:00:98:92
 wlan0: authenticated
 wlan0: associate with AP 00:0d:14:00:98:92
 wlan0: RX AssocResp from 00:0d:14:00:98:92 (capab=0x431 status=0 aid=1)
 wlan0: associated
 CE: hpet increasing min_delta_ns to 15000 nsec
------=_20081023171910_34336--


