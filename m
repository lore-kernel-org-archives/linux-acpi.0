From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: Re: ACPI in kernel 2.5.68 works better (for me) than 2.5.69
Date: 06 May 2003 15:04:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052226287.646.4.camel@chevrolet.hybel>
References: <1052180986.1005.3.camel@chevrolet.hybel>
	 <20030506112053.GO2954@poup.poupinou.org>
	 <1052222508.5614.5.camel@chevrolet.hybel>
	 <20030506123650.GR2954@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xsuWb6BrWzXQYNsVMVbM"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030506123650.GR2954-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-xsuWb6BrWzXQYNsVMVbM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tir, 06.05.2003 kl. 14.36 skrev Ducrot Bruno:
> On Tue, May 06, 2003 at 02:01:48PM +0200, Stian Jordet wrote:
> > tir, 06.05.2003 kl. 13.20 skrev Ducrot Bruno:
> > > On Tue, May 06, 2003 at 02:29:46AM +0200, Stian Jordet wrote:
> > > > Hi,
> > > > 
> > > > Since kernel 2.5.69, usb no longer work with acpi on my computer. With
> > > > 2.5.68 it did. Do you know what changes you have done might cause this?
> > > > 
> > > > I get this error, but this one is with both .68 and .69.
> > > > 
> > > > ACPI-0109: *** Error: No object was returned from
> > > > [\_SB_.PCI0.PX40.IRDA._STA] (Node dff5cc80), AE_NOT_EXIST
> > > 
> > > A pointer to your DSDT will be appreciate...
> > 
> > I'm probably just stupid, but I have been searching a bit, and I can't
> > seem to find information about how to find it anywhere.. With 2.4 it was
> > under /proc/acpi, but not in 2.5.. Hmm..
> 
> Ok.  I must admit I don't know for 2.5.  Then just grab acpidump
> from sf'cvs :
> 
> cvs -d:pserver:anonymous-CZy7tVeV0kv+F7Cq6hUZDNHuzzzSOjJt@public.gmane.org:/cvsroot/acpi login
> cvs -z3 -d:pserver:anonymous-CZy7tVeV0kv+F7Cq6hUZDNHuzzzSOjJt@public.gmane.org:/cvsroot/acpi co acpidump
> 
> then, in acpidump directory, do a make and a
> ./acpidump -b DSDT > dsdt
> then send me a gzipped version to this one (or place a pointer in www,
> ftp, etc.).

Thanks :)

> > > > This is a Asus CUV266-DLS smp motherboard, and thus I need acpi to power
> > > > it off, and it would have been very, very much apprpeciated if this
> > > > somehow could be fixed before 2.6, atleast. I don't want to be running
> > > > 2.5.68 for ever :)
> > > > 
> > > 
> > > 
> > > Stupid question: does USB work without ACPI?
> > 
> > It does indeed (with MPS1.4 disabled). But it has worked with at least
> > the 15 last 2.5.x kernels...
> 
> IMHO, it is likely to be a problem with IRQ and IO-APIC.  Andy should
> answer more on this than me.  But I guess that at first a
> cat /proc/interrupts
> may help (with and without acpi), and with attached dmesgs.

You are most likely right, it is a irq problem for sure. When you look
at the atteched /proc/interrupts, you can see that 2.5.69 with acpi, the
usb host-controller doesn't get interrupts.

I just hope Andy has the time to look at this, but since I'm obviously
the only one getting hit by this, I don't have my hopes to high :( But
since it worked in .68, it shouldn't be impossible.

And I really appreciate some feedback :) Thanks.

Best regards,
Stian

--=-xsuWb6BrWzXQYNsVMVbM
Content-Disposition: attachment; filename=dmesg-2.5.68-withacpi
Content-Type: text/plain; name=dmesg-2.5.68-withacpi; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.5.68 (root@chevrolet) (gcc version 3.2.3) #1 SMP Wed Apr 30 23:51:38 CEST 2003
Video mode to be used for restore is 0
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
found SMP MP-table at 000f5500
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6930
ACPI: RSDT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CV266DLS 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/sda2 ro idebus=33 vga=0
ide_setup: idebus=33
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1000.418 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1957.88 BogoMIPS
Memory: 514044k/524272k available (2875k kernel code, 9440k reserved, 790k data, 152k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.00 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3952.64 BogoMIPS).
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
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
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
 09 001 01  1    1    0   1   0    1    1    71
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
..... CPU clock speed is 999.0641 MHz.
..... host bus clock speed is 133.0285 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030328
    ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.PX40.IRDA._STA] (Node dff5cc80), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
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
Bluetooth: Core ver 2.2
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 266 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
Freeing alive device dfdb6000, eth%d
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD1200JB-00CRA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, UDMA(100)
 hda: hda1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi1:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi1:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi1:A:6): 7.812MB/s transfers (7.812MHz, offset 15)
  Vendor: PIONEER   Model: DVD-ROM DVD-304F  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW-F1S           Rev: 1.0f
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: DAT    04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20030413, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0
sr1: scsi3-mmc drive: 44x/44x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 5, lun 0
PCI: Enabling device 00:0f.0 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq18
Socket status: 30000810
PCI: Enabling device 00:0f.1 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq19
Socket status: 30000006
input: PC Speaker
gameport: Creative Labs SB Live! MIDI/Game P at pci00:0e.1 speed 1193 kHz
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
vt596 smbus 00:11.0: Found Via VIA Technologies, In VT8233 PCI to ISA Br device
registering 1-002d
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 0.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 738948k swap on /dev/sda5.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,2), internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:11.2: VIA Technologies, In USB
uhci-hcd 00:11.2: irq 9, io base 00009800
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 00:11.3: VIA Technologies, In USB (#2)
uhci-hcd 00:11.3: irq 9, io base 00009400
uhci-hcd 00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 00:11.4: VIA Technologies, In USB (#3)
uhci-hcd 00:11.4: irq 9, io base 00009000
uhci-hcd 00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
Bluetooth: HCI USB driver ver 2.1
drivers/usb/core/usb.c: registered new driver hci_usb
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
drivers/usb/core/usb.c: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS volume version 3.0.
hub 1-0:0: new USB device on port 1, assigned address 2
NTFS volume version 3.0.
usb 1-1: USB device not accepting new address=2 (error=-110)
hub 1-0:0: new USB device on port 1, assigned address 3
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
pl2303 3-1:0: PL-2303 converter detected
usb 3-1: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
hub 3-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 2, assigned address 3
drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x011d) now attached to usb/scanner0
e100: eth0 NIC Link is Up 100 Mbps Full duplex

--=-xsuWb6BrWzXQYNsVMVbM
Content-Disposition: attachment; filename=dmesg-2.5.69-noacpi
Content-Type: text/plain; name=dmesg-2.5.69-noacpi; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.5.69 (root@chevrolet) (gcc version 3.2.3) #1 SMP Mon May 5 14:01:31 CEST 2003
Video mode to be used for restore is 0
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
found SMP MP-table at 000f5500
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #3 6:8 APIC version 17
Processor #0 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: root=/dev/sda2 ro idebus=33 vga=0 acpi=off
ide_setup: idebus=33
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1000.416 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1957.88 BogoMIPS
Memory: 514020k/524272k available (2877k kernel code, 9464k reserved, 792k data, 176k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.00 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3952.64 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-13, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
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
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0641 MHz.
..... host bus clock speed is 133.0285 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
ACPI: Disabled via command line (acpi=off)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3074] at 00:11.0
Initializing RT netlink socket
Bluetooth: Core ver 2.2
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 266 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
Freeing alive device dfdd7000, eth%d
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD1200JB-00CRA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, UDMA(100)
 hda: hda1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi1:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi1:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi1:A:6): 7.812MB/s transfers (7.812MHz, offset 15)
  Vendor: PIONEER   Model: DVD-ROM DVD-304F  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW-F1S           Rev: 1.0f
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: DAT    04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20030413, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0
sr1: scsi3-mmc drive: 44x/44x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 5, lun 0
PCI: Enabling device 00:0f.0 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq5
Socket status: 30000810
PCI: Enabling device 00:0f.1 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq9
Socket status: 30000006
input: PC Speaker
gameport: Creative Labs SB Live! MIDI/Game P at pci00:0e.1 speed 1193 kHz
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
registering 1-002d
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 0.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 738948k swap on /dev/sda5.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda2, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:11.2: VIA Technologies, In USB
uhci-hcd 00:11.2: irq 9, io base 00009800
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 00:11.3: VIA Technologies, In USB (#2)
uhci-hcd 00:11.3: irq 9, io base 00009400
uhci-hcd 00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 00:11.4: VIA Technologies, In USB (#3)
uhci-hcd 00:11.4: irq 9, io base 00009000
uhci-hcd 00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
Bluetooth: HCI USB driver ver 2.4
drivers/usb/core/usb.c: registered new driver hci_usb
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
drivers/usb/core/usb.c: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS volume version 3.0.
NTFS volume version 3.0.
hub 1-0:0: new USB device on port 1, assigned address 2
usb 1-1: USB device not accepting new address=2 (error=-110)
hub 1-0:0: new USB device on port 1, assigned address 3
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
pl2303 3-1:0: PL-2303 converter detected
usb 3-1: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
hub 3-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 2, assigned address 3
drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x011d) now attached to usb/scanner0
e100: eth0 NIC Link is Up 100 Mbps Full duplex
usb 1-1: USB disconnect, address 3
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 4

--=-xsuWb6BrWzXQYNsVMVbM
Content-Disposition: attachment; filename=dmesg-2.5.69-withacpi
Content-Type: text/plain; name=dmesg-2.5.69-withacpi; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.5.69 (root@chevrolet) (gcc version 3.2.3) #1 SMP Mon May 5 14:01:31 CEST 2003
Video mode to be used for restore is 0
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
found SMP MP-table at 000f5500
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6930
ACPI: RSDT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CV266DLS 12336.12337) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CV266DLS 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/sda2 ro idebus=33 vga=0
ide_setup: idebus=33
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1000.416 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1957.88 BogoMIPS
Memory: 514020k/524272k available (2877k kernel code, 9464k reserved, 792k data, 176k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.00 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3952.64 BogoMIPS).
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
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
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
 09 001 01  1    1    0   1   0    1    1    71
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
..... CPU clock speed is 999.0519 MHz.
..... host bus clock speed is 133.0269 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
    ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.PX40.IRDA._STA] (Node dff5fc40), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
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
IOAPIC[0]: Set PCI routing entry (2-11 -> 0x81 -> IRQ 11)
00:00:11[A] -> 2-11 -> IRQ 11
IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10)
00:00:11[B] -> 2-10 -> IRQ 10
IOAPIC[0]: Set PCI routing entry (2-5 -> 0x51 -> IRQ 5)
00:00:11[C] -> 2-5 -> IRQ 5
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9)
00:00:11[D] -> 2-9 -> IRQ 9
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Initializing RT netlink socket
Bluetooth: Core ver 2.2
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 266 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
Freeing alive device dfdbe000, eth%d
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD1200JB-00CRA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, UDMA(100)
 hda: hda1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi1:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi1:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi1:A:6): 7.812MB/s transfers (7.812MHz, offset 15)
  Vendor: PIONEER   Model: DVD-ROM DVD-304F  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW-F1S           Rev: 1.0f
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: DAT    04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20030413, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0
sr1: scsi3-mmc drive: 44x/44x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 5, lun 0
PCI: Enabling device 00:0f.0 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq18
Socket status: 30000810
PCI: Enabling device 00:0f.1 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq19
Socket status: 30000006
input: PC Speaker
gameport: Creative Labs SB Live! MIDI/Game P at pci00:0e.1 speed 1193 kHz
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
registering 1-002d
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 0.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 738948k swap on /dev/sda5.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda2, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:11.2: VIA Technologies, In USB
uhci-hcd 00:11.2: irq 9, io base 00009800
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 00:11.3: VIA Technologies, In USB (#2)
uhci-hcd 00:11.3: irq 9, io base 00009400
uhci-hcd 00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 00:11.4: VIA Technologies, In USB (#3)
uhci-hcd 00:11.4: irq 9, io base 00009000
uhci-hcd 00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
Bluetooth: HCI USB driver ver 2.4
drivers/usb/core/usb.c: registered new driver hci_usb
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
drivers/usb/core/usb.c: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS volume version 3.0.
hub 1-0:0: new USB device on port 1, assigned address 2
NTFS volume version 3.0.
e100: eth0 NIC Link is Up 100 Mbps Full duplex
drivers/usb/core/message.c: usb_control/bulk_msg: timeout

--=-xsuWb6BrWzXQYNsVMVbM
Content-Disposition: attachment; filename=interrupts-2.5.68-withacpi
Content-Type: text/plain; name=interrupts-2.5.68-withacpi; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

           CPU0       CPU1       
  0:      61771         46    IO-APIC-edge  timer
  1:        158          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          4          0    IO-APIC-edge  rtc
  9:        292          1   IO-APIC-level  acpi, uhci-hcd, uhci-hcd, uhci-hcd
 12:         59          1    IO-APIC-edge  i8042
 14:         22          0    IO-APIC-edge  ide0
 17:       2611          0   IO-APIC-level  aic7xxx, EMU10K1
 18:        178          1   IO-APIC-level  aic7xxx, Ricoh Co Ltd RL5c476 II, ide2
 19:        161          0   IO-APIC-level  Ricoh Co Ltd RL5c476 II (#2), eth0
NMI:          0          0 
LOC:      61651      61650 
ERR:          0
MIS:          0

--=-xsuWb6BrWzXQYNsVMVbM
Content-Disposition: attachment; filename=interrupts-2.5.69-noacpi
Content-Type: text/plain; name=interrupts-2.5.69-noacpi; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

           CPU0       CPU1       
  0:   40841046         15    IO-APIC-edge  timer
  1:      18916          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  5:        516          0   IO-APIC-level  aic7xxx, Ricoh Co Ltd RL5c476 II, ide2
  8:          4          0    IO-APIC-edge  rtc
  9:      57571          1   IO-APIC-level  Ricoh Co Ltd RL5c476 II (#2), uhci-hcd, uhci-hcd, uhci-hcd, eth0
 10:      80190          1   IO-APIC-level  aic7xxx, EMU10K1
 12:     137138          1    IO-APIC-edge  i8042
 14:      93587          1    IO-APIC-edge  ide0
NMI:          0          0 
LOC:   40839484   40839483 
ERR:          0
MIS:          0

--=-xsuWb6BrWzXQYNsVMVbM
Content-Disposition: attachment; filename=interrupts-2.5.69-withacpi
Content-Type: text/plain; name=interrupts-2.5.69-withacpi; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

           CPU0       CPU1       
  0:      80499         27    IO-APIC-edge  timer
  1:        253          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          4          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi, uhci-hcd, uhci-hcd, uhci-hcd
 12:         59          1    IO-APIC-edge  i8042
 14:         21          1    IO-APIC-edge  ide0
 17:       2996          1   IO-APIC-level  aic7xxx, EMU10K1
 18:        147          1   IO-APIC-level  aic7xxx, Ricoh Co Ltd RL5c476 II, ide2
 19:        161          1   IO-APIC-level  Ricoh Co Ltd RL5c476 II (#2), eth0
NMI:          0          0 
LOC:      80367      80366 
ERR:          0
MIS:          0

--=-xsuWb6BrWzXQYNsVMVbM
Content-Disposition: attachment; filename=dsdt.gz
Content-Type: application/x-gzip; name=dsdt.gz
Content-Transfer-Encoding: base64

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

--=-xsuWb6BrWzXQYNsVMVbM--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
