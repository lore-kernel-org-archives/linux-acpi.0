From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH 2/2] update mutex usage in aggregator driver
Date: Mon, 14 Dec 2009 09:42:29 +0800
Message-ID: <1260754949-11239-3-git-send-email-gong.chen@linux.intel.com>
References: <1260754949-11239-1-git-send-email-gong.chen@linux.intel.com>
 <1260754949-11239-2-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:60349 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbZLNBkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Dec 2009 20:40:20 -0500
In-Reply-To: <1260754949-11239-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Chen Gong <gong.chen@linux.intel.com>

I have 2 issues.
 1. I consider thread creation and RR thread execution don't share the
global data, so the serialization execution is not necessary. It is
enough to use another different mutex to lock thread exectuion itself
when these threads running concurrently.
 2. part of sysfs interfaces doesn't need to own mutex with thread createion.
Though some data maybe are not identical, it is not a big deal.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/acpi_pad.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index a7bd49f..ceb8270 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -34,6 +34,7 @@
 #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 static DEFINE_MUTEX(isolated_cpus_lock);
+static DEFINE_MUTEX(isolated_thread_lock);
 
 #define MWAIT_SUBSTATE_MASK	(0xf)
 #define MWAIT_CSTATE_MASK	(0xf)
@@ -105,7 +106,6 @@ static void round_robin_cpu(unsigned int tsk_index)
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
 
-	mutex_lock(&isolated_cpus_lock);
 	cpumask_clear(tmp);
 	for_each_cpu(cpu, pad_busy_cpus)
 		cpumask_or(tmp, tmp, topology_thread_cpumask(cpu));
@@ -113,10 +113,10 @@ static void round_robin_cpu(unsigned int tsk_index)
 	/* avoid HT sibilings if possible */
 	if (cpumask_empty(tmp))
 		cpumask_andnot(tmp, cpu_online_mask, pad_busy_cpus);
-	if (cpumask_empty(tmp)) {
-		mutex_unlock(&isolated_cpus_lock);
+	if (cpumask_empty(tmp))
 		return;
-	}
+
+	mutex_lock(&isolated_thread_lock);
 	for_each_cpu(cpu, tmp) {
 		if (cpu_weight[cpu] < min_weight) {
 			min_weight = cpu_weight[cpu];
@@ -129,7 +129,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	tsk_in_cpu[tsk_index] = preferred_cpu;
 	cpumask_set_cpu(preferred_cpu, pad_busy_cpus);
 	cpu_weight[preferred_cpu]++;
-	mutex_unlock(&isolated_cpus_lock);
+	mutex_unlock(&isolated_thread_lock);
 
 	set_cpus_allowed_ptr(current, cpumask_of(preferred_cpu));
 }
@@ -280,9 +280,7 @@ static ssize_t acpi_pad_rrtime_store(struct device *dev,
 		return -EINVAL;
 	if (num < 1 || num >= 100)
 		return -EINVAL;
-	mutex_lock(&isolated_cpus_lock);
 	round_robin_time = num;
-	mutex_unlock(&isolated_cpus_lock);
 	return count;
 }
 
@@ -303,9 +301,7 @@ static ssize_t acpi_pad_idlepct_store(struct device *dev,
 		return -EINVAL;
 	if (num < 1 || num >= 100)
 		return -EINVAL;
-	mutex_lock(&isolated_cpus_lock);
 	idle_pct = num;
-	mutex_unlock(&isolated_cpus_lock);
 	return count;
 }
 
-- 
1.6.5.2.143.g8cc62

