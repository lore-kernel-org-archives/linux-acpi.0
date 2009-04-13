From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: FAN Processor and Thermap
Date: Mon, 13 Apr 2009 09:37:24 +0800
Message-ID: <1239586644.5564.17.camel@localhost.localdomain>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
	 <49DFE506.8040307@gmail.com>
	 <335b7d740904120419x548018caqd7f41c5b24639bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1951 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbZDMBgJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2009 21:36:09 -0400
In-Reply-To: <335b7d740904120419x548018caqd7f41c5b24639bec@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Perl <kenperl@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2009-04-12 at 19:19 +0800, Ken Perl wrote:
> I entered the bios but don't find a option to enable/disable ACPI. th=
e
> dmesg output is below,

>From the dmesg log it seems that there exists the following warning
message:
   >=EF=BB=BFACPI Error (tbxfroot-0218): A valid RSDP was not found [20=
080321]
   It indicates that no ACPI table is found on this box. In such case
the ACPI can't be initialized correctly. Of course the
=46AN/Processor/Thermal driver can't be loaded correctly.
   So IMO this is a BIOS bug rather than ACPI bug.

   Will you please try the previous kernel(for example: 2.6.23 ) and
attach the output of dmesg?

   Thanks.
>=20
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 2.6.26-1-686 (Debian 2.6.26-13lenny2)
> (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian
> 4.1.2-25)) #1 SMP Fri Mar 13 18:08:45 UTC 2009
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usabl=
e)
> [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reser=
ved)
> [    0.000000]  BIOS-e820: 00000000000f0c00 - 0000000000100000 (reser=
ved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 0000000008000000 (usabl=
e)
> [    0.000000]  BIOS-e820: 00000000ffff0c00 - 0000000100000000 (reser=
ved)
> [    0.000000] 0MB HIGHMEM available.
> [    0.000000] 128MB LOWMEM available.
> [    0.000000] Entering add_active_range(0, 0, 32768) 0 entries of 25=
6 used
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA             0 ->     4096
> [    0.000000]   Normal       4096 ->    32768
> [    0.000000]   HighMem     32768 ->    32768
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0:        0 ->    32768
> [    0.000000] On node 0 totalpages: 32768
> [    0.000000]   DMA zone: 32 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 4064 pages, LIFO batch:0
> [    0.000000]   Normal zone: 224 pages used for memmap
> [    0.000000]   Normal zone: 28448 pages, LIFO batch:7
> [    0.000000]   HighMem zone: 0 pages used for memmap
> [    0.000000]   Movable zone: 0 pages used for memmap
> [    0.000000] DMI not present or invalid.
> [    0.000000] ACPI Error (tbxfroot-0218): A valid RSDP was not found=
 [20080321]
> [    0.000000] Allocating PCI resources starting at 10000000 (gap:
> 08000000:f7ff0c00)
> [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000=
000000a0000
> [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000=
000000f1000
> [    0.000000] PM: Registered nosave memory: 00000000000f1000 - 00000=
00000100000
> [    0.000000] SMP: Allowing 0 CPUs, 0 hotplug CPUs
> [    0.000000] PERCPU: Allocating 37960 bytes of per cpu data
> [    0.000000] NR_CPUS: 8, nr_cpu_ids: 1
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 32512
> [    0.000000] Kernel command line: root=3D/dev/hda1 ro quiet
> console=3DttyS0,115200n8
> [    0.000000] Local APIC disabled by BIOS -- you can enable it with =
"lapic"
> [    0.000000] mapped APIC to ffffb000 (0110c000)
> [    0.000000] Enabling fast FPU save and restore... done.
> [    0.000000] Initializing CPU#0
> [    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
> [    0.000000] Detected 267.283 MHz processor.
> [    0.004000] Console: colour VGA+ 80x25
> [    0.004000] console [ttyS0] enabled
> [    0.004000] Dentry cache hash table entries: 16384 (order: 4, 6553=
6 bytes)
> [    0.004000] Inode-cache hash table entries: 8192 (order: 3, 32768 =
bytes)
> [    0.004000] Memory: 120060k/131072k available (1769k kernel code,
> 10456k reserved, 752k data, 244k init, 0k highmem)
> [    0.004000] virtual kernel memory layout:
> [    0.004000]     fixmap  : 0xfff4c000 - 0xfffff000   ( 716 kB)
> [    0.004000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
> [    0.004000]     vmalloc : 0xc8800000 - 0xff7fe000   ( 879 MB)
> [    0.004000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> [    0.004000]       .init : 0xc037f000 - 0xc03bc000   ( 244 kB)
> [    0.004000]       .data : 0xc02ba4d3 - 0xc0376620   ( 752 kB)
> [    0.004000]       .text : 0xc0100000 - 0xc02ba4d3   (1769 kB)
> [    0.004000] Checking if this processor honours the WP bit even in
> supervisor mode...Ok.
> [    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
> [    0.085108] Calibrating delay using timer specific routine.. 536.5=
9
> BogoMIPS (lpj=3D1073195)
> [    0.085466] Security Framework initialized
> [    0.085517] SELinux:  Disabled at boot.
> [    0.085550] Capability LSM initialized
> [    0.085708] Mount-cache hash table entries: 512
> [    0.087018] Initializing cgroup subsys ns
> [    0.087061] Initializing cgroup subsys cpuacct
> [    0.087085] Initializing cgroup subsys devices
> [    0.087292] CPU: L1 I cache: 16K, L1 D cache: 16K
> [    0.087337] Intel machine check architecture supported.
> [    0.087369] Intel machine check reporting enabled on CPU#0.
> [    0.087471] Checking 'hlt' instruction... OK.
> [    0.101247] SMP alternatives: switching to UP code
> [    0.133922] Freeing SMP alternatives: 16k freed
> [    0.133956] ACPI: Core revision 20080321
> [    0.134291] ACPI Exception (tbxface-0629): AE_NO_ACPI_TABLES, Whil=
e
> loading namespace from ACPI tables [20080321]
> [    0.134339] ACPI: Unable to load the System Description Tables
> [    0.140008] weird, boot CPU (#0) not listedby the BIOS.
> [    0.140008] SMP motherboard not detected.
> [    0.140008] Local APIC not detected. Using dummy APIC emulation.
> [    0.140008] SMP disabled
> [    0.140607] Brought up 1 CPUs
> [    0.140637] Total of 1 processors activated (536.59 BogoMIPS).
> [    0.140698] CPU0 attaching sched-domain:
> [    0.140720]  domain 0: span 0
> [    0.140739]   groups: 0
> [    0.143270] net_namespace: 660 bytes
> [    0.143314] Booting paravirtualized kernel on bare hardware
> [    0.145944] NET: Registered protocol family 16
> [    0.153024] PCI: PCI BIOS revision 2.10 entry at 0xfd9cc, last bus=
=3D1
> [    0.153057] PCI: Using configuration type 1 for base access
> [    0.153082] Setting up standard PCI resources
> [    0.168352] ACPI: Interpreter disabled.
> [    0.168386] Linux Plug and Play Support v0.97 (c) Adam Belay
> [    0.169043] pnp: PnP ACPI: disabled
> [    0.169077] PnPBIOS: Scanning system for PnP BIOS support...
> [    0.169243] PnPBIOS: Found PnP BIOS installation structure at 0xc0=
0f7b90
> [    0.169273] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa38b, d=
seg 0x400
> [    0.189159] PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by=
 driver
> [    0.195069] PCI: Probing PCI hardware
> [    0.195103] PCI: Probing PCI hardware (bus 00)
> [    0.196527] * Found PM-Timer Bug on the chipset. Due to workaround=
s
> for a bug,
> [    0.196547] * this clock source is slow. Consider trying other clo=
ck sources
> [    0.196674] pci 0000:00:07.3: quirk: region 8000-803f claimed by P=
IIX4 ACPI
> [    0.196705] pci 0000:00:07.3: quirk: region 2180-218f claimed by P=
IIX4 SMB
> [    0.204349] PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:=
07.0
> [    0.204473] PCI: setting IRQ 9 as level-triggered
> [    0.204499] PCI: Found IRQ 9 for device 0000:00:0f.0
> [    0.204565] PCI: Sharing IRQ 9 with 0000:00:14.0
> [    0.206313] system 00:00: iomem range 0xfff80000-0xffffffff could
> not be reserved
> [    0.206407] system 00:01: iomem range 0x0-0x9ffff could not be res=
erved
> [    0.206438] system 00:01: iomem range 0xe0000-0xfffff could not be=
 reserved
> [    0.206466] system 00:01: iomem range 0x100000-0x7ffffff could not
> be reserved
> [    0.206572] system 00:0a: ioport range 0x4d0-0x4d1 has been reserv=
ed
> [    0.206603] system 00:0a: ioport range 0x8000-0x803f has been rese=
rved
> [    0.206629] system 00:0a: ioport range 0x2180-0x218f has been rese=
rved
> [    0.214772] PCI: Bridge: 0000:00:01.0
> [    0.214802]   IO window: disabled.
> [    0.214825]   MEM window: disabled.
> [    0.214844]   PREFETCH window: disabled.
> [    0.215125] NET: Registered protocol family 2
> [    0.216435] IP route cache hash table entries: 1024 (order: 0, 409=
6 bytes)
> [    0.218451] TCP established hash table entries: 4096 (order: 3, 32=
768 bytes)
> [    0.218758] TCP bind hash table entries: 4096 (order: 3, 32768 byt=
es)
> [    0.219079] TCP: Hash tables configured (established 4096 bind 409=
6)
> [    0.219103] TCP reno registered
> [    0.220088] NET: Registered protocol family 1
> [    0.221113] checking if image is initramfs... it is
> [    5.337205] Freeing initrd memory: 6023k freed
> [    5.344636] audit: initializing netlink socket (disabled)
> [    5.344731] type=3D2000 audit(1239528267.344:1): initialized
> [    5.345896] Total HugeTLB memory allocated, 0
> [    5.346815] VFS: Disk quotas dquot_6.5.1
> [    5.347114] Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)
> [    5.347555] msgmni has been set to 246
> [    5.349105] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 253)
> [    5.349145] io scheduler noop registered
> [    5.349163] io scheduler anticipatory registered
> [    5.349181] io scheduler deadline registered
> [    5.349344] io scheduler cfq registered (default)
> [    5.349412] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    5.349538] pci 0000:00:14.0: Boot video device
> [    5.355215] isapnp: Scanning for PnP cards...
> [    5.465580]  01:01: card 'CRD4237B-5'
> [    5.465612] isapnp: 1 Plug & Play card detected total
> [    5.517472] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
> IRQ sharing enabled
> [    5.518390] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> [    5.524339] 00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> [    5.552352] brd: module loaded
> [    5.553992] PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 ir=
q 1,12
> [    5.558114] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    5.558181] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    5.560886] mice: PS/2 mouse device common for all mice
> [    5.562978] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
> [    5.563073] rtc0: alarms up to one day
> [    5.563770] cpuidle: using governor ladder
> [    5.563801] cpuidle: using governor menu
> [    5.563860] No iBFT detected.
> [    5.567791] TCP cubic registered
> [    5.567829] NET: Registered protocol family 17
> [    5.567887] Using IPI No-Shortcut mode
> [    5.570094] registered taskstats version 1
> [    5.570719] rtc_cmos 00:05: setting system clock to 2009-04-12
> 09:24:28 UTC (1239528268)
> [    5.572525] Freeing unused kernel memory: 244k freed
> [    6.671691] thermal: Unknown symbol acpi_processor_set_thermal_lim=
it
> [   11.279535] FDC 0 is a post-1991 82077
> [   11.288680] usbcore: registered new interface driver usbfs
> [   11.288981] usbcore: registered new interface driver hub
> [   11.289542] usbcore: registered new device driver usb
> [   11.418063] SCSI subsystem initialized
> [   11.457426] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
> [   11.457577] 8139cp 0000:00:0f.0: This (id 10ec:8139 rev 10) is not
> an 8139C+ compatible chip
> [   11.466112] 8139cp 0000:00:0f.0: Try the "8139too" driver instead.
> [   11.502056] USB Universal Host Controller Interface driver v3.0
> [   11.502334] uhci_hcd 0000:00:07.2: enabling device (0000 -> 0001)
> [   11.502388] PCI: setting IRQ 10 as level-triggered
> [   11.502409] PCI: Assigned IRQ 10 for device 0000:00:07.2
> [   11.502514] uhci_hcd 0000:00:07.2: UHCI Host Controller
> [   11.503231] uhci_hcd 0000:00:07.2: new USB bus registered, assigne=
d
> bus number 1
> [   11.503355] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000fcc0
> [   11.504347] usb usb1: configuration #1 chosen from 1 choice
> [   11.504738] hub 1-0:1.0: USB hub found
> [   11.504850] hub 1-0:1.0: 2 ports detected
> [   11.574015] 8139too Fast Ethernet driver 0.9.28
> [   11.823971] usb usb1: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0001
> [   11.824009] usb usb1: New USB device strings: Mfr=3D3, Product=3D2=
,
> SerialNumber=3D1
> [   11.824033] usb usb1: Product: UHCI Host Controller
> [   11.824052] usb usb1: Manufacturer: Linux 2.6.26-1-686 uhci_hcd
> [   11.824071] usb usb1: SerialNumber: 0000:00:07.2
> [   11.824865] 8139too 0000:00:0f.0: enabling device (0000 -> 0003)
> [   11.824913] PCI: Found IRQ 9 for device 0000:00:0f.0
> [   11.824988] PCI: Sharing IRQ 9 with 0000:00:14.0
> [   11.827560] eth0: RealTek RTL8139 at 0xf800, 00:05:1c:15:b0:6e, IR=
Q 9
> [   11.827594] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
> [   11.850569] libata version 3.00 loaded.
> [   12.059682] Uniform Multi-Platform E-IDE driver
> [   12.059729] ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=3Dxx
> [   12.080991] PIIX4: IDE controller (0x8086:0x7111 rev 0x01) at  PCI
> slot 0000:00:07.1
> [   12.081072] PIIX4: not 100% native mode: will probe irqs later
> [   12.081123]     ide0: BM-DMA at 0xfcf0-0xfcf7
> [   12.081178]     ide1: BM-DMA at 0xfcf8-0xfcff
> [   12.081213] Probing IDE interface ide0...
> [   12.368571] hda: ST310211A, ATA DISK drive
> [   13.040659] hda: host max PIO4 wanted PIO255(auto-tune) selected P=
IO4
> [   13.040884] hda: UDMA/33 mode selected
> [   13.040985] Probing IDE interface ide1...
> [   13.776653] hdc: LEOPTICS CD-ROM 24X v2.2C, ATAPI CD/DVD-ROM drive
> [   14.112666] hdc: host max PIO4 wanted PIO255(auto-tune) selected P=
IO4
> [   14.112836] hdc: MWDMA2 mode selected
> [   14.113091] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [   14.113323] ide1 at 0x170-0x177,0x376 on irq 15
> [   14.448439] hda: max request size: 128KiB
> [   14.534166] hda: 19541088 sectors (10005 MB) w/1024KiB Cache, CHS=3D=
19386/16/63
> [   14.534210] hda: cache flushes not supported
> [   14.534526]  hda: hda1 hda2 < hda5 >
> [   14.594238] hdc: ATAPI 20X CD-ROM drive, 128kB Cache
> [   14.594288] Uniform CD-ROM driver Revision: 3.20
> [   15.136450] PM: Starting manual resume from disk
> [   15.394219] EXT3-fs: INFO: recovery required on readonly filesyste=
m.
> [   15.394256] EXT3-fs: write access will be enabled during recovery.
> [   16.694052] kjournald starting.  Commit interval 5 seconds
> [   16.694167] EXT3-fs: hda1: orphan cleanup on readonly fs
> [   16.694230] ext3_orphan_cleanup: deleting unreferenced inode 28672=
9
> [   16.694429] ext3_orphan_cleanup: deleting unreferenced inode 28672=
8
> [   16.694533] ext3_orphan_cleanup: deleting unreferenced inode 28672=
7
> [   16.694631] ext3_orphan_cleanup: deleting unreferenced inode 28672=
6
> [   16.694857] ext3_orphan_cleanup: deleting unreferenced inode 28672=
5
> [   16.694944] EXT3-fs: hda1: 5 orphan inodes deleted
> [   16.694968] EXT3-fs: recovery complete.
> [   16.735943] EXT3-fs: mounted filesystem with ordered data mode.
> [   17.859848] spurious 8259A interrupt: IRQ7.
> [   20.248151] udevd version 125 started
> [   26.125560] input: PC Speaker as /class/input/input0
> [   30.281356] Linux agpgart interface v0.103
> [   30.422789] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [   30.669684] shpchp: Standard Hot Plug PCI Controller Driver versio=
n: 0.4
> [   31.741028] agpgart: Detected an Intel 440LX Chipset.
> [   31.750189] agpgart: AGP aperture is 64M @ 0xf4000000
> [   32.839954] piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
> [   33.188787] Error: Driver 'pcspkr' is already registered, aborting=
=2E..
> [   33.425456] parport_pc 00:10: reported by Plug and Play BIOS
> [   33.425536] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP=
]
> [   34.034629] ns558 01:01.01: activated
> [   34.063541] gameport: NS558 PnP Gameport is pnp01:01.01/gameport0,
> io 0x200, speed 727kHz
> [   34.179454] cs4236_isapnp 01:01.00: activated
> [   34.182287] cs4236_isapnp 01:01.02: activated
> [   34.185549] cs4236_isapnp 01:01.03: activated
> [   38.965548] Adding 465844k swap on /dev/hda5.  Priority:-1
> extents:1 across:465844k
> [   39.618203] EXT3 FS on hda1, internal journal
> [   40.922052] loop: module loaded
> [   43.891563] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> [   48.185069] NET: Registered protocol family 10
> [   48.189408] lo: Disabled Privacy Extensions
> [   58.985185] eth0: no IPv6 routers present
>=20
>=20
> On Sat, Apr 11, 2009 at 8:32 AM, Robert Hancock <hancockrwd@gmail.com=
> wrote:
> > Ken Perl wrote:
> >>
> >> After I replaced my mainboard, then I can see errors related to AC=
PI
> >> during the Linux booting, I can also reproduce it with command bel=
ow,
> >>
> >> moproble fan processor thermap
> >>
> >> I got error "no such device",  I ever tried to append following li=
nes
> >> to the /etc/modprobe.d/blacklist but can not succeed, I can still =
see
> >> same error during boot, another error is "ACPI unable to load syst=
em
> >> description tables",
> >>
> >> blacklist fan
> >> blacklist processor
> >> blacklist thermap
> >>
> >> Do these a big problem? Can anyone tell how I can fix the issue?
> >>
> >
> > Can you post your dmesg output? Make sure that the motherboard does=
n't have
> > ACPI disabled in the BIOS or something (I don't think many even hav=
e that
> > option anymore, but who knows).
> >
>=20
>=20
>=20
> --
> perl -e 'print unpack(u,"62V5N\"FME;G\!E<FQ`9VUA:6PN8V]M\"\@``
> ")'
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
