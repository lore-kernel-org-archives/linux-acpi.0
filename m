From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Kdump broken in ACPI initialization upon reading SCI_EN bit
Date: Thu, 19 Oct 2006 16:25:02 -0400
Message-ID: <20061019202502.GB15078@in.ibm.com>
References: <20061019201405.GA15078@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33002 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946448AbWJSUZi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 16:25:38 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9JKPXQO007465
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2006 16:25:34 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k9JKPXId145234
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2006 16:25:33 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k9JKPXRc010557
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2006 16:25:33 -0400
Content-Disposition: inline
In-Reply-To: <20061019201405.GA15078@in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Fastboot mailing list <fastboot@lists.osdl.org>

On Thu, Oct 19, 2006 at 04:14:05PM -0400, Vivek Goyal wrote:
> Hi,
> 
> On one of my machines (Intel Xeon 2.00GHz), Kdump is broken. Second
> kernel hangs during boot during ACPI initialization. I am
> using 2.6.19-rc2.
> 
> It basically hangs when it tries to read from hardware whether system
> is already in ACPI mode or not. It tries to read SCI_ENABLE bit from
> PM1 control register.
> 
> Interestingly this phenomenon is observed only if the code is running 
> on a non-boot cpu (cpu id is not zero). I system crashes on cpu 0 and
> second kernel is booting on cpu 0 then everything is fine.
> 
> Following is the code sequence.
> 
>   acpi_early_init()
>    acpi_enable_subsystem()
>      acpi_hw_get_mode
>        acpi_hw_get_register
> 	  acpi_hw_register_read
> 	    acpi_hw_low_level_read
> 		acpi_os_read_port()
> 
> In acpi_os_read_port() it tries to read port 0x804 (inw()) and then it hangs.
> 
> Any idea what's happening? Are there any dependencies of this port being
> read by a boot cpu only? Any suggestions how can I debug further?
> 

Forgot to attach the serial console logs last time. Here it is.

Kernel panic - not syncing: Module Triggered Panic

  Linux version 2.6.19-rc2-16M (root@dhcp83-186.boston.redhat.com) (gcc 
version 4.1.1 20060817 (Red Hat 4.1.1-18)) #1 SMP Thu Oct 19 08:32:48 
EDT 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000100 - 00000000000a0000 (usable)
  BIOS-e820: 0000000000100000 - 000000001ff75000 (usable)
  BIOS-e820: 000000001ff75000 - 000000001ff77000 (ACPI NVS)
  BIOS-e820: 000000001ff77000 - 000000001ff98000 (ACPI data)
  BIOS-e820: 000000001ff98000 - 0000000020000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
  user: 0000000000000000 - 00000000000a0000 (usable)
  user: 0000000001000000 - 00000000015a1000 (usable)
  user: 0000000001641400 - 0000000009000000 (usable)
0MB HIGHMEM available.
144MB LOWMEM available.
found SMP MP-table at 000fe710
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->    36864
   HighMem     36864 ->    36864
early_node_map[1] active PFN ranges
     0:        0 ->    36864
DMI 2.3 present.
Using APIC driver default
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
WARNING: maxcpus limit of 1 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
WARNING: maxcpus limit of 1 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
WARNING: maxcpus limit of 1 reached. Processor ignored.
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10000000 (gap: 09000000:f7000000)
Detected 1993.512 MHz processor.
Built 1 zonelists.  Total pages: 36576
Kernel command line: ro root=/dev/VolGroup00/LogVol00 
crashkernel=128M@16M console=tty0 console=ttyS0,115200 maxcpus=1 irqpoll 
memmap=exactmap memmap=640K@0K memmap=5764K@16384K memmap=124667K@22789K 
elfcorehdr=22788K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 121832k/147456k available (3094k kernel code, 9120k reserved, 
1405k data, 260k init, 0k highmem)
virtual kernel memory layout:
     fixmap  : 0xffe16000 - 0xfffff000   (1956 kB)
     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
     vmalloc : 0xc9800000 - 0xff7fe000   ( 863 MB)
     lowmem  : 0xc0000000 - 0xc9000000   ( 144 MB)
       .init : 0xc14dd000 - 0xc151e000   ( 260 kB)
       .data : 0xc130582f - 0xc1464d8c   (1405 kB)
       .text : 0xc1000000 - 0xc130582f   (3094 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4010.48 BogoMIPS 
(lpj=8020975)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
  tbxface-0107 [01] load_tables           : ACPI Tables successfully 
acquired
Parsing all Control Methods:
Table [DSDT](id 0006) - 339 Objects with 32 Devices 136 Methods 21 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 7 Objects with 0 Devices 2 Methods 0 Regions
ACPI Namespace successfully loaded at root c157d170

**********************SYSTEM HANGS********************************************

Thanks
Vivek
