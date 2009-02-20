From: venkip@linux-os.sc.intel.com
Subject: [patch 2/2] x86, acpi_cpufreq: do not clear aperf mperf MSR after read
Date: Thu, 19 Feb 2009 16:53:54 -0800
Message-ID: <20090220005517.811901000@linux-os.sc.intel.com>
References: <20090220005352.674253000@linux-os.sc.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29533 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbZBTA5Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Feb 2009 19:57:25 -0500
Content-Disposition: inline; filename=disable_aperf_mperf_writes_2629.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Not write zeroes to APERF and MPERF by ondemand governor. With this other
users can share these MSRs during reads.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---

 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2009-02-04 16:05:42.000000000 -0800
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2009-02-04 16:08:51.000000000 -0800
@@ -66,6 +66,7 @@ struct acpi_cpufreq_data {
 	unsigned int max_freq;
 	unsigned int resume;
 	unsigned int cpu_feature;
+	u64 saved_aperf, saved_mperf;
 };
 
 static DEFINE_PER_CPU(struct acpi_cpufreq_data *, drv_data);
@@ -256,9 +257,6 @@ static void read_measured_perf_ctrs(void
 
 	rdmsr(MSR_IA32_APERF, cur->aperf.split.lo, cur->aperf.split.hi);
 	rdmsr(MSR_IA32_MPERF, cur->mperf.split.lo, cur->mperf.split.hi);
-
-	wrmsr(MSR_IA32_APERF, 0, 0);
-	wrmsr(MSR_IA32_MPERF, 0, 0);
 }
 
 /*
@@ -277,13 +275,20 @@ static void read_measured_perf_ctrs(void
 static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 				      unsigned int cpu)
 {
-	struct perf_pair cur;
+	struct perf_pair readin, cur;
 	unsigned int perf_percent;
 	unsigned int retval;
 
-	if (smp_call_function_single(cpu, read_measured_perf_ctrs, &cur, 1))
+	if (smp_call_function_single(cpu, read_measured_perf_ctrs, &readin, 1))
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

