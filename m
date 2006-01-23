From: Raphael Clifford <raphael@clifford.net>
Subject: Re: 2.6.16-rc1  will not boot on msi rs480m2 when either acpi or
 apic is enabled
Date: Mon, 23 Jan 2006 19:04:00 +0000
Message-ID: <43D528A0.8030704@clifford.net>
References: <43D4FE2F.5080700@clifford.net> <200601231000.46575.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pih-relay06.plus.net ([212.159.14.133]:3529 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S964892AbWAWS5r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 13:57:47 -0500
In-Reply-To: <200601231000.46575.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Monday 23 January 2006 09:02, Raphael Clifford wrote:
>   
>> MSI rs480m2 system  (AMD64 processor) will not boot when either acpi or apic are
>> enabled in the boot arguments.  This has been tested in many kernels (gentoo and vanilla) up
>> to and including 2.6.16-rc1.  
>>     
>
> Can you try "pci=routeirq"?  Can you capture the entire boot output
> with a serial console or netconsole?  Are any BIOS updates available
> for this box?
>
> --
The system boots with pci=routeirq as the only boot prompt argument.  
The latest dmesg is attached below. For full debug info on the system 
please see


http://bugzilla.kernel.org/show_bug.cgi?id=5933

Do you need to see the entire boot output specifically from the cases 
where it doesn't boot too?




(Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 Sat Jan 21 14:56:38 GMT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003bef0000 (usable)
 BIOS-e820: 000000003bef0000 - 000000003bef3000 (ACPI NVS)
 BIOS-e820: 000000003bef3000 - 000000003bf00000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 RS480                                 ) @ 
0x00000000000f8070
ACPI: RSDT (v001 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003bef3040
ACPI: FADT (v002 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003bef30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 
0x000000003bef69c0
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 
0x000000003bef6ac0
ACPI: MCFG (v001 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003bef6bc0
ACPI: MADT (v001 RS480  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000003bef6900
ACPI: DSDT (v001 RS480  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
On node 0 totalpages: 240915
  DMA zone: 2823 pages, LIFO batch:0
  DMA32 zone: 238092 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3bf00000:a4100000)
Checking aperture...
CPU 0: aperture @ 258a000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: root=/dev/ram0 init=/linuxrc ramdisk=8192 
real_root=/dev/sda5 udev  report_lost_ticks=100 pci=routeirq
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1790.872 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
PCI-DMA: Disabling IOMMU.
Memory: 960000k/981952k available (2786k kernel code, 21036k reserved, 
1087k data, 200k init)
Calibrating delay using timer specific routine.. 3589.12 BogoMIPS 
(lpj=7178245)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
time.c: Lost 1 timer tick(s)! rip acpi_os_write_port+0x1a/0x34)
Using local APIC timer interrupts.
Detected 12.436 MHz APIC timer.
time.c: Lost 14 timer tick(s)! rip setup_boot_APIC_clock+0xdb/0xde)
testing NMI watchdog ... OK.
checking if image is initramfs...<4>time.c: Lost 13 timer tick(s)! rip 
inflate_codes+0x165/0x3c6)
 it is
Freeing initrd memory: 1433k freed
DMI 2.4 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
GSI 21 sharing vector 0xA9 and IRQ 21
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 *11), disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 23 (level, low) -> IRQ 16
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 17
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 18
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 19
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 20
GSI 22 sharing vector 0xD9 and IRQ 22
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 20 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Cannot allocate resource region 3 of device 0000:00:00.0
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fdd00000-fddfffff
  PREFETCH window: d8000000-dfffffff
PCI: Bridge: 0000:00:14.4
  IO window: d000-dfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: fde00000-fdefffff
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
JFS: nTxBlock = 7515, nTxLock = 60122
SGI XFS with ACLs, large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
time.c: Lost 2 timer tick(s)! rip msleep+0x3/0x3a)
time.c: Lost 2 timer tick(s)! rip msleep+0x3/0x3a)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp_glue: can't get bus number, assuming 0
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports 8 throttling states)
ibm_acpi: ec object not found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: BENQ DVD DD DW1640, ATAPI CD/DVD-ROM drive
time.c: Lost 14 timer tick(s)! rip default_idle+0x2a/0x52)
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 126X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  5458.000 MB/sec
raid5: using function: generic_sse (5458.000 MB/sec)
raid6: int64x1    833 MB/s
raid6: int64x2   1040 MB/s
raid6: int64x4   1081 MB/s
raid6: int64x8    817 MB/s
raid6: sse2x1    1101 MB/s
raid6: sse2x2    1464 MB/s
raid6: sse2x4    1667 MB/s
raid6: using algorithm sse2x4 (1667 MB/s)
md: raid6 personality registered for level 6
md: multipath personality registered for level -4
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xa, vid 0x6
ACPI wakeup devices:
PCI0 USB0 USB1 USB2 AUDO  P2P  MAC
ACPI: (supports S0 S1 S3 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 200k freed
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 18
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 18, io mem 0xfe02b000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
input: AT Translated Set 2 keyboard as /class/input/input0
usb 1-7: new high speed USB device using ehci_hcd and address 3
usb 1-7: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
USB Universal Host Controller Interface driver v2.3
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe02d000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 18, io mem 0xfe02c000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
libata version 1.20 loaded.
sata_sil 0000:00:11.0: version 0.9
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 23 (level, low) -> IRQ 16
ata1: SATA max UDMA/100 cmd 0xFFFFC2000002E080 ctl 0xFFFFC2000002E08A 
bmdma 0xFFFFC2000002E000 irq 16
ata2: SATA max UDMA/100 cmd 0xFFFFC2000002E0C0 ctl 0xFFFFC2000002E0CA 
bmdma 0xFFFFC2000002E008 irq 16
ata1: SATA link down (SStatus 0)
scsi1 : sata_sil
usb 3-1: new low speed USB device using ohci_hcd and address 2
ata2: SATA link down (SStatus 0)
scsi2 : sata_sil
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 17
ata3: SATA max UDMA/100 cmd 0xFFFFC20000030080 ctl 0xFFFFC2000003008A 
bmdma 0xFFFFC20000030000 irq 17
ata4: SATA max UDMA/100 cmd 0xFFFFC200000300C0 ctl 0xFFFFC200000300CA 
bmdma 0xFFFFC20000030008 irq 17
usb 3-1: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as 
/class/input/input1
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with 
IntelliEye(TM)] on usb-0000:00:13.1-1
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7468 86:3c01 87:4023 
88:40ff
ata3: dev 0 ATA-7, max UDMA7, 390721968 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi3 : sata_sil
ata4: SATA link down (SStatus 0)
scsi4 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP2004C   Rev: VM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 > sda4
sd 3:0:0:0: Attached scsi disk sda
sd 3:0:0:0: Attached scsi generic sg0 type 0
ReiserFS: sda5: warning: sh-2021: reiserfs_fill_super: can not find 
reiserfs on sda5
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
  Vendor: USB2.0    Model: CF  CardReader    Rev:    
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 0:0:0:0: Attached scsi removable disk sdb
sd 0:0:0:0: Attached scsi generic sg1 type 0
  Vendor: USB2.0    Model: CBO CardReader    Rev:    
  Type:   Direct-Access                      ANSI SCSI revision: 00
sd 0:0:0:1: Attached scsi removable disk sdc
sd 0:0:0:1: Attached scsi generic sg2 type 0
usb-storage: device scan complete
Adding 2811332k swap on /dev/sda6.  Priority:-1 extents:1 across:2811332k
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.25 [Flags: R/O MODULE].
NTFS volume version 3.1.
time.c: Lost 13 timer tick(s)! rip 0x43da68)
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 20
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 20 (level, low) -> IRQ 22
eth0: RealTek RTL8139 at 0xffffc20000066000, 00:13:d3:2e:29:c6, IRQ 22
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
Driver 'smsc47m1' needs updating - please use bus_type methods
time.c: Lost 14 timer tick(s)! rip default_idle+0x2a/0x52)
eth0: no IPv6 routers present


Raphael
