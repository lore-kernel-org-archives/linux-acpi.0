From: Samuele Kaplun <kaplun-e7mAqy1nzl5eoWH0uzbU5w@public.gmane.org>
Subject: Problems with pci or maybe io-apic... who knows...
Date: Thu, 19 Dec 2002 15:06:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212191506.54613.kaplun@inwind.it>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+JdA+ImE7gONXEG"
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


--Boundary-00=_+JdA+ImE7gONXEG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody...
I patched my kernel with the latest patches set of Con Kolivas porting my acpi 
subsystem to revision 20021122
With the new system of acpi I encounter some problems with my harddisk, which 
eventually caused it to hang...
I think it's an irq problems but I don't know anything about this world... I 
attach my dmesg report...
The lines which make me worry are:
[...]
    ACPI-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
[...]
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
[...]
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
[...]
--Boundary-00=_+JdA+ImE7gONXEG
Content-Type: text/x-log;
  charset="us-ascii";
  name="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="dmesg.log"

Linux version 2.4.20-ck2 (root@localhost) (gcc version 3.2.1) #1 Thu Dec 19=
 14:26:14 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
found SMP MP-table at 000fb9e0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000fa7b0
ACPI: RSDT (v001 AMIINT AMIINI09 00000.00016) @ 0x1fff0000
ACPI: FADT (v001 AMIINT AMIINI09 00000.00017) @ 0x1fff0030
ACPI: MADT (v001 AMIINT AMIINI09 00000.00017) @ 0x1fff00c0
ACPI: DSDT (v001    VIA   VIA_K7 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 2, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x=
3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: BOOT_IMAGE=3DNew ro root=3D306
Initializing CPU#0
Detected 1733.697 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3416.06 BogoMIPS
Memory: 516140k/524224k available (1249k kernel code, 7696k reserved, 417k =
data, 116k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2100+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E... register #01: 00178002
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 1
=2E......     : IO APIC version: 0002
 WARNING: unexpected IO-APIC, please mail
          to linux-smp-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1733.0103 MHz.
=2E.... host bus clock speed is 266.0631 MHz.
cpu: 0, clocks: 266631, slice: 133315
CPU0<T0:266624,T1:133296,D:13,S:133315,C:266631>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021122
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=3D1
PCI: Using configuration type 1
    ACPI-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:01[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:01[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22)
00:00:11[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21)
00:00:11[D] -> 2-21 -> IRQ 21
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18)
00:00:09[B] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19)
00:00:09[C] -> 2-19 -> IRQ 19
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
PCI: Via IRQ fixup for 00:11.2, from 10 to 5
PCI: Via IRQ fixup for 00:11.3, from 10 to 5
PCI: Via IRQ fixup for 00:14.0, from 11 to 0
PCI: Via IRQ fixup for 00:14.1, from 10 to 1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Compressed Cache: 0.24pre5
Compressed Cache: maximum size
Compressed Cache:  32764 pages =3D 262112KiB
Compressed Cache: hash table
Compressed Cache:  fragment   (1024 entries =3D 4096B)
Compressed Cache:  free space (42 entries =3D 168B)
Compressed Cache:  total free space (42 entries =3D 168B)
Compressed Cache: compression algorithm: LZO
Compressed Cache: adaptivity
Compressed Cache:  clean page (4096 entries =3D 16384B)
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
vesafb: framebuffer at 0xd0000000, mapped to 0xe080b000, size 65536k
vesafb: mode is 1024x768x8, linelength=3D1024, pages=3D84
vesafb: protected mode interface info at c000:5584
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L040J2, ATA DISK drive
hdc: _NEC DV-5800B, ATAPI CD/DVD-ROM drive
hdd: _NEC CD-RW NR-9100A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02edd04, I/O limit 4095Mb (mask 0xffffffff)
hda: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=3D4866/255/63, UDMA(1=
33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 > p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
=46reeing unused kernel memory: 116k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 530104k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
SCSI subsystem driver Revision: 1.00
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
inserting floppy driver for 2.4.20-ck2
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
hcd.c: ehci-hcd @ 00:14.2, VIA Technologies, Inc. USB 2.0
hcd.c: irq 18, pci mem e48c1f00
usb.c: new USB bus registered, assigned bus number 1
ehci-hcd.c: USB 2.0 support enabled, EHCI rev 0.95
hub.c: USB hub found
hub.c: 4 ports detected
usb-uhci.c: $Revision: 1.275 $ time 14:34:21 Dec 19 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 17
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:11.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc00e) is not claimed by any active d=
river.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
hub.c: new USB device 00:11.2-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x5a9/0xa511) is not claimed by any active d=
river.
hub.c: new USB device 00:11.3-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x4a9/0x220d) is not claimed by any active d=
river.
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb2:2.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
Linux video capture interface: v1.00
usb.c: registered new driver ov511
ov511.c: USB OV511+ video device found
ov511.c: model: Generic Camera (no ID)
ov511.c: Sensor is an OV7620
ov511.c: Device registered on minor 0
ov511.c: v1.61 for Linux 2.4 : ov511 USB Camera Driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Creative EMU10K1 PCI Audio Driver, version 0.20, 14:33:47 Dec 19 2002
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xe800-0xe81f, IRQ 19
ac97_codec: AC97 Audio codec, id: =83=84v8(SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A

--Boundary-00=_+JdA+ImE7gONXEG--



-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
