From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 2/2] ACPI / CPPC: add sysfs entries for CPPC perf capabilities
Date: Wed, 14 Dec 2016 18:06:34 -0700
Message-ID: <1481763994-28146-3-git-send-email-pprakash@codeaurora.org>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbcLOBGn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Dec 2016 20:06:43 -0500
In-Reply-To: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, Prashanth Prakash <pprakash@codeaurora.org>

Computed delivered performance using CPPC feedback counters will be
in the CPPC abstract scale, whereas cppc_cpufreq driver operates in
KHz scale. Exposing the CPPC performance capabilities (highest,
lowest, nominal, lowest non-linear) will allow userspace to figure
out the conversion factor from CPPC abstract scale to KHz.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/cppc_acpi.c | 61 ++++++++++++++++++++++++++----------------------
 include/acpi/cppc_acpi.h |  2 +-
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 45f021a..3c6a035 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -138,49 +138,54 @@ struct cppc_attr {
 
 #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
 
+#define show_cppc_data(access_fn, struct_name, member_name)		\
+	static ssize_t show_##member_name(struct kobject *kobj,		\
+					struct attribute *attr,	char *buf) \
+	{								\
+		struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);		\
+		struct struct_name st_name = {0};			\
+		int ret;						\
+									\
+		ret = access_fn(cpc_ptr->cpu_id, &st_name);		\
+		if (ret)						\
+			return ret;					\
+									\
+		return scnprintf(buf, PAGE_SIZE, "%llu\n",		\
+				(u64)st_name.member_name);		\
+	}								\
+	define_one_cppc_ro(member_name)
+
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_non_linear_perf);
+show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
+show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct attribute *attr, char *buf)
 {
 	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	int ret;
 
-	cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
+	ret = cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
+	if (ret)
+		return ret;
 
 	return scnprintf(buf, PAGE_SIZE, "ref:%llu del:%llu\n",
 			fb_ctrs.reference, fb_ctrs.delivered);
 }
 define_one_cppc_ro(feedback_ctrs);
 
-static ssize_t show_reference_perf(struct kobject *kobj,
-		struct attribute *attr, char *buf)
-{
-	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
-	struct cppc_perf_fb_ctrs fb_ctrs = {0};
-
-	cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
-
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			fb_ctrs.reference_perf);
-}
-define_one_cppc_ro(reference_perf);
-
-static ssize_t show_wraparound_time(struct kobject *kobj,
-				struct attribute *attr, char *buf)
-{
-	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
-	struct cppc_perf_fb_ctrs fb_ctrs = {0};
-
-	cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
-
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", fb_ctrs.ctr_wrap_time);
-
-}
-define_one_cppc_ro(wraparound_time);
-
 static struct attribute *cppc_attrs[] = {
 	&feedback_ctrs.attr,
 	&reference_perf.attr,
 	&wraparound_time.attr,
+	&highest_perf.attr,
+	&lowest_perf.attr,
+	&lowest_non_linear_perf.attr,
+	&nominal_perf.attr,
 	NULL
 };
 
@@ -1124,7 +1129,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	perf_fb_ctrs->delivered = delivered;
 	perf_fb_ctrs->reference = reference;
 	perf_fb_ctrs->reference_perf = ref_perf;
-	perf_fb_ctrs->ctr_wrap_time = ctr_wrap_time;
+	perf_fb_ctrs->wraparound_time = ctr_wrap_time;
 out_err:
 	if (regs_in_pcc)
 		up_write(&pcc_data.pcc_lock);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3f64660..08c2c78 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -116,7 +116,7 @@ struct cppc_perf_fb_ctrs {
 	u64 reference;
 	u64 delivered;
 	u64 reference_perf;
-	u64 ctr_wrap_time;
+	u64 wraparound_time;
 };
 
 /* Per CPU container for runtime CPPC management. */
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

