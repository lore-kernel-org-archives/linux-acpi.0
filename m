From: Dirk Koopman <djk-ovDUel0N34n10XsdtD+oqA@public.gmane.org>
Subject: Tarting up my ACER 1703 ACPI spec
Date: Wed, 07 Jan 2004 14:57:36 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073487455.3051.17.camel@dirkl.int.tobit.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-T+U0lJNjEJMO3AdWaPMH"
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


--=-T+U0lJNjEJMO3AdWaPMH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have an Acer 1703SC and I have had several months of no battery
indication and megabytes of error messages. Having finally discovered
how to fiddle with the various tools, I have fixed this. Does nobody
test their DSDTs before they stick them in? 

Anyway, before I submit it I would like to get the rest of the warnings
out and then write a little paper on what I did.

I enclose the various bits of info as attachments. 

My original problem seems to have been caused by the battery code
calling Method Z009 which (by a process of deduction) must have been
renamed Z00A. Viz:

"Jan  6 04:02:38 dhcppc0 kernel: search_node c1b2ea00 start_node c1b2ea00 return_node 00000000
Jan  6 04:02:38 dhcppc0 kernel:     ACPI-1120: *** Error: [NULL NAME], AE_NOT_FOUND
Jan  6 04:02:38 dhcppc0 kernel:     ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c1b2eac0), AE_NOT_FOUND
Jan  6 04:02:38 dhcppc0 kernel:     ACPI-0352: *** Error: Looking up [Z009] in namespace, AE_NOT_FOUND"

That is now fixed. However, when compiling the DSDT I get these warnings:-

[root-0jNJT1+6+ws@public.gmane.org iasl-linux-20030918]# iasl dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl   816:                     Method (DRUL, 1, NotSerialized)
Warning  2019 -                                ^ Not all control paths return a value (DRUL)

dsdt.dsl  3577:             Method (Z00A, 0, NotSerialized)
Warning  2019 -                        ^ Not all control paths return a value (Z00A)

dsdt.dsl  3701:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WAK)

ASL Input:  dsdt.dsl - 3766 lines, 136715 bytes, 1973 keywords
AML Output: DSDT.aml - 15831 bytes 485 named objects 1488 executable opcodes

Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 645 Optimizations

Also in the dmesg I have:-

ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKA._CRS] (Node c1
b33ee0), AE_TYPE
ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKC._CRS] (Node c1
b322c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKD._CRS] (Node c1
b323c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKD] (IRQs 10)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKE._CRS] (Node c1
b324c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKE] (IRQs 10)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKF._CRS] (Node c1
b325c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKF] (IRQs 10)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKG._CRS] (Node c1
b326c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10)
ACPI: Embedded Controller [EC0] (gpe 25)

At least on initial boot up before I make the replacement of the DSDT
using the initrd patch (included in Mandrake 9.2).

Firstly: is this anything to worry about?
Secondly: before I try to work out what is going on, can anyone that
knows what they are doing look at it a fix it quicker, else give me some
pointers?

Ta

Dirk 

--=-T+U0lJNjEJMO3AdWaPMH
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=
Content-Transfer-Encoding: 7bit

00000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bdf0000 (usable)
 BIOS-e820: 000000001bdf0000 - 000000001bdfb000 (ACPI data)
 BIOS-e820: 000000001bdfb000 - 000000001be00000 (ACPI NVS)
 BIOS-e820: 000000001be00000 - 000000001c000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
445MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000f6e00
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 114160
zone(0): 4096 pages.
zone(1): 110064 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6ea0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1bdf6923
ACPI: FADT (v001 SiS    M650     0x06040000 PTL  0x000f4240) @ 0x1bdfaf14
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1bdfaf88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1bdfafd8
ACPI: DSDT (v001 PTLTD      650M 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x10] polarity[0x3] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2422-21smp ro root=1605 devfs=mount hda=ide-scsi acpi=on resume=/dev/hdc6
ide_setup: hda=ide-scsi
Initializing CPU#0
Detected 2655.908 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5295.30 BogoMIPS
Memory: 444076k/456640k available (1521k kernel code, 8484k reserved, -2146k data, 160k init, 0k highmem, 0k BadRAM)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07
per-CPU timeslice cutoff: 1462.98 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-2, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=16 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
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
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2655.8790 MHz.
..... host bus clock speed is 132.7937 MHz.
cpu: 0, clocks: 1327937, slice: 663968
CPU0<T0:1327936,T1:663968,D:0,S:663968,C:1327937>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfd9c6, last bus=1
PCI: Using configuration type 1
Looking for DSDT in initrd ... found!
    ACPI-0292: *** Info: Table [DSDT] replaced by host OS
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKA._CRS] (Node c1b33ee0), AE_TYPE
ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKC._CRS] (Node c1b322c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKD._CRS] (Node c1b323c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKD] (IRQs 10)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKE._CRS] (Node c1b324c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKE] (IRQs 10)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKF._CRS] (Node c1b325c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKF] (IRQs 10)
    ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKG._CRS] (Node c1b326c0), AE_TYPE
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10)
ACPI: Embedded Controller [EC0] (gpe 25)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (1-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:02[B] -> 1-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:02[C] -> 1-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xb9 -> IRQ 20 Mode:1 Active:1)
00:00:03[A] -> 1-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xc1 -> IRQ 21 Mode:1 Active:1)
00:00:03[B] -> 1-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xc9 -> IRQ 22 Mode:1 Active:1)
00:00:03[C] -> 1-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (1-23 -> 0xd1 -> IRQ 23 Mode:1 Active:1)
00:00:03[D] -> 1-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (1-19 -> 0xd9 -> IRQ 19 Mode:1 Active:1)
00:00:04[A] -> 1-19 -> IRQ 19
Pin 1-17 already programmed
Pin 1-18 already programmed
Pin 1-19 already programmed
IOAPIC[0]: Set PCI routing entry (1-16 -> 0xe1 -> IRQ 16 Mode:1 Active:1)
00:01:00[A] -> 1-16 -> IRQ 16
Pin 1-18 already programmed
PCI: No IRQ known for interrupt pin A of device 00:02.5 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
kinoded started
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
pty: 1024 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Enabling device 00:02.6 (0000 -> 0001)
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
PCI: No IRQ known for interrupt pin A of device 00:02.5 - using IRQ 255
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
hdc: ST380012A, ATA DISK drive
blk: queue c01a660c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/1024KiB Cache, CHS=9729/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus1/target0/lun0: p1 p2 < p5 p6 p7 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 107k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xdc847000, IRQ 20
usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] USB 1.0 Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-ohci.c: USB OHCI at membase 0xdc849000, IRQ 21
usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-ohci.c: USB OHCI at membase 0xdc84b000, IRQ 22
usb-ohci.c: usb-00:03.2, Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usbdevfs: remount parameter error
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,5), internal journal
Adding Swap: 1172704k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
hda: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: QSI       Model: CDRW/DVD SBW-242  Rev: UX08
  Type:   CD-ROM                             ANSI SCSI revision: 02
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.4a [Flags: R/O MODULE].
NTFS volume version 3.1.
ohci1394: $Rev$ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
PCI: Enabling device 00:02.3 (0000 -> 0002)
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[e4000000-e40007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000bee8a]
sis900.c: v1.08.06 9/24/2002
eth0: Unknown PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x2000, IRQ 19, 00:c0:9f:26:1a:19.
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (39 C)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
inserting floppy driver for 2.4.22-21mdksmp
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 4x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Linux Kernel Card Services Kernel Version
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:0a.0 (0000 -> 0002)
Yenta IRQ list 0098, PCI irq17
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x1c0-0x1cf 0x378-0x37f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
PCI: Enabling device 00:02.7 (0000 -> 0001)
intel8x0: clocking to 48000
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 0
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 2
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 4
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 6
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 0
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 2
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 4
ide-scsi: hda: unsupported command in request queue (0)
end_request: I/O error, dev 03:00 (hda), sector 6

--=-T+U0lJNjEJMO3AdWaPMH
Content-Disposition: attachment; filename=dmidecode
Content-Type: text/plain; name=dmidecode; charset=
Content-Transfer-Encoding: 7bit

# dmidecode 2.3
SMBIOS 2.31 present.
40 structures occupying 1306 bytes.
Table at 0x1BDFC000.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: acer   
		Version: 3A76
		Release Date: 05/27/03
		Address: 0xE4A80
		Runtime Size: 112000 bytes
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			BIOS ROM is socketed
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: acer
		Product Name: Aspire 1700
		Version: 0303
		Serial Number: LXA0805038329000CCEF02
		UUID: 0031D552-C763-0010-96DC-C000269F191A
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: acer
		Product Name: Aspire 1700
		Version: 0303
		Serial Number: None
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: acer
		Type: Other
		Lock: Not Present
		Version: N/A
		Serial Number: None
		Asset Tag: No Asset Tag  XXX               
		Boot-up State: Unknown
		Power Supply State: Unknown
		Thermal State: Unknown
		Security Status: Unknown
		OEM Information: 0x00001234
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: Socket 478/423
		Type: Central Processor
		Family: Pentium 4
		Manufacturer: Intel
		ID: 27 0F 00 00 FF FB EB BF
		Signature: Type 0, Family 15, Model 2, Stepping 7
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			PAE (Physical address extension)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			APIC (On-chip APIC hardware supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			SS (Self-snoop)
			HTT (Hyper-threading technology)
			TM (Thermal monitor supported)
			SBF (Signal break on FERR)
		Version: Celeron
		Voltage: 3.3 V
		External Clock: Unknown
		Max Speed: 2000 MHz
		Current Speed: 2660 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: Not Provided
		L2 Cache Handle: 0x0009
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 512 MB
		Maximum Total Memory Size: 1024 MB
		Supported Speeds:
			70 ns
			60 ns
		Supported Memory Types:
			DIMM
			SDRAM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0000
			0x0001
		Enabled Error Correcting Capabilities:
			Unknown
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: SDRAM 1
		Bank Connections: 0 1
		Current Speed: 70 ns
		Type: None
		Installed Size: 512 MB (Double-bank Connection)
		Enabled Size: 512 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: SDRAM 2
		Bank Connections: 2 3
		Current Speed: 70 ns
		Type: None
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: SDRAM 3
		Bank Connections: 4 5
		Current Speed: 70 ns
		Type: None
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 512 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000A
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: AGP Slot
		Type: 64-bit AGP 4x
		Current Usage: Available
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
Handle 0x000B
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot 1
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
Handle 0x000C
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot 2
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x000D
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot 3
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x000E
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot 4
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x000F
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot 5
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0010
	DMI type 10, 8 bytes.
	On Board Device 1 Information
		Type: Sound
		Status: Disabled
		Description: SiS 7018 PCI Sound Chip
	On Board Device 2 Information
		Type: Ethernet
		Status: Disabled
		Description: SiS 900 EtherNet Chip
Handle 0x0011
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: This is a SMBIOS 2.3 BIOS
		String 2: Some of the structures are included
		String 3: for demonstration purposes only
Handle 0x0012
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: Jumper Settings can be described here.
		Option 2: Ex: JPXX Cache size select
		Option 3: Ex:      1-2  256K Cache
		Option 4: Ex:      2-3  512K Cache
Handle 0x0013
	DMI type 15, 29 bytes.
	System Event Log
		Area Length: 0 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: General-purpose non-volatile data functions
		Access Address: 0x0000
		Status: Invalid, Not Full
		Change Token: 0x000000F0
		Header Format: Type 1
		Supported Log Type Descriptors: 3
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
		Descriptor 2: Single-bit ECC memory error
		Data Format 2: Multiple-event
		Descriptor 3: Multi-bit ECC memory error
		Data Format 3: Multiple-event
Handle 0x0014
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 3 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x0015
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0014
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 512 MB
		Form Factor: DIMM
		Set: 1
		Locator: DIMM1
		Bank Locator: DIMM1
		Type: DRAM
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0016
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0014
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: DIMM2
		Bank Locator: DIMM2
		Type: DRAM
		Type Detail: Unknown
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0017
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0014
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: DIMM3
		Bank Locator: DIMM3
		Type: DRAM
		Type Detail: Unknown
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0018
	DMI type 18, 23 bytes.
	32-bit Memory Error Information
		Type: OKBad Read
		Granularity: Unknown
		Operation: Unknown
		Vendor Syndrome: Unknown
		Memory Array Address: Unknown
		Device Address: Unknown
		Resolution: Unknown
Handle 0x0019
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0014
		Partition Width: 0
Handle 0x001A
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x0015
		Memory Array Mapped Address Handle: 0x0019
		Partition Row Position: 2
		Interleave Position: 1
		Interleaved Data Depth: 6
Handle 0x001B
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x0001FFFFC00
		Ending Address: 0x0001FFFFFFF
		Range Size: 1 kB
		Physical Device Handle: 0x0016
		Memory Array Mapped Address Handle: 0x0019
		Partition Row Position: 2
		Interleave Position: 1
		Interleaved Data Depth: 6
Handle 0x001C
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x0001FFFFC00
		Ending Address: 0x0001FFFFFFF
		Range Size: 1 kB
		Physical Device Handle: 0x0017
		Memory Array Mapped Address Handle: 0x0019
		Partition Row Position: 2
		Interleave Position: 1
		Interleaved Data Depth: 6
Handle 0x001D
	DMI type 23, 13 bytes.
	System Reset
		Status: Enabled
		Watchdog Timer: Present
		Boot Option: Do Not Reboot
		Boot Option On Limit: Do Not Reboot
		Reset Count: Unknown
		Reset Limit: Unknown
		Timer Interval: Unknown
		Timeout: Unknown
Handle 0x001E
	DMI type 24, 5 bytes.
	Hardware Security
		Power-On Password Status: Disabled
		Keyboard Password Status: Unknown
		Administrator Password Status: Enabled
		Front Panel Reset Status: Unknown
Handle 0x001F
	DMI type 25, 9 bytes.
	System Power Controls
		Next Scheduled Power-on: 12-31 23:59:59
Handle 0x0020
	DMI type 26, 22 bytes.
	Voltage Probe
		Description: Voltage Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
		Nominal Value: 8.192 V
Handle 0x0021
	DMI type 29, 22 bytes.
	Electrical Current Probe
		Description: Electrical Current Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
		Nominal Value: Unknown
Handle 0x0022
	DMI type 30, 6 bytes.
	Out-of-band Remote Access
		Manufacturer Name: SiS
		Inbound Connection: Enabled
		Outbound Connection: Disabled
Handle 0x0023
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x0024
	DMI type 33, 31 bytes.
	64-bit Memory Error Information
		Type: OKBad Read
		Granularity: Unknown
		Operation: Unknown
		Vendor Syndrome: Unknown
		Memory Array Address: 0x0000000080000000
		Device Address: 0x0000000080000000
		Resolution: Unknown
Handle 0x0025
	DMI type 36, 16 bytes.
	Management Device Threshold Data
		Lower Non-critical Threshold: 1000
		Upper Non-critical Threshold: 1000
		Lower Critical Threshold: 1000
		Upper Critical Threshold: 1000
		Lower Non-recoverable Threshold: 1000
		Upper Non-recoverable Threshold: 1000
Handle 0x0026
	DMI type 126, 4 bytes.
	Inactive
Handle 0x0027
	DMI type 127, 4 bytes.
	End Of Table

--=-T+U0lJNjEJMO3AdWaPMH
Content-Disposition: attachment; filename=dsdt.dsl
Content-Type: text/x-dsl; name=dsdt.dsl; charset=
Content-Transfer-Encoding: 7bit

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of /tmp/dsdt, Wed Jan  7 13:22:46 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "650M", 100925440)
{
    OperationRegion (P80G, SystemIO, 0x80, 0x01)
    Field (P80G, ByteAcc, NoLock, Preserve)
    {
        DBPG,   8
    }

    OperationRegion (FANC, SystemIO, 0x0500, 0xFF)
    Field (FANC, ByteAcc, NoLock, Preserve)
    {
        Offset (0x56), 
        FANR,   8, 
        Offset (0x58), 
        F1CR,   8
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
    }

    Name (_S0, Package (0x02)
    {
        0x00, 
        0x00
    })
    Name (_S3, Package (0x02)
    {
        0x03, 
        0x03
    })
    Name (_S4, Package (0x02)
    {
        0x04, 
        0x04
    })
    Name (_S5, Package (0x02)
    {
        0x05, 
        0x05
    })
    Name (PICF, 0x00)
    Method (_PIC, 1, NotSerialized)
    {
        Store (Arg0, PICF)
    }

    Scope (_SB)
    {
        Name (OSTB, Ones)
        Name (FWSO, "FWSO")
        Name (ECEN, 0x00)
        Name (ACST, 0x01)
        Device (PCI0)
        {
            Method (_PRT, 0, NotSerialized)
            {
                If (LNot (\PICF))
                {
                    Return (PICM)
                }
                Else
                {
                    Return (APIC)
                }
            }

            Name (PICM, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x01, 
                    \_SB.PCI0.LPCB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    \_SB.PCI0.LPCB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKE, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x01, 
                    \_SB.PCI0.LPCB.LNKF, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    \_SB.PCI0.LPCB.LNKG, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    \_SB.PCI0.LPCB.LNKH, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x01, 
                    \_SB.PCI0.LPCB.LNKD, 
                    0x00
                }
            })
            Name (APIC, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x00, 
                    0x00, 
                    0x14
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x01, 
                    0x00, 
                    0x15
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    0x00, 
                    0x16
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    0x00, 
                    0x17
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x00, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }
            })
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            Name (_UID, 0x00)
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Method (_INI, 0, NotSerialized)
            {
            }

            OperationRegion (MA, PCI_Config, 0x00, 0xFF)
            Field (MA, ByteAcc, NoLock, Preserve)
            {
                Offset (0x70), 
                SHC0,   1, 
                SHC4,   1, 
                SHC8,   1, 
                SHCC,   1, 
                SHD0,   1, 
                SHD4,   1, 
                SHD8,   1, 
                SHDC,   1, 
                SHE0,   1, 
                SHE4,   1, 
                SHE8,   1, 
                SHEC,   1, 
                Offset (0xAE), 
                MAL,    8, 
                MAH,    8
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100, 0x00)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8, 0x00)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x04000000,
                    0xFFEDFFFF,
                    0x00000000,
                    0x00000000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C0000,
                    0x000C3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C4000,
                    0x000C7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C8000,
                    0x000CBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000CC000,
                    0x000CFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000D0000,
                    0x000D3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000D4000,
                    0x000D7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000D8000,
                    0x000DBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000DC000,
                    0x000DFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000E0000,
                    0x000E3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000E4000,
                    0x000E7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000E8000,
                    0x000EBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000EC000,
                    0x000EFFFF,
                    0x00000000,
                    0x00004000, 0x00)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateBitField (CRES, 0x03B0, C0RW)
                CreateDWordField (CRES, 0x87, C0LN)
                Store (One, C0RW)
                Store (0x4000, C0LN)
                If (SHC0)
                {
                    Store (0x00, C0LN)
                }

                CreateBitField (CRES, 0x0488, C4RW)
                CreateDWordField (CRES, 0xA2, C4LN)
                Store (One, C4RW)
                Store (0x4000, C4LN)
                If (SHC4)
                {
                    Store (0x00, C4LN)
                }

                CreateBitField (CRES, 0x0560, C8RW)
                CreateDWordField (CRES, 0xBD, C8LN)
                Store (One, C8RW)
                Store (0x4000, C8LN)
                If (SHC8)
                {
                    Store (0x00, C8LN)
                }

                CreateBitField (CRES, 0x0638, CCRW)
                CreateDWordField (CRES, 0xD8, CCLN)
                Store (One, CCRW)
                Store (0x4000, CCLN)
                If (SHCC)
                {
                    Store (0x00, CCLN)
                }

                CreateBitField (CRES, 0x0710, D0RW)
                CreateDWordField (CRES, 0xF3, D0LN)
                Store (One, D0RW)
                Store (0x4000, D0LN)
                If (SHD0)
                {
                    Store (0x00, D0LN)
                }

                CreateBitField (CRES, 0x07E8, D4RW)
                CreateDWordField (CRES, 0x010E, D4LN)
                Store (One, D4RW)
                Store (0x4000, D4LN)
                If (SHD4)
                {
                    Store (0x00, D4LN)
                }

                CreateBitField (CRES, 0x08C0, D8RW)
                CreateDWordField (CRES, 0x0129, D8LN)
                Store (One, D8RW)
                Store (0x4000, D8LN)
                If (SHD8)
                {
                    Store (0x00, D8LN)
                }

                CreateBitField (CRES, 0x0998, DCRW)
                CreateDWordField (CRES, 0x0144, DCLN)
                Store (One, DCRW)
                Store (0x4000, DCLN)
                If (SHDC)
                {
                    Store (0x00, DCLN)
                }

                CreateBitField (CRES, 0x0A70, E0RW)
                CreateDWordField (CRES, 0x015F, E0LN)
                Store (One, E0RW)
                Store (0x4000, E0LN)
                If (SHE0)
                {
                    Store (0x00, E0LN)
                }

                CreateBitField (CRES, 0x0B48, E4RW)
                CreateDWordField (CRES, 0x017A, E4LN)
                Store (One, E4RW)
                Store (0x4000, E4LN)
                If (SHE4)
                {
                    Store (0x00, E4LN)
                }

                CreateBitField (CRES, 0x0C20, E8RW)
                CreateDWordField (CRES, 0x0195, E8LN)
                Store (One, E8RW)
                Store (0x4000, E8LN)
                If (SHE8)
                {
                    Store (0x00, E8LN)
                }

                CreateBitField (CRES, 0x0CF8, ECRW)
                CreateDWordField (CRES, 0x01B0, ECLN)
                Store (One, ECRW)
                Store (0x4000, ECLN)
                If (SHEC)
                {
                    Store (0x00, ECLN)
                }

                CreateDWordField (CRES, 0x60, RAMT)
                CreateDWordField (CRES, 0x6C, RAMR)
                ShiftLeft (\_SB.PCI0.MAH, 0x1C, Local0)
                ShiftLeft (\_SB.PCI0.MAL, 0x14, Local1)
                Add (Local1, Local0, Local2)
                Store (Local2, RAMT)
                Subtract (0xFFEE0000, RAMT, RAMR)
                Return (CRES)
            }

            Device (AGPB)
            {
                Name (_ADR, 0x00010000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (LNot (\PICF))
                    {
                        Return (AGPP)
                    }
                    Else
                    {
                        Return (AGPA)
                    }
                }

                Name (AGPP, Package (0x02)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.PCI0.LPCB.LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.PCI0.LPCB.LNKC, 
                        0x00
                    }
                })
                Name (AGPA, Package (0x02)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x12
                    }
                })
                Device (VGA)
                {
                    Name (_ADR, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPCB.Z000)
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS1, 0, NotSerialized)
                    {
                        Store (0x01, _PSC)
                    }

                    Method (_PS2, 0, NotSerialized)
                    {
                        Store (0x02, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Name (DISW, 0x01)
                    Name (NDSP, 0x00)
                    Name (VRSM, 0x00)
                    Name (PDSP, 0x00)
                    Name (CDSP, 0x00)
                    Name (TGLT, Package (0x04)
                    {
                        Package (0x08)
                        {
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x02, 
                            0x03, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x05, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x02, 
                            0x03, 
                            0x05, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }
                    })
                    Name (TGLP, 0x00)
                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Name (_PSC, 0x00)
                        Name (_S3D, 0x03)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("LCD._DSS(1) called", Debug)
                                Or (NDSP, 0x01, NDSP)
                            }
                            Else
                            {
                                Store ("LCD._DSS(0) called", Debug)
                                And (NDSP, 0xFE, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("LCD._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                                UDGS ()
                            }
                        }
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("CRT._DSS(1) called", Debug)
                                Or (NDSP, 0x02, NDSP)
                            }
                            Else
                            {
                                Store ("CRT._DSS(0) called", Debug)
                                And (NDSP, 0xFD, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("CRT._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                                UDGS ()
                            }
                        }
                    }

                    Device (TV)
                    {
                        Name (_ADR, 0x0200)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("TV_._DSS(1) called", Debug)
                                Or (NDSP, 0x04, NDSP)
                            }
                            Else
                            {
                                Store ("TV_._DSS(0) called", Debug)
                                And (NDSP, 0xFB, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("TV_._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                                UDGS ()
                            }
                        }
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        USTA ()
                        Store (CDSP, PDSP)
                        Store (CDSP, Local1)
                        Or (ShiftRight (And (Local1, 0x10), 0x03), 0x1D, ^LCD._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x02), 0x03), ShiftRight (And (Local1, 0x20), 0x04)), 0x0D, ^CRT._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x04), 0x02), ShiftRight (And (Local1, 0x40), 0x05)), 0x0D, ^TV._DCS)
                        ShiftRight (Local1, 0x04, NDSP)
                        Store (ShiftRight (And (^LCD._DCS, 0x02), 0x01), ^LCD._DGS)
                        Store (ShiftRight (And (^CRT._DCS, 0x02), 0x01), ^CRT._DGS)
                        Store (ShiftRight (And (^TV._DCS, 0x02), 0x01), ^TV._DGS)
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (Arg0, DISW)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x03)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x00010200
                        })
                    }

                    Method (DRUL, 1, NotSerialized)
                    {
                        USTA ()
                        If (LNot (LEqual (And (PDSP, 0x07), And (CDSP, 0x07))))
                        {
                            UDGS ()
                            Store (CDSP, PDSP)
                        }

                        Store (CDSP, Local2)
                        Store (^CRT._DCS, Local1)
                        Or (Or (ShiftLeft (And (Local2, 0x02), 0x03), ShiftRight (And (Local2, 0x20), 0x04)), And (Local1, 0x0D), ^CRT._DCS)
                        Store (^TV._DCS, Local3)
                        Or (Or (ShiftLeft (And (Local2, 0x04), 0x02), ShiftRight (And (Local2, 0x40), 0x05)), And (Local3, 0x0D), ^TV._DCS)
                        If (LEqual (Arg0, 0x01))
                        {
                            If (LOr (LAnd (^CRT._DGS, LNot (And (^CRT._DCS, 0x10))), LAnd (^TV._DGS, LNot (And (^TV._DCS, 0x10)))))
                            {
                                UDGS ()
                                Return (0x00)
                            }
                            Else
                            {
                                Notify (VGA, 0x80)
                                Return (0x00)
                            }
                        }
                    }

                    Method (USTA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.LPCB.Z000, 0x00))
                        {
                            Store (\_SB.PCI0.LPCB.PHSR (0x00, 0x00), CDSP)
                        }
                        Else
                        {
                            Store (0x11, CDSP)
                        }

                        And (CDSP, 0x0F, Local1)
                        If (LEqual (Local1, 0x03))
                        {
                            Store (0x01, TGLP)
                        }
                        Else
                        {
                            If (LEqual (Local1, 0x05))
                            {
                                Store (0x02, TGLP)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x07))
                                {
                                    Store (0x03, TGLP)
                                }
                                Else
                                {
                                    Store (0x00, TGLP)
                                }
                            }
                        }
                    }

                    Method (UDGS, 0, NotSerialized)
                    {
                        And (^LCD._DGS, 0x01, Local0)
                        Or (Local0, ShiftLeft (And (^CRT._DGS, 0x01), 0x01), Local0)
                        Or (Local0, ShiftLeft (And (^TV._DGS, 0x01), 0x02), Local0)
                        Store (DerefOf (Index (DerefOf (Index (TGLT, TGLP)), Local0)), Local1)
                        And (Local1, 0x01, ^LCD._DGS)
                        ShiftRight (And (Local1, 0x02), 0x01, ^CRT._DGS)
                        ShiftRight (And (Local1, 0x04), 0x02, ^TV._DGS)
                    }
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x00020000)
                OperationRegion (PCFG, PCI_Config, 0x00, 0x80)
                Field (PCFG, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x41), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    Offset (0x60), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8, 
                    Offset (0x74), 
                    Z001,   16
                }

                OperationRegion (SOW, SystemIO, 0x8000, 0x90)
                Field (SOW, WordAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                        ,   1, 
                    TDCC,   3, 
                    TFEN,   1, 
                    Offset (0x1A), 
                        ,   1, 
                    RLSL,   1, 
                    Offset (0x20), 
                        ,   2, 
                    SLP,    1, 
                    WK,     1, 
                    Offset (0x2B), 
                        ,   5, 
                    SSL,    1, 
                    SWK,    1, 
                    Z002,   1, 
                    Offset (0x3E), 
                        ,   7, 
                    LIDP,   1, 
                    Offset (0x49), 
                    LGMS,   1, 
                    Offset (0x62), 
                        ,   6, 
                    ALED,   2, 
                    Offset (0x64), 
                        ,   7, 
                    LIDS,   1, 
                        ,   3, 
                    BLIT,   1
                }

                OperationRegion (SMB, SystemIO, 0x8100, 0x20)
                Field (SMB, AnyAcc, NoLock, Preserve)
                {
                    BSTS,   8, 
                    BEN,    8, 
                    BCNT,   8, 
                    HCNT,   8, 
                    BADR,   8, 
                    BCOD,   8, 
                    BCOU,   8, 
                    SBY0,   8, 
                    SBY1,   8, 
                    SBY2,   8, 
                    SBY3,   8, 
                    SBY4,   8, 
                    SBY5,   8, 
                    SBY6,   8, 
                    SBY7,   8, 
                    DADR,   8, 
                    SBD0,   8, 
                    SBD1,   8, 
                    BSAA,   8
                }

                Method (THRL, 1, NotSerialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        \_SB.PCI0.LPCB.PHSR (0x07, 0x00)
                    }
                    Else
                    {
                        \_SB.PCI0.LPCB.PHSR (0x07, 0x01)
                    }
                }

                OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
                Field (SMI0, AnyAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                OperationRegion (SMI1, SystemMemory, 0x1BDFBE2D, 0x00000120)
                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    BCMD,   8, 
                    DID,    32, 
                    INFO,   2008
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    DMY,    40, 
                    INF,    8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x110), 
                    Z000,   1, 
                    Z003,   1, 
                    Offset (0x111), 
                    Z004,   8
                }

                Mutex (PSMX, 0x00)
                Method (PHSR, 2, NotSerialized)
                {
                    Acquire (\_SB.PCI0.LPCB.PSMX, 0xFFFF)
                    Store (0x90, BCMD)
                    Store (Arg0, DID)
                    Store (Arg1, INFO)
                    Store (Zero, SMIC)
                    Store (INF, Local0)
                    Release (\_SB.PCI0.LPCB.PSMX)
                    Return (Local0)
                }

                Name (Z005, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {5}
                })
                Name (Z006, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {3}
                })
                Name (Z007, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {7,10}
                })
                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z007)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRA, 0x80, \_SB.PCI0.LPCB.PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z007, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRA, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRA, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRA, 0x70), \_SB.PCI0.LPCB.PIRA)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRA, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z006)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRB, 0x80, \_SB.PCI0.LPCB.PIRB)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z006, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRB, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRB, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRB, 0x70), \_SB.PCI0.LPCB.PIRB)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRB, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z005)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRC, 0x80, \_SB.PCI0.LPCB.PIRC)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z005, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRC, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRC, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRC, 0x70), \_SB.PCI0.LPCB.PIRC)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRC, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z007)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRD, 0x80, \_SB.PCI0.LPCB.PIRD)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z007, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRD, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRD, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRD, 0x70), \_SB.PCI0.LPCB.PIRD)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRD, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z007)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRE, 0x80, \_SB.PCI0.LPCB.PIRE)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z007, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRE, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRE, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRE, 0x70), \_SB.PCI0.LPCB.PIRE)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRE, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z007)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRF, 0x80, \_SB.PCI0.LPCB.PIRF)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z007, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRF, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRF, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRF, 0x70), \_SB.PCI0.LPCB.PIRF)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRF, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z007)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRG, 0x80, \_SB.PCI0.LPCB.PIRG)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z007, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRG, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRG, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRG, 0x70), \_SB.PCI0.LPCB.PIRG)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRG, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z007)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRH, 0x80, \_SB.PCI0.LPCB.PIRH)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z007, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRH, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRH, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRH, 0x70), \_SB.PCI0.LPCB.PIRH)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRH, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    Mutex (S192, 0x00)
                    OperationRegion (SMC1, SystemIO, 0x2E, 0x02)
                    Field (SMC1, ByteAcc, Lock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    IndexField (INDX, DATA, AnyAcc, NoLock, Preserve)
                    {
                        AccessAs (ByteAcc, 0x00), 
                        Offset (0x02), 
                        CFG,    8, 
                        Offset (0x07), 
                        LDN,    8, 
                        Offset (0x22), 
                        PWC,    8, 
                        LPWC,   8, 
                        Offset (0x30), 
                        ACTR,   1, 
                        Offset (0x60), 
                        IOAH,   8, 
                        IOAL,   8, 
                        Offset (0x70), 
                        INTR,   8, 
                        Offset (0x74), 
                        DMCH,   8, 
                        Offset (0xF0), 
                        OPT1,   8, 
                        OPT2,   8, 
                        OPT3,   8
                    }

                    IndexField (INDX, DATA, AnyAcc, NoLock, WriteAsOnes)
                    {
                        Offset (0xF0), 
                        LPTM,   3
                    }

                    Method (ENFG, 0, NotSerialized)
                    {
                        Store (0x55, INDX)
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Store (0xAA, INDX)
                    }

                    Device (COM1)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x04, LDN)
                            If (ACTR)
                            {
                                Store (0x0F, Local1)
                            }
                            Else
                            {
                                Store (0x0D, Local1)
                            }

                            EXFG ()
                            Release (S192)
                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x04, LDN)
                            Store (Zero, ACTR)
                            EXFG ()
                            Release (S192)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (RSRC, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {}
                            })
                            CreateByteField (RSRC, 0x02, IO1)
                            CreateByteField (RSRC, 0x03, IO2)
                            CreateByteField (RSRC, 0x04, IO3)
                            CreateByteField (RSRC, 0x05, IO4)
                            CreateWordField (RSRC, 0x09, IRQV)
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x04, LDN)
                            If (ACTR)
                            {
                                Store (IOAL, IO1)
                                Store (IOAH, IO2)
                                Store (IOAL, IO3)
                                Store (IOAH, IO4)
                                Store (0x01, Local0)
                                ShiftLeft (Local0, INTR, IRQV)
                            }

                            EXFG ()
                            Release (S192)
                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            EndDependentFn ()
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IO1)
                            CreateByteField (Arg0, 0x03, IO2)
                            CreateWordField (Arg0, 0x09, IRQV)
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x04, LDN)
                            Store (IO1, IOAL)
                            Store (IO2, IOAH)
                            FindSetRightBit (IRQV, Local0)
                            Subtract (Local0, 0x01, INTR)
                            Store (0x01, ACTR)
                            EXFG ()
                            Release (S192)
                        }
                    }

                    Device (FDC)
                    {
                        Name (_HID, EisaId ("PNP0700"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x00, LDN)
                            If (ACTR)
                            {
                                Store (0x0F, Local1)
                            }
                            Else
                            {
                                Store (0x0D, Local1)
                            }

                            EXFG ()
                            Release (S192)
                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            And (PWC, 0xFE, PWC)
                            Release (S192)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (RSRC, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x06)
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x01)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer16) {}
                            })
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x00, LDN)
                            If (ACTR)
                            {
                                CreateByteField (RSRC, 0x02, IO1)
                                CreateByteField (RSRC, 0x03, IO2)
                                CreateByteField (RSRC, 0x04, IO3)
                                CreateByteField (RSRC, 0x05, IO4)
                                CreateByteField (RSRC, 0x0A, IO5)
                                CreateByteField (RSRC, 0x0B, IO6)
                                CreateByteField (RSRC, 0x0C, IO7)
                                CreateByteField (RSRC, 0x0D, IO8)
                                CreateWordField (RSRC, 0x11, IRQV)
                                CreateByteField (RSRC, 0x14, DMAV)
                                Store (IOAL, IO1)
                                Store (IOAH, IO2)
                                Store (IOAL, IO3)
                                Store (IOAH, IO4)
                                Add (IOAL, 0x07, IO5)
                                Store (IOAH, IO6)
                                Add (IOAL, 0x07, IO7)
                                Store (IOAH, IO8)
                                Store (0x01, Local0)
                                ShiftLeft (Local0, INTR, IRQV)
                                Store (0x01, Local0)
                                ShiftLeft (Local0, DMCH, DMAV)
                            }

                            EXFG ()
                            Release (S192)
                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x03F0, 0x03F0, 0x08, 0x06)
                                IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                                IRQNoFlags () {6}
                                DMA (Compatibility, NotBusMaster, Transfer8) {2}
                            }
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0370, 0x0370, 0x08, 0x06)
                                IO (Decode16, 0x0377, 0x0377, 0x01, 0x01)
                                IRQNoFlags () {6}
                                DMA (Compatibility, NotBusMaster, Transfer8) {2}
                            }
                            EndDependentFn ()
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IO1)
                            CreateByteField (Arg0, 0x03, IO2)
                            CreateWordField (Arg0, 0x11, IRQV)
                            CreateByteField (Arg0, 0x14, DMAV)
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x00, LDN)
                            Store (IO1, IOAL)
                            Store (IO2, IOAH)
                            FindSetRightBit (IRQV, Local0)
                            Subtract (Local0, 0x01, INTR)
                            FindSetRightBit (DMAV, Local0)
                            Subtract (Local0, 0x01, DMCH)
                            Store (0x01, ACTR)
                            Or (PWC, 0x01, PWC)
                            EXFG ()
                            Release (S192)
                        }
                    }

                    Device (ECP)
                    {
                        Name (_HID, EisaId ("PNP0401"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x03, LDN)
                            If (ACTR)
                            {
                                Store (LPTM, Local0)
                                And (Local0, 0x07, Local0)
                                If (LEqual (Local0, 0x02))
                                {
                                    Store (0x0F, Local1)
                                }
                                Else
                                {
                                    Store (0x0D, Local1)
                                }
                            }
                            Else
                            {
                                Store (0x0D, Local1)
                            }

                            EXFG ()
                            Release (S192)
                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x03, LDN)
                            Store (0x00, ACTR)
                            Store (0x00, DMCH)
                            EXFG ()
                            Release (S192)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x03, LDN)
                            Name (CRSB, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer16) {}
                            })
                            CreateByteField (CRSB, 0x02, IOB1)
                            CreateByteField (CRSB, 0x03, IOB2)
                            CreateByteField (CRSB, 0x04, IOB3)
                            CreateByteField (CRSB, 0x05, IOB4)
                            CreateByteField (CRSB, 0x06, ALB1)
                            CreateByteField (CRSB, 0x07, LNB1)
                            CreateByteField (CRSB, 0x0A, IOB5)
                            CreateByteField (CRSB, 0x0B, IOB6)
                            CreateByteField (CRSB, 0x0C, IOB7)
                            CreateByteField (CRSB, 0x0D, IOB8)
                            CreateByteField (CRSB, 0x0E, ALB2)
                            CreateByteField (CRSB, 0x0F, LNB2)
                            CreateWordField (CRSB, 0x11, IRQB)
                            CreateWordField (CRSB, 0x14, DMAV)
                            If (ACTR)
                            {
                                Store (IOAL, IOB1)
                                Store (IOAH, IOB2)
                                Store (IOAL, IOB3)
                                Store (IOAH, IOB4)
                                Store (IOAL, IOB5)
                                Add (IOAH, 0x04, IOB6)
                                Store (IOAL, IOB7)
                                Add (IOAH, 0x04, IOB8)
                                If (LEqual (IOAL, 0xBC))
                                {
                                    Store (0x08, ALB1)
                                    Store (0x03, LNB1)
                                    Store (0x08, ALB2)
                                    Store (0x03, LNB2)
                                }

                                Store (0x01, Local0)
                                ShiftLeft (Local0, INTR, IRQB)
                                Store (0x01, Local0)
                                ShiftLeft (Local0, DMCH, DMAV)
                                Return (CRSB)
                            }
                            Else
                            {
                                Return (CRSB)
                            }

                            EXFG ()
                            Release (S192)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            EndDependentFn ()
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            Acquire (S192, 0xFFFF)
                            ENFG ()
                            Store (0x03, LDN)
                            CreateByteField (Arg0, 0x02, IOB1)
                            CreateByteField (Arg0, 0x03, IOB2)
                            CreateByteField (Arg0, 0x04, IOB3)
                            CreateByteField (Arg0, 0x05, IOB4)
                            CreateByteField (Arg0, 0x06, ALB1)
                            CreateByteField (Arg0, 0x07, LNB1)
                            CreateByteField (Arg0, 0x0A, IOB5)
                            CreateByteField (Arg0, 0x0B, IOB6)
                            CreateByteField (Arg0, 0x0C, IOB7)
                            CreateByteField (Arg0, 0x0D, IOB8)
                            CreateByteField (Arg0, 0x0E, ALB2)
                            CreateByteField (Arg0, 0x0F, LNB2)
                            CreateWordField (Arg0, 0x11, IRQB)
                            CreateWordField (Arg0, 0x14, DMAV)
                            Store (IOB1, IOAL)
                            Store (IOB2, IOAH)
                            FindSetLeftBit (IRQB, Local0)
                            Subtract (Local0, 0x01, INTR)
                            FindSetLeftBit (DMAV, Local0)
                            Subtract (Local0, 0x01, DMCH)
                            Store (0x01, ACTR)
                            Store (LPTM, Local0)
                            And (Local0, 0xF8, Local0)
                            Or (Local0, 0x02, Local0)
                            Store (Local0, LPTM)
                            EXFG ()
                            Release (S192)
                        }
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        IO (Decode16, 0x0480, 0x0480, 0x01, 0x10)
                        DMA (Compatibility, NotBusMaster, Transfer16) {4}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQ (Edge, ActiveHigh, Exclusive) {2}
                    })
                }

                Device (TIME)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x02)
                        IRQNoFlags () {8}
                    })
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x1000, 0x1000, 0x01, 0x90)
                        IO (Decode16, 0x8090, 0x8090, 0x01, 0x70)
                        IO (Decode16, 0x8100, 0x8100, 0x01, 0x20)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0xFE00, 0xFE00, 0x01, 0x01)
                        IO (Decode16, 0x002E, 0x002E, 0x01, 0x01)
                        IO (Decode16, 0x002F, 0x002F, 0x01, 0x01)
                        IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x02)
                        Memory32Fixed (ReadOnly, 0xFEC00000, 0x00100000)
                        Memory32Fixed (ReadOnly, 0xFEE00000, 0x00100000)
                        Memory32Fixed (ReadOnly, 0xFFC00000, 0x00001000)
                        Memory32Fixed (ReadOnly, 0xFFE00000, 0x00001000)
                        Memory32Fixed (ReadOnly, 0xFFE80000, 0x00080000)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x01C0, 0x01C0, 0x01, 0x10)
                        IO (Decode16, 0x0500, 0x0500, 0x01, 0x80)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x02, PMMN)
                        CreateWordField (RSRC, 0x04, PMMX)
                        And (\_SB.PCI0.LPCB.Z001, 0xFF80, PMMN)
                        Store (PMMN, PMMX)
                        Return (RSRC)
                    }
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0B)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                Device (KBC)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_UID, 0x01)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQNoFlags () {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_UID, 0x00)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive) {12}
                    })
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x19)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, Local0)
                            If (Local0)
                            {
                                Store (0x01, ECEN)
                            }
                            Else
                            {
                                Store (0x00, ECEN)
                            }
                        }
                    }

                    Mutex (MUT0, 0x00)
                    Mutex (MUT1, 0x00)
                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x60), 
                        SMPR,   8, 
                        SMST,   8, 
                        SMAD,   8, 
                        SMCM,   8, 
                        SMD0,   256, 
                        BCNT,   8, 
                        SMAA,   8, 
                        BATD,   16, 
                        Offset (0x91), 
                            ,   4, 
                        ACST,   1, 
                        Offset (0x9C), 
                        THRL,   8, 
                        BTMD,   8, 
                        BTCS,   8, 
                        BTMN,   8, 
                        BTSN,   16, 
                        BTDV,   16, 
                        BTDC,   16, 
                        LFCC,   16, 
                        BATV,   16, 
                        BATC,   16, 
                        BATT,   16, 
                        BTRC,   16, 
                        BTST,   16, 
                        OBTS,   7, 
                        BATF,   1
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        SMW0,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        SMB0,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD0,   64
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD1,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD2,   192
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD3,   256
                    }

                    Method (SMRD, 4, NotSerialized)
                    {
                        If (LNot (\_SB.ECEN))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x07)))
                        {
                            If (LNot (LEqual (Arg0, 0x09)))
                            {
                                If (LNot (LEqual (Arg0, 0x0B)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x07))
                            {
                                Store (SMB0, Arg3)
                            }

                            If (LEqual (Arg0, 0x09))
                            {
                                Store (SMW0, Arg3)
                            }

                            If (LEqual (Arg0, 0x0B))
                            {
                                Store (BCNT, Local3)
                                ShiftRight (0x0100, 0x03, Local2)
                                If (LGreater (Local3, Local2))
                                {
                                    Store (Local2, Local3)
                                }

                                If (LLess (Local3, 0x09))
                                {
                                    Store (FLD0, Local2)
                                }
                                Else
                                {
                                    If (LLess (Local3, 0x11))
                                    {
                                        Store (FLD1, Local2)
                                    }
                                    Else
                                    {
                                        If (LLess (Local3, 0x19))
                                        {
                                            Store (FLD2, Local2)
                                        }
                                        Else
                                        {
                                            Store (FLD3, Local2)
                                        }
                                    }
                                }

                                Increment (Local3)
                                Store (Buffer (Local3) {}, Local4)
                                Decrement (Local3)
                                Store (Zero, Local5)
                                While (LGreater (Local3, Local5))
                                {
                                    GBFE (Local2, Local5, RefOf (Local6))
                                    PBFE (Local4, Local5, Local6)
                                    Increment (Local5)
                                }

                                PBFE (Local4, Local5, 0x00)
                                Store (Local4, Arg3)
                            }
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
                        If (LNot (\_SB.ECEN))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x06)))
                        {
                            If (LNot (LEqual (Arg0, 0x08)))
                            {
                                If (LNot (LEqual (Arg0, 0x0A)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            If (LEqual (Arg0, 0x06))
                            {
                                Store (Arg3, SMB0)
                            }

                            If (LEqual (Arg0, 0x08))
                            {
                                Store (Arg3, SMW0)
                            }

                            If (LEqual (Arg0, 0x0A))
                            {
                                Store (Arg3, SMD0)
                            }

                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (GBFE, 3, NotSerialized)
                    {
                        CreateByteField (Arg0, Arg1, TIDX)
                        Store (TIDX, Arg2)
                    }

                    Method (PBFE, 3, NotSerialized)
                    {
                        CreateByteField (Arg0, Arg1, TIDX)
                        Store (Arg2, TIDX)
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q0E, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPCB.Z000)
                        {
                            \_SB.PCI0.LPCB.PHSR (0x01, 0x00)
                        }
                        Else
                        {
                            \_SB.PCI0.AGPB.VGA.DRUL (0x01)
                        }
                    }

                    Method (_Q0F, 0, NotSerialized)
                    {
                        XOr (\_SB.PCI0.LPCB.BLIT, 0x01, \_SB.PCI0.LPCB.BLIT)
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Notify (\_SB.ACAD, 0x80)
                        Sleep (0x01F4)
                        \_SB.BAT1.Z008 ()
                        Notify (\_SB.BAT1, 0x80)
                        If (\_SB.BAT1.BTCH)
                        {
                            \_SB.BAT1.UBIF ()
                            Notify (\_SB.BAT1, 0x81)
                            Store (0x00, \_SB.BAT1.BTCH)
                        }
                    }
                }
            }

            Device (IEEE)
            {
                Name (_ADR, 0x00020003)
            }

            Device (IDE)
            {
                Name (_ADR, 0x00020005)
                Name (IO5T, Package (0x03)
                {
                    Package (0x07)
                    {
                        0x78, 
                        0xB4, 
                        0x014A, 
                        0x0186, 
                        0x0258, 
                        0x78, 
                        0x96
                    }, 

                    Package (0x07)
                    {
                        0x06, 
                        0x07, 
                        0x1C, 
                        0x1C, 
                        0x1C, 
                        0x06, 
                        0x07
                    }, 

                    Package (0x07)
                    {
                        0x04, 
                        0x09, 
                        0x03, 
                        0x09, 
                        0x1E, 
                        0x04, 
                        0x06
                    }
                })
                Name (IO6T, Package (0x03)
                {
                    Package (0x07)
                    {
                        0x78, 
                        0xB4, 
                        0x014A, 
                        0x0186, 
                        0x0258, 
                        0x78, 
                        0xB4
                    }, 

                    Package (0x07)
                    {
                        0x09, 
                        0x0A, 
                        0x26, 
                        0x26, 
                        0x26, 
                        0x09, 
                        0x0A
                    }, 

                    Package (0x07)
                    {
                        0x05, 
                        0x0C, 
                        0x04, 
                        0x0C, 
                        0x28, 
                        0x05, 
                        0x0C
                    }
                })
                Name (UM5T, Package (0x06)
                {
                    0x0B, 
                    0x07, 
                    0x05, 
                    0x04, 
                    0x02, 
                    0x01
                })
                Name (UM6T, Package (0x07)
                {
                    0x0F, 
                    0x0A, 
                    0x07, 
                    0x05, 
                    0x03, 
                    0x02, 
                    0x01
                })
                Name (PIO5, Package (0x05)
                {
                    0x3A, 
                    0x25, 
                    0x1F, 
                    0x10, 
                    0x0A
                })
                Name (PIO6, Package (0x05)
                {
                    0x4E, 
                    0x32, 
                    0x2A, 
                    0x16, 
                    0x0E
                })
                Name (CRCT, Package (0x07)
                {
                    0x06, 
                    0x04, 
                    0x03, 
                    0x01, 
                    0x01, 
                    0x01, 
                    0x01
                })
                Name (INTT, Package (0x05)
                {
                    0x02, 
                    0x02, 
                    0x02, 
                    0x04, 
                    0x06
                })
                Name (DMAT, Package (0x05)
                {
                    0x00, 
                    0x01, 
                    0x01, 
                    0x01, 
                    0x02
                })
                Name (RMFL, 0x01)
                OperationRegion (CF40, PCI_Config, 0x40, 0x18)
                Field (CF40, WordAcc, NoLock, Preserve)
                {
                        ,   1, 
                    IOR0,   1, 
                    UDM0,   1, 
                    UM60,   1, 
                    UCT0,   4, 
                    CRC0,   4, 
                    INI0,   4, 
                    ATT0,   6, 
                    Offset (0x03), 
                    RCT0,   6, 
                    Offset (0x04), 
                        ,   1, 
                    IOR1,   1, 
                    UDM1,   1, 
                    UM61,   1, 
                    UCT1,   4, 
                    CRC1,   4, 
                    INI1,   4, 
                    ATT1,   6, 
                    Offset (0x07), 
                    RCT1,   6, 
                    Offset (0x08), 
                        ,   1, 
                    IOR2,   1, 
                    UDM2,   1, 
                    UM62,   1, 
                    UCT2,   4, 
                    CRC2,   4, 
                    INI2,   4, 
                    ATT2,   6, 
                    Offset (0x0B), 
                    RCT2,   6, 
                    Offset (0x0C), 
                        ,   1, 
                    IOR3,   1, 
                    UDM3,   1, 
                    UM63,   1, 
                    UCT3,   4, 
                    CRC3,   4, 
                    INI3,   4, 
                    ATT3,   6, 
                    Offset (0x0F), 
                    RCT3,   6, 
                    Offset (0x10), 
                        ,   1, 
                    CHE0,   1, 
                    Offset (0x12), 
                        ,   1, 
                    CHE1,   1, 
                    Offset (0x14), 
                        ,   30, 
                    REMP,   1, 
                    Offset (0x18)
                }

                Name (IDEP, Buffer (0x14) {})
                CreateDWordField (IDEP, 0x00, GTM0)
                CreateDWordField (IDEP, 0x04, GTM1)
                CreateDWordField (IDEP, 0x08, GTM2)
                CreateDWordField (IDEP, 0x0C, GTM3)
                CreateDWordField (IDEP, 0x10, GTM4)
                Device (IDE0)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (0xFFFFFFFF, Local0)
                        Store (0xFFFFFFFF, Local1)
                        Store (0xFFFFFFFF, Local2)
                        Store (0xFFFFFFFF, Local3)
                        Store (0x10, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (CHE0)
                        {
                            If (LNot (LEqual (ATT0, 0x00)))
                            {
                                Add (RCT0, 0x01, Local5)
                                Add (ATT0, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM60, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local0)
                                ShiftRight (Local0, 0x01, Local0)
                                If (LNot (LGreater (Local0, 0xB4)))
                                {
                                    Store (Local0, Local1)
                                }

                                If (IOR0)
                                {
                                    Or (Local4, 0x02, Local4)
                                }

                                If (UDM0)
                                {
                                    Add (UCT0, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local1)
                                    Or (Local4, 0x01, Local4)
                                }
                            }

                            If (LNot (LEqual (ATT1, 0x00)))
                            {
                                Add (RCT1, 0x01, Local5)
                                Add (ATT1, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM61, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local2)
                                ShiftRight (Local2, 0x01, Local2)
                                If (LNot (LGreater (Local2, 0xB4)))
                                {
                                    Store (Local2, Local3)
                                }

                                If (IOR1)
                                {
                                    Or (Local4, 0x08, Local4)
                                }

                                If (UDM1)
                                {
                                    Add (UCT1, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local3)
                                    Or (Local4, 0x04, Local4)
                                }
                            }
                        }

                        Store (RMFL, REMP)
                        Store (Local0, GTM0)
                        Store (Local1, GTM1)
                        Store (Local2, GTM2)
                        Store (Local3, GTM3)
                        Store (Local4, GTM4)
                        Return (IDEP)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, IDEP)
                        Store (GTM0, Local0)
                        Store (GTM1, Local1)
                        Store (GTM2, Local2)
                        Store (GTM3, Local3)
                        Store (GTM4, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNot (LEqual (Local1, 0x00))))
                        {
                            If (And (Local4, 0x01))
                            {
                                Store (0x01, UDM0)
                                If (LLess (Local1, 0x14))
                                {
                                    Store (0x01, UM60)
                                    Store (0x01, UCT0)
                                }
                                Else
                                {
                                    Store (0x00, UM60)
                                    Divide (Local1, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT0)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC0)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNot (LEqual (Local0, 0x00))))
                        {
                            If (UM60)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT0)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT0)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT0)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT0)
                                Store (DerefOf (Index (INTT, Local6)), INI0)
                            }
                        }

                        If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNot (LEqual (Local3, 0x00))))
                        {
                            If (And (Local4, 0x04))
                            {
                                Store (0x01, UDM1)
                                If (LLess (Local3, 0x14))
                                {
                                    Store (0x01, UM61)
                                    Store (0x01, UCT1)
                                }
                                Else
                                {
                                    Store (0x00, UM61)
                                    Divide (Local3, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT1)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC1)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNot (LEqual (Local2, 0x00))))
                        {
                            If (UM61)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT1)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT1)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT1)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT1)
                                Store (DerefOf (Index (INTT, Local6)), INI1)
                            }
                        }

                        Store (RMFL, REMP)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT0, 0x00)))
                            {
                                Add (ATT0, RCT0, Local5)
                                If (UM60)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM0)
                                {
                                    If (UM60)
                                    {
                                        Store (Match (UM6T, MEQ, UCT0, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT0, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT1, 0x00)))
                            {
                                Add (ATT1, RCT1, Local5)
                                If (UM61)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM1)
                                {
                                    If (UM61)
                                    {
                                        Store (Match (UM6T, MEQ, UCT1, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT1, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }
                }

                Device (IDE1)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (0xFFFFFFFF, Local0)
                        Store (0xFFFFFFFF, Local1)
                        Store (0xFFFFFFFF, Local2)
                        Store (0xFFFFFFFF, Local3)
                        Store (0x10, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (CHE1)
                        {
                            If (LNot (LEqual (ATT2, 0x00)))
                            {
                                Add (RCT2, 0x01, Local5)
                                Add (ATT2, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM62, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local0)
                                ShiftRight (Local0, 0x01, Local0)
                                If (LNot (LGreater (Local0, 0xB4)))
                                {
                                    Store (Local0, Local1)
                                }

                                If (IOR2)
                                {
                                    Or (Local4, 0x02, Local4)
                                }

                                If (UDM2)
                                {
                                    Add (UCT2, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local1)
                                    Or (Local4, 0x01, Local4)
                                }
                            }

                            If (LNot (LEqual (ATT3, 0x00)))
                            {
                                Add (RCT3, 0x01, Local5)
                                Add (ATT3, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM63, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local2)
                                ShiftRight (Local2, 0x01, Local2)
                                If (LNot (LGreater (Local2, 0xB4)))
                                {
                                    Store (Local2, Local3)
                                }

                                If (IOR3)
                                {
                                    Or (Local4, 0x08, Local4)
                                }

                                If (UDM3)
                                {
                                    Add (UCT3, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local3)
                                    Or (Local4, 0x04, Local4)
                                }
                            }
                        }

                        Store (RMFL, REMP)
                        Store (Local0, GTM0)
                        Store (Local1, GTM1)
                        Store (Local2, GTM2)
                        Store (Local3, GTM3)
                        Store (Local4, GTM4)
                        Return (IDEP)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, IDEP)
                        Store (GTM0, Local0)
                        Store (GTM1, Local1)
                        Store (GTM2, Local2)
                        Store (GTM3, Local3)
                        Store (GTM4, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNot (LEqual (Local1, 0x00))))
                        {
                            If (And (Local4, 0x01))
                            {
                                Store (0x01, UDM2)
                                If (LLess (Local1, 0x14))
                                {
                                    Store (0x01, UM62)
                                    Store (0x01, UCT2)
                                }
                                Else
                                {
                                    Store (0x00, UM62)
                                    Divide (Local1, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT2)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC2)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNot (LEqual (Local0, 0x00))))
                        {
                            If (UM62)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT2)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT2)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT2)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT2)
                                Store (DerefOf (Index (INTT, Local6)), INI2)
                            }
                        }

                        If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNot (LEqual (Local3, 0x00))))
                        {
                            If (And (Local4, 0x04))
                            {
                                Store (0x01, UDM3)
                                If (LLess (Local3, 0x14))
                                {
                                    Store (0x01, UM63)
                                    Store (0x01, UCT3)
                                }
                                Else
                                {
                                    Store (0x00, UM63)
                                    Divide (Local3, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT3)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC3)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNot (LEqual (Local2, 0x00))))
                        {
                            If (UM63)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT3)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT3)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT3)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT3)
                                Store (DerefOf (Index (INTT, Local6)), INI3)
                            }
                        }

                        Store (RMFL, REMP)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT2, 0x00)))
                            {
                                Add (ATT2, RCT2, Local5)
                                If (UM62)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM2)
                                {
                                    If (UM62)
                                    {
                                        Store (Match (UM6T, MEQ, UCT2, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT2, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }

                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                            \_SB.PCI0.LPCB.PHSR (0x09, 0x00)
                            Sleep (0x01F4)
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT3, 0x00)))
                            {
                                Add (ATT3, RCT3, Local5)
                                If (UM63)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM3)
                                {
                                    If (UM63)
                                    {
                                        Store (Match (UM6T, MEQ, UCT3, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT3, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }
                }
            }

            Device (MDEM)
            {
                Name (_ADR, 0x00020006)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
            }

            Device (AUDI)
            {
                Name (_ADR, 0x00020007)
            }

            Device (USB1)
            {
                Name (_ADR, 0x00030000)
                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
            }

            Device (USB2)
            {
                Name (_ADR, 0x00030001)
                Name (_PRW, Package (0x02)
                {
                    0x04, 
                    0x03
                })
            }

            Device (USB3)
            {
                Name (_ADR, 0x00030002)
                Name (_PRW, Package (0x02)
                {
                    0x07, 
                    0x03
                })
            }

            Device (USB4)
            {
                Name (_ADR, 0x00030003)
            }

            Device (LAN)
            {
                Name (_ADR, 0x00040000)
                Name (_PRW, Package (0x02)
                {
                    0x0C, 
                    0x04
                })
            }

            Device (CBUS)
            {
                Name (_ADR, 0x000A0000)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (_PRW, Package (0x02)
            {
                0x17, 
                0x03
            })
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPCB.LIDS)
                {
                    Store (0x00, \_SB.PCI0.LPCB.LIDP)
                    Return (0x01)
                }
                Else
                {
                    Store (0x01, \_SB.PCI0.LPCB.LIDP)
                    Return (0x00)
                }
            }
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (ACST, 0x00)
            Method (_PSR, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPCB.EC0.ACST, Local0)
                Release (\_SB.PCI0.LPCB.EC0.MUT1)
                If (Local0)
                {
                    Store (0x01, ACST)
                    If (LEqual (\_TZ.THRM.HOTE, 0x00))
                    {
                        \_SB.PCI0.LPCB.THRL (0x00)
                    }

                    Return (0x01)
                }
                Else
                {
                    Store (0x00, ACST)
                    \_SB.PCI0.LPCB.THRL (0x01)
                    Return (0x00)
                }
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (CBTI, 0x00)
            Name (PBTI, 0x00)
            Name (BTIN, 0x00)
            Name (BTCH, 0x00)
            Name (BIFI, 0x00)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0x1932, 
                0x1932, 
                0x01, 
                0x2B5C, 
                0x012C, 
                0x14, 
                0x20, 
                0x20, 
                "BAT1      ", 
                "          ", 
                "          ", 
                "          "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                /* was: Z009, 
                        Z009,*/
		Z00A,
		Z00A, 
                0x2710
            })
            Name (ERRC, 0x00)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Method (_STA, 0, NotSerialized)
            {
                Z008 ()
                If (BTIN)
                {
                    Return (0x1F)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (LEqual (BIFI, 0x00))
                {
                    \_SB.BAT1.UBIF ()
                    Store (0x01, BIFI)
                }

                Return (PBIF)
            }

            Method (UBIF, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPCB.EC0.BTDC, Local0)
                Store (\_SB.PCI0.LPCB.EC0.LFCC, Local1)
                Store (\_SB.PCI0.LPCB.EC0.BTDV, Local2)
                Store (\_SB.PCI0.LPCB.EC0.BTMD, Local3)
                Store (\_SB.PCI0.LPCB.EC0.BTMN, Local4)
                Store (\_SB.PCI0.LPCB.EC0.BTSN, Local5)
                If (LEqual (Local1, 0x00))
                {
                    Store (0x01, \_SB.PCI0.LPCB.EC0.BATF)
                }

                Release (\_SB.PCI0.LPCB.EC0.MUT1)
                Store (Local0, Index (PBIF, 0x01))
                Store (Local1, Index (PBIF, 0x02))
                Store (Local2, Index (PBIF, 0x04))
                Store ("LION", Index (PBIF, 0x0B))
                If (LEqual (Local3, 0x01))
                {
                    Store ("01DTR", Index (PBIF, 0x09))
                }
                Else
                {
                    If (LEqual (Local3, 0x02))
                    {
                        Store ("02DTR", Index (PBIF, 0x09))
                    }
                    Else
                    {
                        If (LEqual (Local3, 0x03))
                        {
                            Store ("03DTR", Index (PBIF, 0x09))
                        }
                        Else
                        {
                            If (LEqual (Local3, 0x04))
                            {
                                Store ("04DTR", Index (PBIF, 0x09))
                            }
                        }
                    }
                }

                If (LEqual (Local4, 0x01))
                {
                    Store ("MOTOROLA", Index (PBIF, 0x0C))
                }
                Else
                {
                    If (LEqual (Local4, 0x02))
                    {
                        Store ("SIMPLO", Index (PBIF, 0x0C))
                    }
                    Else
                    {
                        If (LEqual (Local4, 0x03))
                        {
                            Store ("SANYO", Index (PBIF, 0x0C))
                        }
                        Else
                        {
                            If (LEqual (Local4, 0x04))
                            {
                                Store ("SONY", Index (PBIF, 0x0C))
                            }
                        }
                    }
                }

                Store (ITOS (ToBCD (Local5)), Index (PBIF, 0x0A))
            }

            Method (_BST, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPCB.EC0.OBTS, Local0)
                Store (\_SB.PCI0.LPCB.EC0.BTRC, Local1)
                Store (\_SB.PCI0.LPCB.EC0.BATC, Local2)
                Store (\_SB.PCI0.LPCB.EC0.BATV, Local3)
                Store (\_SB.PCI0.LPCB.EC0.ACST, Local4)
                Release (\_SB.PCI0.LPCB.EC0.MUT1)
                Store (CBTI, PBTI)
                Store (Local0, CBTI)
                Store (Local1, DBPG)
                If (LEqual (And (Local0, 0x01), 0x00))
                {
                    Store (0x00, Index (PBST, 0x00))
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                    Store (0xFFFFFFFF, Index (PBST, 0x02))
                    Store (0xFFFFFFFF, Index (PBST, 0x03))
                    If (LEqual (BTIN, 0x01))
                    {
                        Store (0x01, BTCH)
                        Store (0x00, BIFI)
                    }

                    Store (0x00, BTIN)
                    Return (PBST)
                }
                Else
                {
                    If (LEqual (BTIN, 0x00))
                    {
                        Store (0x01, BTCH)
                        Store (0x00, BIFI)
                    }

                    Store (0x01, BTIN)
                }

                Store (0x00, Index (PBST, 0x00))
                Store (0x00, Index (PBST, 0x01))
                Store (0x00, Index (PBST, 0x02))
                Store (0x00, Index (PBST, 0x03))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (Local1, Index (PBST, 0x02))
                Store (Local3, Index (PBST, 0x03))
                Store (0x00, Local5)
                If (Local4)
                {
                    If (LEqual (And (Local0, 0x08), 0x00))
                    {
                        Store (0x02, Local5)
                    }
                }
                Else
                {
                    Store (0x01, Local5)
                    If (LAnd (Local0, 0x20))
                    {
                        Or (0x04, Local5)
                    }
                }

                Store (Local5, Index (PBST, 0x00))
                Return (PBST)
            }

            Method (Z008, 0, NotSerialized)
            {
                If (\_SB.ECEN)
                {
                    Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPCB.EC0.OBTS, Local0)
                    Store (0x01, \_SB.PCI0.LPCB.EC0.BATF)
                    Release (\_SB.PCI0.LPCB.EC0.MUT1)
                    And (Local0, 0x01, Local0)
                    If (LEqual (Local0, 0x00))
                    {
                        If (LEqual (\_SB.BAT1.BTIN, 0x01))
                        {
                            Store (0x01, \_SB.BAT1.BTCH)
                            Store (0x00, BIFI)
                        }

                        Store (0x00, \_SB.BAT1.BTIN)
                    }
                    Else
                    {
                        If (LEqual (\_SB.BAT1.BTIN, 0x00))
                        {
                            Store (0x01, \_SB.BAT1.BTCH)
                            Store (0x00, BIFI)
                        }

                        Store (0x01, \_SB.BAT1.BTIN)
                    }
                }
            }

            Method (ITOS, 1, NotSerialized)
            {
                Store (Buffer (0x09)
                    {
                        0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00
                    }, Local0)
                Store (Buffer (0x11)
                    {
                        "0123456789ABCDEF"
                    }, Local7)
                Store (0x08, Local1)
                Store (0x00, Local2)
                Store (0x00, Local3)
                While (Local1)
                {
                    Decrement (Local1)
                    And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
                    If (Local4)
                    {
                        Store (Ones, Local3)
                    }

                    If (Local3)
                    {
                        GBFE (Local7, Local4, RefOf (Local5))
                        PBFE (Local0, Local2, Local5)
                        Increment (Local2)
                    }
                }

                Return (Local0)
            }

            Method (GBFE, 3, NotSerialized)
            {
                CreateByteField (Arg0, Arg1, TIDX)
                Store (TIDX, Arg2)
            }

            Method (PBFE, 3, NotSerialized)
            {
                CreateByteField (Arg0, Arg1, TIDX)
                Store (Arg2, TIDX)
            }

            Method (Z00A, 0, NotSerialized)
            {
                If (LNot (ECEN))
                {
                    Return (0x00)
                }

                Store (0x0C, Local1)
                Store (Buffer (0x0D)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00, 0x00, 0x00, 0x22, 0x00
                    }, Local2)
                While (LGreater (Local1, 0x08))
                {
                    \_SB.PCI0.LPCB.EC0.GBFE (Local2, Local1, RefOf (Local3))
                    If (Local3)
                    {
                        If (LNot (LEqual (\_SB.PCI0.LPCB.EC0.SMRD (0x0B, 0x16, Local3, RefOf (Local4)), 0xFF)))
                        {
                            Store (\_SB.PCI0.LPCB.EC0.BCNT, Local5)
                            Store (Zero, Local3)
                            Store (Zero, ERRC)
                            While (LGreater (Local5, Local3))
                            {
                                \_SB.PCI0.LPCB.EC0.GBFE (Local4, Local3, RefOf (Local6))
                                Increment (Local3)
                                If (And (Local6, 0x80))
                                {
                                    Increment (ERRC)
                                }
                            }

                            If (LEqual (ERRC, 0x00))
                            {
                                Store (Local4, Index (PBIF, Local1))
                                Store (Ones, Local0)
                            }
                        }
                    }
                }

                Decrement (Local1)
            }
        }

        Scope (\_TZ)
        {
            ThermalZone (THRM)
            {
                Name (HOTE, 0x00)
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.PCI0.LPCB.Z003)
                    {
                        Store (0x00, \_SB.PCI0.LPCB.Z003)
                        \_SB.PCI0.LPCB.PHSR (0x03, 0x00)
                    }

                    \_SB.PCI0.LPCB.PHSR (0x02, 0x00)
                    Store (\_SB.PCI0.LPCB.Z004, Local0)
                    If (LNot (LLess (Local0, 0x43)))
                    {
                        \_SB.PCI0.LPCB.THRL (0x01)
                        Store (0x01, HOTE)
                    }

                    If (LAnd (LNot (LGreater (Local0, 0x3D)), LEqual (\_SB.ACAD.ACST, 0x01)))
                    {
                        \_SB.PCI0.LPCB.THRL (0x00)
                        Store (0x00, HOTE)
                    }

                    Store (FANR, Local1)
                    Store (Local1, FANR)
                    Sleep (0x01F4)
                    Store (F1CR, Local2)
                    Store (Local2, F1CR)
                    Return (Add (Multiply (Local0, 0x0A), 0x0AAC))
                }

                Method (_PSV, 0, NotSerialized)
                {
                    Return (Add (Multiply (0x50, 0x0A), 0x0AAC))
                }

                Name (_PSL, Package (0x01)
                {
                    \_PR.CPU0
                })
                Name (_TSP, 0x28)
                Name (_TC1, 0x02)
                Name (_TC2, 0x03)
                Method (_CRT, 0, NotSerialized)
                {
                    Return (Add (Multiply (0x4B, 0x0A), 0x0AAC))
                }
            }
        }
    }

    Method (_PTS, 1, NotSerialized)
    {
        Add (Arg0, 0x50, Local0)
        Store (Local0, DBPG)
        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Store (0x01, \_SB.PCI0.LPCB.Z003)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.PCI0.LPCB.PHSR (0x05, 0x00)
        }

        If (LEqual (Arg0, 0x05))
        {
            \_SB.PCI0.LPCB.PHSR (0x08, 0x00)
        }

        Store (0x11, DBPG)
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (0x55, DBPG)
        Store (0x00, \_SB.PCI0.LPCB.ALED)
        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Notify (\_SB.PCI0.USB1, 0x00)
            Notify (\_SB.PCI0.USB2, 0x00)
            Notify (\_SB.PCI0.USB3, 0x00)
            Notify (\_SB.PCI0.USB4, 0x00)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
        }

        If (LEqual (Arg0, 0x05))
        {
            \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
        }
    }

    Scope (_GPE)
    {
        Method (_L17, 0, NotSerialized)
        {
            Notify (\_SB.LID, 0x80)
        }

        Method (_L12, 0, NotSerialized)
        {
            \_SB.PCI0.LPCB.PHSR (0x03, 0x00)
            Notify (\_TZ.THRM, 0x80)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L0E, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L07, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }
    }
}


--=-T+U0lJNjEJMO3AdWaPMH
Content-Disposition: attachment; filename=interrupts
Content-Type: text/plain; name=interrupts; charset=
Content-Transfer-Encoding: 7bit

           CPU0       
  0:     157937    IO-APIC-edge  timer
  1:       3246    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          1    IO-APIC-edge  acpi
 12:     169129    IO-APIC-edge  PS/2 Mouse
 14:         39    IO-APIC-edge  ide0
 15:      13571    IO-APIC-edge  ide1
 17:          9   IO-APIC-level  ohci1394, O2 Micro, Inc. OZ6912 Cardbus Controller
 18:         83   IO-APIC-level  SiS SI7012
 19:      13434   IO-APIC-level  eth0
 20:          0   IO-APIC-level  usb-ohci
 21:          0   IO-APIC-level  usb-ohci
 22:          0   IO-APIC-level  usb-ohci
NMI:          0 
LOC:     157887 
ERR:          0
MIS:          0

--=-T+U0lJNjEJMO3AdWaPMH
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 80)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e4100000-e41fffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 14)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 3000ns max)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin ? routed to IRQ 255
	Region 4: I/O ports at 1000 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at 1400 [size=256]
	Region 1: I/O ports at 1080 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 173 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 1800 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at e4001000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at e4002000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at e4003000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at e4004000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 91)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 173 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 2000 [size=256]
	Region 1: Memory at e4005000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at 1c000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 1c400000-1c7ff000 (prefetchable)
	Memory window 1: 1c800000-1cbff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0028
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	BIST result: 00
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e4100000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 9000 [size=128]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


--=-T+U0lJNjEJMO3AdWaPMH--



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
