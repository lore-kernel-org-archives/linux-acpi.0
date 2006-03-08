From: akpm@osdl.org
Subject: [patch 01/22] git-acpi: uniprocessor compile fixes
Date: Tue, 07 Mar 2006 23:49:29 -0800
Message-ID: <200603080751.k287pIAb000948@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:39329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751772AbWCHHvU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 02:51:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, venkatesh.pallipadi@intel.com


From: Andrew Morton <akpm@osdl.org>

cpu_online_map doesn't exist if !CONFIG_SMP.

This path is rather lame and it'd be nice to fix it better.

Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |    2 ++
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    2 ++
 2 files changed, 4 insertions(+)

diff -puN arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi-up-fix arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- devel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi-up-fix	2006-03-07 23:44:46.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-07 23:44:46.000000000 -0800
@@ -225,8 +225,10 @@ acpi_cpufreq_target (
 	freqs.old = data->freq_table[cur_state].frequency;
 	freqs.new = data->freq_table[next_state].frequency;
 
+#ifdef CONFIG_SMP
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#endif
 
 	for_each_cpu_mask(j, online_policy_cpus) {
 		freqs.cpu = j;
diff -puN arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- devel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix	2006-03-07 23:44:50.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-07 23:44:50.000000000 -0800
@@ -654,8 +654,10 @@ static int centrino_target (struct cpufr
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_SMP
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#endif
 
 	saved_mask = current->cpus_allowed;
 	first_cpu = 1;
_
