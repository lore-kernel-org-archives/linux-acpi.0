From: Athul Acharya <aacharya-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Various ACPI Problems on COMPAL CL56
Date: Mon, 21 Jun 2004 20:06:05 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5a67a16f04062118063910b19c@mail.gmail.com>
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

Hello, 

I've been having various ACPI problems on my machine, a Compal CL56,
and after having spent the better part of two months trying to fix it
and making little progress, I was hoping someone here might be able to
help me, or at least point me in the right direction.

First and foremost, no kind of suspend works. S4 appears to work, but
on attempting to boot using the resume= partition, the kernel reboots,
causing the machine to go into a boot/reboot cycle.  The closest I
could get S3 to working, I had sound and usb modules unloaded, was
using the ATI fglrx driver, and on pressing a key, the machine
appeared to wake up, the backlight turned on, but there was no video
output, and about 10 second later the machine shut down.  I understand
that this sort of problem with S3/S4 is very common, so any sort of
fix would be a welcome surprise.

Secondly, my /proc/acpi/fan and /proc/acpi/thermal_zone/ directories
are empty.  I was originally given to believe that the DSDT was the
source of the problem; however, the Intel compiler compiled my
disassembled DSDT with no errors and no warnings, and no amount of
fiddling with  the acpi_os_name boot parameter has caused entries in
these directories to be created. So I am similarly at a loss here.

At the bottom of this email you will find, as requested on your
webpage, output from dmesg -s40000, dmidecode, acpidmp, lspci -vv, and
/proc/interrupts.

Thanks,

Athul

-- dmesg --
v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @ 0x1fffa7f0
ACPI: FADT (v001 ACER   DCL56    0x00000200 _CSI 0x00010101) @ 0x1ffffb00
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @ 0x1ffffb90
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010101) @ 0x1ffffbc0
ACPI: SSDT (v001 INSYDE   GV3Ref 0x00002000 INTL 0x20021002) @ 0x1fffa830
ACPI: DSDT (v001 ACER     0860   0x00000006 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Kernel command line: root=/dev/hda3 vga=795 acpi_os_name="Gentoo Linux 2.6"
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1794.311 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514940k/524224k available (2234k kernel code, 8520k reserved,
994k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3555.32 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: afe9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: afe9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU:     After all inits, caps: afe9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1793.0963 MHz.
..... host bus clock speed is 99.0664 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xe97a4, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 10) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10) *11
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10) *11
ACPI: Embedded Controller [EC0] (gpe 28)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
radeonfb: Invalid ROM signature 303 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=390.00 Mhz, System=200.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: AUO                     
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon NP  SDR SGRAM 128 MB
Simple Boot Flag at 0x37 set to 0x80
NTFS driver 2.1.14 [Flags: R/O].
udf: registering filesystem
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
Console: switching to colour frame buffer device 175x65
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xb0000000
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xa000, 00:02:3f:14:c1:b3, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: HTS548080M9AT00, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: COMPAL TSB24H1 Slim DVD-ROM/CD-RW Drive, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2
ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e184a000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8
period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
usb usb1: Manufacturer: Linux 2.6.7-rc3-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
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
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001200
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Intel Corp. 82801DB (ICH4) USB UHCI #1
usb usb2: Manufacturer: Linux 2.6.7-rc3-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 00001600
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: Intel Corp. 82801DB (ICH4) USB UHCI #2
usb usb3: Manufacturer: Linux 2.6.7-rc3-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001403 POWER sig=k  CSC CONNECT
hub 1-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001700
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: Intel Corp. 82801DB (ICH4) USB UHCI #3
usb usb4: Manufacturer: Linux 2.6.7-rc3-mm2 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: hotplug
hub 1-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 3 low speed --> companion
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 37
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003002 POWER OWNER sig=se0  CSC
uhci_hcd 0000:00:1d.1: port 1 portsc 01a3
hub 3-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun May 30
10:49:40 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
usb 3-1: new low speed USB device using address 2
usb 3-1: skipped 1 descriptor after interface
usb 3-1: new device strings: Mfr=1, Product=3, SerialNumber=0
usb 3-1: default language 0x0409
usb 3-1: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
usb 3-1: Manufacturer: Microsoft
usb 3-1: hotplug
usb 3-1: adding 3-1:1.0 (config #1, interface 0)
usb 3-1:1.0: hotplug
usbhid 3-1:1.0: usb_probe_interface
usbhid 3-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with
IntelliEye(TM)] on usb-0000:00:1d.1-1
intel8x0_measure_ac97_clock: measured 49530 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xf0000400, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S4bios S5)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
uhci_hcd 0000:00:1d.0: suspend_hc
uhci_hcd 0000:00:1d.2: suspend_hc
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 755012k swap on /dev/hda1.  Priority:-1 extents:1
NTFS volume version 3.1.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies,
Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 431 MBytes.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
[fglrx] module loaded - fglrx 3.9.0 [May 11 2004] on minor 0
[fglrx:firegl_unlock] *ERROR* Process 9663 using kernel context 0
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.

-- dmidecode --
# dmidecode 2.3
SMBIOS 2.3 present.
33 structures occupying 1466 bytes.
Table at 0x000EB160.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: COMPAL
		Version: Version 1.00.00
		Release Date: 03/12/2004
		Address: 0xEB000
		Runtime Size: 84 kB
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			Selectable boot is supported
			Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
			USB legacy is supported
			I2O boot is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: ................
		Product Name: ................................
		Version: Null
		Serial Number: ......................        
		UUID: 91AAEB65-41DA-11D8-910F-00023F14C1B3
		Wake-up Type: Unknown
Handle 0x0003
	DMI type 3, 24 bytes.
	Chassis Information
		Manufacturer: COMPAL                     
		Type: Portable
		Lock: Not Present
		Version: N/A             
		Serial Number: None           
		Asset Tag: ................                
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00000000
Heigth: Unspecified
Number Of Power Cords: 1
		Contained Elements: 0
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: mPGA478
		Type: Central Processor
		Family: Pentium
		Manufacturer: 123456789ABC
		ID: 00 00 00 00 00 00 00 00
		Signature: Type 0, Family 0, Model 0, Stepping 0
		Flags: None
		Version: Banias
		Voltage: 2.9 V
		External Clock: 133 MHz
		Max Speed: 1800 MHz
		Current Speed: 1800 MHz
		Status: Populated, Enabled
		Upgrade: None
		L1 Cache Handle: 0x0007
		L2 Cache Handle: 0x0008
		L3 Cache Handle: Not Provided
		Serial Number: Processor Serial Number
		Asset Tag: Asset_TAG
		Part Number: Part Number
Handle 0x0005
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DRAM SLOT 0
		Bank Connections: 0 1
		Current Speed: 60 ns
		Type: EDO DIMM
		Installed Size: 512 MB (Double-bank Connection)
		Enabled Size: 512 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DRAM SLOT 1
		Bank Connections: 2 3
		Current Speed: 60 ns
		Type: EDO DIMM
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0007
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
		Installed SRAM Type: Burst Pipeline Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 2048 KB
		Maximum Size: 2048 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
		Installed SRAM Type: Burst Pipeline Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0009
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:  
		Internal Connector Type: None
		External Reference Designator: Keyboard
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:  
		Internal Connector Type: None
		External Reference Designator: Mouse
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:            
		Internal Connector Type: None
		External Reference Designator: Line Out
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: VGA Conn.
		Internal Connector Type: None
		External Reference Designator: J7
		External Connector Type: Other
		Port Type: Serial Port 16550A Compatible
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:  
		Internal Connector Type: None
		External Reference Designator: USB 1
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:  
		Internal Connector Type: None
		External Reference Designator: USB 2
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:  
		Internal Connector Type: None
		External Reference Designator: USB 3
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: IDE1
		Internal Connector Type: On Board IDE
		External Reference Designator:    
		External Connector Type: None
		Port Type: Other
Handle 0x0011
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 4
		Characteristics: Unknown
Handle 0x0012
	DMI type 10, 18 bytes.
	On Board Device Information
		Type: Ethernet
		Status: Enabled
		Description: RTL8100L
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: 16550 UART
	On Board Device Information
		Type: Other
		Status: Disabled
		Description: IrDA Port
	On Board Device Information
		Type: Sound
		Status: Enabled
		Description: Audio Controller
	On Board Device Information
		Type: Other
		Status: Disabled
		Description: CardBus Bridge
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: IDE Controller
	On Board Device Information
		Type: Video
		Status: Disabled
		Description: VGA
Handle 0x0013
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: Insyde Software SM-BIOS For Whitney
Handle 0x0014
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			en|US|iso8859-1
		Currently Installed Language: en|US|iso8859-1
Handle 0x0015
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 1 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x0016
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: Video Memory
		Error Correction Type: None
		Maximum Capacity: 2 MB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x0017
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0015
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 512 MB
		Form Factor: DIMM
		Set: Unknown
		Locator: DIMM0
		Bank Locator: Banks 0/1
		Type: DRAM
		Type Detail: EDO
		Speed: 1 MHz (1000.0 ns)
		Manufacturer: NEC
		Serial Number: 12345678
		Asset Tag:         
		Part Number:         
Handle 0x0018
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0015
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: No Module Installed
		Form Factor: DIMM
		Set: Unknown
		Locator: DIMM1
		Bank Locator: Banks 2/3
		Type: DRAM
		Type Detail: EDO
		Speed: 1 MHz (1000.0 ns)
		Manufacturer: NEC
		Serial Number: 12345678
		Asset Tag:         
		Part Number:         
Handle 0x0019
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0016
		Error Information Handle: Not Provided
		Total Width: 8 bits
		Data Width: 8 bits
		Size: No Module Installed
		Form Factor: Unknown
		Set: None
		Locator: FROM
		Bank Locator:     
		Type: Flash
		Type Detail: Non-Volatile
		Speed: Unknown
		Manufacturer: SST
		Serial Number: 12345678
		Asset Tag:         
		Part Number:         
Handle 0x001A
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0015
		Partition Width: 0
Handle 0x001B
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000007FFFF
		Range Size: 512 kB
		Physical Array Handle: 0x0016
		Partition Width: 0
Handle 0x001C
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x0017
		Memory Array Mapped Address Handle: 0x001A
		Partition Row Position: 1
Handle 0x001D
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x0018
		Memory Array Mapped Address Handle: 0x001A
		Partition Row Position: 1
Handle 0x001E
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000007FFFF
		Range Size: 512 kB
		Physical Device Handle: 0x0019
		Memory Array Mapped Address Handle: 0x001B
		Partition Row Position: 1
Handle 0x001F
	DMI type 22, 26 bytes.
	Portable Battery
		Location: Battery Information
		Manufacturer:         
		Manufacture Date:         
		Serial Number:     
		Name:       
		Design Capacity: 0 mWh
		Design Voltage: 64764 mV
		SBDS Version:         
		Maximum Error: 6%
		SBDS Chemistry: Not Specified
		OEM-specific Information: 0x00000000
Handle 0x0020
	DMI type 127, 4 bytes.
	End Of Table
Wrong DMI structures count: 33 announced, only 32 decoded.

-- acpidmp --
RSDP "OID_00" @ 0x000e6010
  0000: 52 53 44 20 50 54 52 20 91 4f 49 44 5f 30 30 00  RSD PTR .OID_00.
  0010: f0 a7 ff 1f                                      ....

RSDT @ 0x1fffa7f0
  0000: 52 53 44 54 34 00 00 00 01 c3 49 4e 53 59 44 45  RSDT4.....INSYDE
  0010: 52 53 44 54 5f 30 30 30 01 00 00 00 5f 43 53 49  RSDT_000...._CSI
  0020: 01 01 01 00 00 fb ff 1f 90 fb ff 1f c0 fb ff 1f  ................
  0030: 30 a8 ff 1f                                      0...

FACP @ 0x1ffffb00
  0000: 46 41 43 50 74 00 00 00 01 18 41 43 45 52 20 20  FACPt.....ACER  
  0010: 44 43 4c 35 36 20 20 20 00 02 00 00 5f 43 53 49  DCL56   ...._CSI
  0020: 01 01 01 00 c0 ff ff 1f 70 ac ff 1f 00 00 09 00  ........p.......
  0030: b2 00 00 00 e0 e1 e2 80 00 10 00 00 00 00 00 00  ................
  0040: 04 10 00 00 00 00 00 00 20 10 00 00 08 10 00 00  ........ .......
  0050: 28 10 00 00 00 00 00 00 04 02 01 04 08 00 00 85  (...............
  0060: 01 00 55 00 00 00 00 00 01 03 0d 00 00 00 00 00  ..U.............
  0070: 85 00 00 00                                      ....

DSDT @ 0x1fffac70
  0000: 44 53 44 54 8a 4e 00 00 01 40 41 43 45 52 20 20  DSDT.N...-IRPtH1dmhZM@public.gmane.org  
  0010: 30 38 36 30 20 20 00 00 06 00 00 00 4d 53 46 54  0860  ......MSFT
  0020: 0e 00 00 01 5b 80 4d 4e 56 53 00 0c 00 fc ff 1f  ....[.MNVS......
  0030: 0a 60 5b 81 42 05 4d 4e 56 53 10 4f 53 59 53 10  .`[.B.MNVS.OSYS.
  0040: 43 4d 41 50 08 43 4d 42 50 08 46 44 43 50 08 4c  CMAP.CMBP.FDCP.L
  0050: 50 54 50 08 42 54 45 4e 08 49 47 44 53 08 4c 43  PTP.BTEN.IGDS.LC
  0060: 44 41 10 54 4c 53 54 08 43 41 44 4c 10 50 41 44  DA.TLST.CADL.PAD
  0070: 4c 10 43 53 54 45 10 4e 53 54 45 10 53 53 54 45  L.CSTE.NSTE.SSTE
  0080: 10 42 52 41 44 08 10 4d 09 5f 50 52 5f 5b 83 45  .BRAD..M._PR_[.E
  0090: 09 43 50 55 30 00 10 10 00 00 06 14 48 08 5f 43  .CPU0.......H._C
  00a0: 53 54 00 a4 12 4f 07 05 0a 04 12 1e 04 11 14 0a  ST...O..........
  00b0: 11 82 0c 00 7f 08 00 00 00 00 00 00 00 00 00 00  ................
  00c0: 79 00 0a 01 0a 01 0b e8 03 12 1e 04 11 14 0a 11  y...............
  00d0: 82 0c 00 01 08 00 00 14 10 00 00 00 00 00 00 79  ...............y
  00e0: 00 0a 02 0a 01 0b f4 01 12 1d 04 11 14 0a 11 82  ................
  00f0: 0c 00 01 08 00 00 15 10 00 00 00 00 00 00 79 00  ..............y.
  0100: 0a 03 0a 55 0a fa 12 1d 04 11 14 0a 11 82 0c 00  ...U............
  0110: 01 08 00 00 16 10 00 00 00 00 00 00 79 00 0a 03  ............y...
  0120: 0a b9 0a 64 08 5c 5f 53 30 5f 12 06 02 0a 00 0a  ...d.\_S0_......
  0130: 00 08 5c 5f 53 31 5f 12 06 02 0a 02 0a 02 08 5c  ..\_S1_........\
  0140: 5f 53 33 5f 12 06 02 0a 05 0a 05 08 5c 5f 53 34  _S3_........\_S4
  0150: 5f 12 06 02 0a 06 0a 06 08 5c 5f 53 35 5f 12 06  _........\_S5_..
  0160: 02 0a 07 0a 07 5b 80 50 4f 52 54 01 0a 80 0a 01  .....[.PORT.....
  0170: 5b 81 0b 50 4f 52 54 01 50 38 30 48 08 08 45 43  [..PORT.P80H..EC
  0180: 44 59 0a 03 08 4f 53 54 50 0a 00 08 5c 47 50 49  DY...OSTP...\GPI
  0190: 43 0a 00 08 5c 41 43 50 53 0a 00 14 47 05 5f 50  C...\ACPS...G._P
  01a0: 54 53 01 a0 11 93 68 0a 03 5c 2e 5f 53 42 5f 47  TS....h..\._SB_G
  01b0: 53 4d 49 0a 09 a0 3d 93 68 0a 04 70 0a 07 5c 2f  SMI...=.h..p..\/
  01c0: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 55 48 43  ._SB_PCI0LPC0UHC
  01d0: 49 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  Ip..\/._SB_PCI0L
  01e0: 50 43 30 45 48 43 49 5c 2e 5f 53 42 5f 47 53 4d  PC0EHCI\._SB_GSM
  01f0: 49 0a 02 14 42 07 5f 57 41 4b 01 a0 1b 93 68 0a  I...B._WAK....h.
  0200: 03 a0 15 93 4f 53 54 50 0a 01 86 5c 2e 5f 53 42  ....OSTP...\._SB
  0210: 5f 50 57 52 42 0a 02 a0 4b 04 93 68 0a 04 86 5c  _PWRB...K..h...\
  0220: 2e 5f 53 42 5f 50 57 52 42 0a 02 70 0a 00 5c 2f  ._SB_PWRB..p..\/
  0230: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 55 48 43  ._SB_PCI0LPC0UHC
  0240: 49 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  Ip..\/._SB_PCI0L
  0250: 50 43 30 45 48 43 49 5c 2e 5f 53 42 5f 47 53 4d  PC0EHCI\._SB_GSM
  0260: 49 0a 05 a4 0a 00 10 40 0f 5f 47 50 45 14 18 5f  I......-TIJN+PXVmA8@public.gmane.org
  0270: 4c 30 33 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30  L03..\/._SB_PCI0
  0280: 55 53 42 31 0a 02 14 18 5f 4c 30 34 00 86 5c 2f  USB1...._L04..\/
  0290: 03 5f 53 42 5f 50 43 49 30 55 53 42 32 0a 02 14  ._SB_PCI0USB2...
  02a0: 18 5f 4c 30 35 00 86 5c 2f 03 5f 53 42 5f 50 43  ._L05..\/._SB_PC
  02b0: 49 30 4d 4f 44 4d 0a 02 14 18 5f 4c 30 38 00 86  I0MODM...._L08..
  02c0: 5c 2f 03 5f 53 42 5f 50 43 49 30 48 55 42 5f 0a  \/._SB_PCI0HUB_.
  02d0: 02 14 18 5f 4c 30 42 00 86 5c 2f 03 5f 53 42 5f  ..._L0B..\/._SB_
  02e0: 50 43 49 30 48 55 42 5f 0a 02 14 18 5f 4c 30 43  PCI0HUB_...._L0C
  02f0: 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53 42  ..\/._SB_PCI0USB
  0300: 33 0a 02 14 18 5f 4c 30 44 00 86 5c 2f 03 5f 53  3...._L0D..\/._S
  0310: 42 5f 50 43 49 30 45 55 53 42 0a 02 14 3a 5f 4c  B_PCI0EUSB...:_L
  0320: 31 44 00 80 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  1D..\/._SB_PCI0L
  0330: 50 43 30 4c 50 4f 4c 5c 2f 04 5f 53 42 5f 50 43  PC0LPOL\/._SB_PC
  0340: 49 30 4c 50 43 30 4c 50 4f 4c 86 5c 2e 5f 53 42  I0LPC0LPOL.\._SB
  0350: 5f 4c 49 44 5f 0a 80 10 82 b3 04 5f 53 42 5f 5b  _LID_......_SB_[
  0360: 82 2a 4c 49 44 5f 08 5f 48 49 44 0c 41 d0 0c 0d  .*LID_._HID.A...
  0370: 14 1a 5f 4c 49 44 00 a4 5c 2f 04 5f 53 42 5f 50  .._LID..\/._SB_P
  0380: 43 49 30 4c 50 43 30 4c 50 4f 4c 5b 82 0f 50 57  CI0LPC0LPOL[..PW
  0390: 52 42 08 5f 48 49 44 0c 41 d0 0c 0c 5b 80 53 4d  RB._HID.A...[.SM
  03a0: 49 4f 01 0a b2 0a 02 5b 81 10 53 4d 49 4f 01 41  IO.....[..SMIO.A
  03b0: 50 4d 43 08 41 50 4d 44 08 14 2b 47 53 4d 49 01  PMC.APMD..+GSMI.
  03c0: 70 68 41 50 4d 44 70 0a e3 41 50 4d 43 5b 21 0a  phAPMDp..APMC[!.
  03d0: ff 5b 21 0a ff 5b 21 0a ff 5b 21 0a ff 5b 21 0a  .[!..[!..[!..[!.
  03e0: ff 5b 21 0a ff 5b 82 83 aa 04 50 43 49 30 08 5f  .[!..[....PCI0._
  03f0: 48 49 44 0c 41 d0 0a 03 08 5f 42 42 4e 0a 00 08  HID.A...._BBN...
  0400: 5f 41 44 52 0a 00 14 4e 06 5f 49 4e 49 00 a0 2e  _ADR...N._INI...
  0410: 5b 12 5c 5f 4f 53 49 60 a0 1b 5c 5f 4f 53 49 0d  [.\_OSI`..\_OSI.
  0420: 57 69 6e 64 6f 77 73 20 32 30 30 31 00 70 0a 03  Windows 2001.p..
  0430: 4f 53 54 50 a1 08 70 0a 04 4f 53 54 50 a1 2e a0  OSTP..p..OSTP...
  0440: 10 93 87 5f 4f 53 5f 0a 14 70 0a 01 4f 53 54 50  ..._OS_..p..OSTP
  0450: a1 1b a0 10 93 87 5f 4f 53 5f 0a 27 70 0a 02 4f  ......_OS_.'p..O
  0460: 53 54 50 a1 08 70 0a 00 4f 53 54 50 70 4f 53 54  STP..p..OSTPpOST
  0470: 50 4f 53 59 53 14 09 5f 53 31 44 00 a4 0a 02 14  POSYS.._S1D.....
  0480: 09 5f 53 33 44 00 a4 0a 02 14 09 5f 53 34 44 00  ._S3D......_S4D.
  0490: a4 0a 02 5b 80 48 42 55 53 02 0a 40 0a c0 5b 81  ...[.HBUS..-rVxdn2TrCWA@public.gmane.org[.
  04a0: 43 08 48 42 55 53 03 00 40 10 44 52 42 30 08 44  C.HBUS..-HvhAD0xw7hk@public.gmane.org
  04b0: 52 42 31 08 44 52 42 32 08 44 52 42 33 08 00 40  RB1.DRB2.DRB3..@
  04c0: 16 00 04 50 4d 30 48 02 00 02 50 4d 31 4c 02 00  ...PM0H...PM1L..
  04d0: 02 50 4d 31 48 02 00 02 50 4d 32 4c 02 00 02 50  .PM1H...PM2L...P
  04e0: 4d 32 48 02 00 02 50 4d 33 4c 02 00 02 50 4d 33  M2H...PM3L...PM3
  04f0: 48 02 00 02 50 4d 34 4c 02 00 02 50 4d 34 48 02  H...PM4L...PM4H.
  0500: 00 02 50 4d 35 4c 02 00 02 50 4d 35 48 02 00 02  ..PM5L...PM5H...
  0510: 50 4d 36 4c 02 00 02 50 4d 36 48 02 00 02 46 44  PM6L...PM6H...FD
  0520: 48 43 08 08 42 55 46 30 11 46 20 0b 01 02 88 0e  HC..BUF0.F .....
  0530: 00 02 0c 00 00 00 00 00 ff 00 00 00 00 01 00 87  ................
  0540: 18 00 01 0c 03 00 00 00 00 00 00 00 00 f7 0c 00  ................
  0550: 00 00 00 00 00 f8 0c 00 00 00 47 01 f8 0c f8 0c  ..........G.....
  0560: 01 08 87 18 00 01 0c 03 00 00 00 00 00 0d 00 00  ................
  0570: ff ff 00 00 00 00 00 00 00 f3 00 00 00 87 18 00  ................
  0580: 00 0c 03 00 00 00 00 00 00 0a 00 ff ff 0b 00 00  ................
  0590: 00 00 00 00 00 02 00 00 87 18 00 00 0c 03 00 00  ................
  05a0: 00 00 00 00 0c 00 ff 3f 0c 00 00 00 00 00 00 40  .......?.......@
  05b0: 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 40 0c  ..............-4b8TPpkIZ3Q@public.gmane.org
  05c0: 00 ff 7f 0c 00 00 00 00 00 00 40 00 00 00 87 18  ..........-5mgE8MpiMJg@public.gmane.org
  05d0: 00 00 0c 03 00 00 00 00 00 80 0c 00 ff bf 0c 00  ................
  05e0: 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00  .....-BlbsxGdv4A6tXF2fZOsJYA@public.gmane.org
  05f0: 00 00 00 00 c0 0c 00 ff ff 0c 00 00 00 00 00 00  ................
  0600: 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 00  @...............
  0610: 0d 00 ff 3f 0d 00 00 00 00 00 00 40 00 00 00 87  ...?.......-9D9NNryygCw@public.gmane.org
  0620: 18 00 00 0c 03 00 00 00 00 00 40 0d 00 ff 7f 0d  ..........-5mgE8MpiMJg@public.gmane.org
  0630: 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03  ......-BlbsxGdv4A7hvxM+mQhndA@public.gmane.org
  0640: 00 00 00 00 00 80 0d 00 ff bf 0d 00 00 00 00 00  ................
  0650: 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00  .-BlbsxGdv4A4TZT1p1SMppg@public.gmane.org
  0660: c0 0d 00 ff ff 0d 00 00 00 00 00 00 40 00 00 00  ............-47IYjYMXMt4@public.gmane.org
  0670: 87 18 00 00 0c 03 00 00 00 00 00 00 0e 00 ff 3f  ...............?
  0680: 0e 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c  .......-BlbsxGdv4A4@public.gmane.org
  0690: 03 00 00 00 00 00 40 0e 00 ff 7f 0e 00 00 00 00  ......-BlbsxGdv4A7hvxM+mQhndA@public.gmane.org
  06a0: 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00  ..-BlbsxGdv4A7maATwymIwmA@public.gmane.org
  06b0: 00 80 0e 00 ff bf 0e 00 00 00 00 00 00 40 00 00  .............-rVxdn2TrCWA@public.gmane.org
  06c0: 00 87 18 00 00 0c 03 00 00 00 00 00 c0 0e 00 ff  ................
  06d0: ff 0e 00 00 00 00 00 00 40 00 00 00 87 18 00 00  ........-3wQm9ZMZ9co@public.gmane.org
  06e0: 0c 03 00 00 00 00 00 00 0f 00 ff ff 0f 00 00 00  ................
  06f0: 00 00 00 00 01 00 00 87 18 00 00 0c 03 00 00 00  ................
  0700: 00 00 00 00 00 ff ff bf fe 00 00 00 00 00 00 00  ................
  0710: 00 00 87 18 00 00 0c 03 00 00 00 00 00 00 00 00  ................
  0720: 00 00 00 00 00 00 00 00 00 00 00 00 00 79 00 14  .............y..
  0730: 45 39 5f 43 52 53 08 a0 16 50 4d 31 4c 8a 42 55  E9_CRS...PM1L.BU
  0740: 46 30 0a 80 43 30 4c 4e 70 00 43 30 4c 4e a0 1a  F0..C0LNp.C0LN..
  0750: 93 50 4d 31 4c 0a 01 8d 42 55 46 30 0b 78 03 43  .PM1L...BUF0.x.C
  0760: 30 52 57 70 00 43 30 52 57 a0 16 50 4d 31 48 8a  0RWp.C0RW..PM1H.
  0770: 42 55 46 30 0a 9b 43 34 4c 4e 70 00 43 34 4c 4e  BUF0..C4LNp.C4LN
  0780: a0 1a 93 50 4d 31 48 0a 01 8d 42 55 46 30 0b 50  ...PM1H...BUF0.P
  0790: 04 43 34 52 57 70 00 43 34 52 57 a0 16 50 4d 32  .C4RWp.C4RW..PM2
  07a0: 4c 8a 42 55 46 30 0a b6 43 38 4c 4e 70 00 43 38  L.BUF0..C8LNp.C8
  07b0: 4c 4e a0 1a 93 50 4d 32 4c 0a 01 8d 42 55 46 30  LN...PM2L...BUF0
  07c0: 0b 28 05 43 38 52 57 70 00 43 38 52 57 a0 16 50  .(.C8RWp.C8RW..P
  07d0: 4d 32 48 8a 42 55 46 30 0a d1 43 43 4c 4e 70 00  M2H.BUF0..CCLNp.
  07e0: 43 43 4c 4e a0 1a 93 50 4d 32 48 0a 01 8d 42 55  CCLN...PM2H...BU
  07f0: 46 30 0b 00 06 43 43 52 57 70 00 43 43 52 57 a0  F0...CCRWp.CCRW.
  0800: 16 50 4d 33 4c 8a 42 55 46 30 0a ec 44 30 4c 4e  .PM3L.BUF0..D0LN
  0810: 70 00 44 30 4c 4e a0 1a 93 50 4d 33 4c 0a 01 8d  p.D0LN...PM3L...
  0820: 42 55 46 30 0b d8 06 44 30 52 57 70 00 44 30 52  BUF0...D0RWp.D0R
  0830: 57 a0 17 50 4d 33 48 8a 42 55 46 30 0b 07 01 44  W..PM3H.BUF0...D
  0840: 34 4c 4e 70 00 44 34 4c 4e a0 1a 93 50 4d 33 48  4LNp.D4LN...PM3H
  0850: 0a 01 8d 42 55 46 30 0b b0 07 44 34 52 57 70 00  ...BUF0...D4RWp.
  0860: 44 34 52 57 a0 17 50 4d 34 4c 8a 42 55 46 30 0b  D4RW..PM4L.BUF0.
  0870: 22 01 44 38 4c 4e 70 00 44 38 4c 4e a0 1a 93 50  ".D8LNp.D8LN...P
  0880: 4d 34 4c 0a 01 8d 42 55 46 30 0b 88 08 44 38 52  M4L...BUF0...D8R
  0890: 57 70 00 44 38 52 57 a0 17 50 4d 34 48 8a 42 55  Wp.D8RW..PM4H.BU
  08a0: 46 30 0b 3d 01 44 43 4c 4e 70 00 44 43 4c 4e a0  F0.=.DCLNp.DCLN.
  08b0: 1a 93 50 4d 34 48 0a 01 8d 42 55 46 30 0b 60 09  ..PM4H...BUF0.`.
  08c0: 44 43 52 57 70 00 44 43 52 57 a0 17 50 4d 35 4c  DCRWp.DCRW..PM5L
  08d0: 8a 42 55 46 30 0b 58 01 45 30 4c 4e 70 00 45 30  .BUF0.X.E0LNp.E0
  08e0: 4c 4e a0 1a 93 50 4d 35 4c 0a 01 8d 42 55 46 30  LN...PM5L...BUF0
  08f0: 0b 38 0a 45 30 52 57 70 00 45 30 52 57 a0 17 50  .8.E0RWp.E0RW..P
  0900: 4d 35 48 8a 42 55 46 30 0b 73 01 45 34 4c 4e 70  M5H.BUF0.s.E4LNp
  0910: 00 45 34 4c 4e a0 1a 93 50 4d 35 48 0a 01 8d 42  .E4LN...PM5H...B
  0920: 55 46 30 0b 10 0b 45 34 52 57 70 00 45 34 52 57  UF0...E4RWp.E4RW
  0930: a0 17 50 4d 36 4c 8a 42 55 46 30 0b 8e 01 45 38  ..PM6L.BUF0...E8
  0940: 4c 4e 70 00 45 38 4c 4e a0 1a 93 50 4d 36 4c 0a  LNp.E8LN...PM6L.
  0950: 01 8d 42 55 46 30 0b e8 0b 45 38 52 57 70 00 45  ..BUF0...E8RWp.E
  0960: 38 52 57 a0 17 50 4d 36 48 8a 42 55 46 30 0b a9  8RW..PM6H.BUF0..
  0970: 01 45 43 4c 4e 70 00 45 43 4c 4e a0 1a 93 50 4d  .ECLNp.ECLN...PM
  0980: 36 48 0a 01 8d 42 55 46 30 0b c0 0c 45 43 52 57  6H...BUF0...ECRW
  0990: 70 00 45 43 52 57 a0 17 50 4d 30 48 8a 42 55 46  p.ECRW..PM0H.BUF
  09a0: 30 0b c4 01 46 30 4c 4e 70 00 46 30 4c 4e a0 1a  0...F0LNp.F0LN..
  09b0: 93 50 4d 30 48 0a 01 8d 42 55 46 30 0b 98 0d 46  .PM0H...BUF0...F
  09c0: 30 52 57 70 00 46 30 52 57 8a 42 55 46 30 0b d3  0RWp.F0RW.BUF0..
  09d0: 01 4d 31 4d 4e 8a 42 55 46 30 0b d7 01 4d 31 4d  .M1MN.BUF0...M1M
  09e0: 58 8a 42 55 46 30 0b df 01 4d 31 4c 4e 77 0c 00  X.BUF0...M1LNw..
  09f0: 00 00 02 44 52 42 33 4d 31 4d 4e 72 74 4d 31 4d  ...DRB3M1MNrtM1M
  0a00: 58 4d 31 4d 4e 00 0a 01 4d 31 4c 4e 7a 7b 5c 2f  XM1MN...M1LNz{\/
  0a10: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 48 50 54  ._SB_PCI0LPC0HPT
  0a20: 45 0c 00 80 03 00 00 0a 0f 60 a0 45 09 7b 60 0a  E........`.E.{`.
  0a30: 04 00 8a 42 55 46 30 0b ee 01 4d 32 4d 4e 8a 42  ...BUF0...M2MN.B
  0a40: 55 46 30 0b f2 01 4d 32 4d 58 8a 42 55 46 30 0b  UF0...M2MX.BUF0.
  0a50: fa 01 4d 32 4c 4e 70 0c 00 00 d0 fe 4d 32 4d 4e  ..M2LNp.....M2MN
  0a60: 70 0c ff 03 d0 fe 4d 32 4d 58 70 0b 00 04 4d 32  p.....M2MXp...M2
  0a70: 4c 4e a0 19 93 60 0a 05 70 0c 00 10 d0 fe 4d 32  LN...`..p.....M2
  0a80: 4d 4e 70 0c ff 13 d0 fe 4d 32 4d 58 a0 19 93 60  MNp.....M2MX...`
  0a90: 0a 06 70 0c 00 20 d0 fe 4d 32 4d 4e 70 0c ff 23  ..p.. ..M2MNp..#
  0aa0: d0 fe 4d 32 4d 58 a0 19 93 60 0a 07 70 0c 00 30  ..M2MX...`..p..0
  0ab0: d0 fe 4d 32 4d 4e 70 0c ff 33 d0 fe 4d 32 4d 58  ..M2MNp..3..M2MX
  0ac0: a4 42 55 46 30 14 49 12 5f 50 52 54 00 a0 4f 05  .BUF0.I._PRT..O.
  0ad0: 47 50 49 43 a4 12 47 05 06 12 0d 04 0c ff ff 1d  GPIC..G.........
  0ae0: 00 0a 00 0a 00 0a 10 12 0d 04 0c ff ff 1d 00 0a  ................
  0af0: 01 0a 00 0a 13 12 0d 04 0c ff ff 1d 00 0a 02 0a  ................
  0b00: 00 0a 12 12 0d 04 0c ff ff 1d 00 0a 03 0a 00 0a  ................
  0b10: 17 12 0d 04 0c ff ff 1f 00 0a 00 0a 00 0a 12 12  ................
  0b20: 0d 04 0c ff ff 1f 00 0a 01 0a 00 0a 11 a1 41 0c  ..............A.
  0b30: a4 12 4d 0b 06 12 1e 04 0c ff ff 1d 00 0a 00 5c  ..M............\
  0b40: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e  /._SB_PCI0LPC0LN
  0b50: 4b 41 0a 00 12 1e 04 0c ff ff 1d 00 0a 01 5c 2f  KA............\/
  0b60: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b  ._SB_PCI0LPC0LNK
  0b70: 44 0a 00 12 1e 04 0c ff ff 1d 00 0a 02 5c 2f 04  D............\/.
  0b80: 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 43  _SB_PCI0LPC0LNKC
  0b90: 0a 00 12 1e 04 0c ff ff 1d 00 0a 03 5c 2f 04 5f  ............\/._
  0ba0: 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 48 0a  SB_PCI0LPC0LNKH.
  0bb0: 00 12 1e 04 0c ff ff 1f 00 0a 00 5c 2f 04 5f 53  ...........\/._S
  0bc0: 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 43 0a 00  B_PCI0LPC0LNKC..
  0bd0: 12 1e 04 0c ff ff 1f 00 0a 01 5c 2f 04 5f 53 42  ..........\/._SB
  0be0: 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 42 0a 00 5b  _PCI0LPC0LNKB..[
  0bf0: 82 46 04 41 47 50 42 08 5f 41 44 52 0c 00 00 01  .F.AGPB._ADR....
  0c00: 00 14 27 5f 50 52 54 00 a4 12 1f 01 12 1c 04 0b  ..'_PRT.........
  0c10: ff ff 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  0c20: 50 43 30 4c 4e 4b 41 0a 00 5b 82 0c 56 47 41 5f  PC0LNKA..[..VGA_
  0c30: 08 5f 41 44 52 0a 00 5b 82 4a 2a 48 55 42 5f 08  ._ADR..[.J*HUB_.
  0c40: 5f 41 44 52 0c 00 00 1e 00 14 45 0a 5f 50 52 54  _ADR......E._PRT
  0c50: 00 a4 12 4c 09 05 12 1c 04 0b ff ff 0a 00 5c 2f  ...L..........\/
  0c60: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b  ._SB_PCI0LPC0LNK
  0c70: 42 0a 00 12 1e 04 0c ff ff 01 00 0a 00 5c 2f 04  B............\/.
  0c80: 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 44  _SB_PCI0LPC0LNKD
  0c90: 0a 00 12 1e 04 0c ff ff 02 00 0a 00 5c 2f 04 5f  ............\/._
  0ca0: 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 43 0a  SB_PCI0LPC0LNKC.
  0cb0: 00 12 1e 04 0c ff ff 03 00 0a 00 5c 2f 04 5f 53  ...........\/._S
  0cc0: 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 43 0a 00  B_PCI0LPC0LNKC..
  0cd0: 12 1e 04 0c ff ff 06 00 0a 00 5c 2f 04 5f 53 42  ..........\/._SB
  0ce0: 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 44 0a 00 5b  _PCI0LPC0LNKD..[
  0cf0: 82 4f 07 56 33 39 34 08 5f 41 44 52 0a 00 08 5f  .O.V394._ADR..._
  0d00: 50 53 43 0a 00 5b 80 54 49 44 53 02 0a 00 0a 04  PSC..[.TIDS.....
  0d10: 5b 81 0b 54 49 44 53 03 56 49 49 44 20 14 1a 5f  [..TIDS.VIID .._
  0d20: 53 54 41 00 a0 0e 93 56 49 49 44 0c ff ff ff ff  STA....VIID.....
  0d30: a4 0a 00 a1 04 a4 0a 0f 14 0d 5f 50 53 30 00 70  .........._PS0.p
  0d40: 0a 00 5f 50 53 43 14 0d 5f 50 53 31 00 70 0a 01  .._PSC.._PS1.p..
  0d50: 5f 50 53 43 14 0d 5f 50 53 32 00 70 0a 02 5f 50  _PSC.._PS2.p.._P
  0d60: 53 43 14 0d 5f 50 53 33 00 70 0a 03 5f 50 53 43  SC.._PS3.p.._PSC
  0d70: 5b 82 19 43 42 31 5f 08 5f 41 44 52 0c 00 00 03  [..CB1_._ADR....
  0d80: 00 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 25 45 4c  ..._STA....[.%EL
  0d90: 41 4e 08 5f 41 44 52 0c 00 00 01 00 14 09 5f 53  AN._ADR......._S
  0da0: 54 41 00 a4 0a 0f 08 5f 50 52 57 12 06 02 0a 08  TA....._PRW.....
  0db0: 0a 04 5b 82 4f 09 4d 49 4e 31 08 5f 41 44 52 0c  ..[.O.MIN1._ADR.
  0dc0: 00 00 02 00 08 5f 50 53 43 0a 00 5b 80 4d 49 44  ....._PSC..[.MID
  0dd0: 53 02 0a 00 0a c8 5b 81 1c 4d 49 44 53 03 4d 4f  S.....[..MIDS.MO
  0de0: 49 44 20 00 40 60 00 08 4d 50 4d 45 01 00 06 4d  ID .@`..MPME...M
  0df0: 50 4d 53 01 14 1a 5f 53 54 41 00 a0 0e 93 4d 4f  PMS..._STA....MO
  0e00: 49 44 0c ff ff ff ff a4 0a 00 a1 04 a4 0a 0f 14  ID..............
  0e10: 0d 5f 50 53 30 00 70 0a 00 5f 50 53 43 14 0d 5f  ._PS0.p.._PSC.._
  0e20: 50 53 31 00 70 0a 01 5f 50 53 43 14 0d 5f 50 53  PS1.p.._PSC.._PS
  0e30: 32 00 70 0a 02 5f 50 53 43 14 0d 5f 50 53 33 00  2.p.._PSC.._PS3.
  0e40: 70 0a 03 5f 50 53 43 08 5f 50 52 57 12 06 02 0a  p.._PSC._PRW....
  0e50: 08 0a 03 5b 82 4e 08 4d 49 4e 32 08 5f 41 44 52  ...[.N.MIN2._ADR
  0e60: 0c 00 00 06 00 08 5f 50 53 43 0a 00 5b 80 4c 4e  ......_PSC..[.LN
  0e70: 44 53 02 0a 00 0a 04 5b 81 0b 4c 4e 44 53 03 4c  DS.....[..LNDS.L
  0e80: 4e 49 44 20 14 1a 5f 53 54 41 00 a0 0e 93 4c 4e  NID .._STA....LN
  0e90: 49 44 0c ff ff ff ff a4 0a 00 a1 04 a4 0a 0f 14  ID..............
  0ea0: 0d 5f 50 53 30 00 70 0a 00 5f 50 53 43 14 0d 5f  ._PS0.p.._PSC.._
  0eb0: 50 53 31 00 70 0a 01 5f 50 53 43 14 0d 5f 50 53  PS1.p.._PSC.._PS
  0ec0: 32 00 70 0a 02 5f 50 53 43 14 0d 5f 50 53 33 00  2.p.._PSC.._PS3.
  0ed0: 70 0a 03 5f 50 53 43 08 5f 50 52 57 12 06 02 0a  p.._PSC._PRW....
  0ee0: 0b 0a 04 5b 82 8d db 02 4c 50 43 30 08 5f 41 44  ...[....LPC0._AD
  0ef0: 52 0c 00 00 1f 00 08 44 56 45 4e 0a 00 5b 80 52  R......DVEN..[.R
  0f00: 45 47 53 02 0a 40 0a c0 5b 81 2b 52 45 47 53 13  EGS..-rVxdn2TrCWA@public.gmane.org[.+REGS.
  0f10: 50 4d 42 41 10 00 40 0b 47 50 42 41 10 00 40 4b  PMBA..-uAchhwfckjc@public.gmane.org@K
  0f20: 00 05 46 55 4e 44 02 00 11 55 48 43 49 03 00 04  ..FUND...UHCI...
  0f30: 45 48 43 49 01 14 0a 44 45 43 44 0c 70 68 5b 31  EHCI...DECD.ph[1
  0f40: 5b 82 4e 17 4d 42 52 44 08 5f 48 49 44 0c 41 d0  [.N.MBRD._HID.A.
  0f50: 0c 02 08 5f 55 49 44 0a 1f 08 52 53 52 43 11 4a  ..._UID...RSRC.J
  0f60: 0f 0a f6 47 01 10 00 10 00 01 10 47 01 24 00 24  ...G.......G.$.$
  0f70: 00 01 02 47 01 28 00 28 00 01 02 47 01 2c 00 2c  ...G.(.(...G.,.,
  0f80: 00 01 02 47 01 30 00 30 00 01 02 47 01 34 00 34  ...G.0.0...G.4.4
  0f90: 00 01 02 47 01 38 00 38 00 01 02 47 01 3c 00 3c  ...G.8.8...G.<.<
  0fa0: 00 01 02 47 01 50 00 50 00 01 04 47 01 72 00 72  ...G.P.P...G.r.r
  0fb0: 00 01 06 47 01 80 00 80 00 01 01 47 01 90 00 90  ...G.......G....
  0fc0: 00 01 10 47 01 92 00 92 00 01 01 47 01 a4 00 a4  ...G.......G....
  0fd0: 00 01 02 47 01 a8 00 a8 00 01 02 47 01 ac 00 ac  ...G.......G....
  0fe0: 00 01 02 47 01 b0 00 b0 00 01 06 47 01 b2 00 b2  ...G.......G....
  0ff0: 00 01 02 47 01 b8 00 b8 00 01 02 47 01 bc 00 bc  ...G.......G....
  1000: 00 01 02 47 01 00 10 00 10 01 80 47 01 80 11 80  ...G.......G....
  1010: 11 01 40 47 01 2e 00 2e 00 01 02 47 01 4e 00 4e  ..-DRP6v/mynx6BN9qw/k7Zzg@public.gmane.org
  1020: 00 01 02 47 01 4c 00 4c 00 01 04 47 01 00 02 00  ...G.L.L...G....
  1030: 02 01 10 47 01 d0 04 d0 04 01 02 47 01 00 fe 00  ...G.......G....
  1040: fe 01 01 47 01 2c ff 2c ff 01 04 86 09 00 00 00  ...G.,.,........
  1050: 00 f8 ff 00 00 08 00 79 00 14 46 06 5f 43 52 53  .......y..F._CRS
  1060: 00 8b 52 53 52 43 0a a2 50 4d 4d 4e 8b 52 53 52  ..RSRC..PMMN.RSR
  1070: 43 0a a4 50 4d 4d 58 7b 5e 5e 50 4d 42 41 0b 80  C..PMMX{^^PMBA..
  1080: ff 50 4d 4d 4e 70 50 4d 4d 4e 50 4d 4d 58 8b 52  .PMMNpPMMNPMMX.R
  1090: 53 52 43 0a aa 47 50 4d 4e 8b 52 53 52 43 0a ac  SRC..GPMN.RSRC..
  10a0: 47 50 4d 58 7b 5e 5e 47 50 42 41 0b 80 ff 47 50  GPMX{^^GPBA...GP
  10b0: 4d 4e 70 47 50 4d 4e 47 50 4d 58 a4 52 53 52 43  MNpGPMNGPMX.RSRC
  10c0: 5b 82 46 04 44 4d 41 43 08 5f 48 49 44 0c 41 d0  [.F.DMAC._HID.A.
  10d0: 02 00 08 5f 43 52 53 11 30 0a 2d 47 01 00 00 00  ..._CRS.0.-G....
  10e0: 00 01 10 47 01 80 00 80 00 01 12 47 01 81 00 81  ...G.......G....
  10f0: 00 01 0f 47 01 93 00 93 00 01 0d 47 01 c0 00 c0  ...G.......G....
  1100: 00 01 20 2a 10 02 79 00 5b 82 26 4d 41 54 48 08  .. *..y.[.&MATH.
  1110: 5f 48 49 44 0c 41 d0 0c 04 08 5f 43 52 53 11 11  _HID.A...._CRS..
  1120: 0a 0e 47 01 f0 00 f0 00 01 0f 23 00 20 01 79 00  ..G.......#. .y.
  1130: 5b 82 4e 09 50 49 43 5f 08 5f 48 49 44 0b 41 d0  [.N.PIC_._HID.A.
  1140: 08 5f 43 52 53 11 4a 08 0a 86 47 01 20 00 20 00  ._CRS.J...G. . .
  1150: 01 02 47 01 24 00 24 00 01 02 47 01 28 00 28 00  ..G.$.$...G.(.(.
  1160: 01 02 47 01 2c 00 2c 00 01 02 47 01 30 00 30 00  ..G.,.,...G.0.0.
  1170: 01 02 47 01 34 00 34 00 01 02 47 01 38 00 38 00  ..G.4.4...G.8.8.
  1180: 01 02 47 01 3c 00 3c 00 01 02 47 01 a0 00 a0 00  ..G.<.<...G.....
  1190: 01 02 47 01 a4 00 a4 00 01 02 47 01 a8 00 a8 00  ..G.......G.....
  11a0: 01 02 47 01 ac 00 ac 00 01 02 47 01 b0 00 b0 00  ..G.......G.....
  11b0: 01 02 47 01 b4 00 b4 00 01 02 47 01 b8 00 b8 00  ..G.......G.....
  11c0: 01 02 47 01 bc 00 bc 00 01 02 23 04 00 01 79 00  ..G.......#...y.
  11d0: 5b 82 26 52 54 43 5f 08 5f 48 49 44 0c 41 d0 0b  [.&RTC_._HID.A..
  11e0: 00 08 5f 43 52 53 11 11 0a 0e 47 01 70 00 70 00  .._CRS....G.p.p.
  11f0: 01 02 23 00 01 01 79 00 5b 82 22 53 50 4b 52 08  ..#...y.[."SPKR.
  1200: 5f 48 49 44 0c 41 d0 08 00 08 5f 43 52 53 11 0d  _HID.A...._CRS..
  1210: 0a 0a 47 01 61 00 61 00 01 01 79 00 5b 82 2e 54  ..G.a.a...y.[..T
  1220: 49 4d 45 08 5f 48 49 44 0c 41 d0 01 00 08 5f 43  IME._HID.A...._C
  1230: 52 53 11 19 0a 16 47 01 40 00 40 00 01 04 47 01  RS....G.-4b8TPpkIZ3Q@public.gmane.org@...G.
  1240: 50 00 50 00 01 04 23 01 00 01 79 00 5b 82 2e 4b  P.P...#...y.[..K
  1250: 42 43 30 08 5f 48 49 44 0c 41 d0 03 03 08 5f 43  BC0._HID.A...._C
  1260: 52 53 11 19 0a 16 47 01 60 00 60 00 01 01 47 01  RS....G.`.`...G.
  1270: 64 00 64 00 01 01 23 02 00 01 79 00 5b 82 30 4d  d.d...#...y.[.0M
  1280: 53 45 30 08 5f 48 49 44 0c 4f 2e 07 02 08 5f 43  SE0._HID.O...._C
  1290: 49 44 12 0c 02 0c 4f 2e 07 00 0c 41 d0 0f 13 08  ID....O....A....
  12a0: 5f 43 52 53 11 09 0a 06 23 00 10 01 79 00 5b 82  _CRS....#...y.[.
  12b0: 45 0b 4c 4e 4b 41 08 5f 48 49 44 0c 41 d0 0c 0f  E.LNKA._HID.A...
  12c0: 08 5f 55 49 44 0a 01 08 5f 50 52 53 11 09 0a 06  ._UID..._PRS....
  12d0: 23 20 04 18 79 00 08 52 53 52 43 11 09 0a 06 23  # ..y..RSRC....#
  12e0: 00 00 18 79 00 14 11 5f 44 49 53 00 7d 50 49 52  ...y..._DIS.}PIR
  12f0: 41 0a 80 50 49 52 41 14 2d 5f 43 52 53 00 8b 52  A..PIRA.-_CRS..R
  1300: 53 52 43 0a 01 49 52 51 30 7b 50 49 52 41 0a 0f  SRC..IRQ0{PIRA..
  1310: 60 79 0a 01 60 49 52 51 30 70 52 53 52 43 5b 31  `y..`IRQ0pRSRC[1
  1320: a4 52 53 52 43 14 28 5f 53 52 53 01 70 68 5b 31  .RSRC.(_SRS.ph[1
  1330: 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60 76 60  .h..IRQ0.IRQ0`v`
  1340: 7d 60 7b 50 49 52 41 0a 70 00 50 49 52 41 14 16  }`{PIRA.p.PIRA..
  1350: 5f 53 54 41 00 a0 0c 7b 50 49 52 41 0a 80 00 a4  _STA...{PIRA....
  1360: 0a 09 a4 0a 0b 5b 82 4a 0a 4c 4e 4b 42 08 5f 48  .....[.J.LNKB._H
  1370: 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 02 08 5f  ID.A...._UID..._
  1380: 50 52 53 11 09 0a 06 23 20 04 18 79 00 08 52 53  PRS....# ..y..RS
  1390: 52 43 11 09 0a 06 23 00 00 18 79 00 14 11 5f 44  RC....#...y..._D
  13a0: 49 53 00 7d 50 49 52 42 0a 80 50 49 52 42 14 26  IS.}PIRB..PIRB.&
  13b0: 5f 43 52 53 00 8b 52 53 52 43 0a 01 49 52 51 30  _CRS..RSRC..IRQ0
  13c0: 7b 50 49 52 42 0a 0f 60 79 0a 01 60 49 52 51 30  {PIRB..`y..`IRQ0
  13d0: a4 52 53 52 43 14 24 5f 53 52 53 01 8b 68 0a 01  .RSRC.$_SRS..h..
  13e0: 49 52 51 30 82 49 52 51 30 60 76 60 7d 60 7b 50  IRQ0.IRQ0`v`}`{P
  13f0: 49 52 42 0a 70 00 50 49 52 42 14 16 5f 53 54 41  IRB.p.PIRB.._STA
  1400: 00 a0 0c 7b 50 49 52 42 0a 80 00 a4 0a 09 a4 0a  ...{PIRB........
  1410: 0b 5b 82 4a 0a 4c 4e 4b 43 08 5f 48 49 44 0c 41  .[.J.LNKC._HID.A
  1420: d0 0c 0f 08 5f 55 49 44 0a 03 08 5f 50 52 53 11  ...._UID..._PRS.
  1430: 09 0a 06 23 20 04 18 79 00 08 52 53 52 43 11 09  ...# ..y..RSRC..
  1440: 0a 06 23 00 00 18 79 00 14 11 5f 44 49 53 00 7d  ..#...y..._DIS.}
  1450: 50 49 52 43 0a 80 50 49 52 43 14 26 5f 43 52 53  PIRC..PIRC.&_CRS
  1460: 00 8b 52 53 52 43 0a 01 49 52 51 30 7b 50 49 52  ..RSRC..IRQ0{PIR
  1470: 43 0a 0f 60 79 0a 01 60 49 52 51 30 a4 52 53 52  C..`y..`IRQ0.RSR
  1480: 43 14 24 5f 53 52 53 01 8b 68 0a 01 49 52 51 30  C.$_SRS..h..IRQ0
  1490: 82 49 52 51 30 60 76 60 7d 60 7b 50 49 52 43 0a  .IRQ0`v`}`{PIRC.
  14a0: 70 00 50 49 52 43 14 16 5f 53 54 41 00 a0 0c 7b  p.PIRC.._STA...{
  14b0: 50 49 52 43 0a 80 00 a4 0a 09 a4 0a 0b 5b 82 4a  PIRC.........[.J
  14c0: 0a 4c 4e 4b 44 08 5f 48 49 44 0c 41 d0 0c 0f 08  .LNKD._HID.A....
  14d0: 5f 55 49 44 0a 04 08 5f 50 52 53 11 09 0a 06 23  _UID..._PRS....#
  14e0: 20 04 18 79 00 08 52 53 52 43 11 09 0a 06 23 00   ..y..RSRC....#.
  14f0: 00 18 79 00 14 11 5f 44 49 53 00 7d 50 49 52 44  ..y..._DIS.}PIRD
  1500: 0a 80 50 49 52 44 14 26 5f 43 52 53 00 8b 52 53  ..PIRD.&_CRS..RS
  1510: 52 43 0a 01 49 52 51 30 7b 50 49 52 44 0a 0f 60  RC..IRQ0{PIRD..`
  1520: 79 0a 01 60 49 52 51 30 a4 52 53 52 43 14 24 5f  y..`IRQ0.RSRC.$_
  1530: 53 52 53 01 8b 68 0a 01 49 52 51 30 82 49 52 51  SRS..h..IRQ0.IRQ
  1540: 30 60 76 60 7d 60 7b 50 49 52 44 0a 70 00 50 49  0`v`}`{PIRD.p.PI
  1550: 52 44 14 16 5f 53 54 41 00 a0 0c 7b 50 49 52 44  RD.._STA...{PIRD
  1560: 0a 80 00 a4 0a 09 a4 0a 0b 5b 82 45 0b 4c 4e 4b  .........[.E.LNK
  1570: 45 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44  E._HID.A...._UID
  1580: 0a 05 08 5f 50 52 53 11 09 0a 06 23 b8 dc 18 79  ..._PRS....#...y
  1590: 00 08 52 53 52 43 11 09 0a 06 23 00 00 18 79 00  ..RSRC....#...y.
  15a0: 14 11 5f 44 49 53 00 7d 50 49 52 45 0a 80 50 49  .._DIS.}PIRE..PI
  15b0: 52 45 14 2d 5f 43 52 53 00 8b 52 53 52 43 0a 01  RE.-_CRS..RSRC..
  15c0: 49 52 51 30 7b 50 49 52 45 0a 0f 60 79 0a 01 60  IRQ0{PIRE..`y..`
  15d0: 49 52 51 30 70 52 53 52 43 5b 31 a4 52 53 52 43  IRQ0pRSRC[1.RSRC
  15e0: 14 28 5f 53 52 53 01 70 68 5b 31 8b 68 0a 01 49  .(_SRS.ph[1.h..I
  15f0: 52 51 30 82 49 52 51 30 60 76 60 7d 60 7b 50 49  RQ0.IRQ0`v`}`{PI
  1600: 52 45 0a 70 00 50 49 52 45 14 16 5f 53 54 41 00  RE.p.PIRE.._STA.
  1610: a0 0c 7b 50 49 52 45 0a 80 00 a4 0a 09 a4 0a 0b  ..{PIRE.........
  1620: 5b 82 45 0b 4c 4e 4b 46 08 5f 48 49 44 0c 41 d0  [.E.LNKF._HID.A.
  1630: 0c 0f 08 5f 55 49 44 0a 06 08 5f 50 52 53 11 09  ..._UID..._PRS..
  1640: 0a 06 23 b8 dc 18 79 00 08 52 53 52 43 11 09 0a  ..#...y..RSRC...
  1650: 06 23 00 00 18 79 00 14 11 5f 44 49 53 00 7d 50  .#...y..._DIS.}P
  1660: 49 52 46 0a 80 50 49 52 46 14 2d 5f 43 52 53 00  IRF..PIRF.-_CRS.
  1670: 8b 52 53 52 43 0a 01 49 52 51 30 7b 50 49 52 46  .RSRC..IRQ0{PIRF
  1680: 0a 0f 60 79 0a 01 60 49 52 51 30 70 52 53 52 43  ..`y..`IRQ0pRSRC
  1690: 5b 31 a4 52 53 52 43 14 28 5f 53 52 53 01 70 68  [1.RSRC.(_SRS.ph
  16a0: 5b 31 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60  [1.h..IRQ0.IRQ0`
  16b0: 76 60 7d 60 7b 50 49 52 46 0a 70 00 50 49 52 46  v`}`{PIRF.p.PIRF
  16c0: 14 16 5f 53 54 41 00 a0 0c 7b 50 49 52 46 0a 80  .._STA...{PIRF..
  16d0: 00 a4 0a 09 a4 0a 0b 5b 82 45 0b 4c 4e 4b 47 08  .......[.E.LNKG.
  16e0: 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 07  _HID.A...._UID..
  16f0: 08 5f 50 52 53 11 09 0a 06 23 b8 dc 18 79 00 08  ._PRS....#...y..
  1700: 52 53 52 43 11 09 0a 06 23 00 00 18 79 00 14 11  RSRC....#...y...
  1710: 5f 44 49 53 00 7d 50 49 52 47 0a 80 50 49 52 47  _DIS.}PIRG..PIRG
  1720: 14 2d 5f 43 52 53 00 8b 52 53 52 43 0a 01 49 52  .-_CRS..RSRC..IR
  1730: 51 30 7b 50 49 52 47 0a 0f 60 79 0a 01 60 49 52  Q0{PIRG..`y..`IR
  1740: 51 30 70 52 53 52 43 5b 31 a4 52 53 52 43 14 28  Q0pRSRC[1.RSRC.(
  1750: 5f 53 52 53 01 70 68 5b 31 8b 68 0a 01 49 52 51  _SRS.ph[1.h..IRQ
  1760: 30 82 49 52 51 30 60 76 60 7d 60 7b 50 49 52 47  0.IRQ0`v`}`{PIRG
  1770: 0a 70 00 50 49 52 47 14 16 5f 53 54 41 00 a0 0c  .p.PIRG.._STA...
  1780: 7b 50 49 52 47 0a 80 00 a4 0a 09 a4 0a 0b 5b 82  {PIRG.........[.
  1790: 45 0b 4c 4e 4b 48 08 5f 48 49 44 0c 41 d0 0c 0f  E.LNKH._HID.A...
  17a0: 08 5f 55 49 44 0a 08 08 5f 50 52 53 11 09 0a 06  ._UID..._PRS....
  17b0: 23 20 04 18 79 00 08 52 53 52 43 11 09 0a 06 23  # ..y..RSRC....#
  17c0: 00 00 18 79 00 14 11 5f 44 49 53 00 7d 50 49 52  ...y..._DIS.}PIR
  17d0: 48 0a 80 50 49 52 48 14 2d 5f 43 52 53 00 8b 52  H..PIRH.-_CRS..R
  17e0: 53 52 43 0a 01 49 52 51 30 7b 50 49 52 48 0a 0f  SRC..IRQ0{PIRH..
  17f0: 60 79 0a 01 60 49 52 51 30 70 52 53 52 43 5b 31  `y..`IRQ0pRSRC[1
  1800: a4 52 53 52 43 14 28 5f 53 52 53 01 70 68 5b 31  .RSRC.(_SRS.ph[1
  1810: 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60 76 60  .h..IRQ0.IRQ0`v`
  1820: 7d 60 7b 50 49 52 48 0a 70 00 50 49 52 48 14 16  }`{PIRH.p.PIRH..
  1830: 5f 53 54 41 00 a0 0c 7b 50 49 52 48 0a 80 00 a4  _STA...{PIRH....
  1840: 0a 09 a4 0a 0b 5b 80 50 49 52 58 02 0a 60 0a 04  .....[.PIRX..`..
  1850: 5b 81 1d 50 49 52 58 13 01 01 00 50 49 52 41 08  [..PIRX....PIRA.
  1860: 50 49 52 42 08 50 49 52 43 08 50 49 52 44 08 5b  PIRB.PIRC.PIRD.[
  1870: 80 50 49 52 59 02 0a 68 0a 04 5b 81 1d 50 49 52  .PIRY..h..[..PIR
  1880: 59 13 01 01 00 50 49 52 45 08 50 49 52 46 08 50  Y....PIRE.PIRF.P
  1890: 49 52 47 08 50 49 52 48 08 5b 80 47 50 49 4f 01  IRG.PIRH.[.GPIO.
  18a0: 0b 00 13 0a 3c 5b 81 46 04 47 50 49 4f 13 00 40  ....<[.F.GPIO..@
  18b0: 07 50 52 53 54 01 53 52 53 54 01 00 46 0f 00 05  .PRST.SRST..F...
  18c0: 4c 50 4f 4c 01 00 42 05 00 01 53 50 57 52 01 49  LPOL..B...SPWR.I
  18d0: 56 42 30 01 49 56 42 31 01 49 56 42 32 01 42 49  VB0.IVB1.IVB2.BI
  18e0: 44 30 01 42 49 44 31 01 42 49 44 32 01 5b 80 50  D0.BID1.BID2.[.P
  18f0: 4d 49 4f 01 0b 00 10 0a 40 5b 81 2d 50 4d 49 4f  MIO.....@[.-PMIO
  1900: 12 01 03 00 00 48 15 00 05 4c 50 4f 53 01 00 1a  .....H...LPOS...
  1910: 00 05 4c 49 44 45 01 00 42 05 00 07 41 43 50 57  ..LIDE..B...ACPW
  1920: 01 00 05 4c 49 44 53 01 5b 80 4c 50 43 52 02 0a  ...LIDS.[.LPCR..
  1930: 00 0a ff 5b 81 16 4c 50 43 52 01 00 40 68 48 50  ...[..LPCR..-07JaBq2j7YY@public.gmane.org
  1940: 54 45 20 00 40 09 43 4d 41 44 01 5b 82 84 62 01  TE .-i1//ESUxW7M@public.gmane.org[..b.
  1950: 53 49 4f 5f 08 5f 48 49 44 0c 41 d0 0a 05 14 1c  SIO_._HID.A.....
  1960: 5f 49 4e 49 00 70 0a 00 5c 2f 04 5f 53 42 5f 50  _INI.p..\/._SB_P
  1970: 43 49 30 4c 50 43 30 43 4d 41 44 5b 80 53 49 49  CI0LPC0CMAD[.SII
  1980: 4f 01 0a 2e 0a 02 5b 81 10 53 49 49 4f 01 49 4e  O.....[..SIIO.IN
  1990: 44 58 08 44 41 54 41 08 5b 01 53 32 32 37 00 14  DX.DATA.[.S227..
  19a0: 0d 45 4e 54 52 00 70 0a 55 49 4e 44 58 14 0d 45  .ENTR.p.UINDX..E
  19b0: 58 49 54 00 70 0a aa 49 4e 44 58 14 1c 52 44 52  XIT.p..INDX..RDR
  19c0: 47 01 45 4e 54 52 70 68 49 4e 44 58 70 44 41 54  G.ENTRphINDXpDAT
  19d0: 41 60 45 58 49 54 a4 60 14 1a 57 52 52 47 02 45  A`EXIT.`..WRRG.E
  19e0: 4e 54 52 70 68 49 4e 44 58 70 69 44 41 54 41 45  NTRphINDXpiDATAE
  19f0: 58 49 54 14 27 52 45 41 44 03 5b 23 53 32 32 37  XIT.'READ.[#S227
  1a00: ff ff a0 0c 93 68 0a 00 70 52 44 52 47 69 61 7b  .....h..pRDRGia{
  1a10: 61 6a 61 5b 27 53 32 32 37 a4 61 14 20 57 52 49  aja['S227.a. WRI
  1a20: 54 03 5b 23 53 32 32 37 ff ff a0 0b 93 68 0a 00  T.[#S227.....h..
  1a30: 57 52 52 47 69 6a 5b 27 53 32 32 37 5b 82 4c 2f  WRRGij['S227[.L/
  1a40: 49 52 44 41 08 5f 48 49 44 0c 41 d0 05 10 08 49  IRDA._HID.A....I
  1a50: 45 4e 41 0a 01 08 52 53 52 43 11 10 0a 0d 47 01  ENA...RSRC....G.
  1a60: 00 00 00 00 00 00 22 00 00 79 00 14 4b 07 5f 53  ......"..y..K._S
  1a70: 54 41 00 70 52 45 41 44 0a 00 0a 2b 0a ff 60 a0  TA.pREAD...+..`.
  1a80: 09 92 93 60 0a 00 a4 0a 00 70 52 45 41 44 0a 00  ...`.....pREAD..
  1a90: 0a 25 0a ff 60 a0 08 93 60 0a 00 a4 0a 00 70 52  .%..`...`.....pR
  1aa0: 45 41 44 0a 00 0a 0c 0a 38 60 a0 28 92 93 60 0a  EAD.....8`.(..`.
  1ab0: 10 a0 09 92 93 60 0a 08 a4 0a 00 a1 17 70 52 45  .....`.......pRE
  1ac0: 41 44 0a 00 0a 2b 0a ff 60 a0 09 92 93 60 0a 00  AD...+..`....`..
  1ad0: a4 0a 00 70 49 45 4e 41 60 a0 08 93 60 0a 00 a4  ...pIENA`...`...
  1ae0: 0a 0d a1 04 a4 0a 0f 14 40 0b 5f 53 52 53 01 8c  ........-AKyS8pOMB+g@public.gmane.org
  1af0: 68 0a 02 49 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8c  h..IOLO.h..IOHI.
  1b00: 68 0a 09 49 52 51 4c 57 52 49 54 0a 00 0a 25 0a  h..IRQLWRIT...%.
  1b10: 00 82 49 52 51 4c 60 76 60 70 52 45 41 44 0a 00  ..IRQL`v`pREAD..
  1b20: 0a 28 0a f0 61 7d 60 61 60 57 52 49 54 0a 00 0a  .(..a}`a`WRIT...
  1b30: 28 60 70 49 4f 4c 4f 60 7a 60 0a 02 60 7b 60 0a  (`pIOLO`z`..`{`.
  1b40: fe 60 70 49 4f 48 49 61 79 61 0a 06 61 7d 60 61  .`pIOHIaya..a}`a
  1b50: 60 57 52 49 54 0a 00 0a 25 60 70 52 45 41 44 0a  `WRIT...%`pREAD.
  1b60: 00 0a 02 0a ff 60 7d 60 0a 80 60 57 52 49 54 0a  .....`}`..`WRIT.
  1b70: 00 0a 02 60 70 52 45 41 44 0a 00 0a 07 0a ff 60  ...`pREAD......`
  1b80: 80 0a 20 61 7b 60 61 60 57 52 49 54 0a 00 0a 07  .. a{`a`WRIT....
  1b90: 60 70 0a 01 49 45 4e 41 14 40 0d 5f 43 52 53 00  `p..IENA.-G1aPW9bytnI@public.gmane.org
  1ba0: 7b 5f 53 54 41 0a 02 60 a0 09 93 60 00 a4 52 53  {_STA..`...`..RS
  1bb0: 52 43 08 42 55 46 30 11 10 0a 0d 47 01 f8 03 f8  RC.BUF0....G....
  1bc0: 03 08 08 22 10 00 79 00 8c 42 55 46 30 0a 02 49  ..."..y..BUF0..I
  1bd0: 4f 4c 4f 8c 42 55 46 30 0a 03 49 4f 48 49 8c 42  OLO.BUF0..IOHI.B
  1be0: 55 46 30 0a 04 49 4f 52 4c 8c 42 55 46 30 0a 05  UF0..IORL.BUF0..
  1bf0: 49 4f 52 48 8c 42 55 46 30 0a 09 49 52 51 4c 8c  IORH.BUF0..IRQL.
  1c00: 42 55 46 30 0a 0a 49 52 51 48 70 52 45 41 44 0a  BUF0..IRQHpREAD.
  1c10: 00 0a 25 0a ff 60 70 60 61 7b 61 0a c0 61 7a 61  ..%..`p`a{a..aza
  1c20: 0a 06 61 79 60 0a 02 60 70 60 49 4f 4c 4f 70 61  ..ay`..`p`IOLOpa
  1c30: 49 4f 48 49 70 49 4f 4c 4f 49 4f 52 4c 70 49 4f  IOHIpIOLOIORLpIO
  1c40: 48 49 49 4f 52 48 70 52 45 41 44 0a 00 0a 28 0a  HIIORHpREAD...(.
  1c50: 0f 60 70 0a 01 61 79 61 60 49 52 51 4c 70 0a 00  .`p..aya`IRQLp..
  1c60: 49 52 51 48 a4 42 55 46 30 08 5f 50 52 53 11 3a  IRQH.BUF0._PRS.:
  1c70: 0a 37 31 04 47 01 f8 02 f8 02 01 08 22 08 00 31  .71.G......."..1
  1c80: 04 47 01 e8 02 e8 02 01 08 22 08 00 31 04 47 01  .G......."..1.G.
  1c90: f8 03 f8 03 01 08 22 10 00 31 04 47 01 e8 03 e8  ......"..1.G....
  1ca0: 03 01 08 22 10 00 38 79 00 14 0d 5f 44 49 53 00  ..."..8y..._DIS.
  1cb0: 70 0a 00 49 45 4e 41 14 3d 5f 50 53 30 00 70 52  p..IENA.=_PS0.pR
  1cc0: 45 41 44 0a 00 0a 02 0a ff 60 7d 60 0a 80 60 57  EAD......`}`..`W
  1cd0: 52 49 54 0a 00 0a 02 60 70 52 45 41 44 0a 00 0a  RIT....`pREAD...
  1ce0: 07 0a ff 60 80 0a 20 61 7b 60 61 60 57 52 49 54  ...`.. a{`a`WRIT
  1cf0: 0a 00 0a 07 60 14 20 5f 50 53 31 00 70 52 45 41  ....`. _PS1.pREA
  1d00: 44 0a 00 0a 07 0a ff 60 7d 60 0a 20 60 57 52 49  D......`}`. `WRI
  1d10: 54 0a 00 0a 07 60 14 23 5f 50 53 33 00 70 52 45  T....`.#_PS3.pRE
  1d20: 41 44 0a 00 0a 02 0a ff 60 80 0a 80 61 7b 60 61  AD......`...a{`a
  1d30: 60 57 52 49 54 0a 00 0a 02 60 5b 82 45 41 46 49  `WRIT....`[.EAFI
  1d40: 52 5f 08 5f 48 49 44 0c 4d a3 f0 10 08 46 45 4e  R_._HID.M....FEN
  1d50: 41 0a 01 08 42 55 46 30 11 1b 0a 18 47 01 f8 02  A...BUF0....G...
  1d60: f8 02 01 08 47 01 f8 06 f8 06 01 08 22 0a 00 2a  ....G......."..*
  1d70: 0a 00 79 00 08 52 53 52 43 11 1b 0a 18 47 01 00  ..y..RSRC....G..
  1d80: 00 00 00 00 00 47 01 00 00 00 00 00 00 22 01 00  .....G......."..
  1d90: 2a 0a 00 79 00 14 45 04 5f 53 54 41 00 70 52 45  *..y..E._STA.pRE
  1da0: 41 44 0a 00 0a 25 0a ff 60 a0 08 93 60 0a 00 a4  AD...%..`...`...
  1db0: 0a 00 70 52 45 41 44 0a 00 0a 2b 0a ff 60 a0 08  ..pREAD...+..`..
  1dc0: 93 60 0a 00 a4 0a 00 70 46 45 4e 41 60 a0 08 93  .`.....pFENA`...
  1dd0: 60 0a 00 a4 0a 0d a1 04 a4 0a 0f 14 40 14 5f 53  `...........-vPJ9Rs2UBf0@public.gmane.org
  1de0: 52 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68 0a 03 49  RS..h..IOLO.h..I
  1df0: 4f 48 49 8c 68 0a 0a 49 32 4c 4f 8c 68 0a 0b 49  OHI.h..I2LO.h..I
  1e00: 32 48 49 8c 68 0a 11 49 52 51 4c 8c 68 0a 14 44  2HI.h..IRQL.h..D
  1e10: 4d 41 43 57 52 49 54 0a 00 0a 25 0a 00 82 49 52  MACWRIT...%...IR
  1e20: 51 4c 60 76 60 70 52 45 41 44 0a 00 0a 28 0a f0  QL`v`pREAD...(..
  1e30: 61 7d 60 61 60 57 52 49 54 0a 00 0a 28 60 70 49  a}`a`WRIT...(`pI
  1e40: 4f 4c 4f 60 7a 60 0a 02 60 7b 60 0a fe 60 70 49  OLO`z`..`{`..`pI
  1e50: 4f 48 49 61 79 61 0a 06 61 7d 60 61 60 57 52 49  OHIaya..a}`a`WRI
  1e60: 54 0a 00 0a 25 60 70 49 32 4c 4f 60 7a 60 0a 03  T...%`pI2LO`z`..
  1e70: 60 70 49 32 48 49 61 79 61 0a 05 61 7d 60 61 60  `pI2HIaya..a}`a`
  1e80: 57 52 49 54 0a 00 0a 2b 60 82 44 4d 41 43 60 76  WRIT...+`.DMAC`v
  1e90: 60 57 52 49 54 0a 00 0a 2c 60 70 52 45 41 44 0a  `WRIT...,`pREAD.
  1ea0: 00 0a 0a 0a ff 60 80 0a c0 61 7b 60 61 60 7d 60  .....`...a{`a`}`
  1eb0: 0a 40 60 57 52 49 54 0a 00 0a 0a 60 70 52 45 41  .@`WRIT....`pREA
  1ec0: 44 0a 00 0a 0c 0a ff 60 80 0a 38 61 7b 60 61 60  D......`..8a{`a`
  1ed0: 7d 60 0a 08 60 57 52 49 54 0a 00 0a 0c 60 70 52  }`..`WRIT....`pR
  1ee0: 45 41 44 0a 00 0a 02 0a ff 60 7d 60 0a 80 60 57  EAD......`}`..`W
  1ef0: 52 49 54 0a 00 0a 02 60 70 52 45 41 44 0a 00 0a  RIT....`pREAD...
  1f00: 07 0a ff 60 80 0a 20 61 7b 60 61 60 57 52 49 54  ...`.. a{`a`WRIT
  1f10: 0a 00 0a 07 60 70 0a 01 46 45 4e 41 14 46 13 5f  ....`p..FENA.F._
  1f20: 43 52 53 00 7b 5f 53 54 41 0a 02 60 a0 09 93 60  CRS.{_STA..`...`
  1f30: 00 a4 52 53 52 43 8c 42 55 46 30 0a 02 49 4f 4c  ..RSRC.BUF0..IOL
  1f40: 4f 8c 42 55 46 30 0a 03 49 4f 48 49 8c 42 55 46  O.BUF0..IOHI.BUF
  1f50: 30 0a 04 49 4f 52 4c 8c 42 55 46 30 0a 05 49 4f  0..IORL.BUF0..IO
  1f60: 52 48 8c 42 55 46 30 0a 0a 49 32 4c 4f 8c 42 55  RH.BUF0..I2LO.BU
  1f70: 46 30 0a 0b 49 32 48 49 8c 42 55 46 30 0a 0c 49  F0..I2HI.BUF0..I
  1f80: 32 52 4c 8c 42 55 46 30 0a 0d 49 32 52 48 8c 42  2RL.BUF0..I2RH.B
  1f90: 55 46 30 0a 11 49 52 51 4c 8c 42 55 46 30 0a 12  UF0..IRQL.BUF0..
  1fa0: 49 52 51 48 8c 42 55 46 30 0a 14 44 4d 41 43 70  IRQH.BUF0..DMACp
  1fb0: 52 45 41 44 0a 00 0a 25 0a ff 60 70 60 61 7b 61  READ...%..`p`a{a
  1fc0: 0a c0 61 7a 61 0a 06 61 79 60 0a 02 60 7b 60 0a  ..aza..ay`..`{`.
  1fd0: ff 60 70 60 49 4f 4c 4f 70 61 49 4f 48 49 70 49  .`p`IOLOpaIOHIpI
  1fe0: 4f 4c 4f 49 4f 52 4c 70 49 4f 48 49 49 4f 52 48  OLOIORLpIOHIIORH
  1ff0: 70 49 4f 48 49 60 72 60 0a 04 60 70 60 49 32 48  pIOHI`r`..`p`I2H
  2000: 49 70 60 49 32 52 48 70 49 4f 4c 4f 60 70 60 49  Ip`I2RHpIOLO`p`I
  2010: 32 4c 4f 70 60 49 32 52 4c 70 52 45 41 44 0a 00  2LOp`I2RLpREAD..
  2020: 0a 28 0a 0f 60 70 0a 01 61 79 61 60 49 52 51 4c  .(..`p..aya`IRQL
  2030: 70 0a 00 49 52 51 48 70 52 45 41 44 0a 00 0a 2c  p..IRQHpREAD...,
  2040: 0a 0f 60 70 0a 01 61 79 61 60 44 4d 41 43 a4 42  ..`p..aya`DMAC.B
  2050: 55 46 30 08 5f 50 52 53 11 47 06 0a 63 31 04 47  UF0._PRS.G..c1.G
  2060: 01 f8 02 f8 02 01 08 47 01 f8 06 f8 06 01 08 22  .......G......."
  2070: 18 00 2a 0a 00 31 04 47 01 f8 03 f8 03 01 08 47  ..*..1.G.......G
  2080: 01 f8 07 f8 07 01 08 22 18 00 2a 0a 00 31 04 47  ......."..*..1.G
  2090: 01 e8 03 e8 03 01 08 47 01 e8 07 e8 07 01 08 22  .......G......."
  20a0: 18 00 2a 0a 00 31 04 47 01 e8 02 e8 02 01 08 47  ..*..1.G.......G
  20b0: 01 e8 06 e8 06 01 08 22 18 00 2a 0a 00 38 79 00  ......."..*..8y.
  20c0: 14 0d 5f 44 49 53 00 70 0a 00 46 45 4e 41 14 3d  .._DIS.p..FENA.=
  20d0: 5f 50 53 30 00 70 52 45 41 44 0a 00 0a 02 0a ff  _PS0.pREAD......
  20e0: 60 7d 60 0a 80 60 57 52 49 54 0a 00 0a 02 60 70  `}`..`WRIT....`p
  20f0: 52 45 41 44 0a 00 0a 07 0a ff 60 80 0a 20 61 7b  READ......`.. a{
  2100: 60 61 60 57 52 49 54 0a 00 0a 07 60 14 20 5f 50  `a`WRIT....`. _P
  2110: 53 31 00 70 52 45 41 44 0a 00 0a 07 0a ff 60 7d  S1.pREAD......`}
  2120: 60 0a 20 60 57 52 49 54 0a 00 0a 07 60 14 23 5f  `. `WRIT....`.#_
  2130: 50 53 33 00 70 52 45 41 44 0a 00 0a 02 0a ff 60  PS3.pREAD......`
  2140: 80 0a 80 61 7b 60 61 60 57 52 49 54 0a 00 0a 02  ...a{`a`WRIT....
  2150: 60 5b 82 45 32 4c 50 54 5f 08 5f 48 49 44 0c 41  `[.E2LPT_._HID.A
  2160: d0 04 00 08 5f 55 49 44 0a 01 08 5a 30 30 30 0a  ...._UID...Z000.
  2170: 01 14 44 05 5f 53 54 41 00 a0 1d 93 5a 30 30 30  ..D._STA....Z000
  2180: 0a 01 70 52 45 41 44 0a 00 0a 01 0a 04 60 a0 08  ..pREAD......`..
  2190: 93 60 0a 00 a4 0a 00 70 52 45 41 44 0a 00 0a 01  .`.....pREAD....
  21a0: 0a 08 60 a0 08 93 60 0a 00 a4 0a 00 70 52 45 41  ..`...`.....pREA
  21b0: 44 0a 00 0a 23 0a c0 60 a0 08 93 60 0a 00 a4 0a  D...#..`...`....
  21c0: 0d a1 04 a4 0a 0f 14 48 0a 5f 53 52 53 01 8c 68  .......H._SRS..h
  21d0: 0a 02 49 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8c 68  ..IOLO.h..IOHI.h
  21e0: 0a 09 49 52 51 4c 57 52 49 54 0a 00 0a 23 0a 00  ..IRQLWRIT...#..
  21f0: 82 49 52 51 4c 60 a0 1d 60 76 60 70 52 45 41 44  .IRQL`..`v`pREAD
  2200: 0a 00 0a 27 0a f0 61 7d 60 61 60 57 52 49 54 0a  ...'..a}`a`WRIT.
  2210: 00 0a 27 60 a1 16 70 52 45 41 44 0a 00 0a 27 0a  ..'`..pREAD...'.
  2220: f0 60 57 52 49 54 0a 00 0a 27 60 70 49 4f 4c 4f  .`WRIT...'`pIOLO
  2230: 60 7a 60 0a 02 60 70 49 4f 48 49 61 79 61 0a 06  `z`..`pIOHIaya..
  2240: 61 7d 60 61 60 57 52 49 54 0a 00 0a 23 60 70 52  a}`a`WRIT...#`pR
  2250: 45 41 44 0a 00 0a 01 0a ff 60 7d 60 0a 0c 60 57  EAD......`}`..`W
  2260: 52 49 54 0a 00 0a 01 60 70 0a 01 5a 30 30 30 14  RIT....`p..Z000.
  2270: 46 0e 5f 43 52 53 00 08 42 55 46 30 11 10 0a 0d  F._CRS..BUF0....
  2280: 47 01 00 00 00 00 01 08 22 00 00 79 00 8c 42 55  G......."..y..BU
  2290: 46 30 0a 02 49 4f 4c 4f 8c 42 55 46 30 0a 03 49  F0..IOLO.BUF0..I
  22a0: 4f 48 49 8c 42 55 46 30 0a 04 49 4f 52 4c 8c 42  OHI.BUF0..IORL.B
  22b0: 55 46 30 0a 05 49 4f 52 48 8c 42 55 46 30 0a 07  UF0..IORH.BUF0..
  22c0: 4c 4e 41 31 8c 42 55 46 30 0a 09 49 52 51 4c 70  LNA1.BUF0..IRQLp
  22d0: 52 45 41 44 0a 00 0a 23 0a ff 60 70 60 61 7b 61  READ...#..`p`a{a
  22e0: 0a c0 61 7a 61 0a 06 61 7b 60 0a 3f 60 79 60 0a  ..aza..a{`.?`y`.
  22f0: 02 60 70 60 49 4f 4c 4f 70 61 49 4f 48 49 70 49  .`p`IOLOpaIOHIpI
  2300: 4f 4c 4f 49 4f 52 4c 70 49 4f 48 49 49 4f 52 48  OLOIORLpIOHIIORH
  2310: a0 18 60 a0 0c 93 60 0a bc 70 0a 04 4c 4e 41 31  ..`...`..p..LNA1
  2320: a1 08 70 0a 08 4c 4e 41 31 a1 08 70 0a 00 4c 4e  ..p..LNA1..p..LN
  2330: 41 31 a0 1e 60 70 52 45 41 44 0a 00 0a 27 0a ff  A1..`pREAD...'..
  2340: 60 7b 60 0a 0f 60 70 0a 01 61 79 61 60 49 52 51  `{`..`p..aya`IRQ
  2350: 4c a4 42 55 46 30 08 5f 50 52 53 11 2d 0a 2a 31  L.BUF0._PRS.-.*1
  2360: 00 47 01 78 03 78 03 01 08 22 a0 00 31 05 47 01  .G.x.x..."..1.G.
  2370: 78 02 78 02 01 08 22 a0 00 31 0a 47 01 bc 03 bc  x.x..."..1.G....
  2380: 03 01 04 22 a0 00 38 79 00 14 4c 04 5f 44 49 53  ..."..8y..L._DIS
  2390: 00 57 52 49 54 0a 00 0a 23 0a 00 70 52 45 41 44  .WRIT...#..pREAD
  23a0: 0a 00 0a 27 0a ff 60 7b 60 0a f0 60 57 52 49 54  ...'..`{`..`WRIT
  23b0: 0a 00 0a 27 60 70 52 45 41 44 0a 00 0a 01 0a ff  ...'`pREAD......
  23c0: 60 7b 60 0a fb 60 57 52 49 54 0a 00 0a 01 60 70  `{`..`WRIT....`p
  23d0: 0a 00 5a 30 30 30 14 2a 5f 50 53 33 00 70 52 45  ..Z000.*_PS3.pRE
  23e0: 41 44 0a 00 0a 01 0a ff 60 80 0a 04 61 7b 60 61  AD......`...a{`a
  23f0: 60 57 52 49 54 0a 00 0a 01 60 70 0a 00 5a 30 30  `WRIT....`p..Z00
  2400: 30 14 4d 04 5f 50 53 30 00 70 52 45 41 44 0a 00  0.M._PS0.pREAD..
  2410: 0a 01 0a ff 60 80 0a 04 61 7b 60 61 60 7d 60 0a  ....`...a{`a`}`.
  2420: 04 60 57 52 49 54 0a 00 0a 01 60 70 0a 01 5a 30  .`WRIT....`p..Z0
  2430: 30 30 70 52 45 41 44 0a 00 0a 07 0a ff 60 80 0a  00pREAD......`..
  2440: 10 61 7b 60 61 60 57 52 49 54 0a 00 0a 07 60 14  .a{`a`WRIT....`.
  2450: 28 5f 50 53 32 00 70 52 45 41 44 0a 00 0a 07 0a  (_PS2.pREAD.....
  2460: ff 60 80 0a 10 61 7b 60 61 60 7d 60 0a 10 60 57  .`...a{`a`}`..`W
  2470: 52 49 54 0a 00 0a 07 60 5b 82 46 35 4c 50 42 49  RIT....`[.F5LPBI
  2480: 08 5f 48 49 44 0c 41 d0 04 00 08 5f 55 49 44 0a  ._HID.A...._UID.
  2490: 02 08 5a 30 30 31 0a 01 14 4b 06 5f 53 54 41 00  ..Z001...K._STA.
  24a0: a0 1d 93 5a 30 30 31 0a 01 70 52 45 41 44 0a 00  ...Z001..pREAD..
  24b0: 0a 01 0a 04 60 a0 08 93 60 0a 00 a4 0a 00 70 52  ....`...`.....pR
  24c0: 45 41 44 0a 00 0a 01 0a 08 60 a0 09 92 93 60 0a  EAD......`....`.
  24d0: 00 a4 0a 00 70 52 45 41 44 0a 00 0a 04 0a 03 60  ....pREAD......`
  24e0: a0 09 92 93 60 0a 00 a4 0a 00 70 52 45 41 44 0a  ....`.....pREAD.
  24f0: 00 0a 23 0a c0 60 a0 08 93 60 0a 00 a4 0a 0d a1  ..#..`...`......
  2500: 04 a4 0a 0f 14 42 0c 5f 53 52 53 01 8c 68 0a 02  .....B._SRS..h..
  2510: 49 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8c 68 0a 09  IOLO.h..IOHI.h..
  2520: 49 52 51 4c 57 52 49 54 0a 00 0a 23 0a 00 82 49  IRQLWRIT...#...I
  2530: 52 51 4c 60 a0 1d 60 76 60 70 52 45 41 44 0a 00  RQL`..`v`pREAD..
  2540: 0a 27 0a f0 61 7d 60 61 60 57 52 49 54 0a 00 0a  .'..a}`a`WRIT...
  2550: 27 60 a1 16 70 52 45 41 44 0a 00 0a 27 0a f0 60  '`..pREAD...'..`
  2560: 57 52 49 54 0a 00 0a 27 60 70 49 4f 4c 4f 60 7a  WRIT...'`pIOLO`z
  2570: 60 0a 02 60 70 49 4f 48 49 61 79 61 0a 06 61 7d  `..`pIOHIaya..a}
  2580: 60 61 60 57 52 49 54 0a 00 0a 23 60 70 52 45 41  `a`WRIT...#`pREA
  2590: 44 0a 00 0a 04 0a fc 60 57 52 49 54 0a 00 0a 04  D......`WRIT....
  25a0: 60 70 52 45 41 44 0a 00 0a 01 0a ff 60 7d 60 0a  `pREAD......`}`.
  25b0: 04 60 7b 60 0a f7 60 57 52 49 54 0a 00 0a 01 60  .`{`..`WRIT....`
  25c0: 70 0a 01 5a 30 30 31 14 46 0e 5f 43 52 53 00 08  p..Z001.F._CRS..
  25d0: 42 55 46 30 11 10 0a 0d 47 01 00 00 00 00 01 08  BUF0....G.......
  25e0: 22 00 00 79 00 8c 42 55 46 30 0a 02 49 4f 4c 4f  "..y..BUF0..IOLO
  25f0: 8c 42 55 46 30 0a 03 49 4f 48 49 8c 42 55 46 30  .BUF0..IOHI.BUF0
  2600: 0a 04 49 4f 52 4c 8c 42 55 46 30 0a 05 49 4f 52  ..IORL.BUF0..IOR
  2610: 48 8c 42 55 46 30 0a 07 4c 4e 41 31 8c 42 55 46  H.BUF0..LNA1.BUF
  2620: 30 0a 09 49 52 51 4c 70 52 45 41 44 0a 00 0a 23  0..IRQLpREAD...#
  2630: 0a ff 60 70 60 61 7b 61 0a c0 61 7a 61 0a 06 61  ..`p`a{a..aza..a
  2640: 7b 60 0a 3f 60 79 60 0a 02 60 70 60 49 4f 4c 4f  {`.?`y`..`p`IOLO
  2650: 70 61 49 4f 48 49 70 49 4f 4c 4f 49 4f 52 4c 70  paIOHIpIOLOIORLp
  2660: 49 4f 48 49 49 4f 52 48 a0 18 60 a0 0c 93 60 0a  IOHIIORH..`...`.
  2670: bc 70 0a 04 4c 4e 41 31 a1 08 70 0a 08 4c 4e 41  .p..LNA1..p..LNA
  2680: 31 a1 08 70 0a 00 4c 4e 41 31 a0 1e 60 70 52 45  1..p..LNA1..`pRE
  2690: 41 44 0a 00 0a 27 0a ff 60 7b 60 0a 0f 60 70 0a  AD...'..`{`..`p.
  26a0: 01 61 79 61 60 49 52 51 4c a4 42 55 46 30 08 5f  .aya`IRQL.BUF0._
  26b0: 50 52 53 11 2d 0a 2a 31 00 47 01 78 03 78 03 01  PRS.-.*1.G.x.x..
  26c0: 08 22 a0 00 31 05 47 01 78 02 78 02 01 08 22 a0  ."..1.G.x.x...".
  26d0: 00 31 0a 47 01 bc 03 bc 03 01 04 22 a0 00 38 79  .1.G......."..8y
  26e0: 00 14 4c 04 5f 44 49 53 00 57 52 49 54 0a 00 0a  ..L._DIS.WRIT...
  26f0: 23 0a 00 70 52 45 41 44 0a 00 0a 27 0a ff 60 7b  #..pREAD...'..`{
  2700: 60 0a f0 60 57 52 49 54 0a 00 0a 27 60 70 52 45  `..`WRIT...'`pRE
  2710: 41 44 0a 00 0a 01 0a ff 60 7b 60 0a fb 60 57 52  AD......`{`..`WR
  2720: 49 54 0a 00 0a 01 60 70 0a 00 5a 30 30 31 14 2a  IT....`p..Z001.*
  2730: 5f 50 53 33 00 70 52 45 41 44 0a 00 0a 01 0a ff  _PS3.pREAD......
  2740: 60 80 0a 04 61 7b 60 61 60 57 52 49 54 0a 00 0a  `...a{`a`WRIT...
  2750: 01 60 70 0a 00 5a 30 30 31 14 4d 04 5f 50 53 30  .`p..Z001.M._PS0
  2760: 00 70 52 45 41 44 0a 00 0a 01 0a ff 60 80 0a 04  .pREAD......`...
  2770: 61 7b 60 61 60 7d 60 0a 04 60 57 52 49 54 0a 00  a{`a`}`..`WRIT..
  2780: 0a 01 60 70 0a 01 5a 30 30 31 70 52 45 41 44 0a  ..`p..Z001pREAD.
  2790: 00 0a 07 0a ff 60 80 0a 10 61 7b 60 61 60 57 52  .....`...a{`a`WR
  27a0: 49 54 0a 00 0a 07 60 14 28 5f 50 53 32 00 70 52  IT....`.(_PS2.pR
  27b0: 45 41 44 0a 00 0a 07 0a ff 60 80 0a 10 61 7b 60  EAD......`...a{`
  27c0: 61 60 7d 60 0a 10 60 57 52 49 54 0a 00 0a 07 60  a`}`..`WRIT....`
  27d0: 5b 82 4d 43 45 43 50 5f 08 5f 48 49 44 0c 41 d0  [.MCECP_._HID.A.
  27e0: 04 01 08 5a 30 30 32 0a 01 14 4b 06 5f 53 54 41  ...Z002...K._STA
  27f0: 00 a0 1d 93 5a 30 30 32 0a 01 70 52 45 41 44 0a  ....Z002..pREAD.
  2800: 00 0a 01 0a 04 60 a0 08 93 60 0a 00 a4 0a 00 70  .....`...`.....p
  2810: 52 45 41 44 0a 00 0a 01 0a 08 60 a0 09 92 93 60  READ......`....`
  2820: 0a 00 a4 0a 00 70 52 45 41 44 0a 00 0a 04 0a 03  .....pREAD......
  2830: 60 a0 09 92 93 60 0a 02 a4 0a 00 70 52 45 41 44  `....`.....pREAD
  2840: 0a 00 0a 23 0a c0 60 a0 08 93 60 0a 00 a4 0a 0d  ...#..`...`.....
  2850: a1 04 a4 0a 0f 14 4a 10 5f 53 52 53 01 8c 68 0a  ......J._SRS..h.
  2860: 02 49 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8c 68 0a  .IOLO.h..IOHI.h.
  2870: 11 49 52 51 4c 8c 68 0a 14 44 4d 41 43 57 52 49  .IRQL.h..DMACWRI
  2880: 54 0a 00 0a 23 0a 00 82 49 52 51 4c 60 a0 1d 60  T...#...IRQL`..`
  2890: 76 60 70 52 45 41 44 0a 00 0a 27 0a f0 61 7d 60  v`pREAD...'..a}`
  28a0: 61 60 57 52 49 54 0a 00 0a 27 60 a1 16 70 52 45  a`WRIT...'`..pRE
  28b0: 41 44 0a 00 0a 27 0a f0 60 57 52 49 54 0a 00 0a  AD...'..`WRIT...
  28c0: 27 60 70 49 4f 4c 4f 60 7a 60 0a 02 60 70 49 4f  '`pIOLO`z`..`pIO
  28d0: 48 49 61 79 61 0a 06 61 7d 60 61 60 57 52 49 54  HIaya..a}`a`WRIT
  28e0: 0a 00 0a 23 60 82 44 4d 41 43 60 a0 1d 60 76 60  ...#`.DMAC`..`v`
  28f0: 70 52 45 41 44 0a 00 0a 26 0a f0 61 7d 60 61 60  pREAD...&..a}`a`
  2900: 57 52 49 54 0a 00 0a 26 60 a1 16 70 52 45 41 44  WRIT...&`..pREAD
  2910: 0a 00 0a 26 0a f0 60 57 52 49 54 0a 00 0a 26 60  ...&..`WRIT...&`
  2920: 70 52 45 41 44 0a 00 0a 04 0a fc 60 7d 60 0a 02  pREAD......`}`..
  2930: 60 57 52 49 54 0a 00 0a 04 60 70 52 45 41 44 0a  `WRIT....`pREAD.
  2940: 00 0a 01 0a ff 60 7d 60 0a 04 60 7b 60 0a f7 60  .....`}`..`{`..`
  2950: 57 52 49 54 0a 00 0a 01 60 70 0a 01 5a 30 30 32  WRIT....`p..Z002
  2960: 14 4a 16 5f 43 52 53 00 08 42 55 46 30 11 1b 0a  .J._CRS..BUF0...
  2970: 18 47 01 00 00 00 00 08 04 47 01 00 00 00 00 08  .G.......G......
  2980: 04 22 00 00 2a 00 00 79 00 8c 42 55 46 30 0a 02  ."..*..y..BUF0..
  2990: 49 4f 4c 4f 8c 42 55 46 30 0a 03 49 4f 48 49 8c  IOLO.BUF0..IOHI.
  29a0: 42 55 46 30 0a 04 49 4f 52 4c 8c 42 55 46 30 0a  BUF0..IORL.BUF0.
  29b0: 05 49 4f 52 48 8c 42 55 46 30 0a 07 4c 4e 41 31  .IORH.BUF0..LNA1
  29c0: 8c 42 55 46 30 0a 0a 44 41 4c 4f 8c 42 55 46 30  .BUF0..DALO.BUF0
  29d0: 0a 0b 44 41 48 49 8c 42 55 46 30 0a 0c 44 52 4c  ..DAHI.BUF0..DRL
  29e0: 4f 8c 42 55 46 30 0a 0d 44 52 48 49 8c 42 55 46  O.BUF0..DRHI.BUF
  29f0: 30 0a 0f 4c 4e 41 32 8c 42 55 46 30 0a 11 49 52  0..LNA2.BUF0..IR
  2a00: 51 4c 8c 42 55 46 30 0a 14 44 4d 41 43 70 52 45  QL.BUF0..DMACpRE
  2a10: 41 44 0a 00 0a 23 0a ff 60 70 60 61 7b 61 0a c0  AD...#..`p`a{a..
  2a20: 61 7a 61 0a 06 61 7b 60 0a 3f 60 79 60 0a 02 60  aza..a{`.?`y`..`
  2a30: 70 60 49 4f 4c 4f 70 61 49 4f 48 49 70 49 4f 4c  p`IOLOpaIOHIpIOL
  2a40: 4f 49 4f 52 4c 70 49 4f 48 49 49 4f 52 48 72 61  OIORLpIOHIIORHra
  2a50: 0a 04 61 70 49 4f 4c 4f 44 41 4c 4f 70 61 44 41  ..apIOLODALOpaDA
  2a60: 48 49 70 44 41 4c 4f 44 52 4c 4f 70 44 41 48 49  HIpDALODRLOpDAHI
  2a70: 44 52 48 49 a0 13 93 60 0a 00 70 0a 00 4c 4e 41  DRHI...`..p..LNA
  2a80: 31 70 0a 00 4c 4e 41 32 a0 1e 60 70 52 45 41 44  1p..LNA2..`pREAD
  2a90: 0a 00 0a 27 0a ff 60 7b 60 0a 0f 60 70 0a 01 61  ...'..`{`..`p..a
  2aa0: 79 61 60 49 52 51 4c a0 1e 60 70 52 45 41 44 0a  ya`IRQL..`pREAD.
  2ab0: 00 0a 26 0a ff 60 7b 60 0a 0f 60 70 0a 01 61 79  ..&..`{`..`p..ay
  2ac0: 61 60 44 4d 41 43 a4 42 55 46 30 08 5f 50 52 53  a`DMAC.BUF0._PRS
  2ad0: 11 4f 04 0a 4b 31 00 47 01 78 03 78 03 08 04 47  .O..K1.G.x.x...G
  2ae0: 01 78 07 78 07 08 04 22 a0 00 2a 0a 00 31 05 47  .x.x..."..*..1.G
  2af0: 01 78 02 78 02 08 04 47 01 78 06 78 06 08 04 22  .x.x...G.x.x..."
  2b00: a0 00 2a 0a 00 31 0a 47 01 bc 03 bc 03 08 04 47  ..*..1.G.......G
  2b10: 01 bc 07 bc 07 08 04 22 a0 00 2a 0a 00 38 79 00  ......."..*..8y.
  2b20: 14 4c 04 5f 44 49 53 00 57 52 49 54 0a 00 0a 23  .L._DIS.WRIT...#
  2b30: 0a 00 70 52 45 41 44 0a 00 0a 27 0a ff 60 7b 60  ..pREAD...'..`{`
  2b40: 0a f0 60 57 52 49 54 0a 00 0a 27 60 70 52 45 41  ..`WRIT...'`pREA
  2b50: 44 0a 00 0a 01 0a ff 60 7b 60 0a fb 60 57 52 49  D......`{`..`WRI
  2b60: 54 0a 00 0a 01 60 70 0a 00 5a 30 30 32 14 2a 5f  T....`p..Z002.*_
  2b70: 50 53 33 00 70 52 45 41 44 0a 00 0a 01 0a ff 60  PS3.pREAD......`
  2b80: 80 0a 04 61 7b 60 61 60 57 52 49 54 0a 00 0a 01  ...a{`a`WRIT....
  2b90: 60 70 0a 00 5a 30 30 32 14 4d 04 5f 50 53 30 00  `p..Z002.M._PS0.
  2ba0: 70 52 45 41 44 0a 00 0a 01 0a ff 60 80 0a 04 61  pREAD......`...a
  2bb0: 7b 60 61 60 7d 60 0a 04 60 57 52 49 54 0a 00 0a  {`a`}`..`WRIT...
  2bc0: 01 60 70 0a 01 5a 30 30 32 70 52 45 41 44 0a 00  .`p..Z002pREAD..
  2bd0: 0a 07 0a ff 60 80 0a 10 61 7b 60 61 60 57 52 49  ....`...a{`a`WRI
  2be0: 54 0a 00 0a 07 60 14 28 5f 50 53 32 00 70 52 45  T....`.(_PS2.pRE
  2bf0: 41 44 0a 00 0a 07 0a ff 60 80 0a 10 61 7b 60 61  AD......`...a{`a
  2c00: 60 7d 60 0a 10 60 57 52 49 54 0a 00 0a 07 60 5b  `}`..`WRIT....`[
  2c10: 82 40 36 45 50 50 5f 08 5f 48 49 44 0c 41 d0 04  .-rrCfgMNmVYYQLQ4F6vkVjQ@public.gmane.org
  2c20: 00 08 5f 55 49 44 0a 03 08 5a 30 30 33 0a 01 14  .._UID...Z003...
  2c30: 4b 06 5f 53 54 41 00 a0 1d 93 5a 30 30 33 0a 01  K._STA....Z003..
  2c40: 70 52 45 41 44 0a 00 0a 01 0a 04 60 a0 08 93 60  pREAD......`...`
  2c50: 0a 00 a4 0a 00 70 52 45 41 44 0a 00 0a 01 0a 08  .....pREAD......
  2c60: 60 a0 09 92 93 60 0a 00 a4 0a 00 70 52 45 41 44  `....`.....pREAD
  2c70: 0a 00 0a 04 0a 03 60 a0 09 92 93 60 0a 01 a4 0a  ......`....`....
  2c80: 00 70 52 45 41 44 0a 00 0a 23 0a c0 60 a0 08 93  .pREAD...#..`...
  2c90: 60 0a 00 a4 0a 0d a1 04 a4 0a 0f 14 4c 0c 5f 53  `...........L._S
  2ca0: 52 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68 0a 03 49  RS..h..IOLO.h..I
  2cb0: 4f 48 49 8c 68 0a 09 49 52 51 4c 57 52 49 54 0a  OHI.h..IRQLWRIT.
  2cc0: 00 0a 23 0a 00 82 49 52 51 4c 60 a0 1d 60 76 60  ..#...IRQL`..`v`
  2cd0: 70 52 45 41 44 0a 00 0a 27 0a f0 61 7d 60 61 60  pREAD...'..a}`a`
  2ce0: 57 52 49 54 0a 00 0a 27 60 a1 16 70 52 45 41 44  WRIT...'`..pREAD
  2cf0: 0a 00 0a 27 0a f0 60 57 52 49 54 0a 00 0a 27 60  ...'..`WRIT...'`
  2d00: 70 49 4f 4c 4f 60 7a 60 0a 02 60 70 49 4f 48 49  pIOLO`z`..`pIOHI
  2d10: 61 79 61 0a 06 61 7d 60 61 60 57 52 49 54 0a 00  aya..a}`a`WRIT..
  2d20: 0a 23 60 70 52 45 41 44 0a 00 0a 04 0a fc 60 7d  .#`pREAD......`}
  2d30: 60 0a 01 60 7b 60 0a bf 60 57 52 49 54 0a 00 0a  `..`{`..`WRIT...
  2d40: 04 60 70 52 45 41 44 0a 00 0a 01 0a ff 60 7d 60  .`pREAD......`}`
  2d50: 0a 04 60 7b 60 0a f7 60 57 52 49 54 0a 00 0a 01  ..`{`..`WRIT....
  2d60: 60 70 0a 01 5a 30 30 33 14 46 0e 5f 43 52 53 00  `p..Z003.F._CRS.
  2d70: 08 42 55 46 30 11 10 0a 0d 47 01 00 00 00 00 01  .BUF0....G......
  2d80: 08 22 00 00 79 00 8c 42 55 46 30 0a 02 49 4f 4c  ."..y..BUF0..IOL
  2d90: 4f 8c 42 55 46 30 0a 03 49 4f 48 49 8c 42 55 46  O.BUF0..IOHI.BUF
  2da0: 30 0a 04 49 4f 52 4c 8c 42 55 46 30 0a 05 49 4f  0..IORL.BUF0..IO
  2db0: 52 48 8c 42 55 46 30 0a 07 4c 4e 41 31 8c 42 55  RH.BUF0..LNA1.BU
  2dc0: 46 30 0a 09 49 52 51 4c 70 52 45 41 44 0a 00 0a  F0..IRQLpREAD...
  2dd0: 23 0a ff 60 70 60 61 7b 61 0a c0 61 7a 61 0a 06  #..`p`a{a..aza..
  2de0: 61 7b 60 0a 3f 60 79 60 0a 02 60 70 60 49 4f 4c  a{`.?`y`..`p`IOL
  2df0: 4f 70 61 49 4f 48 49 70 49 4f 4c 4f 49 4f 52 4c  OpaIOHIpIOLOIORL
  2e00: 70 49 4f 48 49 49 4f 52 48 a0 18 60 a0 0c 93 60  pIOHIIORH..`...`
  2e10: 0a bc 70 0a 04 4c 4e 41 31 a1 08 70 0a 08 4c 4e  ..p..LNA1..p..LN
  2e20: 41 31 a1 08 70 0a 00 4c 4e 41 31 a0 1e 60 70 52  A1..p..LNA1..`pR
  2e30: 45 41 44 0a 00 0a 27 0a ff 60 7b 60 0a 0f 60 70  EAD...'..`{`..`p
  2e40: 0a 01 61 79 61 60 49 52 51 4c a4 42 55 46 30 08  ..aya`IRQL.BUF0.
  2e50: 5f 50 52 53 11 2d 0a 2a 31 00 47 01 78 03 78 03  _PRS.-.*1.G.x.x.
  2e60: 01 08 22 a0 00 31 05 47 01 78 02 78 02 01 08 22  .."..1.G.x.x..."
  2e70: a0 00 31 0a 47 01 bc 03 bc 03 01 04 22 a0 00 38  ..1.G......."..8
  2e80: 79 00 14 4c 04 5f 44 49 53 00 57 52 49 54 0a 00  y..L._DIS.WRIT..
  2e90: 0a 23 0a 00 70 52 45 41 44 0a 00 0a 27 0a ff 60  .#..pREAD...'..`
  2ea0: 7b 60 0a f0 60 57 52 49 54 0a 00 0a 27 60 70 52  {`..`WRIT...'`pR
  2eb0: 45 41 44 0a 00 0a 01 0a ff 60 7b 60 0a fb 60 57  EAD......`{`..`W
  2ec0: 52 49 54 0a 00 0a 01 60 70 0a 00 5a 30 30 33 14  RIT....`p..Z003.
  2ed0: 2a 5f 50 53 33 00 70 52 45 41 44 0a 00 0a 01 0a  *_PS3.pREAD.....
  2ee0: ff 60 80 0a 04 61 7b 60 61 60 57 52 49 54 0a 00  .`...a{`a`WRIT..
  2ef0: 0a 01 60 70 0a 00 5a 30 30 33 14 4d 04 5f 50 53  ..`p..Z003.M._PS
  2f00: 30 00 70 52 45 41 44 0a 00 0a 01 0a ff 60 80 0a  0.pREAD......`..
  2f10: 04 61 7b 60 61 60 7d 60 0a 04 60 57 52 49 54 0a  .a{`a`}`..`WRIT.
  2f20: 00 0a 01 60 70 0a 01 5a 30 30 33 70 52 45 41 44  ...`p..Z003pREAD
  2f30: 0a 00 0a 07 0a ff 60 80 0a 10 61 7b 60 61 60 57  ......`...a{`a`W
  2f40: 52 49 54 0a 00 0a 07 60 14 28 5f 50 53 32 00 70  RIT....`.(_PS2.p
  2f50: 52 45 41 44 0a 00 0a 07 0a ff 60 80 0a 10 61 7b  READ......`...a{
  2f60: 60 61 60 7d 60 0a 10 60 57 52 49 54 0a 00 0a 07  `a`}`..`WRIT....
  2f70: 60 14 2a 45 43 4f 4b 00 a0 1e 93 5c 2f 05 5f 53  `.*ECOK....\/._S
  2f80: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 45 43  B_PCI0LPC0EC0_EC
  2f90: 4f 4b 0a 01 a4 0a 01 a1 04 a4 0a 00 5b 82 4a 6f  OK..........[.Jo
  2fa0: 45 43 30 5f 08 5f 48 49 44 0c 41 d0 0c 09 08 5f  EC0_._HID.A...._
  2fb0: 47 50 45 0a 1c 08 45 43 4f 4b 00 08 5f 43 52 53  GPE...ECOK.._CRS
  2fc0: 11 15 0a 12 47 01 62 00 62 00 01 01 47 01 66 00  ....G.b.b...G.f.
  2fd0: 66 00 01 01 79 00 14 12 5f 52 45 47 02 a0 0b 93  f...y..._REG....
  2fe0: 68 0a 03 70 69 45 43 4f 4b 5b 80 45 52 41 4d 03  h..piECOK[.ERAM.
  2ff0: 0a 00 0b 00 01 5b 81 4e 24 45 52 41 4d 11 00 40  .....[.N$ERAM..@
  3000: 17 52 53 4d 54 10 00 40 08 00 08 43 53 50 52 01  .RSMT..-ZS2Qsa9/WYo@public.gmane.org
  3010: 00 47 0f 53 50 52 4f 08 53 4d 53 54 08 53 41 44  .G.SPRO.SMST.SAD
  3020: 44 08 53 4d 42 43 08 53 44 30 30 08 53 44 30 31  D.SMBC.SD00.SD01
  3030: 08 53 44 30 32 08 53 44 30 33 08 53 44 30 34 08  .SD02.SD03.SD04.
  3040: 53 44 30 35 08 53 44 30 36 08 53 44 30 37 08 53  SD05.SD06.SD07.S
  3050: 44 30 38 08 00 48 0b 53 42 43 4e 08 53 41 4c 41  D08..H.SBCN.SALA
  3060: 08 53 41 44 30 08 53 41 44 31 08 00 40 04 43 48  .SAD0.SAD1..-2IFBRcQklIQ@public.gmane.org
  3070: 47 4d 10 43 48 47 53 10 43 48 47 43 10 43 48 47  GM.CHGS.CHGC.CHG
  3080: 56 10 43 48 47 41 10 42 41 4c 30 01 42 41 4c 31  V.CHGA.BAL0.BAL1
  3090: 01 42 41 4c 32 01 42 41 4c 33 01 00 0c 42 45 45  .BAL2.BAL3...BEE
  30a0: 50 01 46 41 4e 31 01 46 41 4e 32 01 43 52 54 5f  P.FAN1.FAN2.CRT_
  30b0: 01 45 58 46 44 01 50 48 44 44 01 53 48 44 44 01  .EXFD.PHDD.SHDD.
  30c0: 46 44 44 5f 01 53 42 54 4e 01 56 49 44 4f 01 56  FDD_.SBTN.VIDO.V
  30d0: 4f 4c 44 01 56 4f 4c 55 01 4d 55 54 45 01 43 4f  OLD.VOLU.MUTE.CO
  30e0: 4e 54 01 42 52 47 54 01 48 42 54 4e 01 53 34 53  NT.BRGT.HBTN.S4S
  30f0: 5f 01 53 4b 45 59 01 42 4b 45 59 01 00 15 44 4b  _.SKEY.BKEY...DK
  3100: 53 54 01 00 06 44 4b 45 56 01 00 08 53 30 4c 44  ST...DKEV...S0LD
  3110: 01 53 33 4c 44 01 56 47 41 51 01 50 43 4d 51 01  .S3LD.VGAQ.PCMQ.
  3120: 50 43 4d 52 01 41 44 50 5f 01 53 59 53 36 01 53  PCMR.ADP_.SYS6.S
  3130: 59 53 37 01 50 57 41 4b 01 4d 57 41 4b 01 4c 57  YS7.PWAK.MWAK.LW
  3140: 41 4b 01 00 05 46 4f 54 5f 08 46 53 44 31 08 46  AK...FOT_.FSD1.F
  3150: 53 44 32 08 00 40 04 43 54 4d 50 08 00 38 42 54  SD2..-tvmEkdyvhZUgbAIP373q7w@public.gmane.org
  3160: 44 54 01 42 54 50 57 01 42 54 44 53 01 42 54 50  DT.BTPW.BTDS.BTP
  3170: 53 01 42 54 53 57 01 00 01 42 4c 45 44 01 00 01  S.BTSW...BLED...
  3180: 42 52 54 53 08 00 08 57 4c 41 54 01 42 54 41 54  BRTS...WLAT.BTAT
  3190: 01 57 4c 45 58 01 42 54 45 58 01 4b 4c 53 57 01  .WLEX.BTEX.KLSW.
  31a0: 00 23 00 04 42 4d 46 30 03 42 54 59 30 01 42 44  .#..BMF0.BTY0.BD
  31b0: 43 48 01 42 54 43 48 01 42 4c 4c 42 01 42 53 54  CH.BTCH.BLLB.BST
  31c0: 30 05 42 52 43 30 10 42 53 4e 30 10 42 50 56 30  0.BRC0.BSN0.BPV0
  31d0: 10 42 44 56 30 10 42 44 43 30 10 42 46 43 30 10  .BDV0.BDC0.BFC0.
  31e0: 47 41 55 30 08 00 08 00 04 42 4d 46 31 03 42 54  GAU0.....BMF1.BT
  31f0: 59 31 01 42 53 54 31 08 42 52 43 31 10 42 53 4e  Y1.BST1.BRC1.BSN
  3200: 31 10 42 50 56 31 10 42 44 56 31 10 42 44 43 31  1.BPV1.BDV1.BDC1
  3210: 10 42 46 43 31 10 47 41 55 31 08 00 40 0e 42 54  .BFC1.GAU1..-DM5VFMz13dY@public.gmane.org
  3220: 45 43 08 55 42 44 4d 04 55 42 50 43 03 00 01 42  EC.UBDM.UBPC...B
  3230: 54 43 53 08 42 4d 44 4c 08 43 42 44 4d 04 43 42  TCS.BMDL.CBDM.CB
  3240: 50 43 03 00 01 5b 81 0e 45 52 41 4d 11 00 40 32  PC...[..ERAM..-wZAM94cBS44@public.gmane.org
  3250: 44 54 44 57 10 5b 81 14 45 52 41 4d 11 00 40 32  DTDW.[..ERAM..-wZAM94cBS44@public.gmane.org
  3260: 42 4c 4f 4b 40 10 42 43 4e 54 08 5b 81 0f 45 52  BLOK-7x/0wJfZGL4@public.gmane.org[..ER
  3270: 41 4d 11 00 40 32 46 4c 44 30 40 04 5b 81 0f 45  AM..-1eCXavwf2WU@public.gmane.org@.[..E
  3280: 52 41 4d 11 00 40 32 46 4c 44 31 40 08 14 36 5f  RAM..-w/YC6ifYAIk@public.gmane.org@..6_
  3290: 51 31 31 00 70 0d 3d 3d 3d 3d 3d 51 55 45 52 59  Q11.p.=====QUERY
  32a0: 5f 31 31 3d 3d 3d 3d 3d 00 5b 31 a0 18 5c 2f 05  _11=====.[1..\/.
  32b0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  32c0: 42 52 47 54 14 4d 05 5f 51 31 43 00 70 0d 3d 3d  BRGT.M._Q1C.p.==
  32d0: 3d 3d 3d 51 55 45 52 59 5f 31 43 3d 3d 3d 3d 3d  ===QUERY_1C=====
  32e0: 00 5b 31 a0 3e 5c 2f 05 5f 53 42 5f 50 43 49 30  .[1.>\/._SB_PCI0
  32f0: 4c 50 43 30 45 43 30 5f 56 49 44 4f 5c 2e 5f 53  LPC0EC0_VIDO\._S
  3300: 42 5f 47 53 4d 49 0a 08 70 0a 00 5c 2f 05 5f 53  B_GSMI..p..\/._S
  3310: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 56 49  B_PCI0LPC0EC0_VI
  3320: 44 4f 14 1d 5f 51 31 44 00 5c 2f 05 5f 53 42 5f  DO.._Q1D.\/._SB_
  3330: 50 43 49 30 4c 50 43 30 45 43 30 5f 50 43 4c 4b  PCI0LPC0EC0_PCLK
  3340: 14 1d 5f 51 31 45 00 5c 2f 05 5f 53 42 5f 50 43  .._Q1E.\/._SB_PC
  3350: 49 30 4c 50 43 30 45 43 30 5f 50 43 4c 4b 14 33  I0LPC0EC0_PCLK.3
  3360: 5f 51 32 32 00 70 0d 3d 3d 3d 3d 3d 51 55 45 52  _Q22.p.=====QUER
  3370: 59 5f 32 32 3d 3d 3d 3d 3d 00 5b 31 86 5c 2f 04  Y_22=====.[1.\/.
  3380: 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 41 54 31  _SB_PCI0LPC0BAT1
  3390: 0a 80 14 1c 5f 51 32 33 00 86 5c 2f 04 5f 53 42  ...._Q23..\/._SB
  33a0: 5f 50 43 49 30 4c 50 43 30 42 41 54 31 0a 80 14  _PCI0LPC0BAT1...
  33b0: 44 05 5f 51 32 35 00 70 0d 3d 3d 3d 3d 3d 51 55  D._Q25.p.=====QU
  33c0: 45 52 59 5f 32 35 3d 3d 3d 3d 3d 00 5b 31 5b 22  ERY_25=====.[1["
  33d0: 0b e8 03 86 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  33e0: 50 43 30 42 41 54 31 0a 81 5b 22 0b e8 03 86 5c  PC0BAT1..["....\
  33f0: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 41  /._SB_PCI0LPC0BA
  3400: 54 31 0a 80 14 4b 05 5f 51 33 37 00 70 0d 3d 3d  T1...K._Q37.p.==
  3410: 3d 3d 3d 51 55 45 52 59 5f 33 37 3d 3d 3d 3d 3d  ===QUERY_37=====
  3420: 00 5b 31 5c 2e 5f 53 42 5f 47 53 4d 49 0a 0d 86  .[1\._SB_GSMI...
  3430: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 41  \/._SB_PCI0LPC0A
  3440: 43 41 44 0a 00 5b 22 0b e8 03 86 5c 2f 04 5f 53  CAD..["....\/._S
  3450: 42 5f 50 43 49 30 4c 50 43 30 42 41 54 31 0a 80  B_PCI0LPC0BAT1..
  3460: 14 4b 05 5f 51 33 38 00 70 0d 3d 3d 3d 3d 3d 51  .K._Q38.p.=====Q
  3470: 55 45 52 59 5f 33 38 3d 3d 3d 3d 3d 00 5b 31 5c  UERY_38=====.[1\
  3480: 2e 5f 53 42 5f 47 53 4d 49 0a 0d 86 5c 2f 04 5f  ._SB_GSMI...\/._
  3490: 53 42 5f 50 43 49 30 4c 50 43 30 41 43 41 44 0a  SB_PCI0LPC0ACAD.
  34a0: 01 5b 22 0b e8 03 86 5c 2f 04 5f 53 42 5f 50 43  .["....\/._SB_PC
  34b0: 49 30 4c 50 43 30 42 41 54 31 0a 80 14 29 5f 51  I0LPC0BAT1...)_Q
  34c0: 34 32 00 70 0d 3d 3d 3d 3d 3d 51 55 45 52 59 5f  42.p.=====QUERY_
  34d0: 34 32 3d 3d 3d 3d 3d 00 5b 31 5c 2e 5f 53 42 5f  42=====.[1\._SB_
  34e0: 47 53 4d 49 0a 0a 14 3f 5f 51 36 30 00 70 0d 3d  GSMI...?_Q60.p.=
  34f0: 3d 3d 3d 3d 51 55 45 52 59 5f 36 30 3d 3d 3d 3d  ====QUERY_60====
  3500: 3d 00 5b 31 5c 2e 5f 53 42 5f 47 53 4d 49 0a 0b  =.[1\._SB_GSMI..
  3510: 86 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 43  .\/._SB_PCI0IDEC
  3520: 53 45 43 44 0a 01 5b 80 43 43 4c 4b 01 0b 10 10  SECD..[.CCLK....
  3530: 0a 04 5b 81 1b 43 43 4c 4b 03 00 01 44 55 54 59  ..[..CCLK...DUTY
  3540: 03 54 48 45 4e 01 00 03 00 09 54 53 54 53 01 5b  .THEN.....TSTS.[
  3550: 80 45 43 52 4d 03 0a 00 0a ff 5b 81 46 04 45 43  .ECRM.....[.F.EC
  3560: 52 4d 11 00 40 4a 45 52 49 42 10 45 52 42 44 08  RM..-gBAHVOeOpo6zXgU/A8SF6A@public.gmane.org
  3570: 00 48 0a 53 44 54 4d 08 46 53 53 4e 04 46 41 4e  .H.SDTM.FSSN.FAN
  3580: 55 04 50 54 56 4c 03 00 04 54 54 48 52 01 00 48  U.PTVL...TTHR..H
  3590: 06 50 4a 49 44 08 00 08 00 48 1d 52 46 52 44 08  .PJID....H.RFRD.
  35a0: 00 08 5b 01 46 41 4d 58 00 14 22 46 41 4e 47 01  ..[.FAMX.."FANG.
  35b0: 5b 23 46 41 4d 58 ff ff 70 68 45 52 49 42 70 45  [#FAMX..phERIBpE
  35c0: 52 42 44 60 5b 27 46 41 4d 58 a4 60 14 22 46 41  RBD`['FAMX.`."FA
  35d0: 4e 57 02 5b 23 46 41 4d 58 ff ff 70 69 45 52 42  NW.[#FAMX..piERB
  35e0: 44 70 68 45 52 49 42 5b 27 46 41 4d 58 a4 69 14  DphERIB['FAMX.i.
  35f0: 09 54 55 56 52 01 a4 0a 03 14 30 54 48 52 4f 01  .TUVR.....0THRO.
  3600: a0 0a 93 68 0a 00 a4 54 48 45 4e a1 1e a0 0a 93  ...h...THEN.....
  3610: 68 0a 01 a4 44 55 54 59 a1 11 a0 0a 93 68 0a 02  h...DUTY.....h..
  3620: a4 54 54 48 52 a1 04 a4 0a ff 14 45 04 50 43 4c  .TTHR......E.PCL
  3630: 4b 00 70 50 54 56 4c 60 a0 0c 93 60 0a 00 70 0a  K.pPTVL`...`..p.
  3640: 00 54 48 45 4e a1 2a 80 60 60 72 60 0a 01 60 7b  .THEN.*.``r`..`{
  3650: 60 0a 07 60 70 60 44 55 54 59 a0 0c 93 60 0a 00  `..`p`DUTY...`..
  3660: 70 0a 00 54 48 45 4e a1 08 70 0a 01 54 48 45 4e  p..THEN..p..THEN
  3670: 14 27 43 4c 43 4b 01 a0 0c 93 68 0a 00 70 0a 00  .'CLCK....h..p..
  3680: 54 48 45 4e a1 0e 70 68 44 55 54 59 70 0a 01 54  THEN..phDUTYp..T
  3690: 48 45 4e a4 54 48 45 4e 5b 82 4c 08 41 43 41 44  HEN.THEN[.L.ACAD
  36a0: 08 5f 48 49 44 0d 41 43 50 49 30 30 30 33 00 08  ._HID.ACPI0003..
  36b0: 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 14 49 06 5f  _PCL...\_SB_.I._
  36c0: 50 53 52 00 a0 4c 05 90 5c 2f 05 5f 53 42 5f 50  PSR..L..\/._SB_P
  36d0: 43 49 30 4c 50 43 30 45 43 30 5f 45 43 4f 4b 93  CI0LPC0EC0_ECOK.
  36e0: 45 43 44 59 0a 00 a0 1b 5c 2f 05 5f 53 42 5f 50  ECDY....\/._SB_P
  36f0: 43 49 30 4c 50 43 30 45 43 30 5f 42 54 43 48 a4  CI0LPC0EC0_BTCH.
  3700: 0a 01 a0 1b 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  3710: 50 43 30 45 43 30 5f 42 44 43 48 a4 0a 00 a4 0a  PC0EC0_BDCH.....
  3720: 01 a1 04 a4 0a 00 5b 82 42 38 42 41 54 31 08 5f  ......[.B8BAT1._
  3730: 48 49 44 0c 41 d0 0c 0a 08 5f 55 49 44 0a 01 08  HID.A...._UID...
  3740: 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 08 50 42 49  _PCL...\_SB_.PBI
  3750: 46 12 3b 0d 0a 01 0b a0 0f 0b a0 0f 0a 01 0b d0  F.;.............
  3760: 39 0b a4 01 0a 9c 0b 08 01 0b c4 0e 0d 4c 69 5f  9............Li_
  3770: 49 6f 6e 20 34 30 30 30 6d 41 20 00 0d 00 0d 4c  Ion 4000mA ....L
  3780: 69 4f 4e 00 0d 43 4f 4d 50 41 4c 20 00 14 43 06  iON..COMPAL ..C.
  3790: 5f 53 54 41 00 a0 42 05 90 45 43 4f 4b 93 45 43  _STA..B..ECOK.EC
  37a0: 44 59 0a 00 70 0d 3d 3d 20 4d 61 69 6e 20 42 61  DY..p.== Main Ba
  37b0: 74 74 65 72 79 20 5f 53 54 41 3d 3d 00 5b 31 a0  ttery _STA==.[1.
  37c0: 1f 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  37d0: 45 43 30 5f 42 41 4c 30 5b 22 0a 14 a4 0a 1f a1  EC0_BAL0["......
  37e0: 08 5b 22 0a 14 a4 0a 0f a1 08 5b 22 0a 14 a4 0a  .[".......["....
  37f0: 1f 14 45 18 5f 42 49 46 00 a0 48 17 90 45 43 4f  ..E._BIF..H..ECO
  3800: 4b 93 45 43 44 59 0a 00 70 0d 3d 3d 4d 61 69 6e  K.ECDY..p.==Main
  3810: 20 42 61 74 74 65 72 79 20 49 6e 66 6f 72 6d 61   Battery Informa
  3820: 74 69 6f 6e 20 5f 42 49 46 3d 3d 00 5b 31 5b 22  tion _BIF==.[1["
  3830: 0a 14 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  ..p\/._SB_PCI0LP
  3840: 43 30 45 43 30 5f 42 44 43 30 61 5b 22 0a 14 a0  C0EC0_BDC0a["...
  3850: 14 93 61 0b 66 08 70 0a dc 61 70 61 88 50 42 49  ..a.f.p..apa.PBI
  3860: 46 0a 06 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30  F...p\/._SB_PCI0
  3870: 4c 50 43 30 45 43 30 5f 42 4d 46 30 61 5b 22 0a  LPC0EC0_BMF0a[".
  3880: 14 a0 2d 93 61 0a 01 70 0d 47 43 38 36 35 30 38  ..-.a..p.GC86508
  3890: 53 41 54 30 20 00 88 50 42 49 46 0a 09 00 70 0d  SAT0 ..PBIF...p.
  38a0: 53 41 4e 59 4f 20 00 88 50 42 49 46 0a 0c 00 a1  SANYO ..PBIF....
  38b0: 42 0c a0 2c 93 61 0a 02 70 0d 47 43 38 36 35 30  B..,.a..p.GC8650
  38c0: 33 53 59 39 30 20 00 88 50 42 49 46 0a 09 00 70  3SY90 ..PBIF...p
  38d0: 0d 53 4f 4e 59 20 00 88 50 42 49 46 0a 0c 00 a1  .SONY ..PBIF....
  38e0: 42 09 a0 31 93 61 0a 04 70 0d 47 43 38 36 35 30  B..1.a..p.GC8650
  38f0: 33 50 41 47 30 20 00 88 50 42 49 46 0a 09 00 70  3PAG0 ..PBIF...p
  3900: 0d 50 41 4e 41 53 4f 4e 49 43 20 00 88 50 42 49  .PANASONIC ..PBI
  3910: 46 0a 0c 00 a1 4d 05 a0 2f 93 61 0a 05 70 0d 47  F....M../.a..p.G
  3920: 43 38 36 35 30 38 53 4d 36 30 20 00 88 50 42 49  C86508SM60 ..PBI
  3930: 46 0a 09 00 70 0d 53 41 4d 53 55 4e 47 20 00 88  F...p.SAMSUNG ..
  3940: 50 42 49 46 0a 0c 00 a1 2a 70 0d 42 43 4c 33 31  PBIF....*p.BCL31
  3950: 30 30 4c 69 4f 4e 20 00 88 50 42 49 46 0a 09 00  00LiON ..PBIF...
  3960: 70 0d 43 4f 4d 50 41 4c 20 00 88 50 42 49 46 0a  p.COMPAL ..PBIF.
  3970: 0c 00 a4 50 42 49 46 14 42 13 5f 42 53 54 00 70  ...PBIF.B._BST.p
  3980: 0d 3d 3d 4d 61 69 6e 20 42 61 74 74 65 72 79 20  .==Main Battery 
  3990: 53 74 61 74 75 73 20 5f 42 53 54 3d 3d 00 5b 31  Status _BST==.[1
  39a0: a0 23 94 45 43 44 59 0a 00 76 45 43 44 59 86 5c  .#.ECDY..vECDY.\
  39b0: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 41  /._SB_PCI0LPC0BA
  39c0: 54 31 0a 81 08 50 42 53 54 12 11 04 0a 00 0c ff  T1...PBST.......
  39d0: ff ff ff 0c ff ff ff ff 0b d0 39 70 0a 00 60 70  ..........9p..`p
  39e0: 0a 33 62 70 0b d0 39 63 a0 4e 08 90 45 43 4f 4b  .3bp..9c.N..ECOK
  39f0: 93 45 43 44 59 0a 00 a0 1c 5c 2f 05 5f 53 42 5f  .ECDY....\/._SB_
  3a00: 50 43 49 30 4c 50 43 30 45 43 30 5f 42 54 43 48  PCI0LPC0EC0_BTCH
  3a10: 70 0a 02 60 a1 05 70 0a 01 60 5b 22 0a 14 70 5c  p..`..p..`["..p\
  3a20: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  3a30: 30 5f 47 41 55 30 62 5b 22 0a 14 70 5c 2f 05 5f  0_GAU0b["..p\/._
  3a40: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 42  SB_PCI0LPC0EC0_B
  3a50: 50 56 30 63 5b 22 0a 14 a0 1e 5c 2f 04 5f 53 42  PV0c["....\/._SB
  3a60: 5f 50 43 49 30 4c 50 43 30 41 43 50 57 a0 09 93  _PCI0LPC0ACPW...
  3a70: 62 0a 64 70 0a 00 60 77 62 0a 28 62 70 60 88 50  b.dp..`wb.(bp`.P
  3a80: 42 53 54 0a 00 00 70 0a 00 88 50 42 53 54 0a 01  BST...p...PBST..
  3a90: 00 70 62 88 50 42 53 54 0a 02 00 70 63 88 50 42  .pb.PBST...pc.PB
  3aa0: 53 54 0a 03 00 a4 50 42 53 54 5b 82 46 1f 57 35  ST....PBST[.F.W5
  3ab0: 31 38 08 5f 48 49 44 0c 5c a3 05 18 5b 80 53 44  18._HID.\...[.SD
  3ac0: 49 4f 01 0a 4e 0a 02 5b 81 10 53 44 49 4f 01 57  IO..N..[..SDIO.W
  3ad0: 49 4e 44 08 57 44 41 54 08 5b 86 45 04 57 49 4e  IND.WDAT.[.E.WIN
  3ae0: 44 57 44 41 54 01 00 38 57 30 30 37 08 00 48 10  DWDAT..8W007..H.
  3af0: 57 30 32 39 08 00 30 57 30 33 30 08 00 48 17 57  W029..0W030..H.W
  3b00: 30 36 30 08 57 30 36 31 08 00 40 07 57 30 37 30  060.W061..-RA1qWS8Jogg@public.gmane.org
  3b10: 08 00 18 57 30 37 34 08 00 48 3d 57 30 46 30 08  ...W074..H=W0F0.
  3b20: 14 2b 45 4e 53 44 00 70 0a 83 57 49 4e 44 70 0a  .+ENSD.p..WINDp.
  3b30: 83 57 49 4e 44 a0 0d 93 0a 4e 0a 4e 70 0a 03 57  .WIND....N.Np..W
  3b40: 30 30 37 a1 08 70 0a 01 57 30 30 37 14 0d 45 58  007..p..W007..EX
  3b50: 53 44 00 70 0a aa 57 49 4e 44 14 2d 5f 53 54 41  SD.p..WIND.-_STA
  3b60: 00 45 4e 53 44 70 57 30 33 30 60 45 58 53 44 a0  .ENSDpW030`EXSD.
  3b70: 08 93 60 0a ff a4 0a 00 a1 0f a0 08 90 60 0a 01  ..`..........`..
  3b80: a4 0a 0f a1 04 a4 0a 0d 14 19 5f 44 49 53 00 45  .........._DIS.E
  3b90: 4e 53 44 7b 57 30 33 30 0a fe 57 30 33 30 45 58  NSD{W030..W030EX
  3ba0: 53 44 14 43 07 5f 43 52 53 00 08 49 43 52 53 11  SD.C._CRS..ICRS.
  3bb0: 10 0a 0d 47 01 48 02 48 02 08 08 22 40 00 79 00  ...G.H.H..."@.y.
  3bc0: 8b 49 43 52 53 0a 02 49 4d 49 4e 8b 49 43 52 53  .ICRS..IMIN.ICRS
  3bd0: 0a 04 49 4d 41 58 8b 49 43 52 53 0a 09 49 52 51  ..IMAX.ICRS..IRQ
  3be0: 30 45 4e 53 44 79 57 30 36 30 0a 08 60 7d 57 30  0ENSDyW060..`}W0
  3bf0: 36 31 60 49 4d 49 4e 70 49 4d 49 4e 49 4d 41 58  61`IMINpIMINIMAX
  3c00: 70 01 60 79 60 57 30 37 30 49 52 51 30 45 58 53  p.`y`W070IRQ0EXS
  3c10: 44 a4 49 43 52 53 08 5f 50 52 53 11 1e 0a 1b 30  D.ICRS._PRS....0
  3c20: 47 01 48 02 48 02 08 08 22 40 00 30 47 01 00 02  G.H.H..."@.0G...
  3c30: ff 02 08 08 22 40 0c 38 79 00 14 47 06 5f 53 52  ...."@.8y..G._SR
  3c40: 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68 0a 03 49 4f  S..h..IOLO.h..IO
  3c50: 48 49 8b 68 0a 09 49 52 51 30 45 4e 53 44 70 0a  HI.h..IRQ0ENSDp.
  3c60: 10 57 30 32 39 70 49 4f 48 49 57 30 36 30 70 49  .W029pIOHIW060pI
  3c70: 4f 4c 4f 57 30 36 31 82 49 52 51 30 60 74 60 0a  OLOW061.IRQ0`t`.
  3c80: 01 57 30 37 30 a0 0d 93 0a 4e 0a 4e 70 0a 02 57  .W070....N.Np..W
  3c90: 30 46 30 7d 57 30 33 30 0a 01 57 30 33 30 45 58  0F0}W030..W030EX
  3ca0: 53 44 08 4e 41 54 41 12 07 01 0c 01 00 1f 00 5b  SD.NATA........[
  3cb0: 82 4c fc 49 44 45 43 08 5f 41 44 52 0c 01 00 1f  .L.IDEC._ADR....
  3cc0: 00 5b 80 49 44 45 43 02 0a 40 0a 18 5b 81 4f 05  .[.IDEC..-rVxdn2TrCWA@public.gmane.org[.O.
  3cd0: 49 44 45 43 03 50 52 49 54 10 53 45 43 54 10 50  IDEC.PRIT.SECT.P
  3ce0: 53 49 54 04 53 53 49 54 04 00 18 53 59 4e 43 04  SIT.SSIT...SYNC.
  3cf0: 00 0c 53 44 54 30 02 00 02 53 44 54 31 02 00 02  ..SDT0...SDT1...
  3d00: 53 44 54 32 02 00 02 53 44 54 33 02 00 42 04 49  SDT2...SDT3..B.I
  3d10: 43 52 30 04 49 43 52 31 04 49 43 52 32 04 49 43  CR0.ICR1.ICR2.IC
  3d20: 52 33 04 49 43 52 34 04 49 43 52 35 04 5b 82 44  R3.ICR4.ICR5.[.D
  3d30: 6a 50 52 49 44 08 5f 41 44 52 0a 00 5b 80 48 44  jPRID._ADR..[.HD
  3d40: 49 4f 01 0b f0 01 0a 08 5b 81 1c 48 44 49 4f 01  IO......[..HDIO.
  3d50: 00 08 00 08 00 08 00 08 00 08 00 08 48 44 53 4c  ............HDSL
  3d60: 08 48 44 43 4d 08 14 49 14 5f 47 54 4d 00 08 50  .HDCM..I._GTM..P
  3d70: 42 55 46 11 17 0a 14 00 00 00 00 00 00 00 00 00  BUF.............
  3d80: 00 00 00 00 00 00 00 00 00 00 00 8a 50 42 55 46  ............PBUF
  3d90: 0a 00 50 49 4f 30 8a 50 42 55 46 0a 04 44 4d 41  ..PIO0.PBUF..DMA
  3da0: 30 8a 50 42 55 46 0a 08 50 49 4f 31 8a 50 42 55  0.PBUF..PIO1.PBU
  3db0: 46 0a 0c 44 4d 41 31 8a 50 42 55 46 0a 10 46 4c  F..DMA1.PBUF..FL
  3dc0: 41 47 70 47 45 54 50 50 52 49 54 50 49 4f 30 70  AGpGETPPRITPIO0p
  3dd0: 47 44 4d 41 7b 53 59 4e 43 0a 01 00 7b 49 43 52  GDMA{SYNC...{ICR
  3de0: 33 0a 01 00 7b 49 43 52 30 0a 01 00 53 44 54 30  3...{ICR0...SDT0
  3df0: 7b 49 43 52 31 0a 01 00 44 4d 41 30 a0 14 93 44  {ICR1...DMA0...D
  3e00: 4d 41 30 0c ff ff ff ff 70 50 49 4f 30 44 4d 41  MA0.....pPIO0DMA
  3e10: 30 a0 2e 7b 50 52 49 54 0b 00 40 00 a0 14 93 7b  0..{PRIT..-9D9NNryygCw@public.gmane.org{
  3e20: 50 52 49 54 0a 90 00 0a 80 70 0b 84 03 50 49 4f  PRIT.....p...PIO
  3e30: 31 a1 0e 70 47 45 54 54 50 53 49 54 50 49 4f 31  1..pGETTPSITPIO1
  3e40: a1 0b 70 0c ff ff ff ff 50 49 4f 31 70 47 44 4d  ..p.....PIO1pGDM
  3e50: 41 7b 53 59 4e 43 0a 02 00 7b 49 43 52 33 0a 02  A{SYNC...{ICR3..
  3e60: 00 7b 49 43 52 30 0a 02 00 53 44 54 31 7b 49 43  .{ICR0...SDT1{IC
  3e70: 52 31 0a 02 00 44 4d 41 31 a0 14 93 44 4d 41 31  R1...DMA1...DMA1
  3e80: 0c ff ff ff ff 70 50 49 4f 31 44 4d 41 31 70 47  .....pPIO1DMA1pG
  3e90: 45 54 46 7b 53 59 4e 43 0a 01 00 7b 53 59 4e 43  ETF{SYNC...{SYNC
  3ea0: 0a 02 00 50 52 49 54 46 4c 41 47 a4 50 42 55 46  ...PRITFLAG.PBUF
  3eb0: 14 41 2c 5f 53 54 4d 03 8a 68 0a 00 50 49 4f 30  .A,_STM..h..PIO0
  3ec0: 8a 68 0a 04 44 4d 41 30 8a 68 0a 08 50 49 4f 31  .h..DMA0.h..PIO1
  3ed0: 8a 68 0a 0c 44 4d 41 31 8a 68 0a 10 46 4c 41 47  .h..DMA1.h..FLAG
  3ee0: 70 0a 04 49 43 52 32 a0 47 12 93 87 69 0b 00 02  p..ICR2.G...i...
  3ef0: 7b 50 52 49 54 0b f0 40 50 52 49 54 7b 53 59 4e  {PRIT..-2Xuijrnunv4@public.gmane.org{SYN
  3f00: 43 0a 0e 53 59 4e 43 70 0a 00 53 44 54 30 7b 49  C..SYNCp..SDT0{I
  3f10: 43 52 30 0a 0e 49 43 52 30 7b 49 43 52 31 0a 0e  CR0..ICR0{ICR1..
  3f20: 49 43 52 31 7b 49 43 52 33 0a 0e 49 43 52 33 7b  ICR1{ICR3..ICR3{
  3f30: 49 43 52 35 0a 0e 49 43 52 35 8b 69 0a 62 57 34  ICR5..ICR5.i.bW4
  3f40: 39 30 8b 69 0a 6a 57 35 33 30 8b 69 0a 7e 57 36  90.i.jW530.i.~W6
  3f50: 33 30 8b 69 0a 80 57 36 34 30 8b 69 0a b0 57 38  30.i..W640.i..W8
  3f60: 38 30 8b 69 0a ba 57 39 33 30 7d 50 52 49 54 0b  80.i..W930}PRIT.
  3f70: 04 80 50 52 49 54 a0 1e 90 7b 46 4c 41 47 0a 02  ..PRIT...{FLAG..
  3f80: 00 7b 57 34 39 30 0b 00 08 00 7d 50 52 49 54 0a  .{W490....}PRIT.
  3f90: 02 50 52 49 54 7d 50 52 49 54 53 45 54 50 50 49  .PRIT}PRITSETPPI
  3fa0: 4f 30 57 35 33 30 57 36 34 30 50 52 49 54 a0 40  O0W530W640PRIT.@
  3fb0: 06 7b 46 4c 41 47 0a 01 00 7d 53 59 4e 43 0a 01  .{FLAG...}SYNC..
  3fc0: 53 59 4e 43 70 53 44 4d 41 44 4d 41 30 53 44 54  SYNCpSDMADMA0SDT
  3fd0: 30 a0 13 95 44 4d 41 30 0a 1e 7d 49 43 52 33 0a  0...DMA0..}ICR3.
  3fe0: 01 49 43 52 33 a0 13 95 44 4d 41 30 0a 3c 7d 49  .ICR3...DMA0.<}I
  3ff0: 43 52 30 0a 01 49 43 52 30 a0 15 7b 57 39 33 30  CR0..ICR0..{W930
  4000: 0b 00 20 00 7d 49 43 52 31 0a 01 49 43 52 31 a0  .. .}ICR1..ICR1.
  4010: 42 16 93 87 6a 0b 00 02 7b 50 52 49 54 0b 0f 3f  B...j...{PRIT..?
  4020: 50 52 49 54 70 0a 00 50 53 49 54 7b 53 59 4e 43  PRITp..PSIT{SYNC
  4030: 0a 0d 53 59 4e 43 70 0a 00 53 44 54 31 7b 49 43  ..SYNCp..SDT1{IC
  4040: 52 30 0a 0d 49 43 52 30 7b 49 43 52 31 0a 0d 49  R0..ICR0{ICR1..I
  4050: 43 52 31 7b 49 43 52 33 0a 0d 49 43 52 33 7b 49  CR1{ICR3..ICR3{I
  4060: 43 52 35 0a 0d 49 43 52 35 8b 6a 0a 62 57 34 39  CR5..ICR5.j.bW49
  4070: 31 8b 6a 0a 6a 57 35 33 31 8b 6a 0a 7e 57 36 33  1.j.jW531.j.~W63
  4080: 31 8b 6a 0a 80 57 36 34 31 8b 6a 0a b0 57 38 38  1.j..W641.j..W88
  4090: 31 8b 6a 0a ba 57 39 33 31 7d 50 52 49 54 0b 40  1.j..W931}PRIT.@
  40a0: 80 50 52 49 54 a0 1e 90 7b 46 4c 41 47 0a 08 00  .PRIT...{FLAG...
  40b0: 7b 57 34 39 31 0b 00 08 00 7d 50 52 49 54 0a 20  {W491....}PRIT. 
  40c0: 50 52 49 54 a0 4c 04 7b 46 4c 41 47 0a 10 00 7d  PRIT.L.{FLAG...}
  40d0: 50 52 49 54 0b 00 40 50 52 49 54 a0 13 94 50 49  PRIT..-R3FBB1wyRtNVBBxDL7pS9w@public.gmane.org
  40e0: 4f 31 0a f0 7d 50 52 49 54 0a 80 50 52 49 54 a1  O1..}PRIT..PRIT.
  40f0: 21 7d 50 52 49 54 0a 10 50 52 49 54 70 53 45 54  !}PRIT..PRITpSET
  4100: 54 50 49 4f 31 57 35 33 31 57 36 34 31 50 53 49  TPIO1W531W641PSI
  4110: 54 a0 40 06 7b 46 4c 41 47 0a 04 00 7d 53 59 4e  T.-4b8TPpkIZ3Q@public.gmane.org{FLAG...}SYN
  4120: 43 0a 02 53 59 4e 43 70 53 44 4d 41 44 4d 41 31  C..SYNCpSDMADMA1
  4130: 53 44 54 31 a0 13 95 44 4d 41 30 0a 1e 7d 49 43  SDT1...DMA0..}IC
  4140: 52 33 0a 02 49 43 52 33 a0 13 95 44 4d 41 30 0a  R3..ICR3...DMA0.
  4150: 3c 7d 49 43 52 30 0a 02 49 43 52 30 a0 15 7b 57  <}ICR0..ICR0..{W
  4160: 39 33 31 0b 00 20 00 7d 49 43 52 31 0a 02 49 43  931.. .}ICR1..IC
  4170: 52 31 5b 82 46 14 50 5f 44 30 08 5f 41 44 52 0a  R1[.F.P_D0._ADR.
  4180: 00 14 40 10 5f 47 54 46 00 08 50 49 42 30 11 11  ..-CGOz1Ppph0hkhyuVvDCdkg@public.gmane.org
  4190: 0a 0e 03 00 00 00 00 a0 ef 03 00 00 00 00 a0 ef  ................
  41a0: 8c 50 49 42 30 0a 01 50 4d 44 30 8c 50 49 42 30  .PIB0..PMD0.PIB0
  41b0: 0a 08 44 4d 44 30 a0 40 06 7b 50 52 49 54 0a 02  ..DMD0.-4b8TPpkIZ3Q@public.gmane.org{PRIT..
  41c0: 00 a0 13 93 7b 50 52 49 54 0a 09 00 0a 08 70 0a  ....{PRIT.....p.
  41d0: 08 50 4d 44 30 a1 41 04 70 0a 0a 50 4d 44 30 7a  .PMD0.A.p..PMD0z
  41e0: 7b 50 52 49 54 0b 00 03 00 0a 08 60 7a 7b 50 52  {PRIT......`z{PR
  41f0: 49 54 0b 00 30 00 0a 0c 61 72 60 61 62 a0 0c 93  IT..0...ar`ab...
  4200: 0a 03 62 70 0a 0b 50 4d 44 30 a0 0c 93 0a 05 62  ..bp..PMD0.....b
  4210: 70 0a 0c 50 4d 44 30 a1 08 70 0a 01 50 4d 44 30  p..PMD0..p..PMD0
  4220: a0 47 04 7b 53 59 4e 43 0a 01 00 70 7d 53 44 54  .G.{SYNC...p}SDT
  4230: 30 0a 40 00 44 4d 44 30 a0 2f 7b 49 43 52 31 0a  0.-Bp4WBFZxkXI@public.gmane.org/{ICR1.
  4240: 01 00 a0 14 7b 49 43 52 30 0a 01 00 72 44 4d 44  ....{ICR0...rDMD
  4250: 30 0a 02 44 4d 44 30 a0 10 7b 49 43 52 33 0a 01  0..DMD0..{ICR3..
  4260: 00 70 0a 45 44 4d 44 30 a1 14 7d 74 7b 50 4d 44  .p.EDMD0..}t{PMD
  4270: 30 0a 07 00 0a 02 00 0a 20 44 4d 44 30 a4 50 49  0....... DMD0.PI
  4280: 42 30 08 5f 50 53 43 0a 00 14 22 5f 50 53 30 00  B0._PSC..."_PS0.
  4290: 70 0a a0 48 44 53 4c a2 0d 7b 48 44 43 4d 0a 80  p..HDSL..{HDCM..
  42a0: 00 5b 22 0a 05 70 0a 00 5f 50 53 43 14 0d 5f 50  .["..p.._PSC.._P
  42b0: 53 33 00 70 0a 03 5f 50 53 43 5b 82 49 10 50 5f  S3.p.._PSC[.I.P_
  42c0: 44 31 08 5f 41 44 52 0a 01 14 4b 0f 5f 47 54 46  D1._ADR...K._GTF
  42d0: 00 08 50 49 42 31 11 11 0a 0e 03 00 00 00 00 b0  ..PIB1..........
  42e0: ef 03 00 00 00 00 b0 ef 8c 50 49 42 31 0a 01 50  .........PIB1..P
  42f0: 4d 44 31 8c 50 49 42 31 0a 08 44 4d 44 31 a0 4b  MD1.PIB1..DMD1.K
  4300: 05 7b 50 52 49 54 0a 20 00 a0 13 93 7b 50 52 49  .{PRIT. ....{PRI
  4310: 54 0a 90 00 0a 80 70 0a 08 50 4d 44 31 a1 3c 72  T.....p..PMD1.<r
  4320: 7b 50 53 49 54 0a 03 00 7a 7b 50 53 49 54 0a 0c  {PSIT...z{PSIT..
  4330: 00 0a 02 00 60 a0 0c 93 0a 05 60 70 0a 0c 50 4d  ....`.....`p..PM
  4340: 44 31 a1 17 a0 0c 93 0a 03 60 70 0a 0b 50 4d 44  D1.......`p..PMD
  4350: 31 a1 08 70 0a 0a 50 4d 44 31 a1 08 70 0a 01 50  1..p..PMD1..p..P
  4360: 4d 44 31 a0 47 04 7b 53 59 4e 43 0a 02 00 70 7d  MD1.G.{SYNC...p}
  4370: 53 44 54 31 0a 40 00 44 4d 44 31 a0 2f 7b 49 43  SDT1.-cDEJmm6HT9M@public.gmane.org/{IC
  4380: 52 31 0a 02 00 a0 14 7b 49 43 52 30 0a 02 00 72  R1.....{ICR0...r
  4390: 44 4d 44 31 0a 02 44 4d 44 31 a0 10 7b 49 43 52  DMD1..DMD1..{ICR
  43a0: 33 0a 02 00 70 0a 45 44 4d 44 31 a1 14 7d 74 7b  3...p.EDMD1..}t{
  43b0: 50 4d 44 31 0a 07 00 0a 02 00 0a 20 44 4d 44 31  PMD1....... DMD1
  43c0: a4 50 49 42 31 14 06 5f 50 53 30 00 14 06 5f 50  .PIB1.._PS0..._P
  43d0: 53 33 00 5b 82 4d 6f 53 45 43 44 08 5f 41 44 52  S3.[.MoSECD._ADR
  43e0: 0a 01 14 49 14 5f 47 54 4d 00 08 53 42 55 46 11  ...I._GTM..SBUF.
  43f0: 17 0a 14 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  4400: 00 00 00 00 00 00 00 8a 53 42 55 46 0a 00 50 49  ........SBUF..PI
  4410: 4f 30 8a 53 42 55 46 0a 04 44 4d 41 30 8a 53 42  O0.SBUF..DMA0.SB
  4420: 55 46 0a 08 50 49 4f 31 8a 53 42 55 46 0a 0c 44  UF..PIO1.SBUF..D
  4430: 4d 41 31 8a 53 42 55 46 0a 10 46 4c 41 47 70 47  MA1.SBUF..FLAGpG
  4440: 45 54 50 53 45 43 54 50 49 4f 30 70 47 44 4d 41  ETPSECTPIO0pGDMA
  4450: 7b 53 59 4e 43 0a 04 00 7b 49 43 52 33 0a 04 00  {SYNC...{ICR3...
  4460: 7b 49 43 52 30 0a 04 00 53 44 54 32 7b 49 43 52  {ICR0...SDT2{ICR
  4470: 31 0a 04 00 44 4d 41 30 a0 14 93 44 4d 41 30 0c  1...DMA0...DMA0.
  4480: ff ff ff ff 70 50 49 4f 30 44 4d 41 30 a0 2e 7b  ....pPIO0DMA0..{
  4490: 53 45 43 54 0b 00 40 00 a0 14 93 7b 53 45 43 54  SECT..-9D9NNryygCw@public.gmane.org{SECT
  44a0: 0a 90 00 0a 80 70 0b 84 03 50 49 4f 31 a1 0e 70  .....p...PIO1..p
  44b0: 47 45 54 54 53 53 49 54 50 49 4f 31 a1 0b 70 0c  GETTSSITPIO1..p.
  44c0: ff ff ff ff 50 49 4f 31 70 47 44 4d 41 7b 53 59  ....PIO1pGDMA{SY
  44d0: 4e 43 0a 08 00 7b 49 43 52 33 0a 08 00 7b 49 43  NC...{ICR3...{IC
  44e0: 52 30 0a 08 00 53 44 54 33 7b 49 43 52 31 0a 08  R0...SDT3{ICR1..
  44f0: 00 44 4d 41 31 a0 14 93 44 4d 41 31 0c ff ff ff  .DMA1...DMA1....
  4500: ff 70 50 49 4f 31 44 4d 41 31 70 47 45 54 46 7b  .pPIO1DMA1pGETF{
  4510: 53 59 4e 43 0a 04 00 7b 53 59 4e 43 0a 08 00 53  SYNC...{SYNC...S
  4520: 45 43 54 46 4c 41 47 a4 53 42 55 46 14 41 2c 5f  ECTFLAG.SBUF.A,_
  4530: 53 54 4d 03 8a 68 0a 00 50 49 4f 30 8a 68 0a 04  STM..h..PIO0.h..
  4540: 44 4d 41 30 8a 68 0a 08 50 49 4f 31 8a 68 0a 0c  DMA0.h..PIO1.h..
  4550: 44 4d 41 31 8a 68 0a 10 46 4c 41 47 70 0a 04 49  DMA1.h..FLAGp..I
  4560: 43 52 32 a0 47 12 93 87 69 0b 00 02 7b 53 45 43  CR2.G...i...{SEC
  4570: 54 0b f0 40 53 45 43 54 7b 53 59 4e 43 0a 0b 53  T..-rEp6QHzXslU@public.gmane.org{SYNC..S
  4580: 59 4e 43 70 0a 00 53 44 54 32 7b 49 43 52 30 0a  YNCp..SDT2{ICR0.
  4590: 0b 49 43 52 30 7b 49 43 52 31 0a 0b 49 43 52 31  .ICR0{ICR1..ICR1
  45a0: 7b 49 43 52 33 0a 0b 49 43 52 33 7b 49 43 52 35  {ICR3..ICR3{ICR5
  45b0: 0a 0b 49 43 52 35 8b 69 0a 62 57 34 39 30 8b 69  ..ICR5.i.bW490.i
  45c0: 0a 6a 57 35 33 30 8b 69 0a 7e 57 36 33 30 8b 69  .jW530.i.~W630.i
  45d0: 0a 80 57 36 34 30 8b 69 0a b0 57 38 38 30 8b 69  ..W640.i..W880.i
  45e0: 0a ba 57 39 33 30 7d 53 45 43 54 0b 04 80 53 45  ..W930}SECT...SE
  45f0: 43 54 a0 1e 90 7b 46 4c 41 47 0a 02 00 7b 57 34  CT...{FLAG...{W4
  4600: 39 30 0b 00 08 00 7d 53 45 43 54 0a 02 53 45 43  90....}SECT..SEC
  4610: 54 7d 53 45 43 54 53 45 54 50 50 49 4f 30 57 35  T}SECTSETPPIO0W5
  4620: 33 30 57 36 34 30 53 45 43 54 a0 40 06 7b 46 4c  30W640SECT.-4b8TPpkIZ3Q@public.gmane.org{FL
  4630: 41 47 0a 01 00 7d 53 59 4e 43 0a 04 53 59 4e 43  AG...}SYNC..SYNC
  4640: 70 53 44 4d 41 44 4d 41 30 53 44 54 32 a0 13 95  pSDMADMA0SDT2...
  4650: 44 4d 41 30 0a 1e 7d 49 43 52 33 0a 04 49 43 52  DMA0..}ICR3..ICR
  4660: 33 a0 13 95 44 4d 41 30 0a 3c 7d 49 43 52 30 0a  3...DMA0.<}ICR0.
  4670: 04 49 43 52 30 a0 15 7b 57 39 33 30 0b 00 20 00  .ICR0..{W930.. .
  4680: 7d 49 43 52 31 0a 04 49 43 52 31 a0 42 16 93 87  }ICR1..ICR1.B...
  4690: 6a 0b 00 02 7b 53 45 43 54 0b 0f 3f 53 45 43 54  j...{SECT..?SECT
  46a0: 70 0a 00 53 53 49 54 7b 53 59 4e 43 0a 07 53 59  p..SSIT{SYNC..SY
  46b0: 4e 43 70 0a 00 53 44 54 33 7b 49 43 52 30 0a 07  NCp..SDT3{ICR0..
  46c0: 49 43 52 30 7b 49 43 52 31 0a 07 49 43 52 31 7b  ICR0{ICR1..ICR1{
  46d0: 49 43 52 33 0a 07 49 43 52 33 7b 49 43 52 35 0a  ICR3..ICR3{ICR5.
  46e0: 07 49 43 52 35 8b 6a 0a 62 57 34 39 31 8b 6a 0a  .ICR5.j.bW491.j.
  46f0: 6a 57 35 33 31 8b 6a 0a 7e 57 36 33 31 8b 6a 0a  jW531.j.~W631.j.
  4700: 80 57 36 34 31 8b 6a 0a b0 57 38 38 31 8b 6a 0a  .W641.j..W881.j.
  4710: ba 57 39 33 31 7d 53 45 43 54 0b 40 80 53 45 43  .W931}SECT.-v8PaNyJhlOA@public.gmane.org
  4720: 54 a0 1e 90 7b 46 4c 41 47 0a 08 00 7b 57 34 39  T...{FLAG...{W49
  4730: 31 0b 00 08 00 7d 53 45 43 54 0a 20 53 45 43 54  1....}SECT. SECT
  4740: a0 4c 04 7b 46 4c 41 47 0a 10 00 7d 53 45 43 54  .L.{FLAG...}SECT
  4750: 0b 00 40 53 45 43 54 a0 13 94 50 49 4f 31 0a f0  ..-9D9euU5CxHEUcNwqLg151g@public.gmane.org
  4760: 7d 53 45 43 54 0a 80 53 45 43 54 a1 21 7d 53 45  }SECT..SECT.!}SE
  4770: 43 54 0a 10 53 45 43 54 70 53 45 54 54 50 49 4f  CT..SECTpSETTPIO
  4780: 31 57 35 33 31 57 36 34 31 53 53 49 54 a0 40 06  1W531W641SSIT.-4b8TPpkIZ3Q@public.gmane.org
  4790: 7b 46 4c 41 47 0a 04 00 7d 53 59 4e 43 0a 08 53  {FLAG...}SYNC..S
  47a0: 59 4e 43 70 53 44 4d 41 44 4d 41 31 53 44 54 33  YNCpSDMADMA1SDT3
  47b0: a0 13 95 44 4d 41 30 0a 1e 7d 49 43 52 33 0a 08  ...DMA0..}ICR3..
  47c0: 49 43 52 33 a0 13 95 44 4d 41 30 0a 3c 7d 49 43  ICR3...DMA0.<}IC
  47d0: 52 30 0a 08 49 43 52 30 a0 15 7b 57 39 33 31 0b  R0..ICR0..{W931.
  47e0: 00 20 00 7d 49 43 52 31 0a 08 49 43 52 31 5b 82  . .}ICR1..ICR1[.
  47f0: 4a 19 53 5f 44 30 08 5f 41 44 52 0a 00 14 40 10  J.S_D0._ADR...-4b8TPpkIZ3Q@public.gmane.org
  4800: 5f 47 54 46 00 08 53 49 42 30 11 11 0a 0e 03 00  _GTF..SIB0......
  4810: 00 00 00 a0 ef 03 00 00 00 00 a0 ef 8c 53 49 42  .............SIB
  4820: 30 0a 01 50 4d 44 30 8c 53 49 42 30 0a 08 44 4d  0..PMD0.SIB0..DM
  4830: 44 30 a0 40 06 7b 53 45 43 54 0a 02 00 a0 13 93  D0.-4b8TPpkIZ3Q@public.gmane.org{SECT......
  4840: 7b 53 45 43 54 0a 09 00 0a 08 70 0a 08 50 4d 44  {SECT.....p..PMD
  4850: 30 a1 41 04 70 0a 0a 50 4d 44 30 7a 7b 53 45 43  0.A.p..PMD0z{SEC
  4860: 54 0b 00 03 00 0a 08 60 7a 7b 53 45 43 54 0b 00  T......`z{SECT..
  4870: 30 00 0a 0c 61 72 60 61 62 a0 0c 93 0a 03 62 70  0...ar`ab.....bp
  4880: 0a 0b 50 4d 44 30 a0 0c 93 0a 05 62 70 0a 0c 50  ..PMD0.....bp..P
  4890: 4d 44 30 a1 08 70 0a 01 50 4d 44 30 a0 47 04 7b  MD0..p..PMD0.G.{
  48a0: 53 59 4e 43 0a 04 00 70 7d 53 44 54 32 0a 40 00  SYNC...p}SDT2.-4b8TPpkIZ3Q@public.gmane.org
  48b0: 44 4d 44 30 a0 2f 7b 49 43 52 31 0a 04 00 a0 14  DMD0./{ICR1.....
  48c0: 7b 49 43 52 30 0a 04 00 72 44 4d 44 30 0a 02 44  {ICR0...rDMD0..D
  48d0: 4d 44 30 a0 10 7b 49 43 52 33 0a 04 00 70 0a 45  MD0..{ICR3...p.E
  48e0: 44 4d 44 30 a1 14 7d 74 7b 50 4d 44 30 0a 07 00  DMD0..}t{PMD0...
  48f0: 0a 02 00 0a 20 44 4d 44 30 a4 53 49 42 30 14 26  .... DMD0.SIB0.&
  4900: 5f 53 54 41 00 a0 1a 93 5c 2f 04 5f 53 42 5f 50  _STA....\/._SB_P
  4910: 43 49 30 4c 50 43 30 53 50 57 52 0a 00 a4 0a 0d  CI0LPC0SPWR.....
  4920: a1 04 a4 0a 0f 14 06 5f 4c 43 4b 01 14 46 05 5f  ......._LCK..F._
  4930: 45 4a 30 01 7b 53 45 43 54 0b dd ff 53 45 43 54  EJ0.{SECT...SECT
  4940: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  4950: 43 30 53 52 53 54 5b 22 0a 1e 7d 7b 49 43 52 34  C0SRST["..}{ICR4
  4960: 0a 03 00 0a 04 49 43 52 34 5b 22 0a 1e 70 0a 00  .....ICR4["..p..
  4970: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 53  \/._SB_PCI0LPC0S
  4980: 50 57 52 08 5f 52 4d 56 0a 01 5b 82 49 10 53 5f  PWR._RMV..[.I.S_
  4990: 44 31 08 5f 41 44 52 0a 01 14 4b 0f 5f 47 54 46  D1._ADR...K._GTF
  49a0: 00 08 53 49 42 31 11 11 0a 0e 03 00 00 00 00 b0  ..SIB1..........
  49b0: ef 03 00 00 00 00 b0 ef 8c 53 49 42 31 0a 01 50  .........SIB1..P
  49c0: 4d 44 31 8c 53 49 42 31 0a 08 44 4d 44 31 a0 4b  MD1.SIB1..DMD1.K
  49d0: 05 7b 53 45 43 54 0a 20 00 a0 13 93 7b 53 45 43  .{SECT. ....{SEC
  49e0: 54 0a 90 00 0a 80 70 0a 08 50 4d 44 31 a1 3c 72  T.....p..PMD1.<r
  49f0: 7b 53 53 49 54 0a 03 00 7a 7b 53 53 49 54 0a 0c  {SSIT...z{SSIT..
  4a00: 00 0a 02 00 60 a0 0c 93 0a 05 60 70 0a 0c 50 4d  ....`.....`p..PM
  4a10: 44 31 a1 17 a0 0c 93 0a 03 60 70 0a 0b 50 4d 44  D1.......`p..PMD
  4a20: 31 a1 08 70 0a 0a 50 4d 44 31 a1 08 70 0a 01 50  1..p..PMD1..p..P
  4a30: 4d 44 31 a0 47 04 7b 53 59 4e 43 0a 08 00 70 7d  MD1.G.{SYNC...p}
  4a40: 53 44 54 33 0a 40 00 44 4d 44 31 a0 2f 7b 49 43  SDT3.-cDEJmm6HT9M@public.gmane.org/{IC
  4a50: 52 31 0a 08 00 a0 14 7b 49 43 52 30 0a 08 00 72  R1.....{ICR0...r
  4a60: 44 4d 44 31 0a 02 44 4d 44 31 a0 10 7b 49 43 52  DMD1..DMD1..{ICR
  4a70: 33 0a 08 00 70 0a 45 44 4d 44 31 a1 14 7d 74 7b  3...p.EDMD1..}t{
  4a80: 50 4d 44 31 0a 07 00 0a 02 00 0a 20 44 4d 44 31  PMD1....... DMD1
  4a90: a4 53 49 42 31 08 5f 50 53 43 0a 00 14 18 5f 50  .SIB1._PSC...._P
  4aa0: 53 30 00 70 0a 00 5f 50 53 43 7b 49 43 52 34 0a  S0.p.._PSC{ICR4.
  4ab0: 03 49 43 52 34 14 1c 5f 50 53 33 00 70 0a 03 5f  .ICR4.._PS3.p.._
  4ac0: 50 53 43 7d 7b 49 43 52 34 0a 03 00 0a 04 49 43  PSC}{ICR4.....IC
  4ad0: 52 34 14 46 04 47 45 54 50 09 a0 0f 93 7b 68 0a  R4.F.GETP....{h.
  4ae0: 09 00 0a 00 a4 0c ff ff ff ff a0 0d 93 7b 68 0a  .............{h.
  4af0: 09 00 0a 08 a4 0b 84 03 7a 7b 68 0b 00 03 00 0a  ........z{h.....
  4b00: 08 60 7a 7b 68 0b 00 30 00 0a 0c 61 a4 77 0a 1e  .`z{h..0...a.w..
  4b10: 74 0a 09 72 60 61 00 00 00 14 30 47 44 4d 41 0d  t..r`a....0GDMA.
  4b20: a0 23 68 a0 07 90 69 6c a4 0a 14 a0 0e 90 6a 6c  .#h...il......jl
  4b30: a4 77 74 0a 04 6b 00 0a 0f 00 a4 77 74 0a 04 6b  .wt..k.....wt..k
  4b40: 00 0a 1e 00 a4 0c ff ff ff ff 14 1f 47 45 54 54  ............GETT
  4b50: 09 a4 77 0a 1e 74 0a 09 72 7b 7a 68 0a 02 00 0a  ..w..t..r{zh....
  4b60: 03 00 7b 68 0a 03 00 00 00 00 14 46 06 47 45 54  ..{h.......F.GET
  4b70: 46 0b 08 54 4d 50 46 0a 00 a0 0d 68 7d 54 4d 50  F..TMPF....h}TMP
  4b80: 46 0a 01 54 4d 50 46 a0 11 7b 6a 0a 02 00 7d 54  F..TMPF..{j...}T
  4b90: 4d 50 46 0a 02 54 4d 50 46 a0 0d 69 7d 54 4d 50  MPF..TMPF..i}TMP
  4ba0: 46 0a 04 54 4d 50 46 a0 11 7b 6a 0a 20 00 7d 54  F..TMPF..{j. .}T
  4bb0: 4d 50 46 0a 08 54 4d 50 46 a0 12 7b 6a 0b 00 40  MPF..TMPF..{j..@
  4bc0: 00 7d 54 4d 50 46 0a 10 54 4d 50 46 a4 54 4d 50  .}TMPF..TMPF.TMP
  4bd0: 46 14 3e 53 45 54 50 0b a0 08 94 68 0a f0 a4 0a  F.>SETP....h....
  4be0: 08 a1 2e a0 28 7b 69 0a 02 00 a0 10 90 92 94 68  ....({i........h
  4bf0: 0a 78 7b 6a 0a 02 00 a4 0b 01 23 a0 10 90 92 94  .x{j......#.....
  4c00: 68 0a b4 7b 6a 0a 01 00 a4 0b 01 21 a4 0b 01 10  h..{j......!....
  4c10: 14 3b 53 44 4d 41 09 a0 09 92 94 68 0a 14 a4 0a  .;SDMA.....h....
  4c20: 01 a0 09 92 94 68 0a 1e a4 0a 02 a0 09 92 94 68  .....h.........h
  4c30: 0a 2d a4 0a 01 a0 09 92 94 68 0a 3c a4 0a 02 a0  .-.......h.<....
  4c40: 09 92 94 68 0a 5a a4 0a 01 a4 0a 00 14 30 53 45  ...h.Z.......0SE
  4c50: 54 54 0b a0 26 7b 69 0a 02 00 a0 0f 90 92 94 68  TT..&{i........h
  4c60: 0a 78 7b 6a 0a 02 00 a4 0a 0b a0 0f 90 92 94 68  .x{j...........h
  4c70: 0a b4 7b 6a 0a 01 00 a4 0a 09 a4 0a 04 5b 82 4c  ..{j.........[.L
  4c80: 06 55 53 42 31 08 5f 41 44 52 0c 00 00 1d 00 5b  .USB1._ADR.....[
  4c90: 80 55 53 42 4f 02 0a c4 0a 04 5b 81 0b 55 53 42  .USBO.....[..USB
  4ca0: 4f 13 52 53 45 4e 02 08 5f 50 52 57 12 06 02 0a  O.RSEN.._PRW....
  4cb0: 03 0a 03 14 19 5f 50 53 57 01 a0 09 68 70 0a 03  ....._PSW...hp..
  4cc0: 52 53 45 4e a1 08 70 0a 00 52 53 45 4e 14 09 5f  RSEN..p..RSEN.._
  4cd0: 53 31 44 00 a4 0a 02 14 09 5f 53 33 44 00 a4 0a  S1D......_S3D...
  4ce0: 02 14 09 5f 53 34 44 00 a4 0a 02 5b 82 4c 06 55  ..._S4D....[.L.U
  4cf0: 53 42 32 08 5f 41 44 52 0c 01 00 1d 00 5b 80 55  SB2._ADR.....[.U
  4d00: 53 42 4f 02 0a c4 0a 04 5b 81 0b 55 53 42 4f 13  SBO.....[..USBO.
  4d10: 52 53 45 4e 02 08 5f 50 52 57 12 06 02 0a 04 0a  RSEN.._PRW......
  4d20: 03 14 19 5f 50 53 57 01 a0 09 68 70 0a 03 52 53  ..._PSW...hp..RS
  4d30: 45 4e a1 08 70 0a 00 52 53 45 4e 14 09 5f 53 31  EN..p..RSEN.._S1
  4d40: 44 00 a4 0a 02 14 09 5f 53 33 44 00 a4 0a 02 14  D......_S3D.....
  4d50: 09 5f 53 34 44 00 a4 0a 02 5b 82 4c 06 55 53 42  ._S4D....[.L.USB
  4d60: 33 08 5f 41 44 52 0c 02 00 1d 00 5b 80 55 53 42  3._ADR.....[.USB
  4d70: 4f 02 0a c4 0a 04 5b 81 0b 55 53 42 4f 13 52 53  O.....[..USBO.RS
  4d80: 45 4e 02 08 5f 50 52 57 12 06 02 0a 0c 0a 03 14  EN.._PRW........
  4d90: 19 5f 50 53 57 01 a0 09 68 70 0a 03 52 53 45 4e  ._PSW...hp..RSEN
  4da0: a1 08 70 0a 00 52 53 45 4e 14 09 5f 53 31 44 00  ..p..RSEN.._S1D.
  4db0: a4 0a 02 14 09 5f 53 33 44 00 a4 0a 02 14 09 5f  ....._S3D......_
  4dc0: 53 34 44 00 a4 0a 02 5b 82 30 45 55 53 42 08 5f  S4D....[.0EUSB._
  4dd0: 41 44 52 0c 07 00 1d 00 08 5f 53 31 44 0a 02 08  ADR......_S1D...
  4de0: 5f 53 33 44 0a 02 08 5f 53 34 44 0a 02 08 5f 50  _S3D..._S4D..._P
  4df0: 52 57 12 06 02 0a 0d 0a 03 5b 82 0f 53 4d 42 53  RW.......[..SMBS
  4e00: 08 5f 41 44 52 0c 03 00 1f 00 5b 82 2d 41 55 44  ._ADR.....[.-AUD
  4e10: 49 08 5f 41 44 52 0c 05 00 1f 00 14 09 5f 53 31  I._ADR......._S1
  4e20: 44 00 a4 0a 02 14 09 5f 53 33 44 00 a4 0a 02 14  D......_S3D.....
  4e30: 09 5f 53 34 44 00 a4 0a 02 5b 82 4f 04 4d 4f 44  ._S4D....[.O.MOD
  4e40: 4d 08 5f 41 44 52 0c 06 00 1f 00 08 5f 50 52 57  M._ADR......_PRW
  4e50: 12 06 02 0a 05 0a 03 5b 80 4d 44 49 53 02 0a 00  .......[.MDIS...
  4e60: 0a 04 5b 81 0b 4d 44 49 53 03 4d 44 49 44 20 14  ..[..MDIS.MDID .
  4e70: 1a 5f 53 54 41 00 a0 0e 93 4d 44 49 44 0c ff ff  ._STA....MDID...
  4e80: ff ff a4 0a 00 a1 04 a4 0a 0f                    ..........

FACS @ 0x1fffffc0
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

BOOT @ 0x1ffffb90
  0000: 42 4f 4f 54 28 00 00 00 01 cc 49 4e 53 59 44 45  BOOT(.....INSYDE
  0010: 53 59 53 5f 42 4f 4f 54 00 01 00 00 5f 43 53 49  SYS_BOOT...._CSI
  0020: 01 01 01 00 37 00 00 00                          ....7...

DBGP @ 0x1ffffbc0
  0000: 44 42 47 50 34 00 00 00 01 90 49 4e 53 59 44 45  DBGP4.....INSYDE
  0010: 44 42 47 50 5f 30 30 30 00 01 00 00 5f 43 53 49  DBGP_000...._CSI
  0020: 01 01 01 00 00 00 00 00 01 08 00 00 f8 03 00 00  ................
  0030: 00 00 00 00                                      ....

SSDT @ 0x1fffa830
  0000: 53 53 44 54 92 01 00 00 01 7f 49 4e 53 59 44 45  SSDT......INSYDE
  0010: 47 56 33 52 65 66 00 00 00 20 00 00 49 4e 54 4c  GV3Ref... ..INTL
  0020: 02 10 02 20 10 4d 16 2e 5f 50 52 5f 43 50 55 30  ... .M.._PR_CPU0
  0030: 14 1a 5f 50 50 43 00 a0 07 01 a4 41 43 50 53 a1  .._PPC.....ACPS.
  0040: 0b 74 87 53 50 53 53 01 60 a4 60 08 50 44 43 30  .t.SPSS.`.`.PDC0
  0050: 0c 00 00 00 f0 14 17 5f 50 44 43 01 8a 68 0a 08  ......._PDC..h..
  0060: 43 41 50 30 70 43 41 50 30 50 44 43 30 14 40 07  CAP0pCAP0PDC0.-4b8TPpkIZ3Q@public.gmane.org
  0070: 5f 50 43 54 00 a0 38 93 7b 50 44 43 30 01 00 01  _PCT..8.{PDC0...
  0080: a4 12 2c 02 11 14 0a 11 82 0c 00 7f 00 00 00 00  ..,.............
  0090: 00 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00  .......y........
  00a0: 7f 00 00 00 00 00 00 00 00 00 00 00 79 00 a1 2f  ............y../
  00b0: a4 12 2c 02 11 14 0a 11 82 0c 00 01 10 00 00 b2  ..,.............
  00c0: 00 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00  .......y........
  00d0: 01 08 00 00 b3 00 00 00 00 00 00 00 79 00 14 1d  ............y...
  00e0: 5f 50 53 53 00 a0 0f 93 7b 50 44 43 30 01 00 01  _PSS....{PDC0...
  00f0: a4 4e 50 53 53 a1 06 a4 53 50 53 53 08 4e 50 53  .NPSS...SPSS.NPS
  0100: 53 12 45 04 02 12 20 06 0c 08 07 00 00 0c 00 00  S.E... .........
  0110: 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 28 12 00  .............(..
  0120: 00 0c 28 12 00 00 12 20 06 0c 58 02 00 00 0c 00  ..(.... ..X.....
  0130: 00 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 12 06  ................
  0140: 00 00 0c 12 06 00 00 08 53 50 53 53 12 45 04 02  ........SPSS.E..
  0150: 12 20 06 0c 08 07 00 00 0c 00 00 00 00 0c 64 00  . ............d.
  0160: 00 00 0c 6e 00 00 00 0c 83 00 00 00 0c 00 00 00  ...n............
  0170: 00 12 20 06 0c 58 02 00 00 0c 00 00 00 00 0c 64  .. ..X.........d
  0180: 00 00 00 0c 6e 00 00 00 0c 83 01 00 00 0c 01 00  ....n...........
  0190: 00 00                                            ..

-- lspci -vv --
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
Controller (rev 21)
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at b0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [4104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x2

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP
Controller (rev 21) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: a0000000-afffffff
	Expansion ROM at 0000c000 [disabled] [size=8K]
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1
(rev 03) (prog-if 00 [UHCI])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1200 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2
(rev 03) (prog-if 00 [UHCI])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1600 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3
(rev 03) (prog-if 00 [UHCI])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1700 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI
Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at f4000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: d0000000-dfffffff
	Prefetchable memory behind bridge: 90000000-9fffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1100 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4)
AC'97 Audio Controller (rev 03)
	Subsystem: COMPAL Electronics Inc: Unknown device 0017
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at e000
	Region 1: I/O ports at e100 [size=64]
	Region 2: Memory at f0000400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at f0000600 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller
(rev 03) (prog-if 00 [Generic])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at e200
	Region 1: I/O ports at e300 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350
[Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at a8000000 (32-bit, prefetchable)
	Region 1: I/O ports at c100 [size=256]
	Region 2: Memory at e0010000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394
Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (8000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0001800 (32-bit, non-prefetchable)
	Region 1: I/O ports at a100 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a000
	Region 1: Memory at d0001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:02.0 Network controller: Intel Corp. Intel(R) PRO/Wireless
2200BG (rev 05)
	Subsystem: Intel Corp.: Unknown device 2701
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (750ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:02:03.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus
Controller (rev 01)
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 90100000 (32-bit, non-prefetchable)
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

-- /proc/interrupts --

           CPU0       
  0:    5330379          XT-PIC  timer
  1:       9138          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:      51166          XT-PIC  acpi
 10:      77862          XT-PIC  ehci_hcd, uhci_hcd, uhci_hcd,
uhci_hcd, Intel 82801DB-ICH4, eth0
 12:       5098          XT-PIC  i8042
 14:      30169          XT-PIC  ide0
 15:         24          XT-PIC  ide1
NMI:          0 
LOC:    5324236 
ERR:          0
MIS:          0


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
