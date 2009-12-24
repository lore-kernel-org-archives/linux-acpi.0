From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/34] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid
 cross-CPU interrupts by using smp_call_function_any()
Date: Thu, 24 Dec 2009 01:23:49 -0500
Message-ID: <4a28395d72a956f2dad24e343d06bc08c9afb89a.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbZLXTbg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:36 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:16 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>, Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Len Brown <len.brown@intel.com>, Mike Galbraith <efault@gmx.de>, Rusty Russell <rusty@rustcorp.com.au>, Thomas Gleixner <tglx@linutronix.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

From: Andrew Morton <akpm@linux-foundation.org>

Presently acpi-cpufreq will perform the MSR read on the first CPU in the
mask.  That's inefficient if that CPU differs from the current CPU.
Because we have to perform a cross-CPU call, but we could have run the
rdmsr on the current CPU.

So switch to using the new smp_call_function_any(), which will perform the
call on the current CPU if that CPU is present in the mask (it is).

Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Dave Jones <davej@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index f28decf..1b1920f 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -190,9 +190,11 @@ static void do_drv_write(void *_cmd)
 
 static void drv_read(struct drv_cmd *cmd)
 {
+	int err;
 	cmd->val = 0;
 
-	smp_call_function_single(cpumask_any(cmd->mask), do_drv_read, cmd, 1);
+	err = smp_call_function_any(cmd->mask, do_drv_read, cmd, 1);
+	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
 }
 
 static void drv_write(struct drv_cmd *cmd)
-- 
1.6.0.6

