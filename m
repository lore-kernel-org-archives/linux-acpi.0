From: Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Sat, 21 Sep 2002 04:04:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020921020430.GC6132@www.13thfloor.at>
Reply-To: herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Problems with HP Server and 4Port Tulip NIC ...

linux-2.4.20-pre7 kernel is working fine,
with acpi-20020918-2.4.20-pre7.diff NIC stops working ...

only difference in lspci -vvv are the interrupts ...

best,
Herbert

-------

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:02.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev
08)
00:05.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 65)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev
04)
01:04.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
01:05.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
01:06.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
01:07.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
05:05.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c896 (rev 07)
05:05.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c896 (rev 07)




--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-linux-2.4.20-pre7-acpi20020918.out"

ermine) stepping 06
per-CPU timeslice cutoff: 731.61 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-2, 2-0, 2-1, 2-2, 2-3, 2-4, 2-5, 2-6, 2-7, 2-8, 2-9, 2-10, 2-11, 2-12, 2-13, 2-14, 2-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
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
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0E000000
.......     : arbitration: 0E
.... IRQ redirection table:
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
..... CPU clock speed is 733.3607 MHz.
..... host bus clock speed is 133.3380 MHz.
cpu: 0, clocks: 1333380, slice: 666690
CPU0<T0:1333376,T1:666672,D:14,S:666690,C:1333380>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xfd9e1, last bus=7
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (1-9 -> 0x71 -> IRQ 9)
ACPI breakpoint: Executed AML Breakpoint opcode
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKU] (IRQs 5, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK4] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNK5] (IRQs 9 11, disabled)
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNK9] (IRQs 3 4 5 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Root Bridge [PCI1] (00:05)
PCI: Probing PCI hardware (bus 05)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
IOAPIC[1]: Set PCI routing entry (2-10 -> 0xa9 -> IRQ 26)
00:00:07[A] -> 2-10 -> IRQ 26
IOAPIC[1]: Set PCI routing entry (2-4 -> 0xb1 -> IRQ 20)
00:00:02[A] -> 2-4 -> IRQ 20
IOAPIC[1]: Set PCI routing entry (2-0 -> 0xb9 -> IRQ 16)
00:00:03[A] -> 2-0 -> IRQ 16
Pin 2-10 already programmed
IOAPIC[1]: Set PCI routing entry (2-11 -> 0xc1 -> IRQ 27)
00:00:03[C] -> 2-11 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (2-12 -> 0xc9 -> IRQ 28)
00:00:03[D] -> 2-12 -> IRQ 28
IOAPIC[1]: Set PCI routing entry (2-1 -> 0xd1 -> IRQ 17)
00:00:04[A] -> 2-1 -> IRQ 17
Pin 2-12 already programmed
Pin 2-10 already programmed
Pin 2-11 already programmed
IOAPIC[1]: Set PCI routing entry (2-2 -> 0xd9 -> IRQ 18)
00:00:05[A] -> 2-2 -> IRQ 18
Pin 2-11 already programmed
Pin 2-12 already programmed
Pin 2-10 already programmed
IOAPIC[1]: Set PCI routing entry (2-3 -> 0xe1 -> IRQ 19)
00:00:06[A] -> 2-3 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (2-13 -> 0xe9 -> IRQ 29)
00:00:06[B] -> 2-13 -> IRQ 29
IOAPIC[1]: Set PCI routing entry (2-14 -> 0x32 -> IRQ 30)
00:00:06[C] -> 2-14 -> IRQ 30
IOAPIC[1]: Set PCI routing entry (2-15 -> 0x3a -> IRQ 31)
00:00:06[D] -> 2-15 -> IRQ 31
IOAPIC[1]: Set PCI routing entry (2-8 -> 0x42 -> IRQ 24)
00:05:05[A] -> 2-8 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (2-9 -> 0x4a -> IRQ 25)
00:05:05[B] -> 2-9 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (2-7 -> 0x52 -> IRQ 23)
00:05:04[A] -> 2-7 -> IRQ 23
Pin 2-13 already programmed
Pin 2-14 already programmed
Pin 2-15 already programmed
IOAPIC[1]: Set PCI routing entry (2-6 -> 0x5a -> IRQ 22)
00:05:03[A] -> 2-6 -> IRQ 22
Pin 2-14 already programmed
Pin 2-15 already programmed
Pin 2-13 already programmed
IOAPIC[1]: Set PCI routing entry (2-5 -> 0x62 -> IRQ 21)
00:05:02[A] -> 2-5 -> IRQ 21
Pin 2-15 already programmed
Pin 2-13 already programmed
Pin 2-14 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
vesafb: framebuffer at 0xfc000000, mapped to 0xd0807000, size 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:4dc8
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:5:5, shift=0:10:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 1024 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:pio, hdd:pio
hda: C/H/S=59881/223/0 from BIOS ignored
hda: IC35L120AVVA07-0, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0374304, I/O limit 4095Mb (mask 0xffffffff)
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(33)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
SCSI subsystem driver Revision: 1.00
sym0: <896> rev 0x7 on pci bus 5 device 5 function 0 irq 24
sym0: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <896> rev 0x7 on pci bus 5 device 5 function 1 irq 25
sym1: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
blk: queue cfee4618, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: HP 18.2G  Model: MAN3184MP         Rev: HP04
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue cfecee18, I/O limit 4095Mb (mask 0xffffffff)
sym0:3:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
sym0:3: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
 /dev/scsi/host0/bus0/target3/lun0: p1 p2 p3 p4 < p5 p6 p7 >
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
md: linear personality registered as nr 1
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1352.800 MB/sec
   32regs    :   659.600 MB/sec
   pIII_sse  :  1501.200 MB/sec
   pII_mmx   :  1649.200 MB/sec
   p5_mmx    :  1719.600 MB/sec
raid5: using function: pIII_sse (1501.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,3), internal journal
loop: loaded (max 8 devices)
Adding Swap: 1048784k swap-space (priority 10)
Adding Swap: 511992k swap-space (priority 10)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:18:C6:13:60, IRQ 20.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 506470-151, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0xd0d06000, 00:80:C8:B9:9E:C5, IRQ 27.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at 0xd0d08400, 00:80:C8:B9:9E:C6, IRQ 27.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at 0xd0d0a800, 00:80:C8:B9:9E:C7, IRQ 27.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
eth4: Digital DS21143 Tulip rev 65 at 0xd0d0cc00, 00:80:C8:B9:9E:C8, IRQ 27.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 03:27:45 Sep 21 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
eth4: Setting full-duplex based on MII#1 link partner capability of 41e1.

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-linux-2.4.20-pre7-acpi20020918.out"

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 48, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08

00:02.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Hewlett-Packard Company: Unknown device 10ca
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fd100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at fd000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:05.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=36
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fd200000-fd2fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 65) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 10e1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1400 [size=256]
	Region 2: Memory at fd101000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
	Subsystem: ServerWorks OSB4 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1840 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd102000 (32-bit, non-prefetchable) [size=4K]

01:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 2000 [size=128]
	Region 1: Memory at fd200000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 2080 [size=128]
	Region 1: Memory at fd200400 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 2400 [size=128]
	Region 1: Memory at fd200800 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 2480 [size=128]
	Region 1: Memory at fd200c00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

05:05.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c896 (rev 07)
	Subsystem: Hewlett-Packard Company: Unknown device 60e0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 3000 [size=256]
	Region 1: Memory at fd302000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at fd300000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:05.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c896 (rev 07)
	Subsystem: Hewlett-Packard Company: Unknown device 60e0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 25
	Region 0: I/O ports at 3400 [size=256]
	Region 1: Memory at fd302400 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at fd304000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-linux-2.4.20-pre7.out"

Linux version 2.4.20-pre7 (root@golem2) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #2 SMP Sat Sep 21 01:59:59 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000f6f60
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: E 800        APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #1 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
Processors: 1
Kernel command line: BOOT_IMAGE=linux-pre7 ro root=803 devfs=mount panic=60 console=ttyS0,115200n8
Initializing CPU#0
Detected 733.385 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1464.72 BogoMIPS
Memory: 256224k/262080k available (1479k kernel code, 5468k reserved, 509k data, 128k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
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
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.61 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 1 ... ok.
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-5, 1-9, 1-10, 1-11, 2-0, 2-1, 2-3, 2-5, 2-6, 2-7, 2-11, 2-13, 2-14, 2-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 19.
number of IO-APIC #1 registers: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
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
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    69
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 001 01  1    1    0   1   0    1    1    89
 03 000 00  1    0    0   0   0    0    0    00
 04 001 01  1    1    0   1   0    1    1    91
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 001 01  1    1    0   1   0    1    1    99
 09 001 01  1    1    0   1   0    1    1    A1
 0a 001 01  1    1    0   1   0    1    1    A9
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  1    1    0   1   0    1    1    B1
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ18 -> 1:2
IRQ20 -> 1:4
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ26 -> 1:10
IRQ28 -> 1:12
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 733.4347 MHz.
..... host bus clock speed is 133.3516 MHz.
cpu: 0, clocks: 1333516, slice: 666758
CPU0<T0:1333504,T1:666736,D:10,S:666758,C:1333516>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd9e1, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 05 [IRQ]
PCI->APIC IRQ transform: (B0,I2,P0) -> 20
PCI->APIC IRQ transform: (B0,I15,P0) -> 33
PCI->APIC IRQ transform: (B1,I4,P0) -> 18
PCI->APIC IRQ transform: (B1,I6,P0) -> 28
PCI->APIC IRQ transform: (B1,I7,P0) -> 26
PCI->APIC IRQ transform: (B5,I5,P0) -> 24
PCI->APIC IRQ transform: (B5,I5,P1) -> 25
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
ACPI: Core Subsystem version [20011018]
ACPI breakpoint: Executed AML Breakpoint opcode
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
ACPI: Power Button (FF) found
vesafb: framebuffer at 0xfc000000, mapped to 0xd0807000, size 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:4dc8
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:5:5, shift=0:10:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 1024 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:pio, hdd:pio
hda: C/H/S=59881/223/0 from BIOS ignored
hda: IC35L120AVVA07-0, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c036afc4, I/O limit 4095Mb (mask 0xffffffff)
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(33)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
SCSI subsystem driver Revision: 1.00
sym0: <896> rev 0x7 on pci bus 5 device 5 function 0 irq 24
sym0: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <896> rev 0x7 on pci bus 5 device 5 function 1 irq 25
sym1: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
blk: queue cfee9c18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: HP 18.2G  Model: MAN3184MP         Rev: HP04
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue cfee9418, I/O limit 4095Mb (mask 0xffffffff)
sym0:3:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
sym0:3: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
 /dev/scsi/host0/bus0/target3/lun0: p1 p2 p3 p4 < p5 p6 p7 >
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
md: linear personality registered as nr 1
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1352.800 MB/sec
   32regs    :   660.000 MB/sec
   pIII_sse  :  1503.600 MB/sec
   pII_mmx   :  1649.200 MB/sec
   p5_mmx    :  1720.000 MB/sec
raid5: using function: pIII_sse (1503.600 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,3), internal journal
loop: loaded (max 8 devices)
Adding Swap: 1048784k swap-space (priority 10)
Adding Swap: 511992k swap-space (priority 10)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:18:C6:13:60, IRQ 20.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 506470-151, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0xd0d06000, 00:80:C8:B9:9E:C5, IRQ 18.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at 0xd0d08400, 00:80:C8:B9:9E:C6, IRQ 5.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at 0xd0d0a800, 00:80:C8:B9:9E:C7, IRQ 28.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
eth4: Digital DS21143 Tulip rev 65 at 0xd0d0cc00, 00:80:C8:B9:9E:C8, IRQ 26.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 01:46:55 Sep 21 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
eth4: Setting full-duplex based on MII#1 link partner capability of 41e1.

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-linux-2.4.20-pre7.out"

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 48, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08

00:02.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Hewlett-Packard Company: Unknown device 10ca
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fd100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at fd000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:05.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=36
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fd200000-fd2fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 65) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 10e1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1400 [size=256]
	Region 2: Memory at fd101000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
	Subsystem: ServerWorks OSB4 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1840 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 33
	Region 0: Memory at fd102000 (32-bit, non-prefetchable) [size=4K]

01:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 2000 [size=128]
	Region 1: Memory at fd200000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 2080 [size=128]
	Region 1: Memory at fd200400 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 28
	Region 0: I/O ports at 2400 [size=128]
	Region 1: Memory at fd200800 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 26
	Region 0: I/O ports at 2480 [size=128]
	Region 1: Memory at fd200c00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

05:05.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c896 (rev 07)
	Subsystem: Hewlett-Packard Company: Unknown device 60e0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 3000 [size=256]
	Region 1: Memory at fd302000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at fd300000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:05.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c896 (rev 07)
	Subsystem: Hewlett-Packard Company: Unknown device 60e0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 25
	Region 0: I/O ports at 3400 [size=256]
	Region 1: Memory at fd302400 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at fd304000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--5mCyUwZo2JvN/JJP--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
