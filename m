From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: Re: ACPI patches updated (20021111)
Date: 13 Nov 2002 22:01:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037221316.825.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-LVNOOffD6FcGQ6heySzf"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-LVNOOffD6FcGQ6heySzf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tir, 2002-11-12 kl. 21:48 skrev Grover, Andrew: 
> Hi all,
> 
> New patches are up on sf.net/projects/acpi.
This did not help my acpi+usb trouble. I will try this one last time. 

I have an Asus CUV266-DLS dual P3 motherboard, which USB won't work when
I use acpi. 

With acpi I get this error:

hub.c: new USB device 00:11.2-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:11.2-1, assigned address 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)

Without ACPI it works perfect (but I can not have MPS1.4 enabled, but
that's ok). Then I get this output:

hub.c: new USB device 00:11.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc504) is not claimed by any
active driver.
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input0: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb1:2.0
input1: USB HID v1.10 Mouse [Logitech USB Receiver] on usb1:2.1
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers

I have changed in BIOS so that acpi and usb does not use the same irq,
but that did not help.

/proc/interrupts with acpi:
stianj@chevrolet:~$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    1266787    1152993    IO-APIC-edge  timer
  1:      33475      35520    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:         10          9    IO-APIC-edge  serial
  5:     269867     266825    IO-APIC-edge  usb-uhci, usb-uhci, usb-uhci
  8:          2          1    IO-APIC-edge  rtc
  9:        614        722   IO-APIC-level  acpi
12:     231716     231615    IO-APIC-edge  PS/2 Mouse
14:      22395      25783    IO-APIC-edge  ide0
15:       4036       3511    IO-APIC-edge  ide1
17:     257388     255922   IO-APIC-level  aic7xxx, EMU10K1
18:        433        387   IO-APIC-level  aic7xxx, Ricoh Co Ltd RL5c476
II
19:     267424     270449   IO-APIC-level  Ricoh Co Ltd RL5c476 II (#2),
eth0, ide2, saa7134[0]
NMI:          0          0 
LOC:    2420129    2420126 
ERR:          0
MIS:          0

/proc/interrupts without acpi:
stianj@chevrolet:~$ cat /proc/interrupts 
           CPU0       CPU1       
  0:      27365      20033    IO-APIC-edge  timer
  1:          2          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          1          1    IO-APIC-edge  serial
  5:        893        757   IO-APIC-level  Ricoh Co Ltd RL5c476 II
(#2), usb-uhci, usb-uhci, usb-uhci, eth0, ide2
  8:          2          1    IO-APIC-edge  rtc
 10:       3632       3649   IO-APIC-level  aic7xxx, EMU10K1
 12:        113        111   IO-APIC-level  aic7xxx, Ricoh Co Ltd
RL5c476 II
 14:         24         10    IO-APIC-edge  ide0
 15:         14          3    IO-APIC-edge  ide1
NMI:          0          0 
LOC:      47314      47313 
ERR:          0
MIS:          0

I have attached a dmesg with acpi. I'm not sure this is solveable, but I
have to give it a last try. I'm stressing this because my computer won't
turn off without acpi (I have tried apm=power-off), and I'm getting a
usb-scanner soon.

Thanks.

Best regards,
Stian Jordet

--=-LVNOOffD6FcGQ6heySzf
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.4.20-rc1 (root@chevrolet) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP ons nov 13 01:18:55 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000f5500
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6930
ACPI: RSDT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CV266DLS 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 Pentium(tm) Pro APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: root=/dev/sda2 ro idebus=33
ide_setup: idebus=33
Initializing CPU#0
Detected 999.744 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 514972k/524272k available (1969k kernel code, 8912k reserved, 727k data, 104k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
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
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.73 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1998.84 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3991.14 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
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
 09 003 03  1    1    0   1   0    1    1    71
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.5597 MHz.
..... host bus clock speed is 133.2744 MHz.
cpu: 0, clocks: 1332744, slice: 444248
CPU0<T0:1332736,T1:888480,D:8,S:444248,C:1332744>
cpu: 1, clocks: 1332744, slice: 444248
CPU1<T0:1332736,T1:444240,D:0,S:444248,C:1332744>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20021111
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
    ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17)
00:00:07[A] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18)
00:00:07[B] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19)
00:00:05[A] -> 2-19 -> IRQ 19
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16)
00:00:0c[B] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
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
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver v1.1.22 [Flags: R/O]
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST360021A, ATA DISK drive
hdc: Maxtor 90432D2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0412964, I/O limit 4095Mb (mask 0xffffffff)
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63, UDMA(100)
blk: queue c0412cc8, I/O limit 4095Mb (mask 0xffffffff)
hdc: 8440992 sectors (4322 MB) w/512KiB Cache, CHS=8374/16/63, UDMA(33)
Partition check:
 hda: hda1 < hda5 hda6 >
 hdc: [PTBL] [525/255/63] hdc1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.1.24-k1
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) 8255x-based Ethernet Adapter
  Mem:0xde000000  IRQ:19  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: unsupported bridge
agpgart: no supported devices found.
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: PIONEER   Model: DVD-ROM DVD-304F  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: DAT    04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20020805, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 5, lun 0
(scsi1:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
(scsi1:A:5): 20.000MB/s transfers (20.000MHz, offset 7)
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Creative EMU10K1 PCI Audio Driver, version 0.19, 01:21:04 Nov 13 2002
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xa800-0xa81f, IRQ 17
ac97_codec: AC97 Audio codec, id: v8(SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:0f.0 (0000 -> 0002)
PCI: Enabling device 00:0f.1 (0000 -> 0002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0000, PCI irq18
Socket status: 30000006
Yenta IRQ list 0000, PCI irq19
Socket status: 30000810
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
Adding Swap: 738948k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 01:26:16 Nov 13 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x9800, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0x9400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0x9000, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
mice: PS/2 mouse device common for all mice
e100: eth0 NIC Link is Up 100 Mbps Full duplex

--=-LVNOOffD6FcGQ6heySzf--



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
