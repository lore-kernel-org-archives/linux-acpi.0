From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: ASUS P5W DH boot up messages
Date: Fri, 16 Feb 2007 10:43:32 -0800
Message-ID: <20070216104332.2a5f1768@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:57965 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946216AbXBPSnk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 13:43:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Andi Kleen <ak@suse.de>
Cc: linux-acpi@vger.kernel.org

On a system with ASUS P5W DH motherboard and Core 2 Duo processor
running x86_64 system, I see the following messages during boot up. 
System runs okay. Can't use full 4G of memory because of video driver
bug (AGP/DRM?).

1. Some noise about E820 mapping
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved

2. Doesn't use MMCONFIG
PCI: Not using MMCONFIG.

3. ACPI checksum warning

Using specific hotkey driver
ACPI Warning (tbutils-0158): Incorrect checksum in table [OEMB] -  58, should be 4F [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._OSC] (Node ffff8100045e7b30), AE_ALREADY_EXISTS
ACPI: Marking method _OSC as Serialized

This is with the latest BIOS version.

Full boot log:
[    0.000000] Linux version 2.6.20 (shemminger@freekitty) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #5 SMP PREEMPT Thu Feb 15 11:46:45 PST 2007
[    0.000000] Command line: root=/dev/sda1 ro quiet splash
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000d7f80000 (usable)
[    0.000000]  BIOS-e820: 00000000d7f80000 - 00000000d7f8e000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000d7f8e000 - 00000000d7fe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000d7fe0000 - 00000000d8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 884608) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP 000FAF20, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT D7F80000, 0044 (r1 NEC              1000724 MSFT       97)
[    0.000000] ACPI: FACP D7F80200, 0081 (r1 A_M_I_ OEMFACP   1000724 MSFT       97)
[    0.000000] ACPI: DSDT D7F80590, 9560 (r1  A0543 A0543000        0 INTL 20060113)
[    0.000000] ACPI: FACS D7F8E000, 0040
[    0.000000] ACPI: APIC D7F80390, 0080 (r1 A_M_I_ OEMAPIC   1000724 MSFT       97)
[    0.000000] ACPI: SLIC D7F80410, 0176 (r1 NEC              1000724 MSFT       97)
[    0.000000] ACPI: OEMB D7F8E040, 0066 (r1 A_M_I_ AMI_OEM   1000724 MSFT       97)
[    0.000000] ACPI: HPET D7F89AF0, 0038 (r1 A_M_I_ OEMHPET   1000724 MSFT       97)
[    0.000000] ACPI: MCFG D7F89B30, 003C (r1 A_M_I_ OEMMCFG   1000724 MSFT       97)
[    0.000000] ACPI: SSDT D7F8E0B0, 01C6 (r1    AMI   CPU1PM        1 INTL 20060113)
[    0.000000] ACPI: SSDT D7F8E280, 013A (r1    AMI   CPU2PM        1 INTL 20060113)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 884608) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   884608
[    0.000000] On node 0 totalpages: 884511
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1950 pages reserved
[    0.000000]   DMA zone: 1993 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12038 pages used for memmap
[    0.000000]   DMA32 zone: 868474 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to physical flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at dc000000 (gap: d8000000:27b00000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 33792 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 870467
[    0.000000] Kernel command line: root=/dev/sda1 ro quiet splash
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   47.648112] Console: colour VGA+ 80x25
[   47.648132] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   47.648134] ... MAX_LOCKDEP_SUBCLASSES:    8
[   47.648136] ... MAX_LOCK_DEPTH:          30
[   47.648138] ... MAX_LOCKDEP_KEYS:        2048
[   47.648140] ... CLASSHASH_SIZE:           1024
[   47.648141] ... MAX_LOCKDEP_ENTRIES:     8192
[   47.648143] ... MAX_LOCKDEP_CHAINS:      16384
[   47.648145] ... CHAINHASH_SIZE:          8192
[   47.648147]  memory used by lock dependency info: 1648 kB
[   47.648149]  per task-struct memory footprint: 1680 bytes
[   47.649398] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[   47.653075] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   47.653385] Checking aperture...
[   47.653396] Calgary: detecting Calgary via BIOS EBDA area
[   47.653398] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[   47.694769] Memory: 3475200k/3538432k available (2162k kernel code, 62712k reserved, 1259k data, 196k init)
[   47.754881] Calibrating delay using timer specific routine.. 4277.45 BogoMIPS (lpj=2138725)
[   47.754949] Security Framework v1.0.0 initialized
[   47.754994] Mount-cache hash table entries: 256
[   47.755434] CPU: L1 I cache: 32K, L1 D cache: 32K
[   47.755437] CPU: L2 cache: 2048K
[   47.755439] using mwait in idle threads.
[   47.755441] CPU: Physical Processor ID: 0
[   47.755443] CPU: Processor Core ID: 0
[   47.755449] CPU0: Thermal monitoring enabled (TM2)
[   47.755463] lockdep: not fixing up alternatives.
[   47.755466] ACPI: Core revision 20070126
[   47.783169] Using local APIC timer interrupts.
[   47.829950] result 16695212
[   47.829952] Detected 16.695 MHz APIC timer.
[   47.831220] lockdep: not fixing up alternatives.
[   47.831301] Booting processor 1/2 APIC 0x1
[   47.862061] Initializing CPU#1
[   47.922811] Calibrating delay using timer specific routine.. 4274.05 BogoMIPS (lpj=2137027)
[   47.922817] CPU: L1 I cache: 32K, L1 D cache: 32K
[   47.922819] CPU: L2 cache: 2048K
[   47.922821] CPU: Physical Processor ID: 0
[   47.922823] CPU: Processor Core ID: 1
[   47.922828] CPU1: Thermal monitoring enabled (TM2)
[   47.923139] Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
[   47.923838] Brought up 2 CPUs
[   47.923882] testing NMI watchdog ... OK.
[   47.933893] time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
[   47.933896] time.c: Detected 2136.988 MHz processor.
[   48.013464] migration_cost=22
[   48.014048] NET: Registered protocol family 16
[   48.014293] ACPI: bus type pci registered
[   48.014303] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   48.014334] PCI: Not using MMCONFIG.
[   48.014363] PCI: Using configuration type 1
[   48.028779] ACPI: Interpreter enabled
[   48.028781] ACPI: Using IOAPIC for interrupt routing
[   48.040592] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   48.040621] PCI: Probing PCI hardware (bus 00)
[   48.041339] PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
[   48.041343] PCI quirk: region 0480-04bf claimed by ICH6 GPIO
[   48.041631] Boot video device is 0000:06:00.0
[   48.042542] PCI: Transparent bridge - 0000:00:1e.0
[   48.042629] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   48.042904] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[   48.043013] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
[   48.043191] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[   48.043297] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
[   48.043401] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
[   48.043485] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[   48.047992] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   48.048131] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   48.048266] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   48.048402] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   48.048537] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   48.048673] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   48.048891] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   48.049035] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   48.049188] Linux Plug and Play Support v0.97 (c) Adam Belay
[   48.049203] pnp: PnP ACPI init
[   48.053058] pnp: PnP ACPI: found 16 devices
[   48.053298] SCSI subsystem initialized
[   48.053371] libata version 2.10 loaded.
[   48.053479] usbcore: registered new interface driver usbfs
[   48.053535] usbcore: registered new interface driver hub
[   48.053612] usbcore: registered new device driver usb
[   48.053685] PCI: Using ACPI for IRQ routing
[   48.053687] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   48.053851] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   48.053856] hpet0: 3 64-bit timers, 14318180 Hz
[   48.054899] PCI-GART: No AMD northbridge found.
[   48.054994] pnp: 00:01: iomem range 0xfed13000-0xfed19fff has been reserved
[   48.055004] pnp: 00:07: ioport range 0x290-0x297 has been reserved
[   48.055012] pnp: 00:08: iomem range 0xfed1c000-0xfed1ffff has been reserved
[   48.055015] pnp: 00:08: iomem range 0xfed20000-0xfed3ffff has been reserved
[   48.055018] pnp: 00:08: iomem range 0xfed50000-0xfed8ffff has been reserved
[   48.055021] pnp: 00:08: iomem range 0xffb00000-0xffbfffff has been reserved
[   48.055031] pnp: 00:0c: iomem range 0xfec00000-0xfec00fff has been reserved
[   48.055034] pnp: 00:0c: iomem range 0xfee00000-0xfee00fff has been reserved
[   48.055042] pnp: 00:0e: iomem range 0xf0000000-0xf3ffffff has been reserved
[   48.055049] pnp: 00:0f: iomem range 0x0-0x9ffff could not be reserved
[   48.055052] pnp: 00:0f: iomem range 0xc0000-0xdffff could not be reserved
[   48.055056] pnp: 00:0f: iomem range 0xe0000-0xfffff could not be reserved
[   48.055059] pnp: 00:0f: iomem range 0x100000-0xd7ffffff could not be reserved
[   48.055524] PCI: Bridge: 0000:00:01.0
[   48.055527]   IO window: c000-cfff
[   48.055532]   MEM window: ff900000-ff9fffff
[   48.055535]   PREFETCH window: dff00000-efefffff
[   48.055540] PCI: Bridge: 0000:00:1c.0
[   48.055541]   IO window: disabled.
[   48.055546]   MEM window: disabled.
[   48.055550]   PREFETCH window: dfe00000-dfefffff
[   48.055555] PCI: Bridge: 0000:00:1c.2
[   48.055558]   IO window: b000-bfff
[   48.055564]   MEM window: ff800000-ff8fffff
[   48.055568]   PREFETCH window: disabled.
[   48.055573] PCI: Bridge: 0000:00:1c.3
[   48.055576]   IO window: a000-afff
[   48.055581]   MEM window: ff700000-ff7fffff
[   48.055585]   PREFETCH window: disabled.
[   48.055590] PCI: Bridge: 0000:00:1c.4
[   48.055593]   IO window: 9000-9fff
[   48.055598]   MEM window: ff600000-ff6fffff
[   48.055602]   PREFETCH window: disabled.
[   48.055608] PCI: Bridge: 0000:00:1e.0
[   48.055609]   IO window: disabled.
[   48.055614]   MEM window: ff500000-ff5fffff
[   48.055618]   PREFETCH window: disabled.
[   48.055636] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   48.055642] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   48.055661] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   48.055666] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   48.055687] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   48.055692] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   48.055712] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   48.055718] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   48.055736] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
[   48.055742] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   48.055753] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   48.055791] NET: Registered protocol family 2
[   48.066841] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   48.067239] TCP established hash table entries: 65536 (order: 10, 4194304 bytes)
[   48.072216] TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
[   48.077317] TCP: Hash tables configured (established 65536 bind 65536)
[   48.077348] TCP reno registered
[   48.082165] audit: initializing netlink socket (disabled)
[   48.082191] audit(1171587176.360:1): initialized
[   48.082832] io scheduler noop registered
[   48.082836] io scheduler anticipatory registered
[   48.082838] io scheduler deadline registered
[   48.082854] io scheduler cfq registered (default)
[   48.083253] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   48.083299] assign_interrupt_mode Found MSI capability
[   48.083341] Allocate Port Service[0000:00:01.0:pcie00]
[   48.083460] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   48.083507] assign_interrupt_mode Found MSI capability
[   48.083544] Allocate Port Service[0000:00:1c.0:pcie00]
[   48.083603] Allocate Port Service[0000:00:1c.0:pcie02]
[   48.083722] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   48.083772] assign_interrupt_mode Found MSI capability
[   48.083808] Allocate Port Service[0000:00:1c.2:pcie00]
[   48.083870] Allocate Port Service[0000:00:1c.2:pcie02]
[   48.083989] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   48.084035] assign_interrupt_mode Found MSI capability
[   48.084072] Allocate Port Service[0000:00:1c.3:pcie00]
[   48.084198] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   48.084243] assign_interrupt_mode Found MSI capability
[   48.084280] Allocate Port Service[0000:00:1c.4:pcie00]
[   48.117208] hpet_resources: 0xfed00000 is busy
[   48.117247] Linux agpgart interface v0.101 (c) Dave Jones
[   48.117321] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   48.117533] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   48.118505] 00:0d: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   48.119628] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   48.119922] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   48.119926] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   48.119990] ICH7: IDE controller at PCI slot 0000:00:1f.1
[   48.120004] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[   48.120015] ICH7: chipset revision 1
[   48.120017] ICH7: not 100% native mode: will probe irqs later
[   48.120027]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
[   48.120039]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
[   48.120050] Probing IDE interface ide0...
[   48.803649] hda: TDK CDRW321040X, ATAPI CD/DVD-ROM drive
[   49.113403] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   49.113858] Probing IDE interface ide1...
[   49.642297] Probing IDE interface ide1...
[   50.171700] hda: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache
[   50.171706] Uniform CD-ROM driver Revision: 3.20
[   50.173925] ata_piix 0000:00:1f.2: version 2.00ac7
[   50.173931] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   50.325900] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
[   50.325918] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   50.326011] ata1: SATA max UDMA/133 cmd 0x000000000001e400 ctl 0x000000000001e082 bmdma 0x000000000001d880 irq 23
[   50.326049] ata2: SATA max UDMA/133 cmd 0x000000000001e000 ctl 0x000000000001dc02 bmdma 0x000000000001d888 irq 23
[   50.326060] scsi0 : ata_piix
[   50.481996] ata1.00: ATA-7: Maxtor 6Y080M0, YAR51HW0, max UDMA/133
[   50.481999] ata1.00: 156312576 sectors, multi 16: LBA 
[   50.485995] ata1.00: configured for UDMA/133
[   50.486001] scsi1 : ata_piix
[   51.212855] ata2.00: ATA-6: Config  Disk, RGL10364, max UDMA/133
[   51.212858] ata2.00: 640 sectors, multi 1: LBA 
[   51.212860] ata2.00: Drive reports diagnostics failure. This may indicate a drive
[   51.212862] ata2.00: fault or invalid emulation. Contact drive vendor for information.
[   51.213186] ata2.00: configured for UDMA/133
[   51.213521] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
[   51.213855] SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
[   51.213871] sda: Write Protect is off
[   51.213873] sda: Mode Sense: 00 3a 00 00
[   51.213901] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   51.214240] SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
[   51.214256] sda: Write Protect is off
[   51.214258] sda: Mode Sense: 00 3a 00 00
[   51.214286] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   51.214325]  sda: sda1 sda3 sda4
[   51.227687] sd 0:0:0:0: Attached scsi disk sda
[   51.227846] scsi 1:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
[   51.227977] SCSI device sdb: 640 512-byte hdwr sectors (0 MB)
[   51.227992] sdb: Write Protect is off
[   51.227994] sdb: Mode Sense: 00 3a 00 00
[   51.228022] SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   51.228079] SCSI device sdb: 640 512-byte hdwr sectors (0 MB)
[   51.228095] sdb: Write Protect is off
[   51.228097] sdb: Mode Sense: 00 3a 00 00
[   51.228126] SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   51.228128]  sdb: unknown partition table
[   51.228412] sd 1:0:0:0: Attached scsi disk sdb
[   51.228490] usbmon: debugfs is not available
[   51.228554] usbcore: registered new interface driver libusual
[   51.228671] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   51.231156] serio: i8042 KBD port at 0x60,0x64 irq 1
[   51.231178] serio: i8042 AUX port at 0x60,0x64 irq 12
[   51.231419] mice: PS/2 mouse device common for all mice
[   51.231489] EDAC MC: Ver: 2.0.1 Feb 15 2007
[   51.231801] TCP cubic registered
[   51.231810] NET: Registered protocol family 1
[   51.231817] NET: Registered protocol family 17
[   51.250147] ACPI: (supports S0 S1 S3 S4 S5)
[   51.250198] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   51.254873] input: AT Translated Set 2 keyboard as /class/input/input0
[   51.362936] kjournald starting.  Commit interval 5 seconds
[   51.363040] EXT3-fs: mounted filesystem with ordered data mode.
[   51.363112] VFS: Mounted root (ext3 filesystem) readonly.
[   51.363141] Freeing unused kernel memory: 196k freed
[   57.298957] IPv4 FIB: Using LC-trie version 0.407
[   58.081071] USB Universal Host Controller Interface driver v3.0
[   58.081137] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
[   58.081149] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   58.081153] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   58.081814] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   58.081847] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
[   58.082235] usb usb1: configuration #1 chosen from 1 choice
[   58.082377] hub 1-0:1.0: USB hub found
[   58.082430] hub 1-0:1.0: 2 ports detected
[   58.184410] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
[   58.184421] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   58.184425] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   58.184470] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   58.184497] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
[   58.184647] usb usb2: configuration #1 chosen from 1 choice
[   58.184687] hub 2-0:1.0: USB hub found
[   58.184694] hub 2-0:1.0: 2 ports detected
[   58.274867] Real Time Clock Driver v1.12ac
[   58.286033] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   58.286045] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   58.286049] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   58.286094] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[   58.286123] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
[   58.286274] usb usb3: configuration #1 chosen from 1 choice
[   58.286315] hub 3-0:1.0: USB hub found
[   58.286322] hub 3-0:1.0: 2 ports detected
[   58.317379] intel_rng: FWH not detected
[   58.356168] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   58.356215] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   58.374979] Floppy drive(s): fd0 is 1.44M
[   58.387968] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
[   58.387981] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   58.387985] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   58.388030] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[   58.388059] uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
[   58.388229] usb usb4: configuration #1 chosen from 1 choice
[   58.388269] hub 4-0:1.0: USB hub found
[   58.388276] hub 4-0:1.0: 2 ports detected
[   58.388834] input: PC Speaker as /class/input/input1
[   58.392029] FDC 0 is a post-1991 82077
[   58.490077] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
[   58.490099] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   58.490104] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   58.490155] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[   58.490237] ehci_hcd 0000:00:1d.7: debug port 1
[   58.490249] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   58.490256] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffafbc00
[   58.494155] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   58.494318] usb usb5: configuration #1 chosen from 1 choice
[   58.494360] hub 5-0:1.0: USB hub found
[   58.494478] hub 5-0:1.0: 8 ports detected
[   58.596092] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
[   58.596861] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 18 (level, low) -> IRQ 18
[   58.596875] PCI: Setting latency timer of device 0000:04:00.0 to 64
[   58.596940] sky2 0000:04:00.0: v1.13 addr 0xff8fc000 irq 18 Yukon-EC (0xb6) rev 2
[   58.597416] sky2 eth0: addr 00:00:5a:9b:0a:c3
[   58.597446] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[   58.597457] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   58.597498] sky2 0000:03:00.0: v1.13 addr 0xff7fc000 irq 19 Yukon-EC (0xb6) rev 2
[   58.597756] sky2 eth1: addr 00:18:f3:79:78:4d
[   58.597785] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   58.597796] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   58.597830] sky2 0000:02:00.0: v1.13 addr 0xff6fc000 irq 16 Yukon-EC (0xb6) rev 2
[   58.598086] sky2 eth2: addr 00:18:f3:79:74:81
[   58.682126] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
[   58.682164] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   58.794436] input: PS/2 Generic Mouse as /class/input/input2
[   58.833627] usb 5-7: new high speed USB device using ehci_hcd and address 2
[   58.923412] sky2 eth2: enabling interface
[   58.925341] sky2 eth2: ram buffer 48K
[   58.951881] usb 5-7: configuration #1 chosen from 1 choice
[   58.952335] hub 5-7:1.0: USB hub found
[   58.952644] hub 5-7:1.0: 4 ports detected
[   58.966178] sky2 eth0: enabling interface
[   58.968006] sky2 eth0: ram buffer 48K
[   59.040278] sky2 eth1: enabling interface
[   59.042098] sky2 eth1: ram buffer 48K
[   59.092699] Adding 2008116k swap on /dev/disk/by-uuid/39de78e1-bdbd-4f94-b351-2fb4de2cea07.  Priority:-1 extents:1 across:2008116k
[   59.157725] EXT3 FS on sda1, internal journal
[   59.228674] usb 5-7.3: new high speed USB device using ehci_hcd and address 3
[   59.313003] usb 5-7.3: configuration #1 chosen from 1 choice
[   59.331241] kjournald starting.  Commit interval 5 seconds
[   59.331582] EXT3 FS on sda4, internal journal
[   59.331589] EXT3-fs: mounted filesystem with ordered data mode.
[   61.585580] sky2 eth0: Link is up at 1000 Mbps, full duplex, flow control both
[   65.212147] input: Power Button (FF) as /class/input/input3
[   65.212183] ACPI: Power Button (FF) [PWRF]
[   65.212301] input: Power Button (CM) as /class/input/input4
[   65.212326] ACPI: Power Button (CM) [PWRB]
[   65.270612] Using specific hotkey driver
[   65.296222] ACPI Warning (tbutils-0158): Incorrect checksum in table [OEMB] -  58, should be 4F [20070126]
[   65.296236] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._OSC] (Node ffff8100045e7b30), AE_ALREADY_EXISTS
[   65.296245] ACPI: Marking method _OSC as Serialized
[   65.296287] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] (Node ffff8100045e7b50), AE_ALREADY_EXISTS
[   65.296293] ACPI: Marking method _PDC as Serialized
[   65.296705] ACPI: Processor [CPU1] (supports 8 throttling states)
[   65.296936] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._OSC] (Node ffff8100045e7a10), AE_ALREADY_EXISTS
[   65.296942] ACPI: Marking method _OSC as Serialized
[   65.296979] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] (Node ffff8100045e7a30), AE_ALREADY_EXISTS
[   65.296985] ACPI: Marking method _PDC as Serialized
[   65.297250] ACPI: Processor [CPU2] (supports 8 throttling states)
[   65.297265] ACPI Exception (acpi_processor-0784): AE_NOT_FOUND, Processor Device is not present [20070126]
[   65.297279] ACPI Exception (acpi_processor-0784): AE_NOT_FOUND, Processor Device is not present [20070126]
[   66.329526] [drm] Initialized drm 1.1.0 20060810
[   66.418064] ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   66.419685] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[   66.420468] mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
[   67.206566] mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
[   67.417617] mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
[   67.417736] mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
[   67.417811] mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
[   69.296349] NET: Registered protocol family 10
[   69.296569] lo: Disabled Privacy Extensions
[   69.297300] ADDRCONF(NETDEV_UP): eth2: link is not ready
[   69.297653] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   69.760365] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   69.774341] [drm] Setting GART location based on new memory map
[   69.774956] [drm] Loading R300 Microcode
[   69.775107] [drm] writeback test succeeded in 1 usecs
[   79.973407] eth0: no IPv6 routers present


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
