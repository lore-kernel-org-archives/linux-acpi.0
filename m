From: "Gareth Wheelton" <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Subject: ACPI can't perform S5 soft off
Date: Wed, 02 Jun 2004 16:46:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1BVXrX-0005XU-Dn@sc8-sf-mx1.sourceforge.net>
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

Hi

I'm currently receiving the following final debug messages when I attempt
to power off with ACPI.


dsmthdat-0462 [29] ds_method_data_get_val: Uninitialized local[0] at node
dffe290c

hwsleep-0304 [17] acpi_enter_sleep_state: Entering sleep state[S5]

ACPI: can not not power off machine

evevent-0286: *** Error: No installed handle for fixed event [00000004]


Please can someone assist me with this problem, does this point to a buggy
BIOS and am I stuffed for ACPI power off?


Many thanks in advance


Cheers Gareth


my dmesg is as follows

Linux version 2.4.26 (root-ECCPu7MoMNaR4xdCYaFEMlWX1VGg3526@public.gmane.org) (gcc version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #28 Wed Jun 2 13:25:24 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 VT8371                                    ) @ 0x000f7900
ACPI: RSDT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 VT8371 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Kernel command line: ro root=/dev/sda3 hdb=noprobe hdc=noprobe hdd=noprobe
hde=noprobe hdf=noprobe hdg=noprobe hdh=noprobe
ide_setup: hdb=noprobe
ide_setup: hdc=noprobe
ide_setup: hdd=noprobe
ide_setup: hde=noprobe
ide_setup: hdf=noprobe
ide_setup: hdg=noprobe
ide_setup: hdh=noprobe
Initializing CPU#0
Detected 850.068 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 515608k/524224k available (1545k kernel code, 8228k reserved, 412k
data, 276k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:.......................................................................
Table [DSDT](id F004) - 326 Objects with 30 Devices 71 Methods 21 Regions
ACPI Namespace successfully loaded at root c033f53c
ACPI: IRQ11 SCI: Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at
0000000000004020 on int 11
evgpeblk-0925 [06] ev_create_gpe_block   : Found 5 Wake, Enabled 0 Runtime
GPEs in this block
Completing Region/Field/Buffer/Package
initialization:...........................................
Initialized 21/21 Regions 1/1 Fields 16/16 Buffers 5/9 Packages (335 nodes)
Executing all Device _STA and_INI methods:................................
32 Devices found containing: 32 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/100 Network Driver - version 2.3.38-k1
Copyright (c) 2004 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC32500H, ATA DISK drive
blk: queue c03572e0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 4999680 sectors (2560 MB) w/128KiB Cache, CHS=1024/255/63, DMA
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 123k freed
VFS: Mounted root (ext2 filesystem).
Device Driver for HPT3xx ATA RAID Controller
Version 1.35, Compiled Jun  2 2004 13:25:55
Found Controller: HPT370 UDMA/ATA100 RAID Controller
scsi0 : hpt37x2
  Vendor: HPT Inc.  Model: HPT37x2   RAID 1  Rev: 1.05
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 276k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Real Time Clock Driver v1.10f
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
Adding Swap: 755044k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
NET4: AppleTalk 0.18a for Linux NET4.0




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
