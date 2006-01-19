From: Michael Braun <charlysnews@gmx.de>
Subject: Status/state for LID is _close_ while the lid is open
Date: Thu, 19 Jan 2006 07:42:04 +0100
Message-ID: <1137652924.5766.7.camel@neo.dtm.ops.eu.uu.net>
Reply-To: charlysnews@gmx.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from turboserver.de ([81.169.187.44]:6923 "EHLO
	webmail.turboserver.de") by vger.kernel.org with ESMTP
	id S964956AbWASGnS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 01:43:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I get a wrong ACPI event state for my lid of my laptop (Samsung X20 1730 II).
When its open I get "closed" state.

cat /proc/acpi/button/lid/LID0/state
state:      closed

cat /proc/acpi/button/lid/LID0/info
type:                    Lid Switch

After some tests, I get the state to "open" after I've closed the lid for about
10 seconds. When I open it under 10 seconds its still closed.

I think it is no hardware problem, because under WinXP the lid function works as
it should.

I hope someone can help me to solve this problem. If you need more information
please let me know.

Distribution: Mandriva 2006 (+cooker)

Hardware Environment: Notebook - Samsung X20 1730 II
(http://www.samsungcomputer.com/product/spec_x20.htm?SMSESSION=NO)

/proc/version
*******************
Linux version 2.6.15-rc7.4mdk (lcapitulino@n1.mandriva.com) (gcc version 4.0.2
(4.0.2
-1mdk for Mandriva Linux release 2006.1)) #1 Wed Dec 28 18:57:53 CET 2005

/proc/cpuinfo
*****************************
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.73GHz
stepping        : 8
cpu MHz         : 798.171
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
bogomips        : 1597.95


DMESG
*****
Linux version 2.6.15-rc7.4mdk (lcapitulino@n1.mandriva.com) (gcc version 4.0.2
(4.0.2-1mdk for Mandriva Linux release 2006.1)) #1 Wed Dec 28 18:57:53 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fea0000 (usable)
 BIOS-e820: 000000003fea0000 - 000000003feb1000 (ACPI data)
 BIOS-e820: 000000003feb1000 - 000000003ff00000 (ACPI NVS)
BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
NX (Execute Disable) protection: active
On node 0 totalpages: 261792
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32416 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7730
ACPI: RSDT (v001 PTLTD  Ohlone00 0x06040000  LTP 0x00000000) @ 0x3feaa995
ACPI: FADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x3feb0e96
ACPI: MADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x3feb0f0a
ACPI: HPET (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x3feb0f64
ACPI: MCFG (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x3feb0f9c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x3feb0fd8
ACPI: SSDT (v001 SataRe SataAhci 0x00001000 INTL 0x20030224) @ 0x3feab18b
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030224) @ 0x3feaac60
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x3feaaaa6
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x3feaa9dd
ACPI: DSDT (v001 INTEL  ALVISO   0x06040000 INTL 0x20030224) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.15-rc7.4 root=305 resume=/dev/hda6
splash=si
lent
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034064k/1047168k available (2041k kernel code, 12496k reserved, 610k
data, 2
16k init, 129664k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Using HPET for gettimeofday
Detected 1729.040 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 3461.56 BogoMIPS (lpj=6923122)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180
00000
000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180
000000
00 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180
00000000 000
00000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1.73GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like
an initrd
Freeing initrd memory: 188k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd92e, last bus=6
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5)
ACPI: Embedded Controller [H_EC] (gpe 23)
ACPI: Power Resource [CFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: c0100000-c01fffff
  PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 4000-4fff
  MEM window: c4000000-c7ffffff
  PREFETCH window: d8000000-dbffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00005000-000050ff
  IO window: 00005400-000054ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-5fff
  MEM window: c8000000-c80fffff
  PREFETCH window: 50000000-51ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 16 (level, low) -> IRQ 16
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1136203606.484:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 1875k, total 131072k
vesafb: mode is 800x600x16, linelength=1600, pages=135
vesafb: protected mode interface info at c000:5b3b
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hpet_resources: 0xfed00000 is busy
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 20 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18c0-0x18c7, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: HTS421210H9AT00, ATA DISK drive
hdb: TSSTcorpCD/DVDW TS-L632B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: Host Protected Area detected.
        current capacity is 194560369 sectors (99614 MB)
        native  capacity is 195371568 sectors (100030 MB)
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0x37
hda: 194560369 sectors (99614 MB) w/7528KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI wakeup devices:
PWRB RP01 LANC MODM
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 136KiB [1 disk] into ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^Hdone.
VFS: Mounted root (cramfs filesystem) readonly.
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 216k freed
Synaptics Touchpad, model: 1, fw: 6.1, id: 0x2580b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001800
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 21, io base 0x00001820
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 19, io base 0x00001840
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xc0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb 2-1: can't set config #1, error -71
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ts: Compaq touchscreen protocol output
usb 2-1: new low speed USB device using uhci_hcd and address 4
usbcore: registered new driver hiddev
input: Microsoft Microsoft USB Wireless Mouse as /class/input/input2
input: USB HID v1.11 Mouse [Microsoft Microsoft USB Wireless Mouse] on
usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
EXT3 FS on hda5, internal journal
Adding 1630556k swap on /dev/hda6.  Priority:-1 extents:1 across:1630556k
input: PC Speaker as /class/input/input3
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.25 [Flags: R/O MODULE].
NTFS volume version 3.1.
loop: loaded (max 8 devices)
hdb: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8181 buckets, 65448 max) - 232 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Removing netfilter NETLINK layer.
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (on)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (63 C)
ACPI: Video Device [ATIM] (multi-head: yes  rom: no  post: no)
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 16 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:06:09.0 [144d:c018]
Yenta: ISA IRQ mask 0x04b8, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x5fff
cs: IO port probe 0x5000-0x5fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc8000000 - 0xc80fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect
breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for
details.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0xa00-0xaff: clean.
floppy0: no floppy controllers found
floppy0: no floppy controllers found
CAPI Subsystem Rev 1.1.2.8
capifs: Rev 1.1.2.3
capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
NET: Registered protocol family 17
tg3.c:v3.46 (Dec 19, 2005)
ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 22 (level, low) -> IRQ 22
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit)
10/100/1000BaseT Ethernet 00:13:77:02:d6:0c
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1]
eth0: dma_rwctrl[763f0000]
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
ipw2200: Copyright(c) 2003-2005 Intel Corporation
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 20 (level, low) -> IRQ 18
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ip_tables: (C) 2000-2002 Netfilter core team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8181 buckets, 65448 max) - 232 bytes per conntrack
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
ieee80211_crypt: registered algorithm 'TKIP'
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 55501 usecs
intel8x0: clocking to 48000
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.6
eth2: no IPv6 routers present


