From: =?ISO-8859-1?Q?J=FCrgen_L=FCters?=
	<jlueters@intranet-engineering.de>
Subject: acpi information - as you have requested  in dmesg
Date: Sat, 26 Jul 2008 15:20:14 +0200
Message-ID: <1217078414.2211.1.camel@siddomu.ie-office.test>
Reply-To: jlueters@intranet-engineering.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-c2loxJSkVnWsEwq49+Bz"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bitz180.bitz.briteline.de ([195.90.9.180]:56400 "EHLO
	srv01.intranet-engineering.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751865AbYGZNsq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Jul 2008 09:48:46 -0400
Received: from nx.intranet-engineering.de (loghost.ie-office.test [192.168.2.70])
	by srv01.intranet-engineering.de (Postfix) with ESMTP id 35AD31BD66
	for <linux-acpi@vger.kernel.org>; Sat, 26 Jul 2008 15:20:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by nx.intranet-engineering.de (Postfix) with ESMTP id D6126471B4
	for <linux-acpi@vger.kernel.org>; Sat, 26 Jul 2008 15:20:16 +0200 (CEST)
Received: from nx.intranet-engineering.de ([127.0.0.1])
	by localhost (dbserver.ie-office.test [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BStNA0t5tGXo for <linux-acpi@vger.kernel.org>;
	Sat, 26 Jul 2008 15:20:16 +0200 (CEST)
Received: from [192.168.2.7] (siddomu.ie-office.test [192.168.2.7])
	by nx.intranet-engineering.de (Postfix) with ESMTP id 11935470E2
	for <linux-acpi@vger.kernel.org>; Sat, 26 Jul 2008 15:20:15 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-c2loxJSkVnWsEwq49+Bz
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Kind Regards

-- 
Jürgen Lüters 

--=-c2loxJSkVnWsEwq49+Bz
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Linux version 2.6.25-2-686 (Debian 2.6.25-7) (maks@debian.org) (gcc version 4.1.3 20080623 (prerelease) (Debian 4.1.2-23)) #1 SMP Fri Jul 18 17:46:56 UTC 2008
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f670000 (usable)
[    0.000000]  BIOS-e820: 000000003f670000 - 000000003f700000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] 118MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] Scan SMP from c0000000 for 1024 bytes.
[    0.000000] Scan SMP from c009fc00 for 1024 bytes.
[    0.000000] Scan SMP from c00f0000 for 65536 bytes.
[    0.000000] found SMP MP-table at [c00f8230] 000f8230
[    0.000000] Entering add_active_range(0, 0, 259696) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   259696
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   259696
[    0.000000] On node 0 totalpages: 259696
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 236 pages used for memmap
[    0.000000]   HighMem zone: 30084 pages, LIFO batch:7
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP 000F8200, 0014 (r0 MATBIO)
[    0.000000] ACPI: RSDT 3F67F4B9, 0044 (r1 MATBIO CFT5W-3   6040000 MEI         0)
[    0.000000] ACPI: FACP 3F686CD0, 0084 (r2 MATBIO CFT5W-3   6040000 MEI        5A)
[    0.000000] ACPI: DSDT 3F67FE46, 6E8A (r1 MATBIO  CFT5W-3  6040000 MSFT  3000000)
[    0.000000] ACPI: FACS 3F687FC0, 0040
[    0.000000] ACPI: HPET 3F686D54, 0038 (r1 MATBIO CFT5W-3   6040000 MEI        5A)
[    0.000000] ACPI: SLIC 3F686D8C, 0176 (r1 MATBIO CFT5W-3   6040000 MEI         0)
[    0.000000] ACPI: APIC 3F686F02, 0068 (r1 MATBIO CFT5W-3   6040000 MEI         0)
[    0.000000] ACPI: MCFG 3F686F6A, 003C (r1 MATBIO CFT5W-3   6040000 MEI         0)
[    0.000000] ACPI: BOOT 3F686FA6, 0028 (r1 MATBIO CFT5W-3   6040000 MEI         1)
[    0.000000] ACPI: TCPA 3F686FCE, 0032 (r1 MATBIO CFT5W-3   6040000 MEI         1)
[    0.000000] ACPI: SSDT 3F67F4FD, 04F6 (r1 MATBIO CFT5W-3      3000 MEI  20050624)
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:14 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 6:14 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 0000000000100000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257668
[    0.000000] Kernel command line: root=/dev/mapper/hda1_crypt ro quiet
[    0.000000] mapped APIC to ffffb000 (fee00000)
[    0.000000] mapped IOAPIC to ffffa000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1064.029 MHz processor.
[    0.001838] Console: colour VGA+ 80x25
[    0.001843] console [tty0] enabled
[    0.002180] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.002708] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.004000] Memory: 1018992k/1038784k available (1753k kernel code, 19032k reserved, 728k data, 252k init, 121280k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xfff4c000 - 0xfffff000   ( 716 kB)
[    0.004000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.004000]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.004000]       .init : 0xc0375000 - 0xc03b4000   ( 252 kB)
[    0.004000]       .data : 0xc02b649a - 0xc036c640   ( 728 kB)
[    0.004000]       .text : 0xc0100000 - 0xc02b649a   (1753 kB)
[    0.004000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.004000] hpet clockevent registered
[    0.080009] Calibrating delay using timer specific routine.. 2131.13 BogoMIPS (lpj=4262264)
[    0.080068] Security Framework initialized
[    0.080076] SELinux:  Disabled at boot.
[    0.080081] Capability LSM initialized
[    0.080105] Mount-cache hash table entries: 512
[    0.080299] Initializing cgroup subsys ns
[    0.080305] Initializing cgroup subsys cpuacct
[    0.080332] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.080336] CPU: L2 cache: 2048K
[    0.080340] CPU: Physical Processor ID: 0
[    0.080343] CPU: Processor Core ID: 0
[    0.080348] Intel machine check architecture supported.
[    0.080358] Intel machine check reporting enabled on CPU#0.
[    0.080361] using mwait in idle threads.
[    0.080366] Compat vDSO mapped to ffffe000.
[    0.080375] Checking 'hlt' instruction... OK.
[    0.098099] ACPI: Core revision 20070126
[    0.112065] CPU0: Intel(R) Core(TM) Duo CPU      U2400  @ 1.06GHz stepping 0c
[    0.112093] Booting processor 1/1 ip 4000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 2128.05 BogoMIPS (lpj=4256111)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 2048K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] Intel machine check architecture supported.
[    0.004000] Intel machine check reporting enabled on CPU#1.
[    0.204819] CPU1: Intel(R) Core(TM) Duo CPU      U2400  @ 1.06GHz stepping 0c
[    0.204853] Total of 2 processors activated (4259.18 BogoMIPS).
[    0.205064] ENABLING IO-APIC IRQs
[    0.205287] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.248015] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.248030] Brought up 2 CPUs
[    0.248066] CPU0 attaching sched-domain:
[    0.248070]  domain 0: span 03
[    0.248074]   groups: 01 02
[    0.248080] CPU1 attaching sched-domain:
[    0.248083]  domain 0: span 03
[    0.248086]   groups: 02 01
[    0.248476] net_namespace: 548 bytes
[    0.248500] Booting paravirtualized kernel on bare hardware
[    0.248904] NET: Registered protocol family 16
[    0.249196] ACPI: bus type pci registered
[    0.249348] PCI: Using MMCONFIG for extended config space
[    0.249352] PCI: Using configuration type 1
[    0.249402] Setting up standard PCI resources
[    0.254240] ACPI: EC: Look up EC in DSDT
[    0.257586] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.264118] ACPI: BIOS _OSI(Linux) query ignored
[    0.264123] ACPI: DMI System Vendor: Matsushita Electric Industrial Co.,Ltd.
[    0.264127] ACPI: DMI Product Name: CF-T5MWKSZSG
[    0.264130] ACPI: DMI Product Version: 003
[    0.264133] ACPI: DMI Board Name: CFT5W-3
[    0.264136] ACPI: DMI BIOS Vendor: Phoenix Technologies Ltd.
[    0.264139] ACPI: DMI BIOS Date: 08/15/2007
[    0.264142] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[    0.264146] ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
[    0.272320] ACPI: BIOS _OSI(Linux) query ignored
[    0.272324] ACPI: DMI System Vendor: Matsushita Electric Industrial Co.,Ltd.
[    0.272328] ACPI: DMI Product Name: CF-T5MWKSZSG
[    0.272331] ACPI: DMI Product Version: 003
[    0.272334] ACPI: DMI Board Name: CFT5W-3
[    0.272337] ACPI: DMI BIOS Vendor: Phoenix Technologies Ltd.
[    0.272340] ACPI: DMI BIOS Date: 08/15/2007
[    0.272343] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[    0.272347] ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
[    0.273992] ACPI: Interpreter enabled
[    0.273997] ACPI: (supports S0 S3 S4 S5)
[    0.274018] ACPI: Using IOAPIC for interrupt routing
[    0.291243] ACPI: EC: GPE = 0x1d, I/O: command/status = 0x66, data = 0x62
[    0.291248] ACPI: EC: driver started in interrupt mode
[    0.291320] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.292366] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.292374] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.293381] PCI: Transparent bridge - 0000:00:1e.0
[    0.293455] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.293745] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.293979] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.294220] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.298132] ACPI: PCI Interrupt Link [LNKA] (IRQs *5 6 7 10 11)
[    0.298296] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 10 *11)
[    0.298456] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 6 *7 10 11)
[    0.298614] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11)
[    0.298773] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 6 7 10 *11)
[    0.298935] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 7 10 11) *0, disabled.
[    0.299097] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 6 7 10 *11)
[    0.299255] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 *10 11)
[    0.299569] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.299629] pnp: PnP ACPI init
[    0.299641] ACPI: bus type pnp registered
[    0.311069] pnp: PnP ACPI: found 12 devices
[    0.311073] ACPI: ACPI bus type pnp unregistered
[    0.311082] PnPBIOS: Disabled by ACPI PNP
[    0.311486] PCI: Using ACPI for IRQ routing
[    0.311490] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.316040] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.316047] hpet0: 3 64-bit timers, 14318180 Hz
[    0.317101] ACPI: RTC can wake from S4
[    0.324045] system 00:01: iomem range 0xce600-0xce7ff has been reserved
[    0.324051] system 00:01: iomem range 0xcf800-0xcffff has been reserved
[    0.324061] system 00:02: ioport range 0x900-0x91f has been reserved
[    0.324066] system 00:02: ioport range 0x92c-0x97f has been reserved
[    0.324071] system 00:02: ioport range 0xfe00-0xfe01 has been reserved
[    0.324077] system 00:02: iomem range 0xff000000-0xffffffff could not be reserved
[    0.324089] system 00:06: ioport range 0x800-0x80f has been reserved
[    0.324094] system 00:06: ioport range 0x1000-0x107f has been reserved
[    0.324099] system 00:06: ioport range 0x1180-0x11bf has been reserved
[    0.324105] system 00:06: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.324111] system 00:06: iomem range 0xfed14000-0xfed17fff could not be reserved
[    0.324116] system 00:06: iomem range 0xfed18000-0xfed18fff could not be reserved
[    0.324122] system 00:06: iomem range 0xfed19000-0xfed19fff could not be reserved
[    0.324127] system 00:06: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[    0.324133] system 00:06: iomem range 0xfed20000-0xfed3ffff could not be reserved
[    0.324138] system 00:06: iomem range 0xfed45000-0xfed8ffff could not be reserved
[    0.324144] system 00:06: iomem range 0xfef00000-0xfef03fff has been reserved
[    0.354887] PCI: Bridge: 0000:00:1c.0
[    0.354890]   IO window: disabled.
[    0.354899]   MEM window: disabled.
[    0.354905]   PREFETCH window: disabled.
[    0.354915] PCI: Bridge: 0000:00:1c.2
[    0.354918]   IO window: disabled.
[    0.354927]   MEM window: 0xd0000000-0xd00fffff
[    0.354933]   PREFETCH window: disabled.
[    0.354947] PCI: Bus 5, cardbus bridge: 0000:04:05.0
[    0.354951]   IO window: 0x00002400-0x000024ff
[    0.354958]   IO window: 0x00002800-0x000028ff
[    0.354966]   PREFETCH window: 0x50000000-0x53ffffff
[    0.354973]   MEM window: 0x54000000-0x57ffffff
[    0.354980] PCI: Bridge: 0000:00:1e.0
[    0.354985]   IO window: 2000-2fff
[    0.354993]   MEM window: 0xd0100000-0xd01fffff
[    0.355001]   PREFETCH window: 0x0000000050000000-0x0000000053ffffff
[    0.355043] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[    0.355054] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.355086] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[    0.355096] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.355112] PCI: Enabling device 0000:00:1e.0 (0004 -> 0007)
[    0.355121] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.355144] ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 22 (level, low) -> IRQ 22
[    0.355195] NET: Registered protocol family 2
[    0.368119] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.368486] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.369648] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.370235] TCP: Hash tables configured (established 131072 bind 65536)
[    0.370239] TCP reno registered
[    0.376294] checking if image is initramfs...<7>Switched to high resolution mode on CPU 1
[    0.504040] Switched to high resolution mode on CPU 0
[    0.876010]  it is
[    1.411563] Freeing initrd memory: 6899k freed
[    1.411797] Simple Boot Flag at 0x46 set to 0x1
[    1.168296] audit: initializing netlink socket (disabled)
[    1.168322] type=2000 audit(1217074889.412:1): initialized
[    1.168549] highmem bounce pool size: 64 pages
[    1.168556] Total HugeTLB memory allocated, 0
[    1.168708] VFS: Disk quotas dquot_6.5.1
[    1.168754] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.168905] io scheduler noop registered
[    1.168909] io scheduler anticipatory registered
[    1.168912] io scheduler deadline registered
[    1.168934] io scheduler cfq registered (default)
[    1.168952] pci 0000:00:02.0: Boot video device
[    1.169220] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    1.169285] assign_interrupt_mode Found MSI capability
[    1.169348] Allocate Port Service[0000:00:1c.0:pcie00]
[    1.169423] Allocate Port Service[0000:00:1c.0:pcie02]
[    1.169494] Allocate Port Service[0000:00:1c.0:pcie03]
[    1.169649] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    1.169711] assign_interrupt_mode Found MSI capability
[    1.169771] Allocate Port Service[0000:00:1c.2:pcie00]
[    1.169845] Allocate Port Service[0000:00:1c.2:pcie02]
[    1.169912] Allocate Port Service[0000:00:1c.2:pcie03]
[    1.170493] isapnp: Scanning for PnP cards...
[    1.525031] isapnp: No Plug & Play device found
[    1.529730] hpet_resources: 0xfed00000 is busy
[    1.529830] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.531907] brd: module loaded
[    1.532057] PNP: PS/2 Controller [PNP0303:K101,PNP0f13:MOU3] at 0x60,0x64 irq 1,12
[    1.534983] i8042.c: Detected active multiplexing controller, rev 1.1.
[    1.536243] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.536251] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.536256] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.536260] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.536265] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.536471] mice: PS/2 mouse device common for all mice
[    1.536581] cpuidle: using governor ladder
[    1.536585] cpuidle: using governor menu
[    1.537253] TCP cubic registered
[    1.537268] NET: Registered protocol family 1
[    1.537285] NET: Registered protocol family 17
[    1.537296] Using IPI No-Shortcut mode
[    1.537549] registered taskstats version 1
[    1.537872] Freeing unused kernel memory: 252k freed
[    1.896128] input: AT Translated Set 2 keyboard as /class/input/input0
[    1.931973] ACPI: SSDT 3F67FC57, 0166 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
[    1.932404] ACPI: SSDT 3F67F9F3, 01DF (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
[    1.933174] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    1.933250] ACPI: ACPI0007:00 is registered as cooling_device0
[    1.933257] ACPI: Processor [CPU0] (supports 8 throttling states)
[    1.933758] ACPI: SSDT 3F67FDBD, 0089 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
[    1.934099] ACPI: SSDT 3F67FBD2, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
[    1.693916] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    1.693986] ACPI: ACPI0007:01 is registered as cooling_device1
[    1.693993] ACPI: Processor [CPU1] (supports 8 throttling states)
[    1.935141] Marking TSC unstable due to: TSC halts in idle.
[    2.039225] ACPI: LNXTHERM:01 is registered as thermal_zone0
[    2.040312] ACPI: Thermal Zone [TZ00] (60 C)
[    2.040343] ACPI: LNXTHERM:02 is registered as thermal_zone1
[    2.040984] ACPI: Thermal Zone [TZ01] (64 C)
[    2.356764] usbcore: registered new interface driver usbfs
[    2.356808] usbcore: registered new interface driver hub
[    2.356874] usbcore: registered new device driver usb
[    2.358733] USB Universal Host Controller Interface driver v3.0
[    2.358791] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[    2.358806] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    2.358812] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.358981] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    2.359022] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001820
[    2.359247] usb usb1: configuration #1 chosen from 1 choice
[    2.359289] hub 1-0:1.0: USB hub found
[    2.359300] hub 1-0:1.0: 2 ports detected
[    2.664623] Uniform Multi-Platform E-IDE driver
[    2.664631] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    2.674480] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[    2.463286] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    2.463293] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.463298] usb usb1: Product: UHCI Host Controller
[    2.463302] usb usb1: Manufacturer: Linux 2.6.25-2-686 uhci_hcd
[    2.463306] usb usb1: SerialNumber: 0000:00:1d.0
[    2.463369] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[    2.463387] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    2.463393] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.463432] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    2.463475] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001840
[    2.463648] usb usb2: configuration #1 chosen from 1 choice
[    2.463689] hub 2-0:1.0: USB hub found
[    2.463702] hub 2-0:1.0: 2 ports detected
[    2.464798] sdhci: Secure Digital Host Controller Interface driver
[    2.464802] sdhci: Copyright(c) Pierre Ossman
[    2.567297] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    2.567304] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.567309] usb usb2: Product: UHCI Host Controller
[    2.567313] usb usb2: Manufacturer: Linux 2.6.25-2-686 uhci_hcd
[    2.567317] usb usb2: SerialNumber: 0000:00:1d.1
[    2.567377] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[    2.567394] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    2.567401] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.567445] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    2.567492] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
[    2.567698] usb usb3: configuration #1 chosen from 1 choice
[    2.567738] hub 3-0:1.0: USB hub found
[    2.567750] hub 3-0:1.0: 2 ports detected
[    2.670104] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.670110] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.670115] usb usb3: Product: UHCI Host Controller
[    2.670119] usb usb3: Manufacturer: Linux 2.6.25-2-686 uhci_hcd
[    2.670123] usb usb3: SerialNumber: 0000:00:1d.2
[    2.670174] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
[    2.670194] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    2.670203] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.670246] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    2.670290] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001880
[    2.670464] usb usb4: configuration #1 chosen from 1 choice
[    2.670504] hub 4-0:1.0: USB hub found
[    2.670514] hub 4-0:1.0: 2 ports detected
[    2.704914] usb 1-2: new full speed USB device using uhci_hcd and address 2
[    2.776739] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.776744] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.776749] usb usb4: Product: UHCI Host Controller
[    2.776752] usb usb4: Manufacturer: Linux 2.6.25-2-686 uhci_hcd
[    2.776756] usb usb4: SerialNumber: 0000:00:1d.3
[    3.003577] 8139cp 0000:04:01.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
[    3.003577] 8139cp 0000:04:01.0: Try the "8139too" driver instead.
[    2.777471] sdhci: SDHCI controller found at 0000:04:05.1 [1180:0822] (rev 13)
[    2.777497] ACPI: PCI Interrupt 0000:04:05.1[B] -> GSI 20 (level, low) -> IRQ 20
[    2.777520] sdhc0:slot0: Will use DMA mode even though HW doesn't fully claim to support it.
[    2.780613] mmc0: SDHCI at 0xd0100400 irq 20 DMA
[    3.012206] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
[    3.012225] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    3.012232] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    3.012294] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    3.016207] ehci_hcd 0000:00:1d.7: debug port 1
[    3.016217] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[    3.016227] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0544000
[    3.025760] 8139too Fast Ethernet driver 0.9.28
[    3.067636] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    3.067817] usb usb5: configuration #1 chosen from 1 choice
[    3.067861] hub 5-0:1.0: USB hub found
[    3.067872] hub 5-0:1.0: 8 ports detected
[    3.167684] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    3.167691] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.167696] usb usb5: Product: EHCI Host Controller
[    3.167700] usb usb5: Manufacturer: Linux 2.6.25-2-686 ehci_hcd
[    3.167704] usb usb5: SerialNumber: 0000:00:1d.7
[    3.167820] ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 19 (level, low) -> IRQ 19
[    3.169163] eth0: RealTek RTL8139 at 0x2000, 00:0b:97:50:74:d3, IRQ 19
[    3.169167] eth0:  Identified 8139 chip type 'RTL-8101'
[    3.169337] ICH7: IDE controller (0x8086:0x27df rev 0x02) at  PCI slot 0000:00:1f.1
[    3.169348] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[    3.169358] ICH7: not 100% native mode: will probe irqs later
[    3.169373] ICH7: IDE port disabled
[    3.169382]     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:PIO
[    3.169397] Probing IDE interface ide0...
[    3.454840] hda: TOSHIBA MK6034GAX, ATA DISK drive
[    3.462465] usb 1-2: device not accepting address 2, error -71
[    3.518313] hub 1-0:1.0: unable to enumerate USB device on port 2
[    3.884594] hub 5-0:1.0: unable to enumerate USB device on port 2
[    4.067853] hub 5-0:1.0: unable to enumerate USB device on port 3
[    4.123575] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    4.123645] hda: UDMA/100 mode selected
[    4.123742] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.127405] No dock devices found.
[    4.140030] SCSI subsystem initialized
[    4.154761] libata version 3.00 loaded.
[    3.961307] hda: max request size: 512KiB
[    3.984672] hda: 117210240 sectors (60011 MB), CHS=16383/255/63
[    3.984793] hda: cache flushes supported
[    3.984854]  hda: hda1 hda2 hda3 hda4 < hda5 >
[    4.309243] usb 1-2: new full speed USB device using uhci_hcd and address 4
[    4.486164] device-mapper: uevent: version 1.0.3
[    4.486587] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
[    4.490392] usb 1-2: configuration #1 chosen from 1 choice
[    4.494556] usb 1-2: New USB device found, idVendor=0c24, idProduct=000e
[    4.494562] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.731404] usb 2-1: new low speed USB device using uhci_hcd and address 2
[    4.907078] usb 2-1: configuration #1 chosen from 1 choice
[    4.909390] usb 2-1: New USB device found, idVendor=0430, idProduct=0530
[    4.909396] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.909400] usb 2-1: Product: USB Touch Panel
[    4.909404] usb 2-1: Manufacturer: Fujitsu Component
[    4.952460] usbcore: registered new interface driver hiddev
[    4.967047] hiddev96hidraw0: USB HID v1.00 Device [Fujitsu Component USB Touch Panel] on usb-0000:00:1d.1-1
[    4.967047] usbcore: registered new interface driver usbhid
[    4.967047] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   18.212624] PM: Starting manual resume from disk
[   18.280655] kjournald starting.  Commit interval 5 seconds
[   18.280655] EXT3-fs: mounted filesystem with ordered data mode.
[   21.173727] Linux agpgart interface v0.103
[   21.221591] agpgart: Detected an Intel 945GM Chipset.
[   21.222478] agpgart: Detected 7932K stolen memory.
[   21.241091] agpgart: AGP aperture is 256M @ 0xc0000000
[   21.357055] input: Power Button (FF) as /class/input/input1
[   21.395734] ACPI: Power Button (FF) [PWRF]
[   21.395836] input: Lid Switch as /class/input/input2
[   21.437929] ACPI: Lid Switch [LID]
[   21.438045] input: Power Button (CM) as /class/input/input3
[   21.483750] ACPI: Power Button (CM) [PWRB]
[   21.487230] ACPI: AC Adapter [AC] (on-line)
[   21.952362] ACPI: Battery Slot [BATA] (battery present)
[   22.293558] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
[   22.293598] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   22.364541] ACPI: device:04 is registered as cooling_device2
[   22.365304] input: Video Bus as /class/input/input4
[   22.419803] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   22.491421] Bluetooth: Core ver 2.11
[   22.517303] NET: Registered protocol family 31
[   22.517308] Bluetooth: HCI device and connection manager initialized
[   22.517315] Bluetooth: HCI socket layer initialized
[   22.517502] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.2.23ks
[   22.517506] iwl3945: Copyright(c) 2003-2007 Intel Corporation
[   22.517649] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 18
[   22.517668] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   22.517695] iwl3945: Detected Intel PRO/Wireless 3945ABG Network Connection
[   22.701825] Bluetooth: HCI USB driver ver 2.9
[   22.705010] usbcore: registered new interface driver hci_usb
[   22.616775] iwl3945: Tunable channels: 13 802.11bg, 23 802.11a channels
[   22.643217] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   22.874259] intel_rng: FWH not detected
[   23.203581] input: PC Speaker as /class/input/input5
[   23.135226] Real Time Clock Driver v1.12ac
[   23.193129] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[   23.193555] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
[   23.380782] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
[   23.281009] Yenta: CardBus bridge found at 0000:04:05.0 [10f7:8338]
[   23.526178] tpm_inf_pnp 00:09: Found TPM with ID IFX0102
[   23.526245] tpm_inf_pnp 00:09: TPM found: config base 0x4e, data base 0x920, chip version 0x000b, vendor id 0x15d1 (Infineon), product id 0x000b (SLB 9635 TT 1.2)
[   23.409972] Yenta: ISA IRQ mask 0x0cb8, PCI irq 22
[   23.409979] Socket status: 30000006
[   23.409984] Yenta: Raising subordinate bus# of parent bus (#04) from #05 to #08
[   23.409992] pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
[   23.409996] cs: IO port probe 0x2000-0x2fff: clean.
[   23.410408] pcmcia: parent PCI bridge Memory window: 0xd0100000 - 0xd01fffff
[   23.410413] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
[   23.936909] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x39a0b2, caps: 0xa04753/0x200000
[   23.970912] input: SynPS/2 Synaptics TouchPad as /class/input/input6
[   23.999022] iTCO_wdt: Found a ICH7-M TCO device (Version=2, TCOBASE=0x1060)
[   23.999065] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   24.147374] cs: IO port probe 0x100-0x3af: clean.
[   24.149840] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[   24.150894] cs: IO port probe 0x820-0x8ff: clean.
[   24.151742] cs: IO port probe 0xc00-0xcf7: clean.
[   24.152786] cs: IO port probe 0xa00-0xaff: clean.
[   25.254452] EXT3 FS on dm-0, internal journal
[   25.377761] loop: module loaded
[   25.880808] kjournald starting.  Commit interval 5 seconds
[   25.988271] EXT3 FS on hda5, internal journal
[   25.988282] EXT3-fs: mounted filesystem with ordered data mode.
[   25.946072] Adding 3902756k swap on /dev/mapper/hda2_crypt.  Priority:-1 extents:1 across:3902756k
[   27.332926] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--=-c2loxJSkVnWsEwq49+Bz--

