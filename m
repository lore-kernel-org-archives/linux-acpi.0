From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH] CPPC: Initialize CPUFreq CPU co-ord type correctly
Date: Thu, 12 Nov 2015 19:52:54 -0500
Message-ID: <1447375974-3736-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33423 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbbKMAxP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 19:53:15 -0500
Received: by qkas77 with SMTP id s77so33226299qka.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2015 16:53:14 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

The CPU policy struct indicates the co-ordination type
for all CPUs of a common freq domain. Initialize it
correctly using the CPU specific data gathered from
CPPC ACPI lib via acpi_get_psd_map().

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 93c219f..508809b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -98,6 +98,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->max = cpu->perf_caps.highest_perf;
 	policy->cpuinfo.min_freq = policy->min;
 	policy->cpuinfo.max_freq = policy->max;
+	policy->shared_type = cpu->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
 		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
-- 
1.9.1

