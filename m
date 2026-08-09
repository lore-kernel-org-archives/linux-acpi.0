Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A68221FB6
	for <linux-acpi@vger.kernel.org>; Sun,  9 Aug 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786261646; cv=none; b=XuwOKWrsQpTmR/qvERymahk5GVHMLYDHWHjw9/yYWh0FVf7N/NkLDzRDJgDfW2+pQSFCm3mHXliJ6KdEDL88N02D6tDietfxpRF0In6GNOzMFQ8Fn26PmYPXO7H3/HVRgN073Aaim/otK11GttgwLh9pzTP6b9H/k90lm6TvKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786261646; c=relaxed/simple;
	bh=MxxK1nswFdGGIQiE2Cgw7vJY/VTYW1q42GfKB1Dk82A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZZVj0zI6LHXbMIO1BS5jI9HKn9++pypXwc2LW64MXYGxkbCH4DYOYazyCgu6BDs6W2GwYVavjPKLTMt3sq7pTvYSBe0A+A9qbffRTHBDLLTDap+NoIrlgdyLvI6SwwZU1zvEcBW3I3mo2gEFmOqbSkwskSMe5od20+bh/9fL80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-458582a8c9fso126197fac.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Aug 2026 00:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786261643; x=1786866443;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EoRtarnkCMgBYDZmui+42eWr+FzDy4ub2bi2lcKX4OY=;
        b=M3gzD2GJZHNu8jGvyAzP4mTIXlXHNooo10n6CmTAxALvSNseqrMk5HmN7jXzsA/kTh
         sYNGPS8w6u3J3AtdW5jNOz4YpXIb00OsoO9mrwpcQtAU/aI3acputnvuj2PjHATzY+JO
         qGXSASNnyRA6adBBar9uLu19N9jiZRiemHs+XTU7T1jr3OP8AZJddr8gH5zPzTHXCQV0
         SGWpwmvnhrSwXxLNP8p1pL24hHladF0fFsBZ1LoscXHpQtwrvSHCmZfOBoaO14vmuHzl
         AKKN5WChIkCR8OdSZxLCD6ehVFf0NxmyPgtWPG193Q+8cygAJasNMNZL/XVmTjNQpKQd
         //zw==
X-Forwarded-Encrypted: i=1; AHgh+RrKfRTGWl2SlQsMszk3HEyVaSOgE9udtpfA/XxOCc8tnr4t1RF78ba2aX7jyMAiUib7Qvj7XNg/Blnn@vger.kernel.org
X-Gm-Message-State: AOJu0YzfX3tVTEaPHA7+9Zo4MTJq5/nFXrNkvCHB63z0LVMP1pmfLRBx
	MgYhpAUiJRLzUNDAMwUDOBFbO77cnBQtI7gBv/+2WMPetglBWOWqnUf8U8iW7i38RZZ5Xs+vBsP
	atb3kAlTmbZG6SLk3hMv6hYklhSCrx9DYIaXvqpp3SFxX/c/sTdIXrjDsw9E=
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5392:b0:48f:a9f3:1c38 with SMTP id
 5614622812f47-4afadebaf89mr19199567b6e.2.1786261643402; Sun, 09 Aug 2026
 00:47:23 -0700 (PDT)
Date: Sun, 09 Aug 2026 00:47:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a78308b.b50370da.49fe0.003b.GAE@google.com>
Subject: [syzbot] [acpica?] KCSAN: data-race in number / vsnprintf
From: syzbot <syzbot+6fd18c31ea0ad8f3d5ee@syzkaller.appspotmail.com>
To: acpica-devel@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, robert.moore@intel.com, 
	saket.dumbre@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140dbe32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=6fd18c31ea0ad8f3d5ee
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1a0ae21bd78/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9be505d18eb6/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ab6a3838bc0/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fd18c31ea0ad8f3d5ee@syzkaller.appspotmail.com

      osl-1334 os_signal_semaphore   : Signaling semaphore[ffff8881000c3390|1]
==================================================================
BUG: KCSAN: data-race in number / vsnprintf

write to 0xffffffff89405bc0 of 30 bytes by task 3755 on cpu 1:
 vsnprintf+0x2c0/0x8c0 lib/vsprintf.c:2896
 vsprintf+0x2a/0x40 lib/vsprintf.c:3090
 acpi_os_vprintf drivers/acpi/osl.c:162 [inline]
 acpi_os_printf+0x87/0x200 drivers/acpi/osl.c:153
 acpi_debug_print+0x113/0x200 drivers/acpi/acpica/utdebug.c:158
 acpi_os_wait_semaphore+0x29e/0x2b0 drivers/acpi/osl.c:1310
 acpi_ut_acquire_mutex+0x242/0x4a0 drivers/acpi/acpica/utmutex.c:241
 acpi_ns_get_node+0x46/0xc0 drivers/acpi/acpica/nsutils.c:721
 acpi_get_handle+0xfd/0x180 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x46/0x80 drivers/acpi/utils.c:672
 acpi_pci_set_power_state+0x5d/0x190 drivers/pci/pci-acpi.c:1084
 platform_pci_set_power_state drivers/pci/pci.c:1068 [inline]
 pci_power_up+0x40/0x3b0 drivers/pci/pci.c:1306
 pci_pm_power_up_and_verify_state+0x29/0x130 drivers/pci/pci.c:3153
 pci_pm_default_resume_early drivers/pci/pci-driver.c:591 [inline]
 pci_pm_restore_noirq+0x53/0x1b0 drivers/pci/pci-driver.c:1259
 dpm_run_callback+0x53/0x2f0 drivers/base/power/main.c:510
 device_resume_noirq+0x851/0x880 drivers/base/power/main.c:857
 async_resume_noirq+0x2c/0x40 drivers/base/power/main.c:879
 async_run_entry_fn+0x52/0x180 kernel/async.c:129
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

write to 0xffffffff89405bca of 1 bytes by task 3757 on cpu 0:
 number+0x5c2/0xb80 lib/vsprintf.c:553
 vsnprintf+0x68f/0x8c0 lib/vsprintf.c:2909
 vsprintf+0x2a/0x40 lib/vsprintf.c:3090
 acpi_os_vprintf drivers/acpi/osl.c:162 [inline]
 acpi_os_printf+0x87/0x200 drivers/acpi/osl.c:153
 acpi_debug_print+0x150/0x200 drivers/acpi/acpica/utdebug.c:171
 acpi_ut_status_exit+0xc1/0x120 drivers/acpi/acpica/utdebug.c:-1
 acpi_ns_get_node+0xa2/0xc0 drivers/acpi/acpica/nsutils.c:-1
 acpi_get_handle+0xfd/0x180 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x46/0x80 drivers/acpi/utils.c:672
 acpi_pci_set_power_state+0x5d/0x190 drivers/pci/pci-acpi.c:1084
 platform_pci_set_power_state drivers/pci/pci.c:1068 [inline]
 pci_power_up+0x40/0x3b0 drivers/pci/pci.c:1306
 pci_pm_power_up_and_verify_state+0x29/0x130 drivers/pci/pci.c:3153
 pci_pm_default_resume_early drivers/pci/pci-driver.c:591 [inline]
 pci_pm_restore_noirq+0x53/0x1b0 drivers/pci/pci-driver.c:1259
 dpm_run_callback+0x53/0x2f0 drivers/base/power/main.c:510
 device_resume_noirq+0x851/0x880 drivers/base/power/main.c:857
 async_resume_noirq+0x2c/0x40 drivers/base/power/main.c:879
 async_run_entry_fn+0x52/0x180 kernel/async.c:129
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

value changed: 0x73 -> 0x65

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3757 Comm: kworker/u8:46 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: async async_run_entry_fn

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
