From: "Anil" <anil-+qn8b3nBRqHc+919tysfdA@public.gmane.org>
Subject: Re: Contents of Acpi-devel digest...   unsubscribe
Date: Thu, 23 Jan 2003 10:18:32 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2c29a$aec2f680$0d01a8c0@anil2kacpi>
References: <E18b5SD-00033Q-00@sc8-sf-list2.sourceforge.net>
Reply-To: <anil-+qn8b3nBRqHc+919tysfdA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E18b5SD-00033Q-00-ek0oC1U1TqqnvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
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



-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of
acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Sent: Wednesday, January 22, 2003 2:26 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Acpi-devel digest, Vol 1 #772 - 3 msgs


Send Acpi-devel mailing list submissions to
	acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/acpi-devel
or, via email, send a message with subject or body 'help' to
	acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

You can reach the person managing the list at
	acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Acpi-devel digest..."


Today's Topics:

   1. Re: [PATCH] SMP parsing rewrite, phase 1 (Andrew Walrond)
   2. Re: could not map ACPI (Ducrot Bruno)
   3. Re: [PATCH] SMP parsing rewrite, phase 1 (Andrew Walrond)

--__--__--

Message: 1
Date: Tue, 21 Jan 2003 20:31:43 +0000
From: Andrew Walrond <andrew-2/QedQ4M3FBAfugRpC6u6w@public.gmane.org>
To: Andy Grover <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org>
CC: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel@sourceforge.net
Subject: [ACPI] Re: [PATCH] SMP parsing rewrite, phase 1

Results from a an Asus PR-DLS Dual Xeon HT

Don't know if this is useful, but I'll try anything that might bring
back my e1000 ;) No joy though - doesn't find all the PCI buses (14 and
18 missing - see below)

+===========================================================================
===+
| CPU Type          : Intel(R) Xeon(TM) CPU 2.60GHz
        |
| Cache Memory      : 512K,512K,512K,512K Memory Installed  : 4096M
        |
+---------------------------------------------------------------------------
---+
| Diskette Drive  A : None                Serial Port(s)    : 3F8
        |
| Diskette Drive  B : None                Parallel Port(s)  : None
        |
| Pri. Master  Disk : None                DRAM Type         : Registered
DDR   |
| Pri. Slave   Disk : None
        |
| Sec. Master  Disk : None
        |
| Sec. Slave   Disk : None
        |
+===========================================================================
===+

PCI device listing.....
Bus No. Device No. Func No. Vendor ID   Device ID   Device Class
    IRQ
----------------------------------------------------------------------------
----
    0        2         0        8086        1229     Network controller
      12
    0        3         0        1002        4752     Display controller
      10
   14        4         0        1000        0030     Mass storage
controller 14
   14        4         1        1000        0030     Mass storage
controller  3
   18        2         0        8086        100D     Network controller
      15




Press the Pause to pause or any other key to continueROM segment 0x07c0
length 0x2e00 reloc 0x9400
Etherboot 5.0.7 (GPL) Tagged ELF for [EEPRO100]
Probing...[EEPRO100]Found Intel EtherExpressPro100 ROM address 0xafc0
Ethernet addr: 00:E0:18:D2:75:9D
Searching for server (DHCP)...
Me: 10.0.0.103, Server: 10.0.0.1, Gateway 10.0.0.1
Loading 10.0.0.1:/eboot/kernels/hal.elf (ELF)1093done
Linux version 2.5.59 (root-M7ZLnNZEYR1DcWalurthmA@public.gmane.org) (gcc version 3.2) #2 SMP Tue Jan
21 17:30:26 GMT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bfffa000 (usable)
  BIOS-e820: 00000000bfffa000 - 00000000bffff000 (ACPI data)
  BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 1048576
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 819200 pages, LIFO batch:16
found SMP MP-table at 000f0490
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f4ff0
ACPI: RSDT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa000
ACPI: FADT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa145
ACPI: BOOT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa034
ACPI: SPCR (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa05c
ACPI: MADT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa0a9
ACPI: DSDT (v001   ASUS PR-DLS   00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, IRQ 16-31
ACPI: IOAPIC (id[0x04] address[0xfec02000] global_irq_base[0x20])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, IRQ 32-47
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3]
trigger[0x3])
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: ro root=/dev/nfs ip=dhcp console=tty0
console=ttyS0,115200n8 init=/boot.sh
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2591.552 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5111.80 BogoMIPS
Memory: 3100432k/4194304k available (1692k kernel code, 44152k reserved,
453k data, 312k init, 2228200k hig)Dentry cache hash table entries:
524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Total of 2 processors activated (10289.15 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2591.0101 MHz.
..... host bus clock speed is 99.0657 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf1510, last bus=22
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109
  tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:....................................................................
............Table
[DSDT] - 643 Objects with 62 Devices 202 Methods 12 Regions
ACPI Namespace successfully loaded at root c038b7fc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode
successful
    evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE31
    evgpe-0262: *** Info: GPE Block1 defined as GPE32 to GPE63
Executing all Device _STA and_INI
methods:..............................................................
62 Devices found containing: 62 _STA, 4 _INI methods
Completing Region/Field/Buffer/Package
initialization:......................................................Initial
ized
8/12 Regions 0/0 Fields 49/49 Buffers 14/14 Packages (643 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKQ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKV] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKW] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKX] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKY] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKZ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 10 11 12 14 15, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:0f.02 not
present in PCI namespace
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Root Bridge [PCI2] (00:00)
ACPI: PCI Root Bridge [PCI3] (00:00)
ACPI: PCI Root Bridge [PCI4] (00:00)
block request queues:
  128 requests per read queue
  128 requests per write queue
  8 requests per batch
  enter congestion at 15
  exit congestion at 17
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
pci_link-0343 [03] acpi_pci_link_set     : Attempt to enable at IRQ 11
resulted in IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
pci_link-0343 [03] acpi_pci_link_set     : Attempt to enable at IRQ 11
resulted in IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKJ] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKK] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKL] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKN] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKO] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKP] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKQ] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKR] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKS] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKT] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKV] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKW] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKX] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKY] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKZ] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
pci_link-0343 [03] acpi_pci_link_set     : Attempt to enable at IRQ 5
resulted in IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Enabling SEP on CPU 0
Enabling SEP on CPU 1
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Processor [CPU3] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Intel(R) PRO/100 Network Driver - version 2.1.29-k1
Copyright (c) 2002 Intel Corporation

Freeing alive device c39c4800, eth%d
e100: eth0: Intel(R) PRO/100 S Server Adapter
   Hardware receive checksums enabled

Intel(R) PRO/1000 Network Driver - version 4.4.19-k1
Copyright (c) 1999-2002 Intel Corporation.
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.103
IP-Config: Complete:



--__--__--

Message: 2
Date: Tue, 21 Jan 2003 21:42:35 +0100
To: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>,
	Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>,
	acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] could not map ACPI
From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>

On Tue, Jan 21, 2003 at 03:26:01PM +0100, Robert wrote:
>
>
> Ducrot Bruno schrieb:
>
> >On Tue, Jan 21, 2003 at 12:52:17PM +0100, Robert Woerle Paceblade/Support
> >wrote:
> >
> >
> >>Hi
> >>
> >>When i use mem=XXXM ACPI works fine , BUT i get cruel crashes when using
> >>Sound and Ethernet or/and usb togethere ( they all have IRQ 5 ) one
> >>device alone is fine .
> >>When i dont use mem=XXXM i get an error at /drivers/acpi/tables/tb_get.c
> >>BUT all the devices work fine , even together !!!
> >>i tried also mem=XXXM + acpi=nopci  which gives the same result : ACPI
> >>works and the devices crash together ....
> >>the machine is a Transmeta driving machine ...
> >>
> >>So when i look at tb_get.c at the specific functions...
> >>i see that it maps the pointers there according to a
> >>switch(adress->pointer) call !
> >>Is possible that it normally uses the
> >>case ACPI_LOGMODE_PHYSPTR:
> >>stuff but when i use mem=XXX
> >>it might use the other case statement:
> >>case ACPI_LOGMODE_LOGPTR:
> >>
> >>can i make a cruel hack around that that it always uses the working one
> >>???
> >>

The problem is that the BIOS call to retrieve memory infos give 'false'
information on how the memory controller is configured.
This is the messages you see as <4> BIOS-e820: ...  (...)

and the code is in asm at very early stage of initialisation in
arch/i386/boot/setup.S via int15 with param e820h.
In fact, the acpi tables should go to a 'special' type (the ACPI data
one) but I don't see anything at all in the BIOS-e820 calls.

I want to verify now if your DSDT table have correct infos on how
the memory controller have to be configured.


--
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


--__--__--

Message: 3
Date: Tue, 21 Jan 2003 20:54:07 +0000
From: Andrew Walrond <andrew-2/QedQ4M3FBAfugRpC6u6w@public.gmane.org>
To: Andrew Walrond <andrew-2/QedQ4M3FBAfugRpC6u6w@public.gmane.org>
CC: Andy Grover <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org>, linux-kernel@vger.kernel.org,
   acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Subject: [ACPI] Re: [PATCH] SMP parsing rewrite, phase 1

This is a multi-part message in MIME format.
--------------070606010909010907030004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

In case it's useful, lots of weird stuff happens when I boot with
pci=noacpi (see attachment),none of which results in a successful boot :(

I particularly liked this bit...

PCI: Probing PCI hardware
PCI: Discovered peer bus 0e
PCI: Discovered peer bus 12
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 13 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 18!

;)

--------------070606010909010907030004
Content-Type: text/plain;
 name="minicom.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="minicom.cap"

Linux version 2.5.59 (root-M7ZLnNZEYR1DcWalurthmA@public.gmane.org) (gcc version 3.2) #2 SMP Tue Jan 21
17:30:26 GMT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfffa000 (usable)
 BIOS-e820: 00000000bfffa000 - 00000000bffff000 (ACPI data)
 BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 819200 pages, LIFO batch:16
found SMP MP-table at 000f0490
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f4ff0
ACPI: RSDT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa000
ACPI: FADT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa145
ACPI: BOOT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa034
ACPI: SPCR (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa05c
ACPI: MADT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa0a9
ACPI: DSDT (v001   ASUS PR-DLS   00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, IRQ 16-31
ACPI: IOAPIC (id[0x04] address[0xfec02000] global_irq_base[0x20])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, IRQ 32-47
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3]
trigger[0x3])
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: ro root=/dev/nfs ip=dhcp console=tty0
console=ttyS0,115200n8 init=/boot.sh pci=noacpi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2591.566 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5111.80 BogoMIPS
Memory: 3100432k/4194304k available (1692k kernel code, 44152k reserved,
453k data, 312k init, 2228200k highmem)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Total of 2 processors activated (10289.15 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2591.0225 MHz.
..... host bus clock speed is 99.0662 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf1510, last bus=22
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:....................................................................
............................................................................
..........................................................
Table [DSDT] - 643 Objects with 62 Devices 202 Methods 12 Regions
ACPI Namespace successfully loaded at root c038b7fc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode
successful
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE31
   evgpe-0262: *** Info: GPE Block1 defined as GPE32 to GPE63
Executing all Device _STA and_INI
methods:..............................................................
62 Devices found containing: 62 _STA, 4 _INI methods
Completing Region/Field/Buffer/Package
initialization:.............................................................
..........
Initialized 8/12 Regions 0/0 Fields 49/49 Buffers 14/14 Packages (643 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKQ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKV] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKW] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKX] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKY] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKZ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 10 11 12 14 15, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:0f.02 not present in
PCI namespace
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Root Bridge [PCI2] (00:00)
ACPI: PCI Root Bridge [PCI3] (00:00)
ACPI: PCI Root Bridge [PCI4] (00:00)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
PCI: Probing PCI hardware
PCI: Discovered peer bus 0e
PCI: Discovered peer bus 12
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 13 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 18!
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Enabling SEP on CPU 0
Enabling SEP on CPU 1
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Processor [CPU3] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Intel(R) PRO/100 Network Driver - version 2.1.29-k1
Copyright (c) 2002 Intel Corporation

Freeing alive device c39c3800, eth%d
e100: eth0: Intel(R) PRO/100 S Server Adapter
  Hardware receive checksums enabled

Intel(R) PRO/1000 Network Driver - version 4.4.19-k1
Copyright (c) 1999-2002 Intel Corporation.
eth1: Intel(R) PRO/1000 Network Connection
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Sending DHCP requests .<3>e100: eth0 NIC Link is Up 100 Mbps Full duplex
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex
.<6>NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
.<6>NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
.<6>NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out

--------------070606010909010907030004--




--__--__--

_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


End of Acpi-devel Digest



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
