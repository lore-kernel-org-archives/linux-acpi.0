From: Eli Stair <eli.stair-+MseY0pMZYIAvxtiuMwx3w@public.gmane.org>
Subject: ACPI & SMP still don't work together happily.
Date: Mon, 7 Oct 2002 19:21:39 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021007192139.2e775717.eli.stair@mchsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

ACPI has been non-functional on an SMP system I have since I built it.
ACPI works fine as long as SMP support is _not_ compiled into my kernel,
all devices are enumerated properly with correct IRQ's, everything works.
With all currently available kernels (with ACPI patches, using 2.5.xx, 
stock kernels etc...) it is a no go.  With both enabled, the system
seems unable to read the IRQ routing table from ACPI, while it works
with SMP gone.

Here's a snip of a serial console  boot msg., more is available, and I 
am willing to do whatever I can to help out in tracking this down.
If I remove the AIC_78xx driver, something similar happens to my 3Ware
disk controller, and if I remove that, it gets as far as my SBLive card
and has serious oopses.  

Thanks,

Eli Stair

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Linux version 2.5.41 (root@Padmasambhava) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #4 SMP Mon Oct 7 18:54:35 EDT 2002
...
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5980
...
On node 0 totalpages: 131056
  DMA zone: 4096 pages
  Normal zone: 126960 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7200
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: MADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff5680
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
...
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...........................................................................
Table [DSDT] - 306 Objects with 26 Devices 75 Methods 19 Regions
ACPI Namespace successfully loaded at root c04ff77c
evxfevnt-0063 [04] Acpi_enable           : Already in ACPI mode.
Executing all Device _STA and_INI methods:..........................
26 Devices found containing: 26 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:....................................
Initialized 16/19 Regions 0/0 Fields 14/14 Buffers 6/6 Packages (306 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
rscreate-0307 [10] Rs_create_pci_routing_: Need Integer, found Reference
 pci_irq-0207 [07] acpi_pci_irq_add_prt  : Error evaluating _PRT [AE_BAD_DATA]
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:07.02 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!
...
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
...
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x48
ACCUM = 0x3, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x2
 DFCNTRL = 0x0, DFSTATUS = 0x2d
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0x0
STACK == 0x3, 0x0, 0x0, 0x190
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Pending list: 
Kernel Free SCB list: 3 1 0 
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x48
ACCUM = 0x2, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x2
 DFCNTRL = 0x0, DFSTATUS = 0x2d
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0x0
STACK == 0x3, 0x0, 0x0, 0x190
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Pending list: 
Kernel Free SCB list: 2 1 0 
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x48
ACCUM = 0x3, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x2
 DFCNTRL = 0x0, DFSTATUS = 0x2d
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0x0
STACK == 0x3, 0x0, 0x0, 0x190
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
