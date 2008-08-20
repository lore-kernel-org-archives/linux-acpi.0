From: Li Zefan <lizf@cn.fujitsu.com>
Subject: [-mm] sysfs: duplicate filename 'acpi' can not be created
Date: Wed, 20 Aug 2008 13:34:42 +0800
Message-ID: <48ABACF2.4060503@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:58863 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbYHTFgH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2008 01:36:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

When I compiled latest -mm and booted up:

------------[ cut here ]------------
WARNING: at fs/sysfs/dir.c:463 sysfs_add_one+0x27/0x2f()
sysfs: duplicate filename 'acpi' can not be created
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27-rc3-mm1 #2
 [<c0421173>] warn_slowpath+0x61/0x83
 [<c043b422>] __lock_acquire+0x601/0x658
 [<c047ea0d>] ifind+0x13/0x79
 [<c05c2ce9>] _spin_unlock+0x14/0x1c
 [<c047ea6d>] ifind+0x73/0x79
 [<c04a5a32>] sysfs_find_dirent+0x13/0x23
 [<c04a5ac5>] sysfs_add_one+0x27/0x2f
 [<c04a5f83>] create_dir+0x3c/0x81
 [<c04a5ff1>] sysfs_create_dir+0x29/0x3b
 [<c05c2ce9>] _spin_unlock+0x14/0x1c
 [<c04c466d>] kobject_add_internal+0xb1/0x14a
 [<c04c490b>] kobject_init_and_add+0x29/0x2c
 [<c06ea613>] kernel_param_sysfs_setup+0x4f/0x9f
 [<c06ea753>] param_sysfs_init+0xf0/0x147
 [<c0401122>] _stext+0x3a/0x12f
 [<c06ea663>] param_sysfs_init+0x0/0x147
 [<c041b3ee>] try_to_wake_up+0x146/0x14f
 [<c042d9f5>] __create_workqueue_key+0xa0/0x13c
 [<c06d9550>] kernel_init+0x18d/0x1f1
 [<c06d93c3>] kernel_init+0x0/0x1f1
 [<c04044ff>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
kobject_add_internal failed for acpi with -EEXIST, don't try to register things with the same name in the same directory.
Pid: 1, comm: swapper Tainted: G        W 2.6.27-rc3-mm1 #2
 [<c04c46d0>] kobject_add_internal+0x114/0x14a
 [<c04c490b>] kobject_init_and_add+0x29/0x2c
 [<c06ea613>] kernel_param_sysfs_setup+0x4f/0x9f
 [<c06ea753>] param_sysfs_init+0xf0/0x147
 [<c0401122>] _stext+0x3a/0x12f
 [<c06ea663>] param_sysfs_init+0x0/0x147
 [<c041b3ee>] try_to_wake_up+0x146/0x14f
 [<c042d9f5>] __create_workqueue_key+0xa0/0x13c
 [<c06d9550>] kernel_init+0x18d/0x1f1
 [<c06d93c3>] kernel_init+0x0/0x1f1
 [<c04044ff>] kernel_thread_helper+0x7/0x10
 =======================
Module 'acpi' failed to be added to sysfs, error number -17
The system will be unstable now.
