From: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Subject: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Sun, 1 Dec 2002 00:19:54 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211302353.17620.chris@chrishowells.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qWV69HbL9Daa3zr"
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


--Boundary-00=_qWV69HbL9Daa3zr
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I've just compiled 2.4.20 + the 2002112 patch for 2.4.20rc3 + the cpufreq for
rc3 on my Dell Inspiron 2650 (Mobile P4 1.9GHz. A few weeks work and a few
things don't :)

* I can successfully sleep and wakeup from S1, even while in X, which is 
wonderful. (great to see it working, thanks to everybody who's contributed!). 
However, the screen does not seem to be turned off, only much darker -- I can 
still see the screen albeit darkly when the system is supposedly asleep.

Also, entering S1 means that the system clock seems to stop. For example, if I 
watch the clock on KDE's Kicker, and enter S1, then the system will show the 
same time when it wakes up as when it entered sleep.

Also, the processor fan continues to run even when in S1. The fan stops while 
in standby mode in XP, IIRC, which is what I expect -- the processor is 
halted (I think) so it should cool down, so there's no need t

* dmesg reveals a few errors, whether the are important or not I do not know:

Journalled Block Device driver loaded
    ACPI-1103: *** Error: Method execution failed, AE_AML_REGION_LIMIT

And after having cat'ed a few things in /proc/acpi, the following appears at
the end of the dmesg:

    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT

I'm current using NVidia's propreitary kernel modules, I'd be happy to re-test
with this module not loaded if that is likely to make any difference.

* Reading battery information partially works:

chris@gandalf:/proc/acpi/battery/BAT1$ cat *
alarm:                   unsupported
present:                 yes
ERROR: Unable to read battery information
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      3676 mAh
present voltage:         16700 mV

However, the battery is not recognised after removing and reinserting it.

chris@gandalf:/proc/acpi/battery/BAT1$ cat *
present:                 no
present:                 no
present:                 no

* The /proc/acpi/ac_adapter and fan (and possibly other) directories are
empty.


* Slightly OT for here, but controlling the processor speed using cpufreq and
/proc/cpufreq seems to work perfectly, with /proc/cpuinfo reporting that the
speed varies between 1.2 and 1.9, depending whether I ask for performance or
max battery. Whether it actually will increase battery life needs more
investigation :)

I remember there being a acpi->cpufreq patch -- has that been accepted into
the main acpi patch yet? Does the patch only switch between the maximum and
minimum speeds, or other speeds in between, as the SpeeedStep driver for XP
does?

A full dmesg is attached.

- --
Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, pp0u20d9@liv.ac.uk, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.org





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE96VWwF8Iu1zN5WiwRAjdNAJ9v1vNEF3AzVVDVhwYBWSLAx9hT0gCcDdHk
hZloPvz+jCS4z9qJbRN883w=
=rppD
-----END PGP SIGNATURE-----

--Boundary-00=_qWV69HbL9Daa3zr
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.4.20acpi (root@gandalf) (gcc version 2.95.4 20011002 (Debia=
n prerelease)) #2 Sat Nov 30 23:20:07 GMT 2002
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
Kernel command line: BOOT_IMAGE=3DLinux ro root=3D306 hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 1894.436 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3774.87 BogoMIPS
Memory: 126616k/130560k available (1216k kernel code, 3492k reserved, 523k =
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
    ACPI-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0511: *** Info: GPE Block1 defined as GPE16 to GPE31
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
    ACPI-1103: *** Error: Method execution failed, AE_AML_REGION_LIMIT
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
blk: queue c02f4a84, I/O limit 4095Mb (mask 0xffffffff)
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
usb-uhci.c: $Revision: 1.275 $ time 23:23:28 Nov 30 2002
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
hub.c: new USB device 00:1d.1-1.2, assigned address 4
usb.c: USB device 4 (vend/prod 0x50f/0x180) is not claimed by any active dr=
iver.
mice: PS/2 mouse device common for all mice
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:01.0: 3Com PCI 3c905C Tornado at 0x3000. Vers LK1.1.16
usb.c: registered new driver irda-usb
IRDA-USB found at address 4, Vendor: 50f, Product: 180
IrDA: Registered device irda0
USB IrDA support registered
hub.c: new USB device 00:1d.1-1.4, assigned address 5
ip_tables: (C) 2000-2002 Netfilter core team
usb.c: USB device 5 (vend/prod 0x3f0/0x1904) is not claimed by any active d=
river.
ip_conntrack version 2.1 (1020 buckets, 8160 max) - 292 bytes per conntrack
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 5 if 0 alt 0 proto 2 vid 0=
x03F0 pid 0x1904
printer.c: v0.11: USB Printer Device Class driver
Intel 810 + AC97 Audio, version 0.21, 23:23:14 Nov 30 2002
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
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:4=
2 PDT 2002
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT
    ACPI-1103: *** Error: Method execution failed, AE_BAD_HEX_CONSTANT

--Boundary-00=_qWV69HbL9Daa3zr--



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
