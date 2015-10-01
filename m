From: Meelis Roos <mroos@ut.ee>
Subject: bisected: Re: 4.3.0-rc3-00042: ACPI Warning: AcpiEnable failed
Date: Thu, 1 Oct 2015 09:36:57 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1510010927010.10113@math.ut.ee>
References: <alpine.LRH.2.20.1509291519111.3351@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:34517 "EHLO smtp1.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbbJAGfm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Oct 2015 02:35:42 -0400
In-Reply-To: <alpine.LRH.2.20.1509291519111.3351@math.ut.ee>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

> 4.2.0 worked fine, 4.3.0-rc3-00042-g3225031 was the next one tested 
> after that and with this kernel, ACPI enabling fails. This is Pentium 
> III, 1 GHz, Intel 815 chipset, DMI tells something about "Packard Bell 
> NEC" as the mainboard type.
> 
> Full dmesg and config are below. What additional information can I 
> provide besides bisecting (will take time)?

Bisecting done, here is the culprit:

8ec3f459073e67e5c6d78507dec693064b3040a2 is the first bad commit
commit 8ec3f459073e67e5c6d78507dec693064b3040a2
Author: Lv Zheng <lv.zheng@intel.com>
Date:   Tue Aug 25 10:29:01 2015 +0800

    ACPICA: Tables: Fix global table list issues by removing fixed table indexes
    
    ACPICA commit c0b38b4c3982c2336ee92a2a14716107248bd941
    
    The fixed table indexes leave holes in the global table list:
     1. One hole can be seen when there is only 1 FACS provided by the BIOS.
     2. Tow holes can be seen when it is a reduced hardware platform.
    The holes do not break OSPMs but have broken ACPI debugger "tables"
    command.
    
    Also the "fixed table indexes" mechanism may make the descriptors of the
    standard tables installed earlier than DSDT to be overwritten by the
    descriptors of the fixed tables. For example, FACP disappears from the
    global table list after DSDT is installed.
    
    This patch fixes all above issues by removing the "fixed table indexes"
    mechanism which is too complicated to be maintained in a regression safe
    manner. After removal, the table loader will determine the indexes of the
    fixed tables. Lv Zheng.
    
    Link: https://github.com/acpica/acpica/commit/c0b38b4c
    Signed-off-by: Lv Zheng <lv.zheng@intel.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 0c3bbd0eca80e79fcf6f265cfc98f38b51b3a807 46d34d3ce537aff081694b0ad511a5ae00771b86 M      drivers


Additionally, it seem I included a wrong dmesg. Here is a correct one:

[    0.000000] Linux version 4.3.0-rc3-00042-g3225031 (mroos@matrox) (gcc version 5.2.1 20150808 (Debian 5.2.1-15) ) #54 PREEMPT Tue Sep 29 14:36:48 EEST 2015
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000001ffe0000-0x000000001ffeffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000001fff0000-0x000000001fffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000fff80000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] Legacy DMI 2.3 present.
[    0.000000] DMI: Packard Bell NEC 00000000000000000000000/i815                            , BIOS 2.0Q                             09/27/2001
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1ffe0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 base 020000000 mask FFFF80000 write-back
[    0.000000]   2 base 020000000 mask FFFF80000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 512MB, type WB
[    0.000000] reg 1, base: 512MB, range: 512KB, type WB
[    0.000000] reg 2, base: 512MB, range: 512KB, type UC
[    0.000000] total RAM covered: 512M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 64K 	num_reg: 1  	lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 512MB, type WB
[    0.000000] initial memory mapped: [mem 0x00000000-0x01bfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x1f800000-0x1fbfffff]
[    0.000000]  [mem 0x1f800000-0x1fbfffff] page 4M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1f7fffff]
[    0.000000]  [mem 0x00100000-0x003fffff] page 4k
[    0.000000]  [mem 0x00400000-0x1f7fffff] page 4M
[    0.000000] init_memory_mapping: [mem 0x1fc00000-0x1ffdffff]
[    0.000000]  [mem 0x1fc00000-0x1ffdffff] page 4k
[    0.000000] BRK [0x015e9000, 0x015e9fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FBE70 000014 (v00 AMI   )
[    0.000000] ACPI: RSDT 0x000000001FFE0000 000028 (v01 AMIINT AMIINT10 00000011 MSFT 0100000C)
[    0.000000] ACPI: FACP 0x000000001FFE0030 000074 (v01 AMIINT AMIINT10 00000011 MSFT 0100000C)
[    0.000000] ACPI: DSDT 0x000000001FFE00B0 00317F (v01 INTEL  SOLANO   00001004 MSFT 0100000D)
[    0.000000] ACPI: FACS 0x000000001FFE8000 000040
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1ffe0000
[    0.000000]   low ram: 0 - 1ffe0000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x000000001ffdffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdffff]
[    0.000000] On node 0 totalpages: 130942
[    0.000000] free_area_init_node: node 0, pgdat c15367c0, node_mem_map dfbe0020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 992 pages used for memmap
[    0.000000]   Normal zone: 126944 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] Local APIC disabled by BIOS -- reenabling.
[    0.000000] Found and enabled local APIC!
[    0.000000] e820: [mem 0x20000000-0xfff7ffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129918
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.3.0-rc3-00042-g3225031 root=/dev/sda1 ro lapic
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Memory: 513084K/523768K available (3960K kernel code, 253K rwdata, 1144K rodata, 340K init, 300K bss, 10684K reserved, 0K cma-reserved)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xfffa3000 - 0xfffff000   ( 368 kB)
                   vmalloc : 0xe07e0000 - 0xfffa1000   ( 503 MB)
                   lowmem  : 0xc0000000 - 0xdffe0000   ( 511 MB)
                     .init : 0xc153f000 - 0xc1594000   ( 340 kB)
                     .data : 0xc13de426 - 0xc153d780   (1404 kB)
                     .text : 0xc1000000 - 0xc13de426   (3961 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:2304 nr_irqs:24 16
[    0.000000] CPU 0 irqstacks, hard=df406000 soft=df408000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1003.830 MHz processor
[    0.008021] Calibrating delay loop (skipped), value calculated using timer frequency.. 2007.66 BogoMIPS (lpj=4015320)
[    0.008184] pid_max: default: 32768 minimum: 301
[    0.008313] ACPI: Core revision 20150818
[    0.014195] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.014311] ACPI: setting ELCR to 0200 (from 0a20)
[    0.014447] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.014533] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.015244] mce: CPU supports 5 MCE banks
[    0.015373] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 2
[    0.015454] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
[    0.015534] CPU: Intel Pentium III (Coppermine) (family: 0x6, model: 0x8, stepping: 0xa)
[    0.015953] ACPI Warning: AcpiEnable failed (20150818/utxfinit-162)
[    0.016091] ACPI: Unable to enable ACPI
[    0.016368] Performance Events: p6 PMU driver.
[    0.016469] ... version:                0
[    0.016542] ... bit width:              32
[    0.016615] ... generic registers:      2
[    0.016688] ... value mask:             00000000ffffffff
[    0.016763] ... max period:             000000007fffffff
[    0.016838] ... fixed-purpose events:   0
[    0.016910] ... event mask:             0000000000000003
[    0.017547] Enabling APIC mode:  Flat.  Using 0 I/O APICs
[    0.020000] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.020000] devtmpfs: initialized
[    0.020000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.020000] NET: Registered protocol family 16
[    0.028026] cpuidle: using governor ladder
[    0.036012] cpuidle: using governor menu
[    0.038435] PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=2
[    0.038521] PCI: Using configuration type 1 for base access
[    0.053187] ACPI: Interpreter disabled.
[    0.053549] vgaarb: loaded
[    0.053894] SCSI subsystem initialized
[    0.054320] libata version 3.00 loaded.
[    0.054452] PCI: Probing PCI hardware
[    0.054539] PCI: root bus 00: using default resources
[    0.054545] PCI: Probing PCI hardware (bus 00)
[    0.054644] PCI host bridge to bus 0000:00
[    0.054732] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.054816] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.054901] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.055068] pci 0000:00:00.0: [8086:1130] type 00 class 0x060000
[    0.055096] pci 0000:00:00.0: reg 0x10: [mem 0xe8000000-0xebffffff pref]
[    0.055249] pci 0000:00:01.0: [8086:1131] type 01 class 0x060400
[    0.055406] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060400
[    0.055541] pci 0000:00:1f.0: [8086:2440] type 00 class 0x060100
[    0.055625] pci 0000:00:1f.0: quirk: [io  0x0400-0x047f] claimed by ICH4 ACPI/GPIO/TCO
[    0.055775] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by ICH4 GPIO
[    0.055963] pci 0000:00:1f.1: [8086:244b] type 00 class 0x010180
[    0.056543] pci 0000:00:1f.1: reg 0x20: [io  0xff00-0xff0f]
[    0.056578] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.056671] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.056755] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.056840] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.057129] pci 0000:00:1f.2: [8086:2442] type 00 class 0x0c0300
[    0.057189] pci 0000:00:1f.2: reg 0x20: [io  0xd000-0xd01f]
[    0.057347] pci 0000:00:1f.3: [8086:2443] type 00 class 0x0c0500
[    0.057403] pci 0000:00:1f.3: reg 0x20: [io  0x0540-0x054f]
[    0.057555] pci 0000:00:1f.4: [8086:2444] type 00 class 0x0c0300
[    0.057612] pci 0000:00:1f.4: reg 0x20: [io  0xd400-0xd41f]
[    0.057767] pci 0000:00:1f.5: [8086:2445] type 00 class 0x040100
[    0.057792] pci 0000:00:1f.5: reg 0x10: [io  0xdc00-0xdcff]
[    0.057808] pci 0000:00:1f.5: reg 0x14: [io  0xd800-0xd83f]
[    0.058099] pci 0000:01:00.0: [102b:2527] type 00 class 0x030000
[    0.058133] pci 0000:01:00.0: reg 0x10: [mem 0xe4000000-0xe5ffffff pref]
[    0.058147] pci 0000:01:00.0: reg 0x14: [mem 0xef9fc000-0xef9fffff]
[    0.058161] pci 0000:01:00.0: reg 0x18: [mem 0xef000000-0xef7fffff]
[    0.058192] pci 0000:01:00.0: reg 0x30: [mem 0xef9c0000-0xef9dffff pref]
[    0.058283] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.058375] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.058611] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.058699] pci 0000:00:01.0:   bridge window [mem 0xee900000-0xef9fffff]
[    0.058709] pci 0000:00:01.0:   bridge window [mem 0xe2600000-0xe66fffff pref]
[    0.058837] pci 0000:02:01.0: [8086:1229] type 00 class 0x020000
[    0.058869] pci 0000:02:01.0: reg 0x10: [mem 0xefeff000-0xefefffff]
[    0.058884] pci 0000:02:01.0: reg 0x14: [io  0xac00-0xac3f]
[    0.058899] pci 0000:02:01.0: reg 0x18: [mem 0xefd00000-0xefdfffff]
[    0.058936] pci 0000:02:01.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    0.058961] pci 0000:02:01.0: supports D1 D2
[    0.058968] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.059146] pci 0000:00:1e.0: PCI bridge to [bus 02] (subtractive decode)
[    0.059240] pci 0000:00:1e.0:   bridge window [io  0xa000-0xafff]
[    0.059250] pci 0000:00:1e.0:   bridge window [mem 0xefa00000-0xefefffff]
[    0.059260] pci 0000:00:1e.0:   bridge window [mem 0xe6700000-0xe67fffff pref]
[    0.059268] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.059275] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff] (subtractive decode)
[    0.059298] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 02
[    0.059543] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:2440]
[    0.059644] PCI: setting IRQ 5 as level-triggered
[    0.059653] pci 0000:00:1f.3: found PCI INT B -> IRQ 5
[    0.059752] pci 0000:00:1f.3: sharing IRQ 5 with 0000:00:1f.5
[    0.059845] PCI: pci_cache_line_size set to 32 bytes
[    0.059892] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.059901] e820: reserve RAM buffer [mem 0x1ffe0000-0x1fffffff]
[    0.061414] clocksource: Switched to clocksource refined-jiffies
[    0.061947] pnp: PnP ACPI: disabled
[    0.108290] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.108460] clocksource: Switched to clocksource acpi_pm
[    0.108570] pci 0000:02:01.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: address conflict with reserved [mem 0xfff80000-0xffffffff]
[    0.108744] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.108830] pci 0000:00:01.0:   bridge window [mem 0xee900000-0xef9fffff]
[    0.108913] pci 0000:00:01.0:   bridge window [mem 0xe2600000-0xe66fffff pref]
[    0.109063] pci 0000:02:01.0: BAR 6: assigned [mem 0xe6700000-0xe67fffff pref]
[    0.109201] pci 0000:00:1e.0: PCI bridge to [bus 02]
[    0.109281] pci 0000:00:1e.0:   bridge window [io  0xa000-0xafff]
[    0.109367] pci 0000:00:1e.0:   bridge window [mem 0xefa00000-0xefefffff]
[    0.109456] pci 0000:00:1e.0:   bridge window [mem 0xe6700000-0xe67fffff pref]
[    0.109607] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.109614] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.109622] pci_bus 0000:01: resource 1 [mem 0xee900000-0xef9fffff]
[    0.109630] pci_bus 0000:01: resource 2 [mem 0xe2600000-0xe66fffff pref]
[    0.109637] pci_bus 0000:02: resource 0 [io  0xa000-0xafff]
[    0.109645] pci_bus 0000:02: resource 1 [mem 0xefa00000-0xefefffff]
[    0.109652] pci_bus 0000:02: resource 2 [mem 0xe6700000-0xe67fffff pref]
[    0.109659] pci_bus 0000:02: resource 4 [io  0x0000-0xffff]
[    0.109666] pci_bus 0000:02: resource 5 [mem 0x00000000-0xffffffff]
[    0.109789] NET: Registered protocol family 2
[    0.110424] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.110562] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.110688] TCP: Hash tables configured (established 4096 bind 4096)
[    0.110866] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.110962] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.111176] NET: Registered protocol family 1
[    0.111392] pci 0000:01:00.0: Video device with shadowed ROM
[    0.111426] pci 0000:02:01.0: Firmware left e100 interrupts enabled; disabling
[    0.111575] PCI: CLS 32 bytes, default 32
[    0.111970] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.112600] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.116396] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.116565] io scheduler noop registered
[    0.116689] io scheduler cfq registered (default)
[    0.117057] Serial: 8250/16550 driver, 16 ports, IRQ sharing disabled
[    0.137768] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.158520] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.161000] Non-volatile memory driver v1.3
[    0.161109] Linux agpgart interface v0.103
[    0.161269] agpgart-intel 0000:00:00.0: Intel i815 Chipset
[    0.166328] agpgart-intel 0000:00:00.0: AGP aperture is 64M @ 0xe8000000
[    0.166538] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    0.167006] ata_piix 0000:00:1f.1: version 2.13
[    0.168905] scsi host0: ata_piix
[    0.169511] scsi host1: ata_piix
[    0.169759] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    0.169846] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    0.170030] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    0.170111] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.170234] PCI: setting IRQ 11 as level-triggered
[    0.170244] e100 0000:02:01.0: found PCI INT A -> IRQ 11
[    0.180281] Floppy drive(s): fd0 is 1.44M
[    0.196315] e100 0000:02:01.0 eth0: addr 0xefeff000, irq 11, MAC addr 00:02:b3:09:1e:59
[    0.196753] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    0.199516] FDC 0 is a post-1991 82077
[    0.202460] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.202671] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.203145] mousedev: PS/2 mouse device common for all mice
[    0.205652] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    0.205781] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram
[    0.206032] hidraw: raw HID events driver (C) Jiri Kosina
[    0.207133] NET: Registered protocol family 10
[    0.208644] NET: Registered protocol family 17
[    0.208772] Key type dns_resolver registered
[    0.209520] Using IPI Shortcut mode
[    0.210819] Key type encrypted registered
[    0.211318] console [netcon0] enabled
[    0.211400] netconsole: network logging started
[    0.211535] rtc_cmos rtc_cmos: setting system clock to 2015-10-01 06:32:23 UTC (1443681143)
[    0.332503] ata2.00: ATAPI: CDU5211, YYS2, max UDMA/33, CDB intr
[    0.340306] ata2.00: configured for UDMA/33
[    0.380130] ata1.00: ATA-7: ST380215A, 3.AAD, max UDMA/100
[    0.380214] ata1.00: 156301488 sectors, multi 16: LBA48 
[    0.454982] ata1.00: configured for UDMA/100
[    0.455361] scsi 0:0:0:0: Direct-Access     ATA      ST380215A        D    PQ: 0 ANSI: 5
[    0.456111] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    0.456328] sd 0:0:0:0: [sda] Write Protect is off
[    0.456412] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.456446] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.458011] scsi 1:0:0:0: CD-ROM            SONY     CDU5211          YYS2 PQ: 0 ANSI: 5
[    0.525685]  sda: sda1 sda2 < sda5 >
[    0.526475] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.848447] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[    0.848842] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[    0.878226] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    0.878418] VFS: Mounted root (ext4 filesystem) readonly on device 259:524288.
[    0.913961] devtmpfs: mounted
[    0.915028] Freeing unused kernel memory: 340K (c153f000 - c1594000)
[    0.915336] Write protecting the kernel text: 3964k
[    0.915464] Write protecting the kernel read-only data: 1148k
[    1.112060] tsc: Refined TSC clocksource calibration: 1003.898 MHz
[    1.112191] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0xe78796d166, max_idle_ns: 440795251252 ns
[    2.112135] clocksource: Switched to clocksource tsc
[    3.416751] random: udevadm urandom read with 15 bits of entropy available
[    4.195212] intel_rng: FWH not detected
[    4.223948] usbcore: registered new interface driver usbfs
[    4.227603] usbcore: registered new interface driver hub
[    4.227755] usbcore: registered new device driver usb
[    4.298137] snd_intel8x0 0000:00:1f.5: found PCI INT B -> IRQ 5
[    4.298264] snd_intel8x0 0000:00:1f.5: sharing IRQ 5 with 0000:00:1f.3
[    4.315835] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.365284] uhci_hcd: USB Universal Host Controller Interface driver
[    4.372938] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    4.412860] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.413112] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    4.427482] Error: Driver 'pcspkr' is already registered, aborting...
[    4.457630] sr 1:0:0:0: [sr0] scsi3-mmc drive: 52x/52x cd/rw xa/form2 cdda tray
[    4.457797] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.458230] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.620054] snd_intel8x0 0000:00:1f.5: intel8x0_measure_ac97_clock: measured 55696 usecs (2676 samples)
[    4.620225] snd_intel8x0 0000:00:1f.5: clocking to 48000
[    4.622215] i801_smbus 0000:00:1f.3: found PCI INT B -> IRQ 5
[    4.622340] i801_smbus 0000:00:1f.3: sharing IRQ 5 with 0000:00:1f.5
[    4.622466] i801_smbus 0000:00:1f.3: SMBus using polling
[    4.622852] PCI: setting IRQ 9 as level-triggered
[    4.622864] uhci_hcd 0000:00:1f.2: found PCI INT D -> IRQ 9
[    4.623001] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[    4.623097] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
[    4.623285] uhci_hcd 0000:00:1f.2: irq 9, io base 0x0000d000
[    4.623536] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    4.623625] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.623770] usb usb1: Product: UHCI Host Controller
[    4.623851] usb usb1: Manufacturer: Linux 4.3.0-rc3-00042-g3225031 uhci_hcd
[    4.623935] usb usb1: SerialNumber: 0000:00:1f.2
[    4.626341] hub 1-0:1.0: USB hub found
[    4.626452] hub 1-0:1.0: 2 ports detected
[    4.626829] uhci_hcd 0000:00:1f.4: found PCI INT C -> IRQ 9
[    4.626967] uhci_hcd 0000:00:1f.4: UHCI Host Controller
[    4.627057] uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
[    4.627231] uhci_hcd 0000:00:1f.4: irq 9, io base 0x0000d400
[    4.628190] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    4.628289] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.628433] usb usb2: Product: UHCI Host Controller
[    4.628515] usb usb2: Manufacturer: Linux 4.3.0-rc3-00042-g3225031 uhci_hcd
[    4.628599] usb usb2: SerialNumber: 0000:00:1f.4
[    4.631363] hub 2-0:1.0: USB hub found
[    4.631484] hub 2-0:1.0: 2 ports detected
[    7.000714] Adding 1005564k swap on /dev/sda5.  Priority:-1 extents:1 across:1005564k 
[    7.113287] EXT4-fs (sda1): re-mounted. Opts: (null)
[    7.402468] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    8.360798] loop: module loaded
[    8.431688] it87: Found IT8712F chip at 0x290, revision 4
[    8.431965] it87 it87.656: Detected broken BIOS defaults, disabling PWM interface


-- 
Meelis Roos (mroos@linux.ee)
