From: "Praveen. C" <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Subject: ACPI on Thinkpad R40e
Date: Fri, 23 Jan 2004 20:24:18 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040123202418.1d6e7cdb.praveen@aero.iisc.ernet.in>
References: <200401222231.i0MMVNKI024536@iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200401222231.i0MMVNKI024536-Lx2V9xx+e3ASDc0kpPPPTw@public.gmane.org>
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

I am running Linux 2.4.22 on IBM Thinkpad R40e (Model 2684-LA2) with
acpi
20031203. ACPI partly works: battery, ac adapter and buttons work. But
if I
try to load processor or thermal then the keyboard hangs and I have to
poweroff. Acpi also seems to interfere with the special keys for volume
and
brightness control; if I boot the same kernel with acpi=off they work
fine otherwise those keys are ineffective. I would like to know if
anybody has had better success.
Thanks
praveen

My dmesg is below:
-----------------------------------------------------------------------
---
Linux version 2.4.22 (root-AOiGnv2RGtY@public.gmane.org) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r1, propolice)) #1 Wed Jan 21 21:52:56 IST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ef70000 (usable)
 BIOS-e820: 000000000ef70000 - 000000000ef7b000 (ACPI data)
 BIOS-e820: 000000000ef7b000 - 000000000ef7d000 (ACPI NVS)
 BIOS-e820: 000000000ef80000 - 000000000f000000 (reserved)
 BIOS-e820: 000000001ef80000 - 000000001f000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
239MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 61296
zone(0): 4096 pages.
zone(1): 57200 pages.
zone(2): 0 pages.
IBM machine detected. Enabling interrupts during APM calls.
ACPI: RSDP (v002 IBM                                       ) @
0x000f6d90
ACPI: XSDT (v001 IBM    TP-1S    0x00001230  LTP 0x00000000) @
0x0ef74a3b
ACPI: FADT (v003 IBM    TP-1S    0x00001230 IBM  0x00000001) @
0x0ef74b00
ACPI: SSDT (v001 IBM    TP-1S    0x00001230 MSFT 0x0100000e) @
0x0ef74cb4
ACPI: ECDT (v001 IBM    TP-1S    0x00001230 IBM  0x00000001) @
0x0ef7ae89
ACPI: BOOT (v001 IBM    TP-1S    0x00001230  LTP 0x00000001) @
0x0ef7afd8
ACPI: DSDT (v001 IBM    TP-1S    0x00001230 MSFT 0x0100000e) @
0x00000000
Kernel command line: root=/dev/hda5 vga=773
Initializing CPU#0
Detected 2193.084 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 4377.80 BogoMIPS
Memory: 239996k/245184k available (1284k kernel code, 4800k reserved,
551k data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Celeron(R) CPU 2.20GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031203
PCI: PCI BIOS revision 2.10 entry at 0xfd84c, last bus=4
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:...............................................................
.......................................................................
.......................................................................
..................
Table [DSDT](id F005) - 782 Objects with 44 Devices 223 Methods 10
Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c02f3adc
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 63 [_GPE] 8 regs at
0000000000008028 on int 9
schedule_task(): keventd has not started
ACPI: Found ECDT
Completing Region/Field/Buffer/Package
initialization:........................................................
.......................................................................
.............................................
Initialized 10/10 Regions 80/80 Fields 49/49 Buffers 33/33 Packages (791
nodes)
Executing all Device _STA and_INI
methods:..............................................
46 Devices found containing: 46 _STA, 6 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 2)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
 pci_irq-0305 [30] acpi_pci_irq_derive   : Unable to derive IRQ for
device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
vesafb: framebuffer at 0xf8000000, mapped to 0xcf810000, size 1536k
vesafb: mode is 1024x768x8, linelength=1024, pages=20
vesafb: protected mode interface info at c000:4f59
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller at PCI slot 00:0f.0
 pci_irq-0305 [31] acpi_pci_irq_derive   : Unable to derive IRQ for
device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHS2020AT E, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
blk: queue c03099a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 33000053 sectors (16896 MB) w/2048KiB Cache, CHS=2182/240/63,
UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 96k freed
Adding Swap: 385552k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension
(NICE) ver. 7.1.9 (11/03/03)
eth0: Broadcom BCM5901 100Base-TX found at mem e8000000, IRQ 11, node
addr 00061bda8eba
eth0: Broadcom BCM5705 Integrated Copper transceiver found
eth0: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON,
802.1Q VLAN ON, NAPI ON
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version
0.14.10h, 22:13:26 Jan 21 2004
trident: ALi Audio Accelerator found at IO 0x8800, IRQ 11
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Real Time Clock Driver v1.10e
bcm5700: eth0 NIC Link is UP, 100 Mbps full duplex


-- 
Praveen. C
http://www.cpraveen.tk


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
