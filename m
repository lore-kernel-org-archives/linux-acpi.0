From: sneed snodgrass <sneed_snodgrass-FFYn/CNdgSA@public.gmane.org>
Subject: ACPI AE_NOT_EXIST error on Omnibook 6100 (latest bios) 2.6.0t4
Date: Sun, 31 Aug 2003 09:58:07 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030831135807.29223.qmail@web20706.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1324829221-1062338287=:28311"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--0-1324829221-1062338287=:28311
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi

I get the following error on an Omnibook 6100 (1GHz
P3m). Occurs with my previous bios (2.20) and latest
bios (2.40). I am trying to get cpufreq to work but it
seems to be dependant on ACPI. Full dmesg attached.
Please respond if you need more information.

Thanks

Sneed

ACPI: Subsystem revision 20030813
    ACPI-1121: *** Error: Method execution failed
[\_SB_.PCI0.HUB_.FDS_.FCB1.CSID] (Node d7e93520),
AE_NOT_EXIST
    ACPI-1121: *** Error: Method execution failed
[\_SB_.PCI0.HUB_.FDS_._REG] (Node d7e938a0),
AE_NOT_EXIST
ACPI: Unable to initialize ACPI objects

cpufreq: No CPUs supporting ACPI performance
management found.




______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
--0-1324829221-1062338287=:28311
Content-Type: text/plain; name="dmesg.txt"
Content-Description: dmesg.txt
Content-Disposition: inline; filename="dmesg.txt"

Linux version 2.6.0-test4 (root@ob6) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #3 Tue Aug 26 18:45:03 EDT 2003
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017f60000 (usable)
 BIOS-e820: 0000000017f60000 - 0000000017f73c00 (ACPI data)
 BIOS-e820: 0000000017f73c00 - 0000000017f80000 (ACPI NVS)
 BIOS-e820: 0000000017f80000 - 0000000018000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98144
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94048 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6610
ACPI: RSDT (v001 PTLTD  EBRSDT   0x02400000  LTP 0x00000000) @ 0x17f682e4
ACPI: FADT (v001 QUANTA EBmador  0x02400000 RT2  0x00000001) @ 0x17f73b64
ACPI: BOOT (v001 PTLTD  EBBFTBL$ 0x02400000  LTP 0x00000001) @ 0x17f73bd8
ACPI: DSDT (v001 HP-MCD EB DSDT  0x02400000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda6 vga=791
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 996.921 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1974.27 BogoMIPS
Memory: 384284k/392576k available (2429k kernel code, 7528k reserved, 877k data, 152k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd968, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.HUB_.FDS_.FCB1.CSID] (Node d7e93520), AE_NOT_EXIST
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.HUB_.FDS_._REG] (Node d7e938a0), AE_NOT_EXIST
ACPI: Unable to initialize ACPI objects
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6680
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa2f7, dseg 0x400
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:10
PM: Adding info for pnp:00:12
PM: Adding info for pnp:00:13
PM: Adding info for pnp:00:17
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [pm]
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Transparent bridge - 0000:00:1e.0
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:02.0
PM: Adding info for pci:0000:02:03.0
PM: Adding info for pci:0000:02:04.0
PM: Adding info for pci:0000:02:05.0
PM: Adding info for pci:0000:02:05.1
PM: Adding info for pci:0000:02:08.0
PCI: Using IRQ router PIIX [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:02:03.0
PCI: IRQ 0 for device 0000:02:05.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:02:05.0
PCI: Sharing IRQ 10 with 0000:00:1d.0
PCI: IRQ 0 for device 0000:02:05.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:02:05.1
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:01:00.0
PCI: Sharing IRQ 10 with 0000:02:02.0
radeonfb_pci_register BEGIN
PCI: Found IRQ 10 for device 0000:01:00.0
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:02:02.0
PCI: Sharing IRQ 10 with 0000:02:05.1
radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
radeonfb: probed DDR SGRAM 16384k videoram
radeon_get_moninfo: bios 4 scratch = 1000044
radeonfb: panel ID string: 1024x768                
radeonfb: detected DFP panel size from BIOS: 1024x768
radeonfb: ATI Radeon M6 LY DDR SGRAM 16 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END
hStart = 1040, hEnd = 1176, hTotal = 1344
vStart = 770, vEnd = 776, vTotal = 806
h_total_disp = 0x7f00a7	   hsync_strt_wid = 0x91040a
v_total_disp = 0x2ff0325	   vsync_strt_wid = 0x860301
post div = 0x2
fb_div = 0x121
ppll_div_3 = 0x10121
ron = 1152, roff = 18284
vclk_freq = 6503, per = 653
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
NTFS driver 2.1.4 [Flags: R/W].
udf: registering filesystem
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
PM: Adding info for platform:floppy0
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 10 for device 0000:02:08.0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:02:03.0
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1820-0x1827, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1828-0x182f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB), CHS=38760/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Enabling device 0000:02:03.0 (0000 -> 0001)
PCI: Found IRQ 5 for device 0000:02:03.0
PCI: Sharing IRQ 5 with 0000:00:1f.1
ALSA device list:
  #0: ESS Allegro PCI at 0x3000, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cpufreq: No CPUs supporting ACPI performance management found.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
Adding 415796k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
e100: eth0 NIC Link is Up 100 Mbps Half duplex

--0-1324829221-1062338287=:28311--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
