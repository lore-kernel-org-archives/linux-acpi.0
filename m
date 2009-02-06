From: Adam Pigg <piggz1@gmail.com>
Subject: Re: Problems with Toshiba Satellite L355
Date: Fri, 6 Feb 2009 18:47:40 +0000
Message-ID: <200902061847.41050.adam@piggz.co.uk>
References: <200902052311.31794.adam@piggz.co.uk> <1233883554.3625.8.camel@localhost.localdomain>
Reply-To: adam@piggz.co.uk
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NXIjJ2gje30PQZ+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:34712 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278AbZBFSuc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 13:50:32 -0500
Received: by ewy14 with SMTP id 14so1521335ewy.13
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2009 10:50:29 -0800 (PST)
In-Reply-To: <1233883554.3625.8.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

--Boundary-00=_NXIjJ2gje30PQZ+
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 06 February 2009 01:25:54 yakui_zhao wrote:
> On Fri, 2009-02-06 at 07:11 +0800, Adam Pigg wrote:
> > Hi
> >
> > i have 2 acpi related (i think) problems with my satellite l355 which i
> > hope someone can help with.
> >
> > 1. /proc/acpi/ac_adapter.../state always show the correct state, but
> > acpi_listen and lshal --monitor dont see any un/plug events.
>
> Will you please do the following test?
>    a. kill the process which is using /proc/acpi/event (Use the command
> of "lsof /proc/acpi/event" to get the process ID)
>    b. grep . /sys/firmware/acpi/interrupts/* >interrupts_before;
>    c. cat /proc/acpi/event . then you plug/unplug the AC adapter and see
> whether the ACPI event can be reported
>    d. after the test, grep . /sys/firmware/acpi/interrupts/* >
> interrupts_after
>
>    If no ACPI event is reported, will you please file a bug report at
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI and attach the
> output of acpidump, lspci -vxxx ?
>    Thanks.
>
> > 2. The machine will suspend to ram, resume, but after a second suspend,
> > wont resume.
>
>      Will you please add the boot option of "acpi_sleep=s3_beep" and do
> the following test?
>     a. kill the process which is using /proc/acpi/event
>     b. echo mem > /sys/power/state; dmesg >dmesg_after;
>     c. press the power button and see whether the box can be resumed.
>
>     If it can't be resumed, please reboot the system and check whether
> there exists the file of "dmesg_after".
>     Thanks.
>
So, ive tried this twice, with the same result both times.

After the first resume i have the file dmesg_after1, but repeating it, i dont 
get a dmesg_after2.

Also odd is that it takes almost exactly 60 seconds from pressing the power 
button to the desktop appearing (timed with stop watch) in the first resume, 
so i may as well boot normally, its just as quick! :)

So, any more ideas? another bug to open?

Cheers
> > I think i saw a similar sounding problem on an R500, but it was fixed.
> >
> > Ive attached the output of dmidecode, and am using 2.6.29rc3.
> >
> > Anything else that will  help let me know.
> >
> > Cheers
> >
> > Adam



--Boundary-00=_NXIjJ2gje30PQZ+
Content-Type: text/plain;
  charset="UTF-8";
  name="dmesg_after1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_after1"

Linux version 2.6.29-0.rc3.1mdv (mandrake@deborah.mandriva.com) (gcc version 4.3.2 (GCC) ) #1 SMP Sun Feb 1 09:49:14 EST 2009
Command line: BOOT_IMAGE=2.6.29rc3-1 root=UUID=13e63d3e-a73e-48a1-9878-8dfbf32eafe1 resume=UUID=7ddd248f-1dd8-4820-a4a1-4ade1fdc5da9 splash=silent vga=788 acpi_sleep=s3_beep
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bf4de000 (usable)
 BIOS-e820: 00000000bf4de000 - 00000000bf4e9000 (reserved)
 BIOS-e820: 00000000bf4e9000 - 00000000bf543000 (usable)
 BIOS-e820: 00000000bf543000 - 00000000bf546000 (reserved)
 BIOS-e820: 00000000bf546000 - 00000000bf5bb000 (usable)
 BIOS-e820: 00000000bf5bb000 - 00000000bf5bf000 (reserved)
 BIOS-e820: 00000000bf5bf000 - 00000000bf669000 (usable)
 BIOS-e820: 00000000bf669000 - 00000000bf6bf000 (ACPI NVS)
 BIOS-e820: 00000000bf6bf000 - 00000000bf700000 (ACPI data)
 BIOS-e820: 00000000bf700000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
DMI 2.4 present.
last_pfn = 0xbf669 max_arch_pfn = 0x100000000
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
init_memory_mapping: 0000000000000000-00000000bf669000
 0000000000 - 00bf600000 page 2M
 00bf600000 - 00bf669000 page 4k
kernel direct mapping tables up to bf669000 @ 8000-d000
last_map_addr: bf669000 end: bf669000
RAMDISK: 37c25000 - 37feff9b
ACPI: RSDP 000FE020, 0024 (r2 TOSINV)
ACPI: XSDT BF6FE120, 0064 (r1 TOSINV TOSINV00        1       1000013)
ACPI: FACP BF6FD000, 00F4 (r4 TOSINV TOSINV00        1 MSFT  1000013)
FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
ACPI: DSDT BF6F5000, 78BB (r1 TOSINV TOSINV00        1 MSFT  1000013)
ACPI: FACS BF675000, 0040
ACPI: APIC BF6F4000, 0068 (r2 TOSINV TOSINV00        1 MSFT  1000013)
ACPI: HPET BF6F3000, 0038 (r1 TOSINV TOSINV00        1 MSFT  1000013)
ACPI: MCFG BF6F2000, 003C (r1 TOSINV TOSINV00        1 MSFT  1000013)
ACPI: ASF! BF6F1000, 00A5 (r32 TOSINV TOSINV00        1 MSFT  1000013)
ACPI: SLIC BF6F0000, 0176 (r1 TOSINV TOSINV00        1 MSFT  1000013)
ACPI: BOOT BF6EF000, 0028 (r1 TOSINV TOSINV00        1 MSFT  1000013)
ACPI: SSDT BF6EE000, 04C4 (r1  PmRef    CpuPm     3000 INTL 20051117)
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
Faking a node at 0000000000000000-00000000bf669000
Bootmem setup node 0 0000000000000000-00000000bf669000
  NODE_DATA [0000000000001000 - 0000000000005fff]
  bootmap [000000000000b000 -  0000000000022ecf] pages 18
(6 early reservations) ==> bootmem [0000000000 - 00bf669000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0000200000 - 000081e9d0]    TEXT DATA BSS ==> [0000200000 - 000081e9d0]
  #3 [0037c25000 - 0037feff9b]          RAMDISK ==> [0037c25000 - 0037feff9b]
  #4 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
  #5 [0000008000 - 000000b000]          PGTABLE ==> [0000008000 - 000000b000]
found SMP MP-table at [ffff8800000fe250] 000fe250
 [ffffe20000000000-ffffe200029fffff] PMD -> [ffff880001200000-ffff880003bfffff] on node 0
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00100000
Movable zone start PFN for each node
early_node_map[5] active PFN ranges
    0: 0x00000000 -> 0x0000009f
    0: 0x00000100 -> 0x000bf4de
    0: 0x000bf4e9 -> 0x000bf543
    0: 0x000bf546 -> 0x000bf5bb
    0: 0x000bf5bf -> 0x000bf669
On node 0 totalpages: 783862
  DMA zone: 56 pages used for memmap
  DMA zone: 1670 pages reserved
  DMA zone: 2273 pages, LIFO batch:0
  DMA32 zone: 10663 pages used for memmap
  DMA32 zone: 769200 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 0, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
PM: Registered nosave memory: 00000000bf4de000 - 00000000bf4e9000
PM: Registered nosave memory: 00000000bf543000 - 00000000bf546000
PM: Registered nosave memory: 00000000bf5bb000 - 00000000bf5bf000
Allocating PCI resources starting at c4000000 (gap: c0000000:38000000)
NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_node_ids:1
PERCPU: Allocating 53248 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 771473
Policy zone: DMA32
Kernel command line: BOOT_IMAGE=2.6.29rc3-1 root=UUID=13e63d3e-a73e-48a1-9878-8dfbf32eafe1 resume=UUID=7ddd248f-1dd8-4820-a4a1-4ade1fdc5da9 splash=silent vga=788 acpi_sleep=s3_beep
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Fast TSC calibration using PIT
Detected 1828.889 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Checking aperture...
No AGP bridge found
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 3081956k/3135908k available (3137k kernel code, 460k absent, 53492k reserved, 1723k data, 568k init)
SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
hpet clockevent registered
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
Calibrating delay loop (skipped), value calculated using timer frequency.. 3657.77 BogoMIPS (lpj=1828889)
Security Framework initialized
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
[ds] using core 2 configuration
CPU 0/0x0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring handled by SMI
using mwait in idle threads.
ACPI: Core revision 20081204
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.68 BogoMIPS (lpj=1828842)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
[ds] using core 2 configuration
CPU 1/0x1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
Total of 2 processors activated (7315.46 BogoMIPS).
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
net_namespace: 1840 bytes
Booting paravirtualized kernel on bare hardware
regulator: core version 0.5
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MCFG configuration 0: base f8000000 segment 0 buses 0 - 63
PCI: MCFG area at f8000000 reserved in E820
PCI: Using MMCONFIG at f8000000 - fbffffff
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
CPU1: Temperature/speed normal
ACPI: BIOS _OSI(Linux) query ignored
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE storm detected, transactions will use polling mode
ACPI: EC: missing confirmations, switch off interrupt mode.
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in poll mode
ACPI: No dock devices found.
ACPI Warning (nspredef-0328): \_SB_.PCI0._OSC: Parameter count mismatch - ASL declared 5, ACPI requires 4 [20081204]
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:02.0: reg 10 64bit mmio: [0xd3100000-0xd31fffff]
pci 0000:00:02.0: reg 18 64bit mmio: [0xc0000000-0xcfffffff]
pci 0000:00:02.0: reg 20 io port: [0x6110-0x6117]
pci 0000:00:02.1: reg 10 64bit mmio: [0xd3200000-0xd32fffff]
pci 0000:00:1a.0: reg 20 io port: [0x60c0-0x60df]
pci 0000:00:1a.1: reg 20 io port: [0x60a0-0x60bf]
pci 0000:00:1a.7: reg 10 32bit mmio: [0xd6404c00-0xd6404fff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1b.0: reg 10 64bit mmio: [0xd6400000-0xd6403fff]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: PME# disabled
pci 0000:00:1d.0: reg 20 io port: [0x6080-0x609f]
pci 0000:00:1d.1: reg 20 io port: [0x6060-0x607f]
pci 0000:00:1d.2: reg 20 io port: [0x6040-0x605f]
pci 0000:00:1d.7: reg 10 32bit mmio: [0xd6404800-0xd6404bff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 1640 (mask 000f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 0068 (mask 0007)
pci 0000:00:1f.1: reg 10 io port: [0x6108-0x610f]
pci 0000:00:1f.1: reg 14 io port: [0x6124-0x6127]
pci 0000:00:1f.1: reg 18 io port: [0x6100-0x6107]
pci 0000:00:1f.1: reg 1c io port: [0x6120-0x6123]
pci 0000:00:1f.1: reg 20 io port: [0x60e0-0x60ef]
pci 0000:00:1f.2: reg 10 io port: [0x60f8-0x60ff]
pci 0000:00:1f.2: reg 14 io port: [0x611c-0x611f]
pci 0000:00:1f.2: reg 18 io port: [0x60f0-0x60f7]
pci 0000:00:1f.2: reg 1c io port: [0x6118-0x611b]
pci 0000:00:1f.2: reg 20 io port: [0x6020-0x603f]
pci 0000:00:1f.2: reg 24 32bit mmio: [0xd6404000-0xd64047ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 10 32bit mmio: [0xd6405000-0xd64050ff]
pci 0000:00:1f.3: reg 20 io port: [0x6000-0x601f]
pci 0000:02:00.0: reg 10 io port: [0x4000-0x40ff]
pci 0000:02:00.0: reg 18 64bit mmio: [0xd0010000-0xd0010fff]
pci 0000:02:00.0: reg 20 64bit mmio: [0xd0000000-0xd000ffff]
pci 0000:02:00.0: unsupported PM cap regs version (7)
pci 0000:00:1c.0: bridge io port: [0x4000-0x5fff]
pci 0000:00:1c.0: bridge 32bit mmio: [0xd5400000-0xd63fffff]
pci 0000:00:1c.0: bridge 64bit mmio pref: [0xd0000000-0xd10fffff]
pci 0000:03:00.0: reg 10 32bit mmio: [0xd4300000-0xd4300fff]
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.1: bridge io port: [0x3000-0x3fff]
pci 0000:00:1c.1: bridge 32bit mmio: [0xd4300000-0xd53fffff]
pci 0000:00:1c.1: bridge 64bit mmio pref: [0xd1100000-0xd20fffff]
pci 0000:00:1c.4: bridge io port: [0x2000-0x2fff]
pci 0000:00:1c.4: bridge 32bit mmio: [0xd3300000-0xd42fffff]
pci 0000:00:1c.4: bridge 64bit mmio pref: [0xd2100000-0xd30fffff]
pci 0000:00:1e.0: transparent bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: Power Resource [FN00] (on)
PCI: Using ACPI for IRQ routing
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 9 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: ioport range 0x164e-0x164f has been reserved
system 00:01: ioport range 0x800-0x80f has been reserved
system 00:01: ioport range 0x400-0x47f has been reserved
system 00:01: ioport range 0x500-0x53f has been reserved
system 00:01: iomem range 0xf8000000-0xfbffffff has been reserved
system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
system 00:01: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:01: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:04: iomem range 0xfed00000-0xfed003ff has been reserved
pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
pci 0000:00:1c.0:   IO window: 0x4000-0x5fff
pci 0000:00:1c.0:   MEM window: 0xd5400000-0xd63fffff
pci 0000:00:1c.0:   PREFETCH window: 0x000000d0000000-0x000000d10fffff
pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
pci 0000:00:1c.1:   IO window: 0x3000-0x3fff
pci 0000:00:1c.1:   MEM window: 0xd4300000-0xd53fffff
pci 0000:00:1c.1:   PREFETCH window: 0x000000d1100000-0x000000d20fffff
pci 0000:00:1c.4: PCI bridge, secondary bus 0000:08
pci 0000:00:1c.4:   IO window: 0x2000-0x2fff
pci 0000:00:1c.4:   MEM window: 0xd3300000-0xd42fffff
pci 0000:00:1c.4:   PREFETCH window: 0x000000d2100000-0x000000d30fffff
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:06
pci 0000:00:1e.0:   IO window: disabled
pci 0000:00:1e.0:   MEM window: disabled
pci 0000:00:1e.0:   PREFETCH window: disabled
pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.1: setting latency timer to 64
pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.4: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:02: resource 0 io:  [0x4000-0x5fff]
pci_bus 0000:02: resource 1 mem: [0xd5400000-0xd63fffff]
pci_bus 0000:02: resource 2 mem: [0xd0000000-0xd10fffff]
pci_bus 0000:02: resource 3 mem: [0x0-0x0]
pci_bus 0000:03: resource 0 io:  [0x3000-0x3fff]
pci_bus 0000:03: resource 1 mem: [0xd4300000-0xd53fffff]
pci_bus 0000:03: resource 2 mem: [0xd1100000-0xd20fffff]
pci_bus 0000:03: resource 3 mem: [0x0-0x0]
pci_bus 0000:08: resource 0 io:  [0x2000-0x2fff]
pci_bus 0000:08: resource 1 mem: [0xd3300000-0xd42fffff]
pci_bus 0000:08: resource 2 mem: [0xd2100000-0xd30fffff]
pci_bus 0000:08: resource 3 mem: [0x0-0x0]
pci_bus 0000:06: resource 0 mem: [0x0-0x0]
pci_bus 0000:06: resource 1 mem: [0x0-0x0]
pci_bus 0000:06: resource 2 mem: [0x0-0x0]
pci_bus 0000:06: resource 3 io:  [0x00-0xffff]
pci_bus 0000:06: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
Freeing initrd memory: 3883k freed
Simple Boot Flag value 0x5 read from CMOS RAM was invalid
Simple Boot Flag at 0x44 set to 0x1
audit: initializing netlink socket (disabled)
type=2000 audit(1233944364.094:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 6027
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:02.0: Boot video device
pcieport-driver 0000:00:1c.0: setting latency timer to 64
pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
pcieport-driver 0000:00:1c.1: setting latency timer to 64
pcieport-driver 0000:00:1c.1: irq 25 for MSI/MSI-X
pcieport-driver 0000:00:1c.4: setting latency timer to 64
pcieport-driver 0000:00:1c.4: irq 26 for MSI/MSI-X
vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20005100000, using 1875k, total 7616k
vesafb: mode is 800x600x16, linelength=1600, pages=6
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel 965GM Chipset
agpgart-intel 0000:00:00.0: detected 7676K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
brd: module loaded
input: Macintosh mouse button emulation as /class/input/input0
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
registered taskstats version 1
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 568k freed
input: AT Translated Set 2 keyboard as /class/input/input1
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
libata version 3.00 loaded.
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: irq 27 for MSI/MSI-X
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led clo pmp pio slum part ems 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 abar m2048@0xd6404000 port 0xd6404100 irq 27
ata2: SATA max UDMA/133 abar m2048@0xd6404000 port 0xd6404180 irq 27
ata3: DUMMY
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: Hitachi HTS542520K9SA00, BBDOC33P, max UDMA/133
ata1.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54252 BBDO PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<6>Synaptics Touchpad, model: 1, fw: 6.3, id: 0x9280b1, caps: 0xa04711/0xa04000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
 sda1 sda2 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
ata2: SATA link down (SStatus 0 SControl 300)
ata_piix 0000:00:1f.1: version 2.12
ata_piix 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi3 : ata_piix
scsi4 : ata_piix
ata4: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x60e0 irq 14
ata5: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x60e8 irq 15
ata4.00: ATAPI: PIONEER DVD-RW  DVRKD08L, 2.51, max UDMA/33
ata4.00: configured for UDMA/33
isa bounce pool size: 16 pages
scsi 3:0:0:0: CD-ROM            PIONEER  DVD-RW  DVRKD08L 2.51 PQ: 0 ANSI: 5
Uniform Multi-Platform E-IDE driver
ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 403719
ext3_orphan_cleanup: deleting unreferenced inode 403707
ext3_orphan_cleanup: deleting unreferenced inode 403718
ext3_orphan_cleanup: deleting unreferenced inode 403709
ext3_orphan_cleanup: deleting unreferenced inode 403713
EXT3-fs: sda1: 5 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: AC Adapter [ADP0] (on-line)
input: Power Button (FF) as /class/input/input3
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
input: Lid Switch as /class/input/input5
ACPI: Lid Switch [LID]
ACPI: SSDT BF674C90, 01F0 (r1  PmRef  Cpu0Ist     3000 INTL 20051117)
ACPI: SSDT BF673610, 05B3 (r1  PmRef  Cpu0Cst     3001 INTL 20051117)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
processor ACPI_CPU:00: registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT BF674F10, 00C4 (r1  PmRef  Cpu1Ist     3000 INTL 20051117)
ACPI: SSDT BF676D10, 0083 (r1  PmRef  Cpu1Cst     3000 INTL 20051117)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
processor ACPI_CPU:01: registered as cooling_device1
ACPI: Processor [CPU1] (supports 8 throttling states)
Marking TSC unstable due to TSC halts in idle
thermal LNXTHERM:01: registered as thermal_zone0
ACPI: Transitioning device [FAN] to D3
ACPI: Thermal Zone [THRM] (55 C)
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, 242 bytes nvram, hpet irqs
Driver 'sr' needs updating - please use bus_type methods
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 3:0:0:0: Attached scsi generic sg1 type 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
fan PNP0C0B:00: registered as cooling_device2
ACPI: Fan [FAN] (on)
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 16, io base 0x000060c0
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.29-0.rc3.1mdv uhci_hcd
usb usb1: SerialNumber: 0000:00:1a.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 21, io base 0x000060a0
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.29-0.rc3.1mdv uhci_hcd
usb usb2: SerialNumber: 0000:00:1a.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00006080
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.29-0.rc3.1mdv uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00006060
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.29-0.rc3.1mdv uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00006040
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.29-0.rc3.1mdv uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.2
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xd6404c00
iTCO_vendor_support: vendor-support=0
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: EHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.29-0.rc3.1mdv ehci_hcd
usb usb6: SerialNumber: 0000:00:1a.7
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 4 ports detected
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd6404800
acpi device:1a: registered as cooling_device3
input: Video Bus as /class/input/input6
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: EHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.29-0.rc3.1mdv ehci_hcd
usb usb7: SerialNumber: 0000:00:1d.7
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
ACPI: Video Device [OVGA] (multi-head: yes  rom: no  post: no)
cfg80211: Using static regulatory domain info
cfg80211: Regulatory domain: US
	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
	(2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
	(5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
cfg80211: Calling CRDA for country: US
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.04
iTCO_wdt: Found a ICH8M TCO device (Version=2, TCOBASE=0x0460)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=1)
lib80211: common routines for IEEE802.11 drivers
lib80211_crypt: registered algorithm 'NULL'
i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) -> IRQ 19
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
r8169 0000:02:00.0: setting latency timer to 64
r8169 0000:02:00.0: irq 28 for MSI/MSI-X
eth0: RTL8102e at 0xffffc2000067c000, 00:1e:33:34:5d:5c, XID 34a00000 IRQ 28
usb 6-2: new high speed USB device using ehci_hcd and address 2
usb 6-2: New USB device found, idVendor=04f2, idProduct=b070
usb 6-2: New USB device strings: Mfr=2, Product=1, SerialNumber=3
usb 6-2: Product: CNF7051
usb 6-2: Manufacturer: Chicony Electronics Co., Ltd.
usb 6-2: SerialNumber: SN0001
usb 6-2: configuration #1 chosen from 1 choice
usb 6-4: new high speed USB device using ehci_hcd and address 3
iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.2.26ks
iwl3945: Copyright(c) 2003-2008 Intel Corporation
iwl3945 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
iwl3945 0000:03:00.0: setting latency timer to 64
iwl3945: Tunable channels: 11 802.11bg, 13 802.11a channels
iwl3945: Detected Intel Wireless WiFi Link 3945ABG
iwl3945 0000:03:00.0: PCI INT A disabled
wmaster0 (iwl3945): not using net_device_ops yet
phy0: Selected rate control algorithm 'iwl-3945-rs'
Linux video capture interface: v2.00
usb 6-4: New USB device found, idVendor=0bda, idProduct=0158
usb 6-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 6-4: Product: USB2.0-CRW
usb 6-4: Manufacturer: Generic
usb 6-4: SerialNumber: 20071114173400000
usb 6-4: configuration #1 chosen from 1 choice
wlan0 (iwl3945): not using net_device_ops yet
uvcvideo: Found UVC 1.00 device CNF7051 (04f2:b070)
uvcvideo: UVC non compliance - GET_DEF(PROBE) not supported. Enabling workaround.
input: CNF7051 as /class/input/input7
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
Initializing USB Mass Storage driver...
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
iwl3945 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
iwl3945 0000:03:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
iwl3945 0000:03:00.0: irq 29 for MSI/MSI-X
iwl3945 0000:03:00.0: firmware: requesting iwlwifi-3945-2.ucode
usb 4-1: new full speed USB device using uhci_hcd and address 2
iwl3945: iwlwifi-3945-2.ucode firmware file req failed: Reason -2
iwl3945 0000:03:00.0: firmware: requesting iwlwifi-3945-1.ucode
usb 4-1: New USB device found, idVendor=1caa, idProduct=0001
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: configuration #1 chosen from 1 choice
iwl3945: Loaded firmware iwlwifi-3945-1.ucode, which is deprecated. Please use API v2 instead.
iwl3945: Firmware has old API version. Expected 2, got 1. New firmware can be obtained from http://www.intellinuxwireless.org.
iwl3945 loaded firmware version 15.28.1.6
Registered led device: iwl-phy0:radio
Registered led device: iwl-phy0:assoc
Registered led device: iwl-phy0:RX
Registered led device: iwl-phy0:TX
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
Bluetooth: Core ver 2.14
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: Generic Bluetooth USB driver ver 0.4
usbcore: registered new interface driver btusb
Non-volatile memory driver v1.3
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
EXT3 FS on sda1, internal journal
scsi 5:0:0:0: Direct-Access     Generic- Multi-Card       1.00 PQ: 0 ANSI: 0 CCS
sd 5:0:0:0: [sdb] Attached SCSI removable disk
sd 5:0:0:0: Attached scsi generic sg2 type 0
usb-storage: device scan complete
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: module loaded
Adding 4088500k swap on /dev/sda5.  Priority:-1 extents:1 across:4088500k 
Clocksource tsc unstable (delta = -146567518 ns)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): wlan0: link is not ready
Bluetooth: L2CAP ver 2.11
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bridge firewalling registered
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.10
Bluetooth: SCO (Voice Link) ver 0.6
Bluetooth: SCO socket layer initialized
[drm] Initialized drm 1.1.0 20060810
pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:02.0: setting latency timer to 64
pci 0000:00:02.0: irq 30 for MSI/MSI-X
[drm] Initialized i915 1.6.0 20080730 on minor 0
X:4191 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
X:4191 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
X:4191 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
X:4191 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
X:4339 freeing invalid memtype c0000000-d0000000
X:4191 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
X:4340 freeing invalid memtype c0000000-d0000000
X:4191 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
X:4617 freeing invalid memtype c0000000-d0000000
iwl3945 0000:03:00.0: PCI INT A disabled
iwl3945 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
iwl3945 0000:03:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
iwl3945 0000:03:00.0: irq 29 for MSI/MSI-X
Registered led device: iwl-phy0:radio
Registered led device: iwl-phy0:assoc
Registered led device: iwl-phy0:RX
Registered led device: iwl-phy0:TX
ADDRCONF(NETDEV_UP): wlan0: link is not ready
wlan0: direct probe to AP 00:12:bf:16:43:ea try 1
wlan0 direct probe responded
wlan0: authenticate with AP 00:12:bf:16:43:ea
wlan0: authenticated
wlan0: associate with AP 00:12:bf:16:43:ea
wlan0: RX AssocResp from 00:12:bf:16:43:ea (capab=0x461 status=0 aid=2)
wlan0: associated
ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
wlan0: authenticate with AP 00:12:bf:16:43:ea
wlan0: authenticated
wlan0: associate with AP 00:12:bf:16:43:ea
wlan0: RX ReassocResp from 00:12:bf:16:43:ea (capab=0x461 status=0 aid=2)
wlan0: associated
NET: Registered protocol family 17
wlan0: no IPv6 routers present
Machine check events logged
PM: Syncing filesystems ... done.
X:4191 freeing invalid memtype c0000000-d0000000
Freezing user space processes ... (elapsed 0.03 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
btusb_intr_complete: hci0 urb ffff8800ba078240 failed to resubmit (1)
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
iwl3945 0000:03:00.0: PCI INT A disabled
ata_piix 0000:00:1f.1: PCI INT A disabled
ehci_hcd 0000:00:1d.7: PCI INT A disabled
ehci_hcd 0000:00:1d.7: PME# disabled
uhci_hcd 0000:00:1d.2: PCI INT C disabled
uhci_hcd 0000:00:1d.1: PCI INT B disabled
uhci_hcd 0000:00:1d.0: PCI INT A disabled
HDA Intel 0000:00:1b.0: PCI INT A disabled
ehci_hcd 0000:00:1a.7: PCI INT C disabled
ehci_hcd 0000:00:1a.7: PME# disabled
uhci_hcd 0000:00:1a.1: PCI INT B disabled
uhci_hcd 0000:00:1a.0: PCI INT A disabled
ACPI: Preparing to enter system sleep state S3
Disabling non-boot CPUs ...
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
CPU0 attaching NULL sched-domain.
CPU1 is down
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Back to C!
pci 0000:00:02.0: restoring config space at offset 0x6 (was 0xc, writing 0xc000000c)
pci 0000:00:02.0: restoring config space at offset 0x1 (was 0x900007, writing 0x900403)
HDA Intel 0000:00:1b.0: restoring config space at offset 0x1 (was 0x100006, writing 0x100002)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0xf (was 0x100, writing 0x105)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x9 (was 0x10001, writing 0xd101d001)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x8 (was 0x0, writing 0xd630d540)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x7 (was 0x20000000, writing 0x5040)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x6 (was 0x0, writing 0x20200)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
pcieport-driver 0000:00:1c.0: restoring config space at offset 0x7 (was 0x20005040, writing 0x5040)
pcieport-driver 0000:00:1c.1: restoring config space at offset 0xf (was 0x200, writing 0x20b)
pcieport-driver 0000:00:1c.1: restoring config space at offset 0x9 (was 0x10001, writing 0xd201d111)
pcieport-driver 0000:00:1c.1: restoring config space at offset 0x8 (was 0x0, writing 0xd530d430)
pcieport-driver 0000:00:1c.1: restoring config space at offset 0x7 (was 0x20000000, writing 0x3030)
pcieport-driver 0000:00:1c.1: restoring config space at offset 0x6 (was 0x0, writing 0x30300)
pcieport-driver 0000:00:1c.1: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
pcieport-driver 0000:00:1c.1: restoring config space at offset 0x7 (was 0x20003030, writing 0x3030)
pcieport-driver 0000:00:1c.4: restoring config space at offset 0xf (was 0x100, writing 0x10b)
pcieport-driver 0000:00:1c.4: restoring config space at offset 0x9 (was 0x10001, writing 0xd301d211)
pcieport-driver 0000:00:1c.4: restoring config space at offset 0x8 (was 0x0, writing 0xd420d330)
pcieport-driver 0000:00:1c.4: restoring config space at offset 0x7 (was 0x20000000, writing 0x2020)
pcieport-driver 0000:00:1c.4: restoring config space at offset 0x6 (was 0x0, writing 0x90800)
pcieport-driver 0000:00:1c.4: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
pcieport-driver 0000:00:1c.4: restoring config space at offset 0x7 (was 0x20002020, writing 0x2020)
pci 0000:00:1e.0: restoring config space at offset 0x9 (was 0x10001, writing 0x1fff1)
pci 0000:00:1e.0: restoring config space at offset 0x8 (was 0x0, writing 0xfff0)
pci 0000:00:1e.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100003)
ata_piix 0000:00:1f.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2880005)
ahci 0000:00:1f.2: restoring config space at offset 0x1 (was 0x2b00007, writing 0x2b00407)
r8169 0000:02:00.0: restoring config space at offset 0xf (was 0x1ff, writing 0x105)
r8169 0000:02:00.0: restoring config space at offset 0x8 (was 0xc, writing 0xd000000c)
r8169 0000:02:00.0: restoring config space at offset 0x6 (was 0xc, writing 0xd001000c)
r8169 0000:02:00.0: restoring config space at offset 0x4 (was 0x1, writing 0x4001)
r8169 0000:02:00.0: restoring config space at offset 0x3 (was 0x0, writing 0x8)
r8169 0000:02:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
iwl3945 0000:03:00.0: restoring config space at offset 0xf (was 0x100, writing 0x10b)
iwl3945 0000:03:00.0: restoring config space at offset 0x4 (was 0x0, writing 0xd4300000)
iwl3945 0000:03:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100006)
Enabling non-boot CPUs ...
SMP alternatives: switching to SMP code
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3662.80 BogoMIPS (lpj=1831402)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
[ds] using core 2 configuration
CPU 1/0x1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
CPU0 attaching NULL sched-domain.
Switched to high resolution mode on CPU 1
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
CPU1 is up
ACPI: Waking up from system sleep state S3
ACPI: Transitioning device [FAN] to D3
ACPI: Unable to turn cooling device [ffff8800bee31540] 'off'
pci 0000:00:02.0: PME# disabled
pci 0000:00:02.1: PME# disabled
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
usb usb1: root hub lost power or was reset
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
usb usb2: root hub lost power or was reset
ehci_hcd 0000:00:1a.7: PME# disabled
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: PME# disabled
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
pcieport-driver 0000:00:1c.0: setting latency timer to 64
pcieport-driver 0000:00:1c.1: setting latency timer to 64
pcieport-driver 0000:00:1c.4: setting latency timer to 64
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
usb usb3: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
usb usb4: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: PME# disabled
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: PME# disabled
pci 0000:00:1e.0: setting latency timer to 64
ata_piix 0000:00:1f.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2880005)
ata_piix 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.1: setting latency timer to 64
ahci 0000:00:1f.2: setting latency timer to 64
iwl3945 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
iwl3945 0000:03:00.0: irq 29 for MSI/MSI-X
sd 0:0:0:0: [sda] Starting disk
Registered led device: iwl-phy0:radio
Registered led device: iwl-phy0:assoc
Registered led device: iwl-phy0:RX
Registered led device: iwl-phy0:TX
ata4.00: configured for UDMA/33
ata2: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
usb 6-2: reset high speed USB device using ehci_hcd and address 2
usb 6-4: reset high speed USB device using ehci_hcd and address 3
usb 4-1: reset full speed USB device using uhci_hcd and address 2
btusb 4-1:1.0: no reset_resume for driver btusb?
btusb 4-1:1.1: no reset_resume for driver btusb?
pci 0000:00:02.0: setting latency timer to 64
Restarting tasks ... done.

--Boundary-00=_NXIjJ2gje30PQZ+--
