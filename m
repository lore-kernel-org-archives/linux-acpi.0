From: "Shawn P. Garbett" <listman-qZIqNUI/gJRAfugRpC6u6w@public.gmane.org>
Subject: P2120 ACPI 2.5.64bk7
Date: Thu, 13 Mar 2003 09:04:03 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303130904.03589.listman@garbett.org>
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
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I've just gotten a P2120 because I'm a big fan of long battery life and power 
management. I was disappointed when I discovered it was ACPI and not the 
kinda working APM. In the long run it's probably better to have ACPI, so I'm 
okay with this.

I installed the 2.5.64bk7 kernel to see what the current progress is. I'm 
willing to test whatever, code and contribute if someone wants to tell me 
what needs to be done. I have years and years of C experience and have done 
embedded work. I just don't want to work on something that someone else is 
already doing (wasting effort).

The S3 ACPI shutdown appears to work, but is unwakeable. At somepoint, I think 
with the vanilla 2.5.64 kernel it worked once, I just had to hit Ctrl-Alt-F1, 
Ctrl-Alt-F7 to get the display back.

The S4 ACPI shutdown has the "enter refrigerator" messages, followed by the 
following:
  stopping tasks failed (1 tasks remaining)
Suspend failed: Not all processes stopped!
Restarting tasks...<6> Strange, eth0 not stopped
 done
Then the "left refrigerator" messages follow.

So I tried "ifdown eth0; rmmod 8139too" before trying a S4 shutdown. Then 
after the "enter refrigerator" messages, it says:
Freeing memory, (display flickers), writing to swap, (display off). I can then 
start it back up with a "resume=/dev/hda5" (my swap partition). I have an 
"a0" hibernate partition, but it doesn't find or use this.

Same behavior from an S4b shutdown.

Is it just unfinished work in the 8139too kernel driver? Should I contact that 
person and see about helping? Is there something I can do to debug and 
provide useful feedback about the S3 hang? Is the "a0" parition no longer 
used for suspend to disk?

Here's my dmesg at startup for the curious:

Linux version 2.5.64-bk7 (root@sputnik) (gcc version 3.2.3 20030228 (Debian 
prerelease)) #1 Wed Mar 12 21:19:54 CST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001efe0000 (usable)
 BIOS-e820: 000000001efe0000 - 000000001efefc00 (ACPI data)
 BIOS-e820: 000000001efefc00 - 000000001eff0000 (ACPI NVS)
 BIOS-e820: 000000001eff0000 - 000000001f100000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126944
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 122848 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 FUJ                        ) @ 0x000f6f70
ACPI: RSDT (v001 FUJ    PAULING3 00261.00000) @ 0x1efec539
ACPI: FADT (v001 FUJ    PAULING3 00261.00000) @ 0x1efefa92
ACPI: SSDT (v001 PTLTD  ACPIPST1 00000.00001) @ 0x1efefb06
ACPI: DSDT (v001 FUJ    PAULING3 00261.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=303
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 924.773 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1765.37 BogoMIPS
Memory: 499044k/507776k available (1936k kernel code, 7936k reserved, 609k 
data, 140k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 933 MHz
CPU: Code Morphing Software revision 4.3.2-9-566
CPU: 20030108 13:03 official release 28.0.3-4.3.2#1
CPU serial number disabled.
CPU:     After generic, caps: 0080893f 0081813f 00000000 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd89e, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:........................................................................................................................................................
Table [DSDT] - 548 Objects with 47 Devices 152 Methods 24 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c03b161c
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 8 registers at 
000000000000FF18
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE63
Executing all Device _STA and_INI 
methods:...............................................
47 Devices found containing: 47 _STA, 7 _INI methods
Completing Region/Field/Buffer/Package 
initialization:.............................................................
Initialized 10/24 Regions 0/0 Fields 23/23 Buffers 28/28 Packages (551 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 0)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7 9 10 *11)
ACPI: Power Resource [USBP] (on)
Linux Plug and Play Support v0.95 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
 pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 
00:0f.0
ACPI: No IRQ known for interrupt pin A of device 00:0f.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Enabling SEP on CPU 0
Journalled Block Device driver loaded
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [CMB1] (battery present)
ACPI: Battery Slot [CMB2] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:0f.0
 pci_irq-0295 [22] acpi_pci_irq_derive   : Unable to derive IRQ for device 
00:0f.0
ACPI: No IRQ known for interrupt pin A of device 00:0f.0
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK4018GAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=77520/16/63, UDMA(66)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Yenta IRQ list 0cf8, PCI irq9
Socket status: 30000006
Intel PCIC probe: not found.
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 
2003 UTC).
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (3967 buckets, 31736 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S3 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
Unable to find swap-space signature
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Real Time Clock Driver v1.11
Adding 506008k swap on /dev/hda5. Priority:-1 extents:1
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xdf842800, 00:e0:00:fb:7b:49, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 
45e1.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
