From: Len Brown <lenb@kernel.org>
Subject: [PATCH 86/98] ACPI: cap off P-state transition latency from buggy
 BIOSes
Date: Sat, 28 Mar 2009 00:32:01 -0400
Message-ID: <a59d1637eb0e0a37ee0e5c92800c60abe3624e24.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50093 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247AbZC1Edr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700D5C8O8IBKA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:45 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>

Some BIOSes report very high frequency transition latency which are plainly
wrong on CPus that can change frequency using native MSR interface.

One such system is IBM T42 (2327-8ZU) as reported by Owen Taylor and
Rik van Riel.

cpufreq_ondemand driver uses this transition latency to come up with a
reasonable sampling interval to sample CPU usage and with such high
latency value, ondemand sampling interval ends up being very high
(0.5 sec, in this particular case), resulting in performance impact due to
slow response to increasing frequency.

Fix it by capping-off the transition latency to 20uS for native MSR based
frequency transitions.

mjg: We've confirmed that this also helps on the X31

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 4b1c319..89c676d 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -680,6 +680,18 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			    perf->states[i].transition_latency * 1000;
 	}
 
+	/* Check for high latency (>20uS) from buggy BIOSes, like on T42 */
+	if (perf->control_register.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE &&
+	    policy->cpuinfo.transition_latency > 20 * 1000) {
+		static int print_once;
+		policy->cpuinfo.transition_latency = 20 * 1000;
+		if (!print_once) {
+			print_once = 1;
+			printk(KERN_INFO "Capping off P-state tranision latency"
+				" at 20 uS\n");
+		}
+	}
+
 	data->max_freq = perf->states[0].core_frequency * 1000;
 	/* table init */
 	for (i=0; i<perf->state_count; i++) {
-- 
1.6.0.6

