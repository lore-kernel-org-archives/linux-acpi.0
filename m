From: Hilbert Barelds <list-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>
Subject: Hello every boddy, I have a compaq evo 800v any news about any
 dsdt (LONG)
Date: 12 Feb 2003 22:19:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045084756.2329.58.camel@calvin.hjblocal.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
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

Hello,

I am a verry happy owner of an evo 800v

Installed redhat 8.0
have a patched dsdt
running kernel 2.4.21 pre3 with latest patch

The following shows my problem, can anyone help my in a direction to
search or privide some links.

I know C and have embedded programming knowlede so I am not afraid, just
need some help in the right direction. It's of no use to reinvent the
wheel.

Please mail if you want the the patched dsdt, I find this big post,
don't want to make it longer.

The startup errors about device C03C bother me, also
Feb 12 19:00:43 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.00 not present in PCI namespace
Feb 12 19:00:43 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.01 not present in PCI namespace
Feb 12 19:00:43 suzie keytable: Loading system font:=20
Feb 12 19:00:44 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.02 not present in PCI namespace
Feb 12 19:00:44 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.07 not present in PCI namespace

Bothers me, but probably related to the first error
Also the debug statements at the bottom bother me.

Regards,

Hilbert Barelds

Again sorry for the long post



Feb 12 19:00:43 suzie syslogd 1.4.1: restart.
Feb 12 19:00:43 suzie syslog: syslogd startup succeeded
Feb 12 19:00:43 suzie syslog: klogd startup succeeded
Feb 12 19:00:43 suzie kernel: klogd 1.4.1, log source =3D /proc/kmsg
started.
Feb 12 19:00:43 suzie kernel: Linux version 2.4.21-pre3
(root-I6FTR8E0DhUM22dXXXuHVmZHpeb/A1Y/@public.gmane.org) (gcc version 3.2 20020903 (Red Hat Linux 8.0
3.2-7)) #3 Mon Feb 10 12:52:56 GMT+1 2003
Feb 12 19:00:43 suzie kernel: BIOS-provided physical RAM map:
Feb 12 19:00:43 suzie kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Feb 12 19:00:43 suzie kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Feb 12 19:00:43 suzie kernel:  BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)
Feb 12 19:00:43 suzie kernel:  BIOS-e820: 0000000000100000 -
000000001ffd0000 (usable)
Feb 12 19:00:43 suzie kernel:  BIOS-e820: 000000001ffd0000 -
000000001fff0c00 (reserved)
Feb 12 19:00:43 suzie kernel:  BIOS-e820: 000000001fff0c00 -
000000001fffc000 (ACPI NVS)
Feb 12 19:00:43 suzie kernel:  BIOS-e820: 000000001fffc000 -
0000000020000000 (reserved)
Feb 12 19:00:43 suzie kernel: 511MB LOWMEM available.
Feb 12 19:00:43 suzie kernel: On node 0 totalpages: 131024
Feb 12 19:00:43 suzie kernel: zone(0): 4096 pages.
Feb 12 19:00:43 suzie kernel: zone(1): 126928 pages.
Feb 12 19:00:43 suzie kernel: zone(2): 0 pages.
Feb 12 19:00:43 suzie kernel: ACPI: RSDP (v000
COMPAQ                     ) @ 0x000f9970
Feb 12 19:00:43 suzie kernel: ACPI: RSDT (v001 COMPAQ CPQ004A=20
12297.00544) @ 0x1fff0c84
Feb 12 19:00:43 suzie kernel: ACPI: FADT (v002 COMPAQ CPQ004A=20
00000.00002) @ 0x1fff0c00
Feb 12 19:00:43 suzie kernel: ACPI: SSDT (v001 COMPAQ  CPQGysr
00000.04097) @ 0x1fff6508
Feb 12 19:00:43 suzie kernel: ACPI: SSDT (v001 COMPAQ   CPQMag
00000.04097) @ 0x1fff6616
Feb 12 19:00:43 suzie kernel: ACPI: DSDT (v001 COMPAQ  EVON800
00001.00000) @ 0x00000000
Feb 12 19:00:43 suzie kernel: ACPI: BIOS passes blacklist
Feb 12 19:00:43 suzie kernel: ACPI: MADT not present
Feb 12 19:00:43 suzie kernel: Kernel command line: ro root=3D/dev/hda3
hdc=3Dide-scsi
Feb 12 19:00:43 suzie kernel: ide_setup: hdc=3Dide-scsi
Feb 12 19:00:43 suzie kernel: No local APIC present or hardware disabled
Feb 12 19:00:43 suzie kernel: Initializing CPU#0
Feb 12 19:00:43 suzie kernel: Detected 1196.148 MHz processor.
Feb 12 19:00:43 suzie kernel: Console: colour VGA+ 80x25
Feb 12 19:00:43 suzie kernel: Calibrating delay loop... 2385.51 BogoMIPS
Feb 12 19:00:43 suzie kernel: Memory: 514392k/524096k available (2446k
kernel code, 9316k reserved, 808k data, 148k init, 0k highmem)
Feb 12 19:00:43 suzie kernel: Dentry cache hash table entries: 65536
(order: 7, 524288 bytes)
Feb 12 19:00:43 suzie kernel: Inode cache hash table entries: 32768
(order: 6, 262144 bytes)
Feb 12 19:00:43 suzie kernel: Mount-cache hash table entries: 8192
(order: 4, 65536 bytes)
Feb 12 19:00:43 suzie portmap: portmap startup succeeded
Feb 12 19:00:43 suzie kernel: Buffer-cache hash table entries: 32768
(order: 5, 131072 bytes)
Feb 12 19:00:43 suzie kernel: Page-cache hash table entries: 131072
(order: 7, 524288 bytes)
Feb 12 19:00:43 suzie kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Feb 12 19:00:43 suzie kernel: CPU: L2 cache: 512K
Feb 12 19:00:43 suzie kernel: Intel machine check architecture
supported.
Feb 12 19:00:43 suzie kernel: Intel machine check reporting enabled on
CPU#0.
Feb 12 19:00:43 suzie kernel: CPU: Intel Mobile Intel(R) Pentium(R) 4 -
M CPU 1.70GHz stepping 07
Feb 12 19:00:43 suzie kernel: Enabling fast FPU save and restore...
done.
Feb 12 19:00:43 suzie kernel: Enabling unmasked SIMD FPU exception
support... done.
Feb 12 19:00:43 suzie kernel: Checking 'hlt' instruction... OK.
Feb 12 19:00:43 suzie kernel: POSIX conformance testing by UNIFIX
Feb 12 19:00:43 suzie kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
Feb 12 19:00:43 suzie kernel: mtrr: detected mtrr type: Intel
Feb 12 19:00:43 suzie kernel: ACPI: Subsystem revision 20030122
Feb 12 19:00:43 suzie kernel: PCI: PCI BIOS revision 2.10 entry at
0xf031f, last bus=3D3
Feb 12 19:00:43 suzie kernel: PCI: Using configuration type 1
Feb 12 19:00:43 suzie kernel:    tbget-0273: *** Info: Table [DSDT]
replaced by host OS
Feb 12 19:00:43 suzie kernel:  tbxface-0098 [03] acpi_load_tables      :
ACPI Tables successfully acquired
Feb 12 19:00:43 suzie kernel: Parsing all Control
Methods:...................................................................=
...........................................................................=
...........................................................................=
........................
Feb 12 19:00:43 suzie kernel: Table [DSDT] - 781 Objects with 88 Devices
241 Methods 24 Regions
Feb 12 19:00:43 suzie kernel: Parsing all Control Methods:
Feb 12 19:00:43 suzie kernel: Table [SSDT] - 0 Objects with 0 Devices 0
Methods 0 Regions
Feb 12 19:00:43 suzie kernel: Parsing all Control Methods:
Feb 12 19:00:43 suzie kernel: Table [SSDT] - 0 Objects with 0 Devices 0
Methods 0 Regions
Feb 12 19:00:43 suzie kernel: ACPI Namespace successfully loaded at root
c04662bc
Feb 12 19:00:43 suzie kernel: evxfevnt-0073 [04] acpi_enable           :
Transition to ACPI mode successful
Feb 12 19:00:43 suzie kernel:    evgpe-0262: *** Info: GPE Block0
defined as GPE0 to GPE15
Feb 12 19:00:43 suzie kernel:    evgpe-0262: *** Info: GPE Block1
defined as GPE16 to GPE31
Feb 12 19:00:43 suzie kernel: Executing all Device _STA and_INI
methods:...evrgnini-0242: *** Error: Could not install pci_config
handler for C03C, AE_ALREADY_EXISTS
Feb 12 19:00:43 suzie kernel: ....evrgnini-0242: *** Error: Could not
install pci_config handler for C03C, AE_ALREADY_EXISTS
Feb 12 19:00:43 suzie nfslock: rpc.statd startup succeeded
Feb 12 19:00:43 suzie kernel:
.............................................................evrgnini-0242:=
 *** Error: Could not install pci_config handler for C03C, AE_ALREADY_EXIST=
S
Feb 12 19:00:43 suzie kernel: ....................
Feb 12 19:00:43 suzie kernel: 88 Devices found containing: 88 _STA, 5
_INI methods
Feb 12 19:00:43 suzie kernel: Completing Region/Field/Buffer/Package
initialization:............................................................=
.................................
Feb 12 19:00:43 suzie kernel: Initialized 14/24 Regions 0/0 Fields 25/26
Buffers 54/63 Packages (797 nodes)
Feb 12 19:00:43 suzie kernel: ACPI: Interpreter enabled
Feb 12 19:00:43 suzie kernel: ACPI: Using PIC for interrupt routing
Feb 12 19:00:43 suzie kernel: ACPI: System [ACPI] (supports S0 S3 S4bios
S4 S5)
Feb 12 19:00:43 suzie kernel: ACPI: PCI Root Bridge [C03C] (00:00)
Feb 12 19:00:43 suzie kernel: PCI: Probing PCI hardware (bus 00)
Feb 12 19:00:43 suzie kernel: PCI: Ignoring BAR0-3 of IDE controller
00:1f.1
Feb 12 19:00:43 suzie kernel: Transparent bridge - Intel Corp.
82801BAM/CAM PCI Bridge
Feb 12 19:00:43 suzie kernel: pci_bind-0194 [05] acpi_pci_bind         :
Device 00:02:04.01 not present in PCI namespace
Feb 12 19:00:43 suzie kernel: ACPI: Embedded Controller [C0D0] (gpe 29)
Feb 12 19:00:43 suzie keytable: Loading keymap:=20
Feb 12 19:00:43 suzie kernel: schedule_task(): keventd has not started
Feb 12 19:00:43 suzie rpc.statd[510]: Version 1.0.1 Starting
Feb 12 19:00:43 suzie kernel: ACPI: Power Resource [C140] (off)
Feb 12 19:00:43 suzie kernel: ACPI: Power Resource [C154] (off)
Feb 12 19:00:43 suzie keytable:=20
Feb 12 19:00:43 suzie kernel: ACPI: Power Resource [C158] (off)
Feb 12 19:00:43 suzie kernel: ACPI: Power Resource [C15C] (off)
Feb 12 19:00:43 suzie kernel: ACPI: Power Resource [C165] (on)
Feb 12 19:00:43 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.00 not present in PCI namespace
Feb 12 19:00:43 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.01 not present in PCI namespace
Feb 12 19:00:43 suzie keytable: Loading system font:=20
Feb 12 19:00:44 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.02 not present in PCI namespace
Feb 12 19:00:44 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
Device 00:00:1d.07 not present in PCI namespace
Feb 12 19:00:44 suzie kernel: ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10
*11)
Feb 12 19:00:44 suzie kernel: ACPI: PCI Interrupt Link [C0B7] (IRQs *5
10 11)
Feb 12 19:00:44 suzie kernel: ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10
11, disabled)
Feb 12 19:00:44 suzie kernel: ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10
*11)
Feb 12 19:00:44 suzie kernel: ACPI: PCI Interrupt Link [C0BA] (IRQs 5
*10 11)
Feb 12 19:00:44 suzie keytable:=20
Feb 12 19:00:44 suzie kernel: pci_link-0122 [14] acpi_pci_link_get_poss:
Blank IRQ resource
Feb 12 19:00:44 suzie rc: Starting keytable:  succeeded
Feb 12 19:00:44 suzie kernel: pci_link-0122 [14] acpi_pci_link_get_poss:
Blank IRQ resource
Feb 12 19:00:44 suzie kernel: pci_link-0122 [14] acpi_pci_link_get_poss:
Blank IRQ resource
Feb 12 19:00:44 suzie kernel: ACPI: Power Resource [C0CF] (on)
Feb 12 19:00:44 suzie kernel: ACPI: Power Resource [C1D1] (off)
Feb 12 19:00:44 suzie kernel: ACPI: Power Resource [C1D2] (off)
Feb 12 19:00:44 suzie kernel: ACPI: Power Resource [C1D3] (off)
Feb 12 19:00:44 suzie kernel: ACPI: Power Resource [C1D4] (off)
Feb 12 19:00:44 suzie kernel: PCI: Probing PCI hardware
Feb 12 19:00:44 suzie kernel: ACPI: PCI Interrupt Link [C0B8] enabled at
IRQ 5
Feb 12 19:00:44 suzie kernel: PCI: Using ACPI for IRQ routing
Feb 12 19:00:44 suzie kernel: PCI: if you experience problems, try using
option 'pci=3Dnoacpi' or even 'acpi=3Doff'
Feb 12 19:00:44 suzie kernel: isapnp: Scanning for PnP cards...
Feb 12 19:00:44 suzie kernel: isapnp: No Plug & Play device found
Feb 12 19:00:44 suzie kernel: Linux NET4.0 for Linux 2.4
Feb 12 19:00:44 suzie kernel: Based upon Swansea University Computer
Society NET3.039
Feb 12 19:00:44 suzie kernel: Initializing RT netlink socket
Feb 12 19:00:44 suzie kernel: IA-32 Microcode Update Driver: v1.11
<tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Feb 12 19:00:44 suzie kernel: Starting kswapd
Feb 12 19:00:44 suzie kernel: Journalled Block Device driver loaded
Feb 12 19:00:44 suzie kernel: Installing knfsd (copyright (C) 1996
okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
Feb 12 19:00:44 suzie kernel: NTFS driver v1.1.22 [Flags: R/O]
Feb 12 19:00:44 suzie kernel: ACPI: AC Adapter [C11A] (off-line)
Feb 12 19:00:44 suzie kernel: ACPI: Battery Slot [C11C] (battery
present)
Feb 12 19:00:44 suzie kernel: ACPI: Battery Slot [C11B] (battery absent)
Feb 12 19:00:44 suzie kernel: ACPI: Power Button (FF) [PWRF]
Feb 12 19:00:44 suzie random: Initializing random number generator:=20
succeeded
Feb 12 19:00:44 suzie kernel: ACPI: Sleep Button (CM) [C11E]
Feb 12 19:00:44 suzie kernel: ACPI: Lid Switch [C11D]
Feb 12 19:00:44 suzie kernel: ACPI: Fan [C1D5] (off)
Feb 12 19:00:44 suzie kernel: ACPI: Fan [C1D6] (off)
Feb 12 19:00:44 suzie kernel: ACPI: Fan [C1D7] (off)
Feb 12 19:00:44 suzie kernel: ACPI: Fan [C1D8] (off)
Feb 12 19:00:44 suzie kernel: ACPI: Processor [C000] (supports C1 C2 C3,
2 performance states, 8 throttling states)
Feb 12 19:00:44 suzie kernel: [ACPI Debug] Integer: 0000000000000E3A
Feb 12 19:00:44 suzie kernel: [ACPI Debug] Integer: 0000000000000DB8
Feb 12 19:00:44 suzie kernel: [ACPI Debug] Integer: 0000000000000D7C
Feb 12 19:00:44 suzie kernel: [ACPI Debug] Integer: 0000000000000D4A
Feb 12 19:00:44 suzie kernel: [ACPI Debug] Integer: 0000000000000CD2
Feb 12 19:00:44 suzie kernel: ACPI: Thermal Zone [TZ1] (38 C)
Feb 12 19:00:44 suzie kernel: ACPI: Thermal Zone [TZ2] (32 C)
Feb 12 19:00:44 suzie kernel: [ACPI Debug] Integer: 0000000000000CBE
Feb 12 19:00:44 suzie kernel: ACPI: Thermal Zone [TZ3] (21 C)
Feb 12 19:00:44 suzie kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP]
Feb 12 19:00:44 suzie kernel: parport0: irq 7 detected
Feb 12 19:00:44 suzie kernel: radeonfb: ref_clk=3D2700, ref_div=3D12,
xclk=3D17575 from BIOS
Feb 12 19:00:44 suzie kernel: radeonfb: panel ID string:
LGP                    =20
Feb 12 19:00:44 suzie kernel: radeonfb: detected DFP panel size from
BIOS: 1400x1050
Feb 12 19:00:44 suzie kernel: Console: switching to colour frame buffer
device 175x65
Feb 12 19:00:44 suzie kernel: radeonfb: ATI Radeon M7 LW  DDR SGRAM 32
MB
Feb 12 19:00:44 suzie kernel: radeonfb: DVI port LCD monitor connected
Feb 12 19:00:44 suzie kernel: radeonfb: CRT port no monitor connected
Feb 12 19:00:44 suzie kernel: pty: 256 Unix98 ptys configured
Feb 12 19:00:44 suzie kernel: Serial driver version 5.05c (2001-07-08)
with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Feb 12 19:00:44 suzie kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Feb 12 19:00:44 suzie kernel: ttyS02 at 0x03e8 (irq =3D 4) is a 16550A
Feb 12 19:00:44 suzie kernel: lp0: using parport0 (polling).
Feb 12 19:00:44 suzie kernel: i810_rng: RNG not detected
Feb 12 19:00:44 suzie kernel: Floppy drive(s): fd0 is 1.44M
Feb 12 19:00:44 suzie kernel: FDC 0 is a National Semiconductor PC87306
Feb 12 19:00:44 suzie kernel: loop: loaded (max 8 devices)
Feb 12 19:00:44 suzie kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
Feb 12 19:00:44 suzie kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
Feb 12 19:00:44 suzie kernel: eth0: OEM i82557/i82558 10/100 Ethernet,
00:08:02:68:36:A5, IRQ 10.
Feb 12 19:00:44 suzie kernel:   Board assembly 000000-000, Physical
connectors present: RJ45
Feb 12 19:00:44 suzie kernel:   Primary interface chip i82555 PHY #1.
Feb 12 19:00:44 suzie kernel:   General self-test: passed.
Feb 12 19:00:44 suzie pcmcia: Starting PCMCIA services:
Feb 12 19:00:44 suzie kernel:   Serial sub-system self-test: passed.
Feb 12 19:00:44 suzie pcmcia:  cardmgr.
Feb 12 19:00:44 suzie kernel:   Internal registers self-test: passed.
Feb 12 19:00:44 suzie cardmgr[559]: starting, version is 3.1.31
Feb 12 19:00:44 suzie kernel:   ROM checksum self-test: passed
(0x04f4518b).
Feb 12 19:00:44 suzie rc: Starting pcmcia:  succeeded
Feb 12 19:00:44 suzie kernel: PPP generic driver version 2.4.2
Feb 12 19:00:44 suzie cardmgr[559]: config error, file 'config' line
1053: syntax error
Feb 12 19:00:44 suzie kernel: PPP Deflate Compression module registered
Feb 12 19:00:44 suzie cardmgr[559]: config error, file 'config' line
2129: no function bindings
Feb 12 19:00:44 suzie kernel: PPP BSD Compression module registered
Feb 12 19:00:44 suzie kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Feb 12 19:00:44 suzie cardmgr[559]: watching 1 sockets
Feb 12 19:00:44 suzie kernel: agpgart: Maximum main memory to use for
agp memory: 439M
Feb 12 19:00:44 suzie cardmgr[559]: Card Services release does not match
Feb 12 19:00:44 suzie kernel: agpgart: Detected Intel i845 chipset
Feb 12 19:00:44 suzie kernel: agpgart: AGP aperture is 256M @ 0x60000000
Feb 12 19:00:44 suzie kernel: [drm] Initialized tdfx 1.0.0 20010216 on
minor 0
Feb 12 19:00:44 suzie kernel: [drm] AGP 0.99 on Intel i845 @ 0x60000000
256MB
Feb 12 19:00:44 suzie kernel: [drm] Initialized radeon 1.1.1 20010405 on
minor 1
Feb 12 19:00:44 suzie kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00beta-2.4
Feb 12 19:00:44 suzie kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=3Dxx
Feb 12 19:00:44 suzie kernel: ICH3M: IDE controller at PCI slot 00:1f.1
Feb 12 19:00:44 suzie kernel: PCI: Enabling device 00:1f.1 (0005 ->
0007)
Feb 12 19:00:44 suzie kernel: ICH3M: chipset revision 2
Feb 12 19:00:44 suzie kernel: ICH3M: not 100%% native mode: will probe
irqs later
Feb 12 19:00:44 suzie kernel:     ide0: BM-DMA at 0x4440-0x4447, BIOS
settings: hda:DMA, hdb:pio
Feb 12 19:00:44 suzie kernel:     ide1: BM-DMA at 0x4448-0x444f, BIOS
settings: hdc:DMA, hdd:pio
Feb 12 19:00:44 suzie kernel: hda: IC25N040ATCS05-0, ATA DISK drive
Feb 12 19:00:44 suzie kernel: blk: queue c047dca0, I/O limit 4095Mb
(mask 0xffffffff)
Feb 12 19:00:44 suzie kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N,
ATAPI CD/DVD-ROM drive
Feb 12 19:00:44 suzie kernel: ide2: ports already in use, skipping probe
Feb 12 19:00:44 suzie kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 19:00:44 suzie kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 12 19:00:44 suzie kernel: hda: host protected area =3D> 1
Feb 12 19:00:44 suzie kernel: hda: 78140160 sectors (40008 MB) w/7898KiB
Cache, CHS=3D5168/240/63, UDMA(100)
Feb 12 19:00:44 suzie kernel: Partition check:
Feb 12 19:00:44 suzie kernel:  hda: hda1 hda2 < hda5 > hda3 hda4
Feb 12 19:00:44 suzie kernel: SCSI subsystem driver Revision: 1.00
Feb 12 19:00:44 suzie kernel: scsi0 : SCSI host adapter emulation for
IDE ATAPI devices
Feb 12 19:00:44 suzie kernel:   Vendor: HL-DT-ST  Model: RW/DVD
GCC-4240N  Rev: 0110
Feb 12 19:00:45 suzie netfs: Mounting NFS filesystems:  succeeded
Feb 12 19:00:45 suzie kernel:   Type: =20
CD-ROM                             ANSI SCSI revision: 02
Feb 12 19:00:45 suzie kernel: Attached scsi CD-ROM sr0 at scsi0, channel
0, id 0, lun 0
Feb 12 19:00:45 suzie kernel: sr0: scsi3-mmc drive: 24x/24x writer cd/rw
xa/form2 cdda tray
Feb 12 19:00:45 suzie kernel: Uniform CD-ROM driver Revision: 3.12
Feb 12 19:00:45 suzie kernel: Intel 810 + AC97 Audio, version 0.24,
12:55:12 Feb 10 2003
Feb 12 19:00:45 suzie kernel: i810: Intel ICH3 found at IO 0x4400 and
0x4000, MEM 0x0000 and 0x0000, IRQ 5
Feb 12 19:00:45 suzie kernel: i810_audio: Audio Controller supports 6
channels.
Feb 12 19:00:45 suzie kernel: i810_audio: Defaulting to base 2 channel
mode.
Feb 12 19:00:45 suzie kernel: i810_audio: Resetting connection 0
Feb 12 19:00:45 suzie kernel: ac97_codec: AC97 Audio codec, id: ADS99
(Unknown)
Feb 12 19:00:45 suzie kernel: i810_audio: AC'97 codec 0 Unable to map
surround DAC's (or DAC's not present), total channels =3D 2
Feb 12 19:00:45 suzie kernel: Linux Kernel Card Services 3.1.22
Feb 12 19:00:45 suzie kernel:   options:  [pci] [cardbus] [pm]
Feb 12 19:00:45 suzie kernel: usb.c: registered new driver usbdevfs
Feb 12 19:00:45 suzie kernel: usb.c: registered new driver hub
Feb 12 19:00:45 suzie kernel: Yenta IRQ list 0098, PCI irq11
Feb 12 19:00:45 suzie kernel: Socket status: 30000006
Feb 12 19:00:45 suzie kernel: ehci-hcd 02:0e.2: NEC Corporation USB 2.0
Feb 12 19:00:45 suzie netfs: Mounting other filesystems:  succeeded
Feb 12 19:00:45 suzie kernel: ehci-hcd 02:0e.2: irq 10, pci mem e2865000
Feb 12 19:00:45 suzie kernel: usb.c: new USB bus registered, assigned
bus number 1
Feb 12 19:00:45 suzie kernel: ehci-hcd 02:0e.2: USB 2.0 enabled, EHCI
0.95, driver 2002-Dec-20
Feb 12 19:00:45 suzie kernel: hub.c: USB hub found
Feb 12 19:00:45 suzie kernel: hub.c: 5 ports detected
Feb 12 19:00:45 suzie kernel: uhci.c: USB Universal Host Controller
Interface driver v1.1
Feb 12 19:00:45 suzie kernel: usb-ohci.c: USB OHCI at membase
0xe2867000, IRQ 10
Feb 12 19:00:45 suzie kernel: usb-ohci.c: usb-02:0e.0, NEC Corporation
USB
Feb 12 19:00:45 suzie kernel: usb.c: new USB bus registered, assigned
bus number 2
Feb 12 19:00:45 suzie kernel: hub.c: USB hub found
Feb 12 19:00:45 suzie kernel: hub.c: 3 ports detected
Feb 12 19:00:45 suzie kernel: usb-ohci.c: USB OHCI at membase
0xe2869000, IRQ 10
Feb 12 19:00:45 suzie kernel: usb-ohci.c: usb-02:0e.1, NEC Corporation
USB (#2)
Feb 12 19:00:45 suzie kernel: usb.c: new USB bus registered, assigned
bus number 3
Feb 12 19:00:45 suzie kernel: hub.c: USB hub found
Feb 12 19:00:45 suzie kernel: hub.c: 2 ports detected
Feb 12 19:00:45 suzie kernel: usb.c: registered new driver hiddev
Feb 12 19:00:45 suzie kernel: usb.c: registered new driver hid
Feb 12 19:00:45 suzie kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech
Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Feb 12 19:00:45 suzie kernel: hid-core.c: USB HID support drivers
Feb 12 19:00:45 suzie kernel: usb.c: registered new driver serial
Feb 12 19:00:45 suzie kernel: usbserial.c: USB Serial Driver core v1.4
Feb 12 19:00:45 suzie kernel: usbserial.c: USB Serial support registered
for Handspring Visor / Palm 4.0 / Cli=E9 4.x
Feb 12 19:00:45 suzie kernel: usbserial.c: USB Serial support registered
for Sony Cli=E9 3.5
Feb 12 19:00:45 suzie kernel: visor.c: USB HandSpring Visor, Palm m50x,
Sony Cli=E9 driver v1.6
Feb 12 19:00:45 suzie kernel: Initializing USB Mass Storage driver...
Feb 12 19:00:45 suzie kernel: usb.c: registered new driver usb-storage
Feb 12 19:00:45 suzie kernel: USB Mass Storage support registered.
Feb 12 19:00:45 suzie kernel: mice: PS/2 mouse device common for all
mice
Feb 12 19:00:45 suzie kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 12 19:00:45 suzie kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Feb 12 19:00:45 suzie kernel: IP: routing cache hash table of 4096
buckets, 32Kbytes
Feb 12 19:00:45 suzie kernel: TCP: Hash tables configured (established
32768 bind 65536)
Feb 12 19:00:45 suzie kernel: ip_conntrack version 2.1 (4094 buckets,
32752 max) - 292 bytes per conntrack
Feb 12 19:00:45 suzie kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Feb 12 19:00:45 suzie ypbind: Setting NIS domain name hjblocal.nl:=20
succeeded
Feb 12 19:00:45 suzie kernel: kjournald starting.  Commit interval 5
seconds
Feb 12 19:00:45 suzie kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Feb 12 19:00:45 suzie kernel: VFS: Mounted root (ext3 filesystem)
readonly.
Feb 12 19:00:45 suzie kernel: Freeing unused kernel memory: 148k freed
Feb 12 19:00:45 suzie kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,3), internal journal
Feb 12 19:00:45 suzie kernel: Adding Swap: 1050832k swap-space (priority
-1)
Feb 12 19:00:45 suzie kernel: microcode: CPU0 no microcode found!
(sig=3Df27, pflags=3D8)
Feb 12 19:00:45 suzie kernel: ip_tables: (C) 2000-2002 Netfilter core
team
Feb 12 19:00:45 suzie kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Feb 12 19:00:45 suzie kernel: cs: IO port probe 0x0100-0x04ff: excluding
0x4d0-0x4d7
Feb 12 19:00:45 suzie ypbind: ypbind startup succeeded
Feb 12 19:00:45 suzie kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Feb 12 19:00:45 suzie ypbind: bound to NIS server calvin.hjblocal.nl
Feb 12 19:00:43 suzie ifup:  done.=20
Feb 12 19:00:43 suzie network: Bringing up interface eth0:  succeeded=20
Feb 12 19:00:45 suzie autofs: automount startup succeeded
Feb 12 19:00:46 suzie sshd: Starting sshd:
Feb 12 19:00:46 suzie sshd:  succeeded
Feb 12 19:00:46 suzie sshd:=20
Feb 12 19:00:46 suzie rc: Starting sshd:  succeeded
Feb 12 19:00:48 suzie xinetd[670]: xinetd Version 2.3.7 started with
libwrap options compiled in.
Feb 12 19:00:48 suzie xinetd[670]: Started working: 1 available service
Feb 12 19:00:49 suzie xinetd: xinetd startup succeeded
Feb 12 19:00:50 suzie mysqld: Starting MySQL:  succeeded
Feb 12 19:00:52 suzie sendmail: sendmail startup succeeded
Feb 12 19:00:52 suzie sendmail: sm-client startup succeeded
Feb 12 19:00:53 suzie gpm: gpm startup succeeded
Feb 12 19:00:56 suzie httpd: httpd startup succeeded
Feb 12 19:00:56 suzie crond: crond startup succeeded
Feb 12 19:00:59 suzie xfs: xfs startup succeeded
Feb 12 19:00:59 suzie anacron: anacron startup succeeded
Feb 12 19:00:59 suzie xfs: listening on port 7100=20
Feb 12 19:00:59 suzie atd: atd startup succeeded
Feb 12 19:00:59 suzie wine: Registering binary handler for Windows
applications
Feb 12 19:00:59 suzie wine: /etc/rc5.d/S98wine: line 16:
/proc/sys/fs/binfmt_misc/register: No such file or directory
Feb 12 19:00:59 suzie wine: /etc/rc5.d/S98wine: line 17:
/proc/sys/fs/binfmt_misc/register: No such file or directory
Feb 12 19:00:59 suzie rc: Starting wine:  succeeded
Feb 12 19:01:00 suzie xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)=20
Feb 12 19:01:02 suzie modprobe: modprobe: Can't locate module
char-major-10-134
Feb 12 19:08:16 suzie gdm(pam_unix)[897]: session opened for user
bareldshj by (uid=3D0)
Feb 12 19:08:18 suzie gconfd (bareldshj-959): starting (version 1.2.1),
pid 959 user 'bareldshj'
Feb 12 19:08:18 suzie gconfd (bareldshj-959): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config
source at position 0
Feb 12 19:08:18 suzie gconfd (bareldshj-959): Resolved address
"xml:readwrite:/home_local/bareldshj/.gconf" to a writable config source
at position 1
Feb 12 19:08:18 suzie gconfd (bareldshj-959): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config
source at position 2
Feb 12 19:47:24 suzie dhclient: DHCPREQUEST on eth0 to 10.0.0.138 port
67
Feb 12 19:47:24 suzie dhclient: DHCPACK from 10.0.0.138
Feb 12 19:47:25 suzie dhclient: bound to 10.0.0.154 -- renewal in 2932
seconds.
Feb 12 20:11:23 suzie kernel: [ACPI Debug] Integer: 0000000000000E3A
Feb 12 20:11:23 suzie kernel: [ACPI Debug] Integer: 0000000000000DB8
Feb 12 20:11:23 suzie kernel: [ACPI Debug] Integer: 0000000000000D7C
Feb 12 20:11:23 suzie kernel: [ACPI Debug] Integer: 0000000000000D4A
Feb 12 20:11:23 suzie kernel: [ACPI Debug] Integer: 0000000000000C3C
Feb 12 20:36:16 suzie dhclient: DHCPREQUEST on eth0 to 10.0.0.138 port
67
Feb 12 20:36:16 suzie dhclient: DHCPACK from 10.0.0.138
Feb 12 20:36:16 suzie dhclient: bound to 10.0.0.154 -- renewal in 3134
seconds.
Feb 12 20:40:51 suzie kernel: [ACPI Debug] Integer: 0000000000000E3A
Feb 12 20:40:51 suzie kernel: [ACPI Debug] Integer: 0000000000000DB8
Feb 12 20:40:51 suzie kernel: [ACPI Debug] Integer: 0000000000000D7C
Feb 12 20:40:51 suzie kernel: [ACPI Debug] Integer: 0000000000000D4A
Feb 12 20:40:51 suzie kernel: [ACPI Debug] Integer: 0000000000000C3C



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
