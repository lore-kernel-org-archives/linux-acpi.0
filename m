From: Cyril Scetbon <cyril.scetbon@free.fr>
Subject: nx6125 battery issues
Date: Wed, 14 Jun 2006 16:57:30 +0200
Message-ID: <449023DA.8050602@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010803080505090907040308"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3-g19.free.fr ([212.27.42.29]:65217 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751253AbWFNO7c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jun 2006 10:59:32 -0400
Received: from [81.57.162.33] (cre94-1-81-57-162-33.fbx.proxad.net [81.57.162.33])
	by smtp3-g19.free.fr (Postfix) with ESMTP id AD5504978D
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jun 2006 16:59:30 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803080505090907040308
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi people,

I got a laptop nx6125 and acpi is not able to refresh battery status.
If I boot with ac on acpi sees that the battery is charging in  
/proc/acpi/battery/C179/*
But if I unplug the ac, acpi sees that the battery is charged and 
whatever I do after the state is not modified !!!

I use kernel 2.6.17-rc6, and U can see my dmesg output.

Thanks.



--------------010803080505090907040308
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

6>Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 382820k/393024k available (1332k kernel code, 9556k reserved, 526k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3598.12 BogoMIPS (lpj=7196259)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff c3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: After vendor identify, caps: 078bfbff c3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 078bfbff c3d3fbff 00000000 00000410 00000001 00000000 00000001
CPU: AMD Mobile AMD Sempron(tm) 3100+ stepping 02
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0e20)
checking if image is initramfs... it is
Freeing initrd memory: 3865k freed
HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
PCI: No mmconfig possible on 0:18
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI Error (evgpeblk-0284): Unknown GPE method type: C275 (name not of form _Lxx or _Exx) [20060127]
ACPI Error (evgpeblk-0284): Unknown GPE method type: C276 (name not of form _Lxx or _Exx) [20060127]
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C047] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C047] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.C047._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C047.C048._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C047.C0AB._PRT]
ACPI: Power Resource [C1CF] (off)
ACPI: Embedded Controller [C111] (gpe 17) interrupt mode.
ACPI: Power Resource [C1B7] (on)
ACPI: Power Resource [C1C7] (on)
ACPI: PCI Interrupt Link [C0F0] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F1] (IRQs 10 11) *5
ACPI: PCI Interrupt Link [C0F2] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C0F3] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F4] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0F5] (IRQs *9)
ACPI: PCI Interrupt Link [C0F6] (IRQs 10 11) *5
ACPI: PCI Interrupt Link [C0F7] (IRQs *10 11)
ACPI: Power Resource [C26C] (off)
ACPI: Power Resource [C26D] (off)
ACPI: Power Resource [C26E] (off)
ACPI: Power Resource [C26F] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:05.0
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: d0400000-d07fffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 5, cardbus bridge: 0000:04:04.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bridge: 0000:00:14.4
  IO window: 1000-1fff
  MEM window: d0000000-d03fffff
  PREFETCH window: 30000000-31ffffff
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
ACPI: PCI Interrupt Link [C0F4] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:04:04.0[A] -> Link [C0F4] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1150296180.708:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
vesafb: framebuffer at 0xc0000000, mapped to 0xd8880000, using 937k, total 131072k
vesafb: mode is 800x600x8, linelength=800, pages=254
vesafb: protected mode interface info at c000:53c7
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [C0F1] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [C0F1] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:14.6 disabled
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
loop: loaded (max 8 devices)
tg3.c:v3.58 (May 22, 2006)
ACPI: PCI Interrupt Link [C0F7] enabled at IRQ 10
ACPI: PCI Interrupt 0000:04:01.0[A] -> Link [C0F7] -> GSI 10 (level, low) -> IRQ 10
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0f:b0:f6:12:14
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
Using IPI Shortcut mode
ACPI wakeup devices: 
C047 C0AB C1CE C0DD C0E3 C0E8 C1D0 C1D1 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 152k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: Fan [C270] (off)
ACPI: Fan [C271] (off)
ACPI: Fan [C272] (off)
ACPI: Fan [C273] (off)
ACPI: CPU0 (power states: C1[C1] C3[C3])
ACPI: Processor [C000] (supports 8 throttling states)
ACPI: Thermal Zone [TZ1] (72 C)
ACPI: Thermal Zone [TZ2] (61 C)
ACPI: Thermal Zone [TZ3] (39 C)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt Link [C0F0] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [C0F0] -> GSI 10 (level, low) -> IRQ 10
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3010-0x3017, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x3018-0x301f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST98823A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITAUJ-840D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [C0F3] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [C0F3] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 10, io mem 0xd0800000
ieee1394: Initialized config rom entry `ip1394'
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [C0F3] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 10, io mem 0xd0801000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [C0F3] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: irq 10, io mem 0xd0802000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
ACPI: PCI Interrupt Link [C0F5] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:04:04.2[C] -> Link [C0F5] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[d0013000-d00137ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
Attempting manual resume
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ohci_hcd 0000:00:13.1: wakeup
ReiserFS: dm-0: Using r5 hash to sort names
usb 2-1: new full speed USB device using ohci_hcd and address 2
spurious 8259A interrupt: IRQ7.
usb 2-1: configuration #1 chosen from 1 choice
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f992951000c]
usb 2-3: new low speed USB device using ohci_hcd and address 3
usb 2-3: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Logitech USB Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:13.1-3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ACPI: PCI Interrupt 0000:04:04.0[A] -> Link [C0F4] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:04:04.0 [103c:308b]
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
Yenta: ISA IRQ mask 0x00f8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd03fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
sdhci: SDHCI controller found at 0000:04:04.4 [104c:8034] (rev 0)
ACPI: PCI Interrupt 0000:04:04.4[C] -> Link [C0F5] -> GSI 9 (level, low) -> IRQ 9
mmc0: SDHCI at 0xd001a000 irq 9 DMA
mmc1: SDHCI at 0xd001b000 irq 9 DMA
mmc2: SDHCI at 0xd001c000 irq 9 DMA
ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [C0F1] -> GSI 10 (level, low) -> IRQ 10
mice: PS/2 mouse device common for all mice
MC'97 0 converters and GPIO not ready (0x1)
ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [C0F1] -> GSI 10 (level, low) -> IRQ 10
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
ndiswrapper version 1.16 loaded (preempt=no,smp=no)
ndiswrapper: driver bcmwl5 (Broadcom,04/21/2005, 3.100.65.1) loaded
ACPI: PCI Interrupt Link [C0F6] enabled at IRQ 11
ACPI: PCI Interrupt 0000:04:02.0[A] -> Link [C0F6] -> GSI 11 (level, low) -> IRQ 11
ndiswrapper: using irq 11
wlan0: vendor: ''
wlan0: ndiswrapper ethernet device 00:14:a5:6b:03:4a using driver bcmwl5, 14E4:4318:103C:1356.5.conf
wlan0: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES/CCMP with WPA, WPA2, WPA2PSK
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xc (1250 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x13 (1075 mV)
cpu_init done, current fid 0xa, vid 0x8
powernow-k8: ph2 null fid transition 0xa
Adding 2097144k swap on /dev/mapper/vg0-lv_swap.  Priority:-1 extents:1 across:2097144k
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: dm-8: found reiserfs format "3.6" with standard journal
ReiserFS: dm-8: using ordered data mode
ReiserFS: dm-8: journal params: device dm-8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-8: checking transaction log (dm-8)
ReiserFS: dm-8: Using r5 hash to sort names
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
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
ACPI: AC Adapter [C177] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1F0]
ACPI: Lid Switch [C1F1]
ACPI: Battery Slot [C179] (battery present)
ACPI: Battery Slot [C178] (battery absent)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)

--------------010803080505090907040308
Content-Type: text/x-vcard; charset=utf-8;
 name="cyril.scetbon.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cyril.scetbon.vcf"

begin:vcard
fn:Cyril Scetbon
n:Scetbon;Cyril
email;internet:cyril.scetbon@free.fr
version:2.1
end:vcard


--------------010803080505090907040308--
