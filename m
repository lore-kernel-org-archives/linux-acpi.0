From: Diego Calleja <diegocg@gmail.com>
Subject: [PATCH] Memory leak in acpi_processor_register_performance?
Date: Sat, 3 Sep 2011 17:02:55 +0200
Message-ID: <201109031702.55470.diegocg@gmail.com>
Reply-To: diegocg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34078 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab1ICPDE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2011 11:03:04 -0400
Received: by wwe5 with SMTP id 5so2846429wwe.1
        for <linux-acpi@vger.kernel.org>; Sat, 03 Sep 2011 08:03:03 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

unreferenced object 0xffff880333240a90 (size 1024):
  comm "pm-suspend", pid 6658, jiffies 4299053388 (age 26684.732s)
  hex dump (first 32 bytes):
    49 0d 00 00 00 00 00 00 18 73 01 00 00 00 00 00  I........s......
    0a 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8168757c>] kmemleak_alloc+0x5c/0xc0
    [<ffffffff8114b703>] __kmalloc+0x213/0x2f0
    [<ffffffffa00681bd>] acpi_processor_register_performance+0x2ec/0x4f1 [processor]
    [<ffffffffa013d578>] acpi_cpufreq_cpu_init+0xd8/0x6b0 [acpi_cpufreq]
    [<ffffffff81537e9e>] cpufreq_add_dev+0x2be/0x6e0
    [<ffffffff816985ae>] cpufreq_cpu_callback+0x68/0x75
    [<ffffffff816aa254>] notifier_call_chain+0x94/0xe0
    [<ffffffff8107c6fe>] __raw_notifier_call_chain+0xe/0x10
    [<ffffffff81051460>] __cpu_notify+0x20/0x40
    [<ffffffff816963f1>] _cpu_up+0xc0/0x103
    [<ffffffff8168697c>] enable_nonboot_cpus+0x9c/0xd0
    [<ffffffff8109f2c1>] suspend_devices_and_enter+0x291/0x480
    [<ffffffff8109f5d1>] enter_state+0x121/0x150
    [<ffffffff8109e7b7>] state_store+0xb7/0xf0
    [<ffffffff812fb7df>] kobj_attr_store+0xf/0x30
    [<ffffffff811c9ed7>] sysfs_write_file+0xe7/0x170


Maybe this fixes it?


Signed-off-by: Diego Calleja <diegocg@gmail.com>
---
 drivers/acpi/processor_perflib.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/drivers/acpi/processor_perflib.c
===================================================================
--- linux.orig/drivers/acpi/processor_perflib.c
+++ linux/drivers/acpi/processor_perflib.c
@@ -380,6 +380,7 @@ static int acpi_processor_get_performanc
 		}
 	}
 
+	kfree(pr->performance->states);
       end:
 	kfree(buffer.pointer);
 
