From: wli222 <wli222@casema.nl>
Subject: DMI information
Date: Tue, 14 Oct 2008 12:50:24 +0200
Message-ID: <48F47970.5070500@casema.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030701060503060300060108"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq4.gn.mail.iss.as9143.net ([212.54.34.167]:55180 "EHLO
	smtpq4.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753932AbYJNLKI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Oct 2008 07:10:08 -0400
Received: from [212.54.34.139] (port=55748 helo=smtp8.gn.mail.iss.as9143.net)
	by smtpq4.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <wli222@casema.nl>)
	id 1KphTp-0008Di-Bc
	for linux-acpi@vger.kernel.org; Tue, 14 Oct 2008 12:50:21 +0200
Received: from 5350e339.cable.casema.nl ([83.80.227.57] helo=[192.168.1.2])
	by smtp8.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <wli222@casema.nl>)
	id 1KphTl-0007Ns-Fp
	for linux-acpi@vger.kernel.org; Tue, 14 Oct 2008 12:50:18 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030701060503060300060108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello
I have a new intel computer.
In the kernel log I saw a request for DMI information
I have attached the logs here

Regards Wim van der Linde



--------------030701060503060300060108
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.24-19-generic (buildd@yellow) (gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Wed Jun 18 14:15:37 UTC 2008 (Ubuntu 2.6.24-19.34-generic)
[    0.000000] Command line: root=UUID=7ac5aa4c-c452-438d-a01c-cb3e463200ac ro quiet splash
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000095c00 (usable)
[    0.000000]  BIOS-e820: 0000000000095c00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fae6000 (usable)
[    0.000000]  BIOS-e820: 000000007fae6000 - 000000007fb09000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fb09000 - 000000007fd4c000 (reserved)
[    0.000000]  BIOS-e820: 000000007fd4c000 - 000000007fd4d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fd4d000 - 000000007fd4f000 (usable)
[    0.000000]  BIOS-e820: 000000007fd4f000 - 000000007fd56000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fd56000 - 000000007fd58000 (usable)
[    0.000000]  BIOS-e820: 000000007fd58000 - 000000007fd5d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fd5d000 - 000000007fd5e000 (reserved)
[    0.000000]  BIOS-e820: 000000007fd5e000 - 000000007fd5f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fd5f000 - 000000007fd66000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007fd66000 - 000000007fd70000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fd70000 - 000000007fd8e000 (reserved)
[    0.000000]  BIOS-e820: 000000007fd8e000 - 000000007fd94000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fd94000 - 000000007ff00000 (usable)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 149) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 522982) 1 entries of 3200 used
[    0.000000] Entering add_active_range(0, 523597, 523599) 2 entries of 3200 used
[    0.000000] Entering add_active_range(0, 523606, 523608) 3 entries of 3200 used
[    0.000000] Entering add_active_range(0, 523668, 524032) 4 entries of 3200 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP signature @ 0xFFFF8100000F03C0 checksum 0
[    0.000000] ACPI: RSDP 000F03C0, 0024 (r2  INTEL)
[    0.000000] ACPI: XSDT 7FD64E18, 004C (r1 INTEL  DP45SG         83 MSFT    10013)
[    0.000000] ACPI Warning (tbutils-0217): Incorrect checksum in table [XSDT] -  A0, should be 4B [20070126]
[    0.000000] ACPI: FACP 7FD63D98, 00F4 (r4  INTEL   DP45SG       83 MSFT    10013)
[    0.000000] ACPI: DSDT 7FD5F018, 3D82 (r1 INTEL    DP45SG       83 INTL 20051117)
[    0.000000] ACPI: FACS 7FD6DE40, 0040
[    0.000000] ACPI: APIC 7FD63F18, 006C (r2  INTEL   DP45SG       83 MSFT    10013)
[    0.000000] ACPI: MCFG 7FD6ED98, 003C (r1 INTEL  DP45SG         83 MSFT       97)
[    0.000000] ACPI: HPET 7FD6ED18, 0038 (r1 INTEL  DP45SG         83 AMI.        3)
[    0.000000] ACPI: ASPT 7FD6EA98, 002C (r1 INTEL  PerfTune       83 AMI         3)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007ff00000
[    0.000000] Entering add_active_range(0, 0, 149) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 522982) 1 entries of 3200 used
[    0.000000] Entering add_active_range(0, 523597, 523599) 2 entries of 3200 used
[    0.000000] Entering add_active_range(0, 523606, 523608) 3 entries of 3200 used
[    0.000000] Entering add_active_range(0, 523668, 524032) 4 entries of 3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-000000007ff00000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[5] active PFN ranges
[    0.000000]     0:        0 ->      149
[    0.000000]     0:      256 ->   522982
[    0.000000]     0:   523597 ->   523599
[    0.000000]     0:   523606 ->   523608
[    0.000000]     0:   523668 ->   524032
[    0.000000] On node 0 totalpages: 523243
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1230 pages reserved
[    0.000000]   DMA zone: 2703 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7108 pages used for memmap
[    0.000000]   DMA32 zone: 512146 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] Processor #2
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] Processor #3
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] swsusp: Registered nosave memory region: 0000000000095000 - 0000000000096000
[    0.000000] swsusp: Registered nosave memory region: 0000000000096000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000e0000 - 0000000000100000
[    0.000000] swsusp: Registered nosave memory region: 000000007fae6000 - 000000007fb09000
[    0.000000] swsusp: Registered nosave memory region: 000000007fb09000 - 000000007fd4c000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd4c000 - 000000007fd4d000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd4f000 - 000000007fd56000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd58000 - 000000007fd5d000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd5d000 - 000000007fd5e000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd5e000 - 000000007fd5f000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd5f000 - 000000007fd66000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd66000 - 000000007fd70000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd70000 - 000000007fd8e000
[    0.000000] swsusp: Registered nosave memory region: 000000007fd8e000 - 000000007fd94000
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 7ff00000:7ee1c000)
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 34656 bytes of per cpu data
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 514849
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=UUID=7ac5aa4c-c452-438d-a01c-cb3e463200ac ro quiet splash
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] hpet clockevent registered
[    0.000000] TSC calibrated against HPET
[   55.864975] time.c: Detected 2833.289 MHz processor.
[   55.865723] Console: colour VGA+ 80x25
[   55.865725] console [tty0] enabled
[   55.865741] Checking aperture...
[   55.865747] Calgary: detecting Calgary via BIOS EBDA area
[   55.865748] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[   55.878082] Memory: 2050720k/2096128k available (2489k kernel code, 42252k reserved, 1318k data, 320k init)
[   55.878105] SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=4, Nodes=1
[   55.954860] Calibrating delay using timer specific routine.. 5670.60 BogoMIPS (lpj=11341214)
[   55.954880] Security Framework initialized
[   55.954885] SELinux:  Disabled at boot.
[   55.954893] AppArmor: AppArmor initialized
[   55.954896] Failure registering capabilities with primary security module.
[   55.955018] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   55.955770] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   55.956116] Mount-cache hash table entries: 256
[   55.956190] Initializing cgroup subsys ns
[   55.956193] Initializing cgroup subsys cpuacct
[   55.956202] CPU: L1 I cache: 32K, L1 D cache: 32K
[   55.956204] CPU: L2 cache: 6144K
[   55.956205] CPU 0/0 -> Node 0
[   55.956206] using mwait in idle threads.
[   55.956207] CPU: Physical Processor ID: 0
[   55.956208] CPU: Processor Core ID: 0
[   55.956213] CPU0: Thermal monitoring enabled (TM2)
[   55.956221] SMP alternatives: switching to UP code
[   55.956820] Early unpacking initramfs... done
[   56.222848] ACPI: Core revision 20070126
[   56.222872] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   56.264393] Using local APIC timer interrupts.
[   56.299649] APIC timer calibration result 20833001
[   56.299650] Detected 20.833 MHz APIC timer.
[   56.299701] SMP alternatives: switching to SMP code
[   56.300237] Booting processor 1/4 APIC 0x1
[   56.310814] Initializing CPU#1
[   56.387552] Calibrating delay using timer specific routine.. 5666.62 BogoMIPS (lpj=11333244)
[   56.387557] CPU: L1 I cache: 32K, L1 D cache: 32K
[   56.387558] CPU: L2 cache: 6144K
[   56.387559] CPU 1/1 -> Node 0
[   56.387560] CPU: Physical Processor ID: 0
[   56.387561] CPU: Processor Core ID: 1
[   56.387565] CPU1: Thermal monitoring enabled (TM2)
[   56.388206] Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz stepping 07
[   56.388231] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[   56.408268] SMP alternatives: switching to SMP code
[   56.408821] Booting processor 2/4 APIC 0x2
[   56.419396] Initializing CPU#2
[   56.499423] Calibrating delay using timer specific routine.. 5666.64 BogoMIPS (lpj=11333298)
[   56.499427] CPU: L1 I cache: 32K, L1 D cache: 32K
[   56.499428] CPU: L2 cache: 6144K
[   56.499430] CPU 2/2 -> Node 0
[   56.499431] CPU: Physical Processor ID: 0
[   56.499431] CPU: Processor Core ID: 2
[   56.499435] CPU2: Thermal monitoring enabled (TM2)
[   56.500076] Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz stepping 07
[   56.500114] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[   56.520130] SMP alternatives: switching to SMP code
[   56.520511] Booting processor 3/4 APIC 0x3
[   56.531086] Initializing CPU#3
[   56.611294] Calibrating delay using timer specific routine.. 5666.64 BogoMIPS (lpj=11333295)
[   56.611298] CPU: L1 I cache: 32K, L1 D cache: 32K
[   56.611299] CPU: L2 cache: 6144K
[   56.611300] CPU 3/3 -> Node 0
[   56.611301] CPU: Physical Processor ID: 0
[   56.611302] CPU: Processor Core ID: 3
[   56.611306] CPU3: Thermal monitoring enabled (TM2)
[   56.611947] Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz stepping 07
[   56.612004] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[   56.631992] Brought up 4 CPUs
[   56.632066] CPU0 attaching sched-domain:
[   56.632067]  domain 0: span 03
[   56.632068]   groups: 01 02
[   56.632070]   domain 1: span 0f
[   56.632071]    groups: 03 0c
[   56.632072]    domain 2: span 0f
[   56.632073]     groups: 0f
[   56.632074] CPU1 attaching sched-domain:
[   56.632075]  domain 0: span 03
[   56.632076]   groups: 02 01
[   56.632077]   domain 1: span 0f
[   56.632078]    groups: 03 0c
[   56.632079]    domain 2: span 0f
[   56.632080]     groups: 0f
[   56.632081] CPU2 attaching sched-domain:
[   56.632082]  domain 0: span 0c
[   56.632083]   groups: 04 08
[   56.632084]   domain 1: span 0f
[   56.632085]    groups: 0c 03
[   56.632086]    domain 2: span 0f
[   56.632087]     groups: 0f
[   56.632088] CPU3 attaching sched-domain:
[   56.632089]  domain 0: span 0c
[   56.632090]   groups: 08 04
[   56.632091]   domain 1: span 0f
[   56.632092]    groups: 0c 03
[   56.632093]    domain 2: span 0f
[   56.632094]     groups: 0f
[   56.632282] net_namespace: 120 bytes
[   56.632520] Time: 10:34:09  Date: 10/04/08
[   56.632535] NET: Registered protocol family 16
[   56.632655] ACPI: bus type pci registered
[   56.632701] PCI: Using configuration type 1
[   56.632718] mtrr: your CPUs had inconsistent fixed MTRR settings
[   56.632719] mtrr: probably your BIOS does not setup all CPUs.
[   56.632720] mtrr: corrected configuration.
[   56.633543] ACPI: BIOS _OSI(Linux) query ignored
[   56.633545] ACPI: DMI System Vendor:                                  
[   56.633546] ACPI: DMI Product Name:                                  
[   56.633547] ACPI: DMI Product Version:                                  
[   56.633548] ACPI: DMI Board Name: DP45SG
[   56.633548] ACPI: DMI BIOS Vendor: Intel Corp.
[   56.633549] ACPI: DMI BIOS Date: 08/19/2008
[   56.633550] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[   56.633551] ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
[   56.634670] ACPI: EC: Look up EC in DSDT
[   56.636564] ACPI: Interpreter enabled
[   56.636566] ACPI: (supports S0 S1 S3 S4 S5)
[   56.636575] ACPI: Using IOAPIC for interrupt routing
[   56.640038] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   56.640887] PCI: Transparent bridge - 0000:00:1e.0
[   56.640902] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   56.641003] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[   56.643115] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   56.643179] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[   56.643242] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[   56.643323] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[   56.643385] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   56.643448] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   56.643510] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   56.643573] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   56.643658] Linux Plug and Play Support v0.97 (c) Adam Belay
[   56.643676] pnp: PnP ACPI init
[   56.643680] ACPI: bus type pnp registered
[   56.644956] pnp: PnP ACPI: found 11 devices
[   56.644957] ACPI: ACPI bus type pnp unregistered
[   56.645099] PCI: Using ACPI for IRQ routing
[   56.645100] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   56.659258] NET: Registered protocol family 8
[   56.659259] NET: Registered protocol family 20
[   56.659279] PCI-GART: No AMD northbridge found.
[   56.659283] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[   56.659286] hpet0: 4 64-bit timers, 14318180 Hz
[   56.660304] AppArmor: AppArmor Filesystem Enabled
[   56.663234] Time: tsc clocksource has been installed.
[   56.663239] Switched to high resolution mode on CPU 0
[   56.663924] Switched to high resolution mode on CPU 1
[   56.663939] Switched to high resolution mode on CPU 2
[   56.663958] Switched to high resolution mode on CPU 3
[   56.671206] system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
[   56.671208] system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
[   56.671211] system 00:02: ioport range 0xa20-0xa3f has been reserved
[   56.671213] system 00:02: ioport range 0xa00-0xa1f has been reserved
[   56.671217] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[   56.671219] system 00:07: ioport range 0x540-0x5ff has been reserved
[   56.671221] system 00:07: ioport range 0x600-0x6ef has been reserved
[   56.671222] system 00:07: ioport range 0x6f0-0x6ff has been reserved
[   56.671224] system 00:07: ioport range 0x700-0x7ef has been reserved
[   56.671226] system 00:07: ioport range 0x7f0-0x7ff has been reserved
[   56.671227] system 00:07: ioport range 0x800-0x8ef has been reserved
[   56.671229] system 00:07: ioport range 0x8f0-0x8ff has been reserved
[   56.671231] system 00:07: ioport range 0x900-0x9ef has been reserved
[   56.671232] system 00:07: ioport range 0x9f0-0x9ff has been reserved
[   56.671235] system 00:07: iomem range 0xffe00000-0xffffffff could not be reserved
[   56.671236] system 00:07: iomem range 0xfed30000-0xfed3ffff has been reserved
[   56.671240] system 00:09: ioport range 0x400-0x47f has been reserved
[   56.671242] system 00:09: ioport range 0x1180-0x119f has been reserved
[   56.671244] system 00:09: ioport range 0x500-0x57f could not be reserved
[   56.671246] system 00:09: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[   56.671248] system 00:09: iomem range 0xfec00000-0xfecfffff has been reserved
[   56.671249] system 00:09: iomem range 0xfee00000-0xfee0ffff could not be reserved
[   56.671251] system 00:09: iomem range 0xff000000-0xffffffff could not be reserved
[   56.671488] PCI: Bridge: 0000:00:01.0
[   56.671489]   IO window: e000-efff
[   56.671491]   MEM window: c0000000-d00fffff
[   56.671493]   PREFETCH window: disabled.
[   56.671495] PCI: Bridge: 0000:00:1e.0
[   56.671495]   IO window: disabled.
[   56.671499]   MEM window: d0100000-d01fffff
[   56.671501]   PREFETCH window: disabled.
[   56.671510] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   56.671513] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   56.671519] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   56.671525] NET: Registered protocol family 2
[   56.707198] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   56.707574] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   56.708313] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   56.708530] TCP: Hash tables configured (established 262144 bind 65536)
[   56.708531] TCP reno registered
[   56.719225] checking if image is initramfs... it is
[   57.242923] Freeing initrd memory: 8444k freed
[   57.245614] audit: initializing netlink socket (disabled)
[   57.245623] audit(1223116449.304:1): initialized
[   57.247046] VFS: Disk quotas dquot_6.5.1
[   57.247094] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   57.247162] io scheduler noop registered
[   57.247163] io scheduler anticipatory registered
[   57.247164] io scheduler deadline registered
[   57.247236] io scheduler cfq registered (default)
[   65.236820] 0000:00:1a.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
[   73.227124] 0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
[   73.228394] Boot video device is 0000:01:00.0
[   73.228504] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   73.228522] assign_interrupt_mode Found MSI capability
[   73.228538] Allocate Port Service[0000:00:01.0:pcie00]
[   73.245030] Real Time Clock Driver v1.12ac
[   73.245140] hpet_resources: 0xfed00000 is busy
[   73.245151] Linux agpgart interface v0.102
[   73.245152] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   73.245253] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   73.245571] 00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   73.246096] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   73.246137] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[   73.246231] PNP: No PS/2 controller found. Probing ports directly.
[   73.250356] serio: i8042 KBD port at 0x60,0x64 irq 1
[   73.250359] serio: i8042 AUX port at 0x60,0x64 irq 12
[   73.264621] mice: PS/2 mouse device common for all mice
[   73.264647] cpuidle: using governor ladder
[   73.264648] cpuidle: using governor menu
[   73.264728] NET: Registered protocol family 1
[   73.264788] registered taskstats version 1
[   73.264848]   Magic number: 12:412:577
[   73.264855]   hash matches device ptyb9
[   73.264864] /build/buildd/linux-2.6.24/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   73.264866] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   73.264867] EDD information not available.
[   73.264874] Freeing unused kernel memory: 320k freed
[   74.369530] fuse init (API version 7.9)
[   74.381457] ACPI: SSDT 7FD67C18, 02CC (r1    AMI      IST        1 MSFT  3000001)
[   74.381702] ACPI: Processor [CPU1] (supports 8 throttling states)
[   74.381859] ACPI: Processor [CPU2] (supports 8 throttling states)
[   74.382005] ACPI: Processor [CPU3] (supports 8 throttling states)
[   74.382143] ACPI: Processor [CPU4] (supports 8 throttling states)
[   74.382151] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
[   74.382156] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
[   74.382164] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
[   74.382169] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
[   74.444020] usbcore: registered new interface driver usbfs
[   74.444032] usbcore: registered new interface driver hub
[   74.452307] usbcore: registered new device driver usb
[   74.457464] USB Universal Host Controller Interface driver v3.0
[   74.457496] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
[   74.457503] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   74.457506] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   74.457634] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   74.457657] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000f0e0
[   74.457728] usb usb1: configuration #1 chosen from 1 choice
[   74.457741] hub 1-0:1.0: USB hub found
[   74.457743] hub 1-0:1.0: 2 ports detected
[   74.506581] SCSI subsystem initialized
[   74.514673] libata version 3.00 loaded.
[   74.562590] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
[   74.562598] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   74.562601] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   74.562614] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
[   74.562636] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000f0c0
[   74.562696] usb usb2: configuration #1 chosen from 1 choice
[   74.562709] hub 2-0:1.0: USB hub found
[   74.562712] hub 2-0:1.0: 2 ports detected
[   74.666443] ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level, low) -> IRQ 18
[   74.666450] PCI: Setting latency timer of device 0000:00:1a.2 to 64
[   74.666452] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[   74.666464] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 3
[   74.666486] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000f0a0
[   74.666543] usb usb3: configuration #1 chosen from 1 choice
[   74.666556] hub 3-0:1.0: USB hub found
[   74.666559] hub 3-0:1.0: 2 ports detected
[   74.769301] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[   74.769306] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   74.769309] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   74.769321] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[   74.769342] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000f080
[   74.769399] usb usb4: configuration #1 chosen from 1 choice
[   74.769412] hub 4-0:1.0: USB hub found
[   74.769414] hub 4-0:1.0: 2 ports detected
[   74.801215] usb 1-2: new low speed USB device using uhci_hcd and address 2
[   74.873164] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[   74.873169] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   74.873171] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   74.873182] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
[   74.873202] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000f060
[   74.873257] usb usb5: configuration #1 chosen from 1 choice
[   74.873269] hub 5-0:1.0: USB hub found
[   74.873272] hub 5-0:1.0: 2 ports detected
[   74.977040] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   74.977045] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   74.977047] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   74.977058] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
[   74.977078] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000f040
[   74.977133] usb usb6: configuration #1 chosen from 1 choice
[   74.977145] hub 6-0:1.0: USB hub found
[   74.977148] hub 6-0:1.0: 2 ports detected
[   74.979135] usb 1-2: configuration #1 chosen from 1 choice
[   75.080964] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[   75.133034] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[d0100000-d01007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[   75.140958] ahci 0000:00:1f.2: version 3.0
[   75.140971] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   75.250169] usb 5-2: new full speed USB device using uhci_hcd and address 2
[   75.428643] usb 5-2: configuration #1 chosen from 1 choice
[   75.436627] usbcore: registered new interface driver hiddev
[   75.450687] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.0/input/input1
[   75.469921] input,hidraw0: USB HID v1.10 Keyboard [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
[   75.494681] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.1/input/input2
[   75.520857] input,hidraw1: USB HID v1.10 Mouse [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
[   75.520866] usbcore: registered new interface driver usbhid
[   75.520867] /build/buildd/linux-2.6.24/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   75.521613] usbcore: registered new interface driver libusual
[   75.523677] Initializing USB Mass Storage driver...
[   75.524268] scsi0 : SCSI emulation for USB Mass Storage devices
[   75.524669] usb-storage: device found at 2
[   75.524671] usb-storage: waiting for device to settle before scanning
[   75.524673] usbcore: registered new interface driver usb-storage
[   75.524675] USB Mass Storage support registered.
[   76.143609] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl RAID mode
[   76.143611] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part 
[   76.143614] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   76.143780] scsi1 : ahci
[   76.143883] scsi2 : ahci
[   76.143972] scsi3 : ahci
[   76.144059] scsi4 : ahci
[   76.144147] scsi5 : ahci
[   76.144236] scsi6 : ahci
[   76.144256] ata1: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225100 irq 510
[   76.144258] ata2: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225180 irq 510
[   76.144260] ata3: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225200 irq 510
[   76.144262] ata4: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225280 irq 510
[   76.144264] ata5: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225300 irq 510
[   76.144266] ata6: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225380 irq 510
[   76.407340] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00902700022b3cdc]
[   76.619015] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   76.620382] ata1.00: ATA-8: ST31000340AS, SD15, max UDMA/133
[   76.620384] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   76.622217] ata1.00: configured for UDMA/133
[   77.094436] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   77.263261] ata2.00: ATAPI: LITE-ON DVDRW LH-20A1L, BL05, max UDMA/100, ATAPI AN
[   77.431057] ata2.00: configured for UDMA/100
[   77.741648] ata3: SATA link down (SStatus 0 SControl 300)
[   78.053270] ata4: SATA link down (SStatus 0 SControl 300)
[   78.366389] ata5: SATA link down (SStatus 0 SControl 300)
[   78.678010] ata6: SATA link down (SStatus 0 SControl 300)
[   78.678076] scsi 1:0:0:0: Direct-Access     ATA      ST31000340AS     SD15 PQ: 0 ANSI: 5
[   78.679192] scsi 2:0:0:0: CD-ROM            LITE-ON  DVDRW LH-20A1L   BL05 PQ: 0 ANSI: 5
[   78.679282] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
[   78.680455] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   78.680459] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   78.680489] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 7
[   78.684387] ehci_hcd 0000:00:1a.7: debug port 1
[   78.684391] PCI: cache line size of 32 is not supported by device 0000:00:1a.7
[   78.684396] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xd0225c00
[   78.688311] Driver 'sd' needs updating - please use bus_type methods
[   78.688361] sd 1:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   78.688368] sd 1:0:0:0: [sda] Write Protect is off
[   78.688369] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   78.688378] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   78.688419] sd 1:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   78.688424] sd 1:0:0:0: [sda] Write Protect is off
[   78.688425] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   78.688434] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   78.688436]  sda:<4>Driver 'sr' needs updating - please use bus_type methods
[   78.697484] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   78.697558] usb usb7: configuration #1 chosen from 1 choice
[   78.697572] hub 7-0:1.0: USB hub found
[   78.697575] hub 7-0:1.0: 6 ports detected
[   78.706082]  sda1 sda2 sda3
[   78.706132] sd 1:0:0:0: [sda] Attached SCSI disk
[   78.708387] sd 1:0:0:0: Attached scsi generic sg0 type 0
[   78.708398] sr 2:0:0:0: Attached scsi generic sg1 type 5
[   78.714519] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   78.714521] Uniform CD-ROM driver Revision: 3.20
[   78.714542] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   78.800422] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
[   78.801609] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   78.801614] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   78.801659] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 8
[   78.805553] ehci_hcd 0000:00:1d.7: debug port 1
[   78.805558] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   78.805562] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0225800
[   78.820337] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   78.820398] usb usb8: configuration #1 chosen from 1 choice
[   78.820412] hub 8-0:1.0: USB hub found
[   78.820415] hub 8-0:1.0: 6 ports detected
[   78.985666] usb 1-2: USB disconnect, address 2
[   79.291765] usb 1-2: new low speed USB device using uhci_hcd and address 3
[   79.473929] usb 1-2: configuration #1 chosen from 1 choice
[   79.501003] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.0/input/input3
[   79.515507] input,hidraw0: USB HID v1.10 Keyboard [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
[   79.539999] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.1/input/input4
[   79.572443] input,hidraw1: USB HID v1.10 Mouse [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
[   79.572483] usb 5-2: USB disconnect, address 2
[   79.943975] usb 8-4: new high speed USB device using ehci_hcd and address 2
[   80.092544] usb 8-4: configuration #1 chosen from 1 choice
[   80.093187] scsi7 : SCSI emulation for USB Mass Storage devices
[   80.093217] usb-storage: device found at 2
[   80.093219] usb-storage: waiting for device to settle before scanning
[   84.304215] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   84.432023] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   84.444762] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   84.454904] input: Power Button (FF) as /devices/virtual/input/input6
[   84.985377] ACPI: Power Button (FF) [PWRF]
[   84.985424] input: Power Button (CM) as /devices/virtual/input/input7
[   85.049302] ACPI: Power Button (CM) [PWRB]
[   85.090301] usb-storage: device scan complete
[   85.096730] scsi 7:0:0:0: Direct-Access     Generic- Compact Flash    1.00 PQ: 0 ANSI: 0 CCS
[   85.103222] scsi 7:0:0:1: Direct-Access     Generic- SM/xD-Picture    1.00 PQ: 0 ANSI: 0 CCS
[   85.103825] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
[   85.105071] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   85.110124] scsi 7:0:0:2: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 0 CCS
[   85.116707] scsi 7:0:0:3: Direct-Access     Generic- MS/MS-Pro        1.00 PQ: 0 ANSI: 0 CCS
[   85.117967] sd 7:0:0:0: [sdb] Attached SCSI removable disk
[   85.117988] sd 7:0:0:0: Attached scsi generic sg2 type 0
[   85.118957] sd 7:0:0:1: [sdc] Attached SCSI removable disk
[   85.118975] sd 7:0:0:1: Attached scsi generic sg3 type 0
[   85.119957] sd 7:0:0:2: [sdd] Attached SCSI removable disk
[   85.119975] sd 7:0:0:2: Attached scsi generic sg4 type 0
[   85.120953] sd 7:0:0:3: [sde] Attached SCSI removable disk
[   85.120974] sd 7:0:0:3: Attached scsi generic sg5 type 0
[   85.186072] ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 17 (level, low) -> IRQ 17
[   85.187259] PCI: Setting latency timer of device 0000:01:00.1 to 64
[   85.975804] lp: driver loaded but no devices found
[   86.666797] device-mapper: uevent: version 1.0.3
[   86.666815] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
[   87.681350] ip_tables: (C) 2000-2006 Netfilter Core Team

--------------030701060503060300060108
Content-Type: text/plain;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.log"

Oct  4 10:33:03 wli222 kernel: [47074.767880] ip6_tables: (C) 2000-2006 Netfilter Core Team
Oct  4 10:34:41 wli222 kernel: Inspecting /boot/System.map-2.6.24-19-generic
Oct  4 10:34:41 wli222 kernel: Loaded 28491 symbols from /boot/System.map-2.6.24-19-generic.
Oct  4 10:34:41 wli222 kernel: Symbols match kernel version 2.6.24.
Oct  4 10:34:41 wli222 kernel: Loaded 15630 symbols from 75 modules.
Oct  4 10:34:41 wli222 kernel: [    0.000000] Initializing cgroup subsys cpuset
Oct  4 10:34:41 wli222 kernel: [    0.000000] Initializing cgroup subsys cpu
Oct  4 10:34:41 wli222 kernel: [    0.000000] Linux version 2.6.24-19-generic (buildd@yellow) (gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Wed Jun 18 14:15:37 UTC 2008 (Ubuntu 2.6.24-19.34-generic)
Oct  4 10:34:41 wli222 kernel: [    0.000000] Command line: root=UUID=7ac5aa4c-c452-438d-a01c-cb3e463200ac ro quiet splash
Oct  4 10:34:41 wli222 kernel: [    0.000000] BIOS-provided physical RAM map:
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 0000000000095c00 (usable)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 0000000000095c00 - 00000000000a0000 (reserved)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 000000007fae6000 (usable)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fae6000 - 000000007fb09000 (ACPI NVS)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fb09000 - 000000007fd4c000 (reserved)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd4c000 - 000000007fd4d000 (ACPI NVS)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd4d000 - 000000007fd4f000 (usable)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd4f000 - 000000007fd56000 (ACPI NVS)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd56000 - 000000007fd58000 (usable)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd58000 - 000000007fd5d000 (ACPI NVS)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd5d000 - 000000007fd5e000 (reserved)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd5e000 - 000000007fd5f000 (ACPI NVS)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd5f000 - 000000007fd66000 (ACPI data)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd66000 - 000000007fd70000 (ACPI NVS)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd70000 - 000000007fd8e000 (reserved)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd8e000 - 000000007fd94000 (ACPI NVS)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 000000007fd94000 - 000000007ff00000 (usable)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
Oct  4 10:34:41 wli222 kernel: [    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 0, 149) 0 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 256, 522982) 1 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 523597, 523599) 2 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 523606, 523608) 3 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 523668, 524032) 4 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] end_pfn_map = 1048576
Oct  4 10:34:41 wli222 kernel: [    0.000000] DMI 2.4 present.
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: RSDP signature @ 0xFFFF8100000F03C0 checksum 0
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: RSDP 000F03C0, 0024 (r2  INTEL)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: XSDT 7FD64E18, 004C (r1 INTEL  DP45SG         83 MSFT    10013)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI Warning (tbutils-0217): Incorrect checksum in table [XSDT] -  A0, should be 4B [20070126]
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: FACP 7FD63D98, 00F4 (r4  INTEL   DP45SG       83 MSFT    10013)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: DSDT 7FD5F018, 3D82 (r1 INTEL    DP45SG       83 INTL 20051117)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: FACS 7FD6DE40, 0040
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: APIC 7FD63F18, 006C (r2  INTEL   DP45SG       83 MSFT    10013)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: MCFG 7FD6ED98, 003C (r1 INTEL  DP45SG         83 MSFT       97)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: HPET 7FD6ED18, 0038 (r1 INTEL  DP45SG         83 AMI.        3)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: ASPT 7FD6EA98, 002C (r1 INTEL  PerfTune       83 AMI         3)
Oct  4 10:34:41 wli222 kernel: [    0.000000] No NUMA configuration found
Oct  4 10:34:41 wli222 kernel: [    0.000000] Faking a node at 0000000000000000-000000007ff00000
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 0, 149) 0 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 256, 522982) 1 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 523597, 523599) 2 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 523606, 523608) 3 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Entering add_active_range(0, 523668, 524032) 4 entries of 3200 used
Oct  4 10:34:41 wli222 kernel: [    0.000000] Bootmem setup node 0 0000000000000000-000000007ff00000
Oct  4 10:34:41 wli222 kernel: [    0.000000] Zone PFN ranges:
Oct  4 10:34:41 wli222 kernel: [    0.000000]   DMA             0 ->     4096
Oct  4 10:34:41 wli222 kernel: [    0.000000]   DMA32        4096 ->  1048576
Oct  4 10:34:41 wli222 kernel: [    0.000000]   Normal    1048576 ->  1048576
Oct  4 10:34:41 wli222 kernel: [    0.000000] Movable zone start PFN for each node
Oct  4 10:34:41 wli222 kernel: [    0.000000] early_node_map[5] active PFN ranges
Oct  4 10:34:41 wli222 kernel: [    0.000000]     0:        0 ->      149
Oct  4 10:34:41 wli222 kernel: [    0.000000]     0:      256 ->   522982
Oct  4 10:34:41 wli222 kernel: [    0.000000]     0:   523597 ->   523599
Oct  4 10:34:41 wli222 kernel: [    0.000000]     0:   523606 ->   523608
Oct  4 10:34:41 wli222 kernel: [    0.000000]     0:   523668 ->   524032
Oct  4 10:34:41 wli222 kernel: [    0.000000] On node 0 totalpages: 523243
Oct  4 10:34:41 wli222 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Oct  4 10:34:41 wli222 kernel: [    0.000000]   DMA zone: 1230 pages reserved
Oct  4 10:34:41 wli222 kernel: [    0.000000]   DMA zone: 2703 pages, LIFO batch:0
Oct  4 10:34:41 wli222 kernel: [    0.000000]   DMA32 zone: 7108 pages used for memmap
Oct  4 10:34:41 wli222 kernel: [    0.000000]   DMA32 zone: 512146 pages, LIFO batch:31
Oct  4 10:34:41 wli222 kernel: [    0.000000]   Normal zone: 0 pages used for memmap
Oct  4 10:34:41 wli222 kernel: [    0.000000]   Movable zone: 0 pages used for memmap
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x408
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Oct  4 10:34:41 wli222 kernel: [    0.000000] Processor #0 (Bootup-CPU)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Oct  4 10:34:41 wli222 kernel: [    0.000000] Processor #1
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Oct  4 10:34:41 wli222 kernel: [    0.000000] Processor #2
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Oct  4 10:34:41 wli222 kernel: [    0.000000] Processor #3
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
Oct  4 10:34:41 wli222 kernel: [    0.000000] IOAPIC[0]: apic_id 0, address 0xfec00000, GSI 0-23
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: IRQ0 used by override.
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: IRQ2 used by override.
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: IRQ9 used by override.
Oct  4 10:34:41 wli222 kernel: [    0.000000] Setting APIC routing to flat
Oct  4 10:34:41 wli222 kernel: [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
Oct  4 10:34:41 wli222 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 0000000000095000 - 0000000000096000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 0000000000096000 - 00000000000a0000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e0000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 00000000000e0000 - 0000000000100000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fae6000 - 000000007fb09000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fb09000 - 000000007fd4c000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd4c000 - 000000007fd4d000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd4f000 - 000000007fd56000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd58000 - 000000007fd5d000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd5d000 - 000000007fd5e000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd5e000 - 000000007fd5f000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd5f000 - 000000007fd66000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd66000 - 000000007fd70000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd70000 - 000000007fd8e000
Oct  4 10:34:41 wli222 kernel: [    0.000000] swsusp: Registered nosave memory region: 000000007fd8e000 - 000000007fd94000
Oct  4 10:34:41 wli222 kernel: [    0.000000] Allocating PCI resources starting at 80000000 (gap: 7ff00000:7ee1c000)
Oct  4 10:34:41 wli222 kernel: [    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
Oct  4 10:34:41 wli222 kernel: [    0.000000] PERCPU: Allocating 34656 bytes of per cpu data
Oct  4 10:34:41 wli222 kernel: [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 514849
Oct  4 10:34:41 wli222 kernel: [    0.000000] Policy zone: DMA32
Oct  4 10:34:41 wli222 kernel: [    0.000000] Kernel command line: root=UUID=7ac5aa4c-c452-438d-a01c-cb3e463200ac ro quiet splash
Oct  4 10:34:41 wli222 kernel: [    0.000000] Initializing CPU#0
Oct  4 10:34:41 wli222 kernel: [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
Oct  4 10:34:41 wli222 kernel: [    0.000000] Extended CMOS year: 2000
Oct  4 10:34:41 wli222 kernel: [    0.000000] hpet clockevent registered
Oct  4 10:34:41 wli222 kernel: [    0.000000] TSC calibrated against HPET
Oct  4 10:34:41 wli222 kernel: [   55.864975] time.c: Detected 2833.289 MHz processor.
Oct  4 10:34:41 wli222 kernel: [   55.865723] Console: colour VGA+ 80x25
Oct  4 10:34:41 wli222 kernel: [   55.865725] console [tty0] enabled
Oct  4 10:34:41 wli222 kernel: [   55.865741] Checking aperture...
Oct  4 10:34:41 wli222 kernel: [   55.865747] Calgary: detecting Calgary via BIOS EBDA area
Oct  4 10:34:41 wli222 kernel: [   55.865748] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Oct  4 10:34:41 wli222 kernel: [   55.878082] Memory: 2050720k/2096128k available (2489k kernel code, 42252k reserved, 1318k data, 320k init)
Oct  4 10:34:41 wli222 kernel: [   55.878105] SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=4, Nodes=1
Oct  4 10:34:41 wli222 kernel: [   55.954860] Calibrating delay using timer specific routine.. 5670.60 BogoMIPS (lpj=11341214)
Oct  4 10:34:41 wli222 kernel: [   55.954880] Security Framework initialized
Oct  4 10:34:41 wli222 kernel: [   55.954885] SELinux:  Disabled at boot.
Oct  4 10:34:41 wli222 kernel: [   55.954893] AppArmor: AppArmor initialized
Oct  4 10:34:41 wli222 kernel: [   55.954896] Failure registering capabilities with primary security module.
Oct  4 10:34:41 wli222 kernel: [   55.955018] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Oct  4 10:34:41 wli222 kernel: [   55.955770] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Oct  4 10:34:41 wli222 kernel: [   55.956116] Mount-cache hash table entries: 256
Oct  4 10:34:41 wli222 kernel: [   55.956190] Initializing cgroup subsys ns
Oct  4 10:34:41 wli222 kernel: [   55.956193] Initializing cgroup subsys cpuacct
Oct  4 10:34:41 wli222 kernel: [   55.956202] CPU: L1 I cache: 32K, L1 D cache: 32K
Oct  4 10:34:41 wli222 kernel: [   55.956204] CPU: L2 cache: 6144K
Oct  4 10:34:41 wli222 kernel: [   55.956205] CPU 0/0 -> Node 0
Oct  4 10:34:41 wli222 kernel: [   55.956206] using mwait in idle threads.
Oct  4 10:34:41 wli222 kernel: [   55.956207] CPU: Physical Processor ID: 0
Oct  4 10:34:41 wli222 kernel: [   55.956208] CPU: Processor Core ID: 0
Oct  4 10:34:41 wli222 kernel: [   55.956213] CPU0: Thermal monitoring enabled (TM2)
Oct  4 10:34:41 wli222 kernel: [   55.956221] SMP alternatives: switching to UP code
Oct  4 10:34:41 wli222 kernel: [   55.956820] Early unpacking initramfs... done
Oct  4 10:34:41 wli222 kernel: [   56.222848] ACPI: Core revision 20070126
Oct  4 10:34:41 wli222 kernel: [   56.222872] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
Oct  4 10:34:41 wli222 kernel: [   56.264393] Using local APIC timer interrupts.
Oct  4 10:34:41 wli222 kernel: [   56.299649] APIC timer calibration result 20833001
Oct  4 10:34:41 wli222 kernel: [   56.299650] Detected 20.833 MHz APIC timer.
Oct  4 10:34:41 wli222 kernel: [   56.299701] SMP alternatives: switching to SMP code
Oct  4 10:34:41 wli222 kernel: [   56.300237] Booting processor 1/4 APIC 0x1
Oct  4 10:34:41 wli222 kernel: [   56.310814] Initializing CPU#1
Oct  4 10:34:41 wli222 kernel: [   56.387552] Calibrating delay using timer specific routine.. 5666.62 BogoMIPS (lpj=11333244)
Oct  4 10:34:41 wli222 kernel: [   56.387557] CPU: L1 I cache: 32K, L1 D cache: 32K
Oct  4 10:34:41 wli222 kernel: [   56.387558] CPU: L2 cache: 6144K
Oct  4 10:34:41 wli222 kernel: [   56.387559] CPU 1/1 -> Node 0
Oct  4 10:34:41 wli222 kernel: [   56.387560] CPU: Physical Processor ID: 0
Oct  4 10:34:41 wli222 kernel: [   56.387561] CPU: Processor Core ID: 1
Oct  4 10:34:41 wli222 kernel: [   56.387565] CPU1: Thermal monitoring enabled (TM2)
Oct  4 10:34:41 wli222 kernel: [   56.388206] Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz stepping 07
Oct  4 10:34:41 wli222 kernel: [   56.388231] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Oct  4 10:34:41 wli222 kernel: [   56.408268] SMP alternatives: switching to SMP code
Oct  4 10:34:41 wli222 kernel: [   56.408821] Booting processor 2/4 APIC 0x2
Oct  4 10:34:41 wli222 kernel: [   56.419396] Initializing CPU#2
Oct  4 10:34:41 wli222 kernel: [   56.499423] Calibrating delay using timer specific routine.. 5666.64 BogoMIPS (lpj=11333298)
Oct  4 10:34:41 wli222 kernel: [   56.499427] CPU: L1 I cache: 32K, L1 D cache: 32K
Oct  4 10:34:41 wli222 kernel: [   56.499428] CPU: L2 cache: 6144K
Oct  4 10:34:41 wli222 kernel: [   56.499430] CPU 2/2 -> Node 0
Oct  4 10:34:41 wli222 kernel: [   56.499431] CPU: Physical Processor ID: 0
Oct  4 10:34:41 wli222 kernel: [   56.499431] CPU: Processor Core ID: 2
Oct  4 10:34:41 wli222 kernel: [   56.499435] CPU2: Thermal monitoring enabled (TM2)
Oct  4 10:34:41 wli222 kernel: [   56.500076] Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz stepping 07
Oct  4 10:34:41 wli222 kernel: [   56.500114] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Oct  4 10:34:41 wli222 kernel: [   56.520130] SMP alternatives: switching to SMP code
Oct  4 10:34:41 wli222 kernel: [   56.520511] Booting processor 3/4 APIC 0x3
Oct  4 10:34:41 wli222 kernel: [   56.531086] Initializing CPU#3
Oct  4 10:34:41 wli222 kernel: [   56.611294] Calibrating delay using timer specific routine.. 5666.64 BogoMIPS (lpj=11333295)
Oct  4 10:34:41 wli222 kernel: [   56.611298] CPU: L1 I cache: 32K, L1 D cache: 32K
Oct  4 10:34:41 wli222 kernel: [   56.611299] CPU: L2 cache: 6144K
Oct  4 10:34:41 wli222 kernel: [   56.611300] CPU 3/3 -> Node 0
Oct  4 10:34:41 wli222 kernel: [   56.611301] CPU: Physical Processor ID: 0
Oct  4 10:34:41 wli222 kernel: [   56.611302] CPU: Processor Core ID: 3
Oct  4 10:34:41 wli222 kernel: [   56.611306] CPU3: Thermal monitoring enabled (TM2)
Oct  4 10:34:41 wli222 kernel: [   56.611947] Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz stepping 07
Oct  4 10:34:41 wli222 kernel: [   56.612004] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Oct  4 10:34:41 wli222 kernel: [   56.631992] Brought up 4 CPUs
Oct  4 10:34:41 wli222 kernel: [   56.632066] CPU0 attaching sched-domain:
Oct  4 10:34:41 wli222 kernel: [   56.632067]  domain 0: span 03
Oct  4 10:34:41 wli222 kernel: [   56.632068]   groups: 01 02
Oct  4 10:34:41 wli222 kernel: [   56.632070]   domain 1: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632071]    groups: 03 0c
Oct  4 10:34:41 wli222 kernel: [   56.632072]    domain 2: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632073]     groups: 0f
Oct  4 10:34:41 wli222 kernel: [   56.632074] CPU1 attaching sched-domain:
Oct  4 10:34:41 wli222 kernel: [   56.632075]  domain 0: span 03
Oct  4 10:34:41 wli222 kernel: [   56.632076]   groups: 02 01
Oct  4 10:34:41 wli222 kernel: [   56.632077]   domain 1: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632078]    groups: 03 0c
Oct  4 10:34:41 wli222 kernel: [   56.632079]    domain 2: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632080]     groups: 0f
Oct  4 10:34:41 wli222 kernel: [   56.632081] CPU2 attaching sched-domain:
Oct  4 10:34:41 wli222 kernel: [   56.632082]  domain 0: span 0c
Oct  4 10:34:41 wli222 kernel: [   56.632083]   groups: 04 08
Oct  4 10:34:41 wli222 kernel: [   56.632084]   domain 1: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632085]    groups: 0c 03
Oct  4 10:34:41 wli222 kernel: [   56.632086]    domain 2: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632087]     groups: 0f
Oct  4 10:34:41 wli222 kernel: [   56.632088] CPU3 attaching sched-domain:
Oct  4 10:34:41 wli222 kernel: [   56.632089]  domain 0: span 0c
Oct  4 10:34:41 wli222 kernel: [   56.632090]   groups: 08 04
Oct  4 10:34:41 wli222 kernel: [   56.632091]   domain 1: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632092]    groups: 0c 03
Oct  4 10:34:41 wli222 kernel: [   56.632093]    domain 2: span 0f
Oct  4 10:34:41 wli222 kernel: [   56.632094]     groups: 0f
Oct  4 10:34:41 wli222 kernel: [   56.632282] net_namespace: 120 bytes
Oct  4 10:34:41 wli222 kernel: [   56.632520] Time: 10:34:09  Date: 10/04/08
Oct  4 10:34:41 wli222 kernel: [   56.632535] NET: Registered protocol family 16
Oct  4 10:34:41 wli222 kernel: [   56.632655] ACPI: bus type pci registered
Oct  4 10:34:41 wli222 kernel: [   56.632701] PCI: Using configuration type 1
Oct  4 10:34:41 wli222 kernel: [   56.632718] mtrr: your CPUs had inconsistent fixed MTRR settings
Oct  4 10:34:41 wli222 kernel: [   56.632719] mtrr: probably your BIOS does not setup all CPUs.
Oct  4 10:34:41 wli222 kernel: [   56.632720] mtrr: corrected configuration.
Oct  4 10:34:41 wli222 kernel: [   56.633543] ACPI: BIOS _OSI(Linux) query ignored
Oct  4 10:34:41 wli222 kernel: [   56.633545] ACPI: DMI System Vendor:                                  
Oct  4 10:34:41 wli222 kernel: [   56.633546] ACPI: DMI Product Name:                                  
Oct  4 10:34:41 wli222 kernel: [   56.633547] ACPI: DMI Product Version:                                  
Oct  4 10:34:41 wli222 kernel: [   56.633548] ACPI: DMI Board Name: DP45SG
Oct  4 10:34:41 wli222 kernel: [   56.633548] ACPI: DMI BIOS Vendor: Intel Corp.
Oct  4 10:34:41 wli222 kernel: [   56.633549] ACPI: DMI BIOS Date: 08/19/2008
Oct  4 10:34:41 wli222 kernel: [   56.633550] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
Oct  4 10:34:41 wli222 kernel: [   56.633551] ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
Oct  4 10:34:41 wli222 kernel: [   56.634670] ACPI: EC: Look up EC in DSDT
Oct  4 10:34:41 wli222 kernel: [   56.636564] ACPI: Interpreter enabled
Oct  4 10:34:41 wli222 kernel: [   56.636566] ACPI: (supports S0 S1 S3 S4 S5)
Oct  4 10:34:41 wli222 kernel: [   56.636575] ACPI: Using IOAPIC for interrupt routing
Oct  4 10:34:41 wli222 kernel: [   56.640038] ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct  4 10:34:41 wli222 kernel: [   56.640887] PCI: Transparent bridge - 0000:00:1e.0
Oct  4 10:34:41 wli222 kernel: [   56.640902] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Oct  4 10:34:41 wli222 kernel: [   56.641003] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
Oct  4 10:34:41 wli222 kernel: [   56.643115] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Oct  4 10:34:41 wli222 kernel: [   56.643179] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
Oct  4 10:34:41 wli222 kernel: [   56.643242] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
Oct  4 10:34:41 wli222 kernel: [   56.643323] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
Oct  4 10:34:41 wli222 kernel: [   56.643385] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Oct  4 10:34:41 wli222 kernel: [   56.643448] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Oct  4 10:34:41 wli222 kernel: [   56.643510] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Oct  4 10:34:41 wli222 kernel: [   56.643573] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Oct  4 10:34:41 wli222 kernel: [   56.643658] Linux Plug and Play Support v0.97 (c) Adam Belay
Oct  4 10:34:41 wli222 kernel: [   56.643676] pnp: PnP ACPI init
Oct  4 10:34:41 wli222 kernel: [   56.643680] ACPI: bus type pnp registered
Oct  4 10:34:41 wli222 kernel: [   56.644956] pnp: PnP ACPI: found 11 devices
Oct  4 10:34:41 wli222 kernel: [   56.644957] ACPI: ACPI bus type pnp unregistered
Oct  4 10:34:41 wli222 kernel: [   56.645099] PCI: Using ACPI for IRQ routing
Oct  4 10:34:41 wli222 kernel: [   56.645100] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Oct  4 10:34:41 wli222 kernel: [   56.659258] NET: Registered protocol family 8
Oct  4 10:34:41 wli222 kernel: [   56.659259] NET: Registered protocol family 20
Oct  4 10:34:41 wli222 kernel: [   56.659279] PCI-GART: No AMD northbridge found.
Oct  4 10:34:41 wli222 kernel: [   56.659283] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
Oct  4 10:34:41 wli222 kernel: [   56.659286] hpet0: 4 64-bit timers, 14318180 Hz
Oct  4 10:34:41 wli222 kernel: [   56.660304] AppArmor: AppArmor Filesystem Enabled
Oct  4 10:34:41 wli222 kernel: [   56.663234] Time: tsc clocksource has been installed.
Oct  4 10:34:41 wli222 kernel: [   56.663239] Switched to high resolution mode on CPU 0
Oct  4 10:34:41 wli222 kernel: [   56.663924] Switched to high resolution mode on CPU 1
Oct  4 10:34:41 wli222 kernel: [   56.663939] Switched to high resolution mode on CPU 2
Oct  4 10:34:41 wli222 kernel: [   56.663958] Switched to high resolution mode on CPU 3
Oct  4 10:34:41 wli222 kernel: [   56.671206] system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671208] system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671211] system 00:02: ioport range 0xa20-0xa3f has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671213] system 00:02: ioport range 0xa00-0xa1f has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671217] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671219] system 00:07: ioport range 0x540-0x5ff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671221] system 00:07: ioport range 0x600-0x6ef has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671222] system 00:07: ioport range 0x6f0-0x6ff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671224] system 00:07: ioport range 0x700-0x7ef has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671226] system 00:07: ioport range 0x7f0-0x7ff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671227] system 00:07: ioport range 0x800-0x8ef has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671229] system 00:07: ioport range 0x8f0-0x8ff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671231] system 00:07: ioport range 0x900-0x9ef has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671232] system 00:07: ioport range 0x9f0-0x9ff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671235] system 00:07: iomem range 0xffe00000-0xffffffff could not be reserved
Oct  4 10:34:41 wli222 kernel: [   56.671236] system 00:07: iomem range 0xfed30000-0xfed3ffff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671240] system 00:09: ioport range 0x400-0x47f has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671242] system 00:09: ioport range 0x1180-0x119f has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671244] system 00:09: ioport range 0x500-0x57f could not be reserved
Oct  4 10:34:41 wli222 kernel: [   56.671246] system 00:09: iomem range 0xfed1c000-0xfed1ffff could not be reserved
Oct  4 10:34:41 wli222 kernel: [   56.671248] system 00:09: iomem range 0xfec00000-0xfecfffff has been reserved
Oct  4 10:34:41 wli222 kernel: [   56.671249] system 00:09: iomem range 0xfee00000-0xfee0ffff could not be reserved
Oct  4 10:34:41 wli222 kernel: [   56.671251] system 00:09: iomem range 0xff000000-0xffffffff could not be reserved
Oct  4 10:34:41 wli222 kernel: [   56.671488] PCI: Bridge: 0000:00:01.0
Oct  4 10:34:41 wli222 kernel: [   56.671489]   IO window: e000-efff
Oct  4 10:34:41 wli222 kernel: [   56.671491]   MEM window: c0000000-d00fffff
Oct  4 10:34:41 wli222 kernel: [   56.671493]   PREFETCH window: disabled.
Oct  4 10:34:41 wli222 kernel: [   56.671495] PCI: Bridge: 0000:00:1e.0
Oct  4 10:34:41 wli222 kernel: [   56.671495]   IO window: disabled.
Oct  4 10:34:41 wli222 kernel: [   56.671499]   MEM window: d0100000-d01fffff
Oct  4 10:34:41 wli222 kernel: [   56.671501]   PREFETCH window: disabled.
Oct  4 10:34:41 wli222 kernel: [   56.671510] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
Oct  4 10:34:41 wli222 kernel: [   56.671513] PCI: Setting latency timer of device 0000:00:01.0 to 64
Oct  4 10:34:41 wli222 kernel: [   56.671519] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Oct  4 10:34:41 wli222 kernel: [   56.671525] NET: Registered protocol family 2
Oct  4 10:34:41 wli222 kernel: [   56.707198] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Oct  4 10:34:41 wli222 kernel: [   56.707574] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Oct  4 10:34:41 wli222 kernel: [   56.708313] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Oct  4 10:34:41 wli222 kernel: [   56.708530] TCP: Hash tables configured (established 262144 bind 65536)
Oct  4 10:34:41 wli222 kernel: [   56.708531] TCP reno registered
Oct  4 10:34:41 wli222 kernel: [   56.719225] checking if image is initramfs... it is
Oct  4 10:34:41 wli222 kernel: [   57.242923] Freeing initrd memory: 8444k freed
Oct  4 10:34:41 wli222 kernel: [   57.245614] audit: initializing netlink socket (disabled)
Oct  4 10:34:41 wli222 kernel: [   57.245623] audit(1223116449.304:1): initialized
Oct  4 10:34:41 wli222 kernel: [   57.247046] VFS: Disk quotas dquot_6.5.1
Oct  4 10:34:41 wli222 kernel: [   57.247094] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Oct  4 10:34:41 wli222 kernel: [   57.247162] io scheduler noop registered
Oct  4 10:34:41 wli222 kernel: [   57.247163] io scheduler anticipatory registered
Oct  4 10:34:41 wli222 kernel: [   57.247164] io scheduler deadline registered
Oct  4 10:34:41 wli222 kernel: [   57.247236] io scheduler cfq registered (default)
Oct  4 10:34:41 wli222 kernel: [   65.236820] 0000:00:1a.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
Oct  4 10:34:41 wli222 kernel: [   73.227124] 0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
Oct  4 10:34:41 wli222 kernel: [   73.228394] Boot video device is 0000:01:00.0
Oct  4 10:34:41 wli222 kernel: [   73.228504] PCI: Setting latency timer of device 0000:00:01.0 to 64
Oct  4 10:34:41 wli222 kernel: [   73.228522] assign_interrupt_mode Found MSI capability
Oct  4 10:34:41 wli222 kernel: [   73.228538] Allocate Port Service[0000:00:01.0:pcie00]
Oct  4 10:34:41 wli222 kernel: [   73.245030] Real Time Clock Driver v1.12ac
Oct  4 10:34:41 wli222 kernel: [   73.245140] hpet_resources: 0xfed00000 is busy
Oct  4 10:34:41 wli222 kernel: [   73.245151] Linux agpgart interface v0.102
Oct  4 10:34:41 wli222 kernel: [   73.245152] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Oct  4 10:34:41 wli222 kernel: [   73.245253] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct  4 10:34:41 wli222 kernel: [   73.245571] 00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct  4 10:34:41 wli222 kernel: [   73.246096] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
Oct  4 10:34:41 wli222 kernel: [   73.246137] input: Macintosh mouse button emulation as /devices/virtual/input/input0
Oct  4 10:34:41 wli222 kernel: [   73.246231] PNP: No PS/2 controller found. Probing ports directly.
Oct  4 10:34:41 wli222 kernel: [   73.250356] serio: i8042 KBD port at 0x60,0x64 irq 1
Oct  4 10:34:41 wli222 kernel: [   73.250359] serio: i8042 AUX port at 0x60,0x64 irq 12
Oct  4 10:34:41 wli222 kernel: [   73.264621] mice: PS/2 mouse device common for all mice
Oct  4 10:34:41 wli222 kernel: [   73.264647] cpuidle: using governor ladder
Oct  4 10:34:41 wli222 kernel: [   73.264648] cpuidle: using governor menu
Oct  4 10:34:41 wli222 kernel: [   73.264728] NET: Registered protocol family 1
Oct  4 10:34:41 wli222 kernel: [   73.264788] registered taskstats version 1
Oct  4 10:34:41 wli222 kernel: [   73.264848]   Magic number: 12:412:577
Oct  4 10:34:41 wli222 kernel: [   73.264855]   hash matches device ptyb9
Oct  4 10:34:41 wli222 kernel: [   73.264864] /build/buildd/linux-2.6.24/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Oct  4 10:34:41 wli222 kernel: [   73.264866] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
Oct  4 10:34:41 wli222 kernel: [   73.264867] EDD information not available.
Oct  4 10:34:41 wli222 kernel: [   73.264874] Freeing unused kernel memory: 320k freed
Oct  4 10:34:41 wli222 kernel: [   74.369530] fuse init (API version 7.9)
Oct  4 10:34:41 wli222 kernel: [   74.381457] ACPI: SSDT 7FD67C18, 02CC (r1    AMI      IST        1 MSFT  3000001)
Oct  4 10:34:41 wli222 kernel: [   74.381702] ACPI: Processor [CPU1] (supports 8 throttling states)
Oct  4 10:34:41 wli222 kernel: [   74.381859] ACPI: Processor [CPU2] (supports 8 throttling states)
Oct  4 10:34:41 wli222 kernel: [   74.382005] ACPI: Processor [CPU3] (supports 8 throttling states)
Oct  4 10:34:41 wli222 kernel: [   74.382143] ACPI: Processor [CPU4] (supports 8 throttling states)
Oct  4 10:34:41 wli222 kernel: [   74.382151] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
Oct  4 10:34:41 wli222 kernel: [   74.382156] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
Oct  4 10:34:41 wli222 kernel: [   74.382164] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
Oct  4 10:34:41 wli222 kernel: [   74.382169] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
Oct  4 10:34:41 wli222 kernel: [   74.444020] usbcore: registered new interface driver usbfs
Oct  4 10:34:41 wli222 kernel: [   74.444032] usbcore: registered new interface driver hub
Oct  4 10:34:41 wli222 kernel: [   74.452307] usbcore: registered new device driver usb
Oct  4 10:34:41 wli222 kernel: [   74.457464] USB Universal Host Controller Interface driver v3.0
Oct  4 10:34:41 wli222 kernel: [   74.457496] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
Oct  4 10:34:41 wli222 kernel: [   74.457503] PCI: Setting latency timer of device 0000:00:1a.0 to 64
Oct  4 10:34:41 wli222 kernel: [   74.457506] uhci_hcd 0000:00:1a.0: UHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   74.457634] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
Oct  4 10:34:41 wli222 kernel: [   74.457657] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000f0e0
Oct  4 10:34:41 wli222 kernel: [   74.457728] usb usb1: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   74.457741] hub 1-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   74.457743] hub 1-0:1.0: 2 ports detected
Oct  4 10:34:41 wli222 kernel: [   74.506581] SCSI subsystem initialized
Oct  4 10:34:41 wli222 kernel: [   74.514673] libata version 3.00 loaded.
Oct  4 10:34:41 wli222 kernel: [   74.562590] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
Oct  4 10:34:41 wli222 kernel: [   74.562598] PCI: Setting latency timer of device 0000:00:1a.1 to 64
Oct  4 10:34:41 wli222 kernel: [   74.562601] uhci_hcd 0000:00:1a.1: UHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   74.562614] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
Oct  4 10:34:41 wli222 kernel: [   74.562636] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000f0c0
Oct  4 10:34:41 wli222 kernel: [   74.562696] usb usb2: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   74.562709] hub 2-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   74.562712] hub 2-0:1.0: 2 ports detected
Oct  4 10:34:41 wli222 kernel: [   74.666443] ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level, low) -> IRQ 18
Oct  4 10:34:41 wli222 kernel: [   74.666450] PCI: Setting latency timer of device 0000:00:1a.2 to 64
Oct  4 10:34:41 wli222 kernel: [   74.666452] uhci_hcd 0000:00:1a.2: UHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   74.666464] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 3
Oct  4 10:34:41 wli222 kernel: [   74.666486] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000f0a0
Oct  4 10:34:41 wli222 kernel: [   74.666543] usb usb3: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   74.666556] hub 3-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   74.666559] hub 3-0:1.0: 2 ports detected
Oct  4 10:34:41 wli222 kernel: [   74.769301] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
Oct  4 10:34:41 wli222 kernel: [   74.769306] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Oct  4 10:34:41 wli222 kernel: [   74.769309] uhci_hcd 0000:00:1d.0: UHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   74.769321] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
Oct  4 10:34:41 wli222 kernel: [   74.769342] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000f080
Oct  4 10:34:41 wli222 kernel: [   74.769399] usb usb4: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   74.769412] hub 4-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   74.769414] hub 4-0:1.0: 2 ports detected
Oct  4 10:34:41 wli222 kernel: [   74.801215] usb 1-2: new low speed USB device using uhci_hcd and address 2
Oct  4 10:34:41 wli222 kernel: [   74.873164] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Oct  4 10:34:41 wli222 kernel: [   74.873169] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Oct  4 10:34:41 wli222 kernel: [   74.873171] uhci_hcd 0000:00:1d.1: UHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   74.873182] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
Oct  4 10:34:41 wli222 kernel: [   74.873202] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000f060
Oct  4 10:34:41 wli222 kernel: [   74.873257] usb usb5: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   74.873269] hub 5-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   74.873272] hub 5-0:1.0: 2 ports detected
Oct  4 10:34:41 wli222 kernel: [   74.977040] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Oct  4 10:34:41 wli222 kernel: [   74.977045] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Oct  4 10:34:41 wli222 kernel: [   74.977047] uhci_hcd 0000:00:1d.2: UHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   74.977058] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
Oct  4 10:34:41 wli222 kernel: [   74.977078] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000f040
Oct  4 10:34:41 wli222 kernel: [   74.977133] usb usb6: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   74.977145] hub 6-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   74.977148] hub 6-0:1.0: 2 ports detected
Oct  4 10:34:41 wli222 kernel: [   74.979135] usb 1-2: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   75.080964] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
Oct  4 10:34:41 wli222 kernel: [   75.133034] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[d0100000-d01007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
Oct  4 10:34:41 wli222 kernel: [   75.140958] ahci 0000:00:1f.2: version 3.0
Oct  4 10:34:41 wli222 kernel: [   75.140971] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
Oct  4 10:34:41 wli222 kernel: [   75.250169] usb 5-2: new full speed USB device using uhci_hcd and address 2
Oct  4 10:34:41 wli222 kernel: [   75.428643] usb 5-2: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   75.436627] usbcore: registered new interface driver hiddev
Oct  4 10:34:41 wli222 kernel: [   75.450687] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.0/input/input1
Oct  4 10:34:41 wli222 kernel: [   75.469921] input,hidraw0: USB HID v1.10 Keyboard [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
Oct  4 10:34:41 wli222 kernel: [   75.494681] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.1/input/input2
Oct  4 10:34:41 wli222 kernel: [   75.520857] input,hidraw1: USB HID v1.10 Mouse [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
Oct  4 10:34:41 wli222 kernel: [   75.520866] usbcore: registered new interface driver usbhid
Oct  4 10:34:41 wli222 kernel: [   75.520867] /build/buildd/linux-2.6.24/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Oct  4 10:34:41 wli222 kernel: [   75.521613] usbcore: registered new interface driver libusual
Oct  4 10:34:41 wli222 kernel: [   75.523677] Initializing USB Mass Storage driver...
Oct  4 10:34:41 wli222 kernel: [   75.524268] scsi0 : SCSI emulation for USB Mass Storage devices
Oct  4 10:34:41 wli222 kernel: [   75.524669] usb-storage: device found at 2
Oct  4 10:34:41 wli222 kernel: [   75.524671] usb-storage: waiting for device to settle before scanning
Oct  4 10:34:41 wli222 kernel: [   75.524673] usbcore: registered new interface driver usb-storage
Oct  4 10:34:41 wli222 kernel: [   75.524675] USB Mass Storage support registered.
Oct  4 10:34:41 wli222 kernel: [   76.143609] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl RAID mode
Oct  4 10:34:41 wli222 kernel: [   76.143611] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part 
Oct  4 10:34:41 wli222 kernel: [   76.143614] PCI: Setting latency timer of device 0000:00:1f.2 to 64
Oct  4 10:34:41 wli222 kernel: [   76.143780] scsi1 : ahci
Oct  4 10:34:41 wli222 kernel: [   76.143883] scsi2 : ahci
Oct  4 10:34:41 wli222 kernel: [   76.143972] scsi3 : ahci
Oct  4 10:34:41 wli222 kernel: [   76.144059] scsi4 : ahci
Oct  4 10:34:41 wli222 kernel: [   76.144147] scsi5 : ahci
Oct  4 10:34:41 wli222 kernel: [   76.144236] scsi6 : ahci
Oct  4 10:34:41 wli222 kernel: [   76.144256] ata1: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225100 irq 510
Oct  4 10:34:41 wli222 kernel: [   76.144258] ata2: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225180 irq 510
Oct  4 10:34:41 wli222 kernel: [   76.144260] ata3: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225200 irq 510
Oct  4 10:34:41 wli222 kernel: [   76.144262] ata4: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225280 irq 510
Oct  4 10:34:41 wli222 kernel: [   76.144264] ata5: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225300 irq 510
Oct  4 10:34:41 wli222 kernel: [   76.144266] ata6: SATA max UDMA/133 abar m2048@0xd0225000 port 0xd0225380 irq 510
Oct  4 10:34:41 wli222 kernel: [   76.407340] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00902700022b3cdc]
Oct  4 10:34:41 wli222 kernel: [   76.619015] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct  4 10:34:41 wli222 kernel: [   76.620382] ata1.00: ATA-8: ST31000340AS, SD15, max UDMA/133
Oct  4 10:34:41 wli222 kernel: [   76.620384] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
Oct  4 10:34:41 wli222 kernel: [   76.622217] ata1.00: configured for UDMA/133
Oct  4 10:34:41 wli222 kernel: [   77.094436] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct  4 10:34:41 wli222 kernel: [   77.263261] ata2.00: ATAPI: LITE-ON DVDRW LH-20A1L, BL05, max UDMA/100, ATAPI AN
Oct  4 10:34:41 wli222 kernel: [   77.431057] ata2.00: configured for UDMA/100
Oct  4 10:34:41 wli222 kernel: [   77.741648] ata3: SATA link down (SStatus 0 SControl 300)
Oct  4 10:34:41 wli222 kernel: [   78.053270] ata4: SATA link down (SStatus 0 SControl 300)
Oct  4 10:34:41 wli222 kernel: [   78.366389] ata5: SATA link down (SStatus 0 SControl 300)
Oct  4 10:34:41 wli222 kernel: [   78.678010] ata6: SATA link down (SStatus 0 SControl 300)
Oct  4 10:34:41 wli222 kernel: [   78.678076] scsi 1:0:0:0: Direct-Access     ATA      ST31000340AS     SD15 PQ: 0 ANSI: 5
Oct  4 10:34:41 wli222 kernel: [   78.679192] scsi 2:0:0:0: CD-ROM            LITE-ON  DVDRW LH-20A1L   BL05 PQ: 0 ANSI: 5
Oct  4 10:34:41 wli222 kernel: [   78.679282] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
Oct  4 10:34:41 wli222 kernel: [   78.680455] PCI: Setting latency timer of device 0000:00:1a.7 to 64
Oct  4 10:34:41 wli222 kernel: [   78.680459] ehci_hcd 0000:00:1a.7: EHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   78.680489] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 7
Oct  4 10:34:41 wli222 kernel: [   78.684387] ehci_hcd 0000:00:1a.7: debug port 1
Oct  4 10:34:41 wli222 kernel: [   78.684391] PCI: cache line size of 32 is not supported by device 0000:00:1a.7
Oct  4 10:34:41 wli222 kernel: [   78.684396] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xd0225c00
Oct  4 10:34:41 wli222 kernel: [   78.688311] Driver 'sd' needs updating - please use bus_type methods
Oct  4 10:34:41 wli222 kernel: [   78.688361] sd 1:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
Oct  4 10:34:41 wli222 kernel: [   78.688368] sd 1:0:0:0: [sda] Write Protect is off
Oct  4 10:34:41 wli222 kernel: [   78.688369] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct  4 10:34:41 wli222 kernel: [   78.688378] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  4 10:34:41 wli222 kernel: [   78.688419] sd 1:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
Oct  4 10:34:41 wli222 kernel: [   78.688424] sd 1:0:0:0: [sda] Write Protect is off
Oct  4 10:34:41 wli222 kernel: [   78.688425] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct  4 10:34:41 wli222 kernel: [   78.688434] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  4 10:34:41 wli222 kernel: [   78.688436]  sda:<4>Driver 'sr' needs updating - please use bus_type methods
Oct  4 10:34:41 wli222 kernel: [   78.697484] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Oct  4 10:34:41 wli222 kernel: [   78.697558] usb usb7: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   78.697572] hub 7-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   78.697575] hub 7-0:1.0: 6 ports detected
Oct  4 10:34:41 wli222 kernel: [   78.706082]  sda1 sda2 sda3
Oct  4 10:34:41 wli222 kernel: [   78.706132] sd 1:0:0:0: [sda] Attached SCSI disk
Oct  4 10:34:41 wli222 kernel: [   78.708387] sd 1:0:0:0: Attached scsi generic sg0 type 0
Oct  4 10:34:41 wli222 kernel: [   78.708398] sr 2:0:0:0: Attached scsi generic sg1 type 5
Oct  4 10:34:41 wli222 kernel: [   78.714519] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Oct  4 10:34:41 wli222 kernel: [   78.714521] Uniform CD-ROM driver Revision: 3.20
Oct  4 10:34:41 wli222 kernel: [   78.714542] sr 2:0:0:0: Attached scsi CD-ROM sr0
Oct  4 10:34:41 wli222 kernel: [   78.800422] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
Oct  4 10:34:41 wli222 kernel: [   78.801609] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Oct  4 10:34:41 wli222 kernel: [   78.801614] ehci_hcd 0000:00:1d.7: EHCI Host Controller
Oct  4 10:34:41 wli222 kernel: [   78.801659] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 8
Oct  4 10:34:41 wli222 kernel: [   78.805553] ehci_hcd 0000:00:1d.7: debug port 1
Oct  4 10:34:41 wli222 kernel: [   78.805558] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Oct  4 10:34:41 wli222 kernel: [   78.805562] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0225800
Oct  4 10:34:41 wli222 kernel: [   78.820337] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Oct  4 10:34:41 wli222 kernel: [   78.820398] usb usb8: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   78.820412] hub 8-0:1.0: USB hub found
Oct  4 10:34:41 wli222 kernel: [   78.820415] hub 8-0:1.0: 6 ports detected
Oct  4 10:34:41 wli222 kernel: [   78.985666] usb 1-2: USB disconnect, address 2
Oct  4 10:34:41 wli222 kernel: [   79.291765] usb 1-2: new low speed USB device using uhci_hcd and address 3
Oct  4 10:34:41 wli222 kernel: [   79.473929] usb 1-2: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   79.501003] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.0/input/input3
Oct  4 10:34:41 wli222 kernel: [   79.515507] input,hidraw0: USB HID v1.10 Keyboard [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
Oct  4 10:34:41 wli222 kernel: [   79.539999] input: CHESEN PS2 to USB Converter as /devices/pci0000:00/0000:00:1a.0/usb1/1-2/1-2:1.1/input/input4
Oct  4 10:34:41 wli222 kernel: [   79.572443] input,hidraw1: USB HID v1.10 Mouse [CHESEN PS2 to USB Converter] on usb-0000:00:1a.0-2
Oct  4 10:34:41 wli222 kernel: [   79.572483] usb 5-2: USB disconnect, address 2
Oct  4 10:34:41 wli222 kernel: [   79.943975] usb 8-4: new high speed USB device using ehci_hcd and address 2
Oct  4 10:34:41 wli222 kernel: [   80.092544] usb 8-4: configuration #1 chosen from 1 choice
Oct  4 10:34:41 wli222 kernel: [   80.093187] scsi7 : SCSI emulation for USB Mass Storage devices
Oct  4 10:34:41 wli222 kernel: [   80.093217] usb-storage: device found at 2
Oct  4 10:34:41 wli222 kernel: [   80.093219] usb-storage: waiting for device to settle before scanning
Oct  4 10:34:41 wli222 kernel: [   84.304215] input: PC Speaker as /devices/platform/pcspkr/input/input5
Oct  4 10:34:41 wli222 kernel: [   84.432023] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Oct  4 10:34:41 wli222 kernel: [   84.444762] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Oct  4 10:34:41 wli222 kernel: [   84.454904] input: Power Button (FF) as /devices/virtual/input/input6
Oct  4 10:34:41 wli222 kernel: [   84.985377] ACPI: Power Button (FF) [PWRF]
Oct  4 10:34:41 wli222 kernel: [   84.985424] input: Power Button (CM) as /devices/virtual/input/input7
Oct  4 10:34:41 wli222 kernel: [   85.049302] ACPI: Power Button (CM) [PWRB]
Oct  4 10:34:41 wli222 kernel: [   85.090301] usb-storage: device scan complete
Oct  4 10:34:41 wli222 kernel: [   85.096730] scsi 7:0:0:0: Direct-Access     Generic- Compact Flash    1.00 PQ: 0 ANSI: 0 CCS
Oct  4 10:34:41 wli222 kernel: [   85.103222] scsi 7:0:0:1: Direct-Access     Generic- SM/xD-Picture    1.00 PQ: 0 ANSI: 0 CCS
Oct  4 10:34:41 wli222 kernel: [   85.103825] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
Oct  4 10:34:41 wli222 kernel: [   85.105071] PCI: Setting latency timer of device 0000:00:1b.0 to 64
Oct  4 10:34:41 wli222 kernel: [   85.110124] scsi 7:0:0:2: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 0 CCS
Oct  4 10:34:41 wli222 kernel: [   85.116707] scsi 7:0:0:3: Direct-Access     Generic- MS/MS-Pro        1.00 PQ: 0 ANSI: 0 CCS
Oct  4 10:34:41 wli222 kernel: [   85.117967] sd 7:0:0:0: [sdb] Attached SCSI removable disk
Oct  4 10:34:41 wli222 kernel: [   85.117988] sd 7:0:0:0: Attached scsi generic sg2 type 0
Oct  4 10:34:41 wli222 kernel: [   85.118957] sd 7:0:0:1: [sdc] Attached SCSI removable disk
Oct  4 10:34:41 wli222 kernel: [   85.118975] sd 7:0:0:1: Attached scsi generic sg3 type 0
Oct  4 10:34:41 wli222 kernel: [   85.119957] sd 7:0:0:2: [sdd] Attached SCSI removable disk
Oct  4 10:34:41 wli222 kernel: [   85.119975] sd 7:0:0:2: Attached scsi generic sg4 type 0
Oct  4 10:34:41 wli222 kernel: [   85.120953] sd 7:0:0:3: [sde] Attached SCSI removable disk
Oct  4 10:34:41 wli222 kernel: [   85.120974] sd 7:0:0:3: Attached scsi generic sg5 type 0
Oct  4 10:34:41 wli222 kernel: [   85.186072] ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 17 (level, low) -> IRQ 17
Oct  4 10:34:41 wli222 kernel: [   85.187259] PCI: Setting latency timer of device 0000:01:00.1 to 64
Oct  4 10:34:41 wli222 kernel: [   85.975804] lp: driver loaded but no devices found
Oct  4 10:34:41 wli222 kernel: [   86.666797] device-mapper: uevent: version 1.0.3
Oct  4 10:34:41 wli222 kernel: [   86.666815] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
Oct  4 10:34:41 wli222 kernel: [   87.681350] ip_tables: (C) 2000-2006 Netfilter Core Team
Oct  4 10:34:41 wli222 kernel: [   87.895545] No dock devices found.
Oct  4 10:34:41 wli222 kernel: [   88.804018] ppdev: user-space parallel port driver
Oct  4 10:34:42 wli222 kernel: [   88.978526] audit(1223109282.071:2): type=1503 operation="inode_permission" requested_mask="a::" denied_mask="a::" name="/dev/tty" pid=5282 profile="/usr/sbin/cupsd" namespace="default"
Oct  4 10:34:42 wli222 kernel: [   89.754064] Bluetooth: Core ver 2.11
Oct  4 10:34:42 wli222 kernel: [   89.754210] NET: Registered protocol family 31
Oct  4 10:34:42 wli222 kernel: [   89.754214] Bluetooth: HCI device and connection manager initialized
Oct  4 10:34:42 wli222 kernel: [   89.754217] Bluetooth: HCI socket layer initialized
Oct  4 10:34:42 wli222 kernel: [   89.762139] Bluetooth: L2CAP ver 2.9
Oct  4 10:34:42 wli222 kernel: [   89.762142] Bluetooth: L2CAP socket layer initialized
Oct  4 10:34:42 wli222 kernel: [   89.805573] Bluetooth: RFCOMM socket layer initialized
Oct  4 10:34:42 wli222 kernel: [   89.805584] Bluetooth: RFCOMM TTY layer initialized
Oct  4 10:34:42 wli222 kernel: [   89.805585] Bluetooth: RFCOMM ver 1.8
Oct  4 10:34:59 wli222 kernel: [  106.410828] NET: Registered protocol family 10
Oct  4 10:34:59 wli222 kernel: [  106.410994] lo: Disabled Privacy Extensions

--------------030701060503060300060108--
