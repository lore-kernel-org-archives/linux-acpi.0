From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 6/8] CPUFREQ: Add average frequency to sysfs exported files of cpufreq_stats
Date: Fri, 17 Apr 2009 16:22:10 +0200
Message-ID: <1239978132-6261-7-git-send-email-trenn@suse.de>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49971 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbZDQOWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 10:22:14 -0400
In-Reply-To: <1239978132-6261-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, venkatesh.pallipadi@intel.com, Thomas Renninger <trenn@suse.de>

Average frequency can now be monitored easily (e.g. every second) by:
watch -n1 cat /sys/devices/system/cpu/cpu*/cpufreq/stats/average_freq
if CONFIG_CPU_FREQ_STAT is compiled and the cpufreq_stats module got
loaded.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: <linux-acpi@vger.kernel.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@vger.kernel.org>
---
 drivers/cpufreq/cpufreq_stats.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 5a62d67..64542dd 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -20,6 +20,9 @@
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 #include <asm/cputime.h>
+#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
+#include <asm/processor.h>
+#endif
 
 static spinlock_t cpufreq_stats_lock;
 
@@ -44,6 +47,10 @@ struct cpufreq_stats {
 };
 
 static DEFINE_PER_CPU(struct cpufreq_stats *, cpufreq_stats_table);
+#ifdef CONFIG_X86_AVERAGE_FREQUENCY
+static DEFINE_PER_CPU(u64, saved_aperf);
+static DEFINE_PER_CPU(u64, saved_mperf);
+#endif
 
 struct cpufreq_stats_attribute {
 	struct attribute attr;
@@ -139,6 +146,28 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 CPUFREQ_STATDEVICE_ATTR(trans_table, 0444, show_trans_table);
 #endif
 
+#ifdef CONFIG_X86_AVERAGE_FREQUENCY
+static ssize_t show_average_freq(struct cpufreq_policy *policy, char *buf)
+{
+	ssize_t len;
+	unsigned int average_perf;
+
+	if (!cpu_has(&current_cpu_data, X86_FEATURE_IDA)) {
+		len = sprintf(buf, "not supported\n");
+		return len;
+	}
+
+	average_perf = get_average_perf(policy, policy->cpu,
+					&per_cpu(saved_aperf, policy->cpu),
+					&per_cpu(saved_mperf, policy->cpu));
+
+	len = sprintf(buf, "%d\n", average_perf);
+	return len;
+}
+CPUFREQ_STATDEVICE_ATTR(average_freq, 0444, show_average_freq);
+#endif
+
+
 CPUFREQ_STATDEVICE_ATTR(total_trans, 0444, show_total_trans);
 CPUFREQ_STATDEVICE_ATTR(time_in_state, 0444, show_time_in_state);
 
@@ -148,6 +177,9 @@ static struct attribute *default_attrs[] = {
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	&_attr_trans_table.attr,
 #endif
+#ifdef CONFIG_X86_AVERAGE_FREQUENCY
+	&_attr_average_freq.attr,
+#endif
 	NULL
 };
 static struct attribute_group stats_attr_group = {
-- 
1.6.0.2

