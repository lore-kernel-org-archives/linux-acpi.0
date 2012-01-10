From: akpm@linux-foundation.org
Subject: [patch 1/3] intel_idle: fix API misuse
Date: Tue, 10 Jan 2012 15:48:19 -0800
Message-ID: <20120110234819.7F484100270@wpzn3.hot.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:37800 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab2AJXsU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2012 18:48:20 -0500
Received: by yenm5 with SMTP id m5so19127yen.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2012 15:48:20 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, shaohua.li@intel.com

From: Shaohua Li <shaohua.li@intel.com>
Subject: intel_idle: fix API misuse

smp_call_function() only lets all other CPUs execute a specific function,
while we expect all CPUs do in intel_idle.  Without the fix, we could have
one cpu which has auto_demotion enabled or has no boradcast timer setup. 
Usually we don't see impact because auto demotion just harms power and the
intel_idle init is called in CPU 0, where boradcast timer delivers
interrupt, but this still could be a problem.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/idle/intel_idle.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/idle/intel_idle.c~intel_idle-fix-api-misuse drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~intel_idle-fix-api-misuse
+++ a/drivers/idle/intel_idle.c
@@ -394,7 +394,7 @@ static int intel_idle_probe(void)
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
 	else {
-		smp_call_function(__setup_broadcast_timer, (void *)true, 1);
+		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
 		register_cpu_notifier(&setup_broadcast_notifier);
 	}
 
@@ -471,7 +471,7 @@ static int intel_idle_cpuidle_driver_ini
 	}
 
 	if (auto_demotion_disable_flags)
-		smp_call_function(auto_demotion_disable, NULL, 1);
+		on_each_cpu(auto_demotion_disable, NULL, 1);
 
 	return 0;
 }
@@ -568,7 +568,7 @@ static void __exit intel_idle_exit(void)
 	cpuidle_unregister_driver(&intel_idle_driver);
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
-		smp_call_function(__setup_broadcast_timer, (void *)false, 1);
+		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
 		unregister_cpu_notifier(&setup_broadcast_notifier);
 	}
 
_
