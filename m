Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455401;
	b=jLWCagm2XbJfQRHTYeW0RinjyDdUXdSUZ/+OGb/sASqCajmN6KGRrEw+0I3uZYgE5/V/
	 VLMOxGW5GWSpFo2hAFkOtPoIf6gRLQBbfRPoR0Z/4MtbPvDjpcxcOGPqdS+OW9RwHve2V
	 gaRDAI3EQaT9EhFBOKr+y4IKtMVwR64OQaYqI4Wi1ObhPgYGlM5CFFsLG1cg4lNheVBKP
	 8fgrgvbUqNXET2JczstUfSz4ic1hSCJHRyHyPb8OQSRuQGmQSSYg33pbBAG8+hmx3gVwK
	 FF0C7MEv7NHEk/NYMYq3FVPaxHjQ+J9FWIKuAG995IXBlj2kOd++wxe5Vj/TfDyzWVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455401;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=HOD+pvsCAakPIqAhHkyWdm2kYq6q1N6qhotia7J/S1c=;
	b=JocBwvQPbEq/NfTQFu+BzGNqDmPZHM5UMUATQ3FY9cP9jQ8Dp3Nfsfh79urrE+wKI+KT
	 ujMCiRg5DLgvUcHUTbBvI6MouMDUlcpFe9eXvucmGDz1WfGhBFqr2xpgOfUn8pIcrWQq7
	 6nXpqZmwUgwr3y5BIJhcLjeXIzg1okTcLJfugIc7csA45vc8f/Z9RWy7u/iO/Br090pA1
	 llrrCF1ktGdNHkdz+MsyUj1FDr3FaHflOgXF88Cu+RP3zRYGVBiVTlenplO1KRH6n8iQj
	 kBwYQesbF3G92JXRDcIlfFC3wo58jC1BilV/Me9UWAKcLYYiAAQIjKidPdDM26iea5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF7606A32C
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 00:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FAF7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c307941971so4355937b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 17:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455400; x=1793060200;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOD+pvsCAakPIqAhHkyWdm2kYq6q1N6qhotia7J/S1c=;
        b=Bih06zDYbuvq6zatXFFFhGQIKhZDh/zSDiguY1AE8ZcmVaxofO/x6z5zBU/3J5Xagn
         nhl2+Nf57w+VnS2p/G4zT/abaU6QnpdbT9VeNCxsSmgGSmdVDVegO4gwkv014DBsvaVL
         AqR0hnWuQCukL0Xarro+4rOkUXaYzwumh0+zUVvrAN+rSsfKBzBbHp3KkaFXHlWChYem
         11FkKdTaxbiO3wKz1Ina/cx9mrTeitZeh+oznVm75XwANH3C8tM37nASTNiFQz9JyXHR
         i0AsK9WvothTU2ypkwC95zlybsPa6hHL6bWD/8J8kXbZ00arTZbVuou6zxtPlvhNVdaY
         fSoA==
X-Forwarded-Encrypted: i=1; AKwUvByHMW4xnkhP76YQcfH6tkP2NNGm4PWn6zEKrOLUkIQ6rdXxDD5xmQb4f7ds9rP+izRUcVi2nzNq4ymn@vger.kernel.org
X-Gm-Message-State: AFq9FYKl7t7090VvVEdYU2FaV38RsWQ9PhtiqxFNgMj4rKNE/vJCAxQw
	QirVwJRfQW8x3acy51Q6NRkEv6LaY/PXkoIxnmKZl/LqbMwqRBU0+q5gNRjxNA4B75HUOW3Z8a2
	sRu5lDRwP0AvBRNqDCpSJ4Nkizue6uiQd/Dtf93X1YmZkRDh6MfToRTq7nBQ=
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f53:b0:4f6:1336:cdf9 with SMTP id
 5614622812f47-53cd42a766amr8944900b6e.35.1792455400424; Mon, 19 Oct 2026
 17:16:40 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:16:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad6b2e8.b5bd089a.6b57.0083.GAE@google.com>
Subject: [syzbot] [acpica?] KASAN: slab-use-after-free Read in acpi_ns_check_package
From: syzbot <syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, rafael@kernel.org, robert.moore@intel.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fcb05b72344 Merge tag 'libcrypto-fixes-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dab29c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e
dashboard link: https://syzkaller.appspot.com/bug?extid=e1268acad3c273b12120
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0fcb05b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d63a4093e9d7/vmlinux-0fcb05b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/238bf14f8b3f/bzImage-0fcb05b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com

ACPI Error: AE_NO_MEMORY, Could not update object reference count (20260408/utdelete-651)
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 UID: 0 PID: 5326 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x410/0x560 lib/fault-inject.c:174
 should_failslab+0xa8/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4638 [inline]
 slab_alloc_node mm/slub.c:4974 [inline]
 kmem_cache_alloc_noprof+0xa1/0x600 mm/slub.c:5010
 acpi_ut_create_generic_state drivers/acpi/acpica/utstate.c:90 [inline]
 acpi_ut_create_update_state+0x76/0x110 drivers/acpi/acpica/utstate.c:165
 acpi_ut_create_update_state_and_push+0x2a/0x70 drivers/acpi/acpica/utmisc.c:172
 acpi_ut_update_object_reference+0x2c0/0x870 drivers/acpi/acpica/utdelete.c:563
 acpi_ds_do_implicit_return+0x2ba/0x3c0 drivers/acpi/acpica/dsutils.c:113
 acpi_ds_is_result_used+0x7a/0x8c0 drivers/acpi/acpica/dsutils.c:156
 acpi_ds_delete_result_if_not_used+0xb1/0x190 drivers/acpi/acpica/dsutils.c:320
 acpi_ds_exec_end_op+0x1015/0x1b00 drivers/acpi/acpica/dswexec.c:740
 acpi_ps_parse_loop+0xfa3/0x23f0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x388/0x1020 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_method+0x89d/0xa70 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0xd05/0x1320 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xe1/0x560 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0xb2/0x150 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0x98/0xe0 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x163/0x1040 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x45/0x690 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_disable+0x151/0x340 drivers/acpi/pci_irq.c:499
 do_pci_disable_device drivers/pci/pci.c:2203 [inline]
 pci_disable_device+0x1d6/0x320 drivers/pci/pci.c:2239
 pci_device_remove+0x99/0x1c0 drivers/pci/pci-driver.c:535
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0xf6/0x120 drivers/pci/remove.c:94
 pci_stop_and_remove_bus_device drivers/pci/remove.c:129 [inline]
 pci_stop_and_remove_bus_device_locked+0x77/0xb0 drivers/pci/remove.c:137
 remove_store+0xe5/0x150 drivers/pci/pci-sysfs.c:524
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f32c179e559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f32c2588fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f32c1a25fa0 RCX: 00007f32c179e559
RDX: 0000000000000001 RSI: 0000200000000580 RDI: 0000000000000009
RBP: 00007f32c18358b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f32c1a26038 R14: 00007f32c1a25fa0 R15: 00007fff5dc47ed8
 </TASK>
ACPI Error: AE_NO_MEMORY, Could not update object reference count (20260408/utdelete-651)
==================================================================
BUG: KASAN: slab-use-after-free in acpi_ns_check_package+0x163c/0x1950 drivers/acpi/acpica/nsprepkg.c:274
Read of size 1 at addr ffff888000d624e9 by task syz.0.0/5326

CPU: 0 UID: 0 PID: 5326 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 acpi_ns_check_package+0x163c/0x1950 drivers/acpi/acpica/nsprepkg.c:274
 acpi_ns_check_return_value+0x22f/0x3a0 drivers/acpi/acpica/nspredef.c:136
 acpi_ns_evaluate+0xd5f/0x1320 drivers/acpi/acpica/nseval.c:261
 acpi_ut_evaluate_object+0xe1/0x560 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0xb2/0x150 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0x98/0xe0 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x163/0x1040 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x45/0x690 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_disable+0x151/0x340 drivers/acpi/pci_irq.c:499
 do_pci_disable_device drivers/pci/pci.c:2203 [inline]
 pci_disable_device+0x1d6/0x320 drivers/pci/pci.c:2239
 pci_device_remove+0x99/0x1c0 drivers/pci/pci-driver.c:535
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0xf6/0x120 drivers/pci/remove.c:94
 pci_stop_and_remove_bus_device drivers/pci/remove.c:129 [inline]
 pci_stop_and_remove_bus_device_locked+0x77/0xb0 drivers/pci/remove.c:137
 remove_store+0xe5/0x150 drivers/pci/pci-sysfs.c:524
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f32c179e559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f32c2588fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f32c1a25fa0 RCX: 00007f32c179e559
RDX: 0000000000000001 RSI: 0000200000000580 RDI: 0000000000000009
RBP: 00007f32c18358b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f32c1a26038 R14: 00007f32c1a25fa0 R15: 00007fff5dc47ed8
 </TASK>

Allocated by task 1:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:351 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:377
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x2b9/0x600 mm/slub.c:5010
 acpi_ut_allocate_object_desc_dbg+0x8c/0x230 drivers/acpi/acpica/utobject.c:359
 acpi_ut_create_internal_object_dbg+0x4d/0x310 drivers/acpi/acpica/utobject.c:69
 acpi_ds_build_internal_package_obj+0x126/0xbe0 drivers/acpi/acpica/dspkginit.c:92
 acpi_ds_eval_data_object_operands+0x337/0x5c0 drivers/acpi/acpica/dsopcode.c:638
 acpi_ds_exec_end_op+0x1307/0x1b00 drivers/acpi/acpica/dswexec.c:-1
 acpi_ps_parse_loop+0xfa3/0x23f0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x388/0x1020 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_table+0x352/0x440 drivers/acpi/acpica/psxface.c:295
 acpi_ns_execute_table+0x5d0/0x890 drivers/acpi/acpica/nsparse.c:116
 acpi_ns_parse_table+0xef/0x170 drivers/acpi/acpica/nsparse.c:268
 acpi_ns_load_table+0x131/0x430 drivers/acpi/acpica/nsload.c:71
 acpi_tb_load_namespace+0x2ca/0x880 drivers/acpi/acpica/tbxfload.c:158
 acpi_load_tables+0x53/0xf0 drivers/acpi/acpica/tbxfload.c:59
 acpi_bus_init+0x82/0x360 drivers/acpi/bus.c:1373
 acpi_init+0xa1/0x1f0 drivers/acpi/bus.c:1486
 do_one_initcall+0x250/0x870 init/main.c:1362
 do_initcall_level+0x10a/0x1a0 init/main.c:1424
 do_initcalls+0x59/0xa0 init/main.c:1440
 kernel_init_freeable+0x29d/0x3e0 init/main.c:1675
 kernel_init+0x22/0x1d0 init/main.c:1565
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5326:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6509 [inline]
 kmem_cache_free+0x182/0x650 mm/slub.c:6636
 acpi_os_release_object+0x1d/0x30 drivers/acpi/osl.c:1661
 acpi_ut_delete_object_desc+0x9b/0x110 drivers/acpi/acpica/utobject.c:402
 acpi_ut_delete_internal_obj drivers/acpi/acpica/utdelete.c:316 [inline]
 acpi_ut_update_ref_count+0x174c/0x1d10 drivers/acpi/acpica/utdelete.c:436
 acpi_ut_update_object_reference+0x4a8/0x870 drivers/acpi/acpica/utdelete.c:632
 acpi_ds_clear_implicit_return+0x156/0x1f0 drivers/acpi/acpica/dsutils.c:55
 acpi_ds_exec_end_control_op+0x533/0xe00 drivers/acpi/acpica/dscontrol.c:226
 acpi_ds_exec_end_op+0x799/0x1b00 drivers/acpi/acpica/dswexec.c:462
 acpi_ps_parse_loop+0xfa3/0x23f0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x388/0x1020 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_method+0x89d/0xa70 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0xd05/0x1320 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xe1/0x560 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0xb2/0x150 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0x98/0xe0 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x163/0x1040 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x45/0x690 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_disable+0x151/0x340 drivers/acpi/pci_irq.c:499
 do_pci_disable_device drivers/pci/pci.c:2203 [inline]
 pci_disable_device+0x1d6/0x320 drivers/pci/pci.c:2239
 pci_device_remove+0x99/0x1c0 drivers/pci/pci-driver.c:535
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0xf6/0x120 drivers/pci/remove.c:94
 pci_stop_and_remove_bus_device drivers/pci/remove.c:129 [inline]
 pci_stop_and_remove_bus_device_locked+0x77/0xb0 drivers/pci/remove.c:137
 remove_store+0xe5/0x150 drivers/pci/pci-sysfs.c:524
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888000d624e0
 which belongs to the cache Acpi-Operand of size 72
The buggy address is located 9 bytes inside of
 freed 72-byte region [ffff888000d624e0, ffff888000d62528)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xd62
flags: 0x7ff00000000000(node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 007ff00000000000 ffff88801c0a0dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000200270027 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 3956366881
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2209/0x2280 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x217/0x5a0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 kmem_cache_alloc_noprof+0x399/0x600 mm/slub.c:5010
 acpi_ut_allocate_object_desc_dbg+0x8c/0x230 drivers/acpi/acpica/utobject.c:359
 acpi_ut_create_internal_object_dbg+0x4d/0x310 drivers/acpi/acpica/utobject.c:69
 acpi_ds_build_internal_object+0x294/0x690 drivers/acpi/acpica/dsobject.c:94
 acpi_ds_build_internal_package_obj+0x599/0xbe0 drivers/acpi/acpica/dspkginit.c:202
 acpi_ds_eval_data_object_operands+0x337/0x5c0 drivers/acpi/acpica/dsopcode.c:638
 acpi_ds_exec_end_op+0x1307/0x1b00 drivers/acpi/acpica/dswexec.c:-1
 acpi_ps_parse_loop+0xfa3/0x23f0 drivers/acpi/acpica/psloop.c:553
 acpi_ps_parse_aml+0x388/0x1020 drivers/acpi/acpica/psparse.c:489
 acpi_ps_execute_table+0x352/0x440 drivers/acpi/acpica/psxface.c:295
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888000d62380: fb fc fc fc fc fa fb fb fb fb fb fb fb fb fc fc
 ffff888000d62400: fc fc 00 00 00 00 00 00 00 00 00 fc fc fc fc 00
>ffff888000d62480: 00 00 00 00 00 00 00 00 fc fc fc fc fa fb fb fb
                                                          ^
 ffff888000d62500: fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb
 ffff888000d62580: fb fb fc fc fc fc fa fb fb fb fb fb fb fb fb fc
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
