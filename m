From: Michael Ost <most-NE/i7qws/Rdz3GwezmZiRw@public.gmane.org>
Subject: HP XH545 laptop - boot fails with acpi on
Date: 27 Aug 2004 11:28:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093631322.1083.22.camel@ihop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aqAEhxiBywgAt+wyHElR"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--=-aqAEhxiBywgAt+wyHElR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Howdy. 

My trusty but old HP XH545 laptop fails to boot with acpi on. I turned
on acpi debug messages and the message before the boot hangs is: 

Executing all Device _STA and_INI methods:..... 

I am using a stock kernel 2.6.7, with one patch to fix a bad USB IRQ for
my hp laptop. 

Any suggestions for a fix? It's really annoying! 

If I boot with acpi=off the kernel boots. However thesystem sputters
pretty badly since I am only part way through getting the kernel to work
on my RH8 based system --- there are still unhappy components. 

I tried 2.6.7 from my usual 2.4.19 at the suggestion of a colleague who
said that the newer kernel would be easier to get support from
acpi-devel for. But I can't get very far with 2.6.7 + acpi, since it
doesn't boot.

Interestingly my 2.4.19 kernel hangs in the same spot, but only about
40% of the time. The rest of the time it gets passed that line, and then
acpi debug displays:

43 Devices found containing: 43 _STA, 1 _INI methods 

That kernel is patched with the HP USB patch, and with acpi from
20020918. 
 
This laptop, the hp pavilion xh545, is pretty much the same as the more
common hp pavilion N5400. My BIOS is GE.M2.O1, while the N5400s have
GE.M3.O1. The stock 2.6.7 kernel has the GE.M3.O1 detection patch in,
which is built to fix a bogus USB IRQ on those laptops. I patched the
kernel to detect my GE.M2.O1 BIOS as well and do the same tweak. That
works fine in 2.4.19.

I don't know how to attach a boot log from a failed boot. But, in case
it might help, attached is dmesg from a successful boot of 2.4.19.

Thanks... mo 


--=-aqAEhxiBywgAt+wyHElR
Content-Disposition: attachment; filename=2.4.19-boot.log
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=2.4.19-boot.log; charset=UTF-8

Linux version 2.4.19-m2 (root@ihop) (gcc version 3.2 20020903 (Red Hat Linu=
x 8.0 3.2-7)) #4 Fri Jul 23 15:20:31 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
256MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7ed0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0fefb0b3
ACPI: FADT (v001 ALI    M1533    01540.00000) @ 0x0fefee4c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fefeec0
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0fefeee8
ACPI: DSDT (v001 COMPAL      736 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
HP Pavilion N5400 Series Laptop detected - fixing broken IRQ routing
Kernel command line: ro root=3DLABEL=3D/=20
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 950.035 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1893.99 BogoMIPS
Memory: 256504k/262144k available (1447k kernel code, 5188k reserved, 523k =
data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor =3D 2
Enabling Disabled K7/SSE Support...
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c7fbff 00000000 00000000
CPU: AMD mobile AMD Athlon(tm) 4 Processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 950.0879 MHz.
..... host bus clock speed is 200.0185 MHz.
cpu: 0, clocks: 2000185, slice: 1000092
CPU0<T0:2000176,T1:1000080,D:4,S:1000092,C:2000185>
ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=3D1
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...........................................................=
...........................................................................=
....
Table [DSDT] - 486 Objects with 43 Devices 138 Methods 11 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c0316c9c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successf=
ul
Executing all Device _STA and_INI methods:....<3>schedule_task(): keventd h=
as not started
.......................................
43 Devices found containing: 43 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:.....................=
..................................
Initialized 6/11 Regions 0/0 Fields 22/22 Buffers 27/27 Packages (489 nodes=
)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5, disabled)
ACPI: PCI Interrupt Link [LNKU] (IRQs *9)
ACPI: Embedded Controller [EC0] (gpe 25)
ACPI: Power Resource [PFAN] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
 pci_irq-0293 [13] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Fan [FAN] (off)
acpi_processor-0899 [18] acpi_processor_get_per: Unsupported address space =
[127] (control_register)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
[ACPI Debug] String: __________________________________
[ACPI Debug] String:=20
[ACPI Debug] String: _SCP
[ACPI Debug] String: __________________________________
ACPI: Thermal Zone [THRM] (40 C)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ALI15X3: IDE controller on PCI bus 00 dev 78
 pci_irq-0293 [12] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0 - using IRQ 255
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATDA04-0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
hdc: UJDA710, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=3D2432/255/63, UDMA(3=
3)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux Tulip driver version 0.9.15-pre11 (May 11, 2002)
eth0: ADMtek Comet rev 17 at 0x8c00, 00:D0:59:7B:84:09, IRQ 11.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
I2O Core - (C) Copyright 1999 Red Hat Software
spurious 8259A interrupt: IRQ7.
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
I2O: Event thread created as pid 10
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 64k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 96k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xd082a000, IRQ 9
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
hub.c: USB new device connect on bus1/1, assigned device number 2
input0: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb1:2.0
input1: USB HID v1.10 Mouse [Logitech USB Receiver] on usb1:2.1
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
Adding Swap: 522072k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver v1.1.22 [Flags: R/O MODULE]
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x408-0x40f 0x480-0x=
48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
cdrom: This disc doesn't have any tracks I recognize!
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 273
keyboard.c: can't emulate rawmode for keycode 273
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272

--=-aqAEhxiBywgAt+wyHElR--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
