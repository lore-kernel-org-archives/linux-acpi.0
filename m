From: Morgan Read <mstuff-tXhYEH5G0dc@public.gmane.org>
Subject: acpi & cpu cooling
Date: Sat, 15 Jan 2005 22:53:26 +1300
Message-ID: <41E8E816.2050003@pl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
I've lurked on this list for a while & my questions seem a little
elementary, but it seems this is the best place to ask?

My objective is to quieten my laptop (donated to me) so I can sit it in=20
lectures with out embarrassment or complaint from my fellow students...

I've de-dusted the heat-sink & re set it.  But, it still spends most of=20
the time with the fan at full speed.

Computer: Clevo 2200T dating from 2001
BIOS: is fully updated to 2002 (when updates stopped)
The ACPI version is reported at boot as: "ACPI BIOS version 1.00.12"
The manual says it - "Supports ACPI 1.0B compliant"
I'm running FC2 with kernel 2.6.6-1.435.2.3
CPU: P3 at 1.2Ghz

I've used acpi=3Dforce (otherwise it doesn't load due to the bios being=20
1996 vintage - only the copyright I understand).

The fan appears to have three states: off; slow; full.

The contents of /proc/acpi include:
/ac_adapter/AC
/battery/BAT0
/button/power & /sleep
/embedded_controller/EC0
/power_resource/PUT1
/processor/CPU0

and with nothing in them:
/thermal_zone
/fan
(and /asus of course)

Obviously there's some thermal monitoring as there's some control over
the fan.

The power switch seems to shutdown elegantly with acpi on (and not if off=
).

Running "echo 3 > /proc/acpi/sleep" as root appears to send it to
sleep, but it immediately resume.  A common fault?  Any fix?

If I can throttle down the cpu it'll cool off and the fan will
drop down to slow??? - My strategy.

Any ideas about what I should try/use to achieve my ends from amongst
the plethora of bits & pieces would be very much appreciated.

Copied below is the output from dmesg after boot.

Thanks very much.
Regards,
Morgan.

--=20
Morgan Read
<mailto:mstuffATplDOTnet>

###############################
[morgan@morgansmachine morgan]$ dmesg
Linux version 2.6.6-1.435.2.3 (bhcompile-FkyZWkai+dgaZRsM4JBhTKfLeoKvNuZc@public.gmane.org) (gcc
version 3 .3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Thu Jul 1 08:25:29
EDT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
  BIOS-e820: 000000000dff0000 - 000000000dffffc0 (ACPI data)
  BIOS-e820: 000000000dffffc0 - 000000000e000000 (ACPI NVS)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
223MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 57328
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 53232 pages, LIFO batch:12
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e4010
ACPI: RSDT (v001 OID_00 RSDT_000 0x30303030 =EF=BF=BD& 0x00010000) @ 0x0d=
fffbd0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 =EF=BF=BD& 0x00010000) @ 0x0d=
fffb20
ACPI: BOOT (v001 INSYDE ISC_BOOT 0x00000100 =EF=BF=BD& 0x00010000) @ 0x0d=
fffba0
ACPI: DSDT (v001 SiS630 INSYDESW 0x00001001 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/ rhgb quiet selinux=3D0 acpi=3Dfo=
rce
mapped 4G/4G trampoline to ffff3000.
Initializing CPU#0
CPU 0 irqstacks, hard=3D02346000 soft=3D02345000
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1196.363 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 223968k/229312k available (1552k kernel code, 4664k reserved,
603k data,  144k init, 0k highmem)
Calibrating delay loop... 2367.48 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 0000000=
0
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f1ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III CPU             1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 189k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xeb2f0, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
     ACPI-0165: *** Error: No object was returned from
[\_SB_.PCI0.LPC_.LPT_._STA ] (Node 0ff02d08), AE_NOT_EXIST
     ACPI-0165: *** Error: No object was returned from
[\_SB_.PCI0.LPC_.COM1._STA ] (Node 0ff02a08), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS18 that hid as a SIS503 (compatible=3D0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 8)
ACPI: Power Resource [PUT1] (on)
ACPI: Power Resource [PUT1] (on)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs *5 10 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 *11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: No IRQ known for interrupt pin A of device 0000:00:00.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
vesafb: probe of vesafb0 failed with error -6
Simple Boot Flag at 0x37 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1105714777.672:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 630 chipset
agpgart: Maximum main memory to use for agp memory: 176M
agpgart: AGP aperture is 64M @ 0x40000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SIS5513: IDE controller at PCI slot 0000:00:00.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:00.1
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS630 ATA 100 (1st gen) controller
     ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI CD-RW/DVD-ROM SBW-081, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=3D38760/16/63, UDMA=
(100)
  hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S4bios S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 144k freed
NET: Registered protocol family 10
Disabled Privacy Extensions on device 022deac0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
[drm] Initialized sis 1.1.0 20030826 on minor 0:
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:01.2: OHCI Host Controller
ohci_hcd 0000:00:01.2: irq 11, pci mem 1088f000
ohci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:01.3: OHCI Host Controller
ohci_hcd 0000:00:01.3: irq 11, pci mem 10891000
ohci_hcd 0000:00:01.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
EXT3 FS on hda2, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
cdrom: open failed.
Adding 514072k swap on /dev/hda4.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.13 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
microcode: CPU0 already at revision 0x1c (current=3D0x1c)
microcode: No new microdata for cpu 0
parport0: PC-style at 0x378 [PCSPP,EPP]
SCSI subsystem initialized
inserting floppy driver for 2.6.6-1.435.2.3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ohci1394: $Rev: 1203 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[5]
MMIO=3D[44004000-440047ff]  Max Packet=3D[2048]
sis900.c: v1.08.07 11/02/2003
divert: allocating divert_blk for eth0
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x3200, IRQ 10, 00:90:f5:13:d2:5f.
divert: freeing divert_blk for eth0
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:0a.0 [1558:2202]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x01d71c77, devctl 0x66
Yenta: ISA IRQ mask 0x0098, PCI irq 11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x480-0x48f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
ip_tables: (C) 2000-2002 Netfilter core team
parport0: PC-style at 0x378 [PCSPP,EPP]
lp0: using parport0 (polling).
lp0: console ready
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
[morgan@morgansmachine morgan]$






-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
