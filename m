From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: Linux doesn't shutdown (turn off) the computer
Date: Wed, 28 Apr 2010 21:36:17 -0300
Message-ID: <4bd8d484.1408c00a.5b63.11e8@mx.google.com>
References: <phlm97-dol.ln1@tux.abusar.org.br>
	<4BD7782D.4080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:38866 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab0D2AgY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2010 20:36:24 -0400
Received: by gxk9 with SMTP id 9so2267480gxk.8
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2010 17:36:22 -0700 (PDT)
In-Reply-To: <4BD7782D.4080608@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 27 Apr 2010 17:50:05 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:

> dmesg output from bootup would be useful. Is it actually using ACPI, or 
> is it an APM system? I think you should see an "acpi_power_off called" 
> message if the kernel is actually trying to use ACPI to power off the 
> machine.

	Hi Robert! Thanks for replying.

	It's using ACPI. But I booted from a live cd and it shutdown
properly (powered off). So it's a configuration issue, somewhere.
Here is the dmesg from the boot:

0000001c000 - 0000000000020fff]
  bootmap [0000000000021000 -  0000000000058fff] pages 38
(12 early reservations) ==> bootmem [0000000000 - 01c0000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0001000000 - 00014890b4]    TEXT DATA BSS ==> [0001000000 - 00014890b4]
  #2 [000148a000 - 000148a12b]              BRK ==> [000148a000 - 000148a12b]
  #3 [00000ff790 - 0000100000]    BIOS reserved ==> [00000ff790 - 0000100000]
  #4 [00000ff780 - 00000ff790]     MP-table mpf ==> [00000ff780 - 00000ff790]
  #5 [000009ec00 - 00000fdce0]    BIOS reserved ==> [000009ec00 - 00000fdce0]
  #6 [00000fde74 - 00000ff780]    BIOS reserved ==> [00000fde74 - 00000ff780]
  #7 [00000fdce0 - 00000fde74]     MP-table mpc ==> [00000fdce0 - 00000fde74]
  #8 [0000010000 - 0000012000]       TRAMPOLINE ==> [0000010000 - 0000012000]
  #9 [0000012000 - 0000016000]      ACPI WAKEUP ==> [0000012000 - 0000016000]
  #10 [0000016000 - 0000019000]          PGTABLE ==> [0000016000 - 0000019000]
  #11 [0000019000 - 000001c000]          PGTABLE ==> [0000019000 - 000001c000]
 [ffffea0000000000-ffffea00061fffff] PMD -> [ffff880028600000-ffff88002d9fffff] on node 0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x001c0000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000010 -> 0x0000009e
    0: 0x00000100 -> 0x000bf780
    0: 0x00100000 -> 0x001c0000
On node 0 totalpages: 1570574
  DMA zone: 56 pages used for memmap
  DMA zone: 109 pages reserved
  DMA zone: 3817 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 765880 pages, LIFO batch:31
  Normal zone: 10752 pages used for memmap
  Normal zone: 775680 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0xffffffff base: 0xfed00000
12 Processors exceeds NR_CPUS limit of 8
SMP: Allowing 8 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
Allocating PCI resources starting at c0000000 (gap: c0000000:3ee00000)
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
PERCPU: Embedded 26 pages/cpu @ffff880028200000 s77272 r8192 d21032 u262144
pcpu-alloc: s77272 r8192 d21032 u262144 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1545377
Policy zone: Normal
Kernel command line: auto BOOT_IMAGE=linux rw root=802
PID hash table entries: 4096 (order: 3, 32768 bytes)
Checking aperture...
No AGP bridge found
Memory: 6124512k/7340032k available (2659k kernel code, 1057736k absent, 157784k reserved, 1305k data, 448k init)
SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Experimental preemptable hierarchical RCU implementation.
NR_IRQS:512
Console: colour VGA+ 80x25
console [tty0] enabled
hpet clockevent registered
Fast TSC calibration using PIT
Detected 2807.074 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 5614.14 BogoMIPS (lpj=2807074)
Security Framework initialized
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 256
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 9 MCE banks
CPU0: Thermal monitoring enabled (TM1)
CPU 0 MCA banks CMCI:2 CMCI:3 CMCI:5 CMCI:6 CMCI:8
using mwait in idle threads.
Performance Events: Nehalem/Corei7 events, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
ACPI: Core revision 20091214
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz stepping 05
Booting Node   0, Processors  #1
CPU 1 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6 SHD:8
 #2
CPU 2 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6 SHD:8
 #3
CPU 3 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6 SHD:8
 #4
CPU 4 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
 #5
CPU 5 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
 #6
CPU 6 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
 #7 Ok.
CPU 7 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
Brought up 8 CPUs
Total of 8 processors activated (44906.90 BogoMIPS).
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: not using MMCONFIG
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
ACPI Warning: Incorrect checksum in table [OEMB] - CD, should be CC (20091214/tbutils-314)
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci_root PNP0A08:00: ignoring host bridge windows from ACPI; boot with "pci=use_crs" to use them
pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7] (ignored)
pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff] (ignored)
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000dffff] (ignored)
pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xdfffffff] (ignored)
pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0xfed8ffff] (ignored)
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
pci 0000:00:07.0: PME# disabled
pci 0000:00:1a.0: reg 20: [io  0xbc00-0xbc1f]
pci 0000:00:1a.1: reg 20: [io  0xb880-0xb89f]
pci 0000:00:1a.2: reg 20: [io  0xb800-0xb81f]
pci 0000:00:1a.7: reg 10: [mem 0xf5ffe000-0xf5ffe3ff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1b.0: reg 10: [mem 0xf5ff8000-0xf5ffbfff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: PME# disabled
pci 0000:00:1d.0: reg 20: [io  0xb480-0xb49f]
pci 0000:00:1d.1: reg 20: [io  0xb400-0xb41f]
pci 0000:00:1d.2: reg 20: [io  0xb080-0xb09f]
pci 0000:00:1d.7: reg 10: [mem 0xf5ffc000-0xf5ffc3ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00 (mask 00ff)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0a00 (mask 0017)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700 (mask 00ff)
pci 0000:00:1f.2: reg 10: [io  0xb000-0xb007]
pci 0000:00:1f.2: reg 14: [io  0xac00-0xac03]
pci 0000:00:1f.2: reg 18: [io  0xa880-0xa887]
pci 0000:00:1f.2: reg 1c: [io  0xa800-0xa803]
pci 0000:00:1f.2: reg 20: [io  0xa480-0xa49f]
pci 0000:00:1f.2: reg 24: [mem 0xf5ff6000-0xf5ff67ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 10: [mem 0xf5ff5c00-0xf5ff5cff 64bit]
pci 0000:00:1f.3: reg 20: [io  0x0400-0x041f]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:02:00.0: reg 10: [mem 0xf8000000-0xf8ffffff]
pci 0000:02:00.0: reg 14: [mem 0xc0000000-0xdfffffff 64bit pref]
pci 0000:02:00.0: reg 1c: [mem 0xf6000000-0xf7ffffff 64bit]
pci 0000:02:00.0: reg 24: [io  0xcc00-0xcc7f]
pci 0000:02:00.0: reg 30: [mem 0xf9d80000-0xf9dfffff pref]
pci 0000:00:03.0: PCI bridge to [bus 02-02]
pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:03.0:   bridge window [mem 0xf6000000-0xf9dfffff]
pci 0000:00:03.0:   bridge window [mem 0xc0000000-0xdfffffff 64bit pref]
pci 0000:00:07.0: PCI bridge to [bus 03-03]
pci 0000:00:1c.0: PCI bridge to [bus 04-04]
pci 0000:06:00.0: reg 10: [io  0xe800-0xe8ff]
pci 0000:06:00.0: reg 18: [mem 0xf9fff000-0xf9ffffff 64bit]
pci 0000:06:00.0: reg 20: [mem 0xf4ff0000-0xf4ffffff 64bit pref]
pci 0000:06:00.0: reg 30: [mem 0xf9fc0000-0xf9fdffff pref]
pci 0000:06:00.0: supports D1 D2
pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:06:00.0: PME# disabled
pci 0000:00:1c.4: PCI bridge to [bus 06-06]
pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.4:   bridge window [mem 0xf9f00000-0xf9ffffff]
pci 0000:00:1c.4:   bridge window [mem 0xf4f00000-0xf4ffffff 64bit pref]
pci 0000:07:00.0: reg 10: [mem 0xfa000000-0xfaffffff]
pci 0000:00:1e.0: PCI bridge to [bus 07-07] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xfa000000-0xfaffffff]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE7._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 *7 10 11 12 14 15)
vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
HPET: 4 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: [mem 0xfbf00000-0xfbffffff] has been reserved
system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
system 00:01: [mem 0xfe000000-0xfebfffff] has been reserved
system 00:01: [mem 0xfec8a000-0xfec8afff] has been reserved
system 00:01: [mem 0xfed10000-0xfed10fff] has been reserved
system 00:07: [io  0x0a00-0x0adf] has been reserved
system 00:07: [io  0x0ae0-0x0aef] has been reserved
system 00:08: [io  0x04d0-0x04d1] has been reserved
system 00:08: [io  0x0800-0x087f] has been reserved
system 00:08: [io  0x0500-0x057f] could not be reserved
system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:08: [mem 0xfed10000-0xfed103ff] has been reserved
system 00:08: [mem 0xfed10400-0xfed107ff] has been reserved
system 00:08: [mem 0xfed10800-0xfed10bff] has been reserved
system 00:08: [mem 0xfed10c00-0xfed10fff] has been reserved
system 00:08: [mem 0xfec8a000-0xfec8a3ff] has been reserved
system 00:08: [mem 0xfec8a400-0xfec8a7ff] has been reserved
system 00:08: [mem 0xfec8a800-0xfec8abff] has been reserved
system 00:08: [mem 0xfec8ac00-0xfec8afff] has been reserved
system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:08: [mem 0xfed45000-0xfed89fff] has been reserved
system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:08: [mem 0xfed40000-0xfed8ffff] could not be reserved
system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
system 00:0b: [mem 0xe0000000-0xefffffff] has been reserved
system 00:0c: [mem 0x00000000-0x0009ffff] could not be reserved
system 00:0c: [mem 0x000c0000-0x000cffff] has been reserved
system 00:0c: [mem 0x000e0000-0x000fffff] could not be reserved
system 00:0c: [mem 0x00100000-0xbfffffff] could not be reserved
system 00:0c: [mem 0xfed90000-0xffffffff] could not be reserved
pci 0000:00:1c.0: BAR 8: assigned [mem 0xf0000000-0xf01fffff]
pci 0000:00:1c.0: BAR 9: assigned [mem 0xf0200000-0xf03fffff 64bit pref]
pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  disabled]
pci 0000:00:01.0:   bridge window [mem disabled]
pci 0000:00:01.0:   bridge window [mem pref disabled]
pci 0000:00:03.0: PCI bridge to [bus 02-02]
pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:03.0:   bridge window [mem 0xf6000000-0xf9dfffff]
pci 0000:00:03.0:   bridge window [mem 0xc0000000-0xdfffffff 64bit pref]
pci 0000:00:07.0: PCI bridge to [bus 03-03]
pci 0000:00:07.0:   bridge window [io  disabled]
pci 0000:00:07.0:   bridge window [mem disabled]
pci 0000:00:07.0:   bridge window [mem pref disabled]
pci 0000:00:1c.0: PCI bridge to [bus 04-04]
pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:1c.0:   bridge window [mem 0xf0000000-0xf01fffff]
pci 0000:00:1c.0:   bridge window [mem 0xf0200000-0xf03fffff 64bit pref]
pci 0000:00:1c.4: PCI bridge to [bus 06-06]
pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.4:   bridge window [mem 0xf9f00000-0xf9ffffff]
pci 0000:00:1c.4:   bridge window [mem 0xf4f00000-0xf4ffffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 07-07]
pci 0000:00:1e.0:   bridge window [io  disabled]
pci 0000:00:1e.0:   bridge window [mem 0xfa000000-0xfaffffff]
pci 0000:00:1e.0:   bridge window [mem pref disabled]
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:03.0: setting latency timer to 64
pci 0000:00:07.0: setting latency timer to 64
pci 0000:00:1c.0: enabling device (0104 -> 0107)
pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.4: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffffffffffff]
pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:02: resource 1 [mem 0xf6000000-0xf9dfffff]
pci_bus 0000:02: resource 2 [mem 0xc0000000-0xdfffffff 64bit pref]
pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:04: resource 1 [mem 0xf0000000-0xf01fffff]
pci_bus 0000:04: resource 2 [mem 0xf0200000-0xf03fffff 64bit pref]
pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
pci_bus 0000:06: resource 1 [mem 0xf9f00000-0xf9ffffff]
pci_bus 0000:06: resource 2 [mem 0xf4f00000-0xf4ffffff 64bit pref]
pci_bus 0000:07: resource 1 [mem 0xfa000000-0xfaffffff]
pci_bus 0000:07: resource 3 [io  0x0000-0xffff]
pci_bus 0000:07: resource 4 [mem 0x00000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
UDP hash table entries: 4096 (order: 5, 131072 bytes)
UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
pci 0000:02:00.0: Boot video device
PCI: CLS 256 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
software IO TLB at phys 0x20000000 - 0x24000000
msgmni has been set to 11961
io scheduler noop registered
io scheduler cfq registered (default)
pcieport 0000:00:01.0: setting latency timer to 64
pcieport 0000:00:01.0: irq 24 for MSI/MSI-X
pcieport 0000:00:03.0: setting latency timer to 64
pcieport 0000:00:03.0: irq 25 for MSI/MSI-X
pcieport 0000:00:07.0: setting latency timer to 64
pcieport 0000:00:07.0: irq 26 for MSI/MSI-X
pcieport 0000:00:1c.0: setting latency timer to 64
pcieport 0000:00:1c.0: irq 27 for MSI/MSI-X
pcieport 0000:00:1c.4: setting latency timer to 64
pcieport 0000:00:1c.4: irq 28 for MSI/MSI-X
aer 0000:00:01.0:pcie02: AER service couldn't init device: no _OSC support
aer 0000:00:03.0:pcie02: AER service couldn't init device: no _OSC support
aer 0000:00:07.0:pcie02: AER service couldn't init device: no _OSC support
Linux agpgart interface v0.103
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: irq 29 for MSI/MSI-X
ahci: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ccc ems sxs 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6100 irq 29
ata2: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6180 irq 29
ata3: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6200 irq 29
ata4: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6280 irq 29
ata5: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6300 irq 29
ata6: SATA max UDMA/133 abar m2048@0xf5ff6000 port 0xf5ff6380 irq 29
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: ST31500341AS, CC1H, max UDMA/133
ata1.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST31500341AS     CC1H PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
EXT4-fs (sda2): warning: maximal mount count reached, running e2fsck is recommended
EXT4-fs (sda2): mounted filesystem with ordered data mode
VFS: Mounted root (ext4 filesystem) on device 8:2.
Freeing unused kernel memory: 448k freed
NET: Registered protocol family 1
Adding 136512k swap on /dev/sda1.  Priority:-1 extents:1 across:136512k 
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 256 is not supported
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf5ffe000
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 256 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf5ffc000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000bc00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000b880
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.2: PCI INT D -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1a.2: setting latency timer to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000b800
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000b480
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000b400
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000b080
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb 1-1: new high speed USB device using ehci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
udev: starting version 152
usb 1-2: new high speed USB device using ehci_hcd and address 3
Real Time Clock Driver v1.12b
Linux video capture interface: v2.00
usb 1-1.1: new high speed USB device using ehci_hcd and address 5
uvcvideo: Found UVC 1.00 device <unnamed> (046d:0990)
input: UVC Camera (046d:0990) as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input0
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
hub 1-1.1:1.0: USB hub found
hub 1-1.1:1.0: 4 ports detected
usb 1-1.2: new low speed USB device using ehci_hcd and address 6
usbcore: registered new interface driver hiddev
input: Logitech Logitech USB Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2:1.0/input/input1
generic-usb 0003:046D:C316.0001: input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1a.7-1.2/input0
input: Logitech Logitech USB Keyboard as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.2/1-1.2:1.1/input/input2
generic-usb 0003:046D:C316.0002: input: USB HID v1.10 Device [Logitech Logitech USB Keyboard] on usb-0000:00:1a.7-1.2/input1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
usbcore: registered new interface driver snd-usb-audio
usb 5-2: new low speed USB device using uhci_hcd and address 2
ACPI: SSDT 00000000bf78e0c0 01E1C (v01 DpgPmm  P001Ist 00000011 INTL 20051117)
ACPI: SSDT 00000000bf78fee0 00678 (v01  PmRef  P001Cst 00003001 INTL 20051117)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
f71882fg: Found f71882fg chip at 0xa00, revision 32
f71882fg f71882fg.2560: Fan: 1 is in duty-cycle mode
f71882fg f71882fg.2560: Fan: 2 is in duty-cycle mode
f71882fg f71882fg.2560: Fan: 3 is in duty-cycle mode
f71882fg f71882fg.2560: Fan: 4 is in duty-cycle mode
coretemp coretemp.0: Unable to access MSR 0xEE, for Tjmax, left at default
coretemp coretemp.1: Unable to access MSR 0xEE, for Tjmax, left at default
coretemp coretemp.2: Unable to access MSR 0xEE, for Tjmax, left at default
coretemp coretemp.3: Unable to access MSR 0xEE, for Tjmax, left at default
coretemp coretemp.4: Unable to access MSR 0xEE, for Tjmax, left at default
coretemp coretemp.5: Unable to access MSR 0xEE, for Tjmax, left at default
coretemp coretemp.6: Unable to access MSR 0xEE, for Tjmax, left at default
coretemp coretemp.7: Unable to access MSR 0xEE, for Tjmax, left at default
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
ACPI: Power Button [PWRF]
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
input: PC Speaker as /devices/platform/pcspkr/input/input5
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: irq 30 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
hda_codec: ALC889: BIOS auto-probing.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
cx88/0: cx2388x v4l2 driver version 0.0.7 loaded
cx8800 0000:07:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
cx88[0]: subsystem: 14f1:ea3d, board: PowerColor RA330 [card=62,autodetected], frontend(s): 0
cx88[0]: TV tuner type 71, Radio tuner type 0
tuner 0-0061: chip found @ 0xc2 (cx88[0])
xc2028 0-0061: creating new instance
xc2028 0-0061: type set to XCeive xc2028/xc3028 tuner
cx88[0]: Asking xc2028/3028 to load firmware xc3028-v27.fw
input: cx88 IR (PowerColor RA330) as /devices/pci0000:00/0000:00:1e.0/0000:07:00.0/input/input6
cx88[0]/0: found at 0000:07:00.0, rev: 5, irq: 16, latency: 64, mmio: 0xfa000000
IRQ 16/cx88[0]: IRQF_DISABLED is not guaranteed on shared IRQs
cx88[0]/0: registered device video1 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
cx8800 0000:07:00.0: firmware: requesting xc3028-v27.fw
cx88 IR (PowerColor RA330): unknown key for scancode 0x003f
cx88 IR (PowerColor RA330): unknown key: key=0x3f down=1
cx88 IR (PowerColor RA330): unknown key: key=0x3f down=0
xc2028 0-0061: Error: firmware xc3028-v27.fw not found.
cx8800 0000:07:00.0: firmware: requesting xc3028-v27.fw
xc2028 0-0061: Error: firmware xc3028-v27.fw not found.
generic-usb 0003:051D:0002.0003: hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g9 .D USB FW:g9 ] on usb-0000:00:1a.2-2/input0
usb 1-1.1.1: new high speed USB device using ehci_hcd and address 7
scsi6 : usb-storage 1-1.1.1:1.0
vboxdrv: Trying to deactivate the NMI watchdog permanently...
vboxdrv: Warning: 2.6.31+ kernel detected. Most likely the hardware performance
vboxdrv: counter framework which can generate NMIs is active. You have to prevent
vboxdrv: the usage of hardware performance counters by
vboxdrv:   echo 2 > /proc/sys/kernel/perf_counter_paranoid
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
cx8800 0000:07:00.0: firmware: requesting xc3028-v27.fw
cx88 IR (PowerColor RA330): unknown key for scancode 0x003f
cx88 IR (PowerColor RA330): unknown key: key=0x3f down=1
cx88 IR (PowerColor RA330): unknown key: key=0x3f down=0
xc2028 0-0061: Error: firmware xc3028-v27.fw not found.
cx8800 0000:07:00.0: firmware: requesting xc3028-v27.fw
xc2028 0-0061: Error: firmware xc3028-v27.fw not found.
generic-usb 0003:051D:0002.0003: hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g9 .D USB FW:g9 ] on usb-0000:00:1a.2-2/input0
usb 1-1.1.1: new high speed USB device using ehci_hcd and address 7
scsi6 : usb-storage 1-1.1.1:1.0
vboxdrv: Trying to deactivate the NMI watchdog permanently...
vboxdrv: Warning: 2.6.31+ kernel detected. Most likely the hardware performance
vboxdrv: counter framework which can generate NMIs is active. You have to prevent
vboxdrv: the usage of hardware performance counters by
vboxdrv:   echo 2 > /proc/sys/kernel/perf_counter_paranoid
vboxdrv: Found 8 processor cores.
VBoxDrv: dbg - g_abExecMemory=ffffffffa024e380
vboxdrv: fAsync=0 offMin=0x1a4 offMax=0x385b
vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
vboxdrv: Successfully loaded version 3.1.6 (interface 0x00100001).
i2c /dev entries driver
usb 1-1.1.2: new low speed USB device using ehci_hcd and address 8
input: Logitech Optical USB Mouse as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/input/input7
generic-usb 0003:046D:C016.0004: input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.7-1.1.2/input0
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:06:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
r8169 0000:06:00.0: setting latency timer to 64
r8169 0000:06:00.0: irq 31 for MSI/MSI-X
eth0: RTL8168c/8111c at 0xffffc9001181e000, 00:24:21:b8:b2:2b, XID 1c4000c0 IRQ 31
r8169: eth0: link down
r8169: eth0: link down
NET: Registered protocol family 17
r8169: eth0: link up
scsi 6:0:0:0: Direct-Access     Generic  Flash HS-CF      5.39 PQ: 0 ANSI: 0
sd 6:0:0:0: [sdb] Attached SCSI removable disk
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
ip_tables: (C) 2000-2006 Netfilter Core Team
cx8800 0000:07:00.0: firmware: requesting xc3028-v27.fw
xc2028 0-0061: Error: firmware xc3028-v27.fw not found.
xc2028 0-0061: Error on line 1135: -6
uvcvideo: Failed to query (1) UVC control 4 (unit 1) : -32 (exp. 4).
nvidia: module license 'NVIDIA' taints kernel.
Disabling lock debugging due to kernel taint
nvidia 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
nvidia 0000:02:00.0: setting latency timer to 64
vgaarb: device changed decodes: PCI:0000:02:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  195.36.24  Thu Apr 22 19:10:14 PDT 2010
process `skype' is using obsolete setsockopt SO_BSDCOMPAT

-- 
