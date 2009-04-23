From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] acpi-cpufreq: Use X86_FEATURE_APERF_MPERF to check for average freq capability
Date: Thu, 23 Apr 2009 15:03:04 +0200
Message-ID: <1240491784-29933-4-git-send-email-trenn@suse.de>
References: <1240491784-29933-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47617 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588AbZDWNDH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 09:03:07 -0400
In-Reply-To: <1240491784-29933-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index bf9b6b1..b75ca28 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -647,12 +647,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	acpi_processor_notify_smm(THIS_MODULE);
 
 	/* Check for APERF/MPERF support in hardware */
-	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 6) {
-		unsigned int ecx;
-		ecx = cpuid_ecx(6);
-		if (ecx & CPUID_6_ECX_APERFMPERF_CAPABILITY)
-			acpi_cpufreq_driver.getavg = get_measured_perf;
-	}
+	if (cpu_has(c, X86_FEATURE_APERF_MPERF))
+		acpi_cpufreq_driver.getavg = get_measured_perf;
 
 	dprintk("CPU%u - ACPI performance management activated.\n", cpu);
 	for (i = 0; i < perf->state_count; i++)
-- 
1.6.0.2

