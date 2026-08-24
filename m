Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22483749F5
	for <linux-acpi@vger.kernel.org>; Mon, 24 Aug 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587004; cv=none; b=FTCTl0WnAxSuaX1tvOSAfzXQAnNLs6EpFfqsszalElA8d4ofRRemS25n0ldU7+4rJQEDP7+LFmI8UChWcKilksSlcvGjCjBfvG4eWy2shxL1WptA2sXM/+7+SGAgNEmDt8P9YGbyybj2Og/zpENNJa0LLUQqPaSB8j9E6CoQemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587004; c=relaxed/simple;
	bh=NcrWUDcrG/mCNtXMbgPfbvZSceIj/D8GGkFMMDJWFvU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XYNgt7y+6maLtNhBslpr5YuYxuScVv/584xvnhQrpzXJ9D1IjtSB6Fqrz59vCKVCU1eg7FoW74+QiGCYG35Ip5Kz2genyOrokdfm8/ZwzjyAr5lBpU6K5pzoueCj78fg42sYChDcheOD9QuAzh3FHL+xO3BCjyQYjLvRKcHQtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4961058e787so486093b6e.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Aug 2026 08:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586996; x=1788191796;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InSelIQtvuERPXKUGsUKFbCwhTimVborn25IOYTuBGY=;
        b=XwIT1bWR9fyBgqlf3iAXygiYfZp4dRifbIfuPiNAL6lf30me9/+3GnZXIrW7h4CyEh
         f1Zp9Rwbbrqyd8hFAAF6Msy4h65Sv2vemjctS4GFdOh18P1BjiDJ17AjLctC0TjMPRBu
         6EBDHBNeCtIMUHpPa/G0onaDHK0IbP69kqXfUMpw8DSxarE/NZX4WD5H1XZun53VVfSj
         aklRqTQJuCbLrgkWzUbgxS9DlIimgO4Vb6o9+1lZhXDClSlxvwoo37k7cCrMAYGhYXvV
         EhwvqmxWeXREZ6l54wNXSVMYNVstEA07Ol4GoNNX+D+OvdWpJ/pFWyEhPN9NrnfY1W4L
         LtHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqPMbr+eoIht4XSlgs5dmqE5edhnjpibR78i9EEl/38Sdi1PRpxXcWppzHh5yXG1bysB1X6WRkL2cn@vger.kernel.org
X-Gm-Message-State: AFuF++nWstuCivzdhM437O7Mq/VUhIxUwifG3+DaEmb8mHR+1/ySctCa
	JusnMckfDG2hZqcLFcupIvHWuh6S0dzi6Q4ipnuUkObq2oq+mt4UTXMbWIkI0ErWK46YvDjvnro
	NkbmORwzhA8d/fgIFcE1O1jI9aDfCFvcXrSzIg0zc+i4yWZ78DVXWiZ3te2I=
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bd3:b0:495:e16d:5d03 with SMTP id
 5614622812f47-4b309ca1450mr18112834b6e.21.1787586995752; Mon, 24 Aug 2026
 08:56:35 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:56:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8c69b3.dbb3a75c.7844.0008.GAE@google.com>
Subject: [syzbot] [acpica?] possible deadlock in get_from_partial_node
From: syzbot <syzbot+c45feb6d62880ad9f42b@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, robert.moore@intel.com, 
	saket.dumbre@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a4ff2be345d0 Merge tag 'v7.3-p1' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12786549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29686c02180e4e86
dashboard link: https://syzkaller.appspot.com/bug?extid=c45feb6d62880ad9f42b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a4ff2be3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0a874c2c2e0/vmlinux-a4ff2be3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b39932275def/bzImage-a4ff2be3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c45feb6d62880ad9f42b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.2.702/8696 is trying to acquire lock:
ffffffff8ecf5400 (console_owner){..-.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2026 [inline]
ffffffff8ecf5400 (console_owner){..-.}-{0:0}, at: vprintk_emit+0x4c3/0x6b0 kernel/printk/printk.c:2478

but task is already holding lock:
ffff888027fc2558 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:377 [inline]
ffff888027fc2558 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:8009 [inline]
ffff888027fc2558 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0x10c/0x330 mm/slub.c:8058

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&n->list_lock){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
       get_from_partial_node+0x7d/0x5b0 mm/slub.c:3817
       get_from_partial mm/slub.c:3947 [inline]
       ___slab_alloc+0x78/0x800 mm/slub.c:4459
       slab_alloc_node mm/slub.c:4908 [inline]
       kmem_cache_alloc_noprof+0x3a9/0x6a0 mm/slub.c:4931
       kmem_alloc_batch+0x49/0x170 lib/debugobjects.c:371
       fill_pool lib/debugobjects.c:420 [inline]
       debug_objects_fill_pool lib/debugobjects.c:780 [inline]
       debug_objects_fill_pool+0x24d/0x550 lib/debugobjects.c:758
       debug_object_activate+0x103/0x4b0 lib/debugobjects.c:869
       debug_work_activate kernel/workqueue.c:682 [inline]
       insert_work+0x2e/0x230 kernel/workqueue.c:2223
       insert_wq_barrier kernel/workqueue.c:3940 [inline]
       start_flush_work kernel/workqueue.c:4303 [inline]
       __flush_work+0x46e/0xcb0 kernel/workqueue.c:4338
       flush_all_cpus_locked+0x1bc/0x220 mm/slub.c:4008
       flush_all mm/slub.c:4017 [inline]
       __kmem_cache_shrink+0x15/0x30 mm/slub.c:8326
       acpi_os_purge_cache+0x15/0x20 drivers/acpi/osl.c:1622
       acpi_purge_cached_objects+0x51/0x140 drivers/acpi/acpica/utxface.c:237
       acpi_initialize_objects+0x8b/0x100 drivers/acpi/acpica/utxfinit.c:250
       acpi_bus_init drivers/acpi/bus.c:1375 [inline]
       acpi_init+0x1b0/0x840 drivers/acpi/bus.c:1464
       do_one_initcall+0x11c/0x6f0 init/main.c:1353
       do_initcall_level init/main.c:1415 [inline]
       do_initcalls init/main.c:1431 [inline]
       do_basic_setup init/main.c:1451 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1666
       kernel_init+0x21/0x1e0 init/main.c:1556
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&pool->lock){-.-.}-{2:2}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
       __queue_work+0x298/0x12b0 kernel/workqueue.c:2361
       queue_work_on+0x1a9/0x1e0 kernel/workqueue.c:2452
       queue_work include/linux/workqueue.h:699 [inline]
       rpm_suspend+0xf6b/0x1220 drivers/base/power/runtime.c:685
       rpm_idle+0x60c/0x790 drivers/base/power/runtime.c:559
       __pm_runtime_idle+0xba/0x1a0 drivers/base/power/runtime.c:1129
       pm_runtime_put include/linux/pm_runtime.h:551 [inline]
       __device_attach+0x37e/0x4d0 drivers/base/dd.c:1116
       device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
       bus_probe_device+0x64/0x160 drivers/base/bus.c:620
       device_add+0x121d/0x1970 drivers/base/core.c:3776
       serial_base_port_add+0x227/0x2b0 drivers/tty/serial/serial_base_bus.c:186
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3275 [inline]
       serial_core_register_port+0x13c/0x16f0 drivers/tty/serial/serial_core.c:3314
       serial8250_register_8250_port+0x15af/0x2330 drivers/tty/serial/8250/8250_core.c:828
       serial_pnp_probe+0x436/0x930 drivers/tty/serial/8250/8250_pnp.c:480
       pnp_device_probe+0x2b3/0x4a0 drivers/pnp/driver.c:111
       call_driver_probe drivers/base/dd.c:628 [inline]
       really_probe+0x241/0xa60 drivers/base/dd.c:706
       __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
       driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
       __driver_attach+0x21f/0x5b0 drivers/base/dd.c:1292
       bus_for_each_dev+0x13e/0x1d0 drivers/base/bus.c:383
       bus_add_driver+0x305/0x5b0 drivers/base/bus.c:763
       driver_register+0x1e2/0x360 drivers/base/driver.c:174
       serial8250_init+0xcc/0x1c0 drivers/tty/serial/8250/8250_platform.c:317
       do_one_initcall+0x11c/0x6f0 init/main.c:1353
       do_initcall_level init/main.c:1415 [inline]
       do_initcalls init/main.c:1431 [inline]
       do_basic_setup init/main.c:1451 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1666
       kernel_init+0x21/0x1e0 init/main.c:1556
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&dev->power.lock){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
       __pm_runtime_resume+0xa9/0x170 drivers/base/power/runtime.c:1196
       pm_runtime_get include/linux/pm_runtime.h:494 [inline]
       __uart_start+0x1b0/0x510 drivers/tty/serial/serial_core.c:149
       uart_write+0x211/0xb20 drivers/tty/serial/serial_core.c:629
       process_output_block drivers/tty/n_tty.c:557 [inline]
       n_tty_write+0x431/0x1160 drivers/tty/n_tty.c:2366
       iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
       file_tty_write.isra.0+0x4d2/0x890 drivers/tty/tty_io.c:1081
       tty_write drivers/tty/tty_io.c:1102 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1125 [inline]
       redirected_tty_write+0xd4/0x120 drivers/tty/tty_io.c:1105
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:181
       uart_port_lock_irqsave include/linux/serial_core.h:719 [inline]
       serial8250_console_write+0x177/0x1a50 drivers/tty/serial/8250/8250_port.c:3344
       console_emit_next_record kernel/printk/printk.c:3183 [inline]
       console_flush_one_record+0x790/0xe50 kernel/printk/printk.c:3269
       console_flush_all kernel/printk/printk.c:3343 [inline]
       __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
       console_unlock+0x103/0x260 kernel/printk/printk.c:3413
       vprintk_emit+0x407/0x6b0 kernel/printk/printk.c:2479
       _printk+0xcf/0x110 kernel/printk/printk.c:2504
       register_console.cold+0xc0/0x248 kernel/printk/printk.c:4208
       univ8250_console_init+0x6f/0x80 drivers/tty/serial/8250/8250_core.c:515
       console_init+0x3d5/0x5b0 kernel/printk/printk.c:4407
       start_kernel+0x314/0x490 init/main.c:1118
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
       x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
       common_startup_64+0x13e/0x158

-> #0 (console_owner){..-.}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5253
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       console_trylock_spinning kernel/printk/printk.c:2026 [inline]
       vprintk_emit+0x4d4/0x6b0 kernel/printk/printk.c:2478
       _printk+0xcf/0x110 kernel/printk/printk.c:2504
       __slab_bug+0x4f/0xb0 mm/slub.c:1144
       slab_bug+0x5d/0x80 mm/slub.c:1155
       list_slab_objects mm/slub.c:7978 [inline]
       free_partial mm/slub.c:8015 [inline]
       __kmem_cache_shutdown.cold+0x39/0x177 mm/slub.c:8058
       kmem_cache_destroy mm/slab_common.c:569 [inline]
       kmem_cache_destroy+0x73/0x190 mm/slab_common.c:527
       virtio_gpu_free_vbufs+0x38/0x80 drivers/gpu/drm/virtio/virtgpu_vq.c:86
       virtio_gpu_release+0x5c/0x1c0 drivers/gpu/drm/virtio/virtgpu_kms.c:312
       drm_dev_release drivers/gpu/drm/drm_drv.c:912 [inline]
       kref_put include/linux/kref.h:65 [inline]
       drm_dev_put.part.0+0xbd/0x140 drivers/gpu/drm/drm_drv.c:948
       drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
       virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
       device_remove+0xcb/0x180 drivers/base/dd.c:616
       __device_release_driver drivers/base/dd.c:1349 [inline]
       device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
       bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
       device_del+0x376/0x9b0 drivers/base/core.c:3965
       device_unregister+0x1d/0xe0 drivers/base/core.c:4006
       unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
       virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
       pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
       device_remove+0xcb/0x180 drivers/base/dd.c:616
       __device_release_driver drivers/base/dd.c:1349 [inline]
       device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
       unbind_store+0xf8/0x110 drivers/base/bus.c:244
       drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  console_owner --> &pool->lock --> &n->list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&n->list_lock);
                               lock(&pool->lock);
                               lock(&n->list_lock);
  lock(console_owner);

 *** DEADLOCK ***

locks held by syz.2.702/8696: 8, last CPU#0:
 #0: ffff888013f16ef0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff888042fd8460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff888035090c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffff888022e821f8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888022e821f8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #3: ffff888022e821f8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
 #4: ffff88802658d1b0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88802658d1b0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88802658d1b0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
 #5: ffffffff8ec7a350 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy mm/slab_common.c:556 [inline]
 #5: ffffffff8ec7a350 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy+0x4b/0x190 mm/slab_common.c:527
 #6: ffffffff8ef8a0e0 (slab_mutex){+.+.}-{4:4}, at: kmem_cache_destroy mm/slab_common.c:557 [inline]
 #6: ffffffff8ef8a0e0 (slab_mutex){+.+.}-{4:4}, at: kmem_cache_destroy+0x59/0x190 mm/slab_common.c:527
 #7: ffff888027fc2558 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:377 [inline]
 #7: ffff888027fc2558 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:8009 [inline]
 #7: ffff888027fc2558 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0x10c/0x330 mm/slub.c:8058

stack backtrace:
CPU: 0 UID: 0 PID: 8696 Comm: syz.2.702 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5253
 lock_acquire kernel/locking/lockdep.c:5886 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
 console_trylock_spinning kernel/printk/printk.c:2026 [inline]
 vprintk_emit+0x4d4/0x6b0 kernel/printk/printk.c:2478
 _printk+0xcf/0x110 kernel/printk/printk.c:2504
 __slab_bug+0x4f/0xb0 mm/slub.c:1144
 slab_bug+0x5d/0x80 mm/slub.c:1155
 list_slab_objects mm/slub.c:7978 [inline]
 free_partial mm/slub.c:8015 [inline]
 __kmem_cache_shutdown.cold+0x39/0x177 mm/slub.c:8058
 kmem_cache_destroy mm/slab_common.c:569 [inline]
 kmem_cache_destroy+0x73/0x190 mm/slab_common.c:527
 virtio_gpu_free_vbufs+0x38/0x80 drivers/gpu/drm/virtio/virtgpu_vq.c:86
 virtio_gpu_release+0x5c/0x1c0 drivers/gpu/drm/virtio/virtgpu_kms.c:312
 drm_dev_release drivers/gpu/drm/drm_drv.c:912 [inline]
 kref_put include/linux/kref.h:65 [inline]
 drm_dev_put.part.0+0xbd/0x140 drivers/gpu/drm/drm_drv.c:948
 drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
 virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3965
 device_unregister+0x1d/0xe0 drivers/base/core.c:4006
 unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
 virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 unbind_store+0xf8/0x110 drivers/base/bus.c:244
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f857079e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8571728028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8570a25fa0 RCX: 00007f857079e0d9
RDX: 000000000000000d RSI: 00002000000001c0 RDI: 0000000000000003
RBP: 00007f8570835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8570a26038 R14: 00007f8570a25fa0 R15: 00007ffeb5a8ff58
 </TASK>
BUG virtio-gpu-vbufs (Tainted: G             L     ): Objects remaining on __kmem_cache_shutdown()
-----------------------------------------------------------------------------

Object 0xffff888027e50348 @offset=840
Object 0xffff888027e50460 @offset=1120
Object 0xffff888027e50d20 @offset=3360
Object 0xffff888027e50e38 @offset=3640
Object 0xffff888027e51298 @offset=4760
Object 0xffff888027e513b0 @offset=5040
Object 0xffff888027e514c8 @offset=5320
Object 0xffff888027e515e0 @offset=5600
Slab 0xffffea00009f9400 objects=29 used=8 fp=0xffff888027e50000 flags=0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
------------[ cut here ]------------
1
WARNING: mm/slub.c:1244 at __slab_err+0x15/0x20 mm/slub.c:1244, CPU#0: syz.2.702/8696
Modules linked in:
CPU: 0 UID: 0 PID: 8696 Comm: syz.2.702 Tainted: G    B        L      syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE, [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__slab_err+0x15/0x20 mm/slub.c:1244
Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 5b fd ff ff be 01 00 00 00 bf 05 00 00 00 e8 7c f6 a2 00 90 <0f> 0b 90 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000160f808 EFLAGS: 00010046
RAX: 0000000000080000 RBX: ffffc9000160f858 RCX: ffffc90006a91000
RDX: 0000000000080000 RSI: ffffffff81c7459d RDI: ffff8880308e8000
RBP: ffff888027fc2558 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000062616c53 R12: 0000000000001ea0
R13: ffff888027e51fb8 R14: ffff888027fc2540 R15: ffffea00009f9400
FS:  00007f85717286c0(0000) GS:ffff8880d5bc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe71918568 CR3: 0000000040e74000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 list_slab_objects mm/slub.c:7994 [inline]
 free_partial mm/slub.c:8015 [inline]
 __kmem_cache_shutdown.cold+0x16e/0x177 mm/slub.c:8058
 kmem_cache_destroy mm/slab_common.c:569 [inline]
 kmem_cache_destroy+0x73/0x190 mm/slab_common.c:527
 virtio_gpu_free_vbufs+0x38/0x80 drivers/gpu/drm/virtio/virtgpu_vq.c:86
 virtio_gpu_release+0x5c/0x1c0 drivers/gpu/drm/virtio/virtgpu_kms.c:312
 drm_dev_release drivers/gpu/drm/drm_drv.c:912 [inline]
 kref_put include/linux/kref.h:65 [inline]
 drm_dev_put.part.0+0xbd/0x140 drivers/gpu/drm/drm_drv.c:948
 drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
 virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3965
 device_unregister+0x1d/0xe0 drivers/base/core.c:4006
 unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
 virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 unbind_store+0xf8/0x110 drivers/base/bus.c:244
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f857079e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8571728028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8570a25fa0 RCX: 00007f857079e0d9
RDX: 000000000000000d RSI: 00002000000001c0 RDI: 0000000000000003
RBP: 00007f8570835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8570a26038 R14: 00007f8570a25fa0 R15: 00007ffeb5a8ff58
 </TASK>


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
