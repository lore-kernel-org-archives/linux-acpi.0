From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: S3 broken on a Samsung P30
Date: Thu, 04 Nov 2004 22:50:10 +0100
Message-ID: <1099605010.5191.20.camel@mhcln03>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SJQSNVBqi5iXWzgLFQTN"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-SJQSNVBqi5iXWzgLFQTN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all,

I've been trying for some time now to get S3 working on my laptop.
It suspends just fine with 

echo 3 > /proc/acpi/sleep
and
echo -n mem > /sys/power/state

but it never wakes up. The screen stays dark and the keyboard
(CAPSLOCK/NUMLOCK) doesn't work. Trying to blindly execute programs in
the console also fails.
The only thing which seems to wake up is the DVD drive, which spins up
after a resume, but that's about it.

Since the display stays dark, (no back-light, totally dead) I've
connected and configured a serial console. Sadly, it appears that the
serial port doesn't wake up either....

On a resume i get 2 to 10 chars of random garbage on the serial console,
nothing else (it works perfectly when the latop is running)

I've tried "enabling" the devices in /proc/acpi/wakeup, and / or
suspending with the kernel option "init=/bin/bash", but that didn't help
either.

I've run the tests with Linux 2.6.10-rc1-mm2 because it's likely to
include the latest and greatest ACPI bk patches.

My kernel.config and other (hopefully) useful outputs are attached.

I'd really appreciate a helping hand here as S3 is a _really_ useful
feature for a laptop :)

Thanks in advance
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-SJQSNVBqi5iXWzgLFQTN
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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
/w9qikR3jZoAAK==


--=-SJQSNVBqi5iXWzgLFQTN
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.10-rc1-mm2 (root@mhcln03) (gcc-Version 3.3.5 (Debian 1:3.3.5-2)) #4 Thu Nov 4 21:12:35 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000dc000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
 BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffff000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6630
ACPI: RSDT (v001 PTLTD  CooperSp 0x06040000  LTP 0x00000000) @ 0x1ff76971
ACPI: FADT (v001 INTEL  ODEM     0x06040000 PTL  0x00000050) @ 0x1ff7bed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: SSDT (v001  INTEL  EISTRef 0x00000001 INTL 0x02002015) @ 0x1ff769a1
ACPI: DSDT (v001 INTEL  ODEM     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.10-rc1-mm2 ro root=302 console=ttyS0,9600 console=tty0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1495.686 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514324k/523712k available (2473k kernel code, 8828k reserved, 1015k data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2965.50 BogoMIPS (lpj=1482752)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
   tbget-0294: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9d3, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041015
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: Power Resource [CFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by pnpacpi
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:03' and the driver 'system'
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (off)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (55 C)
Asus Laptop ACPI Extras version 0.29
  Samsung P30 detected, supported
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
pnp: the driver 'i8042 kdb' has been registered
pnp: match found with the PnP device '00:08' and the driver 'i8042 kdb'
PNP: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:09' and the driver 'i8042 aux'
PNP: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.9.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:06' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N060ATMR04-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: DV-W22E, ATAPI CD/DVD-ROM drive
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
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 1419kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 12.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
swsusp: Resume From Partition: /dev/hda3
<3>swsusp: Invalid partition type.
pmdisk: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
LANC USB0 USB1 USB2 USB7 MODM 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
Adding 979956k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49450 usecs
intel8x0: clocking to 48000
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL8139 at 0xe0926800, 00:00:f0:7e:bc:08, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport_pc: Ignoring new-style parameters in presence of obsolete ones
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:05' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
irda_init()
NET: Registered protocol family 23
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
usb 1-1: new low speed USB device using uhci_hcd and address 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 5, pci mem 0xd0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb 1-1: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hw_random: RNG not detected
usb 1-1: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:1d.0-1
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 5 (level, low) -> IRQ 5
Yenta: CardBus bridge found at 0000:02:01.0 [144d:c00c]
Yenta: ISA IRQ mask 0x0418, PCI irq 5
Socket status: 30000006
PCI: Enabling device 0000:02:01.1 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.1 [144d:c00c]
Yenta: ISA IRQ mask 0x0418, PCI irq 11
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[d0201000-d02017ff]  Max Packet=[2048]
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.59
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
ipw2100: eth1: Firmware 'ipw2100-1.3.fw' not available or load failed.
ipw2100: eth1: ipw2100_get_firmware failed: -2
ipw2100: eth1: Failed to power on the adapter.
ipw2100: eth1: Failed to start the firmware.
ipw2100: probe of 0000:02:02.0 failed with error -5
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000f0414010ba78]
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
nfs warning: mount version older than kernel
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
SCSI subsystem initialized
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x807
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
Access to /proc/cpufreq is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01

--=-SJQSNVBqi5iXWzgLFQTN
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 21)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV250 5c63 [Radeon Mobility 9200 M9+] (rev 01)
0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
0000:02:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
0000:02:01.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 04)
0000:02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)

--=-SJQSNVBqi5iXWzgLFQTN
Content-Disposition: attachment; filename=proc_interrupts.txt
Content-Type: text/plain; name=proc_interrupts.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

           CPU0       
  0:     153378          XT-PIC  timer
  1:        203          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:         13          XT-PIC  serial
  5:        573          XT-PIC  Intel 82801DB-ICH4, uhci_hcd, ehci_hcd, Intel 82801DB-ICH4 Modem, yenta, eth0
  7:          1          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:        454          XT-PIC  acpi
 11:       3582          XT-PIC  uhci_hcd, uhci_hcd, yenta, ohci1394
 12:        617          XT-PIC  i8042
 14:       7458          XT-PIC  ide0
 15:         20          XT-PIC  ide1
NMI:          0 
ERR:          0

--=-SJQSNVBqi5iXWzgLFQTN--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
