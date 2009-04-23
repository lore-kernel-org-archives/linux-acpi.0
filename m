From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/29] acpi-cpufreq: Do not let get_measured perf depend on
 internal variable
Date: Thu, 23 Apr 2009 02:23:47 -0400
Message-ID: <d876dfbbf5c8728102fb4f683450fa9ae3259cda.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbZDWGYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:16 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00EGMJ48K60J@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:09 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Take already available policy->cpuinfo.max_freq and get rid of acpi-cpufreq
specific max_freq variable.

This implies that P0 is always the highest frequency which should always
be true as ACPI spec says:
As a result, the zeroth entry describes the highest performance state

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index aec3161..208ecf6 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -65,7 +65,6 @@ enum {
 struct acpi_cpufreq_data {
 	struct acpi_processor_performance *acpi_data;
 	struct cpufreq_frequency_table *freq_table;
-	unsigned int max_freq;
 	unsigned int resume;
 	unsigned int cpu_feature;
 };
@@ -340,7 +339,7 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 
 #endif
 
-	retval = (per_cpu(drv_data, policy->cpu)->max_freq * perf_percent) / 100;
+	retval = (policy->cpuinfo.max_freq * perf_percent) / 100;
 
 	return retval;
 }
@@ -698,7 +697,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 				    " latency at 20 uS\n");
 	}
 
-	data->max_freq = perf->states[0].core_frequency * 1000;
 	/* table init */
 	for (i = 0; i < perf->state_count; i++) {
 		if (i > 0 && perf->states[i].core_frequency >=
@@ -717,6 +715,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (result)
 		goto err_freqfree;
 
+	if (perf->states[0].core_frequency * 1000 != policy->cpuinfo.max_freq)
+		printk(KERN_WARNING FW_WARN "P-state 0 is not max freq\n");
+
 	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		/* Current speed is unknown and not detectable by IO port */
-- 
1.6.0.6

