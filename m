From: Erik van Pienbroek <admin-0LxUhLuGNoZIf6P1QZMOBw@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: 11 Feb 2003 17:10:41 -0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1044987042.1149.4.camel@localhost.localdomain>
References: <026401c2cf88$9b26d330$0a0110ac@erik>
	<20030208185903.GA539@elf.ucw.cz> <02bc01c2d030$ac23f340$0a0110ac@erik>
	<20030209114731.GD26151@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-uoXLQUQ7+Jtw77JJYJ2p"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030209114731.GD26151-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Mailinglist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-uoXLQUQ7+Jtw77JJYJ2p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've experimented a little bit more with ACPI and found out the
following things :
With kernel 2.4.21-pre4 when I tried to echo "5" to /proc/acpi/sleep
the console would be killed an the following Oops appeared in the logs :

Feb 11 16:14:43 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Feb 11 16:14:43 localhost kernel:  printing eip:
Feb 11 16:14:43 localhost kernel: c01137bb
Feb 11 16:14:43 localhost kernel: *pde = 00000000
Feb 11 16:14:43 localhost kernel: Oops: 0002
Feb 11 16:14:43 localhost kernel: CPU:    0
Feb 11 16:14:43 localhost kernel: EIP:    0010:[<c01137bb>]    Not
tainted
Feb 11 16:14:43 localhost kernel: EFLAGS: 00010002
Feb 11 16:14:43 localhost kernel: eax: 00000000   ebx: 00000001   ecx:
c0311648   edx: 00000000
Feb 11 16:14:43 localhost kernel: esi: 00000005   edi: 00000000   ebp:
da991f60   esp: da991f14
Feb 11 16:14:43 localhost kernel: ds: 0018   es: 0018   ss: 0018
Feb 11 16:14:43 localhost kernel: Process bash (pid: 1158,
stackpage=da991000)
Feb 11 16:14:43 localhost kernel: Stack: c01e1a97 00000003 00000000
00000001 c01e1cc4 00000005 00000002 00000002
Feb 11 16:14:43 localhost kernel:        da991f50 c158b880 c01e27db
00000005 00000000 00000000 00000068 02000000
Feb 11 16:14:43 localhost kernel:        c02de040 c02ddf25 da9a6380
00000a35 00000000 00000000 da9a6380 00000000
Feb 11 16:14:43 localhost kernel: Call Trace:    [<c01e1a97>]
[<c01e1cc4>] [<c01e27db>] [<c0162430>] [<c0141ea3>]
Feb 11 16:14:43 localhost kernel:   [<c010749f>]
Feb 11 16:14:43 localhost kernel:
Feb 11 16:14:43 localhost kernel: Code: 89 02 0f 20 d8 0f 22 d8 31 d2 a1
e4 5c 37 c0 e9 c1 82 02 00

Attached with this mail is my dmesg (taken from kernel 2.4.21-pre4).

Under kernel 2.5.59-bk2 :
First I set the /proc/acpi/debuglevel to 0xffffffff and when I tried
to echo "5" to /proc/acpi/sleep the system would hang.
The last thing that appeared in the logs is this :
Feb 11 16:07:35 localhost kernel: **** Context Switch from TID 351A to
TID 351C ****
Feb 11 16:07:35 localhost kernel:
Feb 11 16:07:35 localhost kernel:    sleep-0315 [351C] [16]
acpi_system_sleep_seq_: ----Entry

I tried getting swsusp to work (I've applied the s4bios patch).
This works under 2.4.21-pre4 (however, if I start up the X server
after resuming the keyboard and mouse fail to respond).
Under 2.5.59-bk2 I get the error that /proc/sys/kernel/swsusp could
not be found (and yes, I've enabled the software suspend option during
make xconfig).
Is this known or am I doing something wrong here ?

I'm also trying to debug the /drivers/acpi/sleep.c from the kernel
source and hoping to find out what goes wrong.
If I find out more info about this behaviour I will report it to this
list.

Greetings,

Erik van Pienbroek

Op zo 09-02-2003, om 10:47 schreef Pavel Machek:
> Hi!
> 
> > The DSDT table of my laptop can be found at www.zapped.2y.net/dsdt.dsl
> > I hope it's of use to any of you.
> 
> I'm not good at reading DSDT's.
> 
> > If you need more information about my notebook configuration, please ask.
> > Oh yeah, I performed the echo's on /proc/acpi/sleep with the 2.5.59-bk2
> > kernel.
> > And can anyone explain to me what the /proc/acpi/alarm file is meant
> > for ?
> 
> You need sleep working, then care about alarm. (It may well be
> broken...)
> 								Pavel
> -- 
> Casualities in World Trade Center: ~3k dead inside the building,
> cryptography in U.S.A. and free speech in Czech Republic.
> 


--=-uoXLQUQ7+Jtw77JJYJ2p
Content-Disposition: attachment; filename=dmesg.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg.txt; charset=UTF-8

Linux version 2.4.21-pre4 (root-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org) (gcc versie 3.2 2002=
0903 (Red Hat Linux 8.0 3.2-7)) #3 di feb 11 15:58:02 GMT+1 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 130944
zone(0): 4096 pages.
zone(1): 126848 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 TOSCPL                     ) @ 0x000f6db0
ACPI: RSDT (v001 TOSCPL   RSDT   01540.00000) @ 0x1fefacc1
ACPI: FADT (v001 TOSCPL BR20     01540.00000) @ 0x1fefef64
ACPI: BOOT (v001 TOSCPL $SBFTBL$ 01540.00000) @ 0x1fefefd8
ACPI: DSDT (v001 COMPAL BR20     01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: ro root=3D/dev/hda2 hdc=3Dide-scsi acpi_sleep=3Ds3_bio=
s
ide_setup: hdc=3Dide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 2491.994 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4967.62 BogoMIPS
Memory: 514928k/523776k available (1763k kernel code, 8396k reserved, 601k =
data, 104k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.50GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030122
PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=3D2
PCI: Using configuration type 1
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control Methods:...............................................=
...........................................................................=
.........................
Table [DSDT] - 509 Objects with 47 Devices 147 Methods 19 Regions
ACPI Namespace successfully loaded at root c03859fc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successf=
ul
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:.................................=
..............
47 Devices found containing: 47 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.....................=
.........................................
Initialized 15/19 Regions 0/0 Fields 33/33 Buffers 14/14 Packages (509 node=
s)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 (swsusp) S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.SLOT._PRT]
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] (IRQs *5)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKH] (IRQs 5, enabled at IRQ 11)
ACPI: Embedded Controller [EC0] (gpe 28)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
Real Time Clock Driver v1.10e
i810_rng: RNG not detected
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel i845 @ 0xec000000 64MB
[drm] Initialized i810 1.2.0 20010920 on minor 1
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
blk: queue c039fda0, I/O limit 4095Mb (mask 0xffffffff)
hdc: DW-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area =3D> 1
hda: 58605120 sectors (30006 MB) w/1768KiB Cache, CHS=3D3648/255/63, UDMA(1=
00)
Partition check:
 hda: hda1 hda2 hda3
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: DW-224E           Rev: F.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Linux video capture interface: v1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 522104k swap-space (priority -1)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller, 00:02:3F:B3:34:D2=
, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Intel 810 + AC97 Audio, version 0.24, 16:01:59 Feb 11 2003
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0x1880 and 0x1c00, MEM 0x0000 and 0x0000, IRQ =
11
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: CRY52 (Cirrus Logic CS4299 rev D)
i810_audio: AC'97 codec 0 supports AMAP, total channels =3D 2

--=-uoXLQUQ7+Jtw77JJYJ2p--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
