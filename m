From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/5] cpuidle / ACPI : change indentation logic
Date: Fri, 19 Oct 2012 11:51:31 +0200
Message-ID: <1350640292-22468-4-git-send-email-daniel.lezcano@linaro.org>
References: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51812 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab2JSJvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2012 05:51:42 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so35104wib.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Oct 2012 02:51:41 -0700 (PDT)
In-Reply-To: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

This patch changes the indentation by returning from the function if
pr->flags.power is not set. That allows to have the remaining code out of a
'if' section.

Even if the patch does not fix anything, it makes the code a bit more readable
for the future cleanups.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |  112 +++++++++++++++++++++--------------------
 1 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5c4330f..f87cb2e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1164,40 +1164,39 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 	 * system instead of once per-cpu.  This condition is a hack
 	 * to make the code that updates C-States be called once.
 	 */
+	if (pr->id != 0 || cpuidle_get_driver() != &acpi_idle_driver)
+		return 0;
 
-	if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
-
-		cpuidle_pause_and_lock();
-		/* Protect against cpu-hotplug */
-		get_online_cpus();
+	cpuidle_pause_and_lock();
+	/* Protect against cpu-hotplug */
+	get_online_cpus();
 
-		/* Disable all cpuidle devices */
-		for_each_online_cpu(cpu) {
-			_pr = per_cpu(processors, cpu);
-			if (!_pr || !_pr->flags.power_setup_done)
-				continue;
-			dev = per_cpu(acpi_cpuidle_device, cpu);
-			cpuidle_disable_device(dev);
-		}
+	/* Disable all cpuidle devices */
+	for_each_online_cpu(cpu) {
+		_pr = per_cpu(processors, cpu);
+		if (!_pr || !_pr->flags.power_setup_done)
+			continue;
+		dev = per_cpu(acpi_cpuidle_device, cpu);
+		cpuidle_disable_device(dev);
+	}
 
-		/* Populate Updated C-state information */
-		acpi_processor_setup_cpuidle_states(pr);
+	/* Populate Updated C-state information */
+	acpi_processor_setup_cpuidle_states(pr);
 
-		/* Enable all cpuidle devices */
-		for_each_online_cpu(cpu) {
-			_pr = per_cpu(processors, cpu);
-			if (!_pr || !_pr->flags.power_setup_done)
-				continue;
-			acpi_processor_get_power_info(_pr);
-			if (_pr->flags.power) {
-				dev = per_cpu(acpi_cpuidle_device, cpu);
-				acpi_processor_setup_cpuidle_cx(_pr, dev);
-				cpuidle_enable_device(dev);
-			}
+	/* Enable all cpuidle devices */
+	for_each_online_cpu(cpu) {
+		_pr = per_cpu(processors, cpu);
+		if (!_pr || !_pr->flags.power_setup_done)
+			continue;
+		acpi_processor_get_power_info(_pr);
+		if (_pr->flags.power) {
+			dev = per_cpu(acpi_cpuidle_device, cpu);
+			acpi_processor_setup_cpuidle_cx(_pr, dev);
+			cpuidle_enable_device(dev);
 		}
-		put_online_cpus();
-		cpuidle_resume_and_unlock();
 	}
+	put_online_cpus();
+	cpuidle_resume_and_unlock();
 
 	return 0;
 }
@@ -1229,7 +1228,8 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr)
 
 	if (acpi_gbl_FADT.cst_control && !nocst) {
 		status =
-		    acpi_os_write_port(acpi_gbl_FADT.smi_command, acpi_gbl_FADT.cst_control, 8);
+		    acpi_os_write_port(acpi_gbl_FADT.smi_command,
+				       acpi_gbl_FADT.cst_control, 8);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Notifying BIOS of _CST ability failed"));
@@ -1239,40 +1239,44 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr)
 	acpi_processor_get_power_info(pr);
 	pr->flags.power_setup_done = 1;
 
+	if (!pr->flags.power)
+		return 0;
+
 	/*
 	 * Install the idle handler if processor power management is supported.
 	 * Note that we use previously set idle handler will be used on
 	 * platforms that only support C1.
 	 */
-	if (pr->flags.power) {
-		/* Register acpi_idle_driver if not already registered */
-		if (!acpi_processor_registered) {
-			acpi_processor_setup_cpuidle_states(pr);
-			retval = cpuidle_register_driver(&acpi_idle_driver);
-			if (retval)
-				return retval;
-			printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
-					acpi_idle_driver.name);
-		}
 
-		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-		if (!dev)
-			return -ENOMEM;
-		per_cpu(acpi_cpuidle_device, pr->id) = dev;
+	/* Register acpi_idle_driver if not already registered */
+	if (!acpi_processor_registered) {
+		acpi_processor_setup_cpuidle_states(pr);
+		retval = cpuidle_register_driver(&acpi_idle_driver);
+		if (retval)
+			return retval;
+		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
+		       acpi_idle_driver.name);
+	}
 
-		acpi_processor_setup_cpuidle_cx(pr, dev);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	per_cpu(acpi_cpuidle_device, pr->id) = dev;
 
-		/* Register per-cpu cpuidle_device. Cpuidle driver
-		 * must already be registered before registering device
-		 */
-		retval = cpuidle_register_device(dev);
-		if (retval) {
-			if (acpi_processor_registered == 0)
-				cpuidle_unregister_driver(&acpi_idle_driver);
-			return retval;
-		}
-		acpi_processor_registered++;
+	acpi_processor_setup_cpuidle_cx(pr, dev);
+
+	/* Register per-cpu cpuidle_device. Cpuidle driver
+	 * must already be registered before registering device
+	 */
+	retval = cpuidle_register_device(dev);
+	if (retval) {
+		if (acpi_processor_registered == 0)
+			cpuidle_unregister_driver(&acpi_idle_driver);
+		return retval;
 	}
+
+	acpi_processor_registered++;
+
 	return 0;
 }
 
-- 
1.7.5.4

