From: venkatesh.pallipadi@intel.com
Subject: [patch 2/2] acpi x86: Make aperf/mperf MSR access in acpi_cpufreq read_only
Date: Mon, 06 Apr 2009 11:26:08 -0700
Message-ID: <20090406182724.072503000@intel.com>
References: <20090406182606.706570000@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16132 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755110AbZDFS2I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Apr 2009 14:28:08 -0400
Content-Disposition: inline; filename=0002-acpi-x86-Make-aperf-mperf-MSR-access-in-acpi_cpufre.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Not write zeroes to APERF and MPERF by ondemand governor. With this
change, other users can share these MSRs for reads.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 340bdbe..9d3af38 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -68,6 +68,7 @@ struct acpi_cpufreq_data {
 	unsigned int max_freq;
 	unsigned int resume;
 	unsigned int cpu_feature;
+	u64 saved_aperf, saved_mperf;
 };
 
 static DEFINE_PER_CPU(struct acpi_cpufreq_data *, drv_data);
@@ -259,9 +260,6 @@ static long read_measured_perf_ctrs(void *_cur)
 	rdmsr(MSR_IA32_APERF, cur->aperf.split.lo, cur->aperf.split.hi);
 	rdmsr(MSR_IA32_MPERF, cur->mperf.split.lo, cur->mperf.split.hi);
 
-	wrmsr(MSR_IA32_APERF, 0, 0);
-	wrmsr(MSR_IA32_MPERF, 0, 0);
-
 	return 0;
 }
 
@@ -281,13 +279,20 @@ static long read_measured_perf_ctrs(void *_cur)
 static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 				      unsigned int cpu)
 {
-	struct perf_pair cur;
+	struct perf_pair readin, cur;
 	unsigned int perf_percent;
 	unsigned int retval;
 
-	if (!work_on_cpu(cpu, read_measured_perf_ctrs, &cur))
+	if (!work_on_cpu(cpu, read_measured_perf_ctrs, &readin))
 		return 0;
 
+	cur.aperf.whole = readin.aperf.whole -
+				per_cpu(drv_data, cpu)->saved_aperf;
+	cur.mperf.whole = readin.mperf.whole -
+				per_cpu(drv_data, cpu)->saved_mperf;
+	per_cpu(drv_data, cpu)->saved_aperf = readin.aperf.whole;
+	per_cpu(drv_data, cpu)->saved_mperf = readin.mperf.whole;
+
 #ifdef __i386__
 	/*
 	 * We dont want to do 64 bit divide with 32 bit kernel
-- 
1.6.0.6

-- 

