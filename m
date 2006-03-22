From: akpm@osdl.org
Subject: [patch 01/23] git-acpi: uniprocessor compile fixes
Date: Tue, 21 Mar 2006 22:30:26 -0800
Message-ID: <200603220633.k2M6XeDF019526@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:2236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750829AbWCVGdm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 01:33:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, venkatesh.pallipadi@intel.com


From: Andrew Morton <akpm@osdl.org>,
      Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

cpu_online_map doesn't exist if !CONFIG_SMP.

This path is rather lame and it'd be nice to fix it better.

Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |    4 ++++
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    4 ++++
 2 files changed, 8 insertions(+)

diff -puN arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi-up-fix arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- devel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi-up-fix	2006-03-21 22:30:03.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-21 22:30:03.000000000 -0800
@@ -225,8 +225,12 @@ acpi_cpufreq_target (
 	freqs.old = data->freq_table[cur_state].frequency;
 	freqs.new = data->freq_table[next_state].frequency;
 
+#ifdef CONFIG_HOTPLUG_CPU
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#else
+	online_policy_cpus = policy->cpus;
+#endif
 
 	for_each_cpu_mask(j, online_policy_cpus) {
 		freqs.cpu = j;
diff -puN arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- devel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix	2006-03-21 22:30:03.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-21 22:30:03.000000000 -0800
@@ -654,8 +654,12 @@ static int centrino_target (struct cpufr
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#else
+	online_policy_cpus = policy->cpus;
+#endif
 
 	saved_mask = current->cpus_allowed;
 	first_cpu = 1;
_
