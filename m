From: Vladimir Volcko <volckov-X2ABGLaSPc4@public.gmane.org>
Subject: Error getting cpuindex for acpiid
Date: Fri, 20 Aug 2004 15:40:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4125FF3C.2@pcs.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070103060105010309000600"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------070103060105010309000600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
  I am using vanilla kernel 2.6.8.1 + acpi-20040715-2.6.8 on Toshiba 
A30-303 - P4 3.06 GHz. Everything seems to be OK, but in dmesg I have this:

ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
acpi_processor-2250 [50] acpi_processor_get_inf: Error getting cpuindex 
for acpiid 0x1

It's something important?

PS: same mesage with 2.6.7 + acpi-20040715-2.6.7


--------------070103060105010309000600
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.8.1 (root-cnugyEDeBUTYT1VimQoPEVCOJt9qmXBj@public.gmane.org) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #5 Fri Aug 20 15:18:02 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dee0000 (usable)
 BIOS-e820: 000000001dee0000 - 000000001deeb000 (ACPI data)
 BIOS-e820: 000000001deeb000 - 000000001df00000 (ACPI NVS)
 BIOS-e820: 000000001df00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
478MB LOWMEM available.
found SMP MP-table at 000f6ca0
On node 0 totalpages: 122592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 118496 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 TOSCPL                                    ) @ 0x000f6c70
ACPI: RSDT (v001 TOSCPL   RSDT   0x06040000  LTP 0x00000000) @ 0x1dee56ea
ACPI: FADT (v001 TOSCPL MONTARA  0x06040000 PTL  0x00000050) @ 0x1deeaf3c
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1deeafb0
ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x20030224) @ 0x1dee571a
ACPI: DSDT (v001 TOSCPL MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: ro root=/dev/hda4 vga=0x317
Initializing CPU#0
CPU 0 irqstacks, hard=c03d4000 soft=c03d3000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 3064.255 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 482220k/490368k available (1883k kernel code, 7376k reserved, 835k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6062.08 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:......................................................................................................................................................................................................
Table [DSDT](id F005) - 678 Objects with 56 Devices 198 Methods 26 Regions
Parsing all Control Methods:...
Table [SSDT](id F003) - 5 Objects with 0 Devices 3 Methods 0 Regions
ACPI Namespace successfully loaded at root c03e563c
evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3063.0539 MHz.
..... host bus clock speed is 133.0197 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9b2, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000001028 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 6 Wake, Enabled 2 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...................................................................
Initialized 26/26 Regions 0/0 Fields 32/32 Buffers 9/15 Packages (692 nodes)
Executing all Device _STA and_INI methods:............................................................
60 Devices found containing: 60 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5) *9
ACPI: PCI Interrupt Link [LNKD] (IRQs 5) *9
ACPI: PCI Interrupt Link [LNKE] (IRQs 7 11) *9
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 11) *9
ACPI: PCI Interrupt Link [LNKG] (IRQs 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 5) *9
ACPI: Embedded Controller [EC0] (gpe 28)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 16 (level, low) -> IRQ 16
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................
IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  1    0    0   0   0    1    1    41
 03 001 01  0    0    0   0   0    1    1    49
 04 001 01  0    0    0   0   0    1    1    51
 05 001 01  0    0    0   0   0    1    1    59
 06 001 01  0    0    0   0   0    1    1    61
 07 001 01  0    0    0   0   0    1    1    69
 08 001 01  0    0    0   0   0    1    1    71
 09 001 01  0    1    0   0   0    1    1    79
 0a 001 01  0    0    0   0   0    1    1    81
 0b 001 01  0    0    0   0   0    1    1    89
 0c 001 01  0    0    0   0   0    1    1    91
 0d 001 01  0    0    0   0   0    1    1    99
 0e 001 01  0    0    0   0   0    1    1    A1
 0f 001 01  0    0    0   0   0    1    1    A9
 10 001 01  1    1    0   1   0    1    1    B1
 11 001 01  1    1    0   1   0    1    1    D1
 12 001 01  1    1    0   1   0    1    1    C1
 13 001 01  1    1    0   1   0    1    1    B9
 14 001 01  1    1    0   1   0    1    1    D9
 15 001 01  1    1    0   1   0    1    1    E1
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    C9
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ23 -> 0:23
.................................... done.
vesafb: framebuffer at 0xe8000000, mapped to 0xde80d000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
IA-32 Microcode Update Driver: v1.14 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
acpi_processor-2250 [50] acpi_processor_get_inf: Error getting cpuindex for acpiid 0x1
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 408M
agpgart: Detected 32636K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 17
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23FA-60, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
ELAN USB1 USB2 USB3 EUSB MODM 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem deba1000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 00001820
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 00001840
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 00001860
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 4-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-1
EXT3 FS on hda4, internal journal
Adding 658656k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!

--------------070103060105010309000600--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
