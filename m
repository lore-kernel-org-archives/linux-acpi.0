From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/17] ACPI x86: Cleanup acpi_cpufreq structures related to
 aperf/mperf
Date: Tue, 07 Apr 2009 19:04:23 -0400
Message-ID: <e4f6937222dbb61b8b8e62caca3d32e648b3b14b.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:32642 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbZDGXFQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:05:16 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR003206SGB1NC@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:05:06 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Change structure name to make the code cleaner and simpler. No
functionality change in this patch.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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

