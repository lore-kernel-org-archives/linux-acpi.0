Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87912378D63
	for <linux-acpi@vger.kernel.org>; Sun, 14 Jun 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475643; cv=none; b=Wmyond61OntlleyMKerFTumRIN4JMjDJKiaR52X/4mjyH5AhNgh/V3gRFE40+ydTmG++as419lG+pJEEf/Z+zkOPMZR/IhMAYTSTuKljGzMbuLabZ/B2fvzEa1oPKiOQr2LAyM1MxJopS94Jm0+cEWJGZZop4rnxz4V6vCC0rrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475643; c=relaxed/simple;
	bh=G8r/95xJ9pTnJbmXhgWqGPDl/XJa8Ir9LGnOlumx2VM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kk/n4IJjpUDZ0YKZLOP/qi6a71SxEU2Luhn5kUN3sNGTWWt2xFefEsgqcNvbEQoYDAiCV5Vyi9LaoMl/hWIdvq2JMc//XuzpMWwGt7jqCmhFDccp5L1RG5d0cJttuWr1LoHJuAajn0gKnPa2P/NLIwnYp24zVHt9JQsHpJQMcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT8fKqLT; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT8fKqLT"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so26873356d6.3
        for <linux-acpi@vger.kernel.org>; Sun, 14 Jun 2026 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781475640; x=1782080440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x79HC4AW88VSJUVztZWqpHV3df6NSlmfvUcZEcWk0J4=;
        b=kT8fKqLTLwKO5azHVYNvkZO6VkNSm4va9Yf++gApzTwOrqpjTMQSv5nkN1d0jz2Hqq
         5n09sQGe0qltx2skBGPavo37m1/MTOVNkyrMzuZVPiHGsyKb4efdNbkpGcNfxz7OukWz
         /K3Fs9qMKq8Z2zpNkmoCda68hPQ611phpyq4M4ik6DfiO3rrFqqUrcjT49+dkhNNrhp4
         jlB9PyObOw1L2Ztadm02U2H3I/BHobC1HjWh4zq37Bgf3ou0SRCyxuDjVd64gh6TAXG+
         PSmjjlNhEMskIDW6wJfzVQUQya4L67qceEP3Z/kzPemhpk3XkB/gQEspb6Ds6V5emipr
         DxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781475640; x=1782080440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x79HC4AW88VSJUVztZWqpHV3df6NSlmfvUcZEcWk0J4=;
        b=BHfuWF1LZn9LXli6PlYoftqyXGO/eaTHWoRRUGIV9hFIZ3jdSbi+fQhwzUoJIYBTAI
         l3J3TWrmX+LKQkV0Gr4CcRzQDKMCzjN8mUt+pPC/pHI86qyAGfzCrcmCMLkTUyYJYdTW
         Z9sExJqF18F+kYLkxW/1CaJZ5jwKucLVJhY6Ue6+8tTZr410tVHdX9VXoiZMmi2JklId
         k9ctc56rwbNJYm1dfbcvIHt82ztBppLwO8FN8LUFomKFpFhRvJVWOTM6FX4/qaAytIAz
         wxZFNR1WGK5OT3Ec2yPusW20CNoM5zKdpOf3vQuLAm7xeNfLOwmcEreRwO8NrGn1722P
         VyoA==
X-Forwarded-Encrypted: i=1; AFNElJ/V14NmP+97HKk6Dd/I04JRCvVpeq+rmJoNWGAIx40nfFCJQfVMhjAoQ7zQ1VBhJX/N0iEw7+ZrprSx@vger.kernel.org
X-Gm-Message-State: AOJu0YykptbpPaNRAQ6sMaPFoLxpv7dlwvtA2DncenwPx3kpO9/6E4t2
	ThGlhHmFXK8Hk90iCiiLlHrpp+8iBVAJUAGrYhm6WRw+IR/EIxeqICjxHcz8Q6UExaM=
X-Gm-Gg: Acq92OFIw/Qf0FaIJ4lAXjqVaueXiG3X5gozj2dEfArSEti6OpcwvN4yJqMPWkVKPXL
	bEgIaE4gIy0dP0DY/jQXTsUjAsIcgiysv11B82gUxxZpKNz2MBc48hYI88IS7sctKrLH40seaFe
	Z6pLu96la2bC8nFzdLgAN9XliDrTfMfQqQ5RepqRlZQT7Y95y/iZeBTdC/AwZomuuKaTdl9IRGW
	Kd/W+JN3jHrcStJ+ym2jIWLSRdU9BH9WYOmmDJcLWEFu6ZXgAgkF7/r8UIg8u8qBg/5arnu617t
	AbBCQovZ/lEfwaMUNGJj/kOsLXHWf02HoCmJaCL7gHySmCWZbz7NcYUfUhlKots8QKYxgyNp8Ua
	e6fxMWxYDVvE7nKBGluc0Vxvtvt5gyBphuFH/57KF5Wbf50n7eRNvWnR8BmoFNu5skksSyl0xKm
	7+GjcrXFhLd507bz1JmCJdUUquENdgybltGg8375GgrrDFNB0tV7XMG/Zu4oR9DHun4j8x0KlO1
	g==
X-Received: by 2002:a05:6214:5408:b0:8d1:ae7a:7d79 with SMTP id 6a1803df08f44-8d450972204mr163526096d6.41.1781475640418;
        Sun, 14 Jun 2026 15:20:40 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb91:14e1:4204:4d87:aacf:f5f1:c2dd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b2cf04sm91315816d6.16.2026.06.14.15.20.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 15:20:40 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-use-after-free in pfru_ioctl
Date: Sun, 14 Jun 2026 18:20:37 -0400
Message-ID: <178144969601.60470.7781990940097306115@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in pfru_ioctl

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/00fb9f2207179688618e3d5e938d93df

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   83.847068][ T8420] BUG: KASAN: slab-use-after-free in pfru_ioctl (drivers/acpi/pfr_update.c:446)
[   83.849125][ T8420] Write of size 4 at addr ffff888102362938 by task pfrut_oldfd_rep/8420
[   83.851358][ T8420]
[   83.852029][ T8420] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   83.852035][ T8420] Call Trace:
[   83.852041][ T8420]  <TASK>
[   83.852046][ T8420]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   83.852061][ T8420]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   83.852098][ T8420]  kasan_report (mm/kasan/report.c:595)
[   83.852121][ T8420]  pfru_ioctl (drivers/acpi/pfr_update.c:446)
[   83.852166][ T8420]  __se_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583)
[   83.852177][ T8420]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   83.852207][ T8420]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   83.852217][ T8420] RIP: 0033:0x7fc16a359237
[   83.852227][ T8420] Code: 00 00 00 48 8b 05 59 cc 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 cc 0d 00 f7 d8 64 89 01 48
[   83.852237][ T8420] RSP: 002b:00007ffe1d81d8d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[   83.852252][ T8420] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc16a359237
[   83.852260][ T8420] RDX: 00007ffe1d81f8f0 RSI: 000000004004ee01 RDI: 0000000000000003
[   83.852266][ T8420] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000008
[   83.852272][ T8420] R10: fffffffffffff66f R11: 0000000000000206 R12: 00007ffe1d81f8f0
[   83.852278][ T8420] R13: 0000000000000000 R14: 00007fc16a43d4c0 R15: 000055c04503b150
[   83.852289][ T8420]  </TASK>
[   83.852293][ T8420]
[   83.870652][ T8420] Freed by task 8420 on cpu 0 at 83.642118s:
[   83.871211][ T8420]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   83.871657][ T8420]  kasan_save_free_info (mm/kasan/generic.c:584)
[   83.872128][ T8420]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   83.872582][ T8420]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[   83.872953][ T8420]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
[   83.873431][ T8420]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
[   83.874003][ T8420]  unbind_store (drivers/base/bus.c:244)
[   83.874436][ T8420]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
[   83.874936][ T8420]  vfs_write (fs/read_write.c:595 fs/read_write.c:688)
[   83.875339][ T8420]  ksys_write (fs/read_write.c:740)
[   83.875748][ T8420]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   83.876187][ T8420]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   83.876745][ T8420]
[   83.876975][ T8420] The buggy address belongs to the object at ffff888102362900
[   83.876975][ T8420]  which belongs to the cache kmalloc-192 of size 192
[   83.878281][ T8420] The buggy address is located 56 bytes inside of
[   83.878281][ T8420]  freed 192-byte region [ffff888102362900, ffff8881023629c0)
[   83.879564][ T8420]


Best,
Shuangpeng
