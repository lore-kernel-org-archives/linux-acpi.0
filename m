From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: ACPI _PPC issue with bios_limit
Date: Fri, 16 Dec 2011 16:01:02 +0200
Message-ID: <4EEB4F1E.3070908@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010107050206000906020509"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tulikuusama.dnainternet.net ([83.102.40.132]:60740 "EHLO
	tulikuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751966Ab1LPOLV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Dec 2011 09:11:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id 0B1FA3F88D
	for <linux-acpi@vger.kernel.org>; Fri, 16 Dec 2011 16:01:05 +0200 (EET)
Received: from tulikuusama.dnainternet.net ([83.102.40.132])
	by localhost (tulikuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva, port 10041)
	with ESMTP id Qz+9co8S5dFV for <linux-acpi@vger.kernel.org>;
	Fri, 16 Dec 2011 16:01:03 +0200 (EET)
Received: from omenapuu.dnainternet.net (omenapuu.dnainternet.net [83.102.40.212])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id 6E13D3FCCE
	for <linux-acpi@vger.kernel.org>; Fri, 16 Dec 2011 16:01:03 +0200 (EET)
Received: from mail.onse.fi (host-109-204-132-101.tp-fne.tampereenpuhelin.net [109.204.132.101])
	by omenapuu.dnainternet.net (Postfix) with ESMTP id 434DA2BAE2
	for <linux-acpi@vger.kernel.org>; Fri, 16 Dec 2011 16:01:02 +0200 (EET)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id 098ED40ED1
	for <linux-acpi@vger.kernel.org>; Fri, 16 Dec 2011 16:01:02 +0200 (EET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010107050206000906020509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi!

On my laptop, processor _PPC is evaluated as 1 and therefore the
processor never goes to the highest frequency (1333MHz vs 1666 MHz).

The system is HP Mini 5102 and processor Atom N450.

ACPI tables are at http://zarb.org/~anssi/hpmini5102/

This only started happening since 2.6.34 when 3b1da4c5d1 ("ACPI:
processor: remove early _PDC optin quirks") was applied and thus the
_PDC is now evaluated early.

This causes extra tables to be loaded dynamically on boot:

> ACPI: SSDT 000000007e939c98 00233 (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT           (null) 00233 (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
> ACPI: SSDT 000000007e937818 0076E (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT           (null) 0076E (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
> ACPI: SSDT 000000007e938e18 001D7 (v01  PmRef    ApIst 00003000 INTL 20060912)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT           (null) 001D7 (v01  PmRef    ApIst 00003000 INTL 20060912)
> ACPI: SSDT 000000007e939f18 0008D (v01  PmRef    ApCst 00003000 INTL 20060912)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT           (null) 0008D (v01  PmRef    ApCst 00003000 INTL 20060912)

Of these, the first two (SSDT4, SSDT5) seem more interesting, and SSDT4
contains "Name (_PPC, 0x00)".

However, I don't know how to debug this further, so I'm asking for
assistance.

Boot dmesg with current linus git tree is attached.
This issue doesn't happen on win7 included with the laptop.

-- 
Anssi Hannula

--------------010107050206000906020509
Content-Type: text/plain;
 name="hpmini5102-dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hpmini5102-dmesg"

Initializing cgroup subsys cpuset
Linux version 3.2.0-rc5+ (anssi@delta.onse.fi) (gcc version 4.5.2 (GCC) ) #30 SMP Fri Dec 16 14:14:17 EET 2011
Command line: initrd=images/hptest/INITIMG ramdisk_size=128000 vga=6 root=/dev/ram3 rw netconsole=4444@192.168.0.63/eth0,9353@192.168.0.1/f4:6d:04:33:3c:e6 BOOT_IMAGE=images/hptest/vmlinuz 
Disabled fast string operations
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007a5e0000 (usable)
 BIOS-e820: 000000007a5e0000 - 000000007a5e2000 (reserved)
 BIOS-e820: 000000007a5e2000 - 000000007d033000 (usable)
 BIOS-e820: 000000007d033000 - 000000007d234000 (ACPI NVS)
 BIOS-e820: 000000007d234000 - 000000007e80a000 (usable)
 BIOS-e820: 000000007e80a000 - 000000007e812000 (reserved)
 BIOS-e820: 000000007e812000 - 000000007e814000 (usable)
 BIOS-e820: 000000007e814000 - 000000007e815000 (reserved)
 BIOS-e820: 000000007e815000 - 000000007e818000 (usable)
 BIOS-e820: 000000007e818000 - 000000007e875000 (reserved)
 BIOS-e820: 000000007e875000 - 000000007e8d3000 (usable)
 BIOS-e820: 000000007e8d3000 - 000000007e90e000 (reserved)
 BIOS-e820: 000000007e90e000 - 000000007e933000 (usable)
 BIOS-e820: 000000007e933000 - 000000007e943000 (reserved)
 BIOS-e820: 000000007e943000 - 000000007ea43000 (ACPI NVS)
 BIOS-e820: 000000007ea43000 - 000000007ea73000 (ACPI data)
 BIOS-e820: 000000007ea73000 - 000000007f600000 (usable)
 BIOS-e820: 000000007f600000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
NX (Execute Disable) protection: active
DMI 2.6 present.
No AGP bridge found
last_pfn = 0x7f600 max_arch_pfn = 0x400000000
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
init_memory_mapping: 0000000000000000-000000007f600000
RAMDISK: 79f5d000 - 7a5bf000
ACPI: RSDP 00000000000fc600 00024 (v02 HPQOEM)
ACPI: XSDT 000000007ea72120 0006C (v01 HPQOEM SLIC-MPC 0000000B      01000013)
ACPI: FACP 000000007ea70000 000F4 (v03 HPQOEM 3653     0000000B HP   00000001)
ACPI: DSDT 000000007ea4e000 1CF67 (v01 HPQOEM 3653     00000001 INTL 20060912)
ACPI: FACS 000000007ea35000 00040
ACPI: HPET 000000007ea6f000 00038 (v01 HPQOEM 3653     00000001 HP   00000001)
ACPI: APIC 000000007ea6e000 000BC (v01 HPQOEM 3653     00000001 HP   00000001)
ACPI: MCFG 000000007ea6d000 0003C (v01 HPQOEM 3653     00000001 HP   00000001)
ACPI: ASF! 000000007ea6c000 000A0 (v32 HPQOEM 3653     00000001 HP   00000001)
ACPI: SSDT 000000007ea4b000 00135 (v01 HPQOEM SataAhci 00001000 INTL 20060912)
ACPI: SLIC 000000007ea49000 00176 (v01 HPQOEM SLIC-MPC 00000001 HP   00000001)
ACPI: SSDT 000000007ea48000 0005F (v01 HPQOEM   HPQNLP 00000001 INTL 20060912)
ACPI: SSDT 000000007ea47000 0066C (v01  PmRef    CpuPm 00003000 INTL 20060912)
No NUMA configuration found
Faking a node at 0000000000000000-000000007f600000
Initmem setup node 0 0000000000000000-000000007f600000
  NODE_DATA [000000007f5fb000 - 000000007f5fffff]
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   empty
Movable zone start PFN for each node
early_node_map[9] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x0007a5e0
    0: 0x0007a5e2 -> 0x0007d033
    0: 0x0007d234 -> 0x0007e80a
    0: 0x0007e812 -> 0x0007e814
    0: 0x0007e815 -> 0x0007e818
    0: 0x0007e875 -> 0x0007e8d3
    0: 0x0007e90e -> 0x0007e933
    0: 0x0007ea73 -> 0x0007f600
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
SMP: Allowing 8 CPUs, 6 hotplug CPUs
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
PM: Registered nosave memory: 000000007a5e0000 - 000000007a5e2000
PM: Registered nosave memory: 000000007d033000 - 000000007d234000
PM: Registered nosave memory: 000000007e80a000 - 000000007e812000
PM: Registered nosave memory: 000000007e814000 - 000000007e815000
PM: Registered nosave memory: 000000007e818000 - 000000007e875000
PM: Registered nosave memory: 000000007e8d3000 - 000000007e90e000
PM: Registered nosave memory: 000000007e933000 - 000000007e943000
PM: Registered nosave memory: 000000007e943000 - 000000007ea43000
PM: Registered nosave memory: 000000007ea43000 - 000000007ea73000
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Booting paravirtualized kernel on bare hardware
setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:8 nr_node_ids:1
PERCPU: Embedded 26 pages/cpu @ffff88007f200000 s77136 r8192 d21168 u262144
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 512462
Policy zone: DMA32
Kernel command line: initrd=images/hptest/INITIMG ramdisk_size=128000 vga=6 root=/dev/ram3 rw netconsole=4444@192.168.0.63/eth0,9353@192.168.0.1/f4:6d:04:33:3c:e6 BOOT_IMAGE=images/hptest/vmlinuz 
PID hash table entries: 4096 (order: 3, 32768 bytes)
Checking aperture...
No AGP bridge found
Memory: 2034164k/2086912k available (3589k kernel code, 4436k absent, 48312k reserved, 2982k data, 556k init)
SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:8448 nr_irqs:744 16
Extended CMOS year: 2000
Console: colour VGA+ 80x60
console [tty0] enabled
allocated 16777216 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Fast TSC calibration using PIT
Detected 1662.378 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 3324.75 BogoMIPS (lpj=16623780)
pid_max: default: 32768 minimum: 301
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
Disabled fast string operations
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 5 MCE banks
CPU0: Thermal monitoring enabled (TM1)
using mwait in idle threads.
ACPI: Core revision 20110623
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Atom(TM) CPU N450   @ 1.66GHz stepping 0a
Performance Events: PEBS fmt0+, Atom events, Intel PMU driver.
... version:                3
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
Booting Node   0, Processors  #1
Disabled fast string operations
Brought up 2 CPUs
Total of 2 processors activated (6649.76 BogoMIPS).
PM: Registering ACPI NVS region at 7d033000 (2101248 bytes)
PM: Registering ACPI NVS region at 7e943000 (1048576 bytes)
RTC time: 14:15:28, date: 12/16/11
NET: Registered protocol family 16
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Executed 1 blocks of module-level executable AML code
[Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
ACPI: SSDT 000000007e939c98 00233 (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 00233 (v01  PmRef  Cpu0Ist 00003000 INTL 20060912)
ACPI: SSDT 000000007e937818 0076E (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 0076E (v01  PmRef  Cpu0Cst 00003001 INTL 20060912)
ACPI: SSDT 000000007e938e18 001D7 (v01  PmRef    ApIst 00003000 INTL 20060912)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 001D7 (v01  PmRef    ApIst 00003000 INTL 20060912)
ACPI: SSDT 000000007e939f18 0008D (v01  PmRef    ApCst 00003000 INTL 20060912)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT           (null) 0008D (v01  PmRef    ApCst 00003000 INTL 20060912)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: Power Resource [APPR] (off)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
ACPI: Power Resource [PFN2] (off)
ACPI: Power Resource [PFN3] (off)
ACPI: Power Resource [PFN4] (off)
ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
ACPI: No dock devices found.
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A08:00: host bridge window [mem 0x80000000-0xfebfffff]
pci 0000:00:1c.0: PCI bridge to [bus 01-01]
pci 0000:00:1c.2: PCI bridge to [bus 02-42]
pci 0000:00:1c.3: PCI bridge to [bus 43-43]
pci 0000:00:1e.0: PCI bridge to [bus 44-44] (subtractive decode)
ACPI Warning: For \_SB_.PCI0.PCIB._PRT: Return Package has no elements (empty) (20110623/nspredef-463)
 pci0000:00: Requesting ACPI _OSC control (0x1d)
 pci0000:00: ACPI _OSC control (0x1d) granted
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:00:02.0
PCI: Using ACPI for IRQ routing
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource hpet
pnp: PnP ACPI init
ACPI: bus type pnp registered
system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:01: [mem 0xfed14000-0xfed17fff] has been reserved
system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
system 00:01: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:01: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:06: [io  0x0200-0x027f] has been reserved
system 00:06: [io  0x1000-0x1003] has been reserved
system 00:06: [io  0x1010-0x101f] has been reserved
system 00:06: [io  0xffff] has been reserved
system 00:06: [io  0x0400-0x047f] has been reserved
system 00:06: [io  0x0500-0x057f] has been reserved
system 00:06: [io  0xef80-0xef9f] has been reserved
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
pci 0000:43:00.0: no compatible bridge window for [mem 0xfffe0000-0xffffffff pref]
pci 0000:00:1c.3: BAR 15: assigned [mem 0x94600000-0x946fffff pref]
pci 0000:00:1c.3: BAR 15: assigned [mem 0x94600000-0x948fffff pref]
pci 0000:00:1c.2: BAR 15: assigned [mem 0x94900000-0x94afffff 64bit pref]
pci 0000:00:1c.0: BAR 15: assigned [mem 0x94b00000-0x94cfffff 64bit pref]
pci 0000:00:1c.0: BAR 13: assigned [io  0x6000-0x6fff]
pci 0000:00:1c.0: PCI bridge to [bus 01-01]
pci 0000:00:1c.0:   bridge window [io  0x6000-0x6fff]
pci 0000:00:1c.0:   bridge window [mem 0x94200000-0x942fffff]
pci 0000:00:1c.0:   bridge window [mem 0x94b00000-0x94cfffff 64bit pref]
pci 0000:00:1c.2: PCI bridge to [bus 02-42]
pci 0000:00:1c.2:   bridge window [io  0x3000-0x4fff]
pci 0000:00:1c.2:   bridge window [mem 0x90200000-0x941fffff]
pci 0000:00:1c.2:   bridge window [mem 0x94900000-0x94afffff 64bit pref]
pci 0000:43:00.0: BAR 6: assigned [mem 0x94600000-0x9461ffff pref]
pci 0000:00:1c.3: PCI bridge to [bus 43-43]
pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.3:   bridge window [mem 0x90100000-0x901fffff]
pci 0000:00:1c.3:   bridge window [mem 0x94600000-0x948fffff pref]
pci 0000:00:1e.0: PCI bridge to [bus 44-44]
pci 0000:00:1e.0:   bridge window [mem 0x90000000-0x900fffff]
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
UDP hash table entries: 1024 (order: 3, 32768 bytes)
UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
NET: Registered protocol family 1
Unpacking initramfs...
Freeing initrd memory: 6536k freed
audit: initializing netlink socket (disabled)
type=2000 audit(1324044928.180:1): initialized
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 3985
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
pcieport 0000:00:1c.2: Signaling PME through PCIe PME interrupt
pcieport 0000:00:1c.3: Signaling PME through PCIe PME interrupt
pci 0000:43:00.0: Signaling PME through PCIe PME interrupt
Marking TSC unstable due to TSC halts in idle
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: Thermal Zone [DTSZ] (57 C)
thermal LNXTHERM:01: registered as thermal_zone1
ACPI: Thermal Zone [CPUZ] (59 C)
thermal LNXTHERM:02: registered as thermal_zone2
ACPI: Thermal Zone [SKNZ] (49 C)
thermal LNXTHERM:03: registered as thermal_zone3
ACPI: Thermal Zone [BATZ] (33 C)
thermal LNXTHERM:04: registered as thermal_zone4
ACPI: Thermal Zone [FDTZ] (30 C)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel GMA3150 Chipset
agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K mappable
agpgart-intel 0000:00:00.0: detected 8192K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x80000000
sky2: driver version 1.30
sky2 0000:43:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
sky2 0000:43:00.0: Yukon-2 Optima chip revision 1
sky2 0000:43:00.0: eth0: addr d8:d3:85:03:17:23
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042: Detected active multiplexing controller, rev 1.1
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:07: RTC can wake from S4
rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
Registering the dns_resolver key type
registered taskstats version 1
  Magic number: 7:443:283
netconsole: local port 4444
netconsole: local IP 192.168.0.63
netconsole: interface 'eth0'
netconsole: remote port 9353
netconsole: remote IP 192.168.0.1
netconsole: remote ethernet address f4:6d:04:33:3c:e6
netconsole: device eth0 not up yet, forcing it
sky2 0000:43:00.0: eth0: enabling interface
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
psmouse serio4: synaptics: Touchpad model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04711/0xa00000/0x20000
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input1
sky2 0000:43:00.0: eth0: Link is up at 1000 Mbps, full duplex, flow control both
console [netcon0] enabled
netconsole: network logging started
rtc_cmos 00:07: setting system clock to 2011-12-16 14:15:32 UTC (1324044932)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 556k freed
Write protecting the kernel read-only data: 6144k
Freeing unused kernel memory: 488k freed
Freeing unused kernel memory: 440k freed

--------------010107050206000906020509--
