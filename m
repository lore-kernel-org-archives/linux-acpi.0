Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DC285060
	for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2026 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106686; cv=none; b=IeNwRH4OE6hM3UhUFQQeFElMrnUWLBGn42x3yyjuTuuonwS0ed2leD+Mz1/Tx6ZXXIWBM64VRNxi2NXhOjpmeBgTO83jJ0gycatfgt7eaMJjahlDf2C5w2ZGO6XrwIegZ4/oYCwN/egkYWMjGns2LR4vQFhQLXLNYIdtTiB8QMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106686; c=relaxed/simple;
	bh=4Df0w7O+PjxxTCXxgNarcc4VRCI89bekYhtLcNWGSaE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zt0s71+EiVTwcvkK3m6R1h5Zn5xoP20W/ZR6SsZq0jFUpf2CWVf0b7YMeRObfe1Tux763nP8BXzQvp4bDqCW6enaHPD1q5xdby3Xvv7QXaUNbwr3JqrYFHfz1vexXhCHgkyzESOEhQ4MRzQwhAaYJhup6s1Wm5/ldh+X0gvj4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f11.google.com with SMTP id 006d021491bc7-6b132681374so142766eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 19:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106683; x=1787711483;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrYXRrWNX4Mquo3qz8DEScYpwIiZa8KKsP3Efpj4QnU=;
        b=dHxjftm0NoFyC2BL0u31IZIn31zFYgd/YS5xnF+vtwUm0wz1n/hbhhV0pfaktdmmsX
         4f8pdXPw4qJRa2kJnm/LLiu3oyei0UlPGJ0tjy6/mxp05Xcj3SbJjMSZr8vhcBV9mwDE
         VIL1VAj9vTuYVE1Tw/AQmTkdveD5vFACkIOnL6tOnvAUsFQIWFFFY+zNnqZ4Pgrp1+JX
         DkL3enshnsxjjyKrf/hHKdfdwQ5EJkCGTT4lyJ/mA2jOIdQvHXSg/tKO4F3Q0Mp3yPTj
         2NZqOozwMIc/ClRvur6y2R+Ox1CFmI87S4Hmh6PJ6n/vUPmJUcJDgd5VWryVcE9Q9ds6
         NXug==
X-Forwarded-Encrypted: i=1; AHgh+RpuRGkUCDo9GhwNMnHr6nRdCfCDMTiCuDIfQPmS4nfRJtgl5bNJUz6w0fBzps28J/g5UEanofnqplBl@vger.kernel.org
X-Gm-Message-State: AOJu0YyKi2zLZ/NC0N3MF4/4KA5/+cL0axoGIBOD3fk1F5ZIeosB3osY
	sxv50l8+yz9td6OvFxigEKBLNyoG8U7L0rrkpDhinzbVVVMLa+bAoz951PZS+GocdOJePYBRzQa
	4Qw4WgOknoecYAbe1Td682pKIaAHeyonWmvh8y/K22D6CV4YKQ/gpku1d7Ds=
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c87:b0:6a0:a791:6885 with SMTP id
 006d021491bc7-6b13c55acf2mr1826471eaf.23.1787106683692; Tue, 18 Aug 2026
 19:31:23 -0700 (PDT)
Date: Tue, 18 Aug 2026 19:31:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a85157b.f7a79266.2f965f.0038.GAE@google.com>
Subject: [syzbot] [acpica?] KASAN: slab-use-after-free Read in acpi_ut_update_object_reference
From: syzbot <syzbot+c6c92a97a9907f92fa1c@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, robert.moore@intel.com, 
	saket.dumbre@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3aa1dcaa4f6f Revert "wifi: mt76: Disable napi when removin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c5ac79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c92a97a9907f92fa1c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3aa1dcaa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e219f4b3c94a/vmlinux-3aa1dcaa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2bd57f22288/bzImage-3aa1dcaa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6c92a97a9907f92fa1c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in acpi_ut_update_object_reference+0x701/0x800 drivers/acpi/acpica/utdelete.c:544
Read of size 1 at addr ffff888021a39f11 by task syz.7.954/9138

CPU: 0 UID: 0 PID: 9138 Comm: syz.7.954 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 acpi_ut_update_object_reference+0x701/0x800 drivers/acpi/acpica/utdelete.c:544
 acpi_ut_add_reference+0x80/0x170 drivers/acpi/acpica/utdelete.c:694
 acpi_ex_resolve_node_to_value+0x7e1/0x9a0 drivers/acpi/acpica/exresnte.c:135
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
 acpi_pci_irq_enable+0x1f5/0x6f0 drivers/acpi/pci_irq.c:414
 pcibios_enable_device+0xb6/0xe0 arch/x86/pci/common.c:699
 do_pci_enable_device+0x21f/0x4a0 drivers/pci/pci.c:1998
 pci_enable_device_flags+0x27c/0x370 drivers/pci/pci.c:2089
 udc_pci_probe+0x55/0x8a0 drivers/usb/gadget/udc/amd5536udc_pci.c:103
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
RIP: 0033:0x7fdb8c39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdb8d2d0028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fdb8c625fa0 RCX: 00007fdb8c39e0d9
RDX: 000000000000000c RSI: 0000200000001700 RDI: 0000000000000005
RBP: 00007fdb8c435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdb8c626038 R14: 00007fdb8c625fa0 R15: 00007ffd31b52658
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
 acpi_ds_build_internal_package_obj+0xa8c/0xe60 drivers/acpi/acpica/dspkginit.c:92
 acpi_ds_eval_data_object_operands+0x2fd/0x640 drivers/acpi/acpica/dsopcode.c:638
 acpi_ds_exec_end_op+0xe41/0x1e60 drivers/acpi/acpica/dswexec.c:617
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

Freed by task 6178:
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
 acpi_pci_irq_disable+0x1a8/0x360 drivers/acpi/pci_irq.c:499
 pcibios_disable_device arch/x86/pci/common.c:706 [inline]
 pcibios_disable_device+0x89/0xb0 arch/x86/pci/common.c:703
 do_pci_disable_device+0x9f/0x100 drivers/pci/pci.c:2170
 pci_disable_device+0x130/0x270 drivers/pci/pci.c:2206
 udc_pci_probe+0x39b/0x8a0 drivers/usb/gadget/udc/amd5536udc_pci.c:188
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

The buggy address belongs to the object at ffff888021a39f08
 which belongs to the cache Acpi-Operand of size 72
The buggy address is located 9 bytes inside of
 freed 72-byte region [ffff888021a39f08, ffff888021a39f50)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888021a39dd0 pfn:0x21a39
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801bc4da40 ffffea0000869290 ffffea0000868d90
raw: ffff888021a39dd0 0000000800270012 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2659888968, free_ts 0
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
 acpi_ds_build_internal_object+0x173/0x790 drivers/acpi/acpica/dsobject.c:94
 acpi_ds_build_internal_package_obj+0x481/0xe60 drivers/acpi/acpica/dspkginit.c:202
 acpi_ds_eval_data_object_operands+0x2fd/0x640 drivers/acpi/acpica/dsopcode.c:638
 acpi_ds_exec_end_op+0xe41/0x1e60 drivers/acpi/acpica/dswexec.c:617
 acpi_ps_parse_loop+0x5e1/0x26e0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x81e/0x1120 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_table+0x393/0x500 drivers/acpi/acpica/psxface.c:295
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888021a39e00: fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb fb
 ffff888021a39e80: fc fc fc fc fa fb fb fb fb fb fb fb fb fc fc fc
>ffff888021a39f00: fc fa fb fb fb fb fb fb fb fb fc fc fc fc fa fb
                         ^
 ffff888021a39f80: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
 ffff888021a3a000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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
