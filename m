From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 01/26] git-acpi: uniprocessor compile fixes
Date: Sat, 1 Apr 2006 21:12:46 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DD1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16251 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932375AbWDBCMu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Apr 2006 21:12:50 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

applied.
thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:03 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; Pallipadi, Venkatesh
>Subject: [patch 01/26] git-acpi: uniprocessor compile fixes
>
>
>From: Andrew Morton <akpm@osdl.org>,
>      Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>
>cpu_online_map doesn't exist if !CONFIG_SMP.
>
>This path is rather lame and it'd be nice to fix it better.
>
>Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>Cc: Len Brown <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |    4 ++++
> arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    4 ++++
> 2 files changed, 8 insertions(+)
>
>diff -puN 
>arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi-up-fix 
>arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
>--- 
>devel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c~git-acpi
>-up-fix	2006-03-28 14:02:59.000000000 -0800
>+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	
>2006-03-28 14:02:59.000000000 -0800
>@@ -225,8 +225,12 @@ acpi_cpufreq_target (
> 	freqs.old = data->freq_table[cur_state].frequency;
> 	freqs.new = data->freq_table[next_state].frequency;
> 
>+#ifdef CONFIG_HOTPLUG_CPU
> 	/* cpufreq holds the hotplug lock, so we are safe from 
>here on */
> 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
>+#else
>+	online_policy_cpus = policy->cpus;
>+#endif
> 
> 	for_each_cpu_mask(j, online_policy_cpus) {
> 		freqs.cpu = j;
>diff -puN 
>arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-f
>ix arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
>--- 
>devel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acp
>i-up-fix	2006-03-28 14:02:59.000000000 -0800
>+++ 
>devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	
>2006-03-28 14:02:59.000000000 -0800
>@@ -652,8 +652,12 @@ static int centrino_target (struct cpufr
> 		return -EINVAL;
> 	}
> 
>+#ifdef CONFIG_HOTPLUG_CPU
> 	/* cpufreq holds the hotplug lock, so we are safe from 
>here on */
> 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
>+#else
>+	online_policy_cpus = policy->cpus;
>+#endif
> 
> 	saved_mask = current->cpus_allowed;
> 	first_cpu = 1;
>_
>
