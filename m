From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/8] acpi-cpufreq: Cleanup: Use printk_once
Date: Fri, 17 Apr 2009 16:22:06 +0200
Message-ID: <1239978132-6261-3-git-send-email-trenn@suse.de>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43589 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760790AbZDQOWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 10:22:14 -0400
In-Reply-To: <1239978132-6261-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, venkatesh.pallipadi@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: <linux-acpi@vger.kernel.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@vger.kernel.org>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index ed43734..4475523 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -693,13 +693,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	/* Check for high latency (>20uS) from buggy BIOSes, like on T42 */
 	if (perf->control_register.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE &&
 	    policy->cpuinfo.transition_latency > 20 * 1000) {
-		static int print_once;
 		policy->cpuinfo.transition_latency = 20 * 1000;
-		if (!print_once) {
-			print_once = 1;
-			printk(KERN_INFO "Capping off P-state tranision latency"
-				" at 20 uS\n");
-		}
+			printk_once(KERN_INFO "Capping off P-state tranision"
+				    " latency at 20 uS\n");
 	}
 
 	data->max_freq = perf->states[0].core_frequency * 1000;
-- 
1.6.0.2

