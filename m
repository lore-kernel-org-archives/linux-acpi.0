From: venkip@linux-os.sc.intel.com
Subject: [patch 1/2] x86, acpi_cpufreq: cleanup structure names related to aperf mperf
Date: Thu, 19 Feb 2009 16:53:53 -0800
Message-ID: <20090220005517.671823000@linux-os.sc.intel.com>
References: <20090220005352.674253000@linux-os.sc.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21653 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026AbZBTA50 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Feb 2009 19:57:26 -0500
Content-Disposition: inline; filename=rename_aperf_mperf.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Change structure name to make the code look simpler. No functionality
change in this patch.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---

 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   44 ++++++++++++++---------------
 1 file changed, 22 insertions(+), 22 deletions(-)

Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2009-02-04 16:03:20.000000000 -0800
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2009-02-04 16:05:42.000000000 -0800
@@ -238,24 +238,24 @@ static u32 get_cur_val(const struct cpum
 	return cmd.val;
 }
 
-struct perf_cur {
+struct perf_pair {
 	union {
 		struct {
 			u32 lo;
 			u32 hi;
 		} split;
 		u64 whole;
-	} aperf_cur, mperf_cur;
+	} aperf, mperf;
 };
 
 
 /* Called via smp_call_function_single(), on the target CPU */
 static void read_measured_perf_ctrs(void *_cur)
 {
-	struct perf_cur *cur = _cur;
+	struct perf_pair *cur = _cur;
 
-	rdmsr(MSR_IA32_APERF, cur->aperf_cur.split.lo, cur->aperf_cur.split.hi);
-	rdmsr(MSR_IA32_MPERF, cur->mperf_cur.split.lo, cur->mperf_cur.split.hi);
+	rdmsr(MSR_IA32_APERF, cur->aperf.split.lo, cur->aperf.split.hi);
+	rdmsr(MSR_IA32_MPERF, cur->mperf.split.lo, cur->mperf.split.hi);
 
 	wrmsr(MSR_IA32_APERF, 0, 0);
 	wrmsr(MSR_IA32_MPERF, 0, 0);
@@ -277,7 +277,7 @@ static void read_measured_perf_ctrs(void
 static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 				      unsigned int cpu)
 {
-	struct perf_cur cur;
+	struct perf_pair cur;
 	unsigned int perf_percent;
 	unsigned int retval;
 
@@ -290,39 +290,39 @@ static unsigned int get_measured_perf(st
 	 * Get an approximate value. Return failure in case we cannot get
 	 * an approximate value.
 	 */
-	if (unlikely(cur.aperf_cur.split.hi || cur.mperf_cur.split.hi)) {
+	if (unlikely(cur.aperf.split.hi || cur.mperf.split.hi)) {
 		int shift_count;
 		u32 h;
 
-		h = max_t(u32, cur.aperf_cur.split.hi, cur.mperf_cur.split.hi);
+		h = max_t(u32, cur.aperf.split.hi, cur.mperf.split.hi);
 		shift_count = fls(h);
 
-		cur.aperf_cur.whole >>= shift_count;
-		cur.mperf_cur.whole >>= shift_count;
+		cur.aperf.whole >>= shift_count;
+		cur.mperf.whole >>= shift_count;
 	}
 
-	if (((unsigned long)(-1) / 100) < cur.aperf_cur.split.lo) {
+	if (((unsigned long)(-1) / 100) < cur.aperf.split.lo) {
 		int shift_count = 7;
-		cur.aperf_cur.split.lo >>= shift_count;
-		cur.mperf_cur.split.lo >>= shift_count;
+		cur.aperf.split.lo >>= shift_count;
+		cur.mperf.split.lo >>= shift_count;
 	}
 
-	if (cur.aperf_cur.split.lo && cur.mperf_cur.split.lo)
-		perf_percent = (cur.aperf_cur.split.lo * 100) /
-				cur.mperf_cur.split.lo;
+	if (cur.aperf.split.lo && cur.mperf.split.lo)
+		perf_percent = (cur.aperf.split.lo * 100) /
+				cur.mperf.split.lo;
 	else
 		perf_percent = 0;
 
 #else
-	if (unlikely(((unsigned long)(-1) / 100) < cur.aperf_cur.whole)) {
+	if (unlikely(((unsigned long)(-1) / 100) < cur.aperf.whole)) {
 		int shift_count = 7;
-		cur.aperf_cur.whole >>= shift_count;
-		cur.mperf_cur.whole >>= shift_count;
+		cur.aperf.whole >>= shift_count;
+		cur.mperf.whole >>= shift_count;
 	}
 
-	if (cur.aperf_cur.whole && cur.mperf_cur.whole)
-		perf_percent = (cur.aperf_cur.whole * 100) /
-				cur.mperf_cur.whole;
+	if (cur.aperf.whole && cur.mperf.whole)
+		perf_percent = (cur.aperf.whole * 100) /
+				cur.mperf.whole;
 	else
 		perf_percent = 0;
 

-- 

