From: Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org>
Subject: Another irq problem!?! irq 20: nobody cared!
Date: Wed, 3 Sep 2003 14:03:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030903140357.20282271.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I thought I give 2.6.0-test4 a chance on my Asus P3C-D dual board. 
To enable acpi I had to force acpi. So forgive me if I am doing the
wrong thing:-). I thought it could be interesting for you.

greets

Marc

           CPU0       CPU1       
  0:       5151    1337544    IO-APIC-edge  timer
  1:       1618          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          1    IO-APIC-edge  rtc
 12:         87          0    IO-APIC-edge  i8042
 14:       3371          1    IO-APIC-edge  ide0
 15:         10          1    IO-APIC-edge  ide1
 18:        396          1   IO-APIC-level  eth0
 20:      95433       4567   IO-APIC-level  acpi
NMI:          0          0 
LOC:    1342667    1342731 
ERR:          0
MIS:          0

Linux version 2.6.0-test4 (root-P1HWuhA2tG4IMPOJRkgOne1GAupnlqi7@public.gmane.org) (gcc version 3.2.3
20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #2 SMP Wed Sep 3
13:26:05 CEST 2003 Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
found SMP MP-table at 000f4820
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
On node 0 totalpages: 65532
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61436 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @
0x000f5ae0 ACPI: RSDT (v001 ASUS   P3C-D    0x30303031 MSFT 0x31313031)
@ 0x0fffc000 ACPI: FADT (v001 ASUS   P3C-D    0x30303031 MSFT
0x31313031) @ 0x0fffc100 ACPI: BOOT (v001 ASUS   P3C-D    0x30303031
MSFT 0x31313031) @ 0x0fffc040 ACPI: MADT (v001 ASUS   P3C-D   
0x30303031 MSFT 0x31313031) @ 0x0fffc080 ACPI: DSDT (v001   ASUS P3C-D  
 0x00001000 MSFT 0x0100000b) @ 0x00000000 ACPI: Local APIC address
0xfee00000 ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x1]) ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14]
polarity[0x1] trigger[0x3]) Enabling APIC mode:  Flat.  Using 1 I/O
APICs Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6.0-test4 rw root=302 enableapic
vga=0x0311 acpi=force Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 937.398 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1851.39 BogoMIPS
Memory: 254736k/262128k available (2504k kernel code, 6652k reserved,
800k data, 212k init, 0k highmem) Dentry cache hash table entries: 32768
(order: 5, 131072 bytes) Inode-cache hash table entries: 16384 (order:
4, 65536 bytes) Mount-cache hash table entries: 512 (order: 0, 4096
bytes)-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383fbff 00000000 00000000
00000000 CPU:     After vendor identify, caps: 0383fbff 00000000
00000000 00000000 CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.39 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1871.87 BogoMIPS
CPU:     After generic identify, caps: 0383fbff 00000000 00000000
00000000 CPU:     After vendor identify, caps: 0383fbff 00000000
00000000 00000000 CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3723.26 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23
not connected...TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    71
 0b 001 01  0    0    0   0   0    1    1    79
 0c 001 01  0    0    0   0   0    1    1    81
 0d 001 01  0    0    0   0   0    1    1    89
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   0   0    1    1    A1
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 937.0131 MHz.
..... host bus clock speed is 133.0875 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 8
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf0770, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired Parsing all Control
Methods:...............................................................
.......................................... Table [DSDT](id F004) - 344
Objects with 39 Devices 105 Methods 19 Regions ACPI Namespace
successfully loaded at root c0495ddc IOAPIC[0]: Set PCI routing entry
(2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1) evxfevnt-0093 [04] acpi_enable 
         : Transition to ACPI mode successful evgpeblk-0748 [06]
ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E428
on int 9 evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE]
2 regs at 000000000000E42C on int 9 Completing
Region/Field/Buffer/Package
initialization:........................................................
........ Initialized 19/19 Regions 9/9 Fields 20/20 Buffers 16/16
Packages (352 nodes) Executing all Device _STA and_INI
methods:.................................  uteval-0109: *** Error: No
object was returned from [\_SB_.PCI0.PX40.UAR2._STA] (Node cff375a8),
AE_NOT_EXIST.......
40 Devices found containing: 39 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Transparent bridge - 0000:00:1e.0
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:0a.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
SCSI subsystem initialized
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16 Mode:1
Active:1) 00:00:1f[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1
Active:1) 00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1
Active:1) 00:00:1f[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1
Active:1) 00:00:1f[D] -> 2-19 -> IRQ 19
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off' vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Starting balanced_irq
Total HugeTLB memory allocated, 0
ikconfig 0.5 with /proc/ikconfig
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Initializing Cryptographic API
Real Time Clock Driver v1.11a
hw_random hardware driver 1.0.0 loaded
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
PM: Adding info for platform:floppy0
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L020AVER07-0, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
irq 20: nobody cared!
Call Trace:
 [<c010d93b>] __report_bad_irq+0x2b/0x90
 [<c022a005>] acpi_irq+0xf/0x1a
 [<c010da26>] note_interrupt+0x66/0xa0
 [<c010dd6b>] do_IRQ+0x17b/0x1b0
 [<c010bebc>] common_interrupt+0x18/0x20
 [<c0116e44>] delay_tsc+0x14/0x20
 [<c021f174>] __delay+0x14/0x20
 [<c0294c9d>] ide_delay_50ms+0x1d/0x30
 [<c028c307>] actual_try_to_identify+0xe7/0x5b0
 [<c028c842>] try_to_identify+0x72/0x130
 [<c028cb5c>] do_probe+0x25c/0x270
 [<c028d063>] probe_hwif+0x383/0x4b0
 [<c028d1ae>] probe_hwif_init+0x1e/0x80
 [<c02a1dda>] ide_setup_pci_device+0x7a/0x90
 [<c028a43b>] piix_init_one+0x3b/0x50
 [<c045845d>] ide_scan_pcidev+0x5d/0x70
 [<c04584b6>] ide_scan_pcibus+0x46/0xd0
 [<c0458373>] probe_for_hwifs+0x13/0x20
 [<c0458388>] ide_init_builtin_drivers+0x8/0x20
 [<c04583e9>] ide_init+0x49/0x60
 [<c043ea1b>] do_initcalls+0x2b/0xa0
 [<c0138e02>] init_workqueues+0x12/0x29
 [<c01050da>] init+0x5a/0x1d0
 [<c0105080>] init+0x0/0x1d0
 [<c0109279>] kernel_thread_helper+0x5/0xc

handlers:
[<c0229ff6>] (acpi_irq+0x0/0x1a)
Disabling IRQ #20
hdc: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 40188960 sectors (20576 MB) w/1916KiB Cache, CHS=39870/16/63,
UDMA(66) /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 48X DVD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S1 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda2, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda2) for (hda2) Using r5 hash to
sort names VFS: Mounted root (reiserfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 212k freed
Adding 369484k swap on /dev/hda3.  Priority:-1 extents:1
st: Version 20030811, fixed bufsize 32768, s/g segs 256
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
3c59x: Unknown parameter `enable_wol'
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1) Using r5 hash to
sort names 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
0000:02:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd800. Vers LK1.1.19


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
