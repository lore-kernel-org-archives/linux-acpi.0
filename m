From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Causes of missing /proc/acpi/sleep entry?
Date: Fri, 10 Jan 2003 21:06:19 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1042185931.1614.3.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-CXQUZ66l65zIP8lUkgjn"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-CXQUZ66l65zIP8lUkgjn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all.

I've just given 2.5.55 a try. With or without a DSDT override for my
Omnibook XE3, I get no /proc/acpi/sleep file. Any suggestions as to what
I should look at/for?

Regards,

Nigel

(Log attached)

--=-CXQUZ66l65zIP8lUkgjn
Content-Disposition: attachment; filename=2.5.55dmesg
Content-Type: text/plain; name=2.5.55dmesg; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.5.55 (root-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Jan 10 20:44:34 NZDT 2003
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000076f0000 (usable)
 BIOS-e820: 00000000076f0000 - 00000000076ff000 (ACPI data)
 BIOS-e820: 00000000076ff000 - 0000000007700000 (ACPI NVS)
 BIOS-e820: 0000000007700000 - 0000000007780000 (usable)
 BIOS-e820: 0000000007780000 - 0000000008000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
119MB LOWMEM available.
On node 0 totalpages: 30592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 26496 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 HP-MCD                     ) @ 0x000f6190
ACPI: RSDT (v001 HP-MCD   RSDT   01540.00000) @ 0x076f9cf3
ACPI: FADT (v001 HP-MCD GF DSDT  01540.00000) @ 0x076fef8c
ACPI: DSDT (v001 HP-MCD GF DSDT  01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=devel ro root=306 quiet devfs=mount resume=/dev/hda5 init S
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 929.918 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1839.10 BogoMIPS
Memory: 117148k/122368k available (1947k kernel code, 4596k reserved, 942k data, 124k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xfd98a, last bus=2
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 228 entries (12 bytes)
biovec pool[1]:   4 bvecs: 228 entries (48 bytes)
biovec pool[2]:  16 bvecs: 228 entries (192 bytes)
biovec pool[3]:  64 bvecs: 228 entries (768 bytes)
biovec pool[4]: 128 bvecs: 114 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  57 entries (3072 bytes)
ACPI: Subsystem revision 20021217
   tbget-0272: *** Info: Table [DSDT] replaced by host OS
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...........................................................................................................................................................................
Table [DSDT] - 598 Objects with 53 Devices 171 Methods 22 Regions
ACPI Namespace successfully loaded at root c042713c
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0258: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0258: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:.....................................................
53 Devices found containing: 53 _STA, 3 _INI methods
Completing Region/Field/Buffer/Package initialization:...........................................................
Initialized 10/22 Regions 0/0 Fields 33/33 Buffers 16/16 Packages (598 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
pci_bind-0188 [07] acpi_pci_bind         : Device 00:02:06.00 not present in PCI namespace
pci_bind-0188 [08] acpi_pci_bind         : Device 00:02:00.00 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: Embedded Controller [EC0] (gpe 28)
Linux Plug and Play Support v0.93 (c) Adam Belay
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6210
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9c33, dseg 0x400
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x1000-0x105f has been reserved
pnp: 00:0a: ioport range 0x1060-0x107f has been reserved
pnp: 00:0a: ioport range 0x1180-0x11bf has been reserved
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
pci_link-0331 [13] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2 C3)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
vesafb: framebuffer at 0xe8000000, mapped to 0xc8006000, size 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at a5f3:1f5f
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
device class 'tty': registering
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Non-volatile memory driver v1.2
i810_rng hardware driver 0.9.8 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 86M
agpgart: detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] Initialized i830 1.2.1 20020828 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:3F:30:CD:4A, IRQ 10.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-10, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 19640880 sectors (10056 MB) w/512KiB Cache, CHS=19485/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
Console: switching to colour frame buffer device 128x48
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 02:04.0 (0081 -> 0083)
PCI: Enabling device 02:04.1 (0081 -> 0083)
device class 'input': registering
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
maestro3: version 1.23 built at 20:40:58 Jan 10 2003
maestro3: Configuring ESS Allegro found at IO 0x2000 IRQ 5
maestro3:  subvendor id: 0x0021103c
Yenta IRQ list 0098, PCI irq9
Socket status: 30000006
Yenta IRQ list 0098, PCI irq9
Socket status: 30000006
ac97_codec: AC97 Audio codec, id: 0x4583:0x8308 (ESS Allegro ES1988)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack version 2.1 (956 buckets, 7648 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.07 2002-Oct-24, 1 devices found
Resume Machine: resuming from /dev/hda5
Resuming from device ide0(3,5)
Resume Machine: This is normal swap space
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Adding 257000k swap on /dev/hda5.  Priority:-1 extents:1
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdc, sector 0
hdc: DMA disabled

--=-CXQUZ66l65zIP8lUkgjn--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
