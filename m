From: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] ACPI-based floppy controller enumeration
Date: Tue, 17 Aug 2004 02:21:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040817002114.GJ1387@fs.tum.de>
References: <200408161225.01359.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XF85m9dhOBO43t/C"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408161225.01359.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 16, 2004 at 12:25:01PM -0600, Bjorn Helgaas wrote:

> Hi Adrian,

Hi Bjorn,

> I hate to ask for more favors, but it'd be great if you could give

no problem.

> this patch a whirl.  It would be very interesting to validate that
> it works for you, both with the floppies enabled and disabled in
> the BIOS.  If you try both those configurations, I'd like to see
> the full dmesg logs.
>...

It works for me in both cases.
dmesg logs are attached (they seem to be identical).


> This is against current BK, and depends on this recent ACPI update:
> http://linux.bkbits.net:8080/linux-2.5/cset%404117a4f5ujfiLt9Paj-V1vwM1-2QFA
>...

I've used 2.6.8.1-mm1 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-floppy-disabled

Linux version 2.6.8.1-mm1 (bunk-qVnFH74u8t9WinMUpH1FfB7hBYORjEh4s0AfqQuZ5sE@public.gmane.org) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #3 Tue Aug 17 01:06:48 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fab70
ACPI: RSDT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x0fff0000
ACPI: FADT (v001 AMIINT SiS740XX 0x00000011 MSFT 0x0100000b) @ 0x0fff0030
ACPI: MADT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x0fff00c0
ACPI: DSDT (v001    SiS      746 0x00000100 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=l-2.6.8.1-mm1 ro root=301 mode=1280x1024@760
CPU 0 irqstacks, hard=c04be000 soft=c04bd000
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1800.276 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254944k/262080k available (2534k kernel code, 6584k reserved, 1125k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3563.52 BogoMIPS (lpj=1781760)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 2200+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
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
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=155.00 Mhz, System=155.00 MHz
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon QY  DDR SGRAM 64 MB
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.17-WIP [Flags: R/O].
Console: switching to colour frame buffer device 160x64
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 746 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xd0000000
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
[drm] Used old pci detect: framebuffer loaded
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
sis900.c: v1.08.07 11/02/2003
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 6, 00:0b:6a:3b:93:a8.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SV1604N, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.2: reset hcs_params 0x102306 dbg=1 cc=2 pcc=3 ordered !ppc ports=6
ehci_hcd 0000:00:03.2: reset hcc_params 7070 thresh 7 uframes 1024
ehci_hcd 0000:00:03.2: capability 0001 at 70
ehci_hcd 0000:00:03.2: irq 10, pci mem d080e000
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.2: reset command 000002 (park)=0 ithresh=0 period=1024 Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:03.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:03.2: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Silicon Integrated Systems [SiS] USB 2.0 Controller
usb usb1: Manufacturer: Linux 2.6.8.1-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:03.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
i2c /dev entries driver
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x0c00
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:03.2: GetStatus port 5 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0xd800, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 160 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 144k freed
hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
hub 1-0:1.0: port 5 not reset yet, waiting 50ms
ehci_hcd 0000:00:03.2: port 5 high speed
ehci_hcd 0000:00:03.2: GetStatus port 5 status 001005 POWER sig=se0  PE CONNECT
usb 1-5: new high speed USB device using address 2
usb 1-5: new device strings: Mfr=0, Product=1, SerialNumber=2
usb 1-5: default language 0x0409
usb 1-5: Product: Macpower USB2.0A 3.5"HDD
usb 1-5: SerialNumber: 00003004200000011681
usb 1-5: hotplug
usb 1-5: adding 1-5:1.0 (config #1, interface 0)
usb 1-5:1.0: hotplug
usb-storage 1-5:1.0: usb_probe_interface
usb-storage 1-5:1.0: usb_probe_interface - got id
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Macpower  Model:  USB2.0A 3.5"HDD  Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
USB Mass Storage device found at 2
Adding 987988k swap on /dev/hda2.  Priority:-1 extents:1
eth0: Media Link On 10mbps half-duplex 

--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-floppy-enabled

Linux version 2.6.8.1-mm1 (bunk-qVnFH74u8t9WinMUpH1FfB7hBYORjEh4s0AfqQuZ5sE@public.gmane.org) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #3 Tue Aug 17 01:06:48 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fab70
ACPI: RSDT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x0fff0000
ACPI: FADT (v001 AMIINT SiS740XX 0x00000011 MSFT 0x0100000b) @ 0x0fff0030
ACPI: MADT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @ 0x0fff00c0
ACPI: DSDT (v001    SiS      746 0x00000100 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=l-2.6.8.1-mm1 ro root=301 mode=1280x1024@760
CPU 0 irqstacks, hard=c04be000 soft=c04bd000
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1800.276 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254944k/262080k available (2534k kernel code, 6584k reserved, 1125k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3563.52 BogoMIPS (lpj=1781760)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 2200+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
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
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=155.00 Mhz, System=155.00 MHz
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon QY  DDR SGRAM 64 MB
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.17-WIP [Flags: R/O].
Console: switching to colour frame buffer device 160x64
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 746 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xd0000000
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
[drm] Used old pci detect: framebuffer loaded
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
sis900.c: v1.08.07 11/02/2003
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 6, 00:0b:6a:3b:93:a8.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SV1604N, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.2: reset hcs_params 0x102306 dbg=1 cc=2 pcc=3 ordered !ppc ports=6
ehci_hcd 0000:00:03.2: reset hcc_params 7070 thresh 7 uframes 1024
ehci_hcd 0000:00:03.2: capability 0001 at 70
ehci_hcd 0000:00:03.2: irq 10, pci mem d080e000
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.2: reset command 000002 (park)=0 ithresh=0 period=1024 Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:03.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:03.2: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Silicon Integrated Systems [SiS] USB 2.0 Controller
usb usb1: Manufacturer: Linux 2.6.8.1-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:03.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
i2c /dev entries driver
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x0c00
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:03.2: GetStatus port 5 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0xd800, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 160 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 144k freed
hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
hub 1-0:1.0: port 5 not reset yet, waiting 50ms
ehci_hcd 0000:00:03.2: port 5 high speed
ehci_hcd 0000:00:03.2: GetStatus port 5 status 001005 POWER sig=se0  PE CONNECT
usb 1-5: new high speed USB device using address 2
usb 1-5: new device strings: Mfr=0, Product=1, SerialNumber=2
usb 1-5: default language 0x0409
usb 1-5: Product: Macpower USB2.0A 3.5"HDD
usb 1-5: SerialNumber: 00003004200000011681
usb 1-5: hotplug
usb 1-5: adding 1-5:1.0 (config #1, interface 0)
usb 1-5:1.0: hotplug
usb-storage 1-5:1.0: usb_probe_interface
usb-storage 1-5:1.0: usb_probe_interface - got id
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Macpower  Model:  USB2.0A 3.5"HDD  Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
USB Mass Storage device found at 2
Adding 987988k swap on /dev/hda2.  Priority:-1 extents:1
eth0: Media Link On 10mbps half-duplex 

--XF85m9dhOBO43t/C--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
