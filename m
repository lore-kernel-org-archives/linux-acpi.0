From: Dom <dom-K271P2BsTd0@public.gmane.org>
Subject: IBM Thinkpad A31 | ACPI problems
Date: Wed, 1 Jan 2003 14:45:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301011445.31369.dom@wahuu.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I have got a IBM Thinkpad A31 notebook (BIOS Version 1.04, 
http://www.pc.ibm.com/support?lang=en_US&doctype=&subtype=All&page=brand&up=unknownuser1004106089&menu=model&brand=IBM+ThinkPad&family=IBM+ThinkPad%7CThinkPad+A31&machineType=IBM+ThinkPad%7CThinkPad+A31%7C2652&model=IBM+ThinkPad%7CThinkPad+A31%7C2652%7CM5G) 
which is running Gentoo Linux 1.4_rc1. The previous gentoo-kernel based on 
2.4.19 with acpi-20020918 is running quite smoothley except for some problems 
with the battery state:
 
---- fragment of /var/log/messages: 2.4.19 + acpi20020918 + gentoo patches 
---------
Jan  1 14:35:38 [kernel]  exstore-0278 [19] Ex_store_object_to_ind: Could not 
store object to indexed package element
Jan  1 14:35:38 [kernel] Method pathname:  \_SB_.PCI0.LPC_.EC__.BAT0._BST 
(Node 42ebd4a8)
-------------

Now I compiled a new kernel 2.4.20 with the acpi kernel patch-20021212 and 
ACPI does not work anymore. :-( 
"ACPI: Found ECDT
ACPI: Could not use ECDT"
How comes? If it is of any help to you I would provide further information 
(log messages, etc.) regarding this issue. Thanks in advance for any help! 

---- dmesg: 2.4.20 vanilla + acpi20021212 -----------
Linux version 2.4.20 (root@jonas) (gcc version 3.2) #2 Wed Jan 1 14:08:19 CET 
2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff60000 (usable)
 BIOS-e820: 000000002ff60000 - 000000002ff7a000 (ACPI data)
 BIOS-e820: 000000002ff7a000 - 000000002ff7c000 (ACPI NVS)
 BIOS-e820: 000000002ff7c000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
767MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 196448
zone(0): 4096 pages.
zone(1): 192352 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7060
ACPI: XSDT (v001 IBM    TP-1G    00000.04160) @ 0x2ff6ee48
ACPI: FADT (v001 IBM    TP-1G    00000.04160) @ 0x2ff6ee8c
ACPI: SSDT (v001 IBM    TP-1G    00000.04160) @ 0x2ff6ef40
ACPI: ECDT (v001 IBM    TP-1G    00000.04160) @ 0x2ff79f87
ACPI: BOOT (v001 IBM    TP-1G    00000.04160) @ 0x2ff79fd8
ACPI: DSDT (v001 IBM    TP-1G    00000.04160) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: root=/dev/hda3 append="hdc=ide-scsi"
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1798.514 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3591.37 BogoMIPS
Memory: 773844k/785792k available (2003k kernel code, 11560k reserved, 678k 
data, 132k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021212
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:.........................................................................................................................................................................................................................................................................................................................................................................................................
Table [DSDT] - 1276 Objects with 64 Devices 393 Methods 18 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c03dc71c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
   evgpe-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Found ECDT
ACPI: Could not use ECDT
evxfevnt-0119 [06] Acpi_disable          : ACPI mode disabled
 utalloc-0968 [05] Ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 02:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 02:00.1
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 02:02.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
hdc: DW-28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03f3624, I/O limit 4095Mb (mask 0xffffffff)
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=5168/240/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 1658kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
PCI: Found IRQ 11 for device 02:08.0
eth0: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller, 
00:D0:59:CF:10:21, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized i810 1.2.0 20010920 on minor 2
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
es1371: version v0.30 time 14:10:24 Jan  1 2003
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Found IRQ 11 for device 02:00.1
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
usb.c: registered new driver hub
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Sharing IRQ 11 with 02:00.0
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0x1800, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
uhci.c: USB UHCI at I/O 0x1820, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Sharing IRQ 11 with 02:02.0
PCI: Setting latency timer of device 00:1d.2 to 64
uhci.c: USB UHCI at I/O 0x1840, IRQ 11
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
Adding Swap: 1028152k swap-space (priority -1)
-------------------


Thanks and a happy new year!
Dominik


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
