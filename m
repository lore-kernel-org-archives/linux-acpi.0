From: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Subject: Re: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Mon, 2 Dec 2002 22:00:09 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212022200.14480.chris@chrishowells.co.uk>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B956@orsmsx107.jf.intel.com> <200212022050.26628.chris@chrishowells.co.uk> <20021202215309.J27991@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pf969W/7snXOJca"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021202215309.J27991-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_pf969W/7snXOJca
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Monday 02 December 2002 21:53, Matthew Wilcox wrote:
> can you reproduce the problem without the tainting vmware modules loaded?

Yes, all problems can be re-produced in run level 3 (e.g. without vmware and 
NVidia modules).

lsmod shows:

Module                  Size  Used by    Not tainted
serial_cs               4384   0  (unused)
i810_audio             20256   0  (autoclean)
soundcore               3492   2  (autoclean) [i810_audio]
ac97_codec              9856   0  (autoclean) [i810_audio]
ipt_TOS                 1088   5  (autoclean)
ipt_state                608   4  (autoclean)
ipt_REJECT              2848   7  (autoclean)
ipt_LOG                 3168  15  (autoclean)
ipt_limit                960  17  (autoclean)
ipt_MASQUERADE          1216   2  (autoclean)
printer                 6720   0
iptable_mangle          2208   1  (autoclean)
iptable_nat            13908   1  (autoclean) [ipt_MASQUERADE]
ip_conntrack           16652   2  (autoclean) [ipt_state ipt_MASQUERADE 
iptable_nat]
iptable_filter          1728   1  (autoclean)
ip_tables              10624  11  [ipt_TOS ipt_state ipt_REJECT ipt_LOG 
ipt_limit ipt_MASQUERADE iptable_mangle iptable_nat iptable_filter]
irda-usb               10016   0  (unused)
irda                   78284   0  [irda-usb]
mousedev                3808   0  (unused)
3c59x                  25000   1  (autoclean)
hid                    17952   0  (unused)
input                   3264   0  [mousedev hid]
usb-uhci               21220   0  (unused)
usbcore                55008   1  [printer irda-usb hid usb-uhci]
rtc                     5756   0  (autoclean)


Proper dmesg attached.

- -- 
Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE969fuF8Iu1zN5WiwRAgfTAJwMre6Xlvd5fkHlrgYLRuZlr/5d/QCeOd81
geZXb1kTlnaqkFs36o7JE1Q=
=9R97
-----END PGP SIGNATURE-----

--Boundary-00=_pf969W/7snXOJca
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.4.20acpidebug (root@gandalf) (gcc version 2.95.4 20011002 (=
Debian prerelease)) #3 Mon Dec 2 01:22:02 GMT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ef0000 (usable)
 BIOS-e820: 0000000007ef0000 - 0000000007eff000 (ACPI data)
 BIOS-e820: 0000000007eff000 - 0000000007f00000 (ACPI NVS)
 BIOS-e820: 0000000007f00000 - 0000000007f80000 (usable)
 BIOS-e820: 0000000007f80000 - 0000000008000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 32640
zone(0): 4096 pages.
zone(1): 28544 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 DELL                       ) @ 0x000f6740
ACPI: RSDT (v001 DELL     RSDT   01540.00000) @ 0x07efadcf
ACPI: FADT (v001 INTEL  845M     01540.00000) @ 0x07efef8c
ACPI: DSDT (v001 DELL   845M     01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Kernel command line: BOOT_IMAGE=3DLinux ro root=3D306 hdc=3Dide-scsi 3
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 1894.452 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3774.87 BogoMIPS
Memory: 126464k/130560k available (1311k kernel code, 3644k reserved, 580k =
data, 96k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.90GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021122
PCI: PCI BIOS revision 2.10 entry at 0xfd9c5, last bus=3D2
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:...........................................................=
=2E........................................................................=
=2E.............
Table [DSDT] - 530 Objects with 51 Devices 146 Methods 16 Regions
ACPI Namespace successfully loaded at root c0302dfc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successf=
ul
 evevent-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
 evevent-0511: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:.................................=
=2E.................
51 Devices found containing: 51 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:.....................=
=2E..........................
Initialized 13/16 Regions 0/0 Fields 20/20 Buffers 15/15 Packages (530 node=
s)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28)
schedule_task(): keventd has not started
pci_bind-0194 [09] acpi_pci_bind         : Device 00:00:1d.02 not present i=
n PCI namespace
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting kswapd
Journalled Block Device driver loaded
 exfldio-0122 [30] Ex_setup_region       : Field [ACPW] Base+Offset+Width 3=
8+0+4 is beyond end of region [GPIO] (length 3B)
 psparse-1103: *** Error: Method execution failed, AE_AML_REGION_LIMIT
Method pathname:  \_SB_.PCI0.LPCB.ACAD._PSR (Node c7e94728)
 acpi_ac-0083 [14] acpi_ac_get_state     : Error reading AC Adapter state
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 performance states, 8 throttling =
states)
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH3M: BIOS setup was incomplete.
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
hdc: HL-DT-STCD-RW/DVD-ROM GCC-4240N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c031ab44, I/O limit 4095Mb (mask 0xffffffff)
[ACPI Debug] String: =3D=3D=3D=3D=3DQUERY_05=3D=3D=3D=3D=3D
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=3D2432/255/63, UDMA(1=
00)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: RW/DVD GCC-4240N  Rev: D110
  Type:   CD-ROM                             ANSI SCSI revision: 02
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000411
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 96k freed
Adding Swap: 248968k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
Real Time Clock Driver v1.10e
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 01:19:39 Dec  2 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:1d.1-1, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:1d.1-1.1, assigned address 3
usb.c: USB device 3 (vend/prod 0x46d/0xc001) is not claimed by any active d=
river.
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb2:3.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:01.0: 3Com PCI 3c905C Tornado at 0x3000. Vers LK1.1.16
hub.c: new USB device 00:1d.1-1.2, assigned address 4
mice: PS/2 mouse device common for all mice
usb.c: USB device 4 (vend/prod 0x50f/0x180) is not claimed by any active dr=
iver.
usb.c: registered new driver irda-usb
IRDA-USB found at address 4, Vendor: 50f, Product: 180
IrDA: Registered device irda0
USB IrDA support registered
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1020 buckets, 8160 max) - 292 bytes per conntrack
hub.c: new USB device 00:1d.1-1.4, assigned address 5
usb.c: USB device 5 (vend/prod 0x3f0/0x1904) is not claimed by any active d=
river.
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 5 if 0 alt 0 proto 2 vid 0=
x03F0 pid 0x1904
printer.c: v0.11: USB Printer Device Class driver
Intel 810 + AC97 Audio, version 0.21, 01:19:33 Dec  2 2002
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH3 found at IO 0x1880 and 0x1c00, IRQ 10
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: =83=84v0(SigmaTel STAC????)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not presen=
t), total channels =3D 2
ac97_codec: AC97 Modem codec, id: CXT33(Unknown)
i810_audio: timed out waiting for codec 1 analog ready.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ttyS01 at port 0x02f8 (irq =3D 3) is a 16550A
[ACPI Debug] String: =3D=3D=3D=3D=3DQUERY_08=3D=3D=3D=3D=3D
[ACPI Debug] String: =3D=3D=3D=3D=3DQUERY_08=3D=3D=3D=3D=3D
[ACPI Debug] String: =3D=3D=3D=3D=3DQUERY_08=3D=3D=3D=3D=3D
 exstore-0278 [59] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [48] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [48] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [37] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [38] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [27] acpi_battery_get_info : Error evaluating _BIF
[ACPI Debug] String: =3D=3D=3D=3D=3DQUERY_08=3D=3D=3D=3D=3D
 exstore-0278 [63] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [52] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [52] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [41] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [41] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [30] acpi_battery_get_info : Error evaluating _BIF
[ACPI Debug] String: =3D=3D=3D=3D=3DQUERY_08=3D=3D=3D=3D=3D
 exstore-0278 [67] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [56] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [56] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [45] acpi_battery_get_info : Error evaluating _BIF
 exstore-0278 [45] Ex_store_object_to_ind: Could not store object to indexe=
d package element
 psparse-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
Method pathname:  \_SB_.PCI0.LPCB.BAT1._BIF (Node c7e91728)
acpi_battery-0134 [34] acpi_battery_get_info : Error evaluating _BIF

--Boundary-00=_pf969W/7snXOJca--



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
