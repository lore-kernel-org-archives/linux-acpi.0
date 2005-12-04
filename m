From: Olaf Conradi <oohlaf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ACPI Thermal Zones and unwanted reset of Trip Points
Date: Sun, 4 Dec 2005 22:40:25 +0100
Message-ID: <1c687cba0512041340r5641603ew8a30a10e480720bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_22344_11166728.1133732425355"
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

------=_Part_22344_11166728.1133732425355
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I'm running Debian Unstable on my laptop and have a question about
trip points in ACPI thermal zones.

My laptop gets too hot very quickly, for example when I compile a
kernel, or in font generation during installation of a latex font.
This causes the laptop to shutdown.

On my laptop (Asus L8400K) the trip points are:

# cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           80 C
passive:                 70 C: tc1=3D1 tc2=3D4 tsp=3D300 devices=3D0xc127cb=
60
active[0]:               60 C: devices=3D0xc127b800

When I set them to the following I get much better results and it
doesn't get overheated much.

# echo -n "80:0:60:55:0" > /proc/acpi/thermal_zone/THRM/trip_points
# cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           80 C
passive:                 60 C: tc1=3D1 tc2=3D4 tsp=3D300 devices=3D0xc127cb=
60
active[0]:               55 C: devices=3D0xc127b800

But, for some reason, the trip points get reset every now and then
(usually within 30 mintes or so, don't know the exact interval).

Does anyone know what causes the trip point setting to be reset?

I'm using debian kernel 2.6.14 from unstable. I attached the dmesg,
dmidecode, acpidump, lspci and interrupts output.

Thanks,
Olaf

------=_Part_22344_11166728.1133732425355
Content-Type: text/plain; name=dmesg.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.14-2-686 (Debian 2.6.14-4) (fs-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org) (gcc version 4.0.3 20051111 (prerelease) (Debian 4.0.2-4)) #1 Sat Nov 26 13:10:11 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e9400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fffe9400 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7050
ACPI: RSDT (v001 PTLTD    RSDT   0x06040001  LTP 0x00000000) @ 0x0fffc5a1
ACPI: FADT (v001 ASUS   L8400B   0x06040001 PTL  0x000f4240) @ 0x0ffffb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040001  LTP 0x00000001) @ 0x0ffffbd9
ACPI: DSDT (v001  Intel   Trajan 0x06040001 MSFT 0x01000004) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 20000000 (gap: 10000000:effe9400)
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro vga=791 acpi=on apm=off
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1002.590 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255156k/262080k available (1875k kernel code, 6320k reserved, 536k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2005.38 BogoMIPS (lpj=1002691)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
softlockup thread 0 started up.
Freeing initrd memory: 987k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9a6, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 6 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 9) *0, disabled.
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 8000-803f claimed by PIIX4 ACPI
PCI quirk: region 2180-219f claimed by PIIX4 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:01: ioport range 0x4d0-0x4d1 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f0000000-f7ffffff
  PREFETCH window: 28000000-280fffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0a.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 24000000-25ffffff
  MEM window: 26000000-27ffffff
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:0a.1 to 64
Simple Boot Flag at 0x37 set to 0x1
audit: initializing netlink socket (disabled)
audit(1133725690.696:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
vesafb: framebuffer at 0xf0000000, mapped to 0xd0880000, using 3072k, total 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:895a
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
ACPI wakeup devices: 
 LID USB0 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 180k freed
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:pio, hdb:DMA
Probing IDE interface ide0...
hda: FUJITSU MHM2200AT, ATA DISK drive
Synaptics Touchpad, model: 1, fw: 4.6, id: 0x135ea1, caps: 0x804713/0x0
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
hdb: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 > hda3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
input: PC Speaker
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
hdb: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
8139too Fast Ethernet driver 0.9.27
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
PCI: Enabling device 0000:00:07.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:07.2: UHCI Host Controller
eth0: RealTek RTL8139 at 0xf000, 00:e0:18:2b:e2:fc, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 9, io base 0x0000fcc0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:00:0a.0 [1043:1044]
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
Yenta: ISA IRQ mask 0x0838, PCI irq 9
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:00:0a.1 [1043:1044]
usb 1-2: new low speed USB device using uhci_hcd and address 2
Yenta: ISA IRQ mask 0x0838, PCI irq 9
Socket status: 30000006
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:07.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
EXT3 FS on hda5, internal journal
SCSI subsystem initialized
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 266232k swap on /dev/mapper/aspen-swap.  Priority:-1 extents:1 across:266232k
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x100-0x4ff: excluding 0x200-0x207 0x398-0x39f
cs: IO port probe 0x100-0x4ff: excluding 0x200-0x207 0x398-0x39f
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 4 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: Thermal Zone [THRM] (49 C)
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0328b40(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
mtrr: 0xf0000000,0x1000000 overlaps existing 0xf0000000,0x800000
mtrr: 0xf4000000,0x4000000 overlaps existing 0xf6000000,0x1000000
mtrr: 0xf0000000,0x1000000 overlaps existing 0xf0000000,0x800000
mtrr: base(0xf2000000) is not aligned on a size(0x5000000) boundary
[drm] Initialized savage 2.4.1 20050313 on minor 0: 
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 0x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 0x mode

------=_Part_22344_11166728.1133732425355
Content-Type: text/plain; name=dmi.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmi.txt"

# dmidecode 2.7
SMBIOS 2.1 present.
27 structures occupying 910 bytes.
Table at 0x000F0240.

Handle 0x0000, DMI type 0, 19 bytes.
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: 0200
	Release Date: 09/05/01
	Address: 0xE9700
	Runtime Size: 92416 bytes
	ROM Size: 256 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)

Handle 0x0001, DMI type 1, 25 bytes.
System Information
	Manufacturer: ASUSTeK Computer Inc.
	Product Name: L8400K series Notebook PC
	Version: CPU Module, VGA Board
	Serial Number: 000000000
	UUID: Not Settable
	Wake-up Type: Unknown

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer: ASUSTeK Computer Inc.
	Product Name: L8400K Main Board
	Version: Not Specified
	Serial Number: NS170000000000

Handle 0x0003, DMI type 3, 13 bytes.
Chassis Information
	Manufacturer: ASUSTeK Computer Inc.
	Type: Notebook
	Lock: Not Present
	Version: T5
	Serial Number: None
	Asset Tag: No Asset Tag
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown

Handle 0x0004, DMI type 4, 32 bytes.
Processor Information
	Socket Designation: PGA 370
	Type: Central Processor
	Family: Pentium III
	Manufacturer: Intel
	ID: 8A 06 00 00 FF F9 87 03
	Signature: Type 0, Family 6, Model 8, Stepping 10
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		PSN (Processor serial number present and enabled)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
	Version: Pentium(R) III
	Voltage: 1.8 V
	External Clock: 100 MHz
	Max Speed: 1000 MHz
	Current Speed: 1000 MHz
	Status: Populated, Enabled
	Upgrade: Daughter Board
	L1 Cache Handle: No L1 Cache
	L2 Cache Handle: 0x0009
	L3 Cache Handle: No L3 Cache

Handle 0x0005, DMI type 5, 20 bytes.
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 128 MB
	Maximum Total Memory Size: 256 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 2
		0x0007
		0x0008
	Enabled Error Correcting Capabilities:
		Unknown

Handle 0x0006, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: On Board
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: Other
	Installed Size: 128 MB (Double-bank Connection)
	Enabled Size: 128 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 2 3
	Current Speed: Unknown
	Type: Other DIMM
	Installed Size: 128 MB (Double-bank Connection)
	Enabled Size: 128 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0008, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0009, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 256 KB
	Maximum Size: 256 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000A, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J1
	Internal Connector Type: None
	External Reference Designator: USB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J1
	Internal Connector Type: None
	External Reference Designator: Keyboard/Mouse
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J4
	Internal Connector Type: None
	External Reference Designator: Docking Connector
	External Connector Type: Other
	Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J6
	Internal Connector Type: None
	External Reference Designator: TV
	External Connector Type: Mini DIN
	Port Type: Video Port

Handle 0x000E, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J3
	Internal Connector Type: None
	External Reference Designator: Monitor
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x000F, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J2
	Internal Connector Type: None
	External Reference Designator: Joystick/Midi
	External Connector Type: DB-15 female
	Port Type: Joystick Port

Handle 0x0010, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J5
	Internal Connector Type: None
	External Reference Designator: Printer Port
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0011, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J7
	Internal Connector Type: None
	External Reference Designator: Serial Port
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0012, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J8
	Internal Connector Type: None
	External Reference Designator: Power Jack
	External Connector Type: Other
	Port Type: Other

Handle 0x0013, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: MIC
	Internal Connector Type: None
	External Reference Designator: Microphone
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0014, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: LINE IN
	Internal Connector Type: None
	External Reference Designator: Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0015, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: SPK
	Internal Connector Type: None
	External Reference Designator: Speaker
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0016, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: U18
	Internal Connector Type: None
	External Reference Designator: IR
	External Connector Type: Infrared
	Port Type: Other

Handle 0x0017, DMI type 9, 13 bytes.
System Slot Information
	Designation: PC Card Upper Socket
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Unknown
	Length: Long
	ID: Adapter 1, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported

Handle 0x0018, DMI type 9, 13 bytes.
System Slot Information
	Designation: PC Card Lower Socket
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Unknown
	Length: Long
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Zoom Video is supported

Handle 0x0019, DMI type 10, 8 bytes.
On Board Device 1 Information
	Type: Video
	Status: Disabled
	Description: S3 Savage MX
On Board Device 2 Information
	Type: Sound
	Status: Disabled
	Description: ESS Allegro-1

Handle 0x001A, DMI type 11, 5 bytes.
OEM Strings
	String 1: Intel 440BX Notebook PC


------=_Part_22344_11166728.1133732425355
Content-Type: video/mpeg; name=acpi.dat
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpi.dat"

DSDT @ 0xfffc5cd
  0000: 44 53 44 54 98 35 00 00 01 1e 49 6e 74 65 6c 00  DSDT.5....Intel.
  0010: 54 72 61 6a 61 6e 00 00 01 00 04 06 4d 53 46 54  Trajan......MSFT
  0020: 04 00 00 01 5b 80 47 50 4f 5f 01 0b 34 80 0a 04  ....[.GPO_..4...
  0030: 5b 81 1a 47 50 4f 5f 01 47 50 4f 30 08 47 50 4f  [..GPO_.GPO0.GPO
  0040: 31 08 47 50 4f 32 08 47 50 4f 33 08 08 50 50 33  1.GPO2.GPO3..PP3
  0050: 34 0a 00 08 50 50 33 35 0a 00 08 50 50 33 36 0a  4...PP35...PP36.
  0060: 00 08 50 50 33 37 0a 00 5b 80 47 4c 42 45 01 0b  ..PP37..[.GLBE..
  0070: 21 80 0a 01 5b 81 1a 47 4c 42 45 01 47 53 42 45  !...[..GLBE.GSBE
  0080: 01 52 45 56 45 01 45 53 4d 49 01 49 52 51 45 01  .REVE.ESMI.IRQE.
  0090: 5b 80 47 4c 42 30 01 0b 28 80 0a 01 5b 81 15 47  [.GLB0..(...[..G
  00a0: 4c 42 30 01 53 4d 49 45 01 42 49 4f 53 01 54 52  LB0.SMIE.BIOS.TR
  00b0: 4d 50 01 5b 80 47 4c 42 31 01 0b 2b 80 0a 01 5b  MP.[.GLB1..+...[
  00c0: 81 10 47 4c 42 31 01 53 4d 46 45 01 4c 49 44 50  ..GLB1.SMFE.LIDP
  00d0: 01 5b 80 47 50 45 4e 01 0b 0f 80 0a 01 5b 81 1a  .[.GPEN......[..
  00e0: 47 50 45 4e 01 55 53 42 45 01 47 50 49 45 01 52  GPEN.USBE.GPIE.R
  00f0: 49 45 5f 01 4c 49 44 45 01 5b 80 44 42 55 47 01  IE_.LIDE.[.DBUG.
  0100: 0a 80 0a 01 5b 81 0b 44 42 55 47 01 50 54 38 30  ....[..DBUG.PT80
  0110: 08 5b 80 50 4d 33 30 01 0b 30 80 0a 04 5b 81 47  .[.PM30..0...[.G
  0120: 07 50 4d 33 30 01 47 49 30 30 01 47 49 30 31 01  .PM30.GI00.GI01.
  0130: 47 49 30 32 01 47 49 30 33 01 47 49 30 34 01 47  GI02.GI03.GI04.G
  0140: 49 30 35 01 47 49 30 36 01 47 49 30 37 01 47 49  I05.GI06.GI07.GI
  0150: 30 38 01 47 49 30 39 01 47 49 31 30 01 47 49 31  08.GI09.GI10.GI1
  0160: 31 01 47 49 31 32 01 47 49 31 33 01 47 49 31 34  1.GI12.GI13.GI14
  0170: 01 47 49 31 35 01 47 49 31 36 01 47 49 31 37 01  .GI15.GI16.GI17.
  0180: 47 49 31 38 01 47 49 31 39 01 47 49 32 30 01 47  GI18.GI19.GI20.G
  0190: 49 32 31 01 00 0a 5b 80 50 4d 33 34 01 0b 34 80  I21...[.PM34..4.
  01a0: 0a 01 5b 81 2e 50 4d 33 34 01 47 4f 30 30 01 47  ..[..PM34.GO00.G
  01b0: 4f 30 31 01 47 4f 30 32 01 47 4f 30 33 01 47 4f  O01.GO02.GO03.GO
  01c0: 30 34 01 47 4f 30 35 01 47 4f 30 36 01 47 4f 30  04.GO05.GO06.GO0
  01d0: 37 01 5b 80 50 4d 33 35 01 0b 35 80 0a 01 5b 81  7.[.PM35..5...[.
  01e0: 2e 50 4d 33 35 01 47 4f 30 38 01 47 4f 30 39 01  .PM35.GO08.GO09.
  01f0: 47 4f 31 30 01 47 4f 31 31 01 47 4f 31 32 01 47  GO10.GO11.GO12.G
  0200: 4f 31 33 01 47 4f 31 34 01 47 4f 31 35 01 5b 80  O13.GO14.GO15.[.
  0210: 50 4d 33 36 01 0b 36 80 0a 01 5b 81 2e 50 4d 33  PM36..6...[..PM3
  0220: 36 01 47 4f 31 36 01 47 4f 31 37 01 47 4f 31 38  6.GO16.GO17.GO18
  0230: 01 47 4f 31 39 01 47 4f 32 30 01 47 4f 32 31 01  .GO19.GO20.GO21.
  0240: 47 4f 32 32 01 47 4f 32 33 01 5b 80 50 4d 33 37  GO22.GO23.[.PM37
  0250: 01 0b 37 80 0a 01 5b 81 2b 50 4d 33 37 01 47 4f  ..7...[.+PM37.GO
  0260: 32 34 01 47 4f 32 35 01 47 4f 32 36 01 47 4f 32  24.GO25.GO26.GO2
  0270: 37 01 47 4f 32 38 01 47 4f 32 39 01 47 4f 33 30  7.GO28.GO29.GO30
  0280: 01 00 01 5b 80 53 4d 30 30 01 0b 80 21 0a 01 5b  ...[.SM00...!..[
  0290: 01 4d 54 58 53 04 5b 81 0b 53 4d 30 30 01 48 53  .MTXS.[..SM00.HS
  02a0: 54 53 08 5b 80 53 4d 30 32 01 0b 82 21 0a 01 5b  TS.[.SM02...!..[
  02b0: 81 0b 53 4d 30 32 01 43 54 4c 52 08 5b 80 53 4d  ..SM02.CTLR.[.SM
  02c0: 30 33 01 0b 83 21 0a 01 5b 81 0b 53 4d 30 33 01  03...!..[..SM03.
  02d0: 43 4d 44 52 08 5b 80 53 4d 30 34 01 0b 84 21 0a  CMDR.[.SM04...!.
  02e0: 01 5b 81 0b 53 4d 30 34 01 41 44 44 52 08 5b 80  .[..SM04.ADDR.[.
  02f0: 53 4d 30 35 01 0b 85 21 0a 01 5b 81 0b 53 4d 30  SM05...!..[..SM0
  0300: 35 01 44 41 54 30 08 5b 80 53 4d 30 36 01 0b 86  5.DAT0.[.SM06...
  0310: 21 0a 01 5b 81 0b 53 4d 30 36 01 44 41 54 31 08  !..[..SM06.DAT1.
  0320: 08 54 4d 41 44 0a 9c 08 54 53 41 44 0a 90 08 54  .TMAD...TSAD...T
  0330: 52 4e 47 0a 00 08 54 50 31 48 0b 04 0d 08 41 43  RNG...TP1H....AC
  0340: 54 54 0a 3c 08 54 50 31 4c 0b 28 0c 08 54 50 32  TT.<.TP1L.(..TP2
  0350: 48 0b 68 0d 08 50 41 53 54 0a 46 08 54 50 32 4c  H.h..PAST.F.TP2L
  0360: 0b 64 0c 08 54 50 43 5f 0b cc 0d 08 41 43 54 44  .d..TPC_....ACTD
  0370: 00 08 44 55 4d 30 00 08 42 51 45 52 00 08 42 51  ..DUM0..BQER..BQ
  0380: 45 31 00 08 54 56 41 52 11 08 0a 05 00 20 23 20  E1..TVAR..... # 
  0390: 22 8c 54 56 41 52 0a 00 50 4c 43 59 8b 54 56 41  ".TVAR..PLCY.TVA
  03a0: 52 0a 01 43 54 4f 53 8b 54 56 41 52 0a 03 43 54  R..CTOS.TVAR..CT
  03b0: 48 59 08 54 42 55 46 11 07 0a 04 00 00 00 00 8c  HY.TBUF.........
  03c0: 54 42 55 46 0a 00 44 42 30 30 8c 54 42 55 46 0a  TBUF..DB00.TBUF.
  03d0: 01 44 42 30 31 8b 54 42 55 46 0a 00 44 57 30 30  .DB01.TBUF..DW00
  03e0: 8b 54 42 55 46 0a 02 44 57 30 31 8a 54 42 55 46  .TBUF..DW01.TBUF
  03f0: 0a 00 44 41 54 44 10 19 5c 5f 50 52 5f 5b 83 11  ..DATD..\_PR_[..
  0400: 5c 2e 5f 50 52 5f 43 50 55 30 01 10 80 00 00 06  \._PR_CPU0......
  0410: 08 5f 53 30 5f 12 0a 04 0a 05 0a 05 0a 00 0a 00  ._S0_...........
  0420: 08 5c 5f 53 31 5f 12 0a 04 0a 04 0a 04 0a 00 0a  .\_S1_..........
  0430: 00 08 5c 5f 53 33 5f 12 0a 04 0a 01 0a 01 0a 00  ..\_S3_.........
  0440: 0a 00 08 5c 5f 53 34 5f 12 0a 04 0a 00 0a 00 0a  ...\_S4_........
  0450: 00 0a 00 08 5c 5f 53 35 5f 12 0a 04 0a 00 0a 00  ....\_S5_.......
  0460: 0a 00 0a 00 08 42 55 46 32 11 03 0a 81 08 42 55  .....BUF2.....BU
  0470: 46 33 11 03 0a 41 14 40 0a 57 36 37 52 03 5b 23  F3...A.@.W67R.[#
  0480: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45  \/._SB_PCI0ISA_E
  0490: 43 30 5f 4d 54 58 45 ff ff 70 6a 5c 2f 05 5f 53  C0_MTXE..pj\/._S
  04a0: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44  B_PCI0ISA_EC0_CD
  04b0: 41 33 70 69 5c 2f 05 5f 53 42 5f 50 43 49 30 49  A3pi\/._SB_PCI0I
  04c0: 53 41 5f 45 43 30 5f 43 44 41 32 70 68 5c 2f 05  SA_EC0_CDA2ph\/.
  04d0: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  04e0: 43 44 41 31 70 0a bb 5c 2f 05 5f 53 42 5f 50 43  CDA1p..\/._SB_PC
  04f0: 49 30 49 53 41 5f 45 43 30 5f 43 43 4d 44 5b 27  I0ISA_EC0_CCMD['
  0500: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45  \/._SB_PCI0ISA_E
  0510: 43 30 5f 4d 54 58 45 14 4b 4a 5c 5f 50 54 53 01  C0_MTXE.KJ\_PTS.
  0520: 70 68 50 54 38 30 70 00 60 a2 4d 0a 74 0a 80 60  phPT80p.`.M.t..`
  0530: 00 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  .[#\/._SB_PCI0IS
  0540: 41 5f 45 43 30 5f 4d 54 58 45 ff ff 70 0a 00 5c  A_EC0_MTXE..p..\
  0550: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  0560: 30 5f 43 44 41 33 70 72 60 0a 80 00 5c 2f 05 5f  0_CDA3pr`...\/._
  0570: 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43  SB_PCI0ISA_EC0_C
  0580: 44 41 32 70 0a ba 5c 2f 05 5f 53 42 5f 50 43 49  DA2p..\/._SB_PCI
  0590: 30 49 53 41 5f 45 43 30 5f 43 43 4d 44 70 5c 2f  0ISA_EC0_CCMDp\/
  05a0: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  05b0: 5f 43 44 41 31 88 42 55 46 32 60 00 5b 27 5c 2f  _CDA1.BUF2`.['\/
  05c0: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  05d0: 5f 4d 54 58 45 75 60 70 00 60 a2 4d 0a 74 0a 40  _MTXEu`p.`.M.t.@
  05e0: 60 00 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49  `.[#\/._SB_PCI0I
  05f0: 53 41 5f 45 43 30 5f 4d 54 58 45 ff ff 70 0a 02  SA_EC0_MTXE..p..
  0600: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45  \/._SB_PCI0ISA_E
  0610: 43 30 5f 43 44 41 33 70 72 60 0a 80 00 5c 2f 05  C0_CDA3pr`...\/.
  0620: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  0630: 43 44 41 32 70 0a ba 5c 2f 05 5f 53 42 5f 50 43  CDA2p..\/._SB_PC
  0640: 49 30 49 53 41 5f 45 43 30 5f 43 43 4d 44 70 5c  I0ISA_EC0_CCMDp\
  0650: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  0660: 30 5f 43 44 41 31 88 42 55 46 33 60 00 5b 27 5c  0_CDA1.BUF3`.['\
  0670: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  0680: 30 5f 4d 54 58 45 75 60 57 36 37 52 0a 9f 0a da  0_MTXEu`W67R....
  0690: 0a 04 57 36 37 52 0a 9f 0a db 0a 04 57 36 37 52  ..W67R......W67R
  06a0: 0a 9f 0a de 0a 04 57 36 37 52 0a 9f 0a df 0a 04  ......W67R......
  06b0: a0 42 21 93 68 0a 03 5b 23 5c 2f 05 5f 53 42 5f  .B!.h..[#\/._SB_
  06c0: 50 43 49 30 49 53 41 5f 45 43 30 5f 4d 54 58 45  PCI0ISA_EC0_MTXE
  06d0: ff ff 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49 30  ..p..\/._SB_PCI0
  06e0: 49 53 41 5f 45 43 30 5f 43 44 41 33 70 0a e9 5c  ISA_EC0_CDA3p..\
  06f0: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  0700: 30 5f 43 44 41 32 70 0a a9 5c 2f 05 5f 53 42 5f  0_CDA2p..\/._SB_
  0710: 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41 31  PCI0ISA_EC0_CDA1
  0720: 70 0a bb 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  p..\/._SB_PCI0IS
  0730: 41 5f 45 43 30 5f 43 43 4d 44 5b 27 5c 2f 05 5f  A_EC0_CCMD['\/._
  0740: 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 4d  SB_PCI0ISA_EC0_M
  0750: 54 58 45 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30  TXE[#\/._SB_PCI0
  0760: 49 53 41 5f 45 43 30 5f 4d 54 58 45 ff ff 70 0a  ISA_EC0_MTXE..p.
  0770: 00 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  0780: 45 43 30 5f 43 44 41 33 70 0a 7d 5c 2f 05 5f 53  EC0_CDA3p.}\/._S
  0790: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44  B_PCI0ISA_EC0_CD
  07a0: 41 32 70 0a 20 5c 2f 05 5f 53 42 5f 50 43 49 30  A2p. \/._SB_PCI0
  07b0: 49 53 41 5f 45 43 30 5f 43 44 41 31 70 0a bb 5c  ISA_EC0_CDA1p..\
  07c0: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  07d0: 30 5f 43 43 4d 44 5b 27 5c 2f 05 5f 53 42 5f 50  0_CCMD['\/._SB_P
  07e0: 43 49 30 49 53 41 5f 45 43 30 5f 4d 54 58 45 5b  CI0ISA_EC0_MTXE[
  07f0: 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  #\/._SB_PCI0ISA_
  0800: 45 43 30 5f 4d 54 58 45 ff ff 70 0a d0 5c 2f 05  EC0_MTXE..p..\/.
  0810: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  0820: 43 44 41 32 70 0a 00 5c 2f 05 5f 53 42 5f 50 43  CDA2p..\/._SB_PC
  0830: 49 30 49 53 41 5f 45 43 30 5f 43 44 41 31 70 0a  I0ISA_EC0_CDA1p.
  0840: da 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  0850: 45 43 30 5f 43 43 4d 44 5b 22 0a 05 5b 27 5c 2f  EC0_CCMD["..['\/
  0860: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  0870: 5f 4d 54 58 45 5b 23 5c 2f 05 5f 53 42 5f 50 43  _MTXE[#\/._SB_PC
  0880: 49 30 49 53 41 5f 45 43 30 5f 4d 54 58 45 ff ff  I0ISA_EC0_MTXE..
  0890: 70 0a cb 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  p..\/._SB_PCI0IS
  08a0: 41 5f 45 43 30 5f 43 43 4d 44 5b 27 5c 2f 05 5f  A_EC0_CCMD['\/._
  08b0: 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 4d  SB_PCI0ISA_EC0_M
  08c0: 54 58 45 70 47 50 4f 30 50 50 33 34 70 47 50 4f  TXEpGPO0PP34pGPO
  08d0: 31 50 50 33 35 70 47 50 4f 32 50 50 33 36 70 47  1PP35pGPO2PP36pG
  08e0: 50 4f 33 50 50 33 37 70 5c 2f 04 5f 53 42 5f 50  PO3PP37p\/._SB_P
  08f0: 43 49 30 49 53 41 5f 50 44 4d 41 5c 2f 04 5f 53  CI0ISA_PDMA\/._S
  0900: 42 5f 50 43 49 30 49 53 41 5f 50 42 39 30 70 5c  B_PCI0ISA_PB90p\
  0910: 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 44 4d  /._SB_PCI0ISA_DM
  0920: 30 33 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41  03\/._SB_PCI0ISA
  0930: 5f 50 42 39 32 70 5c 2f 04 5f 53 42 5f 50 43 49  _PB92p\/._SB_PCI
  0940: 30 49 53 41 5f 44 4d 35 37 5c 2f 04 5f 53 42 5f  0ISA_DM57\/._SB_
  0950: 50 43 49 30 49 53 41 5f 50 42 39 34 70 5c 2f 04  PCI0ISA_PB94p\/.
  0960: 5f 53 42 5f 50 43 49 30 49 53 41 5f 55 52 54 43  _SB_PCI0ISA_URTC
  0970: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50  \/._SB_PCI0ISA_P
  0980: 42 43 42 70 01 5c 2f 04 5f 53 42 5f 50 43 49 30  BCBp.\/._SB_PCI0
  0990: 49 53 41 5f 55 52 54 43 70 0a 5a 5c 2f 04 5f 53  ISA_URTCp.Z\/._S
  09a0: 42 5f 50 43 49 30 49 53 41 5f 42 43 4d 44 70 00  B_PCI0ISA_BCMDp.
  09b0: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 53  \/._SB_PCI0ISA_S
  09c0: 4d 49 43 14 4e 3d 5c 5f 57 41 4b 01 a0 4c 04 93  MIC.N=\_WAK..L..
  09d0: 68 0a 01 70 01 45 53 4d 49 70 01 5c 2f 04 5f 53  h..p.ESMIp.\/._S
  09e0: 42 5f 50 43 49 30 49 53 41 5f 55 52 54 43 70 0a  B_PCI0ISA_URTCp.
  09f0: a6 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  0a00: 42 43 4d 44 70 00 5c 2f 04 5f 53 42 5f 50 43 49  BCMDp.\/._SB_PCI
  0a10: 30 49 53 41 5f 53 4d 49 43 86 5c 2f 04 5f 53 42  0ISA_SMIC.\/._SB
  0a20: 5f 50 43 49 30 49 53 41 5f 43 4f 4d 41 0a 00 86  _PCI0ISA_COMA...
  0a30: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 46  \/._SB_PCI0ISA_F
  0a40: 49 52 5f 0a 00 86 5c 2f 04 5f 53 42 5f 50 43 49  IR_...\/._SB_PCI
  0a50: 30 49 53 41 5f 4c 50 54 5f 0a 00 86 5c 2f 04 5f  0ISA_LPT_...\/._
  0a60: 53 42 5f 50 43 49 30 49 53 41 5f 4c 50 54 42 0a  SB_PCI0ISA_LPTB.
  0a70: 00 86 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41  ..\/._SB_PCI0ISA
  0a80: 5f 45 50 50 5f 0a 00 86 5c 2f 04 5f 53 42 5f 50  _EPP_...\/._SB_P
  0a90: 43 49 30 49 53 41 5f 45 43 50 5f 0a 00 86 5c 2f  CI0ISA_ECP_...\/
  0aa0: 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 46 44 43  ._SB_PCI0ISA_FDC
  0ab0: 5f 0a 00 70 00 60 a2 4e 0a 74 0a 80 60 00 5b 23  _..p.`.N.t..`.[#
  0ac0: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45  \/._SB_PCI0ISA_E
  0ad0: 43 30 5f 4d 54 58 45 ff ff 70 0a 00 5c 2f 05 5f  C0_MTXE..p..\/._
  0ae0: 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43  SB_PCI0ISA_EC0_C
  0af0: 44 41 33 70 72 60 0a 80 00 5c 2f 05 5f 53 42 5f  DA3pr`...\/._SB_
  0b00: 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41 32  PCI0ISA_EC0_CDA2
  0b10: 70 83 88 42 55 46 32 60 00 5c 2f 05 5f 53 42 5f  p..BUF2`.\/._SB_
  0b20: 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41 31  PCI0ISA_EC0_CDA1
  0b30: 70 0a bb 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  p..\/._SB_PCI0IS
  0b40: 41 5f 45 43 30 5f 43 43 4d 44 5b 27 5c 2f 05 5f  A_EC0_CCMD['\/._
  0b50: 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 4d  SB_PCI0ISA_EC0_M
  0b60: 54 58 45 75 60 70 00 60 a2 4e 0a 74 0a 40 60 00  TXEu`p.`.N.t.@`.
  0b70: 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41  [#\/._SB_PCI0ISA
  0b80: 5f 45 43 30 5f 4d 54 58 45 ff ff 70 0a 02 5c 2f  _EC0_MTXE..p..\/
  0b90: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  0ba0: 5f 43 44 41 33 70 72 60 0a 80 00 5c 2f 05 5f 53  _CDA3pr`...\/._S
  0bb0: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44  B_PCI0ISA_EC0_CD
  0bc0: 41 32 70 83 88 42 55 46 33 60 00 5c 2f 05 5f 53  A2p..BUF3`.\/._S
  0bd0: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44  B_PCI0ISA_EC0_CD
  0be0: 41 31 70 0a bb 5c 2f 05 5f 53 42 5f 50 43 49 30  A1p..\/._SB_PCI0
  0bf0: 49 53 41 5f 45 43 30 5f 43 43 4d 44 5b 27 5c 2f  ISA_EC0_CCMD['\/
  0c00: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  0c10: 5f 4d 54 58 45 75 60 7d 7b 0a bf 50 50 33 34 00  _MTXEu`}{..PP34.
  0c20: 7b 0a 40 47 50 4f 30 00 47 50 4f 30 70 50 50 33  {.@GPO0.GPO0pPP3
  0c30: 35 47 50 4f 31 70 50 50 33 36 47 50 4f 32 70 50  5GPO1pPP36GPO2pP
  0c40: 50 33 37 47 50 4f 33 70 01 45 53 4d 49 70 01 5c  P37GPO3p.ESMIp.\
  0c50: 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 55 52  /._SB_PCI0ISA_UR
  0c60: 54 43 70 0a a5 5c 2f 04 5f 53 42 5f 50 43 49 30  TCp..\/._SB_PCI0
  0c70: 49 53 41 5f 42 43 4d 44 70 00 5c 2f 04 5f 53 42  ISA_BCMDp.\/._SB
  0c80: 5f 50 43 49 30 49 53 41 5f 53 4d 49 43 70 5c 2f  _PCI0ISA_SMICp\/
  0c90: 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50 42 39  ._SB_PCI0ISA_PB9
  0ca0: 30 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f  0\/._SB_PCI0ISA_
  0cb0: 50 44 4d 41 70 5c 2f 04 5f 53 42 5f 50 43 49 30  PDMAp\/._SB_PCI0
  0cc0: 49 53 41 5f 50 42 39 32 5c 2f 04 5f 53 42 5f 50  ISA_PB92\/._SB_P
  0cd0: 43 49 30 49 53 41 5f 44 4d 30 33 70 5c 2f 04 5f  CI0ISA_DM03p\/._
  0ce0: 53 42 5f 50 43 49 30 49 53 41 5f 50 42 39 34 5c  SB_PCI0ISA_PB94\
  0cf0: 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 44 4d  /._SB_PCI0ISA_DM
  0d00: 35 37 70 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53  57p\/._SB_PCI0IS
  0d10: 41 5f 50 42 43 42 5c 2f 04 5f 53 42 5f 50 43 49  A_PBCB\/._SB_PCI
  0d20: 30 49 53 41 5f 55 52 54 43 a0 12 93 68 0a 04 86  0ISA_URTC...h...
  0d30: 5c 2e 5f 53 42 5f 4c 49 44 5f 0a 80 5c 2e 5f 54  \._SB_LID_..\._T
  0d40: 5a 5f 57 42 59 54 0a 9c 0a 0b 0a 7f 5c 2e 5f 54  Z_WBYT......\._T
  0d50: 5a 5f 57 42 59 54 0a 9c 0a 0c 0a bf 5c 2e 5f 54  Z_WBYT......\._T
  0d60: 5a 5f 57 42 59 54 0a 9c 0a 0a 0a 01 70 00 5c 2e  Z_WBYT......p.\.
  0d70: 5f 54 5a 5f 54 54 48 54 5c 2e 5f 54 5a 5f 54 52  _TZ_TTHT\._TZ_TR
  0d80: 53 54 86 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 81 86  ST.\._TZ_THRM...
  0d90: 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 80 70 01 47 4f  \._TZ_THRM..p.GO
  0da0: 30 31 10 45 53 5c 5f 54 5a 5f 14 41 04 53 57 46  01.ES\_TZ_.A.SWF
  0db0: 53 00 7b 48 53 54 53 0a 02 60 70 00 61 a2 1a 7b  S.{HSTS..`p.a..{
  0dc0: 93 60 00 92 93 61 0b ff 07 00 75 61 5b 21 0a 01  .`...a....ua[!..
  0dd0: 7b 48 53 54 53 0a 02 60 a0 0c 92 95 61 0b ff 07  {HSTS..`....a...
  0de0: 5b 22 0b 2c 01 70 0a ff 48 53 54 53 14 4b 04 53  [".,.p..HSTS.K.S
  0df0: 42 59 54 02 70 01 47 4f 32 35 70 01 47 4f 32 36  BYT.p.GO25p.GO26
  0e00: 5b 23 4d 54 58 53 ff ff 70 68 41 44 44 52 70 69  [#MTXS..phADDRpi
  0e10: 43 4d 44 52 70 0a ff 48 53 54 53 70 0a 44 43 54  CMDRp..HSTSp.DCT
  0e20: 4c 52 53 57 46 53 5b 27 4d 54 58 53 70 00 47 4f  LRSWFS['MTXSp.GO
  0e30: 32 36 70 00 47 4f 32 35 14 41 05 57 42 59 54 03  26p.GO25.A.WBYT.
  0e40: 70 01 47 4f 32 35 70 01 47 4f 32 36 5b 23 4d 54  p.GO25p.GO26[#MT
  0e50: 58 53 ff ff 70 68 41 44 44 52 70 69 43 4d 44 52  XS..phADDRpiCMDR
  0e60: 70 6a 44 41 54 30 70 0a ff 48 53 54 53 70 0a 48  pjDAT0p..HSTSp.H
  0e70: 43 54 4c 52 53 57 46 53 5b 27 4d 54 58 53 70 00  CTLRSWFS['MTXSp.
  0e80: 47 4f 32 36 70 00 47 4f 32 35 14 47 05 57 57 52  GO26p.GO25.G.WWR
  0e90: 44 04 70 01 47 4f 32 35 70 01 47 4f 32 36 5b 23  D.p.GO25p.GO26[#
  0ea0: 4d 54 58 53 ff ff 70 68 41 44 44 52 70 69 43 4d  MTXS..phADDRpiCM
  0eb0: 44 52 70 6a 44 41 54 30 70 6b 44 41 54 31 70 0a  DRpjDAT0pkDAT1p.
  0ec0: ff 48 53 54 53 70 0a 4c 43 54 4c 52 53 57 46 53  .HSTSp.LCTLRSWFS
  0ed0: 5b 27 4d 54 58 53 70 00 47 4f 32 36 70 00 47 4f  ['MTXSp.GO26p.GO
  0ee0: 32 35 14 45 05 52 42 59 54 02 70 01 47 4f 32 35  25.E.RBYT.p.GO25
  0ef0: 70 01 47 4f 32 36 5b 23 4d 54 58 53 ff 0f 7d 68  p.GO26[#MTXS..}h
  0f00: 0a 01 61 70 61 41 44 44 52 70 69 43 4d 44 52 70  ..apaADDRpiCMDRp
  0f10: 0a ff 48 53 54 53 70 0a 48 43 54 4c 52 53 57 46  ..HSTSp.HCTLRSWF
  0f20: 53 5b 27 4d 54 58 53 70 00 47 4f 32 36 70 00 47  S['MTXSp.GO26p.G
  0f30: 4f 32 35 a4 44 41 54 30 14 41 06 52 57 52 44 02  O25.DAT0.A.RWRD.
  0f40: 70 01 47 4f 32 35 70 01 47 4f 32 36 5b 23 4d 54  p.GO25p.GO26[#MT
  0f50: 58 53 ff ff 7d 68 0a 01 41 44 44 52 70 69 43 4d  XS..}h..ADDRpiCM
  0f60: 44 52 70 0a ff 48 53 54 53 70 0a 4c 43 54 4c 52  DRp..HSTSp.LCTLR
  0f70: 53 57 46 53 70 44 41 54 30 60 79 44 41 54 31 0a  SWFSpDAT0`yDAT1.
  0f80: 08 61 5b 27 4d 54 58 53 70 00 47 4f 32 36 70 00  .a['MTXSp.GO26p.
  0f90: 47 4f 32 35 7d 60 61 62 a4 62 08 54 54 48 54 0a  GO25}`ab.b.TTHT.
  0fa0: 00 14 41 0f 54 5a 4e 45 02 a0 0f 47 49 32 31 74  ..A.TZNE...GI21t
  0fb0: 41 43 54 54 41 43 54 44 60 a1 07 70 41 43 54 54  ACTTACTD`..pACTT
  0fc0: 60 a0 34 93 68 0a 00 72 0a 02 60 63 5c 2e 5f 54  `.4.h..r..`c\._T
  0fd0: 5a 5f 57 42 59 54 0a 9c 0a 0e 0a bf 5c 2e 5f 54  Z_WBYT......\._T
  0fe0: 5a 5f 57 42 59 54 0a 9c 0a 0d 63 7b 47 50 4f 33  Z_WBYT....c{GPO3
  0ff0: 0a f7 47 50 4f 33 a1 4c 09 a0 4a 05 93 68 0a 01  ..GPO3.L..J..h..
  1000: 72 0a 02 50 41 53 54 63 a0 14 93 69 0a 01 5c 2e  r..PASTc...i..\.
  1010: 5f 54 5a 5f 57 42 59 54 0a 9c 0a 0d 63 5c 2e 5f  _TZ_WBYT....c\._
  1020: 54 5a 5f 57 42 59 54 0a 9c 0a 0e 0a 37 70 63 5c  TZ_WBYT.....7pc\
  1030: 50 54 38 30 a0 14 93 69 0a 00 5c 2e 5f 54 5a 5f  PT80...i..\._TZ_
  1040: 57 42 59 54 0a 9c 0a 0d 63 7d 47 50 4f 33 0a 08  WBYT....c}GPO3..
  1050: 47 50 4f 33 a1 3e a0 3c 93 68 0a 02 5c 2e 5f 54  GPO3.>.<.h..\._T
  1060: 5a 5f 57 42 59 54 0a 9c 0a 0d 0a 52 5c 2e 5f 54  Z_WBYT.....R\._T
  1070: 5a 5f 57 42 59 54 0a 9c 0a 0e 50 41 53 54 70 50  Z_WBYT....PASTpP
  1080: 41 53 54 5c 50 54 38 30 7d 47 50 4f 33 0a 08 47  AST\PT80}GPO3..G
  1090: 50 4f 33 14 4c 05 54 52 53 54 00 70 5c 2e 5f 54  PO3.L.TRST.p\._T
  10a0: 5a 5f 52 42 59 54 0a 9d 0a 01 60 70 41 43 54 54  Z_RBYT....`pACTT
  10b0: 63 a0 0c 47 49 32 31 74 63 41 43 54 44 63 a0 0c  c..GI21tcACTDc..
  10c0: 92 94 60 63 70 0a 00 54 52 4e 47 a1 1a a0 0f 92  ..`cp..TRNG.....
  10d0: 94 60 50 41 53 54 70 0a 01 54 52 4e 47 a1 08 70  .`PASTp..TRNG..p
  10e0: 0a 02 54 52 4e 47 54 5a 4e 45 54 52 4e 47 0a 00  ..TRNGTZNETRNG..
  10f0: 14 34 53 4c 4d 54 00 70 52 42 59 54 0a 9d 0a 01  .4SLMT.pRBYT....
  1100: 60 72 60 0a 0a 61 74 60 0a 0a 60 57 42 59 54 0a  `r`..at`..`WBYT.
  1110: 9c 0a 0d 61 57 42 59 54 0a 9c 0a 0e 60 53 42 59  ...aWBYT....`SBY
  1120: 54 0a 19 0a 00 14 31 52 54 4d 58 00 70 52 42 59  T.....1RTMX.pRBY
  1130: 54 0a 9d 0a 01 60 a0 0a 92 95 60 0a 6e 70 0a 48  T....`....`.np.H
  1140: 60 79 60 0a 01 61 79 60 0a 03 62 72 61 62 60 72  `y`..ay`..brab`r
  1150: 60 0b ac 0a 60 a4 60 14 3b 52 54 4d 50 00 70 52  `...`.`.;RTMP.pR
  1160: 57 52 44 54 53 41 44 0a 00 60 7b 60 0a ff 61 79  WRDTSAD..`{`..ay
  1170: 61 0a 08 62 7a 60 0a 08 63 7d 62 63 60 7a 60 0a  a..bz`..c}bc`z`.
  1180: 07 60 79 60 0a 02 61 72 60 61 60 72 60 0b ac 0a  .`y`..ar`a`r`...
  1190: 60 a4 60 5b 84 45 04 50 46 41 4e 00 00 00 14 0b  `.`[.E.PFAN.....
  11a0: 5f 53 54 41 00 a4 44 55 4d 30 14 17 5f 4f 46 46  _STA..DUM0.._OFF
  11b0: 00 70 00 44 55 4d 30 7b 47 50 4f 33 0a f7 47 50  .p.DUM0{GPO3..GP
  11c0: 4f 33 14 17 5f 4f 4e 5f 00 70 01 44 55 4d 30 7d  O3.._ON_.p.DUM0}
  11d0: 47 50 4f 33 0a 08 47 50 4f 33 5b 82 26 46 41 4e  GPO3..GPO3[.&FAN
  11e0: 5f 08 5f 48 49 44 0c 41 d0 0c 0b 14 0a 5f 49 4e  _._HID.A....._IN
  11f0: 49 00 54 52 53 54 08 5f 50 52 30 12 06 01 50 46  I.TRST._PR0...PF
  1200: 41 4e 5b 85 44 0d 54 48 52 4d 08 5f 47 50 45 0a  AN[.D.THRM._GPE.
  1210: 00 08 5f 41 4c 30 12 06 01 46 41 4e 5f 14 24 5f  .._AL0...FAN_.$_
  1220: 41 43 30 00 a0 16 47 49 32 31 77 41 43 54 44 0a  AC0...GI21wACTD.
  1230: 0a 60 74 54 50 31 48 60 60 a4 60 a1 06 a4 54 50  .`tTP1H``.`...TP
  1240: 31 48 08 5f 50 53 4c 12 0c 01 5c 2e 5f 50 52 5f  1H._PSL...\._PR_
  1250: 43 50 55 30 08 5f 54 53 50 0b 2c 01 08 5f 54 43  CPU0._TSP.,.._TC
  1260: 31 0a 01 08 5f 54 43 32 0a 04 14 2a 5f 50 53 56  1..._TC2...*_PSV
  1270: 00 a0 0c 93 54 54 48 54 00 a4 54 50 32 48 a1 16  ....TTHT..TP2H..
  1280: 74 50 41 53 54 0a 05 60 77 60 0a 0a 60 72 60 0b  tPAST..`w`..`r`.
  1290: ac 0a 60 a4 60 14 0b 5f 43 52 54 00 a4 54 50 43  ..`.`.._CRT..TPC
  12a0: 5f 14 11 5f 54 4d 50 00 a4 5c 2e 5f 54 5a 5f 52  _.._TMP..\._TZ_R
  12b0: 54 4d 58 14 24 5f 53 43 50 01 a0 08 68 70 01 50  TMX.$_SCP...hp.P
  12c0: 4c 43 59 a1 07 70 00 50 4c 43 59 86 5c 2e 5f 54  LCY..p.PLCY.\._T
  12d0: 5a 5f 54 48 52 4d 0a 81 10 4e 19 5c 5f 47 50 45  Z_THRM...N.\_GPE
  12e0: 14 4f 15 5f 4c 30 30 00 86 5c 2e 5f 54 5a 5f 54  .O._L00..\._TZ_T
  12f0: 48 52 4d 0a 80 70 5c 2e 5f 54 5a 5f 52 42 59 54  HRM..p\._TZ_RBYT
  1300: 0a 9d 0a 01 60 5c 2e 5f 54 5a 5f 52 42 59 54 0a  ....`\._TZ_RBYT.
  1310: 9d 0a 02 a0 4c 06 92 95 60 50 41 53 54 5c 2e 5f  ....L...`PAST\._
  1320: 54 5a 5f 57 42 59 54 0a 9c 0a 0d 0a 5a 74 50 41  TZ_WBYT.....ZtPA
  1330: 53 54 0a 03 62 5c 2e 5f 54 5a 5f 57 42 59 54 0a  ST..b\._TZ_WBYT.
  1340: 9c 0a 0e 62 a0 27 92 93 5c 2e 5f 54 5a 5f 54 54  ...b.'..\._TZ_TT
  1350: 48 54 01 70 01 5c 2e 5f 54 5a 5f 54 54 48 54 86  HT.p.\._TZ_TTHT.
  1360: 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 81 7d 47 50 4f  \._TZ_THRM..}GPO
  1370: 33 0a 08 47 50 4f 33 70 50 41 53 54 50 54 38 30  3..GPO3pPASTPT80
  1380: a1 41 0b a0 43 07 92 95 60 41 43 54 54 72 50 41  .A..C...`ACTTrPA
  1390: 53 54 0a 03 62 5c 2e 5f 54 5a 5f 57 42 59 54 0a  ST..b\._TZ_WBYT.
  13a0: 9c 0a 0d 62 74 41 43 54 54 0a 05 62 5c 2e 5f 54  ...btACTT..b\._T
  13b0: 5a 5f 57 42 59 54 0a 9c 0a 0e 62 a0 27 92 93 5c  Z_WBYT....b.'..\
  13c0: 2e 5f 54 5a 5f 54 54 48 54 00 70 00 5c 2e 5f 54  ._TZ_TTHT.p.\._T
  13d0: 5a 5f 54 54 48 54 86 5c 2e 5f 54 5a 5f 54 48 52  Z_TTHT.\._TZ_THR
  13e0: 4d 0a 81 7d 47 50 4f 33 0a 08 47 50 4f 33 70 41  M..}GPO3..GPO3pA
  13f0: 43 54 54 50 54 38 30 a1 3a 72 41 43 54 54 0a 05  CTTPT80.:rACTT..
  1400: 61 5c 2e 5f 54 5a 5f 57 42 59 54 0a 9c 0a 0d 61  a\._TZ_WBYT....a
  1410: 5c 2e 5f 54 5a 5f 57 42 59 54 0a 9c 0a 0e 0a bf  \._TZ_WBYT......
  1420: 7b 47 50 4f 33 0a f7 47 50 4f 33 70 0a 33 50 54  {GPO3..GPO3p.3PT
  1430: 38 30 5c 2e 5f 54 5a 5f 53 42 59 54 0a 19 0a 00  80\._TZ_SBYT....
  1440: 14 1d 5f 4c 30 42 00 7f 4c 49 44 50 01 4c 49 44  .._L0B..LIDP.LID
  1450: 50 86 5c 2e 5f 53 42 5f 4c 49 44 5f 0a 80 14 18  P.\._SB_LID_....
  1460: 5f 4c 30 38 08 86 5c 2f 03 5f 53 42 5f 50 43 49  _L08..\/._SB_PCI
  1470: 30 55 53 42 30 0a 02 10 80 12 02 5c 5f 53 42 5f  0USB0......\_SB_
  1480: 5b 82 41 12 4c 4e 4b 41 08 5f 48 49 44 0c 41 d0  [.A.LNKA._HID.A.
  1490: 0c 0f 08 5f 55 49 44 0a 01 14 1c 5f 53 54 41 00  ..._UID...._STA.
  14a0: 7b 50 49 52 41 0a 80 60 a0 08 93 60 0a 80 a4 0a  {PIRA..`...`....
  14b0: 09 a1 04 a4 0a 0b 14 1a 5f 50 52 53 00 08 42 55  ........_PRS..BU
  14c0: 46 41 11 09 0a 06 23 00 02 18 79 00 a4 42 55 46  FA....#...y..BUF
  14d0: 41 14 11 5f 44 49 53 00 7d 50 49 52 41 0a 80 50  A.._DIS.}PIRA..P
  14e0: 49 52 41 14 43 07 5f 43 52 53 00 08 42 55 46 41  IRA.C._CRS..BUFA
  14f0: 11 09 0a 06 23 00 00 18 79 00 8c 42 55 46 41 0a  ....#...y..BUFA.
  1500: 01 49 52 41 31 8c 42 55 46 41 0a 02 49 52 41 32  .IRA1.BUFA..IRA2
  1510: 70 0a 00 63 70 0a 00 64 7b 50 49 52 41 0a 8f 61  p..cp..d{PIRA..a
  1520: a0 31 95 61 0a 80 7b 61 0a 0f 61 a0 0e 94 61 0a  .1.a..{a..a...a.
  1530: 07 74 61 0a 08 62 79 01 62 64 a1 0b a0 09 94 61  .ta..by.bd.....a
  1540: 0a 00 79 01 61 63 70 63 49 52 41 31 70 64 49 52  ..y.acpcIRA1pdIR
  1550: 41 32 a4 42 55 46 41 14 4b 04 5f 53 52 53 01 8c  A2.BUFA.K._SRS..
  1560: 68 0a 01 49 52 41 31 8c 68 0a 02 49 52 41 32 79  h..IRA1.h..IRA2y
  1570: 49 52 41 32 0a 08 60 7d 60 49 52 41 31 60 70 0a  IRA2..`}`IRA1`p.
  1580: 00 61 7a 60 0a 01 60 a2 0c 94 60 0a 00 75 61 7a  .az`..`...`..uaz
  1590: 60 0a 01 60 7b 50 49 52 41 0a 70 60 7d 61 60 50  `..`{PIRA.p`}a`P
  15a0: 49 52 41 5b 82 45 11 4c 4e 4b 42 08 5f 48 49 44  IRA[.E.LNKB._HID
  15b0: 0c 41 d0 0c 0f 08 5f 55 49 44 0a 02 14 1c 5f 53  .A...._UID...._S
  15c0: 54 41 00 7b 50 49 52 42 0a 80 60 a0 08 93 60 0a  TA.{PIRB..`...`.
  15d0: 80 a4 0a 09 a1 04 a4 0a 0b 08 5f 50 52 53 11 09  .........._PRS..
  15e0: 0a 06 23 00 02 18 79 00 14 11 5f 44 49 53 00 7d  ..#...y..._DIS.}
  15f0: 50 49 52 42 0a 80 50 49 52 42 14 43 07 5f 43 52  PIRB..PIRB.C._CR
  1600: 53 00 08 42 55 46 42 11 09 0a 06 23 00 00 18 79  S..BUFB....#...y
  1610: 00 8c 42 55 46 42 0a 01 49 52 42 31 8c 42 55 46  ..BUFB..IRB1.BUF
  1620: 42 0a 02 49 52 42 32 70 0a 00 63 70 0a 00 64 7b  B..IRB2p..cp..d{
  1630: 50 49 52 42 0a 8f 60 a0 31 95 60 0a 80 7b 60 0a  PIRB..`.1.`..{`.
  1640: 0f 60 a0 0e 94 60 0a 07 74 60 0a 08 62 79 01 62  .`...`..t`..by.b
  1650: 64 a1 0b a0 09 94 60 0a 00 79 01 60 63 70 63 49  d.....`..y.`cpcI
  1660: 52 42 31 70 64 49 52 42 32 a4 42 55 46 42 14 4b  RB1pdIRB2.BUFB.K
  1670: 04 5f 53 52 53 01 8c 68 0a 01 49 52 42 31 8c 68  ._SRS..h..IRB1.h
  1680: 0a 02 49 52 42 32 79 49 52 42 32 0a 08 60 7d 60  ..IRB2yIRB2..`}`
  1690: 49 52 42 31 60 70 0a 00 61 7a 60 0a 01 60 a2 0c  IRB1`p..az`..`..
  16a0: 94 60 0a 00 75 61 7a 60 0a 01 60 7b 50 49 52 42  .`..uaz`..`{PIRB
  16b0: 0a 70 60 7d 61 60 50 49 52 42 5b 82 45 11 4c 4e  .p`}a`PIRB[.E.LN
  16c0: 4b 43 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  KC._HID.A...._UI
  16d0: 44 0a 03 14 1c 5f 53 54 41 00 7b 50 49 52 43 0a  D...._STA.{PIRC.
  16e0: 80 60 a0 08 93 60 0a 80 a4 0a 09 a1 04 a4 0a 0b  .`...`..........
  16f0: 08 5f 50 52 53 11 09 0a 06 23 e0 04 18 79 00 14  ._PRS....#...y..
  1700: 11 5f 44 49 53 00 7d 50 49 52 43 0a 80 50 49 52  ._DIS.}PIRC..PIR
  1710: 43 14 43 07 5f 43 52 53 00 08 42 55 46 43 11 09  C.C._CRS..BUFC..
  1720: 0a 06 23 00 00 18 79 00 8c 42 55 46 43 0a 01 49  ..#...y..BUFC..I
  1730: 52 43 31 8c 42 55 46 43 0a 02 49 52 43 32 70 0a  RC1.BUFC..IRC2p.
  1740: 00 63 70 0a 00 64 7b 50 49 52 43 0a 8f 60 a0 31  .cp..d{PIRC..`.1
  1750: 95 60 0a 80 7b 60 0a 0f 60 a0 0e 94 60 0a 07 74  .`..{`..`...`..t
  1760: 60 0a 08 62 79 01 62 64 a1 0b a0 09 94 60 0a 00  `..by.bd.....`..
  1770: 79 01 60 63 70 63 49 52 43 31 70 64 49 52 43 32  y.`cpcIRC1pdIRC2
  1780: a4 42 55 46 43 14 4b 04 5f 53 52 53 01 8c 68 0a  .BUFC.K._SRS..h.
  1790: 01 49 52 43 31 8c 68 0a 02 49 52 43 32 79 49 52  .IRC1.h..IRC2yIR
  17a0: 43 32 0a 08 60 7d 60 49 52 43 31 60 70 0a 00 61  C2..`}`IRC1`p..a
  17b0: 7a 60 0a 01 60 a2 0c 94 60 0a 00 75 61 7a 60 0a  z`..`...`..uaz`.
  17c0: 01 60 7b 50 49 52 43 0a 70 60 7d 61 60 50 49 52  .`{PIRC.p`}a`PIR
  17d0: 43 5b 82 45 11 4c 4e 4b 44 08 5f 48 49 44 0c 41  C[.E.LNKD._HID.A
  17e0: d0 0c 0f 08 5f 55 49 44 0a 04 14 1c 5f 53 54 41  ...._UID...._STA
  17f0: 00 7b 50 49 52 44 0a 80 60 a0 08 93 60 0a 80 a4  .{PIRD..`...`...
  1800: 0a 09 a1 04 a4 0a 0b 08 5f 50 52 53 11 09 0a 06  ........_PRS....
  1810: 23 00 02 18 79 00 14 11 5f 44 49 53 00 7d 50 49  #...y..._DIS.}PI
  1820: 52 44 0a 80 50 49 52 44 14 43 07 5f 43 52 53 00  RD..PIRD.C._CRS.
  1830: 08 42 55 46 44 11 09 0a 06 23 00 00 18 79 00 8c  .BUFD....#...y..
  1840: 42 55 46 44 0a 01 49 52 44 31 8c 42 55 46 44 0a  BUFD..IRD1.BUFD.
  1850: 02 49 52 44 32 70 0a 00 63 70 0a 00 64 7b 50 49  .IRD2p..cp..d{PI
  1860: 52 44 0a 8f 60 a0 31 95 60 0a 80 7b 60 0a 0f 60  RD..`.1.`..{`..`
  1870: a0 0e 94 60 0a 07 74 60 0a 08 62 79 01 62 64 a1  ...`..t`..by.bd.
  1880: 0b a0 09 94 60 0a 00 79 01 60 63 70 63 49 52 44  ....`..y.`cpcIRD
  1890: 31 70 64 49 52 44 32 a4 42 55 46 44 14 4b 04 5f  1pdIRD2.BUFD.K._
  18a0: 53 52 53 01 8c 68 0a 01 49 52 44 31 8c 68 0a 02  SRS..h..IRD1.h..
  18b0: 49 52 44 32 79 49 52 44 32 0a 08 60 7d 60 49 52  IRD2yIRD2..`}`IR
  18c0: 44 31 60 70 0a 00 61 7a 60 0a 01 60 a2 0c 94 60  D1`p..az`..`...`
  18d0: 0a 00 75 61 7a 60 0a 01 60 7b 50 49 52 44 0a 70  ..uaz`..`{PIRD.p
  18e0: 60 7d 61 60 50 49 52 44 5b 82 2d 41 43 5f 5f 08  `}a`PIRD[.-AC__.
  18f0: 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 08 5f 48 49  _PCL...\_SB_._HI
  1900: 44 0d 41 43 50 49 30 30 30 33 00 14 0b 5f 50 53  D.ACPI0003..._PS
  1910: 52 00 a4 47 49 32 31 5b 82 0f 53 4c 50 42 08 5f  R..GI21[..SLPB._
  1920: 48 49 44 0c 41 d0 0c 0e 08 42 41 54 57 0a 0a 08  HID.A....BATW...
  1930: 42 41 54 4c 0a 01 08 42 55 46 30 12 02 0d 08 44  BATL...BUF0....D
  1940: 43 5f 54 12 2b 10 0b 80 10 0b 80 0c 0b 00 0f 0b  C_T.+...........
  1950: 00 0b 0b 00 16 0a 00 0b 00 14 0a 00 0b 00 12 0b  ................
  1960: 80 0d 0a 00 0a 00 0b 00 18 0a 00 0a 00 0a 00 08  ................
  1970: 42 55 46 31 12 02 04 08 4e 41 43 48 0a 00 08 4c  BUF1....NACH...L
  1980: 4d 44 5f 0a 00 14 42 07 57 47 50 4f 01 5b 23 5c  MD_...B.WGPO.[#\
  1990: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  19a0: 30 5f 4d 54 58 45 ff ff 70 68 5c 2f 05 5f 53 42  0_MTXE..ph\/._SB
  19b0: 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41  _PCI0ISA_EC0_CDA
  19c0: 31 70 0a c5 5c 2f 05 5f 53 42 5f 50 43 49 30 49  1p..\/._SB_PCI0I
  19d0: 53 41 5f 45 43 30 5f 43 43 4d 44 5b 22 0a 05 5b  SA_EC0_CCMD["..[
  19e0: 27 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  '\/._SB_PCI0ISA_
  19f0: 45 43 30 5f 4d 54 58 45 14 4d 08 52 47 50 4f 01  EC0_MTXE.M.RGPO.
  1a00: 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41  [#\/._SB_PCI0ISA
  1a10: 5f 45 43 30 5f 4d 54 58 45 ff ff 70 68 5c 2f 05  _EC0_MTXE..ph\/.
  1a20: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  1a30: 43 44 41 31 70 0a c3 5c 2f 05 5f 53 42 5f 50 43  CDA1p..\/._SB_PC
  1a40: 49 30 49 53 41 5f 45 43 30 5f 43 43 4d 44 5b 22  I0ISA_EC0_CCMD["
  1a50: 0a 05 70 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  ..p\/._SB_PCI0IS
  1a60: 41 5f 45 43 30 5f 43 44 41 31 68 5b 27 5c 2f 05  A_EC0_CDA1h['\/.
  1a70: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  1a80: 4d 54 58 45 a4 68 14 43 0a 52 50 4f 4c 01 5b 23  MTXE.h.C.RPOL.[#
  1a90: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45  \/._SB_PCI0ISA_E
  1aa0: 43 30 5f 4d 54 58 45 ff ff 70 68 5c 2f 05 5f 53  C0_MTXE..ph\/._S
  1ab0: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44  B_PCI0ISA_EC0_CD
  1ac0: 41 32 70 0a 03 5c 2f 05 5f 53 42 5f 50 43 49 30  A2p..\/._SB_PCI0
  1ad0: 49 53 41 5f 45 43 30 5f 43 44 41 33 70 0a ba 5c  ISA_EC0_CDA3p..\
  1ae0: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  1af0: 30 5f 43 43 4d 44 70 5c 2f 05 5f 53 42 5f 50 43  0_CCMDp\/._SB_PC
  1b00: 49 30 49 53 41 5f 45 43 30 5f 43 44 41 31 68 5b  I0ISA_EC0_CDA1h[
  1b10: 27 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  '\/._SB_PCI0ISA_
  1b20: 45 43 30 5f 4d 54 58 45 a4 68 14 4a 0c 52 42 41  EC0_MTXE.h.J.RBA
  1b30: 54 02 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49  T.[#\/._SB_PCI0I
  1b40: 53 41 5f 45 43 30 5f 4d 54 58 45 ff ff 70 68 5c  SA_EC0_MTXE..ph\
  1b50: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  1b60: 30 5f 43 44 41 32 70 69 60 79 60 0a 01 60 72 60  0_CDA2pi`y`..`r`
  1b70: 0a da 61 70 61 5c 2f 05 5f 53 42 5f 50 43 49 30  ..apa\/._SB_PCI0
  1b80: 49 53 41 5f 45 43 30 5f 43 43 4d 44 a2 18 5c 2f  ISA_EC0_CCMD..\/
  1b90: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  1ba0: 5f 43 43 4d 44 70 5c 2f 05 5f 53 42 5f 50 43 49  _CCMDp\/._SB_PCI
  1bb0: 30 49 53 41 5f 45 43 30 5f 43 44 41 31 69 70 5c  0ISA_EC0_CDA1ip\
  1bc0: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  1bd0: 30 5f 43 44 41 33 42 51 45 52 5b 27 5c 2f 05 5f  0_CDA3BQER['\/._
  1be0: 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 4d  SB_PCI0ISA_EC0_M
  1bf0: 54 58 45 a4 69 14 43 0b 57 42 41 54 03 5b 23 5c  TXE.i.C.WBAT.[#\
  1c00: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  1c10: 30 5f 4d 54 58 45 ff ff 70 6a 5c 2f 05 5f 53 42  0_MTXE..pj\/._SB
  1c20: 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41  _PCI0ISA_EC0_CDA
  1c30: 31 70 7d 68 0a 80 00 68 70 68 5c 2f 05 5f 53 42  1p}h...hph\/._SB
  1c40: 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41  _PCI0ISA_EC0_CDA
  1c50: 32 70 69 60 79 60 0a 01 60 72 60 0a da 61 70 61  2pi`y`..`r`..apa
  1c60: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45  \/._SB_PCI0ISA_E
  1c70: 43 30 5f 43 43 4d 44 a2 18 5c 2f 05 5f 53 42 5f  C0_CCMD..\/._SB_
  1c80: 50 43 49 30 49 53 41 5f 45 43 30 5f 43 43 4d 44  PCI0ISA_EC0_CCMD
  1c90: 5b 27 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41  ['\/._SB_PCI0ISA
  1ca0: 5f 45 43 30 5f 4d 54 58 45 14 4e 04 52 56 53 52  _EC0_MTXE.N.RVSR
  1cb0: 01 70 52 50 4f 4c 0a 9a 60 70 52 50 4f 4c 0a 9b  .pRPOL..`pRPOL..
  1cc0: 61 79 60 0a 08 60 72 60 61 60 7b 60 0b ff ff 60  ay`..`r`a`{`...`
  1cd0: 7b 60 0b 00 80 61 a0 0b 61 80 60 60 7b 60 0b ff  {`...a..a.``{`..
  1ce0: ff 60 70 60 61 7a 61 0a 01 61 79 60 0a 01 60 72  .`p`aza..ay`..`r
  1cf0: 60 61 60 70 60 68 a4 68 14 4e 0b 42 52 53 54 00  `a`p`h.h.N.BRST.
  1d00: 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41  [#\/._SB_PCI0ISA
  1d10: 5f 45 43 30 5f 4d 54 58 45 ff ff 70 0a 04 5c 2f  _EC0_MTXE..p..\/
  1d20: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  1d30: 5f 43 44 41 33 70 0a ce 5c 2f 05 5f 53 42 5f 50  _CDA3p..\/._SB_P
  1d40: 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41 32 70  CI0ISA_EC0_CDA2p
  1d50: 0a ba 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41  ..\/._SB_PCI0ISA
  1d60: 5f 45 43 30 5f 43 43 4d 44 70 5c 2f 05 5f 53 42  _EC0_CCMDp\/._SB
  1d70: 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41  _PCI0ISA_EC0_CDA
  1d80: 31 60 5b 27 5c 2f 05 5f 53 42 5f 50 43 49 30 49  1`['\/._SB_PCI0I
  1d90: 53 41 5f 45 43 30 5f 4d 54 58 45 a0 1b 92 7b 60  SA_EC0_MTXE...{`
  1da0: 0a 20 00 57 42 41 54 0a 03 0a 00 0a 00 57 42 41  . .WBAT......WBA
  1db0: 54 0a 17 0a 00 0a 00 5b 82 43 52 42 41 54 30 08  T......[.CRBAT0.
  1dc0: 5f 48 49 44 0c 41 d0 0c 0a 08 5f 50 43 4c 12 07  _HID.A...._PCL..
  1dd0: 01 5c 5f 53 42 5f 08 5f 55 49 44 0a 01 14 4a 07  .\_SB_._UID...J.
  1de0: 5f 53 54 41 00 5b 23 5c 2f 05 5f 53 42 5f 50 43  _STA.[#\/._SB_PC
  1df0: 49 30 49 53 41 5f 45 43 30 5f 4d 54 58 45 ff ff  I0ISA_EC0_MTXE..
  1e00: 70 0a aa 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53  p..\/._SB_PCI0IS
  1e10: 41 5f 42 43 4d 44 70 00 5c 2f 04 5f 53 42 5f 50  A_BCMDp.\/._SB_P
  1e20: 43 49 30 49 53 41 5f 53 4d 49 43 5b 27 5c 2f 05  CI0ISA_SMIC['\/.
  1e30: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  1e40: 4d 54 58 45 a4 5c 2f 04 5f 53 42 5f 50 43 49 30  MTXE.\/._SB_PCI0
  1e50: 49 53 41 5f 49 4e 46 5f 14 42 2a 5f 42 49 46 00  ISA_INF_.B*_BIF.
  1e60: 70 01 88 42 55 46 30 0a 00 00 70 52 42 41 54 0a  p..BUF0...pRBAT.
  1e70: 07 0a 00 60 70 0d 42 41 2d 30 34 00 88 42 55 46  ...`p.BA-04..BUF
  1e80: 30 0a 09 00 70 0d 4c 69 2d 49 6f 6e 00 88 42 55  0...p.Li-Ion..BU
  1e90: 46 30 0a 0b 00 7b 60 0a 03 60 70 52 42 41 54 0a  F0...{`..`pRBAT.
  1ea0: 08 0a 00 61 79 61 0a 02 61 72 60 61 60 7b 60 0a  ...aya..ar`a`{`.
  1eb0: 0f 60 70 83 88 44 43 5f 54 60 00 88 42 55 46 30  .`p..DC_T`..BUF0
  1ec0: 0a 01 00 5b 23 5c 2f 05 5f 53 42 5f 50 43 49 30  ...[#\/._SB_PCI0
  1ed0: 49 53 41 5f 45 43 30 5f 4d 54 58 45 ff ff 70 0a  ISA_EC0_MTXE..p.
  1ee0: 03 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  1ef0: 45 43 30 5f 43 44 41 33 70 0a 4b 5c 2f 05 5f 53  EC0_CDA3p.K\/._S
  1f00: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44  B_PCI0ISA_EC0_CD
  1f10: 41 32 70 0a 04 5c 2f 05 5f 53 42 5f 50 43 49 30  A2p..\/._SB_PCI0
  1f20: 49 53 41 5f 45 43 30 5f 43 44 41 31 70 0a bb 5c  ISA_EC0_CDA1p..\
  1f30: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  1f40: 30 5f 43 43 4d 44 5b 27 5c 2f 05 5f 53 42 5f 50  0_CCMD['\/._SB_P
  1f50: 43 49 30 49 53 41 5f 45 43 30 5f 4d 54 58 45 70  CI0ISA_EC0_MTXEp
  1f60: 00 60 70 01 62 70 00 63 a2 28 7b 92 93 60 62 92  .`p.bp.c.({..`b.
  1f70: 93 63 0a 20 00 5b 22 0a 32 70 52 42 41 54 0a 05  .c. .[".2pRBAT..
  1f80: 0a 00 62 70 52 50 4f 4c 0a 97 60 75 63 5b 22 0a  ..bpRPOL..`uc[".
  1f90: 96 70 00 61 70 01 62 70 00 63 a2 24 7b 92 93 61  .p.ap.bp.c.${..a
  1fa0: 62 92 93 63 0a 20 00 5b 22 0a 32 70 52 42 41 54  b..c. .[".2pRBAT
  1fb0: 0a 03 0a 00 62 70 52 50 4f 4c 0a 95 61 75 63 5b  ....bpRPOL..auc[
  1fc0: 23 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  #\/._SB_PCI0ISA_
  1fd0: 45 43 30 5f 4d 54 58 45 ff ff 70 0a 03 5c 2f 05  EC0_MTXE..p..\/.
  1fe0: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  1ff0: 43 44 41 33 70 0a 4b 5c 2f 05 5f 53 42 5f 50 43  CDA3p.K\/._SB_PC
  2000: 49 30 49 53 41 5f 45 43 30 5f 43 44 41 32 70 0a  I0ISA_EC0_CDA2p.
  2010: 00 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  2020: 45 43 30 5f 43 44 41 31 70 0a bb 5c 2f 05 5f 53  EC0_CDA1p..\/._S
  2030: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 43  B_PCI0ISA_EC0_CC
  2040: 4d 44 5b 27 5c 2f 05 5f 53 42 5f 50 43 49 30 49  MD['\/._SB_PCI0I
  2050: 53 41 5f 45 43 30 5f 4d 54 58 45 79 60 0a 05 60  SA_EC0_MTXEy`..`
  2060: 70 60 61 70 60 88 42 55 46 30 0a 02 00 70 01 88  p`ap`.BUF0...p..
  2070: 42 55 46 30 0a 03 00 70 0b 30 2a 88 42 55 46 30  BUF0...p.0*.BUF0
  2080: 0a 04 00 78 61 0a 0a 60 61 70 61 88 42 55 46 30  ...xa..`apa.BUF0
  2090: 0a 05 00 78 61 0a 0a 60 61 70 61 88 42 55 46 30  ...xa..`apa.BUF0
  20a0: 0a 06 00 74 83 88 42 55 46 30 0a 05 00 83 88 42  ...t..BUF0.....B
  20b0: 55 46 30 0a 06 00 88 42 55 46 30 0a 07 00 74 83  UF0....BUF0...t.
  20c0: 88 42 55 46 30 0a 02 00 83 88 42 55 46 30 0a 05  .BUF0.....BUF0..
  20d0: 00 88 42 55 46 30 0a 08 00 70 0d 00 88 42 55 46  ..BUF0...p...BUF
  20e0: 30 0a 0a 00 70 0d 41 53 55 53 54 65 6b 00 88 42  0...p.ASUSTek..B
  20f0: 55 46 30 0a 0c 00 a4 42 55 46 30 14 40 1e 5f 42  UF0....BUF0.@._B
  2100: 53 54 00 70 52 42 41 54 0a 01 0a 00 60 70 42 51  ST.pRBAT....`pBQ
  2110: 45 52 42 51 45 31 70 00 61 a0 0b 7b 60 0a 80 00  ERBQE1p.a..{`...
  2120: 7d 61 0a 02 61 a1 06 7d 61 0a 01 61 5b 23 5c 2f  }a..a..}a..a[#\/
  2130: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  2140: 5f 4d 54 58 45 ff ff 70 0a 04 5c 2f 05 5f 53 42  _MTXE..p..\/._SB
  2150: 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41  _PCI0ISA_EC0_CDA
  2160: 33 70 0a cf 5c 2f 05 5f 53 42 5f 50 43 49 30 49  3p..\/._SB_PCI0I
  2170: 53 41 5f 45 43 30 5f 43 44 41 32 70 0a ba 5c 2f  SA_EC0_CDA2p..\/
  2180: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30  ._SB_PCI0ISA_EC0
  2190: 5f 43 43 4d 44 70 5c 2f 05 5f 53 42 5f 50 43 49  _CCMDp\/._SB_PCI
  21a0: 30 49 53 41 5f 45 43 30 5f 43 44 41 31 63 5b 27  0ISA_EC0_CDA1c['
  21b0: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45  \/._SB_PCI0ISA_E
  21c0: 43 30 5f 4d 54 58 45 a0 0a 47 49 30 39 7d 61 0a  C0_MTXE..GI09}a.
  21d0: 04 61 70 61 88 42 55 46 31 0a 00 00 70 52 56 53  .apa.BUF1...pRVS
  21e0: 52 0a 00 88 42 55 46 31 0a 01 00 5b 23 5c 2f 05  R...BUF1...[#\/.
  21f0: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  2200: 4d 54 58 45 ff ff 70 0a 04 5c 2f 05 5f 53 42 5f  MTXE..p..\/._SB_
  2210: 50 43 49 30 49 53 41 5f 45 43 30 5f 43 44 41 33  PCI0ISA_EC0_CDA3
  2220: 70 0a f8 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  p..\/._SB_PCI0IS
  2230: 41 5f 45 43 30 5f 43 44 41 32 70 0a ba 5c 2f 05  A_EC0_CDA2p..\/.
  2240: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  2250: 43 43 4d 44 70 5c 2f 05 5f 53 42 5f 50 43 49 30  CCMDp\/._SB_PCI0
  2260: 49 53 41 5f 45 43 30 5f 43 44 41 31 62 5b 27 5c  ISA_EC0_CDA1b['\
  2270: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  2280: 30 5f 4d 54 58 45 70 52 50 4f 4c 0a 96 60 70 52  0_MTXEpRPOL..`pR
  2290: 50 4f 4c 0a 95 61 70 61 4e 41 43 48 79 61 0a 08  POL..apaNACHya..
  22a0: 61 72 60 61 61 7a 61 0a 03 61 70 61 88 42 55 46  ar`aaza..apa.BUF
  22b0: 31 0a 02 00 70 52 42 41 54 0a 0b 0a 00 60 77 60  1...pRBAT....`w`
  22c0: 0a 4b 60 7a 60 0a 04 60 77 60 0a 09 60 70 60 88  .K`z`..`w`..`p`.
  22d0: 42 55 46 31 0a 03 00 a4 42 55 46 31 5b 82 42 04  BUF1....BUF1[.B.
  22e0: 4c 49 44 5f 08 5f 48 49 44 0c 41 d0 0c 0d 14 0b  LID_._HID.A.....
  22f0: 5f 4c 49 44 00 a4 4c 49 44 50 08 5f 50 52 57 12  _LID..LIDP._PRW.
  2300: 06 02 0a 0b 0a 04 14 19 5f 50 53 57 01 a0 0a 93  ........_PSW....
  2310: 68 01 70 01 4c 49 44 45 a1 07 70 00 4c 49 44 45  h.p.LIDE..p.LIDE
  2320: 5b 82 41 0d 4d 45 4d 31 08 5f 48 49 44 0c 41 d0  [.A.MEM1._HID.A.
  2330: 0c 01 14 40 0c 5f 43 52 53 00 08 42 55 46 5f 11  ...@._CRS..BUF_.
  2340: 29 0a 26 86 09 00 01 00 00 00 00 00 00 0a 00 86  ).&.............
  2350: 09 00 60 00 00 0e 00 00 00 02 00 86 09 00 01 00  ..`.............
  2360: 00 10 00 00 00 00 00 79 00 8c 42 55 46 5f 0a 20  .......y..BUF_. 
  2370: 53 49 5a 30 8c 42 55 46 5f 0a 21 53 49 5a 31 8c  SIZ0.BUF_.!SIZ1.
  2380: 42 55 46 5f 0a 22 53 49 5a 32 8c 42 55 46 5f 0a  BUF_."SIZ2.BUF_.
  2390: 23 53 49 5a 33 70 5c 2f 03 5f 53 42 5f 50 43 49  #SIZ3p\/._SB_PCI
  23a0: 30 42 58 4d 53 60 79 60 0a 17 60 74 60 0c 00 00  0BXMS`y`..`t`...
  23b0: 10 00 60 7b 60 0a ff 61 70 61 53 49 5a 30 7a 60  ..`{`..apaSIZ0z`
  23c0: 0a 08 60 7b 60 0a ff 61 70 61 53 49 5a 31 7a 60  ..`{`..apaSIZ1z`
  23d0: 0a 08 60 7b 60 0a ff 61 70 61 53 49 5a 32 7a 60  ..`{`..apaSIZ2z`
  23e0: 0a 08 60 7b 60 0a ff 61 70 61 53 49 5a 33 a4 42  ..`{`..apaSIZ3.B
  23f0: 55 46 5f 5b 82 83 1a 01 50 43 49 30 08 5f 48 49  UF_[....PCI0._HI
  2400: 44 0c 41 d0 0a 03 08 5f 41 44 52 0a 00 5b 80 50  D.A...._ADR..[.P
  2410: 42 49 44 02 0a 00 0a 70 5b 81 10 50 42 49 44 02  BID....p[..PBID.
  2420: 56 45 49 44 10 44 45 49 44 10 5b 81 15 50 42 49  VEID.DEID.[..PBI
  2430: 44 01 00 48 32 54 58 4d 53 08 00 08 42 58 4d 53  D..H2TXMS...BXMS
  2440: 08 14 1f 49 34 34 30 00 70 0b f0 ff 60 7b 44 45  ...I440.p...`{DE
  2450: 49 44 60 61 a0 08 93 61 0b 90 71 a4 01 a1 03 a4  ID`a...a..q.....
  2460: 00 08 43 52 45 53 11 4c 08 0a 88 88 0d 00 02 01  ..CRES.L........
  2470: 00 00 00 00 00 ff 00 00 00 00 01 47 01 f8 0c f8  ...........G....
  2480: 0c 01 08 88 0d 00 01 0c 03 00 00 00 00 f7 0c 00  ................
  2490: 00 f8 0c 88 0d 00 01 0c 03 00 00 00 0d ff ff 00  ................
  24a0: 00 00 f3 87 17 00 00 0c 03 00 00 00 00 00 00 0a  ................
  24b0: 00 ff ff 0b 00 00 00 00 00 00 00 02 00 87 17 00  ................
  24c0: 00 0c 03 00 00 00 00 00 b0 0c 00 ff ff 0d 00 00  ................
  24d0: 00 00 00 00 50 01 00 87 17 00 00 0c 03 00 00 00  ....P...........
  24e0: 00 00 00 00 02 ff ff df ff 00 00 00 00 00 00 fc  ................
  24f0: fd 79 00 14 4c 04 5f 43 52 53 00 8a 43 52 45 53  .y..L._CRS..CRES
  2500: 0a 76 52 41 4d 54 8a 43 52 45 53 0a 82 52 41 4d  .vRAMT.CRES..RAM
  2510: 52 70 5c 2f 03 5f 53 42 5f 50 43 49 30 42 58 4d  Rp\/._SB_PCI0BXM
  2520: 53 60 79 60 0a 17 60 70 60 52 41 4d 54 74 0c 00  S`y`..`p`RAMTt..
  2530: 00 e0 ff 52 41 4d 54 52 41 4d 52 a4 43 52 45 53  ...RAMTRAMR.CRES
  2540: 08 5f 50 52 54 12 43 0c 0c 12 0f 04 0c ff ff 07  ._PRT.C.........
  2550: 00 0a 00 4c 4e 4b 41 0a 00 12 0f 04 0c ff ff 07  ...LNKA.........
  2560: 00 0a 01 4c 4e 4b 42 0a 00 12 0f 04 0c ff ff 07  ...LNKB.........
  2570: 00 0a 02 4c 4e 4b 43 0a 00 12 0f 04 0c ff ff 07  ...LNKC.........
  2580: 00 0a 03 4c 4e 4b 44 0a 00 12 0f 04 0c ff ff 01  ...LNKD.........
  2590: 00 0a 00 4c 4e 4b 41 0a 00 12 0f 04 0c ff ff 01  ...LNKA.........
  25a0: 00 0a 01 4c 4e 4b 42 0a 00 12 0f 04 0c ff ff 01  ...LNKB.........
  25b0: 00 0a 02 4c 4e 4b 43 0a 00 12 0f 04 0c ff ff 01  ...LNKC.........
  25c0: 00 0a 03 4c 4e 4b 44 0a 00 12 0f 04 0c ff ff 06  ...LNKD.........
  25d0: 00 0a 00 4c 4e 4b 43 0a 00 12 0f 04 0c ff ff 0a  ...LNKC.........
  25e0: 00 0a 00 4c 4e 4b 41 0a 00 12 0f 04 0c ff ff 0a  ...LNKA.........
  25f0: 00 0a 01 4c 4e 4b 42 0a 00 12 0f 04 0c ff ff 08  ...LNKB.........
  2600: 00 0a 00 4c 4e 4b 44 0a 00 5b 82 0f 41 47 50 5f  ...LNKD..[..AGP_
  2610: 08 5f 41 44 52 0c 00 00 01 00 5b 82 46 e5 49 53  ._ADR.....[.F.IS
  2620: 41 5f 08 5f 41 44 52 0c 00 00 07 00 5b 80 50 49  A_._ADR.....[.PI
  2630: 52 51 02 0a 60 0a 04 10 2e 5c 00 5b 81 29 5c 2f  RQ..`....\.[.)\/
  2640: 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50 49 52  ._SB_PCI0ISA_PIR
  2650: 51 01 50 49 52 41 08 50 49 52 42 08 50 49 52 43  Q.PIRA.PIRB.PIRC
  2660: 08 50 49 52 44 08 14 09 5f 53 54 41 00 a4 0a 0b  .PIRD..._STA....
  2670: 5b 80 58 42 43 53 02 0a 4e 0a 01 5b 81 1f 58 42  [.XBCS..N..[..XB
  2680: 43 53 01 52 54 43 53 01 4b 42 43 53 01 42 49 4f  CS.RTCS.KBCS.BIO
  2690: 53 01 50 36 31 53 01 49 52 51 42 01 5b 80 44 4d  S.P61S.IRQB.[.DM
  26a0: 41 52 02 0a 90 0a 06 5b 81 15 44 4d 41 52 02 50  AR.....[..DMAR.P
  26b0: 44 4d 41 10 44 4d 30 33 10 44 4d 35 37 10 08 50  DMA.DM03.DM57..P
  26c0: 42 39 30 0a 00 08 50 42 39 32 0a 00 08 50 42 39  B90...PB92...PB9
  26d0: 34 0a 00 08 50 42 43 42 0a 00 5b 80 52 54 43 43  4...PBCB..[.RTCC
  26e0: 02 0a cb 0a 01 5b 81 1a 52 54 43 43 01 52 54 43  .....[..RTCC.RTC
  26f0: 45 01 52 45 53 56 01 55 52 54 43 01 4c 4c 52 42  E.RESV.URTC.LLRB
  2700: 01 5b 82 40 3a 45 43 30 5f 5b 80 52 41 4d 5f 03  .[.@:EC0_[.RAM_.
  2710: 0a 00 0a ff 5b 81 4e 08 52 41 4d 5f 10 00 20 43  ....[.N.RAM_.. C
  2720: 43 4d 44 08 43 44 41 31 08 43 44 41 32 08 43 44  CMD.CDA1.CDA2.CD
  2730: 41 33 08 00 40 20 45 56 35 34 08 45 56 35 35 08  A3..@ EV54.EV55.
  2740: 54 4b 35 34 08 54 4b 35 35 08 00 20 45 56 36 30  TK54.TK55.. EV60
  2750: 08 45 56 36 31 08 45 56 36 32 08 45 56 36 33 08  .EV61.EV62.EV63.
  2760: 45 56 36 34 08 45 56 36 35 08 45 56 36 36 08 45  EV64.EV65.EV66.E
  2770: 56 36 37 08 54 4b 36 30 08 54 4b 36 31 08 54 4b  V67.TK60.TK61.TK
  2780: 36 32 08 54 4b 36 33 08 54 4b 36 34 08 54 4b 36  62.TK63.TK64.TK6
  2790: 35 08 54 4b 36 36 08 54 4b 36 37 08 00 40 0c 53  5.TK66.TK67..@.S
  27a0: 54 36 59 08 08 5f 48 49 44 0c 41 d0 0c 09 08 5f  T6Y.._HID.A...._
  27b0: 43 52 53 11 15 0a 12 47 01 62 00 62 00 00 01 47  CRS....G.b.b...G
  27c0: 01 66 00 66 00 00 01 79 00 08 5f 47 50 45 0a 09  .f.f...y.._GPE..
  27d0: 5b 01 4d 54 58 45 03 14 48 08 5f 51 33 34 00 5b  [.MTXE..H._Q34.[
  27e0: 23 4d 54 58 45 ff ff 7f 5c 2f 05 5f 53 42 5f 50  #MTXE...\/._SB_P
  27f0: 43 49 30 49 53 41 5f 45 43 30 5f 45 56 36 34 0a  CI0ISA_EC0_EV64.
  2800: 10 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  2810: 45 43 30 5f 45 56 36 34 a0 12 47 49 32 31 86 5c  EC0_EV64..GI21.\
  2820: 2e 5f 53 42 5f 41 43 5f 5f 0a 00 a1 0e 86 5c 2e  ._SB_AC__.....\.
  2830: 5f 53 42 5f 41 43 5f 5f 0a 01 5b 27 4d 54 58 45  _SB_AC__..['MTXE
  2840: 86 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 81 86 5c 2e  .\._TZ_THRM...\.
  2850: 5f 54 5a 5f 54 48 52 4d 0a 80 70 01 47 4f 30 31  _TZ_THRM..p.GO01
  2860: 14 4c 08 5f 51 33 31 00 5b 23 4d 54 58 45 ff ff  .L._Q31.[#MTXE..
  2870: 7f 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  2880: 45 43 30 5f 45 56 36 31 0a 10 5c 2f 05 5f 53 42  EC0_EV61..\/._SB
  2890: 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 45 56 36  _PCI0ISA_EC0_EV6
  28a0: 31 5b 27 4d 54 58 45 a0 29 7b 5c 2f 05 5f 53 42  1['MTXE.){\/._SB
  28b0: 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 53 54 36  _PCI0ISA_EC0_ST6
  28c0: 59 0a 02 00 86 5c 2e 5f 53 42 5f 42 41 54 30 0a  Y....\._SB_BAT0.
  28d0: 00 a1 1b 86 5c 2e 5f 53 42 5f 42 41 54 30 0a 81  ....\._SB_BAT0..
  28e0: 86 5c 2e 5f 53 42 5f 42 41 54 30 0a 01 14 47 0b  .\._SB_BAT0...G.
  28f0: 5f 51 32 46 00 5b 23 5c 2f 05 5f 53 42 5f 50 43  _Q2F.[#\/._SB_PC
  2900: 49 30 49 53 41 5f 45 43 30 5f 4d 54 58 45 ff ff  I0ISA_EC0_MTXE..
  2910: 70 0a 04 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  p..\/._SB_PCI0IS
  2920: 41 5f 45 43 30 5f 43 44 41 33 70 0a f8 5c 2f 05  A_EC0_CDA3p..\/.
  2930: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  2940: 43 44 41 32 70 0a ba 5c 2f 05 5f 53 42 5f 50 43  CDA2p..\/._SB_PC
  2950: 49 30 49 53 41 5f 45 43 30 5f 43 43 4d 44 70 5c  I0ISA_EC0_CCMDp\
  2960: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  2970: 30 5f 43 44 41 31 60 5b 27 5c 2f 05 5f 53 42 5f  0_CDA1`['\/._SB_
  2980: 50 43 49 30 49 53 41 5f 45 43 30 5f 4d 54 58 45  PCI0ISA_EC0_MTXE
  2990: a0 14 92 7b 60 0a 02 00 86 5c 2e 5f 53 42 5f 42  ...{`....\._SB_B
  29a0: 41 54 30 0a 80 14 13 5f 51 30 41 00 86 5c 2e 5f  AT0...._Q0A..\._
  29b0: 53 42 5f 53 4c 50 42 0a 80 14 0c 5f 51 33 32 00  SB_SLPB...._Q32.
  29c0: 53 4b 45 59 0a 01 14 0c 5f 51 33 37 00 53 4b 45  SKEY...._Q37.SKE
  29d0: 59 0a 02 14 0c 5f 51 33 33 00 53 4b 45 59 0a 04  Y...._Q33.SKEY..
  29e0: 14 0c 5f 51 33 36 00 53 4b 45 59 0a 08 14 45 0b  .._Q36.SKEY...E.
  29f0: 53 4b 45 59 01 70 0a a7 5c 2f 04 5f 53 42 5f 50  SKEY.p..\/._SB_P
  2a00: 43 49 30 49 53 41 5f 42 43 4d 44 70 68 5c 2f 04  CI0ISA_BCMDph\/.
  2a10: 5f 53 42 5f 50 43 49 30 49 53 41 5f 49 4e 46 4f  _SB_PCI0ISA_INFO
  2a20: 70 00 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41  p.\/._SB_PCI0ISA
  2a30: 5f 44 49 44 5f 70 00 5c 2f 04 5f 53 42 5f 50 43  _DID_p.\/._SB_PC
  2a40: 49 30 49 53 41 5f 53 4d 49 43 5b 21 0a 1e 70 0a  I0ISA_SMIC[!..p.
  2a50: a7 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  2a60: 42 43 4d 44 70 68 5c 2f 04 5f 53 42 5f 50 43 49  BCMDph\/._SB_PCI
  2a70: 30 49 53 41 5f 49 4e 46 4f 70 01 5c 2f 04 5f 53  0ISA_INFOp.\/._S
  2a80: 42 5f 50 43 49 30 49 53 41 5f 44 49 44 5f 70 00  B_PCI0ISA_DID_p.
  2a90: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 53  \/._SB_PCI0ISA_S
  2aa0: 4d 49 43 5b 82 44 0f 50 4e 50 44 08 5f 48 49 44  MIC[.D.PNPD._HID
  2ab0: 0c 41 d0 0c 02 14 43 0e 5f 43 52 53 00 a4 11 4a  .A....C._CRS...J
  2ac0: 0d 0a d6 47 01 d0 04 d0 04 01 02 47 01 10 00 10  ...G.......G....
  2ad0: 00 01 09 47 01 1f 00 1f 00 01 01 47 01 24 00 24  ...G.......G.$.$
  2ae0: 00 01 02 47 01 28 00 28 00 01 02 47 01 2c 00 2c  ...G.(.(...G.,.,
  2af0: 00 01 02 47 01 30 00 30 00 01 02 47 01 34 00 34  ...G.0.0...G.4.4
  2b00: 00 01 02 47 01 38 00 38 00 01 02 47 01 3c 00 3c  ...G.8.8...G.<.<
  2b10: 00 01 02 47 01 50 00 50 00 01 03 47 01 74 00 74  ...G.P.P...G.t.t
  2b20: 00 01 04 47 01 90 00 90 00 01 10 47 01 a4 00 a4  ...G.......G....
  2b30: 00 01 02 47 01 a8 00 a8 00 01 02 47 01 ac 00 ac  ...G.......G....
  2b40: 00 01 02 47 01 b0 00 b0 00 01 02 47 01 b4 00 b4  ...G.......G....
  2b50: 00 01 02 47 01 b8 00 b8 00 01 02 47 01 bc 00 bc  ...G.......G....
  2b60: 00 01 02 47 01 72 00 72 00 01 02 47 01 98 03 98  ...G.r.r...G....
  2b70: 03 01 02 47 01 80 21 80 21 01 10 47 01 00 80 00  ...G..!.!..G....
  2b80: 80 01 40 47 01 00 38 00 38 01 40 86 09 00 00 00  ..@G..8.8.@.....
  2b90: 00 f8 ff 00 00 08 00 79 00 5b 82 38 44 4d 41 43  .......y.[.8DMAC
  2ba0: 08 5f 48 49 44 0c 41 d0 02 00 14 28 5f 43 52 53  ._HID.A....(_CRS
  2bb0: 00 a4 11 20 0a 1d 47 01 00 00 00 00 01 10 47 01  ... ..G.......G.
  2bc0: 81 00 81 00 01 0f 47 01 c0 00 c0 00 01 20 2a 10  ......G...... *.
  2bd0: 01 79 00 5b 82 2e 50 49 43 5f 08 5f 48 49 44 0b  .y.[..PIC_._HID.
  2be0: 41 d0 14 20 5f 43 52 53 00 a4 11 18 0a 15 47 01  A.. _CRS......G.
  2bf0: 20 00 20 00 01 02 47 01 a0 00 a0 00 01 02 22 04   . ...G.......".
  2c00: 00 79 00 5b 82 28 54 49 4d 45 08 5f 48 49 44 0c  .y.[.(TIME._HID.
  2c10: 41 d0 01 00 14 18 5f 43 52 53 00 a4 11 10 0a 0d  A....._CRS......
  2c20: 47 01 40 00 40 00 01 04 22 01 00 79 00 5b 82 28  G.@.@..."..y.[.(
  2c30: 52 54 43 5f 08 5f 48 49 44 0c 41 d0 0b 00 14 18  RTC_._HID.A.....
  2c40: 5f 43 52 53 00 a4 11 10 0a 0d 47 01 70 00 70 00  _CRS......G.p.p.
  2c50: 01 02 22 00 01 79 00 5b 82 3a 4b 42 43 5f 08 5f  .."..y.[.:KBC_._
  2c60: 48 49 44 0c 41 d0 03 03 14 20 5f 43 52 53 00 a4  HID.A.... _CRS..
  2c70: 11 18 0a 15 47 01 60 00 60 00 01 01 47 01 64 00  ....G.`.`...G.d.
  2c80: 64 00 01 01 22 02 00 79 00 14 09 5f 53 54 41 00  d..."..y..._STA.
  2c90: a4 0a 0f 5b 82 28 4d 41 54 48 08 5f 48 49 44 0c  ...[.(MATH._HID.
  2ca0: 41 d0 0c 04 14 18 5f 43 52 53 00 a4 11 10 0a 0d  A....._CRS......
  2cb0: 47 01 f0 00 f0 00 01 10 22 00 20 79 00 5b 82 25  G.......". y.[.%
  2cc0: 53 50 4b 5f 08 5f 48 49 44 0c 41 d0 08 00 14 15  SPK_._HID.A.....
  2cd0: 5f 43 52 53 00 a4 11 0d 0a 0a 47 01 61 00 61 00  _CRS......G.a.a.
  2ce0: 01 01 79 00 5b 82 1d 4d 4f 55 45 08 5f 48 49 44  ..y.[..MOUE._HID
  2cf0: 0c 41 d0 0f 13 08 5f 43 52 53 11 08 0a 05 22 00  .A...._CRS....".
  2d00: 10 79 00 5b 80 41 43 42 5f 00 0c bc fe ff 0f 0c  .y.[.ACB_.......
  2d10: 00 01 00 00 5b 81 2a 41 43 42 5f 00 42 43 4d 44  ....[.*ACB_.BCMD
  2d20: 08 44 49 44 5f 20 49 4e 46 4f 40 65 54 47 4f 30  .DID_ INFO@eTGO0
  2d30: 08 54 47 4f 31 08 54 47 4f 32 08 54 47 4f 33 08  .TGO1.TGO2.TGO3.
  2d40: 5b 81 0f 41 43 42 5f 00 00 08 00 20 49 4e 46 5f  [..ACB_.... INF_
  2d50: 08 5b 80 53 4d 49 42 01 0c 00 fe 00 00 0c 02 00  .[.SMIB.........
  2d60: 00 00 5b 81 0b 53 4d 49 42 00 53 4d 49 43 08 08  ..[..SMIB.SMIC..
  2d70: 42 55 46 46 11 15 0a 12 47 01 78 03 78 03 08 08  BUFF....G.x.x...
  2d80: 47 01 78 07 78 07 08 08 79 00 5b 82 40 0c 4c 50  G.x.x...y.[.@.LP
  2d90: 54 5f 08 4d 43 44 5f 0a 13 08 5f 48 49 44 0c 41  T_.MCD_..._HID.A
  2da0: d0 04 00 14 2c 5f 43 52 53 00 a0 1e 5f 53 54 41  ....,_CRS..._STA
  2db0: 70 0a 00 42 43 4d 44 70 0a 13 44 49 44 5f 70 00  p..BCMDp..DID_p.
  2dc0: 53 4d 49 43 a4 49 4e 46 4f a1 06 a4 42 55 46 46  SMIC.INFO...BUFF
  2dd0: 14 20 42 5f 53 52 01 70 0a 01 42 43 4d 44 70 0a  . B_SR.p..BCMDp.
  2de0: 13 44 49 44 5f 70 68 49 4e 46 4f 70 00 53 4d 49  .DID_phINFOp.SMI
  2df0: 43 14 1f 42 5f 50 52 00 70 0a 02 42 43 4d 44 70  C..B_PR.p..BCMDp
  2e00: 0a 13 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e 46  ..DID_p.SMIC.INF
  2e10: 4f 14 1a 42 5f 44 49 00 70 0a 03 42 43 4d 44 70  O..B_DI.p..BCMDp
  2e20: 0a 13 44 49 44 5f 70 00 53 4d 49 43 14 1f 5f 53  ..DID_p.SMIC.._S
  2e30: 54 41 00 70 0a 04 42 43 4d 44 70 0a 13 44 49 44  TA.p..BCMDp..DID
  2e40: 5f 70 00 53 4d 49 43 a4 49 4e 46 5f 5b 82 40 0c  _p.SMIC.INF_[.@.
  2e50: 4c 50 54 42 08 4d 43 44 5f 0a 14 08 5f 48 49 44  LPTB.MCD_..._HID
  2e60: 0c 41 d0 04 00 14 2c 5f 43 52 53 00 a0 1e 5f 53  .A....,_CRS..._S
  2e70: 54 41 70 0a 00 42 43 4d 44 70 0a 14 44 49 44 5f  TAp..BCMDp..DID_
  2e80: 70 00 53 4d 49 43 a4 49 4e 46 4f a1 06 a4 42 55  p.SMIC.INFO...BU
  2e90: 46 46 14 20 5f 53 52 53 01 70 0a 01 42 43 4d 44  FF. _SRS.p..BCMD
  2ea0: 70 0a 14 44 49 44 5f 70 68 49 4e 46 4f 70 00 53  p..DID_phINFOp.S
  2eb0: 4d 49 43 14 1f 5f 50 52 53 00 70 0a 02 42 43 4d  MIC.._PRS.p..BCM
  2ec0: 44 70 0a 14 44 49 44 5f 70 00 53 4d 49 43 a4 49  Dp..DID_p.SMIC.I
  2ed0: 4e 46 4f 14 1a 5f 44 49 53 00 70 0a 03 42 43 4d  NFO.._DIS.p..BCM
  2ee0: 44 70 0a 14 44 49 44 5f 70 00 53 4d 49 43 14 1f  Dp..DID_p.SMIC..
  2ef0: 5f 53 54 41 00 70 0a 04 42 43 4d 44 70 0a 14 44  _STA.p..BCMDp..D
  2f00: 49 44 5f 70 00 53 4d 49 43 a4 49 4e 46 5f 5b 82  ID_p.SMIC.INF_[.
  2f10: 40 0c 45 43 50 5f 08 4d 43 44 5f 0a 0f 08 5f 48  @.ECP_.MCD_..._H
  2f20: 49 44 0c 41 d0 04 01 14 2c 5f 43 52 53 00 a0 1e  ID.A....,_CRS...
  2f30: 5f 53 54 41 70 0a 00 42 43 4d 44 70 0a 0f 44 49  _STAp..BCMDp..DI
  2f40: 44 5f 70 00 53 4d 49 43 a4 49 4e 46 4f a1 06 a4  D_p.SMIC.INFO...
  2f50: 42 55 46 46 14 20 42 5f 53 52 01 70 0a 01 42 43  BUFF. B_SR.p..BC
  2f60: 4d 44 70 0a 0f 44 49 44 5f 70 68 49 4e 46 4f 70  MDp..DID_phINFOp
  2f70: 00 53 4d 49 43 14 1f 42 5f 50 52 00 70 0a 02 42  .SMIC..B_PR.p..B
  2f80: 43 4d 44 70 0a 0f 44 49 44 5f 70 00 53 4d 49 43  CMDp..DID_p.SMIC
  2f90: a4 49 4e 46 4f 14 1a 42 5f 44 49 00 70 0a 03 42  .INFO..B_DI.p..B
  2fa0: 43 4d 44 70 0a 0f 44 49 44 5f 70 00 53 4d 49 43  CMDp..DID_p.SMIC
  2fb0: 14 1f 5f 53 54 41 00 70 0a 04 42 43 4d 44 70 0a  .._STA.p..BCMDp.
  2fc0: 0f 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e 46 5f  .DID_p.SMIC.INF_
  2fd0: 5b 82 40 0c 45 50 50 5f 08 4d 43 44 5f 0a 0e 08  [.@.EPP_.MCD_...
  2fe0: 5f 48 49 44 0c 41 d0 04 00 14 2c 5f 43 52 53 00  _HID.A....,_CRS.
  2ff0: a0 1e 5f 53 54 41 70 0a 00 42 43 4d 44 70 0a 0e  .._STAp..BCMDp..
  3000: 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e 46 4f a1  DID_p.SMIC.INFO.
  3010: 06 a4 42 55 46 46 14 20 42 5f 53 52 01 70 0a 01  ..BUFF. B_SR.p..
  3020: 42 43 4d 44 70 0a 0e 44 49 44 5f 70 68 49 4e 46  BCMDp..DID_phINF
  3030: 4f 70 00 53 4d 49 43 14 1f 42 5f 50 52 00 70 0a  Op.SMIC..B_PR.p.
  3040: 02 42 43 4d 44 70 0a 0e 44 49 44 5f 70 00 53 4d  .BCMDp..DID_p.SM
  3050: 49 43 a4 49 4e 46 4f 14 1a 42 5f 44 49 00 70 0a  IC.INFO..B_DI.p.
  3060: 03 42 43 4d 44 70 0a 0e 44 49 44 5f 70 00 53 4d  .BCMDp..DID_p.SM
  3070: 49 43 14 1f 5f 53 54 41 00 70 0a 04 42 43 4d 44  IC.._STA.p..BCMD
  3080: 70 0a 0e 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e  p..DID_p.SMIC.IN
  3090: 46 5f 5b 82 47 0c 43 4f 4d 41 08 4d 43 44 5f 0a  F_[.G.COMA.MCD_.
  30a0: 0c 08 5f 48 49 44 0c 41 d0 05 01 08 5f 55 49 44  .._HID.A...._UID
  30b0: 0a 01 14 2c 5f 43 52 53 00 a0 1e 5f 53 54 41 70  ...,_CRS..._STAp
  30c0: 0a 00 42 43 4d 44 70 0a 0c 44 49 44 5f 70 00 53  ..BCMDp..DID_p.S
  30d0: 4d 49 43 a4 49 4e 46 4f a1 06 a4 42 55 46 46 14  MIC.INFO...BUFF.
  30e0: 20 5f 53 52 53 01 70 0a 01 42 43 4d 44 70 0a 0c   _SRS.p..BCMDp..
  30f0: 44 49 44 5f 70 68 49 4e 46 4f 70 00 53 4d 49 43  DID_phINFOp.SMIC
  3100: 14 1f 5f 50 52 53 00 70 0a 02 42 43 4d 44 70 0a  .._PRS.p..BCMDp.
  3110: 0c 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e 46 4f  .DID_p.SMIC.INFO
  3120: 14 1a 5f 44 49 53 00 70 0a 03 42 43 4d 44 70 0a  .._DIS.p..BCMDp.
  3130: 0c 44 49 44 5f 70 00 53 4d 49 43 14 1f 5f 53 54  .DID_p.SMIC.._ST
  3140: 41 00 70 0a 04 42 43 4d 44 70 0a 0c 44 49 44 5f  A.p..BCMDp..DID_
  3150: 70 00 53 4d 49 43 a4 49 4e 46 5f 5b 82 47 0c 43  p.SMIC.INF_[.G.C
  3160: 4f 4d 42 08 4d 43 44 5f 0a 12 08 5f 48 49 44 0c  OMB.MCD_..._HID.
  3170: 41 d0 05 00 08 5f 55 49 44 0a 02 14 2c 5f 43 52  A...._UID...,_CR
  3180: 53 00 a0 1e 5f 53 54 41 70 0a 00 42 43 4d 44 70  S..._STAp..BCMDp
  3190: 0a 12 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e 46  ..DID_p.SMIC.INF
  31a0: 4f a1 06 a4 42 55 46 46 14 20 42 5f 53 52 01 70  O...BUFF. B_SR.p
  31b0: 0a 01 42 43 4d 44 70 0a 12 44 49 44 5f 70 68 49  ..BCMDp..DID_phI
  31c0: 4e 46 4f 70 00 53 4d 49 43 14 1f 42 5f 50 52 00  NFOp.SMIC..B_PR.
  31d0: 70 0a 02 42 43 4d 44 70 0a 12 44 49 44 5f 70 00  p..BCMDp..DID_p.
  31e0: 53 4d 49 43 a4 49 4e 46 4f 14 1a 42 5f 44 49 00  SMIC.INFO..B_DI.
  31f0: 70 0a 03 42 43 4d 44 70 0a 12 44 49 44 5f 70 00  p..BCMDp..DID_p.
  3200: 53 4d 49 43 14 1f 5f 53 54 41 00 70 0a 04 42 43  SMIC.._STA.p..BC
  3210: 4d 44 70 0a 12 44 49 44 5f 70 00 53 4d 49 43 a4  MDp..DID_p.SMIC.
  3220: 49 4e 46 5f 5b 82 47 0c 49 52 44 41 08 4d 43 44  INF_[.G.IRDA.MCD
  3230: 5f 0a 10 08 5f 48 49 44 0c 41 d0 05 10 08 5f 55  _..._HID.A...._U
  3240: 49 44 0a 02 14 2c 5f 43 52 53 00 a0 1e 5f 53 54  ID...,_CRS..._ST
  3250: 41 70 0a 00 42 43 4d 44 70 0a 10 44 49 44 5f 70  Ap..BCMDp..DID_p
  3260: 00 53 4d 49 43 a4 49 4e 46 4f a1 06 a4 42 55 46  .SMIC.INFO...BUF
  3270: 46 14 20 42 5f 53 52 01 70 0a 01 42 43 4d 44 70  F. B_SR.p..BCMDp
  3280: 0a 10 44 49 44 5f 70 68 49 4e 46 4f 70 00 53 4d  ..DID_phINFOp.SM
  3290: 49 43 14 1f 42 5f 50 52 00 70 0a 02 42 43 4d 44  IC..B_PR.p..BCMD
  32a0: 70 0a 10 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e  p..DID_p.SMIC.IN
  32b0: 46 4f 14 1a 42 5f 44 49 00 70 0a 03 42 43 4d 44  FO..B_DI.p..BCMD
  32c0: 70 0a 10 44 49 44 5f 70 00 53 4d 49 43 14 1f 5f  p..DID_p.SMIC.._
  32d0: 53 54 41 00 70 0a 04 42 43 4d 44 70 0a 10 44 49  STA.p..BCMDp..DI
  32e0: 44 5f 70 00 53 4d 49 43 a4 49 4e 46 5f 5b 82 47  D_p.SMIC.INF_[.G
  32f0: 0c 46 49 52 5f 08 4d 43 44 5f 0a 0d 08 5f 48 49  .FIR_.MCD_..._HI
  3300: 44 0c 3a 63 60 01 08 5f 55 49 44 0a 02 14 2c 5f  D.:c`.._UID...,_
  3310: 43 52 53 00 a0 1e 5f 53 54 41 70 0a 00 42 43 4d  CRS..._STAp..BCM
  3320: 44 70 0a 0d 44 49 44 5f 70 00 53 4d 49 43 a4 49  Dp..DID_p.SMIC.I
  3330: 4e 46 4f a1 06 a4 42 55 46 46 14 20 5f 53 52 53  NFO...BUFF. _SRS
  3340: 01 70 0a 01 42 43 4d 44 70 0a 0d 44 49 44 5f 70  .p..BCMDp..DID_p
  3350: 68 49 4e 46 4f 70 00 53 4d 49 43 14 1f 5f 50 52  hINFOp.SMIC.._PR
  3360: 53 00 70 0a 02 42 43 4d 44 70 0a 0d 44 49 44 5f  S.p..BCMDp..DID_
  3370: 70 00 53 4d 49 43 a4 49 4e 46 4f 14 1a 5f 44 49  p.SMIC.INFO.._DI
  3380: 53 00 70 0a 03 42 43 4d 44 70 0a 0d 44 49 44 5f  S.p..BCMDp..DID_
  3390: 70 00 53 4d 49 43 14 1f 5f 53 54 41 00 70 0a 04  p.SMIC.._STA.p..
  33a0: 42 43 4d 44 70 0a 0d 44 49 44 5f 70 00 53 4d 49  BCMDp..DID_p.SMI
  33b0: 43 a4 49 4e 46 5f 5b 82 4a 0b 46 44 43 5f 08 4d  C.INF_[.J.FDC_.M
  33c0: 43 44 5f 0a 15 08 5f 48 49 44 0c 41 d0 07 00 14  CD_..._HID.A....
  33d0: 2c 5f 43 52 53 00 a0 1e 5f 53 54 41 70 0a 00 42  ,_CRS..._STAp..B
  33e0: 43 4d 44 70 0a 15 44 49 44 5f 70 00 53 4d 49 43  CMDp..DID_p.SMIC
  33f0: a4 49 4e 46 4f a1 06 a4 42 55 46 46 14 20 5f 53  .INFO...BUFF. _S
  3400: 52 53 01 70 0a 01 42 43 4d 44 70 0a 15 44 49 44  RS.p..BCMDp..DID
  3410: 5f 70 68 49 4e 46 4f 70 00 53 4d 49 43 14 1f 5f  _phINFOp.SMIC.._
  3420: 50 52 53 00 70 0a 02 42 43 4d 44 70 0a 15 44 49  PRS.p..BCMDp..DI
  3430: 44 5f 70 00 53 4d 49 43 a4 49 4e 46 4f 14 14 5f  D_p.SMIC.INFO.._
  3440: 44 49 53 00 70 0a 03 42 43 4d 44 70 0a 15 44 49  DIS.p..BCMDp..DI
  3450: 44 5f 14 1f 5f 53 54 41 00 70 0a 04 42 43 4d 44  D_.._STA.p..BCMD
  3460: 70 0a 15 44 49 44 5f 70 00 53 4d 49 43 a4 49 4e  p..DID_p.SMIC.IN
  3470: 46 5f 5b 82 1b 55 53 42 30 08 5f 41 44 52 0c 02  F_[..USB0._ADR..
  3480: 00 07 00 08 5f 50 52 57 12 06 02 0a 08 0a 01 5b  ...._PRW.......[
  3490: 82 20 43 42 43 30 08 5f 41 44 52 0c 00 00 0a 00  . CBC0._ADR.....
  34a0: 14 09 5f 53 54 41 00 a4 0a 0f 14 06 5f 49 4e 49  .._STA......_INI
  34b0: 00 5b 82 45 0e 50 58 34 33 08 5f 41 44 52 0c 03  .[.E.PX43._ADR..
  34c0: 00 07 00 5b 80 52 45 53 41 02 0a 5c 0a 04 10 4a  ...[.RESA..\...J
  34d0: 04 5c 00 5b 81 44 04 5c 2f 04 5f 53 42 5f 50 43  .\.[.D.\/._SB_PC
  34e0: 49 30 50 58 34 33 52 45 53 41 03 41 31 45 4e 01  I0PX43RESA.A1EN.
  34f0: 41 31 41 44 02 41 32 45 4e 01 00 01 41 32 41 44  A1AD.A2EN...A2AD
  3500: 02 41 33 45 4e 01 41 33 41 44 02 00 0f 41 30 45  .A3EN.A3AD...A0E
  3510: 4e 01 00 05 4c 30 45 4e 01 5b 80 52 45 53 42 02  N...L0EN.[.RESB.
  3520: 0a 60 0a 04 10 32 5c 00 5b 81 2d 5c 2f 04 5f 53  .`...2\.[.-\/._S
  3530: 42 5f 50 43 49 30 50 58 34 33 52 45 53 42 03 47  B_PCI0PX43RESB.G
  3540: 39 41 44 10 00 09 4c 30 41 44 03 46 30 41 44 01  9AD...L0AD.F0AD.
  3550: 46 30 45 4e 01 00 02 5b 80 52 45 53 43 02 0a 64  F0EN...[.RESC..d
  3560: 0a 04 10 35 5c 00 5b 81 30 5c 2f 04 5f 53 42 5f  ...5\.[.0\/._SB_
  3570: 50 43 49 30 50 58 34 33 52 45 53 43 03 47 41 41  PCI0PX43RESC.GAA
  3580: 44 10 00 08 55 30 41 44 03 55 30 45 4e 01 55 31  D...U0AD.U0EN.U1
  3590: 41 44 03 55 31 45 4e 01                          AD.U1EN.

FACS @ 0xfffffc0
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS@...........
  0010: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

FACP @ 0xffffb65
  0000: 46 41 43 50 74 00 00 00 01 d7 41 53 55 53 20 20  FACPt.....ASUS  
  0010: 4c 38 34 30 30 42 20 20 01 00 04 06 50 54 4c 20  L8400B  ....PTL 
  0020: 40 42 0f 00 c0 ff ff 0f cd c5 ff 0f 00 00 09 00  @B..............
  0030: b2 00 00 00 f0 f1 f2 00 00 80 00 00 00 00 00 00  ................
  0040: 04 80 00 00 00 00 00 00 00 00 00 00 08 80 00 00  ................
  0050: 0c 80 00 00 00 00 00 00 04 02 00 04 04 00 00 00  ................
  0060: 64 00 e8 03 00 00 00 00 02 02 0d 00 32 00 00 00  d...........2...
  0070: 25 00 00 00                                      %...

BOOT @ 0xffffbd9
  0000: 42 4f 4f 54 27 00 00 00 01 a4 50 54 4c 54 44 20  BOOT'.....PTLTD 
  0010: 24 53 42 46 54 42 4c 24 01 00 04 06 20 4c 54 50  $SBFTBL$.... LTP
  0020: 01 00 00 00 37 00 00                             ....7..

RSDT @ 0xfffc5a1
  0000: 52 53 44 54 2c 00 00 00 01 c6 50 54 4c 54 44 20  RSDT,.....PTLTD 
  0010: 20 20 52 53 44 54 20 20 01 00 04 06 20 4c 54 50    RSDT  .... LTP
  0020: 00 00 00 00 65 fb ff 0f d9 fb ff 0f              ....e.......

RSD PTR @ 0xf7050
  0000: 52 53 44 20 50 54 52 20 c5 50 54 4c 54 44 20 00  RSD PTR .PTLTD .
  0010: a1 c5 ff 0f                                      ....


------=_Part_22344_11166728.1133732425355
Content-Type: text/plain; name=lspci.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci.txt"

0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1040
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: f0000000-f7ffffff
	Prefetchable memory behind bridge: 28000000-280fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

0000:00:06.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1049
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.1 Communication controller: ESS Technology ESS Modem (rev 12)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1049
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at f400 [disabled] [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcf0 [size=16]

0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at fcc0 [size=32]

0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

0000:00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1045
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at f000 [size=256]
	Region 1: Memory at fedffc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1044
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 28100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1044
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at 28101000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 24000000-25fff000 (prefetchable)
	Memory window 1: 26000000-27fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-MV (rev 12) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1042
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 28000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=<none>


------=_Part_22344_11166728.1133732425355
Content-Type: text/plain; name=interrupts.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="interrupts.txt"

           CPU0       
  0:    6324789          XT-PIC  timer
  1:       3397          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:          0          XT-PIC  parport0
  8:         56          XT-PIC  rtc
  9:     400054          XT-PIC  acpi, uhci_hcd:usb1, yenta, yenta, eth0
 10:        610          XT-PIC  Allegro
 12:        110          XT-PIC  i8042
 14:      84690          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

------=_Part_22344_11166728.1133732425355--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
