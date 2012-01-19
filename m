From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI processor hotplug: Split up acpi_processor_add
Date: Thu, 19 Jan 2012 18:18:42 +0100
Message-ID: <1326993523-6492-2-git-send-email-trenn@suse.de>
References: <1326993523-6492-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49460 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638Ab2ASRSr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2012 12:18:47 -0500
In-Reply-To: <1326993523-6492-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, shaohua.li@intel.com, Thomas Renninger <trenn@suse.de>

No functional change.

This is needed because:
When a CPU gets hotplugged, it's totally uninitialized
and offline. cpuinfo_x86 struct (cpu_data(cpu)) is mostly
zero (CPU feature flags, model, family,..).

When a CPU gets hotplugged, struct processor is alloc'd,
some sysfs files are set up but acpi_processor_add()
must not try to access a MSR on this CPU or try to read
out CPU feature,family, etc.

This must be done in acpi_processor_start().
The next patch will delay the call of acpi_processor_start()
for physically hotpluggedcores, to the time when they are onlined
the first time. There it is safe then to access cpu_data(cpu)
cpuinfo_x86 struct or access MSRs which is needed to
set up cpuidle, throttling and other features.

Tested and
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/processor_driver.c |   94 +++++++++++++++++++++++----------------
 1 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index b9cbd9b..5c19ff6 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -440,6 +440,58 @@ static struct notifier_block acpi_cpu_notifier =
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
+static int __cpuinit acpi_processor_start(struct acpi_processor *pr)
+{
+	struct acpi_device *device = per_cpu(processor_device_array, pr->id);
+	int result = 0;
+
+#ifdef CONFIG_CPU_FREQ
+	acpi_processor_ppc_has_changed(pr, 0);
+#endif
+	acpi_processor_get_throttling_info(pr);
+	acpi_processor_get_limit_info(pr);
+
+	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
+		acpi_processor_power_init(pr, device);
+
+	pr->cdev = thermal_cooling_device_register("Processor", device,
+						   &processor_cooling_ops);
+	if (IS_ERR(pr->cdev)) {
+		result = PTR_ERR(pr->cdev);
+		goto err_power_exit;
+	}
+
+	dev_dbg(&device->dev, "registered as cooling_device%d\n",
+		pr->cdev->id);
+
+	result = sysfs_create_link(&device->dev.kobj,
+				   &pr->cdev->device.kobj,
+				   "thermal_cooling");
+	if (result) {
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		goto err_thermal_unregister;
+	}
+	result = sysfs_create_link(&pr->cdev->device.kobj,
+				   &device->dev.kobj,
+				   "device");
+	if (result) {
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		goto err_remove_sysfs_thermal;
+	}
+
+	return 0;
+
+err_remove_sysfs_thermal:
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+err_thermal_unregister:
+	thermal_cooling_device_unregister(pr->cdev);
+err_power_exit:
+	acpi_processor_power_exit(pr, device);
+
+	return result;
+}
+
+
 static int __cpuinit acpi_processor_add(struct acpi_device *device)
 {
 	struct acpi_processor *pr = NULL;
@@ -494,49 +546,13 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		result = -EFAULT;
 		goto err_free_cpumask;
 	}
-
-#ifdef CONFIG_CPU_FREQ
-	acpi_processor_ppc_has_changed(pr, 0);
-#endif
-	acpi_processor_get_throttling_info(pr);
-	acpi_processor_get_limit_info(pr);
-
-	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
-		acpi_processor_power_init(pr, device);
-
-	pr->cdev = thermal_cooling_device_register("Processor", device,
-						&processor_cooling_ops);
-	if (IS_ERR(pr->cdev)) {
-		result = PTR_ERR(pr->cdev);
-		goto err_power_exit;
-	}
-
-	dev_dbg(&device->dev, "registered as cooling_device%d\n",
-		 pr->cdev->id);
-
-	result = sysfs_create_link(&device->dev.kobj,
-				   &pr->cdev->device.kobj,
-				   "thermal_cooling");
-	if (result) {
-		printk(KERN_ERR PREFIX "Create sysfs link\n");
-		goto err_thermal_unregister;
-	}
-	result = sysfs_create_link(&pr->cdev->device.kobj,
-				   &device->dev.kobj,
-				   "device");
-	if (result) {
-		printk(KERN_ERR PREFIX "Create sysfs link\n");
-		goto err_remove_sysfs;
-	}
+	result = acpi_processor_start(pr);
+	if (result)
+ 		goto err_remove_sysfs;
 
 	return 0;
 
 err_remove_sysfs:
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-err_thermal_unregister:
-	thermal_cooling_device_unregister(pr->cdev);
-err_power_exit:
-	acpi_processor_power_exit(pr, device);
 	sysfs_remove_link(&device->dev.kobj, "sysdev");
 err_free_cpumask:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
-- 
1.7.6.1

