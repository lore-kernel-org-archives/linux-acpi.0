From: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Subject: vaio pcg-v505ap
Date: 07 Jul 2003 12:24:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1057573470.983.17.camel@lana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iJv1xEPEUTTrKi6+dhxi"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-iJv1xEPEUTTrKi6+dhxi
Content-Type: multipart/mixed; boundary="=-N3WIrqXMzGxKZvz4J53F"


--=-N3WIrqXMzGxKZvz4J53F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi *,

my old asus S1300 died and i am experimenting with a new sony vaio
pcg-v505ap. i am having a little problem that i don't know if can be
caused by acpi. i'll try to explain with as much information as i can
and i'll attach dmesg log and dsdt table to this mail and hope... :)

basically both when using an external usb mouse or the builtin touchpad
the left button gets "stuck" even when not actively using the mouse.
e.g., i am writing in emacs and i get a selection or i am moving the
mouse and windows get moved or shaded as if someone was clicking like
fool. this stops when i click the left button once.

the problem gets worse as devices using the same irq are used. heavy
network traffic makes the problem worser.  also note that this vaio
assigns *everything* to irq 9, but i don't know if this is the problem.

dmesg show two problems, imho:

Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
schedule_task(): keventd has not started
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)

and:

ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
 pci_irq-0297 [23] acpi_pci_irq_derive   : Unable to derive IRQ for
device 00:1f.1
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255

sorry for providing so little information on a problem that can be
completely independent from acpi.=20

thank you very much,
federico







--=-N3WIrqXMzGxKZvz4J53F
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=iso-8859-15

Linux version 2.4.22-pre3 (root@lana) (gcc version 3.3.1 20030626 (Debian p=
rerelease)) #2 Mon Jul 7 10:58:31 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65408
zone(0): 4096 pages.
zone(1): 61312 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f73d0
ACPI: RSDT (v001   SONY       B2 08194.04633) @ 0x0fefb275
ACPI: FADT (v002   SONY       B2 08194.04633) @ 0x0fefed8b
ACPI: BOOT (v001   SONY       B2 08194.04633) @ 0x0fefee0f
ACPI: SSDT (v001   SONY       B2 08194.04633) @ 0x0fefee37
ACPI: SSDT (v001   SONY       B2 08194.04633) @ 0x0fefef1e
ACPI: DSDT (v001   SONY       B2 08194.04633) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Sony Vaio laptop detected.
Kernel command line: BOOT_IMAGE=3DDebian-2.4.22p3 ro root=3D306 hdc=3Dide-s=
csi pci=3Dbiosirq
ide_setup: hdc=3Dide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1988.580 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3945.26 BogoMIPS
Memory: 255988k/261632k available (1469k kernel code, 5188k reserved, 549k =
data, 104k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfd9ca, last bus=3D2
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control Methods:...............................................=
...........................................................................=
................
Table [DSDT](id F006) - 459 Objects with 47 Devices 138 Methods 17 Regions
Parsing all Control Methods:.
Table [SSDT](id F004) - 3 Objects with 0 Devices 1 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id F003) - 2 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c0325a5c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 00=
00000000001028 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 00=
0000000000102C on int 9
Completing Region/Field/Buffer/Package initialization:.....................=
...........................................
Initialized 16/17 Regions 0/0 Fields 22/22 Buffers 26/26 Packages (472 node=
s)
Executing all Device _STA and_INI methods:.................................=
...............
48 Devices found containing: 48 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
schedule_task(): keventd has not started
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
pci_link-0187 [22] acpi_pci_link_check_cu: Blank IRQ resource
pci_link-0252 [21] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 9, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
 pci_irq-0297 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:1f.1
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports C1 C2, 2 performance states, 8 throttling =
states)
ACPI: Thermal Zone [ATF0] (58 C)
radeonfb: ref_clk=3D2700, ref_div=3D60, xclk=3D14375 from BIOS
radeonfb: panel ID string: 1024x768               =20
radeonfb: detected DFP panel size from BIOS: 1024x768
Console: switching to colour frame buffer device 128x48
radeonfb: ATI Radeon M6 LY  DDR SGRAM 16 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller, 08:=
00:46:99:28:A0, IRQ 9.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xec000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
 pci_irq-0297 [26] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:1f.1
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
blk: queue c033b3c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=3D4864/255/63, UDMA(1=
00)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
usb.c: registered new driver hub
Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000006
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 104k freed
Adding Swap: 497972k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA745 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
usb-uhci.c: $Revision: 1.275 $ time 10:58:50 Jul  7 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usbmouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Intel 810 + AC97 Audio, version 0.24, 10:55:03 Jul  7 2003
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, MEM 0x0000 and 0x0000, IRQ =
9
hub.c: new USB device 00:1d.1-1, assigned address 2
input0: B16_b_02 USB-PS/2 Optical Mouse on usb2:2.0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: YMH3 (Unknown)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 supports AMAP, total channels =3D 2
hub.c: new USB device 00:1d.2-1, assigned address 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Sony      Model: MSC-U03           Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
klips_info:ipsec_init: KLIPS startup, FreeS/WAN IPSec version: 2.00

[drm] AGP 0.99 aperture @ 0xec000000 64MB
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12

--=-N3WIrqXMzGxKZvz4J53F
Content-Disposition: attachment; filename=DSDT.dump.gz
Content-Type: application/x-gzip; name=DSDT.dump.gz
Content-Transfer-Encoding: base64

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

--=-N3WIrqXMzGxKZvz4J53F
Content-Disposition: attachment; filename=pspci
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=pspci; charset=iso-8859-15

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge =
(rev 04)
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, fast devsel, latency 0
	Memory at ec000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (r=
ev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 96
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog=
-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1800 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog=
-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1820 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog=
-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1840 [size=3D32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 0=
0 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: e8200000-e82fffff
	Prefetchable memory behind bridge: f8000000-f80fffff

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [=
Master SecP PriP])
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 0, IRQ 255
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 1860 [size=3D16]
	Memory at e8000000 (32-bit, non-prefetchable) [size=3D1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: medium devsel, IRQ 9
	I/O ports at 1880 [size=3D32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (r=
ev 02)
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1c00 [size=3D256]
	I/O ports at 18c0 [size=3D64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [Ge=
neric])
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 2400 [size=3D256]
	I/O ports at 2000 [size=3D128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 =
LY (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency=
 66, IRQ 9
	Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	I/O ports at 3000 [size=3D256]
	Memory at e8100000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: <available only to root>

02:02.0 Network controller: Harris Semiconductor: Unknown device 3872 (rev =
01)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0202
	Flags: medium devsel, IRQ 9
	Memory at f8000000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: <available only to root>

02:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev b8)
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	16-bit legacy interface ports at 0001

02:05.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C551 IEEE 1394 Controller (pro=
g-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at e8201000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: <available only to root>

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) E=
thernet Controller (rev 42)
	Subsystem: Sony Corporation: Unknown device 8138
	Flags: bus master, medium devsel, latency 66, IRQ 9
	Memory at e8200000 (32-bit, non-prefetchable) [size=3D4K]
	I/O ports at 4000 [size=3D64]
	Capabilities: <available only to root>


--=-N3WIrqXMzGxKZvz4J53F--

--=-iJv1xEPEUTTrKi6+dhxi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Questa parte del messaggio =?ISO-8859-1?Q?=E8?= firmata

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CUpevcCgrgZGjesRAlUvAJ9nJKNZIfKsGE0MfesQqSGxNQEOGQCfTM0v
yMacfKlZ8wIlxI0zF9slRHA=
=bDfs
-----END PGP SIGNATURE-----

--=-iJv1xEPEUTTrKi6+dhxi--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
