From: Jeff Mahoney <jeffm@suse.com>
Subject: [patch 1/2] init: move populate_rootfs back to start_kernel
Date: Fri, 09 Oct 2009 15:55:09 -0400
Message-ID: <20091009195907.432843620@suse.com>
References: <20091009195508.694274257@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52739 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757938AbZJIUBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2009 16:01:32 -0400
Content-Disposition: inline; filename=patches.suse/populate_rootfs-in-start_kernel
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?UTF-8?q?=C3=89ric=20Piel?= <Eric.Piel@tremplin-utc.net>, Jan Beulich <JBeulich@novell.com>, Thomas Renninger <trenn@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@hera.kernel.org>

 Mainline commit 8d610dd5 introduced the rootfs_initcall and moved
 populate_rootfs out of start_kernel. This was because of issues
 with userspace helpers being executed way too early. Things like
 pipes weren't initialized yet and users were seeing Oopses or
 unpredictable behavior in certain circumstances.

 The fix worked by causing the execve to fail because it couldn't lookup
 the helper in the file system since the file system wasn't populate yet.
 It turns out that's a really late place to fail since the entire
 usermodehelper infrastructure depends on a work queue that is already
 checked to see if it has been initialized. We can fail earlier without
 having to fork threads that will ultimately fail.

 This patch moves populate_rootfs back to start_kernel and avoids the
 race against a very early userspace by moving the initialization of
 khelper_wq to rootfs_initcall.

 This may seem like a small win, but it is essential for my next patch
 which adds the ability to override ACPI tables at boot-time.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 include/linux/init.h |    1 +
 init/initramfs.c     |    3 +--
 init/main.c          |   10 +++++++++-
 kernel/kmod.c        |    1 +
 4 files changed, 12 insertions(+), 3 deletions(-)

--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -146,6 +146,7 @@ extern unsigned int reset_devices;
 /* used by init/main.c */
 void setup_arch(char **);
 void prepare_namespace(void);
+int populate_rootfs(void);
 
 extern void (*late_time_init)(void);
 
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -565,7 +565,7 @@ static void __init clean_rootfs(void)
 }
 #endif
 
-static int __init populate_rootfs(void)
+int __init populate_rootfs(void)
 {
 	char *err = unpack_to_rootfs(__initramfs_start,
 			 __initramfs_end - __initramfs_start);
@@ -605,4 +605,3 @@ static int __init populate_rootfs(void)
 	}
 	return 0;
 }
-rootfs_initcall(populate_rootfs);
--- a/init/main.c
+++ b/init/main.c
@@ -747,6 +747,15 @@ asmlinkage void __init start_kernel(void
 
 	check_bugs();
 
+	/*
+	 * Do this before starting ACPI so we can read-in
+	 * override tables before the tables are actually
+	 * loaded. The usermode helper won't be initialized
+	 * until much later so we don't race against things
+	 * calling out to userspace.
+	 */
+	populate_rootfs();
+
 	acpi_early_init(); /* before LAPIC and SMP init */
 
 	ftrace_init();
@@ -844,7 +853,6 @@ static void __init do_basic_setup(void)
 	rcu_init_sched(); /* needed by module_init stage. */
 	init_workqueues();
 	cpuset_init_smp();
-	usermodehelper_init();
 	init_tmpfs();
 	driver_init();
 	init_irq_proc();
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -527,3 +527,4 @@ void __init usermodehelper_init(void)
 	khelper_wq = create_singlethread_workqueue("khelper");
 	BUG_ON(!khelper_wq);
 }
+rootfs_initcall(usermodehelper_init);


