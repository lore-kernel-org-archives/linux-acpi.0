From: Bradley Chapman <kakadu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Intel 855PM Thermal Zone support
Date: Sun, 29 Aug 2004 22:24:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e294b46e04082914245adf173e@mail.gmail.com>
Reply-To: Bradley Chapman <kakadu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

I'm having trouble with the thermal zone drivers in the 20040715
2.6.8.1 ACPI driverset on my Sager NP3760 laptop, which has an Intel
855PM chipset. The thermal zone drivers are unable to lcate any
thermalzones, and subsequently I can't monitor the CPU termperature.
The CPU itself is an Intel Pentium M Dothan, 1.5GHz. dmesg and cpuinfo
outputs appear below.

Does anyone know where I can learn about the current state of support
for the 855PM chipset?

Brad

<!-- dmesg and cpuinfo //-->
Linux version 2.6.8.1 (bhchapm-yRJU9L5y90jR757GaPG36U1w03SPmsBMYZdqe9AaVak@public.gmane.org) (gcc version
3.3.4 (Debian 1:3.3.4-6sarge1)) #7 Fri Aug 27 09:55:55 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fffffc0 (ACPI data)
 BIOS-e820: 000000001fffffc0 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e4010
ACPI: RSDT (v001 OID_00 RSDT_000 0x30303030 _CSI 0x00010101) @ 0x1ffffbd0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @ 0x1ffffb20
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @ 0x1ffffba0
ACPI: DSDT (v001 INSYDE KENORAA3 0x00001004 MSFT 0x02000001) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: root=/dev/hda6 ro devfs=nomount
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
CPU 0 irqstacks, hard=c04ee000 soft=c04ed000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1500.197 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513760k/524224k available (2895k kernel code, 9712k reserved,
925k data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2973.69 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  afe9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: After all inits, caps:        afe9fbb7 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.50GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1499.0594 MHz.
..... host bus clock speed is 99.0972 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xeb8f0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: Power Resource [PUT2] (on)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 *11)
Linux Plug and Play Support v0.97 (c) Adam Belay
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x37 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
udf: registering filesystem
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID0]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hw_random: RNG not detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xa0000000
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: HTS726060M9AT00, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2512, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:09.0 [1558:0470]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:09.0, mfunc 0x01001c00, devctl 0x66
spurious 8259A interrupt: IRQ7.
Yenta: ISA IRQ mask 0x00f8, PCI irq 10
Socket status: 30000006
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:09.1 [1558:0470]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:09.1, mfunc 0x01001c00, devctl 0x66
Yenta: ISA IRQ mask 0x00f8, PCI irq 11
Socket status: 30000006
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem e0840000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17
14:31:44 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49680 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xf0000400, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
speedstep-centrino: found unsupported CPU with Enhanced SpeedStep:
send /proc/cpuinfo to Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
ACPI: (supports S0 S3 S4 S4bios S5)
ACPI wakeup devices:
SLPB PWRB PCI2 US20 US21 US22 USB0 USB1 USB2 USB3 MC97
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.50GHz
stepping        : 6
cpu MHz         : 1500.197
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe tm2 est
bogomips        : 2973.69


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
