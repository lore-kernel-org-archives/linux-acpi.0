From: Vladimir Volcko <konference-X2ABGLaSPc4@public.gmane.org>
Subject: battery status error question
Date: Fri, 12 Mar 2004 09:30:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4051753D.9070401@pcs.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

Using kernel 2.4.24 and 2.4.25 with  acpi patch I sometimes getting 
repeating error in syslog:

Mar 12 09:16:46 localhost kernel:     ACPI-0279: *** Error: Looking up 
[PBST] in namespace, AE_ALREADY_EXISTS
Mar 12 09:16:46 localhost kernel:     ACPI-1120: *** Error: Method 
execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node ddea1900), 
AE_ALREADY_EXISTS

Doe's it mean I need to repair notebook(toshiba satellite A30-303) DSDT 
table (http://acpi.sourceforge.net/dsdt/view.php?id=172) or it is error 
in acpi?

Vladimir Volcko

<dmesg>
Linux version 2.4.24 (root-BuUY8psAA2Y@public.gmane.org) (gcc version 3.2.2 20030222 (Red Hat 
Linux 3.2.2-5)) #2 St bøe 10 23:59:33 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dee0000 (usable)
 BIOS-e820: 000000001dee0000 - 000000001deeb000 (ACPI data)
 BIOS-e820: 000000001deeb000 - 000000001df00000 (ACPI NVS)
 BIOS-e820: 000000001df00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
478MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
found SMP MP-table at 000f6ca0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 122592
zone(0): 4096 pages.
zone(1): 118496 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 TOSCPL                                    ) @ 0x000f6c70
ACPI: RSDT (v001 TOSCPL   RSDT   0x06040000  LTP 0x00000000) @ 0x1dee56ea
ACPI: FADT (v001 TOSCPL MONTARA  0x06040000 PTL  0x00000050) @ 0x1deeaf3c
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 
0x1deeafb0
ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x20030224) @ 0x1dee571a
ACPI: DSDT (v001 TOSCPL MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI BALANCE SET
Using ACPI (MADT) for SMP configuration information
Kernel command line: ro root=LABEL=/ hdc=ide-scsi vga=0x317
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 3064.093 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 6121.06 BogoMIPS
Memory: 482000k/490368k available (1635k kernel code, 7980k reserved, 
554k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-2, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 
1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3063.9881 MHz.
..... host bus clock speed is 133.2168 MHz.
cpu: 0, clocks: 1332168, slice: 666084
CPU0<T0:1332160,T1:666064,D:12,S:666084,C:1332168>
mtrr: v1.41 (20040107) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040211
PCI: PCI BIOS revision 2.10 entry at 0xfd9b2, last bus=2
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (1-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 (swsusp) S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 7 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 7 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5)
ACPI: Embedded Controller [EC0] (gpe 28)
schedule_task(): keventd has not started
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (1-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 1-16 -> IRQ 16
Pin 1-16 already programmed
IOAPIC[0]: Set PCI routing entry (1-19 -> 0xb1 -> IRQ 19 Mode:1 Active:1)
00:00:1d[B] -> 1-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:1d[C] -> 1-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (1-23 -> 0xc1 -> IRQ 23 Mode:1 Active:1)
00:00:1d[D] -> 1-23 -> IRQ 23
Pin 1-18 already programmed
IOAPIC[0]: Set PCI routing entry (1-17 -> 0xc9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 1-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:02:00[A] -> 1-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
00:02:01[A] -> 1-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)
00:02:02[A] -> 1-22 -> IRQ 22
Pin 1-23 already programmed
Pin 1-16 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
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
 11 001 01  1    1    0   1   0    1    1    C9
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    B1
 14 001 01  1    1    0   1   0    1    1    D1
 15 001 01  1    1    0   1   0    1    1    D9
 16 001 01  1    1    0   1   0    1    1    E1
 17 001 01  1    1    0   1   0    1    1    C1
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
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
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Software Suspend Gzip Compression Driver v1.0
Software Suspend Swap Writer v1.0
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 2 performance states, 8 
throttling states)
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
vesafb: framebuffer at 0xe8000000, mapped to 0xde81c000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at a5f3:1f5f
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
i810_rng hardware driver 0.9.8 loaded
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 408M
agpgart: Detected an Intel(R) 852GME Chipset.
agpgart: Detected 32636K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] AGP 0.99 Aperture @ 0xe8000000 128MB
[drm] Initialized i830 1.3.2 20021108 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23FA-60, ATA DISK drive
blk: queue c0376080, I/O limit 4095Mb (mask 0xffffffff)
hdc: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117210240 sectors (60012 MB) w/8192KiB Cache, CHS=7296/255/63, 
UDMA(100)
hdc: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: DVD-RAM UJ-811    Rev: H100
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0000, PCI irq16
Socket status: 30000006
Looking for first block of swap header at block 0.
Setting logical block size of resume device to 4096.
Software Suspend 2.0: Attempting to set blocksize for 303 to 4096.
Software Suspend 2.0: Swap space signature found.
Software Suspend 2.0: Checking for image...
Software Suspend 2.0: This is normal swap space.
Software Suspend 2.0: kswsuspd starting
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 83k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 124k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 23, pci mem debc4000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 00:1d.7
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 23:51:11 Mar 10 2004
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1860, IRQ 18
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
Adding Swap: 1052248k swap-space (priority -1)
hub.c: new USB device 00:1d.1-1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb3:2.0
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1045 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[e0200000-e02007ff]  Max 
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f3c350022d6]
</dmesg>




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
