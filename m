From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 1/2]intel_idle: fix misuse API - resend
Date: Fri, 03 Jun 2011 10:42:34 +0800
Message-ID: <1307068954.15392.52.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10764 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab1FCCmg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jun 2011 22:42:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

smp_call_function() only lets all other CPUs execute specific
function, while we expect all CPUs do in intel_idle. Without
the fix, we could have one cpu has auto_demotion enabled or
has no boradcast timer setup. Usually we don't see impact
because auto demotion just harms power and the intel_idle init
is called in CPU 0, where boradcast timer delivers interrupt,
but this still could be a problem.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

---
 drivers/idle/intel_idle.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux/drivers/idle/intel_idle.c
===================================================================
--- linux.orig/drivers/idle/intel_idle.c	2011-05-27 16:47:06.000000000 +0800
+++ linux/drivers/idle/intel_idle.c	2011-06-03 09:47:30.000000000 +0800
@@ -367,7 +367,7 @@ static int intel_idle_probe(void)
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
 	else {
-		smp_call_function(__setup_broadcast_timer, (void *)true, 1);
+		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
 		register_cpu_notifier(&setup_broadcast_notifier);
 	}
 
@@ -459,7 +459,7 @@ static int intel_idle_cpuidle_devices_in
 		}
 	}
 	if (auto_demotion_disable_flags)
-		smp_call_function(auto_demotion_disable, NULL, 1);
+		on_each_cpu(auto_demotion_disable, NULL, 1);
 
 	return 0;
 }
@@ -499,7 +499,7 @@ static void __exit intel_idle_exit(void)
 	cpuidle_unregister_driver(&intel_idle_driver);
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
-		smp_call_function(__setup_broadcast_timer, (void *)false, 1);
+		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
 		unregister_cpu_notifier(&setup_broadcast_notifier);
 	}
 


