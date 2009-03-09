From: Ferenc Wagner <wferi@niif.hu>
Subject: 2.6.29-rc7 does not power off on halt
Date: Mon, 09 Mar 2009 19:01:58 +0100
Message-ID: <87vdqishgp.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:59821 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbZCISCE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Mar 2009 14:02:04 -0400
Received: from wferi by tac.ki.iif.hu with local (Exim 4.69)
	(envelope-from <wferi@niif.hu>)
	id 1Lgjna-0005jD-PP
	for linux-acpi@vger.kernel.org; Mon, 09 Mar 2009 19:01:58 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--=-=-=

Hi!

The current git kernel doesn't switch off power as the last step of
system halt (-p) on our Atom systems.  Everything seems to be all
right, just the power remains on.  Is this a known issue perhaps?

Thanks,
Feri.


--=-=-=
Content-Disposition: inline; filename=lspci-n.out
Content-Description: output of lspci -n

00:00.0 Class 0600: 8086:2770 (rev 02)
00:02.0 Class 0300: 8086:2772 (rev 02)
00:1c.0 Class 0604: 8086:27d0 (rev 01)
00:1c.2 Class 0604: 8086:27d4 (rev 01)
00:1c.3 Class 0604: 8086:27d6 (rev 01)
00:1d.0 Class 0c03: 8086:27c8 (rev 01)
00:1d.1 Class 0c03: 8086:27c9 (rev 01)
00:1d.2 Class 0c03: 8086:27ca (rev 01)
00:1d.3 Class 0c03: 8086:27cb (rev 01)
00:1d.7 Class 0c03: 8086:27cc (rev 01)
00:1e.0 Class 0604: 8086:244e (rev e1)
00:1f.0 Class 0601: 8086:27b8 (rev 01)
00:1f.1 Class 0101: 8086:27df (rev 01)
00:1f.2 Class 0101: 8086:27c0 (rev 01)
00:1f.3 Class 0c05: 8086:27da (rev 01)
01:00.0 Class 0200: 10ec:8168 (rev 02)

--=-=-=
Content-Disposition: inline; filename=lspci-v.out
Content-Description: output of lspci -v

00:00.0 Host bridge: Intel Corp.: Unknown device 2770 (rev 02)
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [5109]

00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2772 (rev 02) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at 50200000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 20e0 [size=8]
	Memory at 40000000 (32-bit, prefetchable) [size=256M]
	Memory at 50280000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [d0] Power Management version 2

00:1c.0 PCI bridge: Intel Corp.: Unknown device 27d0 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 50100000-501fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000050000000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.2 PCI bridge: Intel Corp.: Unknown device 27d4 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.3 PCI bridge: Intel Corp.: Unknown device 27d6 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corp.: Unknown device 27c8 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 2080 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 27c9 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 2060 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 27ca (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 2040 [size=32]

00:1d.3 USB Controller: Intel Corp.: Unknown device 27cb (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 2020 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 27cc (rev 01) (prog-if 20 [EHCI])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, medium devsel, latency 0, IRQ 9
	Memory at 502c0000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] #09 [100c]

00:1f.1 IDE interface: Intel Corp.: Unknown device 27df (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 20b0 [size=16]

00:1f.2 IDE interface: Intel Corp.: Unknown device 27c0 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 10
	I/O ports at 20c8 [size=8]
	I/O ports at 20ec [size=4]
	I/O ports at 20c0 [size=8]
	I/O ports at 20e8 [size=4]
	I/O ports at 20a0 [size=16]
	Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corp.: Unknown device 27da (rev 01)
	Subsystem: Intel Corp.: Unknown device 464c
	Flags: medium devsel, IRQ 10
	I/O ports at 2000 [size=32]

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device 8168 (rev 02)
	Subsystem: Unknown device 8680:0100
	Flags: bus master, fast devsel, latency 0, IRQ 11
	I/O ports at 1000 [size=256]
	Memory at 50100000 (64-bit, non-prefetchable) [size=4K]
	Memory at 50000000 (64-bit, prefetchable) [size=64K]
	Expansion ROM at fffe0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] #10 [0201]
	Capabilities: [b0] #11 [0001]
	Capabilities: [d0] Vital Product Data


--=-=-=
Content-Disposition: inline; filename=kernel.log
Content-Description: kernel log

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29-rc7 (wferi@rs22) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 SMP Sat Mar 7 12:53:30 CET 2009
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
[    0.000000]  BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f532000 (usable)
[    0.000000]  BIOS-e820: 000000003f532000 - 000000003f53a000 (reserved)
[    0.000000]  BIOS-e820: 000000003f53a000 - 000000003f5cb000 (usable)
[    0.000000]  BIOS-e820: 000000003f5cb000 - 000000003f5cf000 (reserved)
[    0.000000]  BIOS-e820: 000000003f5cf000 - 000000003f660000 (usable)
[    0.000000]  BIOS-e820: 000000003f660000 - 000000003f6f0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003f6f0000 - 000000003f6f3000 (usable)
[    0.000000]  BIOS-e820: 000000003f6f3000 - 000000003f6ff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003f6ff000 - 000000003f700000 (usable)
[    0.000000]  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0000000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.4 present.
[    0.000000] last_pfn = 0x3f700 max_arch_pfn = 0x1000000
[    0.000000] kernel direct mapping tables up to 379fe000 @ 7000-d000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] RAMDISK: 3f2f0000 - 3f502000
[    0.000000] Allocated new RAMDISK: 00509000 - 0071b000
[    0.000000] Move RAMDISK from 000000003f2f0000 - 000000003f501fff to 00509000 - 0071afff
[    0.000000] ACPI: RSDP 000FE020, 0014 (r0 INTEL )
[    0.000000] ACPI: RSDT 3F6FD038, 0038 (r1 INTEL  D945GLF2       7A       1000013)
[    0.000000] ACPI: FACP 3F6FC000, 0074 (r1 INTEL  D945GLF2       7A MSFT  1000013)
[    0.000000] FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
[    0.000000] ACPI: DSDT 3F6F7000, 45EC (r1 INTEL  D945GLF2       7A MSFT  1000013)
[    0.000000] ACPI: FACS 3F6A3000, 0040
[    0.000000] ACPI: APIC 3F6F6000, 0078 (r1 INTEL  D945GLF2       7A MSFT  1000013)
[    0.000000] ACPI: WDDT 3F6F5000, 0040 (r1 INTEL  D945GLF2       7A MSFT  1000013)
[    0.000000] ACPI: MCFG 3F6F4000, 003C (r1 INTEL  D945GLF2       7A MSFT  1000013)
[    0.000000] ACPI: ASF! 3F6F3000, 00A6 (r32 INTEL  D945GLF2       7A MSFT  1000013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 125MB HIGHMEM available.
[    0.000000] 889MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 379fe000
[    0.000000]   low ram: 00000000 - 379fe000
[    0.000000]   bootmap 00008000 - 0000ef40
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 00379fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 00005014a4]    TEXT DATA BSS ==> [0000100000 - 00005014a4]
[    0.000000]   #4 [0000502000 - 0000509000]    INIT_PG_TABLE ==> [0000502000 - 0000509000]
[    0.000000]   #5 [000009e800 - 0000100000]    BIOS reserved ==> [000009e800 - 0000100000]
[    0.000000]   #6 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
[    0.000000]   #7 [0000509000 - 000071b000]      NEW RAMDISK ==> [0000509000 - 000071b000]
[    0.000000]   #8 [0000008000 - 000000f000]          BOOTMAP ==> [0000008000 - 000000f000]
[    0.000000] found SMP MP-table at [c00fe200] 000fe200
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000379fe
[    0.000000]   HighMem  0x000379fe -> 0x0003f700
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000008f
[    0.000000]     0: 0x00000100 -> 0x0003f532
[    0.000000]     0: 0x0003f53a -> 0x0003f5cb
[    0.000000]     0: 0x0003f5cf -> 0x0003f660
[    0.000000]     0: 0x0003f6f0 -> 0x0003f6f3
[    0.000000]     0: 0x0003f6ff -> 0x0003f700
[    0.000000] On node 0 totalpages: 259559
[    0.000000] free_area_init_node: node 0, pgdat c03e0dc0, node_mem_map c1000000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3951 pages, LIFO batch:0
[    0.000000]   Normal zone: 1748 pages used for memmap
[    0.000000]   Normal zone: 221994 pages, LIFO batch:31
[    0.000000]   HighMem zone: 251 pages used for memmap
[    0.000000]   HighMem zone: 31583 pages, LIFO batch:7
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000008f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:b0000000)
[    0.000000] NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Allocating 40960 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257528
[    0.000000] Kernel command line: initrd=clgr-initrd.img BOOT_IMAGE=vmlinuz-2.6.29-rc7 BOOTIF=01-00-1c-c0-8d-28-ec 
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1596.030 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] ram_console: buffer (null), invalid size 0, datasize -12
[    0.004000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.004000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.004000] Memory: 1022452k/1039360k available (2110k kernel code, 15380k reserved, 1027k data, 336k init, 127336k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xffe18000 - 0xfffff000   (1948 kB)
[    0.004000]     pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
[    0.004000]     vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
[    0.004000]       .init : 0xc0417000 - 0xc046b000   ( 336 kB)
[    0.004000]       .data : 0xc030fad3 - 0xc04108e8   (1027 kB)
[    0.004000]       .text : 0xc0100000 - 0xc030fad3   (2110 kB)
[    0.004000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.004019] Calibrating delay loop (skipped), value calculated using timer frequency.. 3192.06 BogoMIPS (lpj=6384120)
[    0.004194] Security Framework initialized
[    0.004243] SELinux:  Disabled at boot.
[    0.004323] Mount-cache hash table entries: 512
[    0.004614] Initializing cgroup subsys ns
[    0.004663] Initializing cgroup subsys cpuacct
[    0.004709] Initializing cgroup subsys devices
[    0.004753] Initializing cgroup subsys net_cls
[    0.004829] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.004898] CPU: L2 cache: 512K
[    0.004941] [ds] using Core 2/Atom configuration
[    0.004985] CPU: Physical Processor ID: 0
[    0.005028] CPU: Processor Core ID: 0
[    0.005071] Intel machine check architecture supported.
[    0.005118] Intel machine check reporting enabled on CPU#0.
[    0.005163] using mwait in idle threads.
[    0.005218] Checking \'hlt\' instruction... OK.
[    0.023110] ACPI: Core revision 20081204
[    0.032484] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.075495] CPU0: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.076001] Booting processor 1 APIC 0x2 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 3192.37 BogoMIPS (lpj=6384748)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.004000] CPU: L2 cache: 512K
[    0.004000] [ds] using Core 2/Atom configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] Intel machine check architecture supported.
[    0.004000] Intel machine check reporting enabled on CPU#1.
[    0.164386] CPU1: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.164850] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.168262] Booting processor 2 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#2
[    0.004000] Calibrating delay using timer specific routine.. 3192.51 BogoMIPS (lpj=6385021)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.004000] CPU: L2 cache: 512K
[    0.004000] [ds] using Core 2/Atom configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 0
[    0.004000] Intel machine check architecture supported.
[    0.004000] Intel machine check reporting enabled on CPU#2.
[    0.260578] CPU2: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.261818] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.264290] Booting processor 3 APIC 0x3 ip 0x6000
[    0.004000] Initializing CPU#3
[    0.004000] Calibrating delay using timer specific routine.. 3192.37 BogoMIPS (lpj=6384756)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.004000] CPU: L2 cache: 512K
[    0.004000] [ds] using Core 2/Atom configuration
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] Intel machine check architecture supported.
[    0.004000] Intel machine check reporting enabled on CPU#3.
[    0.356375] CPU3: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.356856] checking TSC synchronization [CPU#0 -> CPU#3]:
[    0.360001] Measured 36 cycles TSC warp between CPUs, turning off TSC clock.
[    0.360001] Marking TSC unstable due to check_tsc_sync_source failed
[    0.360066] Brought up 4 CPUs
[    0.360115] Total of 4 processors activated (12769.32 BogoMIPS).
[    0.360216] CPU0 attaching sched-domain:
[    0.360222]  domain 0: span 0,2 level SIBLING
[    0.360227]   groups: 0 2
[    0.360235]   domain 1: span 0-3 level CPU
[    0.360240]    groups: 0,2 1,3
[    0.360249] CPU1 attaching sched-domain:
[    0.360254]  domain 0: span 1,3 level SIBLING
[    0.360258]   groups: 1 3
[    0.360265]   domain 1: span 0-3 level CPU
[    0.360270]    groups: 1,3 0,2
[    0.360278] CPU2 attaching sched-domain:
[    0.360283]  domain 0: span 0,2 level SIBLING
[    0.360287]   groups: 2 0
[    0.360294]   domain 1: span 0-3 level CPU
[    0.360298]    groups: 0,2 1,3
[    0.360307] CPU3 attaching sched-domain:
[    0.360311]  domain 0: span 1,3 level SIBLING
[    0.360316]   groups: 3 1
[    0.360322]   domain 1: span 0-3 level CPU
[    0.360327]    groups: 1,3 0,2
[    0.364001] net_namespace: 1056 bytes
[    0.364069] Booting paravirtualized kernel on bare hardware
[    0.364261] NET: Registered protocol family 16
[    0.364348] ACPI: bus type pci registered
[    0.364348] PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub without MMCONFIG support.
[    0.368882] PCI: Using configuration type 1 for base access
[    0.372150] bio: create slab <bio-0> at 0
[    0.373008] ACPI: EC: Look up EC in DSDT
[    0.379766] ACPI: Interpreter enabled
[    0.379819] ACPI: (supports S0 S1 S3 S4 S5)
[    0.380005] ACPI: Using IOAPIC for interrupt routing
[    0.390338] ACPI: No dock devices found.
[    0.390338] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.390338] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.390338] pci 0000:00:1c.0: PME# disabled
[    0.390338] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.390338] pci 0000:00:1c.2: PME# disabled
[    0.390338] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.390338] pci 0000:00:1c.3: PME# disabled
[    0.390338] pci 0000:00:1d.0: reg 20 io port: [0x2080-0x209f]
[    0.390338] pci 0000:00:1d.1: reg 20 io port: [0x2060-0x207f]
[    0.390338] pci 0000:00:1d.2: reg 20 io port: [0x2040-0x205f]
[    0.390338] pci 0000:00:1d.3: reg 20 io port: [0x2020-0x203f]
[    0.390338] pci 0000:00:1d.7: reg 10 32bit mmio: [0x502c0000-0x502c03ff]
[    0.390338] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.392009] pci 0000:00:1d.7: PME# disabled
[    0.392202] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.392215] pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[    0.392277] pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
[    0.392327] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 007f)
[    0.392436] pci 0000:00:1f.1: reg 10 io port: [0x20d8-0x20df]
[    0.392446] pci 0000:00:1f.1: reg 14 io port: [0x20f4-0x20f7]
[    0.392456] pci 0000:00:1f.1: reg 18 io port: [0x20d0-0x20d7]
[    0.392466] pci 0000:00:1f.1: reg 1c io port: [0x20f0-0x20f3]
[    0.392476] pci 0000:00:1f.1: reg 20 io port: [0x20b0-0x20bf]
[    0.392526] pci 0000:00:1f.2: reg 10 io port: [0x20c8-0x20cf]
[    0.392536] pci 0000:00:1f.2: reg 14 io port: [0x20ec-0x20ef]
[    0.392545] pci 0000:00:1f.2: reg 18 io port: [0x20c0-0x20c7]
[    0.392555] pci 0000:00:1f.2: reg 1c io port: [0x20e8-0x20eb]
[    0.392564] pci 0000:00:1f.2: reg 20 io port: [0x20a0-0x20af]
[    0.392595] pci 0000:00:1f.2: PME# supported from D3hot
[    0.392642] pci 0000:00:1f.2: PME# disabled
[    0.392732] pci 0000:00:1f.3: reg 20 io port: [0x2000-0x201f]
[    0.392813] pci 0000:01:00.0: reg 10 io port: [0x1000-0x10ff]
[    0.392839] pci 0000:01:00.0: reg 18 64bit mmio: [0x50100000-0x50100fff]
[    0.392858] pci 0000:01:00.0: reg 20 64bit mmio: [0x50000000-0x5000ffff]
[    0.392871] pci 0000:01:00.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.392918] pci 0000:01:00.0: supports D1 D2
[    0.392922] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.392973] pci 0000:01:00.0: PME# disabled
[    0.393079] pci 0000:00:1c.0: bridge io port: [0x1000-0x1fff]
[    0.393086] pci 0000:00:1c.0: bridge 32bit mmio: [0x50100000-0x501fffff]
[    0.393096] pci 0000:00:1c.0: bridge 64bit mmio pref: [0x50000000-0x500fffff]
[    0.393253] pci 0000:00:1e.0: transparent bridge
[    0.393324] pci_bus 0000:00: on NUMA node 0
[    0.393336] ACPI: PCI Interrupt Routing Table [\\_SB_.PCI0._PRT]
[    0.393717] ACPI: PCI Interrupt Routing Table [\\_SB_.PCI0.P32_._PRT]
[    0.394115] ACPI: PCI Interrupt Routing Table [\\_SB_.PCI0.PEX0._PRT]
[    0.394254] ACPI: PCI Interrupt Routing Table [\\_SB_.PCI0.PEX2._PRT]
[    0.394389] ACPI: PCI Interrupt Routing Table [\\_SB_.PCI0.PEX3._PRT]
[    0.400419] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[    0.400700] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.401251] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[    0.404021] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
[    0.404523] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.405071] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.405622] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.406177] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
[    0.406558] PCI: Using ACPI for IRQ routing
[    0.420183] hpet clockevent registered
[    0.420190] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.420242] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.420380] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.432015] Switched to high resolution mode on CPU 0
[    0.433019] Switched to high resolution mode on CPU 1
[    0.433093] Switched to high resolution mode on CPU 3
[    0.433976] Switched to high resolution mode on CPU 2
[    0.444030] pnp: PnP ACPI init
[    0.444088] ACPI: bus type pnp registered
[    0.450940] pnp: PnP ACPI: found 12 devices
[    0.450989] ACPI: ACPI bus type pnp unregistered
[    0.451035] PnPBIOS: Disabled by ACPI PNP
[    0.451096] system 00:01: iomem range 0xf0000000-0xf3ffffff has been reserved
[    0.451147] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.451195] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.451245] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.451295] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.451345] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.451394] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.451443] system 00:01: iomem range 0xfed45000-0xfed99fff has been reserved
[    0.451493] system 00:01: iomem range 0xc0000-0xdffff could not be reserved
[    0.451541] system 00:01: iomem range 0xe0000-0xfffff could not be reserved
[    0.451601] system 00:06: ioport range 0x500-0x53f has been reserved
[    0.451649] system 00:06: ioport range 0x400-0x47f has been reserved
[    0.451696] system 00:06: ioport range 0x680-0x6ff has been reserved
[    0.487348] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    0.487399] pci 0000:00:1c.0:   IO window: 0x1000-0x1fff
[    0.487449] pci 0000:00:1c.0:   MEM window: 0x50100000-0x501fffff
[    0.487498] pci 0000:00:1c.0:   PREFETCH window: 0x00000050000000-0x000000500fffff
[    0.487563] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:02
[    0.487607] pci 0000:00:1c.2:   IO window: disabled
[    0.487654] pci 0000:00:1c.2:   MEM window: disabled
[    0.487700] pci 0000:00:1c.2:   PREFETCH window: disabled
[    0.487750] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:03
[    0.487794] pci 0000:00:1c.3:   IO window: disabled
[    0.487842] pci 0000:00:1c.3:   MEM window: disabled
[    0.487887] pci 0000:00:1c.3:   PREFETCH window: disabled
[    0.487937] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
[    0.487981] pci 0000:00:1e.0:   IO window: disabled
[    0.488042] pci 0000:00:1e.0:   MEM window: disabled
[    0.488087] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.488155] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.488207] pci 0000:00:1c.0: setting latency timer to 64
[    0.488222] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.488272] pci 0000:00:1c.2: setting latency timer to 64
[    0.488286] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.488335] pci 0000:00:1c.3: setting latency timer to 64
[    0.488346] pci 0000:00:1e.0: setting latency timer to 64
[    0.488353] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.488359] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.488366] pci_bus 0000:01: resource 0 io:  [0x1000-0x1fff]
[    0.488371] pci_bus 0000:01: resource 1 mem: [0x50100000-0x501fffff]
[    0.488377] pci_bus 0000:01: resource 2 mem: [0x50000000-0x500fffff]
[    0.488382] pci_bus 0000:01: resource 3 mem: [0x0-0x0]
[    0.488387] pci_bus 0000:02: resource 0 mem: [0x0-0x0]
[    0.488392] pci_bus 0000:02: resource 1 mem: [0x0-0x0]
[    0.488396] pci_bus 0000:02: resource 2 mem: [0x0-0x0]
[    0.488401] pci_bus 0000:02: resource 3 mem: [0x0-0x0]
[    0.488406] pci_bus 0000:03: resource 0 mem: [0x0-0x0]
[    0.488410] pci_bus 0000:03: resource 1 mem: [0x0-0x0]
[    0.488415] pci_bus 0000:03: resource 2 mem: [0x0-0x0]
[    0.488419] pci_bus 0000:03: resource 3 mem: [0x0-0x0]
[    0.488424] pci_bus 0000:04: resource 0 mem: [0x0-0x0]
[    0.488429] pci_bus 0000:04: resource 1 mem: [0x0-0x0]
[    0.488433] pci_bus 0000:04: resource 2 mem: [0x0-0x0]
[    0.488438] pci_bus 0000:04: resource 3 io:  [0x00-0xffff]
[    0.488443] pci_bus 0000:04: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.488584] NET: Registered protocol family 2
[    0.536136] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.536511] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.537551] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.538083] TCP: Hash tables configured (established 131072 bind 65536)
[    0.538135] TCP reno registered
[    0.556220] NET: Registered protocol family 1
[    0.556460] checking if image is initramfs...it isn\'t (bad gzip magic numbers); looks like an initrd
[    0.562339] Freeing initrd memory: 2120k freed
[    0.565442] audit: initializing netlink socket (disabled)
[    0.565523] type=2000 audit(1236612887.564:1): initialized
[    0.566007] highmem bounce pool size: 64 pages
[    0.566058] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.566484] VFS: Disk quotas dquot_6.5.2
[    0.566564] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.566671] Created ptmx node in devpts ino 2
[    0.566749] msgmni has been set to 1753
[    0.567037] alg: No test for stdrng (krng)
[    0.567261] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    0.567325] io scheduler noop registered
[    0.567367] io scheduler anticipatory registered
[    0.567410] io scheduler deadline registered
[    0.567505] io scheduler cfq registered (default)
[    0.567568] pci 0000:00:02.0: Boot video device
[    0.568045] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.568113] pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
[    0.568382] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    0.568445] pcieport-driver 0000:00:1c.2: irq 25 for MSI/MSI-X
[    0.568705] pcieport-driver 0000:00:1c.3: setting latency timer to 64
[    0.568767] pcieport-driver 0000:00:1c.3: irq 26 for MSI/MSI-X
[    0.569659] isapnp: Scanning for PnP cards...
[    0.922783] isapnp: No Plug & Play device found
[    0.930341] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.930579] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.931558] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.935574] brd: module loaded
[    0.935848] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    0.938913] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.938967] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.939341] mice: PS/2 mouse device common for all mice
[    0.939488] cpuidle: using governor ladder
[    0.939538] cpuidle: using governor menu
[    0.939586] No iBFT detected.
[    0.939932] TCP cubic registered
[    0.939977] NET: Registered protocol family 17
[    0.940052] Using IPI No-Shortcut mode
[    0.940431] registered taskstats version 1
[    0.963992] input: AT Translated Set 2 keyboard as /class/input/input0
[    1.044079] RAMDISK: cramfs filesystem found at block 0
[    1.044133] RAMDISK: Loading 2120KiB [1 disk] into ram disk... |/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|/-\\|done.
[    1.066408] VFS: Mounted root (cramfs filesystem) readonly on device 1:0.
[    1.131044] Freeing unused kernel memory: 336k freed
[    1.310364] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.310446] r8169 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.310513] r8169 0000:01:00.0: setting latency timer to 64
[    1.310678] r8169 0000:01:00.0: irq 27 for MSI/MSI-X
[    1.311031] r8169 0000:01:00.0: MAC address found in EEPROM: 00:1c:c0:8d:28:ec
[    1.311335] eth0: RTL8168c/8111c at 0xf8252000, 00:1c:c0:8d:28:ec, XID 3c4000c0 IRQ 27
[    1.453460] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[    1.453531] All bugs added by David S. Miller <davem@redhat.com>
[    1.509222] RPC: Registered udp transport module.
[    1.509275] RPC: Registered tcp transport module.
[    1.652048] usbcore: registered new interface driver usbfs
[    1.652335] usbcore: registered new interface driver hub
[    1.652547] usbcore: registered new device driver usb
[    1.658271] uhci_hcd: USB Universal Host Controller Interface driver
[    1.658422] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.658481] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.658488] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.658678] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    1.658786] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002080
[    1.658908] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    1.658957] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.659776] usb usb1: Product: UHCI Host Controller
[    1.659820] usb usb1: Manufacturer: Linux 2.6.29-rc7 uhci_hcd
[    1.659864] usb usb1: SerialNumber: 0000:00:1d.0
[    1.660135] usb usb1: configuration #1 chosen from 1 choice
[    1.660302] hub 1-0:1.0: USB hub found
[    1.660359] hub 1-0:1.0: 2 ports detected
[    1.660875] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.660932] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.660938] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.661101] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    1.661201] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002060
[    1.661316] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.661364] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.661423] usb usb2: Product: UHCI Host Controller
[    1.661467] usb usb2: Manufacturer: Linux 2.6.29-rc7 uhci_hcd
[    1.661516] usb usb2: SerialNumber: 0000:00:1d.1
[    1.661724] usb usb2: configuration #1 chosen from 1 choice
[    1.661893] hub 2-0:1.0: USB hub found
[    1.661946] hub 2-0:1.0: 2 ports detected
[    1.662364] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.662418] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.662424] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.662574] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    1.662670] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002040
[    1.662781] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.662830] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.662889] usb usb3: Product: UHCI Host Controller
[    1.662933] usb usb3: Manufacturer: Linux 2.6.29-rc7 uhci_hcd
[    1.662978] usb usb3: SerialNumber: 0000:00:1d.2
[    1.663192] usb usb3: configuration #1 chosen from 1 choice
[    1.663361] hub 3-0:1.0: USB hub found
[    1.663415] hub 3-0:1.0: 2 ports detected
[    1.663826] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
[    1.663880] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    1.663886] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    1.664041] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    1.664137] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00002020
[    1.664258] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.664307] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.664365] usb usb4: Product: UHCI Host Controller
[    1.664408] usb usb4: Manufacturer: Linux 2.6.29-rc7 uhci_hcd
[    1.664454] usb usb4: SerialNumber: 0000:00:1d.3
[    1.664706] usb usb4: configuration #1 chosen from 1 choice
[    1.664896] hub 4-0:1.0: USB hub found
[    1.664951] hub 4-0:1.0: 2 ports detected
[    1.691779] ehci_hcd: USB 2.0 \'Enhanced\' Host Controller (EHCI) Driver
[    1.691834] Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[    1.691943] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.692175] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.692184] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.692363] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    1.696327] ehci_hcd 0000:00:1d.7: debug port 1
[    1.696376] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    1.696395] ehci_hcd 0000:00:1d.7: irq 23, io mem 0x502c0000
[    1.709020] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.709102] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    1.709152] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.709211] usb usb5: Product: EHCI Host Controller
[    1.709254] usb usb5: Manufacturer: Linux 2.6.29-rc7 ehci_hcd
[    1.709299] usb usb5: SerialNumber: 0000:00:1d.7
[    1.709589] usb usb5: configuration #1 chosen from 1 choice
[    1.709774] hub 5-0:1.0: USB hub found
[    1.709830] hub 5-0:1.0: 8 ports detected
[    1.785019] usbcore: registered new interface driver hiddev
[    1.792573] usbcore: registered new interface driver usbhid
[    1.792623] usbhid: v2.6:USB HID core driver
[    1.861802] Uniform Multi-Platform E-IDE driver
[    1.863836] ide_generic: please use \"probe_mask=0x3f\" module parameter for probing all legacy ISA IDE ports
[    2.016723] ide-gd driver 1.18
[    2.064264] input: Power Button (FF) as /class/input/input1
[    2.077030] ACPI: Power Button (FF) [PWRF]
[    2.077300] input: Sleep Button (CM) as /class/input/input2
[    2.089033] ACPI: Sleep Button (CM) [SLPB]
[    2.242706] r8169: eth0: link down
[    2.242776] r8169: eth0: link down
[    2.886624] r8169: eth0: link up

--=-=-=--
