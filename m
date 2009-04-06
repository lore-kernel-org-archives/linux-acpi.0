From: venkatesh.pallipadi@intel.com
Subject: [patch 1/2] acpi x86: Cleanup acpi_cpufreq structures related to aperf/mperf
Date: Mon, 06 Apr 2009 11:26:07 -0700
Message-ID: <20090406182723.927683000@intel.com>
References: <20090406182606.706570000@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16132 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715AbZDFS2J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Apr 2009 14:28:09 -0400
Content-Disposition: inline; filename=0001-acpi-x86-Cleanup-acpi_cpufreq-structures-related-to.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Change structure name to make the code cleaner and simpler. No
functionality change in this patch.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   42 +++++++++++++--------------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 19f6b9d..340bdbe 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -241,23 +241,23 @@ static u32 get_cur_val(const struct cpumask *mask)
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
 
 
 static long read_measured_perf_ctrs(void *_cur)
 {
-	struct perf_cur *cur = _cur;
+	struct perf_pair *cur = _cur;
 
-	rdmsr(MSR_IA32_APERF, cur->aperf_cur.split.lo, cur->aperf_cur.split.hi);
-	rdmsr(MSR_IA32_MPERF, cur->mperf_cur.split.lo, cur->mperf_cur.split.hi);
+	rdmsr(MSR_IA32_APERF, cur->aperf.split.lo, cur->aperf.split.hi);
+	rdmsr(MSR_IA32_MPERF, cur->mperf.split.lo, cur->mperf.split.hi);
 
 	wrmsr(MSR_IA32_APERF, 0, 0);
 	wrmsr(MSR_IA32_MPERF, 0, 0);
@@ -281,7 +281,7 @@ static long read_measured_perf_ctrs(void *_cur)
 static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 				      unsigned int cpu)
 {
-	struct perf_cur cur;
+	struct perf_pair cur;
 	unsigned int perf_percent;
 	unsigned int retval;
 
@@ -294,39 +294,37 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
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
+		perf_percent = (cur.aperf.split.lo * 100) / cur.mperf.split.lo;
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
+		perf_percent = (cur.aperf.whole * 100) / cur.mperf.whole;
 	else
 		perf_percent = 0;
 
-- 
1.6.0.6

-- 

