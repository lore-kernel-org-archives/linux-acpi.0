From: Nicolas <linux-QSMm8Y9olUQ@public.gmane.org>
Subject: tecra8100 kernel 2.6.0-test1
Date: Thu, 24 Jul 2003 17:02:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307241702.37236.linux@1g6.biz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Maybe you are interested,
I have to set pci=noacpi to remove all theses errors.
I have a toshiba tecra 8100 with 2.6.0-test1.

Nicolas.

PS: you may reply me directly.

Jul 24 16:39:41 tosh syslogd 1.4.1: restart (remote reception).
Jul 24 16:39:41 tosh kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 24 16:39:41 tosh kernel: Inspecting /boot/System.map
Jul 24 16:39:41 tosh partmon: Checking if partitions have enough free 
diskspace:
Jul 24 16:39:42 tosh kernel: Loaded 20727 symbols from /boot/System.map.
Jul 24 16:39:42 tosh kernel: Symbols match kernel version 2.6.0.
Jul 24 16:39:42 tosh kernel: No module symbols loaded - kernel modules not 
enabled.
Jul 24 16:39:42 tosh kernel: Linux version 2.6.0-test1 (npa-xxD3AHfOcXkANPMfv7sqcg@public.gmane.org) (gcc 
version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #2 jeu jui 24 15:01:26 CEST 
2003
Jul 24 16:39:42 tosh kernel: Video mode to be used for restore is 317
Jul 24 16:39:42 tosh kernel: BIOS-provided physical RAM map:
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 00000000000e4000 - 00000000000e8640 
(reserved)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 00000000000e8640 - 00000000000e8840 
(ACPI NVS)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 00000000000e8840 - 00000000000ec000 
(reserved)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 0000000000100000 - 0000000017fe0000 
(usable)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 0000000017fe0000 - 0000000017ff0000 
(ACPI data)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 0000000017ff0000 - 0000000018000000 
(reserved)
Jul 24 16:39:42 tosh kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 
(reserved)
Jul 24 16:39:42 tosh kernel: 383MB LOWMEM available.
Jul 24 16:39:42 tosh kernel: On node 0 totalpages: 98272
Jul 24 16:39:42 tosh kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul 24 16:39:42 tosh kernel:   Normal zone: 94176 pages, LIFO batch:16
Jul 24 16:39:42 tosh kernel:   HighMem zone: 0 pages, LIFO batch:1
Jul 24 16:39:42 tosh kernel: ACPI: RSDP (v000 TOSHIB                     ) @ 
0x000f4fd0
Jul 24 16:39:42 tosh kernel: ACPI: RSDT (v001 TOSHIB 750      00151.02068) @ 
0x17fe0000
Jul 24 16:39:42 tosh kernel: ACPI: FADT (v001 TOSHIB 750      00151.02068) @ 
0x17fe0054
Jul 24 16:39:42 tosh kernel: ACPI: BOOT (v001 TOSHIB 750      00151.02068) @ 
0x17fe002c
Jul 24 16:39:42 tosh kernel: ACPI: DSDT (v001 TOSHIB 8100     08192.01556) @ 
0x00000000
Jul 24 16:39:42 tosh kernel: ACPI: BIOS passes blacklist
Jul 24 16:39:42 tosh kernel: Building zonelist for node : 0
Jul 24 16:39:42 tosh kernel: Kernel command line: BOOT_IMAGE=linux-dev 
root=303 devfs=mount
Jul 24 16:39:42 tosh kernel: Initializing CPU#0
Jul 24 16:39:42 tosh kernel: PID hash table entries: 2048 (order 11: 16384 
bytes)
Jul 24 16:39:42 tosh kernel: Detected 597.879 MHz processor.
Jul 24 16:39:42 tosh kernel: Console: colour dummy device 80x25
Jul 24 16:39:42 tosh kernel: Calibrating delay loop... 1179.64 BogoMIPS
Jul 24 16:39:42 tosh kernel: Memory: 385716k/393088k available (1690k kernel 
code, 6612k reserved, 686k data, 124k init, 0k highmem)
Jul 24 16:39:42 tosh kernel: Dentry cache hash table entries: 65536 (order: 6, 
262144 bytes)
Jul 24 16:39:42 tosh kernel: Inode-cache hash table entries: 32768 (order: 5, 
131072 bytes)
Jul 24 16:39:42 tosh kernel: Mount-cache hash table entries: 512 (order: 0, 
4096 bytes)
Jul 24 16:39:42 tosh kernel: -> /dev
Jul 24 16:39:42 tosh kernel: -> /dev/console
Jul 24 16:39:42 tosh kernel: -> /root
Jul 24 16:39:42 tosh kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 24 16:39:42 tosh kernel: CPU: L2 cache: 256K
Jul 24 16:39:42 tosh kernel: CPU:     After generic, caps: 0383f9ff 00000000 
00000000 00000040
Jul 24 16:39:42 tosh kernel: Intel machine check architecture supported.
Jul 24 16:39:42 tosh kernel: Intel machine check reporting enabled on CPU#0.
Jul 24 16:39:42 tosh kernel: CPU: Intel Pentium III (Coppermine) stepping 01
Jul 24 16:39:42 tosh kernel: Enabling fast FPU save and restore... done.
Jul 24 16:39:42 tosh kernel: Enabling unmasked SIMD FPU exception support... 
done.
Jul 24 16:39:42 tosh kernel: Checking 'hlt' instruction... OK.
Jul 24 16:39:42 tosh kernel: POSIX conformance testing by UNIFIX
Jul 24 16:39:42 tosh kernel: Initializing RT netlink socket
Jul 24 16:39:42 tosh kernel: PCI: PCI BIOS revision 2.10 entry at 0xfee03, 
last bus=21
Jul 24 16:39:42 tosh kernel: PCI: Using configuration type 1
Jul 24 16:39:42 tosh kernel: mtrr: v2.0 (20020519)
Jul 24 16:39:42 tosh kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Jul 24 16:39:42 tosh kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Jul 24 16:39:42 tosh kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Jul 24 16:39:42 tosh kernel: biovec pool[2]:  16 bvecs: 256 entries (192 
bytes)
Jul 24 16:39:42 tosh kernel: biovec pool[3]:  64 bvecs: 256 entries (768 
bytes)
Jul 24 16:39:42 tosh kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 
bytes)
Jul 24 16:39:42 tosh kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 
bytes)
Jul 24 16:39:42 tosh kernel: ACPI: Subsystem revision 20030619
Jul 24 16:39:42 tosh kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI 
Tables successfully acquired
Jul 24 16:39:42 tosh kernel: Parsing all Control 
Methods:..............................................................................................................................................
....................................................................
Jul 24 16:39:42 tosh kernel: Table [DSDT](id F004) - 590 Objects with 59 
Devices 210 Methods 5 Regions
Jul 24 16:39:42 tosh kernel: ACPI Namespace successfully loaded at root 
c03874dc
Jul 24 16:39:42 tosh kernel: evxfevnt-0093 [04] acpi_enable           : 
Transition to ACPI mode successful
Jul 24 16:39:42 tosh kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 
to 15 [_GPE] 2 regs at 000000000000FE0C on int 9
Jul 24 16:39:42 tosh kernel: Completing Region/Field/Buffer/Package 
initialization:.............................................
Jul 24 16:39:42 tosh kernel: Initialized 5/5 Regions 0/0 Fields 10/10 Buffers 
30/30 Packages (598 nodes)
Jul 24 16:39:42 tosh kernel: Executing all Device _STA and_INI methods:..  
uteval-0109: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node 
d7f1dbc8), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKB._STA] (Node d7f1d688), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKC._STA] (Node d7f1d1a8), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKD._STA] (Node d7f1cbe8), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: ..............  uteval-0109: *** Error: No object 
was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node d7f19aa8), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.COM_._STA] (Node d7f13868), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.PRT_._STA] (Node d7f12fa8), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.PRT1._STA] (Node d7f12b28), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.PCC0._STA] (Node d7f12648), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: ..................................
Jul 24 16:39:42 tosh kernel: 57 Devices found containing: 48 _STA, 1 _INI 
methods
Jul 24 16:39:42 tosh kernel: ACPI: Interpreter enabled
Jul 24 16:39:42 tosh kernel: ACPI: Using PIC for interrupt routing
Jul 24 16:39:42 tosh kernel:   uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKE._PRS] (Node d7f1c648), AE_NOT_EXIST
Jul 24 16:39:42 tosh kernel: pci_link-0165 [07] acpi_pci_link_get_poss: Error 
evaluating _PRS
Jul 24 16:39:42 tosh kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 24 16:39:42 tosh kernel: PCI: Probing PCI hardware (bus 00)
Jul 24 16:39:42 tosh kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Jul 24 16:39:42 tosh kernel: ACPI: Power Resource [PIHD] (on)
Jul 24 16:39:42 tosh kernel: ACPI: Power Resource [PMHD] (on)
Jul 24 16:39:42 tosh kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.PCI1._PRT]
Jul 24 16:39:42 tosh kernel: ACPI: Power Resource [PFAN] (off)
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1cd08]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:05.2
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin D of device 
0000:00:05.2
Jul 24 16:39:42 tosh kernel: pci_link-0491 [19] acpi_pci_link_get_irq : 
Invalid link context
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:07.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:00:07.0
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1d2c8]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:09.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:00:09.0
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1dda8]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:0b.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:00:0b.0 - using IRQ 255
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1d7a8]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:0b.1
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin B of device 
0000:00:0b.1 - using IRQ 255
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1cd08]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:0c.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:00:0c.0
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1cd08]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:01:00.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:01:00.0
Jul 24 16:39:42 tosh kernel: PCI: Using ACPI for IRQ routing
Jul 24 16:39:42 tosh kernel: PCI: if you experience problems, try using option 
'pci=noacpi' or even 'acpi=off'
Jul 24 16:39:42 tosh kernel: vesafb: framebuffer at 0xf0000000, mapped to 
0xd8808000, size 8192k
Jul 24 16:39:42 tosh kernel: vesafb: mode is 1024x768x16, linelength=2048, 
pages=4
Jul 24 16:39:42 tosh kernel: vesafb: protected mode interface info at 
c000:8751
Jul 24 16:39:42 tosh kernel: vesafb: scrolling: redraw
Jul 24 16:39:42 tosh kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Jul 24 16:39:42 tosh kernel: fb0: VESA VGA frame buffer device
Jul 24 16:39:42 tosh kernel: Console: switching to colour frame buffer device 
128x48
Jul 24 16:39:42 tosh kernel: pty: 256 Unix98 ptys configured
Jul 24 16:39:42 tosh kernel: SBF: Simple Boot Flag extension found and 
enabled.
Jul 24 16:39:42 tosh kernel: SBF: Simple boot flag value 0x22 read from CMOS 
RAM was invalid
Jul 24 16:39:42 tosh kernel: SBF: Setting boot flags 0x80
Jul 24 16:39:42 tosh kernel: Enabling SEP on CPU 0
Jul 24 16:39:42 tosh kernel: VFS: Disk quotas dquot_6.5.1
Jul 24 16:39:42 tosh kernel: devfs: v1.22 (20021013) Richard Gooch 
(rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
Jul 24 16:39:42 tosh kernel: devfs: boot_options: 0x1
Jul 24 16:39:42 tosh kernel: Initializing Cryptographic API
Jul 24 16:39:42 tosh kernel: Limiting direct PCI/PCI transfers.
Jul 24 16:39:42 tosh kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jul 24 16:39:42 tosh kernel: agpgart: Detected an Intel 440BX Chipset.
Jul 24 16:39:42 tosh kernel: agpgart: Maximum main memory to use for agp 
memory: 321M
Jul 24 16:39:42 tosh kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Jul 24 16:39:42 tosh kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ 
sharing disabled
Jul 24 16:39:42 tosh kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 24 16:39:42 tosh kernel: Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Jul 24 16:39:42 tosh kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Jul 24 16:39:42 tosh kernel: PIIX4: IDE controller at PCI slot 0000:00:05.1
Jul 24 16:39:42 tosh kernel: PIIX4: chipset revision 1
Jul 24 16:39:42 tosh kernel: PIIX4: not 100%% native mode: will probe irqs 
later
Jul 24 16:39:42 tosh kernel:     ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: 
hda:DMA, hdb:pio
Jul 24 16:39:42 tosh kernel:     ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: 
hdc:DMA, hdd:pio
Jul 24 16:39:42 tosh kernel: hda: IC25N040ATCS05-0, ATA DISK drive
Jul 24 16:39:42 tosh kernel: anticipatory scheduling elevator
Jul 24 16:39:42 tosh kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 24 16:39:42 tosh kernel: hdc: CD-224E-B, ATAPI CD/DVD-ROM drive
Jul 24 16:39:42 tosh kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 24 16:39:42 tosh kernel: hda: max request size: 128KiB
Jul 24 16:39:42 tosh kernel: hda: host protected area => 1
Jul 24 16:39:42 tosh kernel: hda: 78140160 sectors (40008 MB) w/7898KiB Cache, 
CHS=77520/16/63, UDMA(33)
Jul 24 16:39:42 tosh kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 
p7 p8 p9 p10 > p3 p4
Jul 24 16:39:42 tosh kernel: Console: switching to colour frame buffer device 
128x48
Jul 24 16:39:42 tosh kernel: mice: PS/2 mouse device common for all mice
Jul 24 16:39:42 tosh kernel: input: ImPS/2 Generic Wheel Mouse on 
isa0060/serio1
Jul 24 16:39:42 tosh kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 24 16:39:42 tosh kernel: input: AT Set 2 keyboard on isa0060/serio0
Jul 24 16:39:42 tosh kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 24 16:39:42 tosh kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 24 16:39:42 tosh kernel: IP: routing cache hash table of 4096 buckets, 
32Kbytes
Jul 24 16:39:42 tosh kernel: TCP: Hash tables configured (established 32768 
bind 65536)
Jul 24 16:39:42 tosh kernel: Initializing IPsec netlink socket
Jul 24 16:39:42 tosh kernel: ACPI: (supports S0 S1 S3 S4 S4bios S5)
Jul 24 16:39:42 tosh kernel: found reiserfs format "3.6" with standard journal
Jul 24 16:39:42 tosh kernel: Reiserfs journal params: device hda3, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
Jul 24 16:39:42 tosh kernel: reiserfs: checking transaction log (hda3) for 
(hda3)
Jul 24 16:39:42 tosh kernel: Using r5 hash to sort names
Jul 24 16:39:42 tosh kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Jul 24 16:39:42 tosh kernel: Mounted devfs on /dev
Jul 24 16:39:42 tosh kernel: Freeing unused kernel memory: 124k freed
Jul 24 16:39:42 tosh kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
Jul 24 16:39:42 tosh kernel: Real Time Clock Driver v1.11
Jul 24 16:39:42 tosh kernel: Adding 506008k swap on /dev/hda5.  Priority:-1 
extents:1
Jul 24 16:39:42 tosh kernel: ACPI: Processor [CPU0] (supports C1 C2)
Jul 24 16:39:42 tosh kernel: cpufreq: No CPUs supporting ACPI performance 
management found.
Jul 24 16:39:42 tosh kernel: Toshiba Laptop ACPI Extras version 0.15
Jul 24 16:39:42 tosh kernel: ACPI: Thermal Zone [THRM] (64 C)
Jul 24 16:39:42 tosh kernel: ACPI: Fan [FAN] (off)
Jul 24 16:39:42 tosh kernel: ACPI: AC Adapter [ADP1] (on-line)
Jul 24 16:39:42 tosh kernel: ACPI: Battery Slot [BAT1] (battery present)
Jul 24 16:39:42 tosh kernel: ACPI: Battery Slot [BAT2] (battery absent)
Jul 24 16:39:42 tosh kernel: ACPI: Power Button (FF) [PWRF]
Jul 24 16:39:42 tosh kernel: ACPI: Lid Switch [LID]
Jul 24 16:39:42 tosh kernel: i2c-piix4 version 2.7.0 (20021208)
Jul 24 16:39:42 tosh kernel: piix4-smbus 0000:00:05.3: Found Intel Corp. 
82371AB/EB/MB PIIX4  device
Jul 24 16:39:42 tosh kernel: drivers/usb/core/usb.c: registered new driver 
usbfs
Jul 24 16:39:42 tosh kernel: drivers/usb/core/usb.c: registered new driver hub
Jul 24 16:39:42 tosh kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host 
Controller Interface driver v2.1
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1cd08]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:05.2
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin D of device 
0000:00:05.2
Jul 24 16:39:42 tosh kernel: uhci-hcd 0000:00:05.2: root hub device address 1
Jul 24 16:39:42 tosh kernel: usb usb1: new device strings: Mfr=3, Product=2, 
SerialNumber=1
Jul 24 16:39:42 tosh kernel: usb usb1: Product: Intel Corp. 82371AB/EB/MB 
PIIX4
Jul 24 16:39:42 tosh kernel: usb usb1: Manufacturer: Linux 2.6.0-test1 
uhci-hcd
Jul 24 16:39:42 tosh kernel: usb usb1: SerialNumber: 0000:00:05.2
Jul 24 16:39:42 tosh kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 24 16:39:42 tosh kernel: usb usb1: usb_new_device - registering interface 
1-0:0
Jul 24 16:39:42 tosh kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 24 16:39:42 tosh kernel: hub 1-0:0: usb_device_probe
Jul 24 16:39:42 tosh kernel: hub 1-0:0: usb_device_probe - got id
Jul 24 16:39:42 tosh kernel: hub 1-0:0: USB hub found
Jul 24 16:39:42 tosh kernel: hub 1-0:0: 2 ports detected
Jul 24 16:39:42 tosh kernel: hub 1-0:0: standalone hub
Jul 24 16:39:42 tosh kernel: hub 1-0:0: ganged power switching
Jul 24 16:39:42 tosh kernel: hub 1-0:0: global over-current protection
Jul 24 16:39:42 tosh kernel: hub 1-0:0: Port indicators are not supported
Jul 24 16:39:42 tosh kernel: hub 1-0:0: power on to power good time: 2ms
Jul 24 16:39:42 tosh kernel: hub 1-0:0: hub controller current requirement: 
0mA
Jul 24 16:39:42 tosh kernel: hub 1-0:0: local power source is good
Jul 24 16:39:42 tosh kernel: hub 1-0:0: no over-current condition exists
Jul 24 16:39:42 tosh kernel: hub 1-0:0: enabling power on all ports
Jul 24 16:39:42 tosh kernel: loop: loaded (max 8 devices)
Jul 24 16:39:42 tosh kernel: Toshiba System Managment Mode driver v1.11 
26/9/2001
Jul 24 16:39:42 tosh kernel: Linux Kernel Card Services 3.1.22
Jul 24 16:39:42 tosh kernel:   options:  [pci] [cardbus] [pm]
Jul 24 16:39:42 tosh kernel: PCI: Enabling device 0000:00:0b.0 (0000 -> 0002)
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1dda8]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:0b.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:00:0b.0 - using IRQ 255
Jul 24 16:39:42 tosh kernel: Yenta IRQ list 04b0, PCI irq0
Jul 24 16:39:42 tosh kernel: Socket status: 30000020
Jul 24 16:39:42 tosh kernel: PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1d7a8]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:0b.1
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin B of device 
0000:00:0b.1 - using IRQ 255
Jul 24 16:39:42 tosh kernel: Yenta IRQ list 04b0, PCI irq0
Jul 24 16:39:42 tosh kernel: Socket status: 30000011
Jul 24 16:39:42 tosh kernel: xircom_tulip_cb.c derived from tulip.c:v0.91 
4/14/99 becker-H7y4myexbJEAvxtiuMwx3w@public.gmane.org
Jul 24 16:39:42 tosh kernel:  unofficial 2.4.x kernel port, version 
0.91+LK1.1, October 11, 2001
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1cd08]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:0c.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:00:0c.0
Jul 24 16:39:42 tosh kernel: ymfpci: YMF744 at 0xefff8000 IRQ 11
Jul 24 16:39:42 tosh kernel: ac97_codec: AC97 Audio codec, id: AKM5 (Unknown)
Jul 24 16:39:42 tosh kernel: irda_init()
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1d2c8]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:00:09.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:00:09.0
Jul 24 16:39:42 tosh kernel: IrDA: Registered device irda0
Jul 24 16:39:42 tosh kernel: ToshOboe: Using single tasks, version $Id: 
toshoboe.c,v 1.91 1999/06/29 14:21:06 root Exp $
Jul 24 16:39:42 tosh kernel: IrCOMM protocol (Dag Brattli)
Jul 24 16:39:42 tosh kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Jul 24 16:39:42 tosh kernel: PPP generic driver version 2.4.2
Jul 24 16:39:42 tosh kernel: PPP Deflate Compression module registered
Jul 24 16:39:42 tosh kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
Jul 24 16:39:42 tosh kernel: acpi_bus-0075 [21] acpi_bus_get_device   : Error 
getting context for object [d7f1dda8]
Jul 24 16:39:42 tosh kernel: pci_link-0485 [20] acpi_pci_link_get_irq : 
Invalid link device
Jul 24 16:39:42 tosh kernel:  pci_irq-0254 [19] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
Jul 24 16:39:42 tosh kernel:  pci_irq-0294 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 0000:02:00.0
Jul 24 16:39:42 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
0000:02:00.0
Jul 24 16:39:42 tosh kernel: PCI: Setting latency timer of device 0000:02:00.0 
to 64
Jul 24 16:39:42 tosh kernel: eth0: Xircom Cardbus Adapter rev 3 at 0x1000, 
00:10:A4:AD:16:83, IRQ 0.
Jul 24 16:39:42 tosh kernel: eth0:  MII transceiver #0 config 3100 status 7809 
advertising 01e1.
Jul 24 16:39:42 tosh kernel: i2c /dev entries driver module version 2.7.0 
(20021208)
Jul 24 16:39:42 tosh kernel: drivers/usb/core/usb.c: registered new driver 
usbscanner
Jul 24 16:39:42 tosh kernel: drivers/usb/image/scanner.c: 0.4.13:USB Scanner 
Driver
Jul 24 16:39:42 tosh kernel: drivers/usb/serial/usb-serial.c: USB Serial 
support registered for Generic
Jul 24 16:39:42 tosh kernel: drivers/usb/core/usb.c: registered new driver 
usbserial



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
