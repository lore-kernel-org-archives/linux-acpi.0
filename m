From: Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: ACPI source release updated (20021002)
Date: Thu, 03 Oct 2002 08:52:51 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D9C3DA3.6090005@optonline.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEF9@orsmsx119.jf.intel.com>
Reply-To: berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Tested the new patch on my Intel srmk2 server (dual-1GHz PIII(256k)  + 
AMIBIOS).
Configuration: 2.4.20-pre8 + acpi-20021002.

No improvement: the interrupt assignment does not work properly, and the 
machine does not boot.
Here the relevant pieces from dmesg:


Linux version 2.4.20-pre8 (root@option) (gcc version 2.96 20000731 (Red 
Hat Linu
x 7.1 2.96-98)) #3 SMP Thu Oct 3 04:04:43 EDT 2002

ACPI: RSDP (v000 AMI                        ) @ 0x000ff980
ACPI: RSDT (v001 RCC    RCCNILE  00000.00001) @ 0x3fff0000
ACPI: FADT (v001 RCC    RCCNILE  00000.00001) @ 0x3fff0030
ACPI: MADT (v001 RCC    RCCNILE  00000.00001) @ 0x3fff00b0
ACPI: DSDT (v001    RCC  CNB30LE 00000.00256) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x3] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x3] lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 4
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, IRQ 0-15
ACPI: IOAPIC (id[0x05] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 5
IOAPIC[1]: apic_id 5, version 17, address 0xfec01000, IRQ 16-31
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x0])
Using ACPI (MADT) for SMP configuration information
Kernel command line: auto BOOT_IMAGE=linux-cu ro root=900 
BOOT_FILE=/boot/vmlinu
z console=tty0 console=ttyS0,38400n8r
.
.
.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................


.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 997.6378 MHz.
..... host bus clock speed is 133.0180 MHz.
cpu: 0, clocks: 1330180, slice: 443393
CPU0<T0:1330176,T1:886768,D:15,S:443393,C:1330180>
cpu: 1, clocks: 1330180, slice: 443393
CPU1<T0:1330176,T1:443376,D:14,S:443393,C:1330180>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20021002
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
 dswload-0495: *** Warning: Type override - [DEB_] had invalid type 
(Integer) fo
r Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [MLIB] had invalid type 
(Integer) fo
r Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [DATA] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [SIO_] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [SB__] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [PM__] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [ICNT] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [ACPI] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [OSB4] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [PM__] had invalid type 
(String) for
 Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [WAKE] had invalid type 
(Integer) fo
r Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [RUNT] had invalid type 
(Integer) fo
r Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [BIOS] had invalid type 
(Integer) fo
r Scope operator, changed to (Scope)
 dswload-0495: *** Warning: Type override - [CMOS] had invalid type 
(Integer) fo
r Scope operator, changed to (Scope)
Parsing 
Methods:................................................................
................................................................................
...........................................
Table [DSDT] - 769 Objects with 47 Devices 187 Methods 17 Regions
ACPI Namespace successfully loaded at root c03c19fc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode 
successful
Executing all Device _STA and_INI 
methods:......................................
.........
47 Devices found containing: 47 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package 
initialization:..........................
............................................
Initialized 11/17 Regions 2/2 Fields 40/40 Buffers 17/17 Packages (769 
nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)
PCI: Probing PCI hardware
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN00] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN01] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN07] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN08] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN09] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 0
pci_link-0327 [03] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 0
dsopcode-0495 [14] Ds_init_buffer_field  : Field size 72 exceeds Buffer 
size 48
(bits)
pci_link-0316 [03] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0
pci_link-0480 [04] acpi_pci_link_get_irq : Link disabled
 pci_irq-0258 [03] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0296 [03] acpi_pci_irq_derive   : Unable to derive IRQ for 
device 00:0f
.2
PCI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off
'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
acpi_processor-1312 [07] acpi_processor_get_thr: duty_cycle spans bit 4
ACPI: Processor [CPU0] (supports C1)
acpi_processor-1312 [07] acpi_processor_get_thr: duty_cycle spans bit 4
ACPI: Processor [CPU1] (supports C1)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@sa
w.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:03:47:C9:93:22, IRQ 17.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2), 00:03:47:C9:93:23, 
IRQ 16.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.1.1 20010405 on minor 1
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver hub
md: raid1 personality registered as nr 3
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0

at this point, the kernel panics (unable to mount /)

Any ideas what's going wrong?

Thanks,
Bernd



Grover, Andrew wrote:

>Hi all,
>
>There is a new release available at http://sf.net/projects/acpi . It
>incorporates many fixes from people on this list (thanks to everyone) as
>well as some interpreter enhancements. Non-Linux source releases and iasl
>binaries will be available at
>http://developer.intel.com/technology/iapc/acpi/downloads.htm by tomorrow
>evening at the latest.
>
>Regards -- Andy
>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
