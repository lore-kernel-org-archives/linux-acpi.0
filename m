From: Abheek Anand <abheek-VX+DGZyGJwM3uPMLIKxrzw@public.gmane.org>
Subject: presario 1505us battery not found
Date: Thu, 24 Apr 2003 15:49:43 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030424194943.GB25389@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,

After quite a bit of tinkering with my presario 1505us, I managed to get most
of what I need up and working. Currently im using linux 2.5.67 with
acpi-20030328. I am able to get ac-adaptor information, and the LID works
fine. However, I am unable to get acpi to recognize my battery, which it
always shows as absent. I have looked at several people's suggestions on this
on the mailing list, but none of them work for me.

I'm including a copy of the dmesg messages my system spews out. I also did the
usual dsdt disassemble, fix, and include in kernel routine. I have put up my
original (and fixed) dsdt on http://www.cs.umd.edu/~abheek/acpi . My
/proc/acpi/battery/BAT1 entries show the battery as absent.

Any help would be _very_ appreciated.

Thanks,
Abheek


----- dmesg <snip> ----

Linux version 2.5.67 (root-c5qLw1b7B3dFcdTHL1IdjYdd74u8MsAO@public.gmane.org) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #6 Thu Apr 24 13:45:50 EDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
 BIOS-e820: 000000000ffd0000 - 000000000fff0c00 (reserved)
 BIOS-e820: 000000000fff0c00 - 000000000fffc000 (ACPI NVS)
 BIOS-e820: 000000000fffc000 - 0000000010000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65488
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61392 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  09478.00544) @ 0x0fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  00000.00002) @ 0x0fff0c00
ACPI: SSDT (v001 COMPAQ CPQCrP4C 00000.04097) @ 0x0fff6637
ACPI: DSDT (v001 COMPAQ  EVON800 00001.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3 hdc=ide-scsi pci=noacpi
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1594.399 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3145.72 BogoMIPS
Memory: 254948k/261952k available (2392k kernel code, 6292k reserved, 963k data, 132k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: BIOS32 entry (0xc00f0000) in high memory, cannot use.
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030328
   tbget-0292: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...................................................................................................................................................................................................................................................
Table [DSDT] - 784 Objects with 88 Devices 243 Methods 24 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c04795dc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at 0000000000001028 on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to GPE 0x0F
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0B as GPE number 0x0B
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at 000000000000102C on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x10 to GPE 0x1F
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L11 as GPE number 0x11
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L13 as GPE number 0x13
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L14 as GPE number 0x14
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L15 as GPE number 0x15
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L17 as GPE number 0x17
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L18 as GPE number 0x18
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L1C as GPE number 0x1C
Executing all Device _STA and_INI methods:...evrgnini-0261: *** Error: Could not install pci_config handler for C03B, AE_ALREADY_EXISTS
....evrgnini-0261: *** Error: Could not install pci_config handler for C03B, AE_ALREADY_EXISTS
....................evregion-0254 [22] ev_address_space_dispa: no handler for region(cff6d3a8) [EmbeddedControl]
 exfldio-0235 [21] ex_access_region      : Region EmbeddedControl(3) has no handler
evregion-0254 [22] ev_address_space_dispa: no handler for region(cff6d3a8) [EmbeddedControl]
 exfldio-0235 [21] ex_access_region      : Region EmbeddedControl(3) has no handler
 psparse-1121: *** Error: Method execution failed [\_SB_.C03B.C04E.C0CF.C0D3] (Node cff6c728), AE_NOT_EXIST
 psparse-1121: *** Error: Method execution failed [\_SB_.C03B.C04E.C0CF._INI] (Node cff696a8), AE_NOT_EXIST
  nsinit-0397 [06] ns_init_one_device    : \_SB_.C03B.C04E.C0CF._INI failed: AE_NOT_EXIST
.........................................evrgnini-0261: *** Error: Could not install pci_config handler for C03B, AE_ALREADY_EXISTS
.......................
91 Devices found containing: 91 _STA, 4 _INI methods
Completing Region/Field/Buffer/Package initialization:.................................................................................................
Initialized 14/24 Regions 0/0 Fields 25/26 Buffers 58/67 Packages (835 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C03B] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.C03B._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03B.C03C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03B.C04D._PRT]
ACPI: Embedded Controller [C0CF] (gpe 29)
ACPI: Power Resource [C142] (off)
ACPI: Power Resource [C156] (off)
ACPI: Power Resource [C15A] (off)
ACPI: Power Resource [C15E] (off)
ACPI: Power Resource [C167] (on)
ACPI: PCI Interrupt Link [C0B5] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B6] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0B7] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B9] (IRQs 5 *10 11)
pci_link-0110 [25] acpi_pci_link_check_po: Blank IRQ resource
ACPI: PCI Interrupt Link [C0BA] (IRQs, disabled)
pci_link-0110 [26] acpi_pci_link_check_po: Blank IRQ resource
ACPI: PCI Interrupt Link [C0BB] (IRQs, disabled)
pci_link-0110 [27] acpi_pci_link_check_po: Blank IRQ resource
ACPI: PCI Interrupt Link [C0BC] (IRQs, disabled)
ACPI: Power Resource [C0CE] (on)
ACPI: Power Resource [C1D3] (off)
ACPI: Power Resource [C1D4] (off)
ACPI: Power Resource [C1D5] (off)
ACPI: Power Resource [C1D6] (off)
ACPI: Power Resource [C1E1] (off)
ACPI: Power Resource [C1E2] (off)
ACPI: Power Resource [C1E3] (off)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f2e20
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x2e4e, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
udf: registering filesystem
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery absent)   
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [C1D7] (off)
ACPI: Fan [C1D8] (off)
ACPI: Fan [C1D9] (off)
ACPI: Fan [C1DA] (off)
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
[ACPI Debug] Integer: 0000000000000E62
[ACPI Debug] Integer: 0000000000000DFE
[ACPI Debug] Integer: 0000000000000D9A
[ACPI Debug] Integer: 0000000000000D36
[ACPI Debug] Integer: 0000000000000CD2
ACPI: Thermal Zone [TZ1] (32 C)
[ACPI Debug] Integer: 0000000000000DFE
[ACPI Debug] Integer: 0000000000000D68
[ACPI Debug] Integer: 0000000000000D04
[ACPI Debug] Integer: 0000000000000CA0
ACPI: Thermal Zone [TZ2] (28 C)
[ACPI Debug] Integer: 0000000000000CD2
ACPI: Thermal Zone [TZ3] (27 C)

----- </snip> ------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
