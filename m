From: Richard Harman <acpi-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>
Subject: Near-perfect DSDT from compaq for Evo N600c
Date: Wed, 15 Oct 2003 16:02:46 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200310152002.h9FK2lN24765@xabean.net>
Reply-To: Richard Harman <acpi-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_2534099520"
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

This is a multipart MIME message.

--==_Exmh_2534099520
Content-Type: text/plain; charset=us-ascii

I downloaded the latest BIOS update from HP/Compaq, flashed, rebooted and 
everything works.  Attached is my dmesg output, it looks like there's a few 
errors still, but I have no problems with fans/thermal zones/batteries what 
not.


-----------------------------------------------------------
"Looks like there'll be no money for you, Crazy Round Man." 
                                             - Samurai Jack
Richard G Harman Jr           <me+nospam-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>



--==_Exmh_2534099520
Content-Type: application/octet-stream ; name="acpi.dmesg"
Content-Description: acpi.dmesg
Content-Disposition: attachment; filename="acpi.dmesg"

Linux version 2.4.22-ck2 (root-ak5jEeKqq9abnaeFrkUmggO4oBArJ+LsXqFh9Ls21Oc@public.gmane.org) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #5 Fri Oct 10 14:06:45 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
 BIOS-e820: 000000000ffd0000 - 000000000fff0c00 (reserved)
 BIOS-e820: 000000000fff0c00 - 000000000fffc000 (ACPI NVS)
 BIOS-e820: 000000000fffc000 - 0000000010000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65488
zone(0): 4096 pages.
zone(1): 61392 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ0030  0x18060320 CPQ  0x00000001) @ 0x0fff0c84
ACPI: FADT (v002 COMPAQ CPQ0030  0x00000002 CPQ  0x00000001) @ 0x0fff0c00
ACPI: SSDT (v001 COMPAQ   CPQCPU 0x00001001 MSFT 0x0100000e) @ 0x0fff7bcb
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x0fff7c16
ACPI: DSDT (v001 COMPAQ EVON600C 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
Kernel command line: ro root=/dev/hda2 vga=833
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1196.083 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2367.48 BogoMIPS
Memory: 256600k/261952k available (1225k kernel code, 4964k reserved, 259k data, 124k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1195.0831 MHz.
..... host bus clock speed is 132.0870 MHz.
cpu: 0, clocks: 132870, slice: 66435
CPU0<T0:132864,T1:66416,D:13,S:66435,C:132870>
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xf04dd, last bus=4
PCI: Using configuration type 1
Looking for DSDT in initrd ... not found!
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..........................................................................................................................................................................................................................................................................
Table [DSDT](id F006) - 833 Objects with 89 Devices 266 Methods 26 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 3 Objects with 0 Devices 1 Methods 0 Regions
Parsing all Control Methods:..
Table [SSDT](id F004) - 4 Objects with 0 Devices 2 Methods 0 Regions
ACPI Namespace successfully loaded at root c014f03c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0740 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000001028 on int 9
evgpeblk-0219 [08] ev_save_method_info   : Unknown GPE method type: C13E (name not of form _Lnn or _Enn)
evgpeblk-0219 [08] ev_save_method_info   : Unknown GPE method type: C18F (name not of form _Lnn or _Enn)
evgpeblk-0219 [08] ev_save_method_info   : Unknown GPE method type: C1DC (name not of form _Lnn or _Enn)
evgpeblk-0740 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000102C on int 9
evgpeblk-0219 [08] ev_save_method_info   : Unknown GPE method type: C13E (name not of form _Lnn or _Enn)
evgpeblk-0219 [08] ev_save_method_info   : Unknown GPE method type: C18F (name not of form _Lnn or _Enn)
evgpeblk-0219 [08] ev_save_method_info   : Unknown GPE method type: C1DC (name not of form _Lnn or _Enn)
Completing Region/Field/Buffer/Package initialization:...........................................................................................................
Initialized 25/26 Regions 0/0 Fields 26/26 Buffers 56/56 Packages (848 nodes)
Executing all Device _STA and_INI methods:..........................................................................................
90 Devices found containing: 90 _STA, 7 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
dsopcode-0513 [20] ds_init_buffer_field  : Field size 1184 exceeds Buffer size 1088 (bits)
 psparse-1120: *** Error: Method execution failed [\_SB_.C03E.C04C] (Node cffa5a48), AE_AML_BUFFER_LIMIT
 psparse-1120: *** Error: Method execution failed [\_SB_.C03E.C050] (Node cffa5b48), AE_AML_BUFFER_LIMIT
 psparse-1120: *** Error: Method execution failed [\_SB_.C03E._CRS] (Node cffa5c48), AE_AML_BUFFER_LIMIT
  uteval-0097: *** Error: Method execution failed [\_SB_.C03E._CRS] (Node cffa5c48), AE_AML_BUFFER_LIMIT
ACPI: PCI Root Bridge [C03E] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.C03E._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03E.C03F._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03E.C052._PRT]
ACPI: Power Resource [C14E] (on)
ACPI: Power Resource [C162] (on)
ACPI: Power Resource [C167] (on)
ACPI: Power Resource [C16B] (on)
ACPI: Power Resource [C174] (on)
ACPI: PCI Interrupt Link [C0BA] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BB] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BE] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BF] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0C0] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0C1] (IRQs 5 10 11, disabled)
ACPI: Power Resource [C1F3] (off)
ACPI: Power Resource [C1F4] (off)
ACPI: Power Resource [C1F5] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [C0BA] enabled at IRQ 10
ACPI: PCI Interrupt Link [C0BD] enabled at IRQ 10
ACPI: PCI Interrupt Link [C0BC] enabled at IRQ 10
ACPI: PCI Interrupt Link [C0BB] enabled at IRQ 10
ACPI: PCI Interrupt Link [C0C0] enabled at IRQ 10
ACPI: PCI Interrupt Link [C0BF] enabled at IRQ 10
ACPI: PCI Interrupt Link [C0BE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
vesafb: framebuffer at 0x48000000, mapped to 0xd0813000, size 5742k
vesafb: mode is 1400x1050x16, linelength=2800, pages=10
vesafb: protected mode interface info at c000:5341
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:5:5, shift=0:10:5:0
Looking for splash picture.... silenjpeg size 22203 bytes, found (1400x1050, 19873 bytes, v3).
Console: switching to colour frame buffer device 175x65
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4060-0x4067, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4068-0x406f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3018GAP, ATA DISK drive
blk: queue c0165780, I/O limit 4095Mb (mask 0xffffffff)
hdc: Compaq DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58605120 sectors (30006 MB), CHS=3876/240/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 41k freed
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,2): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 3205362
ext3_orphan_cleanup: deleting unreferenced inode 3205361
EXT3-fs: ide0(3,2): 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Real Time Clock Driver v1.10e
Adding Swap: 521632k swap-space (priority -1)
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0x4000, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
uhci.c: USB UHCI at I/O 0x4020, IRQ 10
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
uhci.c: USB UHCI at I/O 0x4040, IRQ 10
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: new USB device 00:1d.1-1, assigned address 2
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:1d.1-1, assigned address 3
usb.c: USB device 3 (vend/prod 0x461/0x4d09) is not claimed by any active driver.
usb.c: registered new driver usbmouse
input0: USB HIDBP Mouse 0461:4d09 on usb2:3.0
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdc: DMA disabled
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
microcode: CPU0 already at revision 29 (current=29)
microcode: freed 2048 bytes
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

e100: eth0 NIC Link is Up 100 Mbps Half duplex
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 00f8, PCI irq10
Socket status: 30000006
Yenta IRQ list 00f8, PCI irq10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x140-0x14f 0x378-0x37f 0x3e8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
ACPI: Fan [C1F6] (off)
ACPI: Fan [C1F7] (off)
ACPI: Fan [C1F8] (off)
ACPI: AC Adapter [C1A2] (on-line)
dsmthdat-0461 [49] ds_method_data_get_val: Uninitialized Local[0] at node cea9f508
 psparse-1120: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C12E] (Node c12d6848), AE_AML_UNINITIALIZED_LOCAL
 psparse-1120: *** Error: Method execution failed [\_SB_.C03E.C053.C0D1.C13D] (Node c12d50e8), AE_AML_UNINITIALIZED_LOCAL
 psparse-1120: *** Error: Method execution failed [\_SB_.C19F._BTP] (Node c12fad48), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [C19F] (battery present)
ACPI: Battery Slot [C1A0] (battery absent)
ACPI: Processor [C000] (supports C1 C2 C3, 2 performance states)
ACPI: Thermal Zone [TZ1] (58 C)
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (polling).
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
microcode: CPU0 already at revision 29 (current=29)
microcode: freed 2048 bytes
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel(R) 830M chipset
agpgart: AGP aperture is 256M @ 0x60000000
[drm] AGP 0.99 on Unknown @ 0x60000000 256MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0

--==_Exmh_2534099520--




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
