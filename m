From: =?iso-8859-1?q?Praveen=20C?= <cpravn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi on r40e
Date: Mon, 16 Feb 2004 14:03:59 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040216140359.34210.qmail@web14526.mail.yahoo.com>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6C4@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB6C4-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>   I just want to add my experience on T21 for hot key issue .
> The hot key FN+Home (End) is for brightness control on T21. 
> It do work with ACPI without any Linux ACPI code, which is expected 
> to support hot key feature.
>   To identify the problem you may have, could you send out
> /proc/interrupts
> befroe and after pressing hot-key. I want to see whether this is 
> interrupt or event releated problem.
>   I suspect something is wrong with triggering SMI# or SCI#  on r40e.
> 
> (Full boot log is appreciated!)
> 
> --Luming 

If I boot with acpi=off, the hotkeys work. I can see the keypress by
watch'ing /dev/nvram. But with acpi, the keys dont work and nothing is
registered in /dev/nvram when any of the hotkeys are pressed. 

However the power button is recognized by acpi and I can use it to shut
down properly.

Here is the /proc/interrupts

Before a keypress
           CPU0
  0:     279592          XT-PIC  timer
  1:        305          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 11:          1          XT-PIC  ALI 5451, ohci_hcd, yenta, eth0
 12:        797          XT-PIC  i8042
 14:       2549          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0
ERR:          0

After a key press

           CPU0
  0:     291455          XT-PIC  timer
  1:        463          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 11:          1          XT-PIC  ALI 5451, ohci_hcd, yenta, eth0
 12:        797          XT-PIC  i8042
 14:       2555          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0
ERR:          0

My dmesg is below (with acpi)

Linux version 2.6.1 (root-AOiGnv2RGtY@public.gmane.org) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r1, propolice)) #1 Thu Jan 29 12:57:27 IST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ef70000 (usable)
 BIOS-e820: 000000000ef70000 - 000000000ef7b000 (ACPI data)
 BIOS-e820: 000000000ef7b000 - 000000000ef7d000 (ACPI NVS)
 BIOS-e820: 000000000ef80000 - 000000000f000000 (reserved)
 BIOS-e820: 000000001ef80000 - 000000001f000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
239MB LOWMEM available.
On node 0 totalpages: 61296
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57200 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v002 IBM                                       ) @
0x000f6d90
ACPI: XSDT (v001 IBM    TP-1S    0x00001230  LTP 0x00000000) @
0x0ef74a3b
ACPI: FADT (v003 IBM    TP-1S    0x00001230 IBM  0x00000001) @
0x0ef74b00
ACPI: SSDT (v001 IBM    TP-1S    0x00001230 MSFT 0x0100000e) @
0x0ef74cb4
ACPI: ECDT (v001 IBM    TP-1S    0x00001230 IBM  0x00000001) @
0x0ef7ae89
ACPI: BOOT (v001 IBM    TP-1S    0x00001230  LTP 0x00000001) @
0x0ef7afd8
ACPI: DSDT (v001 IBM    TP-1S    0x00001230 MSFT 0x0100000e) @
0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda5 vga=773
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2192.695 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 238964k/245184k available (2014k kernel code, 5508k reserved,
783k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor
mode... Ok.
Calibrating delay loop... 4308.99 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000
00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Celeron(R) CPU 2.20GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd84c, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:...............................................................................................................................................................................................................................
Table [DSDT](id F005) - 782 Objects with 44 Devices 223 Methods 10
Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c03ec39c
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 63 [_GPE] 8 regs
at 0000000000008028 on int 9
ACPI: Found ECDT
Completing Region/Field/Buffer/Package
initialization:............................................................................................................................................................................
Initialized 10/10 Regions 80/80 Fields 49/49 Buffers 33/33 Packages
(791 nodes)
Executing all Device _STA and_INI
methods:..............................................
46 Devices found containing: 46 _STA, 6 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 2)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
 pci_irq-0302 [30] acpi_pci_irq_derive   : Unable to derive IRQ for
device 0000:00:0f.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
vesafb: framebuffer at 0xf8000000, mapped to 0xcf810000, size 16384k
vesafb: mode is 1024x768x8, linelength=1024, pages=20
vesafb: protected mode interface info at c000:4f59
vesafb: scrolling: redraw
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
udf: registering filesystem
Initializing Cryptographic API
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
 pci_irq-0302 [31] acpi_pci_irq_derive   : Unable to derive IRQ for
device 0000:00:0f.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHS2020AT E, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 33000053 sectors (16896 MB)
        native  capacity is 39070080 sectors (20003 MB)
hda: 33000053 sectors (16896 MB) w/2048KiB Cache, CHS=34920/15/63,
UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
Adding 385552k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension
(NICE) ver.
 7.1.9 (11/03/03)
eth0: Broadcom BCM5901 100Base-TX found at mem e8000000, IRQ 11, node
addr 00061bda8eba
eth0: Broadcom BCM5705 Integrated Copper transceiver found
eth0: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON,
802.1Q VLAN ON, TSO ON
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:02.0: reset, control = 0x83
ohci_hcd 0000:00:02.0: irq 11, pci mem d087a000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID
0x409
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.1 ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:02.0: hcca frame #0031
ohci_hcd 0000:00:02.0: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:0c.0 [1014:0528]
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000007
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12
bcm5700: eth0 NIC Link is DOWN
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).

Thanks
praveen

=====
http://www.cpraveen.tk/

________________________________________________________________________
Yahoo! India Insurance Special: Be informed on the best policies, services, tools and more. 
Go to: http://in.insurance.yahoo.com/licspecial/index.html


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
