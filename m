From: =?iso-8859-1?q?Will=20Woods?= <will_woods2-/E1597aS9LT10XsdtD+oqA@public.gmane.org>
Subject: Re: S3 resume only reboots (long)
Date: Thu, 8 Jul 2004 18:10:03 +0100 (BST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040708171004.34704.qmail@web25005.mail.ukl.yahoo.com>
References: <200407081339.40357.jak97@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200407081339.40357.jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--- John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org> wrote: > Hi
Will
> 
> Please could you post your machine configuration. I
> have the same problem, and 
> it would be good to see if we have any common
> hardware. You can find out more 
> about my machine at 
> 
> 	http://www.doc.ic.ac.uk/~jak97/dsdt/
> 
> Items of interest is the output of
> 
> 	/proc/config.gz (if it's there)
> 	/proc/cpuinfo
> 	/proc/interrupts
> 	dmesg
> 	lspci
> 	lspci -v
> 
> Cheers
> 
> John
> 

Ok here is most of the info you asked for - but not
all the config.gz (3000 lines!). It looks like we have
similar motherboards...

Will


part of /proc/config.gz

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface)
Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y



cat /proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2400+
stepping        : 1
cpu MHz         : 2005.022
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
syscall mmxext 3dnowext 3dnow
bogomips        : 3973.12


cat /proc/interrupts

           CPU0
  0:     800388    IO-APIC-edge  timer
  1:        388    IO-APIC-edge  i8042
  3:      54557    IO-APIC-edge  serial
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      13842    IO-APIC-edge  i8042
 14:       7210    IO-APIC-edge  ide2
 15:       6571    IO-APIC-edge  ide3
 16:      24475   IO-APIC-level  r128-D5X1nVylZaA@public.gmane.org:1:0:0
 18:          5   IO-APIC-level  eth0
 21:          0   IO-APIC-level  uhci_hcd, uhci_hcd,
uhci_hcd, uhci_hcd, ehci_hcd
 22:        190   IO-APIC-level  VIA8233
NMI:          0
LOC:     800333
ERR:          0
MIS:          0


lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8377
[KT400 AGP] Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI
Bridge
00:0b.0 Ethernet controller: Broadcom Corporation
BCM4401 100Base-T (rev 01)
00:0f.0 RAID bus controller: VIA Technologies, Inc.:
Unknown device 3149 (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus
Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. USB
(rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. USB
(rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. USB
(rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. USB
(rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0
(rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown
device 3227
00:11.5 Multimedia audio controller: VIA Technologies,
Inc. VT8233/A/8235 AC97 Audio Controller (rev 60)
01:00.0 VGA compatible controller: ATI Technologies
Inc Rage 128 PF/PRO AGP 4x TMDS



lspci -v

00:00.0 Host bridge: VIA Technologies, Inc. VT8377
[KT400 AGP] Host Bridge (rev 80)
        Subsystem: VIA Technologies, Inc.: Unknown
device 0000
        Flags: bus master, 66Mhz, medium devsel,
latency 8
        Memory at e0000000 (32-bit, prefetchable)
[size=128M]
        Capabilities: [80] AGP version 3.5
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI
Bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel,
latency 0
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge:
d7d00000-dfcfffff
        Capabilities: [80] Power Management version 2

00:0b.0 Ethernet controller: Broadcom Corporation
BCM4401 100Base-T (rev 01)
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 590c
        Flags: bus master, fast devsel, latency 32,
IRQ 18
        Memory at dfffa000 (32-bit, non-prefetchable)
[size=8K]
        Capabilities: [40] Power Management version 2

00:0f.0 RAID bus controller: VIA Technologies, Inc.:
Unknown device 3149 (rev 80)
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: bus master, medium devsel, latency 32,
IRQ 20
        I/O ports at ec00 [size=8]
        I/O ports at e800 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at dc00 [size=16]
        I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2

00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: bus master, medium devsel, latency 32,
IRQ 20
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB
(rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: bus master, medium devsel, latency 32,
IRQ 21
        I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB
(rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: bus master, medium devsel, latency 32,
IRQ 21
        I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB
(rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: bus master, medium devsel, latency 32,
IRQ 21
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB
(rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: bus master, medium devsel, latency 32,
IRQ 21
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0
(rev 86) (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: bus master, medium devsel, latency 32,
IRQ 21
        Memory at dfff9e00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown
device 3227
        Subsystem: VIA Technologies, Inc.: Unknown
device 0000
        Flags: bus master, stepping, medium devsel,
latency 0
        Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies,
Inc. VT8233/A/8235 AC97 Audio Controller (rev 60)
        Subsystem: Micro-Star International Co., Ltd.:
Unknown device 5901
        Flags: medium devsel, IRQ 22
        I/O ports at c400 [size=256]
        Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies
Inc Rage 128 PF/PRO AGP 4x TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury
Pro/Xpert 2000 Pro
        Flags: bus master, stepping, 66Mhz, medium
devsel, latency 32, IRQ 16
        Memory at d8000000 (32-bit, prefetchable)
[size=64M]
        I/O ports at b800 [size=256]
        Memory at dfefc000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at dfec0000 [disabled]
[size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2





dmesg

Linux version 2.6.7-1acpi (root-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org) (gcc
version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #1 Mon
Jul 5 18:56:08 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000
(usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI
data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI
NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000
(reserved)
255MB LOWMEM available.
found SMP MP-table at 000fb990
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                  
    ) @ 0x000faa00
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT
0x00000097) @ 0x0fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT
0x00000097) @ 0x0fff0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT
0x00000097) @ 0x0fff00c0
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT
0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000]
global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000,
GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl
dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low
level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=linux-acpi ro
root=2105 devfs=mount resume=/dev/hde6 splash=silent
acpi=on
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2005.022 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 255720k/262080k available (1809k kernel code,
5616k reserved, 900k data, 260k init, 0k highmem)
Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Calibrating delay loop... 3973.12 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5,
131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
CPU:     After generic identify, caps: 0383fbff
c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff
c1c3fbff 00000000 00000000
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to
2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64
bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff
00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19,
2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2004.0347 MHz.
..... host bus clock speed is 267.0246 MHz.
checking if image is initramfs...it isn't (no cpio
magic); looks like an initrd
Freeing initrd memory: 218k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last
bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11
12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at
0xc00f7900
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x67ab,
dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by
driver
00:00:01[A] -> 2-16 -> IRQ 16 level low
00:00:01[B] -> 2-17 -> IRQ 17 level low
00:00:11[A] -> 2-20 -> IRQ 20 level low
00:00:11[C] -> 2-22 -> IRQ 22 level low
00:00:05[C] -> 2-18 -> IRQ 18 level low
00:00:05[D] -> 2-19 -> IRQ 19 level low
00:00:10[A] -> 2-21 -> IRQ 21 level low
00:00:12[A] -> 2-23 -> IRQ 23 level low
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    C9
 13 001 01  1    1    0   1   0    1    1    D1
 14 001 01  1    1    0   1   0    1    1    B9
 15 001 01  1    1    0   1   0    1    1    D9
 16 001 01  1    1    0   1   0    1    1    C1
 17 001 01  1    1    0   1   0    1    1    E1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
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
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
vesafb: framebuffer at 0xd8000000, mapped to
0xd0807000, size 1875k
vesafb: mode is 800x600x16, linelength=1600, pages=33
vesafb: protected mode interface info at c000:4d22
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
apm: BIOS version 1.2 Flags 0x03 (Driver version
1.16ac)
apm: overridden by ACPI.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device
100x37
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports,
IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K
size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings:
hda:pio, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings:
hdc:pio, hdd:pio
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on
pci0000:00:0f.1
    ide2: BM-DMA at 0xfc00-0xfc07, BIOS settings:
hde:DMA, hdf:pio
    ide3: BM-DMA at 0xfc08-0xfc0f, BIOS settings:
hdg:DMA, hdh:pio
hde: SAMSUNG SP1203N, ATA DISK drive
Using anticipatory io scheduler
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hdg: Pioneer DVD-ROM ATAPIModel DVD-114 0110, ATAPI
CD/DVD-ROM drive
ide3 at 0x170-0x177,0x376 on irq 15
hde: max request size: 1024KiB
hde: 234493056 sectors (120060 MB) w/2048KiB Cache,
CHS=16383/255/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 p6 > p3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind
32768)
NET: Registered protocol family 1
Resume Machine: resuming from /dev/hde6
Resuming from device hde6
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.15 2004-May-17, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
SCSI subsystem initialized
libata version 1.02 loaded.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 260k freed
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0000c800
uhci_hcd 0000:00:10.0: new USB bus registered,
assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0000cc00
uhci_hcd 0000:00:10.1: new USB bus registered,
assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0000d000
uhci_hcd 0000:00:10.2: new USB bus registered,
assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: irq 21, io base 0000d400
uhci_hcd 0000:00:10.3: new USB bus registered,
assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem d09e8e00
ehci_hcd 0000:00:10.4: new USB bus registered,
assigned bus number 5
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00,
driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
EXT3 FS on hde5, internal journal
Adding 811240k swap on /dev/hde6.  Priority:-1
extents:1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: Maximum main memory to use for agp memory:
203M
agpgart: AGP aperture is 128M @ 0xe0000000
NTFS driver 2.1.14 [Flags: R/O MODULE].
NTFS volume version 3.1.
b44.c:v0.94 (May 4, 2004)
eth0: Broadcom 4400 10/100BaseT Ethernet
00:0c:76:5b:b0:79
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) -
296 bytes per conntrack
inserting floppy driver for 2.6.7-1acpi
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdg: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
NET: Registered protocol family 17
PCI: Setting latency timer of device 0000:00:11.5 to
64
b44: eth0: Link is down.
mtrr: 0xd8000000,0x2000000 overlaps existing
0xd8000000,0x100000
mtrr: 0xd8000000,0x2000000 overlaps existing
0xd8000000,0x100000
[drm] Initialized r128 2.5.0 20030725 on minor 0: ATI
Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
mtrr: 0xd8000000,0x2000000 overlaps existing
0xd8000000,0x100000
agpgart: Found an AGP 3.5 compliant device at
0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x
mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x
mode
atkbd.c: Spurious ACK on isa0060/serio0. Some program,
like XFree86, might be trying access hardware
directly.
CSLIP: code copyright 1989 Regents of the University
of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0367e40(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present






















> On Wednesday 07 July 2004 10:57, Will Woods wrote:
> > Ok, I have compiled the 2.6.7 kernel with latest
> acpi
> > patch (acpi-20040326-2.6.7.diff), and I still have
> the
> > same problem (and yes, I have checked that I'm
> running
> > the new kernel :)
> >
> > Any ideas would be much appreciated.
> >
> > Will
> >
> >
> > --- Will Woods <will_woods2-/E1597aS9LT10XsdtD+oqA@public.gmane.org> wrote: >
> >
> > > Hi,
> > >
> > > I think I can get my machine to suspend to ram
> with
> > > 'echo 3 > /proc/aci/sleep', but a subsequent
> press
> > > of
> > > the power button just starts a fresh boot. The
> only
> > > other button I have is the reset, which does
> > > nothing,
> > > and the keyboard is also ignored. I can't figure
> out
> > > if the machine is just powering off (in about 1
> > > second), or if I'm really getting the S3 mode.
> If I
> > > am, is there anything I can configure to ensure
> the
> > > power button does not do a reboot? S3 works fine
> > > under
> > > windows XP, so I assume that the problem is not
> with
> > > the hardware.
> > >
> > > I'm running Mandrake 10 with kernel 2.6.3-7mdk.
> > >
> > >
> > > Will
> >
> >
> 


	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - sooooo many all-new ways to express yourself http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
