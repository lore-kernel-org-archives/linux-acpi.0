From: Greg Norris <haphazard-mqiTH3uDUMEAvxtiuMwx3w@public.gmane.org>
Subject: sibling not found when "CPU Enumeration Only" selected
Date: Mon, 23 Jun 2003 17:40:34 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030623224034.GA20283@glitch.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
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


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After enabling CPU Enumeration Only (CONFIG_ACPI_HT_ONLY) in my config,
.the kernel is not able to see the sibling processor.  This, of course,
prevents hyperthreading from being enabled.  The sibling is found and
enabled successfully under "normal" ACPI, although different problems
crop up in that case... see my post titled "memory problem with ACPI on
Dell Dimension 8300 (i875p chipset)" in acpi-support if you're curious.

So far I've tested kernel versions 2.5.73, and 2.4.21 with the
20030619 ACPI patch.  I've attached the output from dmesg on 2.5.73.


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.5.73-20030622.out"

Linux version 2.5.73 (root@glitch) (gcc version 3.3 (Debian)) #1 SMP Sun Jun 22 19:45:15 CDT 2003
Video mode to be used for restore is 30a
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff74000 (usable)
 BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACPI NVS)
 BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACPI data)
 BIOS-e820: 000000003ff97000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 262004
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32628 pages, LIFO batch:7
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: Dim 8300     APIC at: 0xFEE00000
Processor #0 15:2 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-2.5 ro root=301 hdd=scsi acpi=on acpismp=force
ide_setup: hdd=scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2992.326 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 5914.62 BogoMIPS
Memory: 1034184k/1048016k available (1431k kernel code, 12920k reserved, 613k data, 128k init, 130512k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.91 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Error: only one processor found.
WARNING: No sibling found for CPU 0.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-13 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 40.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00178020
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
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
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 001 01  1    1    0   1   0    1    1    A1
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    B1
 13 001 01  1    1    0   1   0    1    1    B9
 14 001 01  1    1    0   1   0    1    1    C1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    D1
 17 001 01  1    1    0   1   0    1    1    D9
IRQ to pin mappings:
IRQ0 -> 0:2
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
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2991.0988 MHz.
..... host bus clock speed is 199.0465 MHz.
Starting migration thread for cpu 0
CPUS done 2
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfbb38, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
PCI: Using IRQ router default [8086/24d0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 17
PCI->APIC IRQ transform: (B0,I31,P0) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I2,P0) -> 17
PCI->APIC IRQ transform: (B2,I8,P0) -> 20
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Simple boot flag value 0x87 read from CMOS RAM was invalid
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
highmem bounce pool size: 64 pages
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Initializing Cryptographic API
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L120AVV207-0, ATA DISK drive
hdb: WDC WD2500JB-32EVA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW SW-248F, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 17
ICH5-SATA: neither IDE port enabled (BIOS)
hda: max request size: 1024KiB
hda: host protected area => 1
hda: 234375000 sectors (120000 MB) w/1821KiB Cache, CHS=14589/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
hdb: max request size: 1024KiB
hdb: host protected area => 1
hdb: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: p1 < p5 p6 >
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 1.0.6-ioctl (2002-10-15) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
Adding 1004020k swap on /dev/ide/host0/bus0/target0/lun0/part5.  Priority:-1 extents:1
Adding 1003988k swap on /dev/ide/host0/bus0/target1/lun0/part5.  Priority:-2 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
Intel(R) PRO/100 Network Driver - version 2.3.13-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda8, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 0000:00:1d.7: PCI device 8086:24dd (Intel Corp.)
ehci_hcd 0000:00:1d.7: irq 23, pci mem f88fc800
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 8 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Setting latency timer of device 00:1d.0 to 64
uhci-hcd 0000:00:1d.0: PCI device 8086:24d2 (Intel Corp.)
uhci-hcd 0000:00:1d.0: irq 16, io base 0000ff80
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
uhci-hcd 0000:00:1d.1: PCI device 8086:24d4 (Intel Corp.)
uhci-hcd 0000:00:1d.1: irq 19, io base 0000ff60
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
uhci-hcd 0000:00:1d.2: PCI device 8086:24d7 (Intel Corp.)
uhci-hcd 0000:00:1d.2: irq 18, io base 0000ff40
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
uhci-hcd 0000:00:1d.3: PCI device 8086:24de (Intel Corp.)
uhci-hcd 0000:00:1d.3: irq 16, io base 0000ff20
uhci-hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:0: USB hub found
hub 5-0:0: 2 ports detected
e100: eth0 NIC Link is Up 100 Mbps Full duplex

--7AUc2qLy4jB3hD7Z--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
