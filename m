Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154348;
	b=cQ+opXoLTHb7iJIiabeeyq5FgmD2pWMjoIE7iNCvXWWxiSm61EGxNlF7zp/7Z9h8cZ2q
	 q02s80qEMFpttMXfk4stB+r8Yh+lfyembLsbxIORIv3jmIUJwukB3PFOqMnvrLrjhY7PK
	 AmoaXyCUFp8hIrYiI9iQJRGtiszNKmpNko2U0D+iZ51+EHdxF2gV7UIftqJKAzivXGJ4p
	 kVMUzJUgl/YnakuuPkM7qJNByVqyfDgrLh2ueCB0W3WpBgB7lbKDkuDPNUCzsB3EP0FL5
	 gXjxfgLDwYOIzicKP55MIyUAQPWlSNSlz8vCsKe/hwjB/ab2T4CxP/RCBWyADPo1XrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154348;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=rhmKbznBD3f52UhiL1c+PwGZUzJd/M0hsVYysQm4Te8=;
	b=tslKmzuc78XX1trXwv/qrpk2F57mcNEnLim3aFAVdt4T4HyQ8kn7mU1164RXvLjTHGbg
	 WeTqhtXa8To2I6Fp+Ew7ZYADY53EHnYY3s+BAmT5Gss8KJAqqL1Z7QOe6MeA79+uAKGuv
	 Tzbx585U2iOvlGu3Qg/LCN9czM7wp9GNxM9eMVNxA7Noed3/YdoYt6IRmv7Lr/lm6+5eO
	 jZDYEmWA4FH6XkTRIHGRvXwn82MNKuJBGiYLMXUoxaVjQETzRORG0MlsmnHbTjNmdGeot
	 Mm3nis9UkRPd4m3Mbj5tmMEarQsDmtbra4eiEtB2NJIVWIkpoUtqhDsJqCbPaDqLKOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC9606A31D
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 02:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AEC9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b28deb7ee3so866630b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 19:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154347; x=1793759147;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rhmKbznBD3f52UhiL1c+PwGZUzJd/M0hsVYysQm4Te8=;
        b=zLT6Q1xTMN9NbMxnYeZZ4fBgJJmldPWC56icrISXwBwr1EfgjoFfmAbM/t1PatC96t
         8ajDKgmFKa9thI8FwQEKgK7DQUWcnq4PklirS/rijbfOoXDXdcK7NgUboFpQPvH9kYV5
         MBV+fiYAFh++ylZTiuJ/rKmS//Qi9rrS4gL9JHv3f5cRr6AQZeM7ev6H7AYwdWyAudHR
         9EW8ssIkPYae9OWMxuVac3/K705kILyWNPp27G38sRWCYBq5EWwh8H5Nzx6DekhxDAy7
         Y31Cbe4zF3oUrHlqudX3y6KHS+g2hti/B70QKh9QGjNIuGPdFmiff7upZNSLojSfpJ/I
         yGeg==
X-Forwarded-Encrypted: i=1; AKwUvBwp/wgM6+fnwjy6JgRhEQQURVdmHVEscdtpWkGj1y5BNFvIhuDYhmH20Aosg0bFIIcOCUpzbOHAbpuG@vger.kernel.org
X-Gm-Message-State: AFq9FYLbboi+iBG+G/78rfgBsvztZhpN6IgV2fegI6qba7XUmv4bNhBo
	a9EAQAyE8YeRzuKA1shgLiGHkpfttawh71SanSibBlhryTxxr7YWUBB5PJvU/svrx8xWFsWDcEp
	0IjMVme1WIsMDlGSJkq0kAODHP3URrryU4CbLzElMAYFm6CN6foWpe8gts0k=
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f20:b0:4f5:6c14:7978 with SMTP id
 5614622812f47-56383a9103fmr652935b6e.24.1793154347124; Tue, 27 Oct 2026
 19:25:47 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:25:47 -0700
In-Reply-To: <6a85157b.f7a79266.2f965f.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae15d2b.985912ea.1e5798.0125.GAE@google.com>
Subject: Re: [syzbot] [acpica?] KASAN: slab-use-after-free Read in acpi_ut_update_object_reference
From: syzbot <syzbot+c6c92a97a9907f92fa1c@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, rafael@kernel.org, robert.moore@intel.com, 
	saket.dumbre@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    62c457528529 Merge tag 'vfs-7.4-rc1.keyring' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1340e469580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f2905533069b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c92a97a9907f92fa1c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103a8c81580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-62c45752.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6cb6bd98bf2b/vmlinux-62c45752.xz
kernel image: https://storage.googleapis.com/syzbot-assets/139b1aebfd25/bzImage-62c45752.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6c92a97a9907f92fa1c@syzkaller.appspotmail.com

pci 0000:00:04.0:   bridge window [mem 0x80000000-0x801fffff]
pci 0000:00:04.0:   bridge window [mem 0x380000000000-0x3800001fffff 64bit pref]
==================================================================
BUG: KASAN: slab-use-after-free in acpi_ut_update_object_reference+0x701/0x800 drivers/acpi/acpica/utdelete.c:544
Read of size 1 at addr ffff8880236b6f11 by task syz.0.17/6000

CPU: 3 UID: 0 PID: 6000 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
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
 acpi_pci_irq_find_prt_entry+0x178/0xdd0 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x8e/0x6b0 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_enable+0x1f5/0x6f0 drivers/acpi/pci_irq.c:414
 pcibios_enable_device+0xb6/0xe0 arch/x86/pci/common.c:699
 do_pci_enable_device+0x21f/0x4a0 drivers/pci/pci.c:2056
 pci_enable_device_flags+0x27c/0x370 drivers/pci/pci.c:2147
 pcie_port_device_register drivers/pci/pcie/portdrv.c:337 [inline]
 pcie_portdrv_probe+0x167/0x1250 drivers/pci/pcie/portdrv.c:701
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:354
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:416
 __pci_device_probe drivers/pci/pci-driver.c:478 [inline]
 pci_device_probe+0x25b/0x400 drivers/pci/pci-driver.c:512
 call_driver_probe drivers/base/dd.c:629 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:707
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:869
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:899
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1027
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:503
 __device_attach+0x1e4/0x4c0 drivers/base/dd.c:1131
 device_initial_probe+0xaf/0xf0 drivers/base/dd.c:1190
 pci_bus_add_device+0xc5/0x100 drivers/pci/bus.c:373
 pci_bus_add_devices+0x9a/0x1f0 drivers/pci/bus.c:394
 pci_rescan_bus+0x2a/0x40 drivers/pci/probe.c:3509
 rescan_store+0xfb/0x130 drivers/pci/pci-sysfs.c:474
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:173
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc9c9f9f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2d32bec8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc9ca225fa0 RCX: 00007fc9c9f9f559
RDX: 000000000000001e RSI: 0000200000000600 RDI: 0000000000000005
RBP: 00007fc9ca036b20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc9ca225fac R14: 00007fc9ca225fa0 R15: 00007fc9ca225fa0
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:351 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:377
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:5033 [inline]
 kmem_cache_alloc_noprof+0x269/0x6a0 mm/slub.c:5047
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
 acpi_bus_init drivers/acpi/bus.c:1357 [inline]
 acpi_init+0x146/0x840 drivers/acpi/bus.c:1470
 do_one_initcall+0x11c/0x6f0 init/main.c:1423
 do_initcall_level init/main.c:1485 [inline]
 do_initcalls init/main.c:1501 [inline]
 do_basic_setup init/main.c:1521 [inline]
 kernel_init_freeable+0x6ea/0x7b0 init/main.c:1736
 kernel_init+0x21/0x1d0 init/main.c:1626
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6000:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6630 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6757
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
 acpi_pci_irq_find_prt_entry+0x178/0xdd0 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x8e/0x6b0 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_disable+0x1a8/0x360 drivers/acpi/pci_irq.c:499
 pcibios_disable_device arch/x86/pci/common.c:706 [inline]
 pcibios_disable_device+0x89/0xb0 arch/x86/pci/common.c:703
 do_pci_disable_device+0x9f/0x100 drivers/pci/pci.c:2228
 pci_disable_device+0x130/0x270 drivers/pci/pci.c:2264
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:535
 device_remove+0xcb/0x180 drivers/base/dd.c:617
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x441/0x610 drivers/base/dd.c:1380
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0x120/0x160 drivers/pci/remove.c:94
 pci_stop_and_remove_bus_device+0x58/0xa0 drivers/pci/remove.c:129
 pci_stop_and_remove_bus_device_locked+0x1a/0x20 drivers/pci/remove.c:137
 remove_store+0x123/0x140 drivers/pci/pci-sysfs.c:524
 dev_attr_store+0x58/0x80 drivers/base/core.c:2509
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880236b6f08
 which belongs to the cache Acpi-Operand of size 72
The buggy address is located 9 bytes inside of
 freed 72-byte region [ffff8880236b6f08, ffff8880236b6f50)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x236b6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801d44da40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000200270027 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2738198611
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1854
 prep_new_page mm/page_alloc.c:1862 [inline]
 get_page_from_freelist+0x1113/0x35e0 mm/page_alloc.c:3933
 __alloc_frozen_pages_noprof+0x2f6/0x3190 mm/page_alloc.c:5429
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab mm/slub.c:3499 [inline]
 new_slab+0xb1/0x6d0 mm/slub.c:3550
 refill_objects+0xe3/0x410 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 kmem_cache_alloc_noprof+0x4bf/0x6a0 mm/slub.c:5047
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
 ffff8880236b6e00: fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb fb
 ffff8880236b6e80: fc fc fc fc fa fb fb fb fb fb fb fb fb fc fc fc
>ffff8880236b6f00: fc fa fb fb fb fb fb fb fb fb fc fc fc fc 00 00
                         ^
 ffff8880236b6f80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff8880236b7000: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
