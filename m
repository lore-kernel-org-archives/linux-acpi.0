From: Erno Rigo <mcree-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Subject: VIA KT600 error report
Date: Thu, 6 Nov 2003 13:29:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200311061329.33330.mcree@freemail.hu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t6jq/AyEPJpAZHJ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_t6jq/AyEPJpAZHJ
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello!

"likely buggy ACPI BIOS, please report to acpi-devel!"

I think it's rather too new than buggy...

For more info see attachments... (ACPI/APIC failure with kernel 2.4.22-ac4 
(have to use -ac4, because of the SATA controller))

-- 
McRee

--Boundary-00=_t6jq/AyEPJpAZHJ
Content-Type: text/plain;
  charset="iso-8859-2";
  name="acpi_error.txt"
Content-Disposition: attachment;
	filename="acpi_error.txt"
Content-Transfer-Encoding: quoted-printable

de 1 Trigger 1
PIC: IRQ (9) already programmed
PIC: IRQ (11) already programmed
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
PIC: IRQ (10) already programmed
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKH] (likely buggy ACPI =
BIOS, please report to acpi-devel!)
PCI: Using IRQ router VIA [1106/3227] at 00:11.0
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:13.0
PCI: Found IRQ 9 for device 00:0d.0
PCI: Sharing IRQ 9 with 00:0d.1
IRQ routing conflict for 01:00.0, have irq 11, want irq 9
PCI: Found IRQ 5 for device 00:0e.0
PCI: Found IRQ 3 for device 00:0f.1
IRQ routing conflict for 00:0f.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL=
_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
PCI: Enabling device 00:13.0 (0014 -> 0017)
PCI: Found IRQ 5 for device 00:13.0
PCI: Sharing IRQ 5 with 00:09.0
eth0: ADMtek Comet rev 17 at 0x8400, 00:0A:41:79:76:C4, IRQ 5.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: unable to determine aperture size.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta5-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:0f.1
PCI: Found IRQ 3 for device 00:0f.1
IRQ routing conflict for 00:0f.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci00:0f.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200JB-00DUA3, ATA DISK drive
blk: queue c0426800, I/O limit 4095Mb (mask 0xffffffff)
hdc: ASUS CRW-1610A, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=3D14593/255/63, U=
DMA(100)
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p7 > p2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: ASUS      Model: CRW-1610A         Rev: 1.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PIONEER   Model: DVD-ROM DVD-106   Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 02
sata_via version 0.10
PCI: Found IRQ 3 for device 00:0f.0
IRQ routing conflict for 00:0f.0, have irq 9, want irq 3
PCI: Sharing IRQ 3 with 00:0f.1
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xB802 bmdma 0xA800 irq 9
ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 9
ata1: bus reset via SRST
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 8=
8:407f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: bus reset via SRST
ATA: abnormal status 0x7F on port 0xB407
ata2: thread exiting
scsi1 : sata_via
scsi2 : sata_via
  Vendor: ATA       Model: ST3120026AS       Rev: 0.71
  Type:   Direct-Access                      ANSI SCSI revision: 05
libata version 0.71 loaded.
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
es1371: version v0.32 time 08:51:36 Nov  5 2003
PCI: Enabling device 00:0e.0 (0004 -> 0005)
PCI: Found IRQ 5 for device 00:0e.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xd400 irq 5
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 3 for device 00:10.0
IRQ routing conflict for 00:0f.0, have irq 9, want irq 3
PCI: Sharing IRQ 3 with 00:0f.1
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
host/uhci.c: USB UHCI at I/O 0x9800, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
host/uhci.c: detected 2 ports
usb.c: kmalloc IF dfdfab40, numif 1
usb.c: new device strings: Mfr=3D0, Product=3D2, SerialNumber=3D1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: 9800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfdfab40
PCI: Found IRQ 3 for device 00:10.1
IRQ routing conflict for 00:0f.0, have irq 9, want irq 3
PCI: Sharing IRQ 3 with 00:0f.1
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
host/uhci.c: USB UHCI at I/O 0x9400, IRQ 9
usb.c: new USB bus registered, assigned bus number 2
host/uhci.c: detected 2 ports
usb.c: kmalloc IF dfdfad40, numif 1
usb.c: new device strings: Mfr=3D0, Product=3D2, SerialNumber=3D1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: 9400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfdfad40
PCI: Found IRQ 2 for device 00:10.2
IRQ routing conflict for 00:10.2, have irq 11, want irq 2
IRQ routing conflict for 00:10.3, have irq 11, want irq 2
host/uhci.c: USB UHCI at I/O 0x9000, IRQ 11
usb.c: new USB bus registered, assigned bus number 3
host/uhci.c: detected 2 ports
usb.c: kmalloc IF dfdfaf40, numif 1
usb.c: new device strings: Mfr=3D0, Product=3D2, SerialNumber=3D1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: 9000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfdfaf40
PCI: Found IRQ 2 for device 00:10.3
IRQ routing conflict for 00:10.2, have irq 11, want irq 2
IRQ routing conflict for 00:10.3, have irq 11, want irq 2
host/uhci.c: USB UHCI at I/O 0x8800, IRQ 11
host/uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
host/uhci.c: 9800: suspend_hc
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
usb.c: new USB bus registered, assigned bus number 4
host/uhci.c: detected 2 ports
usb.c: kmalloc IF dfd38280, numif 1
usb.c: new device strings: Mfr=3D0, Product=3D2, SerialNumber=3D1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: 8800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfd38280
usb.c: registered new driver serial
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Handspring Visor / Treo / =
Palm 4.0 / Cli=E9 4.x
usbserial.c: USB Serial support registered for Sony Cli=E9 3.5
visor.c: USB HandSpring Visor, Palm m50x, Treo, Sony Cli=E9 driver v1.7
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Linux video capture interface: v1.00
i2c-core.o: driver i2c msp3400 driver registered.
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300=
,tea6420,tda8425,pic16c54 (PV951),ta8874z
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c tda7432 driver registered.
i2c-core.o: driver i2c tda9875 driver registered.
i2c-core.o: driver i2c tda9887 driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
bttv: driver version 0.7.107 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridg=
e
bttv: Bt8xx card found (0).
PCI: Enabling device 00:0d.0 (0004 -> 0006)
PCI: Found IRQ 9 for device 00:0d.0
PCI: Sharing IRQ 9 with 00:0d.1
IRQ routing conflict for 01:00.0, have irq 11, want irq 9
bttv0: Bt878 (rev 17) at 00:0d.0, irq: 9, latency: 32, mmio: 0xee800000
bttv0: detected: Pinnacle PCTV [card=3D39], PCI subsystem ID is 11bd:0012
bttv0: using: BT878(Pinnacle PCTV Studio/Ra) [card=3D39,autodetected]
i2c-dev.o: Registered 'bt848 #0' as minor 0
host/uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
host/uhci.c: 9400: suspend_hc
tuner: chip found @ 0xc0
i2c-core.o: client [(tuner unset)] registered to adapter [bt848 #0](pos. =
0).
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=3D6 tuner=3D5 radio=3Dno stereo=3Dno
bttv0: using tuner=3D5
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: PLL: 28636363 =3D> 35468950 .<7>hub.c: port 1, portstatus 300, cha=
nge 3, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
host/uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
host/uhci.c: 9000: suspend_hc
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
host/uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 100, change 2, 12 Mb/s
hub.c: port 2 enable change, status 100
.<7>host/uhci.c: root-hub INT complete: port1: 48a port2: 58a data: 6
host/uhci.c: 8800: suspend_hc
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
 ok
bttv0: registered device video0
bttv0: registered device vbi0
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntr=
ack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.ne=
t/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
host/uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 2 enable change, status 300
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 332k freed
host/uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 2 enable change, status 300
host/uhci.c: root-hub INT complete: port1: 488 port2: 588 data: 6
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 2 enable change, status 300
Adding Swap: 497972k swap-space (priority -1)
EXT3-fs warning: maximal mount count reached, running e2fsck is recommend=
ed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed=
 Jul 16 19:03:09 PDT 2003
MSDOS FS: IO charset iso8859-2
FAT: Did not find valid FSINFO signature.
Found signature1 0x4e0005 signature2 0xc00b6600 sector=3D1.
VFS: Can't find a valid FAT filesystem on dev 03:02.
FAT: freeing iocharset=3Diso8859-2
MSDOS FS: IO charset iso8859-2
MSDOS FS: IO charset iso8859-2

--Boundary-00=_t6jq/AyEPJpAZHJ
Content-Type: text/plain;
  charset="iso-8859-2";
  name="proc.iomem"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proc.iomem"

00000000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-002ec8ea : Kernel code
  002ec8eb-0038219f : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
eb000000-eb0003ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  eb000000-eb0003ff : tulip
eb800000-eb8000ff : VIA Technologies, Inc. USB 2.0
ec000000-edefffff : PCI Bus #01
  ec000000-ecffffff : nVidia Corporation NV17 [GeForce4 MX 440]
ee000000-ee000fff : Brooktree Corporation Bt878 Audio Capture
ee800000-ee800fff : Brooktree Corporation Bt878 Video Capture
  ee800000-ee800fff : bttv
ef700000-f7ffffff : PCI Bus #01
  ef800000-ef87ffff : nVidia Corporation NV17 [GeForce4 MX 440]
  f0000000-f7ffffff : nVidia Corporation NV17 [GeForce4 MX 440]
f8000000-fbffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

--Boundary-00=_t6jq/AyEPJpAZHJ
Content-Type: text/plain;
  charset="iso-8859-2";
  name="proc.ioports"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proc.ioports"

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
8800-88ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  8800-88ff : tulip
9000-901f : VIA Technologies, Inc. USB (#4)
  9000-901f : usb-uhci
9400-941f : VIA Technologies, Inc. USB (#3)
  9400-941f : usb-uhci
9800-981f : VIA Technologies, Inc. USB (#2)
  9800-981f : usb-uhci
a000-a01f : VIA Technologies, Inc. USB
  a000-a01f : usb-uhci
a400-a40f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
  a400-a407 : ide0
  a408-a40f : ide1
a800-a8ff : PCI device 1106:3149 (VIA Technologies, Inc.)
  a800-a8ff : libata
b000-b00f : PCI device 1106:3149 (VIA Technologies, Inc.)
  b000-b00f : libata
b400-b403 : PCI device 1106:3149 (VIA Technologies, Inc.)
  b400-b403 : libata
b800-b807 : PCI device 1106:3149 (VIA Technologies, Inc.)
  b800-b807 : libata
d000-d003 : PCI device 1106:3149 (VIA Technologies, Inc.)
  d000-d003 : libata
d400-d407 : PCI device 1106:3149 (VIA Technologies, Inc.)
  d400-d407 : libata
d800-d83f : Ensoniq 5880 AudioPCI
  d800-d83f : es1371

--Boundary-00=_t6jq/AyEPJpAZHJ
Content-Type: text/plain;
  charset="iso-8859-2";
  name="ver.linux"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ver.linux"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux mcree 2.4.22-ac4 #7 Wed Nov 5 15:47:02 CET 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.35-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.90
Modules Loaded         nvidia

--Boundary-00=_t6jq/AyEPJpAZHJ--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
