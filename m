Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167058;
	b=1nJA6THO0f98CXxmUqtsdSbOXtGmenGjGIq958s1WVtTwworgpP4jlPvy30FzuPFZc6G
	 hwBQoQYY2N8yjg/ec6KjOgWuCMN9vzO8NqmFeFKh6ACrMM4rcMeIA4X0MTUdQkoJZ/kXi
	 fwvIsdW2gVYxeHxeFtURBaU7F8I5TPFnJ31aEPPz/qFj9NZJcsRqaU3PWQDTS5e84oFPl
	 VypqWt+3sWRimc/ogAsYqCu77zXM/EY784AuuuUPB12cD84DmJIuRk/dR9b6z57IUXmAa
	 fiS0y9rYU7Hx2erpSdWlWx/bj1JlLvLmU6ElvJr9pvXrU7oVQ1D9onXcnYTV2N5afWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167058;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=+2bdNlDkN10oDjIbb35R3tdxbUezY5B5W/AihEWxSmU=;
	b=ZrHd6H2FygLzQz8yXp5pOdm06bCuI3HHNTAKA/jXRM80Pd4aRnYzlJ94/29xu4kjXPTW
	 EzIvevJQgbl8LxAoRYXNWoDHMpGLA5YnDQCZITknkNBSXpZ50Xt7WViXecicvJZq5xjth
	 qhaMn8osuziNqnl9bjtT6qlQ68mJbfWHqwbonH9sQCEUJApt+tespMejn+tob3w/8aRDl
	 FIOHzSIJ0GQ5//4wjOw3ES2E39YHU+cFmizeRwvvfGOaUDhYG+0Er2gcA1/J4UAh3OLUq
	 UO/TMbh+7bZf7SzeIUnBtrectXtVtX8uIt4ozijbUM/SJKUT44wYPXXDIU+n2ROG6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA7606A31A
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 05:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEDA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab4f652f9bso528380b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 22:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793167057; x=1793771857;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2bdNlDkN10oDjIbb35R3tdxbUezY5B5W/AihEWxSmU=;
        b=bEL0bVWF+DuX6t0m1/t8pxpXoO5JdDmCwhdcGAtLOeq4rdrSyGposb2VhAljHrOgc2
         zcjLJdR7rK/9lQAXwKyWOyOO0IJO94f7b+9T/TUUQO4YALAaQv/i1BO6WILVj37f7K/8
         VccVzO6lgPn7WNPXcHNc8QL+H7plmQtS/QT7GUWwtM+lC4UUhcDNF2UGUy+JyipP5wUq
         gbSSsON/1VfGc/7uBo2AP1wzFM6FU59iaDru0pB9UQn07KwW1qkUHaNrXBeX8FzFbLtD
         J5DaESTgZffEHSiEkENwRg5nGmpEQv5BfVuyRguDPTTdW3pId7Gd2VpO/dmpLYzZf/Gj
         /wxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmlRLIeMA/LPvx5kemhW63ztFnC08lf1HT3cx2SO8qDRxmE1CyOPeVP8EH0YTwh4110HzGg7NKpkNu@vger.kernel.org
X-Gm-Message-State: AFq9FYIvZB/xWiAgXGAhlpjglphnpOux2EevTOu9/N+8pSvzuPGLCq5z
	s/V/Tx/cAV9F+iNjamV2JrpB32swjoW58E+6TVX3Uwrhv6+EoUNdQSwQEVALgMZMNMI9yCQmHh4
	Z1luESPSY0N7Etjq3CDvlPCoYIa/QmGItwYfMPVSYyfJ0jycKArbmGS4b128=
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f62:b0:4d6:9232:b3bc with SMTP id
 5614622812f47-56383a8e14fmr876455b6e.51.1793167056863; Tue, 27 Oct 2026
 22:57:36 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:57:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae18ed0.6200f071.51519.0f60.GAE@google.com>
Subject: [syzbot] [acpi?] possible deadlock in cpu_device_down
From: syzbot <syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com>
To: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4da9dedf3fc5 Merge tag 'iommu-updates-v7.4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13058459580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd00d0b501e8d973
dashboard link: https://syzkaller.appspot.com/bug?extid=cea7285bc17b76ffe39f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86361da34cc2/disk-4da9dedf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8afe65c41dcc/vmlinux-4da9dedf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef091f7d9636/bzImage-4da9dedf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L      
------------------------------------------------------
kworker/u8:4/62 is trying to acquire lock:
ffffffff8fe7a7a0 (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_maps_update_begin kernel/cpu.c:468 [inline]
ffffffff8fe7a7a0 (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_down kernel/cpu.c:1490 [inline]
ffffffff8fe7a7a0 (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_device_down+0x46/0xc0 kernel/cpu.c:1508

but task is already holding lock:
ffff88802528c760 (&device->physical_node_lock){+.+.}-{4:4}, at: acpi_bus_offline+0x156/0x550 drivers/acpi/scan.c:152

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&device->physical_node_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
       class_mutex_constructor include/linux/mutex.h:253 [inline]
       acpi_primary_dev_companion drivers/acpi/bus.c:817 [inline]
       acpi_companion_match+0xc0/0x180 drivers/acpi/bus.c:873
       acpi_device_uevent_modalias+0x19/0x30 drivers/acpi/device_sysfs.c:280
       platform_uevent+0x51/0xc0 drivers/base/platform.c:1474
       dev_uevent+0x1de/0x870 drivers/base/core.c:2766
       kobject_uevent_env+0x6eb/0x18b0 lib/kobject_uevent.c:576
       kobject_synth_uevent+0x679/0x7d0 lib/kobject_uevent.c:207
       uevent_store+0x24/0x50 drivers/base/core.c:2847
       dev_attr_store+0x58/0x80 drivers/base/core.c:2509
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (kn->active#5){++++}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       kernfs_drain+0x4eb/0x600 fs/kernfs/dir.c:534
       __kernfs_remove+0x34c/0xbc0 fs/kernfs/dir.c:1578
       kernfs_remove_by_name_ns+0x7c/0x120 fs/kernfs/dir.c:1796
       sysfs_remove_file include/linux/sysfs.h:780 [inline]
       device_remove_file drivers/base/core.c:3146 [inline]
       device_remove_file drivers/base/core.c:3142 [inline]
       device_del+0x361/0x9b0 drivers/base/core.c:3963
       device_unregister+0x1d/0xe0 drivers/base/core.c:4006
       kref_put include/linux/kref.h:65 [inline]
       device_link_put_kref drivers/base/core.c:1022 [inline]
       device_link_put_kref+0x156/0x1b0 drivers/base/core.c:1019
       device_link_remove+0xbb/0x110 drivers/base/core.c:1065
       destroy_regulator+0x417/0x510 drivers/regulator/core.c:2650
       _regulator_put+0xf2/0x1b0 drivers/regulator/core.c:2682
       regulator_put+0x23/0x30 drivers/regulator/core.c:2699
       release_nodes+0xa5/0x120 drivers/base/devres.c:546
       devres_release_group+0x1c2/0x2d0 drivers/base/devres.c:739
       i2c_device_probe+0x70c/0xd10 drivers/i2c/i2c-core-base.c:612
       call_driver_probe drivers/base/dd.c:628 [inline]
       really_probe+0x241/0xa60 drivers/base/dd.c:706
       __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
       driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
       __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
       bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:503
       __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
       device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
       bus_probe_device+0x64/0x160 drivers/base/bus.c:623
       device_add+0x121d/0x1970 drivers/base/core.c:3776
       i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1020
       new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1308
       dev_attr_store+0x58/0x80 drivers/base/core.c:2509
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (device_links_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
       device_links_write_lock drivers/base/core.c:322 [inline]
       device_links_purge drivers/base/core.c:1704 [inline]
       device_del+0x3d7/0x9b0 drivers/base/core.c:3969
       device_unregister+0x1d/0xe0 drivers/base/core.c:4006
       mce_device_remove arch/x86/kernel/cpu/mce/core.c:2715 [inline]
       mce_cpu_pre_down+0x325/0x620 arch/x86/kernel/cpu/mce/core.c:2776
       cpuhp_invoke_callback+0x3b4/0x9a0 kernel/cpu.c:194
       cpuhp_thread_fun+0x3e9/0x7c0 kernel/cpu.c:1109
       smpboot_thread_fn+0x41f/0xb90 kernel/smpboot.c:162
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (cpuhp_state-down){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       cpuhp_lock_acquire kernel/cpu.c:103 [inline]
       cpuhp_kick_ap_work+0xa4/0xbd0 kernel/cpu.c:1188
       _cpu_down+0x47d/0x1020 kernel/cpu.c:1436
       cpu_down_maps_locked kernel/cpu.c:1483 [inline]
       cpu_down kernel/cpu.c:1491 [inline]
       cpu_device_down+0x82/0xc0 kernel/cpu.c:1508
       device_offline drivers/base/core.c:4283 [inline]
       device_offline+0x2f4/0x400 drivers/base/core.c:4267
       online_store+0xd1/0x180 drivers/base/core.c:2883
       dev_attr_store+0x58/0x80 drivers/base/core.c:2509
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (cpu_hotplug_lock){++++}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       percpu_down_write+0x4e/0x3d0 kernel/locking/percpu-rwsem.c:232
       cpus_write_lock kernel/cpu.c:508 [inline]
       _cpu_up+0x68/0x960 kernel/cpu.c:1622
       cpu_up+0x1ba/0x230 kernel/cpu.c:1706
       cpuhp_bringup_mask+0xf8/0x180 kernel/cpu.c:1772
       cpuhp_bringup_cpus_parallel kernel/cpu.c:1850 [inline]
       bringup_nonboot_cpus+0xd9/0x1b0 kernel/cpu.c:1876
       smp_init+0x32/0x150 kernel/smp.c:1151
       kernel_init_freeable+0x44b/0x7b0 init/main.c:1728
       kernel_init+0x21/0x1e0 init/main.c:1626
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (cpu_add_remove_lock){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
       cpu_maps_update_begin kernel/cpu.c:468 [inline]
       cpu_down kernel/cpu.c:1490 [inline]
       cpu_device_down+0x46/0xc0 kernel/cpu.c:1508
       device_offline drivers/base/core.c:4283 [inline]
       device_offline+0x2f4/0x400 drivers/base/core.c:4267
       acpi_bus_offline+0x3c7/0x550 drivers/acpi/scan.c:164
       acpi_scan_try_to_offline drivers/acpi/scan.c:227 [inline]
       acpi_scan_hot_remove drivers/acpi/scan.c:329 [inline]
       acpi_generic_hotplug_event drivers/acpi/scan.c:432 [inline]
       acpi_device_hotplug+0x627/0xbe0 drivers/acpi/scan.c:456
       acpi_hotplug_work_fn+0x5e/0x90 drivers/acpi/osl.c:1194
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
       process_scheduled_works kernel/workqueue.c:3578 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  cpu_add_remove_lock --> kn->active#5 --> &device->physical_node_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&device->physical_node_lock);
                               lock(kn->active#5);
                               lock(&device->physical_node_lock);
  lock(cpu_add_remove_lock);

 *** DEADLOCK ***

locks held by kworker/u8:4/62: 6, last CPU#1:
 #0: ffff8880226a5148 ((wq_completion)kacpi_hotplug){+.+.}-{0:0}, at: process_one_work+0x1461/0x1b10 kernel/workqueue.c:3470
 #1: ffffc9000203fd08 ((work_completion)(&hpw->work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3471
 #2: ffffffff910363e0 (device_hotplug_lock){+.+.}-{4:4}, at: acpi_device_hotplug+0x7e/0xbe0 drivers/acpi/scan.c:442
 #3: ffffffff90d09b40 (acpi_scan_lock){+.+.}-{4:4}, at: acpi_device_hotplug+0x8c/0xbe0 drivers/acpi/scan.c:443
 #4: ffff88802528c760 (&device->physical_node_lock){+.+.}-{4:4}, at: acpi_bus_offline+0x156/0x550 drivers/acpi/scan.c:152
 #5: ffff8880b8138650 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #5: ffff8880b8138650 (&dev->mutex){....}-{4:4}, at: device_offline drivers/base/core.c:4278 [inline]
 #5: ffff8880b8138650 (&dev->mutex){....}-{4:4}, at: device_offline+0x1c5/0x400 drivers/base/core.c:4267

stack backtrace:
CPU: 1 UID: 0 PID: 62 Comm: kworker/u8:4 Tainted: G             L       syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
 cpu_maps_update_begin kernel/cpu.c:468 [inline]
 cpu_down kernel/cpu.c:1490 [inline]
 cpu_device_down+0x46/0xc0 kernel/cpu.c:1508
 device_offline drivers/base/core.c:4283 [inline]
 device_offline+0x2f4/0x400 drivers/base/core.c:4267
 acpi_bus_offline+0x3c7/0x550 drivers/acpi/scan.c:164
 acpi_scan_try_to_offline drivers/acpi/scan.c:227 [inline]
 acpi_scan_hot_remove drivers/acpi/scan.c:329 [inline]
 acpi_generic_hotplug_event drivers/acpi/scan.c:432 [inline]
 acpi_device_hotplug+0x627/0xbe0 drivers/acpi/scan.c:456
 acpi_hotplug_work_fn+0x5e/0x90 drivers/acpi/osl.c:1194
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
 process_scheduled_works kernel/workqueue.c:3578 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
smpboot: CPU 1 is now offline
ACPI: \_SB_.CP01: Eject incomplete - status 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
