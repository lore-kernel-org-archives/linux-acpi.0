Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A31A23A4
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287304; cv=none; b=YVymSwFh+EEjzTuneaGMLOmegm709AGW2rKGrnIgiXdr40s//ld4tM0IkGVJvLZjITjRzJTXSjoTzXRC0FtXYIKd3UhHoFXke8k1JLdokRD4V1LEiiUreTWzL6y7XYEb3uIL5k2icWbuzDAnW9fHzSi0826m5hjmG9eIeBXcYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287304; c=relaxed/simple;
	bh=RUzXBwgXiM/rvvP3cQSqsj764w/uV9u7Tk+ZCUtenj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QAGO9a62odxYN5uATmr+bugmzk0SeHh2EcYDfTcEemSIzrokUqeGp8YuGt7pwiGsN1DeWRZcOC8Mztfw+SD+Z9OCxCMhbp7qXfoIAmbFOESqIVou3Z61v3Vi3DurM3htvy7cMKT7E2oFmzaYWRzJCrR6Ow54o7TaibkPYWGrxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a7de733fa9so459591b6e.3
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 18:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785287301; x=1785892101;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dqSMTTM6vo0zcYNgTqtEZRu9JRO5HukENklKUwy2LkI=;
        b=JbeDA/8WLGkc9m2dH5KPI8FT5QVPylTeayuI5EFk0bCpY9nbaX++RPAXkvwxis5htM
         XZk/w1gPN93a3Trf5ShKT3/jRzf8y8ajBpuaiHX3aMk5RP23AM3Z3w5/kdVllo4MX6Af
         tCOECaAMv8N2bvixvHtpYD6tJOmDYnDgAxMitJi+YLvLoKdQrqqCaO0KN1YVkO/TltzF
         PGeMJXdEaI+Dopx+hXw0ZRT3fWKg3E2t13hMR41xVFt2/sws0yAg7evpL2xmMkEo/3xj
         YZKm7JnAocXwEg4zaqpRY6gVlzmd/xs3ShzIhmtGYmt2lPbfTEr4pMuf41WVUXwA26Mk
         fWHw==
X-Forwarded-Encrypted: i=1; AHgh+Rp021sJlaV1wMfL5SJnBxYq3Gl1GoVZH/lbIc3NNhH8PMJ3xX/1AYXfhBmi6/tiUUvxW2CNkbnk/3za@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fO0NhtvcOQufHhMdWguh2Xy+KR34gikKpd2VydQZZxMJU9ML
	c2obYJnrt/ShbPUBlagGHsrojh9Y77HFI9xdnjAYMPD+PUCySdAo//pxMWYLqSYF9wYW/FRkoMh
	HlU3gX8U59rJa94pFN0H8VLhtAYfv/syZrW5EDWagj8HpKksebO3GJ7/5S4Y=
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1589:b0:485:48da:133d with SMTP id
 5614622812f47-4ad5b989d25mr2652851b6e.10.1785287301288; Tue, 28 Jul 2026
 18:08:21 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:08:21 -0700
In-Reply-To: <6a682bf7.70955b6c.323240.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a695285.e3659fcc.2a40b8.002c.GAE@google.com>
Subject: Re: [syzbot] [acpica?] KASAN: use-after-free Read in acpi_ns_get_attached_object
From: syzbot <syzbot+5725792ce6a9938d1b24@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, robert.moore@intel.com, 
	saket.dumbre@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3b5f4b83c4ab Merge tag 'for-7.2-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dfffde580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=5725792ce6a9938d1b24
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14428aea580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13715632580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3b5f4b83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed6d6b480fd7/vmlinux-3b5f4b83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5a591a74024/bzImage-3b5f4b83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5725792ce6a9938d1b24@syzkaller.appspotmail.com

usb usb2: USB disconnect, device number 1
ehci-pci 0000:00:1d.7: USB bus 2 deregistered
==================================================================
BUG: KASAN: slab-use-after-free in acpi_ns_get_attached_object+0x148/0x1b0 drivers/acpi/acpica/nsobject.c:264
Read of size 1 at addr ffff888022b654e8 by task syz.0.19/5926

CPU: 1 UID: 0 PID: 5926 Comm: syz.0.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 acpi_ns_get_attached_object+0x148/0x1b0 drivers/acpi/acpica/nsobject.c:264
 acpi_ex_resolve_node_to_value+0xb7/0x9a0 drivers/acpi/acpica/exresnte.c:61
 acpi_ex_resolve_to_value+0x3da/0xcd0 drivers/acpi/acpica/exresolv.c:76
 acpi_ds_evaluate_name_path+0x30d/0x4a0 drivers/acpi/acpica/dsutils.c:790
 acpi_ds_exec_end_op+0xb78/0x1e60 drivers/acpi/acpica/dswexec.c:374
 acpi_ps_parse_loop+0x5e1/0x26e0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x81e/0x1120 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_method+0x5c4/0xe90 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0x640/0x1670 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xf7/0x610 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0xa0/0x150 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0xb8/0x140 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x179/0xdd0 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x8e/0x6b0 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_disable+0x1a8/0x360 drivers/acpi/pci_irq.c:499
 pcibios_disable_device arch/x86/pci/common.c:706 [inline]
 pcibios_disable_device+0x89/0xb0 arch/x86/pci/common.c:703
 do_pci_disable_device+0x9f/0x100 drivers/pci/pci.c:2170
 pci_disable_device+0x130/0x270 drivers/pci/pci.c:2206
 usb_hcd_pci_remove+0x1ed/0x300 drivers/usb/core/hcd-pci.c:351
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 unbind_store+0xf8/0x110 drivers/base/bus.c:244
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc01df9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc710447d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc01e225fa0 RCX: 00007fc01df9de99
RDX: 000000000000000c RSI: 0000200000000240 RDI: 0000000000000003
RBP: 00007fc01e033eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc01e225fac R14: 00007fc01e225fa0 R15: 00007fc01e225fa0
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 kmem_cache_alloc_noprof+0x26b/0x6a0 mm/slub.c:4931
 acpi_ut_allocate_object_desc_dbg+0x86/0x240 drivers/acpi/acpica/utobject.c:359
 acpi_ut_create_internal_object_dbg+0x51/0x260 drivers/acpi/acpica/utobject.c:69
 acpi_ds_build_internal_object+0x173/0x790 drivers/acpi/acpica/dsobject.c:94
 acpi_ds_create_node+0xe3/0x280 drivers/acpi/acpica/dsobject.c:281
 acpi_ds_exec_end_op+0x10cf/0x1e60 drivers/acpi/acpica/dswexec.c:594
 acpi_ps_parse_loop+0x5e1/0x26e0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x81e/0x1120 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_table+0x393/0x500 drivers/acpi/acpica/psxface.c:295
 acpi_ns_execute_table+0x596/0x970 drivers/acpi/acpica/nsparse.c:116
 acpi_ns_parse_table+0xcb/0x160 drivers/acpi/acpica/nsparse.c:268
 acpi_ns_load_table+0xc9/0x490 drivers/acpi/acpica/nsload.c:71
 acpi_tb_load_namespace+0x2b0/0x8f0 drivers/acpi/acpica/tbxfload.c:158
 acpi_load_tables+0x89/0x160 drivers/acpi/acpica/tbxfload.c:59
 acpi_bus_init drivers/acpi/bus.c:1479 [inline]
 acpi_init+0x146/0x840 drivers/acpi/bus.c:1592
 do_one_initcall+0x11d/0x700 init/main.c:1347
 do_initcall_level init/main.c:1409 [inline]
 do_initcalls init/main.c:1425 [inline]
 do_basic_setup init/main.c:1445 [inline]
 kernel_init_freeable+0x6ea/0x7b0 init/main.c:1658
 kernel_init+0x1f/0x1e0 init/main.c:1548
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5922:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kmem_cache_free+0x127/0x6b0 mm/slub.c:6504
 acpi_os_release_object+0x1c/0x30 drivers/acpi/osl.c:1661
 acpi_ut_delete_object_desc+0xea/0x130 drivers/acpi/acpica/utobject.c:402
 acpi_ut_delete_internal_obj drivers/acpi/acpica/utdelete.c:316 [inline]
 acpi_ut_update_ref_count.part.0+0x510/0x2250 drivers/acpi/acpica/utdelete.c:436
 acpi_ut_update_ref_count drivers/acpi/acpica/utdelete.c:374 [inline]
 acpi_ut_update_object_reference+0x5f9/0x800 drivers/acpi/acpica/utdelete.c:632
 acpi_ut_remove_reference drivers/acpi/acpica/utdelete.c:740 [inline]
 acpi_ut_remove_reference+0x192/0x1d0 drivers/acpi/acpica/utdelete.c:710
 acpi_rs_get_prt_method_data+0xcd/0x150 drivers/acpi/acpica/rsutils.c:460
 acpi_get_irq_routing_table+0xb8/0x140 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x179/0xdd0 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x8e/0x6b0 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_enable+0x1f5/0x6f0 drivers/acpi/pci_irq.c:414
 pcibios_enable_device+0xb6/0xe0 arch/x86/pci/common.c:699
 do_pci_enable_device+0x21f/0x4a0 drivers/pci/pci.c:1998
 pci_enable_device_flags+0x27c/0x370 drivers/pci/pci.c:2089
 usb_hcd_pci_probe+0x56/0xcb0 drivers/usb/core/hcd-pci.c:184
 ehci_pci_probe+0x35/0x50 drivers/usb/host/ehci-pci.c:385
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:394
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x1cd/0x370 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
 bind_store+0xf4/0x190 drivers/base/bus.c:267
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888022b654e0
 which belongs to the cache Acpi-Operand of size 72
The buggy address is located 8 bytes inside of
 freed 72-byte region [ffff888022b654e0, ffff888022b65528)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888022b65000 pfn:0x22b65
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801bc4da40 ffffea00008aec90 ffffea00008ae550
raw: ffff888022b65000 000000080027001d 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2576811382, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 kmem_cache_alloc_noprof+0x46e/0x6a0 mm/slub.c:4931
 acpi_ut_allocate_object_desc_dbg+0x86/0x240 drivers/acpi/acpica/utobject.c:359
 acpi_ut_create_internal_object_dbg+0x51/0x260 drivers/acpi/acpica/utobject.c:69
 acpi_ds_build_internal_package_obj+0xa8c/0xe60 drivers/acpi/acpica/dspkginit.c:92
 acpi_ds_eval_data_object_operands+0x2fd/0x640 drivers/acpi/acpica/dsopcode.c:638
 acpi_ds_exec_end_op+0xe41/0x1e60 drivers/acpi/acpica/dswexec.c:617
 acpi_ps_parse_loop+0x5e1/0x26e0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x81e/0x1120 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_table+0x393/0x500 drivers/acpi/acpica/psxface.c:295
 acpi_ns_execute_table+0x596/0x970 drivers/acpi/acpica/nsparse.c:116
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888022b65380: fb fc fc fc fc 00 00 00 00 00 00 00 00 00 fc fc
 ffff888022b65400: fc fc fa fb fb fb fb fb fb fb fb fc fc fc fc fa
>ffff888022b65480: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
                                                          ^
 ffff888022b65500: fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb
 ffff888022b65580: fb fb fc fc fc fc fa fb fb fb fb fb fb fb fb fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
