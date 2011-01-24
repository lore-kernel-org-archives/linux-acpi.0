From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] fix a shutdown regression in intel_idle
Date: Mon, 24 Jan 2011 16:00:01 +0800
Message-ID: <1295856001.1949.956.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13510 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861Ab1AXIAD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jan 2011 03:00:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, ari.m.savolainen@gmail.com

Fix a shutdown regression caused by 2a2d31c8. Looks the clockevent framework
can automatically shutdown broadcast timers for hotremove CPUs. And we get a
shutdown regression when we shutdown broadcast timer for hot remove CPU, so
just delete some code.
Also fix some section mismatch.

Reported-by: Ari Savolainen <ari.m.savolainen@gmail.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7acb32e..1fa091e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -263,7 +263,7 @@ static void __setup_broadcast_timer(void *arg)
 	clockevents_notify(reason, &cpu);
 }
 
-static int __cpuinit setup_broadcast_cpuhp_notify(struct notifier_block *n,
+static int setup_broadcast_cpuhp_notify(struct notifier_block *n,
 		unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
@@ -273,15 +273,11 @@ static int __cpuinit setup_broadcast_cpuhp_notify(struct notifier_block *n,
 		smp_call_function_single(hotcpu, __setup_broadcast_timer,
 			(void *)true, 1);
 		break;
-	case CPU_DOWN_PREPARE:
-		smp_call_function_single(hotcpu, __setup_broadcast_timer,
-			(void *)false, 1);
-		break;
 	}
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata setup_broadcast_notifier = {
+static struct notifier_block setup_broadcast_notifier = {
 	.notifier_call = setup_broadcast_cpuhp_notify,
 };
 


