From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/1] thermal: cpu cooling: use const parameter while registering
Date: Mon, 12 Nov 2012 11:58:50 -0400
Message-ID: <1352735930-8025-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53899 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004Ab2KLP7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Nov 2012 10:59:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Eduardo Valentin <eduardo.valentin@ti.com>

There are predefined cpu_masks that are const data structures.
This patch changes the cpu cooling register function so that
those const cpu_masks can be used, without compilation warnings.

include/linux/cpumask.h

 * The following particular system cpumasks and operations manage
 * possible, present, active and online cpus.
 *
 *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
 *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
 *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
 *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
 *

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/cpu_cooling.c |    2 +-
 include/linux/cpu_cooling.h   |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index cc1c930..e5e7153 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -345,7 +345,7 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
  */
 struct thermal_cooling_device *cpufreq_cooling_register(
-	struct cpumask *clip_cpus)
+	const struct cpumask *clip_cpus)
 {
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev = NULL;
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 8515301..b30cc79c 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -35,7 +35,7 @@
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen
  */
 struct thermal_cooling_device *cpufreq_cooling_register(
-		struct cpumask *clip_cpus);
+		const struct cpumask *clip_cpus);
 
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
@@ -44,7 +44,7 @@ struct thermal_cooling_device *cpufreq_cooling_register(
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *cpufreq_cooling_register(
-	struct cpumask *clip_cpus)
+	const struct cpumask *clip_cpus)
 {
 	return NULL;
 }
-- 
1.7.7.1.488.ge8e1c

