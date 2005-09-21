From: Jonas Oreland <jonas-fAbYwIrWRvUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: ACPI, pm timer and ASUS a8v
Date: Wed, 21 Sep 2005 09:44:26 +0200
Message-ID: <43310F5A.3060202@mysql.com>
References: <59D45D057E9702469E5775CBB56411F1784DF0@pdsmsx406>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000609040409060102010308"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F1784DF0@pdsmsx406>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000609040409060102010308
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Li, Shaohua wrote:
> Hi Jonas,
> What the dmesg in the failure case? It seems the attched dmesg has the
> correct pm-timer info.

yes, this is the "my own hardcoded" version.

attaching one from failure case.

thank you for looking at it.

/Jonas

> 
> Thanks,
> Shaohua
> 
> 
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andrew Morton
>>Sent: Wednesday, September 21, 2005 2:18 PM
>>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Cc: Jonas Oreland
>>Subject: [ACPI] Fw: ACPI, pm timer and ASUS a8v
>>
>>
>>Jonas, you'll probably need to raise an ACPi report at
> 
> bugzilla.kernel.org
> 
>>for this one please.
>>
>>Begin forwarded message:
>>
>>Date: Tue, 20 Sep 2005 14:12:53 +0200
>>From: Jonas Oreland <jonas-fAbYwIrWRvUAvxtiuMwx3w@public.gmane.org>
>>To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>Subject: ACPI, pm timer and ASUS a8v
>>
>>
>>Hi,
>>
>>I running 2.6.12-gentoo-r10
>>I have a ASUS a8v motherboard with a AMD64 X2
>>
>>This gives me problem with clock drift
>>(see http://bugzilla.kernel.org/show_bug.cgi?id=5105)
>>
>>So I tried using notsc to force usage of pm timer.
>>
>>But!
>>The the acpi code find the fadt->xpm_tmr_blk.address to 0
>>Making the code yet again fall back to PIT/TSC
>>
>>I booted my system can run
>>perch> grep PM_ /proc/ioports
>>0808-080b : PM_TMR
>>
>>And harded the address 0x808 into pmtmr_ioport
>>This works. The system is using pmtmr and I get no clock drift
>>(tested now for ~a day)
>>
>>But why do ACPI find 0 as pmtmr_ioport?
>>
>>/Jonas
> 
> 
> 


--------------000609040409060102010308
Content-Type: text/plain;
 name="info"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="info"

Bootdata ok (command line is root=/dev/md1 notsc report_lost_ticks)
Linux version 2.6.12-gentoo-r10 (root@perch) (gcc version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 SMP Tue Sep 20 09:01:00 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa7c0
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000530 MSFT 0x00000097) @ 0x000000007ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x06000530 MSFT 0x00000097) @ 0x000000007ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000530 MSFT 0x00000097) @ 0x000000007ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000530 MSFT 0x00000097) @ 0x000000007ffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
On node 0 totalpages: 524208
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 520112 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7f780000)
Checking aperture...
CPU 0: aperture @ e4000000 size 64 MB
Built 1 zonelists
Kernel command line: root=/dev/md1 notsc report_lost_ticks
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2202.915 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2056472k/2096832k available (2742k kernel code, 39756k reserved, 1155k data, 252k init)
Calibrating delay loop... 4308.99 BogoMIPS (lpj=2154496)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
time.c: Lost 45 timer tick(s)! rip setup_boot_APIC_clock+0x112/0x120)
Booting processor 1/1 rip 6000 rsp ffff81007ff51f58
Initializing CPU#1
Calibrating delay loop... 4390.91 BogoMIPS (lpj=2195456)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 573 cycles)
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xe4000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
inotify device minor=63
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.16.0 20050311 on minor 0: 
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
skge addr 0xfb900000 irq 17 chip Yukon-Lite rev 9
skge eth0: addr 00:11:d8:a9:ca:61
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.35.
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 4
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.11 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 4
sata_via(0000:00:0f.0): routed to hard irq line 4
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xB802 bmdma 0xA800 irq 20
ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 20
ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:407f
ata2: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Fusion MPT base driver 3.01.20
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.20
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 21, io mem 0xfbc00000
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000c400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000d000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 5
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000d400
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Intel 810 + AC97 Audio, version 1.01, 08:42:09 Sep 20 2005
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.40.4)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
ACPI wakeup devices: 
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda1 has different UUID to sdb3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb3
raid0:   comparing sdb3(70541312) with sdb3(70541312)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda3
raid0:   comparing sda3(70541312) with sdb3(70541312)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 141082624 blocks.
raid0 : conf->hash_spacing is 141082624 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 252k freed
Adding 1959920k swap on /dev/sda2.  Priority:-1 extents:1
Adding 1959920k swap on /dev/sdb2.  Priority:-2 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
skge eth0: enabling interface
skge eth0: Link is up at 100 Mbps, full duplex, flow control tx and rx
[drm:drm_unlock] *ERROR* Process 4283 using kernel context 0
time.c: Lost 1 timer tick(s)! rip default_idle+0x20/0x30)
Losing some ticks... checking if CPU frequency changed.
time.c: Lost 1 timer tick(s)! rip default_idle+0x20/0x30)
time.c: Lost 1 timer tick(s)! rip default_idle+0x20/0x30)
time.c: Lost 1 timer tick(s)! rip default_idle+0x20/0x30)


---- lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
0000:00:0c.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus Reference Card (rev 01)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)

--------------000609040409060102010308--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
