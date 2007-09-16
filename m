From: =?UTF-8?B?UmHDumwgU8OhbmNoZXogU2lsZXM=?= <rasasi78@gmail.com>
Subject: System hard lock when closing lid.
Date: Mon, 17 Sep 2007 00:47:40 +0200
Message-ID: <fckbqd$4v3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1683477.dGe4k6omPj"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43178 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbXIPWuF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Sep 2007 18:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IX2wE-0003Lj-IQ
	for linux-acpi@vger.kernel.org; Mon, 17 Sep 2007 00:50:02 +0200
Received: from 144.red-88-19-170.staticip.rima-tde.net ([88.19.170.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 17 Sep 2007 00:50:02 +0200
Received: from rasasi78 by 144.red-88-19-170.staticip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 17 Sep 2007 00:50:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--nextPart1683477.dGe4k6omPj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit

  Hello all:

  I've searched for a more user related ML, but this is the closest I've
found. I own a Dell inspiron 510m laptop which include the HW listed at [1]

  As you can see there the graphics card is an intel 855GM. The newer xorg
intel driver tries to save power by disabling one of the video output pipes
of the card, the one that could drive an external VGA monitor. As a result,
someone told me that the system enters in SMM (System Management Mode),
leaves the system in such a state that the system ends up locking totally:
no ssh connection or sys-rq combination works, just hard power off. More
details at https://bugs.freedesktop.org/show_bug.cgi?id=11432

  This result is the same no matter what Linux version I use, tried
2.6.20,21 and 22. I have done some research as to know if this could be
avoided some way in Linux. I ran the linux firmwarekit, I checked the dsdl
table, I upgraded bios, tried different boot parameters but no valuable
results I got. This information is available, so feel free to ask for it.

  I'd like to know if there's anything that could be done with regard to
Linux kernel to soothe or solve the issue. Of course, I'm at your disposal
to do whatever test is needed.

  Just in case, I also attach a dmesg output, maybe not the latest stable
kernel, but still 2.6.22.

  Thanks a lot.

[1]
lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller [8086:3580] (rev 02)
00:00.1 System peripheral [0880]: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller [8086:3584] (rev 02)
00:00.3 System peripheral [0880]: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller [8086:3585] (rev 02)
00:02.0 VGA compatible controller [0300]: Intel Corporation 82852/855GM
Integrated Graphics Device [8086:3582] (rev 02)
00:02.1 Display controller [0380]: Intel Corporation 82852/855GM Integrated
Graphics Device [8086:3582] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 [8086:24c2] (rev 01)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 [8086:24c4] (rev 01)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 [8086:24c7] (rev 01)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller [8086:24cd] (rev 01)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev 81)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge [8086:24cc] (rev 01)
00:1f.1 IDE interface [0101]: Intel Corporation 82801DBM (ICH4-M) IDE
Controller [8086:24ca] (rev 01)
00:1f.5 Multimedia audio controller [0401]: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller [8086:24c5]
(rev 01)
00:1f.6 Modem [0703]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller [8086:24c6] (rev 01)
01:01.0 CardBus bridge [0607]: Texas Instruments PCI4510 PC card Cardbus
Controller [104c:ac44] (rev 02)
01:01.1 FireWire (IEEE 1394) [0c00]: Texas Instruments PCI4510 IEEE-1394
Controller [104c:8029]
01:03.0 Network controller [0280]: Intel Corporation PRO/Wireless 2200BG
Network Connection [8086:4220] (rev 05)
01:08.0 Ethernet controller [0200]: Intel Corporation 82801DB PRO/100 VE
(MOB) Ethernet Controller [8086:103d] (rev 81)

-- 
     Raúl Sánchez Siles
----->Proud Debian user<-----
Linux registered user #416098

--nextPart1683477.dGe4k6omPj
Content-Type: text/plain; name="dmesg.dell"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="dmesg.dell"

Linux version 2.6.22-1-686 (Debian 2.6.22-2) (waldi@debian.org) (gcc version 4.1.3 20070718 (prerelease) (Debian 4.1.2-14)) #1 SMP Mon Jul 23 13:23:02 UTC 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001feaa000 (usable)
 BIOS-e820: 000000001feaa000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
510MB LOWMEM available.
Entering add_active_range(0, 0, 130730) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   130730
  HighMem    130730 ->   130730
early_node_map[1] active PFN ranges
    0:        0 ->   130730
On node 0 totalpages: 130730
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 989 pages used for memmap
  Normal zone: 125645 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000FDF00, 0014 (r0 DELL  )
ACPI: RSDT 1FEF0000, 0028 (r1 DELL    CPi R   27D40909 ASL        61)
ACPI: FACP 1FEF0400, 0074 (r1 DELL    CPi R   27D40909 ASL        61)
ACPI: DSDT 1FEF0C00, 32A6 (r1 INT430 SYSFexxx     1001 MSFT  100000E)
ACPI: FACS 1FEFF800, 0040
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 30000000 (gap: 20000000:dec10000)
Built 1 zonelists.  Total pages: 129709
Kernel command line: root=/dev/hda1 ro resume2=swap:/dev/hda2 break=mount nosplash
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0140c000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 1394.394 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 508296k/522920k available (1688k kernel code, 14036k reserved, 649k data, 244k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfeaa000   ( 510 MB)
      .init : 0xc034f000 - 0xc038c000   ( 244 kB)
      .data : 0xc02a6187 - 0xc03487e4   ( 649 kB)
      .text : 0xc0100000 - 0xc02a6187   (1688 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2790.59 BogoMIPS (lpj=5581199)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f9bf 00000000 00000000 00002040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 11k freed
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 0800)
CPU0: Intel(R) Pentium(R) M processor 1.40GHz stepping 06
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfc96e, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Firmware left 0000:01:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #02 (-#05) is hidden behind transparent bridge #01 (-#01) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 15 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 8
NET: Registered protocol family 20
pnp: 00:00: iomem range 0x0-0x9fbff could not be reserved
pnp: 00:00: iomem range 0x9fc00-0x9ffff could not be reserved
pnp: 00:00: iomem range 0xc0000-0xcffff could not be reserved
pnp: 00:00: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x800-0x805 has been reserved
pnp: 00:02: ioport range 0x808-0x80f has been reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0x806-0x807 has been reserved
pnp: 00:03: ioport range 0x810-0x85f has been reserved
pnp: 00:03: ioport range 0x860-0x87f has been reserved
pnp: 00:03: ioport range 0x880-0x8bf has been reserved
pnp: 00:03: ioport range 0x8c0-0x8df has been reserved
pnp: 00:08: ioport range 0x900-0x97f has been reserved
pnp: 00:0e: ioport range 0x7b0-0x7bb has been reserved
pnp: 00:0e: ioport range 0x7c0-0x7df has been reserved
pnp: 00:0e: ioport range 0xbb0-0xbbb has been reserved
pnp: 00:0e: ioport range 0xbc0-0xbdf has been reserved
pnp: 00:0e: ioport range 0xfb0-0xfbb has been reserved
pnp: 00:0e: ioport range 0xfc0-0xfdf has been reserved
pnp: 00:0e: ioport range 0x13b0-0x13bb has been reserved
pnp: 00:0e: ioport range 0x13c0-0x13df has been reserved
Time: tsc clocksource has been installed.
PCI: Bus 2, cardbus bridge: 0000:01:01.0
  IO window: 0000e000-0000e0ff
  IO window: 0000e400-0000e4ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 38000000-3bffffff
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: fc000000-fdffffff
  PREFETCH window: 30000000-33ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:01:01.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:01.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 196608 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
checking if image is initramfs... it is
Switched to high resolution mode on CPU 0
Freeing initrd memory: 6554k freed
audit: initializing netlink socket (disabled)
audit(1185709215.724:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Freeing unused kernel memory: 244k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (63 C)
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000bf40
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
libata version 2.21 loaded.
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xfaeffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Marking TSC unstable due to: possible TSC halt in C2.
Time: acpi_pm clocksource has been installed.
hda: SAMSUNG HM120JC, ATA DISK drive
hda: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Clocksource tsc unstable (delta = -82073022 ns)
ACPI: PCI Interrupt 0000:01:01.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
firewire_ohci: Added fw-ohci device 0000:01:01.1, OHCI version 1.10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xfcffd000, irq 11, MAC addr 00:0F:1F:D0:F1:CE
hda: max request size: 512KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 > hda4
firewire_core: created new fw device fw0 (0 config rom retries)
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: replayed 468 transactions in 3 seconds
ReiserFS: hda1: Using r5 hash to sort names
Attempting manual resume
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
input: PC Speaker as /class/input/input1
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected an Intel 855GM Chipset.
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
intel_rng: FWH not detected
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: Found a ICH4-M TCO device (Version=1, TCOBASE=0x0860)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
Real Time Clock Driver v1.12ac
parport_pc 00:0c: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
irda_init()
NET: Registered protocol family 23
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0kmq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
input: PS/2 Mouse as /class/input/input2
input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
intel8x0_measure_ac97_clock: measured 55708 usecs
intel8x0: clocking to 48000
Yenta: CardBus bridge found at 0000:01:01.0 [1028:0164]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:01:01.0, mfunc 0x012c1222, devctl 0x64
Yenta: ISA IRQ mask 0x0458, PCI irq 11
Socket status: 30000086
Yenta: Raising subordinate bus# of parent bus (#01) from #01 to #05
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
cs: IO port probe 0xe000-0xefff: clean.
pcmcia: parent PCI bridge Memory window: 0xfc000000 - 0xfdffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
ACPI: PCI Interrupt 0000:01:03.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
cs: IO port probe 0x100-0x3af: excluding 0x280-0x287 0x2f8-0x2ff
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
Unable to find swap-space signature
loop: module loaded
fuse init (API version 7.8)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
Adding 1349452k swap on /dev/hda2.  Priority:-1 extents:1 across:1349452k
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: AC Adapter [AC] (on-line)
input: Lid Switch as /class/input/input4
ACPI: Lid Switch [LID]
input: Power Button (CM) as /class/input/input5
ACPI: Power Button (CM) [PBTN]
input: Sleep Button (CM) as /class/input/input6
ACPI: Sleep Button (CM) [SBTN]
lp0: using parport0 (interrupt-driven).
ppdev: user-space parallel port driver
ADDRCONF(NETDEV_UP): eth1: link is not ready
ADDRCONF(NETDEV_UP): eth2: link is not ready
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized i915 1.6.0 20060119 on minor 0
[drm] Initialized i915 1.6.0 20060119 on minor 1
atkbd.c: Unknown key pressed (translated set 2, code 0x88 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e008 <keycode>' to make it known.
ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
eth2: no IPv6 routers present
ADDRCONF(NETDEV_UP): eth2: link is not ready
ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
eth2: no IPv6 routers present
usb 4-3: new high speed USB device using ehci_hcd and address 2
usb 4-3: configuration #1 chosen from 1 choice
usb 4-3: USB disconnect, address 2
printk: 4 messages suppressed.
printk: 12 messages suppressed.
printk: 3 messages suppressed.
printk: 11 messages suppressed.
printk: 14 messages suppressed.
printk: 17 messages suppressed.


--nextPart1683477.dGe4k6omPj--

