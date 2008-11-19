From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: ACPI Warning (nspredef-0858): \_SB_.BAT0._BIF: Return Package type
 mismatch at index 9
Date: Wed, 19 Nov 2008 23:32:29 +0100
Message-ID: <492493FD.7020501@freemail.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010602080600060102030206"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail01a.mail.t-online.hu ([84.2.40.6]:63929 "EHLO
	mail01a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbYKSWnq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Nov 2008 17:43:46 -0500
Received: from [192.168.1.65] (dsl51B6C478.pool.t-online.hu [81.182.196.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail01a.mail.t-online.hu (Postfix) with ESMTPSA id 3DF0C43F162
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2008 23:32:29 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010602080600060102030206
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

Hi,

I am running Linux kernel 2.6.28-rc5. I get the following warning message
during boot in dmesg:

[   21.425678] ACPI Warning (nspredef-0858): \_SB_.BAT0._BIF: Return Package type mismatch at index 9 - found Buffer, expected String [20080926]

What does it mean? Is it a serious problem?

The laptop is a Clevo D410J. The dmesg attached.

Regards,

	Márton Németh


--------------010602080600060102030206
Content-Type: text/plain;
 name="dmesg-2.6.28-rc5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.28-rc5.txt"

[    0.000000] BIOS EBDA/lowmem at: 0009f800/0009f800
[    0.000000] Linux version 2.6.28-rc5 (nmarci@europa) (gcc version 4.3.2 (Debian 4.3.2-1) ) #1 PREEMPT Wed Nov 19 21:24:54 CET 2008
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
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003bf70000 (usable)
[    0.000000]  BIOS-e820: 000000003bf70000 - 000000003bf7a000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003bf7a000 - 000000003bf80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003bf80000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
[    0.000000] DMI present.
[    0.000000] last_pfn = 0x3bf70 max_arch_pfn = 0x100000
[    0.000000] kernel direct mapping tables up to 377fe000 @ 7000-d000
[    0.000000] ACPI: RSDP 000F68D0, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT 3BF7600B, 0030 (r1 PTLTD    RSDT    6040000  LTP        0)
[    0.000000] ACPI: FACP 3BF79E87, 0074 (r1 AMDK8  PTLTW     6040000 PTL_    F4240)
[    0.000000] ACPI: DSDT 3BF7603B, 3E4C (r1  VIA   PTL_ACPI  6040000 MSFT  100000E)
[    0.000000] ACPI: FACS 3BF7AFC0, 0040
[    0.000000] ACPI: SSDT 3BF79EFB, 00B5 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: APIC 3BF79FB0, 0050 (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 71MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 00000000 - 377fe000
[    0.000000]   bootmap 00009000 - 0000ff00
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 00377fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000100000 - 00008b8350]    TEXT DATA BSS ==> [0000100000 - 00008b8350]
[    0.000000]   #2 [00008b9000 - 00008bd000]    INIT_PG_TABLE ==> [00008b9000 - 00008bd000]
[    0.000000]   #3 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
[    0.000000]   #4 [0000007000 - 0000009000]          PGTABLE ==> [0000007000 - 0000009000]
[    0.000000]   #5 [0000009000 - 0000010000]          BOOTMAP ==> [0000009000 - 0000010000]
[    0.000000] found SMP MP-table at [c00f6870] 000f6870
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x0003bf70
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0003bf70
[    0.000000] On node 0 totalpages: 245519
[    0.000000] free_area_init_node: node 0, pgdat c042a280, node_mem_map c1000000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3967 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 143 pages used for memmap
[    0.000000]   HighMem zone: 18147 pages, LIFO batch:3
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000d8000
[    0.000000] PM: Registered nosave memory: 00000000000d8000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bffe0000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 243600
[    0.000000] Kernel command line: root=/dev/hda3 ro acpi.debug_layer=0x00090004 acpi.debug_level=0x01f resume=/dev/hda2 log_buf_len=128M
[    0.000000] log_buf_len: 134217728
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1603.357 MHz processor.
[    0.000999] Console: colour VGA+ 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000999] ... MAX_LOCKDEP_SUBCLASSES:    8
[    0.000999] ... MAX_LOCK_DEPTH:          48
[    0.000999] ... MAX_LOCKDEP_KEYS:        8191
[    0.000999] ... CLASSHASH_SIZE:           4096
[    0.000999] ... MAX_LOCKDEP_ENTRIES:     8192
[    0.000999] ... MAX_LOCKDEP_CHAINS:      16384
[    0.000999] ... CHAINHASH_SIZE:          8192
[    0.000999]  memory used by lock dependency info: 2335 kB
[    0.000999]  per task-struct memory footprint: 1152 bytes
[    0.000999] ------------------------
[    0.000999] | Locking API testsuite:
[    0.000999] ----------------------------------------------------------------------------
[    0.000999]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.000999]   --------------------------------------------------------------------------
[    0.000999]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]   --------------------------------------------------------------------------
[    0.000999]               recursive read-lock:             |  ok  |             |  ok  |
[    0.000999]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.000999]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.000999]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.000999]   --------------------------------------------------------------------------
[    0.000999]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.000999]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.000999]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.000999]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.000999]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.000999]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.000999]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.000999]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.000999]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.000999]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq read-recursion/123:  ok  |
[    0.000999]       soft-irq read-recursion/123:  ok  |
[    0.000999]       hard-irq read-recursion/132:  ok  |
[    0.000999]       soft-irq read-recursion/132:  ok  |
[    0.000999]       hard-irq read-recursion/213:  ok  |
[    0.000999]       soft-irq read-recursion/213:  ok  |
[    0.000999]       hard-irq read-recursion/231:  ok  |
[    0.000999]       soft-irq read-recursion/231:  ok  |
[    0.000999]       hard-irq read-recursion/312:  ok  |
[    0.000999]       soft-irq read-recursion/312:  ok  |
[    0.000999]       hard-irq read-recursion/321:  ok  |
[    0.000999]       soft-irq read-recursion/321:  ok  |
[    0.000999] -------------------------------------------------------
[    0.000999] Good, all 218 testcases passed! |
[    0.000999] ---------------------------------
[    0.000999] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000999] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000999] Memory: 834284k/982464k available (2289k kernel code, 147536k reserved, 987k data, 328k init, 73160k highmem)
[    0.000999] virtual kernel memory layout:
[    0.000999]     fixmap  : 0xfffac000 - 0xfffff000   ( 332 kB)
[    0.000999]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000999]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000999]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000999]       .init : 0xc0436000 - 0xc0488000   ( 328 kB)
[    0.000999]       .data : 0xc033c771 - 0xc0433498   ( 987 kB)
[    0.000999]       .text : 0xc0100000 - 0xc033c771   (2289 kB)
[    0.000999] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.001031] Calibrating delay loop (skipped), value calculated using timer frequency.. 3206.71 BogoMIPS (lpj=1603357)
[    0.001291] Mount-cache hash table entries: 512
[    0.002263] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.002324] CPU: L2 Cache: 128K (64 bytes/line)
[    0.002380] Intel machine check architecture supported.
[    0.002437] Intel machine check reporting enabled on CPU#0.
[    0.002504] CPU: Mobile AMD Sempron(tm) Processor 2600+ stepping 00
[    0.002653] Checking 'hlt' instruction... OK.
[    0.006472] Freeing SMP alternatives: 0k freed
[    0.006528] ACPI: Core revision 20080926
[    0.018856] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.029011] net_namespace: 800 bytes
[    0.029549] NET: Registered protocol family 16
[    0.031124] EISA bus registered
[    0.031229] ACPI: bus type pci registered
[    0.038928] PCI: PCI BIOS revision 2.10 entry at 0xfd88c, last bus=1
[    0.038998] PCI: Using configuration type 1 for base access
[    0.046983] ACPI: EC: Look up EC in DSDT
[    0.056783] ACPI: Interpreter enabled
[    0.056848] ACPI: (supports S0 S3 S4 S5)
[    0.057097] ACPI: Using IOAPIC for interrupt routing
[    0.072739] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.571980] ACPI: EC: missing confirmations, switch off interrupt mode.
[    0.577013] ACPI: EC: GPE = 0xb, I/O: command/status = 0x66, data = 0x62
[    0.577077] ACPI: EC: driver started in poll mode
[    0.577372] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.577805] pci 0000:00:00.0: reg 10 32bit mmio: [0xe0000000-0xefffffff]
[    0.578231] pci 0000:00:01.0: supports D1
[    0.578284] pci 0000:00:08.0: reg 10 io port: [0x1000-0x10ff]
[    0.578292] pci 0000:00:08.0: reg 14 32bit mmio: [0xd0004000-0xd00040ff]
[    0.578329] pci 0000:00:08.0: supports D1 D2
[    0.578332] pci 0000:00:08.0: PME# supported from D1 D2 D3hot D3cold
[    0.578396] pci 0000:00:08.0: PME# disabled
[    0.578497] pci 0000:00:0c.0: reg 10 32bit mmio: [0x000000-0x000fff]
[    0.578509] pci 0000:00:0c.0: supports D1 D2
[    0.578512] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.578572] pci 0000:00:0c.0: PME# disabled
[    0.578678] pci 0000:00:0e.0: reg 10 32bit mmio: [0xd0001000-0xd0001fff]
[    0.578686] pci 0000:00:0e.0: reg 14 32bit mmio: [0xd0000000-0xd0000fff]
[    0.578722] pci 0000:00:0e.0: supports D1 D2
[    0.578725] pci 0000:00:0e.0: PME# supported from D1 D2 D3hot D3cold
[    0.578785] pci 0000:00:0e.0: PME# disabled
[    0.578881] pci 0000:00:0e.1: reg 10 32bit mmio: [0xd0003000-0xd0003fff]
[    0.578889] pci 0000:00:0e.1: reg 14 32bit mmio: [0xd0002000-0xd0002fff]
[    0.578925] pci 0000:00:0e.1: supports D1 D2
[    0.578928] pci 0000:00:0e.1: PME# supported from D1 D2 D3hot D3cold
[    0.578957] pci 0000:00:0e.1: PME# disabled
[    0.579083] pci 0000:00:10.0: reg 20 io port: [0x1c00-0x1c1f]
[    0.579104] pci 0000:00:10.0: supports D1 D2
[    0.579107] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.579167] pci 0000:00:10.0: PME# disabled
[    0.579291] pci 0000:00:10.1: reg 20 io port: [0x1c20-0x1c3f]
[    0.579313] pci 0000:00:10.1: supports D1 D2
[    0.579315] pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.579375] pci 0000:00:10.1: PME# disabled
[    0.579491] pci 0000:00:10.2: reg 20 io port: [0x1c40-0x1c5f]
[    0.579512] pci 0000:00:10.2: supports D1 D2
[    0.579515] pci 0000:00:10.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.579575] pci 0000:00:10.2: PME# disabled
[    0.579671] pci 0000:00:10.3: reg 10 32bit mmio: [0xd0004400-0xd00044ff]
[    0.579713] pci 0000:00:10.3: supports D1 D2
[    0.579715] pci 0000:00:10.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.579776] pci 0000:00:10.3: PME# disabled
[    0.579969] HPET not enabled in BIOS. You might try hpet=force boot option
[    0.580032] pci 0000:00:11.0: quirk: region 4000-407f claimed by vt8235 PM
[    0.580092] pci 0000:00:11.0: quirk: region 8100-810f claimed by vt8235 SMB
[    0.580220] pci 0000:00:11.1: reg 20 io port: [0x1c60-0x1c6f]
[    0.580291] pci 0000:00:11.5: reg 10 io port: [0x1400-0x14ff]
[    0.580334] pci 0000:00:11.5: supports D1 D2
[    0.580388] pci 0000:00:11.6: reg 10 io port: [0x1800-0x18ff]
[    0.580670] pci 0000:01:00.0: reg 10 32bit mmio: [0xf0000000-0xf3ffffff]
[    0.580677] pci 0000:01:00.0: reg 14 32bit mmio: [0xd1000000-0xd1ffffff]
[    0.580698] pci 0000:01:00.0: reg 30 32bit mmio: [0x000000-0x00ffff]
[    0.580707] pci 0000:01:00.0: supports D1 D2
[    0.580749] pci 0000:00:01.0: bridge 32bit mmio: [0xd1000000-0xd1ffffff]
[    0.580755] pci 0000:00:01.0: bridge 32bit mmio pref: [0xf0000000-0xf3ffffff]
[    0.580789] bus 00 -> node 0
[    0.580811] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.605535] ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *9, disabled.
[    0.606280] ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *11, disabled.
[    0.607040] ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *10, disabled.
[    0.607469] ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *5, disabled.
[    0.607996] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 12 14 15)
[    0.608696] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 12 14 15) *11
[    0.609409] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 11 12 14 15) *10
[    0.610173] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[    0.612493] PCI: Using ACPI for IRQ routing
[    0.613268] pnp: PnP ACPI init
[    0.613268] ACPI: bus type pnp registered
[    0.623728] pnp: PnP ACPI: found 11 devices
[    0.623790] ACPI: ACPI bus type pnp unregistered
[    0.623880] system 00:05: iomem range 0x0-0x9ffff could not be reserved
[    0.623941] system 00:05: iomem range 0xe0000-0xfffff could not be reserved
[    0.624054] system 00:05: iomem range 0xfff00000-0xffffffff could not be reserved
[    0.624125] system 00:05: iomem range 0xffee0000-0xffefffff has been reserved
[    0.624185] system 00:05: iomem range 0xfec00000-0xfec00fff has been reserved
[    0.624245] system 00:05: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.624321] system 00:06: ioport range 0x4d0-0x4d1 has been reserved
[    0.624380] system 00:06: ioport range 0xfe10-0xfe11 has been reserved
[    0.624439] system 00:06: ioport range 0xfe00-0xfe00 has been reserved
[    0.624499] system 00:06: ioport range 0x4000-0x407f has been reserved
[    0.624558] system 00:06: ioport range 0x8100-0x811f could not be reserved
[    0.661608] pci 0000:01:00.0: BAR 6: can't allocate mem resource [0xf4000000-0xf3ffffff]
[    0.661684] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.661741] pci 0000:00:01.0:   IO window: disabled
[    0.661800] pci 0000:00:01.0:   MEM window: 0xd1000000-0xd1ffffff
[    0.661859] pci 0000:00:01.0:   PREFETCH window: 0x000000f0000000-0x000000f3ffffff
[    0.661933] pci 0000:00:0c.0: CardBus bridge, secondary bus 0000:02
[    0.661997] pci 0000:00:0c.0:   IO window: 0x002000-0x0020ff
[    0.662056] pci 0000:00:0c.0:   IO window: 0x002400-0x0024ff
[    0.662115] pci 0000:00:0c.0:   PREFETCH window: 0x50000000-0x53ffffff
[    0.662175] pci 0000:00:0c.0:   MEM window: 0x54000000-0x57ffffff
[    0.662250] pci 0000:00:01.0: setting latency timer to 64
[    0.662259] pci 0000:00:0c.0: enabling device (0000 -> 0003)
[    0.662329] pci 0000:00:0c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.662394] pci 0000:00:0c.0: setting latency timer to 64
[    0.662399] bus: 00 index 0 io port: [0x00-0xffff]
[    0.662454] bus: 00 index 1 mmio: [0x000000-0xffffffff]
[    0.662510] bus: 01 index 0 mmio: [0x0-0x0]
[    0.662565] bus: 01 index 1 mmio: [0xd1000000-0xd1ffffff]
[    0.662621] bus: 01 index 2 mmio: [0xf0000000-0xf3ffffff]
[    0.662677] bus: 01 index 3 mmio: [0x0-0x0]
[    0.662732] bus: 02 index 0 io port: [0x2000-0x20ff]
[    0.662787] bus: 02 index 1 io port: [0x2400-0x24ff]
[    0.662842] bus: 02 index 2 mmio: [0x50000000-0x53ffffff]
[    0.662898] bus: 02 index 3 mmio: [0x54000000-0x57ffffff]
[    0.663025] NET: Registered protocol family 2
[    0.663460] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.664144] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.665425] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[    0.671420] TCP: Hash tables configured (established 131072 bind 65536)
[    0.671523] TCP reno registered
[    0.671793] NET: Registered protocol family 1
[    0.675201] audit: initializing netlink socket (disabled)
[    0.675328] type=2000 audit(1227136378.674:1): initialized
[    0.677994] highmem bounce pool size: 64 pages
[    0.678758] msgmni has been set to 1487
[    0.679364] io scheduler noop registered
[    0.679449] io scheduler cfq registered (default)
[    0.679538] PCI: VIA PCI bridge detected.Disabling DAC.
[    0.679722] pci 0000:01:00.0: Boot video device
[    0.686699] isapnp: Scanning for PnP cards...
[    1.043334] isapnp: No Plug & Play device found
[    1.161997] Switched to high resolution mode on CPU 0
[    1.198823] Uniform Multi-Platform E-IDE driver
[    1.199319] via82cxxx 0000:00:11.1: VIA vt8235 (rev 00) IDE UDMA133
[    1.199381] via82cxxx 0000:00:11.1: IDE controller (0x1106:0x0571 rev 0x06)
[    1.199561] pci 0000:00:11.1: power state changed by ACPI to D0
[    1.199764] ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
[    1.199940] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 23
[    1.200000] ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 23
[    1.200144] pci 0000:00:11.1: PCI INT A -> Link[ALKA] -> GSI 23 (level, low) -> IRQ 23
[    1.200335] via82cxxx 0000:00:11.1: not 100% native mode: will probe irqs later
[    1.200408]     ide0: BM-DMA at 0x1c60-0x1c67
[    1.200472]     ide1: BM-DMA at 0x1c68-0x1c6f
[    1.200529] Probing IDE interface ide0...
[    1.586112] hda: SAMSUNG MP0804H, ATA DISK drive
[    2.198344] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.198413] hda: UDMA/100 mode selected
[    2.198529] Probing IDE interface ide1...
[    2.992111] hdc: Optiarc DVD RW AD-7543A, ATAPI CD/DVD-ROM drive
[    3.604235] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    3.604348] hdc: UDMA/33 mode selected
[    3.604695] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    3.701857] ide1 at 0x170-0x177,0x376 on irq 15
[    3.703922] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
[    3.704427] ide-gd driver 1.18
[    3.704587] hda: max request size: 512KiB
[    3.704786] hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63
[    3.705348] hda: cache flushes supported
[    3.705712]  hda: hda1 hda2 hda3
[    3.708741] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    3.711783] i8042.c: Detected active multiplexing controller, rev 1.1.
[    3.713159] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.713247] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    3.713305] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    3.713363] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    3.713421] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    3.714426] cpuidle: using governor ladder
[    3.714486] cpuidle: using governor menu
[    3.714855] TCP cubic registered
[    3.714913] NET: Registered protocol family 17
[    3.715033] Using IPI Shortcut mode
[    3.737905] input: AT Translated Set 2 keyboard as /class/input/input0
[    3.954141] ReiserFS: hda3: found reiserfs format "3.6" with standard journal
[    3.954265] ReiserFS: hda3: using ordered data mode
[    3.963274] ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[    3.965618] ReiserFS: hda3: checking transaction log (hda3)
[    4.044467] ReiserFS: hda3: Using r5 hash to sort names
[    4.044653] VFS: Mounted root (reiserfs filesystem) readonly.
[    4.045169] Freeing unused kernel memory: 328k freed
[    4.045394] Write protecting the kernel text: 2292k
[    4.045519] Write protecting the kernel read-only data: 800k
[   21.311731] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   21.312201] processor ACPI_CPU:00: registered as cooling_device0
[   21.328615] input: Power Button (FF) as /class/input/input1
[   21.335250] ACPI: Power Button (FF) [PWRF]
[   21.335535] input: Power Button (CM) as /class/input/input2
[   21.342201] ACPI: Power Button (CM) [PWB]
[   21.342441] input: Sleep Button (CM) as /class/input/input3
[   21.349249] ACPI: Sleep Button (CM) [SLPB]
[   21.349513] input: Lid Switch as /class/input/input4
[   21.354149] ACPI: Lid Switch [LID]
[   21.385359] ACPI: AC Adapter [AC] (on-line)
[   21.425678] ACPI Warning (nspredef-0858): \_SB_.BAT0._BIF: Return Package type mismatch at index 9 - found Buffer, expected String [20080926]
[   21.432415] ACPI: Battery Slot [BAT0] (battery present)
[   21.449375] ACPI: Invalid active0 threshold
[   21.449917] thermal LNXTHERM:01: registered as thermal_zone0
[   21.453303] ACPI: Thermal Zone [THRM] (50 C)
[   21.740395] Serial: 8250/16550 driver4 ports, IRQ sharing disabled
[   21.740797] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   21.762348] parport_pc 00:0a: reported by Plug and Play ACPI
[   21.762597] parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   21.989980] input: Video Bus as /class/input/input5
[   21.998245] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   22.030551] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   22.143744] 8139too Fast Ethernet driver 0.9.28
[   22.143882] 8139too 0000:00:08.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   22.144833] eth0: RealTek RTL8139 at 0xf84a6000, 00:90:f5:3e:5a:ca, IRQ 19
[   22.144894] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[   22.305250] usbcore: registered new interface driver usbfs
[   22.305471] usbcore: registered new interface driver hub
[   22.305665] usbcore: registered new device driver usb
[   22.368427] yenta_cardbus 0000:00:0c.0: CardBus bridge found [1558:4702]
[   22.368513] yenta_cardbus 0000:00:0c.0: Using CSCINT to route CSC interrupts to PCI
[   22.368582] yenta_cardbus 0000:00:0c.0: Routing CardBus interrupts to PCI
[   22.368644] yenta_cardbus 0000:00:0c.0: TI: mfunc 0x00001002, devctl 0x44
[   22.591762] yenta_cardbus 0000:00:0c.0: ISA IRQ mask 0x0820, PCI irq 16
[   22.591827] yenta_cardbus 0000:00:0c.0: Socket status: 30000006
[   22.703826] input: PC Speaker as /class/input/input6
[   22.749961] uhci_hcd: USB Universal Host Controller Interface driver
[   22.750303] ACPI: PCI Interrupt Link [ALKD] disabled and referenced, BIOS bug
[   22.750482] ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 21
[   22.750542] ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 21
[   22.750609] uhci_hcd 0000:00:10.0: PCI INT A -> Link[ALKD] -> GSI 21 (level, low) -> IRQ 21
[   22.750699] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   22.754230] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   22.754370] uhci_hcd 0000:00:10.0: irq 21, io base 0x00001c00
[   22.755166] usb usb1: configuration #1 chosen from 1 choice
[   22.755676] hub 1-0:1.0: USB hub found
[   22.755903] hub 1-0:1.0: 2 ports detected
[   22.757575] uhci_hcd 0000:00:10.1: PCI INT B -> Link[ALKD] -> GSI 21 (level, low) -> IRQ 21
[   22.757666] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   22.757824] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   22.757933] uhci_hcd 0000:00:10.1: irq 21, io base 0x00001c20
[   22.758395] usb usb2: configuration #1 chosen from 1 choice
[   22.758573] hub 2-0:1.0: USB hub found
[   22.758650] hub 2-0:1.0: 2 ports detected
[   22.759272] uhci_hcd 0000:00:10.2: PCI INT C -> Link[ALKD] -> GSI 21 (level, low) -> IRQ 21
[   22.759364] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   22.759523] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   22.759633] uhci_hcd 0000:00:10.2: irq 21, io base 0x00001c40
[   22.760090] usb usb3: configuration #1 chosen from 1 choice
[   22.760256] hub 3-0:1.0: USB hub found
[   22.760333] hub 3-0:1.0: 2 ports detected
[   22.791317] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   22.791382] Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[   22.791522] ehci_hcd 0000:00:10.3: PCI INT D -> Link[ALKD] -> GSI 21 (level, low) -> IRQ 21
[   22.791731] ehci_hcd 0000:00:10.3: EHCI Host Controller
[   22.791912] ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   22.792101] ehci_hcd 0000:00:10.3: irq 21, io mem 0xd0004400
[   22.798204] ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00
[   22.798748] usb usb4: configuration #1 chosen from 1 choice
[   22.798928] hub 4-0:1.0: USB hub found
[   22.799107] hub 4-0:1.0: 6 ports detected
[   22.867407] ide-cd driver 5.00
[   22.876822] ide-cd: hdc: ATAPI 24X DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache
[   22.877156] Uniform CD-ROM driver Revision: 3.20
[   23.184071] Marking TSC unstable due to TSC halts in idle
[   23.423079] usb 1-2: new low speed USB device using uhci_hcd and address 2
[   23.492633] input: PS/2 Generic Mouse as /class/input/input7
[   23.676741] usb 1-2: configuration #1 chosen from 1 choice
[   23.689561] VIA 82xx Modem 0000:00:11.6: power state changed by ACPI to D0
[   23.689761] ACPI: PCI Interrupt Link [ALKC] disabled and referenced, BIOS bug
[   23.689934] ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
[   23.689994] ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
[   23.691573] VIA 82xx Modem 0000:00:11.6: PCI INT C -> Link[ALKC] -> GSI 22 (level, low) -> IRQ 22
[   23.692052] VIA 82xx Modem 0000:00:11.6: setting latency timer to 64
[   23.724834] mice: PS/2 mouse device common for all mice
[   23.831679] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x4ff: clean.
[   23.835301] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x800-0x8ff: clean.
[   23.836496] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcff: clean.
[   23.837960] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff: clean.
[   23.848425] input: PS/2 Mouse as /class/input/input8
[   23.872288] input: AlpsPS/2 ALPS GlidePoint as /class/input/input9
[   23.876203] usbcore: registered new interface driver usbhid
[   23.876270] usbhid: v2.6:USB HID core driver
[   24.094164] input:   USB Keyboard as /class/input/input10
[   24.095457] bright 0003:1241:1503.0001: input: USB HID v1.10 Keyboard [  USB Keyboard] on usb-0000:00:10.0-2/input0
[   24.185549] input:   USB Keyboard as /class/input/input11
[   24.186513] bright 0003:1241:1503.0002: input: USB HID v1.10 Device [  USB Keyboard] on usb-0000:00:10.0-2/input1
[   24.198297] VIA 82xx Audio 0000:00:11.5: power state changed by ACPI to D0
[   24.198376] VIA 82xx Audio 0000:00:11.5: PCI INT C -> Link[ALKC] -> GSI 22 (level, low) -> IRQ 22
[   24.198608] VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
[   26.168421] Adding 1951888k swap on /dev/hda2.  Priority:-1 extents:1 across:1951888k
[   37.686757] powernow-k8: Found 1 Mobile AMD Sempron(tm) Processor 2600+ processors (1 cpu cores) (version 2.20.00)
[   37.687485] powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x6
[   37.687543] powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x18
[   37.688482] powernow-k8: ph2 null fid transition 0x8
[   38.219801] Linux agpgart interface v0.103
[   39.127354] [drm] Initialized drm 1.1.0 20060810
[   39.487512] pci 0000:01:00.0: power state changed by ACPI to D0
[   39.487590] pci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   39.489377] [drm] Initialized via 2.11.1 20070202 on minor 0
[   39.600175] leds_clevo_mail: 'Clevo D410J' found
[   39.600893] Registered led device: clevo::mail
[   50.014487] ReiserFS: hda1: found reiserfs format "3.6" with standard journal
[   50.014601] ReiserFS: hda1: using ordered data mode
[   50.019220] ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   50.020695] ReiserFS: hda1: checking transaction log (hda1)
[   50.087378] ReiserFS: hda1: Using r5 hash to sort names
[   51.445106] ip_tables: (C) 2000-2006 Netfilter Core Team
[   51.810882] eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
[   55.551178] NET: Registered protocol family 10
[   59.020170] lp0: using parport0 (interrupt-driven).
[   59.050185] ppdev: user-space parallel port driver
[   63.661065] Clocksource tsc unstable (delta = -129277605 ns)
[   64.395180] warning: `avahi-daemon' uses 32-bit capabilities (legacy support in use)
[   65.766039] eth0: no IPv6 routers present


--------------010602080600060102030206--
