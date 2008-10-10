From: Zhang Rui <rui.zhang@intel.com>
Subject: acpi regression test of the latest ACPI test branch
Date: Fri, 10 Oct 2008 16:06:13 +0800
Message-ID: <1223625973.2735.142.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Yavn649Bixa0+d8vy5+X"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23283 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbYJJIHt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Oct 2008 04:07:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>


--=-Yavn649Bixa0+d8vy5+X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, len,

this is the ACPI regression test result based on the latest ACPI test branch.

1. on ﻿Acer:(AMD CPU, VIA chipset. 64 bit kernel)
﻿When doing S3 test, after pressing the power button, the system
reboots instead of resuming. But if S3 is done after S4, the system can
resume very well after pressing power button or using the RTC
alarm.
Note that this is an upstream regression as it can be reproduced on
linus' tree.
Yakui is investigating this issue.

2. on ﻿most of the laptops(not all of them), we got this warning during
boot, which is an acpi test branch regression. dmesg is attached.

[    0.192102] ------------[ cut here ]------------
[    0.192102] WARNING:
at /workshop/kernel/git/my/linux/fs/sysfs/dir.c:463 sysfs_add_one
+0x35/0x3d()
[    0.192165] sysfs: duplicate filename 'acpi' can not be created
[    0.192223] Modules linked in:
[    0.192311] Pid: 1, comm: swapper Not tainted
2.6.27-rc7-00058-g14d31d8 #760
[    0.192371] 
[    0.192372] Call Trace:
[    0.192475]  [<ffffffff8024e2f7>] warn_slowpath+0xae/0xdd
[    0.192535]  [<ffffffff8026cbf9>] ? trace_hardirqs_off+0xd/0xf
[    0.192594]  [<ffffffff80271318>] ? __lock_acquire+0x70e/0x76c
[    0.192653]  [<ffffffff8026cc2f>] ? get_lock_stats+0x34/0x5d
[    0.192712]  [<ffffffff8026cc66>] ? put_lock_stats+0xe/0x27
[    0.192770]  [<ffffffff8026cd20>] ? lock_release_holdtime+0xa1/0xa9
[    0.192832]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
[    0.192891]  [<ffffffff802d2a8b>] ? ifind+0xa3/0xb3
[    0.192949]  [<ffffffff80308d4f>] ? sysfs_find_dirent+0x1c/0x31
[    0.193008]  [<ffffffff80308d83>] ? __sysfs_add_one+0x1f/0x7c
[    0.193067]  [<ffffffff80308e15>] sysfs_add_one+0x35/0x3d
[    0.193125]  [<ffffffff803093ef>] create_dir+0x58/0x93
[    0.193184]  [<ffffffff80309462>] sysfs_create_dir+0x38/0x4f
[    0.193242]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
[    0.193301]  [<ffffffff803a72cb>] kobject_add_internal+0xdb/0x19b
[    0.193361]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
[    0.193419]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
[    0.193479]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.193538]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.193598]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.196021]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller
+0xf9/0x124
[    0.196081]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.196141]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/0xc6
[    0.196201]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
[    0.196260]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
[    0.196318]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
[    0.196378]  [<ffffffff80209047>] _stext+0x47/0x144
[    0.196436]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
[    0.196497]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
[    0.196555]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[    0.196616]  [<ffffffff802240c9>] child_rip+0xa/0x11
[    0.196674]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
[    0.196733]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
[    0.196791]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain
+0x0/0xb2
[    0.196852]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
[    0.196910]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
[    0.196966] 
[    0.197107] ---[ end trace 4eaa2a86a8e2da22 ]---
[    0.197166] kobject_add_internal failed for acpi with -EEXIST, don't
try to register things with the same name in the same directory.
[    0.197248] Pid: 1, comm: swapper Tainted: G        W
2.6.27-rc7-00058-g14d31d8 #760
[    0.197321] 
[    0.197322] Call Trace:
[    0.197423]  [<ffffffff803a7042>] ? kobject_put+0x47/0x4b
[    0.197481]  [<ffffffff803a7349>] kobject_add_internal+0x159/0x19b
[    0.197540]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
[    0.197599]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
[    0.197658]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.197717]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.197777]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.197835]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller
+0xf9/0x124
[    0.197896]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.197954]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/0xc6
[    0.198014]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
[    0.198073]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
[    0.198132]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
[    0.198190]  [<ffffffff80209047>] _stext+0x47/0x144
[    0.198247]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
[    0.198306]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
[    0.198364]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[    0.198425]  [<ffffffff802240c9>] child_rip+0xa/0x11
[    0.198482]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
[    0.198541]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
[    0.198599]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain
+0x0/0xb2
[    0.198659]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
[    0.198717]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
[    0.198774] 
[    0.198824] Module 'acpi' failed to be added to sysfs, error number
-17
[    0.198882] The system will be unstable now.

--=-Yavn649Bixa0+d8vy5+X
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=UTF-8
Content-Transfer-Encoding: 7bit

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Linux version 2.6.27-rc7-00058-g14d31d8 (david@sli10-conroe) (gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #760 SMP PREEMPT Fri Oct 10 10:28:13 CST 2008
[    0.000000] Command line: ro root=/dev/sda7 3 resume=/dev/sda6
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001f6d0000 (usable)
[    0.000000]  BIOS-e820: 000000001f6d0000 - 000000001f6df000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001f6df000 - 000000001f700000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
[    0.000000] last_pfn = 0x1f6d0 max_arch_pfn = 0x3ffffffff
[    0.000000] init_memory_mapping
[    0.000000]  0000000000 - 001f600000 page 2M
[    0.000000]  001f600000 - 001f6d0000 page 4k
[    0.000000] kernel direct mapping tables up to 1f6d0000 @ 8000-b000
[    0.000000] last_map_addr: 1f6d0000 end: 1f6d0000
[    0.000000] RAMDISK: 1f544000 - 1f6bfc51
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F67B0, 0024 (r2 LENOVO)
[    0.000000] ACPI: XSDT 1F6D1861, 008C (r1 LENOVO TP-7B        2080  LTP        0)
[    0.000000] ACPI: FACP 1F6D1900, 00F4 (r3 LENOVO TP-7B        2080 LNVO        1)
[    0.000000] ACPI Warning (tbfadt-0442): Optional field "Gpe1Block" has zero address or length: 000000000000102C/0 [20080729]
[    0.000000] ACPI: DSDT 1F6D1C90, CEF6 (r1 LENOVO TP-7B        2080 MSFT  100000E)
[    0.000000] ACPI: FACS 1F6F4000, 0040
[    0.000000] ACPI: SSDT 1F6D1AB4, 01DC (r1 LENOVO TP-7B        2080 MSFT  100000E)
[    0.000000] ACPI: ECDT 1F6DEB86, 0052 (r1 LENOVO TP-7B        2080 LNVO        1)
[    0.000000] ACPI: TCPA 1F6DEBD8, 0032 (r2 LENOVO TP-7B        2080 LNVO        1)
[    0.000000] ACPI: APIC 1F6DEC0A, 0068 (r1 LENOVO TP-7B        2080 LNVO        1)
[    0.000000] ACPI: MCFG 1F6DEC72, 003C (r1 LENOVO TP-7B        2080 LNVO        1)
[    0.000000] ACPI: HPET 1F6DECAE, 0038 (r1 LENOVO TP-7B        2080 LNVO        1)
[    0.000000] ACPI: SLIC 1F6DEE62, 0176 (r1 LENOVO TP-7B        2080  LTP        0)
[    0.000000] ACPI: BOOT 1F6DEFD8, 0028 (r1 LENOVO TP-7B        2080  LTP        1)
[    0.000000] ACPI: SSDT 1F6F2645, 025F (r1 LENOVO TP-7B        2080 INTL 20050513)
[    0.000000] ACPI: SSDT 1F6F28A4, 00A6 (r1 LENOVO TP-7B        2080 INTL 20050513)
[    0.000000] ACPI: SSDT 1F6F294A, 04F7 (r1 LENOVO TP-7B        2080 INTL 20050513)
[    0.000000] ACPI: SSDT 1F6F2E41, 01D8 (r1 LENOVO TP-7B        2080 INTL 20050513)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000001f6d0000
[    0.000000] Bootmem setup node 0 0000000000000000-000000001f6d0000
[    0.000000]   NODE_DATA [0000000000001000 - 0000000000004fff]
[    0.000000]   bootmap [0000000000009000 -  000000000000cedf] pages 4
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 001f6d0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 00012e9440]    TEXT DATA BSS ==> [0000200000 - 00012e9440]
[    0.000000]   #3 [001f544000 - 001f6bfc51]          RAMDISK ==> [001f544000 - 001f6bfc51]
[    0.000000]   #4 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
[    0.000000]   #5 [0000008000 - 0000009000]          PGTABLE ==> [0000008000 - 0000009000]
[    0.000000] found SMP MP-table at [ffff8800000f67f0] 000f67f0
[    0.000000]  [ffffe20000000000-ffffe20000dfffff] PMD -> [ffff880001400000-ffff8800021fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0001f6d0
[    0.000000] On node 0 totalpages: 128623
[    0.000000]   DMA zone: 3792 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 121459 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000d2000
[    0.000000] PM: Registered nosave memory: 00000000000d2000 - 00000000000d4000
[    0.000000] PM: Registered nosave memory: 00000000000d4000 - 00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:d0000000)
[    0.000000] PERCPU: Allocating 1625440 bytes of per cpu data
[    0.000000] NR_CPUS: 8, nr_cpu_ids: 2, nr_node_ids 1
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 125251
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: ro root=/dev/sda7 3 resume=/dev/sda6
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 2048 (order: 11, 16384 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] TSC: PIT calibration confirmed by PMTIMER.
[    0.000000] TSC: using PIT calibration value
[    0.000000] Detected 1828.710 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.004000] ... MAX_LOCKDEP_SUBCLASSES:    8
[    0.004000] ... MAX_LOCK_DEPTH:          48
[    0.004000] ... MAX_LOCKDEP_KEYS:        8191
[    0.004000] ... CLASSHASH_SIZE:           4096
[    0.004000] ... MAX_LOCKDEP_ENTRIES:     8192
[    0.004000] ... MAX_LOCKDEP_CHAINS:      16384
[    0.004000] ... CHAINHASH_SIZE:          8192
[    0.004000]  memory used by lock dependency info: 4095 kB
[    0.004000]  per task-struct memory footprint: 2688 bytes
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Memory: 478008k/514880k available (4655k kernel code, 36484k reserved, 2608k data, 2012k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.004000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.004000] hpet clockevent registered
[    0.004000] Calibrating delay loop (skipped), value calculated using timer frequency.. 3657.42 BogoMIPS (lpj=7314840)
[    0.004000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.004000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.004000] Mount-cache hash table entries: 256
[    0.004000] Initializing cgroup subsys debug
[    0.004000] Initializing cgroup subsys ns
[    0.004000] Initializing cgroup subsys cpuacct
[    0.004000] Initializing cgroup subsys memory
[    0.004000] Initializing cgroup subsys devices
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 2048K
[    0.004000] CPU 0/0 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 0
[    0.004000] CPU0: Thermal monitoring enabled (TM2)
[    0.004000] using mwait in idle threads.
[    0.004000] ACPI: Core revision 20080729
[    0.028257] Parsing all Control Methods:
[    0.030952] Table [DSDT](id 0001) - 1589 Objects with 69 Devices 428 Methods 28 Regions
[    0.031297] Parsing all Control Methods:
[    0.034023] Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
[    0.034311] Parsing all Control Methods:
[    0.037042] Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
[    0.037252] Parsing all Control Methods:
[    0.039963] Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
[    0.040334] Parsing all Control Methods:
[    0.043074] Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
[    0.043431] Parsing all Control Methods:
[    0.046314] Table [SSDT](id 0006) - 14 Objects with 1 Devices 2 Methods 0 Regions
[    0.046434]  tbxface-0596 [00] tb_load_namespace     : ACPI Tables successfully acquired
[    0.048015] evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
[    0.048781] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.089836] CPU0: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz stepping 02
[    0.089964] Using local APIC timer interrupts.
[    0.092011] APIC timer calibration result 10390397
[    0.092013] Detected 10.390 MHz APIC timer.
[    0.092644] lockdep: fixing up alternatives.
[    0.092803] Booting processor 1/1 ip 6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 3657.46 BogoMIPS (lpj=7314928)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 2048K
[    0.004000] CPU 1/1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] CPU1: Thermal monitoring enabled (TM2)
[    0.180405] CPU1: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz stepping 02
[    0.183185] checking TSC synchronization [CPU#0 -> CPU#1]:
[    0.184011] Measured 624349 cycles TSC warp between CPUs, turning off TSC clock.
[    0.184011] Marking TSC unstable due to check_tsc_sync_source failed
[    0.184081] Brought up 2 CPUs
[    0.184136] Total of 2 processors activated (7314.88 BogoMIPS).
[    0.184324] CPU0 attaching sched-domain:
[    0.184328]  domain 0: span 0-1 level MC
[    0.184331]   groups: 0 1
[    0.184336]   domain 1: span 0-1 level NODE
[    0.184339]    groups: 0-1
[    0.184368] CPU1 attaching sched-domain:
[    0.184370]  domain 0: span 0-1 level MC
[    0.184373]   groups: 1 0
[    0.184377]   domain 1: span 0-1 level NODE
[    0.184380]    groups: 0-1
[    0.188362] net_namespace: 1312 bytes
[    0.188755] NET: Registered protocol family 16
[    0.188755] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.188755] ACPI: bus type pci registered
[    0.188755] PCI: Using configuration type 1 for base access
[    0.192102] ------------[ cut here ]------------
[    0.192102] WARNING: at /workshop/kernel/git/my/linux/fs/sysfs/dir.c:463 sysfs_add_one+0x35/0x3d()
[    0.192165] sysfs: duplicate filename 'acpi' can not be created
[    0.192223] Modules linked in:
[    0.192311] Pid: 1, comm: swapper Not tainted 2.6.27-rc7-00058-g14d31d8 #760
[    0.192371] 
[    0.192372] Call Trace:
[    0.192475]  [<ffffffff8024e2f7>] warn_slowpath+0xae/0xdd
[    0.192535]  [<ffffffff8026cbf9>] ? trace_hardirqs_off+0xd/0xf
[    0.192594]  [<ffffffff80271318>] ? __lock_acquire+0x70e/0x76c
[    0.192653]  [<ffffffff8026cc2f>] ? get_lock_stats+0x34/0x5d
[    0.192712]  [<ffffffff8026cc66>] ? put_lock_stats+0xe/0x27
[    0.192770]  [<ffffffff8026cd20>] ? lock_release_holdtime+0xa1/0xa9
[    0.192832]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
[    0.192891]  [<ffffffff802d2a8b>] ? ifind+0xa3/0xb3
[    0.192949]  [<ffffffff80308d4f>] ? sysfs_find_dirent+0x1c/0x31
[    0.193008]  [<ffffffff80308d83>] ? __sysfs_add_one+0x1f/0x7c
[    0.193067]  [<ffffffff80308e15>] sysfs_add_one+0x35/0x3d
[    0.193125]  [<ffffffff803093ef>] create_dir+0x58/0x93
[    0.193184]  [<ffffffff80309462>] sysfs_create_dir+0x38/0x4f
[    0.193242]  [<ffffffff806841a5>] ? _spin_unlock+0x30/0x4b
[    0.193301]  [<ffffffff803a72cb>] kobject_add_internal+0xdb/0x19b
[    0.193361]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
[    0.193419]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
[    0.193479]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.193538]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.193598]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.196021]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller+0xf9/0x124
[    0.196081]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.196141]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/0xc6
[    0.196201]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
[    0.196260]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
[    0.196318]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
[    0.196378]  [<ffffffff80209047>] _stext+0x47/0x144
[    0.196436]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
[    0.196497]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
[    0.196555]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[    0.196616]  [<ffffffff802240c9>] child_rip+0xa/0x11
[    0.196674]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
[    0.196733]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
[    0.196791]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain+0x0/0xb2
[    0.196852]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
[    0.196910]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
[    0.196966] 
[    0.197107] ---[ end trace 4eaa2a86a8e2da22 ]---
[    0.197166] kobject_add_internal failed for acpi with -EEXIST, don't try to register things with the same name in the same directory.
[    0.197248] Pid: 1, comm: swapper Tainted: G        W 2.6.27-rc7-00058-g14d31d8 #760
[    0.197321] 
[    0.197322] Call Trace:
[    0.197423]  [<ffffffff803a7042>] ? kobject_put+0x47/0x4b
[    0.197481]  [<ffffffff803a7349>] kobject_add_internal+0x159/0x19b
[    0.197540]  [<ffffffff803a7457>] kobject_add_varg+0x41/0x4e
[    0.197599]  [<ffffffff803a74d2>] kobject_init_and_add+0x6e/0x7c
[    0.197658]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.197717]  [<ffffffff803a7e0c>] ? kobject_uevent_env+0x35b/0x38a
[    0.197777]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.197835]  [<ffffffff8026f95c>] ? trace_hardirqs_on_caller+0xf9/0x124
[    0.197896]  [<ffffffff8026f994>] ? trace_hardirqs_on+0xd/0xf
[    0.197954]  [<ffffffff8095c733>] kernel_param_sysfs_setup+0x6b/0xc6
[    0.198014]  [<ffffffff8095c8ed>] param_sysfs_init+0x15f/0x1d6
[    0.198073]  [<ffffffff803087a0>] ? sysfs_add_file+0xc/0xe
[    0.198132]  [<ffffffff8095c78e>] ? param_sysfs_init+0x0/0x1d6
[    0.198190]  [<ffffffff80209047>] _stext+0x47/0x144
[    0.198247]  [<ffffffff8028b77a>] ? register_irq_proc+0xaf/0xcb
[    0.198306]  [<ffffffff809478ed>] kernel_init+0x11d/0x171
[    0.198364]  [<ffffffff80683699>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[    0.198425]  [<ffffffff802240c9>] child_rip+0xa/0x11
[    0.198482]  [<ffffffff80246160>] ? finish_task_switch+0x5f/0xf3
[    0.198541]  [<ffffffff802236d3>] ? restore_args+0x0/0x30
[    0.198599]  [<ffffffff80686fc5>] ? __atomic_notifier_call_chain+0x0/0xb2
[    0.198659]  [<ffffffff809477d0>] ? kernel_init+0x0/0x171
[    0.198717]  [<ffffffff802240bf>] ? child_rip+0x0/0x11
[    0.198774] 
[    0.198824] Module 'acpi' failed to be added to sysfs, error number -17
[    0.198882] The system will be unstable now.
[    0.208019] evgpeblk-0957 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
[    0.208297] ACPI: EC: EC description table is found, configuring boot EC
[    0.213295] Completing Region/Field/Buffer/Package initialization:........................................................................................................................................................................................................................................................................
[    0.229561] Initialized 28/28 Regions 126/126 Fields 54/54 Buffers 56/56 Packages (1648 nodes)
[    0.229683] Initializing Device/Processor/Thermal objects by executing _INI methods:...<6>ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.240789] ....
[    0.245943] Executed 7 _INI methods requiring 2 _STA executions (examined 76 objects)
[    0.246500] evgpeblk-1054 [00] ev_initialize_gpe_bloc: Found 8 Wake, Enabled 2 Runtime GPEs in this block
[    0.246670] ACPI: Interpreter enabled
[    0.246724] ACPI: (supports S0 S3 S4 S5)
[    0.246938] ACPI: Using IOAPIC for interrupt routing
[    0.272510] ACPI: EC: GPE = 0x1c, I/O: command/status = 0x66, data = 0x62
[    0.272571] ACPI: EC: driver started in interrupt mode
[    0.277197] ACPI: ACPI Dock Station Driver: 3 docks/bays found
[    0.277299] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.277422] PCI: 0000:00:02.0 reg 10 32bit mmio: [ee100000, ee17ffff]
[    0.277422] PCI: 0000:00:02.0 reg 14 io port: [1800, 1807]
[    0.277422] PCI: 0000:00:02.0 reg 18 32bit mmio: [d0000000, dfffffff]
[    0.277422] PCI: 0000:00:02.0 reg 1c 32bit mmio: [ee200000, ee23ffff]
[    0.277422] PCI: 0000:00:02.1 reg 10 32bit mmio: [ee180000, ee1fffff]
[    0.277422] PCI: 0000:00:1b.0 reg 10 64bit mmio: [ee240000, ee243fff]
[    0.277422] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.277422] pci 0000:00:1b.0: PME# disabled
[    0.277422] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.277422] pci 0000:00:1c.0: PME# disabled
[    0.277422] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.277422] pci 0000:00:1c.1: PME# disabled
[    0.277422] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.277422] pci 0000:00:1c.2: PME# disabled
[    0.277422] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.277422] pci 0000:00:1c.3: PME# disabled
[    0.277422] PCI: 0000:00:1d.0 reg 20 io port: [1820, 183f]
[    0.277483] PCI: 0000:00:1d.1 reg 20 io port: [1840, 185f]
[    0.277567] PCI: 0000:00:1d.2 reg 20 io port: [1860, 187f]
[    0.277648] PCI: 0000:00:1d.3 reg 20 io port: [1880, 189f]
[    0.277733] PCI: 0000:00:1d.7 reg 10 32bit mmio: [ee444000, ee4443ff]
[    0.277804] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.277867] pci 0000:00:1d.7: PME# disabled
[    0.278117] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.278194] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.278287] PCI: 0000:00:1f.1 reg 10 io port: [0, 7]
[    0.278297] PCI: 0000:00:1f.1 reg 14 io port: [0, 3]
[    0.278307] PCI: 0000:00:1f.1 reg 18 io port: [0, 7]
[    0.278317] PCI: 0000:00:1f.1 reg 1c io port: [0, 3]
[    0.278327] PCI: 0000:00:1f.1 reg 20 io port: [1810, 181f]
[    0.278408] PCI: 0000:00:1f.2 reg 10 io port: [18d0, 18d7]
[    0.278418] PCI: 0000:00:1f.2 reg 14 io port: [18c4, 18c7]
[    0.278428] PCI: 0000:00:1f.2 reg 18 io port: [18c8, 18cf]
[    0.280033] PCI: 0000:00:1f.2 reg 1c io port: [18c0, 18c3]
[    0.280043] PCI: 0000:00:1f.2 reg 20 io port: [18b0, 18bf]
[    0.280053] PCI: 0000:00:1f.2 reg 24 32bit mmio: [ee444400, ee4447ff]
[    0.280091] pci 0000:00:1f.2: PME# supported from D3hot
[    0.280151] pci 0000:00:1f.2: PME# disabled
[    0.280274] PCI: 0000:00:1f.3 reg 20 io port: [18e0, 18ff]
[    0.280465] PCI: 0000:02:00.0 reg 10 32bit mmio: [ee000000, ee01ffff]
[    0.280493] PCI: 0000:02:00.0 reg 18 io port: [2000, 201f]
[    0.280594] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.280717] pci 0000:02:00.0: PME# disabled
[    0.280836] PCI: bridge 0000:00:1c.0 io port: [2000, 2fff]
[    0.280842] PCI: bridge 0000:00:1c.0 32bit mmio: [ee000000, ee0fffff]
[    0.281044] PCI: 0000:03:00.0 reg 10 32bit mmio: [edf00000, edf00fff]
[    0.281267] pci 0000:03:00.0: PME# supported from D0 D3hot
[    0.281336] pci 0000:03:00.0: PME# disabled
[    0.281455] PCI: bridge 0000:00:1c.1 io port: [3000, 4fff]
[    0.281461] PCI: bridge 0000:00:1c.1 32bit mmio: [ec000000, edffffff]
[    0.281472] PCI: bridge 0000:00:1c.1 64bit mmio pref: [e4000000, e40fffff]
[    0.281551] PCI: bridge 0000:00:1c.2 io port: [5000, 6fff]
[    0.281557] PCI: bridge 0000:00:1c.2 32bit mmio: [e8000000, e9ffffff]
[    0.281567] PCI: bridge 0000:00:1c.2 64bit mmio pref: [e4100000, e41fffff]
[    0.281646] PCI: bridge 0000:00:1c.3 io port: [7000, 8fff]
[    0.281652] PCI: bridge 0000:00:1c.3 32bit mmio: [ea000000, ebffffff]
[    0.281663] PCI: bridge 0000:00:1c.3 64bit mmio pref: [e4200000, e42fffff]
[    0.281727] PCI: 0000:15:00.0 reg 10 32bit mmio: [e4300000, e4300fff]
[    0.281753] pci 0000:15:00.0: supports D1
[    0.281755] pci 0000:15:00.0: supports D2
[    0.281758] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.281822] pci 0000:15:00.0: PME# disabled
[    0.281931] PCI: 0000:15:00.1 reg 10 32bit mmio: [e4301000, e43017ff]
[    0.282013] pci 0000:15:00.1: PME# supported from D0 D3hot D3cold
[    0.282075] pci 0000:15:00.1: PME# disabled
[    0.282182] PCI: 0000:15:00.2 reg 10 32bit mmio: [e4301800, e43018ff]
[    0.282264] pci 0000:15:00.2: supports D1
[    0.282266] pci 0000:15:00.2: supports D2
[    0.282268] pci 0000:15:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.282332] pci 0000:15:00.2: PME# disabled
[    0.282474] pci 0000:00:1e.0: transparent bridge
[    0.282534] PCI: bridge 0000:00:1e.0 io port: [9000, cfff]
[    0.282540] PCI: bridge 0000:00:1e.0 32bit mmio: [e4300000, e7ffffff]
[    0.282550] PCI: bridge 0000:00:1e.0 64bit mmio pref: [e0000000, e3ffffff]
[    0.282635] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.282964] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
[    0.283155] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.283344] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.283536] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
[    0.283726] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[    0.292250] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.292941] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
[    0.293631] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
[    0.294318] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[    0.295003] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.295688] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[    0.296595] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
[    0.297283] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.297873] ACPI: Power Resource [PUBS] (on)
[    0.297873] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.297873] pnp: PnP ACPI init
[    0.297873] ACPI: bus type pnp registered
[    0.304895] pnp: PnP ACPI: found 12 devices
[    0.304952] ACPI: ACPI bus type pnp unregistered
[    0.305035] SCSI subsystem initialized
[    0.305035] libata version 3.00 loaded.
[    0.305035] usbcore: registered new interface driver usbfs
[    0.305035] usbcore: registered new interface driver hub
[    0.308059] usbcore: registered new device driver usb
[    0.308095] PCI: Using ACPI for IRQ routing
[    0.348085] PCI-GART: No AMD northbridge found.
[    0.352040] Switched to high resolution mode on CPU 0
[    0.355500] Switched to high resolution mode on CPU 1
[    0.360038] system 00:00: iomem range 0x0-0x9ffff could not be reserved
[    0.360100] system 00:00: iomem range 0xc0000-0xc3fff has been reserved
[    0.360160] system 00:00: iomem range 0xc4000-0xc7fff has been reserved
[    0.360221] system 00:00: iomem range 0xc8000-0xcbfff has been reserved
[    0.360280] system 00:00: iomem range 0xcc000-0xcffff has been reserved
[    0.360341] system 00:00: iomem range 0xd0000-0xd3fff could not be reserved
[    0.360401] system 00:00: iomem range 0xdc000-0xdffff could not be reserved
[    0.360462] system 00:00: iomem range 0xe0000-0xe3fff could not be reserved
[    0.360523] system 00:00: iomem range 0xe4000-0xe7fff could not be reserved
[    0.360584] system 00:00: iomem range 0xe8000-0xebfff could not be reserved
[    0.360645] system 00:00: iomem range 0xec000-0xeffff could not be reserved
[    0.360705] system 00:00: iomem range 0xf0000-0xfffff could not be reserved
[    0.360766] system 00:00: iomem range 0x100000-0x1fffffff could not be reserved
[    0.363040] system 00:00: iomem range 0xfec00000-0xfed3ffff could not be reserved
[    0.363115] system 00:00: iomem range 0xfed41000-0xffffffff could not be reserved
[    0.363199] system 00:02: ioport range 0x164e-0x164f has been reserved
[    0.363263] system 00:02: ioport range 0x1000-0x107f has been reserved
[    0.363323] system 00:02: ioport range 0x1180-0x11bf has been reserved
[    0.363382] system 00:02: ioport range 0x800-0x80f has been reserved
[    0.363442] system 00:02: ioport range 0x15e0-0x15ef has been reserved
[    0.363502] system 00:02: ioport range 0x1600-0x165f could not be reserved
[    0.363563] system 00:02: iomem range 0xf0000000-0xf3ffffff could not be reserved
[    0.363637] system 00:02: iomem range 0xfed1c000-0xfed1ffff could not be reserved
[    0.363711] system 00:02: iomem range 0xfed14000-0xfed17fff could not be reserved
[    0.363785] system 00:02: iomem range 0xfed18000-0xfed18fff could not be reserved
[    0.363859] system 00:02: iomem range 0xfed19000-0xfed19fff could not be reserved
[    0.369609] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.369671] pci 0000:00:1c.0:   IO window: 0x2000-0x2fff
[    0.369733] pci 0000:00:1c.0:   MEM window: 0xee000000-0xee0fffff
[    0.369796] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.369860] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
[    0.369920] pci 0000:00:1c.1:   IO window: 0x3000-0x4fff
[    0.369983] pci 0000:00:1c.1:   MEM window: 0xec000000-0xedffffff
[    0.370045] pci 0000:00:1c.1:   PREFETCH window: 0x000000e4000000-0x000000e40fffff
[    0.370126] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:04
[    0.370186] pci 0000:00:1c.2:   IO window: 0x5000-0x6fff
[    0.370248] pci 0000:00:1c.2:   MEM window: 0xe8000000-0xe9ffffff
[    0.370310] pci 0000:00:1c.2:   PREFETCH window: 0x000000e4100000-0x000000e41fffff
[    0.370391] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:0c
[    0.370451] pci 0000:00:1c.3:   IO window: 0x7000-0x8fff
[    0.370513] pci 0000:00:1c.3:   MEM window: 0xea000000-0xebffffff
[    0.370575] pci 0000:00:1c.3:   PREFETCH window: 0x000000e4200000-0x000000e42fffff
[    0.370661] pci 0000:15:00.0: CardBus bridge, secondary bus 0000:16
[    0.370719] pci 0000:15:00.0:   IO window: 0x009000-0x0090ff
[    0.370781] pci 0000:15:00.0:   IO window: 0x009400-0x0094ff
[    0.370844] pci 0000:15:00.0:   PREFETCH window: 0xe0000000-0xe3ffffff
[    0.370907] pci 0000:15:00.0:   MEM window: 0x30000000-0x33ffffff
[    0.370970] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:15
[    0.371029] pci 0000:00:1e.0:   IO window: 0x9000-0xcfff
[    0.371092] pci 0000:00:1e.0:   MEM window: 0xe4300000-0xe7ffffff
[    0.371154] pci 0000:00:1e.0:   PREFETCH window: 0x000000e0000000-0x000000e3ffffff
[    0.371250] pci 0000:00:1c.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.371314] pci 0000:00:1c.0: setting latency timer to 64
[    0.371328] pci 0000:00:1c.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    0.371391] pci 0000:00:1c.1: setting latency timer to 64
[    0.371404] pci 0000:00:1c.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    0.371467] pci 0000:00:1c.2: setting latency timer to 64
[    0.371481] pci 0000:00:1c.3: PCI INT D -> GSI 23 (level, low) -> IRQ 23
[    0.371544] pci 0000:00:1c.3: setting latency timer to 64
[    0.371552] pci 0000:00:1e.0: enabling device (0005 -> 0007)
[    0.371614] pci 0000:00:1e.0: setting latency timer to 64
[    0.371630] pci 0000:15:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.371694] pci 0000:15:00.0: setting latency timer to 64
[    0.371699] bus: 00 index 0 io port: [0, ffff]
[    0.371754] bus: 00 index 1 mmio: [0, ffffffffffffffff]
[    0.371811] bus: 02 index 0 io port: [2000, 2fff]
[    0.371866] bus: 02 index 1 mmio: [ee000000, ee0fffff]
[    0.371922] bus: 02 index 2 mmio: [0, 0]
[    0.371977] bus: 02 index 3 mmio: [0, 0]
[    0.372036] bus: 03 index 0 io port: [3000, 4fff]
[    0.372092] bus: 03 index 1 mmio: [ec000000, edffffff]
[    0.372148] bus: 03 index 2 mmio: [e4000000, e40fffff]
[    0.372205] bus: 03 index 3 mmio: [0, 0]
[    0.372260] bus: 04 index 0 io port: [5000, 6fff]
[    0.372315] bus: 04 index 1 mmio: [e8000000, e9ffffff]
[    0.372372] bus: 04 index 2 mmio: [e4100000, e41fffff]
[    0.372428] bus: 04 index 3 mmio: [0, 0]
[    0.372482] bus: 0c index 0 io port: [7000, 8fff]
[    0.372538] bus: 0c index 1 mmio: [ea000000, ebffffff]
[    0.372595] bus: 0c index 2 mmio: [e4200000, e42fffff]
[    0.372651] bus: 0c index 3 mmio: [0, 0]
[    0.372705] bus: 15 index 0 io port: [9000, cfff]
[    0.372762] bus: 15 index 1 mmio: [e4300000, e7ffffff]
[    0.372818] bus: 15 index 2 mmio: [e0000000, e3ffffff]
[    0.372875] bus: 15 index 3 io port: [0, ffff]
[    0.372930] bus: 15 index 4 mmio: [0, ffffffffffffffff]
[    0.372987] bus: 16 index 0 io port: [9000, 90ff]
[    0.373059] bus: 16 index 1 io port: [9400, 94ff]
[    0.373115] bus: 16 index 2 mmio: [e0000000, e3ffffff]
[    0.373171] bus: 16 index 3 mmio: [30000000, 33ffffff]
[    0.373243] NET: Registered protocol family 2
[    0.421103] IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.421604] TCP established hash table entries: 16384 (order: 6, 262144 bytes)
[    0.421948] TCP bind hash table entries: 16384 (order: 8, 1048576 bytes)
[    0.422501] TCP: Hash tables configured (established 16384 bind 16384)
[    0.422561] TCP reno registered
[    0.433120] NET: Registered protocol family 1
[    0.433338] checking if image is initramfs... it is
[    0.565567] Freeing initrd memory: 1519k freed
[    0.566747] Simple Boot Flag at 0x35 set to 0x1
[    0.572509] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.578582] VFS: Disk quotas dquot_6.5.1
[    0.578841] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.580243] NTFS driver 2.1.29 [Flags: R/W].
[    0.580668] msgmni has been set to 936
[    0.580821] io scheduler noop registered
[    0.580876] io scheduler anticipatory registered (default)
[    0.580933] io scheduler deadline registered
[    0.581245] io scheduler cfq registered
[    0.581316] pci 0000:00:02.0: Boot video device
[    0.581700] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.581758] pcieport-driver 0000:00:1c.0: found MSI capability
[    0.581878] pci_express 0000:00:1c.0:pcie00: allocate port service
[    0.581974] pci_express 0000:00:1c.0:pcie02: allocate port service
[    0.582150] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    0.582208] pcieport-driver 0000:00:1c.1: found MSI capability
[    0.582323] pci_express 0000:00:1c.1:pcie00: allocate port service
[    0.582408] pci_express 0000:00:1c.1:pcie02: allocate port service
[    0.582586] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    0.582644] pcieport-driver 0000:00:1c.2: found MSI capability
[    0.582759] pci_express 0000:00:1c.2:pcie00: allocate port service
[    0.582844] pci_express 0000:00:1c.2:pcie02: allocate port service
[    0.583028] pcieport-driver 0000:00:1c.3: setting latency timer to 64
[    0.583085] pcieport-driver 0000:00:1c.3: found MSI capability
[    0.583201] pci_express 0000:00:1c.3:pcie00: allocate port service
[    0.583288] pci_express 0000:00:1c.3:pcie02: allocate port service
[    0.583628] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.584308] pciehp: HPC vendor_id 8086 device_id 27d0 ss_vid 0 ss_did 0
[    0.584498] hpdriver 0000:00:1c.0:pcie02: service driver hpdriver loaded
[    0.584960] pciehp: HPC vendor_id 8086 device_id 27d2 ss_vid 0 ss_did 0
[    0.585150] hpdriver 0000:00:1c.1:pcie02: service driver hpdriver loaded
[    0.585600] pciehp: HPC vendor_id 8086 device_id 27d4 ss_vid 0 ss_did 0
[    0.585795] hpdriver 0000:00:1c.2:pcie02: service driver hpdriver loaded
[    0.586245] pciehp: HPC vendor_id 8086 device_id 27d6 ss_vid 0 ss_did 0
[    0.586423] hpdriver 0000:00:1c.3:pcie02: service driver hpdriver loaded
[    0.586498] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.586681] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.586742] fakephp: Fake PCI Hot Plug Controller Driver
[    0.587391] fakephp: pci_hp_register failed with error -16
[    0.587454] fakephp: pci_hp_register failed with error -16
[    0.588355] ACPI: AC Adapter [AC] (on-line)
[    0.631134] ACPI: Battery Slot [BAT0] (battery present)
[    0.631535] input: Power Button (FF) as /class/input/input0
[    0.631595] ACPI: Power Button (FF) [PWRF]
[    0.631933] input: Lid Switch as /class/input/input1
[    0.636770] ACPI: Lid Switch [LID]
[    0.636971] input: Sleep Button (CM) as /class/input/input2
[    0.637039] ACPI: Sleep Button (CM) [SLPB]
[    0.638196] ACPI: SSDT 1F6F1D26, 0240 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
[    0.638396] Parsing all Control Methods:
[    0.639546] Table [SSDT](id 00E4) - 6 Objects with 0 Devices 4 Methods 0 Regions
[    0.640040] ACPI: SSDT 1F6F1FEB, 065A (r1  PmRef  Cpu0Cst      100 INTL 20050513)
[    0.640273] Parsing all Control Methods:
[    0.641437] Table [SSDT](id 00E5) - 13 Objects with 0 Devices 1 Methods 0 Regions
[    0.645707] Monitor-Mwait will be used to enter C-1 state
[    0.645712] Monitor-Mwait will be used to enter C-2 state
[    0.645716] Monitor-Mwait will be used to enter C-3 state
[    0.645802] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    0.646090] processor ACPI0007:00: registered as cooling_device0
[    0.646153] ACPI: Processor [CPU0] (supports 8 throttling states)
[    0.646829] ACPI: SSDT 1F6F1C5E, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
[    0.647014] Parsing all Control Methods:
[    0.648189] Table [SSDT](id 00ED) - 4 Objects with 0 Devices 4 Methods 0 Regions
[    0.648513] ACPI: SSDT 1F6F1F66, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
[    0.648679] Parsing all Control Methods:
[    0.649841] Table [SSDT](id 00EE) - 1 Objects with 0 Devices 1 Methods 0 Regions
[    0.651957] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    0.652248] processor ACPI0007:01: registered as cooling_device1
[    0.652310] ACPI: Processor [CPU1] (supports 8 throttling states)
[    0.662047] thermal LNXTHERM:01: registered as thermal_zone0
[    0.665657] ACPI: Thermal Zone [THM0] (52 C)
[    0.667003] thermal LNXTHERM:02: registered as thermal_zone1
[    0.668586] ACPI: Thermal Zone [THM1] (52 C)
[    0.759224] Generic RTC Driver v1.07
[    0.759387] Linux agpgart interface v0.103
[    0.759476] agpgart-intel 0000:00:00.0: Intel 945GM Chipset
[    0.760322] agpgart-intel 0000:00:00.0: detected 7932K stolen memory
[    0.775600] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    0.775884] [drm] Initialized drm 1.1.0 20060810
[    0.776134] pci 0000:00:02.0: power state changed by ACPI to D0
[    0.776199] pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.776262] pci 0000:00:02.0: setting latency timer to 64
[    0.776442] [drm] Initialized i915 1.6.0 20060119 on minor 0
[    0.776622] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets
[    0.776701] intelfb: Version 0.9.5
[    0.776803] intelfb: 00:02.0: Intel(R) 945GM, aperture size 256MB, stolen memory 7932kB
[    0.779549] intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
[    0.779698] intelfb: Video mode must be programmed at boot time.
[    0.781017] Serial: 8250/16550 driver4 ports, IRQ sharing disabled
[    0.786329] brd: module loaded
[    0.787950] loop: module loaded
[    0.788007] Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI
[    0.788069] Copyright (c) 1999-2006 Intel Corporation.
[    0.788256] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k2
[    0.788315] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    0.788505] e1000e 0000:02:00.0: Disabling L1 ASPM
[    0.790902] e1000e 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.790972] e1000e 0000:02:00.0: setting latency timer to 64
[    0.846454] 0000:02:00.0: 0000:02:00.0: Warning: detected ASPM enabled in EEPROM
[    0.904475] 0000:02:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:16:d3:b5:1a:7c
[    0.904549] 0000:02:00.0: eth0: Intel(R) PRO/1000 Network Connection
[    0.904682] 0000:02:00.0: eth0: MAC: 2, PHY: 2, PBA No: 005302-003
[    0.904846] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 1.3.18-k4
[    0.904921] ixgbe: Copyright (c) 1999-2007 Intel Corporation.
[    0.905105] Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
[    0.905164] Copyright (c) 1999-2008 Intel Corporation.
[    0.905597] e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
[    0.905656] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.906160] PPP generic driver version 2.4.2
[    0.906783] dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
[    0.906965] winbond-840.c:v1.01-e (2.4 port) Sep-11-2006  Donald Becker <becker@scyld.com>
[    0.906967]   http://www.scyld.com/network/drivers.html
[    0.908152] Adaptec aacraid driver 1.1-5[2456]-ms
[    0.908808] QLogic Fibre Channel HBA Driver: 8.02.01-k7
[    0.909124] megasas: 00.00.04.01 Thu July 24 11:41:51 PST 2008
[    0.909509] Driver 'sd' needs updating - please use bus_type methods
[    0.909633] Driver 'sr' needs updating - please use bus_type methods
[    0.909800] ahci 0000:00:1f.2: version 3.0
[    0.909817] ahci 0000:00:1f.2: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.910000] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
[    0.910076] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[    0.910140] ahci 0000:00:1f.2: setting latency timer to 64
[    0.910278] scsi0 : ahci
[    0.910526] scsi1 : ahci
[    0.910757] scsi2 : ahci
[    0.910989] scsi3 : ahci
[    0.911262] ata1: SATA max UDMA/133 abar m1024@0xee444400 port 0xee444500 irq 507
[    0.911336] ata2: DUMMY
[    0.911388] ata3: DUMMY
[    0.911439] ata4: DUMMY
[    1.452032] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.453547] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
[    1.453551] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    1.453611] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
[    1.454737] ata1.00: ATA-7: HTS541080G9SA00, MB4IC65R, max UDMA/100
[    1.454797] ata1.00: 156301488 sectors, multi 16: LBA48 
[    1.456510] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
[    1.456514] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    1.456572] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
[    1.457712] ata1.00: configured for UDMA/100
[    1.474442] ata1.00: configured for UDMA/100
[    1.474498] ata1: EH complete
[    1.474729] scsi 0:0:0:0: Direct-Access     ATA      HTS541080G9SA00  MB4I PQ: 0 ANSI: 5
[    1.475098] sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
[    1.475185] sd 0:0:0:0: [sda] Write Protect is off
[    1.475242] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.475294] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.475503] sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
[    1.475590] sd 0:0:0:0: [sda] Write Protect is off
[    1.475647] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.475699] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.475777]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
[    1.870209] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.870516] ata_piix 0000:00:1f.1: version 2.12
[    1.870527] ata_piix 0000:00:1f.1: PCI INT C -> GSI 16 (level, low) -> IRQ 16
[    1.870635] ata_piix 0000:00:1f.1: setting latency timer to 64
[    1.870745] scsi4 : ata_piix
[    1.870971] scsi5 : ata_piix
[    1.872144] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1810 irq 14
[    1.872205] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
[    2.056058] ata6: port disabled. ignoring.
[    2.056807] Fusion MPT base driver 3.04.07
[    2.056862] Copyright (c) 1999-2008 LSI Corporation
[    2.056931] Fusion MPT SPI Host driver 3.04.07
[    2.057118] Fusion MPT FC Host driver 3.04.07
[    2.057313] Fusion MPT misc device (ioctl) driver 3.04.07
[    2.057518] mptctl: Registered with Fusion MPT base driver
[    2.057578] mptctl: /dev/mptctl @ (major,minor=10,220)
[    2.057757] Yenta: CardBus bridge found at 0000:15:00.0 [17aa:201c]
[    2.185065] Yenta: ISA IRQ mask 0x0cb8, PCI irq 16
[    2.185123] Socket status: 30000006
[    2.185177] pcmcia: parent PCI bridge I/O window: 0x9000 - 0xcfff
[    2.185237] pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
[    2.185298] pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
[    2.185782] pcd: pcd version 1.07, major 46, nice 0
[    2.186566] pcd0: Autoprobe failed
[    2.186621] pcd: No CD-ROM drive found
[    2.187230] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D0
[    2.187301] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    2.187371] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    2.187376] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    2.187576] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    2.191566] ehci_hcd 0000:00:1d.7: debug port 1
[    2.191627] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    2.191648] ehci_hcd 0000:00:1d.7: irq 19, io mem 0xee444000
[    2.204021] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    2.204327] usb usb1: configuration #1 chosen from 1 choice
[    2.204495] hub 1-0:1.0: USB hub found
[    2.204560] hub 1-0:1.0: 8 ports detected
[    2.412486] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.412698] USB Universal Host Controller Interface driver v3.0
[    2.413459] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[    2.413522] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.413589] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    2.413593] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.413762] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    2.413865] uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001820
[    2.414134] usb usb2: configuration #1 chosen from 1 choice
[    2.414307] hub 2-0:1.0: USB hub found
[    2.414370] hub 2-0:1.0: 2 ports detected
[    2.516349] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    2.516416] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    2.516421] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.516582] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    2.516696] uhci_hcd 0000:00:1d.1: irq 17, io base 0x00001840
[    2.516972] usb usb3: configuration #1 chosen from 1 choice
[    2.517148] hub 3-0:1.0: USB hub found
[    2.517210] hub 3-0:1.0: 2 ports detected
[    2.620901] uhci_hcd 0000:00:1d.2: power state changed by ACPI to D0
[    2.620968] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    2.621039] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    2.621044] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.621206] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    2.621321] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
[    2.621595] usb usb4: configuration #1 chosen from 1 choice
[    2.621765] hub 4-0:1.0: USB hub found
[    2.621826] hub 4-0:1.0: 2 ports detected
[    2.724343] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    2.724409] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    2.724414] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.724574] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    2.724677] uhci_hcd 0000:00:1d.3: irq 19, io base 0x00001880
[    2.724943] usb usb5: configuration #1 chosen from 1 choice
[    2.725115] hub 5-0:1.0: USB hub found
[    2.725178] hub 5-0:1.0: 2 ports detected
[    3.044025] usb 5-2: new full speed USB device using uhci_hcd and address 2
[    3.218942] usb 5-2: configuration #1 chosen from 1 choice
[    3.222491] usbcore: registered new interface driver usbserial
[    3.222549] usbserial: USB Serial Driver core
[    3.222685] usbserial: USB Serial support registered for FTDI USB Serial Device
[    3.222872] usbcore: registered new interface driver ftdi_sio
[    3.222930] ftdi_sio: v1.4.3:USB FTDI Serial Converters Driver
[    3.223215] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.234777] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.234842] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.235163] mice: PS/2 mouse device common for all mice
[    3.235568] device-mapper: uevent: version 1.0.3
[    3.235894] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[    3.237135] cpuidle: using governor ladder
[    3.238498] cpuidle: using governor menu
[    3.238791] usbcore: registered new interface driver hiddev
[    3.238981] usbcore: registered new interface driver usbhid
[    3.239041] usbhid: v2.6:USB HID core driver
[    3.239507] Advanced Linux Sound Architecture Driver Version 1.0.17.
[    3.240998] input: AT Translated Set 2 keyboard as /class/input/input3
[    3.241098] ALSA device list:
[    3.241152]   No soundcards found.
[    3.241342] oprofile: using NMI interrupt.
[    3.242300] TCP cubic registered
[    3.242355] NET: Registered protocol family 17
[    3.242423] ieee80211: 802.11 data/management/control stack, git-1.1.13
[    3.242482] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[    3.242558] ieee80211_crypt: registered algorithm 'NULL'
[    3.243741] PM: Resume from partition /dev/sda6
[    3.243744] PM: Checking hibernation image.
[    3.729917] PM: Resume from disk failed.
[    3.730455] Freeing unused kernel memory: 2012k freed
[    3.731445] Write protecting the kernel read-only data: 6716k
[    3.731712] Testing CPA: undo ffffffff80209000-ffffffff80898000
[    3.731945] Testing CPA: again
[    4.008440] uhci_hcd: disagrees about version of symbol struct_module
[    4.009487] ohci_hcd: disagrees about version of symbol struct_module
[    4.010460] ehci_hcd: disagrees about version of symbol struct_module
[    4.173515] jbd: disagrees about version of symbol struct_module
[    4.177408] ext3: disagrees about version of symbol struct_module
[    4.179219] scsi_mod: disagrees about version of symbol struct_module
[    4.180367] sd_mod: disagrees about version of symbol struct_module
[    4.181672] libata: disagrees about version of symbol struct_module
[    4.182722] ahci: disagrees about version of symbol struct_module
[    4.279034] kjournald starting.  Commit interval 5 seconds
[    4.279132] EXT3-fs: mounted filesystem with ordered data mode.
[    9.316781] EXT3 FS on sda7, internal journal
[    9.430216] kjournald starting.  Commit interval 5 seconds
[    9.430465] EXT3 FS on sda3, internal journal
[    9.430480] EXT3-fs: mounted filesystem with ordered data mode.
[   10.388551] Adding 3068372k swap on /dev/sda6.  Priority:-1 extents:1 across:3068372k
[   19.197261] warning: `dbus-daemon' uses deprecated v2 capabilities in a way that may be insecure.
[   27.666622] 0000:02:00.0: eth0: Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   27.666640] 0000:02:00.0: eth0: 10/100 speed: disabling TSO
[   30.568079] CPA self-test:
[   30.568331]  4k 3280 large 245 gb 0 x 3317[ffff880000000000-ffff88001f400000] miss 0
[   30.581133]  4k 108240 large 40 gb 0 x 108072[ffff880000000000-ffff88001f5ff000] miss 0
[   30.591303]  4k 108240 large 40 gb 0 x 108072[ffff880000000000-ffff88001f5ff000] miss 0
[   30.591319] ok.

--=-Yavn649Bixa0+d8vy5+X--

