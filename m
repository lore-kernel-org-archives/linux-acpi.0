From: Andre Masella <andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>
Subject: Re: Vaio PGC-FXA47 Troubles
Date: Wed, 21 Aug 2002 12:58:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208211258.05198.andre@masella.dynodns.net>
References: <200208182302.01068.andre@masella.dynodns.net> <200208191052.55710.jbr.1@gmx.net>
Reply-To: andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208191052.55710.jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On August 19, 2002 04:52 am, Jochen Reinwand wrote:
> 2.4.19 is no good idea for a notebook that requires ACPI! The ACPI part=
 of
> the kernel is totally out of date. There are a lot of bug fixes in the
> newer patches, that I really need to get my Vaio running at all.
> There's currently no patch against 2.4.19. The current release will be =
put
> into 2.4.20. At the moment the best is to use a 2.4.18 and fetch the ne=
west
> patch from http://sourceforge.net/projects/acpi/.
>
> Most likely you will NOT get a working suspend with that combination. T=
here
> are a lot of problems with suspend. The major work is currently done in
> 2.5. But you will be able to use more features of ACPI with the patch. =
E.g.
> I can throttle my CPU via /proc/acpi/processor/CPU0/throttling. It's a =
lot
> of fun having a 1GHz notebook running at the speed of an old 386 ;-)
>
> regards
> Jochen
>
> > I just got a Vaio FXA47 notebook and am having two seperate problems.=
 I
> > am running Gentoo with a Linux 2.4.19 kernel (from kernel.org -- not
> > patched) and acpid 1.0.1
> > The first is I cannot suspend the system. The /proc/acpi/sleep file
> > contains "S0 S3 S4 S5" but using 0, 4, or 5 powers off the system. 3
> > seems to suspend it, but then it cannot be resumed. Is there a workin=
g
> > suspend? The /proc/acpi/battery/ directory is empty. There is a batte=
ry
> > in the system, but it doesn't show up in that directory. What's wrong=
?


I am still having problems. I got Linux 2.4.18. I applied the latest acpi=
=20
patch. There are now many problems. First, the swsusp won't apply on top =
of=20
the acpi patch. I have tried to compile the kernel but the ACPI does not=20
work. There are a number of AE_NO_MEMORY errors and the /proc/acpi direct=
ory=20
is never created. I though it was gcc-3.1, so I downgraded to gcc-2.96.3,=
 but=20
that made no difference. Here is the dmesg output:

 Linux version 2.4.18 (root-8G9VKVXhOGCR/P4XRbzFoNRsSGLKypYs8uQkFQZpldM@public.gmane.org) (gcc version 2.9=
5.3=20
20010315 (release)) #5 Wed Aug 21 14:49:05 _TIMEZONE_ 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7710
ACPI: RSDT (v001 SONY   K5       01540.00000) @ 0x0fef9a51
ACPI: FADT (v001 SONY   K5       01540.00000) @ 0x0fefee4c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fefeec0
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0fefeee8
Kernel command line: ro vga=3D0x318 root=3D/dev/hda1 mem=3D262144K
Initializing CPU#0
Detected 1000.060 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 255404k/262144k available (1367k kernel code, 6352k reserved, 402=
k=20
data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor =3D 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
ACPI: Subsystem revision 20020725
PCI: PCI BIOS revision 2.10 entry at 0xfd7cd, last bus=3D1
PCI: Using configuration type 1
   tbget-0133: *** Error: Could not map memory at 0fef9a51 for length 0
  tbrsdt-0257 [04] Tb_get_table_rsdt     : Could not get the RSDT/XSDT,=20
AE_NO_MEMORY
 tbxface-0086: *** Error: Acpi_load_tables: Could not load RSDT: AE_NO_ME=
MORY
 tbxface-0116: *** Error: Acpi_load_tables: Could not load tables:=20
AE_NO_MEMORY
ACPI: Unable to load the System Description Tables
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue: [55] 8d->0d
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Sony Vaio laptop detected.
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
vesafb: framebuffer at 0xe9000000, mapped to 0xd0800000, size 8128k
vesafb: mode is 1024x768x24, linelength=3D3072, pages=3D2
vesafb: protected mode interface info at c000:50ae
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:8:8:8, shift=3D0:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL=
_PCI=20
ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
block: 128 slots per queue, batch=3D32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
hdc: UJDA720 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB), CHS=3D2432/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 10 for device 00:10.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:0a.1
eth0: RealTek RTL8139 Fast Ethernet at 0xd0ff3800, 08:00:46:58:a8:0b, IRQ=
 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 128M @ 0xf0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 220k freed
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Assigned IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:07.3
PCI: Sharing IRQ 9 with 00:0e.0
PCI: Setting latency timer of device 00:07.2 to 64
uhci.c: USB UHCI at I/O 0x1c00, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:07.3
PCI: Sharing IRQ 9 with 00:07.2
PCI: Sharing IRQ 9 with 00:0e.0
PCI: Setting latency timer of device 00:07.3 to 64
uhci.c: USB UHCI at I/O 0x1c20, IRQ 9
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
ohci1394: $Revision: 1.80 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
PCI: Found IRQ 9 for device 00:0e.0
PCI: Sharing IRQ 9 with 00:07.2
PCI: Sharing IRQ 9 with 00:07.3
PCI: Setting latency timer of device 00:0e.0 to 64
ohci1394_0: Remapped memory spaces reg 0xd104c000
ohci1394_0: Soft reset finished
ohci1394_0: GUID: 08004603:011291b5
ohci1394_0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394_0: 4 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: Receive DMA ctx=3D0 initialized
ohci1394_0: Receive DMA ctx=3D1 initialized
ohci1394_0: Transmit DMA ctx=3D0 initialized
ohci1394_0: Transmit DMA ctx=3D1 initialized
ohci1394_0: Receive DMA ctx=3D2 initialized
ohci1394_0: Transmit DMA ctx=3D2 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[9]  MMIO=3D[e8004000-e8004800]  M=
ax=20
Packet=3D[2048]
ohci1394_0: request csr_rom address: c21d6000
ohci1394_0: devctl: Bus reset requested
ohci1394_0: IntEvent: 00020010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=3D0x00008409
ohci1394_0: IntEvent: 00010000
ohci1394_0: SelfID interrupt received (phyid 0, root)
ohci1394_0: SelfID packet 0x807f8842 received
ieee1394: Including SelfID 0x42887f80
ohci1394_0: SelfID for this node is 0x807f8842
ohci1394_0: SelfID complete
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=3D0 ... discarded
SCSI subsystem driver Revision: 1.00
eth0: Setting 100mbps half-duplex based on auto-negotiated partner abilit=
y=20
44a1.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
PCI: Found IRQ 10 for device 00:0a.1
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:10.0
Yenta IRQ list 0808, PCI irq9
Socket status: 30000006
Yenta IRQ list 0808, PCI irq10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x378-0x37f 0x388-=
0x38f=20
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
eth0: no IPv6 routers present
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 0, lun 1
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 0, lun 2
Attached scsi CD-ROM sr3 at scsi0, channel 0, id 0, lun 3
Attached scsi CD-ROM sr4 at scsi0, channel 0, id 0, lun 4
Attached scsi CD-ROM sr5 at scsi0, channel 0, id 0, lun 5
Attached scsi CD-ROM sr6 at scsi0, channel 0, id 0, lun 6
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr4: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr5: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr6: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray

What could be wrong?
--=20
--Andre Masella (andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org)
I don't suffer from insanity. I enjoy every minute of it.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
