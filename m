From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 7/8] acpi-cpufreq: Use already defined IDA feature flag instead of checking cpuid
Date: Fri, 17 Apr 2009 16:22:11 +0200
Message-ID: <1239978132-6261-8-git-send-email-trenn@suse.de>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43591 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760463AbZDQOWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Apr 2009 10:22:14 -0400
In-Reply-To: <1239978132-6261-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, venkatesh.pallipadi@intel.com, Thomas Renninger <trenn@suse.de>

It's already defined here:
arch/x86/kernel/cpu/addon_cpuid_features.c:
	{ X86_FEATURE_IDA, CR_EAX, 1, 0x00000006 },

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: <linux-acpi@vger.kernel.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@vger.kernel.org>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 148857a..aaf832f 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -60,7 +60,6 @@ enum {
 };
 
 #define INTEL_MSR_RANGE		(0xffff)
-#define CPUID_6_ECX_APERFMPERF_CAPABILITY	(0x1)
 
 struct acpi_cpufreq_data {
 	struct acpi_processor_performance *acpi_data;
@@ -645,12 +644,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	acpi_processor_notify_smm(THIS_MODULE);
 
 	/* Check for APERF/MPERF support in hardware */
-	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 6) {
-		unsigned int ecx;
-		ecx = cpuid_ecx(6);
-		if (ecx & CPUID_6_ECX_APERFMPERF_CAPABILITY)
-			acpi_cpufreq_driver.getavg = get_measured_perf;
-	}
+	if (cpu_has(&current_cpu_data, X86_FEATURE_IDA))
+		acpi_cpufreq_driver.getavg = get_measured_perf;
+
 
 	dprintk("CPU%u - ACPI performance management activated.\n", cpu);
 	for (i = 0; i < perf->state_count; i++)
-- 
1.6.0.2

