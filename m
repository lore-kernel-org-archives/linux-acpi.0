From: Sur3 <sur3@gmx.de>
Subject: dmidecode to linux-acpi@vger.kernel.org
Date: Tue, 23 Oct 2007 15:06:53 +0200
Message-ID: <471DF1ED.7090107@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040105030604030902040703"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.uni-paderborn.de ([131.234.142.9]:38444 "EHLO
	mail.uni-paderborn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbXJWNiB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Oct 2007 09:38:01 -0400
Received: from blueair.uni-paderborn.de ([131.234.209.34] helo=[131.234.238.250])
	by mail.uni-paderborn.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.62 cyclopia)
	id 1IkJTI-0007lF-BG
	for linux-acpi@vger.kernel.org; Tue, 23 Oct 2007 15:07:00 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040105030604030902040703
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

my dmesg told me "Please send dmidecode to linux-acpi@vger.kernel.org",
so i did it right now.

greets


--------------040105030604030902040703
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.22-gentoo-r8 (root@gamma2) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.1)) #3 SMP Sun Oct 7 04:50:46 CEST 2007
Command line: root=/dev/sda6 vga=0x305
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fed0000 (usable)
 BIOS-e820: 000000007fed0000 - 000000007fedf000 (ACPI NVS)
 BIOS-e820: 000000007fedf000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 155) 0 entries of 256 used
Entering add_active_range(0, 256, 523984) 1 entries of 256 used
end_pfn_map = 1048576
DMI present.
ACPI: RSDP 000F66C0, 0024 (r2 PTLTD )
ACPI: XSDT 7FED5685, 008C (r1 MEDION MEDIONAG  6040000  LTP        0)
ACPI: FACP 7FEDBBD2, 00F4 (r3 INTEL  CRESTLNE  6040000 ALAN        1)
ACPI: DSDT 7FED6A51, 510D (r2 INTEL  CRESTLNE  6040000 INTL 20050624)
ACPI: FACS 7FEDEFC0, 0040
ACPI: APIC 7FEDBCC6, 0068 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: HPET 7FEDBD2E, 0038 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: MCFG 7FEDBD66, 003C (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: TCPA 7FEDBDA2, 0032 (r1 Intel   CRESTLN  6040000          5A52)
ACPI: TMOR 7FEDBDD4, 0026 (r1 PTLTD            6040000 PTL         3)
ACPI: APIC 7FEDBDFA, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: SLIC 7FEDBE62, 0176 (r1 MEDION MEDIONAG  6040000  LTP        1)
ACPI: BOOT 7FEDBFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: SSDT 7FED676D, 02E4 (r1 SataRe SataAhci     1000 INTL 20050624)
ACPI: SSDT 7FED5C9D, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
ACPI: SSDT 7FED5BF7, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050624)
ACPI: SSDT 7FED5711, 04E6 (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
Entering add_active_range(0, 0, 155) 0 entries of 256 used
Entering add_active_range(0, 256, 523984) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      155
    0:      256 ->   523984
On node 0 totalpages: 523883
  DMA zone: 56 pages used for memmap
  DMA zone: 1364 pages reserved
  DMA zone: 2575 pages, LIFO batch:0
  DMA32 zone: 7107 pages used for memmap
  DMA32 zone: 512781 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 32688 bytes of per cpu data
Built 1 zonelists.  Total pages: 515356
Kernel command line: root=/dev/sda6 vga=0x305
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 1995.000 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
Memory: 2058024k/2095936k available (3200k kernel code, 37360k reserved, 1380k data, 224k init)
SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 3995.79 BogoMIPS (lpj=7991584)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring handled by SMI
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12468757
Detected 12.468 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3990.14 BogoMIPS (lpj=7980296)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 Duo CPU     T7300  @ 2.00GHz stepping 0a
Brought up 2 CPUs
migration_cost=27
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
pnp: 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c8000000-caffffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: f6000000-f7ffffff
  PREFETCH window: f0000000-f1ffffff
PCI: Bridge: 0000:00:1c.1
  IO window: 4000-4fff
  MEM window: f8000000-f9ffffff
  PREFETCH window: f2000000-f3ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 5000-5fff
  MEM window: fa000000-fbffffff
  PREFETCH window: f4000000-f5ffffff
PCI: Bridge: 0000:00:1c.3
  IO window: 6000-6fff
  MEM window: c4000000-c5ffffff
  PREFETCH window: cc000000-cdffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
Time: hpet clocksource has been installed.
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Total HugeTLB memory allocated, 0
fuse init (API version 7.8)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:01:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie02]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
hpet_resources: 0xfed00000 is busy
Generic RTC Driver v1.07
Linux agpgart interface v0.102 (c) Dave Jones
vesafb: framebuffer at 0xc9000000, mapped to 0xffffc20010100000, using 1536k, total 14336k
vesafb: mode is 1024x768x8, linelength=1024, pages=3
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
input: Lid Switch as /class/input/input2
ACPI: Lid Switch [LID0]
input: Sleep Button (CM) as /class/input/input3
ACPI: Sleep Button (CM) [SLPB]
set_level status: 0
ACPI: Video Device [VGA0] (multi-head: yes  rom: no  post: no)
ACPI: SSDT 7FED642B, 027A (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT 7FED5EFC, 04AA (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 7FED66A5, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT 7FED63A6, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [TZ00] (52 C)
ACPI: Thermal Zone [TZ01] (55 C)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
PPP generic driver version 2.4.2
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:06:00.0 to 64
eth0: RTL8101e at 0xffffc20000036000, 00:40:d0:b7:bc:ef, IRQ 18
netconsole: not configured, aborting
Linux video capture interface: v2.00
ahci 0000:00:1f.2: version 2.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc20000038100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 314
ata2: SATA max UDMA/133 cmd 0xffffc20000038180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 314
ata3: SATA max UDMA/133 cmd 0xffffc20000038200 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 314
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: WDC WD1600BEVS-00RST0, 04.01G04, max UDMA/133
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600BEVS-0 04.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata_piix 0000:00:1f.1: version 2.11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi3 : ata_piix
scsi4 : ata_piix
ata4: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x00000000000118a0 irq 14
ata5: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x00000000000118a8 irq 15
ata4.00: ATAPI: TOSHIBA DVDW/HD TS-L802A, TU04, max UDMA/33
ata4.00: configured for UDMA/33
scsi 3:0:0:0: CD-ROM            TOSHIBA  DVDW/HD TS-L802A TU04 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 62x/62x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
sr 3:0:0:0: Attached scsi generic sg1 type 5
Fusion MPT base driver 3.04.04
Copyright (c) 1999-2007 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.04
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfc204800
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfc204c00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001800
usb 1-4: new high speed USB device using ehci_hcd and address 2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001820
usb 1-4: configuration #1 chosen from 1 choice
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001840
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-5: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001860
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001880
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
usb 2-5: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input4
rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 19 (level, low) -> IRQ 19
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x92a0b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad as /class/input/input5
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 4
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
rtc_cmos 00:07: setting the system clock to 2007-10-23 13:16:37 (1193145397)
ReiserFS: sda6: found reiserfs format "3.5" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
scsi 5:0:0:0: Direct-Access     Generic- SD/MMC/MS/MSPro  1.00 PQ: 0 ANSI: 0 CCS
sd 5:0:0:0: [sdb] Attached SCSI removable disk
sd 5:0:0:0: Attached scsi generic sg2 type 0
usb-storage: device scan complete
ReiserFS: sda6: replayed 530 transactions in 5 seconds
ReiserFS: sda6: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 224k freed
iwl4965: Intel(R) Wireless WiFi Link 4965AGN driver for Linux, 1.1.17ds
iwl4965: Copyright(c) 2003-2007 Intel Corporation
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
iwl4965: Detected Intel Wireless WiFi Link 4965AGN
nvidia: module license 'NVIDIA' taints kernel.
iwl4965: Radio disabled by HW RF Kill switch
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  100.14.19  Wed Sep 12 14:08:38 PDT 2007
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /var/tmp/portage/media-sound/alsa-driver-9999/work/alsa-driver/pci/hda/hda_codec.c:2142: hda_codec: model 'acer' is selected
ReiserFS: sda6: Removing [35261 2093141 0x0 SD]..done
ReiserFS: sda6: Removing [35261 2093139 0x0 SD]..done
ReiserFS: sda6: Removing [490554 1970234 0x0 SD]..done
ReiserFS: sda6: Removing [35261 300826 0x0 SD]..done
ReiserFS: sda6: Removing [35261 300791 0x0 SD]..done
ReiserFS: sda6: Removing [35261 299584 0x0 SD]..done
ReiserFS: sda6: Removing [35261 236179 0x0 SD]..done
ReiserFS: sda6: There were 7 uncompleted unlinks/truncates. Completed
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
Adding 1044184k swap on /dev/sda7.  Priority:-1 extents:1 across:1044184k
r8169: eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
NVRM: Xid (0001:00): 34
ALSA /var/tmp/portage/media-sound/alsa-driver-9999/work/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:576: hda_intel: azx_get_response timeout, switching to polling mode: last cmd=0x008b0000
NVRM: Xid (0001:00): 34


--------------040105030604030902040703
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.9
SMBIOS 2.4 present.
42 structures occupying 1497 bytes.
Table at 0x7FEDF000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: M1.04 
	Release Date: 07/25/2007
	Address: 0xE53E0
	Runtime Size: 109600 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
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
	Manufacturer: Intel Corporation
	Product Name: Crestline & ICH8M Chipset
	Version: Not Applicable
	Serial Number: Not Applicable
	UUID: 01010101-0101-0101-0101-010101010101
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Intel Corporation
	Product Name: SANTA ROSA CRB
	Version: Not Applicable
	Serial Number: Not Applicable

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: No Enclosure
	Type: Other
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: No Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel
	ID: FA 06 00 00 FF FB EB BF
	Version: CPU Version
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 4096 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
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
	Installed Size: 64 KB
	Maximum Size: 64 KB
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
	Location: Internal
	Installed Size: 4096 KB
	Maximum Size: 4096 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J19
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Mouse Port

Handle 0x000A, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot J8B3
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000B, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot S9B1
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
	Designation: PEG Slot J6B2
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	ID: 6
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000D, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot J6B1
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	ID: 7
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000E, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot J6D1
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000F, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot J8B4
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	ID: 9
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0010, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot J8D1
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Long
	ID: 10
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0011, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot J7B1
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Long
	ID: 10
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0012, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: HD-Audio

Handle 0x0013, DMI type 11, 5 bytes
OEM Strings
	String 1: This is the Intel Crestline
	String 2: Chipset CRB Platform

Handle 0x0014, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x0015, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x00000002
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0016, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 1000 MB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0017, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0016
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Mfg 0
	Serial Number: 1234-B0
	Asset Tag: Not Specified
	Part Number: SODIMM000

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0016
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Mfg 1
	Serial Number: 1234-B1
	Asset Tag: Not Specified
	Part Number: SODIMM001

Handle 0x0019, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0016
	Partition Width: 0

Handle 0x001A, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0017
	Memory Array Mapped Address Handle: 0x0019
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x001B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0018
	Memory Array Mapped Address Handle: 0x0019
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x001C, DMI type 22, 26 bytes
Portable Battery
	Location: Rear
	Manufacturer: Intel Corporation
	Name: Intel Corporation
	Chemistry: Lithium Ion
	Design Capacity: 1000 mWh
	Design Voltage: 19 mV
	SBDS Version: BATT_1234
	Maximum Error: 100%
	SBDS Serial Number: 0001
	SBDS Manufacture Date: 1980-00-01
	OEM-specific Information: 0x00000000

Handle 0x001D, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x001E, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Disabled
	Front Panel Reset Status: Unknown

Handle 0x001F, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0020, DMI type 26, 20 bytes
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

Handle 0x0021, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x0022
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x0022, DMI type 28, 20 bytes
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

Handle 0x0023, DMI type 29, 20 bytes
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

Handle 0x0024, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0025, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0026, DMI type 129, 16 bytes
OEM-specific Type
	Header and Data:
		81 10 26 00 01 01 02 01 00 00 00 01 00 00 08 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x0027, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 27 00 FF FF

Handle 0x0028, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 28 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x0029, DMI type 127, 4 bytes
End Of Table



--------------040105030604030902040703--
