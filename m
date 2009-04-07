From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/17] ACPI x86: Make aperf/mperf MSR access in acpi_cpufreq
 read_only
Date: Tue, 07 Apr 2009 19:04:24 -0400
Message-ID: <18b2646fe3babeb40b34a0c1751e0bf5adfdc64c.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:25848 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbZDGXFH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:05:07 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR00M6W6SHPX77@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:05:06 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Do not write zeroes to APERF and MPERF by ondemand governor. With this
change, other users can share these MSRs for reads.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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

