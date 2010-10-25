From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/60] acpi-cpufreq: fix a memleak when unloading driver
Date: Mon, 25 Oct 2010 02:20:28 -0400
Message-ID: <dab5fff14df2cd16eb1ad4c02e83915e1063fece.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0JYHLK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:10 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:07 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

We didn't free per_cpu(acfreq_data, cpu)->freq_table
when acpi_freq driver is unloaded.

Resulting in the following messages in /sys/kernel/debug/kmemleak:

unreferenced object 0xf6450e80 (size 64):
  comm "modprobe", pid 1066, jiffies 4294677317 (age 19290.453s)
  hex dump (first 32 bytes):
    00 00 00 00 e8 a2 24 00 01 00 00 00 00 9f 24 00  ......$.......$.
    02 00 00 00 00 6a 18 00 03 00 00 00 00 35 0c 00  .....j.......5..
  backtrace:
    [<c123ba97>] kmemleak_alloc+0x27/0x50
    [<c109f96f>] __kmalloc+0xcf/0x110
    [<f9da97ee>] acpi_cpufreq_cpu_init+0x1ee/0x4e4 [acpi_cpufreq]
    [<c11cd8d2>] cpufreq_add_dev+0x142/0x3a0
    [<c11920b7>] sysdev_driver_register+0x97/0x110
    [<c11cce56>] cpufreq_register_driver+0x86/0x140
    [<f9dad080>] 0xf9dad080
    [<c1001130>] do_one_initcall+0x30/0x160
    [<c10626e9>] sys_init_module+0x99/0x1e0
    [<c1002d97>] sysenter_do_call+0x12/0x26
    [<ffffffff>] 0xffffffff

https://bugzilla.kernel.org/show_bug.cgi?id=15807#c21

Tested-by: Toralf Forster <toralf.foerster@gmx.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index cd8da24..a2baafb 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -701,6 +701,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		per_cpu(acfreq_data, policy->cpu) = NULL;
 		acpi_processor_unregister_performance(data->acpi_data,
 						      policy->cpu);
+		kfree(data->freq_table);
 		kfree(data);
 	}
 
-- 
1.7.3.2.90.gd4c43

