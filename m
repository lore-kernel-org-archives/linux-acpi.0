From: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Subject: Portege 7010CT CPU speed
Date: Mon, 11 Apr 2005 22:59:16 -0500
Message-ID: <20050412035916.GB7304@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


Hello,

My friend has a Portege 7010CT that seems to have two ACPI-related
problems.  This is under 2.4.27 with ACPI enabled as well as 2.6.11.  I
posted the DSDT on the sourceforge site.  ACPI gives some method errors
when starting up but seems to otherwise "work".

The first issue is minor.  In ACPI mode, Cardbus cards don't work unless
pci=noacpi is given.  It seems no IRQ is received by the kernel from the
Cardbus controller in this case.  After giving pci=noacpi, I notice no
problems otherwise with PCI or IRQ routing.

The second is a huge problem.  The CPU is a PII-300MHz, but after
booting Linux, the machine is suddenly only running at 150MHz as shown
by bogomips compared to the bogomips of a normal PII-300.  Rebooting
into Windows preserves the speed.  I was able to use WCPUID to query the
speeds.  It shows that the FSB is only running at 33MHz instead of 66MHz
producing a 150MHz CPU clock.  Powering off completely and powering on
then booting straight to WinXP has the correct 300MHz speed.

Does anyone have even half a clue what would be going on here?  It's
sort of embarassing having to explain to him that it's likely not
"Linux" fault but rather the fault of a broken BIOS or DSDT.  How can I
figure out what the real problem is?  It is not APIC related because the
APIC is not being enabled.  I have attached various logs.

Also, the sound system is PnP in Windows but for some reason isapnp
doesn't pick it up.  I guess this is because it is only announced by
PnPBIOS support, which presumably PnP-ACPI should be utilizing, right?
Am I correct in presuming that hotplug should automatically load the
sound system module if PnP-ACPI is correctly working?  This isn't a big
deal because the sound does work, it's just having to manually configure
the resources is a pain in the ass (and neither any OSS mixer nor the
ALSA driver works on this particular hardware...)

I posted to the linux-toshiba list but nobody replied with any useful
information.  I tried using toshset to set the CPU speed to 'fast', but
it didn't seem to have any effect on benchmarks, and after rebooting
into Windows the system is still at 150MHz.

This is a decent laptop but Linux sucks on it at the moment; I'm hoping
to figure out what's going on not only to improve the state of Linux but
also because it might end up being a hand-me-down in the future ;)

Thanks,

-- 
Ryan Underwood, <nemesis-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 151.923
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 295.93


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=dma

 0: MS Sound System
 1: MS Sound System
 4: cascade

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=dmesg_with_acpi
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.10-1-686 (dilinger@mouth) (gcc version 3.3.5 (Debian 1:3.=
3.5-8)) #1 Fri Mar 11 03:55:46 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 00000000000ec000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000009ff0000 (usable)
 BIOS-e820: 0000000009ff0000 - 000000000a000000 (ACPI data)
 BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
 BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
 BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
159MB LOWMEM available.
On node 0 totalpages: 40944
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 36848 pages, LIFO batch:8
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f1140
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x09ff0000
ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x09ff0054
ACPI: DSDT (v001 TOSHIB 7000CT   0x19991112 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xfe08
Built 1 zonelists
Kernel command line: root=3D/dev/hda2 ro acpi=3Dforce pci=3Dnoacpi lapic=20
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
mapped APIC to ffffd000 (01142000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 154.058 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 154244k/163776k available (1682k kernel code, 8968k reserved, 703k =
data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 295.93 BogoMIPS (lpj=3D147968)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 0000=
0000 00000000
CPU: After vendor identify, caps: 0183f9ff 00000000 00000000 00000000 00000=
000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00=
000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (bad gzip magic numbers); looks l=
ike an initrd
Freeing initrd memory: 4676k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1957, last bus=3D21
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
    ACPI-0169: *** Error: No object was returned from [\_SB_.LNKA._STA] (No=
de c9feeee0), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.LNKB._STA] (No=
de c9feede0), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.LNKC._STA] (No=
de c9feece0), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.LNKD._STA] (No=
de c9b48800), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_=
=2E_STA] (Node c9b436e0), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.COM_=
=2E_STA] (Node c9b435a0), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_=
=2E_STA] (Node c9b43420), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1=
=2E_STA] (Node c9b43340), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0=
=2E_STA] (Node c9b43240), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.SND_=
=2E_STA] (Node c9b43ee0), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.ATA_=
=2E_STA] (Node c9b43d80), AE_NOT_EXIST
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.FNC0.MDM_=
=2E_STA] (Node c9b43ca0), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: Power Resource [PIHD] (on)
ACPI: Power Resource [PMHD] (on)
ACPI: Power Resource [PDOC] (off)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
    ACPI-0169: *** Error: No object was returned from [\_SB_.MEM_._CRS] (No=
de c9b48700), AE_NOT_EXIST
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
PCI: setting IRQ 13 as level-triggered
pnp: PnP ACPI: found 9 devices
PnPBIOS: Disabled by ACPI
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:05.0
PCI: IRQ 0 for device 0000:00:0b.0 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: IRQ 0 for device 0000:00:0b.1 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 11 for device 0000:00:0b.1
PCI: Cannot allocate resource region 4 of device 0000:00:05.1
    ACPI-0169: *** Error: No object was returned from [\_SB_.MEM_._CRS] (No=
de c9b48700), AE_NOT_EXIST
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:=20
 USB VIY0 VIY1  LAN LAN2  LID=20
ACPI: (supports S0 S1 S3 S4 S4bios S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4676KiB [1 disk] into ram disk... |=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
vesafb: probe of vesafb0 failed with error -6
NET: Registered protocol family 1
SCSI subsystem initialized
libata version 1.10 loaded.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:05.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4025GAS, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=3D65535/16/63, UDMA(33)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
Probing IDE interface ide1...
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
Adding 489940k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: No ISAPnP cards found, trying standard ones...
opl3sa2: Chipset version =3D 0x5
opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)
Capability LSM initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:00:0b.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 0000:00:0b.0
Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
Yenta: ISA IRQ mask 0x0490, PCI irq 11
Socket status: 30000007
PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
PCI: Found IRQ 11 for device 0000:00:0b.1
Yenta: CardBus bridge found at 0000:00:0b.1 [1179:0001]
Yenta: ISA IRQ mask 0x0490, PCI irq 11
Socket status: 30000007
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 11 for device 0000:00:06.0
PCI: Sharing IRQ 11 with 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:00:09.0
e100: eth0: e100_probe: addr 0xdefff000, irq 11, MAC addr 00:00:39:03:0C:0F
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:05.2
PCI: Sharing IRQ 11 with 0000:00:0d.0
uhci_hcd 0000:00:05.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:05.2: irq 11, io base 0xffe0
uhci_hcd 0000:00:05.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
piix4_smbus 0000:00:05.3: Found 0000:00:05.3 device
irda_init()
NET: Registered protocol family 23
PCI: Found IRQ 11 for device 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:00:06.0
IrDA: Registered device irda0
toshoboe: Using multiple tasks, version $Id: donauboe.c V2.18 ven jan 10 03=
:14:16 2003$
irlap_change_speed(), setting speed to 9600
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
Real Time Clock Driver v1.12
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Thermal Zone [THRM] (50 C)
NET: Registered protocol family 17
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x2f8-0x2ff 0x378-0x=
37f 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c032abe0(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device c8c28800(sit0)
eth0: no IPv6 routers present
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.12.14 (AR5210, AR5211, AR5212)
wlan: 0.8.4.5 (EXPERIMENTAL)
ath_rate_onoe: 1.0
ath_pci: 0.9.4.12 (EXPERIMENTAL)
PCI: Enabling device 0000:05:00.0 (0000 -> 0002)
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbp=
s 36Mbps 48Mbps 54Mbps
ath0: turbo rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
ath0: 802.11 address: 00:40:05:5d:63:2f
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 1 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Atheros 5212: mem=3D0x11000000, irq=3D11
ath0: no IPv6 routers present
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1279 buckets, 10232 max) - 336 bytes per conntrack

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=dmesg_without_acpi
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.10-1-686 (dilinger@mouth) (gcc version 3.3.5 (Debian 1:3.=
3.5-8)) #1 Fri Mar 11 03:55:46 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 00000000000ec000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000009ff0000 (usable)
 BIOS-e820: 0000000009ff0000 - 000000000a000000 (ACPI data)
 BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
 BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
 BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
159MB LOWMEM available.
On node 0 totalpages: 40944
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 36848 pages, LIFO batch:8
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Built 1 zonelists
Kernel command line: root=3D/dev/hda2 ro noacpi acpi=3Doff pci=3Dnoacpi=20
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01142000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 151.923 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 154244k/163776k available (1682k kernel code, 8968k reserved, 703k =
data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 295.93 BogoMIPS (lpj=3D147968)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 0000=
0000 00000000
CPU: After vendor identify, caps: 0183f9ff 00000000 00000000 00000000 00000=
000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00=
000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (bad gzip magic numbers); looks l=
ike an initrd
Freeing initrd memory: 4676k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1957, last bus=3D21
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: ACPI disable
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fed00
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x92c6, dseg 0x0
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:05.0
PCI: IRQ 0 for device 0000:00:0b.0 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: IRQ 0 for device 0000:00:0b.1 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 11 for device 0000:00:0b.1
PCI: Cannot allocate resource region 4 of device 0000:00:05.1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4676KiB [1 disk] into ram disk... |=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
vesafb: probe of vesafb0 failed with error -6
NET: Registered protocol family 1
SCSI subsystem initialized
libata version 1.10 loaded.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
spurious 8259A interrupt: IRQ7.
PIIX4: IDE controller at PCI slot 0000:00:05.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4025GAS, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=3D65535/16/63, UDMA(33)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
Adding 489940k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: No ISAPnP cards found, trying standard ones...
opl3sa2: Chipset version =3D 0x5
opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)
Capability LSM initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 0000:00:0b.0
Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
Yenta: ISA IRQ mask 0x0490, PCI irq 11
Socket status: 30000007
PCI: Found IRQ 11 for device 0000:00:0b.1
Yenta: CardBus bridge found at 0000:00:0b.1 [1179:0001]
Yenta: ISA IRQ mask 0x0490, PCI irq 11
Socket status: 30000020
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:05.2
PCI: Sharing IRQ 11 with 0000:00:0d.0
uhci_hcd 0000:00:05.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:05.2: irq 11, io base 0xffe0
uhci_hcd 0000:00:05.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.12.14 (AR5210, AR5211, AR5212)
wlan: 0.8.4.5 (EXPERIMENTAL)
ath_rate_onoe: 1.0
ath_pci: 0.9.4.12 (EXPERIMENTAL)
PCI: Enabling device 0000:05:00.0 (0000 -> 0002)
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbp=
s 36Mbps 48Mbps 54Mbps
ath0: turbo rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
ath0: 802.11 address: 00:40:05:5d:63:2f
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 1 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Atheros 5212: mem=3D0x11000000, irq=3D11
NET: Registered protocol family 17
piix4_smbus 0000:00:05.3: Found 0000:00:05.3 device
irda_init()
NET: Registered protocol family 23
PCI: Found IRQ 11 for device 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:04.0
IrDA: Registered device irda0
toshoboe: Using multiple tasks, version $Id: donauboe.c V2.18 ven jan 10 03=
:14:16 2003$
irlap_change_speed(), setting speed to 9600
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
Real Time Clock Driver v1.12
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
inserting floppy driver for 2.6.10-1-686
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EC=
P,DMA]
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x2f8-0x=
2ff 0x370-0x37f 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c032abe0(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device c8c15400(sit0)
ath0: no IPv6 routers present

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=interrupts

           CPU0       
  0:    1365856          XT-PIC  timer
  1:       3675          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          1          XT-PIC  MS Sound System
  8:          1          XT-PIC  rtc
  9:        435          XT-PIC  acpi
 11:     255445          XT-PIC  yenta, yenta, eth0, uhci_hcd, irda0, ath0
 12:      14400          XT-PIC  i8042
 14:      20081          XT-PIC  ide0
 15:         26          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=ioports

0000-001f : dma1
0020-0021 : pic1
0022-0022 : PM2_CNT_BLK
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0330-0331 : mpu401
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0530-0533 : WSS config
0534-0537 : MS Sound System
0538-0539 : opl3sa2
0cf8-0cff : PCI conf1
1000-100f : 0000:00:05.1
  1000-1007 : ide0
  1008-100f : ide1
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
4800-48ff : PCI CardBus #05
4c00-4cff : PCI CardBus #05
ee00-eeff : 0000:00:0d.0
fe00-fe3f : 0000:00:05.3
  fe00-fe3f : motherboard
    fe00-fe03 : PM1a_EVT_BLK
    fe04-fe05 : PM1a_CNT_BLK
    fe08-fe0b : PM_TMR
    fe0c-fe0f : GPE0_BLK
fe40-fe41 : motherboard
fe50-fe55 : motherboard
  fe50-fe55 : ACPI CPU throttle
fe60-fe7f : 0000:00:05.3
  fe70-fe7f : motherboard
    fe70-fe77 : piix4-smbus
fe90-fe97 : motherboard
fe9e-fe9e : motherboard
feac-feac : motherboard
ff60-ff7f : 0000:00:09.0
  ff60-ff7e : toshoboe
ff80-ff9f : 0000:00:06.0
  ff80-ff9f : e100
ffe0-ffff : 0000:00:05.2
  ffe0-ffff : uhci_hcd

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=lsmod

Module                  Size  Used by
ipv6                  265888  8 
pcmcia                 22660  4 
parport_pc             37828  0 
parport                37768  1 parport_pc
floppy                 60912  0 
tsdev                   7648  0 
mousedev               11576  0 
rtc                    12664  0 
psmouse                21960  0 
evdev                   9504  0 
pcspkr                  3464  0 
donauboe               16768  0 
irda                  197696  1 donauboe
crc_ccitt               1920  2 donauboe,irda
i2c_piix4               8592  0 
i2c_core               22736  1 i2c_piix4
af_packet              22472  2 
wlan_wep                6752  1 
ath_pci                62944  0 
ath_rate_onoe           8936  1 ath_pci
wlan                  121244  4 wlan_wep,ath_pci,ath_rate_onoe
ath_hal               133360  2 ath_pci
uhci_hcd               33968  0 
usbcore               122520  2 uhci_hcd
yenta_socket           22016  1 
pcmcia_core            60144  2 pcmcia,yenta_socket
capability              4616  0 
commoncap               7776  1 capability
opl3sa2                12480  0 
ad1848                 33756  1 opl3sa2
mpu401                 28836  1 opl3sa2
sound                  82860  3 opl3sa2,ad1848,mpu401
soundcore              10176  1 sound
ide_cd                 42724  0 
cdrom                  41436  1 ide_cd
ext3                  140968  1 
jbd                    62104  1 ext3
mbcache                 8580  1 ext3
ide_generic             1152  0 [permanent]
via82cxxx              13788  0 [permanent]
trm290                  4196  0 [permanent]
triflex                 3680  0 [permanent]
slc90e66                5856  0 [permanent]
sis5513                16392  0 [permanent]
siimage                12512  0 [permanent]
serverworks             9160  0 [permanent]
sc1200                  7264  0 [permanent]
rz1000                  2432  0 [permanent]
piix                   10116  0 [permanent]
pdc202xx_old           11200  0 [permanent]
opti621                 4580  0 [permanent]
ns87415                 4200  0 [permanent]
hpt366                 20128  0 [permanent]
ide_disk               21024  4 hpt366
hpt34x                  5152  0 [permanent]
generic                 3904  0 [permanent]
cy82c693                4612  0 [permanent]
cs5530                  5344  0 [permanent]
cs5520                  4576  0 [permanent]
cmd64x                 11964  0 [permanent]
atiixp                  5968  0 [permanent]
amd74xx                14172  0 [permanent]
alim15x3               12076  0 [permanent]
aec62xx                 7264  0 [permanent]
pdc202xx_new            8928  0 [permanent]
ide_core              133036  28 ide_cd,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti621,ns87415,hpt366,ide_disk,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim15x3,aec62xx,pdc202xx_new
sd_mod                 18096  0 
ata_piix                9092  0 
libata                 47012  1 ata_piix
scsi_mod              130016  2 sd_mod,libata
unix                   28820  30 
fbcon                  38560  0 
font                    8128  1 fbcon
bitblit                 5600  1 fbcon
vesafb                  7704  0 
cfbcopyarea             3936  1 vesafb
cfbimgblt               2880  1 vesafb
cfbfillrect             3584  1 vesafb

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=lspci

0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 02)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]

0000:00:04.0 VGA compatible controller: Neomagic Corporation NM2200 [MagicGraph 256AV] (rev 12) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at df000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at ff800000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at ff700000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1000 [size=16]

0000:00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ffe0 [size=32]

0000:00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

0000:00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
	Subsystem: Toshiba America Info Systems PCI FastEther LAN on Docker
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at defff000 (32-bit, prefetchable) [size=4K]
	Region 1: I/O ports at ff80 [size=32]
	Region 2: Memory at ff600000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at ff500000 [disabled] [size=1M]
	Capabilities: (snip)

0000:00:09.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ff80 [size=32]

0000:00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:00:0d.0 Multimedia controller: C-Cube Microsystems Cinemaster C 3.0 DVD Decoder (rev 02)
	Subsystem: C-Cube Microsystems Cinemaster C 3.0 DVD Decoder
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ee00 [size=256]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:05:00.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
	Subsystem: D-Link System Inc: Unknown device 3a07
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168 (2500ns min, 7000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 11000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


--Dxnq1zWXvFF0Q93v--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
