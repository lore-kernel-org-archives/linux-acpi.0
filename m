From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/3] acpi : remove unused function parameter
Date: Fri, 14 Sep 2012 11:25:35 +0200
Message-ID: <1347614736-9553-2-git-send-email-daniel.lezcano@linaro.org>
References: <1347614736-9553-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52192 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758675Ab2INJZn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Sep 2012 05:25:43 -0400
Received: by weyx8 with SMTP id x8so2266481wey.19
        for <linux-acpi@vger.kernel.org>; Fri, 14 Sep 2012 02:25:42 -0700 (PDT)
In-Reply-To: <1347614736-9553-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

The 'device' parameter is not used neither in acpi_processor_power_init
and acpi_processor_power_exit. This patch removes it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_driver.c |    6 +++---
 drivers/acpi/processor_idle.c   |    6 ++----
 include/acpi/processor.h        |    6 ++----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bfc31cb..9c9288b 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -475,7 +475,7 @@ static __ref int acpi_processor_start(struct acpi_processor *pr)
 	acpi_processor_get_limit_info(pr);
 
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
-		acpi_processor_power_init(pr, device);
+		acpi_processor_power_init(pr);
 
 	pr->cdev = thermal_cooling_device_register("Processor", device,
 						   &processor_cooling_ops);
@@ -509,7 +509,7 @@ err_remove_sysfs_thermal:
 err_thermal_unregister:
 	thermal_cooling_device_unregister(pr->cdev);
 err_power_exit:
-	acpi_processor_power_exit(pr, device);
+	acpi_processor_power_exit(pr);
 
 	return result;
 }
@@ -620,7 +620,7 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 			return -EINVAL;
 	}
 
-	acpi_processor_power_exit(pr, device);
+	acpi_processor_power_exit(pr);
 
 	sysfs_remove_link(&device->dev.kobj, "sysdev");
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0a6405d..3655ab9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1222,8 +1222,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 
 static int acpi_processor_registered;
 
-int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
-			      struct acpi_device *device)
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
 	int retval;
@@ -1295,8 +1294,7 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 	return 0;
 }
 
-int acpi_processor_power_exit(struct acpi_processor *pr,
-			      struct acpi_device *device)
+int acpi_processor_power_exit(struct acpi_processor *pr)
 {
 	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ddd1a44..555d033 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -322,12 +322,10 @@ extern void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
 extern const struct file_operations acpi_processor_throttling_fops;
 extern void acpi_processor_throttling_init(void);
 /* in processor_idle.c */
-int acpi_processor_power_init(struct acpi_processor *pr,
-			      struct acpi_device *device);
+int acpi_processor_power_init(struct acpi_processor *pr);
+int acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_cst_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
-int acpi_processor_power_exit(struct acpi_processor *pr,
-			      struct acpi_device *device);
 int acpi_processor_suspend(struct device *dev);
 int acpi_processor_resume(struct device *dev);
 extern struct cpuidle_driver acpi_idle_driver;
-- 
1.7.5.4

