From: jeff <jeff-sf-bThHCuZ0d8s@public.gmane.org>
Subject: vaio 505fx: GPE9: AE_NOT_FOUND
Date: Tue, 22 Oct 2002 21:16:27 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023041627.GU7621@gage.org>
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

hi folks-

i tried out 2.5.44 on an old Sony Vaio 505fx (p-mmx 266mhz), and i'm
getting this message on console every couple seconds:

[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname: \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND 
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method

the only bios revision number i see is "phoenixbios 4.0 release 6.0, (c)
1985-1998".

setting acpi=off at boot makes the error go away, as expected.
pci=noacpi has no effect, nor does the configuration of bios pnp in either
the kernel or the bios itself. i still get this error when i modularize
everything in acpi that i can (CONFIG_ACPI_FAN, etc) and don't load
those modules.  another 2.5.44 build with the same acpi options has no
trouble on my dell latitude.

is this simply yet another bios that needs to be added to the blacklist?
unfortunately i find no bios updates via google or at what seems to be
the canonical location:
http://www.ita.sel.sony.com/support/pc/pcg505ffx/

please let me know if i can provide more info or test a patch to
address this. i'm not on the list, so a cc: would be groovy.

jeff


here's my dmesg:

Linux version 2.5.44 (root@coal) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Tue Oct 22 19:55:38 PDT 2002
Video mode to be used for restore is 303
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e9800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
 BIOS-e820: 0000000003ff0000 - 0000000003fffc00 (ACPI data)
 BIOS-e820: 0000000003fffc00 - 0000000004000000 (ACPI NVS)
 BIOS-e820: 00000000fffe9800 - 0000000100000000 (reserved)
63MB LOWMEM available.
On node 0 totalpages: 16368
  DMA zone: 4096 pages
  Normal zone: 12272 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6d50
ACPI: RSDT (v001 PTLTD    RSDT   00000.00000) @ 0x03ffcc86
ACPI: FADT (v001 SONY            00000.00000) @ 0x03fffb8c
ACPI: DSDT (v001   SONY          00000.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=304
No local APIC present or hardware disabled
Initializing CPU#0
Detected 265.271 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 524.28 BogoMIPS
Memory: 59860k/65472k available (2356k kernel code, 5224k reserved, 1660k data, 132k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Mobile Pentium MMX stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.9 (c) Adam Belay
PCI: PCI BIOS revision 2.10 entry at 0xfda04, last bus=0
PCI: Using configuration type 1
Registering system device cpu0
adding '' to cpu class interfaces
ACPI: Subsystem revision 20021002
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:........................................................................................................................
Table [DSDT] - 412 Objects with 35 Devices 120 Methods 13 Regions
ACPI Namespace successfully loaded at root c054539c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:.....................[ACPI Debug] String: BAT1 _STA
[ACPI Debug] Integer: 000000000000001F
.[ACPI Debug] String: BAT2 _STA
[ACPI Debug] Integer: 000000000000000F
.[ACPI Debug] String: COM1_STA
[ACPI Debug] Integer: 000000000000000F
.[ACPI Debug] String: IRDA_STA
[ACPI Debug] Integer: 000000000000000F
.[ACPI Debug] String: LPT_STA
[ACPI Debug] Integer: 000000000000000F
.[ACPI Debug] String: FDC_STA
[ACPI Debug] Integer: 000000000000000F
.[ACPI Debug] String: MODEM_STA
[ACPI Debug] Integer: 000000000000000F
........
35 Devices found containing: 35 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:...................................................................
Initialized 6/13 Regions 0/0 Fields 33/33 Buffers 28/28 Packages (412 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[ACPI Debug] String: BAT1 _STA
[ACPI Debug] Integer: 000000000000001F
[ACPI Debug] String: BAT1 _STA
[ACPI Debug] Integer: 000000000000001F
[ACPI Debug] String: BAT2 _STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: BAT2 _STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: COM1_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: COM1_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: IRDA_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: IRDA_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: LPT_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] Integer: 000001040000D041
[ACPI Debug] String: LPT_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: FDC_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: FDC_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: MODEM_STA
[ACPI Debug] Integer: 000000000000000F
[ACPI Debug] String: MODEM_STA
[ACPI Debug] Integer: 000000000000000F
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9, disabled)
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6dc0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xba79, dseg 0x400
pnp: 00:00: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:00: ioport range 0x370-0x371 has been reserved
pnp: 00:00: ioport range 0x8000-0x804f could not be reserved
pnp: 00:00: ioport range 0x2180-0x218f has been reserved
pnp: 00:00: ioport range 0x230-0x233 has been reserved
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Registering system device pic0
Registering system device rtc0
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 114 entries (12 bytes)
biovec pool[1]:   4 bvecs: 114 entries (48 bytes)
biovec pool[2]:  16 bvecs:  57 entries (192 bytes)
biovec pool[3]:  64 bvecs:  28 entries (768 bytes)
biovec pool[4]: 128 bvecs:  14 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   7 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
udf: registering filesystem
Capability LSM initialized
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
vesafb: framebuffer at 0xfd000000, mapped to 0xc4809000, size 1984k
vesafb: mode is 800x600x8, linelength=800, pages=3
vesafb: protected mode interface info at c000:8d50
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
block request queues:
 112 requests per read queue
 112 requests per write queue
 8 requests per batch
 enter congestion at 27
 exit congestion at 29
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK4309MAT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2: ports already in use, skipping probe
hda: host protected area => 1
hda: 8452080 sectors (4327 MB), CHS=559/240/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
drivers/mtd/maps/pcmciamtd.c: PCMCIA Flash memory card driver $Revision: 1.36 $
NFTL driver: nftlcore.c $Revision: 1.82 $, nftlmount.c $Revision: 1.25 $
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
PCI: Enabling device 00:07.2 (0000 -> 0001)
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB/EB/MB PIIX4 USB
drivers/usb/core/hcd-pci.c: irq 9, io base 0000fcc0
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
Yenta IRQ list 0c98, PCI irq9
Socket status: 30000419
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc3 (Mon Oct 14 16:41:26 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
Adding 128512k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
IrCOMM protocol (Dag Brattli)
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x807
cs: IO port probe 0x0100-0x04ff: excluding 0x140-0x147 0x170-0x177 0x220-0x237 0x320-0x327 0x378-0x37f 0x388-0x38f
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: 3Com 3c589, io 0x300, irq 3, hw_addr 00:A0:24:64:91:06
  8K FIFO split 5:3 Rx:Tx, auto xcvr
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
eth0: flipped to 10baseT
eth0: flipped to 10baseT
eth0: flipped to 10baseT
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method
[ACPI Debug] String: SCI generated
[ACPI Debug] Integer: 0000000000000082
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_SB_.PCI0.ISA_.SIO_.EC__.SCID (Node c3f9ee54)
 psparse-1155: *** Error: Method execution failed, AE_NOT_FOUND
Method pathname:  \_GPE._E09 (Node c3fa3b14)
 evevent-0798: *** Error: AE_NOT_FOUND while evaluated GPE9 method


-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
