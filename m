From: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Subject: ACPI support for VIA chipsets
Date: Wed, 12 May 2004 15:19:56 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405121520.14811.meaton@vasco.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was hoping to find out what support there is for my hardware in ACPI. I h=
ave=20
the Acer Ferrari 3000LMi laptop and most things seem to work correctly=20
battery/cpu etc however the laptop will suspend, it just never resumes :-(

I have included the output of the various tools below.
Thanks in advance.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D lspci -v output =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset Hos=
t=20
Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 7205
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable)
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if =
00=20
[Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Expansion ROM at 00009000 [disabled] [size=3D4K]
	Capabilities: <available only to root>

0000:00:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus=20
Controller (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 168, IRQ 5
	Memory at 20000000 (32-bit, non-prefetchable)
	Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	16-bit legacy interface ports at 0001

0000:00:08.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2=
000=20
Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at d0006000 (32-bit, non-prefetchable)
	Memory at d0000000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: <available only to root>

0000:00:09.0 Network controller: Broadcom Corporation BCM94306 802.11g (rev=
=20
03)
	Subsystem: Unknown device 185f:1220
	Flags: bus master, fast devsel, latency 64, IRQ 11
	Memory at d0004000 (32-bit, non-prefetchable)

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 64, IRQ 4
	I/O ports at 1c00 [size=3D32]
	Capabilities: <available only to root>

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 1c20 [size=3D32]
	Capabilities: <available only to root>

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1c40 [size=3D32]
	Capabilities: <available only to root>

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-=
if=20
20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at d0006800 (32-bit, non-prefetchable)
	Capabilities: <available only to root>

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

0000:00:11.1 IDE interface: VIA Technologies, Inc.=20
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8=
a=20
[Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 64, IRQ 4
	I/O ports at 1c60 [size=3D16]
	Capabilities: <available only to root>

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.=20
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: medium devsel, IRQ 9
	I/O ports at 1000
	Capabilities: <available only to root>

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC=
97=20
Modem] (rev 80)
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: medium devsel, IRQ 9
	I/O ports at 1400
	Capabilities: <available only to root>

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]=
=20
(rev 74)
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, medium devsel, latency 64, IRQ 4
	I/O ports at 1800
	Memory at d0006c00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV250 5c61=20
[Radeon Mobility 9200 M9+] (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 003e
	Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 255, IRQ 4
	Memory at d8000000 (32-bit, prefetchable)
	I/O ports at 9000 [size=3D256]
	Memory at d0100000 (32-bit, non-prefetchable) [size=3D64K]
	Capabilities: <available only to root>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D dmesg output =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

 @ 0x1fef69c1
ACPI: FADT (v001 KN400  PTLTW    0x06040000 PTL_ 0x000f4240) @ 0x1fefbe53
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1fefbec7
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: root=3D/dev/hda2 ro=20
Local APIC disabled by BIOS -- reenabling.
=46ound and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1858.318 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 510300k/523200k available (1508k kernel code, 12120k reserved, 640k=
=20
data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3678.20 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an=20
initrd
=46reeing initrd memory: 4412k freed
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Mobile AMD Athlon(tm) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1857.0256 MHz.
=2E.... host bus clock speed is 265.0322 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd65c, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
spurious 8259A interrupt: IRQ7.
ACPI: IRQ10 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: Embedded Controller [EC0] (gpe 1)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f68e0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb6a1, dseg 0x400
pnp: 00:09: ioport range 0xfe00-0xfe01 has been reserved
pnp: 00:0c: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0c: ioport range 0x4000-0x407f has been reserved
pnp: 00:0c: ioport range 0x8100-0x810f has been reserved
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even=20
'acpi=3Doff'
VFS: Disk quotas dquot_6.5.1
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq =3D 3) is a NS16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S3 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4412 blocks [1 disk] into ram disk... | / - \ | / - \ | / =
=2D \=20
| / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | /=
 -=20
\ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ |=
 /=20
=2D - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | /=
 - \=20
| / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | /=
 -=20
\ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ |=
 /=20
=2D - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | /=
 - \=20
| / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ | / - \ done.
VFS: Mounted root (cramfs filesystem) readonly.
=46reeing unused kernel memory: 144k freed
NET: Registered protocol family 1
SCSI subsystem initialized
libata version 1.02 loaded.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1c60-0x1c67, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c68-0x1c6f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23FA-60, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST DVD-RW GWA-4040N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=3D65535/16/63, UDMA(=
100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
VFS: Can't find ext3 filesystem on dev hda2.
VFS: Can't find ext2 filesystem on dev hda2.
Unable to identify CD-ROM format.
=46AT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev hda2.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda2, size 8192, journal first block 18, ma=
x=20
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda2) for (hda2)
Using r5 hash to sort names
Unable to find swap-space signature
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f0650
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 8 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:6 (@c00f06e4)
powernow:  cpuid: 0x7a0	fsb: 133	maxFID: 0x16	startvid: 0xc
powernow:    FID: 0x8 (7.0x [931MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0xa (8.0x [1064MHz])	VID: 0x17 (1.100V)
powernow:    FID: 0xc (9.0x [1197MHz])	VID: 0x15 (1.150V)
powernow:    FID: 0xe (10.0x [1330MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0x0 (11.0x [1463MHz])	VID: 0x11 (1.250V)
powernow:    FID: 0x2 (12.0x [1596MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x14 (13.0x [1729MHz])	VID: 0xd (1.350V)
powernow:    FID: 0x16 (14.0x [1862MHz])	VID: 0xc (1.400V)

powernow: Minimum speed 931 MHz. Maximum speed 1862 MHz.
ts: Compaq touchscreen protocol output
mice: PS/2 mouse device common for all mice
Linux agpgart interface v0.100 (c) Dave Jones
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg,=
=20
GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 431 MBytes.
[fglrx] module loaded - fglrx 3.7.6 [Mar  5 2004] on minor 0
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, ma=
x=20
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names
Unable to find swap-space signature
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=3D1 or dxs_support=3D4 option
         and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:07.0 [1025:003e]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0088, PCI irq 5
Socket status: 30000006
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. USB
uhci_hcd 0000:00:10.0: irq 4, io base 00001c00
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:10.1: irq 5, io base 00001c20
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. USB (#3)
uhci_hcd 0000:00:10.2: irq 9, io base 00001c40
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
irda_init()
NET: Registered protocol family 23
drivers/usb/core/usb.c: registered new driver hiddev
usb 3-1: new full speed USB device using address 2
input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:10.0-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: Flash R/W         Rev: 2002
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0x1800, 00:c0:9f:34:4b:2e, IRQ 4.
eth0: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
agpgart: Detected VIA KM400/KM400A chipset
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 256M @ 0xe0000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1172 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[5]  MMIO=3D[d0006000-d00067=
ff] =20
Max Packet=3D[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f0000147cc2]
ip1394: $Rev: 1175 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: irq 11, pci mem e0b9c800
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 3-1: USB disconnect, address 2
usb 3-1: new full speed USB device using address 3
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: Flash R/W         Rev: 2002
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
USB Mass Storage device found at 3
usb 1-1: USB disconnect, address 2
usb 1-1: new low speed USB device using address 3
input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:10.0-1
acerhk: no version for "struct_module" found: kernel tainted.
acerhk: enabling dritek keyboard extension
Acer Travelmate hotkey driver v0.5.10
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Thermal Zone [THRM] (59 C)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df
cs: IO port probe 0x0a00-0x0aff: clean.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02ec880(lo)
IPv6 over IPv4 tunneling driver
[fglrx] AGP detected, AgpState   =3D 0x1f000a0b (hardware caps of chipset)
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[fglrx] AGP enabled,  AgpCommand =3D 0x1f000302 (selected caps)
[fglrx] free  AGP =3D 256126976
[fglrx] max   AGP =3D 256126976
[fglrx] free  LFB =3D 114278400
[fglrx] max   LFB =3D 114278400
[fglrx] free  Inv =3D 0
[fglrx] max   Inv =3D 0
[fglrx] total Inv =3D 0
[fglrx] total TIM =3D 0
[fglrx] total FB  =3D 0
[fglrx] total AGP =3D 65536
eth0: no IPv6 routers present
NET: Registered protocol family 17
usb 3-2: new full speed USB device using address 4
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
drivers/usb/core/usb.c: registered new driver hci_usb
atkbd.c: Unknown key pressed (translated set 2, code 0xd8 on isa0060/serio0=
).
atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
atkbd.c: Unknown key released (translated set 2, code 0xd8 on isa0060/serio=
0).
atkbd.c: Use 'setkeycodes e058 <keycode>' to make it known.
usb 3-2: USB disconnect, address 4
[fglrx:firegl_umm_init] *ERROR* UMM area already initialized!
[fglrx:firegl_unlock] *ERROR* Process 3480 using kernel context 0
[fglrx:firegl_umm_init] *ERROR* UMM area already initialized!
[fglrx:firegl_unlock] *ERROR* Process 4737 using kernel context 0
ndiswrapper version 0.7 loaded
ndiswrapper adding bcmwl5.sys
wlan0: ndiswrapper ethernet device 00:0b:6b:48:73:6f using driver bcmwl5.sys
atkbd.c: Unknown key pressed (translated set 2, code 0xd5 on isa0060/serio0=
).
atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.
atkbd.c: Unknown key released (translated set 2, code 0xd5 on isa0060/serio=
0).
atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.
wlan0: no IPv6 routers present
wlan0: no IPv6 routers present
wlan0: no IPv6 routers present
wlan0: no IPv6 routers present
wlan0: no IPv6 routers present
wlan0: no IPv6 routers present
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D dmidecode output =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

# dmidecode 2.4
SMBIOS 2.3 present.
24 structures occupying 766 bytes.
Table at 0x000D8010.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Acer  =20
		Version: 3A22
		Release Date: 12/23/2003
		Address: 0xE3140
		Runtime Size: 118464 bytes
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			5.25"/1.2 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Acer
		Product Name: Ferrari 3000 =20
		Version: 0
		Serial Number: 04072422             =20
		UUID: C015982A-F641-D811-ABC7-00C09F344B2E
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Acer,Inc.
		Product Name: Aspire 1450
		Version: Rev.A
		Serial Number: None
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Acer,Inc.
		Type: Notebook
		Lock: Not Present
		Version: 3A22
		Serial Number: 04072422             =20
		Asset Tag: ................................  =20
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00001234
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor Information
		Socket Designation: U23
		Type: Central Processor
		Family: Athlon
		Manufacturer: AMD
		ID: A0 06 00 00 FF F9 83 03
		Signature: Family 6, Model A, Stepping 0
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
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
		Version: AMD Athlon(tm) pr
		Voltage: 2.2 V
		External Clock: Unknown
		Max Speed: 1000 MHz
		Current Speed: 1866 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0008
		L2 Cache Handle: 0x0009
		L3 Cache Handle: Not Provided
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 128 MB
		Maximum Total Memory Size: 256 MB
		Supported Speeds:
			70 ns
			60 ns
		Supported Memory Types:
			FPM
			EDO
			DIMM
			SDRAM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0000
			0x0001
		Enabled Error Correcting Capabilities:
			Unknown
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Socket 0
		Bank Connections: 0 1
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Socket 1
		Bank Connections: 2 3
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 7, 19 bytes.
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
		Error Correction Type: None
		System Type: Other
		Associativity: Other
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Single-bit ECC
		System Type: Unified
		Associativity: Other
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J23
		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
		External Reference Designator: Parallel
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J11
		Internal Connector Type: None
		External Reference Designator: Keyboard
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J12
		Internal Connector Type: None
		External Reference Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000D
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot 1
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x000E
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot 2
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x000F
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: 1
		String 2: 1234567890
Handle 0x0010
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 4 GB
		Error Information Handle: Not Provided
		Number Of Devices: 3
Handle 0x0011
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x0010
		Error Information Handle: No Error
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: M1
		Bank Locator: Bank 0
		Type: DRAM
		Type Detail: Synchronous
		Speed: Unknown
Handle 0x0012
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x0010
		Error Information Handle: No Error
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: M2
		Bank Locator: Bank 1
		Type: DRAM
		Type Detail: Synchronous
		Speed: Unknown
Handle 0x0013
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x0010
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: M3
		Bank Locator: Bank 2
		Type: DRAM
		Type Detail: Synchronous
		Speed: Unknown
Handle 0x0014
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0010
		Partition Width: 0
Handle 0x0015
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0011
		Memory Array Mapped Address Handle: 0x0014
		Partition Row Position: 1
Handle 0x0016
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x0017
	DMI type 127, 4 bytes.
	End Of Table


=2D --=20
Mark Eaton
Senior Software Engineer
VASCO The Authentication Company
+67 3511 5404
+67 (0) 403 384 886
meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAobQCKd93Pkvz/M4RAjmCAJ9KYcrPE8OQjn7yq9KKqF7nFAEtbQCfRucF
lAYSNBBGg/3S28EzXtn1VbM=3D
=3D0nfD
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
