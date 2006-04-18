From: "Garry T. Williams" <gtwilliams@gmail.com>
Subject: Re: acpi function test suite 0.1 and test results
Date: Tue, 18 Apr 2006 07:13:58 -0400
Message-ID: <200604180713.59316.gtwilliams@gmail.com>
References: <D352FD896397D04482B87731BD4DBE7F411331@bjsmsx401nb>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3nMREjGCi4ZGUwP"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.232]:21254 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932184AbWDRLOF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 07:14:05 -0400
Received: by wproxy.gmail.com with SMTP id i2so219529wra
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 04:14:04 -0700 (PDT)
In-Reply-To: <D352FD896397D04482B87731BD4DBE7F411331@bjsmsx401nb>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ling L" <ling.l.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, "Zhang, Kexin" <kexin.zhang@intel.com>, "Luo, Zhenlin" <zhenlin.luo@intel.com>

--Boundary-00=_3nMREjGCi4ZGUwP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 18 April 2006 00:53, Yu, Ling L wrote:
> >I thought you should know that this test suite hung my laptop, 
> >forcing a complete power off to recover.
> >
> Thanks for your test; could you send me the "lsmod" output?

No problem; attached.

> >Here's where it hung: (I got this by running the test suite as a 
> >normal user instead of root.)
> >
> >
> >*******************************************************
> >*           Test ACPI drivers                         *
> >*******************************************************
> >
> >-------------------------------------------------------
> >Driver      State       Action      Results
> >ac          loaded      verifying   PASS
> >
> Could you use root to run again and send me the screen output again?

I don't know how to do that.  Like I said, the system was completely 
non-responsive.  I could not switch to a linux terminal.  I could not 
scroll back the terminal.  I could only hold the power button down to 
power off.

I can tell you that all tests passed up until this one.  It's the first 
module that the tests tried to unload.

I attached my dmesg.

-- 
Garry T. Williams --- +1 678 656-4579

--Boundary-00=_3nMREjGCi4ZGUwP
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lsmod.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsmod.out"

Module                  Size  Used by
i915                   18497  1 
drm                    63701  2 i915
autofs4                19013  1 
hidp                   15937  2 
rfcomm                 34517  0 
l2cap                  23617  10 hidp,rfcomm
bluetooth              44069  5 hidp,rfcomm,l2cap
vfat                   11969  1 
fat                    47709  1 vfat
dm_mirror              19985  0 
dm_mod                 50649  1 dm_mirror
video                  14917  0 
sony_acpi               5516  0 
button                  6609  0 
battery                 9285  0 
ac                      4933  0 
ipv6                  225569  22 
lp                     12296  0 
parport_pc             25445  0 
parport                34313  2 lp,parport_pc
nvram                   8393  0 
ppp_generic            28373  0 
slhc                    6593  1 ppp_generic
pcspkr                  3653  0 
ohci1394               31749  0 
ieee1394              288665  1 ohci1394
ehci_hcd               29005  0 
joydev                  9473  0 
e100                   33093  0 
mii                     5313  1 e100
snd_hda_intel          17233  0 
snd_hda_codec         112065  1 snd_hda_intel
snd_seq_dummy           3781  0 
snd_seq_oss            28993  0 
snd_seq_midi_event      7105  1 snd_seq_oss
snd_seq                47153  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          8909  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            45009  0 
snd_mixer_oss          16449  1 snd_pcm_oss
snd_pcm                76869  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
ipw2200                95633  0 
ieee80211              28681  1 ipw2200
ieee80211_crypt         6081  1 ieee80211
snd_timer              22597  2 snd_seq,snd_pcm
snd                    50500  9 snd_hda_intel,snd_hda_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
uhci_hcd               28881  0 
soundcore               9377  1 snd
i2c_i801                8397  0 
i2c_core               20673  1 i2c_i801
snd_page_alloc         10441  2 snd_hda_intel,snd_pcm
ext3                  116169  2 
jbd                    52693  1 ext3

--Boundary-00=_3nMREjGCi4ZGUwP
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.out"

Linux version 2.6.16-1.2080_FC5 (bhcompile@hs20-bc1-5.build.redhat.com) (gcc version 4.1.0 20060304 (Red Hat 4.1.0-3)) #1 Tue Mar 28 03:38:34 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f6e0000 (usable)
 BIOS-e820: 000000003f6e0000 - 000000003f6ea000 (ACPI data)
 BIOS-e820: 000000003f6ea000 - 000000003f700000 (ACPI NVS)
 BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
895MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 259808
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225279 pages, LIFO batch:31
  HighMem zone: 30433 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7520
ACPI: RSDT (v001   Sony       J1 0x20050311 PTL  0x00000000) @ 0x3f6e58d2
ACPI: MADT (v001   Sony       J1 0x20050311 PTL  0x0000005f) @ 0x3f6e9e78
ACPI: FADT (v002   Sony       J1 0x20050311 PTL  0x0000005f) @ 0x3f6e9ee0
ACPI: BOOT (v001   Sony       J1 0x20050311 PTL  0x00000001) @ 0x3f6e9fd8
ACPI: MCFG (v001   Sony       J1 0x20050311 PTL  0x0000005f) @ 0x3f6e9f9c
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x3f6e618f
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x3f6e5d4a
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x3f6e5b2f
ACPI: SSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x3f6e5916
ACPI: DSDT (v001   Sony       J1 0x20050311 PTL  0x20030224) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ rhgb quiet acpi_os_name="Microsoft Windows XP" acpi_sleep=s3_bios
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03d4000 soft=c03d3000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1596.334 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1025284k/1039232k available (1914k kernel code, 13188k reserved, 774k data, 176k init, 121732k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3200.66 BogoMIPS (lpj=6401335)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f3ff 00100000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
Checking 'hlt' instruction... OK.
ACPI: Overriding _OS definition to 'Microsoft Windows XP'
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 899k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd91f, last bus=8
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #06 (-#07) (try 'pci=assign-busses')
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 *4 5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: Embedded Controller [EC] (gpe 23) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 7, cardbus bridge: 0000:06:03.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: b0100000-b01fffff
  PREFETCH window: 50000000-51ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:06:03.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 16
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1145329733.080:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 8227E1D7AAD49D08
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (63 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: HITACHI_DK23FA-80, ATA DISK drive
hdb: MATSHITAUJ-840D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:06:03.0 [104d:818f]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:06:03.0, mfunc 0x01001b22, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0xb0100000 - 0xb01fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PWRB USB1 USB2 USB3 USB4 USB7 LANC 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 176k freed
Write protecting the kernel read-only data: 359k
input: AT Translated Set 2 keyboard as /class/input/input0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: PS/2 Mouse as /class/input/input1
input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
input: PS/2 Mouse as /class/input/input3
input: AlpsPS/2 ALPS GlidePoint as /class/input/input4
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda7: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 1669405
ext3_orphan_cleanup: deleting unreferenced inode 1669403
ext3_orphan_cleanup: deleting unreferenced inode 1669378
ext3_orphan_cleanup: deleting unreferenced inode 7260823
ext3_orphan_cleanup: deleting unreferenced inode 11980620
ext3_orphan_cleanup: deleting unreferenced inode 5201695
ext3_orphan_cleanup: deleting unreferenced inode 5200010
EXT3-fs: hda7: 7 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
hw_random: RNG not detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 18, io base 0x00001820
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001840
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 17, io base 0x00001860
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
ipw2200: Copyright(c) 2003-2005 Intel Corporation
ACPI: PCI Interrupt 0000:06:04.0[A] -> GSI 22 (level, low) -> IRQ 20
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
usb 2-1: new low speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input5
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ieee1394: Initialized config rom entry `ip1394'
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 20 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 18, io mem 0xb0004000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
e100: eth1: e100_probe: addr 0xb0107000, irq 21, MAC addr 00:01:4A:5E:63:31
ACPI: PCI Interrupt 0000:06:03.2[C] -> GSI 18 (level, low) -> IRQ 17
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[b0104000-b01047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
usb 2-1: USB disconnect, address 2
usb 2-1: new low speed USB device using uhci_hcd and address 3
input: PC Speaker as /class/input/input6
usb 2-1: configuration #1 chosen from 1 choice
CSLIP: code copyright 1989 Regents of the University of California
input: Logitech USB-PS/2 Optical Mouse as /class/input/input7
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
PPP generic driver version 2.4.2
Non-volatile memory driver v1.2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460301e28587]
floppy0: no floppy controllers found
lp: driver loaded but no devices found
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
ACPI Sony Notebook Control Driver v0.2-PP successfully installed
ACPI: Video Device [NGFX] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
EXT3 FS on hda7, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1020088k swap on /dev/hda5.  Priority:-1 extents:1 across:1020088k
ADDRCONF(NETDEV_UP): eth0: link is not ready
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
eth0: no IPv6 routers present
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
ADDRCONF(NETDEV_UP): eth1: link is not ready
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized i915 1.4.0 20060119 on minor 0
eth1: no IPv6 routers present
eth0: no IPv6 routers present
ACPI: Please implement acpi_video_bus_ROM_seq_show
ACPI: Please implement acpi_video_bus_ROM_seq_show
ipw2200: Failed to send SCAN_ABORT: Command timed out.
ipw2200: Firmware error detected.  Restarting.
ipw2200: Sysfs 'error' log captured.
ipw2200: Failed to send SCAN_ABORT: Command timed out.
ipw2200: Firmware error detected.  Restarting.
ipw2200: Sysfs 'error' log already exists.
ACPI: Please implement acpi_video_bus_ROM_seq_show
ACPI: Please implement acpi_video_bus_ROM_seq_show

--Boundary-00=_3nMREjGCi4ZGUwP--
