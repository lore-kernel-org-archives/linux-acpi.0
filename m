From: Steven Michalske <hardkrash-vsIoIIaCAUzCfDggNXIi3w@public.gmane.org>
Subject: Re: interesting bug i have been fighting
Date: Tue, 23 Dec 2003 16:13:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312231613.54970.hardkrash@lunar-linux.org>
References: <3ACA40606221794F80A5670F0AF15F8401720C52@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SAL6/NELTIgFbzE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C52-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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


--Boundary-00=_SAL6/NELTIgFbzE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 23 December 2003 1:59 am, you wrote:
> >On Friday 19 December 2003 1:36 am, Steven Michalske wrote:
> >> this has existed in the 2.6 series for me test4 through release
> >>
> >> I am running an IBM thinkpad a21p
> >>
> >> when acpi events occur, power unpluged, extra keys for back light of
>
> screen
>
> >> are pressed,  my keyboard will lock up if xfree86 has been ran.
> >>
> >> ocaisonly i will get a semafor locking error from osl
> >>
> >> osl-0892 [1952] os_wait_semaphore     : Failed to acquire
> >> semaphore[cffee620| 1|0], AE_TIME
> >
> >this seems to not pertain to the keyboard locking up
> >
> >> is my latest capture of this event.
> >
> > turning on debuging of the acpi corrects the lockup issue.
> >
> >> what information can i collect for debuging this system?
>
> the full dmesg log can help us better understand you problem.


attached is the log.

--Boundary-00=_SAL6/NELTIgFbzE
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="full-dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="full-dmesg.log"

Linux version 2.6.0-beta (root-7rVE/Fg9U4Y@public.gmane.org) (gcc version 3.2.3) #4 Fri Dec 19 00:27:04 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7160
ACPI: RSDT (v001 PTLTD    RSDT   0x06041080  LTP 0x00000000) @ 0x0fff5309
ACPI: FADT (v001 IBM    TP-A21p  0x06041080  0x00000000) @ 0x0fffeb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06041080  LTP 0x00000001) @ 0x0fffebd9
ACPI: DSDT (v001 IBM    TP-A21p  0x06041080 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Lunar ro root=302
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 846.969 MHz processor.
Console: colour dummy device 80x25
Memory: 254084k/262080k available (3220k kernel code, 7268k reserved, 1095k data, 160k init, 0k highmem)
Calibrating delay loop... 1675.26 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 1092 Objects with 53 Devices 328 Methods 19 Regions
ACPI Namespace successfully loaded at root c0578a1c
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000100C on int 9
Completing Region/Field/Buffer/Package initialization:......................................................................................................................................................................
Initialized 15/19 Regions 81/81 Fields 42/42 Buffers 28/28 Packages (1100 nodes)
Executing all Device _STA and_INI methods:.................................................
49 Devices found containing: 49 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PSER] (on)
ACPI: Power Resource [PSIO] (on)
ACPI: Embedded Controller [EC] (gpe 9)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xf8000000, mapped to 0xd080f000, size 16384k
vesafb: mode is 1600x1200x24, linelength=4800, pages=1
vesafb: protected mode interface info at c000:647a
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
fb0: VESA VGA frame buffer device
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
speedstep-smi: signature:0x47534943, command:0x008200b2, event:0x00c000b3, perf_level:0x07d00000.
speedstep-smi: could not detect low and high frequencies by SMI call.
cpufreq: change to 0 MHz succeded
cpufreq: change to 4 MHz succeded
speedstep-smi: workaround worked.
cpufreq: currently at high speed setting - 850 MHz
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
udf: registering filesystem
SGI XFS for Linux with no debug enabled
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (51 C)
Console: switching to colour frame buffer device 200x75
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Generic RTC Driver v1.07
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf4000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

orinoco.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
orinoco_cs.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1850-0x1857, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1858-0x185f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJSA-232, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 62506080 sectors (32003 MB) w/1874KiB Cache, CHS=65535/15/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
Console: switching to colour frame buffer device 200x75
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 04b8, PCI irq11
Socket status: 30000006
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00001860
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
specify port
ALSA device list:
  #0: Sound Fusion CS46xx at 0xf0122000/0xf0000000, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda2) for (hda2)
reiserfs: replayed 16 transactions in 2 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 491392k swap on /dev/discs/disc0/part4.  Priority:-1 extents:1
Removing [39301 41971 0x0 SD]..done
Removing [39301 38538 0x0 SD]..done
There were 2 uncompleted unlinks/truncates. Completed
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth1: Station identity 001f:0001:0007:0034
eth1: Looks like a Lucent/Agere firmware version 7.52
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:04:AC:41
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
eth1: New link status: Connected (0001)
eth1: New link status: Connected (0001)

--Boundary-00=_SAL6/NELTIgFbzE--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
