From: Dirk Meul <dirk.meul-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: Reboots instead of powering down
Date: Wed, 24 Mar 2004 16:31:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080142026.2069.55.camel@legolas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_IwHlgf1jG+EB1og9dI+EiQ)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_IwHlgf1jG+EB1og9dI+EiQ)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hello.

If BIOS wakeup is enabled on shutdown the PC reboots instead of powering
down. If BIOS wakeup is disabled the PC powers down.

Tested with linux-2.6.5-rc2-bk2 + acpi-20040311-2.6.5. The Mainboard is
815E Pro (MS-6337) with a Celeron 850.

Regards,
-- 
                           /"\
Dirk Meul                  \ /    ASCII Ribbon Campaign
dirk.meul-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org    X     Against HTML Mail
                           / \

--Boundary_(ID_IwHlgf1jG+EB1og9dI+EiQ)
Content-type: text/plain; name=dmesg.log; charset=UTF-8
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=dmesg.log

Linux version 2.6.5-rc2-bk3 (root-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org) (gcc version 3.3.3 (Debian)) #1 Wed Mar 24 14:39:09 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7510
ACPI: RSDT (v001 IntelR MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 IntelR MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: rootfstype=ext3 root=/dev/hdc2 ro resume=/dev/hdc1 ide1=dma hdc=autotune vga=0x314 video=vesafb:mtrr,ywrap elevator=deadline
ide_setup: ide1=dma
ide_setup: hdc=autotune
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 856.602 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 256112k/262080k available (1524k kernel code, 5236k reserved, 780k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1695.74 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 856.0166 MHz.
..... host bus clock speed is 100.0725 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb0d0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040311
ACPI: IRQ9 SCI: Edge Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xe4000000, mapped to 0xd0807000, size 16384k
vesafb: mode is 800x600x16, linelength=1600, pages=33
vesafb: protected mode interface info at c000:7f32
vesafb: pmi: set display start = c00c7fbb, set palette = c00c801e
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=10485
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
ACPI: Thermal Zone [THRM] (22 C)
Console: switching to colour frame buffer device 100x37
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DHEA-36481, ATA DISK drive
Using deadline io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG VG38404A, ATA DISK drive
hdd: ASUS CD-S400/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 12692736 sectors (6498 MB) w/472KiB Cache, CHS=12592/16/63, UDMA(33)
 hda: hda1
hdc: max request size: 128KiB
hdc: 16498944 sectors (8447 MB) w/490KiB Cache, CHS=16368/16/63, UDMA(33)
 hdc: hdc1 hdc2
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0000d000
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 11, io base 0000d400
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
savage4 smbus 0000:01:00.0: Using Savage4 at d1808000
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
SCTP: Hash tables configured (established 8192 bind 16384)
Resume Machine: resuming from /dev/hdc1
Resuming from device hdc1
Resume Machine: This is normal swap space
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
usb 1-1: new full speed USB device using address 2
NET: Registered protocol family 1
drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Adding 488364k swap on /dev/hdc1.  Priority:-1 extents:1
EXT3 FS on hdc2, internal journal
hdd: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
NTFS driver 2.1.6 [Flags: R/W MODULE].
NTFS volume version 3.1.
ts: Compaq touchscreen protocol output
Disabled Privacy Extensions on device c02ff0e0(lo)
blk: queue c13a3200, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c138bc00, I/O limit 4095Mb (mask 0xffffffff)
IA-32 Microcode Update Driver: v1.13 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49468 usecs
intel8x0: clocking to 48000
drivers/usb/core/usb.c: registered new driver snd-usb-audio
dummy0: no IPv6 routers present
lp0: using parport0 (interrupt-driven).
mtrr: 0xe4000000,0x2000000 overlaps existing 0xe4000000,0x1000000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
inserting floppy driver for 2.6.5-rc2-bk3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

--Boundary_(ID_IwHlgf1jG+EB1og9dI+EiQ)--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
