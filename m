From: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Shuttle HOT-591P fails ACPI on 2.4.23
Date: Mon, 8 Dec 2003 22:50:49 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031209045049.GB10168@dbz.icequake.net>
References: <20031208122424.GA18539@dbz.icequake.net> <1070896460.2407.15.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1070896460.2407.15.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: multipart/mixed; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

This is the first time I have booted an ACPI-enabled kernel on this
machine.  So I wasn't expecting too much. ;)

Shuttle's spec page for the board: http://de.shuttle.com/591p.htm
does claim to support ACPI.

I attached the files you asked for.  acpi_pic_sci=3Dedge didn't seem to
make a difference (paused in same place, and same error)


On Mon, Dec 08, 2003 at 10:14:20AM -0500, Len Brown wrote:
> Has ACPI worked better on this box using any other releases?
>=20
> Does it work any better if you boot with "acpi_pic_sci=3Dedge"?
>=20
> I'd be interested in seing the complete dmesg -s40000 output
> and the resulting /proc/interrupts.
>=20
> thanks,
> -Len
>=20
> On Mon, 2003-12-08 at 07:24, Ryan Underwood wrote:
> > Hello,
> >=20
> > Shuttle HOT-591P with latest BIOS (591P025) and Cyrix CPU, kernel
> > 2.4.23.  It is a Baby AT board with AT and ATX power.
> >=20
> > Vendor: Award Software International, Inc.
> > Version: 4.51 PG
> > Release Date: 03/27/01
> >=20
> > Manufacturer: Shuttle Inc.
> > Product Name: VIA APOLLO MVP3 (HOT-597)
> > Version: 2A5LEH2B
> > (It is actually a 591P, regardless of the DMI string)
> >=20
> > It seems the ACPI tables are found, but the system does not properly
> > handle the SCI interrupt:
> >=20
> > ACPI: Subsystem revision 20031002
> > PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3D3D1
> > PCI: Using configuration type 1
> >  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acq=
uired
> > Parsing all Control Methods:...........................................=
=2E...........
> > Table [DSDT](id F004) - 227 Objects with 26 Devices 55 Methods 17 Regio=
ns
> > ACPI Namespace successfully loaded at root c02dba3c
> > ACPI: IRQ9 SCI: Level Trigger.  <---- PAUSES HERE
> > evxfevnt-0089: *** Error: Could not transition to ACPI mode.
> >  utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
> > ACPI: Unable to start the ACPI Interpreter
> > evxfevnt-0127 [06] acpi_disable          : System is already in legacy =
(non-ACPI) mode
> >  utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
> > PCI: Probing PCI hardware
> > PCI: ACPI tables contain no PCI IRQ routing entries
> > ...
> >=20
> > At the "ACPI: IRQ9 SCI:" part, it pauses for a few seconds before
> > continuing.
> >=20
> > A similar system with a Tyan ATX board and K6/III 400 works great.
> >=20
> > any ideas?
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20

--=20
Ryan Underwood, <nemesis-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=interrupts
Content-Transfer-Encoding: quoted-printable

$ cat /proc/interrupts=20
           CPU0      =20
  0:      14856          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        542          XT-PIC  eth0
  8:          3          XT-PIC  rtc
 11:          8          XT-PIC  aha1542
 14:       5545          XT-PIC  ide0
 15:         20          XT-PIC  ide1
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=dmesg

$ dmesg -s40000
Linux version 2.4.23 (root-WR7oNGCWftc@public.gmane.org) (gcc version 3.3.3 20031206 (prerelease) (Debian)) #2 Sun Dec 7 22:25:36 CST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
 BIOS-e820: 0000000003ff0000 - 0000000003ff3000 (ACPI NVS)
 BIOS-e820: 0000000003ff3000 - 0000000004000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
63MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 16368
zone(0): 4096 pages.
zone(1): 12272 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 VIAVP3                                    ) @ 0x000f6d30
ACPI: RSDT (v001 VIAVP3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x03ff3000
ACPI: FADT (v001 VIAVP3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x03ff3040
ACPI: DSDT (v001 VIAVP3 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Kernel command line: auto BOOT_IMAGE=Linux ro root=306 acpi_pic_sci=edge
No local APIC present or hardware disabled
Initializing CPU#0
Detected 200.456 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 399.76 BogoMIPS
Memory: 62252k/65472k available (1202k kernel code, 2836k reserved, 511k data, 104k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU:     After generic, caps: 0080a135 00000000 00000000 00000004
CPU:             Common caps: 0080a135 00000000 00000000 00000004
CPU: Cyrix M II 3x Core/Bus Clock stepping 08
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Cyrix ARR
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.......................................................
Table [DSDT](id F004) - 227 Objects with 26 Devices 55 Methods 17 Regions
ACPI Namespace successfully loaded at root c02dba3c
ACPI: IRQ9 SCI: Level set to Edge Trigger.
evxfevnt-0089: *** Error: Could not transition to ACPI mode.
 utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
ACPI: Unable to start the ACPI Interpreter
evxfevnt-0127 [06] acpi_disable          : System is already in legacy (non-ACPI) mode
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST310210A, ATA DISK drive
blk: queue c02f2980, I/O limit 4095Mb (mask 0xffffffff)
hdc: CD-532E-A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: 19925880 sectors (10202 MB) w/2048KiB Cache, CHS=1240/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 104k freed
Adding Swap: 128484k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
SCSI subsystem driver Revision: 1.00
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Configuring Adaptec (SCSI-ID 7) at IO:330, IRQ 11, DMA priority 5
scsi0 : Adaptec 1542
  Vendor: ARCHIVE   Model: Python 27871-XXX  Rev: 1210
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20030406, bufsize 32768, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 0, lun 0
udf: registering filesystem
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
ppdev: user-space parallel port driver
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 27M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
Software Watchdog Timer: 0.05, timer margin: 60 sec
loop: loaded (max 8 devices)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 5 for device 00:0a.0
eth0: RealTek RTL8139 at 0xc48d0000, 00:e0:7d:83:b1:4a, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139B'
hdc: attached ide-cdrom driver.
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
inserting floppy driver for 2.4.23
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Starting AFS cache scan...found 640 non-empty cache files (12%).


--p4qYPpj5QlsIQJ0K--

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1VSpIonHnh+67jkRAgxtAJ9FnEVLsE/9N5XKPg+yuCKZuLgc+gCfeiwr
048dlmV6Ngozcr9AnLL19TE=
=N922
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
