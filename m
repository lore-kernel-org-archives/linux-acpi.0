From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/5] ACPI processor: Split up acpi_processor_add()
Date: Mon, 12 Sep 2011 01:42:30 +0200
Message-ID: <1315784551-39118-5-git-send-email-trenn@suse.de>
References: <1315784551-39118-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258Ab1IKXmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Sep 2011 19:42:44 -0400
In-Reply-To: <1315784551-39118-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>

Should have no functional change, beside a tiny fix in error case:
also remove a previously created link.


Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c |   93 ++++++++++++++++++++++----------------
 1 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 7bc141a..546951a 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -442,6 +442,58 @@ static struct notifier_block acpi_cpu_notifier =
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
+
+	if (cpuidle_get_driver() == &acpi_idle_driver)
+		acpi_processor_power_init(pr, device);
+
+	pr->cdev = thermal_cooling_device_register("Processor", device,
+						&processor_cooling_ops);
+	if (IS_ERR(pr->cdev)) {
+		result = PTR_ERR(pr->cdev);
+		goto err_power_exit;
+	}
+
+	dev_dbg(&device->dev, "registered as cooling_device%d\n",
+		 pr->cdev->id);
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
@@ -496,50 +548,13 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
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
-
-	if (cpuidle_get_driver() == &acpi_idle_driver)
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
+	result = acpi_processor_start(pr);
+	if (result)
 		goto err_remove_sysfs;
-	}
 
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

