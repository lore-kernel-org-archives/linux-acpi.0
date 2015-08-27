From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Lockdep warnings triggered by CPU hotplug
Date: Thu, 27 Aug 2015 15:31:49 +0800
Message-ID: <55DEBCE5.4000404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37284 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbbH0Hbw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Aug 2015 03:31:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Rafael,
	With the latest v4.2-rc8, socket hot-removal triggers following
lockdep warning. I will dig more, but any help are welcomed!
Thanks!
Gerry
[  294.957923] ======================================================
[  294.966401] [ INFO: possible circular locking dependency detected ]
[  294.974959] 4.2.0-rc8+ #6 Not tainted
[  294.979614] -------------------------------------------------------
[  294.986696] kworker/u288:3/627 is trying to acquire lock:
[  294.992799]  (cpu_add_remove_lock){+.+.+.}, at: [<ffffffff818536c2>]
cpu_down+0x22/0x50
[  295.007000]
[  295.007000] but task is already holding lock:
[  295.013593]  (&device->physical_node_lock){+.+.+.}, at:
[<ffffffff814b7acb>] acpi_bus_offline+0x73/0x107
[  295.024706]
[  295.024706] which lock already depends on the new lock.
[  295.024706]
[  295.034007]
[  295.034007] the existing dependency chain (in reverse order) is:
[  295.042503]
[  295.042503] -> #3 (&device->physical_node_lock){+.+.+.}:
[  295.049034]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  295.055831]        [<ffffffff81864430>] mutex_lock_nested+0x70/0x3e0
[  295.063111]        [<ffffffff814b713d>] acpi_companion_match+0x49/0x80
[  295.070581]        [<ffffffff814b8482>] acpi_match_device+0x16/0x27
[  295.077762]        [<ffffffff814bf719>]
acpi_lpss_platform_notify+0x27/0x108
[  295.085910]        [<ffffffff810a873d>] notifier_call_chain+0x5d/0x80
[  295.093288]        [<ffffffff810a8951>]
__blocking_notifier_call_chain+0x51/0x70
[  295.101749]        [<ffffffff810a8986>]
blocking_notifier_call_chain+0x16/0x20
[  295.110025]        [<ffffffff815767ef>] device_add+0x49f/0x6a0
[  295.116714]        [<ffffffff8157bfcf>] platform_device_add+0xcf/0x280
[  295.124187]        [<ffffffff8157c888>]
platform_device_register_full+0xe8/0x110
[  295.132658]        [<ffffffff814c027b>]
acpi_create_platform_device+0x18e/0x1ff
[  295.141249]        [<ffffffff814b825b>]
acpi_default_enumeration+0x4c/0x55
[  295.149107]        [<ffffffff814b9cc9>] acpi_bus_attach+0x166/0x173
[  295.156277]        [<ffffffff814b9c91>] acpi_bus_attach+0x12e/0x173
[  295.163446]        [<ffffffff814b9c91>] acpi_bus_attach+0x12e/0x173
[  295.170625]        [<ffffffff814b9dd1>] acpi_bus_scan+0x61/0x6c
[  295.177414]        [<ffffffff821a733c>] acpi_scan_init+0x7e/0x1b4
[  295.184402]        [<ffffffff821a7124>] acpi_init+0x259/0x276
[  295.190997]        [<ffffffff81002143>] do_one_initcall+0xd3/0x200
[  295.198110]        [<ffffffff82160209>] kernel_init_freeable+0x1f9/0x286
[  295.205833]        [<ffffffff8185228e>] kernel_init+0xe/0xe0
[  295.212334]        [<ffffffff81869ddf>] ret_from_fork+0x3f/0x70
[  295.219128]
[  295.219128] -> #2 (&(&priv->bus_notifier)->rwsem){.+.+.+}:
[  295.225859]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  295.232649]        [<ffffffff81866941>] down_read+0x51/0xa0
[  295.239050]        [<ffffffff810a8939>]
__blocking_notifier_call_chain+0x39/0x70
[  295.247519]        [<ffffffff810a8986>]
blocking_notifier_call_chain+0x16/0x20
[  295.255795]        [<ffffffff815767ef>] device_add+0x49f/0x6a0
[  295.262489]        [<ffffffff8157bfcf>] platform_device_add+0xcf/0x280
[  295.270103]        [<ffffffffa0123a4a>] get_core_online+0xca/0x1a0
[coretemp]
[  295.278264]        [<ffffffffa013c069>] crypt_iv_tcw_ctr+0x89/0xd0
[dm_crypt]
[  295.286417]        [<ffffffff81002143>] do_one_initcall+0xd3/0x200
[  295.293499]        [<ffffffff8185ccc5>] do_init_module+0x61/0x1ec
[  295.300474]        [<ffffffff81129838>] load_module+0x2288/0x2840
[  295.307463]        [<ffffffff81129ff0>] SyS_finit_module+0x80/0xb0
[  295.314546]        [<ffffffff81869972>]
entry_SYSCALL_64_fastpath+0x16/0x7a
[  295.322503]
[  295.322503] -> #1 (pdev_list_mutex){+.+.+.}:
[  295.327866]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  295.334900]        [<ffffffff81864430>] mutex_lock_nested+0x70/0x3e0
[  295.342194]        [<ffffffffa0123034>] coretemp_get_pdev+0x34/0x90
[coretemp]
[  295.350470]        [<ffffffffa01239b3>] get_core_online+0x33/0x1a0
[coretemp]
[  295.358622]        [<ffffffffa013c069>] crypt_iv_tcw_ctr+0x89/0xd0
[dm_crypt]
[  295.366777]        [<ffffffff81002143>] do_one_initcall+0xd3/0x200
[  295.373857]        [<ffffffff8185ccc5>] do_init_module+0x61/0x1ec
[  295.380838]        [<ffffffff81129838>] load_module+0x2288/0x2840
[  295.387822]        [<ffffffff81129ff0>] SyS_finit_module+0x80/0xb0
[  295.394992]        [<ffffffff81869972>]
entry_SYSCALL_64_fastpath+0x16/0x7a
[  295.402951]
[  295.402951] -> #0 (cpu_add_remove_lock){+.+.+.}:
[  295.408701]        [<ffffffff810de269>] __lock_acquire+0x21b9/0x21c0
[  295.415975]        [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  295.422764]        [<ffffffff81864430>] mutex_lock_nested+0x70/0x3e0
[  295.430041]        [<ffffffff818536c2>] cpu_down+0x22/0x50
[  295.436341]        [<ffffffff8157caf4>] cpu_subsys_offline+0x14/0x20
[  295.443617]        [<ffffffff815770c0>] device_offline+0x90/0xb0
[  295.450502]        [<ffffffff814b7b07>] acpi_bus_offline+0xaf/0x107
[  295.457792]        [<ffffffff814d60bf>] acpi_ns_walk_namespace+0xdf/0x18f
[  295.465558]        [<ffffffff814d65b8>] acpi_walk_namespace+0x9d/0xd1
[  295.472934]        [<ffffffff814ba085>] acpi_device_hotplug+0x207/0x3fa
[  295.480503]        [<ffffffff814b33ba>] acpi_hotplug_work_fn+0x1f/0x2b
[  295.487976]        [<ffffffff810a0241>] process_one_work+0x1f1/0x7c0
[  295.495253]        [<ffffffff810a0879>] worker_thread+0x69/0x480
[  295.502141]        [<ffffffff810a71af>] kthread+0x11f/0x140
[  295.508533]        [<ffffffff81869ddf>] ret_from_fork+0x3f/0x70
[  295.515323]
[  295.515323] other info that might help us debug this:
[  295.515323]
[  295.524542] Chain exists of:
[  295.524542]   cpu_add_remove_lock --> &(&priv->bus_notifier)->rwsem
--> &device->physical_node_lock
[  295.524542]
[  295.537206]  Possible unsafe locking scenario:
[  295.537206]
[  295.543949]        CPU0                    CPU1
[  295.549106]        ----                    ----
[  295.554266]   lock(&device->physical_node_lock);
[  295.559654]
lock(&(&priv->bus_notifier)->rwsem);
[  295.568094]
lock(&device->physical_node_lock);
[  295.576313]   lock(cpu_add_remove_lock);
[  295.580946]
[  295.580946]  *** DEADLOCK ***
[  295.580946]
[  295.587807] 6 locks held by kworker/u288:3/627:
[  295.592966]  #0:  ("kacpi_hotplug"){.+.+.+}, at: [<ffffffff810a01b6>]
process_one_work+0x166/0x7c0
[  295.603465]  #1:  ((&hpw->work)){+.+.+.}, at: [<ffffffff810a01b6>]
process_one_work+0x166/0x7c0
[  295.613679]  #2:  (device_hotplug_lock){+.+.+.}, at:
[<ffffffff81575cc7>] lock_device_hotplug+0x17/0x20
[  295.624668]  #3:  (acpi_scan_lock){+.+.+.}, at: [<ffffffff814b9eb4>]
acpi_device_hotplug+0x36/0x3fa
[  295.635266]  #4:  (&device->physical_node_lock){+.+.+.}, at:
[<ffffffff814b7acb>] acpi_bus_offline+0x73/0x107
[  295.646972]  #5:  (&dev->mutex){......}, at: [<ffffffff81577082>]
device_offline+0x52/0xb0
[  295.656694]
[  295.656694] stack backtrace:
[  295.661682] CPU: 16 PID: 627 Comm: kworker/u288:3 Not tainted
4.2.0-rc8+ #6
[  295.669569] Hardware name: Intel Corporation BRICKLAND/BRICKLAND,
BIOS BRHSXIN1.86B.0060.R02.1508171754 08/17/2015
[  295.681278] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[  295.687485]  ffffffff82a99020 ffff88042a31b908 ffffffff8185f048
0000000000000011
[  295.696159]  ffffffff82a389e0 ffff88042a31b958 ffffffff8185c113
0000000000000005
[  295.704835]  ffff88042a31b9c8 ffff88042a31b958 ffff88042a2d5450
ffff88042a2d5300
[  295.713754] Call Trace:
[  295.716581]  [<ffffffff8185f048>] dump_stack+0x4c/0x65
[  295.722426]  [<ffffffff8185c113>] print_circular_bug+0x20b/0x21c
[  295.729245]  [<ffffffff810de269>] __lock_acquire+0x21b9/0x21c0
[  295.735867]  [<ffffffff810df04d>] lock_acquire+0xdd/0x2a0
[  295.741995]  [<ffffffff818536c2>] ? cpu_down+0x22/0x50
[  295.747840]  [<ffffffff81864430>] mutex_lock_nested+0x70/0x3e0
[  295.754462]  [<ffffffff818536c2>] ? cpu_down+0x22/0x50
[  295.760306]  [<ffffffff810dbd6d>] ? trace_hardirqs_on+0xd/0x10
[  295.766927]  [<ffffffff818536c2>] ? cpu_down+0x22/0x50
[  295.772844]  [<ffffffff81577082>] ? device_offline+0x52/0xb0
[  295.779272]  [<ffffffff81851d33>] ? klist_next+0x123/0x130
[  295.785504]  [<ffffffff81577082>] ? device_offline+0x52/0xb0
[  295.791929]  [<ffffffff818536c2>] cpu_down+0x22/0x50
[  295.797577]  [<ffffffff8157caf4>] cpu_subsys_offline+0x14/0x20
[  295.804200]  [<ffffffff815770c0>] device_offline+0x90/0xb0
[  295.810432]  [<ffffffff814b7b07>] acpi_bus_offline+0xaf/0x107
[  295.816959]  [<ffffffff814d60bf>] acpi_ns_walk_namespace+0xdf/0x18f
[  295.824069]  [<ffffffff814b7a58>] ? acpi_bus_get_device+0x44/0x44
[  295.830983]  [<ffffffff814b7a58>] ? acpi_bus_get_device+0x44/0x44
[  295.837970]  [<ffffffff814d65b8>] acpi_walk_namespace+0x9d/0xd1
[  295.844691]  [<ffffffff814ba085>] acpi_device_hotplug+0x207/0x3fa
[  295.851607]  [<ffffffff814b33ba>] acpi_hotplug_work_fn+0x1f/0x2b
[  295.858423]  [<ffffffff810a0241>] process_one_work+0x1f1/0x7c0
[  295.865044]  [<ffffffff810a01b6>] ? process_one_work+0x166/0x7c0
[  295.871860]  [<ffffffff810a0909>] ? worker_thread+0xf9/0x480
[  295.878286]  [<ffffffff810a0879>] worker_thread+0x69/0x480
[  295.884521]  [<ffffffff810a0810>] ? process_one_work+0x7c0/0x7c0
[  295.891337]  [<ffffffff810a71af>] kthread+0x11f/0x140
[  295.897260]  [<ffffffff810a7090>] ? kthread_create_on_node+0x260/0x260
[  295.904661]  [<ffffffff81869ddf>] ret_from_fork+0x3f/0x70
[  295.910810]  [<ffffffff810a7090>] ? kthread_create_on_node+0x260/0x260
