From: Fabio Zyserman <zyserman-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org>
Subject: Re: ACPI and cooling fan control
Date: Mon, 06 Jun 2005 13:59:47 -0300
Message-ID: <42A48103.6060307@fcaglp.unlp.edu.ar>
References: <429AFFA0.1090401@fcaglp.unlp.edu.ar> <20050601222536.GA32150@elf.ucw.cz>
Reply-To: zyserman-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010404090802020907070904"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050601222536.GA32150-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010404090802020907070904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pavel, thanks for your mail;
here I am posting a more detailed
version of my question, (without exclamation marks):


If I boot with: acpi=off pci=biosirq pci=usepirqmask

the fan works ok, and if I close the lid, the screen
goes black.

When I boot with acpi enabled, the fan sometimes
does not start at boot time, but it begins to work if I read
the /proc/acpi/thermal_zone/THZN/temperature file.

Once I do that, the fan keeps working ok, increasing
/decreasing its speed if the temperature of the
processor increases/decreases.
However, the /proc/acpi/fan/FAN/status file
reads always "off"

The screen does not go black when I close the lid.

I have also tried 'suspend to ram', but it did not work,
the computer suspended, but failed to resume correctly.

I am attaching the dmesg file; there are some
errors that seem to have to do with acpi, which I am
unable to decipher.



Regards to all,

Fabio Zyserman


Pavel Machek wrote:
> Hi!
> 
> 
>>Hi folks, I am posting a new version
>>of my previous message, which was
>>''Laptop powers off randomly''
>>
>>Again, I have an A60 toshiba laptop,
>>running kernel 2.6.10
>>
>>I have experienced that it is not randomly,
>>but when the fan stops (and then overheats, and
>>powers off). The problem is
>>
>>why does the fan stop randomly?!!!
> 
> 
> Look into /proc/acpi/thermal*/ and syslog for some hints... [And try
> to use less exclamation marks].
> 
> 							Pavel
> 

--------------010404090802020907070904
Content-Type: text/plain;
 name="dmesg-acpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-acpi"

Linux version 2.6.10 (root@satellite) (gcc version 3.3.4) #1 Tue May 17 03:19:39 ART 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bffffc0 (ACPI data)
 BIOS-e820: 000000000bffffc0 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49136
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45040 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                ) @ 0x000e6010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @ 0x0bffb60f
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @ 0x0bfffa90
ACPI: MADT (v001 INSYDE APIC_000 0x30303030 0000 0x30303030) @ 0x0bfffb20
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @ 0x0bfffb90
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030522) @ 0x0bffb822
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030522) @ 0x0bffb647
ACPI: DSDT (v001 TOSINV   Avani2 0x00001004 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: BOOT_IMAGE=linux ro root=302
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 2534.026 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 189836k/196544k available (2851k kernel code, 6204k reserved, 1085k data, 272k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5029.88 BogoMIPS (lpj=2514944)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Celeron(R) CPU 2.53GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xe9964, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNK2] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 10 11) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 7)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: Power Resource [PFA1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
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
irda_init()
NET: Registered protocol family 23
pnp: 00:06: ioport range 0x200-0x20f has been reserved
pnp: 00:06: ioport range 0x280-0x29f has been reserved
pnp: 00:06: ioport range 0x40b-0x40b has been reserved
Simple Boot Flag at 0x37 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN1] (off)
ACPI: Thermal Zone [THZN] (35 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Ati IGP7000/M chipset
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: AGP aperture is 64M @ 0xb0000000
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: PCI device 1002:4437 (ATI Technologies Inc)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:14.6[B] -> GSI 10 (level, low) -> IRQ 10
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI interrupt 0000:00:14.1[A] -> GSI 11 (level, low) -> IRQ 11
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8070-0x8077, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8078-0x807f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK3025GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R2512, ATAPI CD/DVD-ROM drive
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
hda: 58605120 sectors (30005 MB), CHS=58140/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:06.0 [1179:ff10]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x01111122, devctl 0x64
Yenta: ISA IRQ mask 0x00f8, PCI irq 11
Socket status: 30000006
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:13.0: PCI device 1002:4347 (ATI Technologies Inc)
ohci_hcd 0000:00:13.0: irq 11, pci mem 0xf0001000
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:13.1: PCI device 1002:4348 (ATI Technologies Inc)
ohci_hcd 0000:00:13.1: irq 11, pci mem 0xf0002000
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
EISA: Probing bus 0 at eisa0
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.0
wbsd: Copyright(c) Pierre Ossman
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 10 (level, low) -> IRQ 10
ALSA sound/pci/atiixp.c:521: atiixp: codec reset timeout
ACPI: PCI interrupt 0000:00:14.6[B] -> GSI 10 (level, low) -> IRQ 10
ALSA device list:
  #0: ATI IXP rev 0 with ALC250 at 0xf0000400, irq 10
  #1: ATI IXP Modem rev 1 at 0xf0000500, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
divert: allocating divert_blk for irlan0
IrCOMM protocol (Dag Brattli)
ACPI wakeup devices: 
 LID USB0 USB1 USB2 MC97  P2P LAN0 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 272k freed
Adding 530136k swap on /dev/hda3.  Priority:-1 extents:1
input: PS/2 Synaptics TouchPad on isa0060/serio1
NTFS driver 2.1.22 [Flags: R/W MODULE].
NTFS volume version 3.1.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 5 (level, low) -> IRQ 5
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xa000, 00:a0:d1:db:15:c3, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
eth0: link down
PCI: Enabling device 0000:00:13.2 (0000 -> 0002)
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:13.2: PCI device 1002:4345 (ATI Technologies Inc)
ehci_hcd 0000:00:13.2: irq 11, pci mem 0x10000000
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
input: PC Speaker
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
NET: Registered protocol family 10
Disabled Privacy Extensions on device c048c1c0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode

--------------010404090802020907070904--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
