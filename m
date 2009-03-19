From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: [PATCH] ACPI: cap off P-state transition latency from buggy BIOSes
Date: Thu, 19 Mar 2009 14:41:40 -0700
Message-ID: <20090319214140.GA28868@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19570 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbZCSVls (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Mar 2009 17:41:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, mjg59@srcf.ucam.org


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

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2008-05-02 09:45:23.000000000 -0700
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2008-06-30 12:08:32.000000000 -0700
@@ -659,6 +659,18 @@ static int acpi_cpufreq_cpu_init(struct 
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
