From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/8] acpi-cpufreq: First multiply then divide to avoid zero results
Date: Fri, 17 Apr 2009 16:22:07 +0200
Message-ID: <1239978132-6261-4-git-send-email-trenn@suse.de>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43588 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760582AbZDQOWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
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
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 4475523..7948d88 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -340,7 +340,7 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 
 #endif
 
-	retval = per_cpu(drv_data, policy->cpu)->max_freq * perf_percent / 100;
+	retval = (per_cpu(drv_data, policy->cpu)->max_freq * perf_percent) / 100;
 
 	return retval;
 }
-- 
1.6.0.2

