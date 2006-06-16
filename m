From: Zaher Salman <zaher@triumf.ca>
Subject: ACPI for Toshiba TECRA M5
Date: Fri, 16 Jun 2006 15:52:24 -0400
Message-ID: <44930BF8.3020300@triumf.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030005070103040406080804"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from trshare.triumf.ca ([142.90.100.191]:62889 "EHLO
	trshare.triumf.ca") by vger.kernel.org with ESMTP id S1751420AbWFPOwc
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jun 2006 10:52:32 -0400
Received: from [130.246.49.71] (isis71.nd.rl.ac.uk [130.246.49.71])
	(authenticated bits=0)
	by trshare.triumf.ca (8.12.11.20060308/8.12.10) with ESMTP id k5GEqL56026844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Fri, 16 Jun 2006 07:52:30 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030005070103040406080804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a fairly new Toshiba Tecra M5 (Core duo) running Mandriva 2006 
with kernel 2.6.16. ACPI support for this laptop is quite good including 
battery, fan, thermal zone, cpu frequency, lid and power buttons etc. 
The problem is that /sys/power/state has only standby and mem (no disk) 
and I cannot figure out why. I also cannot get all the function buttons 
to work (only the scree brightness and mute). Attached is the dmesg output.

Any hints/tips  to help get more things running on this laptop is highly 
appreciated.

thanks
Zaher



--------------030005070103040406080804
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.16-1mdkcustom (root@HiFi) (gcc version 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0)) #2 SMP Thu Jun 15 17:15:17 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffa0000 (usable)
 BIOS-e820: 000000007ffa0000 - 000000007ffb0000 (ACPI data)
 BIOS-e820: 000000007ffb0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec28000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
895MB LOWMEM available.
NX (Execute Disable) protection: active
On node 0 totalpages: 524192
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225279 pages, LIFO batch:31
  HighMem zone: 294817 pages, LIFO batch:31
DMI 2.4 present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f01e0
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x7ffa0000
ACPI: FADT (v002 TOSHIB 750      0x20030101 TASM 0x04010000) @ 0x7ffa0068
ACPI: SSDT (v001 TOSHIB A003B    0x20050926 MSFT 0x0100000e) @ 0x7ffa6b6a
ACPI: BOOT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x7ffa0040
ACPI: MADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x7ffa7648
ACPI: MCFG (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x7ffa76b0
ACPI: HPET (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x7ffa76ec
ACPI: SSDT (v001 TOSHIB A003B    0x20051021 MSFT 0x0100000e) @ 0x7ffa7724
ACPI: DSDT (v001 TOSHIB A003B    0x20060424 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xd808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: Skipping IOAPIC probe due to 'noapic' option.
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=linux-2.6.16-1mdk root=806 resume=/dev/sda5 splash=silent acpi=on noapic
bootsplash: silent mode.
Found and enabled local APIC!
mapped APIC to ffffe000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2072548k/2096768k available (2320k kernel code, 22496k reserved, 876k data, 272k init, 1179268k highmem, 0k BadRAM)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Using HPET for gettimeofday
Detected 2161.288 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 4328.53 BogoMIPS (lpj=8657069)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 280k freed
ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
ACPI: setting ELCR to 0200 (from 0e00)
CPU0: Intel Genuine Intel(R) CPU           T2600  @ 2.16GHz stepping 08
Enabling SMP...
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4322.61 BogoMIPS (lpj=8645223)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Genuine Intel(R) CPU           T2600  @ 2.16GHz stepping 08
Total of 2 processors activated (8651.14 BogoMIPS).
checking TSC synchronization across 2 CPUs: passed.
Enabling SMP...
Brought up 2 CPUs
migration_cost=8000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd937, last bus=7
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #06 (-#07) (try 'pci=assign-busses')
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXCB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.MPEX._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:09: ioport range 0x480-0x48f has been reserved
PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fdffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:1c.0
  IO window: c000-cfff
  MEM window: ffd00000-ffdfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: b000-bfff
  MEM window: fa000000-fbffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: ffc00000-ffcfffff
  PREFETCH window: disabled.
PCI: Bus 7, cardbus bridge: 0000:06:0b.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 88000000-89ffffff
  MEM window: 8a000000-8bffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: 8a000000-8cffffff
  PREFETCH window: 88000000-89ffffff
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1c.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1c.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:06:0b.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt 0000:06:0b.0[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x7c set to 0x1
audit: initializing netlink socket (disabled)
audit(1150471239.760:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie03]
vesafb: framebuffer at 0xe0000000, mapped to 0xf8880000, using 3750k, total 131072k
vesafb: mode is 800x600x16, linelength=1600, pages=2
vesafb: protected mode interface info at c000:cd80
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 27015 bytes,<6>...found (800x600, 26967 bytes, v3).
Console: switching to colour frame buffer device 93x30
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 272k freed
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xAF10 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:7f69 84:6063 85:f469 86:3c49 87:6063 88:203f
ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: HTS541080G9SA00   Rev: MB4O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xAF18 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: MATSHITA  Model: DVD-RAM UJ-841S   Rev: 1.21
  Type:   CD-ROM                             ANSI SCSI revision: 05
input: DualPoint Stick as /class/input/input1
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:<6>input: AlpsPS/2 ALPS DualPoint TouchPad as /class/input/input2
 sda1 sda2 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000afe0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000af80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000af60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 10, io base 0x0000af40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xffaffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-1: USB disconnect, address 2
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
ts: Compaq touchscreen protocol output
usb 2-1: new full speed USB device using uhci_hcd and address 3
usb 2-1: configuration #1 chosen from 1 choice
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
ibm_acpi: ec object not found
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (47 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALZ.GHCI
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
ieee1394: Initialized config rom entry `ip1394'
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
Adding 2144636k swap on /dev/sda5.  Priority:-1 extents:1 across:2144636k
Linux agpgart interface v0.101 (c) Dave Jones
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:02:00.0 to 64
e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:0e:7b:50:f7:e5
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
NTFS driver 2.1.26 [Flags: R/O DEBUG MODULE].
NTFS volume version 3.1.
loop: loaded (max 8 devices)
PCI: Enabling device 0000:06:0b.1 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt 0000:06:0b.1[B] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[8c005000-8c0057ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 27015 bytes,<6>...found (800x600, 26967 bytes, v3).
bootsplash: status on console 0 changed to on
Using specific hotkey driver
ACPI: PCI Interrupt 0000:06:0b.0[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:06:0b.0 [1179:0001]
Yenta: ISA IRQ mask 0x00f8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
cs: IO port probe 0x1000-0x1fff: clean.
pcmcia: parent PCI bridge Memory window: 0x8a000000 - 0x8cffffff
pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x89ffffff
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00003900009508d4]
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0x100-0x4ff: excluding 0x370-0x377 0x3b0-0x3df 0x3f0-0x3ff 0x4d0-0x4d7
cs: IO port probe 0xa00-0xaff: clean.
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.0.3mp
ipw3945: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:05:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
NET: Registered protocol family 17
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog_task: 10/100 speed: disabling TSO
ieee80211_crypt: registered algorithm 'WEP'
PCI: Enabling device 0000:00:1b.0 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1b.0 to 64
spurious 8259A interrupt: IRQ7.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth2: link is not ready
IPv6 over IPv4 tunneling driver
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 9887 bytes, v3).
bootsplash: status on console 0 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 9887 bytes, v3).
bootsplash: status on console 1 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 9887 bytes, v3).
bootsplash: status on console 2 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 9887 bytes, v3).
bootsplash: status on console 3 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 9887 bytes, v3).
bootsplash: status on console 4 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 9887 bytes, v3).
bootsplash: status on console 5 changed to on
eth0: no IPv6 routers present
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-8762  Mon May 15 13:06:38 PDT 2006
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-8762  Mon May 15 13:06:38 PDT 2006

--------------030005070103040406080804--
