From: George "William McCammon Jr." <will-O9GpscSZcmc9ruZUYCyO/1Nw9kRHFGba@public.gmane.org>
Subject: [Fwd: acpi patch in kernel 2.4.21]
Date: 19 Sep 2003 13:12:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1063991563.3066.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BgT7fTbu7ajGISF+JLjD"
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


--=-BgT7fTbu7ajGISF+JLjD
Content-Type: multipart/mixed; boundary="=-mE/myH1D312IHAuw+Qea"


--=-mE/myH1D312IHAuw+Qea
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

alan asked that i forward the attached email to the acpi-devel list.=20

--=20
George William McCammon Jr. <will-O9GpscSZcmc9ruZUYCyO/1Nw9kRHFGba@public.gmane.org>
McCammon Enterprises

--=-mE/myH1D312IHAuw+Qea
Content-Disposition: inline
Content-Description: Forwarded message - acpi patch in kernel 2.4.21
Content-Type: message/rfc822

Subject: acpi patch in kernel 2.4.21
From: George "William McCammon Jr." <will-O9GpscSZcmc9ruZUYCyO/1Nw9kRHFGba@public.gmane.org>
To: Alan.Cox-Xh+NVF5n0LLYtjvyW6yDsg@public.gmane.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f06upJnXYaTzkafKonV/"
Organization: McCammon Enterprises
Message-Id: <1063891914.3019.5.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Date: 18 Sep 2003 09:31:55 -0400


--=-f06upJnXYaTzkafKonV/
Content-Type: multipart/mixed; boundary="=-9egaQ8AD7lKJlTnmolI2"


--=-9egaQ8AD7lKJlTnmolI2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

alan,

thanks for your work on the linux kernel.  i've been using the 2.4.21-ac
patches for some time on a sharp actius av18 laptop with great success.
in particular, i'm pleased with the acpi implementation. =20

i tested the redhat severn kernel-2.4.21-20.1.2024.2.1.nptl on this
laptop recently and found the acpi fan features missing.  upon booting
the kernel the fan stopped and the cpu temperature sensor began to
"whistle" on the motherboard.  considering that the upcoming redhat
release will be using acpid instead of apmd for power management, i'm
concerned that other redhat customers may experience the same problem.
please forward my concern to the appropriate developers at redhat and
request that they consider your acpi patch as a possible solution. for
reference, i've attached dmesg output from the kernel-2.4.21 with your
patches applied.

will.


--=20
George William McCammon Jr. <will-O9GpscSZcmc9ruZUYCyO/1Nw9kRHFGba@public.gmane.org>
McCammon Enterprises

--=-9egaQ8AD7lKJlTnmolI2
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=ISO-8859-1

Linux version 2.4.21-ac4 (root@mary) (gcc version 3.2.2 20030222 (Red Hat L=
inux 3.2.2-5)) #2 Thu Sep 18 08:00:03 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002def0000 (usable)
 BIOS-e820: 000000002def0000 - 000000002defc000 (ACPI data)
 BIOS-e820: 000000002defc000 - 000000002df00000 (ACPI NVS)
 BIOS-e820: 000000002df00000 - 000000002e000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
734MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 188144
zone(0): 4096 pages.
zone(1): 184048 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f8080
ACPI: RSDT (v001 PTLTD  RSDT     01540.00000) @ 0x2def7e2f
ACPI: FADT (v001 PTLTD  RSDT     01540.00000) @ 0x2defbe2b
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x2defbe9f
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x2defbec7
ACPI: DSDT (v001 PTLTD  DSDT     01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Kernel command line: ro root=3D/dev/hda2 hdc=3Dide-scsi resume=3D/dev/hda3
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 1393.213 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2778.72 BogoMIPS
Memory: 740572k/752576k available (1515k kernel code, 11616k reserved, 585k=
 data, 136k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 1800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030522
PCI: PCI BIOS revision 2.10 entry at 0xfd93e, last bus=3D1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control Methods:...............................................=
...........................................................................=
............................................................
Table [DSDT](id F005) - 458 Objects with 49 Devices 182 Methods 17 Regions
Parsing all Control Methods:
Table [SSDT](id F003) - 3 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c0342c1c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul
evgpeblk-0743 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 00=
00000000004020 on int 9
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L01 as GP=
E number 0x01
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L05 as GP=
E number 0x05
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L08 as GP=
E number 0x08
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0B as GP=
E number 0x0B
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0C as GP=
E number 0x0C
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0D as GP=
E number 0x0D
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0E as GP=
E number 0x0E
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0F as GP=
E number 0x0F
Completing Region/Field/Buffer/Package initialization:.....................=
.................................................
Initialized 17/17 Regions 0/0 Fields 15/15 Buffers 38/38 Packages (469 node=
s)
Executing all Device _STA and_INI methods:.................................=
.................
50 Devices found containing: 50 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23, disabled)
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23, disabled)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
ACPI: PCI Interrupt Link [ALKD] (IRQs 21, disabled)
ACPI: PCI Interrupt Link [LNKA] (IRQs 10, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9, disabled)
ACPI: Power Resource [PFNH] (off)
ACPI: Power Resource [PFNM] (off)
ACPI: Power Resource [PFNL] (off)
PCI: Probing PCI hardware
pci_link-0345 [20] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
pci_link-0345 [20] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
pci_link-0345 [20] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
pci_link-0345 [20] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
PCI: Via IRQ fixup for 00:11.6, from 255 to 11
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FANH] (off)
ACPI: Fan [FANM] (off)
ACPI: Fan [FANL] (off)
acpi_processor-0899 [27] acpi_processor_get_per: Unsupported address space =
[127] (control_register)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (67 C)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IR=
Q SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
floppy0: no floppy controllers found
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-40, ATA DISK drive
blk: queue c036b760, I/O limit 4095Mb (mask 0xffffffff)
hdc: UJDA750 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 78140160 sectors (40008 MB) w/2048KiB Cache, CHS=3D4864/255/63, UDMA(1=
00)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 181k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 04b8, PCI irq9
Socket status: 30000410
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 00:10.3 (0010 -> 0012)
ehci_hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 00:10.3: irq 9, pci mem ee86dc00
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.3 PCI cache line size corrected to 64.
ehci_hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-12/2.4
hub.c: USB hub found
hub.c: 4 ports detected
usb-uhci.c: $Revision: 1.275 $ time 07:25:48 Sep 18 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0x1040, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 457844k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 896 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[11]  MMIO=3D[e8000000-e80007ff]  Ma=
x Packet=3D[2048]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA750 DVD/CDRW  Rev: 1.50
  Type:   CD-ROM                             ANSI SCSI revision: 02
ieee1394: Host added: Node[00:1023]  GUID[08001f0100328fde]  [Linux OHCI-13=
94]

--=-9egaQ8AD7lKJlTnmolI2--

--=-f06upJnXYaTzkafKonV/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/abPKcAB1V2Fwc8QRAo/sAJoCJqiwbabfC87dwxofOwz+CWt2rwCgkXMq
fRHPIhG5w3qFQ+Z4uXVcXsM=
=SlmY
-----END PGP SIGNATURE-----

--=-f06upJnXYaTzkafKonV/--

--=-mE/myH1D312IHAuw+Qea--

--=-BgT7fTbu7ajGISF+JLjD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/azkLcAB1V2Fwc8QRAsT2AKCJBJ2iqhD7/10MNVER5o+f4eSdowCglh70
hgIi06LJ2n9na3u2bMY75bs=
=EtgX
-----END PGP SIGNATURE-----

--=-BgT7fTbu7ajGISF+JLjD--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
