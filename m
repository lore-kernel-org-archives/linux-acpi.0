From: akpm@linux-foundation.org
Subject: [patch 1/8] kernel core: add smp_call_function_any()
Date: Fri, 18 Sep 2009 12:41:03 -0700
Message-ID: <200909181941.n8IJf3o7002315@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42231 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751530AbZIRTnF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Sep 2009 15:43:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rusty@rustcorp.com.au, davej@redhat.com, efault@gmx.de, jaswinder@kernel.org, len.brown@intel.com, mingo@elte.hu, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com

From: Rusty Russell <rusty@rustcorp.com.au>

Andrew points out that acpi-cpufreq uses cpumask_any, when it really
would prefer to use the same CPU if possible (to avoid an IPI).  In
general, this seems a good idea to offer.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Cc: Dave Jones <davej@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Galbraith <efault@gmx.de>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/smp.h |    3 +++
 kernel/smp.c        |   40 ++++++++++++++++++++++++++++++++++++++++
 kernel/up.c         |   12 ++++++++++++
 3 files changed, 55 insertions(+)

diff -puN include/linux/smp.h~kernel-core-add-smp_call_function_any include/linux/smp.h
--- a/include/linux/smp.h~kernel-core-add-smp_call_function_any
+++ a/include/linux/smp.h
@@ -27,6 +27,9 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, void (*func) (void *info), void *info,
 				int wait);
 
+int smp_call_function_any(const struct cpumask *mask,
+			  void (*func)(void *info), void *info, int wait);
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
diff -puN kernel/smp.c~kernel-core-add-smp_call_function_any kernel/smp.c
--- a/kernel/smp.c~kernel-core-add-smp_call_function_any
+++ a/kernel/smp.c
@@ -331,6 +331,46 @@ int smp_call_function_single(int cpu, vo
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
+/*
+ * smp_call_function_any - Run a function on any of the given cpus
+ * @mask: The mask of cpus it can run on.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait until function has completed.
+ *
+ * Returns 0 on success, else a negative status code (if no cpus were online).
+ * Note that @wait will be implicitly turned on in case of allocation failures,
+ * since we fall back to on-stack allocation.
+ */
+int smp_call_function_any(const struct cpumask *mask,
+			  void (*func)(void *info), void *info, int wait)
+{
+	unsigned int cpu;
+	const struct cpumask *nodemask;
+	int ret;
+
+	/* Try for same CPU (cheapest) */
+	cpu = get_cpu();
+	if (cpumask_test_cpu(cpu, mask))
+		goto call;
+
+	/* Try for same node. */
+	nodemask = cpumask_of_node(cpu);
+	for (cpu = cpumask_first_and(nodemask, mask); cpu < nr_cpu_ids;
+	     cpu = cpumask_next_and(cpu, nodemask, mask)) {
+		if (cpu_online(cpu))
+			goto call;
+	}
+
+	/* Any online will do: smp_call_function_single handles nr_cpu_ids. */
+	cpu = cpumask_any_and(mask, cpu_online_mask);
+call:
+	ret = smp_call_function_single(cpu, func, info, wait);
+	put_cpu();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(smp_call_function_any);
+
 /**
  * __smp_call_function_single(): Run a function on another CPU
  * @cpu: The CPU to run on.
diff -puN kernel/up.c~kernel-core-add-smp_call_function_any kernel/up.c
--- a/kernel/up.c~kernel-core-add-smp_call_function_any
+++ a/kernel/up.c
@@ -19,3 +19,15 @@ int smp_call_function_single(int cpu, vo
 	return 0;
 }
 EXPORT_SYMBOL(smp_call_function_single);
+
+int smp_call_function_any(const struct cpumask *mask,
+			  void (*func)(void *info), void *info,
+			  int wait)
+{
+	local_irq_disable();
+	(func)(info);
+	local_irq_enable();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(smp_call_function_any);
_
