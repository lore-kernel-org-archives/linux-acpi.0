From: Lars Steubesand <lars-X4/TrSdZGH7prZlt/sZkLg@public.gmane.org>
Subject: ACPI problem with Asus A7V266-E
Date: Sat, 30 Nov 2002 00:03:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211300003.47489.lars@steubesand.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

Dear ACPI List,

I have the following configuration

Mainboard  Asus A7V266-E BIOS 1011
RAM        512 MB
Graphics   Matrox G550
PROMISE0:1 IBM IC35L060AVER07-0
IDE0:0     Iomega ZIP 250 ATAPI
IDE0:1     Toshiba DVD-ROM SD-M1612
IDE1:0     Plextor CD-R PX-W2410A
Network    3COM 3C905C-TX

Using kernel linux-2.4.20 different rc versions and also different acpi p=
atch=20
versions results in a system halt during IDE device detection.

Please see below for kernel output.

Does anybody know what the problem might be or where to look for?

Thanks in advance!

Please respond also to my email address.

Lars

Linux version 2.4.20-rc3 (root@linux) (gcc version 3.2) #1 Thu Nov 28 22:=
10:22=20
CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6e20
ACPI: RSDT (v001 ASUS   A7V266-E 12336.12337) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V266-E 12336.12337) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V266-E 12336.12337) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V266-E 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: apm=3Doff root=3D/dev/hda6 hdg=3Dide-scsi  vga=3D791=
=20
max_scsi_luns=3D1 apic console=3DttyS0,115200n8
ide_setup: hdg=3Dide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1544.555 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3080.19 BogoMIPS
Memory: 514812k/524208k available (1687k kernel code, 9008k reserved, 427=
k=20
data, 156k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1544.5843 MHz.
=2E.... host bus clock speed is 268.6233 MHz.
cpu: 0, clocks: 2686233, slice: 1343116
CPU0<T0:2686224,T1:1343104,D:4,S:1343116,C:2686233>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021122
PCI: PCI BIOS revision 2.10 entry at 0xf0ed0, last bus=3D1
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acqui=
red
Parsing=20
Methods:.................................................................=
=2E...............................................
Table [DSDT] - 348 Objects with 42 Devices 113 Methods 18 Regions
ACPI Namespace successfully loaded at root c03514fc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode succes=
sful
 evevent-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:...............................=
=2E =20
uteval-0432 [07] Ut_execute_STA        : No object was returned from _STA
=2E.........
42 Devices found containing: 41 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package=20
initialization:.............................................
Initialized 14/18 Regions 0/0 Fields 19/19 Buffers 12/12 Packages (348 no=
des)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:12.00 not present=
 in=20
PCI namespace
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even=20
'acpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled on user request.
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
vesafb: framebuffer at 0xfa000000, mapped to 0xe0813000, size 32768k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D9
vesafb: protected mode interface info at c000:7d60
vesafb: scrolling: redraw
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT=20
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PDC20265: IDE controller on PCI bus 00 dev 30
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:pio, hdd:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:DMA, hdh:pio
spurious 8259A interrupt: IRQ7.





-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
