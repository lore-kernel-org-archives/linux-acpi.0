From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI 2.5.70+ problem
Date: Mon, 9 Jun 2003 13:32:14 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2DE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stephen Hemminger <shemminger-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have no idea. Did it work on previous kernels w/ACPI?

I see several bugs in bugzilla that might be the same thing...hard to
say.

Regards -- Andy

PS CC-ing acpi-devel

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger-3NddpPZAyC0@public.gmane.org]=20
> Sent: Monday, June 09, 2003 1:12 PM
> To: Grover, Andrew
> Subject: ACPI 2.5.70+ problem
>=20
>=20
> Trying to run 2.5.70 on one our older VA Linux blade servers.
> Is this a known ACPI problem or something new?
> Is it the reason the machine doesn't boot?
>=20
>=20
> LILO boot:
> Loading linux-2.5......................
> Linux version 2.5.70 (shemminger@cl001) (gcc version 3.2=20
> 20020903 (Red Hat Linux 8.0 3.2-7)) #2 Mon Jun 9 11:29:16 PDT 2003
> Video mode to be used for restore is ffff
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fffb000 (usable)
>  BIOS-e820: 000000003fffb000 - 000000003ffff000 (ACPI data)
>  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available.
> On node 0 totalpages: 229376
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> ACPI: RSDP (v000 ASUS                       ) @ 0x000f6250
> ACPI: RSDT (v001 ASUS   CUR-DLS  12336.12337) @ 0x3fffb000
> ACPI: FADT (v001 ASUS   CUR-DLS  12336.12337) @ 0x3fffb100
> ACPI: BOOT (v001 ASUS   CUR-DLS  12336.12337) @ 0x3fffb040
> ACPI: MADT (v001 ASUS   CUR-DLS  12336.12337) @ 0x3fffb080
> ACPI: DSDT (v001   ASUS CUR-DLS  00000.04096) @ 0x00000000
> ACPI: BIOS passes blacklist
> Building zonelist for node : 0
> Kernel command line: auto BOOT_IMAGE=3Dlinux-2.5 ro root=3D306=20
> BOOT_FILE=3D/boot/vmlinuz-2.5.70 console=3DttyS0,38400n8 =
console=3Dtty1
> Initializing CPU#0
> PID hash table entries: 4096 (order 12: 32768 bytes)
> Detected 867.315 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 1712.12 BogoMIPS
> Memory: 905008k/917504k available (1569k kernel code, 11716k=20
> reserved, 533k data, 292k init, 0k highmem)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> -> /dev
> -> /dev/console
> -> /root
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> CPU serial number disabled.
> CPU: Intel Pentium III (Coppermine) stepping 06
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v2.0 (20020519)
> Initializing RT netlink socket
> PCI: PCI BIOS revision 2.10 entry at 0xf0a80, last bus=3D1
> PCI: Using configuration type 1
> BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
> biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
> ACPI: Subsystem revision 20030522
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables=20
> successfully acquired
> Parsing all Control=20
> Methods:......................................................
> ..............................................................
> ....................
> Table [DSDT](id F004) - 437 Objects with 41 Devices 136=20
> Methods 13 Regions
> ACPI Namespace successfully loaded at root c0364f7c
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI=20
> mode successful
> evgpeblk-0743 [06] ev_create_gpe_block   : GPE 00 to 31=20
> [_GPE] 4 regs at 000000000000EB10 on int 9
> evgpeblk-0262 [08] ev_save_method_info   : Registered GPE=20
> method _L00 as GPE number 0x00
> Completing Region/Field/Buffer/Package=20
> initialization:...............................................
> .............
> Initialized 13/13 Regions 0/0 Fields 37/37 Buffers 10/10=20
> Packages (445 nodes)
> Executing all Device _STA and_INI=20
> methods:..........................................
> 42 Devices found containing: 42 _STA, 1 _INI methods
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> pci_link-0256 [10] acpi_pci_link_get_curr: No IRQ resource found
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
> ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14=20
> 15, disabled)
> ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Root Bridge [PCI1] (00:00)
> Linux Plug and Play Support v0.96 (c) Adam Belay
> pty: 256 Unix98 ptys configured
> block request queues:
>  4/128 requests per read queue
>  4/128 requests per write queue
>  enter congestion at 15
>  exit congestion at 17
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
> pci_link-0361 [33] acpi_pci_link_set     : Attempt to enable=20
> at IRQ 9 resulted in IRQ 11
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
> pci_link-0361 [37] acpi_pci_link_set     : Attempt to enable=20
> at IRQ 9 resulted in IRQ 11
> ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 0
> pci_link-0361 [38] acpi_pci_link_set     : Attempt to enable=20
> at IRQ 9 resulted in IRQ 11
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 0
> ACPI: PCI Interrupt Link [LNKK] enabled at IRQ 9
> pci_link-0361 [40] acpi_pci_link_set     : Attempt to enable=20
> at IRQ 5 resulted in IRQ 11
> ACPI: PCI Interrupt Link [LNKL] enabled at IRQ 0
> ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LNKN] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKO] enabled at IRQ 10
> ACPI: PCI Interrupt Link [LNKP] enabled at IRQ 9
> ACPI: PCI Interrupt Link [LNKS] enabled at IRQ 5
> pci_link-0502 [46] acpi_pci_link_get_irq : Link disabled
>  pci_irq-0256 [45] acpi_pci_irq_lookup   : Invalid IRQ link=20
> routing entry
>  pci_irq-0295 [45] acpi_pci_irq_derive   : Unable to derive=20
> IRQ for device 00:04.0
> ACPI: No IRQ known for interrupt pin A of device 00:04.0
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option=20
> 'pci=3Dnoacpi' or even 'acpi=3Doff'
> SBF: Simple Boot Flag extension found and enabled.
> SBF: Setting boot flags 0x80
> Enabling SEP on CPU 0
> udf: registering filesystem
> ACPI: Power Button (FF) [PWRF]
> ACPI: Processor [CPU0] (supports C1)
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> floppy0: no floppy controllers found
> Intel(R) PRO/100 Network Driver - version 2.3.13-k1
> Copyright (c) 2003 Intel Corporation
>=20
> pci_link-0502 [45] acpi_pci_link_get_irq : Link disabled
>  pci_irq-0256 [44] acpi_pci_irq_lookup   : Invalid IRQ link=20
> routing entry
>  pci_irq-0295 [44] acpi_pci_irq_derive   : Unable to derive=20
> IRQ for device 00:04.0
> ACPI: No IRQ known for interrupt pin A of device 00:04.0
> e100: eth0: Intel(R) PRO/100 Network Connection
>   Hardware receive checksums enabled
>   cpu cycle saver enabled
>=20
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override=20
> with idebus=3Dxx
> SvrWks OSB4: IDE controller at PCI slot 00:0f.1
> SvrWks OSB4: chipset revision 0
> SvrWks OSB4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
> hda: QUANTUM FIREBALLP LM20.5, ATA DISK drive
> hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: CD-540E, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: host protected area =3D> 1
> hda: 40132503 sectors (20548 MB) w/1900KiB Cache,=20
> CHS=3D39813/16/63, (U)DMA
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> hdb: max request size: 128KiB
> hdb: host protected area =3D> 1
> hdb: 40132503 sectors (20548 MB) w/1900KiB Cache,=20
> CHS=3D39813/16/63, (U)DMA
>  hdb: hdb1 hdb2 hdb3
> hdc: ATAPI 40X CD-ROM drive, 128kB Cache, (U)DMA
> Uniform CD-ROM driver Revision: 3.12
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3=20
> filesystem as ext2
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 292k freed
> Disabling IRQ #9
>=20


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
