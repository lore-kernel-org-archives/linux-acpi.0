From: foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org
Subject: ACPI trouble in SHG 4000 notebook
Date: Thu, 6 Oct 2005 06:51:14 -0500 (CDT)
Message-ID: <62093.84.48.53.145.1128599474.squirrel@84.48.53.145>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20051006065114_48704"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

------=_20051006065114_48704
Content-Type: multipart/alternative;     
 boundary="----=_20051006065114_48704_part_usf7327"
Content-Transfer-Encoding: base64

------=_20051006065114_48704_part_usf7327
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Forgot the dmesg output, here it is.

------=_20051006065114_48704_part_usf7327
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Forgot the dmesg output, here it is.
------=_20051006065114_48704_part_usf7327--

------=_20051006065114_48704
Content-Type: text/plain; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.13-1.1526_FC4 (bhcompile-RC4msc60od4SYS+u8GLjk/XAX3CI6PSWQQ4Iyu8u01E@public.gmane.org) (=
gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 Wed Sep 28 19:15:10 EDT =
2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003bfef000 (usable)
 BIOS-e820: 000000003bff0000 - 000000003bffffc0 (ACPI data)
 BIOS-e820: 000000003bffffc0 - 000000003c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
63MB HIGHMEM available.
896MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 245743
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 16367 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                ) @ 0x000e6010
ACPI: RSDT (v001 INSYDE FACP_000 0x00000100 0000 0x00010200) @ 0x3bffbd31
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 0000 0x00010200) @ 0x3bfffb00
ACPI: MADT (v001 INSYDE APIC_000 0x30303030 0000 0x00010200) @ 0x3bfffb90
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x02002036) @ 0x3bffbd61
ACPI: DSDT (v001 INSYDE    PN800 0x00001000 INTL 0x02002036) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 3c000000 (gap: 3c000000:c3f80000)
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ rhgb quiet
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc04e7000 soft=3Dc04e6000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1393.527 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 968220k/982972k available (3084k kernel code, 13996k reserved, 70=
4k data, 176k init, 65468k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 2789.86 BogoMIPS (lpj=3D=
5579722)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00000000 00000000 00000000 00=
000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00000000 00000000 00000000 000=
00180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f3ff 00000000 00000000 00000040 00000180 =
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0ca0)
checking if image is initramfs... it is
Freeing initrd memory: 1093k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xe9bf4, last bus=3D1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 23) *11
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *5, disabled.
    ACPI-0229: *** Error: Return object type is incorrect [\_SB_.PCI0.ALK=
D._CRS] (Node f7ecdee0), AE_TYPE
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *0
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
 report
pnp: 00:06: ioport range 0x330-0x331 has been reserved
pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:06: ioport range 0x1000-0x107f could not be reserved
pnp: 00:06: ioport range 0x1400-0x140f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-dfff
  MEM window: c0000000-cfffffff
  PREFETCH window: 90000000-9fffffff
PCI: Bus 2, cardbus bridge: 0000:00:09.0
  IO window: 00002000-00002fff
  IO window: 00003000-00003fff
  PREFETCH window: 3c000000-3dffffff
  MEM window: 3e000000-3fffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 7 (level, low) =
-> IRQ 7
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1128358098.532:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 54AD4C348BA3456
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 16 throttling states)
ACPI: Thermal Zone [TZ0] (0 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA PM800/PN800/PM880/PN880 chipset
agpgart: AGP aperture is 128M @ 0xa0000000
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low)=
 -> IRQ 11
PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK8026GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY DVD RW DW-D56A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB), CHS=3D65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 3.38
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:=20
SBTN  LAN AC97 MC97  KBC=20
ACPI: (supports S0 S1 S3 S4 S4bios S5)
Freeing unused kernel memory: 176k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Synaptics Touchpad, model: 1, fw: 5.9, id: 0xf6eb1, caps: 0xa04713/0x0
input: SynPS/2 Synaptics TouchPad on isa0060/serio3
security:  3 users, 6 roles, 872 types, 101 bools
security:  55 classes, 214191 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_cont=
exts
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
floppy0: no floppy controllers found
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, low)=
 -> IRQ 11
eth0: VIA Rhine II at 0xd0000000, 00:40:d0:75:ab:f0, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e=
1.
ieee80211_crypt: registered algorithm 'NULL'
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.0
ipw2200: Copyright(c) 2003-2004 Intel Corporation
PCI: Enabling device 0000:00:06.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:06.0[A]: no GSI
PCI: Setting latency timer of device 0000:00:06.0 to 64
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Error allocating IRQ 0
ipw2200: probe of 0000:00:06.0 failed with error -16
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=3D5 option
         and report if it works on your machine.
         For more details, read ALSA-Configuration.txt.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 5 (level, low) =
-> IRQ 5
PCI: Setting latency timer of device 0000:00:11.5 to 64
NET: Registered protocol family 23
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=3D0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=3D0x5
ACPI: PCI Interrupt 0000:00:11.6[C] -> Link [LNKC] -> GSI 5 (level, low) =
-> IRQ 5
PCI: Setting latency timer of device 0000:00:11.6 to 64
PCI: Enabling device 0000:00:10.3 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 10 (level, low)=
 -> IRQ 10
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 10, io mem 0x40002000
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: over-current change on port 5
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low)=
 -> IRQ 11
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 11, io base 0x00001200
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 7 (level, low) =
-> IRQ 7
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 7, io base 0x00001220
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 5 (level, low) =
-> IRQ 5
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 5, io base 0x00001240
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 7 (level, low) =
-> IRQ 7
Yenta: CardBus bridge found at 0000:00:09.0 [1071:8666]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:09.0, mfunc 0x01001002, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 7
Socket status: 30000006
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0475600(lo)
IPv6 over IPv4 tunneling driver
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Power Button (CM) [PBTN]
ibm_acpi: ec object not found
ACPI: Video Device [VGA0] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
cdrom: open failed.
cdrom: open failed.
EXT3 FS on hda1, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda3, type ext3), uses xattr
Adding 522104k swap on /dev/hda2.  Priority:-1 extents:1
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_cont=
exts
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (7679 buckets, 61432 max) - 248 bytes per conntr=
ack
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: clean.
cs: IO port probe 0xa00-0xaff: clean.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contex=
ts
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
lp: driver loaded but no devices found
eth0: no IPv6 routers present
application mixer_applet2 uses obsolete OSS audio interface
ieee1394: Initialized config rom entry `ip1394'
audit(:0): major=3D252 name_count=3D0: freeing multiple contexts (1)
audit(:0): major=3D113 name_count=3D0: freeing multiple contexts (2)
audit(:0): major=3D252 name_count=3D0: freeing multiple contexts (1)
audit(:0): major=3D113 name_count=3D0: freeing multiple contexts (2)
audit(:0): major=3D252 name_count=3D0: freeing multiple contexts (1)
audit(:0): major=3D113 name_count=3D0: freeing multiple contexts (2)
audit(:0): major=3D252 name_count=3D0: freeing multiple contexts (1)
audit(:0): major=3D113 name_count=3D0: freeing multiple contexts (2)
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.0
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI Interrupt 0000:00:06.0[A]: no GSI
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Error allocating IRQ 0
ipw2200: probe of 0000:00:06.0 failed with error -16
------=_20051006065114_48704--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
