From: aeriksson-97jfqw80gc6171pxa8y+qA@public.gmane.org
Subject: Dell Latitude 400 support?
Date: Sat, 06 Mar 2004 17:56:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040306165607.7575C3F04@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

I've got an L400 which claims to support acpi. I've been using apm
since day one, but I figured i should try out acpi to get thermal and
fan control at my fingertips. Unfortunately, I'm somewhat at a loss at
how to get there.

/proc/acpi/thermal_zone/THRM/* shows

/proc/acpi/thermal_zone/THRM/cooling_mode:<not supported>
/proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/THRM/state:state:                   ok
/proc/acpi/thermal_zone/THRM/temperature:temperature:             50 C
/proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           97 C

The temperature never leaves 50 C and what does the unsupported
cooling mode mean?

The /proc/acpi/fan/ directory is empty... 


dmesg shows:

Linux version 2.6.3 (anders-hJetzOkQQ2A@public.gmane.org) (gcc version 3.3.2 20031218 
(Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 Sat Feb 21 14:10:38 CET 
2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fffea000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 
0x000f6f60
ACPI: RSDT (v001 DELL   ATLAS II 0x20010509  LTP 0x00000000) @ 
0x0fffc8fd
ACPI: FADT (v001 DELL   Atlas II 0x20010509 PTL  0x000f4240) @ 
0x0ffffb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x20010509  LTP 0x00000001) @ 
0x0ffffbd9
ACPI: DSDT (v001    PTL    BX-TJ 0x20010509 MSFT 0x01000007) @ 
0x00000000
Built 1 zonelists
Kernel command line: ro root=/dev/hda4 mce elevator=anticipatory
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.168 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 256180k/262080k available (1617k kernel code, 5164k reserved, 
682k data, 108k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Calibrating delay loop... 1376.25 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 
00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 
00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9c5, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully 
acquired
Parsing all Control Methods:..........................................
......................................................................
..
Table [DSDT](id F004) - 392 Objects with 38 Devices 114 Methods 15 
Regions
ACPI Namespace successfully loaded at root c036a4dc
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs 
at 000000000000800C on int 9
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: 
POLL (name not of form _Lnn or _Enn)
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: 
PWRE (name not of form _Lnn or _Enn)
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: 
TMPU (name not of form _Lnn or _Enn)
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: 
TMPD (name not of form _Lnn or _Enn)
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: 
EXTE (name not of form _Lnn or _Enn)
Completing Region/Field/Buffer/Package initialization:................
..............................................
Initialized 15/15 Regions 3/3 Fields 28/28 Buffers 16/16 Packages 
(400 nodes)
Executing all Device _STA and_INI methods:...<3>ACPI breakpoint: 
Executed AML Breakpoint opcode
...[ACPI Debug] String: LNKA_STA
..................................
40 Devices found containing: 40 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[ACPI Debug] String: LNKA_STA
[ACPI Debug] String: LNKA_STA
[ACPI Debug] String: LNKA_STA
[ACPI Debug] String: LNKA_CRS
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 14 15)
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[ACPI Debug] String: LNKA_SRS
[ACPI Debug] Buffer: Length 06
[ACPI Debug] String: LNKA_STA
[ACPI Debug] String: LNKA_STA
[ACPI Debug] String: LNKA_CRS
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or 
even 'acpi=off'
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23BA-20, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, 
UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 108k freed
Adding 136544k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
input: ImPS/2 Synaptics Wheel Mouse on isa0060/serio1
speedstep-smi: signature:0x0000e980, command:0x0000e6f5, 
event:0x00000000, perf_level:0x47534943.
cpufreq: Coppermine: MSR_IA32_EBL_CR_POWERON is 0x46480020, 0x0
cpufreq: Coppermine: MSR_IA32_PLATFORM ID is 0x0, 0x485d0000
speedstep-smi: could not detect low and high frequencies by SMI call.
speedstep-lib: P3 - MSR_IA32_EBL_CR_POWERON: 0x46480020 0x0
speedstep-lib: P3 - MSR_IA32_EBL_CR_POWERON: 0x44080020 0x0
speedstep-lib: P3 - MSR_IA32_EBL_CR_POWERON: 0x46480020 0x0
speedstep-smi: workaround worked.
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
cpufreq: currently at high speed setting - 700 MHz
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing 
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Real Time Clock Driver v1.12
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xfc00. Vers LK1.1.19
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
IA-32 Microcode Update Driver: v1.13 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
microcode: CPU0 already at revision 0xc (current=0xc)
microcode: No suitable data for cpu 0
IA-32 Microcode Update Driver v1.13 unregistered
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
inserting floppy driver for 2.6.3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC
[ACPI Debug] String: Sleep Button pressed: Fn+ESC



All those 'Fn+ESC' things seems a bit odd to me....

Any and all help in getting this to work is appreciated!

/Anders



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
