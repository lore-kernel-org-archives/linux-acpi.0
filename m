From: "PSI-Systems" <psi-systems-hi6Y0CQ0nG0@public.gmane.org>
Subject: evxfevnt-0118 [06] Acpi_disable -- does this mean my IBM will never work with ACPI under Linux?
Date: Wed, 27 Nov 2002 23:10:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <003d01c29661$c760f710$0201a8c0@csn.tuchemnitz.de>
References: <20021127130541.19aeeaca.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003A_01C2966A.27CEF6D0"
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

This is a multi-part message in MIME format.

------=_NextPart_000_003A_01C2966A.27CEF6D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

ACPI: Found ECDT
ACPI: Could not use ECDT
  evxfevnt-0118 [06] Acpi_disable : Transition to LEGACY mode successful

for me it looks like the new ACPI code can read the ACPI tables from RAM,
but there is still the problem with the wrong path to the EC in the EC_ID
field.
is this a bug in the code in acquiring/using the new ACPI tables or doesn't
affect this EC problem?

Regards

------=_NextPart_000_003A_01C2966A.27CEF6D0
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.4.20-rc3 (root@a31) (gcc version 3.2.1) #3 Wed Nov 27 =
21:00:39 CET 2002=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)=0A=
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)=0A=
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)=0A=
 BIOS-e820: 000000001ff60000 - 000000001ff7a000 (ACPI data)=0A=
 BIOS-e820: 000000001ff7a000 - 000000001ff7c000 (ACPI NVS)=0A=
 BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)=0A=
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)=0A=
511MB LOWMEM available.=0A=
ACPI: have wakeup address 0xc0001000=0A=
On node 0 totalpages: 130912=0A=
zone(0): 4096 pages.=0A=
zone(1): 126816 pages.=0A=
zone(2): 0 pages.=0A=
ACPI: RSDP (v002 IBM                        ) @ 0x000f7060=0A=
ACPI: XSDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ee48=0A=
ACPI: FADT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ee8c=0A=
ACPI: SSDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ef40=0A=
ACPI: ECDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff79f87=0A=
ACPI: BOOT (v001 IBM    TP-1G    00000.04160) @ 0x1ff79fd8=0A=
ACPI: DSDT (v001 IBM    TP-1G    00000.04160) @ 0x00000000=0A=
ACPI: BIOS passes blacklist=0A=
ACPI: MADT not present=0A=
IBM machine detected. Enabling interrupts during APM calls.=0A=
Kernel command line: BOOT_IMAGE=3DLinux ro root=3D305 root=3D/dev/hda8 =
resume=3D/dev/hda7 devfs=3Donly video=3Dradeonfb:1400x1050-32@60 =
hdc=3Dide-scsi=0A=
ide_setup: hdc=3Dide-scsi=0A=
No local APIC present or hardware disabled=0A=
Initializing CPU#0=0A=
Detected 1199.011 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 2392.06 BogoMIPS=0A=
Memory: 514612k/523648k available (1893k kernel code, 8648k reserved, =
613k data, 160k init, 0k highmem)=0A=
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)=0A=
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)=0A=
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)=0A=
CPU: L1 I cache: 0K, L1 D cache: 8K=0A=
CPU: L2 cache: 512K=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#0.=0A=
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000=0A=
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000=0A=
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)=0A=
mtrr: detected mtrr type: Intel=0A=
ACPI: Subsystem revision 20021122=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=3D8=0A=
PCI: Using configuration type 1=0A=
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully =
acquired=0A=
Parsing =
Methods:.................................................................=
.........................................................................=
.........................................................................=
.........................................................................=
.........................................................................=
....................................=0A=
Table [DSDT] - 1276 Objects with 64 Devices 393 Methods 18 Regions=0A=
Parsing Methods:=0A=
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions=0A=
ACPI Namespace successfully loaded at root c03b87bc=0A=
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode =
successful=0A=
 evevent-0511: *** Info: GPE Block0 defined as GPE0 to GPE15=0A=
 evevent-0511: *** Info: GPE Block1 defined as GPE16 to GPE31=0A=
ACPI: Found ECDT=0A=
ACPI: Could not use ECDT=0A=
evxfevnt-0118 [06] Acpi_disable          : Transition to LEGACY mode =
successful=0A=
 utalloc-0972 [05] Ut_dump_allocations   : No outstanding allocations.=0A=
PCI: Probing PCI hardware=0A=
PCI: ACPI tables contain no PCI IRQ routing entries=0A=
PCI: Probing PCI hardware (bus 00)=0A=
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge=0A=
PCI: Discovered primary peer bus 09 [IRQ]=0A=
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0=0A=
PCI: Found IRQ 11 for device 00:1f.1=0A=
PCI: Sharing IRQ 11 with 00:1d.2=0A=
PCI: Sharing IRQ 11 with 02:02.0=0A=
isapnp: Scanning for PnP cards...=0A=
isapnp: No Plug & Play device found=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
Starting kswapd=0A=
VFS: Diskquotas version dquot_6.4.0 initialized=0A=
Journalled Block Device driver loaded=0A=
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)=0A=
devfs: boot_options: 0x3=0A=
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).=0A=
NTFS driver v1.1.22 [Flags: R/O]=0A=
PCI: Found IRQ 11 for device 01:00.0=0A=
PCI: Sharing IRQ 11 with 00:1d.0=0A=
PCI: Sharing IRQ 11 with 02:00.0=0A=
radeonfb: ref_clk=3D2700, ref_div=3D12, xclk=3D16600 from BIOS=0A=
radeonfb: panel ID string: Samsung LTN150P1-L02    =0A=
radeonfb: detected DFP panel size from BIOS: 1400x1050=0A=
Console: switching to colour frame buffer device 175x65=0A=
radeonfb: ATI Radeon M7 LW  DDR SGRAM 32 MB=0A=
radeonfb: DVI port LCD monitor connected=0A=
radeonfb: CRT port no monitor connected=0A=
pty: 256 Unix98 ptys configured=0A=
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT =
SHARE_IRQ SERIAL_PCI ISAPNP enabled=0A=
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A=0A=
PCI: Found IRQ 5 for device 00:1f.6=0A=
PCI: Sharing IRQ 5 with 00:1f.3=0A=
PCI: Sharing IRQ 5 with 00:1f.5=0A=
PCI: Sharing IRQ 5 with 02:00.1=0A=
Non-volatile memory driver v1.2=0A=
Uniform Multi-Platform E-IDE driver Revision: 6.31=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
ICH3M: IDE controller on PCI bus 00 dev f9=0A=
PCI: Enabling device 00:1f.1 (0005 -> 0007)=0A=
PCI: Found IRQ 11 for device 00:1f.1=0A=
PCI: Sharing IRQ 11 with 00:1d.2=0A=
PCI: Sharing IRQ 11 with 02:02.0=0A=
ICH3M: chipset revision 2=0A=
ICH3M: not 100% native mode: will probe irqs later=0A=
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio=0A=
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio=0A=
hda: IC25N040ATCS04-0, ATA DISK drive=0A=
hdc: UJDA720 DVD/CDRW, ATAPI CD/DVD-ROM drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
blk: queue c03d29c4, I/O limit 4095Mb (mask 0xffffffff)=0A=
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=3D5168/240/63, =
UDMA(100)=0A=
Partition check:=0A=
 /dev/ide/host0/bus0/target0/lun0:<7>ldm_validate_partition_table(): =
Found an MS-DOS partition table, not a dynamic disk.=0A=
 p1 p2 < p5 p6 p7 p8 > p3=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a National Semiconductor PC87306=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
LVM version 1.0.5+(22/07/2002)=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
IP: routing cache hash table of 4096 buckets, 32Kbytes=0A=
TCP: Hash tables configured (established 32768 bind 65536)=0A=
Linux IP multicast router 0.06 plus PIM-SM=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
VFS: Mounted root (ext3 filesystem) readonly.=0A=
Mounted devfs on /dev=0A=
Freeing unused kernel memory: 160k freed=0A=
Adding Swap: 1330520k swap-space (priority -1)=0A=
EXT3 FS 2.4-0.9.19, 19 August 2002 on unknown-block(3,8), internal =
journal=0A=
Real Time Clock Driver v1.10e=0A=
irda_init()=0A=
IrCOMM protocol (Dag Brattli)=0A=
i2c-core.o: i2c core module=0A=
i2c-proc.o version 2.6.1 (20010825)=0A=
Intel 810 + AC97 Audio, version 0.21, 20:34:17 Nov 27 2002=0A=
PCI: Found IRQ 5 for device 00:1f.5=0A=
PCI: Sharing IRQ 5 with 00:1f.3=0A=
PCI: Sharing IRQ 5 with 00:1f.6=0A=
PCI: Sharing IRQ 5 with 02:00.1=0A=
PCI: Setting latency timer of device 00:1f.5 to 64=0A=
i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, IRQ 5=0A=
i810_audio: Audio Controller supports 6 channels.=0A=
ac97_codec: AC97 Audio codec, id: ADS72(Analog Devices AD1881A)=0A=
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not =
present), total channels =3D 2=0A=
ac97_codec: AC97 Modem codec, id: SIL39(Unknown)=0A=
i810_audio: timed out waiting for codec 1 analog ready.=0A=
SCSI subsystem driver Revision: 1.00=0A=
scsi0 : SCSI host adapter emulation for IDE ATAPI devices=0A=
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.03=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.03=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.03=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.03=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.03=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.03=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
  Vendor: MATSHITA  Model: UJDA720 DVD/CDRW  Rev: 1.03=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
usb.c: registered new driver usbdevfs=0A=
usb.c: registered new driver hub=0A=
usb.c: registered new driver usblp=0A=
printer.c: v0.11: USB Printer Device Class driver=0A=
udf: registering filesystem=0A=
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>=0A=
GRE over IPv4 tunneling driver=0A=
ip_tables: (C) 2000-2002 Netfilter core team=0A=
pci_hotplug: PCI Hot Plug PCI Core version: 0.5=0A=
  utmisc-0694 [01] Ut_acquire_mutex      : Thread 83 could not acquire =
Mutex [ACPI_MTX_Namespace] AE_BAD_PARAMETER=0A=
acpiphp_glue: acpiphp_glue_init: acpi_walk_namespace() failed=0A=
CSLIP: code copyright 1989 Regents of the University of California=0A=
PPP generic driver version 2.4.2=0A=
i810_rng hardware driver 0.9.8 loaded=0A=
i810 TCO timer, v0.05: timer margin: 30 sec (0x1060) (nowayout=3D1)=0A=
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)=0A=
lp: driver loaded but no devices found=0A=
usb-uhci.c: $Revision: 1.275 $ time 20:35:18 Nov 27 2002=0A=
usb-uhci.c: High bandwidth mode enabled=0A=
PCI: Found IRQ 11 for device 00:1d.0=0A=
PCI: Sharing IRQ 11 with 01:00.0=0A=
PCI: Sharing IRQ 11 with 02:00.0=0A=
PCI: Setting latency timer of device 00:1d.0 to 64=0A=
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 11=0A=
usb-uhci.c: Detected 2 ports=0A=
usb.c: new USB bus registered, assigned bus number 1=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
PCI: Found IRQ 11 for device 00:1d.1=0A=
PCI: Setting latency timer of device 00:1d.1 to 64=0A=
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 11=0A=
usb-uhci.c: Detected 2 ports=0A=
usb.c: new USB bus registered, assigned bus number 2=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
PCI: Found IRQ 11 for device 00:1d.2=0A=
PCI: Sharing IRQ 11 with 00:1f.1=0A=
PCI: Sharing IRQ 11 with 02:02.0=0A=
PCI: Setting latency timer of device 00:1d.2 to 64=0A=
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 11=0A=
usb-uhci.c: Detected 2 ports=0A=
usb.c: new USB bus registered, assigned bus number 3=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver=0A=
mice: PS/2 mouse device common for all mice=0A=
usb.c: registered new driver usb_mouse=0A=
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver=0A=
hub.c: new USB device 00:1d.1-1, assigned address 2=0A=
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 =
vid 0x03F0 pid 0x1504=0A=
hub.c: new USB device 00:1d.1-2, assigned address 3=0A=
input0: Logitech USB Receiver on usb2:3.0=0A=
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 292 bytes per =
conntrack=0A=
usb.c: registered new driver hiddev=0A=
usb.c: registered new driver hid=0A=
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>=0A=
hid-core.c: USB HID support drivers=0A=
irqtune/0.6: setting system IRQ priority to 3/14=0A=
irqtune/0.6: module cleanup=0A=
microcode: CPU0 no microcode found! (sig=3Df24, pflags=3D8)=0A=
ide-floppy driver 0.99.newide=0A=

------=_NextPart_000_003A_01C2966A.27CEF6D0--



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
