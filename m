From: Valerio Felici <valerio-3NZjWNnCfY8@public.gmane.org>
Subject: Re: Error in dsdt from asus a3527nuh
Date: Thu, 11 Nov 2004 17:58:17 +0100
Message-ID: <200411111758.17113.valerio@bgweb.it>
References: <3ACA40606221794F80A5670F0AF15F84041AC059@pdsmsx403>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_po5kBgw8WPqY9Re"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC059@pdsmsx403>
Content-Disposition: inline
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


--Boundary-00=_po5kBgw8WPqY9Re
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 16:07, gioved=A8=AC 11 novembre 2004, hai scritto:
> kill acpid can solve the "Device or resource busy" issue.
>
Why? Perhaps it conflicts with asus_acpi module ?
However that you say is true, now I can see events from cat /proc/acpi/event
But I still don't understand why.

> Please post dmesg to let me check if ACPI interpreter
> is good enough to catch the possible DSDT fault.
>
You can see it in attachment

> To verify if there are any other issues, you need
> to verfy kernel works well on this laptop, such
> as power off work,=20
Yes

> battery work,=20
Yes

> suspend/resume work, =20
> thermal zone work, C-state, P-state work,...
>
Sorry, I'm not sure on how to test that, where I can read about that ?

Many thanks.
=2D-=20
A presto
=2DValerio-

--Boundary-00=_po5kBgw8WPqY9Re
Content-Type: text/plain;
  charset="gb2312";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B9
 12 001 01  1    1    0   1   0    1    1    B1
 13 001 01  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    C9
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S3 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4588 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
vesafb: framebuffer at 0xf0000000, mapped to 0xf002b000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N060ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA ODD-DVD SD-R6372, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
VFS: Can't find ext3 filesystem on dev hda6.
VFS: Can't find ext2 filesystem on dev hda6.
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
Adding 1461868k swap on /dev/hda5.  Priority:-1 extents:1
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ieee1394: Initialized config rom entry `ip1394'
SCSI subsystem initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Asus Laptop ACPI Extras version 0.28
unsupported, trying default values, supply the developers with your DSDT
Capability LSM initialized
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
ReiserFS: dm-5: found reiserfs format "3.6" with standard journal
ReiserFS: dm-5: using ordered data mode
ReiserFS: dm-5: journal params: device dm-5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-5: checking transaction log (dm-5)
ReiserFS: dm-5: Using r5 hash to sort names
ReiserFS: dm-4: found reiserfs format "3.6" with standard journal
ReiserFS: dm-4: using ordered data mode
ReiserFS: dm-4: journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-4: checking transaction log (dm-4)
ReiserFS: dm-4: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:01:05.0 [1043:1894]
Yenta: ISA IRQ mask 0x0000, PCI irq 17
Socket status: 30000006
Yenta: CardBus bridge found at 0000:01:05.1 [1043:1894]
Yenta: ISA IRQ mask 0x0000, PCI irq 16
Socket status: 30000006
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[fe8ff800-fe8fffff]  Max Packet=[2048]
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xc800, 00:11:2f:a3:9d:84, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f0a52c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000320b082]
usb 1-4: new high speed USB device using address 2
ip1394: $Rev: 1224 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Real Time Clock Driver v1.12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
ts: Compaq touchscreen protocol output
mice: PS/2 mouse device common for all mice
input: PC Speaker
irda_init()
NET: Registered protocol family 23
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 682M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000d480
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000d800
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000d880
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-2: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
intel8x0_measure_ac97_clock: measured 49654 usecs
intel8x0: clocking to 48000
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_write 0: semaphore is not ready for register 0x2
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ieee80211_crypt: registered algorithm 'NULL'
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 0.12
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
eth0: link down
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC0] (on-line)
ACPI: Processor [CPU1] (supports C1 C2 C3, 8 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Thermal Zone [THRM] (41 C)
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: excluding 0xc00-0xc07
cs: IO port probe 0x0a00-0x0aff: clean.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02f4780(lo)
IPv6 over IPv4 tunneling driver
eth2: duplicate address detected!
[drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82852/855GM Integrated Graphics Device
[drm] Initialized i830 1.3.2 20021108 on minor 1: Intel Corp. 82852/855GM Integrated Graphics Device (#2)
mtrr: base(0xf0020000) is not aligned on a size(0x300000) boundary
eth0: no IPv6 routers present
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x32

--Boundary-00=_po5kBgw8WPqY9Re--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
