From: Luis Alves <luis.alves-Gbsd49wXnelWk0Htik3J/w@public.gmane.org>
Subject: support for Sony vaio VGN-A1XX
Date: Sun, 15 Aug 2004 00:48:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408150048.04637.luis.alves@engineer.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0UxHBMVb5ZGnspJ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_0UxHBMVb5ZGnspJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi=20

I am trying to make the extra keys on my vaio work,=20
I tried sonypi but was not able to make the keys work,
but I was able to make the brightness work.

Also this laptop as a auto brightness feature with a light sensor to auto=20
adjust the brightness to save battery life. Does any one know how to make=20
this work.

Hi have a report of my experiences with my vaio at:
http://www.linux-on-laptops.com/hosted/svvgna190.html

I attached the acpi info from my computer
cat /proc/acpi/dsdt > /tmp/trace/dsdt.aml
dmesg -s40000 > /tmp/trace/dmesg_s40000.dump
dmidecode > /tmp/trace/dmidecode.dump
lspci -vv > /tmp/trace/lspci_vv.dmup

any information would be usefull.
=2D-=20
___________________________________________________________________________
Luis Antonio Ferreira Alves

http://finalpoint.homeunix.net
email: luis.alves-Gbsd49wXnelWk0Htik3J/w@public.gmane.org
=A0 =A0 =A0 =A0lalves-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
AIM-lalves AIM-lafasvl ICQ-5061305 AIM-lalvesnet YAHOO-lafa_home
___________________________________________________________________________
DB2Everyplace            http://www-3.ibm.com/software/data/db2/everyplace/
Reclaim Your Inbox!           =A0http://www.mozilla.org/products/thunderbir=
d/

--Boundary-00=_0UxHBMVb5ZGnspJ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg_s40000.dump"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg_s40000.dump"

Linux version 2.6.8-0.rc2.2mdk-i686-up-4GB (nplanel-Z0lnJUwvxyVn+L6o72McsUEOCMrvLtNR@public.gmane.org) (g=
cc version 3.4.1 (Mandrakelinux (Alpha 3.4.1-2mdk)) #1 Wed Jul 21 19:15:51 =
CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff40000 (usable)
 BIOS-e820: 000000007ff40000 - 000000007ff50000 (ACPI data)
 BIOS-e820: 000000007ff50000 - 0000000080000000 (ACPI NVS)
1151MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 524096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294720 pages, LIFO batch:16
DMI present.
ACPI: RSDP (v000 SONY                                      ) @ 0x000f53f0
ACPI: RSDT (v001   SONY       F1 0x20040607 MSFT 0x00000097) @ 0x7ff40000
ACPI: FADT (v002   SONY       F1 0x20040607 MSFT 0x00000097) @ 0x7ff40200
ACPI: OEMB (v001   SONY       F1 0x20040607 MSFT 0x00000097) @ 0x7ff50040
ACPI: DSDT (v001   SONY       F1 0x20040607 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Built 1 zonelists
=46ound and enabled local APIC!
Initializing CPU#0
Kernel command line: BOOT_IMAGE=3Dlinuxi686-up-4GB_noresume ro root=3D307 d=
evfs=3Dmount acpi=3Don resume=3D/dev/hda6 splash=3Dsilent nolapic noresume
bootsplash: silent mode.
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1695.018 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2073980k/2096384k available (2020k kernel code, 21252k reserved, 82=
6k data, 284k init, 1178880k highmem, 0k BadRAM)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3358.72 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  afe9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: After all inits, caps:        afe9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
=46reeing initrd memory: 383k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
Looking for DSDT in initrd ... not found!
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 9)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Disabled
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 4
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 4 (level, low) -> IRQ 4
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:01.3[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:04.1[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:04.2[C] -> GSI 7 (level, low) -> IRQ 7
vesafb: framebuffer at 0xd0000000, mapped to 0xf880c000, size 1875k
vesafb: mode is 800x600x16, linelength=3D1600, pages=3D67
vesafb: protected mode interface info at c000:57f6
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
fb0: VESA VGA frame buffer device
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1092519713.4294966188:0): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
bootsplash 3.1.4-2004/02/19-spock-0.1: looking for picture.... silentjpeg s=
ize 10822 bytes, found (800x600, 10774 bytes, v3).
Console: switching to colour frame buffer device 92x32
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23FA-80, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITAUJ-820D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=3D65535/16/63, UDMA(=
100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
Resume Machine: Resuming from device unknown-block(3,6)
Resume Machine: This is normal swap space
disabled
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
ieee1394: Initialized config rom entry `ip1394'
SCSI subsystem initialized
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
Mounted devfs on /dev
=46reeing unused kernel memory: 284k freed
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 9, io base 0000e800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 4, io base 0000e880
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) -> IRQ 7
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 7, io base 0000ec00
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using address 2
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 3 (level, low) -> IRQ 3
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 3, pci mem f8a25c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
ACPI: PCI interrupt 0000:02:04.2[C] -> GSI 7 (level, low) -> IRQ 7
ehci_hcd 0000:02:04.2: NEC Corporation USB 2.0
ehci_hcd 0000:02:04.2: irq 7, pci mem f8a97400
ehci_hcd 0000:02:04.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:02:04.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 5 ports detected
usb 2-2: device not accepting address 2, error -71
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 9 (level, low) -> IRQ 9
ohci_hcd 0000:02:04.0: NEC Corporation USB
ohci_hcd 0000:02:04.0: irq 9, pci mem f8a99000
ohci_hcd 0000:02:04.0: new USB bus registered, assigned bus number 6
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:02:04.1[B] -> GSI 9 (level, low) -> IRQ 9
ohci_hcd 0000:02:04.1: NEC Corporation USB (#2)
usb 4-4: new high speed USB device using address 2
ohci_hcd 0000:02:04.1: irq 9, pci mem f8a9b000
ohci_hcd 0000:02:04.1: new USB bus registered, assigned bus number 7
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
hub 4-4:1.0: USB hub found
hub 4-4:1.0: 4 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ohci_hcd 0000:02:04.1: wakeup
usb 5-4: new high speed USB device using address 3
usb 4-4.1: new low speed USB device using address 3
usbcore: registered new driver hiddev
input: USB HID v1.11 Keyboard [Microsoft Microsoft Wireless Optical Desktop=
=AE 1.00] on usb-0000:00:1d.7-4.1
input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Desktop=AE=
 1.00] on usb-0000:00:1d.7-4.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
ts: Compaq touchscreen protocol output
usb 4-4.2: new low speed USB device using address 4
input,hiddev0: USB HID v1.10 Keyboard [Sony Sony IR Receiver] on usb-0000:0=
0:1d.7-4.2
usb 7-1: new full speed USB device using address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt=
 1 proto 2 vid 0x067B pid 0x2305
Adding 3148700k swap on /dev/hda6.  Priority:-1 extents:1
imm: Version 2.05 (for Linux 2.4.0)
ppa: Version 2.07 (for Linux 2.4.x)
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: AGP aperture is 256M @ 0xe0000000
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 3 (level, low) -> IRQ 3
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[3]  MMIO=3D[ff6fe800-ff6fef=
ff]  Max Packet=3D[2048]
ip1394: $Rev: 1224 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ip1394: eth0: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460301a5325b]
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 9 (level, low) -> IRQ 9
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 328 bytes per conntrack
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [ATF0] (57 C)
inserting floppy driver for 2.6.8-0.rc2.2mdk-i686-up-4GB
=46loppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
inserting floppy driver for 2.6.8-0.rc2.2mdk-i686-up-4GB
=46loppy drive(s): fd0 is 1.44M<4>devfs_mk_dev: could not append to parent =
for floppy/0u1440
devfs_mk_dev: could not append to parent for floppy/0u1680
devfs_mk_dev: could not append to parent for floppy/0u1722
devfs_mk_dev: could not append to parent for floppy/0u1743
devfs_mk_dev: could not append to parent for floppy/0u1760
devfs_mk_dev: could not append to parent for floppy/0u1920
devfs_mk_dev: could not append to parent for floppy/0u1840
devfs_mk_dev: could not append to parent for floppy/0u1600
devfs_mk_dev: could not append to parent for floppy/0u360
devfs_mk_dev: could not append to parent for floppy/0u720
devfs_mk_dev: could not append to parent for floppy/0u820
devfs_mk_dev: could not append to parent for floppy/0u830
devfs_mk_dev: could not append to parent for floppy/0u1040
devfs_mk_dev: could not append to parent for floppy/0u1120
devfs_mk_dev: could not append to parent for floppy/0u800
devfs_mk_dev: could not append to parent for floppy/0

floppy0: no floppy controllers found
inserting floppy driver for 2.6.8-0.rc2.2mdk-i686-up-4GB
=46loppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
inserting floppy driver for 2.6.8-0.rc2.2mdk-i686-up-4GB
=46loppy drive(s): fd0 is 1.44M<4>devfs_mk_dev: could not append to parent =
for floppy/0u1440
devfs_mk_dev: could not append to parent for floppy/0u1680
devfs_mk_dev: could not append to parent for floppy/0u1722
devfs_mk_dev: could not append to parent for floppy/0u1743
devfs_mk_dev: could not append to parent for floppy/0u1760
devfs_mk_dev: could not append to parent for floppy/0u1920
devfs_mk_dev: could not append to parent for floppy/0u1840
devfs_mk_dev: could not append to parent for floppy/0u1600
devfs_mk_dev: could not append to parent for floppy/0u360
devfs_mk_dev: could not append to parent for floppy/0u720
devfs_mk_dev: could not append to parent for floppy/0u820
devfs_mk_dev: could not append to parent for floppy/0u830
devfs_mk_dev: could not append to parent for floppy/0u1040
devfs_mk_dev: could not append to parent for floppy/0u1120
devfs_mk_dev: could not append to parent for floppy/0u800
devfs_mk_dev: could not append to parent for floppy/0

floppy0: no floppy controllers found
inserting floppy driver for 2.6.8-0.rc2.2mdk-i686-up-4GB
=46loppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
NET: Registered protocol family 17
e1000: eth1: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49562 usecs
intel8x0: clocking to 48000
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.3
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0385b20(lo)
IPv6 over IPv4 tunneling driver
mtrr: 0xd0000000,0x4000000 overlaps existing 0xd0000000,0x100000
lp: driver loaded but no devices found
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
inserting floppy driver for 2.6.8-0.rc2.2mdk-i686-up-4GB
=46loppy drive(s): fd0 is 1.44M<4>devfs_mk_dev: could not append to parent =
for floppy/0u1440
devfs_mk_dev: could not append to parent for floppy/0u1680
devfs_mk_dev: could not append to parent for floppy/0u1722
devfs_mk_dev: could not append to parent for floppy/0u1743
devfs_mk_dev: could not append to parent for floppy/0u1760
devfs_mk_dev: could not append to parent for floppy/0u1920
devfs_mk_dev: could not append to parent for floppy/0u1840
devfs_mk_dev: could not append to parent for floppy/0u1600
devfs_mk_dev: could not append to parent for floppy/0u360
devfs_mk_dev: could not append to parent for floppy/0u720
devfs_mk_dev: could not append to parent for floppy/0u820
devfs_mk_dev: could not append to parent for floppy/0u830
devfs_mk_dev: could not append to parent for floppy/0u1040
devfs_mk_dev: could not append to parent for floppy/0u1120
devfs_mk_dev: could not append to parent for floppy/0u800
devfs_mk_dev: could not append to parent for floppy/0

bootsplash 3.1.4-2004/02/19-spock-0.1: looking for picture.... found (800x6=
00, 11774 bytes, v3).
bootsplash: status on console 0 changed to on
bootsplash 3.1.4-2004/02/19-spock-0.1: looking for picture.... found (800x6=
00, 11774 bytes, v3).
bootsplash: status on console 1 changed to on
bootsplash 3.1.4-2004/02/19-spock-0.1: looking for picture.... found (800x6=
00, 11774 bytes, v3).
bootsplash: status on console 2 changed to on
bootsplash 3.1.4-2004/02/19-spock-0.1: looking for picture.... found (800x6=
00, 11774 bytes, v3).
bootsplash: status on console 3 changed to on
floppy0: no floppy controllers found
bootsplash 3.1.4-2004/02/19-spock-0.1: looking for picture.... found (800x6=
00, 11774 bytes, v3).
bootsplash: status on console 4 changed to on
bootsplash 3.1.4-2004/02/19-spock-0.1: looking for picture.... found (800x6=
00, 11774 bytes, v3).
bootsplash: status on console 5 changed to on
eth1: no IPv6 routers present
inserting floppy driver for 2.6.8-0.rc2.2mdk-i686-up-4GB
=46loppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
cdrom: This disc doesn't have any tracks I recognize!
sonypi: Sony Programmable I/O Controller Driver v1.23.
sonypi: detected type2 model, verbose =3D 0, fnkeyinit =3D off, camera =3D =
off, compat =3D off, mask =3D 0xffffffff, useinput =3D on, acpi =3D on
sonypi: enabled at irq=3D11, port1=3D0x1080, port2=3D0x1084
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.
sonypi: removed.
sonypi: Sony Programmable I/O Controller Driver v1.23.
sonypi: detected type2 model, verbose =3D 0, fnkeyinit =3D off, camera =3D =
off, compat =3D off, mask =3D 0xffffffff, useinput =3D on, acpi =3D on
sonypi: enabled at irq=3D11, port1=3D0x1080, port2=3D0x1084
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.

--Boundary-00=_0UxHBMVb5ZGnspJ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmidecode.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode.dump"

# dmidecode 2.4
SMBIOS 2.3 present.
17 structures occupying 809 bytes.
Table at 0x000F8E30.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: American Megatrends Inc.
		Version: R0050F1
		Release Date: 06/07/2004
		Address: 0xF0000
		Runtime Size: 64 kB
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			8042 keyboard services are supported (int 9h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			Smart battery is supported
			BIOS boot specification is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Sony Corporation
		Product Name: VGN-A190(UC)
		Version: C0003QH1
		Serial Number: 28173030-3110492
		UUID: 5B5966C0-FA69-11D7-8BDC-080046D9C22C
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Sony Corporation
		Type: Notebook
		Lock: Not Present
		Version: N/A
		Serial Number: 28173030-3110492
		Asset Tag: 8Q5L00000200fda0ee04d55672f2
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x0000000A
Handle 0x0003
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: N/A
		Type: Central Processor
		Family: Pentium M
		Manufacturer: GenuineIntel
		ID: D6 06 00 00 BF FB E9 AF
		Signature: Type 0, Family 6, Model 13, Stepping 6
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			APIC (On-chip APIC hardware supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			SS (Self-snoop)
			TM (Thermal monitor supported)
			SBF (Signal break on FERR)
		Version: Intel(R) Pentium(R) M processor 1.70GHz
		Voltage: 1.3 V
		External Clock: 100 MHz
		Max Speed: 1700 MHz
		Current Speed: 1700 MHz
		Status: Populated, Enabled
		Upgrade: None
		L1 Cache Handle: 0x0004
		L2 Cache Handle: 0x0005
		L3 Cache Handle: 0x0006
		Serial Number: N/A
		Asset Tag: N/A
		Part Number: N/A
Handle 0x0004
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Socketed, Level 1
		Operational Mode: Varies With Memory Address
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Unknown
		Installed SRAM Type: Unknown
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Data
		Associativity: 8-way Set-associative
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Socketed, Level 2
		Operational Mode: Varies With Memory Address
		Location: Internal
		Installed Size: 2048 KB
		Maximum Size: 2048 KB
		Supported SRAM Types:
			Unknown
		Installed SRAM Type: Unknown
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unified
		Associativity: 8-way Set-associative
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L3 Cache
		Configuration: Disabled, Not Socketed, Level 3
		Operational Mode: Unknown
		Location: Unknown
		Installed Size: 0 KB
		Maximum Size: 0 KB
		Supported SRAM Types:
			Unknown
		Installed SRAM Type: Unknown
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x0007
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCCARD1
		Type: 32-bit PC Card (PCMCIA)
		Current Usage: Available
		Length: Other
		ID: Adapter 0, Socket 1
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PC Card-16 is supported
			Cardbus is supported
			Modem ring resume is supported
			PME signal is supported
			Hot-plug devices are supported
Handle 0x0008
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: UCG260XEUM
Handle 0x0009
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: Unknown
		Maximum Capacity: 2048 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x000A
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0007FFFFFFF
		Range Size: 2 GB
		Physical Array Handle: 0x0009
		Partition Width: 0
Handle 0x000B
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x0009
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: SODIMM
		Set: None
		Locator: SODIMM1
		Bank Locator: BANK0
		Type: DDR
		Type Detail: Unknown
Handle 0x000C
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0003FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x000B
		Memory Array Mapped Address Handle: 0x000A
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x000D
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x0009
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: SODIMM
		Set: None
		Locator: SODIMM2
		Bank Locator: BANK1
		Type: DDR
		Type Detail: Unknown
Handle 0x000E
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00040000000
		Ending Address: 0x0007FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x000D
		Memory Array Mapped Address Handle: 0x000A
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x000F
	DMI type 32, 20 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0010
	DMI type 127, 4 bytes.
	End Of Table

--Boundary-00=_0UxHBMVb5ZGnspJ
Content-Type: application/octet-stream;
  name="dsdt.aml"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dsdt.aml"

RFNEVFg7AAABGVNPTlkAAEYxAAAAAAAABwYEIE1TRlQNAAABW4BCSU9TAAxkAPV/Cv9bgUcHQklP
UwFTUzFfAVNTMl8BU1MzXwFTUzRfAQAESU9TVBBTUElPEFBNQlMQUE1MTghTTUJTEFNNTE4ISU8x
QhBJTzFMCElPMkIQSU8yTAhUT1BNIFJPTVMgQVBDQiBBUENMEE1HMUIgTUcxTCBNRzJCIE1HMkwg
CFdGQVQKkAhXTlZSCpEIUk5WUgqSCFNXRlIKkwhTVERECpQIR1RERAqVCEFEQlIKlghDR1BTCpcI
Q0dXSwqYCElTV1AKmQhXUlJNCpoIUlJSTQqbCFBSUk0KnAhBR0JDCsEIQVNCQwrCCEFTQlIKwwhB
Q1NYCswIQUNCVgrNCEFDQkkKzwhBUkVDCtQIQVdFQwrVCEFHV1AK8AhBR0JJCvEIR1BCUwsABQhH
UExOCkAIU01CTAoQCEZOQzAKAAhGTkMxChIIRk5DMgoeCEZOQzMKKAhGTkM0CjAUD1JSSU8EcA1S
UklPAFsxFA9SRE1BA3ANckRNQQBbMQhQSUNNCgAUH19QSUMBoAlocAqqREJHOKEIcApVREJHOHBo
UElDTRQxT1NGTABwCgFgoCRNQ1RIXF9PU18NTWljcm9zb2Z0IFdpbmRvd3MgTlQAcAoAYKRgFE8E
TUNUSAKgCJWHaIdppAByh2gKAWAIQlVGMBECYAhCVUYxEQJgcGhCVUYwcGlCVUYxohpgdmCgFZKT
g4hCVUYwYACDiEJVRjFgAKQApAEUK0dQUlcCCFBSV1ASBgIKAAoAcGiIUFJXUAoAAHBpiFBSV1AK
AQCkUFJXUAhXQUtQEgYCCgAKAFuAREVCMAEKgAoBW4ELREVCMAFEQkc4CFuAREVCMQEKkAoCW4EL
REVCMQJEQkc5EBATXF9QUl9bgwtDUFUxARAEAAAGEIbjAlxfU0JfCFBSMDASQwgIEg8EDP//AQAK
AExOS0EKABIPBAz//wEACgFMTktCCgASDwQM//8fAAoATE5LQwoAEg8EDP//HwAKAUxOS0IKABIP
BAz//x0ACgBMTktBCgASDwQM//8dAAoBTE5LRAoAEg8EDP//HQAKAkxOS0MKABIPBAz//x0ACgNM
TktICgAIQVIwMBJDBwgSDQQM//8BAAoACgAKEBINBAz//wEACgEKAAoREg0EDP//HwAKAAoAChIS
DQQM//8fAAoBCgAKERINBAz//x0ACgAKAAoQEg0EDP//HQAKAQoAChMSDQQM//8dAAoCCgAKEhIN
BAz//x0ACgMKAAoXCFBSMDISQwoKEg8EDP//CAAKAExOS0UKABIPBAz//wEACgBMTktGCgASDwQM
//8BAAoCTE5LSAoAEg8EDP//AQAKAUxOS0cKABIPBAz//wIACgBMTktDCgASDwQM//8CAAoBTE5L
RAoAEg8EDP//AwAKAExOS0IKABIPBAz//wQACgBMTktBCgASDwQM//8EAAoBTE5LQgoAEg8EDP//
BAAKAkxOS0MKAAhBUjAyEk8IChINBAz//wgACgAKAAoUEg0EDP//AQAKAAoAChUSDQQM//8BAAoC
CgAKFxINBAz//wEACgEKAAoWEg0EDP//AgAKAAoAChISDQQM//8CAAoBCgAKExINBAz//wMACgAK
AAoREg0EDP//BAAKAAoAChASDQQM//8EAAoBCgAKERINBAz//wQACgIKAAoSCFBSMDESEAESDQQL
//8KAExOS0UKAAhBUjAxEg4BEgsEC///CgAKAAoUCFBSU0ERCQoGI/gCGHkABlBSU0FQUlNCBlBS
U0FQUlNDBlBSU0FQUlNEBlBSU0FQUlNFBlBSU0FQUlNGBlBSU0FQUlNHBlBSU0FQUlNIW4KEtwJQ
Q0kwCF9ISUQMQdAKAwhfQURSCgAIX0JCTgoACF9VSUQKABQWX1BSVACgClBJQ02kQVIwMKRQUjAw
W4JCBlAwUDEIX0FEUgwAAAEAFBZfUFJUAKAKUElDTaRBUjAxpFBSMDFbgjlWR0EwCF9BRFIKAFuC
DUNSVF8IX0FEUgsAAVuCDVRWT18IX0FEUgsAAluCDUxDRF8IX0FEUgsQAVuCSzVQMFAyCF9BRFIM
AAAeABQPX1BSVwCkR1BSVwoLCgMUFl9QUlQAoApQSUNNpEFSMDKkUFIwMluCQwRNTEFOCF9BRFIM
AAAIAFuATEFOUgIKAAsAAVuBFUxBTlIBVklEXxAAQG8AD1BNRVMBFA9fUFJXAKRHUFJXCgsKA1uC
QApDQlMwCF9BRFIMAAABAFuAQ0JTUAIKAArwW4E4Q0JTUAMAIENCMDQIAEgHQ0IxNAgASBNDQjND
CAAIQ0IzRQgAKENCNDQgAEBMUE1FMAhQTUUxCBQMX0lOSQBwAENCNDQUEkNCU1cBoAuTaAoDcABD
QjQ0FCpDQlNSAHtQTUUxCoBhoBlhe1BNRTAK/FBNRTBwUE1FMWJwYlBNRTGkYVuCD0NCUzIIX0FE
UgwCAAEAW4IPQ0JTMwhfQURSDAMAAQBbgi9NUENJCF9BRFIMAAACAFuAVkRJRAIKAApAW4ETVkRJ
RAFXTElEIABAFFdMU0QgW4JDBEdMQU4IX0FEUgwAAAMAW4BMQU5SAgoACwABW4EVTEFOUgFWSURf
EABAbwAPUE1FUwEUD19QUlcApEdQUlcKCwoDW4JBCk5VQjAIX0FEUgwAAAQAW4BOTzFQAgoACwAB
W4EvTk8xUAEAIAABTVNQRQEADgBABU1CQVMgAEAYUFNUQQIABlBNRUUBAAZQTUVTARRDBF9QU1cB
cE1CQVNge2AM8P///2BbgE1NSU8AYAsAAVuBF01NSU8DACBIQ1RMCABIJQAPRFJXRQGgCWhwCgFE
UldFFA9fUFJXAKRHUFJXCgsKA1uCQQpOVUIxCF9BRFIMAQAEAFuATk8xUAIKAAsAAVuBL05PMVAB
ACAAAU1TUEUBAA4AQAVNQkFTIABAGFBTVEECAAZQTUVFAQAGUE1FUwEUQwRfUFNXAXBNQkFTYHtg
DPD///9gW4BNTUlPAGALAAFbgRdNTUlPAwAgSENUTAgASCUAD0RSV0UBoAlocAoBRFJXRRQPX1BS
VwCkR1BSVwoLCgNbgk0FTkVVQghfQURSDAIABABbgE5PMVACCgALAAFbgS9OTzFQAQAgAAFNU1BF
AQAOAEAFTUJBUyAAQBhQU1RBAgAGUE1FRQEABlBNRVMBFA9fUFJXAKRHUFJXCgsKA1uCgbkBU0JS
RwhfQURSDAAAHwBbgitQSUNfCF9ISUQLQdAIX0NSUxEYChVHASAAIAAAAkcBoACgAAACIgQAeQBb
gk4ERE1BRAhfSElEDEHQAgAIX0NSUxE4CjUqEARHAQAAAAAAEEcBgQCBAAADRwGHAIcAAAFHAYkA
iQAAA0cBjwCPAAABRwHAAMAAACB5AFuCJVRNUl8IX0hJRAxB0AEACF9DUlMREAoNRwFAAEAAAAQi
AQB5AFuCJVJUQzAIX0hJRAxB0AsACF9DUlMREAoNRwFwAHAAAAIiAAF5AFuCSgRQUzJLCF9ISUQM
QdADAxQbX1NUQQB5CgEKCmCgC3tJT1NUYACkCg+kCgAIX0NSUxEYChVHAWAAYAAAAUcBZABkAAAB
IgIAeQBbgkYJUFMyTRQbX0hJRACgDFxJRDEwpAxN2ZABoQekDE3ZkAkIX0NJRAxB0A8TFBtfU1RB
AHkKAQoMYKALe0lPU1RgAKQKD6QKAAhDUlMxEQgKBSIAEHkACENSUzIRGAoVRwFgAGAAAAFHAWQA
ZAAAASIAEHkAFCFfQ1JTAHkKAQoKYKANe0lPU1RgAKRDUlMxoQakQ1JTMluCIlNQS1IIX0hJRAxB
0AgACF9DUlMRDQoKRwFhAGEAAAF5AFuCJUNPUFIIX0hJRAxB0AwECF9DUlMREAoNRwHwAPAAABAi
ACB5AFuCQwpTWVNSCF9ISUQMQdAMAghfVUlECgEIX0NSUxFGCAqCRwEQABAAABBHASIAIgAAHkcB
RABEAAAcRwFjAGMAAAFHAWUAZQAAAUcBZwBnAAAJRwFyAHIAAA5HAYAAgAAAAUcBhACEAAADRwGI
AIgAAAFHAYwAjAAAA0cBkACQAAAQRwGiAKIAAB5HAeAA4AAAEEcB0ATQBAACRwEA/gD+AAJ5AFuC
SQtGV0hfCF9ISUQMQdAMAghfVUlECgMIQ1JTXxEdChqGCQAAAAAAAAAAAACGCQAAAAAAAAAAAAB5
AIpDUlNfCgRCUzAwikNSU18KCEJMMDCKQ1JTXwoQQlMxMIpDUlNfChRCTDEwFEIFX0NSUwBwDAAA
gP9ggkZIRDBhdmGgCmF3YQwAAAgAYXJgYWJwYkJTMDByQlMwMAwAAEAAQlMxMHQKAEJTMTBCTDAw
cEJMMDBCTDEwpENSU19bgEZIUjACCuMKAVuBC0ZIUjABRkhEMAhbgk4cT1NZUwhfSElEDEHQDAII
X1VJRAoCCENSU18RPQo6RwEAAAAAAABHAQAAAAAAAEcBAAAAAAAARwEAAAAAAACGCQAAAAAAAAAA
AACGCQAAAAAAAAAAAAB5ABRDF19DUlMAi0NSU18KAkdQMDCLQ1JTXwoER1AwMYxDUlNfCgdHUDBM
cFBNQlNHUDAwcFBNQlNHUDAxcFBNTE5HUDBMoE0EkJKTU1BJTwvwA5RTUElPCvCLQ1JTXwoKR1Ax
MItDUlNfCgxHUDExjENSU18KD0dQTDFwU1BJT0dQMTBwU1BJT0dQMTFwCgJHUEwxoEIESU8xQotD
UlNfChJHUDIwi0NSU18KFEdQMjGMQ1JTXwoXR1AyTHBJTzFCR1AyMHBJTzFCR1AyMXBJTzFMR1Ay
TKBCBElPMkKLQ1JTXwoaR1AzMItDUlNfChxHUDMxjENSU18KH0dQM0xwSU8yQkdQMzBwSU8yQkdQ
MzFwSU8yTEdQM0ygRgVBUENCikNSU18KKE1MMDGKQ1JTXwokTUIwMYpDUlNfCjRNTDAyikNSU18K
ME1CMDJwQVBDQk1CMDFwQVBDTE1MMDFwDAAA4P5NQjAycAsAEE1MMDKkQ1JTXxBDU1wAW4BcR1BT
QwEKsgoCW4ERXEdQU0MBU01DTQhTTVNUCBQNXElTTUkJcGhTTUNNFA1cRElBRwFwaERCRzhbgFxQ
TUlPAVBNQlMKgFuBQghcUE1JTwEAQAgAAVREVFkDVEVOQQFUVERUA0ZSQ1QBAAhUSExTAQBOCgAL
U0JQUwEABAAIRzA4UwEAAkcxMVMBRzEyUwFGTFBTAQACAAJUUE9MAQAFAAgACEcwOEUBAAJHMTFF
AUcxMkUBAAMABFNMUEUBAAMAGAAEU0xQUwEAA1uAXEdQSU8BR1BCUwpAW4FJBFxHUElPAQBABgAZ
Q0JTUAEAAklQV1IBAEMOAAtMSURMAQABRkxQTAEAQgUABUlEMDgBSUQwOQFJRDEwAQABQlRQUgEA
AQABW4BcRUNNUwEKcgoCW4ERXEVDTVMRRUlORAhFREFUCFuGTA5FSU5ERURBVAEAQAhJS0ZHCEZS
UE4QUkFNQiBBVk9MCExCVE4IQ0tMTghDSzAwCENLMDEIQ0swMghDSzAzCENLMDQIQ0swNQhDSzA2
CENLMDcIQ0swOAhDSzA5CENLMTAIQ0sxMQhDSzEyCENLMTMIQ0sxNAhDSzE1CENLMTYIQ0sxNwhD
SzE4CENLMTkIQ0syMAhDSzIxCENLMjIIQ0syMwhDSzI0CENLMjUIQ0syNghDSzI3CENLMjgIQ0sy
OQhFUlJGCE9DTEsIV0lERQFPVkNLAlM0MksDAAJDUFVSBkNQVUYCTEJUMghbgFNNSTABCwD+CgJb
gQtTTUkwAFNNSUMIW4BcUkFNVwBSQU1CCwAIW4FFD1xSQU1XAQBAWFRSVFkIRlNGTghGU1RBEEZB
RFIgRlNJWhBBQ1RECEFWTEQIU0VURAhBQ1BGAURDUEYBQ0hHRgFEQ1AyAUNIRzIBAANQQURMEENB
REwQQ1NURRBOU1RFEFNTVEUQU0ZVTghUU0FECFRBQzMIVEFDMghUQUMxCFRBQzAIVFBTVghUQ1JU
CEYxTDAIRjJMMAhGMUwxCEYyTDEIRjFMMghGMkwyCEYxTDMIRjJMMwhGMUw0CEYyTDQIU0xQVAhE
QlIxCERCUjIgQUlCRgEAB1NTRkcITEFORggASA5DTURCCElORkQgU1hCRoAIAluBFlxSQU1XAQBA
gAAISU5GMQhJTkYyCFsBTUFTUwAUGUFTU18JcGhDTURCcABTTUlDcAoAQ01EQhQnQVNTRApbI01B
U1P//3BpSU5GREFTU19ocElORkRgWydNQVNTpGAULUFTU1cLWyNNQVNT//9waUlORjFwaklORjJB
U1NfaHBJTkYxYFsnTUFTU6RgFCdBU1NCClsjTUFTU///cGlJTkYxQVNTX2hwSU5GMWBbJ01BU1Ok
YAhPU0ZHCgAIT1M5WAoBCE9TOTgKAghPU01FCgQIT1MySwoICE9TWFAKEBRFDU9TVlIAoCdbElxf
T1NJYKAdXF9PU0kNV0lORE9XUyAyMDAxAHBPU1hQT1NGR6FACqAmTUNUSFxfT1NfDU1pY3Jvc29m
dCBXaW5kb3dzAHBPUzk4T1NGR6FGB6A8TUNUSFxfT1NfDU1pY3Jvc29mdCBXaW5kb3dzTUU6IE1p
bGxlbm5pdW0gRWRpdGlvbgBwT1NNRU9TRkehNqApTUNUSFxfT1NfDU1pY3Jvc29mdCBXaW5kb3dz
IE5UAHBPUzJLT1NGR6EKcE9TWFBPU0ZHpE9TRkcUHFxEQkdSAXBoREJSMVxJU01JXEFEQlKkREJS
MQhNTkFNDVNFABAXXC5fU0JfUENJMBQLX0lOSQBcT1NWUhAtXF9TQl9bgiVQV1JCCF9ISUQMQdAM
DAhfUFJXEgYCCh0KBRQJX1NUQQCkCg8QRytcLwNfU0JfUENJMFNCUkdbgkQqRUMwXwhfSElEDEHQ
DAkIX0NSUxEVChJHAWIAYgABAUcBZgBmAAEBeQAIX0dQRQocCEVDT0sKABQSX1JFRwKgC5NoCgNw
aUVDT0sIX1BSVxIGAgodCgVbgEVDUl8DCgAK/1uBRhRFQ1JfEQBAQAACRE9LRAFERkJQAQAEQlQx
QQFCVDJBAUFDQVQBAAVQV1JCAUpPR0IBTElEUwEABUJUMVABQlQyUAEABkIxU1QIQjJTVAgAQAVN
QVNLCEJUMVMBQlQyUwEABkJUMVcBQlQyVwEABkZBTjAIQ0IwUwFDQjFTAQAGUEhZTwEAB0JSSVQI
Q09OVAhTTkRVAVNOREQBAAZTTURNAQAHAAhTSVJRCFNMT0IIU0hJQghNUFdSAVdBS0kBTVBCUAFN
UEJEAgADAAhCMVJDEEIxQUIQQjFBQxBCMVZPEEIyUkMQQjJBQhBCMkFDEEIyVk8QQjFEQxBCMUxG
EEIxRFYQQjFETBBCMkRDEEIyTEYQQjJEVhBCMkRMEEExVFAQQTFBVBBBMVBUEEExQ1QQQTJUUBBB
MkFUEEEyUFQQQTJDVBAUK19RNTAAhkFDQUQKgIZcLl9QUl9DUFUxCoBbIgpkhlwuX1BSX0NQVTEK
gRQjX1E1MQCgDEJUMUGGQkFUMQoAoQiGQkFUMQoBhkJBVDEKgBQ3X1E1OABwDV9RNTg6QVRGIHRo
ZXJtYWwgcG9saWN5IGNoYW5nZWQAWzGGXC5fVFpfQVRGMAqBFD9fUTVGAHANX1E1RjpBVEYgdGVt
cGVyYXR1cmUgcmVhY2hlcyB0cmlwIHBvaW50AFsxhlwuX1RaX0FURjAKgBQcX1E2MACgFVxEQkdS
CgCGXC5fU0JfUFdSQgqAFBNfUTY2AIZcLl9TQl9MSURfCoAQSjpcLwNfU0JfUENJMFNCUkdbgkc5
U1BJQwhfSElEDE3ZYAEIUlNSQxEQCg1HAQAAAAABICIAAHkACFNTUkMREAoNRwEAAAAAASAiAAB5
AAhTSVJUEgoECgYKCQoKCgsUQRJfQ1JTAIxSU1JDCgJJT00xjFJTUkMKA0lPTTKLUlNSQwoCSU8x
SYtSU1JDCgRJTzFBi1JTUkMKCUlSUVagOZNcLwVfU0JfUENJMFNCUkdFQzBfRUNPSwoAcEFTU0JB
UkVDCpxJT00xcEFTU0JBUkVDCp1JT00yoTlwXC8FX1NCX1BDSTBTQlJHRUMwX1NMT0JJT00xcFwv
BV9TQl9QQ0kwU0JSR0VDMF9TSElCSU9NMnBJTzFJSU8xQaApk1wvBV9TQl9QQ0kwU0JSR0VDMF9F
Q09LCgB6QVNTQkFSRUMKmwoEYKEcelwvBV9TQl9QQ0kwU0JSR0VDMF9TSVJRCgRggmBhoBZhdmFw
g4hTSVJUYQBgeQoBYElSUVakUlNSQxRLD19TUlMBjGgKAklPQTGMaAoDSU9BMotoCglJUlFWgklS
UVZgoBdgdmBwiVNJUlQBYAAKAAoAYXkKEGFioQVwCgBioCaTXC8FX1NCX1BDSTBTQlJHRUMwX0VD
T0sKAEFTU1dBV0VDCptioRpwYlwvBV9TQl9QQ0kwU0JSR0VDMF9TSVJRoDeTXC8FX1NCX1BDSTBT
QlJHRUMwX0VDT0sKAEFTU1dBV0VDCp1JT0EyQVNTV0FXRUMKnElPQTGhOXBJT0EyXC8FX1NCX1BD
STBTQlJHRUMwX1NISUJwSU9BMVwvBV9TQl9QQ0kwU0JSR0VDMF9TTE9CWyIKAQhfUFJTES0KKjBH
AYAQgBABIDBHAaAQoBABIDBHAcAQwBABIDBHAeAQ4BABIDgiQA55ABRMCV9ESVMAoD+TXC8FX1NC
X1BDSTBTQlJHRUMwX0VDT0sKAEFTU1dBV0VDCpsKAEFTU1dBV0VDCp0KAEFTU1dBV0VDCpwKAKFA
BXAKAFwvBV9TQl9QQ0kwU0JSR0VDMF9TSVJRcAoAXC8FX1NCX1BDSTBTQlJHRUMwX1NISUJwCgBc
LwVfU0JfUENJMFNCUkdFQzBfU0xPQlsiCgEUTAVfU1RBAKApk1wvBV9TQl9QQ0kwU0JSR0VDMF9F
Q09LCgB6QVNTQkFSRUMKmwoEYKEcelwvBV9TQl9QQ0kwU0JSR0VDMF9TSVJRCgRggmBhoAVhpAoP
oQSkCg1bgkEaU05DXwhfSElEDE3ZUAEURgVHQlJUAKAok1wvBV9TQl9QQ0kwU0JSR0VDMF9FQ09L
CgBwXEFTU0RBUkVDCpZgoRpwXC8FX1NCX1BDSTBTQlJHRUMwX0JSSVRgpFxBU1NCQUNCSWAURgVT
QlJUAXBcQVNTQkFDQlZoYKAlk1wvBV9TQl9QQ0kwU0JSR0VDMF9FQ09LCgBcQVNTQkFTQlJgoRpw
YFwvBV9TQl9QQ0kwU0JSR0VDMF9CUklUpAAUEkdQQlIApFxBU1NCQUdCQwoAFBJTUEJSAVxBU1NC
QVNCQ2ikABQIUFdBSwCkABQvQ1NYQgFbI1xNQVNT//9waFxTWEJGXEFTU19BQ1NYcFxTWEJGYFsn
XE1BU1OkYBQjR1dEUABwQVNTREFHV1AKAGCgDpNcQlRQUgoAfWAKAWCkYBQyUkJNRgl7aAwAAAEA
YFxBU1NEQUdCSWBbIgvQB3AMAAAAA2BwXEFTU0RBR0JJYGCkYBQIUlNCSQmkABQjQ0JNRgl9e2gM
//8BAAAMAAAAAmBwXEFTU0RBR0JJYGCkYBBGGlxfVFpfW4VNGUFURjAUFktFTFYBcGhgd2AKCmBy
YAurCmCkYBRKCl9UTVAAoCiTXC8FX1NCX1BDSTBTQlJHRUMwX0VDT0sKAHBcQVNTREFSRUMKwGGh
GnBcLwVfU0JfUENJMFNCUkdFQzBfQTFUUGF6YQoIYKBDBZRgCoBbIgoyoCiTXC8FX1NCX1BDSTBT
QlJHRUMwX0VDT0sKAHBcQVNTREFSRUMKwGGhGnBcLwVfU0JfUENJMFNCUkdFQzBfQTFUUGF6YQoI
YKRLRUxWYBRGBV9QU1YAoCiTXC8FX1NCX1BDSTBTQlJHRUMwX0VDT0sKAHBcQVNTREFSRUMKxGGh
GnBcLwVfU0JfUENJMFNCUkdFQzBfQTFQVGF6YQoIYKRLRUxWYAhfUFNMEgwBXC5fUFJfQ1BVMRRG
BV9DUlQAoCiTXC8FX1NCX1BDSTBTQlJHRUMwX0VDT0sKAHBcQVNTREFSRUMKxmGhGnBcLwVfU0Jf
UENJMFNCUkdFQzBfQTFDVGF6YQoIYKRLRUxWYAhfVEMxCgEIX1RDMgoCCF9UU1AKMhBCEVwAFEEH
T0VNUwGgNJNoCgNwXC8FX1NCX1BDSTBTQlJHU1BJQ19DUlNcLwVfU0JfUENJMFNCUkdTUElDU1NS
Q6A0k2gKBHBcLwVfU0JfUENJMFNCUkdTUElDX0NSU1wvBV9TQl9QQ0kwU0JSR1NQSUNTU1JDFEsJ
T0VNVwGGXC5fUFJfQ1BVMQqAWyIKZIZcLl9QUl9DUFUxCoGgM5NoCgNcLwVfU0JfUENJMFNCUkdT
UElDX1NSU1wvBV9TQl9QQ0kwU0JSR1NQSUNTU1JDoEEEk2gKBFwvBV9TQl9QQ0kwU0JSR1NQSUNf
U1JTXC8FX1NCX1BDSTBTQlJHU1BJQ1NTUkOGXC5fU0JfUFdSQgoCEE0eXF9HUEUUGF9MMDMIhlwv
A19TQl9QQ0kwVVNCMQoCFBhfTDA0CIZcLwNfU0JfUENJMFVTQjIKAhQYX0wwQwiGXC8DX1NCX1BD
STBVU0IzCgIUGF9MMEQIhlwvA19TQl9QQ0kwRUhDSQoCFBhfTDA1CIZcLwNfU0JfUENJME1PRE0K
AhROE19MMEIIoC5cLwVfU0JfUENJMFAwUDJOVUIwUE1FU4ZcLwRfU0JfUENJMFAwUDJOVUIwCgKg
LlwvBV9TQl9QQ0kwUDBQMk5VQjFQTUVThlwvBF9TQl9QQ0kwUDBQMk5VQjEKAqAuXC8FX1NCX1BD
STBQMFAyTkVVQlBNRVOGXC8EX1NCX1BDSTBQMFAyTkVVQgoCoEQFe1xMQU5GCgEAoEgEXC8FX1NC
X1BDSTBQMFAyTUxBTlBNRVOGXC8EX1NCX1BDSTBQMFAyTUxBTgoCcAFcLwVfU0JfUENJMFAwUDJN
TEFOUE1FU6BEBXtcTEFORgoCAKBIBFwvBV9TQl9QQ0kwUDBQMkdMQU5QTUVThlwvBF9TQl9QQ0kw
UDBQMkdMQU4KAnABXC8FX1NCX1BDSTBQMFAyR0xBTlBNRVMUKV9MMUQIhlwvBF9TQl9QQ0kwU0JS
R0VDMF8KAoZcLl9TQl9QV1JCCgIQRwhcLwRfU0JfUENJMFNCUkdFQzBfW4JAB0FDQUQIX0hJRA1B
Q1BJMDAwMwAIX1BDTBIHAVxfU0JfFEMEX1BTUgCgKpNcLwVfU0JfUENJMFNCUkdFQzBfRUNPSwoA
e0FTU0RBUkVDCoALAARhoQdwQUNBVGGgBGGkAaEDpAAUCV9TVEEApAoPEEohXC8EX1NCX1BDSTBT
QlJHRUMwX1uCQyBCQVQxCF9ISUQMQdAMCghfUENMEgcBXF9TQl8IQkFUSRItDQoAC1CWC1CWCgAL
0DkKAAp4CgAKCg0ADQANTElPTgANU29ueSBDb3JwLgAIQkFUUxIPBAoCDP////8Leg0LQDgUSQRf
U1RBAKAqk1wvBV9TQl9QQ0kwU0JSR0VDMF9FQ09LCgB7QVNTREFSRUMKgAsAAWGhB3BCVDFBYaAG
YXAKH2ChBXAKD2CkYBRCCF9CSUYAoD+TXC8FX1NCX1BDSTBTQlJHRUMwX0VDT0sKAHBBU1NEQVJF
QwqwYHBBU1NEQVJFQwqyYXBBU1NEQVJFQwq2YqETcEIxRENgcEIxTEZhcEIxRFZid2AKCohCQVRJ
CgEAd2EKCohCQVRJCgIAcGKIQkFUSQoEAKRCQVRJFEANX0JTVACgRwWTXC8FX1NCX1BDSTBTQlJH
RUMwX0VDT0sKAHB7QVNTREFSRUMKhAr/YIhCQVRTCgAAcEFTU0RBUkVDCqZgcEFTU0RBUkVDCqRh
cEFTU0RBUkVDCqJioSBwQjFTVIhCQVRTCgAAcEIxVk9gcEIxQUNhcEIxQUJioA2TYQv//3AM////
/2GhHKAPkpVhCwCAf2EL//9hdWF3YGFheGEL6AMAYXBhiEJBVFMKAQB3YgoKiEJBVFMKAgBwYIhC
QVRTCgMApEJBVFMQRgVcX1NCXwhBVEtQAFuCRwRBVEtECF9ISUQNQVRLMDEwMAAIX1VJRAwAAQEB
FBJJTklUAXABQVRLUKRcTU5BTRQMU0ZVTgBwCiBgpGAUCEJTVFMApAAQSQZcX1NCX1uCQAZMSURf
CF9ISUQMQdAMDRRPBF9MSUQAoCqTXC8FX1NCX1BDSTBTQlJHRUMwX0VDT0sKAHtcQVNTQkFSRUMK
ggoEYKEacFwvBV9TQl9QQ0kwU0JSR0VDMF9MSURTYKRgEEELXC5fU0JfQVRLRBQoRlNNSQFwaFxG
U0ZOfWgKoGBwYFxEQkc4SVNNSVxXRkFUpFxGU1RBFBNGTFNIAXBoXEZTVEFGU01JCgAUFEZJTkkB
cGhcRkFEUqRGU01JCgEUFEZFUlMBcGhcRlNUQaRGU01JCgIUIkZXUkkBcGhcRkFEUnALABBcRlNJ
WqR0CwAQRlNNSQoDABQaRldSUABwCgBcRlNJWqR0CwAQRlNNSQoDAFuCTaJJREUwCF9BRFIMAQAf
AAhSRUdGCgEUEl9SRUcCoAuTaAoCcGlSRUdGW4BCQVIwAgoACwABW4FFBkJBUjADAEAgVElNUBBU
SU1TEFNUTVAEU1RNUwQAGFVETVACVURNUwIADFVEVFAGAAJVRFRTBgBCBFBDQjACU0NCMAJQQ0Ew
AlNDQTACAARGUEIwAkZTQjACUFNJRwJTU0lHAghUSU0wEkcHCRILBAp4CrQK8AuEAxIKBAojCiEK
EAoAEgoECgsKCQoECgASDgYKcApJCjYKJwoZCg8SDgYKAAoBCgIKAQoCCgESDgYKAAoACgAKAQoB
CgESDgYKAAoACgAKAAoACgESCgQKBAoDCgIKABIKBAoCCgEKAAoACFRNRDARAwoUilRNRDAKAFBJ
TzCKVE1EMAoERE1BMIpUTUQwCghQSU8xilRNRDAKDERNQTGKVE1EMAoQQ0hORghHVElNCgAIR1NU
TQoACEdVRE0KAAhHVURUCgAIR0NCMAoACEdGQjAKAFuCQwxDSE4wCF9BRFIKABQjX0dUTQCkR1RN
X1RJTVBTVE1QVURNUFVEVFBQQ0IwRlBCMBRDB19TVE0DcGhUTUQwcFRJTVBHVElNcFVEVFBHVURU
oDtTVE1fcEdUSU1USU1QcEdTVE1TVE1QcEdVRE1VRE1QcEdVRFRVRFRQcEdDQjBQQ0IwcEdGQjBG
UEIwcEdURl8KAGlBVEEwcEdURl8KAWpBVEExW4IcRFJWMAhfQURSCgAUD19HVEYApFJBVEFBVEEw
W4JDDENITjEIX0FEUgoBFCNfR1RNAKRHVE1fVElNU1NUTVNVRE1TVURUU1NDQjBGU0IwFEMHX1NU
TQNwaFRNRDBwVElNU0dUSU1wVURUU0dVRFSgO1NUTV9wR1RJTVRJTVNwR1NUTVNUTVNwR1VETVVE
TVNwR1VEVFVEVFNwR0NCMFNDQjBwR0ZCMEZTQjBwR1RGXwoAaUFUQTJwR1RGXwoBakFUQTNbghxE
UlYwCF9BRFIKABQPX0dURgCkUkFUQUFUQTIURhlHVE1fDnD/UElPMHBQSU8wUElPMXBQSU8wRE1B
MHBQSU8wRE1BMXAAQ0hORqAFUkVHRqEGpFRNRDCgEXtoCgIAfUNITkYKAkNITkZ6e2gLADMACghl
cImDiFRJTTAKAQACZQAKAAoAZnCDiIOIVElNMAoAAGYAZ3BnRE1BMKAOe2gKCABwC4QDUElPMKEH
cGdQSU8woBF7aAogAH1DSE5GCghDSE5GoEIFe2gLAEAAfUNITkYKEENITkZwiYOIVElNMAoCAAJp
AAoACgBlcIOIg4hUSU0wCgAAZQBmcGZETUExoA57aAqAAHALhANQSU8xoQdwZlBJTzGgSAR7agoB
AHtrCgNloBCQe20KAQCTZQoBcmUKBGWhDaALe2wKAQByZQoCZXCDiIOIVElNMAoDAGUARE1BMH1D
SE5GCgFDSE5GoEwEe2oKAgB7emsKBAAKA2WgEJB7bQoCAJNlCgFyZQoEZaENoAt7bAoCAHJlCgJl
cIOIg4hUSU0wCgMAZQBETUExfUNITkYKBENITkakVE1EMBREJVNUTV8IoAVSRUdGoQSkCgB7R1RJ
TQtEgEdUSU1wCgBHU1RNcAoAR1VETXAKAEdDQjB7R1VEVArMR1VEVHAKAEdGQjCgRwd7Q0hORgoB
AHCJg4hUSU0wCgMAAkRNQTAACgAKAGCgCZRgCgVwCgVgfUdVRFSDiIOIVElNMAoEAGAAR1VEVH1H
Q0Iwg4iDiFRJTTAKBQBgAEdDQjB9R0ZCMIOIg4hUSU0wCgYAYABHRkIwfUdVRE0KAUdVRE2hN6A1
fZNQSU8w/5NQSU8wCgAAoCR7lURNQTD/lERNQTAKAABwRE1BMFBJTzB9R1RJTQoIR1RJTaBDCHtD
SE5GCgQAcImDiFRJTTAKAwACRE1BMQAKAAoAYKAJlGAKBXAKBWB9R1VEVHmDiIOIVElNMAoEAGAA
CgQAR1VEVH1HQ0IweYOIg4hUSU0wCgUAYAAKAQBHQ0IwfUdGQjB5g4iDiFRJTTAKBgBgAAoBAEdG
QjB9R1VETQoCR1VETaE3oDV9k1BJTzH/k1BJTzEKAACgJHuVRE1BMf+URE1BMQoAAHBETUExUElP
MX1HVElNCoBHVElNoBR7Q0hORgoCAH1HVElNCgNHVElNoBR7Q0hORgoIAH1HVElNCjBHVElNe4mD
iFRJTTAKAAAEUElPMAAKAAoACgNgcIOIg4hUSU0wCgEAYABheWEKCGJ9R1RJTWJHVElNoD97Q0hO
RgoQAH1HVElNCwBAR1RJTXuJg4hUSU0wCgAABFBJTzEACgAKAAoDYHCDiIOIVElNMAoCAGAAR1NU
TaQKAQhBVDAxEQoKBwMAAAAAAO8IQVQwMhEKCgcAAAAAAACQCEFUMDMRCgoHAAAAAAAAxghBVDA0
EQoKBwAAAAAAAJEIQVRBMBEDCh0IQVRBMREDCh0IQVRBMhEDCh0IQVRBMxEDCh0IQVRBQhEDCh2M
QVRBQgoAQ01EQxRMBUdURkILd0NNREMKOGByYAoIYVsTQVRBQmEKOENNRFh3Q01EQwoHYIxBVEFC
cmAKAgBBMDAxjEFUQUJyYAoGAEEwMDVwaENNRFhwaUEwMDFwakEwMDV1Q01EQxRHI0dURl8KcAoA
Q01EQwhJRDQ5CwAMCElENTkKAAhJRDUzCgQISUQ2MwsADwhJRDg4CwAPCElSRFkKAQhQSU9UCgAI
RE1BVAoAoE0Fk4dpCwACi2kKYklXNDlwSVc0OUlENDmLaQpqSVc1M3BJVzUzSUQ1M4tpCn5JVzYz
cElXNjNJRDYzi2kKdklXNTlwSVc1OUlENTmLaQqwSVc4OHBJVzg4SUQ4OHAKoGegSAVocAqwZ3tD
SE5GCghJUkRZoBJ7Q0hORgoQAHBQSU8xUElPVKEKcFBJTzBQSU9UoCd7Q0hORgoEAKASe0NITkYK
EABwRE1BMURNQVShCnBETUEwRE1BVKEoe0NITkYKAklSRFlwUElPMFBJT1SgEntDSE5GCgEAcERN
QTBETUFUoEcEkJB7SUQ1MwoEAHtJRDg4CwD/AERNQVRwiYOIVElNMAoDAAJETUFUAAoACgBhoAmU
YQoFcAoFYUdURkJBVDAxfQpAYQBnoUYEoEMEkHtJRDYzCwD/AFBJT1R7iYOIVElNMAoAAARQSU9U
AAoACgAKA2B9CiCDiIOIVElNMAoIAGAAYUdURkJBVDAxYWegOElSRFl7iYOIVElNMAoAAARQSU9U
AAoACgAKA2B9CgiDiIOIVElNMAoHAGAAYUdURkJBVDAxYWehF6AVe0lENDkLAAQAR1RGQkFUMDEK
AWegJJB7SUQ1OQsAAQB7SUQ1OQr/AEdURkJBVDAze0lENTkK/wBnpEFUQUIUJVJBVEEBjGgKAENN
RE53Q01ETgo4YFsTaAoIYFJFVEKkUkVUQluCD1NNQkMIX0FEUgwDAB8AW4IPQVVESQhfQURSDAUA
HwBbgh9NT0RNCF9BRFIMBgAfABQPX1BSVwCkR1BSVwoFCgNbgk4GVVNCMQhfQURSDAAAHQBbgEJB
UjACCsAKBVuBGUJBUjABVUJMMRAAEFAwV0UBUDFXRQEABhQnX1BTVwGgEGhwCgFQMFdFcAoBUDFX
RaEPcAoAUDBXRXAKAFAxV0UUD19QUlcApEdQUlcKAwoDW4JOBlVTQjIIX0FEUgwBAB0AW4BCQVIw
AgrACgVbgRlCQVIwAVVCTDEQABBQMFdFAVAxV0UBAAYUJ19QU1cBoBBocAoBUDBXRXAKAVAxV0Wh
D3AKAFAwV0VwCgBQMVdFFA9fUFJXAKRHUFJXCgQKA1uCTgZVU0IzCF9BRFIMAgAdAFuAQkFSMAIK
wAoFW4EZQkFSMAFVQkwxEAAQUDBXRQFQMVdFAQAGFCdfUFNXAaAQaHAKAVAwV0VwCgFQMVdFoQ9w
CgBQMFdFcAoAUDFXRRQPX1BSVwCkR1BSVwoMCgNbgh9FSENJCF9BRFIMBwAdABQPX1BSVwCkR1BS
VwoNCgMQTUJcLl9QUl9DUFUxCFRZUEUKAAhQRENNCgEUTAVfUERDAXCHaGAIUERDQhECYHBoUERD
QopQRENCCgBSRVZfilBEQ0IKBFNJWkWgC5VTSVpFCgGkCgCKUERDQgoIREFUMKASe0RBVDBQRENN
AHAKAVRZUEWkCgEITVBDVBIsAhEUChGCDAB/QAAAmQEAAAAAAAB5ABEUChGCDAB/EAAAmAEAAAAA
AAB5AAhQUENUEiwCERQKEYIMAAEQAACyAAAAAAAAAHkAERQKEYIMAAEIAACzAAAAAAAAAHkAFBhf
UENUAKAKVFlQRaRNUENUoQakUFBDVAhNUFNTEkEMChISBgukBgsIUgoKCgoLKBELKBESEgYLpAYL
CFIKCgoKCygRCygREhIGC6QGCwhSCgoKCgsoEQsoERISBgukBgsIUgoKCgoLKBELKBESEgYLpAYL
CFIKCgoKCygRCygREhIGC3gFC1xECgoKCgsiDgsiDhISBguwBAuYOgoKCgoLHgwLHgwSEgYL6AML
1DAKCgoKCxoKCxoKEhIGCyADCxAnCgoKCgsWCAsWCBISBgtYAgtMHQoKCgoLEgYLEgYIUFBTUxJD
CwoSEAYLpAYLCFIKCgpuCoYKABIQBgukBgsIUgoKCm4KhgoAEhAGC6QGCwhSCgoKbgqGCgASEAYL
pAYLCFIKCgpuCoYKABIRBgukBgsIUgoKCm4LhgAKABIRBgt4BQtcRAoKCm4LhgEKARIRBguwBAuY
OgoKCm4LhgIKAhIRBgvoAwvUMAoKCm4LhgMKAxIRBgsgAwsQJwoKCm4LhgQKBBIRBgtYAgtMHQoK
Cm4LhgUKBQhOUFNTCgYUGF9QU1MAoApUWVBFpE1QU1OhBqRQUFNTFCRfUFBDAKAPkpSHUFBTU05Q
U1OkCgChDaR0h1BQU1NOUFNTABRDF19DU1QACEFDU1QSQwQDCgISHgQRFAoRggwAfwAAAAAAAAAA
AAAAeQAKAQoBC+gDEh4EERQKEYIMAAEIAAAUBAAAAAAAAHkACgIKAQv0AQhCQ1NUEkEGBAoDEh4E
ERQKEYIMAH8AAAAAAAAAAAAAAHkACgEKAQvoAxIeBBEUChGCDAABCAAAFAQAAAAAAAB5AAoCCgEL
9AESHQQRFAoRggwAAQgAABUEAAAAAAAAeQAKAwpVCvoIQ0NTVBJPBwUKBBIeBBEUChGCDAB/AAAA
AAAAAAAAAAB5AAoBCgEL6AMSHgQRFAoRggwAAQgAABQEAAAAAAAAeQAKAgoBC/QBEh0EERQKEYIM
AAEIAAAVBAAAAAAAAHkACgMKVQr6Eh0EERQKEYIMAAEIAAAWBAAAAAAAAHkACgMKuQpkoCFcLwZf
U0JfUENJMFNCUkdFQzBfQUNBRF9QU1KkQUNTVKEUoAtcU1NGR6RDQ1NUoQakQkNTVBBFQlxfU0Jf
W4BcLwRfU0JfUENJMFNCUkdJUk9SAgoACv9bgUMEXC8EX1NCX1BDSTBTQlJHSVJPUgEAQDBQSVJB
CFBJUkIIUElSQwhQSVJECAAgUElSRQhQSVJGCFBJUkcIUElSSAgIQlVGQREJCgYjAIAYeQCLQlVG
QQoBSUNSUxQWTFNUQQF7aAqAYKAFYKQKCaEEpAoLFBhMQ1JTAXtoCg9geQoBYElDUlOkQlVGQRQX
TFNSUwGLaAoBSVNSU4JJU1JTYKR2YBQMTERJUwGkfWgKgABbgkgGTE5LQQhfSElEDEHQDA8IX1VJ
RAoBFA9fU1RBAKRMU1RBUElSQRQLX1BSUwCkUFJTQRQTX0RJUwBwTERJU1BJUkFQSVJBFA9fQ1JT
AKRMQ1JTUElSQRQQX1NSUwFwTFNSU2hQSVJBW4JIBkxOS0IIX0hJRAxB0AwPCF9VSUQKAhQPX1NU
QQCkTFNUQVBJUkIUC19QUlMApFBSU0IUE19ESVMAcExESVNQSVJCUElSQhQPX0NSUwCkTENSU1BJ
UkIUEF9TUlMBcExTUlNoUElSQluCSAZMTktDCF9ISUQMQdAMDwhfVUlECgMUD19TVEEApExTVEFQ
SVJDFAtfUFJTAKRQUlNDFBNfRElTAHBMRElTUElSQ1BJUkMUD19DUlMApExDUlNQSVJDFBBfU1JT
AXBMU1JTaFBJUkNbgkgGTE5LRAhfSElEDEHQDA8IX1VJRAoEFA9fU1RBAKRMU1RBUElSRBQLX1BS
UwCkUFJTRBQTX0RJUwBwTERJU1BJUkRQSVJEFA9fQ1JTAKRMQ1JTUElSRBQQX1NSUwFwTFNSU2hQ
SVJEW4JIBkxOS0UIX0hJRAxB0AwPCF9VSUQKBRQPX1NUQQCkTFNUQVBJUkUUC19QUlMApFBSU0UU
E19ESVMAcExESVNQSVJFUElSRRQPX0NSUwCkTENSU1BJUkUUEF9TUlMBcExTUlNoUElSRVuCSAZM
TktGCF9ISUQMQdAMDwhfVUlECgYUD19TVEEApExTVEFQSVJGFAtfUFJTAKRQUlNGFBNfRElTAHBM
RElTUElSRlBJUkYUD19DUlMApExDUlNQSVJGFBBfU1JTAXBMU1JTaFBJUkZbgkgGTE5LRwhfSElE
DEHQDA8IX1VJRAoHFA9fU1RBAKRMU1RBUElSRxQLX1BSUwCkUFJTRxQTX0RJUwBwTERJU1BJUkdQ
SVJHFA9fQ1JTAKRMQ1JTUElSRxQQX1NSUwFwTFNSU2hQSVJHW4JIBkxOS0gIX0hJRAxB0AwPCF9V
SUQKCBQPX1NUQQCkTFNUQVBJUkgUC19QUlMApFBSU0gUE19ESVMAcExESVNQSVJIUElSSBQPX0NS
UwCkTENSU1BJUkgUEF9TUlMBcExTUlNoUElSSBBIE1xfU0JfEEATUENJMAhDUlNfEUwICoiIDQAC
DAAAAAAA/wAAAAABRwH4DPgMAQiIDQABDAMAAAAA9wwAAPgMiA0AAQwDAAAADf//AAAA84cXAAAM
AwAAAAAAAAoA//8LAAAAAAAAAAIAhxcAAAwDAAAAAAAAAAAAAAAAAAAAAAAAAACHFwAADAMAAAAA
AAAAAAAAAAAAAAAAAAAAAHkAikNSU18KXE1JTjWKQ1JTXwpgTUFYNYpDUlNfCmhMRU41ikNSU18K
dk1JTjaKQ1JTXwp6TUFYNopDUlNfCoJMRU42FEUFX0NSUwBwTUcxQk1JTjVwTUcxTExFTjVwTUcx
TGCgDWByTUlONXZgTUFYNXBNRzJCTUlONnBNRzJMTEVONnBNRzJMYHJNSU42dmBNQVg2pENSU18I
SU9YQgvABQhJT1hMChAUJ19QVFMBcGhEQkc4UFRTX2hwCgCIV0FLUAoAAHAKAIhXQUtQCgEAFDpf
V0FLAXloCgREQkc4V0FLX2igFYOIV0FLUAoAAHAKAIhXQUtQCgEAoQtwaIhXQUtQCgEApFdBS1AI
X1MwXxIKBAoACgAKAAoACF9TM18SCgQKBQoACgAKAAhfUzRfEgoECgYKAAoACgAIX1M1XxIKBAoH
CgAKAAoAFAtQVFNfAU9FTVNoFAtXQUtfAU9FTVdo

--Boundary-00=_0UxHBMVb5ZGnspJ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci_vv.dmup"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci_vv.dmup"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: Sony Corporation: Unknown device 8187
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [4104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff500000-ff5fffff
	Prefetchable memory behind bridge: ce900000-de9fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 8188
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at e800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 8188
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 4
	Region 4: I/O ports at e880 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 8188
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 7
	Region 4: I/O ports at ec00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation: Unknown device 8188
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 3
	Region 0: Memory at ff7ffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff600000-ff6fffff
	Prefetchable memory behind bridge: dea00000-deafffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Sony Corporation: Unknown device 8188
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
	Subsystem: Sony Corporation: Unknown device 8188
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 0540 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: Sony Corporation: Unknown device 818b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at ee00 [size=256]
	Region 1: I/O ports at e000 [size=64]
	Region 2: Memory at ff7ff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at ff7ff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 818c
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at e080 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 818a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c800 [size=256]
	Region 2: Memory at ff5f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ff5c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
	Subsystem: Sony Corporation: Unknown device 818f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 80001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

02:01.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI Two-Port PHY/Link-Layer Controller (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 818f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 10
	Interrupt: pin C routed to IRQ 3
	Region 0: Memory at ff6fe800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ff6f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:01.3 Unknown mass storage controller: Texas Instruments PCI7420/PCI7620 Dual Socket CardBus and Smart Card Cont. w/ 1394a-2000 OHCI Two-Port  PHY/Link-Layer Cont. an
	Subsystem: Sony Corporation: Unknown device 8190
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1750ns min, 1000ns max), cache line size 10
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at ff6ff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corp.: Unknown device 2751
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 6000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:03.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
	Subsystem: Sony Corporation: Unknown device 818e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ff6c0000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at ff6a0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at dc00 [size=64]
	Expansion ROM at ff680000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
02:04.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 819a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ff6f7000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 819a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 10
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at ff6fc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation: Unknown device 819a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), cache line size 10
	Interrupt: pin C routed to IRQ 7
	Region 0: Memory at ff6fe400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-00=_0UxHBMVb5ZGnspJ--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
