From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: eisa_set_level_irq(acpi_fadt.sci_int)
Date: 24 Oct 2003 03:54:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1066964092.1541.16.camel@darkstar.portugal>
References: <1066254483.2535.51.camel@dhcppc4>
	<20031017154107.GI8668@poupinou.org>  <1066411716.2527.100.camel@dhcppc4>
	<1066796711.2593.30.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aqtd1+Mw9feFWdfJMO9A"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1066796711.2593.30.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-aqtd1+Mw9feFWdfJMO9A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi
Seems that patch has been applied into kernel-2.4.23-pre8 and hangs my
laptop when lid button is pressed.
Here is dmesg file.
where you can see ACPI: IRQ 10 was Edge Triggered, setting to Level
Triggerd
Notes:=20
With pre7 all works fine.
I have APIC disable.
Other buttons like sleep, power have the normal beaver=20
if I can help testing something else tell me.

thanks

On Wed, 2003-10-22 at 05:25, Len Brown wrote:
> Ducrot,
> I've found at least 1 system where hardcoding the PIC SCI to
> Level-Triggered fails, while leaving it as Edge Triggered succeeds.
>=20
> The Intel SE7505VB2 "Vero Beach" when booted with "noapic" leaves IRQ9
> as edge triggered.
>=20
> When we force it to level triggered, we get no ACPI events.
> If we leave it as edge triggered, we do get ACPI events.
>=20
> The other systems in my office leave the PIC SCI in Level Triggered
> mode, so Linux need do nothing to the trigger.
>=20
> Today's patch prints a warning when the mode changes:
>=20
>                 printk(KERN_WARNING PREFIX "IRQ %d was Edge Triggered, "
>                         "setting to Level Triggerd\n", irq);
>=20
> But I'm thinking that by default we should _not_ change the trigger.
> Instead we should do so only upon, say acpi=3Dsci_level_trigger or some
> such.  If there is a popular model that leaves SCI as edge and requires
> level to work, then we can use DMI to set this param for it.
>=20
> thanks,
> -Len
>=20
> On Fri, 2003-10-17 at 13:28, Len Brown wrote:
> > On Fri, 2003-10-17 at 11:41, Ducrot Bruno wrote:
> > > On Wed, Oct 15, 2003 at 05:48:04PM -0400, Len Brown wrote:
> > > > What does eisa_set_level_irq() do for us?
> > > >=20
> > > > As its presence breaks the !CONFIG_PCI build, I deleted it and foun=
d
> > > > that ACPI in PIC mode seems to work just fine without it (at least =
on 2
> > > > of 2 systems tested so far)
> > > >=20
> > >=20
> > > This ensure SCI interrupt is correctly initialized for (poorly) writt=
en
> > > BIOS.  Without it, this break one of my laptop, and certainly others =
as well.
> >=20
> > Do ACPI interrupt work on this latop?  What happens on that system if
> > you delete the call to eisa_set_level_irq()?
> >=20
> > If we blindly program the PIC to be level senstive when the hardware is
> > designed to be edge triggered, then we'll probably get no ACPI events o=
n
> > those systems, as the pulse may not be asserted long enough to provoke
> > an interrupt.
> >=20
> > We used to blindly program the APIC assuming the SCI was ACPI compliant=
,
> > but we got burnt when we discovered that a significant set of system do
> > _not_ have a level-triggered active-low SCI.  Most of those specified
> > their deviation with an SCI-over-ride in the MADT, but some did not:
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D774
> >=20
> > The APIC solution was to
> > 1. don't hard-code level-triggered active-low
> > 2. do whatever the SCI over-ride says
> > 3. if no SCI over-ride, leave the interrupt trigger/polarity as the BIO=
S
> > programmed it.
> >=20
> > thanks,
> > -Len
> >=20
> > ps. this routine is mis-named, it it not EISA specific.  Further, it is
> > mis-located in a PCI-specific file but is not PCI specific.  It should
> > be in an X86 specific interrupt file and be named pic_something.  I'm
> > thinking I'll clone it into our x86 acpi code and add a warning when we
> > find that it actually _changes_ the polarity.

--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.

--=-aqtd1+Mw9feFWdfJMO9A
Content-Disposition: attachment; filename=dmesg23-pre8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg23-pre8; charset=ISO-8859-1

Linux version 2.4.23-pre8 (root-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org) (gcc version 2.96 200007=
31 (Red Hat Linux 7.3 2.96-113)) #2 Fri Oct 24 02:58:53 WEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000def0000 (usable)
 BIOS-e820: 000000000def0000 - 000000000deff000 (ACPI data)
 BIOS-e820: 000000000deff000 - 000000000df00000 (ACPI NVS)
 BIOS-e820: 000000000df00000 - 000000000e000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
224MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 57344
zone(0): 4096 pages.
zone(1): 53248 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6dd0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0defb63b
ACPI: FADT (v001 COMPAQ  EAGLES  0x06040000 PTL_ 0x000f4240) @ 0x0defeeb6
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0defef2a
ACPI: DSDT (v001 COMAPQ   EAGLES 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Vendor "COMAPQ" System "  EAGLES" Revision 0x6040000 has a known ACPI=
 BIOS problem.
ACPI: Reason: SCI issues (C2 disabled). This is a recoverable error
Kernel command line: ro root=3D/dev/hda5
Initializing CPU#0
Detected 996.560 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1985.74 BogoMIPS
Memory: 224164k/229376k available (1411k kernel code, 4756k reserved, 565k =
data, 84k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD mobile AMD Athlon(tm) 4 Processor stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=3D1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control Methods:...............................................=
..............................................................
Table [DSDT](id F005) - 433 Objects with 44 Devices 109 Methods 15 Regions
Parsing all Control Methods:
Table [SSDT](id F003) - 3 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c031545c
ACPI: IRQ 10 was Edge Triggered, setting to Level Triggerd
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul
evgpeblk-0740 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 00=
00000000008020 on int 10
Completing Region/Field/Buffer/Package initialization:.....................=
......................................
Initialized 15/15 Regions 1/1 Fields 20/20 Buffers 23/23 Packages (444 node=
s)
Executing all Device _STA and_INI methods:.....[ACPI Debug] String: -------=
--------------------- AC _STA
..[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
......................................
45 Devices found containing: 45 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
[ACPI Debug] String: ---------------------------- AC _STA
[ACPI Debug] String: ---------------------------- AC _STA
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 80): [55] 3c & 1f -> 1c
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Embedded Controller [EC] (gpe 6)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
[ACPI Debug] String: ---------------------------- AC _PSR
[ACPI Debug] String: ---------------------------- AC _FLPA
[ACPI Debug] String: ---------------------------- AC on line
ACPI: AC Adapter [AC] (on-line)
[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
[ACPI Debug] String: ---------------- NABT < 6=20
[ACPI Debug] String: ---------------- Li Battery=20
[ACPI Debug] String: --------------------- DC >=3D 3000=20
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
acpi_processor-0897 [28] acpi_processor_get_per: Unsupported address space =
[127] (control_register)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
[ACPI Debug] String: ---------------------------- AC _STA
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PPP generic driver version 2.4.2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 177M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xec000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHN2200AT, ATA DISK drive
blk: queue c032d220, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=3D2432/255/63, UDMA(1=
00)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 02:59:04 Oct 24 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF cdfeab00, numif 1
usb.c: new device strings: Mfr=3D0, Product=3D2, SerialNumber=3D1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: 1800
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
usb.c: hub driver claimed interface cdfeab00
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 84k freed
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:07.2-2, assigned address 2
usb.c: kmalloc IF cdfe85c0, numif 2
usb.c: skipping descriptor 0x24
usb.c: skipping descriptor 0x24
usb.c: skipping descriptor 0x24
usb.c: skipped 3 class/vendor specific endpoint descriptors
usb.c: new device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Thomson Consumer Electronics
Product: Thomson TCM305 Cable Modem
SerialNumber: 001095D5AD3F
usb.c: unhandled interfaces on device
usb.c: USB device 2 (vend/prod 0x69b/0x704) is not claimed by any active dr=
iver.
  Length              =3D 18
  DescriptorType      =3D 01
  USB version         =3D 1.10
  Vendor:Product      =3D 069b:0704
  MaxPacketSize0      =3D 32
  NumConfigurations   =3D 1
  Device version      =3D 28.00
  Device Class:SubClass:Protocol =3D 02:00:00
    Communications class
Configuration:
  bLength             =3D    9
  bDescriptorType     =3D   02
  wTotalLength        =3D 0050
  bNumInterfaces      =3D   02
  bConfigurationValue =3D   01
  iConfiguration      =3D   04
  bmAttributes        =3D   c0
  MaxPower            =3D    2mA

  Interface: 0
  Alternate Setting:  0
    bLength             =3D    9
    bDescriptorType     =3D   04
    bInterfaceNumber    =3D   00
    bAlternateSetting   =3D   00
    bNumEndpoints       =3D   01
    bInterface Class:SubClass:Protocol =3D   02:06:00
    iInterface          =3D   05
    Endpoint:
      bLength             =3D    7
      bDescriptorType     =3D   05
      bEndpointAddress    =3D   85 (in)
      bmAttributes        =3D   03 (Interrupt)
      wMaxPacketSize      =3D 0008
      bInterval           =3D   40

  Interface: 1
  Alternate Setting:  0
    bLength             =3D    9
    bDescriptorType     =3D   04
    bInterfaceNumber    =3D   01
    bAlternateSetting   =3D   00
    bNumEndpoints       =3D   00
    bInterface Class:SubClass:Protocol =3D   0a:00:00
    iInterface          =3D   06
  Alternate Setting:  1
    bLength             =3D    9
    bDescriptorType     =3D   04
    bInterfaceNumber    =3D   01
    bAlternateSetting   =3D   01
    bNumEndpoints       =3D   02
    bInterface Class:SubClass:Protocol =3D   0a:00:00
    iInterface          =3D   07
    Endpoint:
      bLength             =3D    7
      bDescriptorType     =3D   05
      bEndpointAddress    =3D   81 (in)
      bmAttributes        =3D   02 (Bulk)
      wMaxPacketSize      =3D 0040
      bInterval           =3D   00
    Endpoint:
      bLength             =3D    7
      bDescriptorType     =3D   05
      bEndpointAddress    =3D   02 (out)
      bmAttributes        =3D   02 (Bulk)
      wMaxPacketSize      =3D 0040
      bInterval           =3D   00
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Adding Swap: 489940k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=3D0x378
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xce83f000, 00:08:02:04:da:f5, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
CDCEther.c: CDCEther.c: 0.98.6 7 Jan 2002 Brad Hards and another
usb.c: registered new driver CDCEther
CDCEther.c: Ethernet information found at device configuration.  Trying to =
use it anyway.
CDCEther.c: Found Header descriptor, CDC version 110.
CDCEther.c: Imperfect filtering support - need sw hashing
CDCEther.c: Can't use SetEthernetMulticastFilters request
CDCEther.c: detected BULK OUT packets of size 64
CDCEther.c: interrupt address: 5
CDCEther.c: interrupt interval: 64
usb.c: ignoring set_interface for dev 2, iface 0, alt 0
CDCEther.c: eth1: Thomson Consumer Electronics Thomson TCM305 Cable Modem 0=
01095D5AD3F
CDCEther.c: eth1: 00:10:95:D5:AD:3F
usb.c: CDCEther driver claimed interface cdfe85d8
usb.c: CDCEther driver claimed interface cdfe85c0
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=3D0x378
lp0: using parport0 (polling).
lp0: console ready
mtrr: no more MTRRs available
CDCEther.c: CDCEther_open failed intr_urb -22
CDCEther.c: eth1: set multicast filters
CDCEther.c: eth1: set multicast filters
CDCEther.c: eth1: set multicast filters
CDCEther.c: eth1: too many MC filters for hardware, using allmulti

--=-aqtd1+Mw9feFWdfJMO9A--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
