From: Chris Rankin <cj.rankin-XZoyATsUNX5Wk0Htik3J/w@public.gmane.org>
Subject: [REPORT] ACPI boot messages with 2.4.22
Date: Tue, 26 Aug 2003 21:58:58 +0100 (BST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308262058.h7QKwwcM002258@twopit.underworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have just booted a 2.4.22 kernel with the "acpi=force"
parameter. Apparently, my BIOS dates from 1999 and Linux thinks that
this is suspect. Well, I only use ACPI because I don't trust APM on a
SMP machine, and ACPI did what little I asked of it with 2.4.21.

This is what the boot-log says now:

Loaded 18132 symbols from /boot/System.map-2.4.22.
Symbols match kernel version 2.4.22.
Loaded 201 symbols from 10 modules.
Linux version 2.4.22 (chris@twopit) (gcc version 3.2.3) #1 SMP Mon Aug 25 16:56:40 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffe0000 (usable)
 BIOS-e820: 000000003ffe0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000faf50
hm, page 000fa000 reserved twice.
hm, page 000fb000 reserved twice.
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
On node 0 totalpages: 262112
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32736 pages.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa0b0
ACPI: RSDT (v001 AMI___ OEMRSDT  0x19990715 MSFT 
0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMI___ OEMFACP  0x19990715 MSFT 0x00000097) @ 0x3fff1000
ACPI: MADT (v001 AMI___ OEMAPIC  0x19990715 MSFT 
0x00000097) @ 0x3fff2000
ACPI: DSDT (v001 CARMEL 8C1A100A 0x00000012 MSFT 
0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Pentium(tm) Pro APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: IOAPIC (id[0x03] address[0xfd8ff000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 32, address 0xfd8ff000, IRQ 24-47
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Using ACPI (MADT) for SMP configuration information
Kernel command line: BOOT_IMAGE=Linux-profile ro 
root=301 profile=2 ide0=autotune nmi_watchdog=1 console=ttyS0,115200n8 console=tty0 acpi=force
ide_setup: ide0=autotune
Initializing CPU#0
Detected 696.031 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1389.36 BogoMIPS
Memory: 1031324k/1048448k available (1370k kernel code, 16736k reserved, 496k data, 120k init, 130944k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 730.68 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000084
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1389.36 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (2778.72 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23 not connected.
.TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
testing the IO APIC.......................

IO APIC #2......
... register #00: 02000000
......    : physical APIC id: 02
......    : Delivery Type: 0
......    : LTS          : 0
... register #01: 00170020
......     : max redirection entries: 0017
......     : PRQ implemented: 0
......     : IO APIC version: 0020
... register #02: 00000000
......     : arbitration: 00
... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
... register #00: 03000000
......    : physical APIC id: 03
......    : Delivery Type: 0
......    : LTS          : 0
... register #01: 00178020
......     : max redirection entries: 0017
......     : PRQ implemented: 1
......     : IO APIC version: 0020
... register #02: 0C000000
......     : arbitration: 0C
... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 696.0558 MHz.
.... host bus clock speed is 99.4361 MHz.
cpu: 0, clocks: 994361, slice: 331453
CPU0<T0:994352,T1:662896,D:3,S:331453,C:994361>
cpu: 1, clocks: 994361, slice: 331453
CPU1<T0:994352,T1:331440,D:6,S:331453,C:994361>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=5
PCI: Using configuration type 1
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node c1d70640), AE_AML_REGION_LIMIT
    ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node c1d70640), AE_AML_REGION_LIMIT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801AA PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2.PCI3._PRT]
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA] (Node c1d70640), AE_AML_REGION_LIMIT
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb1 -> IRQ 19 Mode:1 Active:1)
00:00:1f[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb9 -> IRQ 16 Mode:1 Active:1)
00:00:01[A] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
00:01:00[C] -> 2-18 -> IRQ 18
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
IOAPIC[1]: Set PCI routing entry (3-0 -> 0xc9 -> IRQ 24 Mode:1 Active:1)
00:04:02[A] -> 3-0 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (3-1 -> 0xd1 -> IRQ 25 Mode:1 Active:1)
00:04:02[B] -> 3-1 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xd9 -> IRQ 26 Mode:1 Active:1)
00:04:02[C] -> 3-2 -> IRQ 26
IOAPIC[1]: Set PCI routing entry (3-3 -> 0xe1 -> IRQ 27 Mode:1 Active:1)
00:04:02[D] -> 3-3 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (3-4 -> 0xe9 -> IRQ 28 Mode:1 Active:1)
00:04:03[A] -> 3-4 -> IRQ 28
IOAPIC[1]: Set PCI routing entry (3-5 -> 0x32 -> IRQ 29 Mode:1 Active:1)
00:04:03[B] -> 3-5 -> IRQ 29
IOAPIC[1]: Set PCI routing entry (3-6 -> 0x3a -> IRQ 30 Mode:1 Active:1)
00:04:03[C] -> 3-6 -> IRQ 30
IOAPIC[1]: Set PCI routing entry (3-7 -> 0x42 -> IRQ 31 Mode:1 Active:1)
00:04:03[D] -> 3-7 -> IRQ 31
IOAPIC[1]: Set PCI routing entry (3-8 -> 0x4a -> IRQ 32 Mode:1 Active:1)
00:04:04[A] -> 3-8 -> IRQ 32
IOAPIC[1]: Set PCI routing entry (3-9 -> 0x52 -> IRQ 33 Mode:1 Active:1)
00:04:04[B] -> 3-9 -> IRQ 33
IOAPIC[1]: Set PCI routing entry (3-10 -> 0x5a -> IRQ 34 Mode:1 Active:1)
00:04:04[C] -> 3-10 -> IRQ 34
IOAPIC[1]: Set PCI routing entry (3-11 -> 0x62 -> IRQ 35 Mode:1 Active:1)
00:04:04[D] -> 3-11 -> IRQ 35
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: ST320420A, ATA DISK drive
blk: queue c0343ee0, I/O limit 4095Mb (mask 0xffffffff)
hdc: Pioneer DVD-ROM ATAPIModel DVD-116 0122, ATAPI CD/DVD-ROM drive
hdd: SONY CD-RW CRX145E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=2480/255/63, UDMA(66)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
LVM version 1.0.5+(22/07/2002)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 576k freed
VFS: Mounted root (ext2 filesystem).
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
microcode: CPU1 updated from revision 0 to 7, date=05052000
microcode: CPU0 updated from revision 0 to 7, date=05052000
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 120k freed
microcode: CPU1 already at revision 7 (current=7)
microcode: CPU0 already at revision 7 (current=7)
microcode: freed 4096 bytes
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Adding Swap: 498004k swap-space (priority 1)
loop: loaded (max 8 devices)
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[fd7fe800-fd7fefff]  Max Packet=[2048]
ohci1394_1: Unexpected PCI resource length of 1000!
ohci1394_1: OHCI-1394 1.0 (PCI): IRQ=[18]  MMIO=[fd2fc000-fd2fc7ff]  Max Packet=[1024]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000003675]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 02:0d.2: NEC Corporation USB 2.0
ehci_hcd 02:0d.2: irq 17, pci mem f8894f00
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 02:0d.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 5 ports detected
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0090a9400800472c]
usb-ohci.c: USB OHCI at membase 0xf889c000, IRQ 16
usb-ohci.c: usb-02:0d.1, NEC Corporation USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-ohci.c: USB OHCI at membase 0xf88af000, IRQ 19
usb-ohci.c: usb-02:0d.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xef80, IRQ 19
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:21:0C:51, IRQ 16.
  Board assembly 389911-037, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
hdc: attached ide-cdrom driver.
hdc: ATAPI 126X DVD-ROM drive, 256kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.12
ide-cd: ignoring drive hdd
i2c-core.o: i2c core module
i2c-i801.o version 2.6.5 (20020915)
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-proc.o version 2.6.1 (20010825)
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801 adapter at efa0](pos. 0).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801 adapter at efa0](pos. 1).
lm87.o version 2.6.5 (20020915)
i2c-core.o: driver LM87 sensor driver registered.
i2c-core.o: client [LM87 chip] registered to adapter [SMBus I801 adapter at efa0](pos. 2).
i2c-core.o: client [LM87 chip] registered to adapter [SMBus I801 adapter at efa0](pos. 3).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected Intel i840 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] AGP 0.99 on Intel i840 @ 0xf8000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
mice: PS/2 mouse device common for all mice
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
SCSI subsystem driver Revision: 1.00
scsi: host order: ide-scsi:sbp2_0:sbp2_1:usb-storage-0:usb-storage-1:ppa
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX145E    Rev: 1.0b
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray


Everything seems to be working, although these errors worry me:

    ACPI-1121: *** Error: Method execution failed    [\_SB_.PCI0.SBRG.PS2M._STA]

It is also interesting to note that the ACPI interrupt now appears as
"IO-APIC-level" instead of "IO-APIC-edge" in /proc/interrupts.

Anyway, I was wondering if there was anything in this log that might
alarm someone, please? I'm guessing that I only need the "button" and
"processor" subsystems here, but there does also seem to be a lot of
redundant work in the PCI probing and interrupt assigning. Why does it
try to assign IRQs 20 - 35, for example? They don't appear in
/proc/interrupts.

But so far so good. Was 1999 a bad year for ACPI BIOSes?
Cheers,
Chris


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
