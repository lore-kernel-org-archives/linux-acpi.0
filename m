From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 19 Sep 2002 13:41:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032435715.338.5.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_oA6h48ztDukE8OXaumBOmQ)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_oA6h48ztDukE8OXaumBOmQ)
Content-type: text/plain
Content-transfer-encoding: 7BIT

On Thu, 2002-09-19 at 08:27, Grover, Andrew wrote:
> - DOES IT BOOT?

No. This is a Gigabyte 7IXE4 with an Athlon 1,3 GHz. It throws two
oopses (NULL pointer deref at 0..04) just after providing information
about thermal zone. I can write them down, type them in and send them if
necessary.

> Failure to do so either indicates a bug that we need to fix (fast) or a
> system that should go on the blacklist. dmesg now includes the DSDT
> signature to aid blacklisting.

I attach a dmesg-output when booting with acpi=off. I hope that helps.

-Knut

PS: Did you get the ospmd patches I sent to you?

-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105









--Boundary_(ID_oA6h48ztDukE8OXaumBOmQ)
Content-type: text/plain; charset=ISO-8859-1; name=dmesg.ok
Content-disposition: attachment; filename=dmesg.ok
Content-transfer-encoding: 7BIT

This buffer is for notes you don't want to save, and for Lisp evaluation.
If you want to create a file, visit that file with C-x C-f,
then enter the text in that file's own buffer.

Linux version 2.4.20-pre7 (root@bacchus) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Thu Sep 19 13:17:54 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000000f00000 (usable)
 BIOS-e820: 0000000000f00000 - 0000000001000000 (reserved)
 BIOS-e820: 0000000001000000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=devel ro root=301 acpi=off
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1312.973 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2614.88 BogoMIPS
Memory: 255708k/262080k available (1251k kernel code, 4960k reserved, 381k data, 260k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1312.9365 MHz.
..... host bus clock speed is 201.9900 MHz.
cpu: 0, clocks: 2019900, slice: 1009950
CPU0<T0:2019888,T1:1009936,D:2,S:1009950,C:2019900>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20020918
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router AMD756 VIPER [1022/740b] at 00:07.3
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI IS
APNP enabled
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 7
AMD7409: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD400AB-00BVA0, ATA DISK drive
hdc: DVD-ROM BDV212B, ATAPI CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0309c04, I/O limit 4095Mb (mask 0xffffffff)
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(33)
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Partition check:
 hda: hda1 hda2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.26
AMD756: dev 10ec:8139, router pirq : 1 get irq : 10
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd080df00, 00:10:a7:0a:71:f0, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] AGP 0.99 on AMD Irongate @ 0xe8000000 64MB
[drm] Initialized r128 2.2.0 20010917 on minor 0
[drm] AGP 0.99 on AMD Irongate @ 0xe8000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
es1371: version v0.30 time 13:15:13 Sep 19 2002
AMD756: dev 1274:5880, router pirq : 1 get irq : 10
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xdc00 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 260k freed

--Boundary_(ID_oA6h48ztDukE8OXaumBOmQ)--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
