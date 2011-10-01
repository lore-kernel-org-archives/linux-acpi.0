From: Cedric Sodhi <manday@gmx.net>
Subject: ACPI/Backlight/DRM/Switcheroo are malfunctioning
Date: Sat, 1 Oct 2011 22:27:00 +0200
Message-ID: <20111001202700.GC16339@fly>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:42483 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752691Ab1JAS2B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Oct 2011 14:28:01 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Configuration:
==============

A mainline kernel of arbitrary version. HP Touchsmart tm-2 2010eg [1]
Laptop with dual (a.k.a "hybrid") switchable graphics:

Intel 1915 Arrandale & Radeon HD 5450 CEDAR

DRM_RADEON_KMS [=y]
HAS_IOMEM [=y]
DRM_RADEON [=y]
DRM_I915 [=y]
DRM_I915_KMS [=y]
DRM [=y]
AGP [=y]
AGP_INTEL [=y]
ACPI [=y]
LCD_CLASS_DEVICE [=y]
LCD_PLATFORM [=y]
BACKLIGHT_CLASS_DEVICE [=y]
FIRMWARE_EDID [=y]
FB_FOREIGN_ENDIAN [=y]
FB_MODE_HELPERS [=y]
FB_EFI [=y]
VIDEO_OUTPUT_CONTROL [=y]
VGA_SWITCHEROO [=y]

plus respective dependencies.

Symptops in default configuration:
==================================

Upon boot the backlight turns off at about the point where KMS would
kick in*. 

The subsequent behaviour shows a complicated yet distinctive pattern, as
follows:

After backlight has gone off, either initially on boot or during uptime
by decreasing the brightness to 0 (either by laptop function keys or
kernel /sys brightness interface) it cannot be turned back on, if
exactly one or more attempts to do so have been made, while the unit was
on AC Power.

In that case, there are only two possible hacks to turn the backlight
back on, in both of which cases the backlight will instantly turn to the
brightest setting, regarldess, although the value in the /sys brightness
interface remains unchanged:

a) Close the laptop screen down for a few seconds and open it back up.

b) If X is running, issue an xrandr --rotate such that the screen will
rotate by 90 deg in either direction.

In all other cases, the backlight can be controlled normally. That is,
if no attempt to increase brightness, id est turn the backlight back on
is made while the unit is AC powered.

None of these problems arise if the backlight has been turned off due to
idle time (say, in TTY), rather than on boot or manually.

* Supplemental information: The kernel defaults to the i915 IGD o boot.
Radeon is not considered here, although it also appears to have problems
controlling the backlight.

Symptoms in various other configurations (list):
================================================

Other configurations have been tried. As you will read in the list,
you can witness another undesired coupling between switcheroo (the
debugfs interface) and KMS. In certain situations, switcheroo is said to
be enabled in CONFIG, yet not available in debugfs for other reasons.
One of those situations, which is not among the ones listed below, is
when the DRM drivers have been compiled as modules rather than compiled
in.

In the following "screen blanks" refers to the situation which is
described above as the symptoms in default configuration:

ACPI off (=>Switcheroo off):	Boots into KMS, everything OK
Switcheroo off:			Boots into KMS, screen blanks
KMS off:			Freezes (visually) on boot
KMS default off (compiled):	Switcheroo disappears, everything OK
KNS on (default off):		Switcheroo disappears, screen blanks
KMS default off, BL off:	Switcheroo disappears, everything OK
KMS on (default off), BL off:	Switcheroo disappears, screen blanks
Same 2 with Switcheroo off:	Same as the two lines above

(BL off means BACKLIGHT_LCD_SUPPORT off, which results in a warning because
DRM & ACPI requires BACKLIGHT_CLASS_SUPPORT, which is a child thereof)

Further information:
====================

This and similar bugs has been repeatedly filed by me and others on
serveral bugtrackers, including freedesktop[2] and kernel (which is
unreachable atm). DMESG in default configuration is attached. You will
find a reference to an ACPI bug which likely to be related to the
initial backlight loss on boot [3]. However, it is so far unclear
whether it is also related to the problems in bringing the backlight
back on.

[1] http://h10025.www1.hp.com/ewfrf/wc/document?docname=c02262928&tmp_task=prodinfoCategory&cc=us&dlc=en&lc=en&product=4213107
[2] https://bugs.freedesktop.org/show_bug.cgi?id=41306
[3] http://forums.gentoo.org/viewtopic-t-874961-start-0.html

-- 
regards, ManDay

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-std

[    0.000000] Linux version 3.0.4-gentoo-r1 (root@fly) (gcc version 4.5.3 (Gentoo 4.5.3-r1 p1.0, pie-0.4.5) ) #13 SMP Sat Oct 1 11:11:50 CEST 2011
[    0.000000] Command line: auto BOOT_IMAGE=Default ro root=801 rootfstype=ext3
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
[    0.000000]  BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000009b63f000 (usable)
[    0.000000]  BIOS-e820: 000000009b63f000 - 000000009b6bf000 (reserved)
[    0.000000]  BIOS-e820: 000000009b6bf000 - 000000009b7bf000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000009b7bf000 - 000000009b7ff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000009b7ff000 - 000000009b800000 (usable)
[    0.000000]  BIOS-e820: 000000009b800000 - 00000000a0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000feb00000 - 00000000feb04000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed14000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed18000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000158000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: Hewlett-Packard HP TouchSmart tm2 NoteBook PC   /1486, BIOS F.25 02/18/2011
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x158000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-combining
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 0FFE00000 mask FFFE00000 write-protect
[    0.000000]   2 base 080000000 mask FE0000000 write-back
[    0.000000]   3 base 09C000000 mask FFC000000 uncachable
[    0.000000]   4 base 09B800000 mask FFF800000 uncachable
[    0.000000]   5 base 100000000 mask F80000000 write-back
[    0.000000]   6 base 158000000 mask FF8000000 uncachable
[    0.000000]   7 base 160000000 mask FE0000000 uncachable
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0x9b800 max_arch_pfn = 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-000000009b800000
[    0.000000]  0000000000 - 009b800000 page 2M
[    0.000000] kernel direct mapping tables up to 9b800000 @ 9b63b000-9b63f000
[    0.000000] init_memory_mapping: 0000000100000000-0000000158000000
[    0.000000]  0100000000 - 0158000000 page 2M
[    0.000000] kernel direct mapping tables up to 158000000 @ 157ff9000-158000000
[    0.000000] ACPI: RSDP 00000000000fe020 00024 (v02 HP    )
[    0.000000] ACPI: XSDT 000000009b7fe120 00094 (v01 HPQOEM SLIC-MPC 00000001      01000013)
[    0.000000] ACPI: FACP 000000009b7fc000 000F4 (v04 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: DSDT 000000009b7e9000 0FD12 (v02 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: FACS 000000009b75e000 00040
[    0.000000] ACPI: ASF! 000000009b7fd000 000A5 (v32 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: HPET 000000009b7fb000 00038 (v01 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: APIC 000000009b7fa000 0008C (v02 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: MCFG 000000009b7f9000 0003C (v01 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SLIC 000000009b7e8000 00176 (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000009b7e6000 01152 (v01 TrmRef PtidDevc 00001000 INTL 20051117)
[    0.000000] ACPI: SSDT 000000009b7e5000 00172 (v01  VaRef  Va_Acpi 00003000 INTL 20051117)
[    0.000000] ACPI: BOOT 000000009b7e4000 00028 (v01 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000009b7e3000 00C39 (v01 INTEL   SataPri 00001000 INTL 20051117)
[    0.000000] ACPI: SSDT 000000009b7e2000 006C5 (v01 INTEL   SataSec 00001000 INTL 20051117)
[    0.000000] ACPI: ASPT 000000009b7e1000 00034 (v04 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000009b7e0000 009F1 (v01  PmRef    CpuPm 00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 000000009b7de000 01A8F (v01 AmdRef  AmdTabl 00001000 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0004bfffff] PMD -> [ffff880153800000-ffff880156ffffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00158000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x0009b63f
[    0.000000]     0: 0x0009b7ff -> 0x0009b800
[    0.000000]     0: 0x00100000 -> 0x00158000
[    0.000000] On node 0 totalpages: 996813
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 618104 pages, LIFO batch:31
[    0.000000]   Normal zone: 4928 pages used for memmap
[    0.000000]   Normal zone: 355520 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] 8 Processors exceeds NR_CPUS limit of 4
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000009b63f000 - 000000009b6bf000
[    0.000000] PM: Registered nosave memory: 000000009b6bf000 - 000000009b7bf000
[    0.000000] PM: Registered nosave memory: 000000009b7bf000 - 000000009b7ff000
[    0.000000] PM: Registered nosave memory: 000000009b800000 - 00000000a0000000
[    0.000000] PM: Registered nosave memory: 00000000a0000000 - 00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
[    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000feb00000
[    0.000000] PM: Registered nosave memory: 00000000feb00000 - 00000000feb04000
[    0.000000] PM: Registered nosave memory: 00000000feb04000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed14000
[    0.000000] PM: Registered nosave memory: 00000000fed14000 - 00000000fed18000
[    0.000000] PM: Registered nosave memory: 00000000fed18000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffe00000
[    0.000000] PM: Registered nosave memory: 00000000ffe00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at a0000000 (gap: a0000000:40000000)
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 25 pages/cpu @ffff880157c00000 s70016 r8192 d24192 u524288
[    0.000000] pcpu-alloc: s70016 r8192 d24192 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 977544
[    0.000000] Kernel command line: auto BOOT_IMAGE=Default ro root=801 rootfstype=ext3
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 3848876k/5636096k available (4785k kernel code, 1648844k absent, 138376k reserved, 2539k data, 452k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] NR_IRQS:384
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 1196.961 MHz processor.
[    0.000005] Calibrating delay loop (skipped), value calculated using timer frequency.. 2393.92 BogoMIPS (lpj=4787844)
[    0.000171] pid_max: default: 32768 minimum: 301
[    0.000319] Mount-cache hash table entries: 256
[    0.000590] CPU: Physical Processor ID: 0
[    0.000668] CPU: Processor Core ID: 0
[    0.000750] mce: CPU supports 9 MCE banks
[    0.000837] CPU0: Thermal monitoring handled by SMI
[    0.000847] using mwait in idle threads.
[    0.001015] ACPI: Core revision 20110413
[    0.035371] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.075121] CPU0: Intel(R) Core(TM) i5 CPU       U 430  @ 1.20GHz stepping 05
[    0.179263] Performance Events: PEBS fmt1+, Westmere events, Intel PMU driver.
[    0.179500] ... version:                3
[    0.179578] ... bit width:              48
[    0.179655] ... generic registers:      4
[    0.179733] ... value mask:             0000ffffffffffff
[    0.179815] ... max period:             000000007fffffff
[    0.179897] ... fixed-purpose events:   3
[    0.179974] ... event mask:             000000070000000f
[    0.180208] Booting Node   0, Processors  #1
[    0.180304] smpboot cpu 1: start_ip = 98000
[    0.271241] CPU1: Thermal monitoring handled by SMI
[    0.291378]  #2
[    0.291428] smpboot cpu 2: start_ip = 98000
[    0.379176] CPU2: Thermal monitoring handled by SMI
[    0.399320]  #3 Ok.
[    0.399395] smpboot cpu 3: start_ip = 98000
[    0.487112] CPU3: Thermal monitoring handled by SMI
[    0.507147] Brought up 4 CPUs
[    0.507226] Total of 4 processors activated (9575.78 BogoMIPS).
[    0.509512] PM: Registering ACPI NVS region at 9b6bf000 (1048576 bytes)
[    0.509813] print_constraints: dummy: 
[    0.509941] NET: Registered protocol family 16
[    0.510386] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.510501] ACPI: bus type pci registered
[    0.510711] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.510834] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.551549] PCI: Using configuration type 1 for base access
[    0.559530] bio: create slab <bio-0> at 0
[    0.562749] ACPI: EC: Look up EC in DSDT
[    0.565628] ACPI: Executed 1 blocks of module-level executable AML code
[    0.595117] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.601689] ACPI: SSDT 000000009b691a98 00334 (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
[    0.602637] ACPI: Dynamic OEM Table Load:
[    0.602795] ACPI: SSDT           (null) 00334 (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
[    0.606044] ACPI: SSDT 000000009b690018 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    0.606957] ACPI: Dynamic OEM Table Load:
[    0.607123] ACPI: SSDT           (null) 00891 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    0.631510] ACPI: SSDT 000000009b691718 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    0.632529] ACPI: Dynamic OEM Table Load:
[    0.632687] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    0.643263] ACPI: SSDT 000000009b68fd98 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    0.644220] ACPI: Dynamic OEM Table Load:
[    0.644378] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    1.562677] ACPI: Interpreter enabled
[    1.562758] ACPI: (supports S0 S3 S4 S5)
[    1.563056] ACPI: Using IOAPIC for interrupt routing
[    1.565023] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    1.590505] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[    1.594244] ACPI: Power Resource [FN00] (on)
[    1.595119] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    1.595288] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.595981] \_SB_.PCI0:_OSC invalid UUID
[    1.595983] _OSC request data:1 8 1f 
[    1.595989] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    1.597057] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.597145] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.597233] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.597348] pci_root PNP0A08:00: host bridge window [mem 0xa0000000-0xfeafffff]
[    1.597477] pci 0000:00:00.0: [8086:0044] type 0 class 0x000600
[    1.597527] pci 0000:00:01.0: [8086:0045] type 1 class 0x000604
[    1.597566] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.597570] pci 0000:00:01.0: PME# disabled
[    1.597588] pci 0000:00:02.0: [8086:0046] type 0 class 0x000300
[    1.597605] pci 0000:00:02.0: reg 10: [mem 0xc0000000-0xc03fffff 64bit]
[    1.597615] pci 0000:00:02.0: reg 18: [mem 0xb0000000-0xbfffffff 64bit pref]
[    1.597622] pci 0000:00:02.0: reg 20: [io  0x4050-0x4057]
[    1.597694] pci 0000:00:16.0: [8086:3b64] type 0 class 0x000780
[    1.597724] pci 0000:00:16.0: reg 10: [mem 0xc4506100-0xc450610f 64bit]
[    1.597800] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.597806] pci 0000:00:16.0: PME# disabled
[    1.597851] pci 0000:00:1a.0: [8086:3b3c] type 0 class 0x000c03
[    1.598159] pci 0000:00:1a.0: reg 10: [mem 0xc4505c00-0xc4505fff]
[    1.599839] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.599846] pci 0000:00:1a.0: PME# disabled
[    1.599874] pci 0000:00:1b.0: [8086:3b56] type 0 class 0x000403
[    1.599894] pci 0000:00:1b.0: reg 10: [mem 0xc4500000-0xc4503fff 64bit]
[    1.599958] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.599963] pci 0000:00:1b.0: PME# disabled
[    1.599986] pci 0000:00:1c.0: [8086:3b42] type 1 class 0x000604
[    1.600049] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.600054] pci 0000:00:1c.0: PME# disabled
[    1.600079] pci 0000:00:1c.1: [8086:3b44] type 1 class 0x000604
[    1.600144] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.600149] pci 0000:00:1c.1: PME# disabled
[    1.600186] pci 0000:00:1d.0: [8086:3b34] type 0 class 0x000c03
[    1.600479] pci 0000:00:1d.0: reg 10: [mem 0xc4505800-0xc4505bff]
[    1.602153] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.602158] pci 0000:00:1d.0: PME# disabled
[    1.602181] pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
[    1.602251] pci 0000:00:1f.0: [8086:3b09] type 0 class 0x000601
[    1.602384] pci 0000:00:1f.2: [8086:3b29] type 0 class 0x000106
[    1.602413] pci 0000:00:1f.2: reg 10: [io  0x4048-0x404f]
[    1.602424] pci 0000:00:1f.2: reg 14: [io  0x405c-0x405f]
[    1.602438] pci 0000:00:1f.2: reg 18: [io  0x4040-0x4047]
[    1.602451] pci 0000:00:1f.2: reg 1c: [io  0x4058-0x405b]
[    1.602463] pci 0000:00:1f.2: reg 20: [io  0x4020-0x403f]
[    1.602475] pci 0000:00:1f.2: reg 24: [mem 0xc4505000-0xc45057ff]
[    1.602526] pci 0000:00:1f.2: PME# supported from D3hot
[    1.602535] pci 0000:00:1f.2: PME# disabled
[    1.602558] pci 0000:00:1f.3: [8086:3b30] type 0 class 0x000c05
[    1.602576] pci 0000:00:1f.3: reg 10: [mem 0xc4506000-0xc45060ff 64bit]
[    1.602602] pci 0000:00:1f.3: reg 20: [io  0x4000-0x401f]
[    1.602645] pci 0000:00:1f.6: [8086:3b32] type 0 class 0x001180
[    1.602673] pci 0000:00:1f.6: reg 10: [mem 0xc4504000-0xc4504fff 64bit]
[    1.602795] pci 0000:01:00.0: [1002:68e0] type 0 class 0x000300
[    1.602818] pci 0000:01:00.0: reg 10: [mem 0xa0000000-0xafffffff 64bit pref]
[    1.602836] pci 0000:01:00.0: reg 18: [mem 0xc4400000-0xc441ffff 64bit]
[    1.602849] pci 0000:01:00.0: reg 20: [io  0x3000-0x30ff]
[    1.602871] pci 0000:01:00.0: reg 30: [mem 0xfffe0000-0xffffffff pref]
[    1.602901] pci 0000:01:00.0: supports D1 D2
[    1.602930] pci 0000:01:00.1: [1002:aa68] type 0 class 0x000403
[    1.602953] pci 0000:01:00.1: reg 10: [mem 0xc4420000-0xc4423fff 64bit]
[    1.603032] pci 0000:01:00.1: supports D1 D2
[    1.603065] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    1.603148] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    1.603153] pci 0000:00:01.0:   bridge window [mem 0xc4400000-0xc44fffff]
[    1.603158] pci 0000:00:01.0:   bridge window [mem 0xa0000000-0xafffffff 64bit pref]
[    1.603225] pci 0000:02:00.0: [10ec:8168] type 0 class 0x000200
[    1.603245] pci 0000:02:00.0: reg 10: [io  0x2000-0x20ff]
[    1.603278] pci 0000:02:00.0: reg 18: [mem 0xc0404000-0xc0404fff 64bit pref]
[    1.603300] pci 0000:02:00.0: reg 20: [mem 0xc0400000-0xc0403fff 64bit pref]
[    1.603356] pci 0000:02:00.0: supports D1 D2
[    1.603359] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.603365] pci 0000:02:00.0: PME# disabled
[    1.603404] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    1.603489] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    1.603494] pci 0000:00:1c.0:   bridge window [mem 0xc3400000-0xc43fffff]
[    1.603502] pci 0000:00:1c.0:   bridge window [mem 0xc0400000-0xc13fffff 64bit pref]
[    1.603603] pci 0000:03:00.0: [14e4:4727] type 0 class 0x000280
[    1.603631] pci 0000:03:00.0: reg 10: [mem 0xc2400000-0xc2403fff 64bit]
[    1.603739] pci 0000:03:00.0: supports D1 D2
[    1.603777] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    1.603864] pci 0000:00:1c.1:   bridge window [io  0x1000-0x1fff]
[    1.603869] pci 0000:00:1c.1:   bridge window [mem 0xc2400000-0xc33fffff]
[    1.603877] pci 0000:00:1c.1:   bridge window [mem 0xc1400000-0xc23fffff 64bit pref]
[    1.603945] pci 0000:00:1e.0: PCI bridge to [bus 04-04] (subtractive decode)
[    1.604037] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.604042] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.604050] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.604054] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    1.604057] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    1.604061] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.604064] pci 0000:00:1e.0:   bridge window [mem 0xa0000000-0xfeafffff] (subtractive decode)
[    1.604085] pci_bus 0000:00: on NUMA node 0
[    1.604089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.604378] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    1.604441] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    1.604572] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.604639] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    1.604790] \_SB_.PCI0:_OSC invalid UUID
[    1.604792] _OSC request data:1 f 1f 
[    1.604797]  pci0000:00: Unable to request _OSC control (_OSC support mask: 0x0f)
[    1.614085] ACPI: PCI Root Bridge [CPBG] (domain 0000 [bus ff])
[    1.614287] pci 0000:ff:00.0: [8086:2c62] type 0 class 0x000600
[    1.614315] pci 0000:ff:00.1: [8086:2d01] type 0 class 0x000600
[    1.614347] pci 0000:ff:02.0: [8086:2d10] type 0 class 0x000600
[    1.614372] pci 0000:ff:02.1: [8086:2d11] type 0 class 0x000600
[    1.614397] pci 0000:ff:02.2: [8086:2d12] type 0 class 0x000600
[    1.614421] pci 0000:ff:02.3: [8086:2d13] type 0 class 0x000600
[    1.614461] pci_bus 0000:ff: on NUMA node 0
[    1.614472]  pci0000:ff: Unable to request _OSC control (_OSC support mask: 0x0f)
[    1.615065] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 15)
[    1.615692] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    1.616381] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
[    1.616999] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 11 12 14 15)
[    1.617621] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.618310] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.619050] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.619728] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.620540] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    1.620665] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
[    1.620784] vgaarb: loaded
[    1.620856] vgaarb: bridge control possible 0000:01:00.0
[    1.620939] vgaarb: bridge control possible 0000:00:02.0
[    1.621190] SCSI subsystem initialized
[    1.621351] libata version 3.00 loaded.
[    1.621435] usbcore: registered new interface driver usbfs
[    1.621554] usbcore: registered new interface driver hub
[    1.621683] usbcore: registered new device driver usb
[    1.621991] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    1.622078] PCI: Using ACPI for IRQ routing
[    1.632166] PCI: pci_cache_line_size set to 64 bytes
[    1.632257] reserve RAM buffer: 000000000009d000 - 000000000009ffff 
[    1.632260] reserve RAM buffer: 000000009b63f000 - 000000009bffffff 
[    1.632264] reserve RAM buffer: 000000009b800000 - 000000009bffffff 
[    1.632600] cfg80211: Calling CRDA to update world regulatory domain
[    1.632928] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.633377] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.635485] Switching to clocksource hpet
[    1.638425] Switched to NOHz mode on CPU #0
[    1.638492] Switched to NOHz mode on CPU #3
[    1.638526] Switched to NOHz mode on CPU #1
[    1.638534] Switched to NOHz mode on CPU #2
[    1.639778] pnp: PnP ACPI init
[    1.639865] ACPI: bus type pnp registered
[    1.640436] pnp 00:00: [bus 00-fe]
[    1.640440] pnp 00:00: [io  0x0000-0x0cf7 window]
[    1.640443] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.640446] pnp 00:00: [io  0x0d00-0xffff window]
[    1.640450] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.640453] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    1.640455] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    1.640458] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    1.640461] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    1.640464] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    1.640467] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    1.640470] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    1.640473] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    1.640476] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    1.640479] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    1.640482] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    1.640484] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    1.640487] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    1.640490] pnp 00:00: [mem 0xa0000000-0xfeafffff window]
[    1.640493] pnp 00:00: [mem 0xfed40000-0xfed44fff window]
[    1.640619] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.640714] pnp 00:01: [io  0x0000-0x001f]
[    1.640717] pnp 00:01: [io  0x0081-0x0091]
[    1.640719] pnp 00:01: [io  0x0093-0x009f]
[    1.640721] pnp 00:01: [io  0x00c0-0x00df]
[    1.640724] pnp 00:01: [dma 4]
[    1.640795] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.640809] pnp 00:02: [mem 0xff000000-0xffffffff]
[    1.640875] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    1.641029] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    1.641105] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.641121] pnp 00:04: [io  0x00f0]
[    1.641133] pnp 00:04: [irq 13]
[    1.641202] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.641219] pnp 00:05: [io  0x002e-0x002f]
[    1.641221] pnp 00:05: [io  0x004e-0x004f]
[    1.641224] pnp 00:05: [io  0x0061]
[    1.641226] pnp 00:05: [io  0x0063]
[    1.641228] pnp 00:05: [io  0x0065]
[    1.641231] pnp 00:05: [io  0x0067]
[    1.641233] pnp 00:05: [io  0x0070]
[    1.641235] pnp 00:05: [io  0x0080]
[    1.641237] pnp 00:05: [io  0x0092]
[    1.641240] pnp 00:05: [io  0x00b2-0x00b3]
[    1.641244] pnp 00:05: [io  0x0680-0x069f]
[    1.641247] pnp 00:05: [io  0x0800-0x080f]
[    1.641249] pnp 00:05: [io  0x0810-0x0813]
[    1.641252] pnp 00:05: [io  0xffff]
[    1.641254] pnp 00:05: [io  0x0400-0x047f]
[    1.641257] pnp 00:05: [io  0x0500-0x0501]
[    1.641259] pnp 00:05: [io  0x0700-0x077f]
[    1.641262] pnp 00:05: [io  0x164e-0x164f]
[    1.641278] pnp 00:05: disabling [io  0x164e-0x164f] because it overlaps 0000:00:1c.1 BAR 7 [io  0x1000-0x1fff]
[    1.641492] system 00:05: [io  0x0680-0x069f] has been reserved
[    1.641580] system 00:05: [io  0x0800-0x080f] has been reserved
[    1.641666] system 00:05: [io  0x0810-0x0813] has been reserved
[    1.641751] system 00:05: [io  0xffff] has been reserved
[    1.641835] system 00:05: [io  0x0400-0x047f] has been reserved
[    1.641920] system 00:05: [io  0x0500-0x0501] has been reserved
[    1.642005] system 00:05: [io  0x0700-0x077f] has been reserved
[    1.642092] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.642106] pnp 00:06: [io  0x0070-0x0077]
[    1.642114] pnp 00:06: [irq 8]
[    1.642186] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.642202] pnp 00:07: [io  0x0060]
[    1.642204] pnp 00:07: [io  0x0064]
[    1.642211] pnp 00:07: [irq 1]
[    1.642283] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.642300] pnp 00:08: [irq 12]
[    1.642372] pnp 00:08: Plug and Play ACPI device, IDs SYN1e2d SYN1e00 SYN0002 PNP0f13 (active)
[    1.642533] pnp 00:09: [irq 23]
[    1.642630] pnp 00:09: Plug and Play ACPI device, IDs HPQ0004 (active)
[    1.642908] pnp 00:0a: [mem 0xfed1c000-0xfed1ffff]
[    1.642911] pnp 00:0a: [mem 0xfed10000-0xfed13fff]
[    1.642914] pnp 00:0a: [mem 0xfed18000-0xfed18fff]
[    1.642917] pnp 00:0a: [mem 0xfed19000-0xfed19fff]
[    1.642919] pnp 00:0a: [mem 0xe0000000-0xefffffff]
[    1.642922] pnp 00:0a: [mem 0xfed20000-0xfed3ffff]
[    1.642925] pnp 00:0a: [mem 0xfed90000-0xfed8ffff disabled]
[    1.642928] pnp 00:0a: [mem 0xfed45000-0xfed8ffff]
[    1.642930] pnp 00:0a: [mem 0xff000000-0xffffffff]
[    1.642933] pnp 00:0a: [mem 0xfee00000-0xfeefffff]
[    1.642936] pnp 00:0a: [mem 0xc4600000-0xc4600fff]
[    1.643065] system 00:0a: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.643154] system 00:0a: [mem 0xfed10000-0xfed13fff] has been reserved
[    1.643243] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.643331] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.643419] system 00:0a: [mem 0xe0000000-0xefffffff] has been reserved
[    1.643518] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.643606] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.643694] system 00:0a: [mem 0xff000000-0xffffffff] could not be reserved
[    1.643784] system 00:0a: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.643873] system 00:0a: [mem 0xc4600000-0xc4600fff] has been reserved
[    1.643962] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.644271] pnp 00:0b: [bus ff]
[    1.644380] pnp 00:0b: Plug and Play ACPI device, IDs PNP0a03 (active)
[    1.644420] pnp: PnP ACPI: found 12 devices
[    1.644499] ACPI: ACPI bus type pnp unregistered
[    1.649161] pci 0000:01:00.0: no compatible bridge window for [mem 0xfffe0000-0xffffffff pref]
[    1.649285] PCI: max bus depth: 1 pci_try_num: 2
[    1.649322] pci 0000:01:00.0: BAR 6: assigned [mem 0xc4440000-0xc445ffff pref]
[    1.649436] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    1.649519] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    1.649607] pci 0000:00:01.0:   bridge window [mem 0xc4400000-0xc44fffff]
[    1.649697] pci 0000:00:01.0:   bridge window [mem 0xa0000000-0xafffffff 64bit pref]
[    1.649814] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    1.649898] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    1.649987] pci 0000:00:1c.0:   bridge window [mem 0xc3400000-0xc43fffff]
[    1.650077] pci 0000:00:1c.0:   bridge window [mem 0xc0400000-0xc13fffff 64bit pref]
[    1.650196] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    1.650280] pci 0000:00:1c.1:   bridge window [io  0x1000-0x1fff]
[    1.650369] pci 0000:00:1c.1:   bridge window [mem 0xc2400000-0xc33fffff]
[    1.650459] pci 0000:00:1c.1:   bridge window [mem 0xc1400000-0xc23fffff 64bit pref]
[    1.650578] pci 0000:00:1e.0: PCI bridge to [bus 04-04]
[    1.650659] pci 0000:00:1e.0:   bridge window [io  disabled]
[    1.650746] pci 0000:00:1e.0:   bridge window [mem disabled]
[    1.650832] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    1.650933] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.651021] pci 0000:00:01.0: setting latency timer to 64
[    1.651032] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.651122] pci 0000:00:1c.0: setting latency timer to 64
[    1.651130] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    1.651219] pci 0000:00:1c.1: setting latency timer to 64
[    1.651227] pci 0000:00:1e.0: setting latency timer to 64
[    1.651232] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.651236] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.651239] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.651242] pci_bus 0000:00: resource 7 [mem 0xa0000000-0xfeafffff]
[    1.651245] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    1.651249] pci_bus 0000:01: resource 1 [mem 0xc4400000-0xc44fffff]
[    1.651252] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xafffffff 64bit pref]
[    1.651255] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    1.651259] pci_bus 0000:02: resource 1 [mem 0xc3400000-0xc43fffff]
[    1.651262] pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc13fffff 64bit pref]
[    1.651265] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    1.651268] pci_bus 0000:03: resource 1 [mem 0xc2400000-0xc33fffff]
[    1.651272] pci_bus 0000:03: resource 2 [mem 0xc1400000-0xc23fffff 64bit pref]
[    1.651275] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    1.651278] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    1.651281] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    1.651285] pci_bus 0000:04: resource 7 [mem 0xa0000000-0xfeafffff]
[    1.651324] NET: Registered protocol family 2
[    1.651445] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.651886] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    1.653148] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.653513] TCP: Hash tables configured (established 262144 bind 65536)
[    1.653601] TCP reno registered
[    1.653678] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    1.653784] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    1.654012] NET: Registered protocol family 1
[    1.654219] RPC: Registered named UNIX socket transport module.
[    1.654305] RPC: Registered udp transport module.
[    1.654385] RPC: Registered tcp transport module.
[    1.654465] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.654567] pci 0000:00:02.0: Boot video device
[    1.683556] PCI: CLS 64 bytes, default 64
[    1.683580] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.683668] Placing 64MB software IO TLB between ffff88009763b000 - ffff88009b63b000
[    1.683783] software IO TLB at phys 0x9763b000 - 0x9b63b000
[    1.683879] Simple Boot Flag at 0x44 set to 0x1
[    1.728296] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    1.728465] msgmni has been set to 7517
[    1.730890] alg: No test for stdrng (krng)
[    1.737427] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.737543] io scheduler noop registered
[    1.737621] io scheduler deadline registered
[    1.737779] io scheduler cfq registered (default)
[    1.737997] pcieport 0000:00:01.0: setting latency timer to 64
[    1.738301] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.738509] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.738647] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.738735] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.739808] Linux agpgart interface v0.103
[    1.739970] agpgart-intel 0000:00:00.0: Intel HD Graphics Chipset
[    1.740179] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    1.741253] agpgart-intel 0000:00:00.0: detected 32768K stolen memory
[    1.741562] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xb0000000
[    1.741890] intel_idle: MWAIT substates: 0x1120
[    1.741893] intel_idle: v0.4 model 0x25
[    1.741895] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.743685] ACPI: AC Adapter [AC] (on-line)
[    1.744227] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
[    1.744378] ACPI: Lid Switch [LID0]
[    1.744541] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    1.744661] ACPI: Power Button [PWRB]
[    1.744821] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.744936] ACPI: Power Button [PWRF]
[    1.745150] ACPI: Fan [FAN0] (on)
[    1.745269] ACPI: acpi_idle yielding to intel_idle
[    1.752268] thermal LNXTHERM:00: registered as thermal_zone0
[    1.752354] ACPI: Thermal Zone [TZ00] (57 C)
[    1.753209] thermal LNXTHERM:01: registered as thermal_zone1
[    1.753305] ACPI: Thermal Zone [TZ01] (45 C)
[    1.754115] thermal LNXTHERM:02: registered as thermal_zone2
[    1.757008] ACPI: Thermal Zone [TZ02] (74 C)
[    1.757333] [drm] Initialized drm 1.1.0 20060810
[    1.757482] [drm] radeon defaulting to kernel modesetting.
[    1.757573] [drm] radeon kernel modesetting enabled.
[    1.757665] VGA switcheroo: detected switching method \_SB_.PCI0.GFX0.ATPX handle
[    1.757817] radeon 0000:01:00.0: enabling device (0000 -> 0003)
[    1.757929] radeon 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.758049] radeon 0000:01:00.0: setting latency timer to 64
[    1.758285] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68E0 0x103C:0x1486).
[    1.758470] [drm] register mmio base: 0xC4400000
[    1.758559] [drm] register mmio size: 131072
[    2.682939] Refined TSC clocksource calibration: 1196.999 MHz.
[    2.683039] Switching to clocksource tsc
[   10.111493] ACPI: Battery Slot [BAT0] (battery present)
[   10.815845] ATOM BIOS: HP
[   10.815995] radeon 0000:01:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
[   10.816114] radeon 0000:01:00.0: GTT: 512M 0x0000000020000000 - 0x000000003FFFFFFF
[   10.816234] mtrr: no more MTRRs available
[   10.816313] [drm] Detected VRAM RAM=512M, BAR=256M
[   10.816393] [drm] RAM width 64bits DDR
[   10.816508] [TTM] Zone  kernel: Available graphics memory: 1924438 kiB.
[   10.816596] [TTM] Initializing pool allocator.
[   10.816700] [drm] radeon: 512M of VRAM memory ready
[   10.816781] [drm] radeon: 512M of GTT memory ready.
[   10.816870] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   10.816957] [drm] Driver supports precise vblank timestamp query.
[   10.817079] [drm] radeon: irq initialized.
[   10.817160] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   10.818135] [drm] Loading CEDAR Microcode
[   10.820597] radeon 0000:01:00.0: WB enabled
[   10.837330] [drm] ring test succeeded in 1 usecs
[   10.837512] [drm] radeon: ib pool ready.
[   10.837667] [drm] ib test succeeded in 0 usecs
[   10.838443] [drm] Radeon Display Connectors
[   10.838523] [drm] Connector 0:
[   10.838597] [drm]   LVDS
[   10.838670] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
[   10.838783] [drm]   Encoders:
[   10.838858] [drm]     LCD1: INTERNAL_UNIPHY
[   10.838937] [drm] Connector 1:
[   10.839011] [drm]   HDMI-A
[   10.839084] [drm]   HPD1
[   10.839157] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[   10.839269] [drm]   Encoders:
[   10.839344] [drm]     DFP1: INTERNAL_UNIPHY1
[   10.839422] [drm] Connector 2:
[   10.839497] [drm]   VGA
[   10.839569] [drm]   DDC: 0x64d8 0x64d8 0x64dc 0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
[   10.839682] [drm]   Encoders:
[   10.839758] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   10.849728] [drm] Radeon display connector LVDS-1: No monitor connected or invalid EDID
[   10.859858] [drm] Radeon display connector HDMI-A-1: No monitor connected or invalid EDID
[   10.869895] [drm] Radeon display connector VGA-1: No monitor connected or invalid EDID
[   10.870084] [drm] Internal thermal controller with fan control
[   10.870302] [drm] radeon: power management initialized
[   10.908905] [drm] fb mappable at 0xA0141000
[   10.908985] [drm] vram apper at 0xA0000000
[   10.909062] [drm] size 4096000
[   10.909137] [drm] fb depth is 24
[   10.909213] [drm]    pitch is 5120
[   11.421421] Console: switching to colour frame buffer device 160x50
[   11.425084] fb0: radeondrmfb frame buffer device
[   11.425086] drm: registered panic notifier
[   11.425158] [drm] Initialized radeon 2.10.0 20080528 for 0000:01:00.0 on minor 0
[   11.425308] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   11.425366] i915 0000:00:02.0: setting latency timer to 64
[   11.479422] mtrr: no more MTRRs available
[   11.479453] [drm] MTRR allocation failed.  Graphics performance may suffer.
[   11.480147] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   11.480191] [drm] Driver supports precise vblank timestamp query.
[   11.480421] vga_switcheroo: enabled
[   11.480501] radeon atpx: version is 1
[   11.480549] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=none
[   11.480608] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
[   11.701779] fbcon: inteldrmfb (fb1) is primary device
[   11.701824] fbcon: Remapping primary device, fb1, to tty 1-63
[   12.338652] fb1: inteldrmfb frame buffer device
[   12.339458] [Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness
[   12.340169] acpi device:02: registered as cooling_device5
[   12.340547] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input3
[   12.340613] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   12.340682] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[   12.342298] acpi device:0b: registered as cooling_device6
[   12.342669] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:09/LNXVIDEO:01/input/input4
[   12.342736] ACPI: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[   12.342863] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 1
[   12.345070] brd: module loaded
[   12.348121] loop: module loaded
[   12.350271] ahci 0000:00:1f.2: version 3.0
[   12.350293] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[   12.352346] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 3 Gbps 0x1 impl SATA mode
[   12.354369] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck pm led clo pio slum part ems apst 
[   12.356415] ahci 0000:00:1f.2: setting latency timer to 64
[   12.357131] scsi0 : ahci
[   12.359369] scsi1 : ahci
[   12.361548] scsi2 : ahci
[   12.363696] scsi3 : ahci
[   12.365869] ata1: SATA max UDMA/133 abar m2048@0xc4505000 port 0xc4505100 irq 19
[   12.367915] ata2: DUMMY
[   12.369982] ata3: DUMMY
[   12.372019] ata4: DUMMY
[   12.374166] tun: Universal TUN/TAP device driver, 1.6
[   12.376165] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   12.378228] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   12.380232] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   12.382223] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[   12.382228] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[   12.384195] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   12.386209] ehci_hcd 0000:00:1a.0: debug port 2
[   12.392100] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[   12.392108] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xc4505c00
[   12.409551] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   12.411746] hub 1-0:1.0: USB hub found
[   12.413747] hub 1-0:1.0: 3 ports detected
[   12.415815] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[   12.417853] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[   12.417858] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[   12.419865] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   12.421932] ehci_hcd 0000:00:1d.0: debug port 2
[   12.427870] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[   12.427887] ehci_hcd 0000:00:1d.0: irq 20, io mem 0xc4505800
[   12.445529] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   12.447715] hub 2-0:1.0: USB hub found
[   12.449685] hub 2-0:1.0: 3 ports detected
[   12.451728] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   12.453733] uhci_hcd: USB Universal Host Controller Interface driver
[   12.455797] usbcore: registered new interface driver usblp
[   12.457775] Initializing USB Mass Storage driver...
[   12.459802] usbcore: registered new interface driver usb-storage
[   12.461798] USB Mass Storage support registered.
[   12.463828] usbcore: registered new interface driver libusual
[   12.465941] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   12.471422] i8042: Detected active multiplexing controller, rev 1.1
[   12.476090] serio: i8042 KBD port at 0x60,0x64 irq 1
[   12.478068] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   12.480043] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   12.482003] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   12.483912] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   12.485960] mousedev: PS/2 mouse device common for all mice
[   12.488198] rtc_cmos 00:06: RTC can wake from S4
[   12.490164] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   12.492025] rtc0: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[   12.493898] i2c /dev entries driver
[   12.496930] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) -> IRQ 19
[   12.498998] Linux video capture interface: v2.00
[   12.500951] usbcore: registered new interface driver uvcvideo
[   12.502822] USB Video Class driver (v1.1.0)
[   12.504783] coretemp coretemp.0: TjMax is 105 C.
[   12.506635] coretemp coretemp.0: TjMax is 105 C.
[   12.508490] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[   12.510507] iTCO_wdt: Found a HM55 TCO device (Version=2, TCOBASE=0x0460)
[   12.512421] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   12.514249] iTCO_vendor_support: vendor-support=0
[   12.516644] cpuidle: using governor ladder
[   12.519517] cpuidle: using governor menu
[   12.521353] EFI Variables Facility v0.08 2004-May-17
[   12.525224] usbcore: registered new interface driver usbhid
[   12.526954] usbhid: USB HID core driver
[   12.528775] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   12.530523] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   12.535196] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[   12.693445] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   12.695718] ata1.00: ATA-8: TOSHIBA MK5061GSYN, MH000C, max UDMA/100
[   12.697594] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[   12.699844] ata1.00: configured for UDMA/100
[   12.702228] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK5061GS MH00 PQ: 0 ANSI: 5
[   12.704417] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[   12.706422] sd 0:0:0:0: [sda] Write Protect is off
[   12.708332] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   12.708353] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.729419] usb 1-1: new high speed USB device number 2 using ehci_hcd
[   12.814139]  sda: sda1 sda2 sda3 sda4 sda5
[   12.817278] sd 0:0:0:0: [sda] Attached SCSI disk
[   12.862219] hub 1-1:1.0: USB hub found
[   12.865689] hub 1-1:1.0: 6 ports detected
[   12.977253] usb 2-1: new high speed USB device number 2 using ehci_hcd
[   13.110613] hub 2-1:1.0: USB hub found
[   13.113132] hub 2-1:1.0: 8 ports detected
[   13.189474] usb 1-1.3: new full speed USB device number 3 using ehci_hcd
[   13.357252] usb 1-1.4: new full speed USB device number 4 using ehci_hcd
[   13.492358] Synaptics Touchpad, model: 1, fw: 7.4, id: 0x1e0b1, caps: 0xd04773/0xe40000/0x5a0400
[   13.525080] usb 2-1.5: new full speed USB device number 3 using ehci_hcd
[   13.529951] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input6
[   13.689185] usb 2-1.6: new high speed USB device number 4 using ehci_hcd
[   13.862414] uvcvideo: Found UVC 1.00 device HP Webcam (174f:1118)
[   13.878057] input: HP Webcam as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.0/input/input7
[   14.591189] HDA Intel 0000:01:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   14.593108] HDA Intel 0000:01:00.1: setting latency timer to 64
[   14.609032] HDMI status: Pin=3 Presence_Detect=0 ELD_Valid=0
[   14.612601] usbcore: registered new interface driver snd-usb-audio
[   14.614580] ALSA device list:
[   14.616496]   #0: HDA Intel at 0xc4500000 irq 22
[   14.618403]   #1: HD-Audio Generic at 0xc4420000 irq 17
[   14.620386] IPv4 over IPv4 tunneling driver
[   14.622965] TCP cubic registered
[   14.625851] NET: Registered protocol family 10
[   14.627994] IPv6 over IPv4 tunneling driver
[   14.630405] NET: Registered protocol family 17
[   14.632267] lib80211: common routines for IEEE802.11 drivers
[   14.634120] lib80211_crypt: registered algorithm 'NULL'
[   14.634753] PM: Hibernation image not present or could not be loaded.
[   14.635251] rtc_cmos 00:06: setting system clock to 2011-10-01 09:17:18 UTC (1317460638)
[   14.677881] EXT3-fs: barriers not enabled
[   14.689894] kjournald starting.  Commit interval 5 seconds
[   14.689938] EXT3-fs (sda1): mounted filesystem with ordered data mode
[   14.689957] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[   14.697645] Freeing unused kernel memory: 452k freed
[   15.796042] udev[1241]: starting version 164
[   15.897998] wmi: Mapper loaded
[   15.902048] hp_accel: laptop model unknown, using default axes configuration
[   15.902916] lis3lv02d: 8 bits sensor found
[   15.907937] brcmutil: module is from the staging directory, the quality is unknown, you have been warned.
[   15.943709] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input8
[   15.943885] Registered led device: hp::hddprotect
[   15.943921] hp_accel: driver loaded
[   16.032981] input: Wacom ISDv4 E3 Finger as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.0/input/input9
[   16.038296] input: Wacom ISDv4 E3 Pen as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.1/input/input10
[   16.041218] usbcore: registered new interface driver wacom
[   16.041227] wacom: v1.52:USB Wacom tablet driver
[   16.051534] brcmsmac: module is from the staging directory, the quality is unknown, you have been warned.
[   16.053104] brcmsmac 0000:03:00.0: bus 3 slot 0 func 0 irq 10
[   16.053128] brcmsmac 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   16.053138] brcmsmac 0000:03:00.0: setting latency timer to 64
[   16.069599] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   16.069631] r8169 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   16.069697] r8169 0000:02:00.0: setting latency timer to 64
[   16.069709] r8169 0000:02:00.0: no MSI. Back to INTx.
[   16.069888] r8169 0000:02:00.0: eth0: RTL8168d/8111d at 0xffffc900100e2000, 1c:c1:de:ae:1e:1c, XID 083000c0 IRQ 16
[   16.124404] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   16.639802] input: HP WMI hotkeys as /devices/virtual/input/input11
[   19.718414] EXT3-fs (sda1): using internal journal
[   20.003455] EXT3-fs: barriers not enabled
[   20.003942] kjournald starting.  Commit interval 5 seconds
[   20.004225] EXT3-fs (sda4): using internal journal
[   20.004238] EXT3-fs (sda4): mounted filesystem with ordered data mode
[   20.083580] EXT3-fs: barriers not enabled
[   20.083937] kjournald starting.  Commit interval 5 seconds
[   20.084199] EXT3-fs (sda3): using internal journal
[   20.084210] EXT3-fs (sda3): mounted filesystem with ordered data mode
[   20.134578] EXT3-fs: barriers not enabled
[   20.149020] kjournald starting.  Commit interval 5 seconds
[   20.149484] EXT3-fs (sda5): using internal journal
[   20.149490] EXT3-fs (sda5): mounted filesystem with ordered data mode
[   21.687282] Adding 2000892k swap on /dev/sda2.  Priority:-1 extents:1 across:2000892k 
[   21.929694] ieee80211 phy0: wl_ops_config: change monitor mode: false (implement)
[   21.929705] ieee80211 phy0: wl_ops_config: change power-save mode: false (implement)
[   21.930266] ieee80211 phy0: wl_ops_bss_info_changed: qos enabled: false (implement)
[   21.931367] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   22.509285] radeon: switched off
[   22.798029] radeon 0000:01:00.0: PCI INT A disabled
[   22.837301] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837306] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837310] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837313] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837316] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837320] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837323] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837326] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837329] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837332] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837335] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837339] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837342] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837345] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837348] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837351] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837355] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837358] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837361] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837364] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837367] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837371] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837374] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837377] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837380] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837383] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837387] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837390] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837393] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837396] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837399] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837403] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837406] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837409] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837412] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837415] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837419] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837422] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837425] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837428] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837431] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837434] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837438] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837441] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837444] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837447] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837451] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837454] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837457] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837460] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837463] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837467] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837470] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837473] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837476] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837479] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837482] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837486] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837489] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837492] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837495] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837498] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837502] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837505] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837508] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837511] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837514] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837518] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837521] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837524] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837527] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837530] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837533] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837537] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837540] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837543] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837546] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837549] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837553] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837556] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837559] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837562] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837565] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837569] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837572] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837575] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837578] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837582] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837585] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837588] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837591] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837594] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837597] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837601] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837604] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837607] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837610] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837613] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837617] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837620] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837623] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837626] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837629] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837633] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837636] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837639] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837642] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837645] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837649] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837652] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837655] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837658] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837661] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837665] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837668] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837671] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837674] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837677] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837681] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837684] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837687] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837690] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837693] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837696] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837700] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837703] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837706] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837709] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837712] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837716] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837719] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837722] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837725] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837728] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837732] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837735] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837738] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837741] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837744] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837748] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837751] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837754] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837757] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837760] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837763] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837767] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837770] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837773] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837776] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837779] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837783] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837786] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837789] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837792] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837795] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837799] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837802] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837805] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837808] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837811] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837815] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837818] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837821] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837824] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837827] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837831] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837834] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837837] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837840] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837843] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837846] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837850] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837853] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837856] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837859] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837862] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837866] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837869] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837872] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837875] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837878] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837881] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837885] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837888] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837891] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837894] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837897] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837901] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837904] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837907] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837910] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837913] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837917] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837920] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837923] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837926] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837929] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837932] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837936] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837939] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837942] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837945] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837948] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837952] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837955] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837958] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837961] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837964] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837967] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837971] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837974] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837977] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837980] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837984] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837987] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837990] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837993] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.837996] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838000] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838003] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838006] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838009] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838012] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838015] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838019] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838022] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   22.838025] hda-intel: spurious response 0x0:0x0, last cmd=0x2f0d00
[   23.226992] wlan0: authenticate with 00:1c:4a:07:7f:76 (try 1)
[   23.229531] wlan0: authenticated
[   23.229557] wlan0: associate with 00:1c:4a:07:7f:76 (try 1)
[   23.233871] wlan0: RX AssocResp from 00:1c:4a:07:7f:76 (capab=0x431 status=0 aid=1)
[   23.233876] wlan0: associated
[   23.234553] ieee80211 phy0: wl_ops_bss_info_changed: qos enabled: true (implement)
[   23.234562] ieee80211 phy0: brcmsmac: wl_ops_bss_info_changed: associated
[   23.234576] ieee80211 phy0: wl_ops_bss_info_changed: arp filtering: enabled true, count 0 (implement)
[   23.235041] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   29.040564] ieee80211 phy0: wl_ops_bss_info_changed: arp filtering: enabled true, count 1 (implement)
[   34.029643] wlan0: no IPv6 routers present

--/9DWx/yDrRhgMJTb--
