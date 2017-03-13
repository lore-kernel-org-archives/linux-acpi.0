From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [acpi] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 24s!
 [swapper/0:1]
Date: Mon, 13 Mar 2017 09:42:22 +0800
Message-ID: <20170313014222.efwlhhj2xo5b6gkn@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="binx3jgq7t6c5pwx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, LKP <lkp@01.org>
List-Id: linux-acpi@vger.kernel.org


--binx3jgq7t6c5pwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

This is an old bug and cannot be bisected to its root cause.
Perhaps it requires some manual investigation. The attached
reproduce-* may help the debugging.

efdb4167e6  scripts/faddr2line: Fix "size mismatch" error
bb5e5ce545  x86/dumpstack: Remove kernel text addresses from stack dump
106e4da602  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
5be4921c99  Add linux-next specific files for 20170310
+------------------------------------------------+------------+------------+------------+---------------+
|                                                | efdb4167e6 | bb5e5ce545 | 106e4da602 | next-20170310 |
+------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                 | 0          | 0          | 18         | 2             |
| boot_failures                                  | 74         | 18         | 8          | 18            |
| BUG:soft_lockup-CPU##stuck_for#s               | 53         | 17         | 8          | 18            |
| EIP_is_at_raw_spin_unlock_irqrestore           | 52         |            |            |               |
| calltrace:virtio_pci_driver_init               | 53         |            |            |               |
| Kernel_panic-not_syncing:softlockup:hung_tasks | 53         | 17         | 8          | 18            |
| BUG:unable_to_handle_kernel                    | 21         | 1          |            |               |
| Oops:#[##]                                     | 21         | 1          |            |               |
| EIP_is_at_i2c_do_del_adapter                   | 21         |            |            |               |
| calltrace:of_unittest                          | 21         |            |            |               |
| Kernel_panic-not_syncing:Fatal_exception       | 21         | 1          |            |               |
| EIP_is_at_kmem_cache_alloc                     | 1          |            |            |               |
| EIP:_raw_spin_unlock_irqrestore                | 0          | 17         | 8          | 16            |
| EIP:i2c_do_del_adapter                         | 0          | 1          |            |               |
| EIP:acpi_ut_update_ref_count                   | 0          | 0          | 0          | 1             |
| EIP:kmem_cache_alloc                           | 0          | 0          | 0          | 1             |
+------------------------------------------------+------------+------------+------------+---------------+

[   12.055229] isapnp: No Plug & Play device found
[   14.198035] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[   22.614543] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[   31.724849] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[   40.140941] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[   65.545954] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 24s! [swapper/0:1]
[   65.547202] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc1-00121-gbb5e5ce5 #1
[   65.548373] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[   65.549994] task: b02c9000 task.stack: b02d4000
[   65.550724] EIP: _raw_spin_unlock_irqrestore+0x76/0xc0
[   65.551525] EFLAGS: 00200246 CPU: 0
[   65.552082] EAX: 00200246 EBX: 00200246 ECX: 00000000 EDX: 00000000
[   65.553054] ESI: b39c5ac0 EDI: 00000016 EBP: b02d5b60 ESP: b02d5b58
[   65.554075]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[   65.554919] CR0: 80050033 CR2: 00000000 CR3: 0424c000 CR4: 000406d0
[   65.555897] Stack:
[   65.556223]  b39c5adc b39c5af0 b02d5b8c b13f8385 00200246 024080c0 00000008 c25ee59c
[   65.557654]  0000002c 00000000 00000001 002887d5 b02a42d0 b02d5bc4 b13fbaa9 b02d5bb0
[   65.559038]  b11c5203 00000000 b02a4518 00000000 00000000 b02d5bc0 024080c0 00200246
[   65.560465] Call Trace:
[   65.560871]  slob_alloc+0x3c5/0x6f0
[   65.561481]  kmem_cache_alloc+0x5a9/0xb60
[   65.562080]  ? do_raw_spin_lock+0x1a3/0x420
[   65.562703]  acpi_ut_create_generic_state+0xa3/0x10b
[   65.563484]  acpi_ut_create_update_state+0x35/0x90
[   65.564193]  acpi_ut_create_update_state_and_push+0x76/0xe7
[   65.565012]  acpi_ut_update_object_reference+0x274/0x534
[   65.565793]  acpi_ut_add_reference+0x123/0x136
[   65.566487]  acpi_ds_method_data_get_value+0x38f/0x3cf
[   65.567245]  acpi_ex_resolve_to_value+0x1e3/0x970
[   65.567938]  acpi_ex_resolve_operands+0x8cd/0x14f9
[   65.568643]  acpi_ds_exec_end_op+0x2ec/0x1417
[   65.569288]  acpi_ps_parse_loop+0x1502/0x1667
[   65.569980]  ? acpi_ut_trace+0x32/0xff
[   65.570538]  acpi_ps_parse_aml+0x467/0xd50
[   65.571161]  acpi_ps_execute_method+0x54f/0x733
[   65.571836]  acpi_ns_evaluate+0x677/0x9c5
[   65.572429]  acpi_ut_evaluate_object+0x175/0x596
[   65.573158]  acpi_rs_get_prt_method_data+0x59/0x12f
[   65.573878]  acpi_get_irq_routing_table+0xcc/0x10f
[   65.574578]  acpi_pci_irq_find_prt_entry+0x20a/0x7c7
[   65.575315]  acpi_pci_irq_lookup+0x30/0x705
[   65.575937]  acpi_pci_irq_disable+0x110/0x21e
[   65.576625]  pcibios_disable_device+0x4d/0x80
[   65.577270]  do_pci_disable_device+0xb2/0xf0
[   65.577904]  pci_disable_device+0x265/0x290
[   65.578523]  ? virtio_pci_modern_remove+0xd4/0x130
[   65.579235]  virtio_pci_remove+0xa2/0x100
[   65.579877]  pci_device_remove+0x12a/0x140
[   65.580481]  driver_probe_device+0x397/0xb10
[   65.581113]  __driver_attach+0x29f/0x2c0
[   65.581699]  ? driver_probe_device+0xb10/0xb10
[   65.582348]  bus_for_each_dev+0xe4/0x170
[   65.582931]  driver_attach+0x2c/0x40
[   65.583514]  ? driver_probe_device+0xb10/0xb10
[   65.584171]  bus_add_driver+0x2fd/0x620
[   65.584742]  driver_register+0x131/0x380
[   65.585324]  ? __raw_spin_lock_init+0x52/0x90
[   65.585968]  ? virtio_mmio_init+0x2d/0x2d
[   65.586604]  __pci_register_driver+0x66/0x80
[   65.587249]  virtio_pci_driver_init+0x22/0x32
[   65.587897]  do_one_initcall+0x12c/0x2de
[   65.588481]  ? kernel_init_freeable+0x23c/0x42b
[   65.589152]  kernel_init_freeable+0x26a/0x42b
[   65.589846]  ? rest_init+0x180/0x180
[   65.590372]  kernel_init+0x1f/0x360
[   65.590895]  ? schedule_tail_wrapper+0x9/0xc
[   65.591520]  ? rest_init+0x180/0x180
[   65.592059]  ret_from_fork+0x19/0x24
[   65.592584] Code: 21 da 32 fe 83 05 b0 ba 85 b4 01 89 f0 83 15 b4 ba 85 b4 00 e8 6c 53 33 fe 83 05 b8 ba 85 b4 01 89 d8 83 15 bc ba 85 b4 00 50 9d <8d> 74 26 00 83 05 c0 ba 85 b4 01 83 15 c4 ba 85 b4 00 83 05 c8
[   65.596837] Kernel panic - not syncing: softlockup: hung tasks
[   65.597685] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G             L  4.9.0-rc1-00121-gbb5e5ce5 #1
[   65.598959] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[   65.600473]  b02d5a24 b1f8dca4 00200046 00000000 00000001 00000000 b02d5a3c b1322da2
[   65.601774]  00000001 00000000 00000001 b02c9000 b02d5a70 b1293edb b379a907 00000000
[   65.603072]  00000018 b02c938c 00000001 b02d5b1c 00000000 00000000 00000001 c2597640
[   65.604427] Call Trace:
[   65.604806]  dump_stack+0x153/0x1cf
[   65.605329]  panic+0x1a9/0x598
[   65.605800]  watchdog_timer_fn+0x5db/0x670
[   65.606402]  hrtimer_run_queues+0x9b5/0x1340
[   65.607092]  ? watchdog+0xa0/0xa0
[   65.607584]  run_local_timers+0x36/0x110
[   65.608171]  update_process_times+0x3d/0xe0
[   65.608799]  tick_nohz_handler+0x173/0x300
[   65.609403]  local_apic_timer_interrupt+0x6a/0xd0
[   65.610145]  smp_apic_timer_interrupt+0x79/0xb0
[   65.610815]  apic_timer_interrupt+0x32/0x38
[   65.611435] EIP: _raw_spin_unlock_irqrestore+0x76/0xc0
[   65.612188] EFLAGS: 00200246 CPU: 0
[   65.612710] EAX: 00200246 EBX: 00200246 ECX: 00000000 EDX: 00000000
[   65.613657] ESI: b39c5ac0 EDI: 00000016 EBP: b02d5b60 ESP: b02d5b58
[   65.614562]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[   65.615358]  ? l_show+0x228/0x230
[   65.615858]  slob_alloc+0x3c5/0x6f0
[   65.616508]  kmem_cache_alloc+0x5a9/0xb60
[   65.617104]  ? do_raw_spin_lock+0x1a3/0x420
[   65.617727]  acpi_ut_create_generic_state+0xa3/0x10b
[   65.618454]  acpi_ut_create_update_state+0x35/0x90
[   65.619173]  acpi_ut_create_update_state_and_push+0x76/0xe7
[   65.620051]  acpi_ut_update_object_reference+0x274/0x534
[   65.620830]  acpi_ut_add_reference+0x123/0x136
[   65.621479]  acpi_ds_method_data_get_value+0x38f/0x3cf
[   65.622240]  acpi_ex_resolve_to_value+0x1e3/0x970
[   65.622936]  acpi_ex_resolve_operands+0x8cd/0x14f9
[   65.623682]  acpi_ds_exec_end_op+0x2ec/0x1417
[   65.624329]  acpi_ps_parse_loop+0x1502/0x1667
[   65.624979]  ? acpi_ut_trace+0x32/0xff
[   65.625532]  acpi_ps_parse_aml+0x467/0xd50
[   65.626141]  acpi_ps_execute_method+0x54f/0x733
[   65.626857]  acpi_ns_evaluate+0x677/0x9c5
[   65.627454]  acpi_ut_evaluate_object+0x175/0x596
[   65.628135]  acpi_rs_get_prt_method_data+0x59/0x12f
[   65.628856]  acpi_get_irq_routing_table+0xcc/0x10f
[   65.629557]  acpi_pci_irq_find_prt_entry+0x20a/0x7c7
[   65.630332]  acpi_pci_irq_lookup+0x30/0x705
[   65.630956]  acpi_pci_irq_disable+0x110/0x21e
[   65.631604]  pcibios_disable_device+0x4d/0x80
[   65.632259]  do_pci_disable_device+0xb2/0xf0
[   65.632893]  pci_disable_device+0x265/0x290
[   65.635170]  ? virtio_pci_modern_remove+0xd4/0x130
[   65.635936]  virtio_pci_remove+0xa2/0x100
[   65.636577]  pci_device_remove+0x12a/0x140
[   65.637177]  driver_probe_device+0x397/0xb10
[   65.637829]  __driver_attach+0x29f/0x2c0
[   65.638395]  ? driver_probe_device+0xb10/0xb10
[   65.639034]  bus_for_each_dev+0xe4/0x170
[   65.639631]  driver_attach+0x2c/0x40
[   65.641178]  ? driver_probe_device+0xb10/0xb10
[   65.641715]  bus_add_driver+0x2fd/0x620
[   65.642175]  driver_register+0x131/0x380
[   65.642640]  ? __raw_spin_lock_init+0x52/0x90
[   65.643353]  ? virtio_mmio_init+0x2d/0x2d
[   65.643842]  __pci_register_driver+0x66/0x80
[   65.644356]  virtio_pci_driver_init+0x22/0x32
[   65.644888]  do_one_initcall+0x12c/0x2de
[   65.645354]  ? kernel_init_freeable+0x23c/0x42b
[   65.645903]  kernel_init_freeable+0x26a/0x42b
[   65.646419]  ? rest_init+0x180/0x180
[   65.646897]  kernel_init+0x1f/0x360
[   65.647431]  ? schedule_tail_wrapper+0x9/0xc
[   65.648050]  ? rest_init+0x180/0x180
[   65.648587]  ret_from_fork+0x19/0x24
[   65.649232] Kernel Offset: disabled


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.10 v4.9 --
git bisect  bad 9e3596b0c6539e28546ff7c72a06576627068353  # 14:25  B      3     7    0   0  kbuild: initramfs cleanup, set target from Kconfig
git bisect  bad 5e176d6973bdac04d9f298ca384c39f08eb084cb  # 14:54  B      1     2    0   0  Merge tag 'for-linus-4.10-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
git bisect  bad 098c30557a9a19827240aaadc137e4668157dc6b  # 15:10  B      1     1    1   1  Merge tag 'driver-core-4.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect  bad e71c3978d6f97659f6c3ee942c3e581299e4adf2  # 15:21  B      0     1   11   0  Merge branch 'smp-hotplug-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 92c020d08d83673ecd15a9069d4457378668da31  # 15:50  G     17     0   17  17  Merge branch 'sched-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad ef486c599a1f20c465ea196cd2019474708fbe52  # 16:04  B      1     4    1   1  Merge branch 'x86-cleanups-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 4ade5b2268b9ff05e48a9cb99689c4fd15fbe9c3  # 16:28  G     17     0   11  11  Merge branch 'x86-apic-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 06cc6b969c6375c65d0abbe4113af7949da29ab8  # 16:51  B      0     4   14   0  Merge branch 'x86-boot-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 5645688f9d0d5a32f030f9c5429e1a58bedca23b  # 17:02  B      1     9    1   1  Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 0ee1dd9f5e7eae4e55f95935b72d4beecb03de9c  # 17:15  B      2    16    2   2  x86/dumpstack: Remove raw stack dump
git bisect good e728f61ce05404a26447e6bbc1885ca5956d6a44  # 17:40  G     18     0   18  18  x86/boot: Move the _stext marker to before the boot code
git bisect good 3b3fa11bc7000bb86c9fd30703da3689a9a9758d  # 18:11  G     18     0   18  18  x86/dumpstack: Print any pt_regs found on the stack
git bisect good 5e25d5bdf6d407224ad185a3fb8b870ad7d6c627  # 18:28  G     17     0   17  17  x86/entry64: Remove unused audit related macros
git bisect  bad bb5e5ce545f2031c96f7901cd8d1698ea3ca4c9c  # 18:40  B      0     7   17   0  x86/dumpstack: Remove kernel text addresses from stack dump
git bisect good efdb4167e676aaba7505bec739785b76e206cb45  # 18:57  G     17     0   17  17  scripts/faddr2line: Fix "size mismatch" error
# first bad commit: [bb5e5ce545f2031c96f7901cd8d1698ea3ca4c9c] x86/dumpstack: Remove kernel text addresses from stack dump
git bisect good efdb4167e676aaba7505bec739785b76e206cb45  # 19:20  G     52     0   52  69  scripts/faddr2line: Fix "size mismatch" error
# extra tests with CONFIG_DEBUG_INFO_REDUCED
git bisect good bb5e5ce545f2031c96f7901cd8d1698ea3ca4c9c  # 19:35  G     18     0   18  18  x86/dumpstack: Remove kernel text addresses from stack dump
# extra tests on HEAD of linux-devel/devel-spot-201703121227
git bisect  bad 82e79ed967147fd85df0025b2364a920c2b32ef8  # 19:35  B      2     9    0   3  0day head guard for 'devel-spot-201703121227'
# extra tests on tree/branch linus/master
git bisect  bad 106e4da60209b508894956b6adf4688f84c1766d  # 20:13  B      4     3    0   0  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
# extra tests with first bad commit reverted
git bisect good ff74cea317355ada8f85574b09e78b4aa8c8fa22  # 20:29  G     18     0   10  10  Revert "x86/dumpstack: Remove kernel text addresses from stack dump"
# extra tests on tree/branch linux-next/master
git bisect  bad 5be4921c9958ec02a67506bd6f7a52fce663c201  # 20:46  B      2    11    2   2  Add linux-next specific files for 20170310

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--binx3jgq7t6c5pwx
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-kbuild-58:20170312183949:i386-randconfig-c0-03121244:4.9.0-rc1-00121-gbb5e5ce5:1.gz"
Content-Transfer-Encoding: base64

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

--binx3jgq7t6c5pwx
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-kbuild-11:20170312185919:i386-randconfig-c0-03121244:4.9.0-rc1-00120-gefdb416:1.gz"
Content-Transfer-Encoding: base64

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

--binx3jgq7t6c5pwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-kbuild-58:20170312183949:i386-randconfig-c0-03121244:4.9.0-rc1-00121-gbb5e5ce5:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 300
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	console=tty0
	vga=normal
	rw
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"

--binx3jgq7t6c5pwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.9.0-rc1-00121-gbb5e5ce5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.9.0-rc1 Kernel Configuration
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DEBUG_RODATA=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_DEBUG=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
CONFIG_TREE_RCU_TRACE=y
CONFIG_RCU_KTHREAD_PRIO=0
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_NONE is not set
# CONFIG_RCU_NOCB_CPU_ZERO is not set
CONFIG_RCU_NOCB_CPU_ALL=y
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_NMI_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIGSMP=y
CONFIG_GOLDFISH=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
CONFIG_STA2X11=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_LGUEST_GUEST is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
CONFIG_MK8=y
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xB0000000
CONFIG_HIGHMEM=y
CONFIG_NEED_NODE_MEMMAP_SIZE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_HIGHPTE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR_CSTATE=y
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEAER_INJECT=y
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_HT_IRQ is not set
CONFIG_PCI_ATS=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI host controller drivers
#
# CONFIG_PCIE_DW_PLAT is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
# CONFIG_YENTA_TOSHIBA is not set
CONFIG_PD6729=y
CONFIG_I82092=y
# CONFIG_I82365 is not set
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_X86_DMA_REMAP=y
CONFIG_PMC_ATOM=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_RFKILL_REGULATOR is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_NFC is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_DST_CACHE is not set
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_QCOM_EBI2 is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PHYSMAP_OF_VERSATILE is not set
# CONFIG_MTD_SCx200_DOCFLASH is not set
CONFIG_MTD_PCI=y
CONFIG_MTD_PCMCIA=y
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
CONFIG_MTD_GPIO_ADDR=y
CONFIG_MTD_INTEL_VR_NOR=y
# CONFIG_MTD_PLATRAM is not set
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=y
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
CONFIG_BLK_CPQ_CISS_DA=y
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_UMEM=y
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_RAM_DAX is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
CONFIG_BLK_DEV_HD=y
CONFIG_BLK_DEV_RSXX=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_CS5535_MFGPT=y
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=y

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
# CONFIG_SCSI_OSD_ULD is not set
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_NETDEVICES is not set
CONFIG_NVM=y
# CONFIG_NVM_DEBUG is not set
# CONFIG_NVM_GENNVM is not set
CONFIG_NVM_RRPC=y

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_TPM=y
CONFIG_NVRAM=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
# CONFIG_XILLYBUS_OF is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_EG20T=y
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_DEVRES=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_AXP209=y
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_STA2X11 is not set
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_ZX is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_SX150X=y
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_CS5535 is not set
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_JANZ_TTL=y
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM8350 is not set

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y

#
# SPI or I2C GPIO expanders
#
CONFIG_GPIO_MCP23S08=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_BQ27000=y
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_MAX8925_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_AXP20X_POWER=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_QORIQ_THERMAL=y
CONFIG_INTEL_POWERCLAMP=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_QCOM_SPMI_TEMP_ALARM=y
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_SILENT is not set
CONFIG_SSB_DEBUG=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_STA2X11=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8925=y
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_WM8350=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_RC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_VIDEO_TUNER=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_DVB_CORE=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture/analog TV support
#
CONFIG_VIDEO_HEXIUM_GEMINI=y
# CONFIG_VIDEO_HEXIUM_ORION is not set
CONFIG_VIDEO_MXB=y
CONFIG_VIDEO_DT3155=y

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX25821 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_SAA7164 is not set

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
CONFIG_DVB_BUDGET_CORE=y
# CONFIG_DVB_BUDGET is not set
# CONFIG_DVB_BUDGET_AV is not set
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
# CONFIG_DVB_PLUTO2 is not set
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
# CONFIG_DVB_NGENE is not set
# CONFIG_DVB_DDBRIDGE is not set
CONFIG_DVB_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_SMS_SIANO_MDTV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_MT9M111 is not set

#
# Flash devices
#

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=y

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
CONFIG_VIDEO_M52790=y

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
# CONFIG_MEDIA_TUNER_TDA827X is not set
# CONFIG_MEDIA_TUNER_TDA18271 is not set
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
# CONFIG_MEDIA_TUNER_XC2028 is not set
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
# CONFIG_DVB_STV090x is not set
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24123=y
# CONFIG_DVB_MT312 is not set
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_STV0288 is not set
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
CONFIG_DVB_SP887X=y
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
CONFIG_DVB_S5H1432=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=y
# CONFIG_DVB_TDA1004X is not set
# CONFIG_DVB_NXT6000 is not set
# CONFIG_DVB_MT352 is not set
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
# CONFIG_DVB_DIB3000MC is not set
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_EC100=y
CONFIG_DVB_HD29L2=y
CONFIG_DVB_STV0367=y
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_SI2168=y
# CONFIG_DVB_AS102_FE is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
# CONFIG_DVB_STV0297 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
# CONFIG_DVB_LGDT3306A is not set
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
CONFIG_DVB_DIB8000=y
# CONFIG_DVB_MB86A20S is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBP21=y
# CONFIG_DVB_LNBP22 is not set
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=y
CONFIG_DVB_SP2=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_TDA665x=y
# CONFIG_DVB_IX2505V is not set
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_HELENE=y

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
# CONFIG_FB_AUO_K1900 is not set
# CONFIG_FB_AUO_K1901 is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_MAX8925=y
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_VGASTATE=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=y
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_PWRSEQ_EMMC is not set
# CONFIG_PWRSEQ_SIMPLE is not set

#
# MMC/SD/SDIO Card Drivers
#
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_F_SDH30=y
CONFIG_MMC_WBSD=y
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_SDRICOH_CS is not set
CONFIG_MMC_CB710=y
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y

#
# LED drivers
#
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_DECODE_MCE is not set
# CONFIG_EDAC_MM_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_HWMON is not set
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_RK808=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
CONFIG_RTC_DS1685_SYSFS_REGS=y
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_SNVS=y
# CONFIG_RTC_DRV_MT6397 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
# CONFIG_TIMB_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
# CONFIG_SLICOSS is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=y

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7152=y
CONFIG_AD7746=y

#
# Direct Digital Synthesis
#

#
# Digital gyroscope sensors
#

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y

#
# Light sensors
#
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_TSL2583=y
CONFIG_TSL2x7x=y

#
# Active energy metering IC
#
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y

#
# Resolver to digital converters
#

#
# Triggers - standalone
#
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_STAGING_BOARD is not set
CONFIG_GOLDFISH_AUDIO=y
CONFIG_MTD_GOLDFISH_NAND=y
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_MOST=y
CONFIG_MOSTCORE=y
# CONFIG_AIM_CDEV is not set
# CONFIG_AIM_NETWORK is not set
# CONFIG_AIM_V4L2 is not set
# CONFIG_HDM_I2C is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=y
CONFIG_GREYBUS_BOOTROM=y
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=y
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
# CONFIG_GREYBUS_GPIO is not set
CONFIG_GREYBUS_I2C=y
CONFIG_GREYBUS_PWM=y
# CONFIG_GREYBUS_SDIO is not set
# CONFIG_GREYBUS_UART is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_CHARDEV is not set
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_RK808=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8173 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_QCOM_SPMI_MISC=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_BMA180 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
CONFIG_AD799X=y
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
CONFIG_INA2XX_ADC=y
CONFIG_LTC2485=y
CONFIG_MAX1363=y
CONFIG_MCP3422=y
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_STX104 is not set
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_AM335X_ADC=y
# CONFIG_VF610_ADC is not set

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=y

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
CONFIG_CIO_DAC=y
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_I2C is not set

#
# Light sensors
#
CONFIG_ACPI_ALS=y
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM36651 is not set
CONFIG_GP2AP020A00F=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_MAX44000=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1145 is not set
CONFIG_STK3310=y
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=y

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_DS1803 is not set
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y

#
# Pressure sensors
#
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_HP03=y
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_SX9500=y

#
# Temperature sensors
#
CONFIG_MLX90614=y
CONFIG_TMP006=y
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
# CONFIG_VME_USER is not set
CONFIG_VME_PIO2=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
# CONFIG_PWM_PCA9685 is not set
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DEV_DAX=y
CONFIG_NR_DEV_DAX=32768
CONFIG_NVMEM=y
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set

#
# FPGA Configuration Support
#
CONFIG_FPGA=y

#
# Firmware Drivers
#
# CONFIG_ARM_SCPI_PROTOCOL is not set
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
CONFIG_GOOGLE_SMI=y
CONFIG_GOOGLE_MEMCONSOLE=y

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
# CONFIG_EFI_RUNTIME_MAP is not set
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
# CONFIG_EFI_CAPSULE_LOADER is not set
CONFIG_EFI_TEST=y

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_DEBUG=y
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FS_ENCRYPTION=y
CONFIG_F2FS_IO_TRACE=y
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
CONFIG_HFSPLUS_FS_POSIX_ACL=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_LOGFS is not set
CONFIG_CRAMFS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
# CONFIG_ROMFS_BACKED_BY_MTD is not set
CONFIG_ROMFS_BACKED_BY_BOTH=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_ZLIB_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=y
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_CPU_NOTIFIER_ERROR_INJECT is not set
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_UPROBE_EVENT is not set
# CONFIG_PROBE_EVENTS is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_ENUM_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set

#
# Runtime Testing
#
CONFIG_LKDTM=y
CONFIG_TEST_LIST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_TEST_HEXDUMP=y
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_KPP2=y
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_UCS2_STRING=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_SBITMAP=y

--binx3jgq7t6c5pwx--
