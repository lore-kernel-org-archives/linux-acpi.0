From: root-Zal4cnAChC2h6J55Ss3d3w@public.gmane.org
Subject: Fw: [Bug 2323] New: ACPI ON -> NO PPPoE/aDSL/DHCP
Date: Wed, 17 Mar 2004 22:42:16 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040317224216.5302a008.root@dune2.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


--------------------------------------------------------------
*>*>*> Begin forwarded message:

Date: Wed, 17 Mar 2004 13:24:41 -0800
From: bugme-daemon-3NddpPZAyC0@public.gmane.org
To: root-Zal4cnAChC2h6J55Ss3d3w@public.gmane.org
Subject: [Bug 2323] New: ACPI ON -> NO PPPoE/aDSL/DHCP


http://bugme.osdl.org/show_bug.cgi?id=2323

           Summary: ACPI ON -> NO PPPoE/aDSL/DHCP
    Kernel Version: 2.6.2
            Status: NEW
          Severity: blocking
             Owner: acpi_config-interrupts-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: root-Zal4cnAChC2h6J55Ss3d3w@public.gmane.org
                CC: root-Zal4cnAChC2h6J55Ss3d3w@public.gmane.org


Distribution: Slackware (Kernel 2.6.2 downloaded on Kernel.org) 
Hardware Environment: Laptop Sharp Actius MM10 (Transmeta Crusoe)

Problem Description:
I had to compile withOUT ACPI to get my PPPoE/aDSL working :/

ACPI works great by itself, but does not let my pppoe driver
(the roaring penguin) do its job properly.
It was the same way between ACPI and DHCP in kernel 2.6.0-TEST9

Workaround : With ACPI compiled IN, and booting with pci=noacpi 
i get both my eth0 working with pppoe and ACPI battery status...
but this is only a workaround.  Interrupt problem ?


Attached (taken under working pci=noacpi) :
- dmesg -s40000 output
- /proc/interrupts
- acpidmp (pmtools) output
- dmidecode
- lspci -v


---

Linux version 2.6.2 (root-xhuzP3ZZnIY@public.gmane.org) (gcc version 3.2.2) #2 SMP Mon Feb 9 18:38:07
CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
 BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000e6f0000 (usable)
 BIOS-e820: 000000000e6f0000 - 000000000e6ff000 (ACPI data)
 BIOS-e820: 000000000e6ff000 - 000000000e700000 (ACPI NVS)
 BIOS-e820: 000000000e700000 - 000000000e800000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
232MB LOWMEM available.
On node 0 totalpages: 59392
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 55296 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7420
ACPI: RSDT (v001 PTLTD  RSDT     0x06040005  LTP 0x00000000) @ 0x0e6fbdfb
ACPI: FADT (v001 TMETA  RSDT     0x06040005 PTL  0x000f4240) @ 0x0e6fef8c
ACPI: DSDT (v001 PTLTD  DSDT     0x06040005 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=6.acpi ro root=305 pci=noacpi
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 993.076 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 229168k/237568k available (3393k kernel code, 7636k reserved, 1181k
data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1949.69 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0080893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0080893f 0081813f 000000ce 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.5.0.2, 1000 MHz
CPU: Code Morphing Software revision 4.3.4-9-540
CPU: 20021104 07:53 official release 4.3.4#1
CPU:     After all inits, caps: 0080893f 0081813f 000000ce 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
per-CPU timeslice cutoff: 1461.76 usecs.
task migration cache decay timeout: 2 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0
CPUS done 0
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8ae, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs 10)
ACPI: PCI Interrupt Link [LNK3] (IRQs *5)
ACPI: PCI Interrupt Link [LNK4] (IRQs 11)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3)
ACPI: PCI Interrupt Link [LNK6] (IRQs 4)
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKA] (IRQs 9)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7 9 10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
PCI: IRQ 0 for device 0000:00:05.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:06.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0b.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0c.2 doesn't match PIRQ mask - try pci=usepirqmask
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.6 [Flags: R/W DEBUG].
udf: registering filesystem
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (41 C)
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
SyncLink PC Card driver $Revision: 4.15 $
SyncLink PC Card driver $Revision: 4.15 $, tty major#253
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Using anticipatory io scheduler
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
8139too Fast Ethernet driver 0.9.26
PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 9 for device 0000:00:0a.0
eth0: RealTek RTL8139 at 0xcf009000, 08:00:1f:b1:31:f2, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
orinoco.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
orinoco_pci.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> & Jean
Tourrilhes <jt-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org>)
PCI: Enabling device 0000:00:0b.0 (0010 -> 0012)
PCI: IRQ 0 for device 0000:00:0b.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 11 for device 0000:00:0b.0
Detected Orinoco/Prism2 PCI device at 0000:00:0b.0, mem:0xF4104000 to 0xF4104FFF
-> 0xcf00b000, irq:11
Reset
done..........................................................................................................................................................................................................................................................;
Clear
Reset...........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB8F72 - FFFB8D7E
eth1: Station identity 001f:0003:0001:0004
eth1: Looks like an Intersil firmware version 1.4.3
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:8A:5B:DB:B0
eth1: Station name "Prism  I"
eth1: ready
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
ALI15X3: simplex device: DMA forced
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:DMA
hda: TOSHIBA MK1503GAL, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 29297520 sectors (15000 MB), CHS=29065/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 >
PCI: IRQ 0 for device 0000:00:05.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 9 for device 0000:00:05.0
Yenta: CardBus bridge found at 0000:00:05.0 [13bd:102b]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000410
PCI: Enabling device 0000:00:0c.2 (0014 -> 0016)
PCI: IRQ 0 for device 0000:00:0c.2 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 0000:00:0c.2
ehci_hcd 0000:00:0c.2: EHCI Host Controller
ehci_hcd 0000:00:0c.2: irq 10, pci mem cf00f400
ehci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0c.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Found IRQ 5 for device 0000:00:0c.0
PCI: Sharing IRQ 5 with 0000:00:0c.1
ohci_hcd 0000:00:0c.0: OHCI Host Controller
ohci_hcd 0000:00:0c.0: irq 5, pci mem c00da000
ohci_hcd 0000:00:0c.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
PCI: Found IRQ 5 for device 0000:00:0c.1
PCI: Sharing IRQ 5 with 0000:00:0c.0
ohci_hcd 0000:00:0c.1: OHCI Host Controller
ohci_hcd 0000:00:0c.1: irq 5, pci mem c00db000
ohci_hcd 0000:00:0c.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 34
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003
UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: IRQ 0 for device 0000:00:06.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 11 for device 0000:00:06.0
ALSA device list:
  #0: ALI 5451 at 0x1400, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (1856 buckets, 14848 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding 152576k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
request_module: failed /sbin/modprobe -- char-major-10-135. error = 65280
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337
0x388-0x38f 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ttyS0 at I/O 0x3f8 (irq = 3) is a 16550A
process `named' is using obsolete setsockopt SO_BSDCOMPAT
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
process `host' is using obsolete setsockopt SO_BSDCOMPAT
request_module: failed /sbin/modprobe -- char-major-10-134. error = 65280
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
spurious 8259A interrupt: IRQ7.
process `named' is using obsolete setsockopt SO_BSDCOMPAT

-------------------------------------


           CPU0       
  0:    5976998          XT-PIC  timer
  1:      14958          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          1          XT-PIC  ohci_hcd, ohci_hcd
  9:     180216          XT-PIC  acpi, yenta, eth0
 10:          1          XT-PIC  ehci_hcd
 11:          0          XT-PIC  eth1, ALI 5451
 12:     155624          XT-PIC  i8042
 14:       6270          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          6
MIS:          0

-------------------------------------------------------

# dmidecode 2.3
SMBIOS 2.31 present.
30 structures occupying 916 bytes.
Table at 0x000DC010.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Phoenix Technologies LTD
		Version: 6.00 :2.02.00U;04-03-01-02-03-00      
		Release Date: 02/25/2003
		Address: 0xE6E40
		Runtime Size: 102848 bytes
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			3.5"/720 KB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			ACPI is supported
			USB legacy is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: SHARP Corporation
		Product Name: PC-MM10 Series
		Version: 1.0
		Serial Number:                 
		UUID: FEE48000-00A5-11D6-8000-08001FB131F2
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: SHARP Corporation
		Product Name: PC-MM10 Series
		Version: 1.0
		Serial Number:                 
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: SHARP Corporation
		Type: Sub Notebook
		Lock: Not Present
		Version: 1.0
		Serial Number:                 
		Asset Tag:                 
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: None
		Type: Central Processor
		Family: Crusoe TM5000
		Manufacturer: Transmeta
		ID: 43 05 00 00 3F 89 84 00
		Version: TM5800
		Voltage: 1.3 V
		External Clock: 66 MHz
		Max Speed: 1000 MHz
		Current Speed: 1000 MHz
		Status: Unpopulated
		Upgrade: None
		L1 Cache Handle: 0x0007
		L2 Cache Handle: 0x0008
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 5, 18 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: Unknown
		Current Interleave: Unknown
		Maximum Memory Module Size: 8 MB
		Maximum Total Memory Size: 8 MB
		Supported Speeds:
			Other
		Supported Memory Types:
			DIMM
			SDRAM
		Memory Module Voltage: Unknown
		Associated Memory Slots: 1
			0x0006
		Enabled Error Correcting Capabilities:
			None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: None
		Bank Connections: 0 1
		Current Speed: Unknown
		Type: None
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Unknown
		Location: Internal
		Installed Size: 128 KB
		Maximum Size: 128 KB
		Supported SRAM Types:
			Unknown
		Installed SRAM Type: Other
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Other
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Unknown
		Installed SRAM Type: Unknown
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0009
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CN2
		Internal Connector Type: None
		External Reference Designator: LAN
		External Connector Type: RJ-45
		Port Type: Network Port
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CN8
		Internal Connector Type: None
		External Reference Designator: Phone Out
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CN9
		Internal Connector Type: None
		External Reference Designator: USB1
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CN12
		Internal Connector Type: None
		External Reference Designator: VGA
		External Connector Type: Proprietary
		Port Type: Video Port
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CN10
		Internal Connector Type: None
		External Reference Designator: USB2
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CN1
		Internal Connector Type: Proprietary
		External Reference Designator: PC Card
		External Connector Type: Other
		Port Type: PCMCIA Type II
Handle 0x000F
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: CardBus Slot
		Type: 32-bit PC Card (PCMCIA)
		Current Usage: Available
		Length: Other
		ID: Adapter 0, Socket 1
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PC Card-16 is supported
			Cardbus is supported
Handle 0x0010
	DMI type 10, 10 bytes.
	On Board Device Information
		Type: Video
		Status: Enabled
		Description: SMI SM722
	On Board Device Information
		Type: Ethernet
		Status: Enabled
		Description: RealTek RTL8100BL
	On Board Device Information
		Type: Sound
		Status: Enabled
		Description: RealTek ALC201
Handle 0x0011
	DMI type 11, 5 bytes.
	OEM Strings
		String 1:  
Handle 0x0012
	DMI type 12, 5 bytes.
	System Configuration Options
Handle 0x0013
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			en|US
		Currently Installed Language: en|US
Handle 0x0014
	DMI type 15, 25 bytes.
	System Event Log
		Area Length: 16 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: General-purpose non-volatile data functions
		Access Address: 0x0000
		Status: Valid, Not Full
		Change Token: 0x000000F1
		Header Format: Type 1
		Supported Log Type Descriptors: 1
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
Handle 0x0015
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 256 MB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x0016
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0015
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: TSOP
		Set: 1
		Locator: On Board
		Bank Locator: Bank0/1
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0017
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Array Handle: 0x0015
		Partition Width: 0
Handle 0x0018
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0016
		Memory Array Mapped Address Handle: 0x0017
		Partition Row Position: 1
Handle 0x0019
	DMI type 21, 7 bytes.
	Built-in Pointing Device
		Type: Touch Pad
		Interface: PS/2
		Buttons: 2
Handle 0x001A
	DMI type 22, 26 bytes.
	Portable Battery
		Location: Back
		Manufacturer: Not Specified
		Name: <BAD INDEX>
		Chemistry: Lithium Ion
		Design Capacity: 59940 mWh
		Design Voltage: 11100 mV
		SBDS Version: Not Specified
		Maximum Error: 0%
		SBDS Serial Number: 0000
		SBDS Manufacture Date: 1980-00-00
		OEM-specific Information: 0x00000000
Handle 0x001B
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x001C
	DMI type 126, 4 bytes.
	Inactive
Handle 0x001D
	DMI type 127, 4 bytes.
	End Of Table

-----------------------------------------------------

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 64
	Memory at f4000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: fast devsel

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: fast devsel

00:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 1400 [size=256]
	Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 0
	Capabilities: [a0] Power Management version 1

00:09.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev c1)
(prog-if 00 [VGA])
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
	Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1800 [size=256]
	Memory at f4101000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:0b.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0200
	Flags: medium devsel, IRQ 11
	Memory at f4104000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:0c.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at 000da000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

00:0c.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at 000db000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

00:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 132, IRQ 10
	Memory at f4101400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if ea)
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1000 [size=16]
	Capabilities: [60] Power Management version 2

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Sharp corporation: Unknown device 102b
	Flags: medium devsel

--------------------------------------------------

That's all folks !
Big thanks to Leonard B. for helping report this bug :)

------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.
You are on the CC list for the bug, or are watching someone who is.



--------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
