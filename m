From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/60] ACPI: thermal: remove unused limit code
Date: Mon, 25 Oct 2010 02:20:47 -0400
Message-ID: <ab7c13c4a5a22335b0cfc6f364ee77abed66503c.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50524 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0JYHLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:03 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:02 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

acpi_processor_apply_limit()
acpi_thermal_cpufreq_increase()
acpi_thermal_cpufreq_decrease()

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_thermal.c |   71 --------------------------------------
 1 files changed, 0 insertions(+), 71 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 419f651..fde49b9 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -44,47 +44,6 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_thermal");
 
-/* --------------------------------------------------------------------------
-                                 Limit Interface
-   -------------------------------------------------------------------------- */
-static int acpi_processor_apply_limit(struct acpi_processor *pr)
-{
-	int result = 0;
-	u16 px = 0;
-	u16 tx = 0;
-
-
-	if (!pr)
-		return -EINVAL;
-
-	if (!pr->flags.limit)
-		return -ENODEV;
-
-	if (pr->flags.throttling) {
-		if (pr->limit.user.tx > tx)
-			tx = pr->limit.user.tx;
-		if (pr->limit.thermal.tx > tx)
-			tx = pr->limit.thermal.tx;
-
-		result = acpi_processor_set_throttling(pr, tx, false);
-		if (result)
-			goto end;
-	}
-
-	pr->limit.state.px = px;
-	pr->limit.state.tx = tx;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Processor [%d] limit set to (P%d:T%d)\n", pr->id,
-			  pr->limit.state.px, pr->limit.state.tx));
-
-      end:
-	if (result)
-		printk(KERN_ERR PREFIX "Unable to set limit\n");
-
-	return result;
-}
-
 #ifdef CONFIG_CPU_FREQ
 
 /* If a passive cooling situation is detected, primarily CPUfreq is used, as it
@@ -107,36 +66,6 @@ static int cpu_has_cpufreq(unsigned int cpu)
 	return 1;
 }
 
-static int acpi_thermal_cpufreq_increase(unsigned int cpu)
-{
-	if (!cpu_has_cpufreq(cpu))
-		return -ENODEV;
-
-	if (per_cpu(cpufreq_thermal_reduction_pctg, cpu) <
-		CPUFREQ_THERMAL_MAX_STEP) {
-		per_cpu(cpufreq_thermal_reduction_pctg, cpu)++;
-		cpufreq_update_policy(cpu);
-		return 0;
-	}
-
-	return -ERANGE;
-}
-
-static int acpi_thermal_cpufreq_decrease(unsigned int cpu)
-{
-	if (!cpu_has_cpufreq(cpu))
-		return -ENODEV;
-
-	if (per_cpu(cpufreq_thermal_reduction_pctg, cpu) >
-		(CPUFREQ_THERMAL_MIN_STEP + 1))
-		per_cpu(cpufreq_thermal_reduction_pctg, cpu)--;
-	else
-		per_cpu(cpufreq_thermal_reduction_pctg, cpu) = 0;
-	cpufreq_update_policy(cpu);
-	/* We reached max freq again and can leave passive mode */
-	return !per_cpu(cpufreq_thermal_reduction_pctg, cpu);
-}
-
 static int acpi_thermal_cpufreq_notifier(struct notifier_block *nb,
 					 unsigned long event, void *data)
 {
-- 
1.7.3.2.90.gd4c43

