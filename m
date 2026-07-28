Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2D3839A0
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211898; cv=none; b=se2dZa9rZ+1SmsL/JfXw+LdEkHCtqN3d6YzZQkOWXFaf8zH5fpgymbjCFnE3gAdJOZmfKAjJbwmRe+ilOgGn6Bh8LQDCLxcn9HVKj+IxpybWSS+HxvlcPaz2BAVRNO6vHN7jdIu4rsL4fOuKjcuodgRobrrxUE06QlgAVsz7XfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211898; c=relaxed/simple;
	bh=MZl83Jgb+124Y3eKh6SJrVGD842fjuW98zkg2v+QWfo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EAdLqGN0LtcOPmDG0ajE2hRmMbnO6OsEc6No++wuokQKTuMkDDE3IWANf3sMAOnUl/jaF6ZuDb1Po249FgvFTP5Y5WAXZpnyfiF89J3u2Q7FLgc+NJLjwKLhCqEp3odkVam/MQhW/qg+ATFNXLVKkM8YP/Zz3qEdIhTSq7OArGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6a13b72112dso3500668eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 21:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785211895; x=1785816695;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbGGrH0cj1r6xVSHJTMQNCv359Cy4DnMO+j4jgY5Qt4=;
        b=g529IL4XsxvUrUMUEbybboIQXDtMaVbbOYXvAi3rCWLblM4yYWMYkgo/MsjvJKU8yD
         WNLPBZco7qPIPEqaYQ75XfXfqevPKsXGvmlyzbBWbBd82ODctohTbjujoIMk1GhLz/0B
         aLBxdyYNCNMWTDCBHW7Ctisww0gh1I8k3J88bu8iNQpihXaTSpdHZ3BOAToyVaFK38tC
         lYZlSqgLRDK9EXjSPee7eM4StLi2RjAX+sX0bwAzZdi09r2ntpaPGtyn2D8hZbBL9wao
         zB9jbTgon1iveJHCcp8ukiOX7pIjRwjMKUCBFvDb1x3f+PQd4DZwiYSzzbRV111JXojL
         ee8w==
X-Forwarded-Encrypted: i=1; AHgh+RoPwU8Yuqt4t5fyvRX2ggO5LM9F4NZTXePr1VTjgKowOWDu+OCTuor/TZWz2JF7IsfY0crwQ3j8SKwD@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmJCZb+fTi8s+0F1YlG9bQwpyFaz5sUvU2uW3InU/iEw8ol5f
	0lRJWNyALUSzBTbhDzrIs5nwQZ6bAAbRoZz/w8CllLTVV8UUz4oZwUJNGN+pLxLONtcqkPhcMr2
	JavfqnA/5ezh8QjLrVZmrz+X7Ny5EqDgXMZ6ofkFskzSxUjKZLrDZqSbtMo8=
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150a:b0:6a3:813d:c84b with SMTP id
 006d021491bc7-6ac96d6d56emr418121eaf.63.1785211895605; Mon, 27 Jul 2026
 21:11:35 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a682bf7.70955b6c.323240.0052.GAE@google.com>
Subject: [syzbot] [acpica?] KASAN: use-after-free Read in acpi_ns_get_attached_object
From: syzbot <syzbot+5725792ce6a9938d1b24@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, robert.moore@intel.com, 
	saket.dumbre@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a293ec25d59d Merge tag 'linux_kselftest-fixes-7.1-rc3' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ac3b26580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
dashboard link: https://syzkaller.appspot.com/bug?extid=5725792ce6a9938d1b24
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7cc7565720f7/disk-a293ec25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d78e9e8aa32/vmlinux-a293ec25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5c85a1abd99/bzImage-a293ec25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5725792ce6a9938d1b24@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in acpi_ns_get_attached_object+0x148/0x1b0 drivers/acpi/acpica/nsobject.c:258
Read of size 1 at addr ffff8880216de8f8 by task syz.2.1126/11381

CPU: 0 UID: 0 PID: 11381 Comm: syz.2.1126 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 acpi_ns_get_attached_object+0x148/0x1b0 drivers/acpi/acpica/nsobject.c:258
 acpi_ns_evaluate+0x158/0x1670 drivers/acpi/acpica/nseval.c:83
 acpi_ut_evaluate_object+0xf7/0x610 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0xa0/0x150 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0xb8/0x140 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x179/0xdd0 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x8e/0x6b0 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_enable+0x1f5/0x6f0 drivers/acpi/pci_irq.c:414
 pcibios_enable_device+0xb6/0xe0 arch/x86/pci/common.c:699
 do_pci_enable_device+0x21f/0x4a0 drivers/pci/pci.c:2000
 pci_enable_device_flags+0x27c/0x370 drivers/pci/pci.c:2091
 enable_store+0x1e1/0x260 drivers/pci/pci-sysfs.c:341
 dev_attr_store+0x58/0x80 drivers/base/core.c:2437
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b35f9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b36df4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7b36215fa0 RCX: 00007f7b35f9cdd9
RDX: 0000000000000081 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007f7b36032d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7b36216038 R14: 00007f7b36215fa0 R15: 00007ffcfd654598
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x4b pfn:0x216de
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f0(buddy)
raw: 00fff00000000000 ffffea0000ab0808 ffffea0000a7ef48 0000000000000000
raw: 000000000000004b 0000000000000000 00000000f0000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x100cc2(GFP_HIGHUSER), pid 10859, tgid 10858 (syz.1.1050), ts 363170141420, free_ts 364039095485
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x11a6/0x33b0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5226
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 alloc_pages_noprof+0x1a/0x160 mm/mempolicy.c:2581
 kimage_alloc_pages+0x72/0x380 kernel/kexec_core.c:284
 kimage_alloc_page+0x232/0x910 kernel/kexec_core.c:686
 kimage_load_normal_segment kernel/kexec_core.c:825 [inline]
 kimage_load_segment+0x507/0xde0 kernel/kexec_core.c:943
 do_kexec_load+0x58d/0x810 kernel/kexec.c:155
 __do_sys_kexec_load kernel/kexec.c:261 [inline]
 __se_sys_kexec_load kernel/kexec.c:242 [inline]
 __x64_sys_kexec_load+0x1bf/0x230 kernel/kexec.c:242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 10859 tgid 10858 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0x747/0x1040 mm/page_alloc.c:2943
 kimage_free_entry kernel/kexec_core.c:554 [inline]
 kimage_free+0x245/0x5a0 kernel/kexec_core.c:601
 do_kexec_load+0x34c/0x810 kernel/kexec.c:175
 __do_sys_kexec_load kernel/kexec.c:261 [inline]
 __se_sys_kexec_load kernel/kexec.c:242 [inline]
 __x64_sys_kexec_load+0x1bf/0x230 kernel/kexec.c:242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880216de780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880216de800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880216de880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                                ^
 ffff8880216de900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880216de980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
