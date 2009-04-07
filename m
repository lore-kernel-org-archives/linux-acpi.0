From: Len Brown <lenb@kernel.org>
Subject: [2.6.29.y PATCH]
Date: Mon, 06 Apr 2009 23:53:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904062351580.5698@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:46427 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZDGDyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2009 23:54:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHP00I54PHL240T@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 06 Apr 2009 22:53:46 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
Date: Thu, 19 Mar 2009 14:41:40 -0700
Subject: [PATCH] ACPI: cap off P-state transition latency from buggy BIOSes
X-Patchwork-Hint: ignore

upstream  a59d1637eb0e0a37ee0e5c92800c60abe3624e24
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
1.6.2.2.446.gfbdc

