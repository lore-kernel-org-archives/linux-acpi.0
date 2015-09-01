From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Possible deadlock related to CPU hotplug and kernfs
Date: Tue, 1 Sep 2015 15:12:34 +0800
Message-ID: <55E54FE2.7030601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49142 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbbIAHMh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Sep 2015 03:12:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux hotplug mailing <linux-hotplug@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Rafael and Tejun,
	When running CPU hotplug tests, it triggers an lockdep warning
as follow. The two possible deadlock paths are:
1) echo x > /sys/devices/system/cpu/cpux/online
   ->kernfs_fop_write()
     ->kernfs_get_active()
1.a)   ->rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
         ->cpu_up()
1.b)       ->cpu_hotplug_begin()[lock_map_acquire(&cpu_hotplug.dep_map)]
2) hardware triggers hotplug evetns
   ->acpi_device_hotplug()
     ->acpi_processor_remove()
2.a)   ->cpu_hotplug_begin()[lock_map_acquire(&cpu_hotplug.dep_map)]
         ->unregister_cpu()
           ->device_del()
             ->kernfs_remove_by_name_ns()
               ->__kernfs_remove()
                 ->kernfs_drain()
2.b)               ->rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_)

So there is a possible deadlock scenario among 1.a, 1.b, 2.a and 2.b.
I'm not familiar with kernfs, so could you please help to comment:
1) whether is a real deadlock issue?
2) any recommended way to get it fixed?
Thanks!
Gerry

Full lockdep warnings:
[  310.309391] [ INFO: possible circular locking dependency detected ]
[  310.316462] 4.2.0-rc8+ #7 Not tainted
[  310.320613] -------------------------------------------------------
[  310.327684] kworker/u288:3/388 is trying to acquire lock:
[  310.333780]  (s_active#97){++++.+}, at: [<ffffffff812bd989>]
kernfs_remove_by_name_ns+0x49/0xb0
[  310.343885]
[  310.343885] but task is already holding lock:
[  310.350466]  (cpu_hotplug.lock#2){+.+.+.}, at: [<ffffffff81080aab>]
cpu_hotplug_begin+0x7b/0xc0
[  310.360564]
[  310.360564] which lock already depends on the new lock.
[  310.360564]
[  310.369766]
[  310.369766] the existing dependency chain (in reverse order) is:
[  310.378198]
[  310.378198] -> #3 (cpu_hotplug.lock#2){+.+.+.}:
[  310.383821]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  310.390591]        [<ffffffff818644a0>] mutex_lock_nested+0x70/0x3e0
[  310.397847]        [<ffffffff81080aab>] cpu_hotplug_begin+0x7b/0xc0
[  310.405004]        [<ffffffff81080b61>] _cpu_up+0x31/0x140
[  310.411285]        [<ffffffff81080cec>] cpu_up+0x7c/0xa0
[  310.417362]        [<ffffffff821859cb>] smp_init+0x86/0x88
[  310.423647]        [<ffffffff82160181>] kernel_init_freeable+0x171/0x286
[  310.431292]        [<ffffffff8185228e>] kernel_init+0xe/0xe0
[  310.437771]        [<ffffffff81869e5f>] ret_from_fork+0x3f/0x70
[  310.444540]
[  310.444540] -> #2 (cpu_hotplug.lock){++++++}:
[  310.449957]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  310.456714]        [<ffffffff81080a9d>] cpu_hotplug_begin+0x6d/0xc0
[  310.463871]        [<ffffffff81080b61>] _cpu_up+0x31/0x140
[  310.470143]        [<ffffffff81080cec>] cpu_up+0x7c/0xa0
[  310.476228]        [<ffffffff821859cb>] smp_init+0x86/0x88
[  310.482509]        [<ffffffff82160181>] kernel_init_freeable+0x171/0x286
[  310.490153]        [<ffffffff8185228e>] kernel_init+0xe/0xe0
[  310.496628]        [<ffffffff81869e5f>] ret_from_fork+0x3f/0x70
[  310.503393]
[  310.503393] -> #1 (cpu_add_remove_lock){+.+.+.}:
[  310.509099]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  310.515866]        [<ffffffff811e1134>] __might_fault+0x84/0xb0
[  310.522635]        [<ffffffff812beb6f>] kernfs_fop_write+0x8f/0x190
[  310.529793]        [<ffffffff81233b68>] __vfs_write+0x28/0xe0
[  310.536368]        [<ffffffff812342ac>] vfs_write+0xac/0x1a0
[  310.542833]        [<ffffffff81235049>] SyS_write+0x49/0xb0
[  310.549212]        [<ffffffff818699f2>]
entry_SYSCALL_64_fastpath+0x16/0x7a
[  310.557149]
[  310.557149] -> #0 (s_active#97){++++.+}:
[  310.562135]        [<ffffffff810de269>] __lock_acquire+0x21b9/0x21c0
[  310.569391]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  310.576159]        [<ffffffff812bc7a1>] __kernfs_remove+0x231/0x330
[  310.583318]        [<ffffffff812bd989>]
kernfs_remove_by_name_ns+0x49/0xb0
[  310.591154]        [<ffffffff812bf3c5>] sysfs_remove_file_ns+0x15/0x20
[  310.598594]        [<ffffffff8157490e>] device_remove_attrs+0x3e/0x80
[  310.605948]        [<ffffffff815752a8>] device_del+0x138/0x270
[  310.612617]        [<ffffffff81575402>] device_unregister+0x22/0x70
[  310.619767]        [<ffffffff8157cfa9>] unregister_cpu+0x39/0x60
[  310.626622]        [<ffffffff81023e73>] arch_unregister_cpu+0x23/0x30
[  310.633974]        [<ffffffff814bab67>] acpi_processor_remove+0x91/0xca
[  310.641524]        [<ffffffff814b82e3>] acpi_bus_trim+0x5a/0x8d
[  310.648292]        [<ffffffff814b82c1>] acpi_bus_trim+0x38/0x8d
[  310.655060]        [<ffffffff814b8333>]
acpi_scan_device_not_present+0x1d/0x3d
[  310.663312]        [<ffffffff814b9e05>] acpi_scan_bus_check+0x29/0xa2
[  310.670654]        [<ffffffff814b9f17>] acpi_device_hotplug+0x99/0x3fa
[  310.678103]        [<ffffffff814b33ba>] acpi_hotplug_work_fn+0x1f/0x2b
[  310.685555]        [<ffffffff810a0241>] process_one_work+0x1f1/0x7c0
[  310.692814]        [<ffffffff810a0879>] worker_thread+0x69/0x480
[  310.699677]        [<ffffffff810a71af>] kthread+0x11f/0x140
[  310.706046]        [<ffffffff81869e5f>] ret_from_fork+0x3f/0x70
[  310.712815]
[  310.712815] other info that might help us debug this:
[  310.712815]
[  310.721907] Chain exists of:
[  310.721907]   s_active#97 --> cpu_hotplug.lock --> cpu_hotplug.lock#2
[  310.721907]
[  310.731680]  Possible unsafe locking scenario:
[  310.731680]
[  310.738413]        CPU0                    CPU1
[  310.743562]        ----                    ----
[  310.748710]   lock(cpu_hotplug.lock#2);
[  310.753261]                                lock(cpu_hotplug.lock);
[  310.760382]                                lock(cpu_hotplug.lock#2);
[  310.767755]   lock(s_active#97);
[  310.771625]
[  310.771625]  *** DEADLOCK ***
[  310.771625]
[  310.778382] 7 locks held by kworker/u288:3/388:
[  310.783530]  #0:  ("kacpi_hotplug"){.+.+.+}, at: [<ffffffff810a01b6>]
process_one_work+0x166/0x7c0
[  310.793975]  #1:  ((&hpw->work)){+.+.+.}, at: [<ffffffff810a01b6>]
process_one_work+0x166/0x7c0
[  310.804126]  #2:  (device_hotplug_lock){+.+.+.}, at:
[<ffffffff81575cc7>] lock_device_hotplug+0x17/0x20
[  310.815057]  #3:  (acpi_scan_lock){+.+.+.}, at: [<ffffffff814b9eb4>]
acpi_device_hotplug+0x36/0x3fa
[  310.825599]  #4:  (cpu_add_remove_lock){+.+.+.}, at:
[<ffffffff810807d7>] cpu_maps_update_begin+0x17/0x20
[  310.836727]  #5:  (cpu_hotplug.lock){++++++}, at:
[<ffffffff81080a35>] cpu_hotplug_begin+0x5/0xc0
[  310.847073]  #6:  (cpu_hotplug.lock#2){+.+.+.}, at:
[<ffffffff81080aab>] cpu_hotplug_begin+0x7b/0xc0
[  310.857774]
[  310.857774] stack backtrace:
[  310.862754] CPU: 11 PID: 388 Comm: kworker/u288:3 Not tainted
4.2.0-rc8+ #7
[  310.870628] Hardware name: Intel Corporation BRICKLAND/BRICKLAND,
BIOS BRHSXIN1.86B.0060.R02.1508171754 08/17/2015
[  310.882326] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[  310.888499]  ffffffff82a39b50 ffff88042b9a38d8 ffffffff8185f0b8
0000000000000011
[  310.897130]  ffffffff82afcab0 ffff88042b9a3928 ffffffff8185c183
0000000000000007
[  310.905762]  ffff88042b9a3998 ffff88042b9a3928 ffff88042b99ab08
ffff88042b99a980
[  310.914393] Call Trace:
[  310.917206]  [<ffffffff8185f0b8>] dump_stack+0x4c/0x65
[  310.923039]  [<ffffffff8185c183>] print_circular_bug+0x20b/0x21c
[  310.929843]  [<ffffffff810de269>] __lock_acquire+0x21b9/0x21c0
[  310.936455]  [<ffffffff810260d8>] ? native_sched_clock+0x28/0x90
[  310.943258]  [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  310.949382]  [<ffffffff812bd989>] ? kernfs_remove_by_name_ns+0x49/0xb0
[  310.956769]  [<ffffffff812bc7a1>] __kernfs_remove+0x231/0x330
[  310.963280]  [<ffffffff812bd989>] ? kernfs_remove_by_name_ns+0x49/0xb0
[  310.970669]  [<ffffffff812bbd67>] ? kernfs_name_hash+0x17/0xa0
[  310.977278]  [<ffffffff812bcb81>] ? kernfs_find_ns+0x81/0x140
[  310.983792]  [<ffffffff812bd989>] kernfs_remove_by_name_ns+0x49/0xb0
[  310.990986]  [<ffffffff812bf3c5>] sysfs_remove_file_ns+0x15/0x20
[  310.997791]  [<ffffffff8157490e>] device_remove_attrs+0x3e/0x80
[  311.004498]  [<ffffffff815752a8>] device_del+0x138/0x270
[  311.010524]  [<ffffffff812bd995>] ? kernfs_remove_by_name_ns+0x55/0xb0
[  311.017914]  [<ffffffff81575402>] device_unregister+0x22/0x70
[  311.024427]  [<ffffffff8157cfa9>] unregister_cpu+0x39/0x60
[  311.030646]  [<ffffffff81023e73>] arch_unregister_cpu+0x23/0x30
[  311.037354]  [<ffffffff814bab67>] acpi_processor_remove+0x91/0xca
[  311.044257]  [<ffffffff814b82e3>] acpi_bus_trim+0x5a/0x8d
[  311.050379]  [<ffffffff814b82c1>] acpi_bus_trim+0x38/0x8d
[  311.056501]  [<ffffffff814b8333>] acpi_scan_device_not_present+0x1d/0x3d
[  311.064085]  [<ffffffff814b9e05>] acpi_scan_bus_check+0x29/0xa2
[  311.070791]  [<ffffffff814b9f17>] acpi_device_hotplug+0x99/0x3fa
[  311.077596]  [<ffffffff814b33ba>] acpi_hotplug_work_fn+0x1f/0x2b
[  311.084402]  [<ffffffff810a0241>] process_one_work+0x1f1/0x7c0
[  311.091012]  [<ffffffff810a01b6>] ? process_one_work+0x166/0x7c0
[  311.097815]  [<ffffffff810a0909>] ? worker_thread+0xf9/0x480
[  311.104231]  [<ffffffff810a0879>] worker_thread+0x69/0x480
[  311.110451]  [<ffffffff810a0810>] ? process_one_work+0x7c0/0x7c0
[  311.117256]  [<ffffffff810a71af>] kthread+0x11f/0x140
[  311.122990]  [<ffffffff810a7090>] ? kthread_create_on_node+0x260/0x260
[  311.130379]  [<ffffffff81869e5f>] ret_from_fork+0x3f/0x70
[  311.136502]  [<ffffffff810a7090>] ? kthread_create_on_node+0x260/0x260
