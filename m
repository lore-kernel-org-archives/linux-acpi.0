From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Docking support?
Date: Mon, 11 Jun 2007 11:42:19 +0200
Message-ID: <20070611094219.GA3744@implementation.labri.fr>
References: <20070608104706.GA10553@implementation> <20070608090733.b737c1a1.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iona.labri.fr ([147.210.8.143]:57199 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbXFKJmW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2007 05:42:22 -0400
Content-Disposition: inline
In-Reply-To: <20070608090733.b737c1a1.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

Kristen Carlson Accardi, le Fri 08 Jun 2007 09:07:33 -0700, a écrit :
> > However, when I put my laptop back on the docking station, nothing seems
> > to happen.  Do I need to echo something on /proc or something else?
> 
> This should just work without you needing to echo anything.

$ uname -a
Linux implementation 2.6.22-rc4-mm2 #1 Sun Jun 10 16:31:07 CEST 2007 i686 GNU/Linux

When pressing the undock button, dmesg gives
ACPI: undocking
usb 1-3: USB disconnect, address 2
psmouse.c: bad data from KBC - timeout

When physically undocking, dmesg gives
tg3: eth0: Link is down.

When physically redocking, dmesg gives
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.

Nothing more, my mouse and keyboard don't work back.

Note: /sys/devices/platform/dock.0/docked always report me '1', and when
using echo 1 > /sys/devices/platform/dock.0/undock for undocking
(instead of pressing the button), the command doesn't return.  Maybe
acpi somehow doesn't manage to finish the undocking (hence can't
redock).

This is a Dell Latitude X300
00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01)
02:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
02:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
02:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 04)
02:04.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
02:05.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M Gigabit Ethernet (rev 01)

dmesg attached

Samuel

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

CPI: ACPI Dock Station Driver 
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #07 (-#0a) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *5)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
libata version 2.21 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:04: iomem range 0xfec10000-0xfec1ffff could not be reserved
Time: tsc clocksource has been installed.
PCI: Bus 3, cardbus bridge: 0000:02:03.0
  IO window: 00003000-000030ff
  IO window: 00003400-000034ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 3c000000-3fffffff
PCI: Bus 7, cardbus bridge: 0000:02:03.1
  IO window: 00003800-000038ff
  IO window: 00003c00-00003cff
  PREFETCH window: 34000000-37ffffff
  MEM window: 40000000-43ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: e0200000-e02fffff
  PREFETCH window: 30000000-37ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:02:03.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:02:03.0 to 64
PCI: Enabling device 0000:02:03.1 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:03.1[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:02:03.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x38 set to 0x1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
input: Power Button (FF) as /devices/virtual/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /devices/virtual/input/input1
ACPI: Lid Switch [LID0]
input: Sleep Button (CM) as /devices/virtual/input/input2
ACPI: Sleep Button (CM) [SLPB]
input: Power Button (CM) as /devices/virtual/input/input3
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN0] (on)
ACPI Exception (processor_throttling-0084): AE_NOT_FOUND, Evaluating _PTC [20070126]
ACPI Exception (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070126]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (43 C)
isapnp: Scanning for PnP cards...
Switched to high resolution mode on CPU 0
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
intel_rng: FWH not detected
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: suspend/resume problematic: resume with 3D/DRI active may lockup X.Org
on some chipset/BIOS combos (see DEBUG_AGP_PM in intel-agp.c)
agpgart: Detected an Intel 855GM Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: HTS548040M9AT00, ATA DISK drive
hda: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 78140160 sectors (40007 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 > hda4
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Marking TSC unstable due to: possible TSC halt in C2.
Time: acpi_pm clocksource has been installed.
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
Clocksource tsc unstable (delta = -64042213 ns)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xe0100000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.22-rc4-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001820
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.22-rc4-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001840
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.22-rc4-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001860
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.22-rc4-mm2 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-3: new high speed USB device using ehci_hcd and address 2
usb 1-3: new device found, idVendor=413c, idProduct=9001
usb 1-3: new device strings: Mfr=56, Product=71, SerialNumber=0
usb 1-3: Product: A04 
usb 1-3: Manufacturer: Dell USB Drive
usb 1-3: configuration #1 chosen from 1 choice
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
usb 1-6: new high speed USB device using ehci_hcd and address 4
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
usb 1-6: new device found, idVendor=0409, idProduct=0058
usb 1-6: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-6: Product: USB2.0 Hub Controller
usb 1-6: Manufacturer: NEC Corporation
usb 1-6: configuration #1 chosen from 1 choice
hub 1-6:1.0: USB hub found
hub 1-6:1.0: 4 ports detected
Yenta: CardBus bridge found at 0000:02:03.0 [1028:014f]
input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio2/input/input5
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x37ffffff
Yenta: CardBus bridge found at 0000:02:03.1 [1028:014f]
usb 4-1: new low speed USB device using uhci_hcd and address 2
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #06 to #0a
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x37ffffff
ACPI: PCI Interrupt 0000:02:03.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[e0212000-e02127ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
usb 4-1: new device found, idVendor=413c, idProduct=2003
usb 4-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-1: Product: Dell USB Keyboard
usb 4-1: Manufacturer: Dell
usb 4-1: configuration #1 chosen from 1 choice
Synaptics Touchpad, model: 1, fw: 5.9, id: 0xa54ab1, caps: 0x804713/0x0
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input6
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
usbcore: registered new interface driver libusual
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver hiddev
input: Dell Dell USB Keyboard as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input7
input: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:1d.2-1
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
cs: IO port probe 0x100-0x3af: excluding 0x2f8-0x2ff
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x2f8-0x2ff
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
intel8x0_measure_ac97_clock: measured 59512 usecs
intel8x0: clocking to 48000
tg3.c:v3.77 (May 31, 2007)
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
eth0: Tigon3 [partno(BCM95705A50) rev 3001 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000Base-T Ethernet 00:0f:1f:44:f3:d8
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[763f0000] dma_mask[64-bit]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00065b4004fe33d2]
Adding 1373516k swap on /dev/hda7.  Priority:-1 extents:1 across:1373516k
EXT3 FS on hda2, internal journal
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (5043 buckets, 40344 max)
WARNING: at drivers/usb/core/urb.c:293 usb_submit_urb()
 [<e8048b01>] usb_submit_urb+0x211/0x230 [usbcore]
 [<e804a41f>] usb_sg_wait+0x8f/0x110 [usbcore]
 [<e822628e>] usb_stor_bulk_transfer_sg+0xae/0x100 [usb_storage]
 [<e82260d7>] usb_stor_bulk_transfer_buf+0x47/0x80 [usb_storage]
 [<e8226741>] usb_stor_Bulk_transport+0x121/0x290 [usb_storage]
 [<e82268d2>] usb_stor_invoke_transport+0x22/0x2b0 [usb_storage]
 [<c0116f7d>] __wake_up_locked+0x1d/0x20
 [<c01187f0>] default_wake_function+0x0/0x10
 [<e8227660>] usb_stor_control_thread+0x0/0x190 [usb_storage]
 [<e8227660>] usb_stor_control_thread+0x0/0x190 [usb_storage]
 [<e8227788>] usb_stor_control_thread+0x128/0x190 [usb_storage]
 [<e8227660>] usb_stor_control_thread+0x0/0x190 [usb_storage]
 [<c012e472>] kthread+0x42/0x70
 [<c012e430>] kthread+0x0/0x70
 [<c0104a3b>] kernel_thread_helper+0x7/0x1c
 =======================
speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI config is deprecated.
 Use X86_ACPI_CPUFREQ (acpi-cpufreq) instead.
fuse init (API version 7.8)
NTFS driver 2.1.28 [Flags: R/O MODULE].
NTFS volume version 3.1.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
PM: Writing back config space on device 0000:02:05.0 at offset c (was f3ff0000, writing 0)
PM: Writing back config space on device 0000:02:05.0 at offset b (was 165d14e4, writing 20031028)
PM: Writing back config space on device 0000:02:05.0 at offset 3 (was 0, writing 4008)
PM: Writing back config space on device 0000:02:05.0 at offset 2 (was 2000000, writing 2000001)
PM: Writing back config space on device 0000:02:05.0 at offset 1 (was 2b00000, writing 2b00106)
ADDRCONF(NETDEV_UP): eth0: link is not ready
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized i915 1.6.0 20060119 on minor 0
[drm] Initialized i915 1.6.0 20060119 on minor 1
ACPI: undocking
usb 1-3: USB disconnect, address 2
psmouse.c: bad data from KBC - timeout
tg3: eth0: Link is down.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ACPI: undocking
tg3: eth0: Link is down.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
tg3: eth0: Link is down.
PM: Writing back config space on device 0000:02:05.0 at offset b (was 165d14e4, writing 20031028)
PM: Writing back config space on device 0000:02:05.0 at offset 3 (was 0, writing 4008)
PM: Writing back config space on device 0000:02:05.0 at offset 2 (was 2000000, writing 2000001)
PM: Writing back config space on device 0000:02:05.0 at offset 1 (was 2b00000, writing 2b00106)
PM: Writing back config space on device 0000:02:05.0 at offset b (was 165d14e4, writing 20031028)
PM: Writing back config space on device 0000:02:05.0 at offset 3 (was 0, writing 4008)
PM: Writing back config space on device 0000:02:05.0 at offset 2 (was 2000000, writing 2000001)
PM: Writing back config space on device 0000:02:05.0 at offset 1 (was 2b00000, writing 2b00106)
ADDRCONF(NETDEV_UP): eth0: link is not ready
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present

--OXfL5xGRrasGEqWY--
