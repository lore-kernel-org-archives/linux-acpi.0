From: Youquan Song <youquan.song@intel.com>
Subject: [PATCH 2/6] cpufreq: Add sampling_window tunable
Date: Thu, 23 Dec 2010 14:17:02 +0800
Message-ID: <1293085026-18173-3-git-send-email-youquan.song@intel.com>
References: <1293085026-18173-1-git-send-email-youquan.song@intel.com>
 <1293085026-18173-2-git-send-email-youquan.song@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1293085026-18173-2-git-send-email-youquan.song@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: davej@redhat.com, cpufreq@vger.kernle.org
Cc: venki@google.com, arjan@linux.intel.com, lenb@kernel.org, suresh.b.siddha@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>, Youquan Song <youquan.song@intel.com>
List-Id: linux-acpi@vger.kernel.org

Add sampling_window tunable and user can set sampling window size by this
interface. The default max sampling window is one second.

Signed-off-by: Youquan Song <youquan.song@intel.com>
---
 drivers/cpufreq/cpufreq_ondemand.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index e49b2e1..87aec7f 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -295,6 +295,7 @@ show_one(up_threshold, up_threshold);
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(ignore_nice_load, ignore_nice);
 show_one(powersave_bias, powersave_bias);
+show_one(sampling_window, sampling_window);
 
 /*** delete after deprecation time ***/
 
@@ -455,12 +456,36 @@ static ssize_t store_powersave_bias(struct kobject *a, struct attribute *b,
 	return count;
 }
 
+static ssize_t store_sampling_window(struct kobject *a, struct attribute *b,
+				    const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret = sscanf(buf, "%u", &input);
+
+	if (ret != 1)
+		return -EINVAL;
+
+	if (input > 1000000)
+		input = 1000000;
+
+	if (input < 10000)
+		input = 10000;
+
+	mutex_lock(&dbs_mutex);
+	dbs_tuners_ins.sampling_window = input;
+	mutex_unlock(&dbs_mutex);
+
+	return count;
+}
+
 define_one_global_rw(sampling_rate);
 define_one_global_rw(io_is_busy);
 define_one_global_rw(up_threshold);
 define_one_global_rw(sampling_down_factor);
 define_one_global_rw(ignore_nice_load);
 define_one_global_rw(powersave_bias);
+define_one_global_rw(sampling_window);
 
 static struct attribute *dbs_attributes[] = {
 	&sampling_rate_max.attr,
@@ -471,6 +496,7 @@ static struct attribute *dbs_attributes[] = {
 	&ignore_nice_load.attr,
 	&powersave_bias.attr,
 	&io_is_busy.attr,
+	&sampling_window.attr,
 	NULL
 };
 
-- 
1.6.4.2
