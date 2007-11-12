From: Chris Dennis <chris@fb-cs.co.uk>
Subject: ACPI: Please test with "acpi_osi=!Linux" / Please send dmidecode
 to linux-acpi@vger.kernel.org
Date: Mon, 12 Nov 2007 16:19:06 +0000
Message-ID: <47387CFA.3070705@fb-cs.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090502010107070605060300"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:55049 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbXKLQYJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Nov 2007 11:24:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP id F1DD6DEEEB
	for <linux-acpi@vger.kernel.org>; Mon, 12 Nov 2007 16:28:28 +0000 (GMT)
Received: from mail.ukfsn.org ([127.0.0.1])
	by localhost (smtp-filter.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4gqV6XEXEJQ for <linux-acpi@vger.kernel.org>;
	Mon, 12 Nov 2007 16:28:28 +0000 (GMT)
Received: from [192.168.1.3] (unknown [78.32.16.193])
	by mail.ukfsn.org (Postfix) with ESMTP id 21FE7DEE5C
	for <linux-acpi@vger.kernel.org>; Mon, 12 Nov 2007 16:23:32 +0000 (GMT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502010107070605060300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello linux-acpi

I'm sending this email in response to this message in my computers dmesg 
log:

  ACPI: Please test with "acpi_osi=!Linux"
  Please send dmidecode to linux-acpi@vger.kernel.org

I've installed Ubuntu 7.10 on this laptop, which is an Acer TravelMate 
7513WSMi.  I've upgraded to the latest BIOS (v1.19).

Ubuntu is mostly working, although sound only works through headphones, 
and some types of memory card aren't detected properly.  I haven't 
tested everything yet.

After selecting the standard kernel from the Grub menu, I get the 
following error messages:

  BIOS BUG #81[00000000] found
  Cannot allocate resource region 7 of bridge 0000:00:04.0
  Cannot allocate resource region 5 of device 0000:03:00.0
  Failed to allocate mem resource #6:20000@00000000 for 0000:03:00.0

The first of those message goes away if I use 'pci=conf1'.

The other three are unaffected by 'noacpi' or 'acpi_osi=!Linux'.

As requested, I've attached dmidecode output, as well as that from dmesg 
and lspci -vvv.  The second dmesg file is the output when using 
'acpi_osi=!Linux' as suggested.

I hope this information is helpful for future kernel development.  And 
if you have any suggestions for getting rid of these error messages on 
my laptop, I'd be very grateful to receive them.

regards

Chris

-- 
Chris Dennis                                 email: chris@fb-cs.co.uk
Fordingbridge Computer Services           web: http://www.fb-cs.co.uk
Phone: (01425) 658265                            Mobile: 07814 239534

--------------090502010107070605060300
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

[    0.000000] Linux version 2.6.22-14-generic (buildd@palmer) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 23:05:12 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ff10000 (usable)
[    0.000000]  BIOS-e820: 000000003ff10000 - 000000003ff1a000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ff1a000 - 000000003ff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f81a0
[    0.000000] Entering add_active_range(0, 0, 261904) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   261904
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   261904
[    0.000000] On node 0 totalpages: 261904
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 254 pages used for memmap
[    0.000000]   HighMem zone: 32274 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xC00F8230 checksum 0
[    0.000000] ACPI: RSDP 000F8230, 0024 (r3 PTLTD )
[    0.000000] ACPI: XSDT 3FF138C9, 005C (r1 ACRSYS ACRPRDCT  6040000 INNA        0)
[    0.000000] ACPI: FACP 3FF19AA6, 00F4 (r3 NVIDIA MCP51M    6040000 PTL     F4240)
[    0.000000] ACPI: DSDT 3FF13925, 6181 (r1 NVIDIA   MCP51M  6040000 MSFT  100000E)
[    0.000000] ACPI: FACS 3FF1AFC0, 0040
[    0.000000] ACPI: SLIC 3FF19C0E, 0176 (r1 ACRSYS ACRPRDCT  6040000 ANNI        1)
[    0.000000] ACPI: MCFG 3FF19D84, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 3FF19DC0, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 3FF19DF8, 005E (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 3FF19E56, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SSDT 3FF19E7E, 0182 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:8 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:8 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] Built 1 zonelists.  Total pages: 259858
[    0.000000] Kernel command line: root=UUID=76b2d2e0-db08-436e-adb2-f82378c0b556 ro quiet splash
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1607.313 MHz processor.
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1026976k/1047616k available (2015k kernel code, 19968k reserved, 916k data, 364k init, 130112k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.000000]       .init : 0xc03e3000 - 0xc043e000   ( 364 kB)
[    0.000000]       .data : 0xc02f7d26 - 0xc03dce84   ( 916 kB)
[    0.000000]       .text : 0xc0100000 - 0xc02f7d26   (2015 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    0.000000] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[    0.000000] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.000000] hpet0: 3 32-bit timers, 25000000 Hz
[    0.080000] Calibrating delay using timer specific routine.. 3217.47 BogoMIPS (lpj=6434955)
[    0.080000] Security Framework v1.0.0 initialized
[    0.080000] SELinux:  Disabled at boot.
[    0.080000] Mount-cache hash table entries: 512
[    0.080000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.080000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.080000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.080000] CPU 0(2) -> Core 0
[    0.080000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.080000] Compat vDSO mapped to ffffe000.
[    0.080000] Checking 'hlt' instruction... OK.
[    0.096000] SMP alternatives: switching to UP code
[    0.096000] Early unpacking initramfs... done
[    0.456000] ACPI: Core revision 20070126
[    0.456000] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[    0.460000] CPU0: AMD Turion(tm) 64 X2 Mobile Technology TL-52 stepping 02
[    0.460000] SMP alternatives: switching to SMP code
[    0.460000] Booting processor 1/1 eip 3000
[    0.472000] Initializing CPU#1
[    0.552000] Calibrating delay using timer specific routine.. 3214.65 BogoMIPS (lpj=6429315)
[    0.552000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.552000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.552000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.552000] CPU 1(2) -> Core 1
[    0.552000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.552000] CPU1: AMD Turion(tm) 64 X2 Mobile Technology TL-52 stepping 02
[    0.552000] Total of 2 processors activated (6432.13 BogoMIPS).
[    0.552000] ENABLING IO-APIC IRQs
[    0.552000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.592000] Brought up 2 CPUs
[    0.608000] migration_cost=4000
[    0.608000] Booting paravirtualized kernel on bare hardware
[    0.608000] Time: 13:01:32  Date: 10/12/107
[    0.608000] NET: Registered protocol family 16
[    0.608000] EISA bus registered
[    0.608000] ACPI: bus type pci registered
[    0.620000] PCI: BIOS BUG #81[49435000] found
[    0.620000] PCI: Using configuration type 1
[    0.620000] Setting up standard PCI resources
[    0.620000] ACPI: EC: Look up EC in DSDT
[    0.624000] ACPI: EC: GPE=0x01, ports=0x66, 0x62
[    0.624000] ACPI: System BIOS is requesting _OSI(Linux)
[    0.624000] ACPI: Please test with "acpi_osi=!Linux"
[    0.624000] Please send dmidecode to linux-acpi@vger.kernel.org
[    0.624000] ACPI: Interpreter enabled
[    0.624000] ACPI: (supports S0 S3 S4 S5)
[    0.624000] ACPI: Using IOAPIC for interrupt routing
[    0.636000] ACPI: EC: GPE=0x01, ports=0x66, 0x62
[    0.636000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.636000] PCI: Probing PCI hardware (bus 00)
[    0.636000] PCI: Transparent bridge - 0000:00:10.0
[    0.636000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.636000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[    0.636000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[    0.636000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[    0.636000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[    0.672000] ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.672000] ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.672000] ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.672000] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 *11 14 15)
[    0.676000] ACPI: PCI Interrupt Link [LK1E] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.676000] ACPI: PCI Interrupt Link [LK2E] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LK3E] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LK4E] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LSMB] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.676000] ACPI: PCI Interrupt Link [LSMU] (IRQs 16 17 18 19 20 21 22 23) *11
[    0.676000] ACPI: PCI Interrupt Link [LUS0] (IRQs 16 17 18 19 20 21 22 23) *11
[    0.676000] ACPI: PCI Interrupt Link [LUS2] (IRQs 16 17 18 19 20 21 22 23) *7
[    0.676000] ACPI: PCI Interrupt Link [LMAC] (IRQs 16 17 18 19 20 21 22 23) *11
[    0.676000] ACPI: PCI Interrupt Link [LAZA] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LACI] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LMCI] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LPID] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LTID] (IRQs 16 17 18 19 20 21 22 23) *5
[    0.676000] ACPI: PCI Interrupt Link [LSI1] (IRQs 16 17 18 19 20 21 22 23) *0
[    0.676000] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.676000] pnp: PnP ACPI init
[    0.676000] ACPI: bus type pnp registered
[    0.680000] pnp: PnP ACPI: found 11 devices
[    0.680000] ACPI: ACPI bus type pnp unregistered
[    0.680000] PnPBIOS: Disabled by ACPI PNP
[    0.680000] PCI: Using ACPI for IRQ routing
[    0.680000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.680000] PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
[    0.680000] PCI: Cannot allocate resource region 5 of device 0000:03:00.0
[    0.680000] NET: Registered protocol family 8
[    0.680000] NET: Registered protocol family 20
[    0.680000] pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.680000] pnp: 00:02: ioport range 0x1000-0x107f has been reserved
[    0.680000] pnp: 00:02: ioport range 0x1080-0x10ff has been reserved
[    0.680000] pnp: 00:02: ioport range 0x1400-0x147f has been reserved
[    0.680000] pnp: 00:02: ioport range 0x1480-0x14ff has been reserved
[    0.680000] pnp: 00:02: ioport range 0x1800-0x187f has been reserved
[    0.680000] pnp: 00:02: ioport range 0x1880-0x18ff has been reserved
[    0.680000] pnp: 00:02: ioport range 0x2000-0x203f has been reserved
[    0.684000] Time: hpet clocksource has been installed.
[    0.712000] PCI: Bridge: 0000:00:02.0
[    0.712000]   IO window: disabled.
[    0.712000]   MEM window: disabled.
[    0.712000]   PREFETCH window: disabled.
[    0.712000] PCI: Bridge: 0000:00:03.0
[    0.712000]   IO window: 4000-4fff
[    0.712000]   MEM window: c4000000-c40fffff
[    0.712000]   PREFETCH window: disabled.
[    0.712000] PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:03:00.0
[    0.712000] PCI: Bridge: 0000:00:04.0
[    0.712000]   IO window: 5000-5fff
[    0.712000]   MEM window: c1000000-c2ffffff
[    0.712000]   PREFETCH window: d0000000-dfffffff
[    0.712000] PCI: Bus 5, cardbus bridge: 0000:04:06.0
[    0.712000]   IO window: 00006000-000060ff
[    0.712000]   IO window: 00006400-000064ff
[    0.712000]   PREFETCH window: 50000000-53ffffff
[    0.712000]   MEM window: 54000000-57ffffff
[    0.712000] PCI: Bridge: 0000:00:10.0
[    0.712000]   IO window: 6000-6fff
[    0.712000]   MEM window: c3000000-c30fffff
[    0.712000]   PREFETCH window: 50000000-53ffffff
[    0.712000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.712000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    0.712000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    0.712000] PCI: Setting latency timer of device 0000:00:10.0 to 64
[    0.712000] ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
[    0.712000] ACPI: PCI Interrupt 0000:04:06.0[A] -> Link [LNK4] -> GSI 11 (level, low) -> IRQ 11
[    0.712000] NET: Registered protocol family 2
[    0.760000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.760000] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[    0.760000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.760000] TCP: Hash tables configured (established 131072 bind 65536)
[    0.760000] TCP reno registered
[    0.776000] checking if image is initramfs... it is
[    1.484000] Freeing initrd memory: 7063k freed
[    1.484000] Simple Boot Flag at 0x36 set to 0x1
[    1.484000] audit: initializing netlink socket (disabled)
[    1.484000] audit(1194872492.184:1): initialized
[    1.484000] highmem bounce pool size: 64 pages
[    1.484000] VFS: Disk quotas dquot_6.5.1
[    1.484000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.484000] io scheduler noop registered
[    1.484000] io scheduler anticipatory registered
[    1.484000] io scheduler deadline registered
[    1.484000] io scheduler cfq registered (default)
[    1.504000] Boot video device is 0000:03:00.0
[    1.504000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    1.504000] assign_interrupt_mode Found MSI capability
[    1.504000] Allocate Port Service[0000:00:02.0:pcie00]
[    1.504000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    1.504000] assign_interrupt_mode Found MSI capability
[    1.504000] Allocate Port Service[0000:00:03.0:pcie00]
[    1.504000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    1.504000] assign_interrupt_mode Found MSI capability
[    1.504000] Allocate Port Service[0000:00:04.0:pcie00]
[    1.504000] isapnp: Scanning for PnP cards...
[    1.856000] isapnp: No Plug & Play device found
[    1.884000] Real Time Clock Driver v1.12ac
[    1.884000] hpet_resources: 0xfed00000 is busy
[    1.884000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.884000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.884000] input: Macintosh mouse button emulation as /class/input/input0
[    1.884000] PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.884000] i8042.c: Detected active multiplexing controller, rev 1.1.
[    1.884000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.884000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.884000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.884000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.884000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.884000] mice: PS/2 mouse device common for all mice
[    1.884000] EISA: Probing bus 0 at eisa.0
[    1.884000] Cannot allocate resource for EISA slot 1
[    1.884000] Cannot allocate resource for EISA slot 2
[    1.884000] Cannot allocate resource for EISA slot 3
[    1.884000] Cannot allocate resource for EISA slot 4
[    1.884000] Cannot allocate resource for EISA slot 5
[    1.884000] Cannot allocate resource for EISA slot 6
[    1.884000] EISA: Detected 0 cards.
[    1.884000] TCP cubic registered
[    1.884000] NET: Registered protocol family 1
[    1.884000] Using IPI No-Shortcut mode
[    1.884000]   Magic number: 15:271:28
[    1.884000]   hash matches device ttydb
[    1.884000] Freeing unused kernel memory: 364k freed
[    1.892000] input: AT Translated Set 2 keyboard as /class/input/input1
[    3.148000] AppArmor: AppArmor initialized<5>audit(1194872494.184:2):  type=1505 info="AppArmor initialized" pid=1251
[    3.156000] fuse init (API version 7.8)
[    3.164000] Failure registering capabilities with primary security module.
[    3.204000] ACPI: Thermal Zone [TZS0] (50 C)
[    3.208000] ACPI: Thermal Zone [TZS1] (53 C)
[    3.872000] usbcore: registered new interface driver usbfs
[    3.872000] usbcore: registered new interface driver hub
[    3.872000] usbcore: registered new device driver usb
[    3.872000] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 23
[    3.872000] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LUS2] -> GSI 23 (level, high) -> IRQ 16
[    3.872000] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[    3.872000] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    3.872000] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
[    3.872000] ehci_hcd 0000:00:0b.1: debug port 1
[    3.872000] PCI: cache line size of 64 is not supported by device 0000:00:0b.1
[    3.872000] ehci_hcd 0000:00:0b.1: irq 16, io mem 0xc0005000
[    3.872000] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    3.872000] usb usb1: configuration #1 chosen from 1 choice
[    3.872000] hub 1-0:1.0: USB hub found
[    3.872000] hub 1-0:1.0: 8 ports detected
[    3.876000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    3.876000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    3.888000] SCSI subsystem initialized
[    3.896000] libata version 2.21 loaded.
[    3.920000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.976000] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[    3.976000] NFORCE-MCP51: chipset revision 241
[    3.976000] NFORCE-MCP51: not 100% native mode: will probe irqs later
[    3.976000] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
[    3.976000] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[    3.976000]     ide0: BM-DMA at 0x3080-0x3087, BIOS settings: hda:pio, hdb:pio
[    3.976000]     ide1: BM-DMA at 0x3088-0x308f, BIOS settings: hdc:DMA, hdd:pio
[    3.976000] Probing IDE interface ide0...
[    3.984000] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[    4.224000] usb 1-2: new high speed USB device using ehci_hcd and address 2
[    4.368000] usb 1-2: configuration #1 chosen from 1 choice
[    4.560000] Probing IDE interface ide1...
[    4.616000] usb 1-6: new high speed USB device using ehci_hcd and address 3
[    4.996000] usb 1-6: configuration #1 chosen from 1 choice
[    5.004000] usbcore: registered new interface driver libusual
[    5.012000] Initializing USB Mass Storage driver...
[    5.012000] scsi0 : SCSI emulation for USB Mass Storage devices
[    5.012000] usb-storage: device found at 2
[    5.012000] usb-storage: waiting for device to settle before scanning
[    5.012000] usbcore: registered new interface driver usb-storage
[    5.012000] USB Mass Storage support registered.
[    5.296000] hdc: Slimtype DVDRW SSM-8515S, ATAPI CD/DVD-ROM drive
[    5.968000] ide1 at 0x170-0x177,0x376 on irq 15
[    5.980000] sata_nv 0000:00:0e.0: version 3.4
[    5.984000] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
[    5.984000] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LTID] -> GSI 22 (level, high) -> IRQ 17
[    5.984000] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    5.984000] scsi1 : sata_nv
[    5.984000] scsi2 : sata_nv
[    5.984000] ata1: SATA max UDMA/133 cmd 0x000130b0 ctl 0x000130a6 bmdma 0x00013090 irq 17
[    5.984000] ata2: SATA max UDMA/133 cmd 0x000130a8 ctl 0x000130a2 bmdma 0x00013098 irq 17
[    6.452000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.460000] ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC70P, max UDMA/100
[    6.460000] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    6.480000] ata1.00: configured for UDMA/100
[    6.792000] ata2: SATA link down (SStatus 0 SControl 300)
[    6.796000] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[    6.796000] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 21
[    6.796000] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LMAC] -> GSI 21 (level, high) -> IRQ 18
[    6.796000] PCI: Setting latency timer of device 0000:00:14.0 to 64
[    6.796000] forcedeth: using HIGHDMA
[    7.320000] eth0: forcedeth.c: subsystem: 01025:0112 bound to 0000:00:14.0
[    7.320000] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
[    7.320000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LUS0] -> GSI 20 (level, high) -> IRQ 19
[    7.320000] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    7.320000] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[    7.320000] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
[    7.320000] ohci_hcd 0000:00:0b.0: irq 19, io mem 0xc0004000
[    7.328000] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    7.328000] sd 1:0:0:0: [sda] Write Protect is off
[    7.328000] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    7.328000] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.328000] sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    7.328000] sd 1:0:0:0: [sda] Write Protect is off
[    7.328000] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    7.328000] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.328000]  sda:<6>hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[    7.332000] Uniform CD-ROM driver Revision: 3.20
[    7.356000]  sda1 sda2 sda3 <<6>usb usb2: configuration #1 chosen from 1 choice
[    7.376000] hub 2-0:1.0: USB hub found
[    7.376000] hub 2-0:1.0: 8 ports detected
[    7.384000]  sda5 sda6 >
[    7.396000] sd 1:0:0:0: [sda] Attached SCSI disk
[    7.400000] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    7.744000] Attempting manual resume
[    7.744000] swsusp: Resume From Partition 8:5
[    7.744000] PM: Checking swsusp image.
[    7.744000] PM: Resume from disk failed.
[    7.780000] kjournald starting.  Commit interval 5 seconds
[    7.780000] EXT3-fs: mounted filesystem with ordered data mode.
[   10.012000] usb-storage: device scan complete
[   10.012000] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 2.0 1.00 PQ: 0 ANSI: 2
[   10.012000] sd 0:0:0:0: [sdb] 4040192 512-byte hardware sectors (2069 MB)
[   10.016000] sd 0:0:0:0: [sdb] Write Protect is off
[   10.016000] sd 0:0:0:0: [sdb] Mode Sense: 23 00 00 00
[   10.016000] sd 0:0:0:0: [sdb] Assuming drive cache: write through
[   10.020000] sd 0:0:0:0: [sdb] 4040192 512-byte hardware sectors (2069 MB)
[   10.020000] sd 0:0:0:0: [sdb] Write Protect is off
[   10.020000] sd 0:0:0:0: [sdb] Mode Sense: 23 00 00 00
[   10.020000] sd 0:0:0:0: [sdb] Assuming drive cache: write through
[   10.020000]  sdb: sdb1
[   10.024000] sd 0:0:0:0: [sdb] Attached SCSI removable disk
[   10.024000] sd 0:0:0:0: Attached scsi generic sg1 type 0
[   16.296000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   16.296000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   16.328000] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x3040
[   16.328000] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x3000
[   16.636000] ath_hal: module license 'Proprietary' taints kernel.
[   16.708000] ath_hal: 0.9.18.0 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
[   16.908000] Linux agpgart interface v0.102 (c) Dave Jones
[   17.144000] wlan: 0.8.4.2 (0.9.3.2)
[   17.160000] ACPI: PCI Interrupt 0000:04:06.2[A] -> Link [LNK4] -> GSI 11 (level, low) -> IRQ 11
[   17.192000] Yenta: CardBus bridge found at 0000:04:06.0 [1025:0112]
[   17.192000] Yenta: Using CSCINT to route CSC interrupts to PCI
[   17.192000] Yenta: Routing CardBus interrupts to PCI
[   17.192000] Yenta TI: socket 0000:04:06.0, mfunc 0x013a1b22, devctl 0x64
[   17.428000] Yenta: ISA IRQ mask 0x04f8, PCI irq 11
[   17.428000] Socket status: 30000006
[   17.428000] Yenta: Raising subordinate bus# of parent bus (#04) from #05 to #08
[   17.428000] pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
[   17.428000] cs: IO port probe 0x6000-0x6fff: clean.
[   17.428000] pcmcia: parent PCI bridge Memory window: 0xc3000000 - 0xc30fffff
[   17.428000] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
[   17.484000] ACPI: PCI Interrupt Link [LK1E] enabled at IRQ 19
[   17.484000] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LK1E] -> GSI 19 (level, high) -> IRQ 20
[   17.484000] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   17.484000] NVRM: loading NVIDIA UNIX x86 Kernel Module  100.14.19  Wed Sep 12 14:12:24 PDT 2007
[   17.516000] ath_pci: 0.9.4.5 (0.9.3.2)
[   17.516000] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 18
[   17.516000] ACPI: PCI Interrupt 0000:04:05.0[A] -> Link [LNK2] -> GSI 18 (level, high) -> IRQ 21
[   18.240000] ath_rate_sample: 1.2 (0.9.3.2)
[   18.244000] wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
[   18.244000] wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
[   18.244000] wifi0: H/W encryption support: WEP AES AES_CCM TKIP
[   18.244000] wifi0: mac 7.8 phy 4.5 radio 5.6
[   18.244000] wifi0: Use hw queue 1 for WME_AC_BE traffic
[   18.244000] wifi0: Use hw queue 0 for WME_AC_BK traffic
[   18.244000] wifi0: Use hw queue 2 for WME_AC_VI traffic
[   18.244000] wifi0: Use hw queue 3 for WME_AC_VO traffic
[   18.244000] wifi0: Use hw queue 8 for CAB traffic
[   18.244000] wifi0: Use hw queue 9 for beacons
[   18.272000] input: PC Speaker as /class/input/input2
[   18.304000] Linux video capture interface: v2.00
[   18.376000] wifi0: Atheros 5212: mem=0xc3000000, irq=21
[   18.448000] uvcvideo: Found UVC 1.00 device USB2.0 Camera (5986:0100)
[   18.532000] usbcore: registered new interface driver uvcvideo
[   18.532000] USB Video Class driver (v0.1.0)
[   18.600000] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 17
[   18.600000] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LAZA] -> GSI 17 (level, high) -> IRQ 22
[   18.600000] PCI: Setting latency timer of device 0000:00:10.1 to 64
[   18.760000] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1280b1, caps: 0xa04713/0x204000
[   18.784000] cs: IO port probe 0x100-0x3af: clean.
[   18.788000] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[   18.788000] cs: IO port probe 0x820-0x8ff: clean.
[   18.788000] cs: IO port probe 0xc00-0xcf7: clean.
[   18.788000] cs: IO port probe 0xa00-0xaff: clean.
[   18.792000] input: SynPS/2 Synaptics TouchPad as /class/input/input3
[   19.328000] loop: module loaded
[   19.376000] lp: driver loaded but no devices found
[   19.468000] Adding 2931820k swap on /dev/sda5.  Priority:-1 extents:1 across:2931820k
[   19.908000] EXT3 FS on sda6, internal journal
[   20.460000] hda_intel: azx_get_response timeout, switching to polling mode...
[   21.312000] No dock devices found.
[   21.328000] ACPI: AC Adapter [ADP1] (on-line)
[   21.440000] input: Power Button (FF) as /class/input/input4
[   21.440000] ACPI: Power Button (FF) [PWRF]
[   21.440000] input: Lid Switch as /class/input/input5
[   21.440000] ACPI: Lid Switch [LID0]
[   21.440000] input: Sleep Button (CM) as /class/input/input6
[   21.440000] ACPI: Sleep Button (CM) [SLPB]
[   21.440000] input: Power Button (CM) as /class/input/input7
[   21.440000] ACPI: Power Button (CM) [PWRB]
[   21.608000] ACPI: Battery Slot [BAT0] (battery present)
[   21.648000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   21.648000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   21.928000] powernow-k8: Found 2 AMD Turion(tm) 64 X2 Mobile Technology TL-52 processors (version 2.00.00)
[   21.928000] powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x13
[   21.928000] powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x1e
[   23.108000] ppdev: user-space parallel port driver
[   23.244000] audit(1194872514.754:3):  type=1503 operation="inode_permission" requested_mask="a" denied_mask="a" name="/dev/tty" pid=5151 profile="/usr/sbin/cupsd"
[   23.324000] apm: BIOS not found.
[   23.904000] Failure registering capabilities with primary security module.
[   24.000000] Clocksource tsc unstable (delta = -112020421 ns)
[   24.204000] Bluetooth: Core ver 2.11
[   24.204000] NET: Registered protocol family 31
[   24.204000] Bluetooth: HCI device and connection manager initialized
[   24.204000] Bluetooth: HCI socket layer initialized
[   24.228000] Bluetooth: L2CAP ver 2.8
[   24.228000] Bluetooth: L2CAP socket layer initialized
[   24.264000] Bluetooth: RFCOMM socket layer initialized
[   24.264000] Bluetooth: RFCOMM TTY layer initialized
[   24.264000] Bluetooth: RFCOMM ver 1.8
[   28.952000] NET: Registered protocol family 17
[   32.720000] NET: Registered protocol family 10
[   32.720000] lo: Disabled Privacy Extensions
[   42.912000] eth0: no IPv6 routers present
[   43.412000] ath0: no IPv6 routers present
[  179.340000] eth0: link down.
[ 1038.848000] ADDRCONF(NETDEV_CHANGE): ath0: link becomes ready
[ 1058.556000] ath0: no IPv6 routers present
[ 2168.312000] usb 1-8: new high speed USB device using ehci_hcd and address 4
[ 2168.448000] usb 1-8: configuration #1 chosen from 1 choice
[ 2168.448000] scsi3 : SCSI emulation for USB Mass Storage devices
[ 2168.448000] usb-storage: device found at 4
[ 2168.448000] usb-storage: waiting for device to settle before scanning
[ 2168.732000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 1 alt 0 proto 2 vid 0x03F0 pid 0x5711
[ 2168.732000] usbcore: registered new interface driver usblp
[ 2168.732000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[ 2173.448000] usb-storage: device scan complete
[ 2173.448000] scsi 3:0:0:0: Direct-Access     HP       Photosmart C4180 1.00 PQ: 0 ANSI: 2
[ 2173.452000] sd 3:0:0:0: [sdc] Attached SCSI removable disk
[ 2173.452000] sd 3:0:0:0: Attached scsi generic sg2 type 0
[ 2276.096000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/usb/class/usblp.c: usblp0: removed
[ 2276.260000] audit(1194874769.368:4):  type=1503 operation="inode_permission" requested_mask="rw" denied_mask="rw" name="/dev/tty" pid=6994 profile="/usr/sbin/cupsd"
[ 2276.304000] audit(1194874769.368:5):  type=1503 operation="inode_permission" requested_mask="rw" denied_mask="rw" name="/dev/tty" pid=6997 profile="/usr/sbin/cupsd"

--------------090502010107070605060300
Content-Type: text/plain;
 name="dmesg2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg2.txt"

[    0.000000] Linux version 2.6.22-14-generic (buildd@palmer) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 23:05:12 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ff10000 (usable)
[    0.000000]  BIOS-e820: 000000003ff10000 - 000000003ff1a000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ff1a000 - 000000003ff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f81a0
[    0.000000] Entering add_active_range(0, 0, 261904) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   261904
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   261904
[    0.000000] On node 0 totalpages: 261904
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 254 pages used for memmap
[    0.000000]   HighMem zone: 32274 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xC00F8230 checksum 0
[    0.000000] ACPI: RSDP 000F8230, 0024 (r3 PTLTD )
[    0.000000] ACPI: XSDT 3FF138C9, 005C (r1 ACRSYS ACRPRDCT  6040000 INNA        0)
[    0.000000] ACPI: FACP 3FF19AA6, 00F4 (r3 NVIDIA MCP51M    6040000 PTL     F4240)
[    0.000000] ACPI: DSDT 3FF13925, 6181 (r1 NVIDIA   MCP51M  6040000 MSFT  100000E)
[    0.000000] ACPI: FACS 3FF1AFC0, 0040
[    0.000000] ACPI: SLIC 3FF19C0E, 0176 (r1 ACRSYS ACRPRDCT  6040000 ANNI        1)
[    0.000000] ACPI: MCFG 3FF19D84, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 3FF19DC0, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 3FF19DF8, 005E (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 3FF19E56, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SSDT 3FF19E7E, 0182 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:8 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:8 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] Built 1 zonelists.  Total pages: 259858
[    0.000000] Kernel command line: root=UUID=76b2d2e0-db08-436e-adb2-f82378c0b556 ro quiet splash acpi_osi=!Linux
[    0.000000] ACPI: Disabled _OSI(Linux)
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1607.374 MHz processor.
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1026976k/1047616k available (2015k kernel code, 19968k reserved, 916k data, 364k init, 130112k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.000000]       .init : 0xc03e3000 - 0xc043e000   ( 364 kB)
[    0.000000]       .data : 0xc02f7d26 - 0xc03dce84   ( 916 kB)
[    0.000000]       .text : 0xc0100000 - 0xc02f7d26   (2015 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    0.000000] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[    0.000000] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.000000] hpet0: 3 32-bit timers, 25000000 Hz
[    0.080000] Calibrating delay using timer specific routine.. 3217.47 BogoMIPS (lpj=6434943)
[    0.080000] Security Framework v1.0.0 initialized
[    0.080000] SELinux:  Disabled at boot.
[    0.080000] Mount-cache hash table entries: 512
[    0.080000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.080000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.080000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.080000] CPU 0(2) -> Core 0
[    0.080000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.080000] Compat vDSO mapped to ffffe000.
[    0.080000] Checking 'hlt' instruction... OK.
[    0.096000] SMP alternatives: switching to UP code
[    0.096000] Early unpacking initramfs... done
[    0.456000] ACPI: Core revision 20070126
[    0.456000] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[    0.460000] CPU0: AMD Turion(tm) 64 X2 Mobile Technology TL-52 stepping 02
[    0.460000] SMP alternatives: switching to SMP code
[    0.460000] Booting processor 1/1 eip 3000
[    0.472000] Initializing CPU#1
[    0.552000] Calibrating delay using timer specific routine.. 3214.65 BogoMIPS (lpj=6429301)
[    0.552000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.552000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.552000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.552000] CPU 1(2) -> Core 1
[    0.552000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.552000] CPU1: AMD Turion(tm) 64 X2 Mobile Technology TL-52 stepping 02
[    0.552000] Total of 2 processors activated (6432.12 BogoMIPS).
[    0.552000] ENABLING IO-APIC IRQs
[    0.552000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.596000] Brought up 2 CPUs
[    0.612000] migration_cost=4000
[    0.612000] Booting paravirtualized kernel on bare hardware
[    0.612000] Time: 14:07:17  Date: 10/12/107
[    0.612000] NET: Registered protocol family 16
[    0.612000] EISA bus registered
[    0.612000] ACPI: bus type pci registered
[    0.624000] PCI: BIOS BUG #81[49435000] found
[    0.624000] PCI: Using configuration type 1
[    0.624000] Setting up standard PCI resources
[    0.624000] ACPI: EC: Look up EC in DSDT
[    0.624000] ACPI: EC: GPE=0x01, ports=0x66, 0x62
[    0.628000] ACPI: System BIOS is requesting _OSI(Linux)
[    0.628000] ACPI: Please test with "acpi_osi=!Linux"
[    0.628000] Please send dmidecode to linux-acpi@vger.kernel.org
[    0.628000] ACPI: Interpreter enabled
[    0.628000] ACPI: (supports S0 S3 S4 S5)
[    0.628000] ACPI: Using IOAPIC for interrupt routing
[    0.640000] ACPI: EC: GPE=0x01, ports=0x66, 0x62
[    0.640000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.640000] PCI: Probing PCI hardware (bus 00)
[    0.640000] PCI: Transparent bridge - 0000:00:10.0
[    0.640000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.640000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[    0.640000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[    0.640000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[    0.640000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[    0.676000] ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.676000] ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.676000] ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.676000] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 *11 14 15)
[    0.676000] ACPI: PCI Interrupt Link [LK1E] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.680000] ACPI: PCI Interrupt Link [LK2E] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.680000] ACPI: PCI Interrupt Link [LK3E] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.680000] ACPI: PCI Interrupt Link [LK4E] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.680000] ACPI: PCI Interrupt Link [LSMB] (IRQs 16 17 18 19 20 21 22 23) *10
[    0.680000] ACPI: PCI Interrupt Link [LSMU] (IRQs 16 17 18 19 20 21 22 23) *11
[    0.680000] ACPI: PCI Interrupt Link [LUS0] (IRQs 16 17 18 19 20 21 22 23) *11
[    0.680000] ACPI: PCI Interrupt Link [LUS2] (IRQs 16 17 18 19 20 21 22 23) *7
[    0.680000] ACPI: PCI Interrupt Link [LMAC] (IRQs 16 17 18 19 20 21 22 23) *11
[    0.680000] ACPI: PCI Interrupt Link [LAZA] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.680000] ACPI: PCI Interrupt Link [LACI] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.680000] ACPI: PCI Interrupt Link [LMCI] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.680000] ACPI: PCI Interrupt Link [LPID] (IRQs 16 17 18 19 20 21 22 23) *0, disabled.
[    0.680000] ACPI: PCI Interrupt Link [LTID] (IRQs 16 17 18 19 20 21 22 23) *5
[    0.680000] ACPI: PCI Interrupt Link [LSI1] (IRQs 16 17 18 19 20 21 22 23) *0
[    0.680000] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.680000] pnp: PnP ACPI init
[    0.680000] ACPI: bus type pnp registered
[    0.684000] pnp: PnP ACPI: found 11 devices
[    0.684000] ACPI: ACPI bus type pnp unregistered
[    0.684000] PnPBIOS: Disabled by ACPI PNP
[    0.684000] PCI: Using ACPI for IRQ routing
[    0.684000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.684000] PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
[    0.684000] PCI: Cannot allocate resource region 5 of device 0000:03:00.0
[    0.684000] NET: Registered protocol family 8
[    0.684000] NET: Registered protocol family 20
[    0.684000] pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.684000] pnp: 00:02: ioport range 0x1000-0x107f has been reserved
[    0.684000] pnp: 00:02: ioport range 0x1080-0x10ff has been reserved
[    0.684000] pnp: 00:02: ioport range 0x1400-0x147f has been reserved
[    0.684000] pnp: 00:02: ioport range 0x1480-0x14ff has been reserved
[    0.684000] pnp: 00:02: ioport range 0x1800-0x187f has been reserved
[    0.684000] pnp: 00:02: ioport range 0x1880-0x18ff has been reserved
[    0.684000] pnp: 00:02: ioport range 0x2000-0x203f has been reserved
[    0.688000] Time: hpet clocksource has been installed.
[    0.716000] PCI: Bridge: 0000:00:02.0
[    0.716000]   IO window: disabled.
[    0.716000]   MEM window: disabled.
[    0.716000]   PREFETCH window: disabled.
[    0.716000] PCI: Bridge: 0000:00:03.0
[    0.716000]   IO window: 4000-4fff
[    0.716000]   MEM window: c4000000-c40fffff
[    0.716000]   PREFETCH window: disabled.
[    0.716000] PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:03:00.0
[    0.716000] PCI: Bridge: 0000:00:04.0
[    0.716000]   IO window: 5000-5fff
[    0.716000]   MEM window: c1000000-c2ffffff
[    0.716000]   PREFETCH window: d0000000-dfffffff
[    0.716000] PCI: Bus 5, cardbus bridge: 0000:04:06.0
[    0.716000]   IO window: 00006000-000060ff
[    0.716000]   IO window: 00006400-000064ff
[    0.716000]   PREFETCH window: 50000000-53ffffff
[    0.716000]   MEM window: 54000000-57ffffff
[    0.716000] PCI: Bridge: 0000:00:10.0
[    0.716000]   IO window: 6000-6fff
[    0.716000]   MEM window: c3000000-c30fffff
[    0.716000]   PREFETCH window: 50000000-53ffffff
[    0.716000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.716000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    0.716000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    0.716000] PCI: Setting latency timer of device 0000:00:10.0 to 64
[    0.716000] ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
[    0.716000] ACPI: PCI Interrupt 0000:04:06.0[A] -> Link [LNK4] -> GSI 11 (level, low) -> IRQ 11
[    0.716000] NET: Registered protocol family 2
[    0.760000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.760000] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[    0.760000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.760000] TCP: Hash tables configured (established 131072 bind 65536)
[    0.760000] TCP reno registered
[    0.776000] checking if image is initramfs... it is
[    1.484000] Freeing initrd memory: 7063k freed
[    1.484000] Simple Boot Flag at 0x36 set to 0x1
[    1.484000] audit: initializing netlink socket (disabled)
[    1.484000] audit(1194876437.188:1): initialized
[    1.484000] highmem bounce pool size: 64 pages
[    1.488000] VFS: Disk quotas dquot_6.5.1
[    1.488000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.488000] io scheduler noop registered
[    1.488000] io scheduler anticipatory registered
[    1.488000] io scheduler deadline registered
[    1.488000] io scheduler cfq registered (default)
[    1.508000] Boot video device is 0000:03:00.0
[    1.508000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    1.508000] assign_interrupt_mode Found MSI capability
[    1.508000] Allocate Port Service[0000:00:02.0:pcie00]
[    1.508000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    1.508000] assign_interrupt_mode Found MSI capability
[    1.508000] Allocate Port Service[0000:00:03.0:pcie00]
[    1.508000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    1.508000] assign_interrupt_mode Found MSI capability
[    1.508000] Allocate Port Service[0000:00:04.0:pcie00]
[    1.508000] isapnp: Scanning for PnP cards...
[    1.860000] isapnp: No Plug & Play device found
[    1.888000] Real Time Clock Driver v1.12ac
[    1.888000] hpet_resources: 0xfed00000 is busy
[    1.888000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.888000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.888000] input: Macintosh mouse button emulation as /class/input/input0
[    1.888000] PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.888000] i8042.c: Detected active multiplexing controller, rev 1.1.
[    1.888000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.888000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.888000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.888000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.888000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.888000] mice: PS/2 mouse device common for all mice
[    1.888000] EISA: Probing bus 0 at eisa.0
[    1.888000] Cannot allocate resource for EISA slot 1
[    1.888000] Cannot allocate resource for EISA slot 2
[    1.888000] Cannot allocate resource for EISA slot 3
[    1.888000] Cannot allocate resource for EISA slot 4
[    1.888000] Cannot allocate resource for EISA slot 5
[    1.888000] Cannot allocate resource for EISA slot 6
[    1.888000] EISA: Detected 0 cards.
[    1.888000] TCP cubic registered
[    1.888000] NET: Registered protocol family 1
[    1.888000] Using IPI No-Shortcut mode
[    1.888000]   Magic number: 15:480:131
[    1.888000]   hash matches device device:06
[    1.888000] Freeing unused kernel memory: 364k freed
[    1.896000] input: AT Translated Set 2 keyboard as /class/input/input1
[    3.152000] AppArmor: AppArmor initialized<5>audit(1194876439.188:2):  type=1505 info="AppArmor initialized" pid=1251
[    3.160000] fuse init (API version 7.8)
[    3.168000] Failure registering capabilities with primary security module.
[    3.200000] ACPI: Thermal Zone [TZS0] (52 C)
[    3.204000] ACPI: Thermal Zone [TZS1] (55 C)
[    3.872000] usbcore: registered new interface driver usbfs
[    3.872000] usbcore: registered new interface driver hub
[    3.872000] usbcore: registered new device driver usb
[    3.872000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.872000] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 23
[    3.872000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LUS0] -> GSI 23 (level, high) -> IRQ 16
[    3.872000] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    3.872000] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[    3.872000] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[    3.872000] ohci_hcd 0000:00:0b.0: irq 16, io mem 0xc0004000
[    3.888000] SCSI subsystem initialized
[    3.896000] libata version 2.21 loaded.
[    3.936000] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[    3.944000] usb usb1: configuration #1 chosen from 1 choice
[    3.944000] hub 1-0:1.0: USB hub found
[    3.944000] hub 1-0:1.0: 8 ports detected
[    4.008000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    4.008000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    4.052000] sata_nv 0000:00:0e.0: version 3.4
[    4.052000] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
[    4.052000] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LTID] -> GSI 22 (level, high) -> IRQ 17
[    4.052000] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    4.052000] scsi0 : sata_nv
[    4.056000] scsi1 : sata_nv
[    4.056000] ata1: SATA max UDMA/133 cmd 0x000130b0 ctl 0x000130a6 bmdma 0x00013090 irq 17
[    4.056000] ata2: SATA max UDMA/133 cmd 0x000130a8 ctl 0x000130a2 bmdma 0x00013098 irq 17
[    4.356000] usb 1-6: new full speed USB device using ohci_hcd and address 2
[    4.532000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.540000] ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC70P, max UDMA/100
[    4.540000] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    4.564000] ata1.00: configured for UDMA/100
[    4.724000] usb 1-6: configuration #1 chosen from 1 choice
[    4.876000] ata2: SATA link down (SStatus 0 SControl 300)
[    4.880000] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[    4.884000] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 21
[    4.884000] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LMAC] -> GSI 21 (level, high) -> IRQ 18
[    4.884000] PCI: Setting latency timer of device 0000:00:14.0 to 64
[    4.884000] forcedeth: using HIGHDMA
[    5.056000] usb 1-8: new full speed USB device using ohci_hcd and address 3
[    5.272000] usb 1-8: configuration #1 chosen from 1 choice
[    5.300000] usbcore: registered new interface driver libusual
[    5.304000] Initializing USB Mass Storage driver...
[    5.304000] scsi2 : SCSI emulation for USB Mass Storage devices
[    5.304000] usb-storage: device found at 3
[    5.304000] usb-storage: waiting for device to settle before scanning
[    5.304000] usbcore: registered new interface driver usb-storage
[    5.304000] USB Mass Storage support registered.
[    5.404000] eth0: forcedeth.c: subsystem: 01025:0112 bound to 0000:00:14.0
[    5.404000] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[    5.404000] NFORCE-MCP51: chipset revision 241
[    5.404000] NFORCE-MCP51: not 100% native mode: will probe irqs later
[    5.404000] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
[    5.404000] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[    5.404000]     ide0: BM-DMA at 0x3080-0x3087, BIOS settings: hda:pio, hdb:pio
[    5.404000]     ide1: BM-DMA at 0x3088-0x308f, BIOS settings: hdc:DMA, hdd:pio
[    5.404000] Probing IDE interface ide0...
[    5.416000] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    5.416000] sd 0:0:0:0: [sda] Write Protect is off
[    5.416000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.416000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.416000] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    5.416000] sd 0:0:0:0: [sda] Write Protect is off
[    5.416000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.416000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.416000]  sda: sda1 sda2 sda3 < sda5 sda6 >
[    5.488000] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.492000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.788000] Attempting manual resume
[    5.788000] swsusp: Resume From Partition 8:5
[    5.788000] PM: Checking swsusp image.
[    5.792000] PM: Resume from disk failed.
[    5.828000] kjournald starting.  Commit interval 5 seconds
[    5.828000] EXT3-fs: mounted filesystem with ordered data mode.
[    5.972000] Probing IDE interface ide1...
[    6.708000] hdc: Slimtype DVDRW SSM-8515S, ATAPI CD/DVD-ROM drive
[    7.380000] ide1 at 0x170-0x177,0x376 on irq 15
[    7.408000] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
[    7.408000] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LUS2] -> GSI 20 (level, high) -> IRQ 19
[    7.408000] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[    7.408000] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    7.408000] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
[    7.408000] ehci_hcd 0000:00:0b.1: debug port 1
[    7.408000] PCI: cache line size of 64 is not supported by device 0000:00:0b.1
[    7.412000] ehci_hcd 0000:00:0b.1: irq 19, io mem 0xc0005000
[    7.412000] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    7.412000] usb 1-6: USB disconnect, address 2
[    7.412000] usb usb2: configuration #1 chosen from 1 choice
[    7.412000] hub 2-0:1.0: USB hub found
[    7.412000] hub 2-0:1.0: 8 ports detected
[    7.548000] usb 1-8: USB disconnect, address 3
[    7.936000] usb 2-6: new high speed USB device using ehci_hcd and address 2
[    8.320000] usb 2-6: configuration #1 chosen from 1 choice
[    8.576000] usb 2-8: new high speed USB device using ehci_hcd and address 3
[    8.712000] usb 2-8: configuration #1 chosen from 1 choice
[    8.712000] scsi3 : SCSI emulation for USB Mass Storage devices
[    8.712000] usb-storage: device found at 3
[    8.712000] usb-storage: waiting for device to settle before scanning
[   13.712000] usb-storage: device scan complete
[   13.712000] scsi 3:0:0:0: Direct-Access     HP       Photosmart C4180 1.00 PQ: 0 ANSI: 2
[   13.724000] sd 3:0:0:0: [sdb] Attached SCSI removable disk
[   13.724000] sd 3:0:0:0: Attached scsi generic sg1 type 0
[   14.556000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   14.556000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   14.732000] ath_hal: module license 'Proprietary' taints kernel.
[   14.732000] ath_hal: 0.9.18.0 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
[   14.872000] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x3040
[   14.872000] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x3000
[   15.048000] wlan: 0.8.4.2 (0.9.3.2)
[   15.104000] Yenta: CardBus bridge found at 0000:04:06.0 [1025:0112]
[   15.104000] Yenta: Using CSCINT to route CSC interrupts to PCI
[   15.104000] Yenta: Routing CardBus interrupts to PCI
[   15.104000] Yenta TI: socket 0000:04:06.0, mfunc 0x013a1b22, devctl 0x64
[   15.124000] Linux agpgart interface v0.102 (c) Dave Jones
[   15.200000] ath_pci: 0.9.4.5 (0.9.3.2)
[   15.348000] Yenta: ISA IRQ mask 0x04f8, PCI irq 11
[   15.348000] Socket status: 30000006
[   15.348000] Yenta: Raising subordinate bus# of parent bus (#04) from #05 to #08
[   15.348000] pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
[   15.348000] cs: IO port probe 0x6000-0x6fff: clean.
[   15.348000] pcmcia: parent PCI bridge Memory window: 0xc3000000 - 0xc30fffff
[   15.348000] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
[   15.348000] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 19
[   15.348000] ACPI: PCI Interrupt 0000:04:05.0[A] -> Link [LNK2] -> GSI 19 (level, high) -> IRQ 20
[   15.656000] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1280b1, caps: 0xa04713/0x204000
[   15.688000] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[   16.068000] input: PC Speaker as /class/input/input3
[   16.348000] Linux video capture interface: v2.00
[   16.424000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 1 alt 0 proto 2 vid 0x03F0 pid 0x5711
[   16.424000] usbcore: registered new interface driver usblp
[   16.424000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   16.436000] ath_rate_sample: 1.2 (0.9.3.2)
[   16.468000] uvcvideo: Found UVC 1.00 device USB2.0 Camera (5986:0100)
[   16.468000] hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   16.468000] Uniform CD-ROM driver Revision: 3.20
[   16.524000] wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
[   16.524000] wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
[   16.524000] wifi0: H/W encryption support: WEP AES AES_CCM TKIP
[   16.524000] wifi0: mac 7.8 phy 4.5 radio 5.6
[   16.524000] wifi0: Use hw queue 1 for WME_AC_BE traffic
[   16.524000] wifi0: Use hw queue 0 for WME_AC_BK traffic
[   16.524000] wifi0: Use hw queue 2 for WME_AC_VI traffic
[   16.524000] wifi0: Use hw queue 3 for WME_AC_VO traffic
[   16.524000] wifi0: Use hw queue 8 for CAB traffic
[   16.524000] wifi0: Use hw queue 9 for beacons
[   16.548000] usbcore: registered new interface driver uvcvideo
[   16.548000] USB Video Class driver (v0.1.0)
[   16.556000] wifi0: Atheros 5212: mem=0xc3000000, irq=20
[   16.556000] ACPI: PCI Interrupt 0000:04:06.2[A] -> Link [LNK4] -> GSI 11 (level, low) -> IRQ 11
[   16.556000] ACPI: PCI Interrupt Link [LK1E] enabled at IRQ 18
[   16.556000] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LK1E] -> GSI 18 (level, high) -> IRQ 21
[   16.556000] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   16.556000] NVRM: loading NVIDIA UNIX x86 Kernel Module  100.14.19  Wed Sep 12 14:12:24 PDT 2007
[   16.780000] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 17
[   16.780000] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LAZA] -> GSI 17 (level, high) -> IRQ 22
[   16.780000] PCI: Setting latency timer of device 0000:00:10.1 to 64
[   16.876000] cs: IO port probe 0x100-0x3af: clean.
[   16.880000] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[   16.880000] cs: IO port probe 0x820-0x8ff: clean.
[   16.880000] cs: IO port probe 0xc00-0xcf7: clean.
[   16.880000] cs: IO port probe 0xa00-0xaff: clean.
[   17.520000] loop: module loaded
[   17.560000] lp: driver loaded but no devices found
[   17.660000] Adding 2931820k swap on /dev/sda5.  Priority:-1 extents:1 across:2931820k
[   18.132000] EXT3 FS on sda6, internal journal
[   18.588000] hda_intel: azx_get_response timeout, switching to polling mode...
[   19.504000] No dock devices found.
[   19.520000] ACPI: AC Adapter [ADP1] (off-line)
[   19.632000] input: Power Button (FF) as /class/input/input4
[   19.632000] ACPI: Power Button (FF) [PWRF]
[   19.632000] input: Lid Switch as /class/input/input5
[   19.632000] ACPI: Lid Switch [LID0]
[   19.632000] input: Sleep Button (CM) as /class/input/input6
[   19.632000] ACPI: Sleep Button (CM) [SLPB]
[   19.632000] input: Power Button (CM) as /class/input/input7
[   19.632000] ACPI: Power Button (CM) [PWRB]
[   19.824000] ACPI: Battery Slot [BAT0] (battery present)
[   19.860000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   19.860000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   20.108000] powernow-k8: Found 2 AMD Turion(tm) 64 X2 Mobile Technology TL-52 processors (version 2.00.00)
[   20.108000] powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x13
[   20.108000] powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x1e
[   21.200000] ppdev: user-space parallel port driver
[   21.460000] audit(1194876457.569:3):  type=1503 operation="inode_permission" requested_mask="a" denied_mask="a" name="/dev/tty" pid=5097 profile="/usr/sbin/cupsd"
[   21.492000] apm: BIOS not found.
[   21.876000] eth0: no link during initialization.
[   22.200000] Failure registering capabilities with primary security module.
[   23.000000] Clocksource tsc unstable (delta = -250036454 ns)
[   23.016000] Bluetooth: Core ver 2.11
[   23.016000] NET: Registered protocol family 31
[   23.016000] Bluetooth: HCI device and connection manager initialized
[   23.016000] Bluetooth: HCI socket layer initialized
[   23.060000] Bluetooth: L2CAP ver 2.8
[   23.060000] Bluetooth: L2CAP socket layer initialized
[   23.176000] Bluetooth: RFCOMM socket layer initialized
[   23.176000] Bluetooth: RFCOMM TTY layer initialized
[   23.176000] Bluetooth: RFCOMM ver 1.8
[   68.244000] NET: Registered protocol family 17
[   77.656000] NET: Registered protocol family 10
[   77.656000] lo: Disabled Privacy Extensions
[   77.656000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   88.372000] ath0: no IPv6 routers present

--------------090502010107070605060300
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.9
SMBIOS 2.4 present.
27 structures occupying 947 bytes.
Table at 0x3FF6B000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: V1.19
	Release Date: 05/15/2007
	Address: 0xE5C60
	Runtime Size: 107424 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		ACPI is supported
		USB legacy is supported
		AGP is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Acer
	Product Name: TravelMate 7510
	Version: 0100           
	Serial Number: LXTJW0X00171001A6E2000
	UUID: 939548E0-CC09-11DB-8865-A7743EFADFDD
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer
	Product Name: Myallm                         
	Version: Rev            
	Serial Number: LXTJW0X00171001A6E2000

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Acer                                
	Type: Notebook
	Lock: Not Present
	Version: N/A            
	Serial Number: None           
	Asset Tag: None                            
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U1
	Type: Central Processor
	Family: Athlon XP
	Manufacturer: AMD
	ID: 82 0F 04 00 FF FB 8B 17
	Signature: Family 15, Model 72, Stepping 2
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Hyper-threading technology)
	Version: AMD Turion(tm) 64
	Voltage: 3.3 V
	External Clock: 800 MHz
	Max Speed: 500 MHz
	Current Speed: 1600 MHz
	Status: Populated, Enabled
	Upgrade: Socket 754
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 16 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 1024 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCMCIA Slot CBUS1
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Long
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: HD-Audio

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: Nvidia

Handle 0x000A, DMI type 15, 29 bytes
System Event Log
	Area Length: 0 bytes
	Header Start Offset: 0x0000
	Data Start Offset: 0x0000
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Invalid, Not Full
	Change Token: 0x00000000
	Header Format: No Header
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000E, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x000B
	Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000E
	Partition Row Position: 1

Handle 0x0010, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0011, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Disabled
	Front Panel Reset Status: Unknown

Handle 0x0012, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0013, DMI type 26, 20 bytes
Voltage Probe
	Description: Voltage Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0014, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x0015
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x0015, DMI type 28, 20 bytes
Temperature Probe
	Description: Temperature Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0016, DMI type 29, 20 bytes
Electrical Current Probe
	Description: Electrical Current Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0017, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0018, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0019, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 19 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x001A, DMI type 127, 4 bytes
End Of Table


--------------090502010107070605060300
Content-Type: text/plain;
 name="lspci-vvv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-vvv.txt"

00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
		Link Config 1: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.03
		Link Frequency 0: 800MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 800MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [e0] HyperTransport: MSI Mapping

00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-

00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #00 [00fe]
	Capabilities: [fc] #00 [0000]

00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn+ PwrFlt+ MRL- PresDet- CmdCplt- HPIrq+
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: c4000000-c40fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn+ PwrFlt+ MRL- PresDet- CmdCplt- HPIrq+
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: c1000000-c2ffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=9 UnitCnt=15 MastHost- DefDir- DUL-
		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
		Link Config 0: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.03
		Link Frequency 0: 800MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [e0] HyperTransport: MSI Mapping

00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 3040 [size=64]
	Region 5: I/O ports at 3000 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.3 Co-processor: nVidia Corporation MCP51 PMU (rev a3)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at c0040000 (32-bit, non-prefetchable) [size=256K]

00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at c0004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at c0005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev f1) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 3080 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev f1) (prog-if 85 [Master SecO PriO])
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 30b0 [size=8]
	Region 1: I/O ports at 30a4 [size=4]
	Region 2: I/O ports at 30a8 [size=8]
	Region 3: I/O ports at 30a0 [size=4]
	Region 4: I/O ports at 3090 [size=16]
	Region 5: Memory at c0006000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [cc] HyperTransport: MSI Mapping

00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=04, subordinate=08, sec-latency=64
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: c3000000-c30fffff
	Prefetchable memory behind bridge: 50000000-53ffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR+
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [b8] Subsystem: Gammagraphx, Inc. Unknown device 0000
	Capabilities: [8c] HyperTransport: MSI Mapping

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a2)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [6c] HyperTransport: MSI Mapping

00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a3)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at c0007000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 30b8 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=8
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [f0] #0f [0010]

03:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce Go 7600] (rev a1) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at c2000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at c1000000 (64-bit, non-prefetchable) [size=16M]
	Region 5: I/O ports at 5000 [size=128]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <1us, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM L0s L1 Enabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16

04:05.0 Ethernet controller: Atheros Communications, Inc. AR2413 802.11bg NIC (rev 01)
	Subsystem: AMBIT Microsystem Corp. Unknown device 0418
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168 (2500ns min, 7000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at c3000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

04:06.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 128 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c3010000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=04, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 50000000-53fff000 (prefetchable)
	Memory window 1: 54000000-57fff000
	I/O window 0: 00006000-000060ff
	I/O window 1: 00006400-000064ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

04:06.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card Reader (SD/MMC/MS/MS PRO/xD)
	Subsystem: Acer Incorporated [ALI] Unknown device 0112
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c3012000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------090502010107070605060300--
