From: Luke Hammer <lukeh-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Subject: S3 works on Dell i2650, but no display
Date: Thu, 22 May 2003 22:15:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053666916.3ecdae6481b61@webmail.textlabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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



Hi all,

I've been playing around with the latest ACPI stuff (acpi-20030512-2.5.69) on my
Dell Inspiron 2650 laptop, and I seemed to be getting the same old problem when
trying to suspend into the S3 state from the console, where the machine would
hang at the text "Stopping tasks...". But on seeing a warning during compilation
about SMP, I disabled support for it and found to my delight that the machine
would immediately go into suspend. 

When I tried to resume however, I found that the console display didn't come
back on - though I knew the machine was responsive because I could type commands
and see that the hard disk was working, and I could touch files, etc. I
remembered hearing about this problem before on this list, and tried the
recommended kernel parameters "acpi_sleep=s3_bios" and "acpi_sleep=s3_mode", but
neither made any difference - I could still type commands, but no display, and
the CPU fan seemed always to be on. Switching virtual terminals and
opening/closing the lid made no difference either.

So can anyone suggest how I can get the display to resume along with everything
else? I'm ultimately wanting to resume/suspend from within X (though I'm
anticipating some hassles with the Nvidia displau driver), but I thought it
would be best to start testing on the console.


I'm attaching my boot log, including the console messages from the resume. Any
help would be appreciated.


Thanks,
Luke


----

Linux version 2.5.69 (root@testbox) (gcc version 2.96 20000731 (Red Hat Linux
7.3 2.96-110)) #2 Fri May 23 12:42:49 GMT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ef0000 (usable)
 BIOS-e820: 0000000017ef0000 - 0000000017eff000 (ACPI data)
 BIOS-e820: 0000000017eff000 - 0000000017f00000 (ACPI NVS)
 BIOS-e820: 0000000017f00000 - 0000000017f80000 (usable)
 BIOS-e820: 0000000017f80000 - 0000000018000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98176
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94080 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 DELL                       ) @ 0x000f6740
ACPI: RSDT (v001 DELL     RSDT   01540.00000) @ 0x17efadcf
ACPI: FADT (v001 INTEL  845M     01540.00000) @ 0x17efef8c
ACPI: DSDT (v001 DELL   845M     01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.5.69 ro root=303
BOOT_FILE=/boot/vmlinuz-2.5.69 acpi_sleep=s3_mode
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1695.378 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3342.33 BogoMIPS
Memory: 385480k/392704k available (1480k kernel code, 6400k reserved, 546k data,
276k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NoNET1.0 for Linux 2.6
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd9c5, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030509
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:..................................................................................................................................................
Table [DSDT](id F004) - 522 Objects with 50 Devices 146 Methods 16 Regions
ACPI Namespace successfully loaded at root c035213c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0735 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at
0000000000001028 on interrupt 9
evgpeblk-0742 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to GPE 0x0F
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L03 as GPE
number 0x03
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L04 as GPE
number 0x04
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L05 as GPE
number 0x05
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L08 as GPE
number 0x08
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L0B as GPE
number 0x0B
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L0C as GPE
number 0x0C
evgpeblk-0735 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at
000000000000102C on interrupt 9
evgpeblk-0742 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x10 to GPE 0x1F
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L1D as GPE
number 0x1D
Completing Region/Field/Buffer/Package
initialization:...................................................
Initialized 16/16 Regions 0/0 Fields 20/20 Buffers 15/15 Packages (530 nodes)
Executing all Device _STA and_INI
methods:...................................................
51 Devices found containing: 51 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: Embedded Controller [EC0] (gpe 28)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
pci_link-0349 [26] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Enabling SEP on CPU 0
Journalled Block Device driver loaded
udf: registering filesystem
 exfldio-0136 [48] ex_setup_region       : Field [ACPW] Base+Offset+Width 38+0+4
is beyond end of region [GPIO] (length 3B)
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.ACAD._PSR]
(Node c13f88a8), AE_AML_REGION_LIMIT
 acpi_ac-0097 [32] acpi_ac_get_state     : Error reading AC Adapter state
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
pty: 256 Unix98 ptys configured
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i845 chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Floppy drive(s): fd0 is 1.44M
[ACPI Debug] String: =====QUERY_05=====
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
Adding 514040k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdc, sector 0
hdc: DMA disabled
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdc, sector 0
hdc: CHECK for good STATUS
blk: queue c035ba7c, I/O limit 4095Mb (mask 0xffffffff)
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
[ACPI Debug] String: =====QUERY_05=====
Stopping tasks: 

klogd entered refrigerator
=init entered refrigerator
=pdflush entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=kseriod entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=syslogd entered refrigerator
=xinetd entered refrigerator
=crond entered refrigerator
=atd entered refrigerator
=login entered refrigerator
=mingetty entered refrigerator
=mingetty entered refrigerator
=mingetty entered refrigerator
=mingetty entered refrigerator
=mingetty entered refrigerator
=

<0>Suspending devices
Suspending device c035ba6c
Suspending devices
Suspending device c035ba6c
suspending: hda <0>Suspending devices
Suspending device c035ba6c
 hwsleep-0257 [33] acpi_enter_sleep_state: Entering sleep state [S3]
Enabling SEP on CPU 0
Back to C!
Devices Resumed
Devices Resumed
Restarting tasks... done
init left refrigerator
pdflush left refrigerator
pdflush left refrigerator
kswapd0 left refrigerator
kseriod left refrigerator
kjournald left refrigerator
kjournald left refrigerator
syslogd left refrigerator
klogd left refrigerator
xinetd left refrigerator
crond left refrigerator
atd left refrigerator
login left refrigerator
mingetty left refrigerator
mingetty left refrigerator
mingetty left refrigerator
mingetty left refrigerator
mingetty left refrigerator



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
