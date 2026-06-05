Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4B3BBFD7
	for <linux-acpi@vger.kernel.org>; Fri,  5 Jun 2026 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619990; cv=none; b=j0UqTtZPX7qsZj3ohREJcJyFJJTIwMBSLl7gtXZcz41DTU6MHHcd52YOzZMpBqr+6NqC5/HDXTb++S1QMwMBUPt1jLbnz2wgZaskLpYmuB5UruRvUOsJxMSCSVBLmyevpkMTtdMDtPXBxErPmDJjZBg/X5p8ZrufA/2Uk38MNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619990; c=relaxed/simple;
	bh=MYwOSZyri+TrN7baUNMgUQBHh2K+b9G/fOb5/l1a4K8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=EmETxb5ULE3jiYcJIfpQdvQ+UWWScpatcWGGXP2AnkZHTByhpneAYy2rTldYz6h+7BKezT4kEFUg/O5bBoK29wC3Pb95LtuXiSHLONBPX/cJerEXSdwbrIQCSUsXO4LJ8jY1NSmTnPDAjOX2w+gp7NDCL7iND9p6M8AXbRn2bzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFgL33R0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFgL33R0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9158fbaa4bbso171440485a.1
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2026 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780619987; x=1781224787; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+NZdL5TxhNo5C7YEkTCJwLRgB4aMOQzN3CL7Aq/+ls=;
        b=gFgL33R0b90NQF4XVaTW54VIKfEN+aN5YCGlrhJse5/VCBpQ8K8tjYBWYftN6uJ2Gt
         vmgfzwgSLSS/oqtU1OMRkHymD8f7R9eJdiSanQa8lAXsivlVisOF78HjMtgvg69YOqkz
         40S4ly+UsFBYpHA1WJdjLcN76U4/o7hs3wPUJjny56HwXlMB+Lt1p4p0zJftX1GYwY4G
         BiGk1kkGVC0aKntgdAJVYDFeegmzfoEX8Z4I5AlFqkqIeYZ57N9P4ggDlJdTaeouDZZn
         WuQ/8JABNSVJJYLJQfpL+lysssL/ZJWextEyYJCTlFAy3IFq1eWAdMMH7Lb3GaU5Yn1a
         gpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780619987; x=1781224787;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+NZdL5TxhNo5C7YEkTCJwLRgB4aMOQzN3CL7Aq/+ls=;
        b=Fu1Ywp7GjzSvgytomhk6mxQo0R09eMBouKbrD5LG+99+1IhvVATtLw/j69osbc2c6E
         Fo13Wd0OvEOt64IpJIneCzHJC/NJQFcR0rIaV49+S9jnLou6gOKevana/54AZB36YC8j
         DWxFijKyWH1bwQbAW3jH7ct37EHHaoB8Z2CxdxPVHpgxmye0l5jmQd3ASCCBhusoja9W
         PFa4FwG5S+7O0l39SNv2XCiQRTNN6mS+mm3aC6ErEs97xtCO/Nl7aMtOsRgD94eTVqgK
         7rRHVeDkFnp8D3GyQkUhu5ucaOOJGAQeGpToheCiAlK8l2tacj5h1qoJUXQ2rQ70ROoj
         OOMQ==
X-Gm-Message-State: AOJu0YxwjNTSrKH7lGtV4kMs55ErYgH7f23g2+pOH3GJx2phNOtYy/Xx
	uT2TBWOyXepb8cmiwqdmjX/9CXh35+GKHwCXYfcBrzx38qYzgcwzSj7/iBrng+dS
X-Gm-Gg: Acq92OHvszHn98DOe4KeD3tbrIaW0oEzVy+CAlqmBzg7NTlvup01ywzpiPkKhTwOn+a
	u+6qFoiC7qCNcMvLK3+bToD6/i5bbxYgpUAo6+EzCHc8vQ6ujAqW3Wpv97ukWLpIcriZb8PW3Hn
	YLjFXKDaj+J4a0HkvZnRumfesd3pThAPBBfcJU6l9GGRbBI3BvzIgAwQV0fHWkPDb4awdSNDfwf
	iulIZhG0jndkHFQkFQ7NjK05xAFqRJb0NHLEy6qb9o+W+F/1FBWfY5ZonxUjZG7NdmkbTOlVFjl
	rPgsz5Uoq48eGN3+sY0XlCIq0Ce0OVzbLKwytmqPOQBwm+mECOFBL6OiU5L/EmUbFh+Kvzoj/1K
	UxAL8H8XD0Hq2JwswaPKrXKwaSgz8zwWQjug4u/49xdfZlNCjV6Iysg6Pgu/McfRlDithh8i/+e
	A9FGERYqHrK+ygYgaO9aq3t5Tl1V26/b5l9x6igTmWH92Q5L8MqvbPxDaV0036REa7wqqzNbAb3
	WaDZjIecguP
X-Received: by 2002:a05:620a:1b8d:b0:914:c0ab:f1ee with SMTP id af79cd13be357-915a9d93f2fmr274123285a.44.1780619986920;
        Thu, 04 Jun 2026 17:39:46 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:863:92d1:80bd:c89d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381560sm747519285a.28.2026.06.04.17.39.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2026 17:39:46 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] ACPI: property: KASAN invalid-free when unloading configfs SSDT
 with hierarchical _DSD subnodes
Message-Id: <E616AB8C-FA36-4F6F-8D2D-B8EC60B4F159@gmail.com>
Date: Thu, 4 Jun 2026 20:39:15 -0400
Cc: linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: rafael@kernel.org,
 lenb@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Kernel Maintainers,

I hit the following KASAN report while testing current upstream kernel:

KASAN: invalid-free in acpi_destroy_nondev_subnodes

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/4e397435a9482205119b0044cfd0ce80

I=E2=80=99m happy to test debug patches or provide additional =
information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   98.822019][  T806] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   98.847029][  T806] BUG: KASAN: invalid-free in =
acpi_destroy_nondev_subnodes (./include/acpi/platform/aclinuxex.h:64 =
drivers/acpi/property.c:667)
[   98.847737][  T806] Free of addr ffff88810dbc0130 by task =
kworker/u8:1/806
[   98.848339][  T806]
[   98.848556][  T806] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   98.848564][  T806] Workqueue: kacpi_hotplug acpi_device_del_work_fn
[   98.848569][  T806] Call Trace:
[   98.848571][  T806]  <TASK>
[   98.848574][  T806]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[   98.848577][  T806]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[   98.848592][  T806]  kasan_report_invalid_free =
(mm/kasan/report.c:557)
[   98.848603][  T806]  check_slab_allocation (mm/kasan/common.c:?)
[   98.848607][  T806]  kfree (./include/linux/kasan.h:199 =
mm/slub.c:2634 mm/slub.c:6251 mm/slub.c:6566)
[   98.848614][  T806]  acpi_destroy_nondev_subnodes =
(./include/acpi/platform/aclinuxex.h:64 drivers/acpi/property.c:667)
[   98.848620][  T806]  acpi_free_properties =
(drivers/acpi/property.c:676)
[   98.848633][  T806]  acpi_device_release (drivers/acpi/scan.c:521)
[   98.848637][  T806]  device_release (drivers/base/core.c:2562)
[   98.848640][  T806]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 =
./include/linux/kref.h:65 lib/kobject.c:737)
[   98.848644][  T806]  acpi_device_del_work_fn =
(./include/acpi/acpi_bus.h:980 drivers/acpi/scan.c:589)
[   98.848647][  T806]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[   98.848654][  T806]  worker_thread (kernel/workqueue.c:3478)
[   98.848661][  T806]  kthread (kernel/kthread.c:436)
[   98.848670][  T806]  ret_from_fork (arch/x86/kernel/process.c:158)
[   98.848682][  T806]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[   98.848687][  T806]  </TASK>
[   98.848688][  T806]
[   98.865113][  T806] Allocated by task 10 on cpu 0 at 95.708432s:
[   98.865648][  T806]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[   98.866058][  T806]  __kasan_kmalloc (mm/kasan/common.c:398 =
mm/kasan/common.c:415)
[   98.866459][  T806]  __kmalloc_noprof (./include/linux/kasan.h:263 =
mm/slub.c:5296 mm/slub.c:5308)
[   98.866875][  T806]  acpi_ut_initialize_buffer =
(drivers/acpi/acpica/utalloc.c:?)
[   98.867351][  T806]  acpi_evaluate_object =
(drivers/acpi/acpica/nsxfeval.c:400)
[   98.867792][  T806]  acpi_evaluate_object_typed =
(drivers/acpi/acpica/nsxfeval.c:84)
[   98.868283][  T806]  acpi_init_properties =
(drivers/acpi/property.c:609)
[   98.868728][  T806]  acpi_init_device_object =
(drivers/acpi/scan.c:1820)
[   98.869208][  T806]  acpi_add_single_object =
(drivers/acpi/scan.c:1870)
[   98.869675][  T806]  acpi_bus_check_add (drivers/acpi/scan.c:2171)
[   98.870113][  T806]  acpi_ns_walk_namespace =
(drivers/acpi/acpica/nswalk.c:?)
[   98.870576][  T806]  acpi_walk_namespace =
(drivers/acpi/acpica/nsxfeval.c:606)
[   98.871000][  T806]  acpi_bus_scan (drivers/acpi/scan.c:2728)
[   98.871393][  T806]  acpi_table_events_fn (drivers/acpi/scan.c:2933)
[   98.871824][  T806]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[   98.872294][  T806]  worker_thread (kernel/workqueue.c:3478)
[   98.872689][  T806]  kthread (kernel/kthread.c:436)
[   98.873042][  T806]  ret_from_fork (arch/x86/kernel/process.c:158)
[   98.873441][  T806]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[   98.873848][  T806]
[   98.874057][  T806] The buggy address belongs to the object at =
ffff88810dbc0000
[   98.874057][  T806]  which belongs to the cache kmalloc-1k of size =
1024
[   98.875239][  T806] The buggy address is located 304 bytes inside of
[   98.875239][  T806]  888-byte region [ffff88810dbc0000, =
ffff88810dbc0378)


Best,
Shuangpeng

