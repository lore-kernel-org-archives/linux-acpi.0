From: "ajh" <ajhindle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RC440BX won't poweroff/shutdown
Date: Tue, 14 Jun 2005 22:36:00 +1000
Message-ID: <BAY102-DAV9CEC620D6D3A1287B5FF5C6F30@phx.gbl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3003816356@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C57131.7073CA60"
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C57131.7073CA60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

OK Thanks for those suggestions - I loaded FC2 (2.6.5-1) and now =
"shutdown now -h" works how I want it to. I'd still like to get it =
working with later Fedoras though.

I will install the latest kernel with FC3 later and let you know how it =
goes.

Here is the dmesg for the working FC2. Further below is the full dmesg =
for FC3.

Linux version 2.6.5-1.358 (bhcompile-9I5xX63LOQpmnsfvQs7cu9vLeJWuRmrY@public.gmane.org) (gcc version =
3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat May 8 09:04:50 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013fe0000 (usable)
 BIOS-e820: 0000000013fe0000 - 0000000013ff8000 (ACPI data)
 BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
319MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 81888
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77792 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: RSDP (v000 AMI                                       ) @ =
0x000fa7a0
ACPI: RSDT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff0000
ACPI: FADT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff1000
ACPI: DSDT (v001 INTEL  RC440BXA 0x00001000 MSFT 0x0100000a) @ =
0x00000000
ACPI: PM-Timer IO Port: 0x408
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ acpi=3Dforce=20
mapped 4G/4G trampoline to ffff3000.
Initializing CPU#0
CPU 0 irqstacks, hard=3D02345000 soft=3D02344000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 398.245 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 321316k/327552k available (1540k kernel code, 5460k reserved, =
599k data, 144k init, 0k highmem)
Calibrating delay loop... 788.48 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security =
failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 =
00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 =
00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0183f3ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
    ACPI-0179: *** Warning: The ACPI AML in your computer contains =
errors, please nag the manufacturer to correct it.
    ACPI-0182: *** Warning: Allowing relaxed access to fields; turn on =
CONFIG_ACPI_DEBUG for details.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even =
'acpi=3Doff'
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1118782415.748:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 64M @ 0xf4000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL EX6.4A, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/418KiB Cache, CHS=3D13328/15/63, =
UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S5)
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd
Freeing initrd memory: 186k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 144k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0000ef80
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
EXT3 FS on hda3, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
cdrom: open failed.
Adding 666656k swap on /dev/hda6.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.13 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
microcode: CPU0 updated from revision 0x4 to 0xa, date =3D 05051999=20
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
SCSI subsystem initialized
inserting floppy driver for 2.6.5-1.358
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0xfbdff000, irq 10, MAC addr =
00:04:AC:53:A2:78
8139too Fast Ethernet driver 0.9.27
divert: allocating divert_blk for eth1
eth1: RealTek RTL8139 at 0xe800, 00:48:54:1d:b0:f9, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
divert: freeing divert_blk for eth0
divert: freeing divert_blk for eth1
ip_tables: (C) 2000-2002 Netfilter core team
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0xfbdff000, irq 10, MAC addr =
00:04:AC:53:A2:78
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.27
divert: allocating divert_blk for eth1
eth1: RealTek RTL8139 at 0xe800, 00:48:54:1d:b0:f9, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
NET: Registered protocol family 10
Disabled Privacy Extensions on device 022db720(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
udf: registering filesystem
UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, =
vol_desc_start=3D0
UDF-fs DEBUG fs/udf/super.c:1552:udf_fill_super: Multi-session=3D0
UDF-fs DEBUG fs/udf/super.c:540:udf_vrs: Starting at sector 16 (2048 =
byte sectors)
UDF-fs DEBUG fs/udf/super.c:567:udf_vrs: ISO9660 Primary Volume =
Descriptor found
UDF-fs DEBUG fs/udf/super.c:570:udf_vrs: ISO9660 Supplementary Volume =
Descriptor found
UDF-fs DEBUG fs/udf/super.c:576:udf_vrs: ISO9660 Volume Descriptor Set =
Terminator found
UDF-fs: No VRS found
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root



*** Here is FC3 dmesg ****


Linux version 2.6.9-1.667 (bhcompile-FkyZWkai+dgaZRsM4JBhTKfLeoKvNuZc@public.gmane.org) (gcc =
version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Tue Nov 2 14:41:25 EST =
2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013fe0000 (usable)
 BIOS-e820: 0000000013fe0000 - 0000000013ff8000 (ACPI data)
 BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
319MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 81888
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77792 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa7a0
ACPI: RSDT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff0000
ACPI: FADT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff1000
ACPI: DSDT (v001 INTEL  RC440BXA 0x00001000 MSFT 0x0100000a) @ =
0x00000000
ACPI: BIOS age (1999) fails cutoff (2001), acpi=3Dforce is required to =
enable ACPI
ACPI: acpi=3Dforce override
ACPI: PM-Timer IO Port: 0x408
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ acpi=3Dforce
mapped 4G/4G trampoline to ffff4000.
Initializing CPU#0
CPU 0 irqstacks, hard=3D023d5000 soft=3D023d4000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 398.409 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 320328k/327552k available (2068k kernel code, 6636k reserved, =
647k data, 144k init, 0k highmem)
Calibrating delay loop... 784.38 BogoMIPS (lpj=3D392192)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security =
failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps:        0183f3ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
checking if image is initramfs... it is
Freeing initrd memory: 388k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, =
disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1118342222.015:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 6ECDA687281A73E5
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 64M @ 0xf4000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: QUANTUM FIREBALL EX6.4A, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/418KiB Cache, CHS=3D13328/15/63, =
UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S5)
ACPI wakeup devices:=20
PCI0 PS2K UAR1  USB SLT1 SLT2 SLT3 SLPB=20
Freeing unused kernel memory: 144k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 4 roles, 280 types, 16 bools
security:  53 classes, 5494 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses =
genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for =
labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for =
labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses =
genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
inserting floppy driver for 2.6.9-1.667
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
divert: allocating divert_blk for eth0
e100: eth0: e100_probe: addr 0xfbdff000, irq 10, MAC addr =
00:04:AC:53:A2:78
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth1
eth1: RealTek RTL8139 at 0xe800, 00:48:54:1d:b0:f9, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0000ef80
SELinux: initialized (dev usbdevfs, type usbdevfs), uses genfs_contexts
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
EXT3 FS on hda2, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda7, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda3, type ext3), uses xattr
SELinux: initialized (dev hda5, type vfat), uses genfs_contexts
Adding 610428k swap on /dev/hda6.  Priority:-1 extents:1
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses =
genfs_contexts
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ip_tables: (C) 2000-2002 Netfilter core team
eth1: link down
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses =
genfs_contexts
i2c /dev entries driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device 02369a00(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
ip_tables: (C) 2000-2002 Netfilter core team
eth0: no IPv6 routers present

  ----- Original Message -----=20
  From: Brown, Len=20
  To: ajh ; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
  Sent: Tuesday, June 14, 2005 4:58 AM
  Subject: RE: [ACPI] RC440BX won't poweroff/shutdown


  The reset may actually be a crash.

  Does this happen only with FC3, or does it also happen with
  the latest kernel.org kernel?  If yes, what is the latest kernel
  where it did NOT happen?

  It would be interesting if you find some boot parameters that make the =
symptom
  go away, that may be a hint.  maxcpus=3D1, and "nolapic" come to mind.

  You can put an infinite loop in the powerdown code
  to see if you can change the reset into a hang --
  then move the loop later and later until you find
  where the access that causes the reset.
  Start with acpi_power_off() in drivers/acpi/sleep/poweroff.c

  cheers,
  -Len

  ps. please always include complete dmesg, not just grepped version.



-------------------------------------------------------------------------=
---
    From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of ajh
    Sent: Monday, June 13, 2005 5:04 AM
    To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
    Subject: [ACPI] RC440BX won't poweroff/shutdown


    Hi

    I have installed FC3 on a PC bought in 1999. It has an Intel RC440BX =
chipset. When I use the commands "shutdown now -h" or "poweroff", the PC =
reboots rather than shutting down. I am forcing ACPI use because it is a =
pre 2001 chipset - see dmesg below.=20

    I see that the Seattle 440BX chipset is on the ACPI4Linux =
"blacklist" but my machine (which is probably similar) doesn't show any =
error messages when closing or booting - it just reboots when asked to =
shutdown. I hope someone can help. Cheers

    "dmesg | grep ACPI" shows this:


     BIOS-e820: 0000000013fe0000 - 0000000013ff8000 (ACPI data)
     BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
    ACPI: RSDP (v000 AMI                                   ) @ =
0x000fa7a0
    ACPI: RSDT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff0000
    ACPI: FADT (v001 INTEL  RC440BXA 0x19990305 AMI  0x00000097) @ =
0x13ff1000
    ACPI: DSDT (v001 INTEL  RC440BXA 0x00001000 MSFT 0x0100000a) @ =
0x00000000
    ACPI: BIOS age (1999) fails cutoff (2001), acpi=3Dforce is required =
to enable ACPI
    ACPI: acpi=3Dforce override
    ACPI: PM-Timer IO Port: 0x408
    ACPI: IRQ9 SCI: Level Trigger.
    ACPI: Subsystem revision 20040816
    ACPI: Interpreter enabled
    ACPI: Using PIC for interrupt routing
    ACPI: PCI Root Bridge [PCI0] (00:00)
    ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    ACPI: Power Resource [URP1] (off)
    ACPI: Power Resource [URP2] (off)
    ACPI: Power Resource [FDDP] (off)
    ACPI: Power Resource [LPTP] (off)
    ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
    ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
    ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) =
*0, disabled.
    ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
    ACPI: Power Resource [GFAN] (off)
    PCI: Using ACPI for IRQ routing
    ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
    ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
    ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
    ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
    ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
    ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
    ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
    ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
    apm: overridden by ACPI.
    ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
    ACPI: (supports S0 S1 S5)
    ACPI wakeup devices:=20
    ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
    ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
    ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
    ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
    ACPI: Power Button (FF) [PWRF]
    ACPI: Sleep Button (CM) [SLPB]
------=_NextPart_000_000A_01C57131.7073CA60
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DArial size=3D2>OK Thanks for those suggestions - I =
loaded FC2=20
(2.6.5-1) and now "shutdown now -h" works how I want it to.&nbsp;I'd =
still like=20
to get it working with later Fedoras though.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I will install the latest kernel with =
FC3 later and=20
let you know how it goes.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Here is the dmesg for the working FC2. =
Further=20
below is the full dmesg for FC3.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Linux version 2.6.5-1.358 (<A=20
href=3D"mailto:bhcompile-9I5xX63LOQpmnsfvQs7cu9vLeJWuRmrY@public.gmane.org">bhcompile-9I5xX63LOQpwb8zX++3IYA@public.gmane.org=
at.com</A>)=20
(gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat May 8 =
09:04:50 EDT=20
2004<BR>BIOS-provided physical RAM map:<BR>&nbsp;BIOS-e820: =
0000000000000000 -=20
000000000009fc00 (usable)<BR>&nbsp;BIOS-e820: 000000000009fc00 -=20
00000000000a0000 (reserved)<BR>&nbsp;BIOS-e820: 00000000000e0000 -=20
0000000000100000 (reserved)<BR>&nbsp;BIOS-e820: 0000000000100000 -=20
0000000013fe0000 (usable)<BR>&nbsp;BIOS-e820: 0000000013fe0000 -=20
0000000013ff8000 (ACPI data)<BR>&nbsp;BIOS-e820: 0000000013ff8000 -=20
0000000014000000 (ACPI NVS)<BR>&nbsp;BIOS-e820: 00000000fec00000 -=20
00000000fec01000 (reserved)<BR>&nbsp;BIOS-e820: 00000000fee00000 -=20
00000000fee01000 (reserved)<BR>&nbsp;BIOS-e820: 00000000fff80000 -=20
0000000100000000 (reserved)<BR>0MB HIGHMEM available.<BR>319MB LOWMEM=20
available.<BR>zapping low mappings.<BR>On node 0 totalpages: =
81888<BR>&nbsp; DMA=20
zone: 4096 pages, LIFO batch:1<BR>&nbsp; Normal zone: 77792 pages, LIFO=20
batch:16<BR>&nbsp; HighMem zone: 0 pages, LIFO batch:1<BR>DMI 2.1=20
present.<BR>ACPI: RSDP (v000=20
AMI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
) @ 0x000fa7a0<BR>ACPI: RSDT (v001 INTEL&nbsp; RC440BXA 0x19990305 =
AMI&nbsp;=20
0x00000097) @ 0x13ff0000<BR>ACPI: FADT (v001 INTEL&nbsp; RC440BXA =
0x19990305=20
AMI&nbsp; 0x00000097) @ 0x13ff1000<BR>ACPI: DSDT (v001 INTEL&nbsp; =
RC440BXA=20
0x00001000 MSFT 0x0100000a) @ 0x00000000<BR>ACPI: PM-Timer IO Port:=20
0x408<BR>Built 1 zonelists<BR>Kernel command line: ro root=3DLABEL=3D/ =
acpi=3Dforce=20
<BR>mapped 4G/4G trampoline to ffff3000.<BR>Initializing CPU#0<BR>CPU 0=20
irqstacks, hard=3D02345000 soft=3D02344000<BR>PID hash table entries: =
2048 (order=20
11: 16384 bytes)<BR>Detected 398.245 MHz processor.<BR>Using pmtmr for =
high-res=20
timesource<BR>Console: colour VGA+ 80x25<BR>Memory: 321316k/327552k =
available=20
(1540k kernel code, 5460k reserved, 599k data, 144k init, 0k=20
highmem)<BR>Calibrating delay loop... 788.48 BogoMIPS<BR>Security =
Scaffold=20
v1.0.0 initialized<BR>SELinux:&nbsp; Initializing.<BR>SELinux:&nbsp; =
Starting in=20
permissive mode<BR>There is already a security framework initialized,=20
register_security failed.<BR>Failure registering capabilities with the=20
kernel<BR>selinux_register_security:&nbsp; Registering secondary module=20
capability<BR>Capability LSM initialized<BR>Dentry cache hash table =
entries:=20
32768 (order: 5, 131072 bytes)<BR>Inode-cache hash table entries: 32768 =
(order:=20
5, 131072 bytes)<BR>Mount-cache hash table entries: 512 (order: 0, 4096=20
bytes)<BR>CPU:&nbsp;&nbsp;&nbsp;&nbsp; After generic identify, caps: =
0183fbff=20
00000000 00000000 00000000<BR>CPU:&nbsp;&nbsp;&nbsp;&nbsp; After vendor=20
identify, caps: 0183fbff 00000000 00000000 00000000<BR>CPU: L1 I cache: =
16K, L1=20
D cache: 16K<BR>CPU: L2 cache: 128K<BR>CPU:&nbsp;&nbsp;&nbsp;&nbsp; =
After all=20
inits, caps: 0183f3ff 00000000 00000000 00000040<BR>Intel machine check=20
architecture supported.<BR>Intel machine check reporting enabled on=20
CPU#0.<BR>CPU: Intel Celeron (Mendocino) stepping 00<BR>Enabling fast =
FPU save=20
and restore... done.<BR>Checking 'hlt' instruction... OK.<BR>POSIX =
conformance=20
testing by UNIFIX<BR>NET: Registered protocol family 16<BR>PCI: PCI BIOS =

revision 2.10 entry at 0xfdb91, last bus=3D1<BR>PCI: Using configuration =
type=20
1<BR>mtrr: v2.0 (20020519)<BR>ACPI: Subsystem revision 20040326<BR>ACPI: =
IRQ9=20
SCI: Level Trigger.<BR>&nbsp;&nbsp;&nbsp; ACPI-0179: *** Warning: The =
ACPI AML=20
in your computer contains errors, please nag the manufacturer to correct =

it.<BR>&nbsp;&nbsp;&nbsp; ACPI-0182: *** Warning: Allowing relaxed =
access to=20
fields; turn on CONFIG_ACPI_DEBUG for details.<BR>ACPI: Interpreter=20
enabled<BR>ACPI: Using PIC for interrupt routing<BR>ACPI: PCI Root =
Bridge [PCI0]=20
(00:00)<BR>PCI: Probing PCI hardware (bus 00)<BR>ACPI: PCI Interrupt =
Routing=20
Table [\_SB_.PCI0._PRT]<BR>ACPI: Power Resource [URP1] (off)<BR>ACPI: =
Power=20
Resource [URP2] (off)<BR>ACPI: Power Resource [FDDP] (off)<BR>ACPI: =
Power=20
Resource [LPTP] (off)<BR>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 =
9 10=20
*11 12 14 15)<BR>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 =
11 12 14=20
15)<BR>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14=20
15)<BR>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14=20
15)<BR>ACPI: Power Resource [GFAN] (off)<BR>Linux Plug and Play Support =
v0.97=20
(c) Adam Belay<BR>usbcore: registered new driver usbfs<BR>usbcore: =
registered=20
new driver hub<BR>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ =
10<BR>ACPI: PCI=20
Interrupt Link [LNKB] enabled at IRQ 9<BR>ACPI: PCI Interrupt Link =
[LNKA]=20
enabled at IRQ 11<BR>PCI: Using ACPI for IRQ routing<BR>PCI: if you =
experience=20
problems, try using option 'pci=3Dnoacpi' or even 'acpi=3Doff'<BR>apm: =
BIOS version=20
1.2 Flags 0x03 (Driver version 1.16ac)<BR>apm: overridden by =
ACPI.<BR>audit:=20
initializing netlink socket (disabled)<BR>audit(1118782415.748:0):=20
initialized<BR>Total HugeTLB memory allocated, 0<BR>VFS: Disk quotas=20
dquot_6.5.1<BR>Dquot-cache hash table entries: 1024 (order 0, 4096=20
bytes)<BR>SELinux:&nbsp; Registering netfilter hooks<BR>Initializing=20
Cryptographic API<BR>Limiting direct PCI/PCI transfers.<BR>pci_hotplug: =
PCI Hot=20
Plug PCI Core version: 0.5<BR>ACPI: Processor [CPU1] (supports C1 C2, 8=20
throttling states)<BR>isapnp: Scanning for PnP cards...<BR>isapnp: No =
Plug &amp;=20
Play device found<BR>Real Time Clock Driver v1.12<BR>Linux agpgart =
interface=20
v0.100 (c) Dave Jones<BR>agpgart: Detected an Intel 440BX =
Chipset.<BR>agpgart:=20
Maximum main memory to use for agp memory: 262M<BR>agpgart: AGP aperture =
is 64M=20
@ 0xf4000000<BR>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ =
sharing=20
enabled<BR>ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A<BR>RAMDISK driver=20
initialized: 16 RAM disks of 16384K size 1024 blocksize<BR>divert: not=20
allocating divert_blk for non-ethernet device lo<BR>Uniform =
Multi-Platform E-IDE=20
driver Revision: 7.00alpha2<BR>ide: Assuming 33MHz system bus speed for =
PIO=20
modes; override with idebus=3Dxx<BR>PIIX4: IDE controller at PCI slot=20
0000:00:07.1<BR>PIIX4: chipset revision 1<BR>PIIX4: not 100% native =
mode: will=20
probe irqs later<BR>&nbsp;&nbsp;&nbsp; ide0: BM-DMA at 0xffa0-0xffa7, =
BIOS=20
settings: hda:pio, hdb:pio<BR>&nbsp;&nbsp;&nbsp; ide1: BM-DMA at =
0xffa8-0xffaf,=20
BIOS settings: hdc:DMA, hdd:pio<BR>hda: QUANTUM FIREBALL EX6.4A, ATA =
DISK=20
drive<BR>Using cfq io scheduler<BR>ide0 at 0x1f0-0x1f7,0x3f6 on irq =
14<BR>hdc:=20
TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive<BR>ide1 at =
0x170-0x177,0x376 on=20
irq 15<BR>hda: max request size: 128KiB<BR>hda: 12594960 sectors (6448 =
MB)=20
w/418KiB Cache, CHS=3D13328/15/63, UDMA(33)<BR>&nbsp;hda: hda1 hda2 hda3 =
hda4 &lt;=20
hda5 hda6 hda7 &gt;<BR>hdc: ATAPI 32X DVD-ROM drive, 256kB Cache,=20
UDMA(33)<BR>Uniform CD-ROM driver Revision: 3.20<BR>ide-floppy driver=20
0.99.newide<BR>usbcore: registered new driver hiddev<BR>usbcore: =
registered new=20
driver hid<BR>drivers/usb/input/hid-core.c: v2.0:USB HID core =
driver<BR>mice:=20
PS/2 mouse device common for all mice<BR>serio: i8042 AUX port at =
0x60,0x64 irq=20
12<BR>input: ImPS/2 Generic Wheel Mouse on isa0060/serio1<BR>serio: =
i8042 KBD=20
port at 0x60,0x64 irq 1<BR>input: AT Translated Set 2 keyboard on=20
isa0060/serio0<BR>md: md driver 0.90.0 MAX_MD_DEVS=3D256, =
MD_SB_DISKS=3D27<BR>NET:=20
Registered protocol family 2<BR>IP: routing cache hash table of 2048 =
buckets,=20
16Kbytes<BR>TCP: Hash tables configured (established 32768 bind=20
65536)<BR>Initializing IPsec netlink socket<BR>NET: Registered protocol =
family=20
1<BR>NET: Registered protocol family 17<BR>ACPI: (supports S0 S1 =
S5)<BR>checking=20
if image is initramfs...it isn't (no cpio magic); looks like an=20
initrd<BR>Freeing initrd memory: 186k freed<BR>md: Autodetecting RAID=20
arrays.<BR>md: autorun ...<BR>md: ... autorun DONE.<BR>RAMDISK: =
Compressed image=20
found at block 0<BR>VFS: Mounted root (ext2 filesystem).<BR>kjournald=20
starting.&nbsp; Commit interval 5 seconds<BR>EXT3-fs: mounted filesystem =
with=20
ordered data mode.<BR>Freeing unused kernel memory: 144k =
freed<BR>SELinux:&nbsp;=20
Disabled at runtime.<BR>SELinux:&nbsp; Unregistering netfilter =
hooks<BR>ACPI:=20
Power Button (FF) [PWRF]<BR>ACPI: Sleep Button (CM) [SLPB]<BR>USB =
Universal Host=20
Controller Interface driver v2.2<BR>uhci_hcd 0000:00:07.2: UHCI Host=20
Controller<BR>uhci_hcd 0000:00:07.2: irq 10, io base =
0000ef80<BR>uhci_hcd=20
0000:00:07.2: new USB bus registered, assigned bus number 1<BR>hub =
1-0:1.0: USB=20
hub found<BR>hub 1-0:1.0: 2 ports detected<BR>EXT3 FS on hda3, internal=20
journal<BR>device-mapper: 4.1.0-ioctl (2003-12-10) initialised: <A=20
href=3D"mailto:dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org">dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org</A><BR>cdrom: open=20
failed.<BR>Adding 666656k swap on /dev/hda6.&nbsp; Priority:-1=20
extents:1<BR>kjournald starting.&nbsp; Commit interval 5 seconds<BR>EXT3 =
FS on=20
hda1, internal journal<BR>EXT3-fs: mounted filesystem with ordered data=20
mode.<BR>kjournald starting.&nbsp; Commit interval 5 seconds<BR>EXT3 FS =
on hda7,=20
internal journal<BR>EXT3-fs: mounted filesystem with ordered data=20
mode.<BR>kjournald starting.&nbsp; Commit interval 5 seconds<BR>EXT3 FS =
on hda2,=20
internal journal<BR>EXT3-fs: mounted filesystem with ordered data=20
mode.<BR>kjournald starting.&nbsp; Commit interval 5 seconds<BR>EXT3 FS =
on hda5,=20
internal journal<BR>EXT3-fs: mounted filesystem with ordered data =
mode.<BR>IA-32=20
Microcode Update Driver: v1.13 &lt;<A=20
href=3D"mailto:tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org">tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org</A>&gt;<BR>microcod=
e: CPU0=20
updated from revision 0x4 to 0xa, date =3D 05051999 <BR>parport0: =
PC-style at=20
0x378 (0x778) [PCSPP,TRISTATE]<BR>parport0: irq 7 detected<BR>SCSI =
subsystem=20
initialized<BR>inserting floppy driver for 2.6.5-1.358<BR>Floppy =
drive(s): fd0=20
is 1.44M<BR>FDC 0 is a post-1991 82077<BR>e100: Intel(R) PRO/100 Network =
Driver,=20
3.0.17<BR>e100: Copyright(c) 1999-2004 Intel Corporation<BR>divert: =
allocating=20
divert_blk for eth0<BR>e100: eth0: e100_probe: addr 0xfbdff000, irq 10, =
MAC addr=20
00:04:AC:53:A2:78<BR>8139too Fast Ethernet driver 0.9.27<BR>divert: =
allocating=20
divert_blk for eth1<BR>eth1: RealTek RTL8139 at 0xe800, =
00:48:54:1d:b0:f9, IRQ=20
11<BR>eth1:&nbsp; Identified 8139 chip type 'RTL-8139C'<BR>divert: =
freeing=20
divert_blk for eth0<BR>divert: freeing divert_blk for eth1<BR>ip_tables: =
(C)=20
2000-2002 Netfilter core team<BR>e100: Intel(R) PRO/100 Network Driver,=20
3.0.17<BR>e100: Copyright(c) 1999-2004 Intel Corporation<BR>divert: =
allocating=20
divert_blk for eth0<BR>e100: eth0: e100_probe: addr 0xfbdff000, irq 10, =
MAC addr=20
00:04:AC:53:A2:78<BR>ip_tables: (C) 2000-2002 Netfilter core =
team<BR>8139too=20
Fast Ethernet driver 0.9.27<BR>divert: allocating divert_blk for =
eth1<BR>eth1:=20
RealTek RTL8139 at 0xe800, 00:48:54:1d:b0:f9, IRQ 11<BR>eth1:&nbsp; =
Identified=20
8139 chip type 'RTL-8139C'<BR>NET: Registered protocol family =
10<BR>Disabled=20
Privacy Extensions on device 022db720(lo)<BR>IPv6 over IPv4 tunneling=20
driver<BR>divert: not allocating divert_blk for non-ethernet device =
sit0<BR>udf:=20
registering filesystem<BR>UDF-fs DEBUG=20
fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no,=20
vol_desc_start=3D0<BR>UDF-fs DEBUG fs/udf/super.c:1552:udf_fill_super:=20
Multi-session=3D0<BR>UDF-fs DEBUG fs/udf/super.c:540:udf_vrs: Starting =
at sector=20
16 (2048 byte sectors)<BR>UDF-fs DEBUG fs/udf/super.c:567:udf_vrs: =
ISO9660=20
Primary Volume Descriptor found<BR>UDF-fs DEBUG =
fs/udf/super.c:570:udf_vrs:=20
ISO9660 Supplementary Volume Descriptor found<BR>UDF-fs DEBUG=20
fs/udf/super.c:576:udf_vrs: ISO9660 Volume Descriptor Set Terminator=20
found<BR>UDF-fs: No VRS found<BR>ISO 9660 Extensions: Microsoft Joliet =
Level=20
3<BR>ISOFS: changing to secondary root</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>*** Here is FC3 dmesg ****</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Linux version 2.6.9-1.667 (<A=20
href=3D"mailto:bhcompile-FkyZWkai+dgaZRsM4JBhTKfLeoKvNuZc@public.gmane.org">bhcompile-FkyZWkai+dg+Jy45OqeSEA@public.gmane.org=
redhat.com</A>)=20
(gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Tue Nov 2 14:41:25 =
EST=20
2004<BR>BIOS-provided physical RAM map:<BR>&nbsp;BIOS-e820: =
0000000000000000 -=20
000000000009fc00 (usable)<BR>&nbsp;BIOS-e820: 000000000009fc00 -=20
00000000000a0000 (reserved)<BR>&nbsp;BIOS-e820: 00000000000e0000 -=20
0000000000100000 (reserved)<BR>&nbsp;BIOS-e820: 0000000000100000 -=20
0000000013fe0000 (usable)<BR>&nbsp;BIOS-e820: 0000000013fe0000 -=20
0000000013ff8000 (ACPI data)<BR>&nbsp;BIOS-e820: 0000000013ff8000 -=20
0000000014000000 (ACPI NVS)<BR>&nbsp;BIOS-e820: 00000000fec00000 -=20
00000000fec01000 (reserved)<BR>&nbsp;BIOS-e820: 00000000fee00000 -=20
00000000fee01000 (reserved)<BR>&nbsp;BIOS-e820: 00000000fff80000 -=20
0000000100000000 (reserved)<BR>0MB HIGHMEM available.<BR>319MB LOWMEM=20
available.<BR>zapping low mappings.<BR>On node 0 totalpages: =
81888<BR>&nbsp; DMA=20
zone: 4096 pages, LIFO batch:1<BR>&nbsp; Normal zone: 77792 pages, LIFO=20
batch:16<BR>&nbsp; HighMem zone: 0 pages, LIFO batch:1<BR>DMI 2.1=20
present.<BR>ACPI: RSDP (v000=20
AMI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
) @ 0x000fa7a0<BR>ACPI: RSDT (v001 INTEL&nbsp; RC440BXA 0x19990305 =
AMI&nbsp;=20
0x00000097) @ 0x13ff0000<BR>ACPI: FADT (v001 INTEL&nbsp; RC440BXA =
0x19990305=20
AMI&nbsp; 0x00000097) @ 0x13ff1000<BR>ACPI: DSDT (v001 INTEL&nbsp; =
RC440BXA=20
0x00001000 MSFT 0x0100000a) @ 0x00000000<BR>ACPI: BIOS age (1999) fails =
cutoff=20
(2001), acpi=3Dforce is required to enable ACPI<BR>ACPI: acpi=3Dforce=20
override<BR>ACPI: PM-Timer IO Port: 0x408<BR>Built 1 zonelists<BR>Kernel =
command=20
line: ro root=3DLABEL=3D/ acpi=3Dforce<BR>mapped 4G/4G trampoline to=20
ffff4000.<BR>Initializing CPU#0<BR>CPU 0 irqstacks, hard=3D023d5000=20
soft=3D023d4000<BR>PID hash table entries: 2048 (order: 11, 32768=20
bytes)<BR>Detected 398.409 MHz processor.<BR>Using tsc for high-res=20
timesource<BR>Console: colour VGA+ 80x25<BR>Dentry cache hash table =
entries:=20
65536 (order: 6, 262144 bytes)<BR>Inode-cache hash table entries: 32768 =
(order:=20
5, 131072 bytes)<BR>Memory: 320328k/327552k available (2068k kernel =
code, 6636k=20
reserved, 647k data, 144k init, 0k highmem)<BR>Calibrating delay loop... =
784.38=20
BogoMIPS (lpj=3D392192)<BR>Security Scaffold v1.0.0 =
initialized<BR>SELinux:&nbsp;=20
Initializing.<BR>SELinux:&nbsp; Starting in permissive mode<BR>There is =
already=20
a security framework initialized, register_security=20
failed.<BR>selinux_register_security:&nbsp; Registering secondary module =

capability<BR>Capability LSM initialized as secondary<BR>Mount-cache =
hash table=20
entries: 512 (order: 0, 4096 bytes)<BR>CPU: After generic identify, =
caps:=20
0183fbff 00000000 00000000 00000000<BR>CPU: After vendor identify, =
caps:&nbsp;=20
0183fbff 00000000 00000000 00000000<BR>CPU: L1 I cache: 16K, L1 D cache: =

16K<BR>CPU: L2 cache: 128K<BR>CPU: After all inits,=20
caps:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0183f3ff 00000000 =
00000000=20
00000040<BR>Intel machine check architecture supported.<BR>Intel machine =
check=20
reporting enabled on CPU#0.<BR>CPU: Intel Celeron (Mendocino) stepping=20
00<BR>Enabling fast FPU save and restore... done.<BR>Checking 'hlt'=20
instruction... OK.<BR>ACPI: IRQ9 SCI: Level Trigger.<BR>checking if =
image is=20
initramfs... it is<BR>Freeing initrd memory: 388k freed<BR>NET: =
Registered=20
protocol family 16<BR>PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last =

bus=3D1<BR>PCI: Using configuration type 1<BR>mtrr: v2.0 =
(20020519)<BR>ACPI:=20
Subsystem revision 20040816<BR>ACPI: Interpreter enabled<BR>ACPI: Using =
PIC for=20
interrupt routing<BR>ACPI: PCI Root Bridge [PCI0] (00:00)<BR>PCI: =
Probing PCI=20
hardware (bus 00)<BR>ACPI: PCI Interrupt Routing Table=20
[\_SB_.PCI0._PRT]<BR>ACPI: Power Resource [URP1] (off)<BR>ACPI: Power =
Resource=20
[URP2] (off)<BR>ACPI: Power Resource [FDDP] (off)<BR>ACPI: Power =
Resource [LPTP]=20
(off)<BR>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14=20
15)<BR>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14=20
15)<BR>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) =
*0,=20
disabled.<BR>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 =
14=20
15)<BR>ACPI: Power Resource [GFAN] (off)<BR>Linux Plug and Play Support =
v0.97=20
(c) Adam Belay<BR>usbcore: registered new driver usbfs<BR>usbcore: =
registered=20
new driver hub<BR>PCI: Using ACPI for IRQ routing<BR>ACPI: PCI Interrupt =
Link=20
[LNKD] enabled at IRQ 10<BR>ACPI: PCI interrupt 0000:00:07.2[D] -&gt; =
GSI 10=20
(level, low) -&gt; IRQ 10<BR>ACPI: PCI Interrupt Link [LNKB] enabled at =
IRQ=20
9<BR>ACPI: PCI interrupt 0000:00:0c.0[A] -&gt; GSI 9 (level, low) -&gt; =
IRQ=20
9<BR>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11<BR>ACPI: PCI =
interrupt=20
0000:00:0d.0[A] -&gt; GSI 11 (level, low) -&gt; IRQ 11<BR>ACPI: PCI =
interrupt=20
0000:00:10.0[A] -&gt; GSI 10 (level, low) -&gt; IRQ 10<BR>ACPI: PCI =
interrupt=20
0000:01:00.0[A] -&gt; GSI 11 (level, low) -&gt; IRQ 11<BR>apm: BIOS =
version 1.2=20
Flags 0x03 (Driver version 1.16ac)<BR>apm: overridden by ACPI.<BR>audit: =

initializing netlink socket (disabled)<BR>audit(1118342222.015:0):=20
initialized<BR>Total HugeTLB memory allocated, 0<BR>VFS: Disk quotas=20
dquot_6.5.1<BR>Dquot-cache hash table entries: 1024 (order 0, 4096=20
bytes)<BR>SELinux:&nbsp; Registering netfilter hooks<BR>Initializing=20
Cryptographic API<BR>ksign: Installing public key data<BR>Loading =
keyring<BR>-=20
Added public key 6ECDA687281A73E5<BR>- User ID: Red Hat, Inc. (Kernel =
Module GPG=20
key)<BR>Limiting direct PCI/PCI transfers.<BR>pci_hotplug: PCI Hot Plug =
PCI Core=20
version: 0.5<BR>vesafb: probe of vesafb0 failed with error -6<BR>ACPI: =
Processor=20
[CPU1] (supports C1 C2, 8 throttling states)<BR>isapnp: Scanning for PnP =

cards...<BR>isapnp: No Plug &amp; Play device found<BR>Real Time Clock =
Driver=20
v1.12<BR>Linux agpgart interface v0.100 (c) Dave Jones<BR>agpgart: =
Detected an=20
Intel 440BX Chipset.<BR>agpgart: Maximum main memory to use for agp =
memory:=20
262M<BR>agpgart: AGP aperture is 64M @ 0xf4000000<BR>serio: i8042 AUX =
port at=20
0x60,0x64 irq 12<BR>serio: i8042 KBD port at 0x60,0x64 irq 1<BR>Serial:=20
8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing =
enabled<BR>ttyS0 at I/O=20
0x3f8 (irq =3D 4) is a 16550A<BR>RAMDISK driver initialized: 16 RAM =
disks of=20
16384K size 1024 blocksize<BR>divert: not allocating divert_blk for =
non-ethernet=20
device lo<BR>Uniform Multi-Platform E-IDE driver Revision: =
7.00alpha2<BR>ide:=20
Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx<BR>PIIX4:=20
IDE controller at PCI slot 0000:00:07.1<BR>PIIX4: chipset revision =
1<BR>PIIX4:=20
not 100% native mode: will probe irqs later<BR>&nbsp;&nbsp;&nbsp; ide0: =
BM-DMA=20
at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio<BR>&nbsp;&nbsp;&nbsp; =
ide1:=20
BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio<BR>Probing IDE=20
interface ide0...<BR>hda: QUANTUM FIREBALL EX6.4A, ATA DISK =
drive<BR>Using cfq=20
io scheduler<BR>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14<BR>Probing IDE =
interface=20
ide1...<BR>hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive<BR>ide1 =
at=20
0x170-0x177,0x376 on irq 15<BR>Probing IDE interface ide2...<BR>ide2: =
Wait for=20
ready failed before probe !<BR>Probing IDE interface ide3...<BR>ide3: =
Wait for=20
ready failed before probe !<BR>Probing IDE interface ide4...<BR>ide4: =
Wait for=20
ready failed before probe !<BR>Probing IDE interface ide5...<BR>ide5: =
Wait for=20
ready failed before probe !<BR>hda: max request size: 128KiB<BR>hda: =
12594960=20
sectors (6448 MB) w/418KiB Cache, CHS=3D13328/15/63, UDMA(33)<BR>hda: =
cache=20
flushes not supported<BR>&nbsp;hda: hda1 hda2 hda3 hda4 &lt; hda5 hda6 =
hda7=20
&gt;<BR>hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)<BR>Uniform =
CD-ROM=20
driver Revision: 3.20<BR>ide-floppy driver 0.99.newide<BR>usbcore: =
registered=20
new driver hiddev<BR>usbcore: registered new driver=20
usbhid<BR>drivers/usb/input/hid-core.c: v2.0:USB HID core =
driver<BR>mice: PS/2=20
mouse device common for all mice<BR>md: md driver 0.90.0 =
MAX_MD_DEVS=3D256,=20
MD_SB_DISKS=3D27<BR>NET: Registered protocol family 2<BR>IP: routing =
cache hash=20
table of 512 buckets, 16Kbytes<BR>TCP: Hash tables configured =
(established 32768=20
bind 9362)<BR>Initializing IPsec netlink socket<BR>NET: Registered =
protocol=20
family 1<BR>NET: Registered protocol family 17<BR>ACPI: (supports S0 S1=20
S5)<BR>ACPI wakeup devices: <BR>PCI0 PS2K UAR1&nbsp; USB SLT1 SLT2 SLT3 =
SLPB=20
<BR>Freeing unused kernel memory: 144k freed<BR>kjournald =
starting.&nbsp; Commit=20
interval 5 seconds<BR>EXT3-fs: mounted filesystem with ordered data=20
mode.<BR>security:&nbsp; 3 users, 4 roles, 280 types, 16=20
bools<BR>security:&nbsp; 53 classes, 5494 rules<BR>SELinux:&nbsp; =
Completing=20
initialization.<BR>SELinux:&nbsp; Setting up existing =
superblocks.<BR>SELinux:=20
initialized (dev hda2, type ext3), uses xattr<BR>SELinux: initialized =
(dev=20
tmpfs, type tmpfs), uses transition SIDs<BR>SELinux: initialized (dev =
selinuxfs,=20
type selinuxfs), uses genfs_contexts<BR>SELinux: initialized (dev =
mqueue, type=20
mqueue), not configured for labeling<BR>SELinux: initialized (dev =
hugetlbfs,=20
type hugetlbfs), not configured for labeling<BR>SELinux: initialized =
(dev=20
devpts, type devpts), uses transition SIDs<BR>SELinux: initialized (dev=20
eventpollfs, type eventpollfs), uses genfs_contexts<BR>SELinux: =
initialized (dev=20
pipefs, type pipefs), uses task SIDs<BR>SELinux: initialized (dev tmpfs, =
type=20
tmpfs), uses transition SIDs<BR>SELinux: initialized (dev futexfs, type=20
futexfs), uses genfs_contexts<BR>SELinux: initialized (dev sockfs, type =
sockfs),=20
uses task SIDs<BR>SELinux: initialized (dev proc, type proc), uses=20
genfs_contexts<BR>SELinux: initialized (dev bdev, type bdev), uses=20
genfs_contexts<BR>SELinux: initialized (dev rootfs, type rootfs), uses=20
genfs_contexts<BR>SELinux: initialized (dev sysfs, type sysfs), uses=20
genfs_contexts<BR>SELinux: initialized (dev usbfs, type usbfs), uses=20
genfs_contexts<BR>inserting floppy driver for 2.6.9-1.667<BR>Floppy =
drive(s):=20
fd0 is 1.44M<BR>FDC 0 is a post-1991 82077<BR>e100: Intel(R) PRO/100 =
Network=20
Driver, 3.0.27-k2-NAPI<BR>e100: Copyright(c) 1999-2004 Intel=20
Corporation<BR>ACPI: PCI interrupt 0000:00:10.0[A] -&gt; GSI 10 (level, =
low)=20
-&gt; IRQ 10<BR>divert: allocating divert_blk for eth0<BR>e100: eth0:=20
e100_probe: addr 0xfbdff000, irq 10, MAC addr =
00:04:AC:53:A2:78<BR>8139too Fast=20
Ethernet driver 0.9.27<BR>ACPI: PCI interrupt 0000:00:0d.0[A] -&gt; GSI =
11=20
(level, low) -&gt; IRQ 11<BR>divert: allocating divert_blk for =
eth1<BR>eth1:=20
RealTek RTL8139 at 0xe800, 00:48:54:1d:b0:f9, IRQ 11<BR>eth1:&nbsp; =
Identified=20
8139 chip type 'RTL-8139C'<BR>ACPI: PCI interrupt 0000:00:0c.0[A] -&gt; =
GSI 9=20
(level, low) -&gt; IRQ 9<BR>USB Universal Host Controller Interface =
driver=20
v2.2<BR>ACPI: PCI interrupt 0000:00:07.2[D] -&gt; GSI 10 (level, low) =
-&gt; IRQ=20
10<BR>uhci_hcd 0000:00:07.2: UHCI Host Controller<BR>uhci_hcd =
0000:00:07.2: irq=20
10, io base 0000ef80<BR>SELinux: initialized (dev usbdevfs, type =
usbdevfs), uses=20
genfs_contexts<BR>uhci_hcd 0000:00:07.2: new USB bus registered, =
assigned bus=20
number 1<BR>hub 1-0:1.0: USB hub found<BR>hub 1-0:1.0: 2 ports =
detected<BR>md:=20
Autodetecting RAID arrays.<BR>md: autorun ...<BR>md: ... autorun =
DONE.<BR>ACPI:=20
Power Button (FF) [PWRF]<BR>ACPI: Sleep Button (CM) [SLPB]<BR>EXT3 FS on =
hda2,=20
internal journal<BR>device-mapper: 4.1.0-ioctl (2003-12-10) initialised: =
<A=20
href=3D"mailto:dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org">dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org</A><BR>cdrom: open=20
failed.<BR>kjournald starting.&nbsp; Commit interval 5 seconds<BR>EXT3 =
FS on=20
hda1, internal journal<BR>EXT3-fs: mounted filesystem with ordered data=20
mode.<BR>SELinux: initialized (dev hda1, type ext3), uses =
xattr<BR>SELinux:=20
initialized (dev tmpfs, type tmpfs), uses transition SIDs<BR>kjournald=20
starting.&nbsp; Commit interval 5 seconds<BR>EXT3 FS on hda7, internal=20
journal<BR>EXT3-fs: mounted filesystem with ordered data =
mode.<BR>SELinux:=20
initialized (dev hda7, type ext3), uses xattr<BR>kjournald =
starting.&nbsp;=20
Commit interval 5 seconds<BR>EXT3 FS on hda3, internal =
journal<BR>EXT3-fs:=20
mounted filesystem with ordered data mode.<BR>SELinux: initialized (dev =
hda3,=20
type ext3), uses xattr<BR>SELinux: initialized (dev hda5, type vfat), =
uses=20
genfs_contexts<BR>Adding 610428k swap on /dev/hda6.&nbsp; Priority:-1=20
extents:1<BR>SELinux: initialized (dev binfmt_misc, type binfmt_misc), =
uses=20
genfs_contexts<BR>parport0: PC-style at 0x378 (0x778)=20
[PCSPP,TRISTATE]<BR>parport0: irq 7 detected<BR>ip_tables: (C) 2000-2002 =

Netfilter core team<BR>ip_tables: (C) 2000-2002 Netfilter core =
team<BR>e100:=20
eth0: e100_watchdog: link up, 100Mbps, full-duplex<BR>ip_tables: (C) =
2000-2002=20
Netfilter core team<BR>eth1: link down<BR>SELinux: initialized (dev =
rpc_pipefs,=20
type rpc_pipefs), uses genfs_contexts<BR>i2c /dev entries =
driver<BR>parport0:=20
PC-style at 0x378 (0x778) [PCSPP,TRISTATE]<BR>parport0: irq 7 =
detected<BR>lp0:=20
using parport0 (polling).<BR>lp0: console ready<BR>NET: Registered =
protocol=20
family 10<BR>Disabled Privacy Extensions on device 02369a00(lo)<BR>IPv6 =
over=20
IPv4 tunneling driver<BR>divert: not allocating divert_blk for =
non-ethernet=20
device sit0<BR>ip_tables: (C) 2000-2002 Netfilter core team<BR>eth0: no =
IPv6=20
routers present<BR></FONT></DIV></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dlen.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org =
href=3D"mailto:len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">Brown, Len</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dajhindle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org=20
  href=3D"mailto:ajhindle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org">ajh</A> ; <A=20
  title=3Dacpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
  =
href=3D"mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">acpi-devel-5NWGOfrQmnegEbju0hdhLg@public.gmane.org=
orge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Tuesday, June 14, 2005 =
4:58=20
AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> RE: [ACPI] RC440BX =
won't=20
  poweroff/shutdown</DIV>
  <DIV><BR></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>The reset may actually be a =
crash.</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN =
class=3D601403418-13062005></SPAN><SPAN=20
  class=3D601403418-13062005><FONT face=3DArial color=3D#0000ff=20
  size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>Does this happen only with FC3, or does it =
also happen=20
  with</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>the latest kernel.org kernel?&nbsp; If yes, =
what is the=20
  latest kernel</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>where it did NOT happen?</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>It would be interesting if you find some boot =
parameters=20
  that make the symptom</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>go away, that may be a hint.&nbsp; =
maxcpus=3D1, and=20
  "nolapic" come to mind.</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>You can put an infinite loop in the powerdown =

  code</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>to see if you can change the reset into a =
hang=20
  --</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>then move the loop later and later until you=20
  find</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>where the access that causes the=20
  reset.</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>Start with acpi_power_off() in=20
  drivers/acpi/sleep/poweroff.c</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>cheers,</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>-Len</FONT></SPAN></DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV dir=3Dltr align=3Dleft><SPAN class=3D601403418-13062005><FONT =
face=3DArial=20
  color=3D#0000ff size=3D2>ps. please always include complete dmesg, not =
just=20
  grepped version.</FONT></SPAN></DIV><BR>
  <BLOCKQUOTE dir=3Dltr=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
    <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft>
    <HR tabIndex=3D-1>
    <FONT face=3DTahoma size=3D2><B>From:</B> =
acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
    [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] <B>On Behalf Of=20
    </B>ajh<BR><B>Sent:</B> Monday, June 13, 2005 5:04 AM<BR><B>To:</B>=20
    acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org<BR><B>Subject:</B> [ACPI] RC440BX =
won't=20
    poweroff/shutdown<BR></FONT><BR></DIV>
    <DIV></DIV>
    <DIV><FONT face=3DArial size=3D2>
    <DIV><FONT face=3DArial size=3D2>
    <DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>I have installed FC3 on a PC bought =
in 1999. It=20
    has an Intel RC440BX chipset. When I use the commands "shutdown now =
-h" or=20
    "poweroff", the PC reboots rather than shutting down. I am forcing =
ACPI use=20
    because it is a pre 2001 chipset - see dmesg below. </FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>I see that the Seattle 440BX =
chipset is on the=20
    ACPI4Linux "blacklist" but my machine (which is probably similar) =
doesn't=20
    show any error messages when closing or booting&nbsp;- it just =
reboots when=20
    asked to shutdown. I hope someone can help. Cheers</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>"dmesg | grep ACPI" shows =
this:</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>&nbsp;BIOS-e820: 0000000013fe0000 - =

    0000000013ff8000 (ACPI data)<BR>&nbsp;BIOS-e820: 0000000013ff8000 -=20
    0000000014000000 (ACPI NVS)<BR>ACPI: RSDP (v000=20
    =
AMI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    ) @ 0x000fa7a0<BR>ACPI: RSDT (v001 INTEL&nbsp; RC440BXA 0x19990305 =
AMI&nbsp;=20
    0x00000097) @ 0x13ff0000<BR>ACPI: FADT (v001 INTEL&nbsp; RC440BXA =
0x19990305=20
    AMI&nbsp; 0x00000097) @ 0x13ff1000<BR>ACPI: DSDT (v001 INTEL&nbsp; =
RC440BXA=20
    0x00001000 MSFT 0x0100000a) @ 0x00000000<BR>ACPI: BIOS age (1999) =
fails=20
    cutoff (2001), acpi=3Dforce is required to enable ACPI<BR>ACPI: =
acpi=3Dforce=20
    override<BR>ACPI: PM-Timer IO Port: 0x408<BR>ACPI: IRQ9 SCI: Level=20
    Trigger.<BR>ACPI: Subsystem revision 20040816<BR>ACPI: Interpreter=20
    enabled<BR>ACPI: Using PIC for interrupt routing<BR>ACPI: PCI Root =
Bridge=20
    [PCI0] (00:00)<BR>ACPI: PCI Interrupt Routing Table=20
    [\_SB_.PCI0._PRT]<BR>ACPI: Power Resource [URP1] (off)<BR>ACPI: =
Power=20
    Resource [URP2] (off)<BR>ACPI: Power Resource [FDDP] (off)<BR>ACPI: =
Power=20
    Resource [LPTP] (off)<BR>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 =
6 7 9=20
    10 *11 12 14 15)<BR>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 =
*9 10 11=20
    12 14 15)<BR>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 =
12 14=20
    15) *0, disabled.<BR>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 =
9 *10=20
    11 12 14 15)<BR>ACPI: Power Resource [GFAN] (off)<BR>PCI: Using ACPI =
for IRQ=20
    routing<BR>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ =
10<BR>ACPI: PCI=20
    interrupt 0000:00:07.2[D] -&gt; GSI 10 (level, low) -&gt; IRQ =
10<BR>ACPI:=20
    PCI Interrupt Link [LNKB] enabled at IRQ 9<BR>ACPI: PCI interrupt=20
    0000:00:0c.0[A] -&gt; GSI 9 (level, low) -&gt; IRQ 9<BR>ACPI: PCI =
Interrupt=20
    Link [LNKA] enabled at IRQ 11<BR>ACPI: PCI interrupt 0000:00:0d.0[A] =
-&gt;=20
    GSI 11 (level, low) -&gt; IRQ 11<BR>ACPI: PCI interrupt =
0000:00:10.0[A]=20
    -&gt; GSI 10 (level, low) -&gt; IRQ 10<BR>ACPI: PCI interrupt=20
    0000:01:00.0[A] -&gt; GSI 11 (level, low) -&gt; IRQ 11<BR>apm: =
overridden by=20
    ACPI.<BR>ACPI: Processor [CPU1] (supports C1 C2, 8 throttling=20
    states)<BR>ACPI: (supports S0 S1 S5)<BR>ACPI wakeup devices: =
<BR>ACPI: PCI=20
    interrupt 0000:00:10.0[A] -&gt; GSI 10 (level, low) -&gt; IRQ =
10<BR>ACPI:=20
    PCI interrupt 0000:00:0d.0[A] -&gt; GSI 11 (level, low) -&gt; IRQ=20
    11<BR>ACPI: PCI interrupt 0000:00:0c.0[A] -&gt; GSI 9 (level, low) =
-&gt; IRQ=20
    9<BR>ACPI: PCI interrupt 0000:00:07.2[D] -&gt; GSI 10 (level, low) =
-&gt; IRQ=20
    10<BR>ACPI: Power Button (FF) [PWRF]<BR>ACPI: Sleep Button (CM)=20
    =
[SLPB]</FONT></DIV></FONT></DIV></FONT></DIV></BLOCKQUOTE></BLOCKQUOTE></=
BODY></HTML>

------=_NextPart_000_000A_01C57131.7073CA60--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
