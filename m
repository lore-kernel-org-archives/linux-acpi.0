From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Wed, 21 Jun 2006 11:43:45 -0700
Message-ID: <1150915426.5830.21.camel@keithlap>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	 <437F1766.8090705@jp.fujitsu.com> <1150853300.5873.49.camel@keithlap>
	 <20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150863525.7865.6.camel@keithlap>
	 <20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dmLqg+0L59rJpUDU7AdJ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:39072 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932346AbWFUSzl
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 14:55:41 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5LItfQD006778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 14:55:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5LIlSPb105556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 12:55:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5LIhscF029932
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 12:43:56 -0600
In-Reply-To: <20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, konrad <darnok@us.ibm.com>, robert.moore@intel.com, lhms-devel <lhms-devel@lists.sourceforge.net>, linux acpi <linux-acpi@vger.kernel.org>


--=-dmLqg+0L59rJpUDU7AdJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-06-21 at 19:48 +0900, KAMEZAWA Hiroyuki wrote:
> On Tue, 20 Jun 2006 21:18:45 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > On Wed, 2006-06-21 at 11:43 +0900, KAMEZAWA Hiroyuki wrote:
> > > On Tue, 20 Jun 2006 18:28:19 -0700
> > > keith mannthey <kmannth@us.ibm.com> wrote: 
> > > > 1. The current driver is unable to created the mem_device from the hot-
> > > > add event and the hot-add fails with out adding any memory to the
> > > > system. I have address_resources attached to the acpi handle but in
> > > > acpi_memory_get_device calling the path of 
> > > > 
> > > > acpi_bus_get_device
> > > > acpi_get_parent
> > > > acpi_bus_get_device /*for parent*/
> > > > acpi_bus_add /*to created the memory device */
> > > > 
> > > 
> > > Do you know where it fails ? 
> > > 1st acpi_bus_get_device() fails or acpi_bus_add() doesn't allocate memory_device ?
> > 
> >         if (!acpi_bus_get_device(handle, &device) && device)
> >                 goto end;
> > fails right away.  

Looks like I fail later that I thought.

When I apply your patch and do a hot add I see

ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No context for object
[ffff81017fc74240] [20060310]
ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No context for object
[ffff81017fc74240] [20060310]

 driver data not foundACPI Error (acpi_memory-0338): Cannot find driver
data [20060310]

(I have attaced the whole dmesg as well)

This implies that I have called acpi_bus_add but didn't create the
memory_device.  

> Could you tell me whether the device you want to add is visible in sysfs's
> acpi name space before hot-add event ?
> If kobject(sysfs) is registerd, it's considered as Enabled && Present.
> (In my understanding)

There are no off lined memory objects in sysfs after boot all memory
listed is present in the system and online.  

-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

--=-dmLqg+0L59rJpUDU7AdJ
Content-Disposition: attachment; filename=debug-mess
Content-Type: text/plain; name=debug-mess; charset=UTF-8
Content-Transfer-Encoding: 7bit


otdata ok (command line is root=/dev/sda4 vga=791  ip=9.47.66.153:9.47.66.169:9.47.66.1:255.255.255.0 resume=/dev/sda2  splash=silent showopts console=ttyS0,115200 console=tty0 earlyprintk=ttyS0,115200 debug numa=hotadd=100)
Linux version 2.6.17-rc6-mm2-smp (root@linux-65o4) (gcc version 4.1.0 (SUSE Linux)) #4 SMP Wed Jun 21 14:08:13 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099c00 (usable)
 BIOS-e820: 0000000000099c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff8da40 (usable)
 BIOS-e820: 000000007ff8da40 - 000000007ff98880 (ACPI data)
 BIOS-e820: 000000007ff98880 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
DMI 2.3 present.
ACPI: RSDP (v000 IBM                                   ) @ 0x00000000000fdcf0
ACPI: RSDT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x000000007ff98800
ACPI: FADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x000000007ff98780
ACPI: MADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x000000007ff98600
ACPI: SRAT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @ 0x000000007ff98400
ACPI: SSDT (v001 IBM    VIGSSDT0 0x00001000 INTL 0x20030122) @ 0x000000007ff90800
ACPI: DSDT (v001 IBM    EXA01ZEU 0x00001000 INTL 0x20030122) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 0 -> APIC 2 -> Node 0
SRAT: PXM 0 -> APIC 3 -> Node 0
SRAT: PXM 0 -> APIC 38 -> Node 0
SRAT: PXM 0 -> APIC 39 -> Node 0
SRAT: PXM 0 -> APIC 36 -> Node 0
SRAT: PXM 0 -> APIC 37 -> Node 0
SRAT: PXM 0 -> APIC 16 -> Node 0
SRAT: PXM 0 -> APIC 17 -> Node 0
SRAT: PXM 0 -> APIC 18 -> Node 0
SRAT: PXM 0 -> APIC 19 -> Node 0
SRAT: PXM 0 -> APIC 54 -> Node 0
SRAT: PXM 0 -> APIC 55 -> Node 0
SRAT: PXM 0 -> APIC 52 -> Node 0
SRAT: PXM 0 -> APIC 53 -> Node 0
SRAT: Node 0 PXM 0 0-80000000
SRAT: Node 0 PXM 0 0-180000000
NUMA: Using 63 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000180000000
On node 0 totalpages: 1025617
  DMA zone: 2700 pages, LIFO batch:0
  DMA32 zone: 505797 pages, LIFO batch:31
  Normal zone: 517120 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x9c
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x26] enabled)
Processor #38 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x27] enabled)
Processor #39 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x24] enabled)
Processor #36 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x25] enabled)
Processor #37 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x10] enabled)
Processor #16 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x11] enabled)
Processor #17 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x12] enabled)
Processor #18 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x13] enabled)
Processor #19 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x36] enabled)
Processor #54 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x37] enabled)
Processor #55 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x34] enabled)
Processor #52 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x35] enabled)
Processor #53 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x09] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0a] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0b] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0c] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0d] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0e] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0f] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 15, version 17, address 0xfec00000, GSI 0-35
ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[36])
IOAPIC[1]: apic_id 14, version 17, address 0xfec01000, GSI 36-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ8 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
Setting APIC routing to clustered
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
SMP: Allowing 16 CPUs, 0 hotplug CPUs
Built 1 zonelists.  Total pages: 1025617
Kernel command line: root=/dev/sda4 vga=791  ip=9.47.66.153:9.47.66.169:9.47.66.1:255.255.255.0 resume=/dev/sda2  splash=silent showopts console=ttyS0,115200 console=tty0 earlyprintk=ttyS0,115200 debug numa=hotadd=100
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
disabling early console
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
PCI-DMA: Calgary IOMMU detected. TCE table spec is 7.
Memory: 4059856k/6291456k available (1986k kernel code, 133576k reserved, 922k data, 200k init)
Calibrating delay using timer specific routine.. 6012.23 BogoMIPS (lpj=12024464)Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0006) - 176 Objects with 17 Devices 45 Methods 4 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 990 Objects with 57 Devices 247 Methods 19 Regions
ACPI Namespace successfully loaded at root ffffffff80551ec0
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 10425667
Detected 10.425 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/16 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6005.50 BogoMIPS (lpj=12011002)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU1: 00(40)
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -108 cycles, maxerr 927 cycles)
SMP alternatives: switching to SMP code
Booting processor 2/16 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 6005.65 BogoMIPS (lpj=12011309)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 2/2 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU2: 00(40)
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -45 cycles, maxerr 1602 cycles)
SMP alternatives: switching to SMP code
Booting processor 3/16 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 6005.61 BogoMIPS (lpj=12011237)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 3/3 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU3: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU3: 00(40)
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff 45 cycles, maxerr 1602 cycles)
SMP alternatives: switching to SMP code
Booting processor 4/16 APIC 0x26
Initializing CPU#4
Calibrating delay using timer specific routine.. 6005.66 BogoMIPS (lpj=12011335)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 4/26 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 1
CPU4: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU4: 00(40)
CPU 4: Syncing TSC to CPU 0.
CPU 4: synchronized TSC with CPU 0 (last diff 31 cycles, maxerr 1593 cycles)
SMP alternatives: switching to SMP code
Booting processor 5/16 APIC 0x27
Initializing CPU#5
Calibrating delay using timer specific routine.. 6005.72 BogoMIPS (lpj=12011441)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 5/27 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 1
CPU5: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU5: 00(40)
CPU 5: Syncing TSC to CPU 0.
CPU 5: synchronized TSC with CPU 0 (last diff 14 cycles, maxerr 1602 cycles)
SMP alternatives: switching to SMP code
Booting processor 6/16 APIC 0x24
Initializing CPU#6
Calibrating delay using timer specific routine.. 6005.78 BogoMIPS (lpj=12011566)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 6/24 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 0
CPU6: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU6: 00(40)
CPU 6: Syncing TSC to CPU 0.
CPU 6: synchronized TSC with CPU 0 (last diff 81 cycles, maxerr 1746 cycles)
SMP alternatives: switching to SMP code
Booting processor 7/16 APIC 0x25
Initializing CPU#7
Calibrating delay using timer specific routine.. 6005.72 BogoMIPS (lpj=12011456)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 7/25 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 0
CPU7: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU7: 00(40)
CPU 7: Syncing TSC to CPU 0.
CPU 7: synchronized TSC with CPU 0 (last diff 14 cycles, maxerr 1602 cycles)
SMP alternatives: switching to SMP code
Booting processor 8/16 APIC 0x10
Initializing CPU#8
Calibrating delay using timer specific routine.. 6005.72 BogoMIPS (lpj=12011458)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 8/10 -> Node 0
CPU: Physical Processor ID: 4
CPU: Processor Core ID: 0
CPU8: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU8: 00(40)
CPU 8: Syncing TSC to CPU 0.
CPU 8: synchronized TSC with CPU 0 (last diff -9 cycles, maxerr 2340 cycles)
SMP alternatives: switching to SMP code
Booting processor 9/16 APIC 0x11
Initializing CPU#9
Calibrating delay using timer specific routine.. 6005.71 BogoMIPS (lpj=12011423)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 9/11 -> Node 0
CPU: Physical Processor ID: 4
CPU: Processor Core ID: 0
CPU9: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU9: 00(40)
CPU 9: Syncing TSC to CPU 0.
CPU 9: synchronized TSC with CPU 0 (last diff 9 cycles, maxerr 2358 cycles)
SMP alternatives: switching to SMP code
Booting processor 10/16 APIC 0x12
Initializing CPU#10
Calibrating delay using timer specific routine.. 6005.73 BogoMIPS (lpj=12011471)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 10/12 -> Node 0
CPU: Physical Processor ID: 4
CPU: Processor Core ID: 1
CPU10: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU10: 00(40)
CPU 10: Syncing TSC to CPU 0.
CPU 10: synchronized TSC with CPU 0 (last diff 22 cycles, maxerr 2367 cycles)
SMP alternatives: switching to SMP code
Booting processor 11/16 APIC 0x13
Initializing CPU#11
Calibrating delay using timer specific routine.. 6005.68 BogoMIPS (lpj=12011361)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 11/13 -> Node 0
CPU: Physical Processor ID: 4
CPU: Processor Core ID: 1
CPU11: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU11: 00(40)
CPU 11: Syncing TSC to CPU 0.
CPU 11: synchronized TSC with CPU 0 (last diff 18 cycles, maxerr 2340 cycles)
SMP alternatives: switching to SMP code
Booting processor 12/16 APIC 0x36
Initializing CPU#12
Calibrating delay using timer specific routine.. 6005.62 BogoMIPS (lpj=12011244)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 12/36 -> Node 0
CPU: Physical Processor ID: 13
CPU: Processor Core ID: 1
CPU12: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU12: 00(40)
CPU 12: Syncing TSC to CPU 0.
CPU 12: synchronized TSC with CPU 0 (last diff 9 cycles, maxerr 2358 cycles)
SMP alternatives: switching to SMP code
Booting processor 13/16 APIC 0x37
Initializing CPU#13
Calibrating delay using timer specific routine.. 6005.73 BogoMIPS (lpj=12011478)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 13/37 -> Node 0
CPU: Physical Processor ID: 13
CPU: Processor Core ID: 1
CPU13: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU13: 00(40)
CPU 13: Syncing TSC to CPU 0.
CPU 13: synchronized TSC with CPU 0 (last diff 2 cycles, maxerr 2340 cycles)
SMP alternatives: switching to SMP code
Booting processor 14/16 APIC 0x34
Initializing CPU#14
Calibrating delay using timer specific routine.. 6005.74 BogoMIPS (lpj=12011491)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 14/34 -> Node 0
CPU: Physical Processor ID: 13
CPU: Processor Core ID: 0
CPU14: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU14: 00(40)
CPU 14: Syncing TSC to CPU 0.
CPU 14: synchronized TSC with CPU 0 (last diff -18 cycles, maxerr 2304 cycles)
SMP alternatives: switching to SMP code
Booting processor 15/16 APIC 0x35
Initializing CPU#15
Calibrating delay using timer specific routine.. 6005.70 BogoMIPS (lpj=12011410)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 15/35 -> Node 0
CPU: Physical Processor ID: 13
CPU: Processor Core ID: 0
CPU15: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
APIC error on CPU15: 00(40)
CPU 15: Syncing TSC to CPU 0.
CPU 15: synchronized TSC with CPU 0 (last diff 5 cycles, maxerr 2340 cycles)
Brought up 16 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 3002.623 MHz processor.
migration_cost=22,1525
checking if image is initramfs... it is
Freeing initrd memory: 2855k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060310
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9evgpeblk-0951 [04] ev_create_gpe_block   : GPE 20 to 3F [_GPE] 4 regs on int 0x9evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 0 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 0 Wake, Enabled 2 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...........................................................................................................
Initialized 23/23 Regions 16/16 Fields 33/33 Buffers 35/35 Packages (1175 nodes)Executing all Device _STA and_INI methods:............................................................................................
92 Devices found - executed 1 _STA, 9 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [VP00] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:01.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.VP00._PRT]
ACPI: PCI Root Bridge [VP01] (0000:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.VP01._PRT]
ACPI: PCI Root Bridge [VP02] (0000:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.VP02._PRT]
ACPI: PCI Root Bridge [VP03] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.VP03._PRT]
ACPI: PCI Root Bridge [VP04] (0000:06)
PCI: Probing PCI hardware (bus 06)
ACPI: PCI Interrupt Routing Table [\_SB_.VP04._PRT]
ACPI: PCI Root Bridge [VP05] (0000:08)
PCI: Probing PCI hardware (bus 08)
ACPI: PCI Interrupt Routing Table [\_SB_.VP05._PRT]
ACPI: PCI Root Bridge [VP06] (0000:0a)
PCI: Probing PCI hardware (bus 0a)
ACPI: PCI Interrupt Routing Table [\_SB_.VP06._PRT]
ACPI: PCI Root Bridge [VP07] (0000:0c)
PCI: Probing PCI hardware (bus 0c)
ACPI: PCI Interrupt Routing Table [\_SB_.VP07._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI-DMA: Using Calgary IOMMU
Calgary: enabling translation on PHB 0
Calgary: errant DMAs will now be prevented on this bus.
Calgary: enabling translation on PHB 1
Calgary: errant DMAs will now be prevented on this bus.
Calgary: enabling translation on PHB 4
Calgary: errant DMAs will now be prevented on this bus.
Calgary: enabling translation on PHB 6
Calgary: errant DMAs will now be prevented on this bus.
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:06:01.0
  IO window: disabled.
  MEM window: ec500000-ec5fffff
  PREFETCH window: 88100000-881fffff
ACPI (acpi_bus-0192): Device [S3F0] is not power manageable [20060310]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1150914281.504:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xe0000000, mapped to 0xffffc20000680000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device [20060310]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 1
ACPI: (supports S0 S5)
Freeing unused kernel memory: 200k freed
Write protecting the kernel read-only data: 395k
logips2pp: Detected unknown logitech mouse model 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
input: PS/2 Logitech Mouse as /class/input/input2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
SvrWks CSB6: simplex device: DMA disabled
ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
Probing IDE interface ide0...
hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Adaptec aacraid driver (1.1-5[2409]-mh1)
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 169
AAC0: kernel 5.0-2[8264]
AAC0: monitor 5.0-2[8264]
AAC0: bios 5.0-2[8264]
AAC0: serial 155fe5
AAC0: 64bit support enabled.
AAC0: 64 Bit DAC enabled
scsi0 : ServeRAID
  Vendor: IBM       Model: Serve Volume      Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 70840192 512-byte hdwr sectors (36270 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 70840192 512-byte hdwr sectors (36270 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3 sda4
sd 0:0:1:0: Attached scsi removable disk sda
sd 0:0:1:0: Attached scsi generic sg0 type 0
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
Losing some ticks... checking if CPU frequency changed.
ReiserFS: sda4: using ordered data mode
ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda4: checking transaction log (sda4)
ReiserFS: sda4: Using r5 hash to sort names
Adding 2104504k swap on /dev/sda2.  Priority:-1 extents:1 across:2104504k
tg3.c:v3.59 (May 26, 2006)
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 177
eth0: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:0c:20
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
eth0: dma_rwctrl[769f0000] dma_mask[64-bit]
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 185
eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:0c:21
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
loop: loaded (max 8 devices)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 288 bytes per conntrack
ACPI: Power Button (FF) [PWRF]
PM: Writing back config space on device 0000:01:01.0 at offset b (was 164814e4, writing 2e71014)
PM: Writing back config space on device 0000:01:01.0 at offset 3 (was 804000, writing 80f010)
PM: Writing back config space on device 0000:01:01.0 at offset 2 (was 2000000, writing 2000010)
PM: Writing back config space on device 0000:01:01.0 at offset 1 (was 2b00000, writing 2b00146)
ADDRCONF(NETDEV_UP): eth0: link is not ready
audit(1150914305.764:2): audit_pid=3387 old=0 by auid=4294967295
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
acpi_processor-0731 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
acpi_processor-0731 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
eth0: no IPv6 routers present
ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No context for object [ffff81017fc74240] [20060310]
ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No context for object [ffff81017fc74240] [20060310]

 driver data not foundACPI Error (acpi_memory-0338): Cannot find driver data [20060310]


--=-dmLqg+0L59rJpUDU7AdJ--

