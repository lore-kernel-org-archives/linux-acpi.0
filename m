From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Thu, 6 Feb 2003 22:36:24 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206223624.GA12408@srcf.ucam.org>
References: <20030131173904.GA3240@poup.poupinou.org> <20030205014041.GA27937@srcf.ucam.org> <20030206205608.GV1205@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030206205608.GV1205-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2003 at 09:56:08PM +0100, Ducrot Bruno wrote:
> On Wed, Feb 05, 2003 at 01:40:41AM +0000, Matthew Garrett wrote:
> > Using this patch (on top of 2.5.59 and acpi 20030123), echo 4b 
> > >/proc/acpi/sleep results in the system freezing all of the processes 
> > and then resetting itself without any state change. This is an IBM 
> > Thinkpad 240x which claims to support S4Bios, and I have the appropriate 
> > partition. Would it be worth me enabling debugging and hooking up a 
> > serial console?
> > 
> 
> Strange.  What say dmesg?

Included dmesg is what I have after boot. FWIW, suspend to disk "works" 
under APM (system suspends, restores, dies due to failing to deal with 
IDE interrupts). There is a newer BIOS available that claims to fix some 
issues with ACPI on Windows XP, which I can try if you think it'd be 
worth it. I've no kernel output of a suspend attempt because the machine 
reboots itself immediately, but I can hook up a serial console if you'd 
like.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.5.59 (root@asparagine) (gcc version 3.2.2 20030129 (Debian prerelease)) #2 Wed Feb 5 01:52:04 GMT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bfffc00 (ACPI data)
 BIOS-e820: 000000000bfffc00 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
191MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 49136
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45040 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6c80
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0bffc972
ACPI: FADT (v001 IBM    TP240    01540.00000) @ 0x0bfffb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0bfffbd9
ACPI: DSDT (v001    PTL    BX-TJ 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=306 video=vesa resume=/dev/hda5 reboot=w
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 497.735 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 985.08 BogoMIPS
Memory: 190788k/196544k available (2134k kernel code, 5120k reserved, 659k data, 128k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
EISA bus registered
EISA: Probing bus...
EISA: Detected 0 card.
PCI: PCI BIOS revision 2.10 entry at 0xfd9df, last bus=0
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030122
    ACPI-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S1 S3 S4 S4bios S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: Embedded Controller [EC0] (gpe 25)
ACPI: Power Resource [PCR0] (off)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.94 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6d20
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xac81, dseg 0x400
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: No IRQ known for interrupt pin A of device 00:09.0 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Capability LSM initialized
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (31 C)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DARA-212000, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=23392/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 >
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Dec 17 19:01:13 2002 UTC).
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
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.07 2002-Oct-24, 1 devices found
Yenta IRQ list 0098, PCI irq11
Socket status: 30000010
Resume Machine: resuming from /dev/hda5
Resuming from device ide0(3,5)
Resume Machine: This is normal swap space
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,6): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 179955
EXT3-fs: ide0(3,6): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
Adding 409616k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Real Time Clock Driver v1.11
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
cs4281: version v1.13.32 time 01:56:51 Feb  5 2003
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:07.2: Intel Corp. 82440MX USB Universa
uhci-hcd 00:07.2: irq 11, io base 00001400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
ttyS2: LSR safety check engaged!
ttyS2: LSR safety check engaged!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x398-0x39f 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hermes.c: 4 Jul 2002 David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
orinoco.c 0.13a (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
orinoco_cs.c 0.13a (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
eth0: Station identity 001f:0004:0001:0003
eth0: Looks like an Intersil firmware version 1.3.4
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:60:B3:68:A4:47
eth0: Station name "Prism  I"
eth0: ready
eth0: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
eth0: New link status: Connected (0001)
Module cs4281 cannot be unloaded due to unsafe usage in include/linux/module.h:430

--+HP7ph2BbKc20aGI--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
