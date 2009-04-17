From: Thomas Renninger <trenn@suse.de>
Subject: acpi-cpufreq: Move average performance code and make it available to userspace and several cleanups in this area
Date: Fri, 17 Apr 2009 16:22:04 +0200
Message-ID: <1239978132-6261-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49967 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759084AbZDQOWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 10:22:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, venkatesh.pallipadi@intel.com

This patch series fixes following bugs:
     - if(!work_on_cpu..) must be if(work_on_cpu..), therefore always zero
       was returned for the average performance
     - use smp_call_function_single instead of work_on_cpu as suggested by
       Andrew Morton (will conflict slightly with his latest patch).
     - brackets forgotten when dividing
     - Handle overflow of MSR registers gracefully

Cleanups:
     - Make use of printk_once interface in acpi-cpufreq.c
     - Get rid of internal acpi-cpufreq max_freq per_cpu variable and use
       the already available policy->cpuinfo.max_freq instead
     - Do not read out cpuid again, but use the already available
       X86_FEATURE_IDA to detect whether MPERF/APERF registers can be used

New functionality:
     - Split up average performance code for re-use
     - Make cpufreq_stats show average performance in:
       /sys/devices/system/cpu/cpu*/cpufreq/stats/average_freq

This code patches against Len's latest acpi test tree.
The first patch is the Null pointer fix from Venkatesh posted on acpi-cpufreq
recently, subject:
[PATCH] x86, acpi_cpufreq: Fix the NULL pointer dereference in get_measured_perf

The patch from Andrew Morton which converts work_on_cpu to
smp_call_function_single at several places will not patch anymore. He sent
the patch on the acpi list recently, subject:
[patch for 2.6.30 1/2] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid using work_on_cpu()
It would be nice when my patches can go in first and Andrew's gets adjusted
(I can do that then). It's easier this way round.

The algorithm to calculate the average frequency from the MSRs has not been
touched.
It would be great if this could still find it's way into 2.6.30.
If not, the fixes should probably be picked up.

Thanks,

     Thomas



