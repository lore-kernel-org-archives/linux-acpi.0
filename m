From: Lutz Vieweg <lkv-v424kkc4RuE@public.gmane.org>
Subject: ACPI problem on all new Asus W3400N notebook
Date: Sat, 12 Feb 2005 15:13:10 +0100
Message-ID: <420E0EF6.5090108@isg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080108080509080909060600"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080108080509080909060600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux ACPI developers,

I was able to obtain one of the first all-new ASUS W3400N notebooks
delivered (W3479NLP), and first of all I'd like to thank all the
contributors to the linux kernel who did such a good job that in
general, this new hardware works very well under Linux!

However, there are a few things left to get running, and other things
that I haven't tested, yet.

While e.g. cat /proc/acpi/battery/BAT0/info works and delivers
correct information, the most important thing to me that does
not work yet is reading the state of the battery:

  > cat /proc/acpi/battery/BAT0/state

returns nothing, the following is emitted to /var/log/messages:

kernel: dswstate-0277 [83] ds_result_pop_from_bot: No result objects! State=f7c8a428
kernel:  dsutils-0547 [83] ds_create_operand 	 : Missing or null operand, AE_AML_NO_RETURN_VALUE
kernel:  dsutils-0640 [82] ds_create_operands	 : While creating Arg 2 - AE_AML_NO_RETURN_VALUE
kernel:  psparse-1138: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node f7f8b328), AE_AML_NO_RETURN_VALUE
kernel: acpi_battery-0208 [73] acpi_battery_get_statu: Error evaluating _BST

The kernel running is a plain 2.6.10 with no modifications as of yet
(ACPI debug info enabled).

Find attached:

- The content of /proc/acpi/dsdt as gziped file attachment (asus_w3479_dsdt.gz)
- The content of /var/log/dmesg  (inline plaintext below)
- The content of /var/log/messages (inline plaintext below)
- The output of "lspci -vv" (inline plaintext below)

There are some ACPI-related error messages visible in /var/log/dmesg, see below.


A minor thing that does not work is

 > cat /proc/acpi/asus/
kernel: Asus ACPI: Error reading LCD status

while switching on the WLAN-indicator LED using "echo 1 >/proc/acpi/asus/wled" does work.

Thanks in advance for any help you might be able to provide!

If I can provide other useful information to identify the problem,
just ask.

Regards,

Lutz Vieweg


---------------------- /var/log/dmesg ----------------------------------
Linux version 2.6.10 (root@brick) (gcc version 3.4.3) #3 Fri Feb 11 01:43:15 CET 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003ff40000 (usable)
  BIOS-e820: 000000003ff40000 - 000000003ff50000 (ACPI data)
  BIOS-e820: 000000003ff50000 - 0000000040000000 (ACPI NVS)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 261952
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32576 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f5de0
ACPI: RSDT (v001 A M I  OEMRSDT  0x01000513 MSFT 0x00000097) @ 0x3ff40000
ACPI: FADT (v001 A M I  OEMFACP  0x01000513 MSFT 0x00000097) @ 0x3ff40200
ACPI: OEMB (v001 A M I  OEMBIOS  0x01000513 MSFT 0x00000097) @ 0x3ff50040
ACPI: DSDT (v001  1ABSP 1ABSP001 0x00000001 MSFT 0x02000001) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Built 1 zonelists
Kernel command line: ro root=/dev/hda6
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c047a000 soft=c0479000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2000.186 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033984k/1047808k available (2443k kernel code, 13152k reserved, 904k data, 184k init, 130304k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3964.92 BogoMIPS (lpj=1982464)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  afe9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps:        afe9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:..................................................................................................
..............................................................................................................................
..................................
Table [DSDT](id F004) - 953 Objects with 56 Devices 258 Methods 28 Regions
ACPI Namespace successfully loaded at root c0494600
ACPI: setting ELCR to 0200 (from 0ea0)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
checking if image is initramfs... it is
Freeing initrd memory: 296k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 8 Runtime GPEs in this block
Completing Region/Field/Buffer/Package 
initialization:........................................................................
..........................................................
Initialized 27/28 Regions 34/35 Fields 44/44 Buffers 25/25 Packages (962 nodes)
Executing all Device _STA and_INI methods:.............................................evregion-0309 [20] 
ev_address_space_dis
pa: No handler for Region [ECOR] (f7f821a8) [EmbeddedControl]
  exfldio-0265: *** Error: Region EmbeddedControl(3) has no handler
  psparse-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.ACS_] (Node f7f864a8), AE_NOT_EXIST
  psparse-1138: *** Error: Method execution failed [\_SB_.AC__._INI] (Node f7f889e8), AE_NOT_EXIST
   nsinit-0414 [06] ns_init_one_device    : \_SB_.AC__._INI._INI failed: AE_NOT_EXIST
..evregion-0309 [22] ev_address_space_dispa: No handler for Region [ECOR] (f7f821a8) [EmbeddedControl]
  exfldio-0265: *** Error: Region EmbeddedControl(3) has no handler
  psparse-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.BATS] (Node f7f86468), AE_NOT_EXIST
  psparse-1138: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node f7f8b2e8), AE_NOT_EXIST
   uteval-0158: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node f7f8b2e8), AE_NOT_EXIST
.............
60 Devices found containing: 59 _STA, 3 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Enabled i801 SMBus device
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6 10)
ACPI: PCI Interrupt Link [LNKE] (IRQs 6 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 6 *10 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
pnp: 00:07: ioport range 0xa00-0xa0f has been reserved
pnp: 00:0b: ioport range 0x540-0x55f has been reserved
pnp: 00:0b: ioport range 0x400-0x47f could not be reserved
pnp: 00:0b: ioport range 0x500-0x53f has been reserved
pnp: 00:0b: ioport range 0x4c0-0x4cf has been reserved
audit: initializing netlink socket (disabled)
audit(1108217764.641:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=390.00 Mhz, System=210.00 MHz
radeonfb: PLL min 20000 max 40000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1280x768 71MHz
radeonfb: detected LVDS panel size from BIOS: 1280x768
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon NP  SDR SGRAM 64 MB
vesafb: probe of vesafb0 failed with error -6
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
acpi_processor-2368 [11] acpi_processor_get_inf: Invalid PBLK length [7]
ACPI: Thermal Zone [THRM] (32 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xe0000000
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 9 (level, low) -> IRQ 9
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHU2100AT, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITAUJ-831D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 < hda5 hda6 hda7 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
  Firmware: 6.1
  180 degree mounted touchpad
  Sensor: 35
  new absolute packet format
  Touchpad has extended capability bits
  -> multifinger detection
  -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI wakeup devices:
SMBS MODM P0P2 USB1 USB2 USB3 EHCI
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 184k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
divert: allocating divert_blk for eth0
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
       PrefPort:A  RlmtMode:Check Link State
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49497 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
hw_random: RNG not detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xffaffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0xe800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 0xe880
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 9, io base 0xec00
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 7 (level, low) -> IRQ 7
Yenta: CardBus bridge found at 0000:02:01.0 [1043:1987]
Yenta: ISA IRQ mask 0x0018, PCI irq 7
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[ff9fb000-ff9fb7ff]  Max Packet=[2048]
Asus Laptop ACPI Extras version 0.29
   W3N model detected, unsupported, trying default values, supply the developers with your DSDT
EXT3 FS on hda6, internal journal
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
cdrom: open failed.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000327ac89]
Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
--------------------------------------------------------------------------------------












---------------------- /var/log/messages --------------------------------
Feb 12 14:16:24 brick syslogd 1.4.1: restart.
Feb 12 14:16:24 brick syslog: syslogd startup succeeded
Feb 12 14:16:24 brick kernel: klogd 1.4.1, log source = /proc/kmsg started.
Feb 12 14:16:24 brick kernel: Linux version 2.6.10 (root@brick) (gcc version 3.4.3) #3 Fri Feb 11 01:43:15 CET 2005
Feb 12 14:16:24 brick kernel: BIOS-provided physical RAM map:
Feb 12 14:16:24 brick kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb 12 14:16:24 brick kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb 12 14:16:24 brick kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Feb 12 14:16:24 brick kernel:  BIOS-e820: 0000000000100000 - 000000003ff40000 (usable)
Feb 12 14:16:24 brick kernel:  BIOS-e820: 000000003ff40000 - 000000003ff50000 (ACPI data)
Feb 12 14:16:24 brick kernel:  BIOS-e820: 000000003ff50000 - 0000000040000000 (ACPI NVS)
Feb 12 14:16:24 brick kernel: 127MB HIGHMEM available.
Feb 12 14:16:24 brick kernel: 896MB LOWMEM available.
Feb 12 14:16:24 brick syslog: klogd startup succeeded
Feb 12 14:16:24 brick netfs: Mounting other filesystems:  succeeded
Feb 12 14:16:24 brick kernel: DMI 2.3 present.
Feb 12 14:16:24 brick kernel: ACPI: PM-Timer IO Port: 0x408
Feb 12 14:16:24 brick kernel: Built 1 zonelists
Feb 12 14:16:24 brick kernel: Kernel command line: ro root=/dev/hda6
Feb 12 14:16:24 brick kernel: Found and enabled local APIC!
Feb 12 14:16:24 brick kernel: Initializing CPU#0
Feb 12 14:16:24 brick kernel: CPU 0 irqstacks, hard=c047a000 soft=c0479000
Feb 12 14:16:24 brick kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Feb 12 14:16:24 brick kernel: Detected 2000.186 MHz processor.
Feb 12 14:16:24 brick kernel: Using pmtmr for high-res timesource
Feb 12 14:16:24 brick kernel: Console: colour VGA+ 80x25
Feb 12 14:16:24 brick kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb 12 14:16:24 brick kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb 12 14:16:24 brick acpid: acpid startup succeeded
Feb 12 14:16:24 brick kernel: Memory: 1033984k/1047808k available (2443k kernel code, 13152k reserved, 904k data, 184k 
init, 130304k highmem)
Feb 12 14:16:24 brick kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb 12 14:16:24 brick kernel: Security Framework v1.0.0 initialized
Feb 12 14:16:24 brick kernel: Capability LSM initialized
Feb 12 14:16:24 brick kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 12 14:16:25 brick sshd:  succeeded
Feb 12 14:16:25 brick kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Feb 12 14:16:25 brick kernel: CPU: L2 cache: 2048K
Feb 12 14:16:25 brick kernel: Intel machine check architecture supported.
Feb 12 14:16:25 brick kernel: Intel machine check reporting enabled on CPU#0.
Feb 12 14:16:25 brick gpm[3274]: *** info [startup.c(95)]:
Feb 12 14:16:25 brick kernel: CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 06
Feb 12 14:16:25 brick gpm[3274]: Started gpm successfully. Entered daemon mode.
Feb 12 14:16:25 brick kernel: Enabling fast FPU save and restore... done.
Feb 12 14:16:25 brick kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 12 14:16:25 brick kernel: Checking 'hlt' instruction... OK.
Feb 12 14:16:25 brick kernel:  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Feb 12 14:16:25 brick kernel: Parsing all Control 
Methods:..................................................................................................................................................................................................................................................................
Feb 12 14:16:25 brick kernel: Table [DSDT](id F004) - 953 Objects with 56 Devices 258 Methods 28 Regions
Feb 12 14:16:25 brick kernel: ACPI Namespace successfully loaded at root c0494600
Feb 12 14:16:25 brick kernel: ACPI: setting ELCR to 0200 (from 0ea0)
Feb 12 14:16:25 brick kernel: evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
Feb 12 14:16:25 brick kernel: checking if image is initramfs... it is
Feb 12 14:16:25 brick kernel: Freeing initrd memory: 296k freed
Feb 12 14:16:25 brick kernel: NET: Registered protocol family 16
Feb 12 14:16:25 brick kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
Feb 12 14:16:25 brick kernel: PCI: Using configuration type 1
Feb 12 14:16:25 brick kernel: mtrr: v2.0 (20020519)
Feb 12 14:16:25 brick gpm[3274]: *** info [mice.c(1766)]:
Feb 12 14:16:25 brick kernel: ACPI: Subsystem revision 20041105
Feb 12 14:16:25 brick gpm[3274]: imps2: Auto-detected intellimouse PS/2
Feb 12 14:16:25 brick kernel: evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
Feb 12 14:16:25 brick kernel: evgpeblk-0987 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 8 Runtime GPEs in this block
Feb 12 14:16:25 brick kernel: Completing Region/Field/Buffer/Package 
initialization:..................................................................................................................................
Feb 12 14:16:25 brick kernel: Initialized 27/28 Regions 34/35 Fields 44/44 Buffers 25/25 Packages (962 nodes)
Feb 12 14:16:25 brick kernel: Executing all Device _STA and_INI 
methods:.............................................evregion-0309 [20] ev_address_space_dispa: No handler for Region 
[ECOR] (f7f821a8) [EmbeddedControl]
Feb 12 14:16:25 brick kernel:  exfldio-0265: *** Error: Region EmbeddedControl(3) has no handler
Feb 12 14:16:25 brick kernel:  psparse-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.ACS_] (Node 
f7f864a8), AE_NOT_EXIST
Feb 12 14:16:25 brick kernel:  psparse-1138: *** Error: Method execution failed [\_SB_.AC__._INI] (Node f7f889e8), 
AE_NOT_EXIST
Feb 12 14:16:25 brick kernel:   nsinit-0414 [06] ns_init_one_device    : \_SB_.AC__._INI._INI failed: AE_NOT_EXIST
Feb 12 14:16:25 brick kernel: ..evregion-0309 [22] ev_address_space_dispa: No handler for Region [ECOR] (f7f821a8) 
[EmbeddedControl]
Feb 12 14:16:25 brick kernel:  exfldio-0265: *** Error: Region EmbeddedControl(3) has no handler
Feb 12 14:16:25 brick kernel:  psparse-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.BATS] (Node 
f7f86468), AE_NOT_EXIST
Feb 12 14:16:25 brick kernel:  psparse-1138: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node f7f8b2e8), 
AE_NOT_EXIST
Feb 12 14:16:25 brick kernel:   uteval-0158: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node f7f8b2e8), 
AE_NOT_EXIST
Feb 12 14:16:25 brick kernel: .............
Feb 12 14:16:25 brick kernel: 60 Devices found containing: 59 _STA, 3 _INI methods
Feb 12 14:16:25 brick kernel: ACPI: Interpreter enabled
Feb 12 14:16:25 brick kernel: ACPI: Using PIC for interrupt routing
Feb 12 14:16:25 brick kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Feb 12 14:16:25 brick kernel: PCI: Probing PCI hardware (bus 00)
Feb 12 14:16:25 brick kernel: PCI: Enabled i801 SMBus device
Feb 12 14:16:25 brick kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Feb 12 14:16:25 brick kernel: PCI: Transparent bridge - 0000:00:1e.0
Feb 12 14:16:25 brick kernel: ACPI: Embedded Controller [EC0] (gpe 28)
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 11 12)
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6 10)
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 6 11) *0, disabled.
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7) *0, disabled.
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7) *0, disabled.
Feb 12 14:16:25 brick kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 4 6 *10 12)
Feb 12 14:16:25 brick kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb 12 14:16:25 brick kernel: pnp: PnP ACPI init
Feb 12 14:16:25 brick gpm: gpm startup succeeded
Feb 12 14:16:25 brick kernel: pnp: PnP ACPI: found 14 devices
Feb 12 14:16:25 brick kernel: usbcore: registered new driver usbfs
Feb 12 14:16:25 brick kernel: usbcore: registered new driver hub
Feb 12 14:16:25 brick kernel: PCI: Using ACPI for IRQ routing
Feb 12 14:16:25 brick crond: crond startup succeeded
Feb 12 14:16:25 brick kernel: ** PCI interrupts are no longer routed automatically.  If this
Feb 12 14:16:25 brick kernel: ** causes a device to stop working, it is probably because the
Feb 12 14:16:26 brick kernel: ** driver failed to call pci_enable_device().  As a temporary
Feb 12 14:16:27 brick xfs: xfs startup succeeded
Feb 12 14:16:27 brick kernel: ** workaround, the "pci=routeirq" argument restores the old
Feb 12 14:16:27 brick atd: atd startup succeeded
Feb 12 14:16:27 brick xfs[3326]: ignoring font path element /usr/X11R6/lib/X11/fonts/Speedo (unreadable)
Feb 12 14:16:27 brick kernel: ** behavior.  If this argument makes the device work again,
Feb 12 14:16:27 brick hal.hotplug[3676]: DEVPATH is not set
Feb 12 14:16:28 brick kernel: ** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
Feb 12 14:16:28 brick kernel: ** so I can fix the driver.
Feb 12 14:16:28 brick kernel: pnp: 00:07: ioport range 0xa00-0xa0f has been reserved
Feb 12 14:16:28 brick kernel: pnp: 00:0b: ioport range 0x540-0x55f has been reserved
Feb 12 14:16:28 brick kernel: pnp: 00:0b: ioport range 0x400-0x47f could not be reserved
Feb 12 14:16:28 brick kernel: pnp: 00:0b: ioport range 0x500-0x53f has been reserved
Feb 12 14:16:28 brick kernel: pnp: 00:0b: ioport range 0x4c0-0x4cf has been reserved
Feb 12 14:16:30 brick kernel: audit: initializing netlink socket (disabled)
Feb 12 14:16:30 brick kernel: audit(1108217764.641:0): initialized
Feb 12 14:16:30 brick kernel: highmem bounce pool size: 64 pages
Feb 12 14:16:30 brick kernel: Total HugeTLB memory allocated, 0
Feb 12 14:16:30 brick kernel: VFS: Disk quotas dquot_6.5.1
Feb 12 14:16:30 brick kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb 12 14:16:30 brick kernel: Initializing Cryptographic API
Feb 12 14:16:31 brick kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Feb 12 14:16:31 brick kernel: PCI: setting IRQ 11 as level-triggered
Feb 12 14:16:31 brick kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Feb 12 14:16:31 brick kernel: radeonfb: Retreived PLL infos from BIOS
Feb 12 14:16:31 brick kernel: radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=390.00 Mhz, System=210.00 MHz
Feb 12 14:16:31 brick kernel: radeonfb: PLL min 20000 max 40000
Feb 12 14:16:31 brick kernel: Non-DDC laptop panel detected
Feb 12 14:16:31 brick kernel: radeonfb: Monitor 1 type LCD found
Feb 12 14:16:31 brick kernel: radeonfb: Monitor 2 type no found
Feb 12 14:16:31 brick kernel: radeonfb: panel ID string: 1280x768 71MHz
Feb 12 14:16:31 brick kernel: radeonfb: detected LVDS panel size from BIOS: 1280x768
Feb 12 14:16:31 brick kernel: radeondb: BIOS provided dividers will be used
Feb 12 14:16:31 brick kernel: radeonfb: Power Management enabled for Mobility chipsets
Feb 12 14:16:31 brick kernel: radeonfb: ATI Radeon NP  SDR SGRAM 64 MB
Feb 12 14:16:31 brick kernel: vesafb: probe of vesafb0 failed with error -6
Feb 12 14:16:31 brick kernel: ACPI: AC Adapter [AC] (on-line)
Feb 12 14:16:31 brick kernel: ACPI: Battery Slot [BAT0] (battery absent)
Feb 12 14:16:31 brick kernel: ACPI: Battery Slot [BAT1] (battery absent)
Feb 12 14:16:31 brick kernel: ACPI: Power Button (FF) [PWRF]
Feb 12 14:16:31 brick kernel: ACPI: Lid Switch [LID]
Feb 12 14:16:31 brick kernel: ACPI: Sleep Button (CM) [SLPB]
Feb 12 14:16:31 brick kernel: ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Feb 12 14:16:31 brick kernel: acpi_processor-2368 [11] acpi_processor_get_inf: Invalid PBLK length [7]
Feb 12 14:16:31 brick kernel: ACPI: Thermal Zone [THRM] (32 C)
Feb 12 14:16:31 brick kernel: isapnp: Scanning for PnP cards...
Feb 12 14:16:31 brick kernel: isapnp: No Plug & Play device found
Feb 12 14:16:31 brick kernel: Real Time Clock Driver v1.12
Feb 12 14:16:31 brick kernel: Linux agpgart interface v0.100 (c) Dave Jones
Feb 12 14:16:31 brick kernel: agpgart: Detected an Intel 855PM Chipset.
Feb 12 14:16:31 brick kernel: agpgart: Maximum main memory to use for agp memory: 941M
Feb 12 14:16:31 brick kernel: agpgart: AGP aperture is 256M @ 0xe0000000
Feb 12 14:16:31 brick kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
Feb 12 14:16:31 brick kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Feb 12 14:16:31 brick kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Feb 12 14:16:31 brick kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Feb 12 14:16:31 brick kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Feb 12 14:16:31 brick kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 12 14:16:31 brick kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
Feb 12 14:16:31 brick kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 12 14:16:31 brick kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
Feb 12 14:16:31 brick kernel: PCI: setting IRQ 7 as level-triggered
Feb 12 14:16:31 brick kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
Feb 12 14:16:31 brick kernel: io scheduler noop registered
Feb 12 14:16:31 brick kernel: io scheduler anticipatory registered
Feb 12 14:16:31 brick kernel: io scheduler deadline registered
Feb 12 14:16:31 brick kernel: io scheduler cfq registered
Feb 12 14:16:31 brick kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Feb 12 14:16:31 brick kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 12 14:16:31 brick kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 12 14:16:31 brick kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Feb 12 14:16:31 brick kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Feb 12 14:16:31 brick kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
Feb 12 14:16:31 brick kernel: PCI: setting IRQ 9 as level-triggered
Feb 12 14:16:31 brick kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 9 (level, low) -> IRQ 9
Feb 12 14:16:31 brick kernel: ICH4: chipset revision 3
Feb 12 14:16:31 brick kernel: ICH4: not 100% native mode: will probe irqs later
Feb 12 14:16:31 brick kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Feb 12 14:16:32 brick kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Feb 12 14:16:32 brick kernel: hda: FUJITSU MHU2100AT, ATA DISK drive
Feb 12 14:16:32 brick kernel: elevator: using anticipatory as default io scheduler
Feb 12 14:16:32 brick kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 14:16:32 brick kernel: hdc: MATSHITAUJ-831D, ATAPI CD/DVD-ROM drive
Feb 12 14:16:32 brick kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 12 14:16:32 brick kernel: hda: max request size: 128KiB
Feb 12 14:16:32 brick kernel: hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
Feb 12 14:16:32 brick kernel:  hda: hda1 hda2 < hda5 hda6 hda7 >
Feb 12 14:16:32 brick kernel: hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Feb 12 14:16:32 brick kernel: Uniform CD-ROM driver Revision: 3.20
Feb 12 14:16:32 brick kernel: ide-floppy driver 0.99.newide
Feb 12 14:16:32 brick kernel: usbcore: registered new driver hiddev
Feb 12 14:16:32 brick kernel: usbcore: registered new driver usbhid
Feb 12 14:16:32 brick kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Feb 12 14:16:32 brick kernel: mice: PS/2 mouse device common for all mice
Feb 12 14:16:32 brick kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Feb 12 14:16:32 brick kernel: Synaptics Touchpad, model: 1
Feb 12 14:16:32 brick kernel:  Firmware: 6.1
Feb 12 14:16:32 brick kernel:  180 degree mounted touchpad
Feb 12 14:16:32 brick kernel:  Sensor: 35
Feb 12 14:16:32 brick kernel:  new absolute packet format
Feb 12 14:16:32 brick kernel:  Touchpad has extended capability bits
Feb 12 14:16:32 brick kernel:  -> multifinger detection
Feb 12 14:16:32 brick kernel:  -> palm detection
Feb 12 14:16:32 brick kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio4
Feb 12 14:16:32 brick kernel: md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Feb 12 14:16:32 brick kernel: NET: Registered protocol family 2
Feb 12 14:16:32 brick kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Feb 12 14:16:32 brick kernel: TCP: Hash tables configured (established 262144 bind 65536)
Feb 12 14:16:32 brick kernel: Initializing IPsec netlink socket
Feb 12 14:16:32 brick kernel: NET: Registered protocol family 1
Feb 12 14:16:32 brick kernel: NET: Registered protocol family 17
Feb 12 14:16:32 brick kernel: ACPI wakeup devices:
Feb 12 14:16:32 brick kernel: SMBS MODM P0P2 USB1 USB2 USB3 EHCI
Feb 12 14:16:32 brick kernel: ACPI: (supports S0 S3 S4 S5)
Feb 12 14:16:32 brick kernel: Freeing unused kernel memory: 184k freed
Feb 12 14:16:32 brick kernel: kjournald starting.  Commit interval 5 seconds
Feb 12 14:16:32 brick kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
Feb 12 14:16:32 brick kernel: eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
Feb 12 14:16:32 brick kernel:       PrefPort:A  RlmtMode:Check Link State
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
Feb 12 14:16:32 brick kernel: intel8x0_measure_ac97_clock: measured 49497 usecs
Feb 12 14:16:32 brick kernel: intel8x0: clocking to 48000
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
Feb 12 14:16:32 brick kernel: MC'97 1 converters and GPIO not ready (0xff00)
Feb 12 14:16:32 brick kernel: hw_random: RNG not detected
Feb 12 14:16:32 brick kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
Feb 12 14:16:32 brick kernel: PCI: setting IRQ 10 as level-triggered
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
Feb 12 14:16:32 brick kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Feb 12 14:16:32 brick kernel: ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xffaffc00
Feb 12 14:16:32 brick kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Feb 12 14:16:32 brick kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
Feb 12 14:16:32 brick kernel: hub 1-0:1.0: USB hub found
Feb 12 14:16:32 brick kernel: hub 1-0:1.0: 6 ports detected
Feb 12 14:16:32 brick kernel: USB Universal Host Controller Interface driver v2.2
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0xe800
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Feb 12 14:16:32 brick kernel: hub 2-0:1.0: USB hub found
Feb 12 14:16:32 brick kernel: hub 2-0:1.0: 2 ports detected
Feb 12 14:16:32 brick kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
Feb 12 14:16:32 brick kernel: PCI: setting IRQ 5 as level-triggered
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.1: irq 5, io base 0xe880
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Feb 12 14:16:32 brick kernel: hub 3-0:1.0: USB hub found
Feb 12 14:16:32 brick kernel: hub 3-0:1.0: 2 ports detected
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.2: irq 9, io base 0xec00
Feb 12 14:16:32 brick kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Feb 12 14:16:32 brick kernel: hub 4-0:1.0: USB hub found
Feb 12 14:16:32 brick kernel: hub 4-0:1.0: 2 ports detected
Feb 12 14:16:32 brick kernel: Linux Kernel Card Services
Feb 12 14:16:32 brick kernel:   options:  [pci] [cardbus] [pm]
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 7 (level, low) -> IRQ 7
Feb 12 14:16:32 brick kernel: Yenta: CardBus bridge found at 0000:02:01.0 [1043:1987]
Feb 12 14:16:32 brick kernel: Yenta: ISA IRQ mask 0x0018, PCI irq 7
Feb 12 14:16:32 brick kernel: Socket status: 30000006
Feb 12 14:16:32 brick kernel: ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
Feb 12 14:16:32 brick kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[ff9fb000-ff9fb7ff]  Max Packet=[2048]
Feb 12 14:16:32 brick kernel: Asus Laptop ACPI Extras version 0.29
Feb 12 14:16:32 brick kernel:   W3N model detected, unsupported, trying default values, supply the developers with your DSDT
Feb 12 14:16:32 brick kernel: EXT3 FS on hda6, internal journal
Feb 12 14:16:32 brick kernel: device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Feb 12 14:16:32 brick kernel: cdrom: open failed.
Feb 12 14:16:32 brick kernel: Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
Feb 12 14:16:32 brick kernel: ip_tables: (C) 2000-2002 Netfilter core team
Feb 12 14:16:32 brick kernel: ip_conntrack version 2.1 (8186 buckets, 65488 max) - 336 bytes per conntrack
Feb 12 14:16:32 brick kernel: eth0: network connection up using port A
Feb 12 14:16:32 brick kernel:     speed:           1000
Feb 12 14:16:32 brick kernel:     autonegotiation: yes
Feb 12 14:16:32 brick kernel:     duplex mode:     full
Feb 12 14:16:32 brick kernel:     flowctrl:        symmetric
Feb 12 14:16:32 brick kernel:     role:            slave
Feb 12 14:16:32 brick kernel:     irq moderation:  static (2000 ints/sec)
Feb 12 14:16:32 brick kernel:     scatter-gather:  enabled
Feb 12 14:16:32 brick kernel: NET: Registered protocol family 10
Feb 12 14:16:32 brick kernel: Disabled Privacy Extensions on device c040cf00(lo)
Feb 12 14:16:32 brick kernel: IPv6 over IPv4 tunneling driver
Feb 12 14:16:32 brick kernel: hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
Feb 12 14:16:32 brick kernel:
Feb 12 14:16:32 brick kernel: ide: failed opcode was: unknown
Feb 12 14:16:32 brick kernel: hda: status timeout: status=0xd0 { Busy }
Feb 12 14:16:32 brick kernel:
Feb 12 14:16:32 brick kernel: ide: failed opcode was: unknown
Feb 12 14:16:32 brick kernel: hda: DMA disabled
Feb 12 14:16:32 brick kernel: hda: drive not ready for command
Feb 12 14:16:32 brick kernel: hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
Feb 12 14:16:32 brick kernel: ide: failed opcode was 100
Feb 12 14:16:32 brick kernel: ide0: reset: success
Feb 12 14:16:32 brick kernel: input: PC Speaker
Feb 12 14:16:32 brick kernel: fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' 
taints kernel.
Feb 12 14:16:32 brick kernel: [fglrx] Maximum main memory to use for locked dma buffers: 928 MBytes.
Feb 12 14:16:32 brick kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Feb 12 14:16:32 brick kernel: [fglrx] module loaded - fglrx 8.8.25 [Jan 14 2005] on minor 0
Feb 12 14:16:32 brick kernel: Fire GL built-in AGP-support
Feb 12 14:16:32 brick kernel: Based on agpgart interface v0.99 (c) Jeff Hartmann
Feb 12 14:16:32 brick kernel: agpgart: Maximum main memory to use for agp memory: 816M
Feb 12 14:16:32 brick kernel: agpgart: Detected an Intel 855PM Chipset, no integrated grapics found.
Feb 12 14:16:32 brick kernel: agpgart: Detected Intel i855PM chipset
Feb 12 14:16:32 brick kernel: agpgart: AGP aperture is 256M @ 0xe0000000
Feb 12 14:16:32 brick kernel: Power management callback for AGP chipset installed
Feb 12 14:16:32 brick kernel: [fglrx] AGP detected, AgpState   = 0x1f000217 (hardware caps of chipset)
Feb 12 14:16:32 brick kernel: AGP: Found 2 AGPv2 devices
Feb 12 14:16:32 brick kernel: AGP: Doing enable for AGPv2
Feb 12 14:16:32 brick kernel: [fglrx] AGP enabled,  AgpCommand = 0x1f000314 (selected caps)
Feb 12 14:16:32 brick kernel: [fglrx] free  AGP = 256126976
Feb 12 14:16:32 brick kernel: [fglrx] max   AGP = 256126976
Feb 12 14:16:32 brick kernel: [fglrx] free  LFB = 53211136
Feb 12 14:16:32 brick kernel: [fglrx] max   LFB = 53211136
Feb 12 14:16:32 brick kernel: [fglrx] free  Inv = 0
Feb 12 14:16:32 brick kernel: [fglrx] max   Inv = 0
Feb 12 14:16:32 brick kernel: [fglrx] total Inv = 0
Feb 12 14:16:33 brick kernel: [fglrx] total TIM = 0
Feb 12 14:16:34 brick kernel: [fglrx] total FB  = 0
Feb 12 14:16:34 brick kernel: [fglrx] total AGP = 65536
-----------------------------------------------------------------------------------


--------- output of "find /proc/acpi -type f" ----------------------------
/proc/acpi/asus/disp
/proc/acpi/asus/brn
/proc/acpi/asus/lcd
/proc/acpi/asus/mled
/proc/acpi/asus/wled
/proc/acpi/asus/info
/proc/acpi/wakeup
/proc/acpi/alarm
/proc/acpi/sleep
/proc/acpi/thermal_zone/THRM/polling_frequency
/proc/acpi/thermal_zone/THRM/cooling_mode
/proc/acpi/thermal_zone/THRM/trip_points
/proc/acpi/thermal_zone/THRM/temperature
/proc/acpi/thermal_zone/THRM/state
/proc/acpi/processor/CPU1/performance
/proc/acpi/processor/CPU1/limit
/proc/acpi/processor/CPU1/throttling
/proc/acpi/processor/CPU1/power
/proc/acpi/processor/CPU1/info
/proc/acpi/video/VGA/LCD/EDID
/proc/acpi/video/VGA/LCD/brightness
/proc/acpi/video/VGA/LCD/state
/proc/acpi/video/VGA/LCD/info
/proc/acpi/video/VGA/TV/EDID
/proc/acpi/video/VGA/TV/brightness
/proc/acpi/video/VGA/TV/state
/proc/acpi/video/VGA/TV/info
/proc/acpi/video/VGA/CRT/EDID
/proc/acpi/video/VGA/CRT/brightness
/proc/acpi/video/VGA/CRT/state
/proc/acpi/video/VGA/CRT/info
/proc/acpi/video/VGA/DOS
/proc/acpi/video/VGA/POST
/proc/acpi/video/VGA/POST_info
/proc/acpi/video/VGA/ROM
/proc/acpi/video/VGA/info
/proc/acpi/button/sleep/SLPB/info
/proc/acpi/button/lid/LID/state
/proc/acpi/button/lid/LID/info
/proc/acpi/button/power/PWRF/info
/proc/acpi/battery/BAT1/alarm
/proc/acpi/battery/BAT1/state
/proc/acpi/battery/BAT1/info
/proc/acpi/battery/BAT0/alarm
/proc/acpi/battery/BAT0/state
/proc/acpi/battery/BAT0/info
/proc/acpi/ac_adapter/AC/state
/proc/acpi/debug_level
/proc/acpi/debug_layer
/proc/acpi/event
/proc/acpi/fadt
/proc/acpi/dsdt
/proc/acpi/info
/proc/acpi/embedded_controller/EC0/info
-----------------------------------------------------------------------------------


------- output of lspci -vv  ------------------------------------------------------
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 186a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] Vendor Specific Information
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 21) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff800000-ff8fffff
	Prefetchable memory behind bridge: ce900000-de9fffff
	Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1869
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at e800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1869
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at e880 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1869
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at ec00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1868
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at ffaffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff900000-ff9fffff
	Prefetchable memory behind bridge: dea00000-deafffff
	Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM (ICH4-M) LPC Interface Bridge (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4-M) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1869
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1869
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 0540 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1893
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 7
	Region 0: I/O ports at ee00 [size=256]
	Region 1: I/O ports at e000 [size=64]
	Region 2: Memory at ffaff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at ffaff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1826
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 7
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at e080 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1772
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), Cache Line Size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c800 [size=256]
	Region 2: Memory at ff8f0000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at ff8c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 173c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), Cache Line Size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ff9fc000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at d800 [size=256]
	Expansion ROM at ff9c0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data

02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1987
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at 40001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 40400000-407ff000 (prefetchable)
	Memory window 1: 40800000-40bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 08) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1987
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at ff9fb000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

02:01.2 Class 0805: Ricoh Co Ltd: Unknown device 0822 (rev 17)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1987
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin C routed to IRQ 9
	Region 0: Memory at ff9fb800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:01.3 System peripheral: Ricoh Co Ltd: Unknown device 0592 (rev 08)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1987
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: Memory at ff9fbc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:02.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corp.: Unknown device 2701
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 6000ns max), Cache Line Size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ff9fa000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
------------------------------------------------------------------------------------------------

---------- output of cat /proc/acpi/asus/info ----------------
Asus Laptop ACPI Extras Driver 0.29
Model reference    : M2E
SFUN value         : 0x0877
DSDT length        : 25774
DSDT checksum      : 142
DSDT revision      : 1
OEM id             : 1ABSP
OEM table id       : 1ABSP001
OEM revision       : 0x1
ASL comp vendor id : MSFT
ASL comp revision  : 0x2000001
------------------------------------------------------------------------------------------------


--------------080108080509080909060600
Content-Type: application/x-tar;
 name="asus_w3479_dsdt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="asus_w3479_dsdt.gz"

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
18g4/gOAX1PTrmQAAA==
--------------080108080509080909060600--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
