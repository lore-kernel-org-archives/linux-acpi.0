From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: IBM Thinkpad problem please give INFO
Date: Thu, 14 Aug 2003 17:26:34 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720AE4@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ruben Puettmann <ruben-BMzfhW7wj34cWVvVuXF20w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, usb-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 we made some progress on this platform. :)
I'd like to follow up this issue on bugme.osdl.org.

Ps.  It's for all 2.4 and 2.6 ACPI  serious bug.

Thanks,
Luming

-----Original Message-----
From: Ruben Puettmann [mailto:ruben-BMzfhW7wj34cWVvVuXF20w@public.gmane.org]
Sent: 2003?8?13? 19:41
To: Yu, Luming
Cc: Pavel Machek; usb-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; =
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] IBM Thinkpad problem please give INFO


On Wed, Aug 13, 2003 at 11:37:21AM +0800, Yu, Luming wrote:
> Would you please test below patch.
>=20
Testet with 2.4.22-pre10-ac1 and error found ...

This happends:

First the boot up:

I Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
schedule_task(): keventd has not started
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even =
'acpi=3Doff'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6d90
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9d5f, dseg 0x400
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x4d0-0x4d1 has been reserved
PnPBIOS: PNP0c02: ioport range 0x1000-0x105f has been reserved
PnPBIOS: PNP0c02: ioport range 0x1060-0x107f has been reserved
PnPBIOS: PNP0c02: ioport range 0x1180-0x11bf has been reserved
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 6 performance states, 8 =
throttling states)
ACPI: Thermal Zone [THM0] (68 C)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI ISAPNP enabled
kmod: failed to exec /sbin/modprobe -s -k parport_lowlevel, errno =3D 2
lp: driver loaded but no devices found
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
i810_rng: RNG not detected
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel(R) 855PM chipset
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] AGP 0.99 Aperture @ 0xd0000000 256MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-60B, ATA DISK drive
blk: queue c04980c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: MATSHITADVD-RAM UJ-810, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 117210240 sectors (60012 MB) w/2048KiB Cache, CHS=3D7752/240/63, =
UDMA(100)
hdc: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: DVD-RAM UJ-810    Rev: C104
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394_0: Remapped memory spaces reg 0xe0868000
ohci1394_0: Soft reset finished
ohci1394_0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394_0: 4 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: GUID: 00061b00:2008c600
ohci1394_0: Receive DMA ctx=3D0 initialized
ohci1394_0: Receive DMA ctx=3D0 initialized
ohci1394_0: Transmit DMA ctx=3D0 initialized
ohci1394_0: Transmit DMA ctx=3D1 initialized
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=3D[9]  MMIO=3D[c0215000-c02157ff]  =
Max Packet=3D[2048]
ohci1394_0: request csr_rom address: dfd02000
ohci1394_0: IntEvent: 00020010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=3D0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=3D0 ... discarded
Intel 810 + AC97 Audio, version 0.24, 13:15:52 Aug 13 2003
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xc0000c00 and =
0xc0000800, IRQ 5
i810: Intel ICH4 mmio at 0xe086ac00 and 0xe086c800
ohci1394_0: IntEvent: 00010000
ohci1394_0: SelfID interrupt received (phyid 0, root)
ohci1394_0: SelfID packet 0x807f8842 received
ieee1394: Including SelfID 0x42887f80
ohci1394_0: SelfID for this node is 0x807f8842
ohci1394_0: SelfID complete
ohci1394_0: PhyReqFilter=3Dffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... =
irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ieee1394: Initiating ConfigROM request for node 0-00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 c3500404
ieee1394: received packet: ffc00160 ffc00000 00000000 c3500404
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 02a000e0
ieee1394: received packet: ffc00960 ffc00000 00000000 02a000e0
ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 001b0600
ieee1394: received packet: ffc00d60 ffc00000 00000000 001b0600
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 00c60820
ieee1394: received packet: ffc01160 ffc00000 00000000 00c60820
ieee1394: send packet local: ffc01540 ffc0ffff f0000400
ieee1394: received packet: ffc01540 ffc0ffff f0000400
ieee1394: send packet local: ffc01560 ffc00000 00000000 c3500404
ieee1394: received packet: ffc01560 ffc00000 00000000 c3500404
ieee1394: send packet local: ffc01940 ffc0ffff f0000414
ieee1394: received packet: ffc01940 ffc0ffff f0000414
ieee1394: send packet local: ffc01960 ffc00000 00000000 760f0300
ieee1394: received packet: ffc01960 ffc00000 00000000 760f0300
ieee1394: send packet local: ffc01d40 ffc0ffff f0000418
ieee1394: received packet: ffc01d40 ffc0ffff f0000418
ieee1394: send packet local: ffc01d60 ffc00000 00000000 28000803
ieee1394: received packet: ffc01d60 ffc00000 00000000 28000803
ieee1394: send packet local: ffc02140 ffc0ffff f000041c
ieee1394: received packet: ffc02140 ffc0ffff f000041c
ieee1394: send packet local: ffc02160 ffc00000 00000000 02000081
ieee1394: received packet: ffc02160 ffc00000 00000000 02000081
ieee1394: send packet local: ffc02540 ffc0ffff f0000424
ieee1394: received packet: ffc02540 ffc0ffff f0000424
ieee1394: send packet local: ffc02560 ffc00000 00000000 ab030600
ieee1394: received packet: ffc02560 ffc00000 00000000 ab030600
ieee1394: send packet local: ffc02940 ffc0ffff f0000420
ieee1394: received packet: ffc02940 ffc0ffff f0000420
ieee1394: send packet local: ffc02960 ffc00000 00000000 c083000c
ieee1394: received packet: ffc02960 ffc00000 00000000 c083000c
ieee1394: NodeMgr: raw=3D0xe000a002 irmc=3D1 cmc=3D1 isc=3D1 bmc=3D0 =
pmc=3D0 cyc_clk_acc=3D0 max_rec=3D2048 gen=3D0 lspd=3D2
ieee1394: send packet local: ffc02d40 ffc0ffff f0000400
ieee1394: received packet: ffc02d40 ffc0ffff f0000400
ieee1394: send packet local: ffc02d60 ffc00000 00000000 c3500404
ieee1394: received packet: ffc02d60 ffc00000 00000000 c3500404
ieee1394: send packet local: ffc03140 ffc0ffff f0000414
ieee1394: received packet: ffc03140 ffc0ffff f0000414
ieee1394: send packet local: ffc03160 ffc00000 00000000 760f0300
ieee1394: received packet: ffc03160 ffc00000 00000000 760f0300
ieee1394: send packet local: ffc03540 ffc0ffff f0000418
ieee1394: received packet: ffc03540 ffc0ffff f0000418
ieee1394: send packet local: ffc03560 ffc00000 00000000 28000803
ieee1394: received packet: ffc03560 ffc00000 00000000 28000803
ieee1394: send packet local: ffc03940 ffc0ffff f000041c
ieee1394: received packet: ffc03940 ffc0ffff f000041c
ieee1394: send packet local: ffc03960 ffc00000 00000000 02000081
ieee1394: received packet: ffc03960 ffc00000 00000000 02000081
ieee1394: send packet local: ffc03d40 ffc0ffff f0000424
ieee1394: received packet: ffc03d40 ffc0ffff f0000424
ieee1394: send packet local: ffc03d60 ffc00000 00000000 ab030600
ieee1394: received packet: ffc03d60 ffc00000 00000000 ab030600
ieee1394: send packet local: ffc04140 ffc0ffff f0000428
ieee1394: received packet: ffc04140 ffc0ffff f0000428
ieee1394: send packet local: ffc04160 ffc00000 00000000 00000000
ieee1394: received packet: ffc04160 ffc00000 00000000 00000000
ieee1394: send packet local: ffc04540 ffc0ffff f000042c
ieee1394: received packet: ffc04540 ffc0ffff f000042c
ieee1394: send packet local: ffc04560 ffc00000 00000000 00000000
ieee1394: received packet: ffc04560 ffc00000 00000000 00000000
ieee1394: send packet local: ffc04940 ffc0ffff f0000430
ieee1394: received packet: ffc04940 ffc0ffff f0000430
ieee1394: send packet local: ffc04960 ffc00000 00000000 756e694c
ieee1394: received packet: ffc04960 ffc00000 00000000 756e694c
ieee1394: send packet local: ffc04d40 ffc0ffff f0000434
ieee1394: received packet: ffc04d40 ffc0ffff f0000434
ieee1394: send packet local: ffc04d60 ffc00000 00000000 484f2078
ieee1394: received packet: ffc04d60 ffc00000 00000000 484f2078
ieee1394: send packet local: ffc05140 ffc0ffff f0000438
ieee1394: received packet: ffc05140 ffc0ffff f0000438
ieee1394: send packet local: ffc05160 ffc00000 00000000 312d4943
ieee1394: received packet: ffc05160 ffc00000 00000000 312d4943
ieee1394: send packet local: ffc05540 ffc0ffff f000043c
ieee1394: received packet: ffc05540 ffc0ffff f000043c
ieee1394: send packet local: ffc05560 ffc00000 00000000 00343933
ieee1394: received packet: ffc05560 ffc00000 00000000 00343933
ieee1394: send packet local: ffc05940 ffc0ffff f0000420
ieee1394: received packet: ffc05940 ffc0ffff f0000420
ieee1394: send packet local: ffc05960 ffc00000 00000000 c083000c
ieee1394: received packet: ffc05960 ffc00000 00000000 c083000c
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b002008c600]
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 0-63:1023, tlabel=3D0, =
tcode=3D0x0, speed=3D0
ohci1394_0: Starting transmit DMA ctx=3D0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=3D0x00008011
ohci1394_0: Packet sent to node 63 tcode=3D0x0 tLabel=3D0x00 ack=3D0x11 =
spd=3D0 data=3D0x1F0000C0 ctx=3D0
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels =3D 2
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 11
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O LAN OSM (C) 1999 University of Helsinki.
i2o_scsi.c: Version 0.0.1
  chain_pool: 0 bytes @ dfd3b760
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
802.1Q VLAN Support v1.8 Ben Greear <greearb-my8/4N5VtI7c+919tysfdA@public.gmane.org>
All bugs added by David S. Miller <davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding Swap: 1050836k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver usbkbd
usbkbd.c: :USB HID Boot Protocol keyboard driver
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 9, pci mem e090f000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
uhci.c: USB UHCI at I/O 0x1820, IRQ 11
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
uhci.c: USB UHCI at I/O 0x1840, IRQ 10
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
e100: eth0 NIC Link is Up 100 Mbps Full duplex
Linux PCMCIA Card Services 3.2.2
  kernel build: 2.4.22-pre10-ac1 #8 Die Aug 5 17:34:09 CEST 2003
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
  Unknown [104c ac56] rev 00 PCI-to-CardBus at slot 02:00, mem =
0x20001000
    host opts [0]: [pci irq 11] [lat 64/176] [bus 3/5]
    PCI irq 11 test failed
    ISA irqs (default) =3D 3,4,7 polling interval =3D 1000 ms

cat /proc/interrupts

           CPU0      =20
  0:      45715          XT-PIC  timer
  1:       1363          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  Intel ICH4
  8:          4          XT-PIC  rtc
  9:         67          XT-PIC  acpi, ohci1394, ehci_hcd, usb-uhci
 10:          0          XT-PIC  usb-uhci
 11:        858          XT-PIC  usb-uhci, eth0
 12:        144          XT-PIC  PS/2 Mouse
 14:       5303          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0=20
LOC:      10572=20
ERR:          0
MIS:          0

find /proc/acpi
.
./thermal_zone
./thermal_zone/THM0
./thermal_zone/THM0/polling_frequency
./thermal_zone/THM0/cooling_mode
./thermal_zone/THM0/trip_points
./thermal_zone/THM0/temperature
./thermal_zone/THM0/state
./processor
./processor/CPU
./processor/CPU/limit
./processor/CPU/throttling
./processor/CPU/performance
./processor/CPU/power
./processor/CPU/info
./fan
./button
./button/sleep
./button/sleep/SLPB
./button/sleep/SLPB/info
./button/lid
./button/lid/LID
./button/lid/LID/state
./button/lid/LID/info
./button/power
./button/power/PWRF
./button/power/PWRF/info
./battery
./battery/BAT1
./battery/BAT1/alarm
./battery/BAT1/state
./battery/BAT1/info
./battery/BAT0
./battery/BAT0/alarm
./battery/BAT0/state
./battery/BAT0/info
./ac_adapter
./ac_adapter/AC
./ac_adapter/AC/state
./embedded_controller
./embedded_controller/EC
./embedded_controller/EC/info
./power_resource
./power_resource/PUBS
./power_resource/PUBS/state
./alarm
./sleep
./event
./fadt
./dsdt
./info


Now the error the first run from acpi runs fine and I got the output :

Battery 1: charging, 67%, 00:33:53 until charged

on the second try:=20

    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.GBST] (Node c15bbdc0), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.BAT0._BST] (Node c15bbf00), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.GBST] (Node c15bbdc0), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.BAT0._BST] (Node c15bbf00), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.GBST] (Node c15bbdc0), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.BAT0._BST] (Node c15bbf00), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.GBST] (Node c15bbdc0), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed =
[\_SB_.PCI0.LPC_.EC__.BAT0._BST] (Node c15bbf00), AE_AML_INTERNAL

Whats wrong?


        Ruben

--=20
Ruben Puettmann
ruben-BMzfhW7wj34cWVvVuXF20w@public.gmane.org
http://www.puettmann.net


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/=
01
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
