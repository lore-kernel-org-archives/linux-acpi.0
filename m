From: Todd Tupper <todd.tupper@gmail.com>
Subject: ACPI info
Date: Fri, 08 Aug 2008 00:06:56 +0200
Message-ID: <489B7200.8060304@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050403020702030502030103"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:53135 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYHGWIE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 18:08:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so380413fgg.17
        for <linux-acpi@vger.kernel.org>; Thu, 07 Aug 2008 15:08:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403020702030502030103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a phoenix bios and my laptop always runs hot and very poor 
battery life.  Is there anyway around this or am I stuck with it?  I 
guess, do you know?  Anyway, here is the data.

todd

ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Gateway
ACPI: DMI Product Name: T-1628
ACPI: DMI Product Version: 90.03   
ACPI: DMI Board Name:         
ACPI: DMI BIOS Vendor: Gateway
ACPI: DMI BIOS Date: 09/27/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: If "acpi_osi=Linux" works better, please notify 
linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing


--------------050403020702030502030103
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.25-gentoo-r7.b5 (root@kupo) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.2)) #5 SMP Wed Aug 6 23:04:25 CEST 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000097e80000 (usable)
 BIOS-e820: 0000000097e80000 - 0000000097e90000 (ACPI data)
 BIOS-e820: 0000000097e90000 - 0000000097e92000 (ACPI NVS)
 BIOS-e820: 0000000097e92000 - 00000000b0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000110000000 (usable)
Warning only 4GB will be used.
Use a HIGHMEM64G enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at [c00f8000] 000f8000
Entering add_active_range(0, 0, 1048576) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->  1048576
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->  1048576
On node 0 totalpages: 1048576
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 6400 pages used for memmap
  HighMem zone: 812800 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI present.
ACPI: RSDP 000F7FD0, 0024 (r2 PTLTD )
ACPI: XSDT 97E89632, 0054 (r1 GATEWA SYSTEM    6040000  LTP        0)
ACPI: FACP 97E8FA5A, 00F4 (r3 ATI    Herring   6040000 ATI     F4240)
ACPI: DSDT 97E89686, 63D4 (r1 GATEWA SYSTEM    6040000 MSFT  3000000)
ACPI: FACS 97E91FC0, 0040
ACPI: TCPA 97E8FBC2, 0032 (r2 AMD              6040000 PTEC        0)
ACPI: SSDT 97E8FBF4, 0206 (r1 PTLTD  POWERNOW  6040000  LTP        1)
ACPI: SLIC 97E8FDFA, 0176 (r1 GATEWA SYSTEM    6040000 *TK*        1)
ACPI: APIC 97E8FF70, 0054 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: MCFG 97E8FFC4, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
ATI board detected. Disabling timer routing over 8254.
Detected use of extended apic ids on hypertransport bus
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:8 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at b4000000 (gap: b0000000:30000000)
PM: Registered nosave memory: 000000000009d000 - 000000000009e000
PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000d0000
PM: Registered nosave memory: 00000000000d0000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1040384
Kernel command line: vga=0x323 real_root=/dev/sda2 pci=usepirqmask
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2000.054 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2448164k/4194304k available (3542k kernel code, 39556k reserved, 1385k data, 340k init, 1571328k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc06d8000 - 0xc072d000   ( 340 kB)
      .data : 0xc0575939 - 0xc06cfd98   (1385 kB)
      .text : 0xc0200000 - 0xc0575939   (3542 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 4067.69 BogoMIPS (lpj=2033849)
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Core 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
CPU0: AMD Turion(tm) 64 X2 Mobile Technology TL-60 stepping 02
Booting processor 1/1 ip 4000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3999.43 BogoMIPS (lpj=1999716)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Core 1
AMD C1E detected late. 	Force timer broadcast.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Turion(tm) 64 X2 Mobile Technology TL-60 stepping 02
Total of 2 processors activated (8067.13 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Brought up 2 CPUs
PM: Adding info for No Bus:platform
net_namespace: 544 bytes
Time: 20:51:08  Date: 08/07/08
NET: Registered protocol family 16
PM: Adding info for No Bus:vtcon0
No dock devices found.
EISA bus registered
ACPI: bus type pci registered
PM: Adding info for No Bus:id
PCI: Using MMCONFIG for extended config space
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Gateway
ACPI: DMI Product Name: T-1628
ACPI: DMI Product Version: 90.03   
ACPI: DMI Board Name:         
ACPI: DMI BIOS Vendor: Gateway
ACPI: DMI BIOS Date: 09/27/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:LNXSYSTM:00
PM: Adding info for acpi:LNXPWRBN:00
PM: Adding info for acpi:ACPI0007:00
PM: Adding info for acpi:ACPI0007:01
PM: Adding info for acpi:device:00
PM: Adding info for acpi:PNP0C0C:00
PM: Adding info for acpi:PNP0C0E:00
PM: Adding info for acpi:PNP0C0D:00
PM: Adding info for acpi:PNP0A08:00
PM: Adding info for acpi:PNP0C02:00
PM: Adding info for acpi:device:01
PM: Adding info for acpi:device:02
PM: Adding info for acpi:device:03
PM: Adding info for acpi:device:04
PM: Adding info for acpi:device:05
PM: Adding info for acpi:device:06
PM: Adding info for acpi:device:07
PM: Adding info for acpi:device:08
PM: Adding info for acpi:device:09
PM: Adding info for acpi:device:0a
PM: Adding info for acpi:device:0b
PM: Adding info for acpi:device:0c
PM: Adding info for acpi:device:0d
PM: Adding info for acpi:device:0e
PM: Adding info for acpi:device:0f
PM: Adding info for acpi:device:10
PM: Adding info for acpi:device:11
PM: Adding info for acpi:device:12
PM: Adding info for acpi:device:13
PM: Adding info for acpi:device:14
PM: Adding info for acpi:device:15
PM: Adding info for acpi:device:16
PM: Adding info for acpi:device:17
PM: Adding info for acpi:device:18
PM: Adding info for acpi:PNP0C0F:00
PM: Adding info for acpi:PNP0C0F:01
PM: Adding info for acpi:PNP0C0F:02
PM: Adding info for acpi:PNP0C0F:03
PM: Adding info for acpi:PNP0C0F:04
PM: Adding info for acpi:PNP0C0F:05
PM: Adding info for acpi:PNP0C0F:06
PM: Adding info for acpi:PNP0C0F:07
PM: Adding info for acpi:PNP0200:00
PM: Adding info for acpi:PNP0C04:00
PM: Adding info for acpi:PNP0000:00
PM: Adding info for acpi:PNP0B00:00
PM: Adding info for acpi:PNP0800:00
PM: Adding info for acpi:PNP0100:00
PM: Adding info for acpi:PNP0303:00
PM: Adding info for acpi:PNP0F13:00
PM: Adding info for acpi:PNP0C02:01
PM: Adding info for acpi:PNP0C01:00
PM: Adding info for acpi:ACPI0003:00
ACPI: EC: non-query interrupt received, switching to interrupt mode
PM: Adding info for acpi:PNP0C0A:00
PM: Adding info for acpi:device:19
PM: Adding info for acpi:device:1a
PM: Adding info for acpi:device:1b
PM: Adding info for acpi:device:1c
PM: Adding info for acpi:device:1d
PM: Adding info for acpi:device:1e
PM: Adding info for acpi:device:1f
PM: Adding info for acpi:PNP0C09:00
PM: Adding info for acpi:PNP0C32:00
PM: Adding info for acpi:PNP0C32:01
PM: Adding info for acpi:PNP0C32:02
PM: Adding info for acpi:LNXTHERM:00
ACPI: EC: GPE = 0x10, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for No Bus:0000:00
pci 0000:00:12.0: set SATA to AHCI mode
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB5_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB7_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:05.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:12.0
PM: Adding info for pci:0000:00:13.0
PM: Adding info for pci:0000:00:13.1
PM: Adding info for pci:0000:00:13.2
PM: Adding info for pci:0000:00:13.3
PM: Adding info for pci:0000:00:13.4
PM: Adding info for pci:0000:00:13.5
PM: Adding info for pci:0000:00:14.0
PM: Adding info for pci:0000:00:14.1
PM: Adding info for pci:0000:00:14.2
PM: Adding info for pci:0000:00:14.3
PM: Adding info for pci:0000:00:14.4
PM: Adding info for pci:0000:00:18.0
PM: Adding info for pci:0000:00:18.1
PM: Adding info for pci:0000:00:18.2
PM: Adding info for pci:0000:00:18.3
PM: Adding info for pci:0000:01:05.0
PM: Adding info for pci:0000:01:05.2
PM: Adding info for No Bus:0000:01
PM: Adding info for No Bus:0000:02
PM: Adding info for pci:0000:08:00.0
PM: Adding info for No Bus:0000:08
PM: Adding info for No Bus:0000:0e
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
ACPI: bus type pnp registered
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
 00:09: mem resource (0xe0000-0xfffff) overlaps 0000:00:05.0 BAR 8 (0x0-0xfffff), disabling
PM: Adding info for pnp:00:09
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0
Bluetooth: Core ver 2.11
PM: Adding info for platform:bluetooth
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
system 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:01: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:08: ioport range 0x1080-0x1080 has been reserved
system 00:08: ioport range 0x200-0x20f has been reserved
system 00:08: ioport range 0x220-0x22f has been reserved
system 00:08: ioport range 0x40b-0x40b has been reserved
system 00:08: ioport range 0x4d0-0x4d1 has been reserved
system 00:08: ioport range 0x4d6-0x4d6 has been reserved
system 00:08: ioport range 0x530-0x537 has been reserved
system 00:08: ioport range 0xc00-0xc01 has been reserved
system 00:08: ioport range 0xc14-0xc14 has been reserved
system 00:08: ioport range 0xc50-0xc52 has been reserved
system 00:08: ioport range 0xc6c-0xc6c has been reserved
system 00:08: ioport range 0xc6f-0xc6f has been reserved
system 00:08: ioport range 0xcd0-0xcd1 has been reserved
system 00:08: ioport range 0xcd2-0xcd3 has been reserved
system 00:08: ioport range 0xcd4-0xcd5 has been reserved
system 00:08: ioport range 0xcd6-0xcd7 has been reserved
system 00:08: ioport range 0xcd8-0xcdf has been reserved
system 00:08: ioport range 0x8000-0x805f has been reserved
system 00:08: ioport range 0xf40-0xf47 has been reserved
system 00:08: ioport range 0x87f-0x87f has been reserved
system 00:09: iomem range 0xfff00000-0xffffffff could not be reserved
system 00:09: iomem range 0xffb83020-0xffb8401f has been reserved
system 00:09: iomem range 0xfed00000-0xfed003ff has been reserved
system 00:09: iomem range 0x0-0x0 could not be reserved
PM: Adding info for No Bus:lo
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: 0xcfd00000-0xcfefffff
  PREFETCH window: 0x00000000b0000000-0x00000000bfffffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: a000-afff
  MEM window: 0xf0200000-0xf02fffff
  PREFETCH window: 0x00000000c0000000-0x00000000c00fffff
PCI: Bridge: 0000:00:14.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
NET: Registered protocol family 2
Clockevents: could not switch to one-shot mode:<6>Clockevents: could not switch to one-shot mode: lapic is not functional.
Could not switch to high resolution mode on CPU 1
 lapic is not functional.
Could not switch to high resolution mode on CPU 0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for No Bus:msr0
PM: Adding info for No Bus:msr1
PM: Adding info for No Bus:cpu0
PM: Adding info for No Bus:cpu1
PM: Adding info for No Bus:snapshot
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.29 [Flags: R/O].
fuse init (API version 7.9)
PM: Adding info for No Bus:fuse
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered (default)
pci 0000:01:05.0: Boot video device
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
PM: Adding info for pci_express:0000:00:05.0:pcie00
Allocate Port Service[0000:00:05.0:pcie02]
PM: Adding info for pci_express:0000:00:05.0:pcie02
Allocate Port Service[0000:00:05.0:pcie03]
PM: Adding info for pci_express:0000:00:05.0:pcie03
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
PM: Adding info for pci_express:0000:00:07.0:pcie00
Allocate Port Service[0000:00:07.0:pcie03]
PM: Adding info for pci_express:0000:00:07.0:pcie03
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
cpcihp_generic: not configured, disabling.
pciehp: HPC vendor_id 1002 device_id 7915 ss_vid 0 ss_did 0
Load service driver hpdriver on pcie device 0000:00:05.0:pcie02
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
PM: Adding info for No Bus:tty
PM: Adding info for No Bus:console
PM: Adding info for No Bus:ptmx
PM: Adding info for No Bus:tty0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:tty1
PM: Adding info for No Bus:tty2
PM: Adding info for No Bus:tty3
PM: Adding info for No Bus:tty4
PM: Adding info for No Bus:tty5
PM: Adding info for No Bus:tty6
PM: Adding info for No Bus:tty7
PM: Adding info for No Bus:tty8
PM: Adding info for No Bus:tty9
PM: Adding info for No Bus:tty10
PM: Adding info for No Bus:tty11
PM: Adding info for No Bus:tty12
PM: Adding info for No Bus:tty13
PM: Adding info for No Bus:tty14
PM: Adding info for No Bus:tty15
PM: Adding info for No Bus:tty16
PM: Adding info for No Bus:tty17
PM: Adding info for No Bus:tty18
PM: Adding info for No Bus:tty19
PM: Adding info for No Bus:tty20
PM: Adding info for No Bus:tty21
PM: Adding info for No Bus:tty22
PM: Adding info for No Bus:tty23
PM: Adding info for No Bus:tty24
PM: Adding info for No Bus:tty25
PM: Adding info for No Bus:tty26
PM: Adding info for No Bus:tty27
PM: Adding info for No Bus:tty28
PM: Adding info for No Bus:tty29
PM: Adding info for No Bus:tty30
PM: Adding info for No Bus:tty31
PM: Adding info for No Bus:tty32
PM: Adding info for No Bus:tty33
PM: Adding info for No Bus:tty34
PM: Adding info for No Bus:tty35
PM: Adding info for No Bus:tty36
PM: Adding info for No Bus:tty37
PM: Adding info for No Bus:tty38
PM: Adding info for No Bus:tty39
PM: Adding info for No Bus:tty40
PM: Adding info for No Bus:tty41
PM: Adding info for No Bus:tty42
PM: Adding info for No Bus:tty43
PM: Adding info for No Bus:tty44
PM: Adding info for No Bus:tty45
PM: Adding info for No Bus:tty46
PM: Adding info for No Bus:tty47
PM: Adding info for No Bus:tty48
PM: Adding info for No Bus:tty49
PM: Adding info for No Bus:tty50
PM: Adding info for No Bus:tty51
PM: Adding info for No Bus:tty52
PM: Adding info for No Bus:tty53
PM: Adding info for No Bus:tty54
PM: Adding info for No Bus:tty55
PM: Adding info for No Bus:tty56
PM: Adding info for No Bus:tty57
PM: Adding info for No Bus:tty58
PM: Adding info for No Bus:tty59
PM: Adding info for No Bus:tty60
PM: Adding info for No Bus:tty61
PM: Adding info for No Bus:tty62
PM: Adding info for No Bus:tty63
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
ipmi message handler version 39.1
ipmi device interface
IPMI System Interface driver.
ipmi_si: Unable to find any System Interface(s)
IPMI Watchdog: driver initialized
Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
PM: Adding info for No Bus:fbcon
PM: Adding info for platform:vesafb.0
vesafb: framebuffer at 0xb0000000, mapped to 0xf8880000, using 6144k, total 16384k
vesafb: mode is 1024x768x32, linelength=4096, pages=4
vesafb: protected mode interface info at c000:9f48
vesafb: pmi: set display start = c00c9fd2, set palette = c00ca090
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
PM: Adding info for No Bus:fb0
PM: Adding info for No Bus:vtcon1
Console: switching to colour frame buffer device 128x48
PM: Adding info for No Bus:fbcondecor
fb0: VESA VGA frame buffer device
PM: Adding info for No Bus:AC
ACPI: AC Adapter [AC] (on-line)
PM: Adding info for No Bus:BAT0
ACPI: Battery Slot [BAT0] (battery present)
PM: Adding info for No Bus:input0
input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button (FF) [PWRF]
PM: Adding info for No Bus:input1
input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
ACPI: Power Button (CM) [PWRB]
PM: Adding info for No Bus:input2
input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
ACPI: Sleep Button (CM) [SLPB]
PM: Adding info for No Bus:input3
input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input3
ACPI: Lid Switch [LID]
PM: Adding info for No Bus:acpi_video0
PM: Adding info for No Bus:acpi_video1
PM: Adding info for No Bus:acpi_video2
PM: Adding info for No Bus:input4
input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:1b/device:1c/input/input4
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PM: Adding info for No Bus:isa
PM: Adding info for No Bus:loop0
PM: Adding info for No Bus:loop1
PM: Adding info for No Bus:loop2
PM: Adding info for No Bus:loop3
PM: Adding info for No Bus:loop4
PM: Adding info for No Bus:loop5
PM: Adding info for No Bus:loop6
PM: Adding info for No Bus:loop7
loop: module loaded
PM: Adding info for No Bus:pktcdvd
nbd: registered device at major 43
PM: Adding info for No Bus:nbd0
PM: Adding info for No Bus:nbd1
PM: Adding info for No Bus:nbd2
PM: Adding info for No Bus:nbd3
PM: Adding info for No Bus:nbd4
PM: Adding info for No Bus:nbd5
PM: Adding info for No Bus:nbd6
PM: Adding info for No Bus:nbd7
PM: Adding info for No Bus:nbd8
PM: Adding info for No Bus:nbd9
PM: Adding info for No Bus:nbd10
PM: Adding info for No Bus:nbd11
PM: Adding info for No Bus:nbd12
PM: Adding info for No Bus:nbd13
PM: Adding info for No Bus:nbd14
PM: Adding info for No Bus:nbd15
PM: Adding info for No Bus:dummy0
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
PM: Adding info for No Bus:tun
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:08:00.0 to 64
PM: Adding info for No Bus:eth0
eth0: RTL8101e at 0xf8828000, 00:03:25:59:89:a5, XID 34200000 IRQ 221
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SB600_PATA: IDE controller (0x1002:0x438c rev 0x00) at  PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
SB600_PATA: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8420-0x8427, BIOS settings: hda:DMA, hdb:PIO
Probing IDE interface ide0...
hda: Optiarc DVD RW AD-7563A, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide0
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
PM: Adding info for No Bus:hda
PM: Adding info for No Bus:tgt
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:00:12.0: version 3.0
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part 
scsi0 : ahci
PM: Adding info for No Bus:host0
scsi1 : ahci
PM: Adding info for No Bus:host1
scsi2 : ahci
PM: Adding info for No Bus:host2
scsi3 : ahci
PM: Adding info for No Bus:host3
ata1: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309100 irq 22
ata2: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309180 irq 22
ata3: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309200 irq 22
ata4: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309280 irq 22
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: WDC WD2500BEVS-22UST0, 01.01A01, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEVS-2 01.0 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
PM: Adding info for No Bus:sda
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
PM: Adding info for No Bus:sda1
PM: Adding info for No Bus:sda2
PM: Adding info for No Bus:sda3
PM: Adding info for No Bus:sda4
PM: Adding info for No Bus:sda5
PM: Adding info for No Bus:sda6
PM: Adding info for No Bus:sda7
PM: Adding info for No Bus:sda8
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
PM: Adding info for No Bus:usb_host1
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xf0309400
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25-gentoo-r7.b5 ehci_hcd
usb usb1: SerialNumber: 0000:00:13.5
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
usb 1-1: new high speed USB device using ehci_hcd and address 2
PM: Adding info for No Bus:usb_host2
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xf0304000
PM: Adding info for usb:1-1
PM: Adding info for No Bus:usbdev1.2_ep00
usb 1-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
PM: Adding info for usb:1-1:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.2_ep83
PM: Adding info for usb:1-1:1.1
PM: Adding info for No Bus:usbdev1.2
usb 1-1: New USB device found, idVendor=04f2, idProduct=b027
usb 1-1: New USB device strings: Mfr=2, Product=1, SerialNumber=3
usb 1-1: Product: Gateway USB 2.0 Webcam
usb 1-1: Manufacturer: Chicony Electronics Co., Ltd.
usb 1-1: SerialNumber: SN0001
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.25-gentoo-r7.b5 ohci_hcd
usb usb2: SerialNumber: 0000:00:13.0
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
PM: Adding info for No Bus:usb_host3
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
hub 1-0:1.0: unable to enumerate USB device on port 2
ohci_hcd 0000:00:13.1: irq 17, io mem 0xf0305000
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-3: new high speed USB device using ehci_hcd and address 4
PM: Adding info for usb:1-3
PM: Adding info for No Bus:usbdev1.4_ep00
usb 1-3: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-3:1.0
PM: Adding info for No Bus:usbdev1.4_ep83
PM: Adding info for No Bus:usbdev1.4_ep04
PM: Adding info for No Bus:usbdev1.4_ep05
PM: Adding info for No Bus:usbdev1.4_ep06
PM: Adding info for No Bus:usbdev1.4_ep07
PM: Adding info for No Bus:usbdev1.4_ep89
PM: Adding info for No Bus:usbdev1.4_ep0a
PM: Adding info for No Bus:usbdev1.4_ep0b
PM: Adding info for No Bus:usbdev1.4_ep0c
PM: Adding info for No Bus:usbdev1.4
usb 1-3: New USB device found, idVendor=0bda, idProduct=8189
usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-3: Product: RTL8187B_WLAN_Adapter 
usb 1-3: Manufacturer: Manufacturer_Realtek
usb 1-3: SerialNumber: 00e04c000001
PM: Adding info for No Bus:usbdev3.1_ep81
PM: Adding info for No Bus:usbdev3.1
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.25-gentoo-r7.b5 ohci_hcd
usb usb3: SerialNumber: 0000:00:13.1
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
PM: Adding info for No Bus:usb_host4
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 18, io mem 0xf0306000
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev4.1_ep81
PM: Adding info for No Bus:usbdev4.1
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.25-gentoo-r7.b5 ohci_hcd
usb usb4: SerialNumber: 0000:00:13.2
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
PM: Adding info for No Bus:usb_host5
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.3: irq 17, io mem 0xf0307000
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev5.1_ep81
PM: Adding info for No Bus:usbdev5.1
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: OHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.25-gentoo-r7.b5 ohci_hcd
usb usb5: SerialNumber: 0000:00:13.3
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
PM: Adding info for No Bus:usb_host6
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
ohci_hcd 0000:00:13.4: irq 18, io mem 0xf0308000
PM: Adding info for usb:usb6
PM: Adding info for No Bus:usbdev6.1_ep00
usb usb6: configuration #1 chosen from 1 choice
PM: Adding info for usb:6-0:1.0
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev6.1_ep81
PM: Adding info for No Bus:usbdev6.1
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: OHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.25-gentoo-r7.b5 ohci_hcd
usb usb6: SerialNumber: 0000:00:13.4
usb 1-8: new high speed USB device using ehci_hcd and address 5
PM: Adding info for usb:1-8
PM: Adding info for No Bus:usbdev1.5_ep00
usb 1-8: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-8:1.0
PM: Adding info for No Bus:usbdev1.5_ep01
PM: Adding info for No Bus:usbdev1.5_ep82
PM: Adding info for No Bus:usbdev1.5
usb 1-8: New USB device found, idVendor=0bda, idProduct=0158
usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-8: Product: USB2.0-CRW
usb 1-8: Manufacturer: Generic
usb 1-8: SerialNumber: 20060413092100000
usb 2-2: new low speed USB device using ohci_hcd and address 2
PM: Adding info for usb:2-2
PM: Adding info for No Bus:usbdev2.2_ep00
usb 2-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-2:1.0
PM: Adding info for No Bus:usbdev2.2_ep81
PM: Adding info for No Bus:usbdev2.2
usb 2-2: New USB device found, idVendor=047d, idProduct=1035
usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-2: Product: Kensington USB Mouse
usb 2-2: Manufacturer: Kensington
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
scsi4 : SCSI emulation for USB Mass Storage devices
PM: Adding info for No Bus:host4
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for No Bus:mice
PM: Adding info for serio:serio0
PM: Adding info for No Bus:psaux
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
PM: Adding info for No Bus:event0
PM: Adding info for No Bus:event1
PM: Adding info for No Bus:event2
PM: Adding info for No Bus:event3
PM: Adding info for No Bus:event4
PM: Adding info for No Bus:input5
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
PM: Adding info for No Bus:event5
i2c /dev entries driver
piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
PM: Adding info for No Bus:i2c-0
PM: Adding info for No Bus:i2c-0
usbcore: registered new interface driver i2c-tiny-usb
PM: Adding info for No Bus:hwmon0
PM: Adding info for No Bus:watchdog
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: HCILL protocol initialized
PM: Adding info for platform:eisa.0
EISA: Probing bus 0 at eisa.0
PM: Removing info for platform:eisa.0
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
PM: Adding info for No Bus:input6
input: Kensington Kensington USB Mouse as /devices/pci0000:00/0000:00:13.0/usb2/2-2/2-2:1.0/input/input6
PM: Adding info for No Bus:mouse0
PM: Adding info for No Bus:event6
PM: Adding info for No Bus:hidraw0
input,hidraw0: USB HID v1.10 Mouse [Kensington Kensington USB Mouse] on usb-0000:00:13.0-2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.16rc2 (Thu Jan 31 16:40:16 2008 UTC).
PM: Adding info for No Bus:timer
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
PM: Adding info for No Bus:seq
ALSA device list:
  No soundcards found.
IPv4 over IPv4 tunneling driver
Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps: 0xa04713/0x0
PM: Adding info for No Bus:tunl0
GRE over IPv4 tunneling driver
PM: Adding info for No Bus:input7
PM: Adding info for No Bus:gre0
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input7
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
PM: Adding info for No Bus:sit0
NET: Registered protocol family 17
NET: Registered protocol family 15
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
NET: Registered protocol family 33
Starting balanced_irq
Using IPI No-Shortcut mode
PM: Adding info for No Bus:cpu_dma_latency
PM: Adding info for No Bus:network_latency
PM: Adding info for No Bus:network_throughput
  Magic number: 4:0:902
  hash matches device nbd2
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
PM: Adding info for No Bus:mouse1
PM: Adding info for No Bus:event7
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 340k freed
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
Linux agpgart interface v0.103
PM: Adding info for No Bus:cooling_device0
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
PM: Adding info for No Bus:cooling_device1
ACPI: ACPI0007:01 is registered as cooling_device1
uvcvideo: Found UVC 1.00 device Gateway USB 2.0 Webcam (04f2:b027)
PM: Adding info for No Bus:video0
PM: Adding info for No Bus:input8
input: Gateway USB 2.0 Webcam as /devices/pci0000:00/0000:00:13.5/usb1/1-1/1-1:1.0/input/input8
PM: Adding info for No Bus:event8
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
Symbol init_mm is marked as UNUSED, however this module is using it.
This symbol will go away in the future.
Please evalute if this is the right api to use, and if it really is, submit a report the linux kernel mailinglist together with submitting your code for inclusion.
[fglrx]   vendor: 1002 device: 791f count: 1
[fglrx] Maximum main memory to use for locked dma buffers: 2256 MBytes.
[fglrx] PAT is enabled successfully!
[fglrx] module loaded - fglrx 8.50.3 [Jun  2 2008] with 1 minors
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
PM: Adding info for No Bus:target4:0:0
scsi 4:0:0:0: Direct-Access     Generic- Multi-Card       1.00 PQ: 0 ANSI: 0 CCS
PM: Adding info for scsi:4:0:0:0
PM: Adding info for No Bus:card0
PM: Adding info for No Bus:pcmC0D0p
PM: Adding info for No Bus:pcmC0D0c
PM: Adding info for No Bus:dsp
PM: Adding info for No Bus:audio
PM: Adding info for No Bus:hwC0D1
PM: Adding info for No Bus:hwC0D0
PM: Adding info for No Bus:controlC0
PM: Adding info for No Bus:mixer
ACPI: PCI Interrupt 0000:01:05.2[B] -> GSI 19 (level, low) -> IRQ 19
PM: Adding info for No Bus:card1
PM: Adding info for No Bus:pcmC1D0p
PM: Adding info for No Bus:dsp1
PM: Adding info for No Bus:audio1
PM: Adding info for No Bus:hwC1D0
PM: Adding info for No Bus:controlC1
PM: Adding info for No Bus:mixer1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
sd 4:0:0:0: [sdb] 7959552 512-byte hardware sectors (4075 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 03 00 00 00
sd 4:0:0:0: [sdb] Assuming drive cache: write through
PM: Adding info for No Bus:sdb
sd 4:0:0:0: [sdb] 7959552 512-byte hardware sectors (4075 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 03 00 00 00
sd 4:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
PM: Adding info for No Bus:sdb1
sd 4:0:0:0: [sdb] Attached SCSI removable disk
sd 4:0:0:0: Attached scsi generic sg1 type 0
PM: Adding info for No Bus:target4:0:1
PM: Removing info for No Bus:target4:0:1
PM: Adding info for No Bus:target4:0:2
PM: Removing info for No Bus:target4:0:2
PM: Adding info for No Bus:target4:0:3
PM: Removing info for No Bus:target4:0:3
PM: Adding info for No Bus:target4:0:4
PM: Removing info for No Bus:target4:0:4
PM: Adding info for No Bus:target4:0:5
PM: Removing info for No Bus:target4:0:5
PM: Adding info for No Bus:target4:0:6
PM: Removing info for No Bus:target4:0:6
PM: Adding info for No Bus:target4:0:7
PM: Removing info for No Bus:target4:0:7
usb-storage: device scan complete
EXT3 FS on sda2, internal journal
ReiserFS: loop0: found reiserfs format "3.6" with standard journal
ReiserFS: loop0: using ordered data mode
ReiserFS: loop0: journal params: device loop0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: loop0: checking transaction log (loop0)
ReiserFS: loop0: Using r5 hash to sort names
ReiserFS: loop1: found reiserfs format "3.6" with standard journal
ReiserFS: loop1: using ordered data mode
ReiserFS: loop1: journal params: device loop1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: loop1: checking transaction log (loop1)
ReiserFS: loop1: Using r5 hash to sort names
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
PM: Removing info for No Bus:vcs8
PM: Removing info for No Bus:vcsa8
PM: Adding info for No Bus:vcs9
PM: Adding info for No Bus:vcsa9
PM: Removing info for No Bus:vcs9
PM: Removing info for No Bus:vcsa9
PM: Adding info for No Bus:vcs10
PM: Adding info for No Bus:vcsa10
PM: Removing info for No Bus:vcs10
PM: Removing info for No Bus:vcsa10
PM: Adding info for No Bus:vcs11
PM: Adding info for No Bus:vcsa11
PM: Removing info for No Bus:vcs11
PM: Removing info for No Bus:vcsa11
PM: Adding info for No Bus:vcs12
PM: Adding info for No Bus:vcsa12
PM: Removing info for No Bus:vcs12
PM: Removing info for No Bus:vcsa12
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
PM: Removing info for No Bus:vcs8
PM: Removing info for No Bus:vcsa8
PM: Adding info for No Bus:vcs9
PM: Adding info for No Bus:vcsa9
PM: Removing info for No Bus:vcs9
PM: Removing info for No Bus:vcsa9
PM: Adding info for No Bus:vcs10
PM: Adding info for No Bus:vcsa10
PM: Removing info for No Bus:vcs10
PM: Removing info for No Bus:vcsa10
PM: Adding info for No Bus:vcs11
PM: Adding info for No Bus:vcsa11
PM: Removing info for No Bus:vcs11
PM: Removing info for No Bus:vcsa11
PM: Adding info for No Bus:vcs12
PM: Adding info for No Bus:vcsa12
PM: Removing info for No Bus:vcs12
PM: Removing info for No Bus:vcsa12
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
PM: Removing info for No Bus:vcs8
PM: Removing info for No Bus:vcsa8
PM: Adding info for No Bus:vcs9
PM: Adding info for No Bus:vcsa9
PM: Removing info for No Bus:vcs9
PM: Removing info for No Bus:vcsa9
PM: Adding info for No Bus:vcs10
PM: Adding info for No Bus:vcsa10
PM: Removing info for No Bus:vcs10
PM: Removing info for No Bus:vcsa10
PM: Adding info for No Bus:vcs11
PM: Adding info for No Bus:vcsa11
PM: Removing info for No Bus:vcs11
PM: Removing info for No Bus:vcsa11
PM: Adding info for No Bus:vcs12
PM: Adding info for No Bus:vcsa12
PM: Removing info for No Bus:vcs12
PM: Removing info for No Bus:vcsa12
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for No Bus:vcs12
PM: Adding info for No Bus:vcsa12
r8169: eth2: link up
r8169: eth2: link up
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Adding info for No Bus:vcsa5
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
eth2: no IPv6 routers present
PM: Adding info for No Bus:dm-0
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 18 (level, low) -> IRQ 18
[fglrx] GART Table is not in FRAME_BUFFER range 
[fglrx] Reserved FB block: Shared offset:0, size:1000000 
glxinfo[3260]: segfault at b7f8c000 ip b77f2e28 sp bfcb8230 error 6 in fglrx_dri.so[b69ea000+f30000]
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
cpufreq-applet[3410]: segfault at ea60 ip b7f05638 sp b6c4aa20 error 4 in libgnomebreakpad.so[b7efd000+10000]
APIC error on CPU0: 00(40)
hda-intel: Invalid position buffer, using LPIB read method instead.
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
PM: Adding info for No Bus:dm-1
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
glxinfo[10256]: segfault at b7f8f000 ip b77f5e28 sp bf8bc5e0 error 6 in fglrx_dri.so[b69ed000+f30000]
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)

--------------050403020702030502030103--
