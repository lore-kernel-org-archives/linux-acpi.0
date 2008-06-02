From: root@vergina.dyndns.org (root)
Subject: DMI info
Date: Mon,  2 Jun 2008 18:32:40 +0300 (EEST)
Message-ID: <20080602153240.BE8C156CBC@laptop.vergina.dyndns.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adsl10-188.ath.forthnet.gr ([77.49.201.188]:46234 "EHLO
	vergina.dyndns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbYFBPou (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jun 2008 11:44:50 -0400
Received: from vergina.dyndns.org (localhost [127.0.0.1])
	by laptop.vergina.dyndns.org (Postfix) with ESMTP id 03D034A9C3
	for <linux-acpi@vger.kernel.org>; Mon,  2 Jun 2008 18:32:41 +0300 (EEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Linux version 2.6.24-gentoo-r8 (root@dwarfy) (gcc version 4.1.2 (Gentoo 4.1.2 p1.1)) #1 SMP Mon Jun 2 18:07:16 EEST 2008
Command line: root=/dev/sda10 ro vga=791
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
 BIOS-e820: 0000000100000000 - 0000000150000000 (usable)
Entering add_active_range(0, 0, 157) 0 entries of 256 used
Entering add_active_range(0, 256, 622208) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1376256) 2 entries of 256 used
end_pfn_map = 1376256
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
Entering add_active_range(0, 0, 157) 0 entries of 256 used
Entering add_active_range(0, 256, 622208) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1376256) 2 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1376256
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0:        0 ->      157
    0:      256 ->   622208
    0:  1048576 ->  1376256
On node 0 totalpages: 949789
  DMA zone: 56 pages used for memmap
  DMA zone: 1162 pages reserved
  DMA zone: 2779 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 603832 pages, LIFO batch:31
  Normal zone: 4480 pages used for memmap
  Normal zone: 323200 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009d000 - 000000000009e000
swsusp: Registered nosave memory region: 000000000009e000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000d0000
swsusp: Registered nosave memory region: 00000000000d0000 - 0000000000100000
swsusp: Registered nosave memory region: 0000000097e80000 - 0000000097e90000
swsusp: Registered nosave memory region: 0000000097e90000 - 0000000097e92000
swsusp: Registered nosave memory region: 0000000097e92000 - 00000000b0000000
swsusp: Registered nosave memory region: 00000000b0000000 - 00000000e0000000
swsusp: Registered nosave memory region: 00000000e0000000 - 00000000f0000000
swsusp: Registered nosave memory region: 00000000f0000000 - 00000000fec00000
swsusp: Registered nosave memory region: 00000000fec00000 - 00000000fec10000
swsusp: Registered nosave memory region: 00000000fec10000 - 00000000fee00000
swsusp: Registered nosave memory region: 00000000fee00000 - 00000000fee01000
swsusp: Registered nosave memory region: 00000000fee01000 - 00000000fff00000
swsusp: Registered nosave memory region: 00000000fff00000 - 0000000100000000
Allocating PCI resources starting at b4000000 (gap: b0000000:30000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 33184 bytes of per cpu data
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 929811
Kernel command line: root=/dev/sda10 ro vga=791
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
TSC calibrated against PM_TIMER
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 1999.984 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 3647052k/5505024k available (2767k kernel code, 151852k reserved, 1174k data, 228k init)
SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 4068.38 BogoMIPS (lpj=6778208)
Security Framework initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
APIC timer calibration result 12499919
Detected 12.499 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4001.69 BogoMIPS (lpj=6666716)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Turion(tm) 64 X2 Mobile Technology TL-60 stepping 01
AMD C1E detected late. Force timer broadcast.
Brought up 2 CPUs
net_namespace: 120 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - e12fffff
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Gateway
ACPI: DMI Product Name: T-1625
ACPI: DMI Product Version: 90.03   
ACPI: DMI Board Name:         
ACPI: DMI BIOS Vendor: Gateway
ACPI: DMI BIOS Date: 09/27/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE = 0x10, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB5_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB7_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
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
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0
DMAR:No DMAR devices found
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
ACPI: RTC can wake from S4
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
system 00:09: iomem range 0xe0000-0xfffff could not be reserved
system 00:09: iomem range 0xfff00000-0xffffffff could not be reserved
system 00:09: iomem range 0xffb83020-0xffb8401f has been reserved
system 00:09: iomem range 0xfed00000-0xfed003ff has been reserved
system 00:09: iomem range 0x0-0x0 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: cfd00000-cfefffff
  PREFETCH window: b0000000-bfffffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: a000-afff
  MEM window: f0200000-f02fffff
  PREFETCH window: c0000000-c00fffff
PCI: Bridge: 0000:00:14.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
NET: Registered protocol family 2
Time: acpi_pm clocksource has been installed.
Clockevents: could not switch to one-shot mode:<6>Clockevents: could not switch to one-shot mode: lapic is not functional.
Could not switch to high resolution mode on CPU 1
 lapic is not functional.
Could not switch to high resolution mode on CPU 0
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler cfq registered (default)
Boot video device is 0000:01:05.0
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
Allocate Port Service[0000:00:05.0:pcie02]
Allocate Port Service[0000:00:05.0:pcie03]
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
Allocate Port Service[0000:00:07.0:pcie03]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102
vesafb: framebuffer at 0xb0000000, mapped to 0xffffc20001400000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]
input: Lid Switch as /class/input/input3
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports 8 throttling states)
console [netcon0] enabled
netconsole: network logging started
Clockevents: could not switch to one-shot mode: lapic is not functional.
Could not switch to high resolution mode on CPU 0
Clockevents: could not switch to one-shot mode: lapic is not functional.
Could not switch to high resolution mode on CPU 1
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:00:12.0: version 3.0
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309100 irq 22
ata2: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309180 irq 22
ata3: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309200 irq 22
ata4: SATA max UDMA/133 abar m1024@0xf0309000 port 0xf0309280 irq 22
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: WDC WD2500BEVS-22UST0, 01.01A01, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEVS-2 01.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: [sda] Attached SCSI disk
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:14.1 to 64
scsi4 : pata_atiixp
scsi5 : pata_atiixp
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x8420 irq 14
ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x8428 irq 15
ata5.00: ATAPI: HL-DT-ST DVDRAM GSA-T20F, EG02, max UDMA/33
ata5.00: configured for UDMA/33
scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T20F  EG02 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input4
i2c /dev entries driver
piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
cpuidle: using governor ladder
cpuidle: using governor menu
powernow-k8: Found 1 AMD Turion(tm) 64 X2 Mobile Technology TL-60 processors (2 cpu cores) (version 2.20.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x12
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x13
powernow-k8:    2 : fid 0x8 (1600 MHz), vid 0x14
powernow-k8:    3 : fid 0x0 (800 MHz), vid 0x1e
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps: 0xa04713/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input5
Clocksource tsc unstable (delta = -251879672 ns)
XFS mounting filesystem sda10
Ending clean XFS mount for filesystem: sda10
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 228k freed
NET: Registered protocol family 1
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:08:00.0 to 64
eth0: RTL8101e at 0xffffc2000006a000, 00:03:25:43:7f:93, XID 34200000 IRQ 317
input: PC Speaker as /class/input/input6
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: Video Bus as /class/input/input7
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xf0309400
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xf0304000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 17, io mem 0xf0305000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 18, io mem 0xf0306000
usb 1-1: configuration #1 chosen from 1 choice
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.3: irq 17, io mem 0xf0307000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
ohci_hcd 0000:00:13.4: irq 18, io mem 0xf0308000
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
usb 1-3: new high speed USB device using ehci_hcd and address 4
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
usb 1-3: configuration #1 chosen from 1 choice
usb 1-8: new high speed USB device using ehci_hcd and address 5
usb 1-8: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
usb 2-2: new low speed USB device using ohci_hcd and address 2
si3054: cannot initialize. EXT MID = 0000
ACPI: PCI Interrupt 0000:01:05.2[B] -> GSI 19 (level, low) -> IRQ 19
usb 2-2: configuration #1 chosen from 1 choice
scsi6 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver hiddev
input: USB Optical Mouse as /class/input/input8
input,hidraw0: USB HID v1.10 Mouse [USB Optical Mouse] on usb-0000:00:13.0-2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Adding 2016116k swap on /dev/sda5.  Priority:-1 extents:1 across:2016116k
scsi 6:0:0:0: Direct-Access     Generic- Multi-Card       1.00 PQ: 0 ANSI: 0 CCS
sd 6:0:0:0: [sdb] Attached SCSI removable disk
usb-storage: device scan complete
r8169: eth0: link up
r8169: eth0: link up
NET: Registered protocol family 17
NET: Registered protocol family 10
eth0: no IPv6 routers present
si3054: cannot initialize. EXT MID = 0000
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
fuse init (API version 7.9)
XFS mounting filesystem sda8
Ending clean XFS mount for filesystem: sda8
