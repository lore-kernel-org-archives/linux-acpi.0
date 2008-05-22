From: utodeb <utodeb@gmail.com>
Subject: acpi_apic_instance=2
Date: Thu, 22 May 2008 07:58:56 +0200
Message-ID: <48350BA0.8070507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090600010504010003070302"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:58078 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759626AbYEVF6o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2008 01:58:44 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1965966mue.1
        for <linux-acpi@vger.kernel.org>; Wed, 21 May 2008 22:58:42 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090600010504010003070302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
My log say :
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify 
linux-acpi@vger.kernel.org

so ...

My laptop work fine.

++

--------------090600010504010003070302
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

[    0.000000] Linux version 2.6.24-16-generic (buildd@palmer) (gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Thu Apr 10 13:23:42 UTC 2008 (Ubuntu 2.6.24-16.30-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fe90000 (usable)
[    0.000000]  BIOS-e820: 000000003fe90000 - 000000003ff00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] 126MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f5c10
[    0.000000] Entering add_active_range(0, 0, 261776) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   261776
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   261776
[    0.000000] On node 0 totalpages: 261776
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 253 pages used for memmap
[    0.000000]   HighMem zone: 32147 pages, LIFO batch:7
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xC00F5A70 checksum 0
[    0.000000] ACPI: RSDP 000F5A70, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT 3FE94FDC, 0058 (r1 ACRSYS ACRPRDCT  6040000 INNA        0)
[    0.000000] ACPI: FACP 3FE9DC78, 0074 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
[    0.000000] ACPI: DSDT 3FE96D79, 6EFF (r1 INTEL  CALISTGA  6040000 MSFT  100000E)
[    0.000000] ACPI: FACS 3FE9EFC0, 0040
[    0.000000] ACPI: APIC 3FE9DCEC, 0068 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
[    0.000000] ACPI: HPET 3FE9DD54, 0038 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
[    0.000000] ACPI: MCFG 3FE9DD8C, 003C (r1 INTEL  CALISTGA  6040000 LOHR       5A)
[    0.000000] ACPI: TCPA 3FE9DDC8, 0032 (r1 PTLTD  CALISTGA  6040000  PTL        1)
[    0.000000] ACPI: SLIC 3FE9DDFA, 0176 (r1 ACRSYS ACRPRDCT  6040000 ANNI        1)
[    0.000000] ACPI: APIC 3FE9DF70, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 3FE9DFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SSDT 3FE9672A, 064F (r1 SataRe  SataPri     1000 INTL 20050624)
[    0.000000] ACPI: SSDT 3FE96098, 0692 (r1 SataRe  SataSec     1000 INTL 20050624)
[    0.000000] ACPI: SSDT 3FE955C0, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
[    0.000000] ACPI: SSDT 3FE9551A, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050624)
[    0.000000] ACPI: SSDT 3FE95034, 04E6 (r1  PmRef    CpuPm     3000 INTL 20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
[    0.000000] ACPI: DMI detected: Acer
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:14 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 6:14 APIC version 20
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec28000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 255, address 0xfec28000, GSI 24-279
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 2 I/O APICs
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000dc000
[    0.000000] swsusp: Registered nosave memory region: 00000000000dc000 - 0000000000100000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259731
[    0.000000] Kernel command line: root=UUID=063e7a9a-f0be-4492-bb3a-5efe17d25851 ro splash
[    0.000000] mapped APIC to ffffb000 (fee00000)
[    0.000000] mapped IOAPIC to ffffa000 (fec00000)
[    0.000000] mapped IOAPIC to ffff9000 (fec28000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1729.275 MHz processor.
[   15.373897] Console: colour VGA+ 80x25
[   15.373904] console [tty0] enabled
[   15.378885] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   15.379614] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   15.432588] Memory: 1023816k/1047104k available (2157k kernel code, 22560k reserved, 998k data, 364k init, 129600k highmem)
[   15.432689] virtual kernel memory layout:
[   15.432692]     fixmap  : 0xfff4b000 - 0xfffff000   ( 720 kB)
[   15.432695]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   15.432697]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   15.432700]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   15.432703]       .init : 0xc041b000 - 0xc0476000   ( 364 kB)
[   15.432706]       .data : 0xc031b5a4 - 0xc0414dc4   ( 998 kB)
[   15.432708]       .text : 0xc0100000 - 0xc031b5a4   (2157 kB)
[   15.433213] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   15.433398] SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[   15.433632] hpet clockevent registered
[   15.513615] Calibrating delay using timer specific routine.. 3463.46 BogoMIPS (lpj=6926921)
[   15.513779] Security Framework initialized
[   15.513853] SELinux:  Disabled at boot.
[   15.513938] AppArmor: AppArmor initialized
[   15.514008] Failure registering capabilities with primary security module.
[   15.514088] Mount-cache hash table entries: 512
[   15.514363] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000 00000000
[   15.514380] monitor/mwait feature present.
[   15.514447] using mwait in idle threads.
[   15.514514] CPU: L1 I cache: 32K, L1 D cache: 32K
[   15.514623] CPU: L2 cache: 1024K
[   15.514686] CPU: Physical Processor ID: 0
[   15.514749] CPU: Processor Core ID: 0
[   15.514812] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00002940 0000c189 00000000 00000000 00000000
[   15.514830] Compat vDSO mapped to ffffe000.
[   15.514914] Checking 'hlt' instruction... OK.
[   15.530378] SMP alternatives: switching to UP code
[   15.533925] Early unpacking initramfs... done
[   16.421096] ACPI: Core revision 20070126
[   16.421284] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   16.468486] CPU0: Intel Genuine Intel(R) CPU           T2080  @ 1.73GHz stepping 0c
[   16.468727] SMP alternatives: switching to SMP code
[   16.470029] Booting processor 1/1 eip 3000
[   16.480328] Initializing CPU#1
[   16.557259] Calibrating delay using timer specific routine.. 3458.55 BogoMIPS (lpj=6917104)
[   16.557272] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000 00000000
[   16.557284] monitor/mwait feature present.
[   16.557290] CPU: L1 I cache: 32K, L1 D cache: 32K
[   16.557294] CPU: L2 cache: 1024K
[   16.557298] CPU: Physical Processor ID: 0
[   16.557302] CPU: Processor Core ID: 1
[   16.557305] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00002940 0000c189 00000000 00000000 00000000
[   16.557945] CPU1: Intel Genuine Intel(R) CPU           T2080  @ 1.73GHz stepping 0c
[   16.558632] Total of 2 processors activated (6922.01 BogoMIPS).
[   16.560250] ENABLING IO-APIC IRQs
[   16.560580] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   16.705402] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[   16.725541] Brought up 2 CPUs
[   16.725676] CPU0 attaching sched-domain:
[   16.725681]  domain 0: span 03
[   16.725685]   groups: 01 02
[   16.725692] CPU1 attaching sched-domain:
[   16.725696]  domain 0: span 03
[   16.725700]   groups: 02 01
[   16.726146] net_namespace: 64 bytes
[   16.726221] Booting paravirtualized kernel on bare hardware
[   16.727268] Time:  5:38:12  Date: 05/22/08
[   16.727383] NET: Registered protocol family 16
[   16.727847] EISA bus registered
[   16.727917] ACPI: bus type pci registered
[   16.728297] PCI: PCI BIOS revision 2.10 entry at 0xfd5a3, last bus=10
[   16.728370] PCI: Using configuration type 1
[   16.728433] Setting up standard PCI resources
[   16.735894] ACPI: EC: Look up EC in DSDT
[   16.740047] ACPI: BIOS _OSI(Linux) query ignored via DMI
[   16.740119] ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
[   16.741087] ACPI: Interpreter enabled
[   16.741154] ACPI: (supports S0 S3 S4 S5)
[   16.741419] ACPI: Using IOAPIC for interrupt routing
[   16.742161] ACPI: EC: non-query interrupt received, switching to interrupt mode
[   16.756812] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[   16.756887] ACPI: EC: driver started in interrupt mode
[   16.757043] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   16.758203] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[   16.758278] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[   16.760005] PCI: Transparent bridge - 0000:00:1e.0
[   16.760227] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   16.760892] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
[   16.761191] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[   16.761481] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[   16.761762] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[   16.762042] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[   16.762352] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[   16.779112] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
[   16.779567] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
[   16.780015] ACPI: PCI Interrupt Link [LNKC] (IRQs *10 11)
[   16.780464] ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
[   16.780911] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[   16.781468] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[   16.782008] ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
[   16.782456] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
[   16.783013] Linux Plug and Play Support v0.97 (c) Adam Belay
[   16.783143] pnp: PnP ACPI init
[   16.783219] ACPI: bus type pnp registered
[   16.788907] pnp: PnP ACPI: found 11 devices
[   16.788976] ACPI: ACPI bus type pnp unregistered
[   16.789044] PnPBIOS: Disabled by ACPI PNP
[   16.789584] PCI: Using ACPI for IRQ routing
[   16.789654] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   16.857495] NET: Registered protocol family 8
[   16.857564] NET: Registered protocol family 20
[   16.857693] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   16.857942] hpet0: 3 64-bit timers, 14318180 Hz
[   16.859068] AppArmor: AppArmor Filesystem Enabled
[   16.861166] Time: tsc clocksource has been installed.
[   16.861256] Switched to high resolution mode on CPU 0
[   16.861487] Switched to high resolution mode on CPU 1
[   16.874172] system 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
[   16.874258] system 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
[   16.876001] system 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
[   16.876084] system 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
[   16.876166] system 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[   16.876247] system 00:01: iomem range 0xfed20000-0xfed3ffff could not be reserved
[   16.876330] system 00:01: iomem range 0xfed40000-0xfed44fff could not be reserved
[   16.876413] system 00:01: iomem range 0xfed45000-0xfed8ffff could not be reserved
[   16.876506] system 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
[   16.876597] system 00:06: ioport range 0x680-0x68f has been reserved
[   16.876667] system 00:06: ioport range 0x800-0x80f has been reserved
[   16.876737] system 00:06: ioport range 0x1000-0x107f has been reserved
[   16.876807] system 00:06: ioport range 0x1180-0x11bf has been reserved
[   16.876877] system 00:06: ioport range 0x1200-0x120f has been reserved
[   16.876952] system 00:07: ioport range 0x6a0-0x6af has been reserved
[   16.877022] system 00:07: ioport range 0x6b0-0x6ff has been reserved
[   16.907972] PCI: Failed to allocate mem resource #6:20000@c0000000 for 0000:01:00.0
[   16.908056] PCI: Bridge: 0000:00:01.0
[   16.908118]   IO window: disabled.
[   16.908184]   MEM window: d0000000-d1ffffff
[   16.908250]   PREFETCH window: b0000000-bfffffff
[   16.908319] PCI: Bridge: 0000:00:1c.0
[   16.908384]   IO window: 2000-2fff
[   16.908452]   MEM window: c8000000-c9ffffff
[   16.908519]   PREFETCH window: c0000000-c1ffffff
[   16.908589] PCI: Bridge: 0000:00:1c.1
[   16.908656]   IO window: 3000-3fff
[   16.908723]   MEM window: ca000000-cbffffff
[   16.908790]   PREFETCH window: c2000000-c3ffffff
[   16.908860] PCI: Bridge: 0000:00:1c.2
[   16.908925]   IO window: 4000-4fff
[   16.908993]   MEM window: cc000000-cdffffff
[   16.909061]   PREFETCH window: c4000000-c5ffffff
[   16.909131] PCI: Bridge: 0000:00:1c.3
[   16.909196]   IO window: 5000-5fff
[   16.909264]   MEM window: ce000000-cfffffff
[   16.909331]   PREFETCH window: c6000000-c7ffffff
[   16.909413] PCI: Bus 11, cardbus bridge: 0000:0a:06.0
[   16.909482]   IO window: 00001400-000014ff
[   16.909550]   IO window: 00001c00-00001cff
[   16.909618]   PREFETCH window: 50000000-53ffffff
[   16.909687]   MEM window: 54000000-57ffffff
[   16.909755] PCI: Bridge: 0000:00:1e.0
[   16.909818]   IO window: disabled.
[   16.909886]   MEM window: d2000000-d20fffff
[   16.909953]   PREFETCH window: disabled.
[   16.910044] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   16.910183] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   16.910218] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   16.910350] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   16.910383] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
[   16.910515] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   16.910549] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   16.910681] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   16.910714] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   16.910846] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   16.910863] PCI: Enabling device 0000:00:1e.0 (0104 -> 0106)
[   16.910938] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   16.910963] ACPI: PCI Interrupt 0000:0a:06.0[A] -> GSI 22 (level, low) -> IRQ 20
[   16.911111] NET: Registered protocol family 2
[   16.954185] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   16.954699] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[   16.956285] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   16.957102] TCP: Hash tables configured (established 131072 bind 65536)
[   16.957175] TCP reno registered
[   16.966345] checking if image is initramfs... it is
[   18.729919] Freeing initrd memory: 9420k freed
[   18.730237] Simple Boot Flag at 0x36 set to 0x1
[   18.731648] audit: initializing netlink socket (disabled)
[   18.731734] audit(1211434694.136:1): initialized
[   18.732137] highmem bounce pool size: 64 pages
[   18.736410] VFS: Disk quotas dquot_6.5.1
[   18.736644] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   18.736982] io scheduler noop registered
[   18.737050] io scheduler anticipatory registered
[   18.737115] io scheduler deadline registered
[   18.737199] io scheduler cfq registered (default)
[   18.737400] Boot video device is 0000:01:00.0
[   18.737613] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   18.737674] assign_interrupt_mode Found MSI capability
[   18.737789] Allocate Port Service[0000:00:01.0:pcie00]
[   18.737932] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   18.738009] assign_interrupt_mode Found MSI capability
[   18.738135] Allocate Port Service[0000:00:1c.0:pcie00]
[   18.738205] Allocate Port Service[0000:00:1c.0:pcie02]
[   18.738363] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   18.738439] assign_interrupt_mode Found MSI capability
[   18.738566] Allocate Port Service[0000:00:1c.1:pcie00]
[   18.738638] Allocate Port Service[0000:00:1c.1:pcie02]
[   18.738795] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   18.738871] assign_interrupt_mode Found MSI capability
[   18.738997] Allocate Port Service[0000:00:1c.2:pcie00]
[   18.739066] Allocate Port Service[0000:00:1c.2:pcie02]
[   18.739227] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   18.739303] assign_interrupt_mode Found MSI capability
[   18.739430] Allocate Port Service[0000:00:1c.3:pcie00]
[   18.739502] Allocate Port Service[0000:00:1c.3:pcie02]
[   18.739988] isapnp: Scanning for PnP cards...
[   19.095417] isapnp: No Plug & Play device found
[   19.153456] Real Time Clock Driver v1.12ac
[   19.153938] hpet_resources: 0xfed00000 is busy
[   19.153985] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   19.156500] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   19.156718] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[   19.156997] PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   19.157507] i8042.c: Detected active multiplexing controller, rev 1.1.
[   19.157663] serio: i8042 KBD port at 0x60,0x64 irq 1
[   19.157735] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   19.157805] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   19.157872] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   19.157939] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   19.189542] mice: PS/2 mouse device common for all mice
[   19.189849] EISA: Probing bus 0 at eisa.0
[   19.189923] Cannot allocate resource for EISA slot 1
[   19.189989] Cannot allocate resource for EISA slot 2
[   19.190055] Cannot allocate resource for EISA slot 3
[   19.190125] Cannot allocate resource for EISA slot 4
[   19.190192] Cannot allocate resource for EISA slot 5
[   19.190279] EISA: Detected 0 cards.
[   19.190353] cpuidle: using governor ladder
[   19.190417] cpuidle: using governor menu
[   19.190638] NET: Registered protocol family 1
[   19.190756] Using IPI No-Shortcut mode
[   19.190866] registered taskstats version 1
[   19.191133]   Magic number: 8:754:618
[   19.191244]   hash matches device ptye8
[   19.191316]   hash matches device ptybb
[   19.191453] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   19.191522] EDD information not available.
[   19.191831] Freeing unused kernel memory: 364k freed
[   19.192919] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[   20.749813] fuse init (API version 7.9)
[   20.795725] ACPI: SSDT 3FE95D9E, 023D (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
[   20.796229] ACPI: SSDT 3FE9581F, 04FA (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
[   20.800771] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   20.800783] ACPI: Processor [CPU0] (supports 8 throttling states)
[   20.801303] ACPI: SSDT 3FE95FDB, 00BD (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
[   20.801758] ACPI: SSDT 3FE95D19, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
[   20.803492] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   20.803505] ACPI: Processor [CPU1] (supports 8 throttling states)
[   20.809842] ACPI: Thermal Zone [TZS0] (37 C)
[   20.811983] ACPI: Thermal Zone [TZS1] (46 C)
[   21.775661] r8169 Gigabit Ethernet driver 2.2LK loaded
[   21.775712] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   21.775742] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   21.776322] eth0: RTL8168b/8111b at 0xf8860000, 00:16:d3:57:17:02, XID 38000000 IRQ 218
[   21.866838] usbcore: registered new interface driver usbfs
[   21.866884] usbcore: registered new interface driver hub
[   21.869972] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
[   21.869995] PCI: Setting latency timer of device 0000:05:00.0 to 64
[   21.898020] usbcore: registered new device driver usb
[   21.904472] SCSI subsystem initialized
[   21.908403] USB Universal Host Controller Interface driver v3.0
[   21.944708] ssb: Sonics Silicon Backplane found on PCI device 0000:05:00.0
[   21.944953] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
[   21.944978] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   21.944986] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   21.945360] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   21.949303] ehci_hcd 0000:00:1d.7: debug port 1
[   21.949314] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   21.949334] ehci_hcd 0000:00:1d.7: irq 21, io mem 0xd2304000
[   21.953604] libata version 3.00 loaded.
[   21.964504] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   21.964747] usb usb1: configuration #1 chosen from 1 choice
[   21.964798] hub 1-0:1.0: USB hub found
[   21.964810] hub 1-0:1.0: 8 ports detected
[   22.068692] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
[   22.068717] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   22.068725] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   22.068776] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   22.068818] uhci_hcd 0000:00:1d.0: irq 21, io base 0x00001800
[   22.069048] usb usb2: configuration #1 chosen from 1 choice
[   22.069099] hub 2-0:1.0: USB hub found
[   22.069111] hub 2-0:1.0: 2 ports detected
[   22.171608] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[   22.171630] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   22.171638] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   22.171686] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   22.171732] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
[   22.171962] usb usb3: configuration #1 chosen from 1 choice
[   22.172017] hub 3-0:1.0: USB hub found
[   22.172029] hub 3-0:1.0: 2 ports detected
[   22.275592] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   22.275616] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   22.275624] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   22.275673] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   22.275720] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
[   22.275949] usb usb4: configuration #1 chosen from 1 choice
[   22.276001] hub 4-0:1.0: USB hub found
[   22.276013] hub 4-0:1.0: 2 ports detected
[   22.379558] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
[   22.379580] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   22.379589] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   22.379636] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[   22.379681] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
[   22.379916] usb usb5: configuration #1 chosen from 1 choice
[   22.379967] hub 5-0:1.0: USB hub found
[   22.379979] hub 5-0:1.0: 2 ports detected
[   22.483747] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   22.483810] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   22.483834] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[   22.495425] usb 1-7: new high speed USB device using ehci_hcd and address 3
[   22.496999] ata_piix 0000:00:1f.2: version 2.12
[   22.497012] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[   22.497051] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   22.497110] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   22.498761] scsi0 : ata_piix
[   22.498921] scsi1 : ata_piix
[   22.500808] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x18b0 irq 14
[   22.500816] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18b8 irq 15
[   22.664857] ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC70P, max UDMA/100
[   22.664869] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (not used)
[   22.679891] ata1.00: configured for UDMA/100
[   22.881677] usb 1-7: configuration #1 chosen from 1 choice
[   23.012698] ata2.01: ATAPI: Optiarc DVD RW AD-7530A, EX31, max UDMA/33
[   23.127150] usb 4-2: new low speed USB device using uhci_hcd and address 2
[   23.183669] ata2.01: configured for UDMA/33
[   23.183951] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[   23.185428] scsi 1:0:1:0: CD-ROM            Optiarc  DVD RW AD-7530A  EX31 PQ: 0 ANSI: 5
[   23.208151] Driver 'sd' needs updating - please use bus_type methods
[   23.208298] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   23.208326] sd 0:0:0:0: [sda] Write Protect is off
[   23.208332] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   23.208372] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   23.208486] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[   23.208510] sd 0:0:0:0: [sda] Write Protect is off
[   23.208516] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   23.208554] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   23.208562]  sda:<4>Driver 'sr' needs updating - please use bus_type methods
[   23.226251]  sda1 sda2 < sda5 sda6 > sda3 sda4
[   23.258599] sd 0:0:0:0: [sda] Attached SCSI disk
[   23.271676] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   23.271687] Uniform CD-ROM driver Revision: 3.20
[   23.271781] sr 1:0:1:0: Attached scsi CD-ROM sr0
[   23.272671] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   23.272712] sr 1:0:1:0: Attached scsi generic sg1 type 5
[   23.307434] usb 4-2: configuration #1 chosen from 1 choice
[   23.435157] usbcore: registered new interface driver hiddev
[   23.448524] input: Microsoft  Microsoft Basic Optical Mouse v2.0  as /devices/pci0000:00/0000:00:1d.2/usb4/4-2/4-2:1.0/input/input2
[   23.475148] input,hidraw0: USB HID v1.11 Mouse [Microsoft  Microsoft Basic Optical Mouse v2.0 ] on usb-0000:00:1d.2-2
[   23.475187] usbcore: registered new interface driver usbhid
[   23.475195] /build/buildd/linux-2.6.24/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   23.590974] Clocksource tsc unstable (delta = -348198300 ns)
[   23.594968] Time: hpet clocksource has been installed.
[   23.608253] Attempting manual resume
[   23.608261] swsusp: Resume From Partition 8:5
[   23.608265] PM: Checking swsusp image.
[   23.608535] PM: Resume from disk failed.
[   23.656340] kjournald starting.  Commit interval 5 seconds
[   23.656373] EXT3-fs: mounted filesystem with ordered data mode.
[   31.741115] Linux agpgart interface v0.102
[   31.930605] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   31.994232] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   32.561811] iTCO_vendor_support: vendor-support=0
[   32.585852] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
[   32.586062] iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
[   32.586083] iTCO_wdt: No card detected
[   32.666074] input: Power Button (FF) as /devices/virtual/input/input3
[   32.689687] ACPI: Power Button (FF) [PWRF]
[   32.689892] input: Lid Switch as /devices/virtual/input/input4
[   32.692167] ACPI: Lid Switch [LID0]
[   32.692328] input: Sleep Button (CM) as /devices/virtual/input/input5
[   32.709684] ACPI: Sleep Button (CM) [SLPB]
[   32.769708] intel_rng: FWH not detected
[   32.992878] ACPI: WMI-Acer: Mapper loaded
[   33.790610] Yenta: CardBus bridge found at 0000:0a:06.0 [1025:0107]
[   33.790648] Yenta: Using CSCINT to route CSC interrupts to PCI
[   33.790652] Yenta: Routing CardBus interrupts to PCI
[   33.790662] Yenta TI: socket 0000:0a:06.0, mfunc 0x01aa1b22, devctl 0x64
[   33.864235] nvidia: module license 'NVIDIA' taints kernel.
[   34.241134] Yenta: ISA IRQ mask 0x0cf8, PCI irq 20
[   34.241143] Socket status: 30000006
[   34.241149] Yenta: Raising subordinate bus# of parent bus (#0a) from #0a to #0e
[   34.241158] pcmcia: parent PCI bridge Memory window: 0xd2000000 - 0xd20fffff
[   34.473605] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:01/LNXVIDEO:00/input/input6
[   34.492004] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   34.492559] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input7
[   34.503992] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   34.614170] ACPI: PCI Interrupt 0000:0a:06.2[A] -> GSI 22 (level, low) -> IRQ 20
[   34.648074] sdhci: Secure Digital Host Controller Interface driver
[   34.648084] sdhci: Copyright(c) Pierre Ossman
[   34.648166] sdhci: SDHCI controller found at 0000:0a:06.3 [104c:803c] (rev 0)
[   34.648198] ACPI: PCI Interrupt 0000:0a:06.3[A] -> GSI 22 (level, low) -> IRQ 20
[   34.648300] mmc0: SDHCI at 0xd2005800 irq 20 PIO
[   35.314344] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 20
[   35.314387] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   35.431656] ACPI: AC Adapter [ADP1] (on-line)
[   35.471717] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   35.471738] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   35.471905] NVRM: loading NVIDIA UNIX x86 Kernel Module  169.12  Thu Feb 14 17:53:07 PST 2008
[   35.713218] ACPI: Battery Slot [BAT0] (battery present)
[   36.551349] b43-phy0: Broadcom 4311 WLAN found
[   36.703819] phy0: Selected rate control algorithm 'simple'
[   36.735213] Linux video capture interface: v2.00
[   36.848160] input: PC Speaker as /devices/platform/pcspkr/input/input8
[   36.907296] uvcvideo: Found UVC 1.00 device USB2.0 Camera (5986:0100)
[   36.988648] usbcore: registered new interface driver uvcvideo
[   36.988659] USB Video Class driver (v0.1.0)
[   37.394961] acer_acpi: Acer Laptop ACPI Extras version 0.11.1
[   37.394975] acer_acpi: Detected Acer AMW0 version 2 interface
[   37.400420] acer_acpi: Unable to detect mail LED
[   37.592857] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1280b1, caps: 0xa04713/0x204000
[   37.623711] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input9
[   39.297668] cs: IO port probe 0x100-0x3af: clean.
[   39.300003] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[   39.300996] cs: IO port probe 0x820-0x8ff: clean.
[   39.301822] cs: IO port probe 0xc00-0xcf7: clean.
[   39.302959] cs: IO port probe 0xa00-0xaff: clean.
[   39.953084] lp: driver loaded but no devices found
[   40.279465] Adding 1076312k swap on /dev/sda5.  Priority:-1 extents:1 across:1076312k
[   40.916318] EXT3 FS on sda6, internal journal
[   42.702407] kjournald starting.  Commit interval 5 seconds
[   42.702696] EXT3 FS on sda3, internal journal
[   42.702706] EXT3-fs: mounted filesystem with ordered data mode.
[   42.764096] kjournald starting.  Commit interval 5 seconds
[   42.764408] EXT3 FS on sda1, internal journal
[   42.764418] EXT3-fs: mounted filesystem with ordered data mode.
[   42.789572] kjournald starting.  Commit interval 5 seconds
[   42.789871] EXT3 FS on sda4, internal journal
[   42.789881] EXT3-fs: mounted filesystem with ordered data mode.
[   43.620125] ip_tables: (C) 2000-2006 Netfilter Core Team

--------------090600010504010003070302--
