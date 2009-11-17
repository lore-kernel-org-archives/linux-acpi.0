From: akpm@linux-foundation.org
Subject: [patch 02/12] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid cross-CPU interrupts by using smp_call_function_any()
Date: Tue, 17 Nov 2009 14:27:28 -0800
Message-ID: <200911172227.nAHMRTjA023119@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54552 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756377AbZKQW26 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:28:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, davej@redhat.com, efault@gmx.de, jaswinder@kernel.org, len.brown@intel.com, mingo@elte.hu, rusty@rustcorp.com.au, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com

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
---

 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts-by-using-smp_call_function_any arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts-by-using-smp_call_function_any
+++ a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
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
_
