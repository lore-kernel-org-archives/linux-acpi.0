From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: notebook going to S3, but rebooting instead of waking up
Date: Thu, 29 May 2003 16:11:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305291611.16265.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EUh1+wy/znje0Sb"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--Boundary-00=_EUh1+wy/znje0Sb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

this notebook can be made to sleep (tested on 2.5.65 and 2.5.69)
but doesn't wake up unless I press the power button which makes
it reboot.

	Regards
		Oliver

Dmesg is:

Linux version 2.4.21-pre6 (oliver@oenone) (gcc version 3.3 20030226 (prerelease) (SuSE Linux)) #3 Mon Mai 26 20:59:28 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d8000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000fa930
ACPI: RSDT (v001 AMIINT VIA_K7   00000.00016) @ 0x1fff0000
ACPI: FADT (v001 AMIINT VIA_K7   00000.00017) @ 0x1fff0030
ACPI: DSDT (v001    VIA   VIA_K7 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: root=/dev/hda2 vga=0x317 hdc=ide-scsi hdclun=0 splash=silent splash=silent
ide_setup: hdc=ide-scsi
ide_setup: hdclun=0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1661.985 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3316.12 BogoMIPS
Memory: 515280k/524224k available (1509k kernel code, 8556k reserved, 504k data, 132k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD mobile AMD Athlon(tm) XP 2000+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1661.8314 MHz.
..... host bus clock speed is 265.8929 MHz.
cpu: 0, clocks: 2658929, slice: 1329464
CPU0<T0:2658928,T1:1329456,D:8,S:1329464,C:2658929>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030522
PCI: PCI BIOS revision 2.10 entry at 0xfda81, last bus=1
PCI: Using configuration type 1
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.SBRG.EC0_] in namespace, AE_NOT_FOUND
search_node dffe9540 start_node dffe9540 return_node 00000000
    ACPI-1121: *** Error: , AE_NOT_FOUND
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.SBRG.EC0_] in namespace, AE_NOT_FOUND
search_node dffe9740 start_node dffe9740 return_node 00000000
    ACPI-1121: *** Error: , AE_NOT_FOUND
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Embedded Controller [EC0] (gpe 5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
PCI: Probing PCI hardware
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
vesafb: framebuffer at 0xd0000000, mapped to 0xe0816000, size 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:5653
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHT2030AT, ATA DISK drive
blk: queue c0348ec0, I/O limit 4095Mb (mask 0xffffffff)
hdc: Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 460k freed
VFS: Mounted root (ext2 filesystem).
reiserfs: checking transaction log (device 03:02) ...
Warning, log replay starting on readonly filesystem
spurious 8259A interrupt: IRQ7.
reiserfs: replayed 11 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 132k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Adding Swap: 1036152k swap-space (priority 42)
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SAMSUNG   Model: CDRW/DVD SN-324B  Rev: U102
  Type:   CD-ROM                             ANSI SCSI revision: 02
via-rhine.c:v1.10-LK1.1.16  February-15-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xd400, 00:a0:cc:de:d6:85, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 0021.
ohci1394: $Rev: 810 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[dffff800-dfffffff]  Max Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Host added: Node[00:1023]  GUID[00030d432511c75d]  [Linux OHCI-1394]
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
raw1394: /dev/raw1394 device initialized
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.3: irq 10, pci mem e49d4700
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.3 PCI cache line size corrected to 64.
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 22:38:18 May 26 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
uhci.c: USB Universal Host Controller Interface driver v1.1
mice: PS/2 mouse device common for all mice
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0098, PCI irq11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: excluding 0x820-0x87f
cs: IO port probe 0x0800-0x080f: excluding 0x800-0x80f
cs: IO port probe 0x03e0-0x04ff: excluding 0x400-0x40f 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: excluding 0x1c0-0x1cf 0x378-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
ACPI: AC Adapter [AC0] (on-line)
ACPI: Processor [CPU1] (supports C1 C2, 16 throttling states)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Thermal Zone [THRM] (75 C)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
[drm:radeon_unlock] *ERROR* Process 1385 using kernel context 0
Linux video capture interface: v1.00
eth0: no IPv6 routers present

--Boundary-00=_EUh1+wy/znje0Sb
Content-Type: application/x-bzip2;
  name="dsdt.dsl.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dsdt.dsl.bz2"

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

--Boundary-00=_EUh1+wy/znje0Sb--



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
