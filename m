From: John Wong <kernel-AAfBIQCtFhbR7s880joybQ@public.gmane.org>
Subject: PCI IRQ routing strangeness with 2.4.22 on A7N266-VM (original nForce)
Date: Thu, 28 Aug 2003 21:50:32 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030829045032.GA688@gambit.implode.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-ID: <20030829160331.GA2658-XxA8UMA2PDBPKbTXaf03yKxOck334EZe@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Content-Disposition: inline
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


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On the nForce original with the onboard GeForce2 video, the BIOS does
assign IRQ 11 to the onboard video, however, Linux does not.  Setting
acpi=off and pci=noirq does not fix the problem.  I have a nForce2 board
without onboard video and ACPI/IO-APIC etc all work fine.

There is a strange entry in the dmesg log:

Pin 2-16 already programmed
    ACPI-1121: *** Error: Method execution failed [\_SB_.SRS_] (Node
cdf363c0),
AE_AML_BUFFER_LIMIT
    ACPI-1121: *** Error: Method execution failed [\_SB_.LNKE._SRS]
(Node cdf36dc0), AE_AML_BUFFER_LIMIT
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI
BIOS).
Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/n    ACPI-1121: *** Error:
Method execution failed [\_SB_.SRS_] (Node cdf363c0),
AE_AML_BUFFER_LIMIT
    ACPI-1121: *** Error: Method execution failed [\_SB_.LNKE._SRS]
(Node cdf36dc0), AE_AML_BUFFER_LIMIT
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI
BIOS).
Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off


I will also attach the dmesg as an attachment.

Here is the interrupts:

           CPU0
  0:     193151    IO-APIC-edge  timer
  1:       9633    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       3012    IO-APIC-edge  PS/2 Mouse
 14:       8515    IO-APIC-edge  ide0
 18:          0   IO-APIC-level  EMU10K1
 22:   42753540   IO-APIC-level  eth0
NMI:          0
LOC:     193041
ERR:          0
MIS:          0

And the lspci -v:

02:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 -
nForce GPU] (rev b1) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ -19
        Memory at e5000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at e7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.22 (root@johnw) (gcc version 3.3.2 20030812 (Debian prerelease)) #1 Thu Aug 28 17:28:52 PDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000080000 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dfec000 (usable)
 BIOS-e820: 000000000dfec000 - 000000000dfef000 (ACPI data)
 BIOS-e820: 000000000dfef000 - 000000000dfff000 (reserved)
 BIOS-e820: 000000000dfff000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
223MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 57324
zone(0): 4096 pages.
zone(1): 53228 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f8090
ACPI: RSDT (v001 ASUS   A7N266VM 0x42302e31 MSFT 0x31313031) @ 0x0dfec000
ACPI: FADT (v001 ASUS   A7N266VM 0x42302e31 MSFT 0x31313031) @ 0x0dfec100
ACPI: BOOT (v001 ASUS   A7N266VM 0x42302e31 MSFT 0x31313031) @ 0x0dfec040
ACPI: MADT (v001 ASUS   A7N266VM 0x42302e31 MSFT 0x31313031) @ 0x0dfec080
ACPI: DSDT (v001   ASUS A7N266VM 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: root=/dev/hda1 ro
Initializing CPU#0
Detected 1662.406 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3316.12 BogoMIPS
Memory: 224268k/229296k available (1213k kernel code, 4516k reserved, 311k data, 276k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2000+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1662.4018 MHz.
..... host bus clock speed is 265.9843 MHz.
cpu: 0, clocks: 2659843, slice: 1329921
CPU0<T0:2659840,T1:1329904,D:15,S:1329921,C:2659843>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xf1b40, last bus=2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 18, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 18, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 18, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 18, disabled)
ACPI: PCI Interrupt Link [LNKE] (IRQs 19, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 20 21 22, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNKU] (IRQs 20 21 22, enabled at IRQ 10)
ACPI: PCI Interrupt Link [LNKI] (IRQs 20 21 22, enabled at IRQ 10)
ACPI: PCI Interrupt Link [LNKJ] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [LNKK] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [LNKM] (IRQs 20 21 22, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xa9 -> IRQ 22 Mode:1 Active:0)
00:00:01[A] -> 2-22 -> IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xb1 -> IRQ 21 Mode:1 Active:0)
00:00:02[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [LNKJ] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb9 -> IRQ 20 Mode:1 Active:0)
00:00:05[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [LNKK] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:0)
00:01:06[A] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc9 -> IRQ 16 Mode:1 Active:0)
00:01:06[B] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
Pin 2-18 already programmed
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 16
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
    ACPI-1121: *** Error: Method execution failed [\_SB_.SRS_] (Node cdf363c0), AE_AML_BUFFER_LIMIT
    ACPI-1121: *** Error: Method execution failed [\_SB_.LNKE._SRS] (Node cdf36dc0), AE_AML_BUFFER_LIMIT
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/n    ACPI-1121: *** Error: Method execution failed [\_SB_.SRS_] (Node cdf363c0), AE_AML_BUFFER_LIMIT
    ACPI-1121: *** Error: Method execution failed [\_SB_.LNKE._SRS] (Node cdf36dc0), AE_AML_BUFFER_LIMIT
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE: IDE controller at PCI slot 00:09.0
NFORCE: chipset revision 195
NFORCE: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: nVidia Corporation nForce IDE (rev c3) UDMA100 controller on pci00:09.0
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: ST38410A, ATA DISK drive
hdb: WDC WD400JB-00ENA0, ATA DISK drive
blk: queue c02efc20, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02efd5c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 16841664 sectors (8623 MB) w/512KiB Cache, CHS=1048/255/63, UDMA(66)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 78165360 sectors (40021 MB) w/8192KiB Cache, CHS=4865/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2
 hdb: unknown partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
Adding Swap: 120476k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Real Time Clock Driver v1.10e
PCI: Setting latency timer of device 00:04.0 to 64
Creative EMU10K1 PCI Audio Driver, version 0.20, 17:39:48 Aug 28 2003
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xc800-0xc81f, IRQ 18
ac97_codec: AC97 Audio codec, id: EMC40 (Unknown)
emu10k1: SBLive! 5.1 card detected
ACPI: Processor [CPU] (supports C1)
ACPI: Power Button (FF) [PWRF]

--EVF5PPMfhYS0aIcm--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
