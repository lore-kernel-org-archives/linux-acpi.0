From: Adam Pigg <piggz1@gmail.com>
Subject: Re: Problems with Toshiba Satellite L355
Date: Mon, 9 Feb 2009 20:03:25 +0000
Message-ID: <200902092003.26112.adam@piggz.co.uk>
References: <200902052311.31794.adam@piggz.co.uk> <200902061847.41050.adam@piggz.co.uk> <1234150278.3706.61.camel@localhost.localdomain>
Reply-To: adam@piggz.co.uk
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OwIkJIbalrwjuBL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:47648 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZBIUGS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Feb 2009 15:06:18 -0500
Received: by ewy14 with SMTP id 14so2754542ewy.13
        for <linux-acpi@vger.kernel.org>; Mon, 09 Feb 2009 12:06:15 -0800 (PST)
In-Reply-To: <1234150278.3706.61.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

--Boundary-00=_OwIkJIbalrwjuBL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 09 February 2009 03:31:18 yakui_zhao wrote:
> On Sat, 2009-02-07 at 02:47 +0800, Adam Pigg wrote:
> > On Friday 06 February 2009 01:25:54 yakui_zhao wrote:
> > > On Fri, 2009-02-06 at 07:11 +0800, Adam Pigg wrote:
> > > > Hi
> > > >
> > > > i have 2 acpi related (i think) problems with my satellite l355 whi=
ch
> > > > i hope someone can help with.
> > > >
> > > > 1. /proc/acpi/ac_adapter.../state always show the correct state, but
> > > > acpi_listen and lshal --monitor dont see any un/plug events.
> > >
> > > Will you please do the following test?
> > >    a. kill the process which is using /proc/acpi/event (Use the comma=
nd
> > > of "lsof /proc/acpi/event" to get the process ID)
> > >    b. grep . /sys/firmware/acpi/interrupts/* >interrupts_before;
> > >    c. cat /proc/acpi/event . then you plug/unplug the AC adapter and
> > > see whether the ACPI event can be reported
> > >    d. after the test, grep . /sys/firmware/acpi/interrupts/* >
> > > interrupts_after
> > >
> > >    If no ACPI event is reported, will you please file a bug report at
> > > http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI and attach the
> > > output of acpidump, lspci -vxxx ?
> > >    Thanks.
> > >
> > > > 2. The machine will suspend to ram, resume, but after a second
> > > > suspend, wont resume.
> > >
> > >      Will you please add the boot option of "acpi_sleep=3Ds3_beep" an=
d do
> > > the following test?
> > >     a. kill the process which is using /proc/acpi/event
> > >     b. echo mem > /sys/power/state; dmesg >dmesg_after;
> > >     c. press the power button and see whether the box can be resumed.
> > >
> > >     If it can't be resumed, please reboot the system and check whether
> > > there exists the file of "dmesg_after".
> > >     Thanks.
> >
> > So, ive tried this twice, with the same result both times.
> >
> > After the first resume i have the file dmesg_after1, but repeating it, i
> > dont get a dmesg_after2.
>
> Do you mean that the box can't be resumed on the second time test?
> Right? How do you do the second suspend/resume test?
>
> > Also odd is that it takes almost exactly 60 seconds from pressing the
> > power button to the desktop appearing (timed with stop watch) in the
> > first resume, so i may as well boot normally, its just as quick! :)
> >From the attached dmesg it seems that there is another issue about your
>
> box:
>    >ACPI: Unable to turn cooling device [ffff8800bee31540] 'off'
>
>    This is related with the broken FAN device definition. The status of
> power resource can't be reflected by the _STA object.
>
>    >Method (_STA, 0, Serialized)
>
>             {
>                 Store (0xF1, P80H)
>                 Return (One)  // It indicates that the power resource is
> turned on
>             }
>
>    For this issue please add the boot option of "acpi.power_nocheck=3D1"
>
> Do you mean that it is resumed very slowly?
>    Will you please add the boot option of "printk.time=3D1" and do the
> following test?
>    =EF=BB=BF
>    a. kill the process which is using /proc/acpi/event
>    b. echo mem > /sys/power/state; dmesg >dmesg_after;
>    c. press the power button and see whether the box can be resumed
>     If it can't be resumed, please reboot the system and check whether
>  there exists the file of "dmesg_after".
>
done that and attached the file....looks like the slow resume is due to X=20
somehow.

After the first resume, i tried again repeating the above, substituting=20
dmesg_after for dmesg_after3, but the file wasnt created and the machine di=
dnt=20
resume.

btw, this is using rc4 now.

Cheers

>  You can file a bug report at
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DPower Management
>
>    thanks.
>
> > So, any more ideas? another bug to open?
> >
> > Cheers
> >
> > > > I think i saw a similar sounding problem on an R500, but it was
> > > > fixed.
> > > >
> > > > Ive attached the output of dmidecode, and am using 2.6.29rc3.
> > > >
> > > > Anything else that will  help let me know.
> > > >
> > > > Cheers
> > > >
> > > > Adam



--Boundary-00=_OwIkJIbalrwjuBL
Content-Type: text/plain;
  charset="UTF-8";
  name="dmesg_after2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_after2"

Linux version 2.6.29-0.rc4.1mdv (mandrake@deborah.mandriva.com) (gcc version 4.3.2 (GCC) ) #1 SMP Sun Feb 8 16:45:12 EST 2009
Command line: BOOT_IMAGE=2.6.29rc4-1 root=UUID=13e63d3e-a73e-48a1-9878-8dfbf32eafe1 resume=UUID=7ddd248f-1dd8-4820-a4a1-4ade1fdc5da9 splash=silent vga=788 acpi.power_nocheck=1 printk.time=1
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
RAMDISK: 37c20000 - 37fef32f
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
  #2 [0000200000 - 000080e750]    TEXT DATA BSS ==> [0000200000 - 000080e750]
  #3 [0037c20000 - 0037fef32f]          RAMDISK ==> [0037c20000 - 0037fef32f]
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
  DMA zone: 1654 pages reserved
  DMA zone: 2289 pages, LIFO batch:0
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
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 771489
Policy zone: DMA32
Kernel command line: BOOT_IMAGE=2.6.29rc4-1 root=UUID=13e63d3e-a73e-48a1-9878-8dfbf32eafe1 resume=UUID=7ddd248f-1dd8-4820-a4a1-4ade1fdc5da9 splash=silent vga=788 acpi.power_nocheck=1 printk.time=1
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1828.944 MHz processor.
[    0.000999] Console: colour dummy device 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Checking aperture...
[    0.000999] No AGP bridge found
[    0.000999] Calgary: detecting Calgary via BIOS EBDA area
[    0.000999] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000999] Memory: 3082000k/3135908k available (3114k kernel code, 460k absent, 53448k reserved, 1683k data, 568k init)
[    0.000999] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000999] hpet clockevent registered
[    0.000999] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.000999] Calibrating delay loop (skipped), value calculated using timer frequency.. 3657.88 BogoMIPS (lpj=1828944)
[    0.000999] Security Framework initialized
[    0.000999] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003631] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.005186] Mount-cache hash table entries: 256
[    0.005394] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.005400] CPU: L2 cache: 2048K
[    0.005404] [ds] using Core 2/Atom configuration
[    0.005408] CPU 0/0x0 -> Node 0
[    0.005411] CPU: Physical Processor ID: 0
[    0.005414] CPU: Processor Core ID: 0
[    0.005423] CPU0: Thermal monitoring handled by SMI
[    0.005425] using mwait in idle threads.
[    0.007675] ACPI: Core revision 20081204
[    0.020058] Setting APIC routing to flat
[    0.020512] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.030966] CPU0: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
[    0.030995] Booting processor 1 APIC 0x1 ip 0x6000
[    0.000999] Initializing CPU#1
[    0.000999] Calibrating delay using timer specific routine.. 3657.67 BogoMIPS (lpj=1828838)
[    0.000999] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.000999] CPU: L2 cache: 2048K
[    0.000999] [ds] using Core 2/Atom configuration
[    0.000999] CPU 1/0x1 -> Node 0
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 1
[    0.000999] CPU1: Thermal monitoring enabled (TM2)
[    0.000999] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.102315] CPU1: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
[    0.102361] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.103049] Brought up 2 CPUs
[    0.103054] Total of 2 processors activated (7315.56 BogoMIPS).
[    0.103113] CPU0 attaching sched-domain:
[    0.103116]  domain 0: span 0-1 level MC
[    0.103119]   groups: 0 1
[    0.103123] CPU1 attaching sched-domain:
[    0.103125]  domain 0: span 0-1 level MC
[    0.103127]   groups: 1 0
[    0.103257] net_namespace: 1840 bytes
[    0.103274] Booting paravirtualized kernel on bare hardware
[    0.103987] regulator: core version 0.5
[    0.104031] NET: Registered protocol family 16
[    0.104061] ACPI: bus type pci registered
[    0.104061] PCI: MCFG configuration 0: base f8000000 segment 0 buses 0 - 63
[    0.104061] PCI: MCFG area at f8000000 reserved in E820
[    0.108795] PCI: Using MMCONFIG at f8000000 - fbffffff
[    0.108799] PCI: Using configuration type 1 for base access
[    0.110025] bio: create slab <bio-0> at 0
[    0.111619] ACPI: EC: Look up EC in DSDT
[    0.115678] ACPI: BIOS _OSI(Linux) query ignored
[    0.116998] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.121004] ACPI: EC: GPE storm detected, transactions will use polling mode
[    0.622003] ACPI: EC: missing confirmations, switch off interrupt mode.
[    0.729129] ACPI: Interpreter enabled
[    0.729134] ACPI: (supports S0 S1 S3 S4 S5)
[    0.729165] ACPI: Using IOAPIC for interrupt routing
[    0.738247] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.738253] ACPI: EC: driver started in poll mode
[    0.739112] ACPI: No dock devices found.
[    0.739247] ACPI Warning (nspredef-0328): \_SB_.PCI0._OSC: Parameter count mismatch - ASL declared 5, ACPI requires 4 [20081204]
[    0.739265] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.739310] pci 0000:00:02.0: reg 10 64bit mmio: [0xd3100000-0xd31fffff]
[    0.739310] pci 0000:00:02.0: reg 18 64bit mmio: [0xc0000000-0xcfffffff]
[    0.739310] pci 0000:00:02.0: reg 20 io port: [0x6110-0x6117]
[    0.739310] pci 0000:00:02.1: reg 10 64bit mmio: [0xd3200000-0xd32fffff]
[    0.739310] pci 0000:00:1a.0: reg 20 io port: [0x60c0-0x60df]
[    0.739310] pci 0000:00:1a.1: reg 20 io port: [0x60a0-0x60bf]
[    0.739310] pci 0000:00:1a.7: reg 10 32bit mmio: [0xd6404c00-0xd6404fff]
[    0.739360] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.739368] pci 0000:00:1a.7: PME# disabled
[    0.739423] pci 0000:00:1b.0: reg 10 64bit mmio: [0xd6400000-0xd6403fff]
[    0.739482] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.739489] pci 0000:00:1b.0: PME# disabled
[    0.739569] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.739575] pci 0000:00:1c.0: PME# disabled
[    0.739660] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.739666] pci 0000:00:1c.1: PME# disabled
[    0.739752] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.739759] pci 0000:00:1c.4: PME# disabled
[    0.739822] pci 0000:00:1d.0: reg 20 io port: [0x6080-0x609f]
[    0.739886] pci 0000:00:1d.1: reg 20 io port: [0x6060-0x607f]
[    0.739950] pci 0000:00:1d.2: reg 20 io port: [0x6040-0x605f]
[    0.740025] pci 0000:00:1d.7: reg 10 32bit mmio: [0xd6404800-0xd6404bff]
[    0.740093] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.740100] pci 0000:00:1d.7: PME# disabled
[    0.740261] pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[    0.740268] pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
[    0.740275] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 1640 (mask 000f)
[    0.740282] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 0068 (mask 0007)
[    0.740336] pci 0000:00:1f.1: reg 10 io port: [0x6108-0x610f]
[    0.740344] pci 0000:00:1f.1: reg 14 io port: [0x6124-0x6127]
[    0.740351] pci 0000:00:1f.1: reg 18 io port: [0x6100-0x6107]
[    0.740359] pci 0000:00:1f.1: reg 1c io port: [0x6120-0x6123]
[    0.740367] pci 0000:00:1f.1: reg 20 io port: [0x60e0-0x60ef]
[    0.740436] pci 0000:00:1f.2: reg 10 io port: [0x60f8-0x60ff]
[    0.740443] pci 0000:00:1f.2: reg 14 io port: [0x611c-0x611f]
[    0.740450] pci 0000:00:1f.2: reg 18 io port: [0x60f0-0x60f7]
[    0.740457] pci 0000:00:1f.2: reg 1c io port: [0x6118-0x611b]
[    0.740464] pci 0000:00:1f.2: reg 20 io port: [0x6020-0x603f]
[    0.740471] pci 0000:00:1f.2: reg 24 32bit mmio: [0xd6404000-0xd64047ff]
[    0.740511] pci 0000:00:1f.2: PME# supported from D3hot
[    0.740517] pci 0000:00:1f.2: PME# disabled
[    0.740549] pci 0000:00:1f.3: reg 10 32bit mmio: [0xd6405000-0xd64050ff]
[    0.740573] pci 0000:00:1f.3: reg 20 io port: [0x6000-0x601f]
[    0.740655] pci 0000:02:00.0: reg 10 io port: [0x4000-0x40ff]
[    0.740680] pci 0000:02:00.0: reg 18 64bit mmio: [0xd0010000-0xd0010fff]
[    0.740698] pci 0000:02:00.0: reg 20 64bit mmio: [0xd0000000-0xd000ffff]
[    0.740755] pci 0000:02:00.0: unsupported PM cap regs version (7)
[    0.743125] pci 0000:00:1c.0: bridge io port: [0x4000-0x5fff]
[    0.743130] pci 0000:00:1c.0: bridge 32bit mmio: [0xd5400000-0xd63fffff]
[    0.743137] pci 0000:00:1c.0: bridge 64bit mmio pref: [0xd0000000-0xd10fffff]
[    0.743277] pci 0000:03:00.0: reg 10 32bit mmio: [0xd4300000-0xd4300fff]
[    0.743514] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.743528] pci 0000:03:00.0: PME# disabled
[    0.743624] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.743821] pci 0000:00:1c.1: bridge io port: [0x3000-0x3fff]
[    0.743825] pci 0000:00:1c.1: bridge 32bit mmio: [0xd4300000-0xd53fffff]
[    0.743833] pci 0000:00:1c.1: bridge 64bit mmio pref: [0xd1100000-0xd20fffff]
[    0.743887] pci 0000:00:1c.4: bridge io port: [0x2000-0x2fff]
[    0.743891] pci 0000:00:1c.4: bridge 32bit mmio: [0xd3300000-0xd42fffff]
[    0.743898] pci 0000:00:1c.4: bridge 64bit mmio pref: [0xd2100000-0xd30fffff]
[    0.743960] pci 0000:00:1e.0: transparent bridge
[    0.744021] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.744291] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.744428] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.744532] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.744642] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
[    0.750526] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 9 10 11 12)
[    0.750699] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12)
[    0.750869] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[    0.751054] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[    0.751224] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.751395] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[    0.751563] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 *11 12)
[    0.751732] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.752104] ACPI: Power Resource [FN00] (on)
[    0.752284] PCI: Using ACPI for IRQ routing
[    0.757018] NetLabel: Initializing
[    0.757022] NetLabel:  domain hash size = 128
[    0.757025] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.757042] NetLabel:  unlabeled traffic allowed by default
[    0.757071] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.757078] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.760009] Switched to high resolution mode on CPU 0
[    0.760441] Switched to high resolution mode on CPU 1
[    0.763259] pnp: PnP ACPI init
[    0.763269] ACPI: bus type pnp registered
[    0.766334] pnp: PnP ACPI: found 9 devices
[    0.766338] ACPI: ACPI bus type pnp unregistered
[    0.766350] system 00:01: ioport range 0x164e-0x164f has been reserved
[    0.766355] system 00:01: ioport range 0x800-0x80f has been reserved
[    0.766360] system 00:01: ioport range 0x400-0x47f has been reserved
[    0.766364] system 00:01: ioport range 0x500-0x53f has been reserved
[    0.766369] system 00:01: iomem range 0xf8000000-0xfbffffff has been reserved
[    0.766374] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.766378] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.766383] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.766388] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.766392] system 00:01: iomem range 0xfec00000-0xfec00fff has been reserved
[    0.766397] system 00:01: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.766407] system 00:04: iomem range 0xfed00000-0xfed003ff has been reserved
[    0.771438] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.771444] pci 0000:00:1c.0:   IO window: 0x4000-0x5fff
[    0.771452] pci 0000:00:1c.0:   MEM window: 0xd5400000-0xd63fffff
[    0.771459] pci 0000:00:1c.0:   PREFETCH window: 0x000000d0000000-0x000000d10fffff
[    0.771469] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
[    0.771474] pci 0000:00:1c.1:   IO window: 0x3000-0x3fff
[    0.771481] pci 0000:00:1c.1:   MEM window: 0xd4300000-0xd53fffff
[    0.771488] pci 0000:00:1c.1:   PREFETCH window: 0x000000d1100000-0x000000d20fffff
[    0.771498] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:08
[    0.771503] pci 0000:00:1c.4:   IO window: 0x2000-0x2fff
[    0.771510] pci 0000:00:1c.4:   MEM window: 0xd3300000-0xd42fffff
[    0.771517] pci 0000:00:1c.4:   PREFETCH window: 0x000000d2100000-0x000000d30fffff
[    0.771527] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:06
[    0.771530] pci 0000:00:1e.0:   IO window: disabled
[    0.771537] pci 0000:00:1e.0:   MEM window: disabled
[    0.771543] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.771562] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.771570] pci 0000:00:1c.0: setting latency timer to 64
[    0.771580] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.771586] pci 0000:00:1c.1: setting latency timer to 64
[    0.771594] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.771601] pci 0000:00:1c.4: setting latency timer to 64
[    0.771608] pci 0000:00:1e.0: setting latency timer to 64
[    0.771612] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.771615] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.771617] pci_bus 0000:02: resource 0 io:  [0x4000-0x5fff]
[    0.771619] pci_bus 0000:02: resource 1 mem: [0xd5400000-0xd63fffff]
[    0.771621] pci_bus 0000:02: resource 2 mem: [0xd0000000-0xd10fffff]
[    0.771623] pci_bus 0000:02: resource 3 mem: [0x0-0x0]
[    0.771625] pci_bus 0000:03: resource 0 io:  [0x3000-0x3fff]
[    0.771627] pci_bus 0000:03: resource 1 mem: [0xd4300000-0xd53fffff]
[    0.771629] pci_bus 0000:03: resource 2 mem: [0xd1100000-0xd20fffff]
[    0.771631] pci_bus 0000:03: resource 3 mem: [0x0-0x0]
[    0.771633] pci_bus 0000:08: resource 0 io:  [0x2000-0x2fff]
[    0.771635] pci_bus 0000:08: resource 1 mem: [0xd3300000-0xd42fffff]
[    0.771637] pci_bus 0000:08: resource 2 mem: [0xd2100000-0xd30fffff]
[    0.771639] pci_bus 0000:08: resource 3 mem: [0x0-0x0]
[    0.771641] pci_bus 0000:06: resource 0 mem: [0x0-0x0]
[    0.771642] pci_bus 0000:06: resource 1 mem: [0x0-0x0]
[    0.771644] pci_bus 0000:06: resource 2 mem: [0x0-0x0]
[    0.771646] pci_bus 0000:06: resource 3 io:  [0x00-0xffff]
[    0.771648] pci_bus 0000:06: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.771679] NET: Registered protocol family 2
[    0.783423] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.784945] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.791117] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.791897] TCP: Hash tables configured (established 524288 bind 65536)
[    0.791902] TCP reno registered
[    0.794371] NET: Registered protocol family 1
[    0.794506] checking if image is initramfs... it is
[    1.095596] Freeing initrd memory: 3900k freed
[    1.097703] Simple Boot Flag value 0x5 read from CMOS RAM was invalid
[    1.097714] Simple Boot Flag at 0x44 set to 0x1
[    1.098660] audit: initializing netlink socket (disabled)
[    1.098679] type=2000 audit(1234202306.098:1): initialized
[    1.099048] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.101814] VFS: Disk quotas dquot_6.5.2
[    1.101912] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.102158] msgmni has been set to 6027
[    1.102396] alg: No test for stdrng (krng)
[    1.102506] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.102512] io scheduler noop registered
[    1.102516] io scheduler anticipatory registered
[    1.102519] io scheduler deadline registered
[    1.102632] io scheduler cfq registered (default)
[    1.102648] pci 0000:00:02.0: Boot video device
[    1.103130] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    1.103209] pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
[    1.103406] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    1.103479] pcieport-driver 0000:00:1c.1: irq 25 for MSI/MSI-X
[    1.103679] pcieport-driver 0000:00:1c.4: setting latency timer to 64
[    1.103753] pcieport-driver 0000:00:1c.4: irq 26 for MSI/MSI-X
[    1.104268] vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20005100000, using 1875k, total 7616k
[    1.104275] vesafb: mode is 800x600x16, linelength=1600, pages=6
[    1.104279] vesafb: scrolling: redraw
[    1.104283] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.113274] Console: switching to colour frame buffer device 100x37
[    1.121252] fb0: VESA VGA frame buffer device
[    1.155154] Linux agpgart interface v0.103
[    1.155303] agpgart-intel 0000:00:00.0: Intel 965GM Chipset
[    1.156181] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[    1.159397] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xc0000000
[    1.159648] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.161969] brd: module loaded
[    1.163294] input: Macintosh mouse button emulation as /class/input/input0
[    1.164850] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
[    1.195502] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.197142] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.202362] mice: PS/2 mouse device common for all mice
[    1.204230] cpuidle: using governor ladder
[    1.206066] cpuidle: using governor menu
[    1.208290] TCP cubic registered
[    1.210368] registered taskstats version 1
[    1.212498] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[    1.214813] Freeing unused kernel memory: 568k freed
[    1.241385] input: AT Translated Set 2 keyboard as /class/input/input1
[    1.527345] SCSI subsystem initialized
[    1.532108] Driver 'sd' needs updating - please use bus_type methods
[    1.548900] libata version 3.00 loaded.
[    1.553852] ahci 0000:00:1f.2: version 3.0
[    1.553876] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.553940] ahci 0000:00:1f.2: irq 27 for MSI/MSI-X
[    1.553978] ahci: SSS flag set, parallel bus scan disabled
[    1.554005] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x3 impl SATA mode
[    1.554009] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led clo pmp pio slum part ems 
[    1.554014] ahci 0000:00:1f.2: setting latency timer to 64
[    1.554205] scsi0 : ahci
[    1.554296] scsi1 : ahci
[    1.554343] scsi2 : ahci
[    1.554444] ata1: SATA max UDMA/133 abar m2048@0xd6404000 port 0xd6404100 irq 27
[    1.554447] ata2: SATA max UDMA/133 abar m2048@0xd6404000 port 0xd6404180 irq 27
[    1.554449] ata3: DUMMY
[    2.013285] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.014183] ata1.00: ATA-8: Hitachi HTS542520K9SA00, BBDOC33P, max UDMA/133
[    2.014186] ata1.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.015274] ata1.00: configured for UDMA/133
[    2.026360] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54252 BBDO PQ: 0 ANSI: 5
[    2.026447] sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
[    2.026463] sd 0:0:0:0: [sda] Write Protect is off
[    2.026465] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.026489] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.026548] sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
[    2.026562] sd 0:0:0:0: [sda] Write Protect is off
[    2.026564] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.026588] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.026592]  sda: sda1 sda2 < sda5 sda6 >
[    2.066066] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.082761] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x9280b1, caps: 0xa04711/0xa04000
[    2.157429] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[    2.371016] ata2: SATA link down (SStatus 0 SControl 300)
[    2.386013] ata_piix 0000:00:1f.1: version 2.12
[    2.386025] ata_piix 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    2.386070] ata_piix 0000:00:1f.1: setting latency timer to 64
[    2.386136] scsi3 : ata_piix
[    2.386190] scsi4 : ata_piix
[    2.386222] ata4: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x60e0 irq 14
[    2.386224] ata5: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x60e8 irq 15
[    2.556324] ata4.00: ATAPI: PIONEER DVD-RW  DVRKD08L, 2.51, max UDMA/33
[    2.594217] ata4.00: configured for UDMA/33
[    2.651294] isa bounce pool size: 16 pages
[    2.689363] scsi 3:0:0:0: CD-ROM            PIONEER  DVD-RW  DVRKD08L 2.51 PQ: 0 ANSI: 5
[    2.863522] Uniform Multi-Platform E-IDE driver
[    2.866091] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
[    3.007280] kjournald starting.  Commit interval 5 seconds
[    3.007292] EXT3-fs: mounted filesystem with ordered data mode.
[    4.533702] usbcore: registered new interface driver usbfs
[    4.533733] usbcore: registered new interface driver hub
[    4.533763] usbcore: registered new device driver usb
[    8.706700] ACPI: AC Adapter [ADP0] (on-line)
[    8.708991] ACPI: Battery Slot [BAT0] (battery present)
[    8.710460] input: Power Button (FF) as /class/input/input3
[    8.719162] ACPI: Power Button (FF) [PWRF]
[    8.719226] input: Power Button (CM) as /class/input/input4
[    8.727081] ACPI: Power Button (CM) [PWRB]
[    8.727144] input: Lid Switch as /class/input/input5
[    8.734236] ACPI: Lid Switch [LID]
[    8.789925] ACPI: SSDT BF674C90, 01F0 (r1  PmRef  Cpu0Ist     3000 INTL 20051117)
[    8.790519] ACPI: SSDT BF673610, 05B3 (r1  PmRef  Cpu0Cst     3001 INTL 20051117)
[    8.791056] Monitor-Mwait will be used to enter C-1 state
[    8.791064] Monitor-Mwait will be used to enter C-2 state
[    8.791070] Monitor-Mwait will be used to enter C-3 state
[    8.791128] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    8.791160] processor ACPI_CPU:00: registered as cooling_device0
[    8.791164] ACPI: Processor [CPU0] (supports 8 throttling states)
[    8.791584] ACPI: SSDT BF674F10, 00C4 (r1  PmRef  Cpu1Ist     3000 INTL 20051117)
[    8.792040] ACPI: SSDT BF676D10, 0083 (r1  PmRef  Cpu1Cst     3000 INTL 20051117)
[    8.792710] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    8.792731] processor ACPI_CPU:01: registered as cooling_device1
[    8.792735] ACPI: Processor [CPU1] (supports 8 throttling states)
[    8.794252] Marking TSC unstable due to TSC halts in idle
[    8.833016] Driver 'sr' needs updating - please use bus_type methods
[    8.835877] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    8.835939] sr 3:0:0:0: Attached scsi generic sg1 type 5
[    8.932354] rtc_cmos 00:03: RTC can wake from S4
[    8.932483] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    8.932519] rtc0: alarms up to one month, 242 bytes nvram, hpet irqs
[    8.957276] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    8.957282] Uniform CD-ROM driver Revision: 3.20
[    8.957428] sr 3:0:0:0: Attached scsi CD-ROM sr0
[    9.009224] thermal LNXTHERM:01: registered as thermal_zone0
[    9.009550] ACPI: Thermal Zone [THRM] (48 C)
[    9.026107] cfg80211: Using static regulatory domain info
[    9.026112] cfg80211: Regulatory domain: US
[    9.026115] 	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[    9.026120] 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
[    9.026124] 	(5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    9.026128] 	(5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    9.026132] 	(5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    9.026135] 	(5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
[    9.026139] 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
[    9.026143] cfg80211: Calling CRDA for country: US
[    9.164582] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.164640] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    9.164683] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    9.164687] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    9.164738] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    9.168662] ehci_hcd 0000:00:1a.7: debug port 1
[    9.168669] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    9.168697] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xd6404c00
[    9.179031] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    9.179059] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    9.179061] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.179063] usb usb1: Product: EHCI Host Controller
[    9.179065] usb usb1: Manufacturer: Linux 2.6.29-0.rc4.1mdv ehci_hcd
[    9.179067] usb usb1: SerialNumber: 0000:00:1a.7
[    9.179196] usb usb1: configuration #1 chosen from 1 choice
[    9.179226] hub 1-0:1.0: USB hub found
[    9.179234] hub 1-0:1.0: 4 ports detected
[    9.179413] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    9.179441] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    9.179445] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    9.179470] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    9.183372] ehci_hcd 0000:00:1d.7: debug port 1
[    9.183380] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    9.183396] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd6404800
[    9.194072] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    9.194126] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    9.194130] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.194135] usb usb2: Product: EHCI Host Controller
[    9.194138] usb usb2: Manufacturer: Linux 2.6.29-0.rc4.1mdv ehci_hcd
[    9.194142] usb usb2: SerialNumber: 0000:00:1d.7
[    9.194296] usb usb2: configuration #1 chosen from 1 choice
[    9.194326] hub 2-0:1.0: USB hub found
[    9.194333] hub 2-0:1.0: 6 ports detected
[    9.201484] fan PNP0C0B:00: registered as cooling_device2
[    9.201491] ACPI: Fan [FAN] (on)
[    9.230627] lib80211: common routines for IEEE802.11 drivers
[    9.230630] lib80211_crypt: registered algorithm 'NULL'
[    9.247829] acpi device:1a: registered as cooling_device3
[    9.248180] input: Video Bus as /class/input/input6
[    9.259125] ACPI: Video Device [OVGA] (multi-head: yes  rom: no  post: no)
[    9.295086] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    9.295108] r8169 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    9.295134] r8169 0000:02:00.0: setting latency timer to 64
[    9.295234] r8169 0000:02:00.0: irq 28 for MSI/MSI-X
[    9.295536] eth0: RTL8102e at 0xffffc20000622000, 00:1e:33:34:5d:5c, XID 34a00000 IRQ 28
[    9.299490] uhci_hcd: USB Universal Host Controller Interface driver
[    9.299579] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    9.299591] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    9.299594] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    9.299627] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    9.299669] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000060c0
[    9.299715] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    9.299717] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.299719] usb usb3: Product: UHCI Host Controller
[    9.299721] usb usb3: Manufacturer: Linux 2.6.29-0.rc4.1mdv uhci_hcd
[    9.299723] usb usb3: SerialNumber: 0000:00:1a.0
[    9.299882] usb usb3: configuration #1 chosen from 1 choice
[    9.299912] hub 3-0:1.0: USB hub found
[    9.299920] hub 3-0:1.0: 2 ports detected
[    9.300124] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    9.300132] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    9.300136] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    9.300160] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    9.300196] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000060a0
[    9.300241] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    9.300244] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.300246] usb usb4: Product: UHCI Host Controller
[    9.300248] usb usb4: Manufacturer: Linux 2.6.29-0.rc4.1mdv uhci_hcd
[    9.300250] usb usb4: SerialNumber: 0000:00:1a.1
[    9.300315] usb usb4: configuration #1 chosen from 1 choice
[    9.300341] hub 4-0:1.0: USB hub found
[    9.300349] hub 4-0:1.0: 2 ports detected
[    9.300479] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    9.300487] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    9.300490] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    9.300512] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    9.300540] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00006080
[    9.300579] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    9.300581] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.300583] usb usb5: Product: UHCI Host Controller
[    9.300585] usb usb5: Manufacturer: Linux 2.6.29-0.rc4.1mdv uhci_hcd
[    9.300587] usb usb5: SerialNumber: 0000:00:1d.0
[    9.300646] usb usb5: configuration #1 chosen from 1 choice
[    9.300675] hub 5-0:1.0: USB hub found
[    9.300683] hub 5-0:1.0: 2 ports detected
[    9.300808] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    9.300815] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    9.300818] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    9.300839] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    9.300873] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00006060
[    9.300911] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    9.300913] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.300915] usb usb6: Product: UHCI Host Controller
[    9.300917] usb usb6: Manufacturer: Linux 2.6.29-0.rc4.1mdv uhci_hcd
[    9.300919] usb usb6: SerialNumber: 0000:00:1d.1
[    9.300974] usb usb6: configuration #1 chosen from 1 choice
[    9.301017] hub 6-0:1.0: USB hub found
[    9.301023] hub 6-0:1.0: 2 ports detected
[    9.301145] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    9.301151] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    9.301155] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    9.301176] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    9.301202] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00006040
[    9.301239] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    9.301241] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.301243] usb usb7: Product: UHCI Host Controller
[    9.301245] usb usb7: Manufacturer: Linux 2.6.29-0.rc4.1mdv uhci_hcd
[    9.301247] usb usb7: SerialNumber: 0000:00:1d.2
[    9.301306] usb usb7: configuration #1 chosen from 1 choice
[    9.301332] hub 7-0:1.0: USB hub found
[    9.301338] hub 7-0:1.0: 2 ports detected
[    9.398313] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) -> IRQ 19
[    9.426815] iTCO_vendor_support: vendor-support=0
[    9.459080] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.04
[    9.459194] iTCO_wdt: Found a ICH8M TCO device (Version=2, TCOBASE=0x0460)
[    9.459314] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=1)
[    9.481042] usb 1-2: new high speed USB device using ehci_hcd and address 2
[    9.634035] usb 1-2: New USB device found, idVendor=04f2, idProduct=b070
[    9.634038] usb 1-2: New USB device strings: Mfr=2, Product=1, SerialNumber=3
[    9.634040] usb 1-2: Product: CNF7051
[    9.634042] usb 1-2: Manufacturer: Chicony Electronics Co., Ltd.
[    9.634044] usb 1-2: SerialNumber: SN0001
[    9.634181] usb 1-2: configuration #1 chosen from 1 choice
[    9.738077] usb 1-4: new high speed USB device using ehci_hcd and address 3
[    9.864277] usb 1-4: New USB device found, idVendor=0bda, idProduct=0158
[    9.864283] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    9.864287] usb 1-4: Product: USB2.0-CRW
[    9.864290] usb 1-4: Manufacturer: Generic
[    9.864293] usb 1-4: SerialNumber: 20071114173400000
[    9.864452] usb 1-4: configuration #1 chosen from 1 choice
[    9.972111] hub 3-0:1.0: over-current change on port 1
[   10.072737] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.2.26ks
[   10.072740] iwl3945: Copyright(c) 2003-2008 Intel Corporation
[   10.072835] iwl3945 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   10.072849] iwl3945 0000:03:00.0: setting latency timer to 64
[   10.131093] Initializing USB Mass Storage driver...
[   10.131214] scsi5 : SCSI emulation for USB Mass Storage devices
[   10.131362] usbcore: registered new interface driver usb-storage
[   10.131366] USB Mass Storage support registered.
[   10.131672] iwl3945: Tunable channels: 11 802.11bg, 13 802.11a channels
[   10.131675] iwl3945: Detected Intel Wireless WiFi Link 3945ABG
[   10.133945] usb-storage: device found at 3
[   10.133948] usb-storage: waiting for device to settle before scanning
[   10.137500] iwl3945 0000:03:00.0: PCI INT A disabled
[   10.137568] wmaster0 (iwl3945): not using net_device_ops yet
[   10.137834] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   10.291655] Linux video capture interface: v2.00
[   10.337085] usb 6-1: new full speed USB device using uhci_hcd and address 2
[   10.405871] wlan0 (iwl3945): not using net_device_ops yet
[   10.440870] uvcvideo: Found UVC 1.00 device CNF7051 (04f2:b070)
[   10.442348] input: CNF7051 as /class/input/input7
[   10.447152] usbcore: registered new interface driver uvcvideo
[   10.447158] USB Video Class driver (v0.1.0)
[   10.478960] usb 6-1: New USB device found, idVendor=1caa, idProduct=0001
[   10.478966] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   10.479170] usb 6-1: configuration #1 chosen from 1 choice
[   10.481325] hub 6-0:1.0: over-current change on port 2
[   10.799052] Bluetooth: Core ver 2.14
[   10.799239] NET: Registered protocol family 31
[   10.799241] Bluetooth: HCI device and connection manager initialized
[   10.799245] Bluetooth: HCI socket layer initialized
[   10.999956] Bluetooth: Generic Bluetooth USB driver ver 0.4
[   11.000069] usbcore: registered new interface driver btusb
[   11.707541] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   11.707626] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   13.114165] Non-volatile memory driver v1.3
[   14.446246] device-mapper: uevent: version 1.0.3
[   14.446427] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   15.135309] scsi 5:0:0:0: Direct-Access     Generic- Multi-Card       1.00 PQ: 0 ANSI: 0 CCS
[   15.137498] sd 5:0:0:0: [sdb] Attached SCSI removable disk
[   15.137623] sd 5:0:0:0: Attached scsi generic sg2 type 0
[   15.138587] usb-storage: device scan complete
[   16.158044] EXT3 FS on sda1, internal journal
[   18.672466] kjournald starting.  Commit interval 5 seconds
[   18.678629] EXT3 FS on sda6, internal journal
[   18.678641] EXT3-fs: mounted filesystem with ordered data mode.
[   18.764695] loop: module loaded
[   21.594917] Adding 4088500k swap on /dev/sda5.  Priority:-1 extents:1 across:4088500k 
[   26.887962] Bluetooth: L2CAP ver 2.11
[   26.887966] Bluetooth: L2CAP socket layer initialized
[   26.947827] Bluetooth: RFCOMM socket layer initialized
[   26.947845] Bluetooth: RFCOMM TTY layer initialized
[   26.947849] Bluetooth: RFCOMM ver 1.10
[   26.956719] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   26.956722] Bluetooth: BNEP filters: protocol multicast
[   26.996652] NET: Registered protocol family 10
[   26.997136] lo: Disabled Privacy Extensions
[   27.000261] Clocksource tsc unstable (delta = -106731256 ns)
[   27.096847] Bridge firewalling registered
[   27.135724] Bluetooth: SCO (Voice Link) ver 0.6
[   27.135727] Bluetooth: SCO socket layer initialized
[   27.540169] iwl3945 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   27.540349] iwl3945 0000:03:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[   27.540556] iwl3945 0000:03:00.0: irq 29 for MSI/MSI-X
[   27.540665] iwl3945 0000:03:00.0: firmware: requesting iwlwifi-3945-2.ucode
[   27.547577] iwl3945: iwlwifi-3945-2.ucode firmware file req failed: Reason -2
[   27.547584] iwl3945 0000:03:00.0: firmware: requesting iwlwifi-3945-1.ucode
[   27.564307] iwl3945: Loaded firmware iwlwifi-3945-1.ucode, which is deprecated. Please use API v2 instead.
[   27.564316] iwl3945: Firmware has old API version. Expected 2, got 1. New firmware can be obtained from http://www.intellinuxwireless.org.
[   27.564324] iwl3945 loaded firmware version 15.28.1.6
[   27.604909] Registered led device: iwl-phy0:radio
[   27.604945] Registered led device: iwl-phy0:assoc
[   27.604976] Registered led device: iwl-phy0:RX
[   27.605031] Registered led device: iwl-phy0:TX
[   27.611324] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   29.258958] wlan0: direct probe to AP 00:12:bf:16:43:ea try 1
[   29.260482] wlan0 direct probe responded
[   29.260487] wlan0: authenticate with AP 00:12:bf:16:43:ea
[   29.262087] wlan0: authenticated
[   29.262091] wlan0: associate with AP 00:12:bf:16:43:ea
[   29.263807] wlan0: RX AssocResp from 00:12:bf:16:43:ea (capab=0x461 status=0 aid=3)
[   29.263813] wlan0: associated
[   29.266060] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   31.343400] [drm] Initialized drm 1.1.0 20060810
[   31.445116] pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   31.445125] pci 0000:00:02.0: setting latency timer to 64
[   31.450008] pci 0000:00:02.0: irq 30 for MSI/MSI-X
[   31.450040] [drm] Initialized i915 1.6.0 20080730 on minor 0
[   32.151746] NET: Registered protocol family 17
[   32.527370] X:4026 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
[   32.527377] reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
[   32.785844] X:4026 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
[   32.785850] reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
[   32.909054] X:4026 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
[   32.909058] reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
[   33.022318] X:4026 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
[   33.022322] reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
[   33.042873] X:4244 freeing invalid memtype c0000000-d0000000
[   33.137235] X:4026 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
[   33.137239] reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
[   33.168130] X:4248 freeing invalid memtype c0000000-d0000000
[   39.498128] wlan0: no IPv6 routers present
[   40.125303] CE: hpet increasing min_delta_ns to 15000 nsec
[   74.732048] X:4026 conflicting memory types c0000000-d0000000 write-combining<->uncached-minus
[   74.732052] reserve_memtype failed 0xc0000000-0xd0000000, track write-combining, req write-combining
[   74.749542] X:4651 freeing invalid memtype c0000000-d0000000
[  592.426427] PM: Syncing filesystems ... done.
[  593.813566] X:4026 freeing invalid memtype c0000000-d0000000
[  593.833512] Freezing user space processes ... (elapsed 0.03 seconds) done.
[  593.870751] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  593.870813] Suspending console(s) (use no_console_suspend to debug)
[  593.884025] btusb_intr_complete: hci0 urb ffff8800b959fd80 failed to resubmit (1)
[  593.917310] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  593.917555] sd 0:0:0:0: [sda] Stopping disk
[  594.935347] iwl3945 0000:03:00.0: PCI INT A disabled
[  594.979273] ata_piix 0000:00:1f.1: PCI INT A disabled
[  594.979382] ehci_hcd 0000:00:1d.7: PCI INT A disabled
[  594.979445] ehci_hcd 0000:00:1d.7: PME# disabled
[  594.990179] uhci_hcd 0000:00:1d.2: PCI INT C disabled
[  594.990228] uhci_hcd 0000:00:1d.1: PCI INT B disabled
[  594.990273] uhci_hcd 0000:00:1d.0: PCI INT A disabled
[  595.012240] HDA Intel 0000:00:1b.0: PCI INT A disabled
[  595.023151] ehci_hcd 0000:00:1a.7: PCI INT C disabled
[  595.023216] ehci_hcd 0000:00:1a.7: PME# disabled
[  595.034169] uhci_hcd 0000:00:1a.1: PCI INT B disabled
[  595.034219] uhci_hcd 0000:00:1a.0: PCI INT A disabled
[  595.034824] ACPI: Preparing to enter system sleep state S3
[  595.040898] Disabling non-boot CPUs ...
[  595.043247] CPU 1 is now offline
[  595.043250] SMP alternatives: switching to UP code
[  595.156195] CPU0 attaching NULL sched-domain.
[  595.156199] CPU1 attaching NULL sched-domain.
[  595.159025] CPU0 attaching NULL sched-domain.
[  595.159277] CPU1 is down
[  595.159289] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[  595.159289] Back to C!
[  595.159289] pci 0000:00:02.0: restoring config space at offset 0x6 (was 0xc, writing 0xc000000c)
[  595.159289] pci 0000:00:02.0: restoring config space at offset 0x1 (was 0x900007, writing 0x900403)
[  595.159289] HDA Intel 0000:00:1b.0: restoring config space at offset 0x1 (was 0x100006, writing 0x100002)
[  595.159289] pcieport-driver 0000:00:1c.0: restoring config space at offset 0xf (was 0x100, writing 0x105)
[  595.159289] pcieport-driver 0000:00:1c.0: restoring config space at offset 0x9 (was 0x10001, writing 0xd101d001)
[  595.159289] pcieport-driver 0000:00:1c.0: restoring config space at offset 0x8 (was 0x0, writing 0xd630d540)
[  595.159289] pcieport-driver 0000:00:1c.0: restoring config space at offset 0x7 (was 0x20000000, writing 0x5040)
[  595.159289] pcieport-driver 0000:00:1c.0: restoring config space at offset 0x6 (was 0x0, writing 0x20200)
[  595.159289] pcieport-driver 0000:00:1c.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
[  595.159289] pcieport-driver 0000:00:1c.1: restoring config space at offset 0xf (was 0x200, writing 0x20b)
[  595.159289] pcieport-driver 0000:00:1c.1: restoring config space at offset 0x9 (was 0x10001, writing 0xd201d111)
[  595.159289] pcieport-driver 0000:00:1c.1: restoring config space at offset 0x8 (was 0x0, writing 0xd530d430)
[  595.159289] pcieport-driver 0000:00:1c.1: restoring config space at offset 0x7 (was 0x20000000, writing 0x3030)
[  595.159289] pcieport-driver 0000:00:1c.1: restoring config space at offset 0x6 (was 0x0, writing 0x30300)
[  595.159289] pcieport-driver 0000:00:1c.1: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
[  595.159289] pcieport-driver 0000:00:1c.4: restoring config space at offset 0xf (was 0x100, writing 0x10b)
[  595.159289] pcieport-driver 0000:00:1c.4: restoring config space at offset 0x9 (was 0x10001, writing 0xd301d211)
[  595.159289] pcieport-driver 0000:00:1c.4: restoring config space at offset 0x8 (was 0x0, writing 0xd420d330)
[  595.159289] pcieport-driver 0000:00:1c.4: restoring config space at offset 0x7 (was 0x20000000, writing 0x2020)
[  595.159289] pcieport-driver 0000:00:1c.4: restoring config space at offset 0x6 (was 0x0, writing 0x90800)
[  595.159289] pcieport-driver 0000:00:1c.4: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
[  595.159289] pci 0000:00:1e.0: restoring config space at offset 0x9 (was 0x10001, writing 0x1fff1)
[  595.159289] pci 0000:00:1e.0: restoring config space at offset 0x8 (was 0x0, writing 0xfff0)
[  595.159289] pci 0000:00:1e.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100007)
[  595.159289] ata_piix 0000:00:1f.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2880005)
[  595.159289] ahci 0000:00:1f.2: restoring config space at offset 0x1 (was 0x2b00007, writing 0x2b00407)
[  595.159289] r8169 0000:02:00.0: restoring config space at offset 0xf (was 0x1ff, writing 0x105)
[  595.159289] r8169 0000:02:00.0: restoring config space at offset 0x8 (was 0xc, writing 0xd000000c)
[  595.159289] r8169 0000:02:00.0: restoring config space at offset 0x6 (was 0xc, writing 0xd001000c)
[  595.159289] r8169 0000:02:00.0: restoring config space at offset 0x4 (was 0x1, writing 0x4001)
[  595.159289] r8169 0000:02:00.0: restoring config space at offset 0x3 (was 0x0, writing 0x8)
[  595.159289] r8169 0000:02:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100407)
[  595.159289] iwl3945 0000:03:00.0: restoring config space at offset 0xf (was 0x100, writing 0x10b)
[  595.159289] iwl3945 0000:03:00.0: restoring config space at offset 0x4 (was 0x0, writing 0xd4300000)
[  595.159289] iwl3945 0000:03:00.0: restoring config space at offset 0x1 (was 0x100000, writing 0x100002)
[  595.160989] Enabling non-boot CPUs ...
[  595.161186] SMP alternatives: switching to SMP code
[  595.278221] Booting processor 1 APIC 0x1 ip 0x6000
[  595.156045] Initializing CPU#1
[  595.156045] Calibrating delay using timer specific routine.. 3662.63 BogoMIPS (lpj=1831318)
[  595.156045] CPU: L1 I cache: 32K, L1 D cache: 32K
[  595.156045] CPU: L2 cache: 2048K
[  595.156045] [ds] using Core 2/Atom configuration
[  595.156045] CPU 1/0x1 -> Node 0
[  595.156045] CPU: Physical Processor ID: 0
[  595.156045] CPU: Processor Core ID: 1
[  595.156045] CPU1: Thermal monitoring enabled (TM2)
[  595.156045] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[  595.356711] CPU1: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz stepping 0d
[  595.356770] CPU0 attaching NULL sched-domain.
[  595.357019] Switched to high resolution mode on CPU 1
[  595.359024] CPU0 attaching sched-domain:
[  595.359026]  domain 0: span 0-1 level MC
[  595.359028]   groups: 0 1
[  595.359031] CPU1 attaching sched-domain:
[  595.359033]  domain 0: span 0-1 level MC
[  595.359034]   groups: 1 0
[  595.360265] CPU1 is up
[  595.360267] ACPI: Waking up from system sleep state S3
[  595.406924] pci 0000:00:02.0: PME# disabled
[  595.406933] pci 0000:00:02.1: PME# disabled
[  595.406948] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  595.406957] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[  595.406986] usb usb3: root hub lost power or was reset
[  595.407010] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[  595.407021] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[  595.407051] usb usb4: root hub lost power or was reset
[  595.407074] ehci_hcd 0000:00:1a.7: PME# disabled
[  595.407080] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[  595.407089] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[  595.407097] ehci_hcd 0000:00:1a.7: PME# disabled
[  595.407109] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[  595.407122] HDA Intel 0000:00:1b.0: setting latency timer to 64
[  595.407158] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[  595.407171] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[  595.407183] pcieport-driver 0000:00:1c.4: setting latency timer to 64
[  595.407196] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[  595.407205] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[  595.407232] usb usb5: root hub lost power or was reset
[  595.407268] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[  595.407276] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[  595.407303] usb usb6: root hub lost power or was reset
[  595.407326] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[  595.407336] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[  595.407366] usb usb7: root hub lost power or was reset
[  595.407388] ehci_hcd 0000:00:1d.7: PME# disabled
[  595.407394] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[  595.407403] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[  595.407412] ehci_hcd 0000:00:1d.7: PME# disabled
[  595.407425] pci 0000:00:1e.0: setting latency timer to 64
[  595.407465] ata_piix 0000:00:1f.1: restoring config space at offset 0x1 (was 0x2800005, writing 0x2880005)
[  595.407480] ata_piix 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[  595.407487] ata_piix 0000:00:1f.1: setting latency timer to 64
[  595.407757] ahci 0000:00:1f.2: setting latency timer to 64
[  595.408196] iwl3945 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  595.408531] iwl3945 0000:03:00.0: irq 29 for MSI/MSI-X
[  595.435641] sd 0:0:0:0: [sda] Starting disk
[  595.626719] ata4.00: configured for UDMA/33
[  595.729149] ata2: SATA link down (SStatus 0 SControl 300)
[  595.880181] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  595.882443] ata1.00: configured for UDMA/133
[  595.893227] sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
[  595.893260] sd 0:0:0:0: [sda] Write Protect is off
[  595.893264] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  595.893309] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  596.705148] usb 1-2: reset high speed USB device using ehci_hcd and address 2
[  596.971179] usb 1-4: reset high speed USB device using ehci_hcd and address 3
[  597.197166] usb 6-1: reset full speed USB device using uhci_hcd and address 2
[  597.336305] btusb 6-1:1.0: no reset_resume for driver btusb?
[  597.336310] btusb 6-1:1.1: no reset_resume for driver btusb?
[  597.586399] pci 0000:00:02.0: setting latency timer to 64
[  597.589239] Restarting tasks ... done.

--Boundary-00=_OwIkJIbalrwjuBL--
