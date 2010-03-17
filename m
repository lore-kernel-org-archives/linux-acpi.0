From: Boris Srostlik <support@blzservices.com>
Subject: as requested here is the list . . . Dell T105 server
Date: Tue, 16 Mar 2010 22:46:02 -0400
Message-ID: <70416D3A-AE8E-4B18-ADBB-BC13895A9433@blzservices.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vt1.blzservices.com ([209.198.126.126]:1414 "EHLO
	vt1.blzservices.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0CQDqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2010 23:46:09 -0400
Received: from macbookpro.blzservices.com (account support@blzservices.com [192.168.99.115] verified)
  by vt1.blzservices.com (CommuniGate Pro SMTP 4.2.10)
  with ESMTP id 1020291 for linux-acpi@vger.kernel.org; Tue, 16 Mar 2010 22:46:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

# dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.24-27-server (buildd@crested) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu3)) #1 SMP Fri Mar 12 01:23:09 UTC 2010 (Ubuntu 2.6.24-27.68-server)
[    0.000000] Command line: root=UUID=132d8b33-5ecc-4c78-a33e-2f9eb57351a9 ro quiet splash
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000ca000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fed0000 (usable)
[    0.000000]  BIOS-e820: 000000007fed0000 - 000000007fee4000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007fee4000 - 000000007ff7f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 157) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 523984) 1 entries of 3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xFFFF8100000F79B0 checksum 0
[    0.000000] ACPI: RSDP 000F79B0, 0024 (r2 PTLTD )
[    0.000000] ACPI: XSDT 7FEDFBAE, 009C (r1 DELL   PE_SC3    6040000 DELL        0)
[    0.000000] ACPI: FACP 7FEE3359, 00F4 (r3 DELL   PE_SC3    6040000 DELL    F4240)
[    0.000000] ACPI: DSDT 7FEDFC4A, 369B (r1 DELL   PE_SC3    6040000 MSFT  100000E)
[    0.000000] ACPI: FACS 7FEE4FC0, 0040
[    0.000000] ACPI: TCPA 7FEE344D, 0032 (r1 Phoeni  x        6040000  TL         0)
[    0.000000] ACPI: SLIC 7FEE347F, 0176 (r1 DELL   PE_SC3    6040000 PTL         1)
[    0.000000] ACPI: SPCR 7FEE35F5, 0050 (r1 DELL   PE_SC3    6040000 PTL         1)
[    0.000000] ACPI: EINJ 7FEE3645, 01B0 (r1 PTL    WHEAPTL   6040000 PTL         1)
[    0.000000] ACPI: HEST 7FEE37F5, 00A8 (r1 PTL    WHEAPTL   6040000 PTL         1)
[    0.000000] ACPI: BERT 7FEE389D, 0030 (r1 PTL    WHEAPTL   6040000 PTL         1)
[    0.000000] ACPI: SSDT 7FEE38CD, 00E1 (r1 wheaos  wheaosc  6040000 INTL 20050624)
[    0.000000] ACPI: ERST 7FEE39AE, 0270 (r1 PTL    WHEAPTL   6040000 PTL         1)
[    0.000000] ACPI: SRAT 7FEE3C1E, 00A0 (r1 AMD    FAM_F_10  6040000 AMD         1)
[    0.000000] ACPI: SSDT 7FEE3CBE, 0248 (r1 AMD    POWERNOW  6040000 AMD         1)
[    0.000000] ACPI: MCFG 7FEE3F06, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 7FEE3F42, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 7FEE3F7A, 005E (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 7FEE3FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 1 -> Node 0
[    0.000000] SRAT: Node 0 PXM 0 0-a0000
[    0.000000] Entering add_active_range(0, 0, 157) 0 entries of 3200 used
[    0.000000] SRAT: Node 0 PXM 0 0-80000000
[    0.000000] Entering add_active_range(0, 0, 157) 1 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 523984) 1 entries of 3200 used
[    0.000000] NUMA: Using 63 for the hash shift.
[    0.000000] Bootmem setup node 0 0000000000000000-000000007fed0000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      157
[    0.000000]     0:      256 ->   523984
[    0.000000] On node 0 totalpages: 523885
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1326 pages reserved
[    0.000000]   DMA zone: 2615 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7107 pages used for memmap
[    0.000000]   DMA32 zone: 512781 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x8008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] swsusp: Registered nosave memory region: 000000000009d000 - 000000000009e000
[    0.000000] swsusp: Registered nosave memory region: 000000000009e000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000ca000
[    0.000000] swsusp: Registered nosave memory region: 00000000000ca000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 42080 bytes of per cpu data
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 515396
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=UUID=132d8b33-5ecc-4c78-a33e-2f9eb57351a9 ro quiet splash
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] hpet clockevent registered
[    0.000000] TSC calibrated against HPET
[   22.684230] Marking TSC unstable due to TSCs unsynchronized
[   22.684232] time.c: Detected 2310.646 MHz processor.
[   22.686205] Console: colour VGA+ 80x25
[   22.686208] console [tty0] enabled
[   22.686224] Checking aperture...
[   22.686226] CPU 0: aperture @ f602000000 size 32 MB
[   22.686227] Aperture too small (32 MB)
[   22.690168] No AGP bridge found
[   22.706919] Memory: 2054024k/2095936k available (2529k kernel code, 41516k reserved, 1331k data, 328k init)
[   22.706952] SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[   22.706968] Calibrating delay loop (skipped), using tsc calculated value.. 4621.29 BogoMIPS (lpj=23106460)
[   22.706996] Security Framework initialized
[   22.707001] SELinux:  Disabled at boot.
[   22.707013] AppArmor: AppArmor initialized
[   22.707016] Failure registering capabilities with primary security module.
[   22.707152] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   22.708304] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   22.708849] Mount-cache hash table entries: 256
[   22.708961] Initializing cgroup subsys ns
[   22.708965] Initializing cgroup subsys cpuacct
[   22.708976] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   22.708977] CPU: L2 Cache: 512K (64 bytes/line)
[   22.708979] CPU 0/0 -> Node 0
[   22.708981] CPU: Physical Processor ID: 0
[   22.708982] CPU: Processor Core ID: 0
[   22.709003] SMP alternatives: switching to UP code
[   22.709533] Early unpacking initramfs... done
[   22.964027] ACPI: Core revision 20070126
[   22.964068] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   23.065877] Using local APIC timer interrupts.
[   23.109143] APIC timer calibration result 12557851
[   23.109144] Detected 12.557 MHz APIC timer.
[   23.109236] SMP alternatives: switching to SMP code
[   23.109698] Booting processor 1/2 APIC 0x1
[   23.116639] Initializing CPU#1
[   23.265961] Calibrating delay using timer specific routine.. 4621.32 BogoMIPS (lpj=23106638)
[   23.265967] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   23.265968] CPU: L2 Cache: 512K (64 bytes/line)
[   23.265970] CPU 1/1 -> Node 0
[   23.265972] CPU: Physical Processor ID: 0
[   23.265973] CPU: Processor Core ID: 1
[   23.266062] AMD Athlon(tm) Dual Core Processor 4450B stepping 02
[   23.269284] Brought up 2 CPUs
[   23.269353] CPU0 attaching sched-domain:
[   23.269356]  domain 0: span 00000000,00000003
[   23.269358]   groups: 00000000,00000001 00000000,00000002
[   23.269361]   domain 1: span 00000000,00000003
[   23.269363]    groups: 00000000,00000003
[   23.269365] CPU1 attaching sched-domain:
[   23.269366]  domain 0: span 00000000,00000003
[   23.269368]   groups: 00000000,00000002 00000000,00000001
[   23.269371]   domain 1: span 00000000,00000003
[   23.269372]    groups: 00000000,00000003
[   23.269658] net_namespace: 120 bytes
[   23.270031] Time:  2:29:24  Date: 03/17/10
[   23.270061] NET: Registered protocol family 16
[   23.270243] ACPI: bus type pci registered
[   23.270308] PCI: Using configuration type 1
[   23.271146] ACPI: EC: Look up EC in DSDT
[   23.272942] ACPI: BIOS _OSI(Linux) query ignored
[   23.272943] ACPI: DMI System Vendor: Dell Inc.
[   23.272945] ACPI: DMI Product Name: PowerEdge T105 
[   23.272946] ACPI: DMI Product Version: (none)
[   23.272947] ACPI: DMI Board Name: 0P957K
[   23.272948] ACPI: DMI BIOS Vendor: Dell Inc.
[   23.272949] ACPI: DMI BIOS Date: 07/30/2009
[   23.272950] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[   23.272952] ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
[   23.273037] ACPI: Interpreter enabled
[   23.273039] ACPI: (supports S0 S4 S5)
[   23.273051] ACPI: Using IOAPIC for interrupt routing
[   23.277013] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   23.277611] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   23.277695] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[   23.277740] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[   23.277773] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[   23.277807] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[   23.277840] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR3._PRT]
[   23.289923] ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0
[   23.290047] ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0
[   23.290168] ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0, disabled.
[   23.290289] ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0, disabled.
[   23.290409] ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
[   23.290534] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0
[   23.290654] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
[   23.290774] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0, disabled.
[   23.290894] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disabled.
[   23.291014] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disabled.
[   23.291134] ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
[   23.291255] ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
[   23.291381] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
[   23.291507] ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0
[   23.291631] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
[   23.291751] Linux Plug and Play Support v0.97 (c) Adam Belay
[   23.291778] pnp: PnP ACPI init
[   23.291786] ACPI: bus type pnp registered
[   23.293581] pnp: PnP ACPI: found 12 devices
[   23.293584] ACPI: ACPI bus type pnp unregistered
[   23.293804] PCI: Using ACPI for IRQ routing
[   23.293807] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   23.319149] NET: Registered protocol family 8
[   23.319151] NET: Registered protocol family 20
[   23.319183] NetLabel: Initializing
[   23.319184] NetLabel:  domain hash size = 128
[   23.319186] NetLabel:  protocols = UNLABELED CIPSOv4
[   23.319199] NetLabel:  unlabeled traffic allowed by default
[   23.319250] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[   23.319253] hpet0: 3 32-bit timers, 25000000 Hz
[   23.320294] AppArmor: AppArmor Filesystem Enabled
[   23.329067] Time: hpet clocksource has been installed.
[   23.329076] Switched to high resolution mode on CPU 0
[   23.326073] Switched to high resolution mode on CPU 1
[   23.349098] system 00:00: iomem range 0xffc00000-0xffffffff could not be reserved
[   23.349101] system 00:00: iomem range 0xfec00000-0xfec00fff could not be reserved
[   23.349103] system 00:00: iomem range 0xfee00000-0xfeefffff could not be reserved
[   23.349106] system 00:00: iomem range 0xfed00000-0xfed00fff has been reserved
[   23.349113] system 00:02: iomem range 0xe0000000-0xefffffff could not be reserved
[   23.349119] system 00:03: ioport range 0x8000-0x807f has been reserved
[   23.349121] system 00:03: ioport range 0x8080-0x80ff has been reserved
[   23.349123] system 00:03: ioport range 0x8400-0x847f has been reserved
[   23.349125] system 00:03: ioport range 0x8480-0x84ff has been reserved
[   23.349127] system 00:03: ioport range 0x8800-0x887f has been reserved
[   23.349130] system 00:03: ioport range 0x8880-0x88ff has been reserved
[   23.349132] system 00:03: ioport range 0x2040-0x207f has been reserved
[   23.349134] system 00:03: ioport range 0x2000-0x203f has been reserved
[   23.349140] system 00:05: ioport range 0x4d0-0x4d1 has been reserved
[   23.349148] system 00:0a: ioport range 0xc00-0xc7f has been reserved
[   23.349513] PCI: Bridge: 0000:00:09.0
[   23.349515]   IO window: 3000-3fff
[   23.349517]   MEM window: d0100000-d01fffff
[   23.349519]   PREFETCH window: d8000000-dfffffff
[   23.349521] PCI: Bridge: 0000:00:0b.0
[   23.349522]   IO window: disabled.
[   23.349524]   MEM window: d0200000-d02fffff
[   23.349526]   PREFETCH window: disabled.
[   23.349528] PCI: Bridge: 0000:00:0c.0
[   23.349529]   IO window: disabled.
[   23.349530]   MEM window: disabled.
[   23.349532]   PREFETCH window: disabled.
[   23.349534] PCI: Bridge: 0000:00:0d.0
[   23.349535]   IO window: disabled.
[   23.349536]   MEM window: disabled.
[   23.349538]   PREFETCH window: disabled.
[   23.349539] PCI: Bridge: 0000:00:0e.0
[   23.349540]   IO window: disabled.
[   23.349542]   MEM window: disabled.
[   23.349543]   PREFETCH window: disabled.
[   23.349549] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   23.349559] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   23.349564] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   23.349569] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   23.349574] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   23.349582] NET: Registered protocol family 2
[   23.439253] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   23.440112] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   23.442450] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   23.443020] TCP: Hash tables configured (established 262144 bind 65536)
[   23.443023] TCP reno registered
[   23.469151] checking if image is initramfs... it is
[   24.011705] Freeing initrd memory: 7338k freed
[   24.015429] Simple Boot Flag at 0x62 set to 0x1
[   24.016269] audit: initializing netlink socket (disabled)
[   24.016280] audit(1268792964.310:1): initialized
[   24.016494] Total HugeTLB memory allocated, 0
[   24.018216] VFS: Disk quotas dquot_6.5.1
[   24.018305] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   24.018489] io scheduler noop registered
[   24.018491] io scheduler anticipatory registered
[   24.018493] io scheduler deadline registered (default)
[   24.018587] io scheduler cfq registered
[   24.018602] pci 0000:00:00.0: Enabling HT MSI Mapping
[   24.019251] pci 0000:00:07.0: Enabling HT MSI Mapping
[   24.019263] pci 0000:00:08.0: Enabling HT MSI Mapping
[   24.019274] pci 0000:00:0b.0: Enabling HT MSI Mapping
[   24.019279] PCI: Found enabled HT MSI Mapping on 0000:00:0b.0
[   24.019286] pci 0000:00:0c.0: Enabling HT MSI Mapping
[   24.019291] PCI: Found enabled HT MSI Mapping on 0000:00:0c.0
[   24.019297] pci 0000:00:0d.0: Enabling HT MSI Mapping
[   24.019302] PCI: Found enabled HT MSI Mapping on 0000:00:0d.0
[   24.019309] pci 0000:00:0e.0: Enabling HT MSI Mapping
[   24.019313] PCI: Found enabled HT MSI Mapping on 0000:00:0e.0
[   24.019319] Boot video device is 0000:01:08.0
[   24.019467] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   24.019482] assign_interrupt_mode Found MSI capability
[   24.019497] Allocate Port Service[0000:00:0b.0:pcie00]
[   24.019549] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   24.019564] assign_interrupt_mode Found MSI capability
[   24.019575] Allocate Port Service[0000:00:0c.0:pcie00]
[   24.019631] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   24.019646] assign_interrupt_mode Found MSI capability
[   24.019656] Allocate Port Service[0000:00:0d.0:pcie00]
[   24.019705] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   24.019719] assign_interrupt_mode Found MSI capability
[   24.019729] Allocate Port Service[0000:00:0e.0:pcie00]
[   24.044327] Real Time Clock Driver v1.12ac
[   24.044484] hpet_resources: 0xfed00000 is busy
[   24.044516] Linux agpgart interface v0.102
[   24.044518] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   24.044646] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   24.045164] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   24.045784] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   24.045843] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[   24.045959] PNP: No PS/2 controller found. Probing ports directly.
[   24.289044] serio: i8042 KBD port at 0x60,0x64 irq 1
[   24.318750] mice: PS/2 mouse device common for all mice
[   24.318786] cpuidle: using governor ladder
[   24.318787] cpuidle: using governor menu
[   24.318919] NET: Registered protocol family 1
[   24.319014] registered taskstats version 1
[   24.319114]   Magic number: 2:393:460
[   24.319237] /build/buildd/linux-2.6.24/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   24.319240] BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
[   24.319435] Freeing unused kernel memory: 328k freed
[   24.319847] Write protecting the kernel read-only data: 1044k
[   24.469154] fuse init (API version 7.9)
[   24.485260] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   24.485267] ACPI: Processor [C000] (supports 2 throttling states)
[   24.485307] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485317] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485327] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485336] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485345] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485354] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485364] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485373] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485384] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485393] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485403] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485413] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485422] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.485431] ACPI Exception (processor_core-0824): AE_NOT_FOUND, Processor Device is not present [20070126]
[   24.769082] usbcore: registered new interface driver usbfs
[   24.769103] usbcore: registered new interface driver hub
[   24.775575] tg3.c:v3.86 (November 9, 2007)
[   24.775817] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 19
[   24.775824] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK2] -> GSI 19 (level, low) -> IRQ 19
[   24.775832] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   24.781700] usbcore: registered new device driver usb
[   24.787783] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   24.788060] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 23
[   24.788066] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 23 (level, low) -> IRQ 23
[   24.788219] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   24.788225] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   24.788445] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
[   24.788465] ohci_hcd 0000:00:02.0: irq 23, io mem 0xd0000000
[   24.795102] SCSI subsystem initialized
[   24.801278] libata version 3.00 loaded.
[   24.821952] eth0: Tigon3 [partno(BCM95722) rev a200 PHY(5722/5756)] (PCI Express) 10/100/1000Base-T Ethernet 00:24:e8:3d:cb:a3
[   24.821959] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
[   24.821961] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[   24.849969] usb usb1: configuration #1 chosen from 1 choice
[   24.849996] hub 1-0:1.0: USB hub found
[   24.850003] hub 1-0:1.0: 10 ports detected
[   24.961283] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 22
[   24.961293] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 22 (level, low) -> IRQ 22
[   24.961467] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   24.961473] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   24.961526] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
[   24.961551] ehci_hcd 0000:00:02.1: debug port 1
[   24.961554] PCI: cache line size of 64 is not supported by device 0000:00:02.1
[   24.961564] ehci_hcd 0000:00:02.1: irq 22, io mem 0xd0001000
[   24.978449] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   24.978551] usb usb2: configuration #1 chosen from 1 choice
[   24.978573] hub 2-0:1.0: USB hub found
[   24.978580] hub 2-0:1.0: 10 ports detected
[   25.088622] PCI: Enabling device 0000:00:07.0 (0005 -> 0007)
[   25.088869] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 21
[   25.088876] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 21 (level, low) -> IRQ 21
[   25.088908] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   25.088917] ACPI: PCI interrupt for device 0000:00:07.0 disabled
[   25.089125] ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 20
[   25.089128] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 20 (level, low) -> IRQ 20
[   25.089142] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   25.089148] ACPI: PCI interrupt for device 0000:00:08.0 disabled
[   25.088404] sata_nv 0000:00:07.0: version 3.5
[   25.088418] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 21 (level, low) -> IRQ 21
[   25.088422] sata_nv 0000:00:07.0: Using ADMA mode
[   25.088612] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   25.088870] scsi0 : sata_nv
[   25.088919] scsi1 : sata_nv
[   25.089038] ata1: SATA max UDMA/133 cmd 0x20f0 ctl 0x20e0 bmdma 0x20b0 irq 21
[   25.089040] ata2: SATA max UDMA/133 cmd 0x20d0 ctl 0x20c0 bmdma 0x20b8 irq 21
[   25.577560] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   25.595371] ata1.00: ATA-8: WDC WD1602ABKS-18N8A0, 02.03B04, max UDMA/133
[   25.595373] ata1.00: 312500000 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   25.638412] ata1.00: configured for UDMA/133
[   25.967399] ata2: SATA link down (SStatus 0 SControl 300)
[   25.967493] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1602ABKS-1 02.0 PQ: 0 ANSI: 5
[   25.967500] ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
[   25.967567] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 20 (level, low) -> IRQ 20
[   25.967572] sata_nv 0000:00:08.0: Using ADMA mode
[   25.967759] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   25.968755] scsi2 : sata_nv
[   25.969238] scsi3 : sata_nv
[   25.969361] ata3: SATA max UDMA/133 cmd 0x2440 ctl 0x2430 bmdma 0x2400 irq 20
[   25.969364] ata4: SATA max UDMA/133 cmd 0x2420 ctl 0x2410 bmdma 0x2408 irq 20
[   26.457220] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   26.637224] ata3.00: ATAPI: HL-DT-ST DVD-ROM DH20N, A102, max UDMA/100
[   26.837154] ata3.00: configured for UDMA/100
[   27.166935] ata4: SATA link down (SStatus 0 SControl 300)
[   27.171411] scsi 2:0:0:0: CD-ROM            HL-DT-ST DVD-ROM DH20N    A102 PQ: 0 ANSI: 5
[   27.171418] ata3: bounce limit 0xFFFFFFFF, segment boundary 0xFFFF, hw segs 127
[   27.185402] Driver 'sd' needs updating - please use bus_type methods
[   27.186241] sd 0:0:0:0: [sda] 312500000 512-byte hardware sectors (160000 MB)
[   27.186253] sd 0:0:0:0: [sda] Write Protect is off
[   27.186255] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   27.186267] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   27.186313] sd 0:0:0:0: [sda] 312500000 512-byte hardware sectors (160000 MB)
[   27.186320] sd 0:0:0:0: [sda] Write Protect is off
[   27.186322] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   27.186334] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   27.186338]  sda:<4>Driver 'sr' needs updating - please use bus_type methods
[   27.198344]  sda1 sda2 sda3
[   27.199577] sd 0:0:0:0: [sda] Attached SCSI disk
[   27.208645] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   27.208665] sr 2:0:0:0: Attached scsi generic sg1 type 5
[   27.227824] sr0: scsi3-mmc drive: 12x/48x cd/rw xa/form2 cdda tray
[   27.227830] Uniform CD-ROM driver Revision: 3.20
[   27.227885] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   27.452600] Attempting manual resume
[   27.452604] swsusp: Resume From Partition 8:1
[   27.452605] PM: Checking swsusp image.
[   27.452794] PM: Resume from disk failed.
[   27.480474] kjournald starting.  Commit interval 5 seconds
[   27.480493] EXT3-fs: mounted filesystem with ordered data mode.
[   30.015970] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   30.026047] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   30.096055] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x2040
[   30.096073] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x2000
[   30.118981] input: PC Speaker as /devices/platform/pcspkr/input/input1
[   30.223725] ck804xrom ck804xrom_init_one(): Unable to register resource 0x00000000ffb00000-0x00000000ffffffff - kernel bug?
[   30.269969] CFI: Found no ck804xrom @ffc00000 device at location zero
[   30.308141] JEDEC: Found no ck804xrom @ffc00000 device at location zero
[   30.308202] CFI: Found no ck804xrom @ffc00000 device at location zero
[   30.308638] JEDEC: Found no ck804xrom @ffc00000 device at location zero
[   30.308665] CFI: Found no ck804xrom @ffc00000 device at location zero
[   30.308842] JEDEC: Found no ck804xrom @ffc00000 device at location zero
[   30.308895] CFI: Found no ck804xrom @ffc10000 device at location zero
[   30.309330] JEDEC: Found no ck804xrom @ffc10000 device at location zero
[   30.309386] CFI: Found no ck804xrom @ffc10000 device at location zero
[   30.309823] JEDEC: Found no ck804xrom @ffc10000 device at location zero
[   30.309849] CFI: Found no ck804xrom @ffc10000 device at location zero
[   30.310025] JEDEC: Found no ck804xrom @ffc10000 device at location zero
[   30.310077] CFI: Found no ck804xrom @ffc20000 device at location zero
[   30.310512] JEDEC: Found no ck804xrom @ffc20000 device at location zero
[   30.310568] CFI: Found no ck804xrom @ffc20000 device at location zero
[   30.311004] JEDEC: Found no ck804xrom @ffc20000 device at location zero
[   30.311030] CFI: Found no ck804xrom @ffc20000 device at location zero
[   30.311207] JEDEC: Found no ck804xrom @ffc20000 device at location zero
[   30.311258] CFI: Found no ck804xrom @ffc30000 device at location zero
[   30.311693] JEDEC: Found no ck804xrom @ffc30000 device at location zero
[   30.311749] CFI: Found no ck804xrom @ffc30000 device at location zero
[   30.312186] JEDEC: Found no ck804xrom @ffc30000 device at location zero
[   30.312212] CFI: Found no ck804xrom @ffc30000 device at location zero
[   30.312388] JEDEC: Found no ck804xrom @ffc30000 device at location zero
[   30.312439] CFI: Found no ck804xrom @ffc40000 device at location zero
[   30.312874] JEDEC: Found no ck804xrom @ffc40000 device at location zero
[   30.312930] CFI: Found no ck804xrom @ffc40000 device at location zero
[   30.313367] JEDEC: Found no ck804xrom @ffc40000 device at location zero
[   30.313393] CFI: Found no ck804xrom @ffc40000 device at location zero
[   30.313569] JEDEC: Found no ck804xrom @ffc40000 device at location zero
[   30.313620] CFI: Found no ck804xrom @ffc50000 device at location zero
[   30.314055] JEDEC: Found no ck804xrom @ffc50000 device at location zero
[   30.314112] CFI: Found no ck804xrom @ffc50000 device at location zero
[   30.314548] JEDEC: Found no ck804xrom @ffc50000 device at location zero
[   30.314574] CFI: Found no ck804xrom @ffc50000 device at location zero
[   30.314751] JEDEC: Found no ck804xrom @ffc50000 device at location zero
[   30.314802] CFI: Found no ck804xrom @ffc60000 device at location zero
[   30.315237] JEDEC: Found no ck804xrom @ffc60000 device at location zero
[   30.315293] CFI: Found no ck804xrom @ffc60000 device at location zero
[   30.315730] JEDEC: Found no ck804xrom @ffc60000 device at location zero
[   30.315756] CFI: Found no ck804xrom @ffc60000 device at location zero
[   30.315932] JEDEC: Found no ck804xrom @ffc60000 device at location zero
[   30.315983] CFI: Found no ck804xrom @ffc70000 device at location zero
[   30.316431] JEDEC: Found no ck804xrom @ffc70000 device at location zero
[   30.316487] CFI: Found no ck804xrom @ffc70000 device at location zero
[   30.316923] JEDEC: Found no ck804xrom @ffc70000 device at location zero
[   30.316949] CFI: Found no ck804xrom @ffc70000 device at location zero
[   30.317125] JEDEC: Found no ck804xrom @ffc70000 device at location zero
[   30.317177] CFI: Found no ck804xrom @ffc80000 device at location zero
[   30.317612] JEDEC: Found no ck804xrom @ffc80000 device at location zero
[   30.317668] CFI: Found no ck804xrom @ffc80000 device at location zero
[   30.318105] JEDEC: Found no ck804xrom @ffc80000 device at location zero
[   30.318131] CFI: Found no ck804xrom @ffc80000 device at location zero
[   30.318308] JEDEC: Found no ck804xrom @ffc80000 device at location zero
[   30.318360] CFI: Found no ck804xrom @ffc90000 device at location zero
[   30.318797] JEDEC: Found no ck804xrom @ffc90000 device at location zero
[   30.318853] CFI: Found no ck804xrom @ffc90000 device at location zero
[   30.319289] JEDEC: Found no ck804xrom @ffc90000 device at location zero
[   30.319315] CFI: Found no ck804xrom @ffc90000 device at location zero
[   30.319492] JEDEC: Found no ck804xrom @ffc90000 device at location zero
[   30.319543] CFI: Found no ck804xrom @ffca0000 device at location zero
[   30.319978] JEDEC: Found no ck804xrom @ffca0000 device at location zero
[   30.320034] CFI: Found no ck804xrom @ffca0000 device at location zero
[   30.320471] JEDEC: Found no ck804xrom @ffca0000 device at location zero
[   30.320497] CFI: Found no ck804xrom @ffca0000 device at location zero
[   30.320673] JEDEC: Found no ck804xrom @ffca0000 device at location zero
[   30.320724] CFI: Found no ck804xrom @ffcb0000 device at location zero
[   30.321159] JEDEC: Found no ck804xrom @ffcb0000 device at location zero
[   30.321216] CFI: Found no ck804xrom @ffcb0000 device at location zero
[   30.321652] JEDEC: Found no ck804xrom @ffcb0000 device at location zero
[   30.321678] CFI: Found no ck804xrom @ffcb0000 device at location zero
[   30.321854] JEDEC: Found no ck804xrom @ffcb0000 device at location zero
[   30.321906] CFI: Found no ck804xrom @ffcc0000 device at location zero
[   30.322341] JEDEC: Found no ck804xrom @ffcc0000 device at location zero
[   30.322397] CFI: Found no ck804xrom @ffcc0000 device at location zero
[   30.322833] JEDEC: Found no ck804xrom @ffcc0000 device at location zero
[   30.322859] CFI: Found no ck804xrom @ffcc0000 device at location zero
[   30.323036] JEDEC: Found no ck804xrom @ffcc0000 device at location zero
[   30.323087] CFI: Found no ck804xrom @ffcd0000 device at location zero
[   30.323522] JEDEC: Found no ck804xrom @ffcd0000 device at location zero
[   30.323578] CFI: Found no ck804xrom @ffcd0000 device at location zero
[   30.324015] JEDEC: Found no ck804xrom @ffcd0000 device at location zero
[   30.324041] CFI: Found no ck804xrom @ffcd0000 device at location zero
[   30.324217] JEDEC: Found no ck804xrom @ffcd0000 device at location zero
[   30.324269] CFI: Found no ck804xrom @ffce0000 device at location zero
[   30.324704] JEDEC: Found no ck804xrom @ffce0000 device at location zero
[   30.324760] CFI: Found no ck804xrom @ffce0000 device at location zero
[   30.325196] JEDEC: Found no ck804xrom @ffce0000 device at location zero
[   30.325222] CFI: Found no ck804xrom @ffce0000 device at location zero
[   30.325398] JEDEC: Found no ck804xrom @ffce0000 device at location zero
[   30.325450] CFI: Found no ck804xrom @ffcf0000 device at location zero
[   30.325885] JEDEC: Found no ck804xrom @ffcf0000 device at location zero
[   30.325941] CFI: Found no ck804xrom @ffcf0000 device at location zero
[   30.326381] JEDEC: Found no ck804xrom @ffcf0000 device at location zero
[   30.326407] CFI: Found no ck804xrom @ffcf0000 device at location zero
[   30.326583] JEDEC: Found no ck804xrom @ffcf0000 device at location zero
[   30.326635] CFI: Found no ck804xrom @ffd00000 device at location zero
[   30.327070] JEDEC: Found no ck804xrom @ffd00000 device at location zero
[   30.327126] CFI: Found no ck804xrom @ffd00000 device at location zero
[   30.327564] JEDEC: Found no ck804xrom @ffd00000 device at location zero
[   30.327590] CFI: Found no ck804xrom @ffd00000 device at location zero
[   30.327766] JEDEC: Found no ck804xrom @ffd00000 device at location zero
[   30.327818] CFI: Found no ck804xrom @ffd10000 device at location zero
[   30.328253] JEDEC: Found no ck804xrom @ffd10000 device at location zero
[   30.328310] CFI: Found no ck804xrom @ffd10000 device at location zero
[   30.328749] JEDEC: Found no ck804xrom @ffd10000 device at location zero
[   30.328776] CFI: Found no ck804xrom @ffd10000 device at location zero
[   30.328952] JEDEC: Found no ck804xrom @ffd10000 device at location zero
[   30.329003] CFI: Found no ck804xrom @ffd20000 device at location zero
[   30.329438] JEDEC: Found no ck804xrom @ffd20000 device at location zero
[   30.329495] CFI: Found no ck804xrom @ffd20000 device at location zero
[   30.329935] JEDEC: Found no ck804xrom @ffd20000 device at location zero
[   30.329962] CFI: Found no ck804xrom @ffd20000 device at location zero
[   30.330140] JEDEC: Found no ck804xrom @ffd20000 device at location zero
[   30.330193] CFI: Found no ck804xrom @ffd30000 device at location zero
[   30.330634] JEDEC: Found no ck804xrom @ffd30000 device at location zero
[   30.330691] CFI: Found no ck804xrom @ffd30000 device at location zero
[   30.331130] JEDEC: Found no ck804xrom @ffd30000 device at location zero
[   30.331156] CFI: Found no ck804xrom @ffd30000 device at location zero
[   30.331332] JEDEC: Found no ck804xrom @ffd30000 device at location zero
[   30.331384] CFI: Found no ck804xrom @ffd40000 device at location zero
[   30.331819] JEDEC: Found no ck804xrom @ffd40000 device at location zero
[   30.331876] CFI: Found no ck804xrom @ffd40000 device at location zero
[   30.332313] JEDEC: Found no ck804xrom @ffd40000 device at location zero
[   30.332338] CFI: Found no ck804xrom @ffd40000 device at location zero
[   30.332515] JEDEC: Found no ck804xrom @ffd40000 device at location zero
[   30.332567] CFI: Found no ck804xrom @ffd50000 device at location zero
[   30.333002] JEDEC: Found no ck804xrom @ffd50000 device at location zero
[   30.333058] CFI: Found no ck804xrom @ffd50000 device at location zero
[   30.333494] JEDEC: Found no ck804xrom @ffd50000 device at location zero
[   30.333521] CFI: Found no ck804xrom @ffd50000 device at location zero
[   30.333697] JEDEC: Found no ck804xrom @ffd50000 device at location zero
[   30.333749] CFI: Found no ck804xrom @ffd60000 device at location zero
[   30.334184] JEDEC: Found no ck804xrom @ffd60000 device at location zero
[   30.334241] CFI: Found no ck804xrom @ffd60000 device at location zero
[   30.334678] JEDEC: Found no ck804xrom @ffd60000 device at location zero
[   30.334704] CFI: Found no ck804xrom @ffd60000 device at location zero
[   30.334880] JEDEC: Found no ck804xrom @ffd60000 device at location zero
[   30.334932] CFI: Found no ck804xrom @ffd70000 device at location zero
[   30.335367] JEDEC: Found no ck804xrom @ffd70000 device at location zero
[   30.335423] CFI: Found no ck804xrom @ffd70000 device at location zero
[   30.335860] JEDEC: Found no ck804xrom @ffd70000 device at location zero
[   30.335887] CFI: Found no ck804xrom @ffd70000 device at location zero
[   30.336063] JEDEC: Found no ck804xrom @ffd70000 device at location zero
[   30.336115] CFI: Found no ck804xrom @ffd80000 device at location zero
[   30.336553] JEDEC: Found no ck804xrom @ffd80000 device at location zero
[   30.336609] CFI: Found no ck804xrom @ffd80000 device at location zero
[   30.337046] JEDEC: Found no ck804xrom @ffd80000 device at location zero
[   30.337072] CFI: Found no ck804xrom @ffd80000 device at location zero
[   30.337248] JEDEC: Found no ck804xrom @ffd80000 device at location zero
[   30.337300] CFI: Found no ck804xrom @ffd90000 device at location zero
[   30.337735] JEDEC: Found no ck804xrom @ffd90000 device at location zero
[   30.337791] CFI: Found no ck804xrom @ffd90000 device at location zero
[   30.338229] JEDEC: Found no ck804xrom @ffd90000 device at location zero
[   30.338255] CFI: Found no ck804xrom @ffd90000 device at location zero
[   30.338432] JEDEC: Found no ck804xrom @ffd90000 device at location zero
[   30.338484] CFI: Found no ck804xrom @ffda0000 device at location zero
[   30.338920] JEDEC: Found no ck804xrom @ffda0000 device at location zero
[   30.338977] CFI: Found no ck804xrom @ffda0000 device at location zero
[   30.339413] JEDEC: Found no ck804xrom @ffda0000 device at location zero
[   30.339439] CFI: Found no ck804xrom @ffda0000 device at location zero
[   30.339615] JEDEC: Found no ck804xrom @ffda0000 device at location zero
[   30.339666] CFI: Found no ck804xrom @ffdb0000 device at location zero
[   30.340101] JEDEC: Found no ck804xrom @ffdb0000 device at location zero
[   30.340158] CFI: Found no ck804xrom @ffdb0000 device at location zero
[   30.340594] JEDEC: Found no ck804xrom @ffdb0000 device at location zero
[   30.340620] CFI: Found no ck804xrom @ffdb0000 device at location zero
[   30.340796] JEDEC: Found no ck804xrom @ffdb0000 device at location zero
[   30.340848] CFI: Found no ck804xrom @ffdc0000 device at location zero
[   30.341282] JEDEC: Found no ck804xrom @ffdc0000 device at location zero
[   30.341339] CFI: Found no ck804xrom @ffdc0000 device at location zero
[   30.341775] JEDEC: Found no ck804xrom @ffdc0000 device at location zero
[   30.341801] CFI: Found no ck804xrom @ffdc0000 device at location zero
[   30.341977] JEDEC: Found no ck804xrom @ffdc0000 device at location zero
[   30.342029] CFI: Found no ck804xrom @ffdd0000 device at location zero
[   30.342464] JEDEC: Found no ck804xrom @ffdd0000 device at location zero
[   30.342520] CFI: Found no ck804xrom @ffdd0000 device at location zero
[   30.342959] JEDEC: Found no ck804xrom @ffdd0000 device at location zero
[   30.342985] CFI: Found no ck804xrom @ffdd0000 device at location zero
[   30.343161] JEDEC: Found no ck804xrom @ffdd0000 device at location zero
[   30.343213] CFI: Found no ck804xrom @ffde0000 device at location zero
[   30.343648] JEDEC: Found no ck804xrom @ffde0000 device at location zero
[   30.343704] CFI: Found no ck804xrom @ffde0000 device at location zero
[   30.344140] JEDEC: Found no ck804xrom @ffde0000 device at location zero
[   30.344166] CFI: Found no ck804xrom @ffde0000 device at location zero
[   30.344343] JEDEC: Found no ck804xrom @ffde0000 device at location zero
[   30.344394] CFI: Found no ck804xrom @ffdf0000 device at location zero
[   30.344829] JEDEC: Found no ck804xrom @ffdf0000 device at location zero
[   30.344885] CFI: Found no ck804xrom @ffdf0000 device at location zero
[   30.345322] JEDEC: Found no ck804xrom @ffdf0000 device at location zero
[   30.345348] CFI: Found no ck804xrom @ffdf0000 device at location zero
[   30.345524] JEDEC: Found no ck804xrom @ffdf0000 device at location zero
[   30.345576] CFI: Found no ck804xrom @ffe00000 device at location zero
[   30.346011] JEDEC: Found no ck804xrom @ffe00000 device at location zero
[   30.346067] CFI: Found no ck804xrom @ffe00000 device at location zero
[   30.346506] JEDEC: Found no ck804xrom @ffe00000 device at location zero
[   30.346532] CFI: Found no ck804xrom @ffe00000 device at location zero
[   30.346708] JEDEC: Found no ck804xrom @ffe00000 device at location zero
[   30.346760] CFI: Found no ck804xrom @ffe10000 device at location zero
[   30.347195] JEDEC: Found no ck804xrom @ffe10000 device at location zero
[   30.347251] CFI: Found no ck804xrom @ffe10000 device at location zero
[   30.347689] JEDEC: Found no ck804xrom @ffe10000 device at location zero
[   30.347715] CFI: Found no ck804xrom @ffe10000 device at location zero
[   30.347892] JEDEC: Found no ck804xrom @ffe10000 device at location zero
[   30.347944] CFI: Found no ck804xrom @ffe20000 device at location zero
[   30.348379] JEDEC: Found no ck804xrom @ffe20000 device at location zero
[   30.348435] CFI: Found no ck804xrom @ffe20000 device at location zero
[   30.348873] JEDEC: Found no ck804xrom @ffe20000 device at location zero
[   30.348899] CFI: Found no ck804xrom @ffe20000 device at location zero
[   30.349075] JEDEC: Found no ck804xrom @ffe20000 device at location zero
[   30.349127] CFI: Found no ck804xrom @ffe30000 device at location zero
[   30.349562] JEDEC: Found no ck804xrom @ffe30000 device at location zero
[   30.349618] CFI: Found no ck804xrom @ffe30000 device at location zero
[   30.350054] JEDEC: Found no ck804xrom @ffe30000 device at location zero
[   30.350080] CFI: Found no ck804xrom @ffe30000 device at location zero
[   30.350256] JEDEC: Found no ck804xrom @ffe30000 device at location zero
[   30.350308] CFI: Found no ck804xrom @ffe40000 device at location zero
[   30.350743] JEDEC: Found no ck804xrom @ffe40000 device at location zero
[   30.350799] CFI: Found no ck804xrom @ffe40000 device at location zero
[   30.351235] JEDEC: Found no ck804xrom @ffe40000 device at location zero
[   30.351261] CFI: Found no ck804xrom @ffe40000 device at location zero
[   30.351438] JEDEC: Found no ck804xrom @ffe40000 device at location zero
[   30.351489] CFI: Found no ck804xrom @ffe50000 device at location zero
[   30.351924] JEDEC: Found no ck804xrom @ffe50000 device at location zero
[   30.351980] CFI: Found no ck804xrom @ffe50000 device at location zero
[   30.352417] JEDEC: Found no ck804xrom @ffe50000 device at location zero
[   30.352443] CFI: Found no ck804xrom @ffe50000 device at location zero
[   30.352619] JEDEC: Found no ck804xrom @ffe50000 device at location zero
[   30.352670] CFI: Found no ck804xrom @ffe60000 device at location zero
[   30.353105] JEDEC: Found no ck804xrom @ffe60000 device at location zero
[   30.353162] CFI: Found no ck804xrom @ffe60000 device at location zero
[   30.353598] JEDEC: Found no ck804xrom @ffe60000 device at location zero
[   30.353624] CFI: Found no ck804xrom @ffe60000 device at location zero
[   30.353801] JEDEC: Found no ck804xrom @ffe60000 device at location zero
[   30.353852] CFI: Found no ck804xrom @ffe70000 device at location zero
[   30.354287] JEDEC: Found no ck804xrom @ffe70000 device at location zero
[   30.354343] CFI: Found no ck804xrom @ffe70000 device at location zero
[   30.354780] JEDEC: Found no ck804xrom @ffe70000 device at location zero
[   30.354806] CFI: Found no ck804xrom @ffe70000 device at location zero
[   30.354982] JEDEC: Found no ck804xrom @ffe70000 device at location zero
[   30.355034] CFI: Found no ck804xrom @ffe80000 device at location zero
[   30.355469] JEDEC: Found no ck804xrom @ffe80000 device at location zero
[   30.355525] CFI: Found no ck804xrom @ffe80000 device at location zero
[   30.355961] JEDEC: Found no ck804xrom @ffe80000 device at location zero
[   30.355987] CFI: Found no ck804xrom @ffe80000 device at location zero
[   30.356164] JEDEC: Found no ck804xrom @ffe80000 device at location zero
[   30.356215] CFI: Found no ck804xrom @ffe90000 device at location zero
[   30.356653] JEDEC: Found no ck804xrom @ffe90000 device at location zero
[   30.356709] CFI: Found no ck804xrom @ffe90000 device at location zero
[   30.357147] JEDEC: Found no ck804xrom @ffe90000 device at location zero
[   30.357173] CFI: Found no ck804xrom @ffe90000 device at location zero
[   30.357349] JEDEC: Found no ck804xrom @ffe90000 device at location zero
[   30.357400] CFI: Found no ck804xrom @ffea0000 device at location zero
[   30.357835] JEDEC: Found no ck804xrom @ffea0000 device at location zero
[   30.357891] CFI: Found no ck804xrom @ffea0000 device at location zero
[   30.358329] JEDEC: Found no ck804xrom @ffea0000 device at location zero
[   30.358355] CFI: Found no ck804xrom @ffea0000 device at location zero
[   30.358532] JEDEC: Found no ck804xrom @ffea0000 device at location zero
[   30.358583] CFI: Found no ck804xrom @ffeb0000 device at location zero
[   30.359020] JEDEC: Found no ck804xrom @ffeb0000 device at location zero
[   30.359077] CFI: Found no ck804xrom @ffeb0000 device at location zero
[   30.359513] JEDEC: Found no ck804xrom @ffeb0000 device at location zero
[   30.359539] CFI: Found no ck804xrom @ffeb0000 device at location zero
[   30.359715] JEDEC: Found no ck804xrom @ffeb0000 device at location zero
[   30.359766] CFI: Found no ck804xrom @ffec0000 device at location zero
[   30.360201] JEDEC: Found no ck804xrom @ffec0000 device at location zero
[   30.360258] CFI: Found no ck804xrom @ffec0000 device at location zero
[   30.360694] JEDEC: Found no ck804xrom @ffec0000 device at location zero
[   30.360720] CFI: Found no ck804xrom @ffec0000 device at location zero
[   30.360896] JEDEC: Found no ck804xrom @ffec0000 device at location zero
[   30.360947] CFI: Found no ck804xrom @ffed0000 device at location zero
[   30.361382] JEDEC: Found no ck804xrom @ffed0000 device at location zero
[   30.361439] CFI: Found no ck804xrom @ffed0000 device at location zero
[   30.361874] JEDEC: Found no ck804xrom @ffed0000 device at location zero
[   30.361901] CFI: Found no ck804xrom @ffed0000 device at location zero
[   30.362077] JEDEC: Found no ck804xrom @ffed0000 device at location zero
[   30.362128] CFI: Found no ck804xrom @ffee0000 device at location zero
[   30.362560] JEDEC: Found no ck804xrom @ffee0000 device at location zero
[   30.362616] CFI: Found no ck804xrom @ffee0000 device at location zero
[   30.363051] JEDEC: Found no ck804xrom @ffee0000 device at location zero
[   30.363077] CFI: Found no ck804xrom @ffee0000 device at location zero
[   30.363253] JEDEC: Found no ck804xrom @ffee0000 device at location zero
[   30.363305] CFI: Found no ck804xrom @ffef0000 device at location zero
[   30.363730] JEDEC: Found no ck804xrom @ffef0000 device at location zero
[   30.363786] CFI: Found no ck804xrom @ffef0000 device at location zero
[   30.364217] JEDEC: Found no ck804xrom @ffef0000 device at location zero
[   30.364243] CFI: Found no ck804xrom @ffef0000 device at location zero
[   30.364419] JEDEC: Found no ck804xrom @ffef0000 device at location zero
[   30.364484] CFI: Found no ck804xrom @fff00000 device at location zero
[   30.364916] JEDEC: Found no ck804xrom @fff00000 device at location zero
[   30.364976] CFI: Found no ck804xrom @fff00000 device at location zero
[   30.365388] JEDEC: Found no ck804xrom @fff00000 device at location zero
[   30.365411] CFI: Found no ck804xrom @fff00000 device at location zero
[   30.365459] Found: SST 49LF080A
[   30.365467] ck804xrom @fff00000: Found 1 x8 devices at 0x0 in 8-bit bank
[   30.383661] input: Power Button (FF) as /devices/virtual/input/input2
[   30.415825] ACPI: Power Button (FF) [PWRF]
[   30.415905] input: Power Button (CM) as /devices/virtual/input/input3
[   30.467027] number of JEDEC chips: 1
[   30.467032] cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
[   30.485684] ACPI: Power Button (CM) [PWRB]
[   30.797870] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   32.280888] loop: module loaded
[   32.329852] lp: driver loaded but no devices found
[   32.379708] tg3: eth0: Link is up at 100 Mbps, full duplex.
[   32.379712] tg3: eth0: Flow control is on for TX and on for RX.
[   32.604728] Adding 1951856k swap on /dev/sda1.  Priority:-1 extents:1 across:1951856k
[   32.905677] EXT3 FS on sda3, internal journal
[   33.274084] kjournald starting.  Commit interval 5 seconds
[   33.274284] EXT3 FS on sda2, internal journal
[   33.274288] EXT3-fs: mounted filesystem with ordered data mode.
[   33.818991] ip_tables: (C) 2000-2006 Netfilter Core Team
[   35.902896] audit(1268792973.626:2): type=1503 operation="capable" name="sys_resource" pid=4339 profile="/usr/sbin/named" namespace="default"
[   40.952066] NET: Registered protocol family 17

