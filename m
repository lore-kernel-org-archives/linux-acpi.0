From: John Fremlin <john-F7Dg16nrplyELgA04lAiVw@public.gmane.org>
Subject: Fujitsu Lifebook S2020 laptop screen brightness
Date: Sat, 13 Sep 2003 17:49:16 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2vfrwtw83.fsf@bayu.ireton.fremlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


The screen brightness on my Fujitsu Lifebook S2020 laptop can be
controlled by using the [Fn] key on the keyboard in conjunction with
the F8 and F9 keys. These key combinations have no effect on the
brightness without the ACPI modules loaded (reporting unknown
keystroke).

With the ACPI modules loaded, they sort of work. However trying to
turn the brightness down "too much" (press [Fn]-F8 a couple of times)
freezes the system with no log messages and breaks even the magic
SysReq. This has also happened just pressing [Fn]-F8 once after
booting up, so possibly it crashes at random with about 50%
probability each time.

The brightness never gets as dark as the laptop can go I
think. Possibly the same thing happens if you press the brightness up
key or the volume control keys but I haven't checked.

I doubt that this occurs in MS Windows but (un)fortunately I am not in
a position to find out.

How can I debug this? 

Is there any chance of getting a program to configure the screen
brightness?

Has anybody got the four extra "security" buttons working to launch
programs etc.?

On a positive note, power off, the power button events, lid close
events, power switch events and battery charge reporting seem to work
fine

dmesg from a Mandrake-modified 2.4.23-pre1 (IIUC):

Linux version 2.4.22-5mdkcustom (root-4UTo/7xUYz8GXeXG67NKHx6HMcF/ZGuc@public.gmane.org) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-2mdk)) #2 Fri Sep 5 17:54:44 UTC 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001def0000 (usable)
 BIOS-e820: 000000001def0000 - 000000001deff000 (ACPI data)
 BIOS-e820: 000000001deff000 - 000000001df00000 (ACPI NVS)
 BIOS-e820: 000000001df00000 - 000000001e000000 (usable)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
480MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 122880
zone(0): 4096 pages.
zone(1): 118784 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 FUJ                                       ) @ 0x000f6980
ACPI: RSDT (v001 FUJ    GARLIC   0x01080000 FUJ  0x00001000) @ 0x1defa5bb
ACPI: FADT (v001 FUJ    GARLIC   0x01080000 FUJ  0x00001000) @ 0x1defee88
ACPI: SSDT (v001 FUJ    GARLIC   0x01080000 FUJ  0x00001000) @ 0x1defeefc
ACPI: BOOT (v001 FUJ    GARLIC   0x01080000 FUJ  0x00001000) @ 0x1defefd8
ACPI: DSDT (v001 FUJ    GARLIC   0x01080000 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/hda7 devfs=mount vga=791 resume=/dev/hda8
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1462.044 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2916.35 BogoMIPS
Memory: 482192k/491520k available (1753k kernel code, 8872k reserved, -2210k data, 164k init, 0k highmem, 0k BadRAM)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP-M (LV) 1900+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1461.9488 MHz.
..... host bus clock speed is 265.8088 MHz.
cpu: 0, clocks: 2658088, slice: 1329044
CPU0<T0:2658080,T1:1329024,D:12,S:1329044,C:2658088>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xfd85e, last bus=3
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:......................................................................................................................................................................................................
Table [DSDT](id F005) - 656 Objects with 52 Devices 198 Methods 24 Regions
Parsing all Control Methods:
Table [SSDT](id F003) - 3 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c016281c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 63 [_GPE] 8 regs at 000000000000FF18 on int 9
Completing Region/Field/Buffer/Package initialization:................................................................................................
Initialized 24/24 Regions 0/0 Fields 42/42 Buffers 30/30 Packages (667 nodes)
Executing all Device _STA and_INI methods:...................................................
51 Devices found containing: 51 _STA, 8 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 (swsusp) S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7 9 10 11, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
 pci_irq-0302 [26] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
kinoded started
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
vesafb: framebuffer at 0xe4000000, mapped to 0xde80c000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at c000:5159
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 1024 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (10b9,5457,10cf,1130)
and the manufacturer and name of serial board or modem board
to serial-pci-info-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org
register_serial(): autoconfig failed
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Warning: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 00:0f.0
 pci_irq-0302 [29] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3021GAS, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
blk: queue c0182b60, I/O limit 4095Mb (mask 0xffffffff)
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
spurious 8259A interrupt: IRQ7.
hda: host protected area => 1
hda: 58605120 sectors (30006 MB), CHS=3648/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Resume Machine:   This is normal swap space
Swsusp 1.0.3: kswsuspd starting
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 164k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xdeb31000, IRQ 9
usb-ohci.c: usb-00:14.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
usb-ohci.c: USB OHCI at membase 0xdeb33000, IRQ 5
usb-ohci.c: usb-00:14.1, NEC Corporation USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
ehci_hcd 00:14.2: NEC Corporation USB 2.0
ehci_hcd 00:14.2: irq 10, pci mem deb3b400
usb.c: new USB bus registered, assigned bus number 3
ehci_hcd 00:14.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 5 ports detected
usbdevfs: remount parameter error
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xdeb5b000, 00:0b:5d:08:5b:96, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: Battery Slot [CMB1] (battery present)
ACPI: Battery Slot [CMB2] (battery absent)
ACPI: AC Adapter [AC] (on-line)
acpi_processor-0899 [35] acpi_processor_get_per: Unsupported address space [127] (control_register)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
inserting floppy driver for 2.4.22-5mdkcustom
floppy0: no floppy controllers found
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Linux Kernel Card Services Kernel Version
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0898, PCI irq5
Socket status: 30000006
Yenta IRQ list 0898, PCI irq10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 18:19:27 Sep  5 2003
trident: ALi Audio Accelerator found at IO 0x1400, IRQ 9
ac97_codec: AC97 Audio codec, id: 0x8384:0x7666 (SigmaTel STAC9750T)
ac97_codec: AC97 Audio codec, id: 0x8384:0x7666 (SigmaTel STAC9750T)
gameport0: ALi Corporation M5451 PCI AC-Link Controller Audio Device at pci00:04.0 speed 2982 kHz
SCSI subsystem driver Revision: 1.00
NET4: Linux IPX 0.47 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
NET4: AppleTalk 0.18a for Linux NET4.0
sock_release: fasync list not empty!
sock_release: fasync list not empty!
i8253 count too high! resetting..



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
