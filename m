From: <gava-7azNGskkaze/k5lE4H/icg@public.gmane.org>
Subject: ACPI, Acer Aspire 1700 series and Kernel 2.6
Date: Thu, 5 Feb 2004 12:20:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <004901c3ebda$2da45c50$feb55452@KXPP>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi List,
i'm having trouble with acpi support on my laptop Acer Aspire 1705SCi with
kernel 2.6.2-rc2 ..
(i applied the patch given in
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.2/acpi-20040116-2.6.2.diff.bz2)

a stange think is that i cannot work without it, cause ACPI permit touchpad
to be recognize and keyborad to work properly

the problem are :
* thermal module can't be loaded
  if thermal module is started automatically get a system shutdown cause a
255c CPU themp was retreived.
  (probably invalid dsdt data)
* 2 error scenarios : after a while process events/0 start and get 30 / 50 %
of CPU usage making system really instable.
                      fan start and System oops (freeze).

i tried also dsdt for Aspire 1703SC found on dsdt repository, that solved
all the error messages, but the problems previous explained are still there

what i understand, is that temperature is not readed correctly by thermal..
cause it reports 255 C before shutting down..
how can i modify my dsdt to make it readed correctly ?


thank's for any help or suggestion.
Regards
  Kolja

  P.S. : attached below kernel config and dmesg

--------------------
-- Kernel :config --
--------------------
#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_RELAXED_AML=y
CONFIG_ACPI_INITRD=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

-----------
-- dmesg --
-----------

Linux version 2.6.2-rc2 (root-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org) (gcc version 2.95.3
20010315 (release)) #10 Tue Feb 3 17:16:09 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bdf0000 (usable)
 BIOS-e820: 000000001bdf0000 - 000000001bdfb000 (ACPI data)
 BIOS-e820: 000000001bdfb000 - 000000001be00000 (ACPI NVS)
 BIOS-e820: 000000001be00000 - 000000001c000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
445MB LOWMEM available.
On node 0 totalpages: 114160
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110064 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6eb0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1bdf67ec
ACPI: FADT (v001 SiS    M650     0x06040000 PTL  0x00000001) @ 0x1bdfaf14
ACPI: MADT (v001 PTLTD    APIC   0x06040000  LTP 0x00000000) @ 0x1bdfaf88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1bdfafd8
ACPI: DSDT (v001 PTLTD      650M 0x06040000 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux ro BOOT_FILE=/boot/vmlinuz-2.6.2
root=/dev/hdc2 video=sisfb:mode:1024x768x16,mem:12288,rate:75
psmouse_resetafter=1
sisfb: Options mode:1024x768x16,mem:12288,rate:75
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 3054.179 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 448232k/456640k available (1609k kernel code, 7640k reserved, 832k
data, 224k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6045.69 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
ACPI: Looking for DSDT in initrd ... not found!
Freeing initrd memory: 218k freed
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9c6, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-0352: *** Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
search_node c14c4640 start_node c14c4640 return_node 00000000
    ACPI-1120: *** Error: [NULL NAME], AE_NOT_FOUND
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKA._CRS] (Node c14c9220), AE_TYPE
ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3)
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKC._CRS] (Node c14c9e20), AE_TYPE
ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKD._CRS] (Node c14c9d20), AE_TYPE
ACPI: PCI Interrupt Link [LNKD] (IRQs 7 10)
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKE._CRS] (Node c14c9c20), AE_TYPE
ACPI: PCI Interrupt Link [LNKE] (IRQs 7 10)
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKF._CRS] (Node c14c9b20), AE_TYPE
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 10)
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKG._CRS] (Node c14c9a20), AE_TYPE
ACPI: PCI Interrupt Link [LNKG] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs 7 10)
ACPI: Embedded Controller [EC0] (gpe 25)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6ee0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb303, dseg 0x400
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x8000-0x80fe has been reserved
pnp: 00:0b: ioport range 0x80ff-0x80ff has been reserved
pnp: 00:0b: ioport range 0x8100-0x811f has been reserved
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: match found with the PnP device '00:0d' and the driver 'system'
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKB._CRS] (Node c14c9f20), AE_TYPE
_CRS returns NULL! Using IRQ 3 fordevice (PCI Interrupt Link [LNKB]).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
ACPI: No IRQ known for interrupt pin A of device 0000:00:02.5 - using IRQ
255
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKC._CRS] (Node c14c9e20), AE_TYPE
_CRS returns NULL! Using IRQ 5 fordevice (PCI Interrupt Link [LNKC]).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKE._CRS] (Node c14c9c20), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKE]).
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKF._CRS] (Node c14c9b20), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKF]).
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKG._CRS] (Node c14c9a20), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKG]).
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKH._CRS] (Node c14c7920), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKH]).
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKD._CRS] (Node c14c9d20), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKD]).
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect
[\_SB_.PCI0.LPCB.LNKA._CRS] (Node c14c9220), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKA]).
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
PCI: Cannot allocate resource region 4 of device 0000:00:02.1
sisfb: Video ROM found and mapped to c00c0000
sisfb: Framebuffer at 0xe8000000, mapped to 0xdc80e000, size 65536k
sisfb: MMIO at 0xe4100000, mapped to 0xe080f000, size 128k
sisfb: Memory heap starting at 12288K
sisfb: Using MMIO queue mode
sisfb: Detected SiS302LV video bridge
sisfb: Detected LCD PanelDelayCompensation 53
sisfb: Bridge uses LCDA for low resolution and text modes
sisfb: Default mode is 1024x768x16 (75Hz)
sisfb: Initial vbflags 0x8000012
sisfb: Added MTRRs
sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
sisfb: Installed SISFB_GET_VBRSTATUS ioctl (80046ef9)
sisfb: 2D acceleration is enabled, scrolling mode ypan
fb0: SIS 65x/M65x/66xFX/M66xFX/74x VGA frame buffer device, Version 1.6.20
sisfb: (C) 2001-2003 Thomas Winischhofer. All rights reserved.
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 378M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-sis: probe of 0000:00:00.0 failed with error -22
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: No IRQ known for interrupt pin A of device 0000:00:02.5 - using IRQ
255
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ST3120023A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdc: hdc1 hdc2 hdc3
ide-floppy driver 0.99.newide
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio3
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 252): journal_recover: JBD: recovery, exit status 0,
recovered transactions 436614 to 436642
(fs/jbd/recovery.c, 254): journal_recover: JBD: Replayed 413 and revoked 0/0
blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hdc2: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 198457
EXT3-fs: hdc2: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 224k freed
ACPI: Processor [CPU0] (supports C1)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [ACAD] (on-line)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: irq 10, pci mem e0856000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: irq 10, pci mem e085d000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: irq 10, pci mem e085f000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Enabling device 0000:00:03.3 (0000 -> 0002)
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 10, pci mem e0861000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
hub 2-0:1.0: connect-debounce failed, port 2 disabled
hub 2-0:1.0: new USB device on port 2, assigned address 2
EXT3 FS on hdc2, internal journal
Adding 923728k swap on /dev/hdc3.  Priority:-1 extents:1
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)
intel8x0: clocking to 48000
request_module: failed /sbin/modprobe -- snd-card-1. error = 256
NTFS driver 2.1.6 [Flags: R/O MODULE].
NTFS volume version 3.1.
ohci1394: $Rev: 1097 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
PCI: Enabling device 0000:00:02.3 (0000 -> 0002)
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[3]  MMIO=[e4000000-e40007ff]
Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000a4e0e]




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
