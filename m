From: Jerome Poggi <Jerome.Poggi-5fwdxd2ikk8@public.gmane.org>
Subject: AE_ALREADY_EXISTS bug still here
Date: Sat, 3 Apr 2004 20:45:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040403184522.GE6617@efflam>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I get one bug :

Apr  3 20:12:03 efflam ACPI-0279: *** Error: Looking up [BUFF] in namespace, AE_ALREADY_EXISTS
Apr  3 20:12:03 efflam ACPI-1133: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c12d0f60), AE_ALREADY_EXISTS

But i had the last kernel version and the last ACPI patch :

root-mvppoxjXWBo@public.gmane.org:/proc # cat version 
Linux version 2.6.4-hardened-r3 (root-mvppoxjXWBo@public.gmane.org) (gcc version 3.3.3 20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)) #5 Fri Apr 2 15:32:48 CEST 2004

root-mvppoxjXWBo@public.gmane.org:/proc/acpi # cat info 
version:                 20040326

# biosdecode 2.3
ACPI 1.0 present.
        OEM Identifier: TOSHIB
        RSD Table 32-bit Address: 0x0FF60000
PCI Interrupt Routing 1.0 present.
        Router ID: 00:1f.0
        Exclusive IRQs: None
        Compatible Router: 8086:122e
        Slot Entry 1: ID 00:1f, on-board
        Slot Entry 2: ID 02:07, on-board
        Slot Entry 3: ID 02:0d, on-board
        Slot Entry 4: ID 02:08, on-board
        Slot Entry 5: ID 01:00, on-board
        Slot Entry 6: ID 02:0c, on-board
        Slot Entry 7: ID 02:0a, slot number 1
        Slot Entry 8: ID 02:0b, slot number 2
        Slot Entry 9: ID 02:01, slot number 3
BIOS32 Service Directory present.
        Revision: 0
        Calling Interface Address: 0x000FC34A
SMBIOS 2.3 present.
        Structure Table Length: 1380 bytes
        Structure Table Address: 0x000EC000
        Number Of Structures: 43
        Maximum Structure Size: 92 bytes
SYSID present.
        Revision: 0
        Structure Table Address: 0x000F03A0
        Number Of Structures: 1
PNP BIOS 1.0 present.
        Event Notification: Polling
        Event Notification Flag Address: 0x00000510
        Real Mode 16-bit Code Address: F000:914B
        Real Mode 16-bit Data Address: 0000:0000
        16-bit Protected Mode Code Address: 0x000F9168
        16-bit Protected Mode Data Address: 0x00000000
        OEM Device Identifier: TOS3500

/proc/acpi/battery/BAT2/alarm
alarm:                   64 mAh
---
/proc/acpi/battery/BAT2/state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            810 mA
remaining capacity:      2283 mAh
present voltage:         10930 mV
---
/proc/acpi/battery/BAT2/info
present:                 yes
design capacity:         3400 mAh
last full capacity:      3168 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 64 mAh
design capacity low:     0 mAh
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            P71022002112
serial number:           1000172838
battery type:            Li-ION  
OEM info:                
---
/proc/acpi/battery/BAT1/alarm
alarm:                   68 mAh
---
/proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            786 mA
remaining capacity:      3400 mAh
present voltage:         11270 mV
---
/proc/acpi/battery/BAT1/info
present:                 yes
design capacity:         3600 mAh
last full capacity:      3400 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 68 mAh
design capacity low:     0 mAh
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            XM2030P02   
serial number:           1000010554
battery type:            Li-ION  
OEM info:                
---

My dmesg and DSDT are in attached piece.

Jerome.


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.4-hardened-r3 (root-mvppoxjXWBo@public.gmane.org) (gcc version 3.3.3 20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)) #5 Fri Apr 2 15:32:48 CEST 2004
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000ff60000 (usable)
BIOS-e820: 000000000ff60000 - 000000000ff70000 (ACPI data)
BIOS-e820: 000000000ff70000 - 0000000010000000 (reserved)
BIOS-e820: 00000000feea0000 - 00000000feec0000 (reserved)
BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65376
DMA zone: 4096 pages, LIFO batch:1
Normal zone: 61280 pages, LIFO batch:14
HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f01b0
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ff60000
ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ff60054
ACPI: DSDT (v001 TOSHIB 8200     0x20001220 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux264 ro root=305 pmdisk=/dev/hda1 resume=/dev/hda1 pci=noacpi pci=usepirqmask
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 847.620 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 254056k/261504k available (2939k kernel code, 6724k reserved, 371k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1679.36 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f1ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda51, last bus=14
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PCIB.MPC0._PRW] (Node c12d4e20), AE_NOT_EXIST
ACPI-0154: *** Error: Method execution failed [\_SB_.PCI0.PCIB.MPC0._PRW] (Node c12d4e20), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node cff5e820), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKB._STA] (Node cff5e920), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKC._STA] (Node cff4c5a0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKD._STA] (Node cff4c4a0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKE._STA] (Node cff4c3a0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.LNKH._STA] (Node cff4c2a0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node c12d3ae0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.COM_._STA] (Node c12d39a0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FSIR._STA] (Node c12d2820), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node c12d26e0), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node c12d2600), AE_NOT_EXIST
ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node c12d2500), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: Power Resource [PIHD] (on)
ACPI: Power Resource [PMHD] (off)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX/ICH [8086/244c] at 0000:00:1f.0
PCI: Found IRQ 11 for device 0000:02:0c.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:0d.0
PCI: Found IRQ 11 for device 0000:02:0d.1
PCI: Sharing IRQ 11 with 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:02:07.0
vesafb: framebuffer at 0xfc000000, mapped to 0xd0809000, size 16384k
vesafb: mode is 1024x768x8, linelength=1024, pages=20
vesafb: protected mode interface info at c000:76ee
vesafb: scrolling: redraw
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
ikconfig 0.7 with /proc/config*
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.6 [Flags: R/W].
udf: registering filesystem
Initializing Cryptographic API
Console: switching to colour frame buffer device 128x48
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset, but could not find the secondary device.
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf0000000
[drm] Initialized i810 1.4.0 20030605 on minor 0
[drm] Initialized i830 1.3.2 20021108 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 0000:00:1f.6
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
PCI: Found IRQ 11 for device 0000:02:08.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:00:39:D1:D0:2E, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
e100: Intel(R) PRO/100 Network Driver, 3.0.16
e100: Copyright(c) 1999-2004 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2M: IDE controller at PCI slot 0000:00:1f.1
ICH2M: chipset revision 3
ICH2M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xcff0-0xcff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcff8-0xcfff, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK2016GAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB), CHS=38760/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 p12 p13 >
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2043 buckets, 16344 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Resume Machine: resuming from /dev/hda1
Resuming from device hda1
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S4bios S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 252): journal_recover: JBD: recovery, exit status 0, recovered transactions 95361 to 95388
(fs/jbd/recovery.c, 254): journal_recover: JBD: Replayed 183 and revoked 4/8 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 164k freed
Adding 257000k swap on /dev/hda1.  Priority:-1 extents:1
Unable to find swap-space signature
EXT3 FS on hda5, internal journal
loop: loaded (max 8 devices)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda6) for (hda6)
reiserfs: replayed 14 transactions in 1 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda8) for (hda8)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda9) for (hda9)
reiserfs: replayed 25 transactions in 1 seconds
Using r5 hash to sort names
Removing [1945 24914 0x0 SD]..done
Removing [1945 24913 0x0 SD]..done
Removing [1945 24912 0x0 SD]..done
There were 3 uncompleted unlinks/truncates. Completed
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda10) for (hda10)
reiserfs: replayed 2 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda11) for (hda11)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda12) for (hda12)
Using r5 hash to sort names
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Unable to find swap-space signature
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Databook TCIC-2 PCMCIA probe: not found.
PCI: Enabling device 0000:02:0c.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 0000:02:0c.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:0d.0
Yenta: CardBus bridge found at 0000:02:0c.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000011
PCI: Enabling device 0000:02:0d.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 0000:02:0d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:0c.0
Yenta: CardBus bridge found at 0000:02:0d.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
PCI: Enabling device 0000:02:0d.1 (0000 -> 0002)
PCI: Found IRQ 11 for device 0000:02:0d.1
PCI: Sharing IRQ 11 with 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:02:07.0
Yenta: CardBus bridge found at 0000:02:0d.1 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
orinoco_cs.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
eth1: Station identity 001f:0001:0006:000e
eth1: Looks like a Lucent/Agere firmware version 6.14
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:11:98:15
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:02:07.0
PCI: Sharing IRQ 11 with 0000:02:0d.1
uhci_hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0000cf80
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1f.4
uhci_hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 11, io base 0000cf60
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using address 2
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
pl2303 1-1:1.0: PL-2303 converter detected
usb 1-1: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
drivers/usb/core/usb.c: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
usb 1-2: new low speed USB device using address 3
PCI: Found IRQ 11 for device 0000:02:07.0
PCI: Sharing IRQ 11 with 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:02:0d.1
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1f.2-2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
process `named' is using obsolete setsockopt SO_BSDCOMPAT
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (48 C)
ACPI: Fan [FAN] (off)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery present)
ACPI: AC Adapter [ADP1] (on-line)
Toshiba System Managment Mode driver v1.11 26/9/2001
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
prism2cs_init: prism2_cs.o: 0.2.1-pre20 Loaded
prism2cs_init: dev_info is: prism2_cs
prism2_cs: index 0x01: Vcc 3.3, irq 3, io 0x0180-0x01bf
PDA Read from 0x007f0000 in EXTDS space.
PDA Read from 0x007f0000 in EXTDS space.
ident: nic h/w: id=0x800c 1.0.0
ident: pri f/w: id=0x15 1.1.1
ident: sta f/w: id=0x1f 1.7.4
MFI:SUP:role=0x00:id=0x01:var=0x01:b/t=1/1
CFI:SUP:role=0x00:id=0x02:var=0x02:b/t=1/1
PRI:SUP:role=0x00:id=0x03:var=0x01:b/t=4/4
STA:SUP:role=0x00:id=0x04:var=0x01:b/t=1/12
PRI-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-MFI:ACT:role=0x01:id=0x01:var=0x01:b/t=1/1
Prism2 card SN: 00034033748\x0a
device wlan0 entered promiscuous mode
monitor mode enabled
device wlan0 left promiscuous mode
monitor mode disabled
dot11req_reset: the macaddress and setdefaultmib arguments are currently unsupported.
dot11req_reset: the macaddress and setdefaultmib arguments are currently unsupported.
device wlan0 entered promiscuous mode
monitor mode enabled
device wlan0 left promiscuous mode
monitor mode disabled
device wlan0 entered promiscuous mode
monitor mode enabled
eth1: New link status: Connected (0001)
device wlan0 left promiscuous mode
monitor mode disabled
hfa384x_docmd_wait: hfa384x_cmd timeout(1), reg=0xffff.
hfa384x_cmd_access: Call to hfa384x_docmd_wait failed (-110 0)
prism2sta_mlmerequest: Failed to read wlan0 statistics: error=-110
hfa384x_docmd_wait: hfa384x_cmd timeout(1), reg=0xffff.
hfa384x_cmd_access: Call to hfa384x_docmd_wait failed (-110 0)
prism2sta_mlmerequest: Failed to read wlan0 statistics: error=-110
hfa384x_docmd_wait: hfa384x_cmd timeout(1), reg=0xffff.
dev_mc_discard: multicast leakage! dmi_users=3
hfa384x_docmd_wait: hfa384x_cmd timeout(1), reg=0xffff.
prism2_cs.o: 0.2.1-pre20 Unloaded
p80211.o: 0.2.1-pre20 Unloaded
grsec: mount /dev/loop0 to /home/poggi/Mail/crypted by /bin/mount[mount:12196] uid/euid:1000/0 gid/egid:1000/1000, parent /home/poggi/bin/fetchmail[fetchmail:29254] uid/euid:1000/1000 gid/egid:1000/1000
grsec: mount /dev/loop1 to /home/poggi/Mail/clients by /bin/mount[mount:22226] uid/euid:1000/0 gid/egid:1000/1000, parent /home/poggi/bin/fetchmail[fetchmail:8931] uid/euid:1000/1000 gid/egid:1000/1000
grsec: mount /dev/loop2 to /home/poggi/clients by /bin/mount[mount:25007] uid/euid:1000/0 gid/egid:1000/1000, parent /home/poggi/bin/fetchmail[fetchmail:7248] uid/euid:1000/1000 gid/egid:1000/1000
eth1: New link status: AP Out of Range (0004)
eth1: New link status: AP In Range (0005)
eth1: New link status: Disconnected (0002)
eth1: New link status: Connected (0001)
ttyUSB0: 1 input overrun(s)
usb 1-2: USB disconnect, address 3
usb 1-2: new low speed USB device using address 4
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1f.2-2
usb 1-1: USB disconnect, address 2
pl2303 1-1:1.0: device disconnected
PL-2303 ttyUSB0: PL-2303 converter now disconnected from ttyUSB0
usb 1-1: new full speed USB device using address 5
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: LEXAR     Model: JUMPDRIVE         Rev: 1.20
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 5
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
grsec: mount /dev/sda1 to /mnt/usbdsk by /bin/mount[mount:20214] uid/euid:1000/0 gid/egid:1000/1000, parent /bin/bash[bash:12515] uid/euid:1000/1000 gid/egid:1000/1000
VFS: Can't find ext2 filesystem on dev loop3.
grsec: mount /dev/loop3 to /home/poggi/perso by /bin/mount[mount:18734] uid/euid:1000/0 gid/egid:1000/1000, parent /bin/bash[bash:8954] uid/euid:1000/1000 gid/egid:1000/1000
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
grsec: unmount of /dev/sda1 by /bin/umount[umount:5716] uid/euid:1000/0 gid/egid:1000/1000, parent /bin/bash[sh:10709] uid/euid:1000/1000 gid/egid:1000/1000
usb 1-1: USB disconnect, address 5
    ACPI-0279: *** Error: Looking up [BUFF] in namespace, AE_ALREADY_EXISTS
    ACPI-1133: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c12d0f60), AE_ALREADY_EXISTS

--Yylu36WmvOXNoKYn
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="dsdt.gz"
Content-Transfer-Encoding: base64

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
iFVnJi1fpEZNluWZgBBSUVOyLM90TYbG5OwUcVRrqIgh+dOQLMsz6RRwuRPs3SMCQSMqdUGb
U8s/sscxWZZnslYRGbI2jamyPJOVe8TErMlDRjtM+gpu1WOyLM9kfVUyiGfSiet0zk82Md3W
A5isx8og0/qsNoAo22iyfis5D5shImNcJi+e6bkkyvJM1qjD0/TmHDdRe9GKmyoKc4vpYtO8
V5ZnQiFuMWZ2Qv44NWUb4iYm7aPW4rSvKMszeauVmzoOWIv5zpP30Onp42i1GCs74Xg1hYJk
4stkJWD92UFZnkcRrF6Qd3Bak2zHhk8Jlm1DoxQcKy7LM1uTmeQDsxWFo4wxW0uZ/i5Vlme2
cVT6s4OyPI8yUphEpllnshPxzTYpRUbCzTYDxQBi/YFq5tYjKKdnS5PJ9Zl97XSZEj5bnyHP
BJQmM5toLg7K8szYEJgz3Hvq6oyNhBn3fVCWZ/YKgOp9tyzPjIyICm9WQYi8afbKASMV2Q4d
WlG5MoNYW7CM4Kf04dl7U/X0vTv1ggAe4bAsz+y9qgIJtvS8QgMuWOYQgcuWGVQgleg8F0os
n7FpVaID602KInxpBQEMoUSHtqkRdsryzNbVDFhQjN6n2M25Scl0s03/UZRrS5u5wWRE/kiD
yRICR2V5clmWZ9aZJQfhFHObKtoxW1PuVWfabG2d0kI3a01GDmbVl1iWZ7YGUkWNPSzaMVu7
qToW+l0n4uwrbEWhcbZajZrDTlme2aeUqHlo46vY17aiFk/Ru2TVJFH1LDVNqw5dJkrbzxfO
klP1VwdIMXW2WpOfbjKwfrbZ72LK3qhsJm11KzBtb3s+w97zC/tleWbvuj53sHIHx8eJtkWr
3g/K8mDhyJqSFf+Zkjt8OtrhkA1aMVwK8fOS3OGL2+F89lmntOLVC97h1h2t6MDbnBVGkLea
zx1rlFZz2CnLM3tftpqHzfngmdiKZGYuKN/jqiNkwdcm0EQXn7IgprpkUBrMufmgLM9ir1WI
O3yx9Yz1wKj2VuSjC7Kfq4G9AZ0wvSDTucT1Yu9qEN0T1nDRLYFWG4Lo5ndQlmfxaomf405Z
nsVrJwIFXjtxSEAp9QwBzRLFJJznQbt68YGO20+iAukz505Irl6QV4KBIXRovUaiIl2WZ/H6
TDzAFq+tqAGtM4PR690YCrUoFkKeTgvyc0TpY/HqjJwRvgqLdw7SYfSsnlCWJ3dleRarnsg6
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

--Yylu36WmvOXNoKYn--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
