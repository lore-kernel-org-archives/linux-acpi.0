From: Michael Madore <mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org>
Subject: Re: APIC not enabled on Opteron
Date: Mon, 25 Aug 2003 15:04:53 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F4A8805.2090706@aslab.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCC4@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080602010209050109070402"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCC4-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080602010209050109070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brown, Len wrote:

>Michael,
>I don't see the log attachment.
>
>In any case, 2.6-test3 is missing a couple of acpi interrupt changes
>that are now in 2.4.22-rc2; and I'll be getting those changes ready for
>2.6 shortly.
>
>In the mean-time, if you want the APIC more than you want ACPI, you can
>boot with acpi=off for now and the legacy code will configure your
>interrupts.
>
>Cheers,
>-Len
>
>  
>
Here is the output from 2.4.22 with acpi enabled.  Lot of errors of the 
following form:

ACPI: Unable to set IRQ for PCI Interrupt Link [LUS0] (likely buggy ACPI 
BIOS).
Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for 
PCI Interrupt Link [LAUI] (likely buggy ACPI BIOS). Aborting ACPI-based 
IRQ routing. Try pci=noacpi or acpi=off


--------------080602010209050109070402
Content-Type: text/plain;
 name="apic_acpi.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apic_acpi.log"

 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
CPU0: AMD Opteron(tm) Processor 240 stepping 01
per-CPU timeslice cutoff: 2925.31 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
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
..... CPU clock speed is 1400.0448 MHz.
..... host bus clock speed is 200.0064 MHz.
cpu: 0, clocks: 2000064, slice: 1000032
CPU0<T0:2000064,T1:1000032,D:0,S:1000032,C:2000064>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 17, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 18, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 19, enabled at IRQ 10)
ACPI: PCI Interrupt Link [LNKD] (IRQs 17, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 16, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LUS0] (IRQs 20, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LUS1] (IRQs 20, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LUS2] (IRQs 20, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LKLN] (IRQs 21, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LAUI] (IRQs 21, enabled at IRQ 10)
ACPI: PCI Interrupt Link [LKMO] (IRQs 21, disabled)
ACPI: PCI Interrupt Link [LKSM] (IRQs 22, disabled)
ACPI: PCI Interrupt Link [LTID] (IRQs 22, disabled)
ACPI: PCI Interrupt Link [LATA] (IRQs 22, enabled at IRQ 14)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LKSM] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xa9 -> IRQ 22 Mode:1 Active:0)
00:00:01[A] -> 1-22 -> IRQ 22
ACPI: Unable to set IRQ for PCI Interrupt Link [LUS0] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LAUI] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: PCI Interrupt Link [LKMO] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xb1 -> IRQ 21 Mode:1 Active:0)
00:00:06[B] -> 1-21 -> IRQ 21
ACPI: Unable to set IRQ for PCI Interrupt Link [LUS1] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LUS2] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LKLN] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: PCI Interrupt Link [LNKB] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xb9 -> IRQ 18 Mode:1 Active:0)
00:02:03[B] -> 1-18 -> IRQ 18
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/n<7>Pin 1-18 already programmed
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/n<7>Pin 1-18 already programmed
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/n<7>Pin 1-18 already programmed
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/n<7>Pin 1-18 already programmed
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LNKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [LUS0] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LUS1] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LUS2] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LKLN] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LAUI] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: IC35L040AVER07-0, ATA DISK drive
hdc: ASUS CD-S400/A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 83k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xf8836000, IRQ -19
usb-ohci.c: usb-00:02.1, PCI device 10de:00d7 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 1
usb-ohci.c: request interrupt -19 failed
usb.c: USB bus 1 deregistered
Trying to vfree() nonexistent vm area (f8836000)
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xf8836000, IRQ -19
usb-ohci.c: usb-00:02.0, PCI device 10de:00d7 (nVidia Corporation)
usb-ohci.c: USB HC TakeOver failed!
Trying to vfree() nonexistent vm area (f8836000)
PCI: Setting latency timer of device 00:02.2 to 64
ehci_hcd 00:02.2: PCI device 10de:00d8 (nVidia Corporation)
hcd.c: request interrupt -19 failed
hcd.c: init 00:02.2 fail, -16
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 2047744k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394: Failed to allocate shared interrupt -19
ip_tables: (C) 2000-2002 Netfilter core team
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

ip_tables: (C) 2000-2002 Netfilter core team
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).

--------------080602010209050109070402--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
