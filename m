From: =?iso-8859-1?q?Jo=E3o_Cardoso?= <jcard-A1Gx7Te15Zc@public.gmane.org>
Subject: ASUS M3N standby resume regression in 2.6.x -- works under 2.4.x
Date: Tue, 11 Jan 2005 16:52:27 +0000
Message-ID: <200501111652.28556.jcard@fe.up.pt>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MRA5Bx1Vuwn5iT0"
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

--Boundary-00=_MRA5Bx1Vuwn5iT0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,

In my ASUS M3N laptop, Centrino based, standby (S1) works fine with 
linux 2.4.x, x>~24, but fails for all 2.6.x series.

In runlevel 1, even with all modules unloaded (but the filesystem 
modules and usbcore, I can't remove it), the system enters standby upon 
executing
   echo 1 > /proc/acpi/sleep
but after pressing the power button to resume the PC hangs.
Standby works fine under linux-2.4.x, even under runlevel 5.

Upon resume, the system becomes blocked, and nothing is written to the 
logs, so I can't give more details other that the ones written to the 
screen:

Stopping tasks:===|
hwsleep_0315[28215] acpi_enter_sleep_state: Entering sleep state [S1]
Back to C!
ACPI: pci interrupt 0000:00:02:0[A] -> GSI 11 (level, low) -> IRQ 11

The hwsleep_0315[xxx] message can vary, depending on the modules loaded, 
the xxx can be 28 or 22.
With all usb modules loaded the message says
   PCI: setting latency time of device yyyy to 64
where yyy corresponds to the threee 
   USB Controller: Intel Corp. 82801DB USB

So, somehow the system starts resuming (the LCD turns on after pressing 
the power button to resume), but hangs after that. Under 2.4.x any 
button starts standby resume, but under 2.6.x only the power button is 
responsible; curiously, under 2.4.x the power button shouldn't be used 
to resume, because it generates two acpi events.

What else can I do to help you helping me? :)

I attach the boot messages and lspci output.The kernel config file, and 
the asl can be found at 

http://www.fe.up.pt/~jcard/acpi/2.6.10.config
http://www.fe.up.pt/~jcard/acpi/M3N-BIOS-0203A.asl

To further complicate matters, ASUS has released a new BIOS, 0206A, but 
under that BIOS standby does not work even under 2.4.x. That BIOS asl 
can be found at http://www.fe.up.pt/~jcard/acpi/M3N-BIOS-0206A.asl

Thanks,
Joao

--Boundary-00=_MRA5Bx1Vuwn5iT0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.10.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.10.dmesg"

Linux version 2.6.10 (root@flash) (gcc version 3.3.3 (SuSE Linux)) #1 Wed Jan 5 04:05:29 WET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f740000 (usable)
 BIOS-e820: 000000001f740000 - 000000001f750000 (ACPI data)
 BIOS-e820: 000000001f750000 - 000000001f800000 (ACPI NVS)
503MB LOWMEM available.
On node 0 totalpages: 128832
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124736 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4b70
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000314 MSFT 0x00000097) @ 0x1f740000
ACPI: FADT (v002 A M I  OEMFACP  0x05000314 MSFT 0x00000097) @ 0x1f740200
ACPI: OEMB (v001 A M I  OEMBIOS  0x05000314 MSFT 0x00000097) @ 0x1f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Kernel command line: root=/dev/hda9 vga=0x317 splash=silent resume=/dev/hda7
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1600.102 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 505708k/515328k available (2211k kernel code, 9096k reserved, 681k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3178.49 BogoMIPS (lpj=1589248)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 1064 Objects with 55 Devices 332 Methods 29 Regions
ACPI Namespace successfully loaded at root c043ea20
ACPI: setting ELCR to 0200 (from 0830)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1169k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 2 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...................................................................................................................................
Initialized 28/29 Regions 30/30 Fields 42/42 Buffers 31/31 Packages (1073 nodes)
Executing all Device _STA and_INI methods:...........................................................
59 Devices found containing: 59 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs *4 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6)
ACPI: PCI Interrupt Link [LNKE] (IRQs 6 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *4 6 12)
ACPI: Power Resource [GFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
pnp: 00:06: ioport range 0x480-0x48f has been reserved
pnp: 00:06: ioport range 0x4c0-0x4cf has been reserved
audit: initializing netlink socket (disabled)
audit(1105445939.183:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: framebuffer at 0xf0000000, mapped to 0xe0080000, using 3072k, total 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 4 (level, low) -> IRQ 4
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHS2060AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
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
hda: 117210240 sectors (60011 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
input: PC Speaker
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
P0P1 LAN0 CBS0 P394 MPCI MODM USB1 USB2 USB3 EHCI SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda9: found reiserfs format "3.6" with standard journal
ReiserFS: hda9: using ordered data mode
ReiserFS: hda9: journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda9: checking transaction log (hda9)
ReiserFS: hda9: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 212k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
ReiserFS: hda8: using ordered data mode
ReiserFS: hda8: journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda8: checking transaction log (hda8)
ReiserFS: hda8: Using r5 hash to sort names
subfs 0.9
Adding 819272k swap on /dev/hda7.  Priority:42 extents:1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.0.1
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:01:04.0[A] -> GSI 4 (level, low) -> IRQ 4
ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth1: e100_probe: addr 0xff7ff000, irq 11, MAC addr 00:0C:6E:59:7D:D0
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 17
hw_random: RNG not detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 431M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0xd480
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 0xd800
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 4, io base 0xd880
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 4
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 4 (level, low) -> IRQ 4
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 4, pci mem 0xffa7fc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 1-2: new low speed USB device using uhci_hcd and address 2
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:01:05.1[B] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[ff7fe800-ff7fefff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800030aac04]
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0399540(lo)
IPv6 over IPv4 tunneling driver
snd_intel8x0: Unknown parameter `joystick'
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Processor [CPU1] (supports C1 C2 C3)
ACPI: Processor [CPU1] (supports 8 throttling states)
intel8x0_measure_ac97_clock: measured 296453 usecs
intel8x0: clocking to 48000
ACPI: Thermal Zone [THRM] (49 C)
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
eth1: no IPv6 routers present
Non-volatile memory driver v1.2
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
st: Version 20041025, fixed bufsize 32768, s/g segs 256
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
mtrr: 0xf0000000,0x8000000 overlaps existing 0xf0000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 0: 
mtrr: 0xf0000000,0x8000000 overlaps existing 0xf0000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 1: 
mtrr: base(0xf0020000) is not aligned on a size(0x41a000) boundary
mtrr: 0xf0000000,0x8000000 overlaps existing 0xf0000000,0x400000
NET: Registered protocol family 4
NET: Registered protocol family 3
NET: Registered protocol family 5
     osl-0957 [879] os_wait_semaphore     : Failed to acquire semaphore[df73ef00|1|0], AE_TIME

--Boundary-00=_MRA5Bx1Vuwn5iT0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.10.lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.10.lspci"

0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1741
	Flags: bus master, fast devsel, latency 0
	Memory at <unassigned> (32-bit, prefetchable)
	Capabilities: [40] #09 [a105]

0000:00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 175a
	Flags: bus master, fast devsel, latency 0

0000:00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 175b
	Flags: bus master, fast devsel, latency 0

0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1742
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at f0000000 (32-bit, prefetchable)
	Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at dc00 [size=8]
	Capabilities: [d0] Power Management version 1

0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1742
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable)
	Memory at ff980000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1

0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1748
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at d480 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1748
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at d800 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1748
	Flags: bus master, medium devsel, latency 0, IRQ 4
	I/O ports at d880 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1749
	Flags: bus master, medium devsel, latency 0, IRQ 4
	Memory at ffa7fc00 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff700000-ff7fffff
	Prefetchable memory behind bridge: dea00000-deafffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 1748
	Flags: bus master, medium devsel, latency 0, IRQ 4
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=16]
	Memory at 1f800000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 1743
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at e000
	I/O ports at e100 [size=64]
	Memory at 1f800400 (32-bit, non-prefetchable) [size=512]
	Memory at 1f800600 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Asustek Computer, Inc.: Unknown device 1746
	Flags: medium devsel, IRQ 11
	I/O ports at e200
	I/O ports at e300 [size=128]
	Capabilities: [50] Power Management version 2

0000:01:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Flags: bus master, medium devsel, latency 64, IRQ 4
	Memory at ff7fd000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

0000:01:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev b8)
	Subsystem: Asustek Computer, Inc.: Unknown device 1744
	Flags: bus master, medium devsel, latency 32
	Memory at 1f801000 (32-bit, non-prefetchable)
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

0000:01:05.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C551 IEEE 1394 Controller (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1747
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at ff7fe800 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

0000:01:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VM (MOB) Ethernet Controller (rev 83)
	Subsystem: Asustek Computer, Inc.: Unknown device 1745
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at ff7ff000 (32-bit, non-prefetchable)
	I/O ports at cc00 [size=64]
	Capabilities: [dc] Power Management version 2


--Boundary-00=_MRA5Bx1Vuwn5iT0--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
