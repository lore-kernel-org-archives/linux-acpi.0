From: Stefan =?iso-8859-1?q?D=F6singer?= <stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org>
Subject: PCI not restored correctly after suspend to ram
Date: Thu, 18 Mar 2004 09:35:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at>
Reply-To: stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_98VWATJVbs94+DF"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello list,
I have the following problems with suspend to ram on my Acer Travelmate 803
(Centrino) notebook:
With the patch for radeon_driver.c(Xfree v. 4.4) I can suspend and resume m=
y=20
notebook. After resume, the settings of most pci devices are not restored=20
correctly and the devices do not work. See the attached lspci_before_suspen=
d=20
and lspci_after_suspend files for details.
Devices not working are:
*Soundcard(00:1f.5)
*All devices on bus 02
*The modem, but there's only a non-GPL driver available.

I can get most devices devies to work by setting the pci registers with set=
pci=20
after resume. I use the attached fixpci.sh script to do so. I can get my=20
soundcard, the ethernet card(02:02.0) and the wireless(02:04.0) to work. I=
=20
have not tested firewire(02:07.0). The secound Cardbus bride(02:06.1) seems=
=20
to have more problems, it's not even listed correctly.
The file "lspci_after_suspend_fix" contains the output of lspci -vvx after=
=20
running fixpci.sh

Restoring the pci registers is a workaround, but I'd like the kernel to han=
dle=20
this so I don't have to unload and reload all modules, especially the=20
soundcard driver.

It this a acpi bug, a bug in the pci driver or a bug in the drivers for the=
=20
devices?

I use kernel 2.6.4 and xfree 4.4. I need X to soft-boot the VGA BIOS.
I use the pci=3Dnobios kernel options, pci=3Dbios does not help here and it=
 causes=20
crashes on boot under certain conditions

Please CC, I am not subscribed to the list.

Thanks for your help,
Stefan D=F6singer





--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

00 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                      ) @ 0x000f60c0
ACPI: RSDT (v001 ACER   Cardinal 0x20021230  LTP 0x00000000) @ 0x1ff74c20
ACPI: FADT (v001 ACER   Cardinal 0x20021230 PTL  0x0000001e) @ 0x1ff7af64
ACPI: BOOT (v001 ACER   Cardinal 0x20021230  LTP 0x00000001) @ 0x1ff7afd8
ACPI: DSDT (v001 ACER   Cardinal 0x20021230 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: root=/dev/hda9 vga=0x342 pci=nobios resume2=swap:/dev/hda5 rootfstype=ext3
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1599.203 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 515232k/523712k available (1557k kernel code, 7708k reserved, 672k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3170.30 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1598.0489 MHz.
..... host bus clock speed is 99.0905 MHz.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040220
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.....................................................................................................................................................................................................
Table [DSDT](id F004) - 729 Objects with 51 Devices 197 Methods 15 Regions
ACPI Namespace successfully loaded at root c036279c
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9
Completing Region/Field/Buffer/Package initialization:........................................................................................
Initialized 15/15 Regions 3/3 Fields 41/41 Buffers 29/29 Packages (737 nodes)
Executing all Device _STA and_INI methods:.....................................................
53 Devices found containing: 53 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Simple Boot Flag 0x1
Machine check exception polling timer started.
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
Initializing Cryptographic API
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p3 < p5 p6 p7 p8 p9 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
NET: Registered protocol family 1
Adding 1052216k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda9, internal journal
SCSI subsystem initialized
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device loop0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (loop0) for (loop0)
Using r5 hash to sort names
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Real Time Clock Driver v1.12
[ACPI Debug] String: Length 0x1C, "Temperature increasing: _Q80"
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e0961000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using address 2
drivers/usb/core/usb.c: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
b44.c:v0.92 (Nov 4, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:27:ea:5a
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
b44: eth0: Link is down.
[ACPI Debug] String: Length 0x1C, "Temperature decreasing: _Q81"
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.32
ipw2100: Copyright(c) 2003-2004 Intel Corporation
Detected ipw2100 PCI device at 0000:02:04.0, dev: wlan0, mem: 0xD0206000-0xD0206FFF -> e0a89000, irq: 10
NET: Registered protocol family 17
ipw2100: Associated with 'doesinger' at 11Mbps, channel 11
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
[ACPI Debug] String: Length 0x19, "Sleep Button Query: Fn+F4"
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 2 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb3: USB disconnect, address 1
usb 3-1: USB disconnect, address 2
uhci_hcd 0000:00:1d.1: USB bus 3 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb4: USB disconnect, address 1
uhci_hcd 0000:00:1d.2: USB bus 4 deregistered
NET: Unregistered protocol family 31
drivers/usb/core/usb.c: deregistering driver hiddev
drivers/usb/core/usb.c: deregistering driver hid
wlan0: Associated lost.
PM: Preparing system for suspend
Stopping tasks: ==============================================================|
[ACPI Debug] String: Length 0x16, ">>>> _PTS ------------"
[ACPI Debug] Integer: 0x0000000000000003
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
 hwsleep-0300 [733] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
PM: Finishing up.
hda: Wakeup request inited, waiting for !BSY...
Synaptics driver lost sync at byte 1
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000135
hda: start_power_step(step: 1000)
blk: queue dfd42800, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
[ACPI Debug] String: Length 0x16, ">>>> _WAK ------------"
[ACPI Debug] Integer: 0x0000000000000002
Restarting tasks... done
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e096f000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using address 2
drivers/usb/core/usb.c: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
b44.c:v0.92 (Nov 4, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:27:ea:5a
b44.c:v0.92 (Nov 4, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:27:ea:5a
b44: eth0: Link is down.

--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci_before_suspend"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci_before_suspend"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00: 86 80 40 33 06 01 90 30 03 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 41 33 07 01 a0 00 03 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
20: 10 d0 10 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1800 [size=32]
00: 86 80 c2 24 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 c4 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 c7 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]
00: 86 80 cd 24 06 01 90 02 03 20 03 0c 00 00 00 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d05fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 01 80 88 83 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 40 40 80 32
20: 20 d0 50 d0 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 cc 24 0f 00 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 ca 24 07 00 80 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 18 00 00 00 00 00 20 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1880 [size=32]
00: 86 80 c3 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c5 24 07 00 90 02 03 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 0c 00 d0 00 08 00 d0
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c6 24 05 00 90 02 03 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 66 4c 87 03 b0 02 01 00 00 03 08 42 00 00
10: 08 00 00 d8 01 30 00 00 00 00 10 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 08 00

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: e4 14 01 44 06 01 10 08 01 00 00 02 00 40 00 00
10: 00 40 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 43 10 16 01 90 02 04 00 80 02 08 40 00 00
10: 00 60 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 27 25
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 02 22

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0207000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: d0400000-d04ff000 (prefetchable)
	Memory window 1: d0300000-d03ff000 (prefetchable)
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004000-000040ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001
00: 17 12 14 71 87 01 10 04 20 00 07 06 00 40 82 00
10: 00 70 20 d0 a0 00 00 02 02 03 06 b0 00 00 40 d0
20: 00 f0 4f d0 00 00 30 d0 00 f0 3f d0 01 44 00 00
30: fd 44 00 00 01 40 00 00 fd 40 00 00 ff 01 c0 03
40: 25 10 1f 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.1 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001
00: 17 12 14 71 80 00 10 04 20 00 07 06 00 00 82 00
10: 00 10 00 20 a0 00 00 02 02 07 0a b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 00 01 00 00
40: 25 10 1f 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0208000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 12 10 71 03 01 10 04 00 00 80 08 08 40 00 00
10: 00 80 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0a 01 00 00

02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0209000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 26 80 16 01 10 02 00 10 00 0c 08 40 00 00
10: 00 90 20 d0 00 00 20 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 02 04


--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci_after_suspend"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci_after_suspend"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00: 86 80 40 33 06 01 90 20 03 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 41 33 07 01 a0 00 03 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
20: 10 d0 10 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1800 [size=32]
00: 86 80 c2 24 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 c4 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 c7 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]
00: 86 80 cd 24 06 00 90 02 03 20 03 0c 00 00 00 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d05fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 05 01 80 80 83 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 40 40 80 22
20: 20 d0 50 d0 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 cc 24 0f 00 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: [virtual] Memory at 20000000 (32-bit, non-prefetchable) [disabled] [size=1K]
00: 86 80 ca 24 05 00 80 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1880 [size=32]
00: 86 80 c3 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1c00 [disabled] [size=256]
	Region 1: I/O ports at 18c0 [disabled] [size=64]
	Region 2: [virtual] Memory at d0000c00 (32-bit, non-prefetchable) [disabled] [size=512]
	Region 3: [virtual] Memory at d0000800 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c5 24 00 00 90 02 03 00 01 04 00 00 00 00
10: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 02 00 00

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 2400 [disabled] [size=256]
	Region 1: I/O ports at 2000 [disabled] [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c6 24 00 00 90 02 03 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 66 4c 87 03 b0 02 01 00 00 03 08 42 00 00
10: 08 00 00 d8 01 30 00 00 00 00 10 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 08 00

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: [virtual] Memory at d0204000 (32-bit, non-prefetchable) [disabled] [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: e4 14 01 44 00 00 10 00 01 00 00 02 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: [virtual] Memory at d0206000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 43 10 00 00 90 02 04 00 80 02 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 27 25
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 01 02 22

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Unknown device 0001:0000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: [virtual] Memory at d0207000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001
00: 17 12 14 71 80 00 10 04 20 00 07 06 00 00 82 00
10: 00 00 00 00 a0 00 00 02 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 01 00 00 00 01 00 00 00 01 00 00 00 00 01 00 00
40: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.1 Class ffff: O2 Micro, Inc.: Unknown device 7114 (rev ff) (prog-if ff)
	!!! Unknown header type 7f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
	Subsystem: Unknown device 0001:0000
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0208000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 12 10 71 03 01 10 04 00 00 80 08 08 40 00 00
10: 00 80 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0a 01 00 00

02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: [virtual] Memory at d0209000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Region 1: [virtual] Memory at d0200000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 26 80 00 00 10 02 00 10 00 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 01 02 04


--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci_after_suspend_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci_after_suspend_fix"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00: 86 80 40 33 06 01 90 30 03 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 41 33 07 01 a0 00 03 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
20: 10 d0 10 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1800 [size=32]
00: 86 80 c2 24 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 c4 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 c7 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]
00: 86 80 cd 24 06 00 90 02 03 20 03 0c 00 00 00 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d05fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 01 80 88 83 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 40 40 80 32
20: 20 d0 50 d0 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 cc 24 0f 00 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: [virtual] Memory at 20000000 (32-bit, non-prefetchable) [disabled] [size=1K]
00: 86 80 ca 24 05 00 80 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1880 [size=32]
00: 86 80 c3 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1c00 [disabled] [size=256]
	Region 1: I/O ports at 18c0 [disabled] [size=64]
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [disabled] [size=512]
	Region 3: Memory at d0000800 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c5 24 00 00 90 02 03 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 0c 00 d0 00 08 00 d0
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 2400 [disabled] [size=256]
	Region 1: I/O ports at 2000 [disabled] [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c6 24 00 00 90 02 03 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 66 4c 87 03 b0 02 01 00 00 03 08 42 00 00
10: 08 00 00 d8 01 30 00 00 00 00 10 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 08 00

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: e4 14 01 44 06 01 10 08 01 00 00 02 00 40 00 00
10: 00 40 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 43 10 16 01 90 02 04 00 80 02 08 40 00 00
10: 00 60 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 27 25
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 02 22

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Unknown device 0001:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0207000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: d0400000-d04ff000 (prefetchable)
	Memory window 1: d0300000-d03ff000 (prefetchable)
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004000-000040ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001
00: 17 12 14 71 87 01 10 04 20 00 07 06 00 40 82 00
10: 00 70 20 d0 a0 00 00 02 02 03 06 b0 00 00 40 d0
20: 00 f0 4f d0 00 00 30 d0 00 f0 3f d0 01 44 00 00
30: fd 44 00 00 01 40 00 00 fd 40 00 00 ff 01 c0 03
40: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.1 Class ffff: O2 Micro, Inc.: Unknown device 7114 (rev ff) (prog-if ff)
	!!! Unknown header type 7f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
	Subsystem: Unknown device 0001:0000
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0208000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 12 10 71 03 01 10 04 00 00 80 08 08 40 00 00
10: 00 80 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0a 01 00 00

02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: [virtual] Memory at d0209000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Region 1: [virtual] Memory at d0200000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 26 80 00 00 10 02 00 10 00 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 01 02 04


--Boundary-00=_98VWATJVbs94+DF
Content-Type: application/x-shellscript;
  name="fixpci.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fixpci.sh"

SETPCI=/sbin/setpci

#First device: Host bridge
DEV=00:00.0
echo "Configuring $DEV"

$SETPCI -s $DEV 08.w=0x0330

#usb controlers work, I don't think I have to set anything there
#there are no differences before and after suspend

#pci to pci bridge
DEV=00:1e.0
echo "Configuring $DEV"
$SETPCI -s $DEV 04.w=0x0107
$SETPCI -s $DEV 06.w=0x8880
$SETPCI -s $DEV 1e.w=0x3280

#Isa bridge is restored correcty

#ide controller: not correctly restored, but no problems so far

#SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03) has no changed bytes

# Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 03)

#I disable this for now because it is unstable
DEV=00:1f.5
echo "Configuring $DEV"
#$SETPCI -s $DEV 04.w=0x0007	#this means pci_enable_device();
				#causes a lockup at this point, and the driver handles it
$SETPCI -s $DEV 10.w=0x1c01
$SETPCI -s $DEV 14.w=0x18c1
$SETPCI -s $DEV 18.w=0x0c00
$SETPCI -s $DEV 1a.w=0xd000
$SETPCI -s $DEV 1c.w=0x0800
$SETPCI -s $DEV 1e.w=0xd000
$SETPCI -s $DEV 3c.w=0x020a
#Here I could enable the device: $SETPCI -s $DEV 04.w=0x0007, but I let the driver do it

#for the same reason I do not touch the modem
#I think it's stongly connected to the audio

#VGA works

#broadcom ethernet controller
DEV=02:02.0
echo "Configuring $DEV"
$SETPCI -s $DEV  04.w=0x0106
$SETPCI -s $DEV  08.w=0x0810
$SETPCI -s $DEV  0c.w=0x4000
$SETPCI -s $DEV  10.w=0x4000
$SETPCI -s $DEV  12.w=0xd020

#wireless lan
DEV=02:04.0
echo "Configuring $DEV"
$SETPCI -s $DEV  04.w=0x0116
$SETPCI -s $DEV  0c.w=0x4008
$SETPCI -s $DEV  10.w=0x6000
$SETPCI -s $DEV  12.w=0xd020
$SETPCI -s $DEV  3c.w=0x010a

#cardbus. Thats a long one
#Maybe I do not need to set everything here,
#I just have no driver loaded. A driver maybe sets
#a lot bytes here.
DEV=02:06.0
echo "Configuring $DEV"
$SETPCI -s $DEV  04.w=0x0187
$SETPCI -s $DEV  0c.w=0x4000

$SETPCI -s $DEV  10.w=0x7000
$SETPCI -s $DEV  12.w=0xd020
$SETPCI -s $DEV  14.w=0x00a0
$SETPCI -s $DEV  16.w=0x0200
$SETPCI -s $DEV  18.w=0x0302
$SETPCI -s $DEV  1a.w=0xb006
$SETPCI -s $DEV  1c.w=0x0000
$SETPCI -s $DEV  1e.w=0xd040

$SETPCI -s $DEV  20.w=0xf000
$SETPCI -s $DEV  22.w=0xd04f
$SETPCI -s $DEV  24.w=0x0000
$SETPCI -s $DEV  26.w=0xd030
$SETPCI -s $DEV  28.w=0xf000
$SETPCI -s $DEV  2a.w=0xd03f
$SETPCI -s $DEV  2c.w=0x4401
$SETPCI -s $DEV  2e.w=0x0000

$SETPCI -s $DEV  30.w=0x44fd
$SETPCI -s $DEV  32.w=0x0000
$SETPCI -s $DEV  34.w=0x4001
$SETPCI -s $DEV  36.w=0x0000
$SETPCI -s $DEV  38.w=0x40fd
$SETPCI -s $DEV  3a.w=0x0000
$SETPCI -s $DEV  3c.w=0x01ff
$SETPCI -s $DEV  3e.w=0x03c0

$SETPCI -s $DEV  40.w=0x1025
$SETPCI -s $DEV  42.w=0x001f
$SETPCI -s $DEV  44.w=0x0001

#secound pcmcia bridge - this one has big problems
#set EVERYTHING
#I fear I can't fix anything here...
#DEV=02:06.1
#$SETPCI -s $DEV 00.w=0x1217
#$SETPCI -s $DEV 02.w=0x1471
#$SETPCI -s $DEV 04.w=0x0080
#$SETPCI -s $DEV 06.w=0x00410
#$SETPCI -s $DEV 08.w=0x0020
#$SETPCI -s $DEV 0a.w=0x0607
#$SETPCI -s $DEV 0c.w=0x0000
#$SETPCI -s $DEV 0e.w=0x0082

#$SETPCI -s $DEV 10.w=0x1000
#$SETPCI -s $DEV 12.w=0x2000
#$SETPCI -s $DEV 14.w=0x00a0
#$SETPCI -s $DEV 16.w=0x0200
#$SETPCI -s $DEV 18.w=0x0702
#$SETPCI -s $DEV 1a.w=0xb00a
#$SETPCI -s $DEV 1c.w=0x0000
#$SETPCI -s $DEV 1e.w=0x0000
#gave up


--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/plain;
  charset="us-ascii";
  name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode"

# dmidecode 2.3
SMBIOS 2.31 present.
24 structures occupying 1085 bytes.
Table at 0x000CF810.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: ACER   
		Version: 4A17
		Release Date: 12/30/2003
		Address: 0xE4580
		Runtime Size: 113280 bytes
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			3.5"/720 KB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Acer
		Product Name: TravelMate 800
		Version: Rev 1                   
		Serial Number: LXT2506087330016BBEF01
		UUID: C0EAAF3B-BDBE-D711-83A8-00C09F27EA5A
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Acer
		Product Name: TravelMate 800
		Version: Rev 1.0                 
		Serial Number: LXT2506087330016BBEF01
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Acer
		Type: Notebook
		Lock: Not Present
		Version: Rev.1                   
		Serial Number: LXT2506087330016BBEF01
		Asset Tag: ................................     
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00001234
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: uFCPGA2
		Type: Central Processor
		Family: Pentium M
		Manufacturer: Intel
		ID: 95 06 00 00 BF F9 E9 A7
		Signature: Type 0, Family 6, Model 9, Stepping 5
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			TM (Thermal monitor supported)
			SBF (Signal break on FERR)
		Version: Intel(R) Pentium(R) M processor
		Voltage: 1.2 V
		External Clock: 400 MHz
		Max Speed: 1600 MHz
		Current Speed: 1600 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0008
		L2 Cache Handle: 0x0009
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 1024 MB
		Maximum Total Memory Size: 2048 MB
		Supported Speeds:
			60 ns
		Supported Memory Types:
			DIMM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0006
			0x0007
		Enabled Error Correcting Capabilities:
			None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM 1
		Bank Connections: 0 1
		Current Speed: 75 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM 2
		Bank Connections: 2 3
		Current Speed: 75 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Asynchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 1024 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: LPT 1
		Internal Connector Type: None
		External Reference Designator: Parallel
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: U28
		Internal Connector Type: None
		External Reference Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000C
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCMCIA socket 0
		Type: 32-bit PC Card (PCMCIA)
		Current Usage: Unknown
		Length: Long
		ID: Adapter 0, Socket 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PC Card-16 is supported
			Cardbus is supported
			Modem ring resume is supported
			PME signal is supported
			Hot-plug devices are supported
Handle 0x000D
	DMI type 10, 10 bytes.
	On Board Device Information
		Type: Video
		Status: Disabled
		Description: ATI M9
	On Board Device Information
		Type: Sound
		Status: Disabled
		Description: AC97 Audio
	On Board Device Information
		Type: Other
		Status: Disabled
		Description: TI TSB43AB21 IEEE-1394 Controller
Handle 0x000E
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: SMBIOS 2.3
		String 2: Customer Reference Platform
Handle 0x000F
	DMI type 15, 29 bytes.
	System Event Log
		Area Length: 0 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: Memory-mapped physical 32-bit address
		Access Address: 0x00000000
		Status: Invalid, Not Full
		Change Token: 0x00000020
		Header Format: Type 1
		Supported Log Type Descriptors: 3
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
		Descriptor 2: Single-bit ECC memory error
		Data Format 2: Multiple-event
		Descriptor 3: Multi-bit ECC memory error
		Data Format 3: Multiple-event
Handle 0x0010
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 1 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x0011
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0010
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: DIMM 0
		Bank Locator: Bank 0, 1
		Type: SRAM
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0012
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0010
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: DIMM 1
		Bank Locator: Bank 2, 3
		Type: SRAM
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0013
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0010
		Partition Width: 0
Handle 0x0014
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0011
		Memory Array Mapped Address Handle: 0x0013
		Partition Row Position: 1
		Interleave Position: 1
Handle 0x0015
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0012
		Memory Array Mapped Address Handle: 0x0013
		Partition Row Position: 1
		Interleave Position: 1
Handle 0x0016
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x0017
	DMI type 127, 4 bytes.
	End Of Table

--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="acpidump"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="acpidump"

/*
RSD PTR: Checksum=3D4, OEMID=3DACER, RsdtAddress=3D0x1ff74c20
 */
/*
RSDT: Length=3D44, Revision=3D1, Checksum=3D227,
	OEMID=3DACER, OEM Table ID=3DCardinal, OEM Revision=3D0x20021230,
	Creator ID=3D LTP, Creator Revision=3D0x0
 */
/*
	Entries=3D{ 0x1ff7af64, 0x1ff7afd8 }
 */
/*
	DSDT=3D0x1ff74c4c
	INT_MODEL=3DPIC
	SCI_INT=3D9
	SMI_CMD=3D0xb2, ACPI_ENABLE=3D0xf0, ACPI_DISABLE=3D0xf1, S4BIOS_REQ=3D0x0
	PM1a_EVT_BLK=3D0x1000-0x1003
	PM1a_CNT_BLK=3D0x1004-0x1005
	PM2_CNT_BLK=3D0x1020-0x1020
	PM2_TMR_BLK=3D0x1008-0x100b
	PM2_GPE0_BLK=3D0x1028-0x102f
	P_LVL2_LAT=3D1ms, P_LVL3_LAT=3D85ms
	FLUSH_SIZE=3D0, FLUSH_STRIDE=3D0
	DUTY_OFFSET=3D0, DUTY_WIDTH=3D0
	DAY_ALRM=3D13, MON_ALRM=3D0, CENTURY=3D50
	Flags=3D{WBINVD,PROC_C1,SLP_BUTTON}
 */
/*
DSDT: Length=3D25368, Revision=3D1, Checksum=3D57,
	OEMID=3DACER, OEM Table ID=3DCardinal, OEM Revision=3D0x20021230,
	Creator ID=3DMSFT, Creator Revision=3D0x100000d
 */
DefinitionBlock ("acpi_dsdt.aml",	"DSDT",0x1,"ACER",			"Cardinal",			0x2002=
1230		=09
)

{
OperationRegion(DBG_, SystemIO, 0x80, 0x1)
=46ield(DBG_, ByteAcc, NoLock, Preserve) {
    DEBG,	8
}
Scope(_PR_) {
    Processor(CPU0, 0, 0x1010, 0x6) {
        Name(_PCT, Package(0x2) {
            Buffer(0x11) {0x82, 0xc, 0x0, 0x1, 0x8, 0x0, 0x0, 0xb2, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x79, 0x0 },
            Buffer(0x11) {0x82, 0xc, 0x0, 0x1, 0x8, 0x0, 0x0, 0xb3, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x79, 0x0 },
        })
        Name(_PSS, Package(0x5) {
            Package(0x6) {
                0x0640,
                0x5dc0,
                0xa,
                0xa,
                0x89,
                0x0,
            },
            Package(0x6) {
                0x0578,
                0x4e20,
                0xa,
                0xa,
                0x8a,
                0x1,
            },
            Package(0x6) {
                0x04b0,
                0x4650,
                0xa,
                0xa,
                0x8b,
                0x2,
            },
            Package(0x6) {
                0x0320,
                0x3e80,
                0xa,
                0xa,
                0x8c,
                0x3,
            },
            Package(0x6) {
                0x0258,
                0x2ee0,
                0xa,
                0xa,
                0x8d,
                0x4,
            },
        })
        Method(_PPC) {
            Return(0x0)
        }
    }
}
Scope(_SI_) {
    Method(_MSG, 1) {
        If(Arg0) {
            Store(One, \_SB_.PCI0.LPC0.BL27)
        }
        Else {
            Store(Zero, \_SB_.PCI0.LPC0.BL27)
        }
    }
}
Name(\_S0_, Package(0x2) {
    0x0,
    0x0,
})
Name(\_S3_, Package(0x2) {
    0x5,
    0x5,
})
Name(\_S4_, Package(0x2) {
    0x6,
    0x6,
})
Name(\_S5_, Package(0x2) {
    0x7,
    0x7,
})
Method(_PTS, 1) {
    Store(Arg0, \_SB_.STAT)
    Store(">>>> _PTS ------------", Debug)
    Store(Arg0, Debug)
    Store(Arg0, \_SB_.SLEE)
    Store(0x84, \_SB_.PCI0.LPC0.BCMD)
    Store(0x0, \_SB_.PCI0.LPC0.SMIC)
    If(Or(LEqual(Arg0, 0x3), LEqual(Arg0, 0x4), )) {
        Store(0x1, \_SB_.PCI0.LPC0.EC0_.APWR)
    }
    If(LEqual(Arg0, 0x3)) {
        Store(0x80, \_SB_.PCI0.LPC0.BCMD)
        Store(0x0, \_SB_.PCI0.LPC0.SMIC)
    }
    If(LEqual(Arg0, 0x4)) {
        Store(0x1, \_SB_.S4WP)
        Store(0x82, \_SB_.PCI0.LPC0.BCMD)
        Store(0x0, \_SB_.PCI0.LPC0.SMIC)
        Store(One, \_SB_.PCI0.LPC0.EC0_.PFLG)
        Store(One, \_SB_.PCI0.LPC0.EC0_.S4LD)
    }
    If(LEqual(SizeOf(\_OS_), 0x27)) {
        Notify(\_SB_.BAT1, 0x80)
        Notify(\_SB_.BAT2, 0x80)
        Notify(\_SB_.ACAD, 0x0)
    }
    If(LEqual(Arg0, 0x5)) {
        Store(One, \_SB_.PCI0.LPC0.EC0_.S5LW)
    }
}
Method(_WAK, 1) {
    Store(">>>> _WAK ------------", Debug)
    Store(Arg0, Debug)
    Store(Arg0, \_SB_.STAT)
    If(LEqual(Arg0, 0x3)) {
        Store(0x81, \_SB_.PCI0.LPC0.BCMD)
        Store(0x0, \_SB_.PCI0.LPC0.SMIC)
    }
    If(LEqual(Arg0, 0x4)) {
        If(LEqual(\_SB_.PCI0.MYOS, 0x3)) {
            Store(0x83, \_SB_.PCI0.LPC0.BCMD)
            Store(0x0, \_SB_.PCI0.LPC0.SMIC)
        }
        Store(0x1, \_SB_.OKEC)
        Notify(\_SB_.SLPB, 0x2)
    }
    If(LEqual(SizeOf(\_OS_), 0x14)) {
        Store(\_SB_.PCI0.LPC0.RBID, Local0)
        Store(\_SB_.PCI0.IDE0.BAYR, Local1)
        Store(Local0, \_SB_.PCI0.IDE0.BAYR)
        If(LNot(LEqual(Local0, Local1))) {
            If(Or(LEqual(Local1, 0x1), LEqual(Local1, 0x2), )) {
                If(And(LEqual(\_SB_.PCI0.MYOS, 0x3), LEqual(Local0, 0x3), )=
) {
                    Notify(\_SB_.PCI0.IDE0.SECN.BAY1, 0x3)
                }
                Else {
                    Notify(\_SB_.PCI0.IDE0.SECN.BAY1, 0x1)
                }
            }
        }
        If(Or(LEqual(Local0, 0x1), LEqual(Local0, 0x2), )) {
            Notify(\_SB_.PCI0.IDE0.SECN.BAY1, 0x0)
        }
    }
    If(LEqual(SizeOf(\_OS_), 0x27)) {
        Notify(\_SB_.BAT1, 0x80)
        Notify(\_SB_.BAT2, 0x80)
        Notify(\_SB_.ACAD, 0x0)
    }
    Store(\_SB_.PCI0.LPC0.EC0_.ACDF, \_SB_.ACST)
    If(LEqual(SizeOf(\_OS_), 0x11)) {
        Notify(\_SB_.SLPB, 0x2)
    }
    Store(0x0, \_SB_.SLEE)
}
Scope(_GPE) {
    Method(_L05) {
        Notify(\_SB_.PCI0.MDM0, 0x2)
    }
    Method(_L0B) {
        Notify(\_SB_.PCI0.HUB_, 0x0)
        If(Or(LEqual(\_SB_.PCI0.MYOS, 0x1), LEqual(\_SB_.PCI0.MYOS, 0x3), )=
) {
            Notify(\_SB_.SLPB, 0x2)
        }
    }
    Method(_L03) {
        Notify(\_SB_.PCI0.USB1, 0x2)
    }
    Method(_L04) {
        Notify(\_SB_.PCI0.USB2, 0x2)
    }
    Method(_L0C) {
        Notify(\_SB_.PCI0.USB3, 0x2)
    }
    Method(_E18) {
        Sleep(0x1)
    }
}
Scope(_SB_) {
    Name(STAT, 0x0)
    Name(D1ST, 0x0)
    Name(D1SJ, 0x1)
    Device(PCI0) {
        Name(MYOS, 0x2)
        Method(_INI) {
            Store(0x1, \_SB_.D1SJ)
            Store(0x2, MYOS)
            If(LEqual(SizeOf(\_OS_), 0x14)) {
                Store(0x1, MYOS)
                Store(0x1, \_SB_.W2KF)
                If(CondRefOf(_OSI, Local0)) {
                    If(\_OSI) {
                        "Windows 2001"
                        Store(0x3, MYOS)
                        Store(0x3, \_SB_.W2KF)
                    }
                }
            }
            Else {
                If(LEqual(SizeOf(\_OS_), 0x11)) {
                    Store(0x0, MYOS)
                    Store(0x0, \_SB_.W2KF)
                }
                Else {
                    If(LEqual(SizeOf(\_OS_), 0x27)) {
                        Store(0x2, MYOS)
                        Store(0x2, \_SB_.W2KF)
                    }
                }
            }
        }
        Name(_HID, 0x030ad041)
        Name(_ADR, 0x0)
        Name(_BBN, 0x0)
        OperationRegion(HBUS, PCI_Config, 0x40, 0xc0)
        Field(HBUS, DWordAcc, NoLock, Preserve) {
            Offset(0x20),
            DRB0,	8,
            DRB1,	8,
            DRB2,	8,
            DRB3,	8,
            Offset(0x50),
            ,	4,
            PM0H,	2,
            Offset(0x51),
            PM1L,	2,
            ,	2,
            PM1H,	2,
            Offset(0x52),
            PM2L,	2,
            ,	2,
            PM2H,	2,
            Offset(0x53),
            PM3L,	2,
            ,	2,
            PM3H,	2,
            Offset(0x54),
            PM4L,	2,
            ,	2,
            PM4H,	2,
            Offset(0x55),
            PM5L,	2,
            ,	2,
            PM5H,	2,
            Offset(0x56),
            PM6L,	2,
            ,	2,
            PM6H,	2,
            Offset(0x57),
            FDHC,	8
        }
        Name(BUF0, Buffer(0x0201) {0x88, 0xe, 0x0, 0x2, 0xc, 0x0, 0x0, 0x0,=
 0x0, 0x0, 0xff, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x87, 0x18, 0x0, 0x1, 0xc, 0=
x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xf7, 0xc, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0xf8, 0xc, 0x0, 0x0, 0x0, 0x47, 0x1, 0xf8, 0xc, 0xf8, 0xc, 0x1, 0=
x8, 0x87, 0x18, 0x0, 0x1, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0xd, 0x0, 0x0,=
 0xff, 0xff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xf3, 0x0, 0x0, 0x0, 0x87, =
0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xa, 0x0, 0xff, 0xf=
f, 0xb, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x0, 0x87, 0x18, 0x0, =
0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc, 0x0, 0xff, 0x3f, 0xc, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, =
0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0xc, 0x0, 0xff, 0x7f, 0xc, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0,=
 0x0, 0x0, 0x0, 0x0, 0x80, 0xc, 0x0, 0xff, 0xbf, 0xc, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0xc0, 0xc, 0x0, 0xff, 0xff, 0xc, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0xd, 0x0, 0xff, 0x3f, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0,=
 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0=
xd, 0x0, 0xff, 0x7f, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0=
, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x80, 0xd, 0x0, =
0xff, 0xbf, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0=
x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc0, 0xd, 0x0, 0xff, 0xf=
f, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0,=
 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xe, 0x0, 0xff, 0x3f, 0xe, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc,=
 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0xe, 0x0, 0xff, 0x7f, 0xe, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x80, 0xe, 0x0, 0xff, 0xbf, 0xe, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0xc0, 0xe, 0x0, 0xff, 0xff, 0xe, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,=
 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0xf, 0x0, 0xff, 0xff, 0xf, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1,=
 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0xff, 0xff, 0xbf, 0xfe, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x87, 0x18, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x79, 0x0 })
        Method(_CRS, 0, Serialized) {
            If(PM1L) {
                CreateDWordField(BUF0, 0x80, C0LN)
                Store(Zero, C0LN)
            }
            If(LEqual(PM1L, 0x1)) {
                CreateBitField(BUF0, 0x0378, C0RW)
                Store(Zero, C0RW)
            }
            If(PM1H) {
                CreateDWordField(BUF0, 0x9b, C4LN)
                Store(Zero, C4LN)
            }
            If(LEqual(PM1H, 0x1)) {
                CreateBitField(BUF0, 0x0450, C4RW)
                Store(Zero, C4RW)
            }
            If(PM2L) {
                CreateDWordField(BUF0, 0xb6, C8LN)
                Store(Zero, C8LN)
            }
            If(LEqual(PM2L, 0x1)) {
                CreateBitField(BUF0, 0x0528, C8RW)
                Store(Zero, C8RW)
            }
            If(PM2H) {
                CreateDWordField(BUF0, 0xd1, CCLN)
                Store(Zero, CCLN)
            }
            If(LEqual(PM2H, 0x1)) {
                CreateBitField(BUF0, 0x0600, CCRW)
                Store(Zero, CCRW)
            }
            If(PM3L) {
                CreateDWordField(BUF0, 0xec, D0LN)
                Store(Zero, D0LN)
            }
            If(LEqual(PM3L, 0x1)) {
                CreateBitField(BUF0, 0x06d8, D0RW)
                Store(Zero, D0RW)
            }
            If(PM3H) {
                CreateDWordField(BUF0, 0x0107, D4LN)
                Store(Zero, D4LN)
            }
            If(LEqual(PM3H, 0x1)) {
                CreateBitField(BUF0, 0x07b0, D4RW)
                Store(Zero, D4RW)
            }
            If(PM4L) {
                CreateDWordField(BUF0, 0x0122, D8LN)
                Store(Zero, D8LN)
            }
            If(LEqual(PM4L, 0x1)) {
                CreateBitField(BUF0, 0x0888, D8RW)
                Store(Zero, D8RW)
            }
            If(PM4H) {
                CreateDWordField(BUF0, 0x013d, DCLN)
                Store(Zero, DCLN)
            }
            If(LEqual(PM4H, 0x1)) {
                CreateBitField(BUF0, 0x0960, DCRW)
                Store(Zero, DCRW)
            }
            If(PM5L) {
                CreateDWordField(BUF0, 0x0158, E0LN)
                Store(Zero, E0LN)
            }
            If(LEqual(PM5L, 0x1)) {
                CreateBitField(BUF0, 0x0a38, E0RW)
                Store(Zero, E0RW)
            }
            If(PM5H) {
                CreateDWordField(BUF0, 0x0173, E4LN)
                Store(Zero, E4LN)
            }
            If(LEqual(PM5H, 0x1)) {
                CreateBitField(BUF0, 0x0b10, E4RW)
                Store(Zero, E4RW)
            }
            If(PM6L) {
                CreateDWordField(BUF0, 0x018e, E8LN)
                Store(Zero, E8LN)
            }
            If(LEqual(PM6L, 0x1)) {
                CreateBitField(BUF0, 0x0be8, E8RW)
                Store(Zero, E8RW)
            }
            If(PM6H) {
                CreateDWordField(BUF0, 0x01a9, ECLN)
                Store(Zero, ECLN)
            }
            If(LEqual(PM6H, 0x1)) {
                CreateBitField(BUF0, 0x0cc0, ECRW)
                Store(Zero, ECRW)
            }
            If(PM0H) {
                CreateDWordField(BUF0, 0x01c4, F0LN)
                Store(Zero, F0LN)
            }
            If(LEqual(PM0H, 0x1)) {
                CreateBitField(BUF0, 0x0d98, F0RW)
                Store(Zero, F0RW)
            }
            CreateDWordField(BUF0, 0x01d3, M1MN)
            CreateDWordField(BUF0, 0x01d7, M1MX)
            CreateDWordField(BUF0, 0x01df, M1LN)
            Multiply(0x02000000, DRB3, M1MN)
            Add(Subtract(M1MX, M1MN, ), 0x1, M1LN)
            ShiftRight(And(\_SB_.PCI0.LPC0.MTSE, 0x0380, ), 0x7, Local0)
            If(And(Local0, 0x4, )) {
                CreateDWordField(BUF0, 0x01ee, M2MN)
                CreateDWordField(BUF0, 0x01f2, M2MX)
                CreateDWordField(BUF0, 0x01fa, M2LN)
                Store(0xfed00000, M2MN)
                Store(0xfed003ff, M2MX)
                Store(0x0400, M2LN)
                If(LEqual(Local0, 0x5)) {
                    Store(0xfed01000, M2MN)
                    Store(0xfed013ff, M2MX)
                }
                If(LEqual(Local0, 0x6)) {
                    Store(0xfed02000, M2MN)
                    Store(0xfed023ff, M2MX)
                }
                If(LEqual(Local0, 0x7)) {
                    Store(0xfed03000, M2MN)
                    Store(0xfed033ff, M2MX)
                }
            }
            Return(BUF0)
        }
        Name(_PRT, Package(0xf) {
            Package(0x4) {
                0xffff,
                0x0,
                \_SB_.PCI0.LPC0.LNKA,
                0x0,
            },
            Package(0x4) {
                0xffff,
                0x1,
                \_SB_.PCI0.LPC0.LNKB,
                0x0,
            },
            Package(0x4) {
                0xffff,
                0x2,
                \_SB_.PCI0.LPC0.LNKC,
                0x0,
            },
            Package(0x4) {
                0xffff,
                0x3,
                \_SB_.PCI0.LPC0.LNKD,
                0x0,
            },
            Package(0x4) {
                0x0001ffff,
                0x0,
                \_SB_.PCI0.LPC0.LNKA,
                0x0,
            },
            Package(0x4) {
                0x001dffff,
                0x0,
                \_SB_.PCI0.LPC0.LNKA,
                0x0,
            },
            Package(0x4) {
                0x001dffff,
                0x1,
                \_SB_.PCI0.LPC0.LNKD,
                0x0,
            },
            Package(0x4) {
                0x001dffff,
                0x2,
                \_SB_.PCI0.LPC0.LNKC,
                0x0,
            },
            Package(0x4) {
                0x001dffff,
                0x3,
                \_SB_.PCI0.LPC0.LNKH,
                0x0,
            },
            Package(0x4) {
                0x001effff,
                0x0,
                \_SB_.PCI0.LPC0.LNKA,
                0x0,
            },
            Package(0x4) {
                0x001effff,
                0x1,
                \_SB_.PCI0.LPC0.LNKB,
                0x0,
            },
            Package(0x4) {
                0x001effff,
                0x2,
                \_SB_.PCI0.LPC0.LNKC,
                0x0,
            },
            Package(0x4) {
                0x001effff,
                0x3,
                \_SB_.PCI0.LPC0.LNKD,
                0x0,
            },
            Package(0x4) {
                0x001fffff,
                0x0,
                \_SB_.PCI0.LPC0.LNKC,
                0x0,
            },
            Package(0x4) {
                0x001fffff,
                0x1,
                \_SB_.PCI0.LPC0.LNKB,
                0x0,
            },
        })
        Device(AGP_) {
            Name(_ADR, 0x00010000)
            Name(_PRT, Package(0x1) {
                Package(0x4) {
                    0xffff,
                    0x0,
                    \_SB_.PCI0.LPC0.LNKA,
                    0x0,
                },
            })
            Device(VGA_) {
                Name(_ADR, 0x0)
                Name(SWIT, 0x1)
                Name(CRTA, 0x1)
                Name(LCDA, 0x1)
                Name(TV0A, 0x1)
                Name(TOGF, 0x2)
                Method(_STA) {
                    Return(0xf)
                }
                Name(_PSC, 0x0)
                Name(USBF, 0x0)
                Method(_PS0) {
                    Store(0x0, _PSC)
                }
                Method(_PS3) {
                    Store(0x3, _PSC)
                }
                Method(_DOS, 1) {
                    Store(And(Arg0, 0x3, ), SWIT)
                }
                Method(_DOD) {
                    Return(Package(0x3) {
                        0x00010100,
                        0x00010110,
                        0x00010200,
                    })
                }
                Device(CRT_) {
                    Name(_ADR, 0x0100)
                    Method(_DCS) {
                        If(CRTA) {
                            Return(0x1f)
                        }
                        Else {
                            Return(0x1d)
                        }
                    }
                    Method(_DGS) {
                        If(CRTA) {
                            Return(0x1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_DSS, 1) {
                        Store("CRT --_DSS", Debug)
                    }
                }
                Device(TV0_) {
                    Name(_ADR, 0x0200)
                    Method(_DCS) {
                        If(TV0A) {
                            Return(0x1f)
                        }
                        Else {
                            Return(0x1d)
                        }
                    }
                    Method(_DGS) {
                        If(TV0A) {
                            Return(0x1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_DSS, 1) {
                        Store("TV --_DSS", Debug)
                    }
                }
                Device(LCD_) {
                    Name(_ADR, 0x0110)
                    Method(_DCS) {
                        If(LCDA) {
                            Return(0x1f)
                        }
                        Else {
                            Return(0x1d)
                        }
                    }
                    Method(_DGS) {
                        Store(LCDA, Local0)
                        If(LCDA) {
                            Return(0x1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_DSS, 1) {
                        Store("LCD --_DSS", Debug)
                    }
                }
                Method(SWIH) {
                    Store(0x3, Local0)
                    If(LEqual(Local0, 0x3)) {
                        Increment(TOGF)
                        Store(TOGF, Local1)
                        If(LEqual(Local1, 0x1)) {
                            Store(One, LCDA)
                            Store(Zero, CRTA)
                            Store(Zero, TV0A)
                        }
                        Else {
                            If(LEqual(Local1, 0x2)) {
                                Store(Zero, LCDA)
                                Store(One, CRTA)
                                Store(Zero, TV0A)
                            }
                            Else {
                                If(LEqual(Local1, 0x3)) {
                                    Store(One, LCDA)
                                    Store(One, CRTA)
                                    Store(Zero, TV0A)
                                }
                                Else {
                                    Store(One, TOGF)
                                    Store(One, LCDA)
                                    Store(Zero, CRTA)
                                    Store(Zero, TV0A)
                                }
                            }
                        }
                    }
                    Else {
                        If(LEqual(Local0, 0x5)) {
                            Increment(TOGF)
                            Store(TOGF, Local1)
                            If(LEqual(Local1, 0x1)) {
                                Store(One, LCDA)
                                Store(Zero, CRTA)
                                Store(Zero, TV0A)
                            }
                            Else {
                                Store(Zero, TOGF)
                                Store(Zero, LCDA)
                                Store(Zero, CRTA)
                                Store(One, TV0A)
                                Store(Zero, TV0A)
                            }
                        }
                        Else {
                            If(LEqual(Local0, 0x7)) {
                                Increment(TOGF)
                                Store(TOGF, Local1)
                                If(LEqual(Local1, 0x1)) {
                                    Store(0x1, LCDA)
                                    Store(0x0, CRTA)
                                    Store(0x0, TV0A)
                                }
                                Else {
                                    If(LEqual(Local1, 0x2)) {
                                        Store(0x0, LCDA)
                                        Store(0x1, CRTA)
                                        Store(0x0, TV0A)
                                    }
                                    Else {
                                        If(LEqual(Local1, 0x3)) {
                                            Store(0x1, LCDA)
                                            Store(0x1, CRTA)
                                            Store(0x0, TV0A)
                                        }
                                        Else {
                                            Store(0x0, TOGF)
                                            Store(0x0, LCDA)
                                            Store(0x0, CRTA)
                                            Store(0x1, TV0A)
                                            Store(0x0, TV0A)
                                        }
                                    }
                                }
                            }
                            Else {
                                Store(0x1, TOGF)
                                Store(0x1, LCDA)
                                Store(0x0, CRTA)
                                Store(0x0, TV0A)
                            }
                        }
                    }
                    Notify(\_SB_.PCI0.AGP_.VGA_, 0x80)
                }
                Method(GETD) {
                    Store(0x98, \_SB_.PCI0.LPC0.BCMD)
                    Store(0x0, \_SB_.PCI0.LPC0.SMIC)
                    Store(\_SB_.DISD, Local0)
                    If(LEqual(Local0, 0x1)) {
                        Store(0x1, TOGF)
                    }
                    If(LEqual(Local0, 0x2)) {
                        Store(0x2, TOGF)
                    }
                    If(LEqual(Local0, 0x3)) {
                        Store(0x3, TOGF)
                    }
                    If(LEqual(Local0, 0x4)) {
                        Store(0x0, TOGF)
                    }
                }
            }
        }
        Device(LPC0) {
            Name(_ADR, 0x001f0000)
            Method(DECD, 4) {
                Store(Arg0, Debug)
            }
            OperationRegion(REGS, PCI_Config, 0x40, 0xc0)
            Field(REGS, DWordAcc, NoLock, Preserve) {
                PMBA,	16,
                Offset(0x18),
                GPBA,	16,
                Offset(0x90),
                POSD,	1,
                Offset(0x91),
                MTSE,	16,
                Offset(0x94),
                Offset(0xa0),
                CMAD,	3,
                ,	1,
                CMBD,	3,
                Offset(0xa1),
                LPTD,	2,
                ,	2,
                FDDD,	1,
                Offset(0xa6),
                ECO1,	1,
                ECO2,	1,
                ELPT,	1,
                EFDD,	1
            }
            OperationRegion(PIRX, PCI_Config, 0x60, 0xc)
            Field(PIRX, DWordAcc, NoLock, Preserve) {
                AccessAs(ByteAcc, 0),
                PIRA,	8,
                PIRB,	8,
                PIRC,	8,
                PIRD,	8,
                Offset(0x8),
                PIRE,	8,
                PIRF,	8,
                PIRG,	8,
                PIRH,	8
            }
            Device(MBRD) {
                Name(_HID, 0x020cd041)
                Name(_UID, 0x1f)
                Name(RSRC, Buffer(0x0136) {0x47, 0x1, 0x10, 0x0, 0x10, 0x0,=
 0x1, 0x10, 0x47, 0x1, 0x24, 0x0, 0x24, 0x0, 0x1, 0x2, 0x47, 0x1, 0x28, 0x0=
, 0x28, 0x0, 0x1, 0x2, 0x47, 0x1, 0x2c, 0x0, 0x2c, 0x0, 0x1, 0x2, 0x47, 0x1=
, 0x30, 0x0, 0x30, 0x0, 0x1, 0x2, 0x47, 0x1, 0x34, 0x0, 0x34, 0x0, 0x1, 0x2=
, 0x47, 0x1, 0x38, 0x0, 0x38, 0x0, 0x1, 0x2, 0x47, 0x1, 0x3c, 0x0, 0x3c, 0x=
0, 0x1, 0x2, 0x47, 0x1, 0x50, 0x0, 0x50, 0x0, 0x1, 0x4, 0x47, 0x1, 0x72, 0x=
0, 0x72, 0x0, 0x1, 0x6, 0x47, 0x1, 0x80, 0x0, 0x80, 0x0, 0x1, 0x1, 0x47, 0x=
1, 0x90, 0x0, 0x90, 0x0, 0x1, 0x10, 0x47, 0x1, 0xa4, 0x0, 0xa4, 0x0, 0x1, 0=
x2, 0x47, 0x1, 0xa8, 0x0, 0xa8, 0x0, 0x1, 0x2, 0x47, 0x1, 0xac, 0x0, 0xac, =
0x0, 0x1, 0x2, 0x47, 0x1, 0xb0, 0x0, 0xb0, 0x0, 0x1, 0x6, 0x47, 0x1, 0xb8, =
0x0, 0xb8, 0x0, 0x1, 0x2, 0x47, 0x1, 0xbc, 0x0, 0xbc, 0x0, 0x1, 0x2, 0x47, =
0x1, 0x0, 0x10, 0x0, 0x10, 0x1, 0x80, 0x47, 0x1, 0x80, 0x11, 0x80, 0x11, 0x=
1, 0x40, 0x47, 0x1, 0xc0, 0x1, 0xc0, 0x1, 0x1, 0x10, 0x47, 0x1, 0x2e, 0x0, =
0x2e, 0x0, 0x1, 0x2, 0x47, 0x1, 0x4e, 0x0, 0x4e, 0x0, 0x1, 0x2, 0x47, 0x1, =
0x68, 0x0, 0x68, 0x0, 0x1, 0x1, 0x47, 0x1, 0x6c, 0x0, 0x6c, 0x0, 0x1, 0x1, =
0x47, 0x1, 0x0, 0xfe, 0x0, 0xfe, 0x0, 0x1, 0x47, 0x1, 0xd0, 0x4, 0xd0, 0x4,=
 0x1, 0x2, 0x47, 0x1, 0x0, 0x6, 0x0, 0x6, 0x1, 0x10, 0x47, 0x1, 0x10, 0x6, =
0x10, 0x6, 0x1, 0x10, 0x47, 0x1, 0x68, 0x0, 0x68, 0x0, 0x1, 0x1, 0x47, 0x1,=
 0x6c, 0x0, 0x6c, 0x0, 0x1, 0x1, 0x86, 0x9, 0x0, 0x0, 0x0, 0x0, 0x80, 0xff,=
 0x0, 0x0, 0x40, 0x0, 0x86, 0x9, 0x0, 0x0, 0x0, 0x0, 0xf0, 0xff, 0x0, 0x0, =
0x10, 0x0, 0x86, 0x9, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xa, 0x0, 0x8=
6, 0x9, 0x0, 0x0, 0x0, 0x0, 0xe, 0x0, 0x0, 0x0, 0x2, 0x0, 0x86, 0x9, 0x0, 0=
x1, 0x0, 0x0, 0x10, 0x0, 0x0, 0x0, 0x0, 0x0, 0x79, 0x0 })
                Method(_CRS) {
                    CreateWordField(RSRC, 0x92, PMMN)
                    CreateWordField(RSRC, 0x94, PMMX)
                    And(^^PMBA, 0xff80, PMMN)
                    Store(PMMN, PMMX)
                    CreateWordField(RSRC, 0x9a, GPMN)
                    CreateWordField(RSRC, 0x9c, GPMX)
                    And(^^GPBA, 0xff80, GPMN)
                    Store(GPMN, GPMX)
                    CreateDWordField(RSRC, 0x0130, TMEM)
                    Store(\_SB_.PCI0.DRB3, TMEM)
                    ShiftLeft(TMEM, 0x19, TMEM)
                    Subtract(TMEM, 0x00100000, TMEM)
                    Return(RSRC)
                }
            }
            Device(DMAC) {
                Name(_HID, 0x0002d041)
                Name(_CRS, Buffer(0x1d) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1=
, 0x10, 0x47, 0x1, 0x81, 0x0, 0x81, 0x0, 0x1, 0xf, 0x47, 0x1, 0xc0, 0x0, 0x=
c0, 0x0, 0x1, 0x20, 0x2a, 0x10, 0x2, 0x79, 0x0 })
            }
            Device(MATH) {
                Name(_HID, 0x040cd041)
                Name(_CRS, Buffer(0xe) {0x47, 0x1, 0xf0, 0x0, 0xf0, 0x0, 0x=
1, 0xf, 0x23, 0x0, 0x20, 0x1, 0x79, 0x0 })
            }
            Device(PIC_) {
                Name(_HID, 0xd041)
                Name(_CRS, Buffer(0x16) {0x47, 0x1, 0x20, 0x0, 0x20, 0x0, 0=
x1, 0x2, 0x47, 0x1, 0xa0, 0x0, 0xa0, 0x0, 0x1, 0x2, 0x23, 0x4, 0x0, 0x1, 0x=
79, 0x0 })
            }
            Device(RTC_) {
                Name(_HID, 0x000bd041)
                Name(_CRS, Buffer(0xe) {0x47, 0x1, 0x70, 0x0, 0x70, 0x0, 0x=
1, 0x2, 0x23, 0x0, 0x1, 0x1, 0x79, 0x0 })
            }
            Device(SPKR) {
                Name(_HID, 0x0008d041)
                Name(_CRS, Buffer(0xa) {0x47, 0x1, 0x61, 0x0, 0x61, 0x0, 0x=
1, 0x1, 0x79, 0x0 })
            }
            Device(TIME) {
                Name(_HID, 0x0001d041)
                Name(_CRS, Buffer(0xe) {0x47, 0x1, 0x40, 0x0, 0x40, 0x0, 0x=
1, 0x4, 0x23, 0x1, 0x0, 0x1, 0x79, 0x0 })
            }
            Device(LNKA) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x1)
                Name(_PRS, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Or(PIRA, 0x80, PIRA)
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRA, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRA, 0x70, ), PIRA)
                }
                Method(_STA) {
                    If(And(PIRA, 0x80, )) {
                        Return(0x9)
                    }
                    Return(0xb)
                }
            }
            Device(LNKB) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x2)
                Name(_PRS, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Or(PIRB, 0x80, PIRB)
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRB, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRB, 0x70, ), PIRB)
                }
                Method(_STA) {
                    If(And(PIRB, 0x80, )) {
                        Return(0x9)
                    }
                    Return(0xb)
                }
            }
            Device(LNKC) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x3)
                Name(_PRS, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Or(PIRC, 0x80, PIRC)
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRC, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRC, 0x70, ), PIRC)
                }
                Method(_STA) {
                    If(And(PIRC, 0x80, )) {
                        Return(0x9)
                    }
                    Return(0xb)
                }
            }
            Device(LNKD) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x4)
                Name(_PRS, Buffer(0x6) {0x23, 0x20, 0x0, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Or(PIRD, 0x80, PIRD)
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRD, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRD, 0x70, ), PIRD)
                }
                Method(_STA) {
                    If(And(PIRD, 0x80, )) {
                        Return(0x9)
                    }
                    Return(0xb)
                }
            }
            Device(LNKE) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x5)
                Name(_PRS, Buffer(0x6) {0x23, 0xb8, 0x1a, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Name(INES, 0x0)
                Method(_DIS) {
                    If(Or(LEqual(\_SB_.PCI0.MYOS, 0x0), LEqual(\_SB_.PCI0.M=
YOS, 0x2), )) {
                        Or(PIRE, 0x80, PIRE)
                    }
                    Else {
                        Or(PIRE, 0x80, PIRE)
                    }
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRE, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRE, 0x70, ), PIRE)
                    Store(PIRE, INES)
                }
                Method(_STA) {
                    If(Or(LEqual(\_SB_.PCI0.MYOS, 0x0), LEqual(\_SB_.PCI0.M=
YOS, 0x2), )) {
                        If(And(PIRE, 0x80, )) {
                            Return(0x9)
                        }
                    }
                    Else {
                        If(And(PIRE, 0x80, )) {
                            Return(0x9)
                        }
                    }
                    Return(0xb)
                }
            }
            Device(LNKF) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x6)
                Name(_PRS, Buffer(0x6) {0x23, 0xb8, 0x1a, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Or(PIRF, 0x80, PIRF)
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRF, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRF, 0x70, ), PIRF)
                }
                Method(_STA) {
                    If(And(PIRF, 0x80, )) {
                        Return(0x9)
                    }
                    Return(0xb)
                }
            }
            Device(LNKG) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x7)
                Name(_PRS, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Or(PIRG, 0x80, PIRG)
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRG, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRG, 0x70, ), PIRG)
                }
                Method(_STA) {
                    If(And(PIRG, 0x80, )) {
                        Return(0x9)
                    }
                    Return(0xb)
                }
            }
            Device(LNKH) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x8)
                Name(_PRS, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
                Name(RSRC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Or(PIRH, 0x80, PIRH)
                }
                Method(_CRS) {
                    CreateWordField(RSRC, 0x1, IRQ0)
                    And(PIRH, 0xf, Local0)
                    ShiftLeft(0x1, Local0, IRQ0)
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRQ0)
                    FindSetRightBit(IRQ0, Local0)
                    Decrement(Local0)
                    Or(Local0, And(PIRH, 0x70, ), PIRH)
                }
                Method(_STA) {
                    If(And(PIRH, 0x80, )) {
                        Return(0x9)
                    }
                    Return(0xb)
                }
            }
            OperationRegion(GPOX, SystemIO, 0x1180, 0x40)
            Field(GPOX, DWordAcc, Lock, Preserve) {
                Offset(0x7),
                ,	1,
                IO25,	1,
                ,	1,
                IO27,	1,
                Offset(0xe),
                LV16,	1,
                LV17,	1,
                Offset(0xf),
                ,	1,
                LV25,	1,
                ,	1,
                LV27,	1,
                Offset(0x1b),
                ,	1,
                BL25,	1,
                ,	1,
                BL27,	1,
                Offset(0x38),
                RBID,	2,
                LV34,	1,
                LV35,	1,
                LV36,	1,
                LV37,	1,
                LV38,	1,
                LV39,	1
            }
            OperationRegion(PMIO, SystemIO, 0x1000, 0x51)
            Field(PMIO, WordAcc, Lock, Preserve) {
                AccessAs(DWordAcc, 0),
                Offset(0x29),
                ,	3,
                PMES,	1,
                Offset(0x2b),
                ,	3,
                PMEE,	1,
                Offset(0x2c),
                GPI0,	1,
                GPI1,	1,
                GPI2,	1,
                GPI3,	1,
                GPI4,	1,
                GPI5,	1,
                GPI6,	1,
                GPI7,	1,
                GPI8,	1,
                GPI9,	1,
                GPIA,	1,
                GPIB,	1,
                GPIC,	1,
                GPID,	1,
                GPIE,	1,
                GPIF,	1,
                ,	6,
                GPEE,	1
            }
            Device(KBC_) {
                Name(_HID, 0x0303d041)
                Name(_CRS, Buffer(0x15) {0x47, 0x1, 0x60, 0x0, 0x60, 0x0, 0=
x1, 0x1, 0x47, 0x1, 0x64, 0x0, 0x64, 0x0, 0x1, 0x1, 0x22, 0x2, 0x0, 0x79, 0=
x0 })
                Method(_STA) {
                    Return(0xf)
                }
            }
            Device(MOUE) {
                Name(_HID, 0x80374d24)
                Name(_CID, 0x130fd041)
                Name(_CRS, Buffer(0x5) {0x22, 0x0, 0x10, 0x79, 0x0 })
                Method(_STA) {
                    If(LEqual(SizeOf(\_OS_), 0x14)) {
                        Return(0x0)
                    }
                    Else {
                        If(\_SB_.PS2M) {
                            Return(0xf)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                }
            }
            Device(MOU2) {
                Name(_HID, 0x130fd041)
                Name(_CRS, Buffer(0x5) {0x22, 0x0, 0x10, 0x79, 0x0 })
                Method(_STA) {
                    If(LEqual(SizeOf(\_OS_), 0x14)) {
                        If(\_SB_.PS2M) {
                            Return(0xf)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Else {
                        Return(0x0)
                    }
                }
            }
            Device(SIO_) {
                Name(_HID, 0x050ad041)
                OperationRegion(SIIO, SystemIO, 0x4e, 0x2)
                Field(SIIO, ByteAcc, NoLock, Preserve) {
                    INDX,	8,
                    DATA,	8
                }
                Mutex(N393, 0)
                Method(SETD, 1, Serialized) {
                    Store(0x7, INDX)
                    Store(Arg0, DATA)
                }
                Method(READ, 1, Serialized) {
                    Store(Arg0, INDX)
                    Store(DATA, Local0)
                    Return(Local0)
                }
                Method(WRIT, 2, Serialized) {
                    Store(Arg0, INDX)
                    Store(Arg1, DATA)
                }
                Method(LDRS, 3) {
                    Acquire(N393, 0xffff)
                    Store(0x7, INDX)
                    Store(Arg0, DATA)
                    Store(Arg1, INDX)
                    Store(Arg2, DATA)
                    Release(N393)
                }
                Method(LDRG, 2) {
                    Acquire(N393, 0xffff)
                    Store(0x7, INDX)
                    Store(Arg0, DATA)
                    Store(Arg1, INDX)
                    Store(DATA, Local0)
                    Release(N393)
                    Return(Local0)
                }
                Method(RCF6, 1) {
                    Acquire(N393, 0xffff)
                    Store(0x26, INDX)
                    Store(DATA, Local0)
                    And(Local0, Arg0, Local0)
                    Release(N393)
                    Return(XOr(Local0, Arg0, ))
                }
                Method(PDRS, 2) {
                    If(\_SB_.PCI0.LPC0.POSD) {
                        If(LEqual(Arg0, 0x0)) {
                            If(LEqual(Arg1, 0x03f0)) {
                                Store(0x0, Local0)
                            }
                            Else {
                                If(LEqual(Arg1, 0x0370)) {
                                    Store(0x1, Local0)
                                }
                            }
                            Store(Local0, \_SB_.PCI0.LPC0.FDDD)
                        }
                        Else {
                            If(LEqual(Arg0, 0x1)) {
                                If(LEqual(Arg1, 0x0378)) {
                                    Store(0x0, Local0)
                                }
                                Else {
                                    If(LEqual(Arg1, 0x0278)) {
                                        Store(0x1, Local0)
                                    }
                                    Else {
                                        If(LEqual(Arg1, 0x03bc)) {
                                            Store(0x2, Local0)
                                        }
                                    }
                                }
                                Store(Local0, \_SB_.PCI0.LPC0.LPTD)
                            }
                            Else {
                                If(LEqual(Arg1, 0x03f8)) {
                                    Store(0x0, Local0)
                                }
                                Else {
                                    If(LEqual(Arg1, 0x02f8)) {
                                        Store(0x1, Local0)
                                    }
                                    Else {
                                        If(LEqual(Arg1, 0x0220)) {
                                            Store(0x2, Local0)
                                        }
                                        Else {
                                            If(LEqual(Arg1, 0x0228)) {
                                                Store(0x3, Local0)
                                            }
                                            Else {
                                                If(LEqual(Arg1, 0x0238)) {
                                                    Store(0x4, Local0)
                                                }
                                                Else {
                                                    If(LEqual(Arg1, 0x02e8)=
) {
                                                        Store(0x5, Local0)
                                                    }
                                                    Else {
                                                        If(LEqual(Arg1, 0x0=
338)) {
                                                            Store(0x6, Loca=
l0)
                                                        }
                                                        Else {
                                                            If(LEqual(Arg1,=
 0x03e8)) {
                                                                Store(0x7, =
Local0)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                If(LEqual(Arg0, 0x2)) {
                                    Store(Local0, \_SB_.PCI0.LPC0.CMBD)
                                }
                                Else {
                                    If(LEqual(Arg0, 0x3)) {
                                        Store(Local0, \_SB_.PCI0.LPC0.CMAD)
                                    }
                                }
                            }
                        }
                        Return(0x1)
                    }
                    Else {
                        Return(0x0)
                    }
                }
                Device(ECP_) {
                    Name(_HID, 0x0104d041)
                    Name(_UID, 0x3)
                    Method(_STA) {
                        Store(LDRG(0x1, 0xf0), Local0)
                        ShiftRight(Local0, 0x5, Local0)
                        If(LAnd(RCF6(0x2), LOr(LEqual(Local0, 0x4), LEqual(=
Local0, 0x7)))) {
                            ShiftLeft(LDRG(0x1, 0x30), 0x1, Local1)
                            Add(0xd, Local1, Local1)
                            Return(Local1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_PS0) {
                        LDRS(0x1, 0x30, 0x1)
                    }
                    Method(_PS3) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_PRS) {
                        Return(Buffer(0xbb) {0x30, 0x47, 0x1, 0x78, 0x3, 0x=
78, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0=
x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, =
0x1, 0x78, 0x6, 0x78, 0x6, 0x8, 0x8, 0x22, 0x20, 0x0, 0x2a, 0x8, 0x0, 0x30,=
 0x47, 0x1, 0x78, 0x3, 0x78, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7=
, 0x8, 0x8, 0x22, 0x20, 0x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x=
78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, 0x78, 0x6, 0x8, 0x8, 0x22, 0x80, 0=
x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0x78, 0x3, 0x78, 0x3, 0x8, 0x8, 0x47, =
0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0x0, 0x2a, 0x2, 0x0, 0x30,=
 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, 0x78, 0x6=
, 0x8, 0x8, 0x22, 0x20, 0x0, 0x2a, 0x2, 0x0, 0x30, 0x47, 0x1, 0x78, 0x3, 0x=
78, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x20, 0=
x0, 0x2a, 0x2, 0x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, =
0x1, 0x78, 0x6, 0x78, 0x6, 0x8, 0x8, 0x22, 0x80, 0x0, 0x2a, 0x2, 0x0, 0x38,=
 0x79, 0x0 })
                    }
                    Method(_DIS) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_CRS) {
                        Name(DCRS, Buffer(0x18) {0x47, 0x1, 0x78, 0x3, 0x78=
, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0x0=
, 0x2a, 0x8, 0x0, 0x79, 0x0 })
                        Store(LDRG(0x1, 0x60), Local1)
                        Store(LDRG(0x1, 0x61), Local0)
                        Store(Local0, Index(DCRS, 0x2, ))
                        Store(Local0, Index(DCRS, 0xa, ))
                        Store(Local0, Index(DCRS, 0x4, ))
                        Store(Local0, Index(DCRS, 0xc, ))
                        Store(Local1, Index(DCRS, 0x3, ))
                        Store(Local1, Index(DCRS, 0x5, ))
                        Add(Local1, 0x4, Local1)
                        Store(Local1, Index(DCRS, 0xb, ))
                        Store(Local1, Index(DCRS, 0xd, ))
                        ShiftLeft(0x1, LDRG(0x1, 0x70), Local0)
                        Store(Local0, Index(DCRS, 0x11, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0x12, ))
                        ShiftLeft(0x1, LDRG(0x1, 0x74), Local0)
                        Store(Local0, Index(DCRS, 0x14, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0x15, ))
                        Return(DCRS)
                    }
                    Method(_SRS, 1) {
                        CreateByteField(Arg0, 0x2, ADRL)
                        CreateByteField(Arg0, 0x3, ADRM)
                        CreateWordField(Arg0, 0x11, IRQM)
                        CreateWordField(Arg0, 0x14, DMAM)
                        FindSetRightBit(IRQM, Local0)
                        Decrement(Local0)
                        FindSetRightBit(DMAM, Local1)
                        Decrement(Local1)
                        LDRS(0x1, 0x70, Local0)
                        LDRS(0x1, 0x74, Local1)
                        LDRS(0x1, 0x60, ADRM)
                        LDRS(0x1, 0x61, ADRL)
                        LDRS(0x1, 0x30, 0x1)
                    }
                }
                Device(EPP_) {
                    Name(_HID, 0x0004d041)
                    Name(_UID, 0x2)
                    Method(_STA) {
                        Store(LDRG(0x1, 0xf0), Local0)
                        ShiftRight(Local0, 0x5, Local0)
                        If(LAnd(RCF6(0x2), LOr(LEqual(Local0, 0x2), LEqual(=
Local0, 0x3)))) {
                            ShiftLeft(LDRG(0x1, 0x30), 0x1, Local1)
                            Add(0xd, Local1, Local1)
                            Return(Local1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_PS0) {
                        LDRS(0x1, 0x30, 0x1)
                    }
                    Method(_PS3) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_PRS) {
                        Return(Buffer(0x7b) {0x30, 0x47, 0x1, 0x78, 0x3, 0x=
78, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0=
x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, =
0x78, 0x6, 0x8, 0x8, 0x22, 0x20, 0x0, 0x30, 0x47, 0x1, 0x78, 0x3, 0x78, 0x3=
, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x20, 0x0, 0x3=
0, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, 0x78, 0=
x6, 0x8, 0x8, 0x22, 0x80, 0x0, 0x30, 0x47, 0x1, 0x78, 0x1, 0x78, 0x1, 0x8, =
0x8, 0x47, 0x1, 0x78, 0x5, 0x78, 0x5, 0x8, 0x8, 0x22, 0x80, 0x0, 0x30, 0x47=
, 0x1, 0x78, 0x1, 0x78, 0x1, 0x8, 0x8, 0x47, 0x1, 0x78, 0x5, 0x78, 0x5, 0x8=
, 0x8, 0x22, 0x20, 0x0, 0x38, 0x79, 0x0 })
                    }
                    Method(_DIS) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_CRS) {
                        Name(DCRS, Buffer(0x15) {0x47, 0x1, 0x78, 0x3, 0x78=
, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0x0=
, 0x79, 0x0 })
                        Store(LDRG(0x1, 0x60), Local1)
                        Store(LDRG(0x1, 0x61), Local0)
                        Store(Local0, Index(DCRS, 0x2, ))
                        Store(Local0, Index(DCRS, 0xa, ))
                        Store(Local0, Index(DCRS, 0x4, ))
                        Store(Local0, Index(DCRS, 0xc, ))
                        Store(Local1, Index(DCRS, 0x3, ))
                        Store(Local1, Index(DCRS, 0x5, ))
                        Add(Local1, 0x4, Local1)
                        Store(Local1, Index(DCRS, 0xb, ))
                        Store(Local1, Index(DCRS, 0xd, ))
                        ShiftLeft(0x1, LDRG(0x1, 0x70), Local0)
                        Store(Local0, Index(DCRS, 0x11, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0x12, ))
                        Return(DCRS)
                    }
                    Method(_SRS, 1) {
                        CreateByteField(Arg0, 0x2, ADRL)
                        CreateByteField(Arg0, 0x3, ADRM)
                        CreateWordField(Arg0, 0x11, IRQM)
                        FindSetRightBit(IRQM, Local0)
                        Decrement(Local0)
                        LDRS(0x1, 0x70, Local0)
                        LDRS(0x1, 0x60, ADRM)
                        LDRS(0x1, 0x61, ADRL)
                        LDRS(0x1, 0x30, 0x1)
                    }
                }
                Device(LPTB) {
                    Name(_HID, 0x0004d041)
                    Name(_UID, 0x1)
                    Method(_STA) {
                        Store(LDRG(0x1, 0xf0), Local0)
                        ShiftRight(Local0, 0x5, Local0)
                        If(LAnd(RCF6(0x2), LEqual(Local0, 0x1))) {
                            ShiftLeft(LDRG(0x1, 0x30), 0x1, Local1)
                            Add(0xd, Local1, Local1)
                            Return(Local1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_PS0) {
                        LDRS(0x1, 0x30, 0x1)
                    }
                    Method(_PS3) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_PRS) {
                        Return(Buffer(0x7b) {0x30, 0x47, 0x1, 0x78, 0x3, 0x=
78, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0=
x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, =
0x78, 0x6, 0x8, 0x8, 0x22, 0x20, 0x0, 0x30, 0x47, 0x1, 0x78, 0x3, 0x78, 0x3=
, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x20, 0x0, 0x3=
0, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, 0x78, 0=
x6, 0x8, 0x8, 0x22, 0x80, 0x0, 0x30, 0x47, 0x1, 0xbc, 0x3, 0xbc, 0x3, 0x4, =
0x4, 0x47, 0x1, 0xbc, 0x7, 0xbc, 0x7, 0x4, 0x4, 0x22, 0x80, 0x0, 0x30, 0x47=
, 0x1, 0xbc, 0x3, 0xbc, 0x3, 0x4, 0x4, 0x47, 0x1, 0xbc, 0x7, 0xbc, 0x7, 0x4=
, 0x4, 0x22, 0x20, 0x0, 0x38, 0x79, 0x0 })
                    }
                    Method(_DIS) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_CRS) {
                        Name(DCRS, Buffer(0x15) {0x47, 0x1, 0x78, 0x3, 0x78=
, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0x0=
, 0x79, 0x0 })
                        Store(LDRG(0x1, 0x60), Local1)
                        Store(LDRG(0x1, 0x61), Local0)
                        Store(Local0, Index(DCRS, 0x2, ))
                        Store(Local0, Index(DCRS, 0xa, ))
                        Store(Local0, Index(DCRS, 0x4, ))
                        Store(Local0, Index(DCRS, 0xc, ))
                        Store(Local1, Index(DCRS, 0x3, ))
                        Store(Local1, Index(DCRS, 0x5, ))
                        Add(Local1, 0x4, Local1)
                        Store(Local1, Index(DCRS, 0xb, ))
                        Store(Local1, Index(DCRS, 0xd, ))
                        If(And(Local0, 0x4, )) {
                            Store(0x4, Local0)
                        }
                        Else {
                            Store(0x8, Local0)
                        }
                        Store(Local0, Index(DCRS, 0x6, ))
                        Store(Local0, Index(DCRS, 0x7, ))
                        Store(Local0, Index(DCRS, 0xe, ))
                        Store(Local0, Index(DCRS, 0xf, ))
                        ShiftLeft(0x1, LDRG(0x1, 0x70), Local0)
                        Store(Local0, Index(DCRS, 0x11, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0x12, ))
                        Return(DCRS)
                    }
                    Method(_SRS, 1) {
                        CreateByteField(Arg0, 0x2, ADRL)
                        CreateByteField(Arg0, 0x3, ADRM)
                        CreateWordField(Arg0, 0x11, IRQM)
                        FindSetRightBit(IRQM, Local0)
                        Decrement(Local0)
                        LDRS(0x1, 0x70, Local0)
                        LDRS(0x1, 0x60, ADRM)
                        LDRS(0x1, 0x61, ADRL)
                        LDRS(0x1, 0x30, 0x1)
                    }
                }
                Device(LPT_) {
                    Name(_HID, 0x0004d041)
                    Name(_UID, 0x0)
                    Method(_STA) {
                        Store(LDRG(0x1, 0xf0), Local0)
                        ShiftRight(Local0, 0x5, Local0)
                        If(LAnd(RCF6(0x2), LEqual(Local0, 0x0))) {
                            ShiftLeft(LDRG(0x1, 0x30), 0x1, Local1)
                            Add(0xd, Local1, Local1)
                            Return(Local1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_PS0) {
                        LDRS(0x1, 0x30, 0x1)
                    }
                    Method(_PS3) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_PRS) {
                        Return(Buffer(0x7b) {0x30, 0x47, 0x1, 0x78, 0x3, 0x=
78, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0=
x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, =
0x78, 0x6, 0x8, 0x8, 0x22, 0x20, 0x0, 0x30, 0x47, 0x1, 0x78, 0x3, 0x78, 0x3=
, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x20, 0x0, 0x3=
0, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x8, 0x8, 0x47, 0x1, 0x78, 0x6, 0x78, 0=
x6, 0x8, 0x8, 0x22, 0x80, 0x0, 0x30, 0x47, 0x1, 0xbc, 0x3, 0xbc, 0x3, 0x4, =
0x4, 0x47, 0x1, 0xbc, 0x7, 0xbc, 0x7, 0x4, 0x4, 0x22, 0x80, 0x0, 0x30, 0x47=
, 0x1, 0xbc, 0x3, 0xbc, 0x3, 0x4, 0x4, 0x47, 0x1, 0xbc, 0x7, 0xbc, 0x7, 0x4=
, 0x4, 0x22, 0x20, 0x0, 0x38, 0x79, 0x0 })
                    }
                    Method(_DIS) {
                        LDRS(0x1, 0x30, 0x0)
                    }
                    Method(_CRS) {
                        Name(DCRS, Buffer(0x15) {0x47, 0x1, 0x78, 0x3, 0x78=
, 0x3, 0x8, 0x8, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x8, 0x8, 0x22, 0x80, 0x0=
, 0x79, 0x0 })
                        Store(LDRG(0x1, 0x60), Local1)
                        Store(LDRG(0x1, 0x61), Local0)
                        Store(Local0, Index(DCRS, 0x2, ))
                        Store(Local0, Index(DCRS, 0xa, ))
                        Store(Local0, Index(DCRS, 0x4, ))
                        Store(Local0, Index(DCRS, 0xc, ))
                        Store(Local1, Index(DCRS, 0x3, ))
                        Store(Local1, Index(DCRS, 0x5, ))
                        Add(Local1, 0x4, Local1)
                        Store(Local1, Index(DCRS, 0xb, ))
                        Store(Local1, Index(DCRS, 0xd, ))
                        If(And(Local0, 0x4, )) {
                            Store(0x4, Local0)
                        }
                        Else {
                            Store(0x8, Local0)
                        }
                        Store(Local0, Index(DCRS, 0x6, ))
                        Store(Local0, Index(DCRS, 0x7, ))
                        Store(Local0, Index(DCRS, 0xe, ))
                        Store(Local0, Index(DCRS, 0xf, ))
                        ShiftLeft(0x1, LDRG(0x1, 0x70), Local0)
                        Store(Local0, Index(DCRS, 0x11, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0x12, ))
                        Return(DCRS)
                    }
                    Method(_SRS, 1) {
                        CreateByteField(Arg0, 0x2, ADRL)
                        CreateByteField(Arg0, 0x3, ADRM)
                        CreateWordField(Arg0, 0x11, IRQM)
                        FindSetRightBit(IRQM, Local0)
                        Decrement(Local0)
                        LDRS(0x1, 0x70, Local0)
                        LDRS(0x1, 0x60, ADRM)
                        LDRS(0x1, 0x61, ADRL)
                        LDRS(0x1, 0x30, 0x1)
                    }
                }
                Device(COMA) {
                    Name(_HID, 0x0105d041)
                    Name(_UID, 0x0)
                    Method(_STA) {
                        If(RCF6(0x8)) {
                            ShiftLeft(LDRG(0x3, 0x30), 0x1, Local1)
                            Add(0xd, Local1, Local1)
                            Return(Local1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_PS0) {
                        LDRS(0x3, 0x30, 0x1)
                    }
                    Method(_PS3) {
                        LDRS(0x3, 0x30, 0x0)
                    }
                    Method(_PRS) {
                        Return(Buffer(0x63) {0x30, 0x47, 0x1, 0xf8, 0x3, 0x=
f8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, =
0x8, 0x8, 0x22, 0x8, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, =
0x22, 0x10, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x8=
, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x8, 0x0, 0x3=
0, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x10, 0x0, 0x30, 0x47, =
0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x8, 0x0, 0x30, 0x47, 0x1, 0xe8,=
 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x10, 0x0, 0x38, 0x79, 0x0 })
                    }
                    Method(_DIS) {
                        LDRS(0x3, 0x30, 0x0)
                    }
                    Method(_CRS) {
                        Name(DCRS, Buffer(0xd) {0x47, 0x1, 0xf8, 0x3, 0xf8,=
 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x79, 0x0 })
                        Store(LDRG(0x3, 0x60), Local1)
                        Store(LDRG(0x3, 0x61), Local0)
                        Store(Local0, Index(DCRS, 0x2, ))
                        Store(Local0, Index(DCRS, 0x4, ))
                        Store(Local1, Index(DCRS, 0x3, ))
                        Store(Local1, Index(DCRS, 0x5, ))
                        ShiftLeft(0x1, LDRG(0x3, 0x70), Local0)
                        Store(Local0, Index(DCRS, 0x9, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0xa, ))
                        Return(DCRS)
                    }
                    Method(_SRS, 1) {
                        CreateByteField(Arg0, 0x2, ADRL)
                        CreateByteField(Arg0, 0x3, ADRM)
                        CreateWordField(Arg0, 0x9, IRQM)
                        FindSetRightBit(IRQM, Local0)
                        Decrement(Local0)
                        LDRS(0x3, 0x70, Local0)
                        LDRS(0x3, 0x60, ADRM)
                        LDRS(0x3, 0x61, ADRL)
                        LDRS(0x3, 0x30, 0x1)
                    }
                }
                Device(FIR_) {
                    Method(_HID) {
                        If(LOr(LEqual(MYOS, 0x1), LEqual(MYOS, 0x3))) {
                            Return(0x0160633a)
                        }
                        Else {
                            Return(0x0160633a)
                        }
                    }
                    Name(_UID, 0x0)
                    Method(_STA) {
                        Store(LDRG(0x2, 0x74), Local0)
                        If(LAnd(RCF6(0x4), LNot(LEqual(Local0, 0x4)))) {
                            ShiftLeft(LDRG(0x2, 0x30), 0x1, Local1)
                            Add(0xd, Local1, Local1)
                            Return(Local1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_PS0) {
                        LDRS(0x2, 0x30, 0x1)
                    }
                    Method(_PS3) {
                        LDRS(0x2, 0x30, 0x0)
                    }
                    Method(_PRS) {
                        Return(Buffer(0x016b) {0x30, 0x47, 0x1, 0xf8, 0x3, =
0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x1, 0x0, 0x30, 0x47, 0x1, 0xf8=
, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x1, 0x0, 0x30, 0x47, 0x1=
, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x1, 0x0, 0x30, 0x=
47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x1, 0x0, 0x=
30, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x1, 0=
x0, 0x30, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a,=
 0x1, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x8, 0x0,=
 0x2a, 0x1, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x1=
0, 0x0, 0x2a, 0x1, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x=
22, 0x10, 0x0, 0x2a, 0x2, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8, =
0x8, 0x22, 0x8, 0x0, 0x2a, 0x2, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0x3,=
 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x2, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x2, 0xe=
8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x2, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x=
3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x2, 0x0, 0x30, 0x47, 0x1, 0x=
f8, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x2, 0x0, 0x30, 0x47, =
0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x2, 0x0, 0x30, =
0x47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x2, 0x0,=
 0x30, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x=
8, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x=
2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x10, =
0x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22,=
 0x8, 0x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8,=
 0x22, 0x8, 0x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8=
, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0=
x3, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x8, 0x0, 0x30, 0x47, 0x1, 0xe8, 0x2, 0=
xe8, 0x2, 0x8, 0x8, 0x22, 0x10, 0x0, 0x2a, 0x8, 0x0, 0x38, 0x79, 0x0 })
                    }
                    Method(_DIS) {
                        LDRS(0x2, 0x30, 0x0)
                        Store(0x0, \_SB_.PCI0.LPC0.ECO1)
                    }
                    Method(_CRS) {
                        Name(DCRS, Buffer(0x10) {0x47, 0x1, 0xf8, 0x2, 0xf8=
, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x2a, 0x1, 0x0, 0x79, 0x0 })
                        Store(LDRG(0x2, 0x60), Local1)
                        Store(LDRG(0x2, 0x61), Local0)
                        Store(Local0, Index(DCRS, 0x2, ))
                        Store(Local0, Index(DCRS, 0x4, ))
                        Store(Local1, Index(DCRS, 0x3, ))
                        Store(Local1, Index(DCRS, 0x5, ))
                        ShiftLeft(0x1, LDRG(0x2, 0x70), Local0)
                        Store(Local0, Index(DCRS, 0x9, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0xa, ))
                        ShiftLeft(0x1, LDRG(0x2, 0x74), Local0)
                        Store(Local0, Index(DCRS, 0xc, ))
                        ShiftRight(Local0, 0x8, Local1)
                        Store(Local1, Index(DCRS, 0xd, ))
                        Return(DCRS)
                    }
                    Method(_SRS, 1) {
                        Store(0x1, \_SB_.PCI0.LPC0.ECO1)
                        CreateByteField(Arg0, 0x2, ADRL)
                        CreateByteField(Arg0, 0x3, ADRM)
                        CreateWordField(Arg0, 0x9, IRQM)
                        CreateWordField(Arg0, 0xc, DMAM)
                        FindSetRightBit(IRQM, Local0)
                        Decrement(Local0)
                        FindSetRightBit(DMAM, Local1)
                        Decrement(Local1)
                        LDRS(0x2, 0x70, Local0)
                        LDRS(0x2, 0x74, Local1)
                        LDRS(0x2, 0x60, ADRM)
                        LDRS(0x2, 0x61, ADRL)
                        PDRS(0x2, Add(ShiftLeft(ADRM, 0x8, ), ADRL, ))
                        LDRS(0x2, 0x30, 0x1)
                    }
                }
            }
            Device(EC0_) {
                Name(_HID, 0x090cd041)
                Name(_CRS, Buffer(0x12) {0x47, 0x1, 0x62, 0x0, 0x62, 0x0, 0=
x1, 0x1, 0x47, 0x1, 0x66, 0x0, 0x66, 0x0, 0x1, 0x1, 0x79, 0x0 })
                Name(_GPE, 0x1d)
                Name(OSEJ, 0x0)
                Method(_REG, 2) {
                    If(LEqual(Arg0, 0x3)) {
                        Store(Arg1, \_SB_.OKEC)
                        If(Or(LEqual(\_SB_.PCI0.MYOS, 0x3), LEqual(\_SB_.PC=
I0.MYOS, 0x1), )) {
                            If(Arg1) {
                                Store(0x1, \_SB_.PCI0.LPC0.EC0_.RG57)
                            }
                        }
                    }
                }
                OperationRegion(ERAM, EmbeddedControl, 0x0, 0xff)
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x4),
                    CMCM,	8,
                    CMD1,	8,
                    CMD2,	8,
                    CMD3,	8,
                    Offset(0x18),
                    SMPR,	8,
                    SMST,	8,
                    SMAD,	8,
                    SMCM,	8,
                    SMD0,	256,
                    BCNT,	8,
                    SMAA,	8,
                    BATD,	16,
                    ACDF,	1,
                    Offset(0x41),
                    ,	4,
                    FPR1,	1,
                    S4LD,	1,
                    S5LW,	1,
                    PFLG,	1,
                    Offset(0x43),
                    TMSS,	2,
                    ,	2,
                    BANK,	4,
                    Offset(0x45),
                    VFAN,	1,
                    Offset(0x46),
                    RL01,	1,
                    RD01,	1,
                    RF01,	1,
                    RP01,	1,
                    RB01,	1,
                    RC01,	1,
                    ,	1,
                    R701,	1,
                    R801,	1,
                    RM01,	1,
                    RI01,	1,
                    ,	1,
                    ,	1,
                    ,	1,
                    RA01,	1,
                    RR01,	1,
                    RL10,	1,
                    RD10,	1,
                    RF10,	1,
                    RP10,	1,
                    RB10,	1,
                    RC10,	1,
                    ,	1,
                    R710,	1,
                    R810,	1,
                    RM10,	1,
                    RI10,	1,
                    ,	1,
                    ,	1,
                    ,	1,
                    RA10,	1,
                    RR10,	1,
                    WL01,	1,
                    WD01,	1,
                    WF01,	1,
                    WP01,	1,
                    WB01,	1,
                    WC01,	1,
                    ,	1,
                    W701,	1,
                    W801,	1,
                    WM01,	1,
                    WI01,	1,
                    ,	1,
                    ,	1,
                    ,	1,
                    WA01,	1,
                    WR01,	1,
                    WL10,	1,
                    WD10,	1,
                    WF10,	1,
                    WP10,	1,
                    WB10,	1,
                    WC10,	1,
                    ,	1,
                    W710,	1,
                    W810,	1,
                    WM10,	1,
                    WI10,	1,
                    ,	1,
                    ,	1,
                    ,	1,
                    WA10,	1,
                    WR10,	1,
                    LIDE,	1,
                    BAYE,	1,
                    EFDE,	1,
                    PRDE,	1,
                    BRBE,	1,
                    CRTE,	1,
                    ,	1,
                    W7BE,	1,
                    W8BE,	1,
                    PMEE,	1,
                    INTE,	1,
                    ,	1,
                    ,	1,
                    ,	1,
                    DB2E,	1,
                    DB3E,	1,
                    Offset(0x52),
                    LIDS,	1,
                    BAYS,	1,
                    EFDS,	1,
                    PRDS,	1,
                    BRBS,	1,
                    CRTS,	1,
                    ,	1,
                    W7BS,	1,
                    W8BS,	1,
                    DPEM,	1,
                    DINT,	1,
                    ,	1,
                    ,	1,
                    ,	1,
                    DB2S,	1,
                    DB3S,	1,
                    Offset(0x57),
                    RG57,	8,
                    CTMP,	8,
                    RG59,	8,
                    RG5A,	8,
                    RG5B,	8,
                    FSPD,	16,
                    Offset(0x5f),
                    FAN2,	1,
                    SFN2,	1,
                    Offset(0x60),
                    ,	1,
                    FANC,	1,
                    Offset(0x70),
                    MBID,	8,
                    MBTS,	1,
                    MBTF,	1,
                    Offset(0x72),
                    MBTC,	1,
                    Offset(0x77),
                    BA1C,	8,
                    MBVG,	16,
                    MCUR,	16,
                    Offset(0x80),
                    SBID,	8,
                    SBTS,	1,
                    SBTF,	1,
                    Offset(0x82),
                    SBTC,	1,
                    Offset(0x87),
                    BA2C,	8,
                    ABVG,	16,
                    ACUR,	16,
                    Offset(0xc3),
                    MBRM,	16,
                    Offset(0xca),
                    ABRM,	16,
                    Offset(0xd0),
                    EBPL,	1,
                    Offset(0xd2),
                    ,	6,
                    APWR,	1,
                    Offset(0xd6),
                    DBPL,	8,
                    Offset(0xe7),
                    GQKS,	7
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    SMW0,	16
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    SMB0,	8
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    FLD0,	64
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    FLD1,	128
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    FLD2,	192
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    FLD3,	256
                }
                Mutex(MUT0, 0)
                Method(SMRD, 4) {
                    If(LNot(\_SB_.OKEC)) {
                        Return(0xff)
                    }
                    If(LNot(LEqual(Arg0, 0x7))) {
                        If(LNot(LEqual(Arg0, 0x9))) {
                            If(LNot(LEqual(Arg0, 0xb))) {
                                Return(0x19)
                            }
                        }
                    }
                    Acquire(MUT0, 0xffff)
                    Store(0x4, Local0)
                    While(LGreater(Local0, 0x1)) {
                        And(SMST, 0x40, SMST)
                        Store(Arg2, SMCM)
                        Store(Arg1, SMAD)
                        Store(Arg0, SMPR)
                        Store(0x0, Local3)
                        While(LNot(And(SMST, 0xbf, Local1))) {
                            Sleep(0x2)
                            Increment(Local3)
                            If(LEqual(Local3, 0x32)) {
                                And(SMST, 0x40, SMST)
                                Store(Arg2, SMCM)
                                Store(Arg1, SMAD)
                                Store(Arg0, SMPR)
                                Store(0x0, Local3)
                            }
                        }
                        If(LEqual(Local1, 0x80)) {
                            Store(0x0, Local0)
                        }
                        Else {
                            Decrement(Local0)
                        }
                    }
                    If(Local0) {
                        Store(And(Local1, 0x1f, ), Local0)
                    }
                    Else {
                        If(LEqual(Arg0, 0x7)) {
                            Store(SMB0, Arg3)
                        }
                        If(LEqual(Arg0, 0x9)) {
                            Store(SMW0, Arg3)
                        }
                        If(LEqual(Arg0, 0xb)) {
                            Store(BCNT, Local3)
                            ShiftRight(0x0100, 0x3, Local2)
                            If(LGreater(Local3, Local2)) {
                                Store(Local2, Local3)
                            }
                            If(LLess(Local3, 0x9)) {
                                Store(FLD0, Local2)
                            }
                            Else {
                                If(LLess(Local3, 0x11)) {
                                    Store(FLD1, Local2)
                                }
                                Else {
                                    If(LLess(Local3, 0x19)) {
                                        Store(FLD2, Local2)
                                    }
                                    Else {
                                        Store(FLD3, Local2)
                                    }
                                }
                            }
                            Increment(Local3)
                            Store(Buffer(Local3) { }, Local4)
                            Decrement(Local3)
                            Store(Zero, Local5)
                            While(LGreater(Local3, Local5)) {
                                GBFE(Local2, Local5, RefOf(Local6))
                                PBFE(Local4, Local5, Local6)
                                Increment(Local5)
                            }
                            PBFE(Local4, Local5, 0x0)
                            Store(Local4, Arg3)
                        }
                    }
                    Release(MUT0)
                    Return(Local0)
                }
                Method(SMWR, 4) {
                    If(LNot(\_SB_.OKEC)) {
                        Return(0xff)
                    }
                    If(LNot(LEqual(Arg0, 0x6))) {
                        If(LNot(LEqual(Arg0, 0x8))) {
                            If(LNot(LEqual(Arg0, 0xa))) {
                                Return(0x19)
                            }
                        }
                    }
                    Acquire(MUT0, 0xffff)
                    Store(0x4, Local0)
                    While(LGreater(Local0, 0x1)) {
                        If(LEqual(Arg0, 0x6)) {
                            Store(Arg3, SMB0)
                        }
                        If(LEqual(Arg0, 0x8)) {
                            Store(Arg3, SMW0)
                        }
                        If(LEqual(Arg0, 0xa)) {
                            Store(Arg3, SMD0)
                        }
                        And(SMST, 0x40, SMST)
                        Store(Arg2, SMCM)
                        Store(Arg1, SMAD)
                        Store(Arg0, SMPR)
                        Store(0x0, Local3)
                        While(LNot(And(SMST, 0xbf, Local1))) {
                            Sleep(0x2)
                            Increment(Local3)
                            If(LEqual(Local3, 0x32)) {
                                And(SMST, 0x40, SMST)
                                Store(Arg2, SMCM)
                                Store(Arg1, SMAD)
                                Store(Arg0, SMPR)
                                Store(0x0, Local3)
                            }
                        }
                        If(LEqual(Local1, 0x80)) {
                            Store(0x0, Local0)
                        }
                        Else {
                            Decrement(Local0)
                        }
                    }
                    If(Local0) {
                        Store(And(Local1, 0x1f, ), Local0)
                    }
                    Release(MUT0)
                    Return(Local0)
                }
                Method(BPOL, 1) {
                    Store(Arg0, DBPL)
                    Store(0x1, EBPL)
                }
                Name(ECUS, 0x0)
                Name(BATO, 0x0)
                Name(BATN, 0x0)
                Name(BATF, 0xc0)
                Method(_Q09) {
                    If(LEqual(SizeOf(\_OS_), 0x14)) {
                        Notify(\_SB_.BAT1, 0x80)
                        Notify(\_SB_.BAT1, 0x0)
                        Notify(\_SB_.BAT2, 0x80)
                        Notify(\_SB_.BAT2, 0x0)
                        Notify(\_SB_.ACAD, 0x0)
                    }
                    If(LEqual(SizeOf(\_OS_), 0x14)) {
                        BPOL(0x3c)
                    }
                }
                Method(_Q20) {
                    If(And(SMST, 0x40, )) {
                        Store(SMAA, Local0)
                        If(LEqual(Local0, 0x14)) {
                            SELE()
                            If(And(0x40, BATF, )) {
                                Notify(\_SB_.BAT1, 0x81)
                            }
                            If(And(0x80, BATF, )) {
                                Notify(\_SB_.BAT2, 0x81)
                            }
                            If(And(0x2, BATF, )) {
                                Notify(\_SB_.ACAD, 0x0)
                            }
                            Notify(\_SB_.BAT1, 0x80)
                            Notify(\_SB_.BAT2, 0x80)
                            Store(BATD, BATO)
                            And(SMST, 0xbf, SMST)
                        }
                    }
                }
                Method(SELE) {
                    Store(BATD, BATN)
                    Store(0x0, BATF)
                    If(And(0xc0, BATN, )) {
                        Or(BATF, 0x1, BATF)
                    }
                    If(And(0x0300, BATN, )) {
                        Or(BATF, 0x4, BATF)
                    }
                    And(BATN, 0x1, Local0)
                    And(BATO, 0x1, Local1)
                    If(Local0) {
                        Or(BATF, 0x0100, BATF)
                    }
                    Else {
                        And(BATF, 0xfeff, BATF)
                    }
                    If(Not(LEqual(Local0, Local1), )) {
                        Or(BATF, 0x40, BATF)
                    }
                    And(BATN, 0x2, Local0)
                    And(BATO, 0x2, Local1)
                    If(Local0) {
                        Or(BATF, 0x0200, BATF)
                    }
                    Else {
                        And(BATF, 0xfdff, BATF)
                    }
                    If(Not(LEqual(Local0, Local1), )) {
                        Or(BATF, 0x80, BATF)
                    }
                    And(BATN, 0xc0, Local0)
                    And(BATO, 0xc0, Local1)
                    If(Not(LEqual(Local0, Local1), )) {
                        Or(BATF, 0x2, BATF)
                    }
                    If(And(0x1, BATF, )) {
                        If(And(0x4, BATF, )) {
                            If(And(BATN, 0x20, )) {
                                Or(BATF, 0x10, BATF)
                            }
                            Else {
                                Or(BATF, 0x20, BATF)
                            }
                        }
                    }
                }
                Method(_Q0D) {
                    Store("Sleep Button Query: Fn+F4", Debug)
                    Notify(\_SB_.SLPB, 0x80)
                }
                Method(_Q0E) {
                    \_SB_.PCI0.AGP_.VGA_.SWIH()
                }
                Method(_Q0F) {
                    Store("Display blank: Fn+F6", Debug)
                    Not(LV16, Local0)
                    Store(Local0, LV16)
                }
                Method(_Q13) {
                    Store("Brightness Up: Fn+->", Debug)
                    Store(0x8c, \_SB_.PCI0.LPC0.BCMD)
                    Store(0x0, \_SB_.PCI0.LPC0.SMIC)
                }
                Method(_Q12) {
                    Store("Brightness Down: Fn+<-", Debug)
                    Store(0x8d, \_SB_.PCI0.LPC0.BCMD)
                    Store(0x0, \_SB_.PCI0.LPC0.SMIC)
                }
                Method(_Q80) {
                    Store("Temperature increasing: _Q80", Debug)
                    Notify(\_TZ_.THRM, 0x80)
                }
                Method(_Q81) {
                    Store("Temperature decreasing: _Q81", Debug)
                    Notify(\_TZ_.THRM, 0x80)
                }
                Event(EJT1)
                Method(_Q8A) {
                    Mutex(MUT0, 0)
                    Mutex(MUT1, 0)
                    Store("------------------_Q0x8A -----------------------=
=2D--------------", Debug)
                    If(LIDE) {
                        Store(0x1, LIDE)
                        Notify(\_SB_.LID_, 0x80)
                    }
                    If(DB2E) {
                        Store("-------- Device R-Bay Event ------", Debug)
                        Store(0x1, DB2E)
                        If(Or(LEqual(\_SB_.PCI0.MYOS, 0x1), LEqual(\_SB_.PC=
I0.MYOS, 0x3), )) {
                            If(DB2S) {
                                Store("----------- Device Bay Change Status=
 ---------- IN ", Debug)
                                Store(\_SB_.PCI0.LPC0.RBID, Local0)
                                Store(Local0, \_SB_.PCI0.IDE0.BAYR)
                                If(LEqual(Local0, 0x0)) {
                                    Store(0x0, \_SB_.PCI0.LPC0.LV37)
                                }
                                Else {
                                    Store(0x0, \_SB_.PCI0.LPC0.LV37)
                                    Store(0x0, \_SB_.PCI0.LPC0.LV39)
                                    Sleep(0x32)
                                    Store(0x1, \_SB_.PCI0.LPC0.LV39)
                                    Sleep(0x09c4)
                                    Store(0x1, \_SB_.PCI0.IDE0.SSIG)
                                    Store(0x1, \_SB_.PCI0.IDE0.UDC1)
                                    Store(0x2, \_SB_.PCI0.IDE0.UDT1)
                                    Or(\_SB_.PCI0.IDE0.FSCB, 0x4, \_SB_.PCI=
0.IDE0.FSCB)
                                    Store(0xe303, \_SB_.PCI0.IDE0.ITM1)
                                    Store(0x0, \_SB_.PCI0.IDE0.SSIG)
                                    Notify(\_SB_.PCI0.IDE0.SECN.BAY1, 0x0)
                                }
                            }
                            Else {
                                Store("-------- Device Bay Event ------ OUT=
 ", Debug)
                                Store(\_SB_.PCI0.IDE0.BAYR, Local0)
                                Store(0x1, \_SB_.PCI0.LPC0.LV37)
                                If(Or(LEqual(Local0, 0x1), LEqual(Local0, 0=
x2), )) {
                                    Notify(\_SB_.PCI0.IDE0.SECN.BAY1, 0x1)
                                }
                            }
                        }
                    }
                }
            }
            OperationRegion(SMI0, SystemIO, 0x0000fe00, 0x00000002)
            Field(SMI0, AnyAcc, NoLock, Preserve) {
                SMIC,	8
            }
            OperationRegion(SMI1, SystemMemory, 0x1ff7bebd, 0x00000090)
            Field(SMI1, AnyAcc, NoLock, Preserve) {
                BCMD,	8,
                DID_,	32,
                INFO,	1024
            }
            Field(SMI1, AnyAcc, NoLock, Preserve) {
                AccessAs(ByteAcc, 0),
                Offset(0x5),
                INF_,	8
            }
        }
        Device(MDM0) {
            Name(_ADR, 0x001f0006)
            Name(_PRW, Package(0x2) {
                0x5,
                0x3,
            })
        }
        Device(HUB_) {
            Name(_ADR, 0x001e0000)
            Name(_PRT, Package(0x5) {
                Package(0x4) {
                    0x0002ffff,
                    0x0,
                    \_SB_.PCI0.LPC0.LNKD,
                    0x0,
                },
                Package(0x4) {
                    0x0004ffff,
                    0x0,
                    \_SB_.PCI0.LPC0.LNKE,
                    0x0,
                },
                Package(0x4) {
                    0x0004ffff,
                    0x1,
                    \_SB_.PCI0.LPC0.LNKF,
                    0x0,
                },
                Package(0x4) {
                    0x0006ffff,
                    0x0,
                    \_SB_.PCI0.LPC0.LNKB,
                    0x0,
                },
                Package(0x4) {
                    0x0007ffff,
                    0x0,
                    \_SB_.PCI0.LPC0.LNKC,
                    0x0,
                },
            })
            Device(GLAN) {
                Name(_ADR, 0x00020000)
                Name(_PRW, Package(0x2) {
                    0xb,
                    0x5,
                })
            }
        }
        Device(IDE0) {
            Name(_ADR, 0x001f0001)
            OperationRegion(PCI_, PCI_Config, 0x0, 0x58)
            Field(PCI_, DWordAcc, NoLock, Preserve) {
                Offset(0x3),
                ,	7,
                SIDE,	1,
                Offset(0x42),
                ,	1,
                EIOR,	1,
                ,	13,
                ESID,	1,
                Offset(0x48),
                UMA0,	1,
                UMA1,	1,
                UMA2,	1,
                UMA3,	1,
                Offset(0x56),
                PSIG,	2,
                SSIG,	2
            }
            Field(PCI_, DWordAcc, NoLock, Preserve) {
                Offset(0x40),
                ITM0,	16,
                ITM1,	16,
                SIT0,	4,
                SIT1,	4,
                Offset(0x48),
                UDC0,	2,
                UDC1,	2,
                Offset(0x4a),
                UDT0,	8,
                UDT1,	8,
                Offset(0x54),
                ICF0,	2,
                ICF1,	2,
                CB80,	4,
                ,	2,
                WPPE,	1,
                ,	1,
                FSCB,	4,
                TRIP,	2,
                TRIS,	2,
                FATS,	4
            }
            Name(TIM0, Package(0x1) {
                Package(0x5) {
                    0x78,
                    0xb4,
                    0xf0,
                    0x0186,
                    0x0258,
                },
            })
            Name(TIM1, Package(0x1) {
                Package(0x3) {
                    0x78,
                    0x96,
                    0x01fe,
                },
            })
            Name(TIM2, Package(0x1) {
                Package(0x6) {
                    0x18,
                    0x1e,
                    0x2d,
                    0x3c,
                    0x5a,
                    0x78,
                },
            })
            Name(AT01, Buffer(0x7) {0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0xef })
            Name(AT02, Buffer(0x7) {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x90 })
            Name(AT03, Buffer(0x7) {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc6 })
            Name(AT04, Buffer(0x7) {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x91 })
            Name(ATA0, Buffer(0x1d) { })
            Name(ATA1, Buffer(0x1d) { })
            Name(ATA2, Buffer(0x1d) { })
            Name(ATA3, Buffer(0x1d) { })
            Name(ATAB, Buffer(0xe) { })
            Name(CMDC, 0x0)
            Name(BAYR, 0x0)
            Method(_INI) {
                Store(\_SB_.PCI0.LPC0.RBID, BAYR)
            }
            Method(GTFB, 3, Serialized) {
                Multiply(CMDC, 0x38, Local0)
                CreateField(ATAB, Local0, 0x38, CMDX)
                Multiply(CMDC, 0x7, Local0)
                CreateByteField(ATAB, Add(Local0, 0x1, ), A001)
                CreateByteField(ATAB, Add(Local0, 0x5, ), A005)
                Store(Arg0, CMDX)
                Store(Arg1, A001)
                Store(Arg2, A005)
                Increment(CMDC)
            }
            Mutex(GTFM, 0)
            Method(GTF_, 3, Serialized) {
                Acquire(GTFM, 0xffff)
                CreateDWordField(Arg2, 0x0, PIO0)
                CreateDWordField(Arg2, 0x4, DMA0)
                CreateDWordField(Arg2, 0x8, PIO1)
                CreateDWordField(Arg2, 0xc, DMA1)
                CreateDWordField(Arg2, 0x10, CHNF)
                Store(0x0, CMDC)
                Name(ID00, 0x80)
                Name(ID49, 0x0c00)
                Name(ID59, 0x0)
                Name(ID53, 0x4)
                Name(ID63, 0x0f00)
                Name(ID88, 0x0f00)
                Name(IRDY, 0x1)
                Name(PIOT, 0x0)
                Name(DMAT, 0x0)
                If(LEqual(SizeOf(Arg1), 0x0200)) {
                    CreateByteField(Arg1, 0x0, IB00)
                    Store(IB00, ID00)
                    CreateWordField(Arg1, 0x62, IW49)
                    Store(IW49, ID49)
                    CreateWordField(Arg1, 0x6a, IW53)
                    Store(IW53, ID53)
                    CreateWordField(Arg1, 0x7e, IW63)
                    Store(IW63, ID63)
                    CreateWordField(Arg1, 0x76, IW59)
                    Store(IW59, ID59)
                    CreateWordField(Arg1, 0xb0, IW88)
                    Store(IW88, ID88)
                }
                Else {
                    Return(ATAB)
                }
                Store(0xa0, Local7)
                If(Arg0) {
                    Store(0xb0, Local7)
                    And(CHNF, 0x8, IRDY)
                    If(And(CHNF, 0x10, )) {
                        Store(PIO1, PIOT)
                    }
                    Else {
                        Store(PIO0, PIOT)
                    }
                    If(And(CHNF, 0x4, )) {
                        If(And(CHNF, 0x10, )) {
                            Store(DMA1, DMAT)
                        }
                        Else {
                            Store(DMA0, DMAT)
                        }
                    }
                }
                Else {
                    And(CHNF, 0x2, IRDY)
                    Store(PIO0, PIOT)
                    If(And(CHNF, 0x1, )) {
                        Store(DMA0, DMAT)
                    }
                }
                If(LAnd(And(ID53, 0x4, ), And(ID88, 0xff, ))) {
                    Store(0x0, Local1)
                    And(ID88, 0xff, Local2)
                    While(ShiftRight(Local2, Local1, )) {
                        Increment(Local1)
                    }
                    Decrement(Local1)
                    GTFB(AT01, Or(0x40, Local1, ), Local7)
                }
                If(IRDY) {
                    Store(Match(DerefOf(Index(TIM0, 0x0, )), MGE, PIOT, MTR=
, 0x0, 0x0), Local1)
                    If(LEqual(Local1, Ones)) {
                        Store(0x4, Local1)
                    }
                    Subtract(0x4, Local1, Local1)
                    GTFB(AT01, Or(0x8, Local1, ), Local7)
                }
                Else {
                    If(And(ID49, 0x0400, )) {
                        GTFB(AT01, 0x1, Local7)
                    }
                }
                Release(GTFM)
                Return(ATAB)
            }
            Method(RATA, 1) {
                CreateByteField(Arg0, 0x0, CMDN)
                Multiply(CMDN, 0x38, Local0)
                CreateField(Arg0, 0x8, Local0, RETB)
                Return(RETB)
            }
            Name(REGF, 0x1)
            Method(_REG, 2) {
                If(LEqual(Arg0, 0x2)) {
                    Store(Arg1, REGF)
                }
            }
            Name(BAYD, 0x0)
            Method(_STA) {
                Return(0xf)
            }
            Method(GTM_, 6) {
                Store(Buffer(0x14) { }, Local0)
                CreateDWordField(Local0, 0x0, PIO0)
                CreateDWordField(Local0, 0x4, DMA0)
                CreateDWordField(Local0, 0x8, PIO1)
                CreateDWordField(Local0, 0xc, DMA1)
                CreateDWordField(Local0, 0x10, FLAG)
                If(LOr(And(Arg0, 0x8, ), LNot(And(Arg0, 0x1, )))) {
                    Store(0x0384, PIO0)
                }
                Else {
                    Add(ShiftRight(And(Arg0, 0x0300, ), 0x8, ), ShiftRight(=
And(Arg0, 0x3000, ), 0xc, ), Local1)
                    Multiply(Subtract(0x9, Local1, ), 0x1e, PIO0)
                }
                If(And(Arg0, 0x4000, )) {
                    If(LOr(And(Arg0, 0x80, ), LNot(And(Arg0, 0x10, )))) {
                        Store(0x0384, PIO1)
                    }
                    Else {
                        Add(And(Arg1, 0x3, ), ShiftRight(And(Arg1, 0xc, ), =
0x2, ), Local1)
                        Multiply(Subtract(0x9, Local1, ), 0x1e, PIO1)
                    }
                }
                Else {
                    Store(PIO0, PIO1)
                }
                If(And(Arg2, 0x1, )) {
                    If(And(Arg5, 0x1, )) {
                        Store(0x8, DMA0)
                    }
                    Else {
                        Subtract(0x4, And(Arg3, 0x3, ), Local1)
                        If(And(Arg4, 0x1, )) {
                            Multiply(Local1, 0xf, DMA0)
                        }
                        Else {
                            Multiply(Local1, 0x1e, DMA0)
                        }
                    }
                }
                Else {
                    Store(PIO0, DMA0)
                }
                If(And(Arg0, 0x4000, )) {
                    If(And(Arg2, 0x2, )) {
                        If(And(Arg5, 0x2, )) {
                            Store(0x8, DMA1)
                        }
                        Else {
                            Subtract(0x4, ShiftRight(And(Arg3, 0x30, ), 0x4=
, ), Local1)
                            If(And(Arg4, 0x2, )) {
                                Multiply(Local1, 0xf, DMA1)
                            }
                            Else {
                                Multiply(Local1, 0x1e, DMA1)
                            }
                        }
                    }
                    Else {
                        Store(PIO1, DMA1)
                    }
                }
                Else {
                    Store(DMA0, DMA1)
                }
                Store(Zero, FLAG)
                If(And(Arg0, 0x1, )) {
                    Or(FLAG, 0x10, FLAG)
                }
                If(And(Arg2, 0x1, )) {
                    Or(FLAG, 0x1, FLAG)
                }
                If(And(Arg0, 0x2, )) {
                    Or(FLAG, 0x2, FLAG)
                }
                If(And(Arg2, 0x2, )) {
                    Or(FLAG, 0x4, FLAG)
                }
                If(And(Arg0, 0x20, )) {
                    Or(FLAG, 0x8, FLAG)
                }
                Return(Local0)
            }
            Method(STMS, 3) {
                Store(Buffer(0x18) { }, Local7)
                CreateDWordField(Local7, 0x0, ITM_)
                CreateDWordField(Local7, 0x4, SIT_)
                CreateDWordField(Local7, 0x8, UDC_)
                CreateDWordField(Local7, 0xc, UDT_)
                CreateDWordField(Local7, 0x10, ICF_)
                CreateDWordField(Local7, 0x14, A100)
                Store(0x1, WPPE)
                CreateDWordField(Arg0, 0x0, PIO0)
                CreateDWordField(Arg0, 0x4, DMA0)
                CreateDWordField(Arg0, 0x8, PIO1)
                CreateDWordField(Arg0, 0xc, DMA1)
                CreateDWordField(Arg0, 0x10, FLAG)
                Store(FLAG, Local4)
                Store(0x4000, Local0)
                Name(W49M, 0x0)
                Name(W53M, 0x0)
                Name(W62M, 0x0)
                Name(W64M, 0x0)
                Name(W88M, 0x0)
                If(LEqual(SizeOf(Arg1), 0x0200)) {
                    CreateDWordField(Arg1, 0x0, W00A)
                    CreateDWordField(Arg1, 0x62, W49A)
                    CreateDWordField(Arg1, 0x6a, W53A)
                    CreateDWordField(Arg1, 0x7c, W62A)
                    CreateDWordField(Arg1, 0x80, W64A)
                    CreateDWordField(Arg1, 0xb0, W88A)
                    Store(W49A, W49M)
                    Store(W53A, W53M)
                    Store(W62A, W62M)
                    Store(W64A, W64M)
                    Store(W88A, W88M)
                    If(W00A) {
                        Or(Local0, 0x8000, Local0)
                    }
                    If(LNot(And(W00A, 0x80, ))) {
                        Or(Local0, 0x4, Local0)
                    }
                }
                Else {
                    Store(0x0, W49M)
                    Store(0x0, W53M)
                    Store(0x0, W62M)
                    Store(0x0, W64M)
                    Store(0x0, W88M)
                }
                Name(W49S, 0x0)
                Name(W53S, 0x0)
                Name(W62S, 0x0)
                Name(W64S, 0x0)
                Name(W88S, 0x0)
                If(LEqual(SizeOf(Arg2), 0x0200)) {
                    CreateDWordField(Arg2, 0x0, W00B)
                    CreateDWordField(Arg2, 0x62, W49B)
                    CreateDWordField(Arg2, 0x6a, W53B)
                    CreateDWordField(Arg2, 0x7c, W62B)
                    CreateDWordField(Arg2, 0x80, W64B)
                    CreateDWordField(Arg2, 0xb0, W88B)
                    Store(W49B, W49S)
                    Store(W53B, W53S)
                    Store(W62B, W62S)
                    Store(W64B, W64S)
                    Store(W88B, W88S)
                    If(W00B) {
                        Or(Local0, 0x8000, Local0)
                    }
                    If(LNot(And(W00B, 0x80, ))) {
                        Or(Local0, 0x40, Local0)
                    }
                }
                Else {
                    Store(0x0, W49S)
                    Store(0x0, W53S)
                    Store(0x0, W62S)
                    Store(0x0, W64S)
                    Store(0x0, W88S)
                }
                Store(0x0, A100)
                If(And(0x38, W88M, )) {
                    If(And(0x20, W88M, )) {
                        Store(0x8, DMA0)
                        Or(A100, 0x00100010, A100)
                    }
                    Else {
                        If(And(0x10, W88M, )) {
                            Store(0x1e, DMA0)
                            Or(A100, 0x10, A100)
                        }
                        Else {
                            Store(0x2d, DMA0)
                        }
                    }
                }
                Else {
                    If(And(0x7, W88M, )) {
                        Or(0x0100, A100, A100)
                        If(And(0x4, W88M, )) {
                            Store(0x3c, DMA0)
                        }
                        Else {
                            If(And(0x2, W88M, )) {
                                Store(0x5a, DMA0)
                            }
                            Else {
                                Store(0x78, DMA0)
                            }
                        }
                    }
                }
                If(And(0x3f, W88S, )) {
                    If(And(0x20, W88S, )) {
                        Store(0x8, DMA1)
                        Or(A100, 0x00200020, A100)
                    }
                    Else {
                        If(And(0x10, W88S, )) {
                            Store(0x1e, DMA1)
                            Or(A100, 0x20, A100)
                        }
                        Else {
                            Store(0x2d, DMA1)
                        }
                    }
                }
                If(LAnd(And(W49M, 0x0800, ), And(Local4, 0x2, ))) {
                    Or(Local0, 0x2, Local0)
                }
                If(LLess(PIO0, 0x0384)) {
                    Or(Local0, 0x1, Local0)
                }
                If(LAnd(And(W49S, 0x0800, ), And(Local4, 0x8, ))) {
                    Or(Local0, 0x20, Local0)
                }
                If(LLess(PIO1, 0x0384)) {
                    Or(Local0, 0x10, Local0)
                }
                If(And(Local4, 0x1, )) {
                    Store(PIO0, Local1)
                }
                Else {
                    Store(DMA0, Local1)
                }
                If(LNot(LLess(Local1, 0xf0))) {
                    Or(Local0, 0x8, Local0)
                }
                Else {
                    If(And(W53M, 0x2, )) {
                        If(LAnd(And(W64M, 0x2, ), LNot(LGreater(Local1, 0x7=
8)))) {
                            Or(Local0, 0x2301, Local0)
                        }
                        Else {
                            If(LAnd(And(W64M, 0x1, ), LNot(LGreater(Local1,=
 0xb4)))) {
                                Or(Local0, 0x2101, Local0)
                            }
                        }
                    }
                    Else {
                        Or(Local0, 0x1001, Local0)
                    }
                }
                Store(Local0, ITM_)
                Store(Zero, Local0)
                If(And(Local4, 0x4, )) {
                    Store(PIO1, Local1)
                }
                Else {
                    Store(DMA1, Local1)
                }
                If(And(Local4, 0x10, )) {
                    If(LNot(LLess(Local1, 0xf0))) {
                        Or(0x80, ITM_, ITM_)
                    }
                    Else {
                        Or(0x10, ITM_, ITM_)
                        If(And(W53S, 0x2, )) {
                            If(LAnd(And(W64S, 0x2, ), LNot(LGreater(Local1,=
 0x78)))) {
                                Store(0xb, Local0)
                            }
                            Else {
                                If(LAnd(And(W64S, 0x1, ), LNot(LGreater(Loc=
al1, 0xb4)))) {
                                    Store(0x9, Local0)
                                }
                            }
                        }
                        Else {
                            Store(0x4, Local0)
                        }
                    }
                }
                Store(Local0, SIT_)
                Store(0x0, Local0)
                If(LAnd(And(0x3f, W88M, ), And(Local4, 0x1, ))) {
                    Or(Local0, 0x1, Local0)
                }
                If(And(Local4, 0x4, )) {
                    Or(Local0, 0x2, Local0)
                }
                Store(Local0, UDC_)
                Store(0x0, Local0)
                If(And(Local4, 0x1, )) {
                    If(LLess(DMA0, 0x1e)) {
                        Or(A100, 0x1000, A100)
                        Or(Local0, 0x1, Local0)
                    }
                    Else {
                        If(LLess(DMA0, 0x3c)) {
                            Divide(DMA0, 0xf, , Local1)
                        }
                        Else {
                            Divide(DMA0, 0x1e, , Local1)
                        }
                        Subtract(0x4, Local1, Local0)
                    }
                }
                If(And(Local4, 0x4, )) {
                    If(LLess(DMA1, 0x1e)) {
                        Or(A100, 0x2000, A100)
                        Or(Local0, 0x10, Local0)
                    }
                    Else {
                        If(LLess(DMA1, 0x3c)) {
                            Divide(DMA1, 0xf, , Local1)
                        }
                        Else {
                            Divide(DMA1, 0x1e, , Local1)
                        }
                        Subtract(0x4, Local1, Local1)
                        ShiftLeft(Local1, 0x4, Local1)
                        Or(Local0, Local1, Local0)
                    }
                }
                Store(Local0, UDT_)
                Store(0x0, Local0)
                If(LLess(DMA0, 0x3c)) {
                    Or(Local0, 0x1, Local0)
                }
                If(LLess(DMA1, 0x3c)) {
                    Or(Local0, 0x2, Local0)
                }
                Store(Local0, ICF_)
                Return(Local7)
            }
            Method(GTF0, 7) {
                Store(Buffer(0x7) {0x3, 0x0, 0x0, 0x0, 0x0, 0xa0, 0xef }, L=
ocal7)
                CreateByteField(Local7, 0x1, MODE)
                If(And(Arg2, 0x1, )) {
                    If(And(Arg6, 0x1, )) {
                        Store(0x45, MODE)
                    }
                    Else {
                        And(Arg3, 0x3, Local0)
                        If(And(Arg4, 0x1, )) {
                            Add(Local0, 0x2, Local0)
                        }
                        Or(Local0, 0x40, MODE)
                    }
                }
                Else {
                    Add(ShiftRight(And(Arg0, 0x0300, ), 0x8, ), ShiftRight(=
And(Arg0, 0x3000, ), 0xc, ), Local0)
                    If(LNot(LLess(Local0, 0x5))) {
                        Store(0x22, MODE)
                    }
                    Else {
                        If(LNot(LLess(Local0, 0x3))) {
                            Store(0x21, MODE)
                        }
                        Else {
                            Store(0x20, MODE)
                        }
                    }
                }
                Concatenate(Local7, Local7, Local6)
                If(LOr(And(Arg0, 0x8, ), LNot(And(Arg0, 0x1, )))) {
                    If(And(Arg0, 0x2, )) {
                        Store(0x0, MODE)
                    }
                    Else {
                        Store(0x8, MODE)
                    }
                }
                Else {
                    Add(ShiftRight(And(Arg0, 0x0300, ), 0x8, ), ShiftRight(=
And(Arg0, 0x3000, ), 0xc, ), Local0)
                    If(LNot(LLess(Local0, 0x5))) {
                        Store(0xc, MODE)
                    }
                    Else {
                        If(LNot(LLess(Local0, 0x3))) {
                            Store(0xb, MODE)
                        }
                        Else {
                            Store(0xa, MODE)
                        }
                    }
                }
                Concatenate(Local6, Local7, Local5)
                Return(Local5)
            }
            Name(B04_, Buffer(0x4) { })
            Name(B20_, Buffer(0x4) { })
            Name(B40_, Buffer(0x4) { })
            Device(PRIM) {
                Name(_ADR, 0x0)
                Name(_PSC, 0x0)
                Method(_PS0) {
                    Store(0x0, _PSC)
                }
                Method(_PS3) {
                    Store(0x3, _PSC)
                }
                Method(_GTM) {
                    Store(Buffer(0x14) {0x0 }, Local0)
                    Store(^^GTM_(^^ITM0, ^^SIT0, ^^UDC0, ^^UDT0, ^^ICF0, ^^=
=46SCB), Local0)
                    Return(Local0)
                }
                Method(_STM, 3) {
                    Store(GTF_(0x0, Arg1, Arg0), ATA0)
                    Store(GTF_(0x1, Arg2, Arg0), ATA1)
                    Store(^^STMS(Arg0, Arg1, Arg2), Local0)
                    CreateDWordField(Local0, 0x0, ITM_)
                    CreateDWordField(Local0, 0x4, SIT_)
                    CreateDWordField(Local0, 0x8, UDC_)
                    CreateDWordField(Local0, 0xc, UDT_)
                    CreateDWordField(Local0, 0x10, ICF_)
                    Store(ITM_, ^^ITM0)
                    Store(SIT_, ^^SIT0)
                    Store(UDC_, ^^UDC0)
                    Store(UDT_, ^^UDT0)
                    CreateDWordField(Local0, 0x14, A100)
                    Or(And(^^CB80, 0xc, ), ShiftRight(And(0x30, A100, ), 0x=
4, ), ^^CB80)
                    Or(And(^^FSCB, 0xc, ), ShiftRight(And(0x3000, A100, ), =
0xc, ), ^^FSCB)
                    Or(And(^^FATS, 0xc, ), ShiftRight(And(0x00300000, A100,=
 ), 0x14, ), ^^FATS)
                    Store(ICF_, ^^ICF0)
                }
                Device(MAST) {
                    Name(_ADR, 0x0)
                    Name(H15F, Zero)
                    Method(_GTF) {
                        Return(RATA(ATA0))
                    }
                }
            }
            Device(SECN) {
                Name(_ADR, 0x1)
                Name(FAST, 0x63)
                Method(_STA) {
                    If(ESID) {
                        Return(0xf)
                    }
                    Else {
                        Return(0x8)
                    }
                }
                Name(_PSC, 0x0)
                Method(_PS0) {
                    Store(0x0, _PSC)
                }
                Method(_PS3) {
                    Store(0x3, _PSC)
                }
                Method(_GTM) {
                    Store(Buffer(0x14) {0x0 }, Local0)
                    Store(^^FSCB, Local1)
                    ShiftRight(Local1, 0x2, Local1)
                    Store(^^GTM_(^^ITM1, ^^SIT1, ^^UDC1, ^^UDT1, ^^ICF1, Lo=
cal1), Local0)
                    Return(Local0)
                }
                Method(_STM, 3) {
                    Store(GTF_(0x0, Arg1, Arg0), ATA2)
                    Store(GTF_(0x1, Arg2, Arg0), ATA3)
                    Store(^^STMS(Arg0, Arg1, Arg2), Local0)
                    CreateDWordField(Local0, 0x0, ITM_)
                    CreateDWordField(Local0, 0x4, SIT_)
                    CreateDWordField(Local0, 0x8, UDC_)
                    CreateDWordField(Local0, 0xc, UDT_)
                    CreateDWordField(Local0, 0x10, ICF_)
                    Store(ITM_, ^^ITM1)
                    Store(SIT_, ^^SIT1)
                    Store(UDC_, ^^UDC1)
                    Store(UDT_, ^^UDT1)
                    CreateDWordField(Local0, 0x14, A100)
                    Or(And(^^CB80, 0x3, ), ShiftRight(And(0x30, A100, ), 0x=
2, ), ^^CB80)
                    Or(And(^^FSCB, 0x3, ), ShiftRight(And(0x3000, A100, ), =
0xa, ), ^^FSCB)
                    Or(And(^^FATS, 0x3, ), ShiftRight(And(0x00300000, A100,=
 ), 0x12, ), ^^FATS)
                    Store(ICF_, ^^ICF1)
                }
                Device(BAY1) {
                    Name(_ADR, 0x0)
                    Name(H15F, Zero)
                    Name(EJ0F, 0x0)
                    Method(_GTF) {
                        Return(RATA(ATA2))
                    }
                    Method(_STA) {
                        If(\_SB_.PCI0.IDE0.ESID) {
                            \_SB_.PCI0.IDE0.SECN.CBAY()
                            Store(^^BFLG, Local0)
                            If(LEqual(^^BNUM, 0x1)) {
                                If(And(Local0, 0x1, )) {
                                    If(\_SB_.PCI0.LPC0.LV37) {
                                        Return(0x8)
                                    }
                                    Else {
                                        Return(0xf)
                                    }
                                }
                            }
                            Else {
                                If(LEqual(^^BNUM, 0x2)) {
                                    If(\_SB_.PCI0.LPC0.LV37) {
                                        Return(0x8)
                                    }
                                    Else {
                                        Return(0xf)
                                    }
                                }
                                Else {
                                    Return(0x8)
                                }
                            }
                        }
                        Else {
                            Return(0x8)
                        }
                    }
                    Method(_EJ0, 1) {
                        If(Arg0) {
                            Store(0x1, ^^^SSIG)
                            Sleep(0x32)
                            Store(0xc000, ^^^ITM1)
                            Store(0x1, \_SB_.PCI0.LPC0.LV37)
                            Store(0x0, \_SB_.PCI0.LPC0.LV39)
                        }
                    }
                }
                Name(BNUM, 0x0)
                Name(BFLG, 0x0)
                Method(CBAY) {
                    Store(0x0, BNUM)
                    Store(0x0, BFLG)
                    Store(\_SB_.PCI0.LPC0.RBID, Local0)
                    If(Or(LEqual(Local0, 0x1), LEqual(Local0, 0x2), )) {
                        Increment(BNUM)
                        Or(BFLG, 0x1, BFLG)
                    }
                }
            }
            Method(_PS0) {
                If(And(LEqual(_PSC, 0x3), LEqual(\_SB_.STAT, 0x3), )) {
                    Store(0x89, \_SB_.PCI0.LPC0.BCMD)
                    Store(0x0, \_SB_.PCI0.LPC0.SMIC)
                }
                Store(0x0, _PSC)
            }
            Method(_PS3) {
                Store(0x3, _PSC)
            }
            Name(_PSC, 0x0)
        }
        Device(USB1) {
            Name(_ADR, 0x001d0000)
            OperationRegion(USBO, PCI_Config, 0xc4, 0x4)
            Field(USBO, ByteAcc, NoLock, Preserve) {
                RSEN,	2
            }
            Name(_PRW, Package(0x2) {
                0x3,
                0x3,
            })
            Method(_PSW, 1) {
                If(Arg0) {
                    Store(0x3, \_SB_.PCI0.USB1.RSEN)
                }
                Else {
                    Store(0x0, \_SB_.PCI0.USB1.RSEN)
                }
            }
        }
        Device(USB2) {
            Name(_ADR, 0x001d0001)
            OperationRegion(USBO, PCI_Config, 0xc4, 0x4)
            Field(USBO, ByteAcc, NoLock, Preserve) {
                RSEN,	2
            }
            Name(_PRW, Package(0x2) {
                0x4,
                0x3,
            })
            Method(_PSW, 1) {
                If(Arg0) {
                    Store(0x3, \_SB_.PCI0.USB2.RSEN)
                }
                Else {
                    Store(0x0, \_SB_.PCI0.USB2.RSEN)
                }
            }
        }
        Device(USB3) {
            Name(_ADR, 0x001d0002)
            OperationRegion(USBO, PCI_Config, 0xc4, 0x4)
            Field(USBO, ByteAcc, NoLock, Preserve) {
                RSEN,	2
            }
            Name(_PRW, Package(0x2) {
                0xc,
                0x3,
            })
            Method(_PSW, 1) {
                If(Arg0) {
                    Store(0x3, \_SB_.PCI0.USB3.RSEN)
                }
                Else {
                    Store(0x0, \_SB_.PCI0.USB3.RSEN)
                }
            }
        }
    }
    Device(LID_) {
        Name(_HID, 0x0d0cd041)
        Name(LSTS, 0x0)
        Method(_LID) {
            If(\_SB_.OKEC) {
                If(\_SB_.PCI0.LPC0.EC0_.LIDS) {
                    Store(Zero, LSTS)
                }
                Else {
                    Store(One, LSTS)
                }
            }
            Else {
                Store(Zero, LSTS)
            }
            Return(LSTS)
        }
    }
    Device(ACAD) {
        Name(_HID, "ACPI0003")
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Name(ACWT, 0x0)
        Method(_PSR) {
            Store(\_SB_.ACST, ACWT)
            If(\_SB_.OKEC) {
                Store(\_SB_.PCI0.LPC0.EC0_.ACDF, \_SB_.ACST)
            }
            If(LNot(LEqual(ACWT, \_SB_.ACST))) {
                Store(0x8b, \_SB_.PCI0.LPC0.BCMD)
                Store(0x0, \_SB_.PCI0.LPC0.SMIC)
            }
            Return(\_SB_.ACST)
        }
    }
    Method(VTOB, 1) {
        Store(0x1, Local0)
        ShiftLeft(Local0, Arg0, Local0)
        Return(Local0)
    }
    Method(BTOV, 1) {
        ShiftRight(Arg0, 0x1, Local0)
        Store(0x0, Local1)
        While(Local0) {
            Increment(Local1)
            ShiftRight(Local0, 0x1, Local0)
        }
        Return(Local1)
    }
    Method(MKWD, 2) {
        If(And(Arg1, 0x80, )) {
            Store(0xffff0000, Local0)
        }
        Else {
            Store(Zero, Local0)
        }
        Or(Local0, Arg0, Local0)
        Or(Local0, ShiftLeft(Arg1, 0x8, ), Local0)
        Return(Local0)
    }
    Method(POSW, 1) {
        If(And(Arg0, 0x8000, )) {
            If(LEqual(Arg0, 0xffff)) {
                Return(0xffffffff)
            }
            Else {
                Not(Arg0, Local0)
                Increment(Local0)
                And(Local0, 0xffff, Local0)
                Return(Local0)
            }
        }
        Else {
            Return(Arg0)
        }
    }
    Method(GBFE, 3) {
        CreateByteField(Arg0, Arg1, TIDX)
        Store(TIDX, Arg2)
    }
    Method(PBFE, 3) {
        CreateByteField(Arg0, Arg1, TIDX)
        Store(Arg2, TIDX)
    }
    Method(ITOS, 1) {
        Store(Buffer(0x9) {0x30, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0 }, =
Local0)
        Store(Buffer(0x11) {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,=
 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x0 }, Local7)
        Store(0x8, Local1)
        Store(0x0, Local2)
        Store(0x0, Local3)
        While(Local1) {
            Decrement(Local1)
            And(ShiftRight(Arg0, ShiftLeft(Local1, 0x2, ), ), 0xf, Local4)
            If(Local4) {
                Store(Ones, Local3)
            }
            If(Local3) {
                GBFE(Local7, Local4, RefOf(Local5))
                PBFE(Local0, Local2, Local5)
                Increment(Local2)
            }
        }
        Return(Local0)
    }
    Device(BAT1) {
        Name(_HID, 0x0a0cd041)
        Name(_UID, 0x1)
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Name(PBIF, Package(0xd) {
            0x1,
            0xffffffff,
            0xffffffff,
            0x1,
            0xffffffff,
            0xfa,
            0x64,
            0xa,
            0x19,
            "BAT1",
            " ",
            " ",
            " ",
        })
        Name(PBST, Package(0x4) {
            0x0,
            0xffffffff,
            0xffffffff,
            0x2710,
        })
        Name(BAST, 0x0)
        Name(FAST, 0x0)
        Name(B1ST, 0xf)
        Name(B1WT, 0x0)
        Method(_STA) {
            If(LLess(FAST, 0x10)) {
                Increment(FAST)
                If(LEqual(FAST, 0x10)) {
                    Store(0x92, \_SB_.PCI0.LPC0.BCMD)
                    Store(0x0, \_SB_.PCI0.LPC0.SMIC)
                }
            }
            If(\_SB_.OKEC) {
                If(\_SB_.PCI0.LPC0.EC0_.MBTS) {
                    Store(0x1f, B1ST)
                }
                Else {
                    Store(0xf, B1ST)
                }
            }
            Else {
                Store(0xf, B1ST)
            }
            Return(B1ST)
        }
        Method(_BIF) {
            If(\_SB_.OKEC) {
                If(\_SB_.PCI0.LPC0.EC0_.MBTS) {
                    UPBI()
                }
                Else {
                    IVBI()
                }
            }
            Else {
                IVBI()
            }
            Return(PBIF)
        }
        Method(_BST) {
            If(\_SB_.OKEC) {
                If(\_SB_.PCI0.LPC0.EC0_.MBTS) {
                    UPBS()
                }
                Else {
                    IVBS()
                }
            }
            Else {
                IVBS()
            }
            Return(PBST)
        }
        Method(UPBI) {
            Store(0x1fff, Local2)
            \_SB_.PCI0.LPC0.EC0_.SMWR(0x8, 0x14, 0x1, Local2)
            \_SB_.PCI0.LPC0.EC0_.SMRD(0x9, 0x14, 0x1, RefOf(Local3))
            If(LEqual(Local2, Or(Local3, 0x0fff, ))) {
                If(LNot(\_SB_.PCI0.LPC0.EC0_.SMRD(0x9, 0x16, 0x10, RefOf(Lo=
cal5)))) {
                    Store(Local5, Index(PBIF, 0x2, ))
                }
            }
            If(LEqual(\_SB_.PCI0.LPC0.EC0_.MBID, 0x1)) {
                Store(0x1130, Index(PBIF, 0x1, ))
                Store(0x39d0, Index(PBIF, 0x4, ))
                Store("01ZG", Index(PBIF, 0x9, ))
                Store("LION", Index(PBIF, 0xb, ))
                Store("SMP ", Index(PBIF, 0xc, ))
            }
            Else {
                If(LEqual(\_SB_.PCI0.LPC0.EC0_.MBID, 0x2)) {
                    Store(0x0e10, Index(PBIF, 0x1, ))
                    Store(0x39d0, Index(PBIF, 0x4, ))
                    Store("02ZG", Index(PBIF, 0x9, ))
                    Store("LION", Index(PBIF, 0xb, ))
                    Store("SANYO", Index(PBIF, 0xc, ))
                }
                Else {
                    If(LEqual(\_SB_.PCI0.LPC0.EC0_.MBID, 0x3)) {
                        Store(0x1130, Index(PBIF, 0x1, ))
                        Store(0x39d0, Index(PBIF, 0x4, ))
                        Store("03ZG", Index(PBIF, 0x9, ))
                        Store("LION", Index(PBIF, 0xb, ))
                        Store("SANYO", Index(PBIF, 0xc, ))
                    }
                    Else {
                        Store(0x1130, Index(PBIF, 0x1, ))
                        Store(0x39d0, Index(PBIF, 0x4, ))
                        Store("01ZG", Index(PBIF, 0x9, ))
                        Store("LION", Index(PBIF, 0xb, ))
                        Store("SMP ", Index(PBIF, 0xc, ))
                    }
                }
            }
            Store(0x1, Index(PBIF, 0x0, ))
            If(LEqual(SizeOf(\_OS_), 0x27)) {
                Store(0x0, Index(PBIF, 0x0, ))
            }
        }
        Method(UPBS) {
            Store(\_SB_.PCI0.LPC0.EC0_.MCUR, Local5)
            Store(POSW(Local5), Index(PBST, 0x1, ))
            Store(\_SB_.PCI0.LPC0.EC0_.MBRM, Index(PBST, 0x2, ))
            Store(\_SB_.PCI0.LPC0.EC0_.MBVG, Index(PBST, 0x3, ))
            If(\_SB_.PCI0.LPC0.EC0_.MBTF) {
                If(\_SB_.PCI0.LPC0.EC0_.ACDF) {
                    Store(0x0, Index(PBST, 0x0, ))
                }
            }
            Else {
                If(\_SB_.PCI0.LPC0.EC0_.MBTC) {
                    If(\_SB_.PCI0.LPC0.EC0_.ACDF) {
                        Store(0x2, Index(PBST, 0x0, ))
                    }
                    Else {
                        Store(0x0, Index(PBST, 0x0, ))
                    }
                }
                Else {
                    If(\_SB_.PCI0.LPC0.EC0_.ACDF) {
                        Store(0x0, Index(PBST, 0x0, ))
                    }
                    Else {
                        Store(0x1, Index(PBST, 0x0, ))
                    }
                }
            }
        }
        Method(IVBI) {
            Store(0xffffffff, Index(PBIF, 0x1, ))
            Store(0xffffffff, Index(PBIF, 0x2, ))
            Store(0xffffffff, Index(PBIF, 0x4, ))
            Store("Bad", Index(PBIF, 0x9, ))
            Store("      ", Index(PBIF, 0xa, ))
            Store("Bad", Index(PBIF, 0xb, ))
            Store("Bad", Index(PBIF, 0xc, ))
        }
        Method(IVBS) {
            Store(0x0, Index(PBST, 0x0, ))
            Store(0xffffffff, Index(PBST, 0x1, ))
            Store(0xffffffff, Index(PBST, 0x2, ))
            Store(0x2710, Index(PBST, 0x3, ))
        }
    }
    Device(BAT2) {
        Name(_HID, 0x0a0cd041)
        Name(_UID, 0x2)
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Name(B2ST, 0xf)
        Name(PBIF, Package(0xd) {
            0x1,
            0xffffffff,
            0xffffffff,
            0x1,
            0xffffffff,
            0xfa,
            0x64,
            0xa,
            0x19,
            "BAT1",
            " ",
            " ",
            " ",
        })
        Name(PBST, Package(0x4) {
            0x0,
            0xffffffff,
            0xffffffff,
            0x2710,
        })
        Method(_STA) {
            If(\_SB_.OKEC) {
                If(\_SB_.PCI0.LPC0.EC0_.SBTS) {
                    Store(0x1f, B2ST)
                }
                Else {
                    Store(0xf, B2ST)
                }
            }
            Else {
                Store(0xf, B2ST)
            }
            Return(B2ST)
        }
        Method(_BIF) {
            If(\_SB_.OKEC) {
                If(\_SB_.PCI0.LPC0.EC0_.SBTS) {
                    UPBI()
                }
                Else {
                    IVBI()
                }
            }
            Else {
                IVBI()
            }
            Return(PBIF)
        }
        Method(_BST) {
            If(\_SB_.OKEC) {
                If(\_SB_.PCI0.LPC0.EC0_.SBTS) {
                    UPBS()
                }
                Else {
                    IVBS()
                }
            }
            Else {
                IVBS()
            }
            Return(PBST)
        }
        Method(UPBI) {
            Store(0x2fff, Local2)
            \_SB_.PCI0.LPC0.EC0_.SMWR(0x8, 0x14, 0x1, Local2)
            \_SB_.PCI0.LPC0.EC0_.SMRD(0x9, 0x14, 0x1, RefOf(Local3))
            If(LEqual(Local2, Or(Local3, 0x0fff, ))) {
                If(LNot(\_SB_.PCI0.LPC0.EC0_.SMRD(0x9, 0x16, 0x10, RefOf(Lo=
cal5)))) {
                    Store(Local5, Index(PBIF, 0x2, ))
                }
            }
            If(LEqual(\_SB_.PCI0.LPC0.EC0_.SBID, 0x1)) {
                Store(0x1130, Index(PBIF, 0x1, ))
                Store(0x39d0, Index(PBIF, 0x4, ))
                Store("01ZG", Index(PBIF, 0x9, ))
                Store("LION", Index(PBIF, 0xb, ))
                Store("SMP ", Index(PBIF, 0xc, ))
            }
            Else {
                If(LEqual(\_SB_.PCI0.LPC0.EC0_.SBID, 0x2)) {
                    Store(0x0e10, Index(PBIF, 0x1, ))
                    Store(0x39d0, Index(PBIF, 0x4, ))
                    Store("02ZG", Index(PBIF, 0x9, ))
                    Store("LION", Index(PBIF, 0xb, ))
                    Store("SANYO", Index(PBIF, 0xc, ))
                }
                Else {
                    If(LEqual(\_SB_.PCI0.LPC0.EC0_.SBID, 0x3)) {
                        Store(0x1130, Index(PBIF, 0x1, ))
                        Store(0x39d0, Index(PBIF, 0x4, ))
                        Store("03ZG", Index(PBIF, 0x9, ))
                        Store("LION", Index(PBIF, 0xb, ))
                        Store("SANYO", Index(PBIF, 0xc, ))
                    }
                    Else {
                        Store(0x0e10, Index(PBIF, 0x1, ))
                        Store(0x39d0, Index(PBIF, 0x4, ))
                        Store("02ZG", Index(PBIF, 0x9, ))
                        Store("LION", Index(PBIF, 0xb, ))
                        Store("SANYO", Index(PBIF, 0xc, ))
                    }
                }
            }
            Store(0x1, Index(PBIF, 0x0, ))
            If(LEqual(SizeOf(\_OS_), 0x27)) {
                Store(0x0, Index(PBIF, 0x0, ))
            }
        }
        Method(UPBS) {
            Store(\_SB_.PCI0.LPC0.EC0_.ACUR, Local5)
            Store(POSW(Local5), Index(PBST, 0x1, ))
            Store(\_SB_.PCI0.LPC0.EC0_.ABRM, Index(PBST, 0x2, ))
            Store(\_SB_.PCI0.LPC0.EC0_.ABVG, Index(PBST, 0x3, ))
            If(\_SB_.PCI0.LPC0.EC0_.SBTF) {
                If(\_SB_.PCI0.LPC0.EC0_.ACDF) {
                    Store(0x0, Index(PBST, 0x0, ))
                }
            }
            Else {
                If(\_SB_.PCI0.LPC0.EC0_.SBTC) {
                    If(\_SB_.PCI0.LPC0.EC0_.ACDF) {
                        Store(0x2, Index(PBST, 0x0, ))
                    }
                    Else {
                        Store(0x0, Index(PBST, 0x0, ))
                    }
                }
                Else {
                    If(\_SB_.PCI0.LPC0.EC0_.ACDF) {
                        Store(0x0, Index(PBST, 0x0, ))
                    }
                    Else {
                        Store(0x1, Index(PBST, 0x0, ))
                    }
                }
            }
        }
        Method(IVBI) {
            Store(0xffffffff, Index(PBIF, 0x1, ))
            Store(0xffffffff, Index(PBIF, 0x2, ))
            Store(0xffffffff, Index(PBIF, 0x4, ))
            Store("Bad", Index(PBIF, 0x9, ))
            Store("      ", Index(PBIF, 0xa, ))
            Store("Bad", Index(PBIF, 0xb, ))
            Store("Bad", Index(PBIF, 0xc, ))
        }
        Method(IVBS) {
            Store(0x0, Index(PBST, 0x0, ))
            Store(0xffffffff, Index(PBST, 0x1, ))
            Store(0xffffffff, Index(PBST, 0x2, ))
            Store(0x2710, Index(PBST, 0x3, ))
        }
    }
    Scope(\_TZ_) {
        Name(TPL_, 0x0ca0)
        Name(TAC1, 0x0d0e)
        Name(TAC0, 0x0d54)
        Name(TPAS, 0x0e44)
        Name(TPC_, 0x0e94)
        Name(TPTM, 0x0c3c)
        Name(TBSE, 0x0aac)
        Name(LTMP, 0x0ca0)
        Name(TVAR, Buffer(0x5) {0x0, 0x20, 0x1f, 0xc, 0x1f })
        CreateByteField(TVAR, 0x0, PLCY)
        CreateWordField(TVAR, 0x1, CTOS)
        CreateWordField(TVAR, 0x3, CTHY)
        Device(FAN0) {
            Name(_HID, 0x0b0cd041)
            Name(_UID, 0x1)
            Name(_PR0, Package(0x1) {
                PFN0,
            })
            Method(_PS0) {
                Store("Low Speed FAN - _PS0", Debug)
            }
            Method(_PS3) {
                Store("Low Speed FAN - _PS3", Debug)
            }
        }
        PowerResource(PFN0, 0, 0) {
            Name(FNS1, 0x0)
            Name(FFST, 0x1)
            Method(_STA) {
                Store(FNS1, Local1)
                Return(Local1)
            }
            Method(_ON_) {
                Store(0x1, FNS1)
                If(\_TZ_.PFN1.FNS2) {
                    Store("FAN 1 (High speed already turn on) ", Debug)
                }
                Else {
                    If(\_SB_.OKEC) {
                        Store(0xb4, \_SB_.PCI0.LPC0.EC0_.FSPD)
                        Store(0x1, \_SB_.PCI0.LPC0.EC0_.FPR1)
                    }
                }
                If(Or(LEqual(\_SB_.PCI0.MYOS, 0x1), LEqual(\_SB_.PCI0.MYOS,=
 0x3), )) {
                    \_TZ_.THRM._SCP(0x1)
                }
            }
            Method(_OFF) {
                Store(0x0, FNS1)
                If(LEqual(SizeOf(\_OS_), 0x14)) {
                    If(\_SB_.OKEC) {
                        If(\_TZ_.PFN1.FNS2) {
                            Store(One, \_SB_.PCI0.LPC0.EC0_.FPR1)
                        }
                        Else {
                            Store(Zero, \_SB_.PCI0.LPC0.EC0_.FPR1)
                        }
                    }
                }
                Else {
                    If(LLess(FFST, 0x2)) {
                        Store(0x86, \_SB_.PCI0.LPC0.BCMD)
                        Store(0x0, \_SB_.PCI0.LPC0.SMIC)
                        Increment(FFST)
                    }
                    Else {
                        If(\_SB_.OKEC) {
                            Store(0x0, \_SB_.PCI0.LPC0.EC0_.FPR1)
                        }
                    }
                }
                If(Or(LEqual(\_SB_.PCI0.MYOS, 0x1), LEqual(\_SB_.PCI0.MYOS,=
 0x3), )) {
                    \_TZ_.THRM._SCP(0x1)
                }
            }
        }
        Device(FAN1) {
            Name(_HID, 0x0b0cd041)
            Name(_UID, 0x2)
            Name(_PR0, Package(0x2) {
                PFN0,
                PFN1,
            })
            Method(_PS0) {
                Store("High Speed FAN - _PS0", Debug)
            }
            Method(_PS3) {
                Store("High Speed FAN - _PS3", Debug)
            }
        }
        PowerResource(PFN1, 0, 0) {
            Name(FNS2, 0x0)
            Method(_STA) {
                Return(FNS2)
            }
            Method(_ON_) {
                Store(0x1, FNS2)
                If(\_SB_.OKEC) {
                    Store(0xff, \_SB_.PCI0.LPC0.EC0_.FSPD)
                    Store(0x1, \_SB_.PCI0.LPC0.EC0_.FPR1)
                }
                If(Or(LEqual(\_SB_.PCI0.MYOS, 0x1), LEqual(\_SB_.PCI0.MYOS,=
 0x3), )) {
                    \_TZ_.THRM._SCP(0x1)
                }
            }
            Method(_OFF) {
                Store(Zero, FNS2)
                Store(0x0, FNS2)
                If(\_TZ_.PFN0.FNS1) {
                    If(\_SB_.OKEC) {
                        Store(0xb4, \_SB_.PCI0.LPC0.EC0_.FSPD)
                        Store(0x1, \_SB_.PCI0.LPC0.EC0_.FPR1)
                    }
                }
                Else {
                    If(\_SB_.OKEC) {
                        Store(0x0, \_SB_.PCI0.LPC0.EC0_.FPR1)
                    }
                }
                If(Or(LEqual(\_SB_.PCI0.MYOS, 0x1), LEqual(\_SB_.PCI0.MYOS,=
 0x3), )) {
                    \_TZ_.THRM._SCP(0x1)
                }
            }
        }
        ThermalZone(THRM) {
            Name(_AL0, Package(0x1) {
                FAN1,
            })
            Method(_AC0) {
                Return(TAC0)
            }
            Name(_AL1, Package(0x1) {
                FAN0,
            })
            Method(_AC1) {
                Return(TAC1)
            }
            Method(_CRT) {
                Return(TPC_)
            }
            Method(_PSV) {
                Return(TPAS)
            }
            Name(_TSP, 0x64)
            Method(_TMP) {
                If(\_SB_.OKEC) {
                    Store(\_SB_.PCI0.LPC0.EC0_.CTMP, Local1)
                    Store("Current Temperature is ----------- ", Debug)
                    Store(Local1, Debug)
                    Store(Local1, \_SB_.CM25)
                    Add(Multiply(Local1, 0xa, ), TBSE, Local1)
                }
                Else {
                    Store(LTMP, Local1)
                }
                Return(Local1)
            }
            Name(_PSL, Package(0x1) {
                \_PR_.CPU0,
            })
            Name(_TC1, 0x2)
            Name(_TC2, 0x3)
            Method(_SCP, 1) {
                Store(Zero, PLCY)
                If(\_TZ_.PFN0.FNS1) {
                    If(LEqual(\_TZ_.PFN1.FNS2, 0x0)) {
                        Store(0x0d22, TAC1)
                        Store(0x0d86, TAC0)
                    }
                    Else {
                        Store(0x0d22, TAC1)
                        Store(0x0d40, TAC0)
                    }
                }
                Else {
                    If(\_TZ_.PFN1.FNS2) {
                        Store(0x0d22, TAC1)
                        Store(0x0d40, TAC0)
                    }
                    Else {
                        Store(0x0d40, TAC1)
                        Store(0x0d86, TAC0)
                    }
                }
                Store(0x0e44, TPAS)
                Notify(\_TZ_.THRM, 0x81)
            }
        }
    }
    Device(SLPB) {
        Name(_HID, 0x0e0cd041)
    }
    OperationRegion(EXCO, SystemIO, 0x72, 0x2)
    Field(EXCO, ByteAcc, NoLock, Preserve) {
        INDX,	8,
        DATA,	8
    }
    IndexField(INDX, DATA, ByteAcc, NoLock, Preserve) {
        Offset(0x20),
        ACST,	1,
        OKEC,	1,
        POPF,	1,
        BLTF,	1,
        W2KF,	2,
        S4WP,	1,
        FLA7,	1,
        LSFG,	1,
        LD10,	1,
        PS2M,	1,
        DISD,	3,
        OVRL,	1,
        Offset(0x22),
        SLEE,	8,
        BPFG,	8,
        PWST,	8,
        CM25,	8,
        CM26,	8,
        CM27,	8,
        CM28,	16,
        CM2A,	16,
        F4FG,	1,
        Offset(0x30),
        CM30,	8,
        CM31,	8,
        CM32,	8
    }
}

}
/*
BOOT: Length=3D40, Revision=3D1, Checksum=3D126,
	OEMID=3DACER, OEM Table ID=3DCardinal, OEM Revision=3D0x20021230,
	Creator ID=3D LTP, Creator Revision=3D0x1
 */

--Boundary-00=_98VWATJVbs94+DF
Content-Type: text/plain;
  charset="us-ascii";
  name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="interrupts"

           CPU0       
  0:    1392924          XT-PIC  timer
  1:       2949          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      80620          XT-PIC  uhci_hcd, eth0
  8:          2          XT-PIC  rtc
  9:        801          XT-PIC  acpi
 10:      79965          XT-PIC  radeon-D5X1nVylZaA@public.gmane.org:1:0:0, ehci_hcd, uhci_hcd, uhci_hcd
 12:        734          XT-PIC  i8042
 14:      14314          XT-PIC  ide0
NMI:          0 
LOC:    1392782 
ERR:          0
MIS:          0

--Boundary-00=_98VWATJVbs94+DF--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
