From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH] CPPC: Initialize and check CPUFreq CPU co-ord type correctly
Date: Thu, 19 Nov 2015 10:40:07 -0500
Message-ID: <1447947607-10822-1-git-send-email-ashwin.chaugule@linaro.org>
References: <CAJ5Y-eY=fo=JT11CqYR09Nis--TLpdHtxo+JyC6nh07kVgUrdg@mail.gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34230 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758331AbbKSPkP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 10:40:15 -0500
Received: by qkfo3 with SMTP id o3so26750733qkf.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2015 07:40:14 -0800 (PST)
In-Reply-To: <CAJ5Y-eY=fo=JT11CqYR09Nis--TLpdHtxo+JyC6nh07kVgUrdg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

The CPU policy struct indicates the co-ordination type
for all CPUs of a common freq domain. Initialize it
correctly using the CPU specific data gathered from
CPPC ACPI lib via acpi_get_psd_map().

The PSD object is optional, so the cpu->shared_type
can also be 0. So instead of assuming any value other
than SW_ANY(0xFD) is unsupported, explictly check
if shared_type is SW_ALL and then bail.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e8cb334..7c0bdfb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -98,10 +98,11 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->max = cpu->perf_caps.highest_perf;
 	policy->cpuinfo.min_freq = policy->min;
 	policy->cpuinfo.max_freq = policy->max;
+	policy->shared_type = cpu->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
 		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
-	else {
+	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
 		/* Support only SW_ANY for now. */
 		pr_debug("Unsupported CPU co-ord type\n");
 		return -EFAULT;
-- 
1.9.1

