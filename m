From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: cannot resume from suspend-to-ram
Date: Wed, 6 Dec 2006 11:17:59 +0100
Message-ID: <20061206111759.fa12d2a2.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:64447 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760422AbWLFKSP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2006 05:18:15 -0500
Received: by nf-out-0910.google.com with SMTP id o25so511203nfa
        for <linux-acpi@vger.kernel.org>; Wed, 06 Dec 2006 02:18:14 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-input@atrey.karlin.mff.cuni.cz

I can't resume from suspend-to-ram on my Sony Vaio VGN-FS215S.
I tryed debugging the thing a little with pm_trace and my dmesg says:

[...]
ACPI: (supports S0 S3 S4 S5)
  Magic number: 4:804:766
  hash matches device serio4
[...]

/sys/bus/serio/devices/serio4/description says:
i8042 AUX3 port

and /sys/bus/serio/devices/serio4/driver/description says:
PS/2 mouse driver

But now I'm stuck, and don't know what to do!

Here is my full dmesg after the reboot (well, not really full, my /var/log/dmesg
is cropped):
<Something misses here>
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
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Detected 1862.328 MHz processor.
Built 1 zonelists.  Total pages: 129763
Kernel command line: root=/dev/sda2 rw quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515096k/523136k available (2058k kernel code, 7552k reserved, 669k data, 160k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdfee0000   ( 510 MB)
      .init : 0xc03ac000 - 0xc03d4000   ( 160 kB)
      .data : 0xc03028bc - 0xc03a9fb4   ( 669 kB)
      .text : 0xc0100000 - 0xc03028bc   (2058 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3726.68 BogoMIPS (lpj=1863341)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
PM: Adding info for No Bus:platform
Time:  4:45:25  Date: 04/02/100
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Firmware left 0000:06:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#07) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1b.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:06:03.0
PM: Adding info for pci:0000:06:03.2
PM: Adding info for pci:0000:06:03.3
PM: Adding info for pci:0000:06:04.0
PM: Adding info for pci:0000:06:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 *4 5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
pnp: PnP ACPI: found 8 devices
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: 90000000-afffffff
  PREFETCH window: c0000000-cfffffff
PCI: Bus 7, cardbus bridge: 0000:06:03.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: b0000000-b00fffff
  PREFETCH window: 30000000-31ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:06:03.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
PM: Adding info for platform:pcspkr
Simple Boot Flag at 0x36 set to 0x1
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PM: Adding info for pci_express:0000:00:01.0:pcie00
Allocate Port Service[0000:00:01.0:pcie03]
PM: Adding info for pci_express:0000:00:01.0:pcie03
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Video Device [NGFX] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THRM] (59 C)
ACPI Sony Notebook Control Driver v0.3 successfully installed
Real Time Clock Driver v1.12ac
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 20 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0xb0007000, irq 17, MAC addr 00:01:4A:5C:72:C3
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1880 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1888 irq 15
scsi0 : ata_piix
PM: Adding info for No Bus:host0
ata1.00: ATA-6, max UDMA/100, 195371568 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
scsi1 : ata_piix
PM: Adding info for No Bus:host1
ata2: port disabled. ignoring.
ATA: abnormal status 0xFF on port 0x177
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK1031GA AA20 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 > sda4
sd 0:0:0:0: Attached scsi disk sda
PM: Adding info for No Bus:target0:0:1
scsi 0:0:1:0: CD-ROM            SONY     DVD RW DW-D56A   PFS3 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:1:0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 19, io mem 0x80004000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 19, io base 0x00001800
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001820
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev4.1_ep81
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
PM: Adding info for No Bus:usbdev5.1_ep81
PM: Adding info for usb:2-1
PM: Adding info for No Bus:usbdev2.2_ep00
usb 2-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-1:1.0
PM: Adding info for No Bus:usbdev2.2_ep81
input: Logitech Optical USB Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.0-1
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
PM: Adding info for serio:serio1
PM: Adding info for serio:serio2
mice: PS/2 mouse device common for all mice
PM: Adding info for serio:serio3
Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
PM: Adding info for serio:serio4
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA device list:
  #0: HDA Intel at 0x80000000 irq 16
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5)
  Magic number: 4:804:766
  hash matches device serio4
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input1
input: PS/2 Mouse as /class/input/input2
input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: replayed 9 transactions in 0 seconds
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem).
Freeing unused kernel memory: 160k freed
input: PS/2 Mouse as /class/input/input4
input: AlpsPS/2 ALPS GlidePoint as /class/input/input5
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4kmpr
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:06:04.0[A] -> GSI 22 (level, low) -> IRQ 21
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
ReiserFS: sda4: using ordered data mode
ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda4: checking transaction log (sda4)
ReiserFS: sda4: Using r5 hash to sort names
Adding 1004020k swap on /dev/sda5.  Priority:-1 extents:1 across:1004020k
