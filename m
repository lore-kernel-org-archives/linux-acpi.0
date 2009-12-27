From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Lockdep spew with dock on resume
Date: Sun, 27 Dec 2009 02:08:28 -0800
Message-ID: <20091227100828.GC14655@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:36534 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZL0KIe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Dec 2009 05:08:34 -0500
Received: by pxi27 with SMTP id 27so5081910pxi.4
        for <linux-acpi@vger.kernel.org>; Sun, 27 Dec 2009 02:08:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

Hi,

I started getting the following complaints from lockdep when resuming
plugged into a docking station (2.6.33-rc*):

Dec 21 08:50:29 dtor-d630 kernel: [ 8018.441766] ACPI: Waking up from system sleep state S3
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464717]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464719] =======================================================
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464720] [ INFO: possible circular locking dependency detected ]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464723] 2.6.33-rc1 #145
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464724] -------------------------------------------------------
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464726] kacpi_hotplug/23 is trying to acquire lock:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464728]  (kacpid){+.+.+.}, at: [<ffffffff81067130>] flush_workqueue+0x0/0xc0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464736]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464737] but task is already holding lock:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464739]  ((&dpc->work)){+.+.+.}, at: [<ffffffff81066c7b>] run_workqueue+0xdb/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464744]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464744] which lock already depends on the new lock.
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464745]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464747]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464747] the existing dependency chain (in reverse order) is:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464749]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464749] -> #1 ((&dpc->work)){+.+.+.}:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464753]        [<ffffffff81080b32>] check_prev_add+0x242/0x570
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464757]        [<ffffffff810814b9>] validate_chain+0x659/0x750
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464761]        [<ffffffff810818c7>] __lock_acquire+0x317/0x4b0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464764]        [<ffffffff81081af9>] lock_acquire+0x99/0x140
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464767]        [<ffffffff81066cc6>] run_workqueue+0x126/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464770]        [<ffffffff81066ed6>] worker_thread+0x96/0xf0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464773]        [<ffffffff8106b55e>] kthread+0x8e/0xa0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464777]        [<ffffffff81003d94>] kernel_thread_helper+0x4/0x10
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464781]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464782] -> #0 (kacpid){+.+.+.}:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464785]        [<ffffffff81080e2e>] check_prev_add+0x53e/0x570
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464788]        [<ffffffff810814b9>] validate_chain+0x659/0x750
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464791]        [<ffffffff810818c7>] __lock_acquire+0x317/0x4b0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464795]        [<ffffffff81081af9>] lock_acquire+0x99/0x140
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464798]        [<ffffffff8106718c>] flush_workqueue+0x5c/0xc0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464801]        [<ffffffff81261ea4>] acpi_os_wait_events_complete+0x10/0x1e
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464805]        [<ffffffff81261ecf>] acpi_os_execute_deferred+0x1d/0x31
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464808]        [<ffffffff81066ccc>] run_workqueue+0x12c/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464811]        [<ffffffff81066ed6>] worker_thread+0x96/0xf0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464814]        [<ffffffff8106b55e>] kthread+0x8e/0xa0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464818]        [<ffffffff81003d94>] kernel_thread_helper+0x4/0x10
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464821]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464821] other info that might help us debug this:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464822]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464824] 2 locks held by kacpi_hotplug/23:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464826]  #0:  (kacpi_hotplug){+.+...}, at: [<ffffffff81066c7b>] run_workqueue+0xdb/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464831]  #1:  ((&dpc->work)){+.+.+.}, at: [<ffffffff81066c7b>] run_workqueue+0xdb/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464836]
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464836] stack backtrace:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464839] Pid: 23, comm: kacpi_hotplug Tainted: P           2.6.33-rc1 #145
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464841] Call Trace:
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464845]  [<ffffffff8107f199>] print_circular_bug+0xe9/0xf0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464849]  [<ffffffff81080e2e>] check_prev_add+0x53e/0x570
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464852]  [<ffffffff8107dabf>] ? save_trace+0x3f/0xc0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464856]  [<ffffffff81066c7b>] ? run_workqueue+0xdb/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464859]  [<ffffffff810814b9>] validate_chain+0x659/0x750
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464863]  [<ffffffff810818c7>] __lock_acquire+0x317/0x4b0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464866]  [<ffffffff81081269>] ? validate_chain+0x409/0x750
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464870]  [<ffffffff81081af9>] lock_acquire+0x99/0x140
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464873]  [<ffffffff81067130>] ? flush_workqueue+0x0/0xc0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464876]  [<ffffffff81261eb2>] ? acpi_os_execute_deferred+0x0/0x31
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464879]  [<ffffffff8106718c>] flush_workqueue+0x5c/0xc0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464882]  [<ffffffff81067130>] ? flush_workqueue+0x0/0xc0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464885]  [<ffffffff81066c7b>] ? run_workqueue+0xdb/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464889]  [<ffffffff81261ea4>] acpi_os_wait_events_complete+0x10/0x1e
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464892]  [<ffffffff81261ecf>] acpi_os_execute_deferred+0x1d/0x31
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464895]  [<ffffffff81066ccc>] run_workqueue+0x12c/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464898]  [<ffffffff81066c7b>] ? run_workqueue+0xdb/0x2a0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464902]  [<ffffffff81066ed6>] worker_thread+0x96/0xf0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464905]  [<ffffffff8106ba70>] ? autoremove_wake_function+0x0/0x40
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464908]  [<ffffffff81066e40>] ? worker_thread+0x0/0xf0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464911]  [<ffffffff8106b55e>] kthread+0x8e/0xa0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464915]  [<ffffffff81003d94>] kernel_thread_helper+0x4/0x10
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464920]  [<ffffffff8143a9c0>] ? restore_args+0x0/0x30
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464923]  [<ffffffff8106b4d0>] ? kthread+0x0/0xa0
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464926]  [<ffffffff81003d90>] ? kernel_thread_helper+0x0/0x10
Dec 21 08:50:29 dtor-d630 kernel: [ 8018.464932] ACPI: \_SB_.PCI0.PCIE.GDCK - docking

They weren't here with 2.6.32.

Thanks.

-- 
Dmitry
