From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/5] cpuidle / ACPI : pass the cpuidle driver as parameter
Date: Fri, 19 Oct 2012 11:51:32 +0200
Message-ID: <1350640292-22468-5-git-send-email-daniel.lezcano@linaro.org>
References: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50414 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab2JSJvn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2012 05:51:43 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so255377wgb.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Oct 2012 02:51:42 -0700 (PDT)
In-Reply-To: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

Instead of refering to a global variable in the function, let's pass
the cpuidle_driver as a parameter to this function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f87cb2e..da38a4b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1030,12 +1030,12 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
  *
  * @pr: the ACPI processor
  */
-static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
+static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr,
+					       struct cpuidle_driver *drv)
 {
 	int i, count = CPUIDLE_DRIVER_STATE_START;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
-	struct cpuidle_driver *drv = &acpi_idle_driver;
 
 	if (!pr->flags.power_setup_done)
 		return -EINVAL;
@@ -1146,6 +1146,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 	int cpu;
 	struct acpi_processor *_pr;
 	struct cpuidle_device *dev;
+	struct cpuidle_driver *drv = cpuidle_get_driver();
 
 	if (disabled_by_idle_boot_param())
 		return 0;
@@ -1164,7 +1165,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 	 * system instead of once per-cpu.  This condition is a hack
 	 * to make the code that updates C-States be called once.
 	 */
-	if (pr->id != 0 || cpuidle_get_driver() != &acpi_idle_driver)
+	if (pr->id != 0 || drv != &acpi_idle_driver)
 		return 0;
 
 	cpuidle_pause_and_lock();
@@ -1181,7 +1182,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 	}
 
 	/* Populate Updated C-state information */
-	acpi_processor_setup_cpuidle_states(pr);
+	acpi_processor_setup_cpuidle_states(pr, drv);
 
 	/* Enable all cpuidle devices */
 	for_each_online_cpu(cpu) {
@@ -1250,7 +1251,7 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr)
 
 	/* Register acpi_idle_driver if not already registered */
 	if (!acpi_processor_registered) {
-		acpi_processor_setup_cpuidle_states(pr);
+		acpi_processor_setup_cpuidle_states(pr, &acpi_idle_driver);
 		retval = cpuidle_register_driver(&acpi_idle_driver);
 		if (retval)
 			return retval;
-- 
1.7.5.4

