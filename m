Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13771F4CB3
	for <linux-acpi@vger.kernel.org>; Sun, 14 Jun 2026 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781466171; cv=none; b=Yw/ypr3aKET2ulfB3T7E53yc4Q0+BGKm5SjVNBLdZtCYPO9EedbVD3GOhLN9TynjD9KY4YNADB6iW8nSt40qEA1MrKlaRROZ44AxbQi0ayRgVEuX1Y/WyWNEi3FgOIAakQwtROubub/qXo7uCaaC4INT53xIPTYQ+Dhh5z7Zjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781466171; c=relaxed/simple;
	bh=YxnL7xpCUgIOrwc6BYPVsk0zqOHSkBhvqAz930dSK4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vjh6lVhSb6TpyvNEcqh848zq+IHrMsnJ0iBr2B1UrMx+nH5z+v+tfMC4XG69hlFk/tI97ioNsbbwWuu+AHIogkdlFhTnULmgZ8xcIooNLOD9CZUrFy+0dPGyb8guPn0o9rw5V5aII4tTGDhx1NmxAzVnx8ElhVx4HB7xCip3dL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWGDiguz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWGDiguz"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517863a2edfso21489681cf.1
        for <linux-acpi@vger.kernel.org>; Sun, 14 Jun 2026 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781466169; x=1782070969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zb70ubGklGxvCJqP74nlF544hbhydrv7hgQ5+0sOggE=;
        b=EWGDiguzMKH3BBeh5efWGuXkltY3g/iNZbX8x40jvc0bIxJhZ2n2vm0szyMQStEHKQ
         nZe6a3WkSOr6BkHmA0ykhcLwyj22fqbqx/lhIpQ6SCawcQZ1UiWF4hpEZAWP8u2mDBwG
         n11OzCmao7kIdI7rhIGf1fOh7cRjQ3extKcmeBEUsS3f1yyHsgpOQoH+CHee5wK3irMa
         a2nP4U8n5udWLDBIA8Nr5NM3hwwPhTd2gBeN+eg5FIcXSDzs77tupmnIU8bq0F9lu97x
         kEtrFXtBlo1/ZsbT4PLmWGWN6+0sc8MRNhHRgoFLIJv9XgVWs4xDSMSEVru0EfUvmLRM
         WDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781466169; x=1782070969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb70ubGklGxvCJqP74nlF544hbhydrv7hgQ5+0sOggE=;
        b=bj255p64LHE+42hSh4OESLbSQ5Bu/wq6of7H0BBONayiSbnSS0zzhnZJHvqoITmQzq
         fdJrLckbp4bC2bLM0tf615uWI/EfPxfKRWPiz6Q3J6Xic1xCt8rv9miL1nPjsg+KwJ70
         GGt0VUOZ0PA1B/rlkrHVluk7NCj7sM3lY5lZRJdatxvtiVdJPpCSjd72OmDlSqAwAXN7
         qBkgPKvVuCh/gGAcmM8YLa+7y+Jh9Qp2anp0LovEKqUvh0dnu2yKnH8IsZYAUcnqr7EZ
         PvmSbL8SbcvtGfEr0yMDBBH207WSl+MnB/jQg5Cj8u4k2HcVkJJKeZ1lcK5LCnUdq2rc
         1AFw==
X-Forwarded-Encrypted: i=1; AFNElJ8y45Z6yQkUWCEOhyxvGYp4BH0V4YlwlYRuMtqSwAXNL1PyaEnVrXl7TO7hfVKQO5Vx+y1TFdKVRqI2@vger.kernel.org
X-Gm-Message-State: AOJu0YwXN+F2/XXrci4quRQk5SgzkNnriiAfL7lpr2XnhAG1bcf+kJp1
	RIJ+XDbYgVnENq8rh+bnFSXe3kvti60qcht+Y4BfuNbzTEQ2LawNIYcCZC0b0cfW2p8=
X-Gm-Gg: Acq92OGTv6MuCQ/l4iL8x0Ijf4Iwe1ELd2F364HrHZ0NNV1sqcX15ejIPu6uW/9bxQ8
	P2d42N/XUqL0uWlC63ry4L2P+3fHzFCTKXwLbzatqPlb+jA/oqGulNPWOtxN/bF4YqapFJPSKEv
	TnznCjA8ZfT9VmgCWSdd0iYGs3eU1dOt9D7jWY/a8dN10iesCpEijHdIQIp53iiPq7NfLzOU/jp
	l/UuXIa+mCMSZDijaksnxw7OeTlZWz10G/IBtldGWkGI+L1UB31db8HqQQAOiyDWIm4mGgDPXBW
	QUaDIOhoi5mP/CiKX4KLw8uhnS2+NquYNxJDPgY4lcAT5Kmjz4IZVSuhR1p96fMDUQSxAqIYVIM
	AtzWWhagAQ3FguF3zdUv4S0Wgw5vD8vDhxXqoxNazeoGLiRVwvzBvBLoQaQgSk4Sg3dJlNaHXt5
	MrqhjmBTqbZ1iYxaQ38N5nWQiDToqLpEr5Yogg+XiQ77VFLiOA5kfumEomDCFnjYqdhMqcBNsG
X-Received: by 2002:ac8:5f89:0:b0:517:5e32:f3ad with SMTP id d75a77b69052e-517fe4d72d3mr178336341cf.26.1781466168741;
        Sun, 14 Jun 2026 12:42:48 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:a8d1:8eec:c0e9:106e:b2e:e8e9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm85323081cf.20.2026.06.14.12.42.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 12:42:48 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-use-after-free in get_pfrt_log_data_info
Date: Sun, 14 Jun 2026 15:42:47 -0400
Message-ID: <178144969601.60470.3508974301899957212@gmail.com>
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

KASAN: slab-use-after-free in get_pfrt_log_data_info

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/d516798907ff96ec17e58f43057f3060

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   52.268064][ T8345] BUG: KASAN: slab-use-after-free in get_pfrt_log_data_info (drivers/acpi/pfr_telemetry.c:82)
[   52.270424][ T8345] Read of size 8 at addr ffff8881023d9048 by task pfrt_telemetry_/8345
[   52.272696][ T8345]
[   52.273378][ T8345] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   52.273386][ T8345] Call Trace:
[   52.273392][ T8345]  <TASK>
[   52.273396][ T8345]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   52.273410][ T8345]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   52.273456][ T8345]  kasan_report (mm/kasan/report.c:595)
[   52.273475][ T8345]  get_pfrt_log_data_info (drivers/acpi/pfr_telemetry.c:82)
[   52.273542][ T8345]  pfrt_log_mmap (drivers/acpi/pfr_telemetry.c:314)
[   52.273588][ T8345]  mmap_region (include/linux/fs.h:2071 mm/internal.h:168 mm/vma.c:2496 mm/vma.c:2562 mm/vma.c:2771 mm/vma.c:2857)
[   52.273703][ T8345]  do_mmap (mm/mmap.c:560)
[   52.273756][ T8345]  vm_mmap_pgoff (mm/util.c:581)
[   52.273805][ T8345]  ksys_mmap_pgoff (mm/mmap.c:606)
[   52.273815][ T8345]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   52.273829][ T8345]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   52.273840][ T8345] RIP: 0033:0x7f7d75db90d2
[   52.273850][ T8345] Code: e4 e8 62 64 01 00 66 90 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 8b 05 89 8d 0d 00 64
[   52.273859][ T8345] RSP: 002b:00007ffe41f36ac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
[   52.273874][ T8345] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f7d75db90d2
[   52.273881][ T8345] RDX: 0000000000000001 RSI: 0000000000001000 RDI: 0000000000000000
[   52.273887][ T8345] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
[   52.273892][ T8345] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000003
[   52.273898][ T8345] R13: 0000000000000004 R14: 0000559ef11e17bb R15: 0000000000000000
[   52.273908][ T8345]  </TASK>
[   52.273912][ T8345]
[   52.304291][ T8345] Freed by task 8345 on cpu 0 at 52.064366s:
[   52.304903][ T8345]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   52.305383][ T8345]  kasan_save_free_info (mm/kasan/generic.c:584)
[   52.305893][ T8345]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   52.306381][ T8345]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[   52.306779][ T8345]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
[   52.307297][ T8345]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
[   52.307907][ T8345]  unbind_store (drivers/base/bus.c:244)
[   52.308372][ T8345]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
[   52.308908][ T8345]  vfs_write (fs/read_write.c:595 fs/read_write.c:688)
[   52.309346][ T8345]  ksys_write (fs/read_write.c:740)
[   52.309785][ T8345]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   52.310257][ T8345]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   52.310850][ T8345]
[   52.311090][ T8345] The buggy address belongs to the object at ffff8881023d9000
[   52.311090][ T8345]  which belongs to the cache kmalloc-192 of size 192
[   52.312495][ T8345] The buggy address is located 72 bytes inside of
[   52.312495][ T8345]  freed 192-byte region [ffff8881023d9000, ffff8881023d90c0)
[   52.313851][ T8345]


Best,
Shuangpeng
